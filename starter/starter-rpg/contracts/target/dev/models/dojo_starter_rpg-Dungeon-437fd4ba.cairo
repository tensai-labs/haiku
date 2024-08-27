impl DungeonIntrospect<> of dojo::model::introspect::Introspect<Dungeon<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(5)
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 1362045696071963491046823716013748693812889004281571853680755260656600308067,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 298141920877297362218063439049958162789509994040046126471683228246625906567,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 458858933607245089679648131798619691919829532491702687054118372189925594141,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 10081705603222233110711583073880238465441675299724638350815334665239107538,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 588725634485595069358303841479915730658972816749156481969410840728465956366,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'Dungeon',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'monster',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'role',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'damage',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'health',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'reward',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct DungeonEntity {
    __id: felt252, // private field
    pub monster: u8,
    pub role: u8,
    pub damage: u8,
    pub health: u8,
    pub reward: u16,
}

#[generate_trait]
pub impl DungeonEntityStoreImpl of DungeonEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> DungeonEntity {
        DungeonModelEntityImpl::get(world, entity_id)
    }


    fn get_monster(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            DungeonEntity
        >::get_member(
            world,
            entity_id,
            1362045696071963491046823716013748693812889004281571853680755260656600308067
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::monster`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_monster(self: @DungeonEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1362045696071963491046823716013748693812889004281571853680755260656600308067,
                serialized.span()
            );
    }

    fn get_role(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            DungeonEntity
        >::get_member(
            world,
            entity_id,
            298141920877297362218063439049958162789509994040046126471683228246625906567
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_role(self: @DungeonEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                298141920877297362218063439049958162789509994040046126471683228246625906567,
                serialized.span()
            );
    }

    fn get_damage(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            DungeonEntity
        >::get_member(
            world,
            entity_id,
            458858933607245089679648131798619691919829532491702687054118372189925594141
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_damage(self: @DungeonEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                458858933607245089679648131798619691919829532491702687054118372189925594141,
                serialized.span()
            );
    }

    fn get_health(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            DungeonEntity
        >::get_member(
            world,
            entity_id,
            10081705603222233110711583073880238465441675299724638350815334665239107538
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_health(self: @DungeonEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                10081705603222233110711583073880238465441675299724638350815334665239107538,
                serialized.span()
            );
    }

    fn get_reward(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            DungeonEntity
        >::get_member(
            world,
            entity_id,
            588725634485595069358303841479915730658972816749156481969410840728465956366
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Dungeon::reward`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_reward(self: @DungeonEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                588725634485595069358303841479915730658972816749156481969410840728465956366,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl DungeonStoreImpl of DungeonStore {
    fn entity_id_from_keys(id: felt252) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Dungeon {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Dungeon>::deserialize(ref serialized);

        if core::option::OptionTrait::<Dungeon>::is_none(@entity) {
            panic!(
                "Model `Dungeon`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Dungeon>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, id: felt252) -> Dungeon {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        dojo::model::Model::<Dungeon>::get(world, serialized.span())
    }


    fn get_monster(world: dojo::world::IWorldDispatcher, id: felt252) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Dungeon
        >::get_member(
            world,
            serialized.span(),
            1362045696071963491046823716013748693812889004281571853680755260656600308067
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::monster`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_monster(self: @Dungeon, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1362045696071963491046823716013748693812889004281571853680755260656600308067,
                serialized.span()
            );
    }

    fn get_role(world: dojo::world::IWorldDispatcher, id: felt252) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Dungeon
        >::get_member(
            world,
            serialized.span(),
            298141920877297362218063439049958162789509994040046126471683228246625906567
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_role(self: @Dungeon, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                298141920877297362218063439049958162789509994040046126471683228246625906567,
                serialized.span()
            );
    }

    fn get_damage(world: dojo::world::IWorldDispatcher, id: felt252) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Dungeon
        >::get_member(
            world,
            serialized.span(),
            458858933607245089679648131798619691919829532491702687054118372189925594141
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_damage(self: @Dungeon, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                458858933607245089679648131798619691919829532491702687054118372189925594141,
                serialized.span()
            );
    }

    fn get_health(world: dojo::world::IWorldDispatcher, id: felt252) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Dungeon
        >::get_member(
            world,
            serialized.span(),
            10081705603222233110711583073880238465441675299724638350815334665239107538
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Dungeon::health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_health(self: @Dungeon, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                10081705603222233110711583073880238465441675299724638350815334665239107538,
                serialized.span()
            );
    }

    fn get_reward(world: dojo::world::IWorldDispatcher, id: felt252) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Dungeon
        >::get_member(
            world,
            serialized.span(),
            588725634485595069358303841479915730658972816749156481969410840728465956366
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Dungeon::reward`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_reward(self: @Dungeon, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                588725634485595069358303841479915730658972816749156481969410840728465956366,
                serialized.span()
            );
    }
}

pub impl DungeonModelEntityImpl of dojo::model::ModelEntity<DungeonEntity> {
    fn id(self: @DungeonEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @DungeonEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.monster, ref serialized);
        core::serde::Serde::serialize(self.role, ref serialized);
        core::serde::Serde::serialize(self.damage, ref serialized);
        core::serde::Serde::serialize(self.health, ref serialized);
        core::serde::Serde::serialize(self.reward, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> DungeonEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<DungeonEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<DungeonEntity>::is_none(@entity_values) {
            panic!("ModelEntity `DungeonEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<DungeonEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> DungeonEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Dungeon>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @DungeonEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Dungeon>::layout()
        );
    }

    fn delete(self: @DungeonEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Dungeon>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Dungeon>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Dungeon>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @DungeonEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Dungeon>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Dungeon>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

#[cfg(target: "test")]
pub impl DungeonModelEntityTestImpl of dojo::model::ModelEntityTest<DungeonEntity> {
    fn update_test(self: @DungeonEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Dungeon>::layout()
        );
    }

    fn delete_test(self: @DungeonEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Dungeon>::layout()
        );
    }
}

pub impl DungeonModelImpl of dojo::model::Model<Dungeon> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Dungeon {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        DungeonStore::from_values(ref _keys, ref values)
    }

    fn set(self: @Dungeon, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @Dungeon, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(Self::keys(self)), Self::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, keys: Span<felt252>, member_id: felt252
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(Self::layout(), member_id) {
            Option::Some(field_layout) => {
                let entity_id = dojo::utils::entity_id_from_keys(keys);
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    Self::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @Dungeon,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>
    ) {
        match dojo::utils::find_model_field_layout(Self::layout(), member_id) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    Self::selector(),
                    dojo::model::ModelIndex::MemberId((self.entity_id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Dungeon"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "dojo_starter_rpg"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "dojo_starter_rpg-Dungeon"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1908176165247139222074945330736159567130651045135032917555622041498844213143
    }

    #[inline(always)]
    fn instance_selector(self: @Dungeon) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        3323996017964218987263254239677412365860613786986002974584247974495222370351
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        478818318480335965857378696073169770196363091739687234837836645523859370417
    }

    #[inline(always)]
    fn entity_id(self: @Dungeon) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Dungeon) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.id);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Dungeon) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.monster, ref serialized);
        core::serde::Serde::serialize(self.role, ref serialized);
        core::serde::Serde::serialize(self.damage, ref serialized);
        core::serde::Serde::serialize(self.health, ref serialized);
        core::serde::Serde::serialize(self.reward, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Dungeon>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Dungeon) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl DungeonModelTestImpl of dojo::model::ModelTest<Dungeon> {
    fn set_test(self: @Dungeon, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<Dungeon>::keys(self)),
            dojo::model::Model::<Dungeon>::values(self),
            dojo::model::Model::<Dungeon>::layout()
        );
    }

    fn delete_test(self: @Dungeon, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<Dungeon>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<Dungeon>::keys(self)),
            dojo::model::Model::<Dungeon>::layout()
        );
    }
}

#[starknet::interface]
pub trait Idungeon<T> {
    fn ensure_abi(self: @T, model: Dungeon);
}

#[starknet::contract]
pub mod dungeon {
    use super::Dungeon;
    use super::Idungeon;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Dungeon>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Dungeon>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Dungeon>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Dungeon>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Dungeon>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Dungeon>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Dungeon>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Dungeon>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Dungeon>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Dungeon>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Dungeon>::ty()
        }
    }

    #[abi(embed_v0)]
    impl dungeonImpl of Idungeon<ContractState> {
        fn ensure_abi(self: @ContractState, model: Dungeon) {}
    }
}
