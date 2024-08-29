mod setup {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::testing::{set_contract_address, set_caller_address};

    // Dojo imports

    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::utils::test::{spawn_test_world};

    // Internal imports

    use rpg::models::index;
    use rpg::types::role::Role;
    use rpg::systems::actions::{actions, IActions, IActionsDispatcher, IActionsDispatcherTrait};

    // Constants

    fn PLAYER() -> ContractAddress {
        starknet::contract_address_const::<'PLAYER'>()
    }

    const PLAYER_NAME: felt252 = 'PLAYER';

    #[derive(Drop)]
    struct Systems {
        actions: IActionsDispatcher,
    }

    #[derive(Drop)]
    struct Context {
        player_id: felt252,
        player_name: felt252,
    }

    #[inline(always)]
    fn spawn_game() -> (IWorldDispatcher, Systems, Context) {
        // [Setup] World
        let models = array![index::player::TEST_CLASS_HASH, index::dungeon::TEST_CLASS_HASH,];
        let world = spawn_test_world(array!["dojo_starter_rpg"].span(), models.span());

        // [Setup] Systems
        let actions_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let systems = Systems {
            actions: IActionsDispatcher { contract_address: actions_address },
        };
        world.grant_writer(dojo::utils::bytearray_hash(@"dojo_starter_rpg"), actions_address);
        world.grant_writer(dojo::utils::bytearray_hash(@"dojo_starter_rpg"), PLAYER());

        // [Setup] Context
        set_contract_address(PLAYER());
        systems.actions.spawn(PLAYER_NAME, Role::Water.into());
        let context = Context { player_id: PLAYER().into(), player_name: PLAYER_NAME, };

        // [Return]
        (world, systems, context)
    }
}
