
// Generated by dojo-bindgen on Wed, 28 Aug 2024 20:25:21 +0000. Do not modify this file manually.
// Import the necessary types from the recs SDK
// generate again with `sozo build --typescript` 
import { defineComponent, Type as RecsType, World } from "@dojoengine/recs";

export type ContractComponents = Awaited<ReturnType<typeof defineContractComponents>>;



// Type definition for `dojo::model::layout::Layout` enum
export type Layout = { type: 'Fixed'; value: RecsType.NumberArray; } | { type: 'Struct'; value: RecsType.StringArray; } | { type: 'Tuple'; value: RecsType.StringArray; } | { type: 'Array'; value: RecsType.StringArray; } | { type: 'ByteArray'; } | { type: 'Enum'; value: RecsType.StringArray; };

export const LayoutDefinition = {
    type: RecsType.String,
    value: RecsType.String
};
        
// Type definition for `dojo::model::layout::FieldLayout` struct
export interface FieldLayout {
    selector: BigInt;
    layout: Layout;
    
}
export const FieldLayoutDefinition = {
    selector: RecsType.BigInt,
    layout: LayoutDefinition,
    
};

// Type definition for `core::byte_array::ByteArray` struct
export interface ByteArray {
    data: String[];
    pending_word: BigInt;
    pending_word_len: Number;
    
}
export const ByteArrayDefinition = {
    data: RecsType.StringArray,
    pending_word: RecsType.BigInt,
    pending_word_len: RecsType.Number,
    
};

// Type definition for `rpg::components::playable::PlayableComponent::SpawnEvent` struct
export interface SpawnEvent {
    player_id: BigInt;
    id: Number;
    timestamp: Number;
    player_role: Number;
    player_mode: Number;
    player_health: Number;
    player_gold: Number;
    player_score: Number;
    player_name: BigInt;
    
}
export const SpawnEventDefinition = {
    player_id: RecsType.BigInt,
    id: RecsType.Number,
    timestamp: RecsType.Number,
    player_role: RecsType.Number,
    player_mode: RecsType.Number,
    player_health: RecsType.Number,
    player_gold: RecsType.Number,
    player_score: RecsType.Number,
    player_name: RecsType.BigInt,
    
};


// Type definition for `rpg::components::playable::PlayableComponent::AttackEvent` struct
export interface AttackEvent {
    player_id: BigInt;
    id: Number;
    timestamp: Number;
    player_role: Number;
    player_mode: Number;
    player_health: Number;
    player_gold: Number;
    player_score: Number;
    player_name: BigInt;
    dungeon_monster: Number;
    dungeon_role: Number;
    dungeon_damage: Number;
    dungeon_health: Number;
    dungeon_reward: Number;
    has_defeated_dungeon: Boolean;
    
}
export const AttackEventDefinition = {
    player_id: RecsType.BigInt,
    id: RecsType.Number,
    timestamp: RecsType.Number,
    player_role: RecsType.Number,
    player_mode: RecsType.Number,
    player_health: RecsType.Number,
    player_gold: RecsType.Number,
    player_score: RecsType.Number,
    player_name: RecsType.BigInt,
    dungeon_monster: RecsType.Number,
    dungeon_role: RecsType.Number,
    dungeon_damage: RecsType.Number,
    dungeon_health: RecsType.Number,
    dungeon_reward: RecsType.Number,
    has_defeated_dungeon: RecsType.Boolean,
    
};


// Type definition for `rpg::components::playable::PlayableComponent::MoveEvent` struct
export interface MoveEvent {
    player_id: BigInt;
    id: Number;
    timestamp: Number;
    direction: Number;
    player_role: Number;
    player_mode: Number;
    player_health: Number;
    player_gold: Number;
    player_score: Number;
    player_name: BigInt;
    new_dungeon_monster: Number;
    new_dungeon_role: Number;
    new_dungeon_damage: Number;
    new_dungeon_health: Number;
    new_dungeon_reward: Number;
    
}
export const MoveEventDefinition = {
    player_id: RecsType.BigInt,
    id: RecsType.Number,
    timestamp: RecsType.Number,
    direction: RecsType.Number,
    player_role: RecsType.Number,
    player_mode: RecsType.Number,
    player_health: RecsType.Number,
    player_gold: RecsType.Number,
    player_score: RecsType.Number,
    player_name: RecsType.BigInt,
    new_dungeon_monster: RecsType.Number,
    new_dungeon_role: RecsType.Number,
    new_dungeon_damage: RecsType.Number,
    new_dungeon_health: RecsType.Number,
    new_dungeon_reward: RecsType.Number,
    
};


