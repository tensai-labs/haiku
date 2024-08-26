mod actors;
mod types;

use tokio::sync::mpsc;

use starknet_crypto::Felt;
use tokio_rusqlite::Connection;
use torii_client::client::Client;

use torii_grpc::types::{EntityKeysClause, KeysClause};

use crate::actors::{event_handler::EventHandler, prompt_handler::PromptHandler};

use self::types::config_types::Config;

async fn init_services(config: Config) {
    let database = Connection::open(config.haiku.metadata.database_url.clone())
        .await
        .expect("Failed to open database");

    let client: Client = Client::new(
        config.haiku.metadata.torii_url.clone(),
        config.haiku.metadata.rpc_url.clone(),
        config.haiku.metadata.relay_url.clone(),
        Felt::from_hex(&config.haiku.metadata.world_address.clone()).unwrap(),
    )
    .await
    .expect("Failed to connect to the Torii client");
    println!("Setting up Torii client");

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

    let mut prompt_handler = PromptHandler::new(prompt_receiver, config.clone(), database);

    tokio::spawn(async move {
        event_handler.run(rcv).await;
    });

    prompt_handler.run().await;
}

#[tokio::main]
async fn main() {
    let args: Vec<String> = std::env::args().collect();

    let config_file_path = args.get(1);

    let config = Config::from_toml(config_file_path.expect("Config file path not provided"))
        .expect("Failed to load config");

    init_services(config).await
}
