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

BUMS checks both AArch64 and x86-64 (AT&T syntax) assembly. The macro reads the assembly
file it is given and picks the instruction set from it, so an annotation looks the same for
either; case studies annotate each function once per architecture with
`#[cfg_attr(target_arch = "...", ...)]`. The analysis runs on the machine doing the build,
so x86-64 assembly can be checked from an Apple Silicon Mac with
`cargo build --release --target x86_64-apple-darwin` (after
`rustup target add x86_64-apple-darwin`), and the resulting tests run under Rosetta 2.
Verification results are only reported by `--release` builds: in debug builds a failed check
is a proc-macro warning, which stable Rust does not display.

Repository structure:
-  [memsafe-checker](memsafe-checker) is the ```bums``` symbex engine
-  [bums_macros](bums_macros) exposes the macro
-  [crypto-playground](crypto-playground) has macro examples on cryptography from [aws-lc-rs](https://github.com/aws/aws-lc-rs)
-  [rav1d-playground](rav1d-playground) has macro examples on video decoding code from [rav1d](https://github.com/memorysafety/rav1d)
-  [openblas-playground](openblas-playground) has macro examples on the hand-written AArch64 and x86-64 BLAS kernels of [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS)
-  [asm-files](asm-files) assembly files for cryptographic algorithms collected from various crypto libraries
-  [scrape-asm](scrape-asm) contains code for searching for assembly in top crates from crates.io

