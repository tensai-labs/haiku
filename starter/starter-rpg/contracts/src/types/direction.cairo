#[derive(Copy, Drop)]
enum Direction {
    None,
    Left,
    Right,
    Up,
    Down,
}

impl IntoDirectionFelt252 of core::Into<Direction, felt252> {
    #[inline]
    fn into(self: Direction) -> felt252 {
        match self {
            Direction::None => 'NONE',
            Direction::Left => 'LEFT',
            Direction::Right => 'RIGHT',
            Direction::Up => 'UP',
            Direction::Down => 'DOWN',
        }
    }
}

impl IntoDirectionU8 of core::Into<Direction, u8> {
    #[inline]
    fn into(self: Direction) -> u8 {
        match self {
            Direction::None => 0,
            Direction::Left => 1,
            Direction::Right => 2,
            Direction::Up => 3,
            Direction::Down => 4,
        }
    }
}

impl IntoU8Direction of core::Into<u8, Direction> {
    #[inline]
    fn into(self: u8) -> Direction {
        let card: felt252 = self.into();
        match card {
            0 => Direction::None,
            1 => Direction::Left,
            2 => Direction::Right,
            3 => Direction::Up,
            4 => Direction::Down,
            _ => Direction::None,
        }
    }
}

impl DirectionPrint of core::debug::PrintTrait<Direction> {
    #[inline]
    fn print(self: Direction) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
