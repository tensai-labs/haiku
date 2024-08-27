// Internal imports

use rpg::elements::monsters::interface::MonsterTrait;

// Constants

const DAMAGE: u8 = 25;
const HEALTH: u8 = 50;
const REWARD: u16 = 35;

impl Boss of MonsterTrait {
    #[inline]
    fn damage() -> u8 {
        DAMAGE
    }

    #[inline]
    fn health() -> u8 {
        HEALTH
    }

    #[inline]
    fn reward() -> u16 {
        REWARD
    }
}
