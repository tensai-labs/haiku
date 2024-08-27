// Core imports

use core::poseidon::{PoseidonTrait, HashState};
use core::hash::HashStateTrait;

// Internal imports

use rpg::constants::{SEED_WEEK_SECONDS, SEED_OFFSET_SECONDS};

#[generate_trait]
impl Seeder of SeederTrait {
    #[inline]
    fn reseed(lhs: felt252, rhs: felt252) -> felt252 {
        let state: HashState = PoseidonTrait::new();
        let state = state.update(lhs);
        let state = state.update(rhs);
        state.finalize()
    }

    #[inline]
    fn compute_id(time: u64) -> u64 {
        (time + SEED_OFFSET_SECONDS) / SEED_WEEK_SECONDS
    }
}
