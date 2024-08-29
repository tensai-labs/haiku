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

    pub fn to_toml<P: AsRef<Path>>(
        &self,
        config_file_path: P,
    ) -> Result<(), Box<dyn std::error::Error>> {
        let content = toml::to_string_pretty(self)?;
        std::fs::write(config_file_path, content)?;
        Ok(())
    }
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Config {
    pub haiku: Haiku,
    pub events: Vec<Event>,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Haiku {
    pub name: String,
    pub metadata: Metadata,
    pub context: Context,
    pub llm: Llm,
    pub db_config: DbConfig,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Metadata {
    pub torii_url: String,
    pub rpc_url: String,
    pub relay_url: String,
    pub database_url: String,
    pub world_address: String,
    pub signer_address: String,
    pub signer_private_key: String,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Llm {
    pub chat_completion_provider: String,
    pub embedding_provider: String,
    pub embedding_model: String,
    pub ai_model: String,
    pub ai_url: String,
    pub ai_token: String,
    pub embedding_url: String,
    pub embedding_token: String,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct DbConfig {
    pub vector_size: String,
    pub number_memory_to_retrieve: String,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Context {
    pub story: String,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Event {
    pub tag: String,
    pub prompt: FieldsContext,
    pub db_keys: DbKeys,
    pub keys_mapping: Vec<KeysMapping>,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct FieldsContext {
    pub template: String,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct DbKeys {
    pub storage_keys: Vec<String>,
    pub retrieval_keys: Vec<String>,
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct KeysMapping {
    pub key: String,
    pub alias: String,
}