// Type definition for `rpg::components::playable::PlayableComponent::HealEvent` struct
export interface HealEvent {
    player_id: BigInt;
    id: Number;
    timestamp: Number;
    player_role: Number;
    player_mode: Number;
    player_health: Number;
    player_gold: Number;
    player_score: Number;
    player_name: BigInt;
    quantity: Number;
    
}
export const HealEventDefinition = {
    player_id: RecsType.BigInt,
    id: RecsType.Number,
    timestamp: RecsType.Number,
    player_role: RecsType.Number,
    player_mode: RecsType.Number,
    player_health: RecsType.Number,
    player_gold: RecsType.Number,
    player_score: RecsType.Number,
    player_name: RecsType.BigInt,
    quantity: RecsType.Number,
    
};


// Type definition for `rpg::models::index::Player` struct
export interface Player {
    id: BigInt;
    mode: Number;
    role: Number;
    damage: Number;
    health: Number;
    gold: Number;
    score: Number;
    seed: BigInt;
    name: BigInt;
    
}
export const PlayerDefinition = {
    id: RecsType.BigInt,
    mode: RecsType.Number,
    role: RecsType.Number,
    damage: RecsType.Number,
    health: RecsType.Number,
    gold: RecsType.Number,
    score: RecsType.Number,
    seed: RecsType.BigInt,
    name: RecsType.BigInt,
    
};


// Type definition for `rpg::models::index::Dungeon` struct
export interface Dungeon {
    id: BigInt;
    monster: Number;
    role: Number;
    damage: Number;
    health: Number;
    reward: Number;
    
}
export const DungeonDefinition = {
    id: RecsType.BigInt,
    monster: RecsType.Number,
    role: RecsType.Number,
    damage: RecsType.Number,
    health: RecsType.Number,
    reward: RecsType.Number,
    
};


// Type definition for `haiku_event::PromptMessage` struct
export interface PromptMessage {
    identity: BigInt;
    event_id: Number;
    event_tag: String;
    prompt: String;
    timestamp: Number;
    
}
export const PromptMessageDefinition = {
    identity: RecsType.BigInt,
    event_id: RecsType.Number,
    event_tag: RecsType.String,
    prompt: RecsType.String,
    timestamp: RecsType.Number,
    
};


