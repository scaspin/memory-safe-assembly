## Symbolic Execution of Assembly for Checking Memory Safety

Multiple test examples of how to use this library without a wrapping macro can be found in [tests](tests/examples.rs).

Note: the computer models are a wip and cover neither the entire AArch64 ISA nor the entire x86-64 ISA.

#### Instruction sets
The engine is shared; each instruction set supplies a parser and a machine model behind the
[`Machine`](src/machine.rs) trait, and gets an `ExecutionEngine` with the same methods:

| | AArch64 | x86-64 |
|---|---|---|
| engine | `bums::engine::ExecutionEngine` | `bums::x86::engine::ExecutionEngine` |
| syntax | GNU (`add x0, x1, #4`) | AT&T (`addq $4, %rdi`), as perlasm, compilers and `llvm-objdump` emit it |
| arguments (`add_abstract_from(i, ..)`) | x0-x7, then the stack | rdi, rsi, rdx, rcx, r8, r9, then 8(%rsp), 16(%rsp), ... |
| model | [computer](src/computer.rs) | [x86/computer](src/x86/computer.rs) |

`bums::engine::AnyEngine::new(lines)` picks the model from the assembly itself (AT&T marks
registers with `%`), which is what `check_mem_safe` uses, so annotations look the same for both.

The x86-64 model covers the general purpose instructions (with 8/16/32-bit sub-registers and
their zero- and merge-extension), flags for `cmp`/`test`/arithmetic and every condition code,
`push`/`pop`/`call`/`ret` against a modelled stack (a `ret` through an overwritten return
address is an error), `rep` string operations, `cmov`/`setcc`/`adc`/`sbb`, and SSE/AVX/AVX-512
instructions generically: their memory operands are checked at the width they move, and
whole-register moves keep a pointer parked in an xmm register. Instructions perlasm hand-encodes
as `.byte` are decoded (`movq` to and from xmm, `rdrand`, `movbe`, `mulx`, SSE/AES/SHA/CLMUL);
an encoding that is not understood is an error rather than skipped. Reads of
`OPENSSL_ia32cap_P` give an unknown value, so every CPU-specific path is checked.

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
- [machine](src/machine.rs) is the interface between the engine and an instruction set model
- [computer](src/computer.rs) is a model of an Arm Cortex-A computer which transforms and returns values with an ```execute``` function
- [memory safety checks](src/computer/memory.rs) are handled within the computer logic on loads and stores
- [x86](src/x86) holds the x86-64 [parser](src/x86/instruction_parser.rs), [computer](src/x86/computer.rs) and [memory checks](src/x86/computer/memory.rs)
- [parser](src/instruction_parser.rs) parses unstructured string inputs into an instruction type
