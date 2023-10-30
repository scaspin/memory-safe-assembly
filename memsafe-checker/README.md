To run example:

```RUST_LOG=info cargo run -- assets/processed-sha256-armv8-ios64.S _sha256_block_data_order x0 x1 x2 <input length>```

Need to specify the 
1. file
2. first label to start execution from

This sha-256 program's specific inputs: 
4. context register
5. input register
6. input length register

## TODOs
- [ ] ensure all inputs lenghts are the same
- [ ] re-introduce macros
- [ ] allow flags to be set before program execution, but account for all possible settings
