use reqwest::Client;
use serde_json::Value;
use config::Config;



pub async fn get_embedding(text: &str) -> Result<Vec<f32>, Box<dyn std::error::Error>> {
    let config = Config::builder()
    .add_source(config::File::with_name("config"))
    .build()
    .expect("Failed to load configuration");

    let url: String = config.get("haiku.metadata.vectorization_url")
    .expect("Failed to get vectorization_url from config");


    let client = Client::new();
    let response = client
        .post(url)
        .header("Authorization", "Bearer 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")
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
