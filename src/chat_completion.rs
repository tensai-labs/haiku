use reqwest::Client;
use serde_json::Value;

pub async fn get_chat_completion(text: &str) -> Result<String, Box<dyn std::error::Error>> {
    let client = Client::new();
    let response = client
        .post("http://localhost:11434/api/generate")
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
    
    // Extract the response from the JSON
    let response_text = json["response"]
        .as_str()
        .ok_or("Invalid JSON structure: 'response' field not found or not a string")?
        .to_string();

    Ok(response_text)
}

// #[tokio::main]
// async fn main() -> Result<(), Box<dyn std::error::Error>> {
//     let prompt = "Why is the sky blue?";
//     let response = get_chat_completion(prompt).await?;
//     println!("Prompt: {}", prompt);
//     println!("Response: {}", response);
//     Ok(())
// }