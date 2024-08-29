// Internal imports

use rpg::elements::monsters::interface::MonsterTrait;

// Constants

const DAMAGE: u8 = 10;
const HEALTH: u8 = 20;
const REWARD: u16 = 10;

impl Common of MonsterTrait {
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
