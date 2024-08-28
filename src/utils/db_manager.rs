use rusqlite::ffi::sqlite3_auto_extension;
use sqlite_vec::sqlite3_vec_init;
use std::convert::TryInto;
use tokio_rusqlite::{params, Connection};
use zerocopy::AsBytes;

use std::collections::HashMap;

use crate::types::config_types::Config;

pub struct DbManager;

impl DbManager {
    pub async fn init_db(config: &Config) -> eyre::Result<Connection> {
        unsafe {
            sqlite3_auto_extension(Some(std::mem::transmute(sqlite3_vec_init as *const ())));
        }

        let database =
            DbManager::open_connection(&config.haiku.metadata.database_url.clone()).await?;

        // Sanity check
        DbManager::sqlite_vec_version(&database).await?;

        DbManager::create_primary_tables(&database).await?;
        DbManager::create_key_tables(&database, config).await?;

        tracing::info!("Database created successfully");

        Ok(database)
    }

    pub async fn open_connection(database_url: &str) -> eyre::Result<Connection> {
        let database = Connection::open(database_url)
            .await
            .expect("Failed to open database");

        Ok(database)
    }

    // To do: Add dynamic vector size to embeddings table
    // To do: Better table names
    pub async fn create_primary_tables(database: &Connection) -> eyre::Result<()> {
        database
            .call(|db| {
                db.execute_batch(
                    "CREATE VIRTUAL TABLE IF NOT EXISTS embeddings USING vec0(embedding float[4]);
                 CREATE TABLE IF NOT EXISTS text_table (
                     id INTEGER PRIMARY KEY,
                     description TEXT NOT NULL
                 );",
                )
                .map_err(|e| e.into())
            })
            .await
            .expect("Failed to create primary tables");

        Ok(())
    }

    pub async fn create_key_tables(database: &Connection, config: &Config) -> eyre::Result<()> {
        // Collect all unique keys from storage_keys and retrieval_keys
        let mut all_keys: Vec<String> = Vec::new();
        for event in &config.events {
            for key in &event.db_keys.storage_keys {
                let mapped_key = event
                    .keys_mapping
                    .iter()
                    .find(|mapping| mapping.key == *key)
                    .map(|mapping| mapping.alias.clone())
                    .unwrap_or_else(|| key.clone());
                all_keys.push(mapped_key);
            }
            for key in &event.db_keys.retrieval_keys {
                let mapped_key = event
                    .keys_mapping
                    .iter()
                    .find(|mapping| mapping.key == *key)
                    .map(|mapping| mapping.alias.clone())
                    .unwrap_or_else(|| key.clone());
                all_keys.push(mapped_key);
            }
        }
        all_keys.sort();
        all_keys.dedup();

        database
            .call(|conn| {
                // Create a table for each unique key
                // id: idx in embeddings/nlp tables of row
                // value: identifier passed as value by event
                for key in all_keys {
                    let create_table_sql = format!(
                        "CREATE TABLE IF NOT EXISTS {} (
					id TEXT PRIMARY KEY,
					value TEXT NOT NULL
				)",
                        key
                    );
                    conn.execute(&create_table_sql, [])?;
                }
                Ok(())
            })
            .await?;
        Ok(())
    }

    // To do: Better fn name
    // To do: String vs &str ??
    pub async fn insert_embedding_and_text(
        database: &Connection,
        text: String,
        embedded_vector: Vec<f32>,
        storage_keys: HashMap<String, String>,
    ) -> eyre::Result<(i64, i64)> {
        database
            .call(move |db| {
                let transaction = db.transaction()?;

                transaction.execute(
                    "INSERT INTO embeddings (embedding) VALUES (?)",
                    params![embedded_vector.as_bytes()],
                )?;
                let embedding_row_id = transaction.last_insert_rowid();
                println!("Inserting embedding");

                transaction.execute(
                    "INSERT INTO text_table (description) VALUES (?)",
                    params![text],
                )?;
                let text_row_id = transaction.last_insert_rowid();
                println!("Inserting text description");

                assert_eq!(
                    embedding_row_id, text_row_id,
                    "nlp & embedded vector needs to be stored at the same idx"
                );

                for (key, value) in &storage_keys {
                    let query = format!("INSERT INTO {} (id, value) VALUES (?, ?)", key);
                    transaction.execute(&query, params![text_row_id.to_string(), value])?;
                    println!("inserting {value} for {key} table");
                }

                transaction.commit()?;
                Ok((embedding_row_id, text_row_id))
            })
            .await
            .map_err(|e| eyre::eyre!("Failed to insert embedding and text: {}", e))
    }

    // To do: Add dyn. limit
    pub async fn retrieve_memories(
        database: &Connection,
        query_embedding: Vec<f32>,
        retrieval_keys: HashMap<String, String>,
    ) -> eyre::Result<Vec<String>> {
        database
            .call(move |db| {
                let transaction = db.transaction()?;
                let mut results = Vec::new();

                let mut ids = Vec::new();
                for (key, value) in &retrieval_keys {
                    let query = format!("SELECT id FROM {} WHERE value = ?", key);
                    let mut stmt = transaction.prepare(&query)?;
                    let rows = stmt.query_map([value], |row| row.get::<_, String>(0))?;

                    for id in rows {
                        ids.push(id?);
                    }
                }

                let query = format!(
                    "SELECT description 
                        FROM text_table 
                        WHERE rowid IN ({}) 
                        ORDER BY vec_distance_cosine(
                            (SELECT embedding FROM embeddings WHERE rowid = text_table.rowid), 
                            ?
                        ) ASC 
                        LIMIT 1",
                    ids.join(",")
                );

                // Scope needed to drop borrowing of transaction
                {
                    let mut stmt = transaction.prepare(&query)?;
                    let rows = stmt.query_map(params![query_embedding.as_bytes()], |row| {
                        row.get::<_, String>(0)
                    })?;

                    for description in rows {
                        results.push(description?);
                    }
                }

                transaction.commit()?;

                println!("Memories retrieved: {:#?}", results);
                Ok(results)
            })
            .await
            .map_err(|e| eyre::eyre!("Failed to retrieve memories: {}", e))
    }

    // Sanity check: sqlite vec extension is loaded
    pub async fn sqlite_vec_version(database: &Connection) -> eyre::Result<()> {
        let version: String = database
            .call(|db| {
                db.query_row("SELECT vec_version();", [], |row| row.get(0))
                    .map_err(|e| e.into())
            })
            .await
            .expect("Failed to get vec version");

        println!("Vec version: {}", version);

        Ok(())
    }
}

