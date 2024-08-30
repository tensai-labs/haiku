use serde::Deserialize;

use crate::utils::constants::HAIKU_ENV_FILE;

#[derive(Deserialize, Debug, Clone, Default)]
pub struct Secrets {
    pub signer_address: String,
    pub signer_private_key: String,
    pub embedding_token: String,
    pub chat_completion_token: String,
}

impl Secrets {
    pub fn from_dotenv() -> Self {
        dotenvy::from_filename(std::env::current_dir().unwrap().join(HAIKU_ENV_FILE)).ok();
        match envy::from_env::<Secrets>() {
            Ok(config) => config,
            Err(error) => panic!("{:#?}", error),
        }
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
}
