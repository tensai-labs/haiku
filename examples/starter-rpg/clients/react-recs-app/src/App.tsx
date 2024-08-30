import "./App.css";
import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useDojo } from "./dojo/useDojo";
import { Button } from "./components/ui/button";
import * as torii from "@dojoengine/torii-client";
import { HaikuMessages } from "./components/HaikuMessages";

function App() {
  const {
    setup: {
      clientComponents: { Dungeon, Player },
      client,
    },
    account: { account },
  } = useDojo();

  // entity id we are syncing
  const entityId = getEntityIdFromKeys([BigInt(account.address)]) as Entity;

  const player = useComponentValue(Player, entityId);
  const dungeon = useComponentValue(Dungeon, entityId);

  console.log("dungeon", dungeon);
  console.log("player", player);

  return (
    <>
      <div className="bg-black text-green-600 h-screen w-screen p-10 relative">
        <h4>RPG Starter</h4>
        <div className="mb-1">
          <Button
            onClick={async () => {
              await client.actions.spawn({
                account,
                name: BigInt(torii.cairoShortStringToFelt("Loaf")),
                role: 1,
              });
            }}
            variant={"default"}
          >
            Spawn
          </Button>
        </div>

        <div className="grid grid-cols-2 gap-1">
          <Button
            disabled={dungeon && dungeon?.health !== 0}
            onClick={async () => {
              await client.actions.move({
                account,
                direction: 1, // North
              });
            }}
            variant={"outline"}
          >
            North
          </Button>
          <Button
            disabled={dungeon && dungeon?.health !== 0}
            onClick={async () => {
              await client.actions.move({
                account,
                direction: 2, // South
              });
            }}
            variant={"outline"}
          >
            South
          </Button>
          <Button
            disabled={dungeon && dungeon?.health !== 0}
            onClick={async () => {
              await client.actions.move({
                account,
                direction: 3, // East
              });
            }}
            variant={"outline"}
          >
            East
          </Button>
          <Button
            disabled={dungeon && dungeon?.health !== 0}
            onClick={async () => {
              await client.actions.move({
                account,
                direction: 4, // West
              });
            }}
            variant={"outline"}
          >
            West
          </Button>
        </div>

        <div className="my-1">
          {" "}
          <Button
            onClick={async () => {
              await client.actions.heal({
                account,
                quantity: 1,
              });
            }}
            variant={"secondary"}
          >
            Heal
          </Button>
          {dungeon?.health !== 0 && (
            <Button
              onClick={async () => {
                await client.actions.attack({
                  account,
                });
              }}
              variant={"destructive"}
            >
              Attack
            </Button>
          )}
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="p-4 rounded border">
            <h3 className="text-xl">Player</h3>
            <div>
              {torii.parseCairoShortString(player?.name.toString() || "0")}
            </div>
            <div>HP: {player?.health.toString()}</div>
            <div>Gold: {player?.gold.toString()}</div>
            <div>Score: {player?.score.toString()}</div>
          </div>
          <div className="p-4 rounded border">
            <h3 className="text-xl">Dungeon</h3>

            <div>Monster: {dungeon?.monster}</div>
            <div>Health: {dungeon?.health}</div>
            <div>Role: {dungeon?.role}</div>
          </div>
        </div>
        <div className="absolute bottom-0 left-0 p-4" id="haiku-messages-container">
          <HaikuMessages />
        </div>
      </div>
    </>
  );
}

export default App;
