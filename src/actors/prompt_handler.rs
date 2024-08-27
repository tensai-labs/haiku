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

use crate::{
    types::{config_types::Config, PromptMessage},
    utils::llm_client::LlmClient,
};
use starknet_crypto::{sign, Felt};

#[derive(Debug)]
pub struct PromptEventMessage {
    pub project_name: String,
    pub event_id: u32,
    pub event_tag: String,
    pub prompt: String,
    pub timestamp: u64,
}

impl PromptEventMessage {
    pub fn new(
        project_name: String,
        event_id: u32,
        event_tag: String,
        prompt: String,
        timestamp: u64,
    ) -> Self {
        Self {
            project_name,
            event_id,
            event_tag,
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
                    key: true,
                },
                Member {
                    name: "event_tag".to_string(),
                    ty: Ty::ByteArray(self.event_tag.clone()),
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

        let domain = Domain::new(&self.project_name, "1", "1", Some("1"));

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
            config,
            database,
            llm_client: LlmClient::new().expect("Failed to initialize LLM client"),
            torii_client,
        }
    }

    pub async fn run(&mut self) {
        while let Some(prompt) = self.prompt_receiver.recv().await {
            self.handle_prompt(prompt).await;
        }
    }

    pub async fn handle_prompt(&self, prompt: PromptMessage) -> eyre::Result<()> {
        let event_config = self
            .config
            .events
            .iter()
            .find(|event| event.tag == prompt.event_tag)
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
                        let value: String = row.get(i)?;
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

        tracing::info!("Retrieved data: {:?}", results);

        let mut improved_prompt = String::from(&self.config.haiku.context.story);
        improved_prompt.push_str("An event happened in the world.");
        improved_prompt.push_str(&prompt.prompt);
        improved_prompt
            .push_str("For context, here are some memories of similar events related to this one");
        // Enter the results from the cosine similarity here
        improved_prompt.push_str("");

        let response = self
            .llm_client
            .request_chat_completion(&improved_prompt)
            .await?;

        tracing::info!("Response: {:?}", response);
        // send message to event messaging
        let event_message = PromptEventMessage::new(
            self.config.haiku.name.clone(),
            prompt.event_id,
            prompt.event_tag,
            prompt.prompt,
            prompt.timestamp,
        );

        self.send_event_messaging(event_message).await?;

        Ok(())
    }

    pub async fn send_event_messaging(
        &self,
        event_message: PromptEventMessage,
    ) -> eyre::Result<()> {
        print!("Sending event message: {:?}", event_message);
        self.torii_client
            .publish_message(
                event_message
                    .to_message(&Felt::from_str(&self.config.haiku.metadata.private_key).unwrap()),
            )
            .await?;
        Ok(())
    }
}