export function defineContractComponents(world: World) {
    return {

        // Model definition for `rpg::components::playable::PlayableComponent::SpawnEvent` model
        SpawnEvent: (() => {
            return defineComponent(
                world,
                {
                    player_id: RecsType.BigInt,
                    id: RecsType.Number,
                    timestamp: RecsType.Number,
                    player_role: RecsType.Number,
                    player_mode: RecsType.Number,
                    player_health: RecsType.Number,
                    player_gold: RecsType.Number,
                    player_score: RecsType.Number,
                    player_name: RecsType.BigInt,
                },
                {
                    metadata: {
                        namespace: "haiku",
                        name: "SpawnEvent",
                        types: ["felt252", "u32", "u64", "u8", "u8", "u8", "u16", "u16", "felt252"],
                        customTypes: [],
                    },
                }
            );
        })(),

        // Model definition for `rpg::components::playable::PlayableComponent::AttackEvent` model
        AttackEvent: (() => {
            return defineComponent(
                world,
                {
                    player_id: RecsType.BigInt,
                    id: RecsType.Number,
                    timestamp: RecsType.Number,
                    player_role: RecsType.Number,
                    player_mode: RecsType.Number,
                    player_health: RecsType.Number,
                    player_gold: RecsType.Number,
                    player_score: RecsType.Number,
                    player_name: RecsType.BigInt,
                    dungeon_monster: RecsType.Number,
                    dungeon_role: RecsType.Number,
                    dungeon_damage: RecsType.Number,
                    dungeon_health: RecsType.Number,
                    dungeon_reward: RecsType.Number,
                    has_defeated_dungeon: RecsType.Boolean,
                },
                {
                    metadata: {
                        namespace: "haiku",
                        name: "AttackEvent",
                        types: ["felt252", "u32", "u64", "u8", "u8", "u8", "u16", "u16", "felt252", "u8", "u8", "u8", "u8", "u16", "bool"],
                        customTypes: [],
                    },
                }
            );
        })(),

        // Model definition for `rpg::components::playable::PlayableComponent::MoveEvent` model
        MoveEvent: (() => {
            return defineComponent(
                world,
                {
                    player_id: RecsType.BigInt,
                    id: RecsType.Number,
                    timestamp: RecsType.Number,
                    direction: RecsType.Number,
                    player_role: RecsType.Number,
                    player_mode: RecsType.Number,
                    player_health: RecsType.Number,
                    player_gold: RecsType.Number,
                    player_score: RecsType.Number,
                    player_name: RecsType.BigInt,
                    new_dungeon_monster: RecsType.Number,
                    new_dungeon_role: RecsType.Number,
                    new_dungeon_damage: RecsType.Number,
                    new_dungeon_health: RecsType.Number,
                    new_dungeon_reward: RecsType.Number,
                },
                {
                    metadata: {
                        namespace: "haiku",
                        name: "MoveEvent",
                        types: ["felt252", "u32", "u64", "u8", "u8", "u8", "u8", "u16", "u16", "felt252", "u8", "u8", "u8", "u8", "u16"],
                        customTypes: [],
                    },
                }
            );
        })(),

        // Model definition for `rpg::components::playable::PlayableComponent::HealEvent` model
        HealEvent: (() => {
            return defineComponent(
                world,
                {
                    player_id: RecsType.BigInt,
                    id: RecsType.Number,
                    timestamp: RecsType.Number,
                    player_role: RecsType.Number,
                    player_mode: RecsType.Number,
                    player_health: RecsType.Number,
                    player_gold: RecsType.Number,
                    player_score: RecsType.Number,
                    player_name: RecsType.BigInt,
                    quantity: RecsType.Number,
                },
                {
                    metadata: {
                        namespace: "haiku",
                        name: "HealEvent",
                        types: ["felt252", "u32", "u64", "u8", "u8", "u8", "u16", "u16", "felt252", "u8"],
                        customTypes: [],
                    },
                }
            );
        })(),

        // Model definition for `rpg::models::index::Player` model
        Player: (() => {
            return defineComponent(
                world,
                {
                    id: RecsType.BigInt,
                    mode: RecsType.Number,
                    role: RecsType.Number,
                    damage: RecsType.Number,
                    health: RecsType.Number,
                    gold: RecsType.Number,
                    score: RecsType.Number,
                    seed: RecsType.BigInt,
                    name: RecsType.BigInt,
                },
                {
                    metadata: {
                        namespace: "dojo_starter_rpg",
                        name: "Player",
                        types: ["felt252", "u8", "u8", "u8", "u8", "u16", "u16", "felt252", "felt252"],
                        customTypes: [],
                    },
                }
            );
        })(),

        // Model definition for `rpg::models::index::Dungeon` model
        Dungeon: (() => {
            return defineComponent(
                world,
                {
                    id: RecsType.BigInt,
                    monster: RecsType.Number,
                    role: RecsType.Number,
                    damage: RecsType.Number,
                    health: RecsType.Number,
                    reward: RecsType.Number,
                },
                {
                    metadata: {
                        namespace: "dojo_starter_rpg",
                        name: "Dungeon",
                        types: ["felt252", "u8", "u8", "u8", "u8", "u16"],
                        customTypes: [],
                    },
                }
            );
        })(),

        // Model definition for `haiku_event::PromptMessage` model
        PromptMessage: (() => {
            return defineComponent(
                world,
                {
                    identity: RecsType.BigInt,
                    event_id: RecsType.Number,
                    event_tag: RecsType.StringDefinition,
                    prompt: RecsType.StringDefinition,
                    timestamp: RecsType.Number,
                },
                {
                    metadata: {
                        namespace: "haiku",
                        name: "PromptMessage",
                        types: ["ContractAddress", "u32", "u64"],
                        customTypes: ["ByteArray", "ByteArray"],
                    },
                }
            );
        })(),
    };
}