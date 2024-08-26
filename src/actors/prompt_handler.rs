use std::str::FromStr;

use dojo_types::primitive::Primitive;
use dojo_types::schema::{Member, Struct, Ty};
use std::collections::HashMap;

use tokio::sync::mpsc;
use tokio_rusqlite::Connection;
use torii_client::client::Client;
use torii_relay::{
    typed_data::{Domain, TypedData},
    types::Message,
};

use crate::types::{config_types::Config, PromptMessage};
use starknet_crypto::{sign, Felt};

#[derive(Debug)]
pub struct PromptEventMessage {
    pub event_id: u32,
    pub prompt: String,
    pub timestamp: u64,
}

impl PromptEventMessage {
    pub fn new(event_id: u32, prompt: String, timestamp: u64) -> Self {
        Self {
            event_id,
            prompt,
            timestamp,
        }
    }

    pub fn to_message(&self, pk: &Felt) -> Message {
        let model = Ty::Struct(Struct {
            name: "PromptEventMessage".to_string(),
            children: vec![
                Member {
                    name: "event_id".to_string(),
                    ty: Ty::Primitive(Primitive::U32(Some(self.event_id))),
                    key: false,
                },
                Member {
                    name: "prompt".to_string(),
                    ty: Ty::ByteArray(self.prompt.clone()),
                    key: false,
                },
                Member {
                    name: "timestamp".to_string(),
                    ty: Ty::Primitive(Primitive::U64(Some(self.timestamp))),
                    key: false,
                },
            ],
        });

        let domain = Domain::new("Eternum", "1", "1", Some("1"));

        let signature = sign(
            pk,
            &Felt::from_str("haiku").unwrap(),
            &Felt::from_str(&self.event_id.to_string()).unwrap(),
        )
        .unwrap();

        Message {
            message: TypedData::from_model(model, domain).unwrap(),
            signature: vec![signature.r, signature.s],
        }
    }
}

pub struct PromptHandler {
    prompt_receiver: mpsc::Receiver<PromptMessage>,
    config: Config,
    pub database: Connection,
    pub client: Client,
}

impl PromptHandler {
    pub fn new(
        prompt_receiver: mpsc::Receiver<PromptMessage>,
        config: Config,
        database: Connection,
        client: Client,
    ) -> Self {
        Self {
            prompt_receiver,
            config,
            database,
            client,
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

        // send message to event messaging
        let event_message = PromptEventMessage::new(1, prompt.prompt, 0);

        self.send_event_messaging(event_message).await?;

        Ok(())
    }

    pub async fn send_event_messaging(
        &self,
        event_message: PromptEventMessage,
    ) -> eyre::Result<()> {
        print!("Sending event message: {:?}", event_message);
        self.client
            .publish_message(event_message.to_message(&Felt::from_str(&self.config.pk).unwrap()))
            .await?;
        Ok(())
    }
}
