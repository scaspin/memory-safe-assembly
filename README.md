# Memory Safe Assembly

Bottom-up memory safety (_BUMS_) checks the memory safety of assembly linked into Rust using
symbolic execution. This repo contains the symbolic execution engine, a procedural macro that
attaches the analysis to Rust declarations, a driver for checking whole crates, and case studies.

The engine takes assembly and a set of memory regions and checks that every memory access stays
within those regions on every possible execution. The `check_mem_safe` macro attaches to an
`extern` function declaration, derives the regions from the Rust argument types, and lets the
developer state preconditions on the inputs (for example, that two slices have equal length).
The preconditions are checked at runtime on every call.

The analysis is sound but not complete:

- BUMS verifies isolated functions, ones that do not allocate or free memory and only touch
  memory passed in through their parameters, the stack, and read-only tables.
- Loops over unbounded inputs are summarized by inductive invariants, so a verified function is
  safe for every input length the preconditions allow.
- When BUMS cannot prove an access safe it reports that access. A failure is either a real
  out-of-bounds access or a place where the analysis is imprecise.

## Instruction sets

BUMS checks AArch64 (GNU syntax) and x86-64 (AT&T syntax). The macro picks the instruction set
from the assembly file it is given, so an annotation looks the same for either; case studies
annotate each function once per architecture with `#[cfg_attr(target_arch = "...", ...)]`.
The analysis runs on the build machine, so x86-64 assembly can be checked from an Apple Silicon
Mac with `cargo build --release --target x86_64-apple-darwin` (after
`rustup target add x86_64-apple-darwin`).

Verification results are only reported by `--release` builds: in debug builds a failed check is
a proc-macro warning, which stable Rust does not display.

## Checking a whole crate

`bums-check` evaluates every `check_mem_safe` annotation of a crate without building it once
per function. It runs the crate's build script once (to find the assembly), then checks each
function in its own process, in parallel, with a wall clock and a memory cap. It uses the
same annotation library as the macro (`bums_annotations`), so its verdicts are the macro's.

```
cargo build --release -p bums-check
target/release/bums-check corecrypto-playground --jobs 4 --out results.tsv --log-dir logs
target/release/bums-check openblas-playground --target x86_64-apple-darwin --timeout 600
```

Options: `--features A,B`, `--all-features`, `--no-default-features`, `--asm-dir DIR`,
`--jobs N`, `--timeout SECS`, `--mem-gb G`, `--filter REGEX`, `--skip-file FILE`, `--list`.
Each function is reported as `verified`, `FAIL`, `TIMEOUT`, `MEMCAP` or `ERROR`; the exit code
is nonzero if any function fails or errors, so it can gate CI.

## Repository structure

Tooling:

- [memsafe-checker](memsafe-checker): the `bums` symbolic execution engine;
  [FORMALISM.md](memsafe-checker/FORMALISM.md) describes its rules
- [bums_macros](bums_macros): the `check_mem_safe` macro
- [bums_annotations](bums_annotations): annotation parsing shared by the macro and `bums-check`
- [bums-check](bums-check): the whole-crate driver

Case studies, each a crate of annotated declarations:

| crate | assembly | from |
|---|---|---|
| [crypto-playground](crypto-playground) | AArch64, x86-64 | [aws-lc-rs](https://github.com/aws/aws-lc-rs) (AES, SHA, ChaCha20, Poly1305, bignum) |
| [bignum-playground](bignum-playground) | AArch64 | [s2n-bignum](https://github.com/awslabs/s2n-bignum) |
| [graviola-playground](graviola-playground) | AArch64 | [graviola](https://github.com/ctz/graviola) |
| [corecrypto-playground](corecrypto-playground) | AArch64 | Apple corecrypto |
| [rav1d-playground](rav1d-playground) | AArch64, x86-64 | [rav1d](https://github.com/memorysafety/rav1d) / dav1d video decoding |
| [ffmpeg-playground](ffmpeg-playground) | AArch64 | [FFmpeg](https://ffmpeg.org) codecs and DSP |
| [openblas-playground](openblas-playground) | AArch64, x86-64 | [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS) BLAS kernels |
| [candle-playground](candle-playground) | AArch64 | inline `asm!` in [candle](https://github.com/huggingface/candle) |
| [compression-playground](compression-playground) | AArch64, x86-64 | [isa-l](https://github.com/intel/isa-l), [zlib-ng](https://github.com/zlib-ng/zlib-ng) and [zstd](https://github.com/facebook/zstd) |

Other material:

- [evaluation](evaluation): scripts that time the verification of every case study and plot
  the results
- [bugs/asm-cves](bugs/asm-cves): vulnerable and fixed versions of assembly behind published
  CVEs, used to show that BUMS rejects the vulnerable code
- [asm-files](asm-files): assembly collected from cryptographic libraries
- [scrape-asm](scrape-asm): a tool for finding assembly in the top crates on crates.io
