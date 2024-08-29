use eyre::eyre;
use reqwest::Client;
use serde_json::Value;
use tokio_retry::strategy::{jitter, ExponentialBackoff};
use tokio_retry::Retry;

use crate::types::config_types::Config;

pub struct LlmClient {
    client: Client,
    config: Config,
}

impl LlmClient {
    pub fn new(config: Config) -> Result<Self, Box<dyn std::error::Error>> {
        Ok(Self {
            client: Client::new(),
            config: config.clone(),
        })
    }

    pub async fn request_chat_completion(&self, text: &str) -> eyre::Result<String> {
        let response_action = || async {
            let response = self
                .client
                .post(&self.config.haiku.llm.ai_url)
                .header("Content-Type", "application/json")
                .header(
                    "Authorization",
                    format!("Bearer {}", self.config.haiku.llm.ai_token),
                )
                .json(&serde_json::json!({
                    "model": self.config.haiku.llm.model,
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
            Ok(response)
        };

        let retry_strategy = ExponentialBackoff::from_millis(100).map(jitter).take(30);

        let response = Retry::spawn(retry_strategy, response_action).await?;

        let json: Value = response.json().await?;

        let response_text = if let Some(content) = json["choices"][0]["message"]["content"].as_str()
        {
            content.to_string()
        } else {
            return Err(eyre!("Content not found or not a string"));
        };
        Ok(response_text)
    }

    pub async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        let response_action = || async {
            let response = self
                .client
                .post("https://api.openai.com/v1/embeddings")
                .header("Content-Type", "application/json")
                .header(
                    "Authorization",
                    format!("Bearer {}", self.config.haiku.llm.vectorization_token),
                )
                .json(&serde_json::json!({
                    "input": text,
                    "model": "text-embedding-3-small"
                }))
                .send()
                .await?;

            if !response.status().is_success() {
                return Err(eyre!(format!(
                    "Vectorization API request failed: {}",
                    response.status()
                )));
            }
            Ok(response)
        };

        let retry_strategy = ExponentialBackoff::from_millis(100).map(jitter).take(30);

        let response = Retry::spawn(retry_strategy, response_action).await?;

        let json: Value = response.json().await?;

        let embeddings: Vec<f32> = json
            .as_object()
            .unwrap()
            .get("data")
            .ok_or_else(|| eyre!("Data not found"))?
            .get(0)
            .ok_or_else(|| eyre!("Index out of bounds"))?
            .get("embedding")
            .ok_or_else(|| eyre!("Embedding not found"))?
            .as_array()
            .ok_or_else(|| eyre!("Embedding is not an array"))?
            .iter()
            .map(|v| v.as_f64().unwrap() as f32)
            .collect();
        Ok(embeddings)
    }
}
