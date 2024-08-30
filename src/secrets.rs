use serde::Deserialize;

use crate::{types::config_types::Config, utils::constants::HAIKU_ENV_FILE};

#[derive(Deserialize, Debug, Clone, Default)]
pub struct Secrets {
    pub signer_address: String,
    pub signer_private_key: String,
    pub embedding_token: String,
    pub chat_completion_token: String,
}

impl Secrets {
    pub fn from_dotenv(config: &Config) -> Self {
        dotenvy::from_filename(std::env::current_dir().unwrap().join(HAIKU_ENV_FILE)).ok();
        let secrets = match envy::from_env::<Secrets>() {
            Ok(secrets) => secrets,
            Err(error) => panic!("{:#?}", error),
        };

        secrets.ensure_valid_secrets(config);

        secrets
    }

    pub fn to_dotenv(&self) -> String {
        format!(
            "SIGNER_ADDRESS=\"{}\"\n\
            SIGNER_PRIVATE_KEY=\"{}\"\n\
            CHAT_COMPLETION_TOKEN=\"{}\"\n\
            EMBEDDING_TOKEN=\"{}\"\n",
            self.signer_address,
            self.signer_private_key,
            self.chat_completion_token,
            self.embedding_token
        )
    }

    pub fn ensure_valid_secrets(&self, config: &Config) {
        assert_ne!(self.signer_address, "", "Signer address cannot be empty.");

        assert_ne!(
            self.signer_private_key, "",
            "Signer private key cannot be empty."
        );

        if config.haiku.llm.embedding_provider == "openai" {
            assert_ne!(
                self.chat_completion_token, "",
                "Chat completion token cannot be empty."
            );
        }

        if config.haiku.llm.chat_completion_provider == "openai" {
            assert_ne!(self.embedding_token, "", "Embedding token cannot be empty.");
        }
    }
}
