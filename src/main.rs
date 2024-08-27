// Mute unused warnings
// #![allow(unused)]

mod actors;
mod types;
mod utils;

use tokio::sync::mpsc;

use starknet_crypto::Felt;
// use tokio_rusqlite::{Connection, Result, params, Error};
use tokio_rusqlite::params;
use torii_client::client::Client;

use torii_grpc::types::{EntityKeysClause, KeysClause};
use tracing_subscriber::EnvFilter;

use crate::actors::{event_handler::EventHandler, prompt_handler::PromptHandler};

use self::types::config_types::Config;
use crate::utils::db_manager::DbManager;

use std::convert::TryInto;
use zerocopy::AsBytes;

async fn init_services(config: Config) {
    let database = DbManager::init_db(&config)
        .await
        .expect("Failed to initialize database");

    // Sanity check: insert a row
    let float_vec = vec![0.1f32, 0.1f32, 0.1f32, 0.1f32];
    let byte_vec: Vec<u8> = float_vec
        .iter()
        .flat_map(|&f| f.to_le_bytes().to_vec())
        .collect();

    database
        .call(move |db| {
            db.execute(
                "INSERT INTO embeddings (embedding) VALUES (?1)",
                params![byte_vec],
            )
            .map_err(|e| e.into())
        })
        .await
        .expect("Failed to insert row");

    // sanity check: query the row
    let queried_vectors = database
        .call(|db| {
            db.query_row("SELECT * FROM embeddings", [], |row| {
                let id: i32 = row.get(0)?;
                let embedding: Vec<u8> = row.get(1)?;
                let float_vec: Vec<f32> = embedding
                    .chunks_exact(4)
                    .map(|chunk| {
                        let arr: [u8; 4] = chunk.try_into().expect("Chunk must be 4 bytes");
                        f32::from_le_bytes(arr)
                    })
                    .collect();
                Ok(float_vec)
            })
            .map_err(|e| e.into())
        })
        .await
        .expect("Failed to query row");
    println!("Queried items: {:?}", queried_vectors);

    let client: Client = Client::new(
        config.haiku.metadata.torii_url.clone(),
        config.haiku.metadata.rpc_url.clone(),
        config.haiku.metadata.relay_url.clone(),
        Felt::from_hex(&config.haiku.metadata.world_address.clone()).unwrap(),
    )
    .await
    .expect("Failed to connect to the Torii client");

    tracing::info!("Torii client successfully connected");

    let models_for_subscription = config
        .events
        .iter()
        .map(|event| event.tag.clone())
        .collect();

    let rcv = client
        .on_event_message_updated(vec![EntityKeysClause::Keys(KeysClause {
            keys: vec![],
            pattern_matching: torii_grpc::types::PatternMatching::VariableLen,
            models: models_for_subscription,
        })])
        .await
        .unwrap();

    let (prompt_sender, prompt_receiver) = mpsc::channel(100);

    let event_handler = EventHandler::new(prompt_sender, config.clone());

    let mut prompt_handler = PromptHandler::new(prompt_receiver, config.clone(), database, client);

    tokio::spawn(async move {
        event_handler.run(rcv).await;
    });

    prompt_handler.run().await;
}

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_env_filter(EnvFilter::new("haiku=trace"))
        .with_file(true)
        .with_line_number(true)
        .init();

    let args: Vec<String> = std::env::args().collect();

    let config_file_path = args.get(1);

    let config = Config::from_toml(config_file_path.expect("Config file path not provided"))
        .expect("Failed to load config");

    init_services(config).await
}