// To do: Create in memory DB for tests purposes
#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_db_operations() {
        let config = Config::from_toml("./config.tests.toml").expect("Failed to load test config");
        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];
        let text: String = "Text sample".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .into_iter()
        .cloned()
        .collect();

        DbManager::insert_embedding_and_text(
            &database,
            text.clone(),
            float_vec.clone(),
            storage_keys,
        )
        .await
        .expect("Failed to insert embedding and text");

        let vec: Vec<f32> = vec![0.1, 0.1, 0.1, 0.1];
        let retrieval_keys: HashMap<String, String> = [("key1".to_string(), "1".to_string())]
            .into_iter()
            .cloned()
            .collect();
        let retrieved_memories = DbManager::retrieve_memories(&database, vec, retrieval_keys)
            .await
            .expect("Failed to retrieve memories");

        assert_eq!(
            retrieved_memories[0],
            "Text sample".to_string(),
            "No memories retrieved"
        );
    }

    #[tokio::test]
    async fn test_embedding_precision() {
        let config = Config::from_toml("./config.tests.toml").expect("Failed to load test config");
        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];
        // Cloned to be able to assert at the bottom of the fn
        let float_vec_clone = float_vec.clone();
        
        let text: String = "Text sample".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .into_iter()
        .cloned()
        .collect();

        DbManager::insert_embedding_and_text(
            &database,
            text.clone(),
            float_vec.clone(),
            storage_keys,
        )
        .await
        .expect("Failed to insert embedding and text");

        let result: Vec<u8> = database
            .call(|db| {
                db.query_row(
                    "
                SELECT
                    embedding
                FROM embeddings
                ",
                    [],
                    |row| row.get(0),
                )
                .map_err(|e| e.into())
            })
            .await
            .expect("Failed to retrieve row");

        // Convert Vec<u8> back to Vec<f32>
        let float_vec: Vec<f32> = result
            .chunks_exact(4)
            .map(|chunk| {
                let arr: [u8; 4] = chunk.try_into().expect("Chunk must be 4 bytes");
                f32::from_le_bytes(arr)
            })
            .collect();

        // Ensure no precision is lost
        assert_eq!(
            float_vec,
            vec![0.1, 0.2, 0.3, 0.4],
            "Values should be identical"
        );
    }
}
