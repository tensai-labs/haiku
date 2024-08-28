#[starknet::contract]
pub mod actions {
    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IWorldProvider;
    use dojo::contract::IContract;
    use starknet::storage::{
        StorageMapReadAccess, StorageMapWriteAccess, StoragePointerReadAccess,
        StoragePointerWriteAccess
    };

    component!(
        path: dojo::contract::upgradeable::upgradeable,
        storage: upgradeable,
        event: UpgradeableEvent
    );

    #[abi(embed_v0)]
    pub impl ContractImpl of IContract<ContractState> {
        fn contract_name(self: @ContractState) -> ByteArray {
            "actions"
        }

        fn namespace(self: @ContractState) -> ByteArray {
            "dojo_starter_rpg"
        }

        fn tag(self: @ContractState) -> ByteArray {
            "dojo_starter_rpg-actions"
        }

        fn name_hash(self: @ContractState) -> felt252 {
            2086192618380495284091910654139796563008957181282529006110721547110208160990
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            478818318480335965857378696073169770196363091739687234837836645523859370417
        }

        fn selector(self: @ContractState) -> felt252 {
            2119759012706724827775869657687441349302555895191611646984125534702989689384
        }
    }

    #[abi(embed_v0)]
    impl WorldProviderImpl of IWorldProvider<ContractState> {
        fn world(self: @ContractState) -> IWorldDispatcher {
            self.world_dispatcher.read()
        }
    }

    #[abi(embed_v0)]
    impl UpgradableImpl =
        dojo::contract::upgradeable::upgradeable::UpgradableImpl<ContractState>;

    // Component imports

    use rpg::components::playable::PlayableComponent;

    // Internal imports

    use rpg::types::mode::Mode;

    // Local imports

    use super::IActions;

    // Components

    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        world_dispatcher: IWorldDispatcher,
        #[substorage(v0)]
        upgradeable: dojo::contract::upgradeable::upgradeable::Storage,
        #[substorage(v0)]
        playable: PlayableComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: dojo::contract::upgradeable::upgradeable::Event,
        #[flat]
        PlayableEvent: PlayableComponent::Event
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
    #[starknet::interface]
    trait IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState);
    }

    #[abi(embed_v0)]
    impl IDojoInitImpl of IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState) {
            assert(
                starknet::get_caller_address() == self.world().contract_address,
                'Only world can init'
            );
            assert(
                self
                    .world()
                    .is_owner(self.selector(), starknet::get_tx_info().account_contract_address),
                'Only owner can init'
            );
        }
    }
}

