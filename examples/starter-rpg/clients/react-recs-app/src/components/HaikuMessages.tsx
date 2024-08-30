import { defineComponentSystem } from "@dojoengine/recs";
import { useEffect, useRef, useState } from "react";
import { useDojo } from "../dojo/useDojo";

export const HaikuMessages = () => {
  const dojo = useDojo();
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const [promptMessages, setPromptMessages] = useState<
    Array<{ message: string; timestamp: Date }>
  >([]);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [promptMessages]);

  useEffect(() => {
    defineComponentSystem(
      dojo.world,
      dojo.setup.contractComponents.PromptMessage,
      (update) => {
        const newMessage = {
          message: update.value[0]?.prompt,
          timestamp: new Date((update.value[0]?.timestamp || 0) * 1000),
        };
        console.log(newMessage);
        setPromptMessages((prevMessages) => {
          const updatedMessages = [...prevMessages, newMessage];
          return updatedMessages.sort(
            (a, b) => b.timestamp.getTime() - a.timestamp.getTime()
          );
        });
      }
    );
  }, []);

  return (
    <div
      className="border-4 border-red-800 rounded-2xl p-7 w-[800px] mx-auto my-5 bg-white"
    >
      <h2
        className="mb-7 pb-4 border-b-2 border-[#B22222] text-[#B22222] text-center text-3xl tracking-wider"
      >
        Haiku Messages 🖌️
      </h2>
      <div
        className="max-h-[200px] overflow-y-auto pr-2.5 flex flex-col-reverse"
      >
        <div ref={messagesEndRef} />
        {promptMessages.map((messageObj, index) => (
          <div
            key={index}
            className="my-2.5 p-4 bg-white bg-opacity-70 border border-[#D2B48C] shadow-md rounded-lg relative"
          >
            <div
              className="whitespace-pre-wrap font-normal text-gray-700 leading-relaxed text-center"
            >
              {messageObj.message}
            </div>
            <div
              className="text-xs text-[#B22222] mt-3 text-right italic"
            >
              {messageObj.timestamp.toLocaleString()}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
