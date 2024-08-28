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
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Metadata {
    pub torii_url: String,
    pub rpc_url: String,
    pub relay_url: String,
    pub ai_url: String,
    pub vectorization_url: String,
    pub database_url: String,
    pub world_address: String,
    pub private_key: String,
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
