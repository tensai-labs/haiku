export interface Player {
  damage: number;
  gold: number;
  health: number;
  seed: string;
  name: string;
  id: string;
  score: number;
  mode: number;
  role: number;
}

// Define the Dungeon interface
export interface Dungeon {
  reward: number;
  monster: number;
  damage: number;
  health: number;
  id: string;
  role: number;
}
