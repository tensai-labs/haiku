use rusqlite::ffi::sqlite3_auto_extension;
use sqlite_vec::sqlite3_vec_init;
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

        #[cfg(not(test))]
        let database =
            DbManager::open_connection(&config.haiku.metadata.database_url.clone()).await?;

        #[cfg(test)]
        let database = DbManager::open_test_connection().await?;

        DbManager::check_loaded_extension(&database).await?;

        DbManager::create_tables(&database, config).await?;

        tracing::info!("Database created successfully");

        Ok(database)
    }

    pub async fn open_connection(database_url: &str) -> eyre::Result<Connection> {
        let database = Connection::open(database_url)
            .await
            .expect("Failed to open database");

        Ok(database)
    }

    #[cfg(test)]
    pub async fn open_test_connection() -> eyre::Result<Connection> {
        let database = Connection::open_in_memory()
            .await
            .expect("Failed to open in-memory database");

        Ok(database)
    }

    pub async fn create_tables(database: &Connection, config: &Config) -> eyre::Result<()> {
        let mut all_keys: Vec<String> = Vec::new();
        for event in &config.events {
            all_keys.extend(event.db_keys.storage_keys.iter().cloned());
            all_keys.extend(event.db_keys.retrieval_keys.iter().cloned());
        }
        all_keys.sort();
        all_keys.dedup();

        let create_core_tables = format!(
            "CREATE VIRTUAL TABLE IF NOT EXISTS embedding USING vec0(vector float[{}]);
             CREATE TABLE IF NOT EXISTS description (
                 id INTEGER PRIMARY KEY,
                 content TEXT NOT NULL
             );",
            config.haiku.db_config.vector_size
        );

        database
            .call(move |db| {
                let transaction = db.transaction()?;

                transaction.execute_batch(&create_core_tables)?;

                for key in all_keys {
                    let create_key_table = format!(
                        "CREATE TABLE IF NOT EXISTS {key} (
                            id TEXT PRIMARY KEY,
                            value TEXT NOT NULL
                        )"
                    );
                    transaction.execute(&create_key_table, [])?;
                }

                transaction.commit()?;
                Ok(())
            })
            .await?;

        tracing::info!("Database tables created successfully");
        Ok(())
    }

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
                    "INSERT INTO embedding (vector) VALUES (?)",
                    params![embedded_vector.as_bytes()],
                )?;
                let embedding_row_id = transaction.last_insert_rowid();

                transaction.execute(
                    "INSERT INTO description (content) VALUES (?)",
                    params![text],
                )?;
                let description_row_id = transaction.last_insert_rowid();

                assert_eq!(
                    embedding_row_id, description_row_id,
                    "description & embedding need to be stored at the same idx"
                );

                for (key, value) in &storage_keys {
                    let query = format!("INSERT INTO {key} (id, value) VALUES (?, ?)");
                    transaction.execute(&query, params![embedding_row_id.to_string(), value])?;
                }

                transaction.commit()?;
                Ok((embedding_row_id, description_row_id))
            })
            .await
            .map_err(|e| eyre::eyre!("Failed to insert embedding and description: {}", e))
    }

    pub async fn retrieve_memories(
        database: &Connection,
        query_embedding: Vec<f32>,
        retrieval_keys: HashMap<String, String>,
        limit: String,
    ) -> eyre::Result<Vec<String>> {
        database
            .call(move |db| {
                let transaction = db.transaction()?;
                let mut memories = Vec::new();

                let mut ids = Vec::new();
                for (key, value) in &retrieval_keys {
                    let query = format!("SELECT id FROM {key} WHERE value = ?");
                    let mut stmt = transaction.prepare(&query)?;
                    let rows = stmt.query_map([value], |row| row.get::<_, String>(0))?;

                    for id in rows {
                        ids.push(id?);
                    }
                }

                let query = format!(
                    "SELECT content 
                        FROM description 
                        WHERE rowid IN ({}) 
                        ORDER BY vec_distance_cosine(
                            (SELECT vector FROM embedding WHERE rowid = description.rowid), 
                            ?
                        ) ASC 
                        LIMIT {limit}",
                    ids.join(",")
                );

                // Scope needed to drop borrowing of transaction
                {
                    let mut stmt = transaction.prepare(&query)?;
                    let rows = stmt.query_map(params![query_embedding.as_bytes()], |row| {
                        row.get::<_, String>(0)
                    })?;

                    for content in rows {
                        memories.push(content?);
                    }
                }

                transaction.commit()?;

                Ok(memories)
            })
            .await
            .map_err(|e| eyre::eyre!("Failed to retrieve memories: {}", e))
    }

    // Sanity check: sqlite vec extension is loaded
    pub async fn check_loaded_extension(database: &Connection) -> eyre::Result<()> {
        database
            .call(|db| {
                db.query_row("SELECT vec_version();", [], |row| row.get::<_, String>(0))
                    .map_err(|e| e.into())
            })
            .await
            .expect("Sqlite-vec extension not loaded");

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::convert::TryInto;

    #[tokio::test]
    async fn test_db_operations() {
        let config = Config::default();
        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];
        let text: String = "Text sample".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .iter()
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
            .iter()
            .cloned()
            .collect();
        let retrieved_memories = DbManager::retrieve_memories(
            &database,
            vec,
            retrieval_keys,
            config.haiku.db_config.number_memory_to_retrieve,
        )
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
        let config = Config::default();
        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];

        let text: String = "Text sample".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .iter()
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
                    vector
                FROM embedding
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
