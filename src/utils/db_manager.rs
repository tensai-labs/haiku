use tokio_rusqlite::Connection;

use crate::types::config_types::Config;

use rusqlite::ffi::sqlite3_auto_extension;
use sqlite_vec::sqlite3_vec_init;

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
    pub async fn create_primary_tables(database: &Connection) -> eyre::Result<()> {
        database
            .call(|db| {
                db.execute_batch(
                    "CREATE VIRTUAL TABLE IF NOT EXISTS embeddings USING vec0(embedding float[4]);
                 CREATE TABLE IF NOT EXISTS text (
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
