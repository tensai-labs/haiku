// Internal imports

use rpg::elements::modes::interface::{ModeTrait, Monster, Role};

impl Medium of ModeTrait {
    #[inline]
    fn monster(seed: felt252) -> Monster {
        let luck: u256 = seed.into() % 100;
        if luck < 10 {
            Monster::None
        } else if luck < 20 {
            Monster::Boss
        } else if luck < 45 {
            Monster::Elite
        } else {
            Monster::Common
        }
    }

    #[inline]
    fn role(seed: felt252, player_role: Role) -> Role {
        let luck: u256 = seed.into() % 100;
        if luck < 25 {
            Role::Fire
        } else if luck < 50 {
            Role::Water
        } else if luck < 75 {
            Role::Earth
        } else {
            Role::Air
        }
    }
}
