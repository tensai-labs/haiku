impl MoveEventIntrospect<> of dojo::model::introspect::Introspect<MoveEvent<>> {
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
                    selector: 614499057413201613508653200066187686724488589622048075426255068221310241069,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
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
                    selector: 1551846197519272756546519329074811207847715575420268253206374961866723898762,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1702906591677597098860823999110556139803868470446447856191673399366143357904,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1630232315719212297968735033388834937783128990663981669716038090606943745415,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 161616720542070567180764314147814754610380526883028639917160462909662827074,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 316566200069724306612527564346095640157090874177011494660960996104903124176,
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
                name: 'MoveEvent',
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
                        name: 'direction',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
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
                        name: 'new_dungeon_monster',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'new_dungeon_role',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'new_dungeon_damage',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'new_dungeon_health',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'new_dungeon_reward',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}
impl MoveEventIsEvent of starknet::Event<MoveEvent> {
    fn append_keys_and_data(self: @MoveEvent, ref keys: Array<felt252>, ref data: Array<felt252>) {
        core::array::ArrayTrait::append(ref keys, dojo::model::Model::<MoveEvent>::selector());

        core::serde::Serde::serialize(self.player_id, ref keys);
        core::serde::Serde::serialize(self.id, ref keys);
        core::serde::Serde::serialize(self.timestamp, ref data);
        core::serde::Serde::serialize(self.direction, ref data);
        core::serde::Serde::serialize(self.player_role, ref data);
        core::serde::Serde::serialize(self.player_mode, ref data);
        core::serde::Serde::serialize(self.player_health, ref data);
        core::serde::Serde::serialize(self.player_gold, ref data);
        core::serde::Serde::serialize(self.player_score, ref data);
        core::serde::Serde::serialize(self.player_name, ref data);
        core::serde::Serde::serialize(self.new_dungeon_monster, ref data);
        core::serde::Serde::serialize(self.new_dungeon_role, ref data);
        core::serde::Serde::serialize(self.new_dungeon_damage, ref data);
        core::serde::Serde::serialize(self.new_dungeon_health, ref data);
        core::serde::Serde::serialize(self.new_dungeon_reward, ref data);
    }
    fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>,) -> Option<MoveEvent> {
        let player_id = core::serde::Serde::deserialize(ref keys)?;
        let id = core::serde::Serde::deserialize(ref keys)?;
        let timestamp = core::serde::Serde::deserialize(ref data)?;
        let direction = core::serde::Serde::deserialize(ref data)?;
        let player_role = core::serde::Serde::deserialize(ref data)?;
        let player_mode = core::serde::Serde::deserialize(ref data)?;
        let player_health = core::serde::Serde::deserialize(ref data)?;
        let player_gold = core::serde::Serde::deserialize(ref data)?;
        let player_score = core::serde::Serde::deserialize(ref data)?;
        let player_name = core::serde::Serde::deserialize(ref data)?;
        let new_dungeon_monster = core::serde::Serde::deserialize(ref data)?;
        let new_dungeon_role = core::serde::Serde::deserialize(ref data)?;
        let new_dungeon_damage = core::serde::Serde::deserialize(ref data)?;
        let new_dungeon_health = core::serde::Serde::deserialize(ref data)?;
        let new_dungeon_reward = core::serde::Serde::deserialize(ref data)?;
        Option::Some(
            MoveEvent {
                player_id,
                id,
                timestamp,
                direction,
                player_role,
                player_mode,
                player_health,
                player_gold,
                player_score,
                player_name,
                new_dungeon_monster,
                new_dungeon_role,
                new_dungeon_damage,
                new_dungeon_health,
                new_dungeon_reward,
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct MoveEventEntity {
    __id: felt252, // private field
    pub timestamp: u64,
    pub direction: u8,
    pub player_role: u8,
    pub player_mode: u8,
    pub player_health: u8,
    pub player_gold: u16,
    pub player_score: u16,
    pub player_name: felt252,
    pub new_dungeon_monster: u8,
    pub new_dungeon_role: u8,
    pub new_dungeon_damage: u8,
    pub new_dungeon_health: u8,
    pub new_dungeon_reward: u16,
}

#[generate_trait]
pub impl MoveEventEntityStoreImpl of MoveEventEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> MoveEventEntity {
        MoveEventModelEntityImpl::get(world, entity_id)
    }


    fn get_timestamp(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `MoveEvent::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1242883636335185042648196101482844477055185136100498177742807244790485718414,
                serialized.span()
            );
    }

    fn get_direction(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            614499057413201613508653200066187686724488589622048075426255068221310241069
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::direction`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_direction(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                614499057413201613508653200066187686724488589622048075426255068221310241069,
                serialized.span()
            );
    }

    fn get_player_role(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            347952960679533249680446863069020167712085033312394040450504241252785680954
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_role(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            1204596313654674981356182785415911392848086107280570558172944394753040003335
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_mode(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            1672877539965766581367585409312665003174591496233478840813315666552568462009
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_health(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8) {
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
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            2042338183989951520926109953808378237802007966626911652903184058220987592
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_gold(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u16) {
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
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            75817691318734259820488298239604529221191294248969653688595679603338157534
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_score(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u16) {
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
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            651389263438509168837490815910930013740248828429395191830431531885294035507
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_player_name(
        self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: felt252
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

    fn get_new_dungeon_monster(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            1551846197519272756546519329074811207847715575420268253206374961866723898762
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_monster`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_monster(
        self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1551846197519272756546519329074811207847715575420268253206374961866723898762,
                serialized.span()
            );
    }

    fn get_new_dungeon_role(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            1702906591677597098860823999110556139803868470446447856191673399366143357904
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_role(
        self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1702906591677597098860823999110556139803868470446447856191673399366143357904,
                serialized.span()
            );
    }

    fn get_new_dungeon_damage(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            1630232315719212297968735033388834937783128990663981669716038090606943745415
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_damage(
        self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1630232315719212297968735033388834937783128990663981669716038090606943745415,
                serialized.span()
            );
    }

    fn get_new_dungeon_health(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            161616720542070567180764314147814754610380526883028639917160462909662827074
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_health(
        self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u8
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                161616720542070567180764314147814754610380526883028639917160462909662827074,
                serialized.span()
            );
    }

    fn get_new_dungeon_reward(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            MoveEventEntity
        >::get_member(
            world,
            entity_id,
            316566200069724306612527564346095640157090874177011494660960996104903124176
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_reward`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_new_dungeon_reward(
        self: @MoveEventEntity, world: dojo::world::IWorldDispatcher, value: u16
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                316566200069724306612527564346095640157090874177011494660960996104903124176,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl MoveEventStoreImpl of MoveEventStore {
    fn entity_id_from_keys(player_id: felt252, id: u32) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> MoveEvent {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<MoveEvent>::deserialize(ref serialized);

        if core::option::OptionTrait::<MoveEvent>::is_none(@entity) {
            panic!(
                "Model `MoveEvent`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<MoveEvent>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> MoveEvent {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        dojo::model::Model::<MoveEvent>::get(world, serialized.span())
    }


    fn get_timestamp(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `MoveEvent::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1242883636335185042648196101482844477055185136100498177742807244790485718414,
                serialized.span()
            );
    }

    fn get_direction(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            614499057413201613508653200066187686724488589622048075426255068221310241069
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::direction`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_direction(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                614499057413201613508653200066187686724488589622048075426255068221310241069,
                serialized.span()
            );
    }

    fn get_player_role(world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            347952960679533249680446863069020167712085033312394040450504241252785680954
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_role(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
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
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            1204596313654674981356182785415911392848086107280570558172944394753040003335
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_mode`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_mode(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
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
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            1672877539965766581367585409312665003174591496233478840813315666552568462009
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_player_health(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
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
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            2042338183989951520926109953808378237802007966626911652903184058220987592
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_gold`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_gold(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u16) {
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
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            75817691318734259820488298239604529221191294248969653688595679603338157534
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_score`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_player_score(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u16) {
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
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            651389263438509168837490815910930013740248828429395191830431531885294035507
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `MoveEvent::player_name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_player_name(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                651389263438509168837490815910930013740248828429395191830431531885294035507,
                serialized.span()
            );
    }

    fn get_new_dungeon_monster(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            1551846197519272756546519329074811207847715575420268253206374961866723898762
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_monster`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_monster(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1551846197519272756546519329074811207847715575420268253206374961866723898762,
                serialized.span()
            );
    }

    fn get_new_dungeon_role(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            1702906591677597098860823999110556139803868470446447856191673399366143357904
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_role`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_role(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1702906591677597098860823999110556139803868470446447856191673399366143357904,
                serialized.span()
            );
    }

    fn get_new_dungeon_damage(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            1630232315719212297968735033388834937783128990663981669716038090606943745415
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_damage`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_damage(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1630232315719212297968735033388834937783128990663981669716038090606943745415,
                serialized.span()
            );
    }

    fn get_new_dungeon_health(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            161616720542070567180764314147814754610380526883028639917160462909662827074
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_health`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_new_dungeon_health(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                161616720542070567180764314147814754610380526883028639917160462909662827074,
                serialized.span()
            );
    }

    fn get_new_dungeon_reward(
        world: dojo::world::IWorldDispatcher, player_id: felt252, id: u32
    ) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, player_id);
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            MoveEvent
        >::get_member(
            world,
            serialized.span(),
            316566200069724306612527564346095640157090874177011494660960996104903124176
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `MoveEvent::new_dungeon_reward`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_new_dungeon_reward(self: @MoveEvent, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                316566200069724306612527564346095640157090874177011494660960996104903124176,
                serialized.span()
            );
    }
}

pub impl MoveEventModelEntityImpl of dojo::model::ModelEntity<MoveEventEntity> {
    fn id(self: @MoveEventEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @MoveEventEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.timestamp, ref serialized);
        core::serde::Serde::serialize(self.direction, ref serialized);
        core::serde::Serde::serialize(self.player_role, ref serialized);
        core::serde::Serde::serialize(self.player_mode, ref serialized);
        core::serde::Serde::serialize(self.player_health, ref serialized);
        core::serde::Serde::serialize(self.player_gold, ref serialized);
        core::serde::Serde::serialize(self.player_score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.player_name);
        core::serde::Serde::serialize(self.new_dungeon_monster, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_role, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_damage, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_health, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_reward, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> MoveEventEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<MoveEventEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<MoveEventEntity>::is_none(@entity_values) {
            panic!("ModelEntity `MoveEventEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<MoveEventEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> MoveEventEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<MoveEvent>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<MoveEvent>::layout()
        );
    }

    fn delete(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<MoveEvent>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<MoveEvent>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<MoveEvent>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @MoveEventEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<MoveEvent>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<MoveEvent>::selector(),
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
pub impl MoveEventModelEntityTestImpl of dojo::model::ModelEntityTest<MoveEventEntity> {
    fn update_test(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<MoveEvent>::layout()
        );
    }

    fn delete_test(self: @MoveEventEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<MoveEvent>::layout()
        );
    }
}

pub impl MoveEventModelImpl of dojo::model::Model<MoveEvent> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> MoveEvent {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        MoveEventStore::from_values(ref _keys, ref values)
    }

    fn set(self: @MoveEvent, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @MoveEvent, world: dojo::world::IWorldDispatcher) {
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
        self: @MoveEvent,
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
        "MoveEvent"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "haiku"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "haiku-MoveEvent"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        2377442064743844227426786033268826958926464326282723435697743234658280327987
    }

    #[inline(always)]
    fn instance_selector(self: @MoveEvent) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        2048099423655516866325128889848950072024096593995917760108287606221251100708
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        159371543000137669334859047484239625827089117287201931851163638171079597795
    }

    #[inline(always)]
    fn entity_id(self: @MoveEvent) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @MoveEvent) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.player_id);
        core::serde::Serde::serialize(self.id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @MoveEvent) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.timestamp, ref serialized);
        core::serde::Serde::serialize(self.direction, ref serialized);
        core::serde::Serde::serialize(self.player_role, ref serialized);
        core::serde::Serde::serialize(self.player_mode, ref serialized);
        core::serde::Serde::serialize(self.player_health, ref serialized);
        core::serde::Serde::serialize(self.player_gold, ref serialized);
        core::serde::Serde::serialize(self.player_score, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.player_name);
        core::serde::Serde::serialize(self.new_dungeon_monster, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_role, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_damage, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_health, ref serialized);
        core::serde::Serde::serialize(self.new_dungeon_reward, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<MoveEvent>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @MoveEvent) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl MoveEventModelTestImpl of dojo::model::ModelTest<MoveEvent> {
    fn set_test(self: @MoveEvent, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<MoveEvent>::keys(self)),
            dojo::model::Model::<MoveEvent>::values(self),
            dojo::model::Model::<MoveEvent>::layout()
        );
    }

    fn delete_test(self: @MoveEvent, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<MoveEvent>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<MoveEvent>::keys(self)),
            dojo::model::Model::<MoveEvent>::layout()
        );
    }
}

#[starknet::interface]
pub trait Imove_event<T> {
    fn ensure_abi(self: @T, model: MoveEvent);
}

#[starknet::contract]
pub mod move_event {
    use super::MoveEvent;
    use super::Imove_event;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<MoveEvent>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<MoveEvent>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<MoveEvent>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<MoveEvent>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<MoveEvent>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<MoveEvent>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<MoveEvent>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<MoveEvent>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<MoveEvent>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<MoveEvent>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<MoveEvent>::ty()
        }
    }

    #[abi(embed_v0)]
    impl move_eventImpl of Imove_event<ContractState> {
        fn ensure_abi(self: @ContractState, model: MoveEvent) {}
    }
}
