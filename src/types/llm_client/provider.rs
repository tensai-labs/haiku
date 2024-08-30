use tokio_retry::strategy::{jitter, ExponentialBackoff};
use tokio_retry::Retry;

use crate::secrets::Secrets;
use crate::types::config_types::Config;
use crate::types::llm_client::providers::{
    baai_bge::BaaiBGEProvider, ollama::OllamaProvider, openai::OpenAIProvider,
};
use crate::types::llm_client::traits::{ChatCompletionProvider, EmbeddingProvider};

pub fn create_chat_provider(
    provider_name: &str,
    config: &Config,
    secrets: &Secrets,
) -> Result<Box<dyn ChatCompletionProvider>, eyre::Report> {
    match provider_name {
        "ollama" => Ok(Box::new(OllamaProvider::new(config, secrets))),
        "openai" => Ok(Box::new(OpenAIProvider::new(config, secrets))),
        _ => {
            return Err(eyre::eyre!(
                "Unsupported chat completion provider: {}",
                provider_name
            ))
        }
    }
}

pub fn create_embedding_provider(
    provider_name: &str,
    config: &Config,
    secrets: &Secrets,
) -> Result<Box<dyn EmbeddingProvider>, eyre::Report> {
    match provider_name {
        "ollama" => Ok(Box::new(OllamaProvider::new(config, secrets))),
        "openai" => Ok(Box::new(OpenAIProvider::new(config, secrets))),
        "baai-bge" => Ok(Box::new(BaaiBGEProvider::new(config, secrets))),
        _ => return Err(eyre::eyre!("Unsupported embedding provider")),
    }
}

pub struct Provider {
    chat_provider: Box<dyn ChatCompletionProvider>,
    embedding_provider: Box<dyn EmbeddingProvider>,
}

impl Provider {
    pub fn new(config: &Config, secrets: &Secrets) -> eyre::Result<Self> {
        let chat_provider = create_chat_provider(
            config.haiku.llm.chat_completion_provider.as_str(),
            config,
            secrets,
        )?;
        let embedding_provider = create_embedding_provider(
            &config.haiku.llm.embedding_provider.as_str(),
            config,
            secrets,
        )?;

        Ok(Self {
            chat_provider,
            embedding_provider,
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
