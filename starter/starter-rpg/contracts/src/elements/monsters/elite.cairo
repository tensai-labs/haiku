// Internal imports

use rpg::elements::monsters::interface::MonsterTrait;

// Constants

const DAMAGE: u8 = 15;
const HEALTH: u8 = 30;
const REWARD: u16 = 15;

impl Elite of MonsterTrait {
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
