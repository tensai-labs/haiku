use tokio_retry::strategy::{jitter, ExponentialBackoff};
use tokio_retry::Retry;

use crate::secrets::Secrets;
use crate::types::config_types::Config;
use crate::types::llm_client::provider_manager::{ProviderManager, ProviderTrait};
use crate::types::llm_client::traits::{ChatCompletionProvider, EmbeddingProvider};

pub struct Provider {
    chat_provider: Box<dyn ChatCompletionProvider>,
    embedding_provider: Box<dyn EmbeddingProvider>,
}

impl Provider {
    pub fn new(config: &Config, secrets: &Secrets) -> eyre::Result<Self> {
        let provider_manager = ProviderManager;

        Ok(Self {
            chat_provider: provider_manager.create_chat_provider(config, secrets)?,
            embedding_provider: provider_manager.create_embedding_provider(config, secrets)?,
        })
    }

    pub async fn request_chat_completion(&self, text: &str) -> eyre::Result<String> {
        let retry_closure = || async { self.chat_provider.request_chat_completion(text).await };

        let retry_strategy = ExponentialBackoff::from_millis(100).map(jitter).take(30);

        Retry::spawn(retry_strategy, retry_closure).await
    }

    pub async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        let retry_closure = || async { self.embedding_provider.request_embedding(text).await };

        let retry_strategy = ExponentialBackoff::from_millis(100).map(jitter).take(30);

        Retry::spawn(retry_strategy, retry_closure).await
    }
}
