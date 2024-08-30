use async_trait::async_trait;
// use eyre::Result;
use eyre::eyre;
use reqwest::Client;
use serde_json::Value;

use crate::secrets::Secrets;
use crate::types::config_types::Config;
use crate::types::llm_client::traits::EmbeddingProvider;

pub struct BaaiBGEProvider {
    config: Config,
    client: Client,
    secrets: Secrets,
}

impl BaaiBGEProvider {
    pub fn new(config: &Config, secrets: &Secrets) -> Self {
        Self {
            config: config.clone(),
            client: Client::new(),
            secrets: secrets.clone(),
        }
    }
}

#[async_trait]
impl EmbeddingProvider for BaaiBGEProvider {
    async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        let response = self
            .client
            .post(&self.config.haiku.llm.embedding_url)
            .header(
                "Authorization",
                format!("Bearer {}", self.secrets.embedding_token),
            )
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({ "inputs": text }))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(eyre!(format!(
                "Vectorization API request failed: {}",
                response.status()
            )));
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
