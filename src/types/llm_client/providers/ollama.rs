use async_trait::async_trait;
use eyre::Result;
use reqwest::Client;
use serde_json::Value;

use crate::types::config_types::Config;
use crate::types::llm_client::traits::ChatCompletionProvider;

pub struct OllamaProvider {
    config: Config,
    client: Client,
}

impl OllamaProvider {
    pub fn new(config: &Config) -> Self {
        Self {
            config: config.clone(),
            client: Client::new(),
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
