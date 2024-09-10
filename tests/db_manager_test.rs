use haiku::utils::db_manager::DbManager;
use std::collections::HashMap;
use std::convert::TryInto;

#[cfg(test)]
mod tests {
    use super::*;
    use haiku::types::config_types::{Config, DbKeys, Event, FieldsContext, KeysMapping};

    #[tokio::test]
    async fn test_db_operations() {
        let config: Config = generate_test_config();

        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];
        let text: String = "Text db ops".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .iter()
        .cloned()
        .collect();

        let mut i = 0;
        while i < 5 {
            DbManager::store_memory(
                &database,
                text.clone(),
                float_vec.clone(),
                storage_keys.clone(),
            )
            .await
            .expect("Failed to insert embedding and text");

            i += 1;
        }

        let vec: Vec<f32> = vec![0.1, 0.1, 0.1, 0.1];
        let retrieval_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .iter()
        .cloned()
        .collect();
        let retrieved_memories = DbManager::retrieve_similar_memories(
            &database,
            vec,
            retrieval_keys,
            config.haiku.db_config.number_memory_to_retrieve,
        )
        .await
        .expect("Failed to retrieve memories");

        assert_eq!(
            retrieved_memories.len(),
            1,
            "Incorrect number of memories retrieved"
        );

        assert_eq!(
            retrieved_memories[0],
            "Text db ops".to_string(),
            "No memories retrieved"
        );
    }

    #[tokio::test]
    async fn test_embedding_precision() {
        let config: Config = generate_test_config();
        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.4, 0.3, 0.2, 0.1];

        let text: String = "Text embedding".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "3".to_string()),
            ("key2".to_string(), "4".to_string()),
        ]
        .iter()
        .cloned()
        .collect();

        DbManager::store_memory(&database, text.clone(), float_vec.clone(), storage_keys)
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
            vec![0.4, 0.3, 0.2, 0.1],
            "Values should be identical"
        );
    }

    #[tokio::test]
    async fn retrieve_with_empty_retrieval_keys_test() {
        let mut config: Config = generate_test_config();
        config.haiku.db_config.number_memory_to_retrieve = "100".to_string();

        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let float_vec: Vec<f32> = vec![0.1, 0.2, 0.3, 0.4];
        let text: String = "Text db ops".to_string();
        let storage_keys: HashMap<String, String> = [
            ("key1".to_string(), "1".to_string()),
            ("key2".to_string(), "2".to_string()),
        ]
        .iter()
        .cloned()
        .collect();

        let mut i = 0;
        while i < 5 {
            DbManager::store_memory(
                &database,
                text.clone(),
                float_vec.clone(),
                storage_keys.clone(),
            )
            .await
            .expect("Failed to insert embedding and text");

            i += 1;
        }

        let vec: Vec<f32> = vec![0.1, 0.1, 0.1, 0.1];
        let retrieval_keys: HashMap<String, String> = [].iter().cloned().collect();
        let retrieved_memories = DbManager::retrieve_similar_memories(
            &database,
            vec,
            retrieval_keys,
            config.haiku.db_config.number_memory_to_retrieve,
        )
        .await
        .expect("Failed to retrieve memories");

        assert!(
            !retrieved_memories.is_empty(),
            "Incorrect number of memories retrieved"
        );
    }

    fn generate_test_config() -> Config {
        let mut config = Config::default();
        config.haiku.name = "haiku_example".to_string();
        config.haiku.metadata.torii_url = "http://localhost:8080".to_string();
        config.haiku.metadata.rpc_url = "http://localhost:5050".to_string();
        config.haiku.metadata.world_address =
            "0x34d4e2fcecd511a3286e6acc3e0108ff5d6b7e9290876f988a76163ade950b2".to_string();
        config.haiku.metadata.database_url = ":memory:".to_string();
        config.haiku.llm.chat_completion_provider = "ollama".to_string();
        config.haiku.llm.embedding_provider = "baai-bge".to_string();
        config.haiku.llm.chat_completion_model = "haiku".to_string();
        config.haiku.llm.chat_completion_url = "http://localhost:11434/api/generate".to_string();
        config.haiku.llm.embedding_url =
            "https://api-inference.huggingface.co/models/BAAI/bge-small-en-v1.5".to_string();
        config.haiku.db_config.vector_size = "4".to_string();
        config.haiku.db_config.number_memory_to_retrieve = "1".to_string();
        config.haiku.context.story = "The game is a dungeon crawler.".to_string();

        config.events.push(Event {
            tag: "dojo_examples-Moved".to_string(),
            prompt: FieldsContext {
                template: "The player ${player} is moving ${direction}.".to_string(),
            },
            db_keys: DbKeys {
                storage_keys: vec!["key1".to_string(), "key2".to_string()],
                retrieval_keys: vec!["player".to_string()],
            },
            keys_mapping: vec![
                KeysMapping {
                    key: "slip".to_string(),
                    alias: "realm_entity_id".to_string(),
                },
                KeysMapping {
                    key: "target_entity_id".to_string(),
                    alias: "realm_entity_id".to_string(),
                },
            ],
        });

        config
    }
}
