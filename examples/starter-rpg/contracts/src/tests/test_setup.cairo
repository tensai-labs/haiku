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
use rpg::systems::actions::IActionsDispatcherTrait;

// Test imports

use rpg::tests::setup::{setup, setup::{Systems, PLAYER}};

#[test]
fn test_actions_setup() {
    // [Setup]
    let (world, _, context) = setup::spawn_game();
    let store = StoreTrait::new(world);

    // [Assert]
    let (player, dungeon) = store.get_state(context.player_id);
    assert(player.id == context.player_id, 'Setup: player id');
    assert(dungeon.health == 0, 'Setup: dungeon health');
}
