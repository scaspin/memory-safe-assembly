Multiple examples can be verified using tests:

```cargo test```

and with logging at:

```RUST_LOG=info cargo test -- --nocapture```

An assembly file is checked by instantiating a symbolic execution engine from ```engine```, then adding the appropriate memory regions if needed, and then starting execution by providing the label of the function.
Examples checked (and in tests):
    * sha256 arm v8 from boringssl