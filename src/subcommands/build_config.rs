use clap::Args;

use crate::types::config_types::{Config, DbKeys, Event, FieldsContext, KeysMapping};

use dojo_world::manifest::DeploymentManifest;

use camino::Utf8PathBuf;

#[derive(Debug, Args)]
pub struct BuildConfigSubcommand {
    /// Path to the manifest file
    #[arg(default_value = "./manifest.toml")]
    pub manifest_file_path: String,
    /// Path to output config file
    #[arg(default_value = "./config.toml")]
    pub output_config_file_path: String,
}

impl BuildConfigSubcommand {
    pub fn execute(self) {
        self.create_config()
    }

    pub fn create_config(self) {
        let path_to_manifest = Utf8PathBuf::from(self.manifest_file_path);

        let manifest = DeploymentManifest::load_from_path(&path_to_manifest)
            .unwrap_or_else(|_| panic!("Failed to load manifest from path: {}", path_to_manifest));

        let mut events = Vec::new();
        for model in manifest.models {
            if model.inner.tag.starts_with("haiku") {
                let keys: Vec<_> = model
                    .inner
                    .members
                    .iter()
                    .filter(|field| field.key)
                    .collect();
                let event = Event {
                tag: model.inner.tag.clone(),
                prompt: FieldsContext {
                    template: "Replace this text by a prompt including the event details. Use the fields ${field_names} in your prompt.".to_string(),
                },
                db_keys: DbKeys {
                    storage_keys: vec![],
                    retrieval_keys: vec![],
                },
                keys_mapping: keys
                    .iter()
                    .map(|key| KeysMapping {
                        key: key.name.clone(),
                        alias: String::new(),
                    })
                    .collect(),
            };
                events.push(event);
            }
        }

        let mut config = Config::default();
        config.haiku.name = "haiku".to_string();
        config.haiku.metadata.database_url = "torii.db".to_string();
        config.haiku.context.story = "Replace this text by a compelling narrative that encapsulates the overarching theme, setting, and key elements of your game world. This should provide a rich, immersive context for all subsequent interactions and events.".to_string();
        config.events = events;

        // write the config to a config_output.toml file
        let config_output_path = Utf8PathBuf::from(self.output_config_file_path);
        Config::to_toml(&config, &config_output_path).expect("Failed to write config to file");
    }
}