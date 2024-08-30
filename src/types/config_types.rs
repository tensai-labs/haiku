use std::path::Path;

use serde::{Deserialize, Serialize};

impl Config {
    pub fn from_toml<P: AsRef<Path>>(
        config_file_path: P,
    ) -> Result<Self, Box<dyn std::error::Error>> {
        let content = std::fs::read_to_string(config_file_path)?;
        let config: Config = toml::from_str(&content)?;
        config.ensure_valid_configuration();

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

    fn ensure_valid_configuration(&self) {
        assert_ne!(
            self.haiku.db_config.vector_size, "0",
            "Vector size cannot be zero."
        );

        assert_ne!(
            self.haiku.llm.chat_completion_provider, "",
            "Chat completion provider cannot be empty."
        );

        assert_ne!(
            self.haiku.llm.chat_completion_model, "",
            "AI model cannot be empty."
        );

        assert_ne!(
            self.haiku.llm.chat_completion_url, "",
            "AI URL cannot be empty."
        );

        assert_ne!(
            self.haiku.llm.embedding_provider, "",
            "Embedding provider cannot be empty."
        );

        assert_ne!(
            self.haiku.llm.embedding_model, "",
            "Embedding model cannot be empty."
        );

        assert_ne!(
            self.haiku.llm.embedding_url, "",
            "Embedding URL cannot be empty."
        );
    }
}

impl Default for Config {
    fn default() -> Self {
        Config {
            haiku: Haiku {
                name: "haiku".to_string(),
                metadata: Metadata {
                    torii_url: "http://localhost:8080/".to_string(),
                    rpc_url: "http://localhost:5050/".to_string(),
                    relay_url: "/ip4/127.0.0.1/udp/9090/quic-v1".to_string(),
                    database_url: "torii.db".to_string(),
                    world_address: "".to_string(),
                },
                context: Context {
                    story: "Replace this text by a compelling narrative that encapsulates the overarching theme, setting, and key elements of your game world. This should provide a rich, immersive context for all subsequent interactions and events.".to_string(),
                },
                llm: Llm {
					chat_completion_provider: "openai".to_string(),
                    chat_completion_model: "gpt-4o-mini".to_string(),
                    chat_completion_url: "https://api.openai.com/v1/chat/completions".to_string(),
                    embedding_provider: "openai".to_string(),
                    embedding_model: "text-embedding-3-small".to_string(),
                    embedding_url: "https://api.openai.com/v1/embeddings".to_string(),
                },
                db_config: DbConfig {
                    vector_size: "1536".to_string(),
                    number_memory_to_retrieve: "1".to_string(),
                },
            },
            events: vec![],
        }
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
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
}

#[derive(Serialize, Deserialize, Debug, Clone, Default)]
pub struct Llm {
    pub chat_completion_provider: String,
    pub chat_completion_model: String,
    pub chat_completion_url: String,
    pub embedding_provider: String,
    pub embedding_model: String,
    pub embedding_url: String,
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
