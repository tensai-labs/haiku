use crate::types::llm_client::traits::{ChatCompletionProvider, EmbeddingProvider};
use crate::types::llm_client::provider_manager::{ProviderManager, ProviderTrait};
use crate::types::config_types::Config;

pub struct Provider {
    chat_provider: Box<dyn ChatCompletionProvider>,
    embedding_provider: Box<dyn EmbeddingProvider>,
}

impl Provider {
    pub fn new(config: &Config) -> eyre::Result<Self> {
        let provider_manager = ProviderManager;

        Ok(Self {
            chat_provider: provider_manager.create_chat_provider(config)?,
            embedding_provider: provider_manager.create_embedding_provider(config)?,
        })
    }

    pub async fn request_chat_completion(&self, text: &str) -> eyre::Result<String> {
        self.chat_provider.request_chat_completion(text).await
    }

    pub async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        self.embedding_provider.request_embedding(text).await
    }
}
