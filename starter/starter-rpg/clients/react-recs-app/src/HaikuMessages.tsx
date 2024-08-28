import { defineComponentSystem } from "@dojoengine/recs";
import { useDojo } from "./dojo/useDojo"
import { useState, useEffect, useRef } from "react";

export const HaikuMessages = () => {
    const dojo = useDojo();
    const messagesEndRef = useRef<HTMLDivElement>(null);

    const [promptMessages, setPromptMessages] = useState<Array<{ message: string, timestamp: string }>>([]);

    useEffect(() => {
        const initialMessage = {
            message: "Welcome to the world of haiku, where brevity meets beauty. In this digital realm, we explore the art of concise expression. Join us on a journey through seasons, emotions, and fleeting moments captured in seventeen syllables. Haiku, an ancient Japanese poetry form, has transcended time and culture to become a global phenomenon. Its simplicity belies its depth, challenging poets to distill complex thoughts into mere words. As you embark on this haiku adventure, let your imagination soar. Observe the world around you with fresh eyes, finding inspiration in the ordinary and extraordinary alike. Each syllable is a brushstroke, painting vivid images in the mind's eye. Embrace the power of pause, the spaces between words, where meaning often resides. Let nature be your muse, as it has been for countless haiku masters before you.",
            timestamp: new Date().toLocaleString()
        };
        setPromptMessages([initialMessage, initialMessage, initialMessage]);
    }, []);

    useEffect(() => {
        messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
    }, [promptMessages]);

    defineComponentSystem(dojo.world, dojo.setup.contractComponents.PromptMessage, ((update) => {
        const newMessage = {
            message: update.value[0]?.prompt,
            timestamp: new Date().toLocaleString()
        };
        setPromptMessages(prevMessages => {
            const updatedMessages = [...prevMessages, newMessage];
            return updatedMessages
                .sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime())
                .slice(0, 5);
        });
    }))
    return (
        <div style={{
            border: '3px solid #B22222', // Deeper red border
            borderRadius: '15px',
            padding: '28px',
            width: '800px',
            margin: '20px auto',
            boxShadow: '6px 6px 12px rgba(0,0,0,0.3)',
            backgroundColor: '#FFF0F5', // Lavender blush background
            fontFamily: '"Noto Serif JP", "Yuji Syuku", serif', // More Japanese-style fonts
            backgroundImage: 'url("data:image/svg+xml,%3Csvg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"%3E%3Cg fill="%23B22222" fill-opacity="0.05"%3E%3Cpath d="M0 0h20L0 20z"/%3E%3C/g%3E%3C/svg%3E")',
            backgroundSize: '20px 20px'
        }}>
            <h2 style={{
                margin: '0 0 28px',
                padding: '0 0 16px',
                borderBottom: '2px solid #B22222',
                color: '#B22222',
                textAlign: 'center',
                fontSize: '1.8em',
                fontWeight: 'normal',
                letterSpacing: '2px'
            }}>俳句メッセージ 🖌️</h2>
            <div style={{
                maxHeight: '200px',
                overflowY: 'auto',
                paddingRight: '10px',
                display: 'flex',
                flexDirection: 'column-reverse'
            }}>
                <div ref={messagesEndRef} />
                {promptMessages.map((messageObj, index) => (
                    <div key={index} style={{
                        margin: '10px 0', // Reduced from 20px to 10px
                        padding: '16px',
                        background: 'rgba(255, 255, 255, 0.7)',
                        border: '1px solid #D2B48C',
                        boxShadow: '3px 3px 6px rgba(0,0,0,0.15)',
                        borderRadius: '10px',
                        position: 'relative'
                    }}>
                        <div style={{
                            whiteSpace: 'pre-wrap',
                            fontStyle: 'normal',
                            color: '#4A4A4A',
                            lineHeight: '1.6',
                            textAlign: 'center'
                        }}>{messageObj.message}</div>
                        <div style={{
                            fontSize: '0.75em',
                            color: '#B22222',
                            marginTop: '12px',
                            textAlign: 'right',
                            fontStyle: 'italic'
                        }}>{messageObj.timestamp}</div>
                    </div>
                ))}
            </div>
        </div>
    )
}