// Internal imports

use rpg::types::role::Role;

trait RoleTrait {
    fn weakness(role: Role) -> Role;
    fn strength(role: Role) -> Role;
}
