use std::str::FromStr;

use starknet_crypto::Felt;
use tokio::sync::mpsc;
use tokio_rusqlite::Connection;
use torii_client::client::Client;

use crate::{
    types::{config_types::Config, PromptMessage},
    utils::{
        db_manager::DbManager, llm_client::LlmClient, prompt_event_message::PromptEventMessage,
    },
};

pub struct PromptHandler {
    prompt_receiver: mpsc::Receiver<PromptMessage>,
    config: Config,
    pub database: Connection,
    pub llm_client: LlmClient,
    pub torii_client: Client,
}

impl PromptHandler {
    pub fn new(
        prompt_receiver: mpsc::Receiver<PromptMessage>,
        config: Config,
        database: Connection,
        torii_client: Client,
    ) -> Self {
        Self {
            prompt_receiver,
            config: config.clone(),
            database,
            llm_client: LlmClient::new(config.clone()).expect("Failed to initialize LLM client"),
            torii_client,
        }
    }

    pub async fn run(&mut self) {
        while let Some(prompt) = self.prompt_receiver.recv().await {
            tracing::debug!("Handling prompt");
            let ret = self.handle_prompt(prompt).await;
            if ret.is_err() {
                tracing::error!("Error handling prompt: {:?}", ret.unwrap_err());
            }
        }
    }

    pub async fn handle_prompt(&self, prompt: PromptMessage) -> eyre::Result<()> {
        let _event_config = self
            .config
            .events
            .iter()
            .find(|event| event.tag == prompt.event_tag)
            .ok_or(eyre::eyre!("Event not found"))?;

        let query_embedding = self.llm_client.request_embedding(&prompt.prompt).await?;

        let memories = DbManager::retrieve_similar_memories(
            &self.database,
            query_embedding,
            prompt.retrieval_key_values,
            self.config
                .haiku
                .db_config
                .number_memory_to_retrieve
                .clone(),
        )
        .await?;

        let mut improved_prompt = String::from(&self.config.haiku.context.story);
        improved_prompt.push_str("An event happened in the world.");
        improved_prompt.push_str(&prompt.prompt);
        improved_prompt
            .push_str("For context, here are some memories of similar events related to this one");

        for (_, memory) in memories.iter().enumerate() {
            improved_prompt.push_str(&format!("\n{}.", memory));
        }

        let response = self
            .llm_client
            .request_chat_completion(&improved_prompt)
            .await?;

        let embedding = self.llm_client.request_embedding(&response).await?;

        DbManager::store_memory(
            &self.database,
            response,
            embedding,
            prompt.storage_key_values,
        )
        .await?;

        let event_message = PromptEventMessage::new(
            self.config.haiku.name.clone(),
            prompt.event_id,
            prompt.event_tag,
            improved_prompt,
            prompt.timestamp,
        );

        self.send_event_messaging(event_message).await?;

        Ok(())
    }

    pub async fn send_event_messaging(
        &self,
        event_message: PromptEventMessage,
    ) -> eyre::Result<()> {
        self.torii_client
            .publish_message(event_message.to_message(
                Felt::from_str(&self.config.haiku.metadata.signer_address)?,
                &Felt::from_str(&self.config.haiku.metadata.signer_private_key)?,
            )?)
            .await?;

        tracing::debug!("hereeeee");
        Ok(())
    }
}
