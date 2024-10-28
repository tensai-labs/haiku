use async_trait::async_trait;
use eyre::{eyre, Result};
use reqwest::Client;
use serde_json::Value;

use crate::secrets::Secrets;
use crate::types::config_types::Config;
use crate::types::llm_client::traits::{ChatCompletionProvider, EmbeddingProvider};

pub struct OllamaProvider {
    config: Config,
    client: Client,
    secrets: Secrets,
}

impl OllamaProvider {
    pub fn new(config: &Config, secrets: &Secrets) -> Self {
        Self {
            config: config.clone(),
            client: Client::new(),
            secrets: secrets.clone(),
        }
    }
}

#[async_trait]
impl ChatCompletionProvider for OllamaProvider {
    async fn request_chat_completion(&self, text: &str) -> Result<String> {
        let response = self
            .client
            .post(&self.config.haiku.llm.chat_completion_url)
            .json(&serde_json::json!({
                "model": self.config.haiku.llm.chat_completion_model,
                "prompt": text,
                "stream": false
            }))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(eyre::eyre!("API request failed: {}", response.status()));
        }

        let json: Value = response.json().await?;
        let completion = json["response"]
            .as_str()
            .ok_or_else(|| eyre::eyre!("Invalid response format"))?;

        Ok(completion.to_string())
    }
}

#[async_trait]
impl EmbeddingProvider for OllamaProvider {
    async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        let response = self
            .client
            .post(&self.config.haiku.llm.embedding_url)
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({"model": &self.config.haiku.llm.embedding_model, "prompt": text}))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(eyre!(format!(
                "Vectorization API request failed: {}",
                response.status()
            )));
        }

        let json: Value = response.json().await?;

        let embedding: Vec<f32> = json["embedding"]
            .as_array()
            .ok_or(eyre!("Invalid JSON structure"))?
            .iter()
            .filter_map(|v| v.as_f64().map(|f| f as f32))
            .collect();

        Ok(embedding)
    }
}
