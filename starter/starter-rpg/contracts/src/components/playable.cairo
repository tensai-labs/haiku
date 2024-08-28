#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::info::{get_caller_address, get_block_timestamp};

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports

    use rpg::constants;
    use rpg::store::{Store, StoreTrait};
    use rpg::models::player::{Player, PlayerTrait, PlayerAssert};
    use rpg::models::dungeon::{Dungeon, DungeonTrait, DungeonAssert};
    use rpg::types::role::Role;
    use rpg::types::mode::Mode;
    use rpg::types::direction::Direction;

    // Errors

    mod errors {}

    // Storage

    #[storage]
    struct Storage {}

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    // Haiku Events
    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    #[dojo::model(namespace: "haiku", nomapping: true)]
    struct SpawnEvent {
        #[key]
        player_id: felt252,
        #[key]
        id: u32,
        timestamp: u64,
        player_role: u8,
        player_mode: u8,
        player_health: u8,
        player_gold: u16,
        player_score: u16,
        player_name: felt252,
    }

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    #[dojo::model(namespace: "haiku", nomapping: true)]
    struct MoveEvent {
        #[key]
        player_id: felt252,
        #[key]
        id: u32,
        timestamp: u64,
        direction: u8,
        player_role: u8,
        player_mode: u8,
        player_health: u8,
        player_gold: u16,
        player_score: u16,
        player_name: felt252,
        new_dungeon_monster: u8,
        new_dungeon_role: u8,
        new_dungeon_damage: u8,
        new_dungeon_health: u8,
        new_dungeon_reward: u16,
    }

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    #[dojo::model(namespace: "haiku", nomapping: true)]
    struct AttackEvent {
        #[key]
        player_id: felt252,
        #[key]
        id: u32,
        timestamp: u64,
        player_role: u8,
        player_mode: u8,
        player_health: u8,
        player_gold: u16,
        player_score: u16,
        player_name: felt252,
        dungeon_monster: u8,
        dungeon_role: u8,
        dungeon_damage: u8,
        dungeon_health: u8,
        dungeon_reward: u16,
        has_defeated_dungeon: bool,
    }

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    #[dojo::model(namespace: "haiku", nomapping: true)]
    struct HealEvent {
        #[key]
        player_id: felt252,
        #[key]
        id: u32,
        timestamp: u64,
        player_role: u8,
        player_mode: u8,
        player_health: u8,
        player_gold: u16,
        player_score: u16,
        player_name: felt252,
        quantity: u8,
    }


    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn spawn(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            name: felt252,
            role: u8,
            mode: u8
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Create player
            let player_id: felt252 = get_caller_address().into();
            let time: u64 = get_block_timestamp();
            let mut player = PlayerTrait::new(player_id, name, time, mode.into());

            // [Effect] Player role
            player.enrole(role.into());

            // [Effect] Set player
            store.set_player(player);

            emit!(
                world,
                SpawnEvent {
                    player_id,
                    id: world.uuid(),
                    timestamp: time,
                    player_name: player.name,
                    player_role: player.role,
                    player_mode: player.mode,
                    player_health: player.health,
                    player_gold: player.gold,
                    player_score: player.score
                }
            );
        }

        fn move(self: @ComponentState<TContractState>, world: IWorldDispatcher, direction: u8) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let player_id: felt252 = get_caller_address().into();
            let (mut player, dungeon) = store.get_state(player_id);

            // [Check] Player is not dead
            player.assert_not_dead();

            // [Check] Current dungeon is done
            dungeon.assert_is_done();

            // [Effect] Move player
            let (monster, role) = player.move(direction.into());
            let new_dungeon: Dungeon = DungeonTrait::new(dungeon.id, monster, role);

            // [Effect] Update state
            store.set_state(player, new_dungeon);

            emit!(
                world,
                MoveEvent {
                    player_id,
                    id: world.uuid(),
                    timestamp: get_block_timestamp(),
                    direction,
                    player_role: player.role,
                    player_mode: player.mode,
                    player_health: player.health,
                    player_gold: player.gold,
                    player_score: player.score,
                    player_name: player.name,
                    new_dungeon_monster: new_dungeon.monster,
                    new_dungeon_role: new_dungeon.role,
                    new_dungeon_damage: new_dungeon.damage,
                    new_dungeon_health: new_dungeon.health,
                    new_dungeon_reward: new_dungeon.reward
                }
            );
        }

        fn attack(self: @ComponentState<TContractState>, world: IWorldDispatcher) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let player_id: felt252 = get_caller_address().into();
            let (mut player, mut dungeon) = store.get_state(player_id);

            // [Check] Player is not dead
            player.assert_not_dead();

            // [Check] Current dungeon is not done
            dungeon.assert_not_done();

            // [Effect] Attack
            dungeon.take_damage(player.role.into(), player.damage);

            // [Effect] Defend
            if dungeon.is_done() {
                player.reward(dungeon.get_treasury());
            } else {
                player.take_damage(dungeon.role.into(), dungeon.damage);
            }

            // [Effect] Update state
            store.set_state(player, dungeon);

            emit!(
                world,
                AttackEvent {
                    player_id,
                    id: world.uuid(),
                    timestamp: get_block_timestamp(),
                    player_role: player.role,
                    player_mode: player.mode,
                    player_health: player.health,
                    player_gold: player.gold,
                    player_score: player.score,
                    player_name: player.name,
                    dungeon_monster: dungeon.monster,
                    dungeon_role: dungeon.role,
                    dungeon_damage: dungeon.damage,
                    dungeon_health: dungeon.health,
                    dungeon_reward: dungeon.reward,
                    has_defeated_dungeon: dungeon.is_done()
                }
            );
        }

        fn heal(self: @ComponentState<TContractState>, world: IWorldDispatcher, quantity: u8) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let player_id: felt252 = get_caller_address().into();
            let (mut player, dungeon) = store.get_state(player_id);

            // [Check] Player is not dead
            player.assert_not_dead();

            // [Check] Current dungeon is a shop
            dungeon.assert_is_shop();

            // [Effect] Heal
            player.heal(quantity);

            // [Effect] Update state
            store.set_player(player);

            emit!(
                world,
                HealEvent {
                    player_id,
                    id: world.uuid(),
                    timestamp: get_block_timestamp(),
                    player_role: player.role,
                    player_mode: player.mode,
                    player_health: player.health,
                    player_gold: player.gold,
                    player_score: player.score,
                    player_name: player.name,
                    quantity
                }
            );
        }
    }
}
