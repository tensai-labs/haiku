// Internal imports

use rpg::elements::roles::interface::{Role, RoleTrait};

impl Fire of RoleTrait {
    #[inline]
    fn weakness(role: Role) -> Role {
        Role::Water
    }

    #[inline]
    fn strength(role: Role) -> Role {
        Role::Air
    }
}
