use clap::Args;

use tokio::sync::mpsc;

use starknet_crypto::Felt;
use torii_client::client::Client;

use torii_grpc::types::{EntityKeysClause, KeysClause};

use crate::{
    actors::{event_handler::EventHandler, prompt_handler::PromptHandler},
    types::config_types::Config,
    utils::db_manager::DbManager,
};

#[derive(Debug, Args)]
pub struct RunSubcommand {
    /// Path to the configuration file
    pub config_file_path: String,
}

impl RunSubcommand {
    pub async fn execute(self) {
        let config = Config::from_toml(self.config_file_path).expect("Failed to load config");

        config.ensure_valid_configuration();

        let services_init_ret = Self::init_services(config).await;

        if services_init_ret.is_err() {
            tracing::error!(
                "Failed to initialize services {:?}",
                services_init_ret.unwrap_err()
            );
        }
    }

    async fn init_services(config: Config) -> eyre::Result<()> {
        let database = DbManager::init_db(&config)
            .await
            .expect("Failed to initialize database");

        let client: Client = Client::new(
            config.haiku.metadata.torii_url.clone(),
            config.haiku.metadata.rpc_url.clone(),
            config.haiku.metadata.relay_url.clone(),
            Felt::from_hex(&config.haiku.metadata.world_address.clone()).unwrap(),
        )
        .await
        .expect("Failed to connect to the Torii client");

        tracing::info!("Launching relay runner");

        let runner = client.relay_runner().clone();
        tokio::spawn(async move {
            runner.lock().await.run().await;
        });

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

        let mut prompt_handler =
            PromptHandler::new(prompt_receiver, config.clone(), database, client);

        tokio::spawn(async move {
            event_handler.run(rcv).await;
        });

        prompt_handler.run().await;

        tracing::info!("All services running 🚀");
        Ok(())
    }
}
