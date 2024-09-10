use crate::types::{config_types::Config, PromptMessage};
use dojo_types::{primitive::Primitive, schema::Ty};
use eyre::eyre;
use serenity::futures::StreamExt;
use starknet::core::utils::parse_cairo_short_string;
use tokio::sync::mpsc;
use torii_grpc::{client::EntityUpdateStreaming, types::schema::Entity};

pub struct EventHandler {
    pub prompt_sender: mpsc::Sender<PromptMessage>,
    pub config: Config,
    pub is_first_event: bool,
}

impl EventHandler {
    pub fn new(prompt_sender: mpsc::Sender<PromptMessage>, config: Config) -> Self {
        Self {
            prompt_sender,
            config,
            is_first_event: true,
        }
    }

    pub async fn run(&mut self, mut rcv: EntityUpdateStreaming) {
        while let Some(Ok((_, entity))) = rcv.next().await {
            let ret = self.handle_event(entity).await;

            if ret.is_err() && !self.is_first_event {
                tracing::error!("Error handling event: {:?}", ret.unwrap_err());
            }

            if self.is_first_event {
                self.is_first_event = false;
            }
        }
    }

    pub async fn handle_event(&self, entity: Entity) -> eyre::Result<()> {
        if !self.is_first_event {
            tracing::debug!("Received event");
        }

        if entity.models.is_empty() {
            return Err(eyre!("Empty models for event or first event received"));
        }

        let model_name = entity.models[0].name.clone();
        let event_config = self
            .config
            .events
            .iter()
            .find(|event| event.tag == model_name)
            .ok_or(eyre::eyre!("Event not found"))?;

        let mut finished_string = event_config.prompt.template.clone();

        let mut prompt_message = PromptMessage::default();

        entity.models[0].children.iter().for_each(|child| {
            let fmt_str = format!("${{{}}}", child.name);
            let value_as_string = ty_to_string(&child.ty);

            if value_as_string.is_err() {
                tracing::error!(
                    "Error converting value to string: {:?}",
                    value_as_string.err()
                );
                return;
            }

            finished_string = finished_string.replace(&fmt_str, &value_as_string.unwrap());

            if child.name == "id" {
                prompt_message.id = child
                    .ty
                    .as_primitive()
                    .expect("Expected a primitive")
                    .as_u32()
                    .expect("Expected a u32");
            }

            if child.name == "timestamp" {
                prompt_message.timestamp = child
                    .ty
                    .as_primitive()
                    .expect("Expected a primitive")
                    .as_u64()
                    .expect("Expected a u64");
            }

            if event_config.db_keys.retrieval_keys.contains(&child.name) {
                let primitive = *child.ty.as_primitive().expect("Expected a primitive");
                let felts = primitive
                    .serialize()
                    .expect("Failed to deserialize primitive");

                prompt_message
                    .retrieval_key_values
                    .insert(child.name.clone(), felts[0].to_hex_string());
            }
            if event_config.db_keys.storage_keys.contains(&child.name) {
                let primitive = *child.ty.as_primitive().expect("Expected a primitive");

                let felts = primitive
                    .serialize()
                    .expect("Failed to deserialize primitive");

                prompt_message
                    .storage_key_values
                    .insert(child.name.clone(), felts[0].to_hex_string());
            }
        });

        prompt_message.prompt = finished_string;
        prompt_message.event_tag = event_config.tag.clone();

        if prompt_message.timestamp == 0 {
            return Err(eyre!("event doesn't have a timestamp"));
        }
        if prompt_message.event_tag.is_empty() {
            return Err(eyre!("event tag is empty"));
        }

        self.prompt_sender.send(prompt_message).await?;

        Ok(())
    }
}

fn ty_to_string(ty: &Ty) -> eyre::Result<String> {
    match ty {
        Ty::Enum(e) => Ok(e.option().unwrap_or_default().to_ascii_lowercase()),
        Ty::Primitive(p) => match p {
            Primitive::ContractAddress(addr) => Ok(addr.unwrap().to_hex_string()),
            Primitive::Felt252(felt) => {
                Ok(parse_cairo_short_string(&felt.ok_or_else(|| {
                    eyre::eyre!("Failed to parse Cairo short string")
                })?)?)
            }
            _ => Ok(u64::from_str_radix(
                format!("{:?}", ty.serialize()?[0]).trim_start_matches("0x"),
                16,
            )?
            .to_string()),
        },
        _ => Ok(u64::from_str_radix(
            format!("{:?}", ty.serialize()?[0]).trim_start_matches("0x"),
            16,
        )?
        .to_string()),
    }
}
