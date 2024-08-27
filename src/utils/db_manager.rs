use tokio_rusqlite::Connection;

use crate::types::config_types::Config;

use rusqlite::ffi::sqlite3_auto_extension;
use sqlite_vec::sqlite3_vec_init;

pub struct DbManager;

// Used by sqlite_vec test fn
use std::convert::TryInto;
use tokio_rusqlite::params;
use zerocopy::AsBytes;

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

    // pub async fn insert_embedding(database: &Connection, storage_keys: ) {

    // }

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

pub async fn test_sqlite_vec_db(database: &Connection) -> eyre::Result<Vec<f32>> {
    let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];
    // Cloned to be able to assert at the bottom of the fn
    let float_vec_clone = float_vec.clone();

    // Sanity check: insert vector embedding
    database
        .call(move |db| {
            db.execute(
                "INSERT INTO embeddings (embedding) VALUES (?)",
                // Convert Vec<f32> to Vec<u8>
                params![float_vec_clone.as_bytes()],
            )
            .map_err(|e| e.into())
        })
        .await
        .expect("Failed to insert row");

    // Sanity check: retrieve stored vector embedding
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

    Ok(float_vec)
}
