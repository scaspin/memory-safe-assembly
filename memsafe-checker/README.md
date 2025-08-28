## Symbolic Execution of Assembly for Checking Memory Safety

Multiple test examples of how to use this library without a wrapping macro can be found in [tests](tests/examples.rs).

Note: the computer model is a wip and cannot currently handle the entire Aarch64 ISA.

#### Usage 
1. Configure and initialize a Z3 context:
    ```rust
    use bums;
    use z3::*;

   let cfg = Config::new();
    let ctx = Context::new(&cfg);
    ```
2. Initialize an engine with a program (as Vec<String>) and the context:
```rust
    let start_label = "test".to_string();
    program.push(start_label);
    program.push("add x0,x0,#1".to_string());
    program.push("ret".to_string());
   
    let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);
```

3. Initialize any known machine state, such as register values or memory
```rust
    engine.add_immediate(String::from("x0"), 1);
    engine.add_region(RegionType::READ, "Input".to_string(), 64);
```

4. Run symbolic execution and handle the result
```rust
    let res = engine.start(start_label);
```

#### Contents
- [engine](src/engine.rs) handles symbolic execution, including running instructions, control flow, and loop acceleration
- [computer](src/computer.rs) is a model of an Arm Cortex-A computer which transforms and returns values with an ```execute``` function
- [memory safety checks](src/computer/memory.rs) are handled within the computer logic on loads and stores
- [parser](src/instruction_parser.rs) parses unstructured string inputs into an instruction type
