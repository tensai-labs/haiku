use std::collections::HashMap;

pub mod config_types;

#[derive(Debug, Clone, Default)]
pub struct PromptMessage {
    pub event_id: u32,
    pub prompt: String,
    pub event_tag: String,
    pub retrieval_key_values: HashMap<String, i32>,
    pub timestamp: u64,
}
