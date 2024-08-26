pub mod config_types;

#[derive(Debug, Clone)]
pub struct PromptMessage {
    pub prompt: String,
    pub config_name: String,
}
