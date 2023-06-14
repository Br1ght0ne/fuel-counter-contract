contract;
use std::logging::log;
use std::auth::msg_sender;
struct IncrementParams {
    caller: Identity,
    counter: u64,
    timestamp: u64,
}

storage {
    counter: u64 = 0,
}

abi Counter {
    #[storage(read, write)]
    fn increment();

    #[storage(read)]
    fn count() -> u64;
}

impl Counter for Contract {
    #[storage(read)]
    fn count() -> u64 {
        storage.counter
    }

    #[storage(read, write)]
    fn increment() {
        let incremented = storage.counter + 1;
        storage.counter = incremented;
        log(IncrementParams {
            caller: msg_sender().unwrap(),
            counter: incremented,
            timestamp: std::block::timestamp(),
        });
    }
}
