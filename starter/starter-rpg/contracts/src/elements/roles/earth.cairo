// Internal imports

use rpg::elements::roles::interface::{Role, RoleTrait};

impl Earth of RoleTrait {
    #[inline]
    fn weakness(role: Role) -> Role {
        Role::Air
    }

    #[inline]
    fn strength(role: Role) -> Role {
        Role::Water
    }
}
