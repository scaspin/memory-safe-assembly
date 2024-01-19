To run example from file assets/processed-sha256-armv8-ios64.S starting at label _sha256_block_data_order 
just do :

```RUST_LOG=info cargo run```

The memory safety checks are run by instantiating a symbolic execution engine and providing it a file (vector of lines). 
Then, defining any necessary immediate and memory regions.
Memory regions are defined by a type (read or write), a register in which the address for the region in memory is stores, and the offsets from the address.
How the checks were called on the sha256 example can be seen in ```check_sha256_armv8_ios64()``` in main.

