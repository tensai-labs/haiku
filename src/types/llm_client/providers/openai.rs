use async_trait::async_trait;
use eyre::eyre;
use eyre::Result;
use reqwest::Client;
use serde_json::Value;

use crate::types::config_types::Config;
use crate::types::llm_client::traits::{ChatCompletionProvider, EmbeddingProvider};

pub struct OpenAIProvider {
    config: Config,
    client: Client,
}

impl OpenAIProvider {
    pub fn new(config: &Config) -> Self {
        Self {
            config: config.clone(),
            client: Client::new(),
        }
    }
}

#[async_trait]
impl ChatCompletionProvider for OpenAIProvider {
    async fn request_chat_completion(&self, text: &str) -> Result<String> {
        let response = self
            .client
            .post(&self.config.haiku.llm.ai_url)
            .header("Content-Type", "application/json")
            .header(
                "Authorization",
                format!("Bearer {}", self.config.haiku.llm.ai_token),
            )
            .json(&serde_json::json!({
                "model": self.config.haiku.llm.ai_model,
                "messages": [{"role": "user", "content": text}],
                "response_format": { "type": "text" }
            }))
            .send()
            .await?;
        if !response.status().is_success() {
            return Err(eyre!(format!(
                "Chat completion API request failed: {}",
                response.status()
            )));
        }

        let json: Value = response.json().await?;

        let completion = json["choices"][0]["message"]["content"]
            .as_str()
            .ok_or_else(|| eyre::eyre!("Invalid response format"))?;

        Ok(completion.to_string())
    }
}

#[async_trait]
impl EmbeddingProvider for OpenAIProvider {
    async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        let response = self
            .client
            .post(&self.config.haiku.llm.embedding_url)
            .header(
                "Authorization",
                format!("Bearer {}", self.config.haiku.llm.embedding_token),
            )
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({ "input": text, "model": &self.config.haiku.llm.embedding_model, "encoding_format": "float"}))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(eyre!(format!(
                "Vectorization API request failed: {}",
                response.status()
            )));
        }

        let json: Value = response.json().await?;

        let embedding: Vec<f32> = json["data"][0]["embedding"]
            .as_array()
            .ok_or(eyre!("Invalid JSON structure"))?
            .iter()
            .filter_map(|v| v.as_f64().map(|f| f as f32))
            .collect();

        Ok(embedding)
    }
}
