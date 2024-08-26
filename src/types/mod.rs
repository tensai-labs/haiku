use std::collections::HashMap;

pub mod config_types;

#[derive(Debug, Clone)]
pub struct PromptMessage {
    pub prompt: String,
    pub config_name: String,
    pub retrieval_key_values: HashMap<String, i32>,
}
