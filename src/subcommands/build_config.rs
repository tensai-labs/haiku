use clap::Args;

use crate::{
    secrets::Secrets,
    types::config_types::{Config, DbKeys, Event, FieldsContext, KeysMapping},
    utils::constants::HAIKU_ENV_FILE,
};

use dojo_world::manifest::DeploymentManifest;

use camino::Utf8PathBuf;

#[derive(Debug, Args)]
pub struct BuildConfigSubcommand {
    /// Path to the manifest file
    #[arg(default_value = "./manifests/dev/deployment/manifest.toml")]
    pub manifest_file_path: String,
    /// Path to output config file
    #[arg(default_value = "./haiku.toml")]
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
            let (namespace, name) = model.inner.tag.split_once('-').unwrap_or_else(|| {
                panic!(
                    "Failed to split tag '{}' on '-'. Expected format: 'namespace-name'",
                    model.inner.tag
                )
            });
            if namespace == "haiku" && name != "PromptMessage" {
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

        let config = Config {
            events,
            ..Default::default()
        };

        // write the config to a config_output.toml file
        let config_output_path = Utf8PathBuf::from(self.output_config_file_path);
        Config::to_toml(&config, &config_output_path).expect("Failed to write config to file");

        let haiku_env_file_path = config_output_path.parent().unwrap().join(HAIKU_ENV_FILE);
        std::fs::write(&haiku_env_file_path, Secrets::default().to_dotenv())
            .expect("Failed to write to .env.haiku file");

        // Add .env.haiku to .gitignore
        let gitignore_path = config_output_path.parent().unwrap().join(".gitignore");
        if gitignore_path.exists() {
            let mut gitignore_content =
                std::fs::read_to_string(&gitignore_path).expect("Failed to read .gitignore file");
            if !gitignore_content.contains(HAIKU_ENV_FILE) {
                if !gitignore_content.ends_with('\n') {
                    gitignore_content.push('\n');
                }
                gitignore_content.push_str(&format!("{}\n", HAIKU_ENV_FILE));
                std::fs::write(&gitignore_path, gitignore_content)
                    .expect("Failed to write to .gitignore file");
            }
        } else {
            tracing::warn!(".gitignore not found, do not commit your secrets .env file");
        }

        tracing::info!(
            "🖌️ Config file successfully created at {}",
            config_output_path.to_string()
        );
    }
}
