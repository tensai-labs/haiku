use eyre::eyre;

use crate::types::config_types::Config;
use crate::types::providers::LlmProvider;
use crate::utils::llm_providers::ollama::OllamaProvider;
use crate::types::providers::ProviderCapabilities;

pub struct LlmClient {
    provider: LlmProvider,
}

impl LlmClient {
    // pub fn new(config: Config) -> Result<Self, Box<dyn std::error::Error>> {
    //     Ok(Self {
    //         client: Client::new(),
    //         config: config.clone(),
    //     })
    // }

    pub fn new(config: &Config) -> Result<Self, eyre::Report> {
        // let provider = match config.haiku.llm.provider.as_str() {
        let provider = match "ollama" {
            "ollama" => LlmProvider::Ollama(OllamaProvider::new(config)?),
            // "openai" => LlmProvider::OpenAi(OpenAiProvider::new(config)?),
            // "grok" => LlmProvider::Grok(GrokProvider::new(config)?),
            // "claude" => LlmProvider::Claude(ClaudeProvider::new(config)?),
            _ => return Err(eyre!("Unsupported LLM provider")),
        };

        Ok(Self { provider })
    }

    pub async fn request_chat_completion(&self, text: &str) -> eyre::Result<String> {
        match &self.provider {
            LlmProvider::Ollama(p) => p.request_chat_completion(text).await,
            // LlmProvider::OpenAi(p) => p.request_chat_completion(text).await,
            // LlmProvider::Grok(p) => p.request_chat_completion(text).await,
            // LlmProvider::Claude(p) => p.request_chat_completion(text).await,
        }
    }

    pub async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
        match &self.provider {
            LlmProvider::Ollama(p) => p.request_embedding(text).await,
            // LlmProvider::OpenAi(p) => p.request_embedding(text).await,
            // LlmProvider::Grok(p) => p.request_embedding(text).await,
            // LlmProvider::Claude(p) => p.request_embedding(text).await,
        }
    }

    // pub async fn request_chat_completion(&self, text: &str) -> eyre::Result<String> {
    //     let response = self
    //         .client
    //         .post(&self.config.haiku.llm.ai_url)
    //         .header("Content-Type", "application/json")
    //         .json(&serde_json::json!({
    //             "model": self.config.haiku.llm.model,
    //             "prompt": text,
    //             "stream": false
    //         }))
    //         .send()
    //         .await?;
    //     if !response.status().is_success() {
    //         return Err(eyre!(format!("API request failed: {}", response.status())));
    //     }

    //     let json: Value = response.json().await?;

    //     let response_text = json["response"]
    //         .as_str()
    //         .ok_or(eyre!(
    //             "Invalid JSON structure: 'response' field not found or not a string"
    //         ))?
    //         .to_string();

    //     Ok(response_text)
    // }

    // pub async fn request_embedding(&self, text: &str) -> eyre::Result<Vec<f32>> {
    //     let response = self
    //         .client
    //         .post(&self.config.haiku.llm.vectorization_url)
    //         .header(
    //             "Authorization",
    //             format!("Bearer {}", self.config.haiku.llm.vectorization_token),
    //         )
    //         .header("Content-Type", "application/json")
    //         .json(&serde_json::json!({ "inputs": text }))
    //         .send()
    //         .await?;

    //     if !response.status().is_success() {
    //         return Err(eyre!(format!("API request failed: {}", response.status())));
    //     }

    //     let json: Value = response.json().await?;

    //     let embedding: Vec<f32> = json
    //         .as_array()
    //         .ok_or(eyre!("Invalid JSON structure"))?
    //         .iter()
    //         .filter_map(|v| v.as_f64().map(|f| f as f32))
    //         .collect();

    //     Ok(embedding)
    // }
}
