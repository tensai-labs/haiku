// Internal imports

use rpg::elements::roles::interface::{Role, RoleTrait};

impl Air of RoleTrait {
    #[inline]
    fn weakness(role: Role) -> Role {
        Role::Fire
    }

    #[inline]
    fn strength(role: Role) -> Role {
        Role::Earth
    }
}
