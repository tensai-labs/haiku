use starknet::ContractAddress;

#[derive(Drop, Serde)]
#[dojo::model(namespace: "haiku", nomapping: true)]
struct PromptMessage {
    #[key]
    identity: ContractAddress,
    #[key]
    event_id: u32,
    event_tag: ByteArray,
    prompt: ByteArray,
    timestamp: u64
}
