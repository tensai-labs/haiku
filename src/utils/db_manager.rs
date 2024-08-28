use rusqlite::ffi::sqlite3_auto_extension;
use sqlite_vec::sqlite3_vec_init;
use tokio_rusqlite::{params, Connection};

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
                            id TEXT,
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

    pub async fn store_memory(
        database: &Connection,
        response: String,
        embedding: Vec<f32>,
        storage_keys: HashMap<String, String>,
    ) -> eyre::Result<((i64, i64))> {
        database
            .call(move |db| {
                let transaction = db.transaction()?;

                // Convert Vec<f32> to Vec<u8> directly
                let vector_bytes: Vec<u8> = embedding
                    .iter()
                    .flat_map(|&f| f.to_le_bytes().to_vec())
                    .collect();

                transaction.execute(
                    "INSERT INTO embedding (vector) VALUES (?)",
                    params![vector_bytes],
                )?;
                let embedding_row_id = transaction.last_insert_rowid();

                transaction.execute(
                    "INSERT INTO description (content) VALUES (?)",
                    params![response],
                )?;
                let description_row_id = transaction.last_insert_rowid();

                assert_eq!(
                    embedding_row_id, description_row_id,
                    "description & embedding need to be stored at the same idx"
                );

                for (key, id) in &storage_keys {
                    let query = format!("INSERT INTO {key} (id, value) VALUES (?, ?)");
                    transaction.execute(&query, params![id, embedding_row_id.to_string()])?;
                }

                transaction.commit()?;
                Ok((description_row_id, embedding_row_id))
            })
            .await
            .map_err(|e| eyre::eyre!("Failed to insert embedding and description: {}", e))
    }

    // TODO:RENAME
    pub async fn retrieve_similar_memories(
        database: &Connection,
        query_embedding: Vec<f32>,
        retrieval_keys: HashMap<String, String>,
        limit: String,
    ) -> eyre::Result<Vec<String>> {
        database
            // .call(move |db| {
            .call(move |conn| {
                let transaction = conn.transaction()?;
                let mut memories = Vec::new();

                let mut values = Vec::new();
                for (key, id) in &retrieval_keys {
                    let query = format!("SELECT value FROM {key} WHERE id = ?");
                    let mut stmt = transaction.prepare(&query)?;
                    let rows = stmt.query_map([id], |row| row.get::<_, String>(0))?;

                    for value in rows {
                        values.push(value?);
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
                    values.join(",")
                );

                // Convert Vec<f32> to Vec<u8> directly
                let vector_bytes: Vec<u8> = query_embedding
                    .iter()
                    .flat_map(|&f| f.to_le_bytes().to_vec())
                    .collect();

                // Scope needed to drop borrowing of transaction
                {
                    let mut stmt = transaction.prepare(&query)?;
                    let rows =
                        stmt.query_map(params![vector_bytes], |row| row.get::<_, String>(0))?;

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
