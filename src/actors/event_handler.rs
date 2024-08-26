use crate::types::{config_types::Config, PromptMessage};
use dojo_types::{primitive::Primitive, schema::Ty};
use serenity::futures::StreamExt;
use tokio::sync::mpsc;
use torii_grpc::{client::EntityUpdateStreaming, types::schema::Entity};

pub struct EventHandler {
    pub prompt_sender: mpsc::Sender<PromptMessage>,
    pub config: Config,
}

impl EventHandler {
    pub fn new(prompt_sender: mpsc::Sender<PromptMessage>, config: Config) -> Self {
        Self {
            prompt_sender,
            config,
        }
    }

    pub async fn run(&self, mut rcv: EntityUpdateStreaming) {
        while let Some(Ok((_, entity))) = rcv.next().await {
            self.handle_event(entity).await;
        }
    }

    pub async fn handle_event(&self, entity: Entity) -> eyre::Result<()> {
        if entity.models.len() == 0 {
            return Ok(());
        }

        let model_name = entity.models[0].name.clone();
        let event_config = self
            .config
            .events
            .iter()
            .find(|event| event.tag == model_name)
            .ok_or(eyre::eyre!("Event not found"))?;

        let mut finished_string = event_config.prompt.template.clone();

        entity.models[0].children.iter().for_each(|child| {
            let fmt_str = format!("${{{}}}", child.name);
            finished_string = finished_string.replace(&fmt_str, &ty_to_string(&child.ty));
        });

        self.prompt_sender
            .send(PromptMessage {
                config_name: event_config.tag.clone(),
                prompt: finished_string,
            })
            .await?;

        Ok(())
    }
}

fn ty_to_string(ty: &Ty) -> String {
    match ty {
        Ty::Enum(e) => e.option().unwrap_or_default().to_ascii_lowercase(),
        Ty::Primitive(p) => match p {
            Primitive::ContractAddress(addr) => addr.unwrap().to_hex_string(),
            _ => p.to_string(),
        },
        _ => ty.to_string(),
    }
}
