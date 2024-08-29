use async_trait::async_trait;
use eyre::Result;

use crate::utils::llm_providers::ollama::OllamaProvider;
use crate::types::config_types::Config;

pub enum LlmProvider {
    Ollama(OllamaProvider)
    // OpenAi(OpenAiProvider),
    // Grok(GrokProvider),
    // Claude(ClaudeProvider),
}

#[async_trait]
pub trait ProviderCapabilities {
    fn new(config: &Config) -> Result<Self> where Self: Sized;
    async fn request_chat_completion(&self, text: &str) -> Result<String>;
    async fn request_embedding(&self, text: &str) -> Result<Vec<f32>>;
}

// pub struct OllamaProvider {

// }

// pub struct OpenAiProvider {
//     // OpenAI-specific fields
// }

// pub struct GrokProvider {
//     // Grok-specific fields
// }

// pub struct ClaudeProvider {
//     // Claude-specific fields
// }