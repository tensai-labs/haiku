use tokio_rusqlite::Connection;

use crate::types::config_types::Config;

pub struct DbManager;

impl DbManager {
    pub async fn init_db(config: &Config) -> eyre::Result<Connection> {
        let database =
            DbManager::open_connection(&config.haiku.metadata.database_url.clone()).await?;
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
}
