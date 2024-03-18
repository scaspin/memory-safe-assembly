Verifying multiple examples can be run using tests:

```cargo test```

and with logging at:

```RUST_LOG=info cargo test -- --nocapture```

An assembly file is checked by instantiating a symbolic execution engine from library [engine](src/engine.rs), then adding the appropriate memory regions if needed, and then starting execution by providing the label of the function.

Example cases are shown in [tests](tests/cli.rs) and the original assembly files are [provided](tests/asm-examples) for the following:
* sha256 arm v8 from boringssl

** Notes on Z3 **

When a memory region is added, it has start and end which are values (real or abstract).
Two constraints are generated and added to solver, along with instantiating the abstracts appropriately. There are at least two abstract: the region "base", i.e the initial address given to the program, and the "pointer", which is the address the program would use to index into this array.

1. base >= 0
2. start >= 0
3. end >= 0
1. pointer >= base + start 
2. pointer =< base + end 

( where start and end CAN be abstract values. End is not the size of the region since it considers alignment and is the last "safe" address for this region. Alignment is added based on computer defs to calculate the end such that the end is inclusive. )
These constraints essentially say the pointer can only take specific values based on the region.

When a memory access to this region is performed, we need to check three properties:
1. pointer = base + index is satisfiable (i.e. this memory access is within the region). This quickly checks the basic case where a memory access is performed in an unreachable are, for example with index = 4 while end = 2.

The next two properties are important when "index" may be undefined. We need to ensure not only that index is possible within the region, but also that there is NO WAY that any possible value of index is outside the memory safe region. A memory access is allowed IFF:

2. index < start is unsatisfiable (we have sufficient constraints to know that "index" is never less than start)
3. index > end is unsatisfiable (we have sufficient constraints to know that "index" is never greater than index)

