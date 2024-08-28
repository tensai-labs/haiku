use eyre::eyre;
use reqwest::Client;
use serde_json::Value;

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
        let response = self
            .client
            .post(&self.config.haiku.llm.ai_url)
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({
                "model": self.config.haiku.llm.model,
                "prompt": text,
                "stream": false
            }))
            .send()
            .await?;
        if !response.status().is_success() {
            return Err(eyre!(format!("API request failed: {}", response.status())));
        }

        let json: Value = response.json().await?;

        let response_text = json["response"]
            .as_str()
            .ok_or(eyre!(
                "Invalid JSON structure: 'response' field not found or not a string"
            ))?
            .to_string();

        Ok(response_text)
    }

    pub async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        let response = self
            .client
            .post(&self.config.haiku.llm.vectorization_url)
            .header(
                "Authorization",
                format!("Bearer {}", self.config.haiku.llm.vectorization_token),
            )
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({ "inputs": text }))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(eyre!(format!("API request failed: {}", response.status())));
        }

        let json: Value = response.json().await?;

        let embedding: Vec<f32> = json
            .as_array()
            .ok_or(eyre!("Invalid JSON structure"))?
            .iter()
            .filter_map(|v| v.as_f64().map(|f| f as f32))
            .collect();

        Ok(embedding)
    }
}
