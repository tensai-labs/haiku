import { useCallback, useEffect, useState } from "react";
import "./App.css";
import * as torii from "@dojoengine/torii-client";
import { dojoConfig } from "../dojoConfig";
import { Button } from "./components/ui/button";
import { setupWorld } from "./typescript/contracts.gen";
import { DojoProvider } from "@dojoengine/core";
import { BurnerManager } from "@dojoengine/create-burner";
import { Account } from "starknet";
import { Dungeon, Player } from "./types";

const client = await setupWorld(
  new DojoProvider(dojoConfig.manifest, dojoConfig.rpcUrl)
);

function App() {
  const [toriiClient, setToriiClient] = useState<torii.ToriiClient | null>(
    null
  );

  const [players, setPlayers] = useState<Record<string, Player>>({});
  const [dungeons, setDungeons] = useState<Record<string, Dungeon>>({});

  const setupToriiClient = async () => {
    const client = await torii.createClient({
      rpcUrl: dojoConfig.rpcUrl,
      toriiUrl: dojoConfig.toriiUrl,
      relayUrl: "",
      worldAddress: dojoConfig.manifest.world.address || "",
    });
    setToriiClient(client);
  };

  useEffect(() => {
    setupToriiClient();
  }, []);

  const setupSync = useCallback(async () => {
    try {
      return await toriiClient?.onEntityUpdated(
        [], // Empty array to listen for all entity updates
        (fetchedEntities: any, data: any) => {
          setPlayers((prevPlayers) => {
            const newPlayers = { ...prevPlayers };
            if (data["dojo_starter_rpg-Player"]) {
              const playerData = data["dojo_starter_rpg-Player"];
              const player: Player = {
                damage: Number(playerData.damage.value),
                gold: Number(playerData.gold.value),
                health: Number(playerData.health.value),
                seed: playerData.seed.value,
                name: playerData.name.value,
                id: playerData.id.value,
                score: Number(playerData.score.value),
                mode: Number(playerData.mode.value),
                role: Number(playerData.role.value),
              };
              newPlayers[player.id] = player;
            }
            return newPlayers;
          });

          setDungeons((prevDungeons) => {
            const newDungeons = { ...prevDungeons };
            if (data["dojo_starter_rpg-Dungeon"]) {
              const dungeonData = data["dojo_starter_rpg-Dungeon"];
              const dungeon: Dungeon = {
                reward: Number(dungeonData.reward.value),
                monster: Number(dungeonData.monster.value),
                damage: Number(dungeonData.damage.value),
                health: Number(dungeonData.health.value),
                id: dungeonData.id.value,
                role: Number(dungeonData.role.value),
              };
              newDungeons[dungeon.id] = dungeon;
            }
            return newDungeons;
          });

          console.log("Updated entities:", fetchedEntities);
        }
      );
    } catch (error) {
      throw error;
    }
  }, [toriiClient]);

  const fetchEntities = useCallback(async () => {
    let cursor = 0;

    let entities = await toriiClient?.getAllEntities(100, cursor);

    let hash = torii.poseidonHash([burnerManager.getActiveAccount()!.address]);

    setPlayers((prevPlayers) => {
      const newPlayers = { ...prevPlayers };
      if (
        entities &&
        entities[hash] &&
        entities[hash]["dojo_starter_rpg-Player"]
      ) {
        const playerData = entities[hash]["dojo_starter_rpg-Player"];
        const player: Player = {
          damage: Number(playerData.damage.value),
          gold: Number(playerData.gold.value),
          health: Number(playerData.health.value),
          seed: playerData.seed.value?.toString()!,
          name: playerData.name.value?.toString()!,
          id: playerData.id.value?.toString()!,
          score: Number(playerData.score.value),
          mode: Number(playerData.mode.value),
          role: Number(playerData.role.value),
        };
        newPlayers[player.id] = player;
      }
      return newPlayers;
    });

    setDungeons((prevDungeons) => {
      const newDungeons = { ...prevDungeons };
      if (
        entities &&
        entities[hash] &&
        entities[hash]["dojo_starter_rpg-Dungeon"]
      ) {
        const dungeonData = entities[hash]["dojo_starter_rpg-Dungeon"];
        const dungeon: Dungeon = {
          reward: Number(dungeonData.reward.value),
          monster: Number(dungeonData.monster.value),
          damage: Number(dungeonData.damage.value),
          health: Number(dungeonData.health.value),
          id: dungeonData.id.value?.toString()!,
          role: Number(dungeonData.role.value),
        };
        newDungeons[dungeon.id] = dungeon;
      }
      return newDungeons;
    });
  }, [toriiClient]);

  console.log(players, dungeons);

  useEffect(() => {
    let unsubscribe: torii.Subscription | undefined;

    fetchEntities();

    setupSync()
      .then((sync) => {
        unsubscribe = sync;
      })
      .catch((error) => {
        console.error("Error setting up entity sync:", error);
      });

    return () => {
      if (unsubscribe) {
        unsubscribe.cancel();
        console.log("Sync unsubscribed");
      }
    };
  }, [setupSync]);

  const dojoProvider = new DojoProvider(dojoConfig.manifest, dojoConfig.rpcUrl);

  const [burnerManager] = useState(
    () =>
      new BurnerManager({
        masterAccount: new Account(
          {
            nodeUrl: dojoConfig.rpcUrl,
          },
          dojoConfig.masterAddress,
          dojoConfig.masterPrivateKey
        ),
        accountClassHash: dojoConfig.accountClassHash,
        rpcProvider: dojoProvider.provider,
        feeTokenAddress: dojoConfig.feeTokenAddress,
      })
  );

  const initializeBurnerManager = async () => {
    try {
      await burnerManager.init();
      if (burnerManager.list().length === 0) {
        await burnerManager.create();
      }
    } catch (e) {
      console.error(e);
    }
  };

  useEffect(() => {
    initializeBurnerManager();
  }, []);

  return (
    <>
      <div className="bg-black text-green-600 h-screen w-screen p-10">
        <h4>RPG Starter</h4>
        <div className="mb-1">
          <Button
            onClick={async () => {
              await client.actions.spawn({
                account: burnerManager.getActiveAccount()!,
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
            onClick={async () => {
              await client.actions.move({
                account: burnerManager.getActiveAccount()!,
                direction: 1, // North
              });
            }}
            variant={"outline"}
          >
            North
          </Button>
          <Button
            onClick={async () => {
              await client.actions.move({
                account: burnerManager.getActiveAccount()!,
                direction: 2, // South
              });
            }}
            variant={"outline"}
          >
            South
          </Button>
          <Button
            onClick={async () => {
              await client.actions.move({
                account: burnerManager.getActiveAccount()!,
                direction: 3, // East
              });
            }}
            variant={"outline"}
          >
            East
          </Button>
          <Button
            onClick={async () => {
              await client.actions.move({
                account: burnerManager.getActiveAccount()!,
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
                account: burnerManager.getActiveAccount()!,
                quantity: 1,
              });
            }}
            variant={"secondary"}
          >
            Heal
          </Button>
          <Button
            onClick={async () => {
              await client.actions.attack({
                account: burnerManager.getActiveAccount()!,
              });
            }}
            variant={"destructive"}
          >
            Attack
          </Button>
        </div>

        <h4>Players:</h4>
        <ul>
          {Object.values(players).map((player) => (
            <li key={player.id}>
              Name: {torii.parseCairoShortString(player.name)}, <br />
              Health: {player.health}, <br />
              Gold: {player.gold}
            </li>
          ))}
        </ul>

        <h4>Dungeons:</h4>
        <ul>
          {Object.values(dungeons).map((dungeon) => (
            <li key={dungeon.id}>
              ID: {dungeon.id}, <br /> Monster: {dungeon.monster}, <br />
              Health: {dungeon.health}
            </li>
          ))}
        </ul>
      </div>
    </>
  );
}

export default App;
