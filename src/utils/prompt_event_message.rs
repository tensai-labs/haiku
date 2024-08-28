use starknet_crypto::{sign, Felt};
use std::str::FromStr;
use torii_relay::{
    typed_data::{Domain, TypedData},
    types::Message,
};

use dojo_types::{
    primitive::Primitive,
    schema::{Member, Struct, Ty},
};

use crate::utils::constants::{HAIKU_EVENTS_NAME, HAIKU_NAMESPACE};

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

    pub fn to_message(&self, account: Felt, pk: &Felt) -> eyre::Result<Message> {
        let model = Ty::Struct(Struct {
            name: format!("{}-{}", HAIKU_NAMESPACE, HAIKU_EVENTS_NAME).to_string(),
            children: vec![
                Member {
                    name: "identity".to_string(),
                    ty: Ty::Primitive(Primitive::ContractAddress(Some(account))),
                    key: true,
                },
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
        let typed_data = TypedData::from_model(model, domain)?;

        let hash = typed_data.encode(account)?;

        let signature = sign(pk, &hash, &Felt::from_str("0x1222111")?)
            .map_err(|e| eyre::eyre!("Failed to sign message: {}", e))?;

        Ok(Message {
            message: typed_data,
            signature: vec![signature.r, signature.s],
        })
    }
}
