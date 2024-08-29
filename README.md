![alt text](img/Haiku-blue.png)

# Haiku - AI-Powered Lore Generation for Dojo Projects

Haiku enables developers to effortlessly implement AI-powered lore generation within Dojo-powered applications by leveraging contract events as triggers and generating contextual lore as outputs, streamed back to the world through event messages.

# Key Features

- Seamless integration with Dojo projects
- AI responses triggered by contract events
- Simple configuration through the `config.toml` file

# How It Works

1. Emit dojo events from your smart contracts
2. Events trigger an LLM chat completion request
3. LLM responses are streamed back to you leveraging dojo event messages


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

      Example: `/ip4/127.0.0.1/udp/9090/quic-v**1**`
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