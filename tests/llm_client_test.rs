mod tests {
    use haiku::types::config_types::Config;
    use haiku::types::llm_client::provider::Provider;

    #[tokio::test]
    #[ignore]
    async fn test_ollama_provider() -> Result<(), Box<dyn std::error::Error>> {
        let mut config = Config::default();
        config.haiku.llm.chat_completion_provider = "ollama".to_string();

        config.haiku.llm.embedding_provider = "openai".to_string();
        config.haiku.llm.ai_url = "http://localhost:11434/api/generate".to_string();

        // Ollama model name
        config.haiku.llm.ai_model = "".to_string();

        let ai_service_manager = Provider::new(&config).expect("Failed to create ollama_provider");

        let test_message = "Are you online ?";
        let response = ai_service_manager
            .request_chat_completion(test_message)
            .await?;
        assert!(
            !response.is_empty(),
            "No chat completion response from ollama"
        );

        Ok(())
    }

    #[tokio::test]
    #[ignore]
    async fn test_baai_provider() -> Result<(), Box<dyn std::error::Error>> {
        let mut config = Config::default();
        config.haiku.llm.chat_completion_provider = "ollama".to_string();

        config.haiku.llm.embedding_provider = "baai-bge".to_string();
        config.haiku.llm.embedding_url =
            "https://api-inference.huggingface.co/models/BAAI/bge-small-en-v1.5".to_string();

        // Huggingface API key
        config.haiku.llm.embedding_token = "hf_xxxxx".to_string();

        let llm_client = Provider::new(&config).expect("Failed to create baai_provider");

        let test_message = "Are you online ?";
        let response = llm_client.request_embedding(test_message).await?;
        assert!(!response.is_empty(), "No embedding received from baai");

        Ok(())
    }

    #[tokio::test]
    #[ignore]
    async fn test_openai_provider() -> Result<(), Box<dyn std::error::Error>> {
        let mut config = Config::default();
        config.haiku.llm.chat_completion_provider = "openai".to_string();
        config.haiku.llm.ai_model = "gpt-4o-mini".to_string();
        config.haiku.llm.ai_url = "https://api.openai.com/v1/chat/completions".to_string();

        // Openai API key
        config.haiku.llm.ai_token = "".to_string();

        config.haiku.llm.embedding_provider = "openai".to_string();
        config.haiku.llm.embedding_model = "text-embedding-3-small".to_string();
        config.haiku.llm.embedding_url = "https://api.openai.com/v1/embeddings".to_string();

        // Openai API key
        config.haiku.llm.embedding_token = "".to_string();

        let test_message = "Are you online ?";
        let ai_service_manager = Provider::new(&config).expect("Failed to create baai_provider");

        let embedding_response = ai_service_manager.request_embedding(test_message).await?;
        assert!(
            !embedding_response.is_empty(),
            "No embedding received from openai"
        );

        let chat_completion_response = ai_service_manager
            .request_chat_completion(test_message)
            .await?;
        assert!(
            !chat_completion_response.is_empty(),
            "No chat completion response from openai"
        );

        Ok(())
    }
}
