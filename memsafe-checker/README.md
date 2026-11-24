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
as `.byte` are decoded when their effects are known (`movq` to and from xmm, `rdrand`, `movbe`,
`mulx`, and the SSE/AES/SHA/CLMUL vector operations); an encoding that is not understood is an
error rather than skipped. On both instruction sets, bytes emitted among the code that control may
fall into are refused as unsupported encoded instructions rather than read as data. Reads of
`OPENSSL_ia32cap_P` give an unknown value, so every CPU-specific path is checked.

#### Usage 
z3 runs in a thread-local context, so there is nothing to configure before building an engine.

1. Initialize an engine with a program (any iterator of lines):
```rust
    let start_label = "test".to_string();
    let mut program = vec![format!("{start_label}:")];
    program.push("add x0,x0,#1".to_string());
    program.push("ret".to_string());

    let mut engine = bums::engine::ExecutionEngine::new(program);
```

2. Initialize any known machine state, such as register values or memory regions
```rust
    use bums::common::{AbstractExpression, RegionType};

    engine.add_immediate("x0", 1);
    engine.add_region(RegionType::READ, "Input", AbstractExpression::Immediate(64));
    engine.add_abstract_from(1, "Input");
```

3. Run symbolic execution and handle the result
```rust
    let res = engine.start(start_label);
```

#### Contents
- [engine](src/engine.rs) handles symbolic execution: running instructions, branches, selects, splits and jump tables, and merging paths
- [summary](src/engine/summary.rs) builds loop summaries: the state as a function of the loop counter, trip and landing facts, ghosts and bounds
- [loops](src/engine/loops.rs) decides when to summarize a loop, checks the summary inductively, re-explores when it is refuted, and handles nested and memory-free loops
- [widening](src/widening.rs) holds the loop invariants a register can follow and the affine forms used to compare steps
- [loader](src/loader.rs) splits a listing into code and data sections and lays out the address map
- [machine](src/machine.rs) is the interface between the engine and an instruction set model
- [computer](src/computer.rs) is a model of an Arm Cortex-A computer which transforms and returns values with an ```execute``` function
- [memory safety checks](src/computer/memory.rs) are handled within the computer logic on loads and stores
- [x86](src/x86) holds the x86-64 [parser](src/x86/instruction_parser.rs), [computer](src/x86/computer.rs) and [memory checks](src/x86/computer/memory.rs)
- [parser](src/instruction_parser.rs) parses unstructured string inputs into an instruction type
- [FORMALISM.md](FORMALISM.md) writes the engine's rules as a small calculus, with the soundness obligations and trusted assumptions
