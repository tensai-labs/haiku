use tokio::sync::mpsc;
use tokio_rusqlite::Connection;

use crate::types::{config_types::Config, PromptMessage};

pub struct PromptHandler {
    prompt_receiver: mpsc::Receiver<PromptMessage>,
    config: Config,
    pub database: Connection,
}

impl PromptHandler {
    pub fn new(
        prompt_receiver: mpsc::Receiver<PromptMessage>,
        config: Config,
        database: Connection,
    ) -> Self {
        Self {
            prompt_receiver,
            config,
            database,
        }
    }

    pub async fn run(&mut self) {
        while let Some(prompt) = self.prompt_receiver.recv().await {
            println!("prompt: {:?}", prompt);
            self.handle_prompt(prompt).await;
        }
    }

    pub async fn handle_prompt(&self, prompt: PromptMessage) -> eyre::Result<()> {
        let keys = self
            .config
            .events
            .iter()
            .find(|event| event.tag == prompt.config_name)
            .ok_or(eyre::eyre!("Event not found"))?
            .db_keys
            .clone();

        let people = self
            .database
            .call(|conn| {
                conn.execute(
                    "CREATE TABLE person (
                    id    INTEGER PRIMARY KEY,
                    name  TEXT NOT NULL,
                    data  BLOB
                )",
                    [],
                )?;
                Ok(())
            })
            .await?;
        Ok(())
    }
}
