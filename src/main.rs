mod types;
use poise::serenity_prelude as serenity;
use serenity::futures::StreamExt;
use sqlx::SqlitePool;
use std::sync::Arc;
use tokio::sync::mpsc;
type Error = Box<dyn std::error::Error + Send + Sync>;
type Context<'a> = poise::Context<'a, Data, Error>;

use starknet_crypto::Felt;
use torii_client::client::Client;

use torii_grpc::types::{EntityKeysClause, KeysClause};

use crate::types::{process_event, EventHandler, MessageDispatcher, ProgramConfig};

struct Data {
    database: SqlitePool,
}

async fn setup_torii_client(token: String, database: SqlitePool) {
    let config = ProgramConfig::from_dotenv();
    tokio::spawn(async move {
        let http = serenity::Http::new(&token.clone());
        println!("Setting up Torii client");
        let client = Client::new(
            config.vite_public_torii_url,
            config.vite_public_rpc_url,
            config.vite_public_relay_url,
            Felt::from_hex_unchecked(&config.vite_public_world_address),
        )
        .await
        .unwrap();
        let mut rcv = client
            .on_event_message_updated(vec![EntityKeysClause::Keys(KeysClause {
                keys: vec![],
                pattern_matching: torii_grpc::types::PatternMatching::VariableLen,
                models: vec![],
            })])
            .await
            .unwrap();

        let (event_sender, mut event_receiver) = mpsc::channel(100);
        let (message_sender, message_receiver) = mpsc::channel(100);

        let event_handler = EventHandler::new(event_sender, database.clone());

        let mut message_dispatcher = MessageDispatcher {
            http: Arc::new(serenity::Http::new(&token)),
            message_receiver,
        };

        tokio::spawn(async move {
            while let Some(event) = event_receiver.recv().await {
                process_event(&database, &message_sender).await;
            }
        });

        tokio::spawn(async move {
            message_dispatcher.run().await;
        });

        while let Some(Ok((_, entity))) = rcv.next().await {
            event_handler.handle_event(entity).await;
        }
    });

    println!("Torii client setup task spawned");
}

#[tokio::main]
async fn main() {
    let token = std::env::var("DISCORD_TOKEN").expect("missing DISCORD_TOKEN");
    let token_clone = token.clone();
    let database_url = std::env::var("DATABASE_URL").expect("missing DATABASE_URL");

    let database = SqlitePool::connect(&database_url)
        .await
        .expect("Failed to connect to the database");
    setup_torii_client(token_clone, database.clone()).await;
}
