use std::path::Path;

use serde::{Deserialize, Serialize};

impl Config {
    pub fn from_toml<P: AsRef<Path>>(
        config_file_path: P,
    ) -> Result<Self, Box<dyn std::error::Error>> {
        let content = std::fs::read_to_string(config_file_path)?;
        let config: Config = toml::from_str(&content)?;
        Ok(config)
    }
}

impl Default for Config {
    fn default() -> Self {
        Config {
            haiku: Haiku {
                name: "haiku_example".to_string(),
                metadata: Metadata {
                    torii_url: "http://localhost:8080".to_string(),
                    rpc_url: "http://localhost:5050".to_string(),
                    world_address:
                        "0x34d4e2fcecd511a3286e6acc3e0108ff5d6b7e9290876f988a76163ade950b2"
                            .to_string(),
                    relay_url: "".to_string(),
                    database_url: "haiku.db".to_string(),
                    signer_address:
                        "0x0101010101010101010101010101010101010101010101010101010101010101"
                            .to_string(),
                    signer_public_key:
                        "0x0101010101010101010101010101010101010101010101010101010101010101"
                            .to_string(),
                    signer_private_key:
                        "0x0101010101010101010101010101010101010101010101010101010101010101"
                            .to_string(),
                },
                llm: Llm {
                    model: "haiku".to_string(),
                    ai_url: "http://localhost:11434/api/generate".to_string(),
                    ai_token: "".to_string(),
                    vectorization_url:
                        "https://api-inference.huggingface.co/models/BAAI/bge-small-en-v1.5"
                            .to_string(),
                    vectorization_token: "hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx".to_string(),
                },
                db_config: DbConfig {
                    vector_size: "4".to_string(),
                    number_memory_to_retrieve: "1".to_string(),
                },
                context: Context {
                    story: "The game is a dungeon crawler.".to_string(),
                },
            },
            events: vec![Event {
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
            }],
        }
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Config {
    pub haiku: Haiku,
    pub events: Vec<Event>,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Haiku {
    pub name: String,
    pub metadata: Metadata,
    pub context: Context,
    pub llm: Llm,
    pub db_config: DbConfig,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Metadata {
    pub torii_url: String,
    pub rpc_url: String,
    pub relay_url: String,
    pub database_url: String,
    pub world_address: String,
    pub signer_address: String,
    pub signer_public_key: String,
    pub signer_private_key: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Llm {
    pub model: String,
    pub ai_url: String,
    pub ai_token: String,
    pub vectorization_url: String,
    pub vectorization_token: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct DbConfig {
    pub vector_size: String,
    pub number_memory_to_retrieve: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Context {
    pub story: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Event {
    pub tag: String,
    pub prompt: FieldsContext,
    pub db_keys: DbKeys,
    pub keys_mapping: Vec<KeysMapping>,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct FieldsContext {
    pub template: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct DbKeys {
    pub storage_keys: Vec<String>,
    pub retrieval_keys: Vec<String>,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct KeysMapping {
    pub key: String,
    pub alias: String,
}
