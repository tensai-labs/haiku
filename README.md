![alt text](img/Haiku-blue.png)

# Haiku: AI Content Generation for Dojo Games and Applications

[Dojo](https://github.com/dojoengine/dojo) provides a user-friendly platform for creating verifiable Games, Autonomous Worlds, and various Applications that are natively composable, extensible, permissionless and persistent.

Haiku empowers developers to seamlessly integrate AI-driven content generation into their Dojo applications and games. The content generation is triggered by contract events and streamed back to the game world through Dojo's offchain message system, making it easy for developers to integrate it in their client. With Haiku, developers can effortlessly enhance their projects with intelligent, context-aware content that evolves alongside player interactions and game states.

# Key Features

- Seamless integration with Dojo projects.
- AI triggered by contract events.
- Results stored in torii offchain messages.
- Simple configuration and prompt engineering through the haiku `config.toml` file.

# How It Works

1. Emit custom haiku events from your smart contracts.
2. The events trigger an LLM chat completion request.
4. Haiku has access to past events related to the fired event to add context to the response.
3. LLM responses are streamed back to you leveraging torii offchain messages.

# Getting Started

## Install Dojo
Follow the instructions to install Dojo [here](https://book.dojoengine.org/getting-started).
## Install Haiku
```
todo: add haiku to releases and curl ...
```

## Add Haiku to your path
```
todo
```

## Add Haiku events in your project
Events must follow the structure:
```
#[derive(Copy, Drop, Serde)]
#[dojo::event]
#[dojo::model(namespace: "haiku", nomapping: true)]
struct YourEventName {
      #[key]
      id: u32,
      timestamp: u64,
      // Add any additional fields or keys you need for your event
      // ...
}
```

The event struct must include these requirements:
- Set the `namespace` to `"haiku"` and `nomapping` to `true` in the `#[dojo::model]` attribute
- Include an `id` field of type `u32` with the `#[key]` attribute
- Include a `timestamp` field of type `u64`

You can choose any name for your event struct (replace `YourEventName`) and add any additional fields that your event requires.

⚠️ Currently, Haiku supports a limited set of data types. For a comprehensive list of supported types and information about current limitations, please refer to the "Supported Data Types and Limitations" section in this documentation.

## Add Haiku dependencies 
Add the following to your Scarb.toml
```
[dependencies]
haiku_event = { git = "https://github.com/edisontim/haiku" }

[[target.dojo]]
build-external-contracts = [ "haiku_event::PromptMessage" ]
```

## Build and migrate you dojo project
Instructions on how to build and migrate a dojo project can be found [here](https://book.dojoengine.org/toolchain/sozo/project-commands/build) and [here](https://book.dojoengine.org/toolchain/sozo/project-commands/migrate).

## Generate Your Haiku Configuration Template
After creating your Dojo manifest.toml file, you can generate a Haiku configuration template using the following command:
```
Usage: haiku build [MANIFEST_FILE_PATH] [OUTPUT_CONFIG_FILE_PATH]

Arguments:
  [MANIFEST_FILE_PATH]       Path to the manifest file [default: ./manifest.toml]
  [OUTPUT_CONFIG_FILE_PATH]  Path to output config file [default: ./config.toml]
```

## Complete the Haiku Configuration Template

After generating the initial Haiku configuration template, you'll need to fill in the necessary details to customize it for your project. This step is crucial for ensuring that Haiku integrates correctly with your Dojo setup and functions as intended.

## Run Haiku

To run Haiku, you need to specify the path to your Haiku configuration file. Use the following command:
```
Usage: haiku run <CONFIG_FILE_PATH>

Arguments:
  <CONFIG_FILE_PATH>  Path to the configuration file

```

Now that your Haiku results are being streamed as offchain messages, you can integrate them into your client application. To help you get started, we've provided example client implementations in the `/examples` folder of this repository. These examples demonstrate various ways to consume and display Haiku messages in different client environments.

# Supported Data Types and Limitations

Haiku events currently have some limitations regarding the data types that can be used for event fields:

1. Numeric Types:
   - Supported: u8, u16, u32, u64, u128
   - Not supported: felt252 for numbers (Haiku converts these to short strings)

2. Boolean Type:
   - Supported: bool

3. String Type:
   - Supported: felt252 for strings

4. Complex Types:
   - Not supported: structs, arrays, or other complex data structures

5. Address Type:
   - Supported: ContractAddress

When defining your event fields, ensure you use these supported types to guarantee proper functionality within the Haiku system. If you need to represent more complex data, consider breaking it down into multiple simple fields or using string representations where appropriate.

Note: This list of supported types may expand in future versions of Haiku. Always refer to the most recent documentation for up-to-date information on supported data types.

# Haiku Configuration

   ## Glossary
   - **E.M.:** Event Message

The Haiku event system is configured in the `config.toml` file. Here are the key sections:

## Haiku

- **name:** Name of the E.M. domain

## Metadata

Defines the basic settings for the Haiku system.

- **torii_url:** Torii address
- **rpc_url:** Katana address
- **world_address:** Dojo world address
- **relay_url:** Used by E.M. stream

      Example: `/ip4/127.0.0.1/udp/9090/quic-v1`
- **database_url:** Name of the DB which will store LLM responses

      - Created if doesn't exist
      - Used to fetch previous memories to enhance prompts
- **signer_address:** 
- **signer_public_key:** 
- **signer_private_key:** 

## LLM

Configures the Language Model (LLM) used for generating Haiku responses
and the Embedding Model used to store them.

- **model:** "haiku"

      Used for interacting with a local Ollama model
- **ai_url:** LLM API endpoint
- **ai_token:** LLM Bearer Token
- **vectorization_url:** Embedding Model API endpoint
- **vectorization_token:** Embedding Model Bearer Token

## Database Config

Defines the database configuration used for storing and retrieving LLM responses

- **vector_size:** Size of the Embedding Model vectors

      Example: "1536" (for OpenAI's 'text-embedding-3-small' model)
- **number_memory_to_retrieve:** Number of memories to fetch for every new prompt

### Context

- **story:** Provides context about your game's lore (System)


## Events


This section defines the events that trigger Haiku generation.
Pregenerated using the 'cairo build' command by fetching events from the Manifest

- **tag:** \<Namespace\>-\<Event Model Name\>

   ### :warning: **Sections below need to be repeated for each event model** :warning:

#### Prompt

   - **template:** Prompt used to generate the response for this specific event model

#### Database Keys

   - **storage_keys:** Names of the events you want to store this event into
   - **retrieval_keys:** Names of the events you want to retrieve memories from

#### Keys Mapping

- **key:**
- **alias:**

![alt text](img/Haiku-red.png)