impl HealEventIntrospect<> of dojo::model::introspect::Introspect<HealEvent<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(8)
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 1242883636335185042648196101482844477055185136100498177742807244790485718414,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 347952960679533249680446863069020167712085033312394040450504241252785680954,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1204596313654674981356182785415911392848086107280570558172944394753040003335,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1672877539965766581367585409312665003174591496233478840813315666552568462009,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 2042338183989951520926109953808378237802007966626911652903184058220987592,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 75817691318734259820488298239604529221191294248969653688595679603338157534,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 651389263438509168837490815910930013740248828429395191830431531885294035507,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 932221791859087357774994577359372937792105398524137980662937907497847454991,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'HealEvent',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'player_id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u32>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'timestamp',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_role',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_mode',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_health',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_gold',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_score',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_name',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'quantity',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}
impl HealEventIsEvent of starknet::Event<HealEvent> {
    fn append_keys_and_data(self: @HealEvent, ref keys: Array<felt252>, ref data: Array<felt252>) {
        core::array::ArrayTrait::append(ref keys, dojo::model::Model::<HealEvent>::selector());

        core::serde::Serde::serialize(self.player_id, ref keys);
        core::serde::Serde::serialize(self.id, ref keys);
        core::serde::Serde::serialize(self.timestamp, ref data);
        core::serde::Serde::serialize(self.player_role, ref data);
        core::serde::Serde::serialize(self.player_mode, ref data);
        core::serde::Serde::serialize(self.player_health, ref data);
        core::serde::Serde::serialize(self.player_gold, ref data);
        core::serde::Serde::serialize(self.player_score, ref data);
        core::serde::Serde::serialize(self.player_name, ref data);
        core::serde::Serde::serialize(self.quantity, ref data);
    }
    fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>,) -> Option<HealEvent> {
        let player_id = core::serde::Serde::deserialize(ref keys)?;
        let id = core::serde::Serde::deserialize(ref keys)?;
        let timestamp = core::serde::Serde::deserialize(ref data)?;
        let player_role = core::serde::Serde::deserialize(ref data)?;
        let player_mode = core::serde::Serde::deserialize(ref data)?;
        let player_health = core::serde::Serde::deserialize(ref data)?;
        let player_gold = core::serde::Serde::deserialize(ref data)?;
        let player_score = core::serde::Serde::deserialize(ref data)?;
        let player_name = core::serde::Serde::deserialize(ref data)?;
        let quantity = core::serde::Serde::deserialize(ref data)?;
        Option::Some(
            HealEvent {
                player_id,
                id,
                timestamp,
                player_role,
                player_mode,
                player_health,
                player_gold,
                player_score,
                player_name,
                quantity,
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct HealEventEntity {
    __id: felt252, // private field
    pub timestamp: u64,
    pub player_role: u8,
    pub player_mode: u8,
    pub player_health: u8,
    pub player_gold: u16,
    pub player_score: u16,
    pub player_name: felt252,
    pub quantity: u8,
}

#[generate_trait]
pub impl HealEventEntityStoreImpl of HealEventEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> HealEventEntity {
        HealEventModelEntityImpl::get(world, entity_id)
    }


    fn get_timestamp(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `HealEvent::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1242883636335185042648196101482844477055185136100498177742807244790485718414,
                serialized.span()
            );
    }

    fn get_player_role(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            347952960679533249680446863069020167712085033312394040450504241252785680954
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::player_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_role(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                347952960679533249680446863069020167712085033312394040450504241252785680954,
                serialized.span()
            );
    }

    fn get_player_mode(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            1204596313654674981356182785415911392848086107280570558172944394753040003335
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::player_mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_mode(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1204596313654674981356182785415911392848086107280570558172944394753040003335,
                serialized.span()
            );
    }

    fn get_player_health(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            1672877539965766581367585409312665003174591496233478840813315666552568462009
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::player_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_health(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1672877539965766581367585409312665003174591496233478840813315666552568462009,
                serialized.span()
            );
    }

    fn get_player_gold(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            2042338183989951520926109953808378237802007966626911652903184058220987592
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `HealEvent::player_gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_gold(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                2042338183989951520926109953808378237802007966626911652903184058220987592,
                serialized.span()
            );
    }

    fn get_player_score(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            75817691318734259820488298239604529221191294248969653688595679603338157534
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `HealEvent::player_score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_score(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                75817691318734259820488298239604529221191294248969653688595679603338157534,
                serialized.span()
            );
    }

    fn get_player_name(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            651389263438509168837490815910930013740248828429395191830431531885294035507
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `HealEvent::player_name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_player_name(
        self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: felt252
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                651389263438509168837490815910930013740248828429395191830431531885294035507,
                serialized.span()
            );
    }

    fn get_quantity(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            HealEventEntity
        >::get_member(
            world,
            entity_id,
            932221791859087357774994577359372937792105398524137980662937907497847454991
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::quantity`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_quantity(self: @HealEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                932221791859087357774994577359372937792105398524137980662937907497847454991,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl HealEventStoreImpl of HealEventStore {
    fn entity_id_from_keys(player_id: felt252, id: u32) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> HealEvent {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<HealEvent>::deserialize(ref serialized);

        if core::option::OptionTrait::<HealEvent>::is_none(@entity) {
            panic!(
                "Model `HealEvent`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<HealEvent>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> HealEvent {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        dojo::model::Model::<HealEvent>::get(world, serialized.span())
    }


    fn get_timestamp(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `HealEvent::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1242883636335185042648196101482844477055185136100498177742807244790485718414,
                serialized.span()
            );
    }

    fn get_player_role(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            347952960679533249680446863069020167712085033312394040450504241252785680954
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::player_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_role(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                347952960679533249680446863069020167712085033312394040450504241252785680954,
                serialized.span()
            );
    }

    fn get_player_mode(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            1204596313654674981356182785415911392848086107280570558172944394753040003335
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::player_mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_mode(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1204596313654674981356182785415911392848086107280570558172944394753040003335,
                serialized.span()
            );
    }

    fn get_player_health(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            1672877539965766581367585409312665003174591496233478840813315666552568462009
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::player_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_health(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1672877539965766581367585409312665003174591496233478840813315666552568462009,
                serialized.span()
            );
    }

    fn get_player_gold(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            2042338183989951520926109953808378237802007966626911652903184058220987592
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `HealEvent::player_gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_gold(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                2042338183989951520926109953808378237802007966626911652903184058220987592,
                serialized.span()
            );
    }

    fn get_player_score(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            75817691318734259820488298239604529221191294248969653688595679603338157534
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `HealEvent::player_score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_score(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                75817691318734259820488298239604529221191294248969653688595679603338157534,
                serialized.span()
            );
    }

    fn get_player_name(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            651389263438509168837490815910930013740248828429395191830431531885294035507
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `HealEvent::player_name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_player_name(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                651389263438509168837490815910930013740248828429395191830431531885294035507,
                serialized.span()
            );
    }

    fn get_quantity(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            HealEvent
        >::get_member(
            world,
            serialized.span(),
            932221791859087357774994577359372937792105398524137980662937907497847454991
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `HealEvent::quantity`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_quantity(self: @HealEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                932221791859087357774994577359372937792105398524137980662937907497847454991,
                serialized.span()
            );
    }
}

pub impl HealEventModelEntityImpl of dojo::model::ModelEntity<HealEventEntity> {
    fn id(self: @HealEventEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @HealEventEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.timestamp, ref serialized);
        core::serde::Serde::serialize(self.player_role, ref serialized);
        core::serde::Serde::serialize(self.player_mode, ref serialized);
        core::serde::Serde::serialize(self.player_health, ref serialized);
        core::serde::Serde::serialize(self.player_gold, ref serialized);
        core::serde::Serde::serialize(self.player_score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.player_name);
        core::serde::Serde::serialize(self.quantity, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> HealEventEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<HealEventEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<HealEventEntity>::is_none(@entity_values) {
            panic!("ModelEntity `HealEventEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<HealEventEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> HealEventEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<HealEvent>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @HealEventEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<HealEvent>::layout()
        );
    }

    fn delete(self: @HealEventEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<HealEvent>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<HealEvent>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<HealEvent>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @HealEventEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<HealEvent>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<HealEvent>::selector(),
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
pub impl HealEventModelEntityTestImpl of dojo::model::ModelEntityTest<HealEventEntity> {
    fn update_test(self: @HealEventEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<HealEvent>::layout()
        );
    }

    fn delete_test(self: @HealEventEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<HealEvent>::layout()
        );
    }
}

pub impl HealEventModelImpl of dojo::model::Model<HealEvent> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> HealEvent {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        HealEventStore::from_values(ref _keys, ref values)
    }

    fn set(self: @HealEvent, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @HealEvent, world: dojo::world::IWorldDispatcher) {
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
        self: @HealEvent,
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
        "HealEvent"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "haiku"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "haiku-HealEvent"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        2109741629776791809124029628189778469537214125125180315527912757002052463093
    }

    #[inline(always)]
    fn instance_selector(self: @HealEvent) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        2433681639730917277741641936063840722253924417097849352448839376327354015901
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        159371543000137669334859047484239625827089117287201931851163638171079597795
    }

    #[inline(always)]
    fn entity_id(self: @HealEvent) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @HealEvent) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.player_id);
        core::serde::Serde::serialize(self.id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @HealEvent) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.timestamp, ref serialized);
        core::serde::Serde::serialize(self.player_role, ref serialized);
        core::serde::Serde::serialize(self.player_mode, ref serialized);
        core::serde::Serde::serialize(self.player_health, ref serialized);
        core::serde::Serde::serialize(self.player_gold, ref serialized);
        core::serde::Serde::serialize(self.player_score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.player_name);
        core::serde::Serde::serialize(self.quantity, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<HealEvent>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @HealEvent) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl HealEventModelTestImpl of dojo::model::ModelTest<HealEvent> {
    fn set_test(self: @HealEvent, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<HealEvent>::keys(self)),
            dojo::model::Model::<HealEvent>::values(self),
            dojo::model::Model::<HealEvent>::layout()
        );
    }

    fn delete_test(self: @HealEvent, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<HealEvent>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<HealEvent>::keys(self)),
            dojo::model::Model::<HealEvent>::layout()
        );
    }
}

#[starknet::interface]
pub trait Iheal_event<T> {
    fn ensure_abi(self: @T, model: HealEvent);
}

#[starknet::contract]
pub mod heal_event {
    use super::HealEvent;
    use super::Iheal_event;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<HealEvent>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<HealEvent>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<HealEvent>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<HealEvent>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<HealEvent>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<HealEvent>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<HealEvent>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<HealEvent>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<HealEvent>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<HealEvent>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<HealEvent>::ty()
        }
    }

    #[abi(embed_v0)]
    impl heal_eventImpl of Iheal_event<ContractState> {
        fn ensure_abi(self: @ContractState, model: HealEvent) {}
    }
}
