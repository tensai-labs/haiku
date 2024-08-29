// Internal imports

use rpg::types::monster::Monster;
use rpg::types::role::{Role, RoleTrait};

trait ModeTrait {
    fn monster(seed: felt252) -> Monster;
    fn role(seed: felt252, player_role: Role) -> Role;
}
