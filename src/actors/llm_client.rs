use reqwest::Client;
use serde_json::Value;
use config::Config;

pub struct LlmClient {
    client: Client,
    vectorization_url: String,
    vectorization_token: String,
    ai_url: String,
    ai_token: String,
}

impl LlmClient {
    pub fn new() -> Result<Self, Box<dyn std::error::Error>> {
        let config = Config::builder()
            .add_source(config::File::with_name("config"))
            .build()?;

        Ok(Self {
            client: Client::new(),
            vectorization_url: config.get("haiku.metadata.vectorization_url")?,
            vectorization_token: config.get("haiku.metadata.vectorization_token")?,
            ai_url: config.get("haiku.metadata.ai_url")?,
            ai_token: config.get("haiku.metadata.ai_token")?,
        })
    }

    pub async fn request_chat_completion(&self, text: &str) -> Result<String, Box<dyn std::error::Error>> {
        let response = self.client
            .post(&self.chat_completion_url)
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({
                "model": "uncensored-dolphin",
                "prompt": text,
                "stream": false
            }))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(format!("API request failed: {}", response.status()).into());
        }

        let json: Value = response.json().await?;
        
        let response_text = json["response"]
            .as_str()
            .ok_or("Invalid JSON structure: 'response' field not found or not a string")?
            .to_string();

        Ok(response_text)
    }

    pub async fn request_embedding(&self, text: &str) -> Result<Vec<f32>, Box<dyn std::error::Error>> {
        let response = self.client
            .post(&self.vectorization_url)
            .header("Authorization", format!("Bearer {}", self.vectorization_token))
            .header("Content-Type", "application/json")
            .json(&serde_json::json!({ "inputs": text }))
            .send()
            .await?;

        if !response.status().is_success() {
            return Err(format!("API request failed: {}", response.status()).into());
        }

        let json: Value = response.json().await?;

        let embedding: Vec<f32> = json
            .as_array()
            .ok_or("Invalid JSON structure")?
            .iter()
            .filter_map(|v| v.as_f64().map(|f| f as f32))
            .collect();

        Ok(embedding)
    }
}