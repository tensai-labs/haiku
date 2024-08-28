// Core imports

use core::debug::PrintTrait;
use core::poseidon::{PoseidonTrait, HashState};
use core::hash::HashStateTrait;

// Inernal imports

use rpg::constants;
use rpg::models::index::Dungeon;
use rpg::types::mode::{Mode, ModeTrait};
use rpg::types::role::{Role, RoleTrait};
use rpg::types::monster::{Monster, MonsterTrait};

mod errors {
    const DUNGEON_NOT_DONE: felt252 = 'Dungeon: not done';
    const DUNGEON_ALREADY_DONE: felt252 = 'Dungeon: already done';
    const DUNGEON_NOT_SHOP: felt252 = 'Dungeon: not shop';
}

#[generate_trait]
impl DungeonImpl of DungeonTrait {
    #[inline]
    fn new(id: felt252, monster: Monster, role: Role) -> Dungeon {
        Dungeon {
            id,
            monster: monster.into(),
            role: role.into(),
            damage: monster.damage(),
            health: monster.health(),
            reward: monster.reward(),
        }
    }

    #[inline]
    fn is_done(self: Dungeon) -> bool {
        self.monster == Monster::None.into() || self.health == 0
    }

    #[inline]
    fn take_damage(ref self: Dungeon, player_role: Role, damage: u8) {
        let monster_role: Role = self.role.into();
        let received_damage = monster_role.received_damage(player_role, damage);
        self.health -= core::cmp::min(self.health, received_damage);
    }

    #[inline]
    fn get_treasury(self: Dungeon) -> u16 {
        let monster: Monster = self.monster.into();
        monster.reward()
    }
}

#[generate_trait]
impl DungeonAssert of AssertTrait {
    #[inline]
    fn assert_is_done(self: Dungeon) {
        assert(self.is_done(), errors::DUNGEON_NOT_DONE);
    }

    #[inline]
    fn assert_not_done(self: Dungeon) {
        assert(!self.is_done(), errors::DUNGEON_ALREADY_DONE);
    }

    #[inline]
    fn assert_is_shop(self: Dungeon) {
        assert(self.monster == Monster::None.into(), errors::DUNGEON_NOT_SHOP);
    }
}

#[cfg(test)]
mod tests {
    // Local imports

    use super::{
        Dungeon, DungeonTrait, AssertTrait, Role, RoleTrait, Monster, MonsterTrait, Mode, ModeTrait
    };

    // Constants

    const ID: felt252 = 'ID';
    const MONSTER: Monster = Monster::Common;
    const ROLE: Role = Role::Fire;

    #[test]
    fn test_dungeon_new() {
        let dungeon: Dungeon = DungeonTrait::new(ID, MONSTER, ROLE);
        assert_eq!(dungeon.id, ID);
        assert_eq!(dungeon.monster, MONSTER.into());
        assert_eq!(dungeon.role, ROLE.into());
        assert_eq!(dungeon.damage, MONSTER.damage());
        assert_eq!(dungeon.health, MONSTER.health());
        assert_eq!(dungeon.reward, MONSTER.reward());
    }

    #[test]
    fn test_dungeon_is_done() {
        let dungeon: Dungeon = DungeonTrait::new(ID, Monster::None, Role::None);
        assert!(dungeon.is_done());
        let mut dungeon: Dungeon = DungeonTrait::new(ID, MONSTER, ROLE);
        assert!(!dungeon.is_done());
        dungeon.take_damage(Role::Water, dungeon.health);
        assert!(dungeon.is_done());
    }

    #[test]
    fn test_dungeon_take_damage() {
        let mut dungeon: Dungeon = DungeonTrait::new(ID, MONSTER, ROLE);
        let damage: u8 = 10;
        let player_role: Role = Role::Water;
        dungeon.take_damage(player_role, damage);
        assert_eq!(dungeon.health < MONSTER.health(), true);
    }
}

