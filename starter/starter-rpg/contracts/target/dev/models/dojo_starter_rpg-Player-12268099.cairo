impl PlayerIntrospect<> of dojo::model::introspect::Introspect<Player<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(8)
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 1662888706315489029783778020829652209226192902507025527692503873491804662958,
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
                    selector: 70178920214545354537298868807007585610213062887858840861456479606807550384,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 260543300941786315594203740777186866812756889840785228703984478738967316256,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1201534557184837065027119851457754782777118590858140753138207699815287338437,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1528802474226268325865027367859591458315299653151958663884057507666229546336,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'Player',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'mode',
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
                        name: 'gold',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'score',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'seed',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'name',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct PlayerEntity {
    __id: felt252, // private field
    pub mode: u8,
    pub role: u8,
    pub damage: u8,
    pub health: u8,
    pub gold: u16,
    pub score: u16,
    pub seed: felt252,
    pub name: felt252,
}

#[generate_trait]
pub impl PlayerEntityStoreImpl of PlayerEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> PlayerEntity {
        PlayerModelEntityImpl::get(world, entity_id)
    }


    fn get_mode(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            1662888706315489029783778020829652209226192902507025527692503873491804662958
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_mode(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1662888706315489029783778020829652209226192902507025527692503873491804662958,
                serialized.span()
            );
    }

    fn get_role(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            298141920877297362218063439049958162789509994040046126471683228246625906567
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_role(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            458858933607245089679648131798619691919829532491702687054118372189925594141
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_damage(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            10081705603222233110711583073880238465441675299724638350815334665239107538
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_health(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                10081705603222233110711583073880238465441675299724638350815334665239107538,
                serialized.span()
            );
    }

    fn get_gold(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            70178920214545354537298868807007585610213062887858840861456479606807550384
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Player::gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_gold(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                70178920214545354537298868807007585610213062887858840861456479606807550384,
                serialized.span()
            );
    }

    fn get_score(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            260543300941786315594203740777186866812756889840785228703984478738967316256
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Player::score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_score(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                260543300941786315594203740777186866812756889840785228703984478738967316256,
                serialized.span()
            );
    }

    fn get_seed(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            1201534557184837065027119851457754782777118590858140753138207699815287338437
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Player::seed`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_seed(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1201534557184837065027119851457754782777118590858140753138207699815287338437,
                serialized.span()
            );
    }

    fn get_name(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            1528802474226268325865027367859591458315299653151958663884057507666229546336
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Player::name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_name(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1528802474226268325865027367859591458315299653151958663884057507666229546336,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl PlayerStoreImpl of PlayerStore {
    fn entity_id_from_keys(id: felt252) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Player {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Player>::deserialize(ref serialized);

        if core::option::OptionTrait::<Player>::is_none(@entity) {
            panic!(
                "Model `Player`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Player>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, id: felt252) -> Player {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        dojo::model::Model::<Player>::get(world, serialized.span())
    }


    fn get_mode(world: dojo::world::IWorldDispatcher, id: felt252) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            1662888706315489029783778020829652209226192902507025527692503873491804662958
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_mode(self: @Player, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1662888706315489029783778020829652209226192902507025527692503873491804662958,
                serialized.span()
            );
    }

    fn get_role(world: dojo::world::IWorldDispatcher, id: felt252) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            298141920877297362218063439049958162789509994040046126471683228246625906567
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_role(self: @Player, world: dojo::world::IWorldDispatcher, value: u8) {
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
            Player
        >::get_member(
            world,
            serialized.span(),
            458858933607245089679648131798619691919829532491702687054118372189925594141
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_damage(self: @Player, world: dojo::world::IWorldDispatcher, value: u8) {
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
            Player
        >::get_member(
            world,
            serialized.span(),
            10081705603222233110711583073880238465441675299724638350815334665239107538
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Player::health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_health(self: @Player, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                10081705603222233110711583073880238465441675299724638350815334665239107538,
                serialized.span()
            );
    }

    fn get_gold(world: dojo::world::IWorldDispatcher, id: felt252) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            70178920214545354537298868807007585610213062887858840861456479606807550384
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Player::gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_gold(self: @Player, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                70178920214545354537298868807007585610213062887858840861456479606807550384,
                serialized.span()
            );
    }

    fn get_score(world: dojo::world::IWorldDispatcher, id: felt252) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            260543300941786315594203740777186866812756889840785228703984478738967316256
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Player::score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_score(self: @Player, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                260543300941786315594203740777186866812756889840785228703984478738967316256,
                serialized.span()
            );
    }

    fn get_seed(world: dojo::world::IWorldDispatcher, id: felt252) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            1201534557184837065027119851457754782777118590858140753138207699815287338437
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Player::seed`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_seed(self: @Player, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1201534557184837065027119851457754782777118590858140753138207699815287338437,
                serialized.span()
            );
    }

    fn get_name(world: dojo::world::IWorldDispatcher, id: felt252) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, id);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            1528802474226268325865027367859591458315299653151958663884057507666229546336
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Player::name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_name(self: @Player, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1528802474226268325865027367859591458315299653151958663884057507666229546336,
                serialized.span()
            );
    }
}

