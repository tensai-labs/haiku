// Core imports

use core::debug::PrintTrait;

// Inernal imports

use rpg::constants::{
    DEFAULT_POTION_HEAL, MAX_PLAYER_HEALTH, DEFAULT_POTION_COST, DEFAULT_PLAYER_DAMAGE,
    DEFAULT_PLAYER_HEALTH, DEFAULT_PLAYER_GOLD
};
use rpg::models::index::Player;
use rpg::types::role::{Role, RoleTrait};
use rpg::types::direction::Direction;
use rpg::types::mode::{Mode, ModeTrait};
use rpg::types::monster::{Monster, MonsterTrait};
use rpg::helpers::seeder::Seeder;

mod errors {
    const PLAYER_NOT_EXIST: felt252 = 'Player: does not exist';
    const PLAYER_ALREADY_EXIST: felt252 = 'Player: already exist';
    const PLAYER_INVALID_NAME: felt252 = 'Player: invalid name';
    const PLAYER_INVALID_CLASS: felt252 = 'Player: invalid role';
    const PLAYER_INVALID_DIRECTION: felt252 = 'Player: invalid direction';
    const PLAYER_NOT_ENOUGH_GOLD: felt252 = 'Player: not enough gold';
    const PLAYER_IS_DEAD: felt252 = 'Player: is dead';
}

#[generate_trait]
impl PlayerImpl of PlayerTrait {
    #[inline]
    fn new(id: felt252, name: felt252, time: u64, mode: Mode) -> Player {
        // [Check] Name is valid
        assert(name != 0, errors::PLAYER_INVALID_NAME);
        // [Compute] Weekly seed according to the timestamp and the mode
        let seed_id: felt252 = Seeder::compute_id(time).into();
        let seed = Seeder::reseed(seed_id, mode.into());
        // [Return] Player
        Player {
            id,
            mode: mode.into(),
            role: Role::None.into(),
            damage: DEFAULT_PLAYER_DAMAGE,
            health: DEFAULT_PLAYER_HEALTH,
            gold: DEFAULT_PLAYER_GOLD,
            score: 0,
            seed,
            name
        }
    }

    #[inline]
    fn enrole(ref self: Player, role: Role) {
        // [Check] Role is valid
        let role_id: u8 = role.into();
        assert(role_id != Role::None.into(), errors::PLAYER_INVALID_CLASS);
        // [Effect] Change the role
        self.role = role_id;
        // [Effect] Reseed
        self.seed = Seeder::reseed(self.seed, role_id.into());
    }

    #[inline]
    fn move(ref self: Player, direction: Direction) -> (Monster, Role) {
        // [Check] Direction is valid
        let direction_id: u8 = direction.into();
        assert(direction_id != Direction::None.into(), errors::PLAYER_INVALID_DIRECTION);
        // [Effect] For the first move, spawn a specific monster and a role
        if self.score == 0 {
            let role: Role = self.role.into();
            return (Monster::Common, role.strength());
        }
        // [Effect] Spawn monster and role
        let seed: u256 = self.seed.into();
        let mode: Mode = self.mode.into();
        let monster: Monster = mode.monster(seed.low.into());
        let role: Role = mode.role(seed.high.into(), self.role.into());
        // [Effect] Reseed
        self.seed = Seeder::reseed(self.seed, direction_id.into());
        // [Return] Monster and role
        (monster, role)
    }

    #[inline]
    fn take_damage(ref self: Player, monster_role: Role, damage: u8) {
        let player_role: Role = self.role.into();
        let received_damage = player_role.received_damage(monster_role, damage);
        self.health -= core::cmp::min(self.health, received_damage);
    }

    #[inline]
    fn reward(ref self: Player, gold: u16) {
        self.gold += gold;
        self.score += 1;
    }

    #[inline]
    fn heal(ref self: Player, quantity: u8) {
        // [Check] Affordable
        let cost: u16 = quantity.into() * DEFAULT_POTION_COST;
        self.assert_is_affordable(cost);
        // [Effect] Remove gold
        self.gold -= cost;
        // [Effect] Restore health
        self.health += core::cmp::min(DEFAULT_POTION_HEAL, MAX_PLAYER_HEALTH - DEFAULT_POTION_HEAL);
    }
}

#[generate_trait]
impl PlayerAssert of AssertTrait {
    #[inline]
    fn assert_exists(self: Player) {
        assert(0 != self.name, errors::PLAYER_NOT_EXIST);
    }

    #[inline]
    fn assert_not_exists(self: Player) {
        assert(0 == self.name, errors::PLAYER_ALREADY_EXIST);
    }

    #[inline]
    fn assert_not_dead(self: Player) {
        assert(self.health != 0, errors::PLAYER_IS_DEAD);
    }

    #[inline]
    fn assert_is_affordable(self: Player, cost: u16) {
        assert(self.gold >= cost, errors::PLAYER_NOT_ENOUGH_GOLD);
    }
}

#[cfg(test)]
mod tests {
    // Local imports

    use super::{
        Player, PlayerTrait, Role, Mode, ModeTrait, Direction, Monster, MonsterTrait,
        DEFAULT_PLAYER_DAMAGE, DEFAULT_PLAYER_HEALTH, DEFAULT_PLAYER_GOLD, DEFAULT_POTION_COST,
        DEFAULT_POTION_HEAL
    };

    // Constants

    const ID: felt252 = 'ID';
    const PLAYER_NAME: felt252 = 'Alice';
    const TIME: u64 = 0;
    const MODE: Mode = Mode::Easy;

    #[test]
    fn test_player_new() {
        let player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
        assert_eq!(player.id, ID);
        assert_eq!(player.name, PLAYER_NAME);
        assert_eq!(player.mode, MODE.into());
        assert_eq!(player.role, Role::None.into());
        assert_eq!(player.damage, DEFAULT_PLAYER_DAMAGE);
        assert_eq!(player.health, DEFAULT_PLAYER_HEALTH);
        assert_eq!(player.gold, DEFAULT_PLAYER_GOLD);
        assert_eq!(player.score, 0);
    }

    #[test]
    fn test_player_enrole() {
        let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
        player.enrole(Role::Fire);
        assert_eq!(player.role, Role::Fire.into());
    }

    #[test]
    fn test_player_move() {
        let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
        let seed = player.seed;
        player.move(Direction::Up);
        assert_eq!(seed, player.seed);
    }

    #[test]
    fn test_player_take_damage() {
        let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
        player.take_damage(Role::Fire, 10);
        assert_eq!(player.health < DEFAULT_PLAYER_HEALTH, true);
    }

    #[test]
    fn test_player_reward() {
        let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
        player.reward(10);
        assert_eq!(player.gold, DEFAULT_PLAYER_GOLD + 10);
        assert_eq!(player.score, 1);
    }

    #[test]
    fn test_player_heal() {
        let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
        player.gold = DEFAULT_POTION_COST;
        player.heal(1);
        assert_eq!(player.gold, 0);
        assert_eq!(player.health, DEFAULT_PLAYER_HEALTH + DEFAULT_POTION_HEAL);
    }
}

