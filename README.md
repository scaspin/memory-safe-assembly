# Memory Safe Assembly

Bottom-up memory-safety (_BUMS_) checks memory safety for assembly linked into Rust using symbolic execution. This repo includes a symbolic execution engine, a procedural macro for easy use of the analysis framework, and some example use cases.
The symbex engine accepts assembly code and memory regions as inputs, and checks whether the assembly operates within the allowable memory regions for all possible executions. 
The macro attaches to function declarations in Rust and derives memory regions and thus memory safety conditions automatically.
The BUMS macro allows developers to specify preconditions on the input passed to the assembly, which may be required for verification to succeed. These preconditions are checked at runtime every time the function is invoked.


Currently, the memory safety analysis performed by _BUMS_ is sound but not complete. 
BUMS can verify isolated programs, i.e, programs that do not allocate or free memory (operating only within memory explicitly passed through input parameters).
BUMS supports resolving constant-step loops over potentially unbounded input buffers by generating inductive proofs of safety.
BUMS specifically targets cryptographic code, which is written for constant-time and includes little to no branching on input, thus simplifying symbolic execution.
BUMS achieves quick verification times by discarding information about program state that could not lead to safe memory accesses, such as the result of a computation over two unspecified input values.

Repository structure:
-  [memsafe-checker](memsafe-checker) is the ```bums``` symbex engine
-  [bums-macros](bums-macros) exposes the macro
-  [crypto-playground](crypto-playground) has macro examples on cryptography from [aws-lc-rs](https://github.com/aws/aws-lc-rs)
-  [rav1d-playground](rav1d-playground) has macro examples on video decoding code from [rav1d](https://github.com/memorysafety/rav1d)
-  [asm-files](asm-files) assembly files for cryptographic algorithms collected from various crypto libraries
-  [scrape-asm](scrape-asm) contains code for searching for assembly in top crates from crates.io

