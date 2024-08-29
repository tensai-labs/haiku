import { useContext } from "react";
import { DojoContext } from "./DojoContext";
import { createWorld } from "@dojoengine/recs";

export const useDojo = () => {
    const world = createWorld();
    const context = useContext(DojoContext);
    if (!context)
        throw new Error(
            "The `useDojo` hook must be used within a `DojoProvider`"
        );

    return {
        world,
        setup: context,
        account: context.account,
    };
};
