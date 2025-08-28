# Memory Safe Assembly

Bottom-up memory-safety (_BUMS_) checks for assembly using symbolic execution. This repo includes a symbolic execution engine, a procedural macro for easy use of the analysis, and some example use cases.
The symbex engine accepts assembly code and memory regions as inputs, and checks whether the assembly operates within the allowable memory regions. 
The macro attaches to function declarations in Rust and derives safety conditions and memory regions automatically.

Currently, the memory safety analysis performed by _BUMS_ is sound but not complete. 
BUMS can verify isolated programs, i.e, programs that do not allocate or free memory (operating only within memory explicitly passed through input parameters).
BUMS supports resolving constant-step loops over potentially unbounded input buffers by generating inductive proofs of safety.

Repository structure:
-  ```memsafe-checker``` is the ```bums``` symbex engine
-  ```bums-macros``` exposes the macro
-  ```crypto-playground``` has macro examples on cryptography from [aws-lc-rs](https://github.com/aws/aws-lc-rs)
-  ```rav1d-playground``` has macro examples on video decoding code from [rav1d](https://github.com/memorysafety/rav1d)
-  ```asm-files``` assembly files for cryptographic algorithms collected from various crypto libraries
-  ```scrape-asm``` contains code for searching for assembly in top crates from crates.io

