// Core imports

use core::debug::PrintTrait;

// Starknet imports

use starknet::testing::{set_contract_address, set_transaction_hash};

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Internal imports

use rpg::store::{Store, StoreTrait};
use rpg::models::player::{Player, PlayerTrait};
use rpg::models::dungeon::{Dungeon, DungeonTrait};
use rpg::types::direction::Direction;
use rpg::systems::actions::IActionsDispatcherTrait;
use rpg::tests::setup::{setup, setup::{Systems, PLAYER}};

#[test]
fn test_actions_heal() {
    // [Setup]
    let (world, systems, context) = setup::spawn_game();
    let store = StoreTrait::new(world);

    // [Move]
    systems.actions.move(Direction::Up.into());

    // [Attack] Till death
    loop {
        let dungeon = store.get_dungeon(context.player_id);
        if dungeon.health == 0 {
            break;
        }
        systems.actions.attack();
    };

    // [Move]
    systems.actions.move(Direction::Up.into());
    let mut dungeon = store.get_dungeon(context.player_id);
    dungeon.monster = 0;
    store.set_dungeon(dungeon);

    // [Heal]
    let player = store.get_player(context.player_id);
    let player_health = player.health;
    let player_gold = player.gold;
    systems.actions.heal(1);

    // [Assert]
    let (player, _dungeon) = store.get_state(context.player_id);
    assert(player.health > player_health, 'Attack: player health');
    assert(player.gold < player_gold, 'Attack: player gold');
}
