use async_trait::async_trait;
use eyre::Result;

#[async_trait]
pub trait ChatCompletionProvider: Send + Sync {
    async fn request_chat_completion(&self, text: &str) -> Result<String>;
}

#[async_trait]
pub trait EmbeddingProvider: Send + Sync {
    async fn request_embedding(&self, text: &str) -> Result<Vec<f32>>;
}
