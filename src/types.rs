use std::{path::PathBuf, sync::Arc};

use dojo_types::primitive::Primitive::ContractAddress;
use serde::Deserialize;
use serenity::{
    all::{CreateMessage, UserId},
    model::id::ChannelId,
};
use sqlx::SqlitePool;
use starknet_crypto::Felt;
use tokio::sync::mpsc;
use torii_grpc::types::schema::Entity;

use starknet::core::utils::parse_cairo_short_string;

pub struct MessageDispatcher {
    pub http: Arc<serenity::all::Http>,
    pub message_receiver: mpsc::Receiver<u8>,
}

pub struct EventHandler {
    pub event_sender: mpsc::Sender<u8>,
    pub database: SqlitePool,
}

impl MessageDispatcher {
    pub async fn run(&mut self) {
        while let Some(message) = self.message_receiver.recv().await {
            if let Err(e) = self.send_message(message).await {
                println!("Failed to send message: {:?}", e);
            }
        }
    }

    pub async fn send_message(&self, message: u8) -> Result<(), serenity::Error> {
        Ok(())
    }
}

pub async fn process_event(database: &SqlitePool, message_sender: &mpsc::Sender<u8>) {
    // match event {}
}

impl EventHandler {
    pub fn new(event_sender: mpsc::Sender<u8>, database: SqlitePool) -> Self {
        Self {
            event_sender,
            database,
        }
    }
    pub async fn handle_event(&self, entity: Entity) {
        self.event_sender.send(1_u8).await.unwrap();
    }
}

#[derive(Deserialize, Debug, Clone)]
pub struct ProgramConfig {
    pub vite_public_torii_url: String,
    pub vite_public_rpc_url: String,
    pub vite_public_relay_url: String,
    pub vite_public_world_address: String,
}

impl ProgramConfig {
    pub fn from_dotenv() -> Self {
        let cargo_manifest_dir =
            std::env::var("CARGO_MANIFEST_DIR").expect("CARGO_MANIFEST_DIR not set");
        let mut env_path = PathBuf::from(cargo_manifest_dir);
        env_path.push("../client/.env.production");

        dotenvy::from_filename(env_path).ok();
        match envy::from_env::<ProgramConfig>() {
            Ok(config) => config,
            Err(error) => panic!("{:#?}", error),
        }
    }
}
