Verifying multiple examples can be run using tests:

```cargo test```

and with logging at:

```RUST_LOG=info cargo test -- --nocapture```

An assembly file is checked by instantiating a symbolic execution engine from library [engine](src/engine.rs), then adding the appropriate memory regions if needed, and then starting execution by providing the label of the function.

Example cases are shown in [tests](tests/cli.rs) and the original assembly files are [provided](tests/asm-examples) for the following:
* sha256 arm v8 from boringssl
