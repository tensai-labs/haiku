// Starknet imports

use starknet::ContractAddress;

// Dojo imports

use dojo::world::IWorldDispatcher;

// Interfaces

#[starknet::interface]
trait IActions<TContractState> {
    fn spawn(self: @TContractState, name: felt252, role: u8);
    fn move(self: @TContractState, direction: u8);
    fn attack(self: @TContractState);
    fn heal(self: @TContractState, quantity: u8);
}

// Contracts

#[dojo::contract]
mod actions {
    // Component imports

    use rpg::components::playable::PlayableComponent;

    // Internal imports

    use rpg::types::mode::Mode;

    // Local imports

    use super::IActions;

    // Components

    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;

    // Storage

    #[storage]
    struct Storage {
        #[substorage(v0)]
        playable: PlayableComponent::Storage,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        PlayableEvent: PlayableComponent::Event,
    }

    // Implementations

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(self: @ContractState, name: felt252, role: u8) {
            self.playable.spawn(self.world(), name, role, Mode::Medium.into())
        }

        fn move(self: @ContractState, direction: u8) {
            self.playable.move(self.world(), direction)
        }

        fn attack(self: @ContractState) {
            self.playable.attack(self.world())
        }

        fn heal(self: @ContractState, quantity: u8) {
            self.playable.heal(self.world(), quantity)
        }
    }
}
