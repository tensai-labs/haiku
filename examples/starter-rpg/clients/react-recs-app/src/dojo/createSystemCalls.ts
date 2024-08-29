import { World } from "@dojoengine/recs";

import { ClientComponents } from "./createClientComponents";
import type { IWorld } from "./typescript/contracts.gen";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  { client }: { client: IWorld },
  {}: ClientComponents,
  world: World
) {
  return {};
}
