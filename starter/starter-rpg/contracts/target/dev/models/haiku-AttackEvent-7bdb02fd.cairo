impl AttackEventIntrospect<> of dojo::model::introspect::Introspect<AttackEvent<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(13)
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
                    selector: 102168950000858571145939073389869560072070425481841930010078123553962538342,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 530109627951607679437301613432747830930139357145950488201492263746749328885,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 977022529409359472764091882104964370301091844461932462043445522239637442846,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1726102987331377717299723881018050734695508387839193167182114725750728528365,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1786935704708425205704413196887994553601343753700099780406507342525672213622,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 822660390160987833625085692681312504283600107546628150648453296634613523547,
                    layout: dojo::model::introspect::Introspect::<bool>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'AttackEvent',
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
                        name: 'dungeon_monster',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'dungeon_role',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'dungeon_damage',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'dungeon_health',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'dungeon_reward',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'has_defeated_dungeon',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<bool>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}
impl AttackEventIsEvent of starknet::Event<AttackEvent> {
    fn append_keys_and_data(
        self: @AttackEvent, ref keys: Array<felt252>, ref data: Array<felt252>
    ) {
        core::array::ArrayTrait::append(ref keys, dojo::model::Model::<AttackEvent>::selector());

        core::serde::Serde::serialize(self.player_id, ref keys);
        core::serde::Serde::serialize(self.id, ref keys);
        core::serde::Serde::serialize(self.timestamp, ref data);
        core::serde::Serde::serialize(self.player_role, ref data);
        core::serde::Serde::serialize(self.player_mode, ref data);
        core::serde::Serde::serialize(self.player_health, ref data);
        core::serde::Serde::serialize(self.player_gold, ref data);
        core::serde::Serde::serialize(self.player_score, ref data);
        core::serde::Serde::serialize(self.player_name, ref data);
        core::serde::Serde::serialize(self.dungeon_monster, ref data);
        core::serde::Serde::serialize(self.dungeon_role, ref data);
        core::serde::Serde::serialize(self.dungeon_damage, ref data);
        core::serde::Serde::serialize(self.dungeon_health, ref data);
        core::serde::Serde::serialize(self.dungeon_reward, ref data);
        core::serde::Serde::serialize(self.has_defeated_dungeon, ref data);
    }
    fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>,) -> Option<AttackEvent> {
        let player_id = core::serde::Serde::deserialize(ref keys)?;
        let id = core::serde::Serde::deserialize(ref keys)?;
        let timestamp = core::serde::Serde::deserialize(ref data)?;
        let player_role = core::serde::Serde::deserialize(ref data)?;
        let player_mode = core::serde::Serde::deserialize(ref data)?;
        let player_health = core::serde::Serde::deserialize(ref data)?;
        let player_gold = core::serde::Serde::deserialize(ref data)?;
        let player_score = core::serde::Serde::deserialize(ref data)?;
        let player_name = core::serde::Serde::deserialize(ref data)?;
        let dungeon_monster = core::serde::Serde::deserialize(ref data)?;
        let dungeon_role = core::serde::Serde::deserialize(ref data)?;
        let dungeon_damage = core::serde::Serde::deserialize(ref data)?;
        let dungeon_health = core::serde::Serde::deserialize(ref data)?;
        let dungeon_reward = core::serde::Serde::deserialize(ref data)?;
        let has_defeated_dungeon = core::serde::Serde::deserialize(ref data)?;
        Option::Some(
            AttackEvent {
                player_id,
                id,
                timestamp,
                player_role,
                player_mode,
                player_health,
                player_gold,
                player_score,
                player_name,
                dungeon_monster,
                dungeon_role,
                dungeon_damage,
                dungeon_health,
                dungeon_reward,
                has_defeated_dungeon,
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct AttackEventEntity {
    __id: felt252, // private field
    pub timestamp: u64,
    pub player_role: u8,
    pub player_mode: u8,
    pub player_health: u8,
    pub player_gold: u16,
    pub player_score: u16,
    pub player_name: felt252,
    pub dungeon_monster: u8,
    pub dungeon_role: u8,
    pub dungeon_damage: u8,
    pub dungeon_health: u8,
    pub dungeon_reward: u16,
    pub has_defeated_dungeon: bool,
}

#[generate_trait]
pub impl AttackEventEntityStoreImpl of AttackEventEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> AttackEventEntity {
        AttackEventModelEntityImpl::get(world, entity_id)
    }


    fn get_timestamp(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `AttackEvent::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u64) {
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
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            347952960679533249680446863069020167712085033312394040450504241252785680954
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_role(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            1204596313654674981356182785415911392848086107280570558172944394753040003335
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_mode(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            1672877539965766581367585409312665003174591496233478840813315666552568462009
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_health(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
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
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            2042338183989951520926109953808378237802007966626911652903184058220987592
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_gold(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u16) {
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
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            75817691318734259820488298239604529221191294248969653688595679603338157534
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_score(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u16
    ) {
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
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            651389263438509168837490815910930013740248828429395191830431531885294035507
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_player_name(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: felt252
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

    fn get_dungeon_monster(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            102168950000858571145939073389869560072070425481841930010078123553962538342
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_monster`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_monster(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                102168950000858571145939073389869560072070425481841930010078123553962538342,
                serialized.span()
            );
    }

    fn get_dungeon_role(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            530109627951607679437301613432747830930139357145950488201492263746749328885
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_role(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                530109627951607679437301613432747830930139357145950488201492263746749328885,
                serialized.span()
            );
    }

    fn get_dungeon_damage(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            977022529409359472764091882104964370301091844461932462043445522239637442846
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_damage(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                977022529409359472764091882104964370301091844461932462043445522239637442846,
                serialized.span()
            );
    }

    fn get_dungeon_health(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            1726102987331377717299723881018050734695508387839193167182114725750728528365
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_health(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1726102987331377717299723881018050734695508387839193167182114725750728528365,
                serialized.span()
            );
    }

    fn get_dungeon_reward(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            1786935704708425205704413196887994553601343753700099780406507342525672213622
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_reward`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_dungeon_reward(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: u16
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1786935704708425205704413196887994553601343753700099780406507342525672213622,
                serialized.span()
            );
    }

    fn get_has_defeated_dungeon(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> bool {
        let mut values = dojo::model::ModelEntity::<
            AttackEventEntity
        >::get_member(
            world,
            entity_id,
            822660390160987833625085692681312504283600107546628150648453296634613523547
        );
        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `AttackEvent::has_defeated_dungeon`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_has_defeated_dungeon(
        self: @AttackEventEntity, world: dojo::world::IWorldDispatcher, value: bool
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                822660390160987833625085692681312504283600107546628150648453296634613523547,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl AttackEventStoreImpl of AttackEventStore {
    fn entity_id_from_keys(player_id: felt252, id: u32) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> AttackEvent {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<AttackEvent>::deserialize(ref serialized);

        if core::option::OptionTrait::<AttackEvent>::is_none(@entity) {
            panic!(
                "Model `AttackEvent`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<AttackEvent>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> AttackEvent {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        dojo::model::Model::<AttackEvent>::get(world, serialized.span())
    }


    fn get_timestamp(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `AttackEvent::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u64) {
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
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            347952960679533249680446863069020167712085033312394040450504241252785680954
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_role(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
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
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            1204596313654674981356182785415911392848086107280570558172944394753040003335
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_mode(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
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
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            1672877539965766581367585409312665003174591496233478840813315666552568462009
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_health(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
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
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            2042338183989951520926109953808378237802007966626911652903184058220987592
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_gold(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u16) {
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
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            75817691318734259820488298239604529221191294248969653688595679603338157534
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_score(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u16) {
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
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            651389263438509168837490815910930013740248828429395191830431531885294035507
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `AttackEvent::player_name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_player_name(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                651389263438509168837490815910930013740248828429395191830431531885294035507,
                serialized.span()
            );
    }

    fn get_dungeon_monster(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            102168950000858571145939073389869560072070425481841930010078123553962538342
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_monster`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_monster(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                102168950000858571145939073389869560072070425481841930010078123553962538342,
                serialized.span()
            );
    }

    fn get_dungeon_role(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            530109627951607679437301613432747830930139357145950488201492263746749328885
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_role(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                530109627951607679437301613432747830930139357145950488201492263746749328885,
                serialized.span()
            );
    }

    fn get_dungeon_damage(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            977022529409359472764091882104964370301091844461932462043445522239637442846
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_damage(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                977022529409359472764091882104964370301091844461932462043445522239637442846,
                serialized.span()
            );
    }

    fn get_dungeon_health(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            1726102987331377717299723881018050734695508387839193167182114725750728528365
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_dungeon_health(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1726102987331377717299723881018050734695508387839193167182114725750728528365,
                serialized.span()
            );
    }

    fn get_dungeon_reward(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            1786935704708425205704413196887994553601343753700099780406507342525672213622
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `AttackEvent::dungeon_reward`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_dungeon_reward(self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1786935704708425205704413196887994553601343753700099780406507342525672213622,
                serialized.span()
            );
    }

    fn get_has_defeated_dungeon(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> bool {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            AttackEvent
        >::get_member(
            world,
            serialized.span(),
            822660390160987833625085692681312504283600107546628150648453296634613523547
        );

        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `AttackEvent::has_defeated_dungeon`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_has_defeated_dungeon(
        self: @AttackEvent, world: dojo::world::IWorldDispatcher, value: bool
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                822660390160987833625085692681312504283600107546628150648453296634613523547,
                serialized.span()
            );
    }
}

pub impl AttackEventModelEntityImpl of dojo::model::ModelEntity<AttackEventEntity> {
    fn id(self: @AttackEventEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @AttackEventEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.timestamp, ref serialized);
        core::serde::Serde::serialize(self.player_role, ref serialized);
        core::serde::Serde::serialize(self.player_mode, ref serialized);
        core::serde::Serde::serialize(self.player_health, ref serialized);
        core::serde::Serde::serialize(self.player_gold, ref serialized);
        core::serde::Serde::serialize(self.player_score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.player_name);
        core::serde::Serde::serialize(self.dungeon_monster, ref serialized);
        core::serde::Serde::serialize(self.dungeon_role, ref serialized);
        core::serde::Serde::serialize(self.dungeon_damage, ref serialized);
        core::serde::Serde::serialize(self.dungeon_health, ref serialized);
        core::serde::Serde::serialize(self.dungeon_reward, ref serialized);
        core::serde::Serde::serialize(self.has_defeated_dungeon, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> AttackEventEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<AttackEventEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<AttackEventEntity>::is_none(@entity_values) {
            panic!("ModelEntity `AttackEventEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<AttackEventEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> AttackEventEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<AttackEvent>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<AttackEvent>::layout()
        );
    }

    fn delete(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<AttackEvent>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<AttackEvent>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<AttackEvent>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @AttackEventEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<AttackEvent>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<AttackEvent>::selector(),
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
pub impl AttackEventModelEntityTestImpl of dojo::model::ModelEntityTest<AttackEventEntity> {
    fn update_test(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<AttackEvent>::layout()
        );
    }

    fn delete_test(self: @AttackEventEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<AttackEvent>::layout()
        );
    }
}

pub impl AttackEventModelImpl of dojo::model::Model<AttackEvent> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> AttackEvent {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        AttackEventStore::from_values(ref _keys, ref values)
    }

    fn set(self: @AttackEvent, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @AttackEvent, world: dojo::world::IWorldDispatcher) {
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
        self: @AttackEvent,
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
        "AttackEvent"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "haiku"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "haiku-AttackEvent"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        3501340031944961553054283730942565239263581936513929366522433661036118274780
    }

    #[inline(always)]
    fn instance_selector(self: @AttackEvent) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        2773157712758990375914705653915957198528669657836106806481203130353907319552
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        159371543000137669334859047484239625827089117287201931851163638171079597795
    }

    #[inline(always)]
    fn entity_id(self: @AttackEvent) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @AttackEvent) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.player_id);
        core::serde::Serde::serialize(self.id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @AttackEvent) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.timestamp, ref serialized);
        core::serde::Serde::serialize(self.player_role, ref serialized);
        core::serde::Serde::serialize(self.player_mode, ref serialized);
        core::serde::Serde::serialize(self.player_health, ref serialized);
        core::serde::Serde::serialize(self.player_gold, ref serialized);
        core::serde::Serde::serialize(self.player_score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.player_name);
        core::serde::Serde::serialize(self.dungeon_monster, ref serialized);
        core::serde::Serde::serialize(self.dungeon_role, ref serialized);
        core::serde::Serde::serialize(self.dungeon_damage, ref serialized);
        core::serde::Serde::serialize(self.dungeon_health, ref serialized);
        core::serde::Serde::serialize(self.dungeon_reward, ref serialized);
        core::serde::Serde::serialize(self.has_defeated_dungeon, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<AttackEvent>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @AttackEvent) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl AttackEventModelTestImpl of dojo::model::ModelTest<AttackEvent> {
    fn set_test(self: @AttackEvent, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<AttackEvent>::keys(self)),
            dojo::model::Model::<AttackEvent>::values(self),
            dojo::model::Model::<AttackEvent>::layout()
        );
    }

    fn delete_test(self: @AttackEvent, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<AttackEvent>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<AttackEvent>::keys(self)),
            dojo::model::Model::<AttackEvent>::layout()
        );
    }
}

#[starknet::interface]
pub trait Iattack_event<T> {
    fn ensure_abi(self: @T, model: AttackEvent);
}

#[starknet::contract]
pub mod attack_event {
    use super::AttackEvent;
    use super::Iattack_event;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<AttackEvent>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<AttackEvent>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<AttackEvent>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<AttackEvent>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<AttackEvent>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<AttackEvent>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<AttackEvent>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<AttackEvent>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<AttackEvent>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<AttackEvent>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<AttackEvent>::ty()
        }
    }

    #[abi(embed_v0)]
    impl attack_eventImpl of Iattack_event<ContractState> {
        fn ensure_abi(self: @ContractState, model: AttackEvent) {}
    }
}
