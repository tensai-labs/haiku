use std::collections::HashMap;

pub mod config_types;
pub mod llm_client;

#[derive(Debug, Clone, Default)]
pub struct PromptMessage {
    pub event_id: u32,
    pub event_tag: String,
    pub prompt: String,
    pub retrieval_key_values: HashMap<String, String>,
    pub storage_key_values: HashMap<String, String>,
    pub timestamp: u64,
}
