// Internal imports

use rpg::elements::roles::interface::{Role, RoleTrait};

impl Water of RoleTrait {
    #[inline]
    fn weakness(role: Role) -> Role {
        Role::Earth
    }

    #[inline]
    fn strength(role: Role) -> Role {
        Role::Fire
    }
}
