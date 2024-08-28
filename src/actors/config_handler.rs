use crate::types::config_types::{
    Config, Context, DbKeys, Event, FieldsContext, Haiku, KeysMapping, Metadata,
};

use dojo_world::manifest::DeploymentManifest;

use camino::Utf8PathBuf;

pub fn create_config(manifest_path: &str, output_path: &str) {
    let path_to_manifest = Utf8PathBuf::from(manifest_path);

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

    let config = Config {
        haiku: Haiku {
            name: "haiku".to_string(),
            metadata: Metadata {
                torii_url: "".to_string(),
                rpc_url: "".to_string(),
                world_address: "".to_string(),
                relay_url: "".to_string(),
                ai_url: "".to_string(),
                vectorization_url: "".to_string(),
                database_url: "torii.db".to_string(),
                private_key: "".to_string(),
            },
            context: Context {
                story: "Replace this text by a compelling narrative that encapsulates the overarching theme, setting, and key elements of your game world. This should provide a rich, immersive context for all subsequent interactions and events.".to_string(),
            },
        },
        events,
    };

    // write the config to a config_output.toml file
    let config_output_path = Utf8PathBuf::from(output_path);
    Config::to_toml(&config, &config_output_path).expect("Failed to write config to file");
}
