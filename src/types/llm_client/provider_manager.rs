use crate::types::config_types::Config;
use crate::types::llm_client::providers::{
    baai_bge::BaaiBGEProvider, ollama::OllamaProvider, openai::OpenAIProvider,
};
use crate::types::llm_client::traits::{ChatCompletionProvider, EmbeddingProvider};

pub trait ProviderTrait {
    fn create_chat_provider(
        &self,
        config: &Config,
    ) -> Result<Box<dyn ChatCompletionProvider>, eyre::Report>;
    fn create_embedding_provider(
        &self,
        config: &Config,
    ) -> Result<Box<dyn EmbeddingProvider>, eyre::Report>;
}
pub struct ProviderManager;

impl ProviderTrait for ProviderManager {
    fn create_chat_provider(
        &self,
        config: &Config,
    ) -> eyre::Result<Box<dyn ChatCompletionProvider>> {
        match config.haiku.llm.chat_completion_provider.as_str() {
            "ollama" => Ok(Box::new(OllamaProvider::new(config))),
            "openai" => Ok(Box::new(OpenAIProvider::new(config))),

            _ => Err(eyre::eyre!("Unsupported chat completion provider")),
        }
    }

    fn create_embedding_provider(
        &self,
        config: &Config,
    ) -> eyre::Result<Box<dyn EmbeddingProvider>> {
        match config.haiku.llm.embedding_provider.as_str() {
            "baai-bge" => Ok(Box::new(BaaiBGEProvider::new(config))),
            "openai" => Ok(Box::new(OpenAIProvider::new(config))),

            _ => Err(eyre::eyre!("Unsupported embedding provider")),
        }
    }
}