pub impl PlayerModelEntityImpl of dojo::model::ModelEntity<PlayerEntity> {
    fn id(self: @PlayerEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @PlayerEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.mode, ref serialized);
        core::serde::Serde::serialize(self.role, ref serialized);
        core::serde::Serde::serialize(self.damage, ref serialized);
        core::serde::Serde::serialize(self.health, ref serialized);
        core::serde::Serde::serialize(self.gold, ref serialized);
        core::serde::Serde::serialize(self.score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.seed);
        core::array::ArrayTrait::append(ref serialized, *self.name);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> PlayerEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<PlayerEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<PlayerEntity>::is_none(@entity_values) {
            panic!("ModelEntity `PlayerEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<PlayerEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> PlayerEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Player>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @PlayerEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Player>::layout()
        );
    }

    fn delete(self: @PlayerEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Player>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Player>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Player>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @PlayerEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Player>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Player>::selector(),
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
pub impl PlayerModelEntityTestImpl of dojo::model::ModelEntityTest<PlayerEntity> {
    fn update_test(self: @PlayerEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Player>::layout()
        );
    }

    fn delete_test(self: @PlayerEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Player>::layout()
        );
    }
}

pub impl PlayerModelImpl of dojo::model::Model<Player> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Player {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        PlayerStore::from_values(ref _keys, ref values)
    }

    fn set(self: @Player, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @Player, world: dojo::world::IWorldDispatcher) {
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
        self: @Player,
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
        "Player"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "dojo_starter_rpg"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "dojo_starter_rpg-Player"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        513103688242339697851777745481086804649935147625853056575045547048345030761
    }

    #[inline(always)]
    fn instance_selector(self: @Player) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        1073075359926275415180704315933677548333097210683379121732618306925003101845
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        478818318480335965857378696073169770196363091739687234837836645523859370417
    }

    #[inline(always)]
    fn entity_id(self: @Player) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Player) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.id);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Player) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.mode, ref serialized);
        core::serde::Serde::serialize(self.role, ref serialized);
        core::serde::Serde::serialize(self.damage, ref serialized);
        core::serde::Serde::serialize(self.health, ref serialized);
        core::serde::Serde::serialize(self.gold, ref serialized);
        core::serde::Serde::serialize(self.score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.seed);
        core::array::ArrayTrait::append(ref serialized, *self.name);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Player>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Player) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl PlayerModelTestImpl of dojo::model::ModelTest<Player> {
    fn set_test(self: @Player, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<Player>::keys(self)),
            dojo::model::Model::<Player>::values(self),
            dojo::model::Model::<Player>::layout()
        );
    }

    fn delete_test(self: @Player, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<Player>::keys(self)),
            dojo::model::Model::<Player>::layout()
        );
    }
}

#[starknet::interface]
pub trait Iplayer<T> {
    fn ensure_abi(self: @T, model: Player);
}

#[starknet::contract]
pub mod player {
    use super::Player;
    use super::Iplayer;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Player>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Player>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Player>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Player>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Player>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Player>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Player>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Player>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Player>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Player>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Player>::ty()
        }
    }

    #[abi(embed_v0)]
    impl playerImpl of Iplayer<ContractState> {
        fn ensure_abi(self: @ContractState, model: Player) {}
    }
}
