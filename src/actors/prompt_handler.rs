use std::collections::HashMap;

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
        let event_config = self
            .config
            .events
            .iter()
            .find(|event| event.tag == prompt.config_name)
            .ok_or(eyre::eyre!("Event not found"))?;

        let retrieval_key_values = prompt.retrieval_key_values;

        let mut query_parts = Vec::new();
        let mut params = Vec::new();

        for (key, value) in &retrieval_key_values {
            query_parts.push(format!("SELECT * FROM {} WHERE id = ?", key));
            params.push(value);
        }

        let query = query_parts.join(" UNION ALL ");

        let results = self
            .database
            .call(move |conn| {
                let mut stmt = conn.prepare(&query)?;
                let params: Vec<&dyn rusqlite::ToSql> = retrieval_key_values
                    .values()
                    .map(|v| v as &dyn rusqlite::ToSql)
                    .collect();

                let rows = stmt.query_map(params.as_slice(), |row| {
                    let mut row_data = HashMap::new();
                    for i in 0..row.as_ref().column_count() {
                        let column_name = row.as_ref().column_name(i)?;
                        let value: i32 = row.get(i)?;
                        row_data.insert(column_name.to_string(), value);
                    }
                    Ok(row_data)
                })?;

                let mut all_results = Vec::new();
                for row in rows {
                    all_results.push(row?);
                }
                Ok(all_results)
            })
            .await?;

        println!("Retrieved data: {:?}", results);

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
