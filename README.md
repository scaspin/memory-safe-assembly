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
Each function is reported as `verified`, `rejected`, `FAIL`, `TIMEOUT`, `MEMCAP` or `ERROR`; the
exit code is nonzero if any function fails or errors, so it can gate CI.

## Recording an over-read: `rejects` and `symbol`

Some assembly reads past the buffer its contract describes and is safe only because callers
allocate padding. Such a function gets two annotations, so a sweep never forgets that its
verdict depends on padding:

```rust
#[bums::check_mem_safe("float_dsp_neon.S", rejects, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len, len % 8 == 0, len >= 8, len <= 1048576])]
fn ff_vector_dmul_scalar_neon(dst: &mut [f64], src: &[f64], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", symbol = "ff_vector_dmul_scalar_neon", dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len + 4, len % 8 == 0, len >= 8, len <= 1048576])]
fn ff_vector_dmul_scalar_neon_padded(dst: &mut [f64], src: &[f64], len: usize);
```

- `rejects` states that the checker must fail the exact contract. `bums-check` reports it as
  `rejected` (not an error); if it ever verifies, that is a `FAIL` and a compile error, since
  either the assembly changed or the checker lost the over-read. Its Rust wrapper is an
  `unsafe fn`, because the contract it states is not a safe one.
- `symbol = "..."` checks (and links to) a different assembly symbol than the Rust name, so the
  padded twin, named `<symbol>_padded`, can state the contract with the padding it needs.

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

## Bugs found

### FFmpeg (AArch64, revision `ee8cbd7d`, October 2026)

**`ff_hevc_put_hevc_qpel_bi_h24_8_neon` walks its second source at the wrong stride.**
In `libavcodec/aarch64/h26x/qpel_neon.S` (the "h24: process 24 pixels per row as 16 + 8"
function), each pair of rows loads the first 16 samples of `src2` with
`ld1 {v16.8h, v17.8h}, [x4], x16` and the last 8 with `ld1 {v25.8h}, [x4], x16`, where
`x16 = HEVC_MAX_PB_SIZE << 2` (256 bytes, two rows), then backs up by 48. The pointer advances
256 + 256 − 48 = 464 bytes per row pair instead of 256. The second load reads columns 0–7 of
row r + 2 instead of columns 16–23 of row r, and the walk leaves a 64 × 64 `int16_t` buffer
from height 36 on (at height 64 the last read ends at byte 14784 of 8192). BUMS rejects it:
`read of 16 bytes at src2_as_ptr + loop2_? * 464`. It is dead code: `NEON8_FNASSIGN_QPEL_H`
in `hevcdsp_init_aarch64.c` dispatches width 24 to `h12`, so FFmpeg never calls it, but the
symbol is exported. `ff_hevc_put_hevc_qpel_bi_h24_8_neon` stays a `FAIL` in
[ffmpeg-playground](ffmpeg-playground).

**`ff_tx_fft_sr_float_neon` and `ff_tx_fft_sr_ns_float_neon` return without their epilogue at
length 32.** In `libavutil/aarch64/tx_float_neon.S` (`FFT_SPLIT_RADIX_FN`), the prologue pushes
96 bytes and saves `x19`–`x22` and `d8`–`d15`, but when the length is 32 the
`cmp w20, #32; b.gt 64f` fall-through stores the last quarter and executes a bare `ret`: the
caller gets back a stack pointer 96 bytes low and clobbered callee-saved `x19`/`x20`. BUMS
rejects it: `stack pointer not restored on return: sp is sp - 96, not sp`. FFmpeg never takes
that path: `tx_float_init.c` registers both codelets as `TX_DEF(fft_sr, FFT, 64, 131072, ...)`
and serves length 32 with the dedicated `fft32` codelets. Each has a `rejects` annotation over
lengths 32–4096 and a `_from_64` twin over 64–4096, which verifies. (The October sweep had
recorded `ff_tx_fft_sr_ns_float_neon` as verified; the current checker rejects it.)

**SBR `ff_sbr_hf_apply_noise_{0,1,2,3}_neon` write one complex entry past `m_max` when `m_max`
is odd.** `apply_noise_common` in `libavcodec/aarch64/sbrdsp_neon.S` handles two complex entries
an iteration (`ld1 {v2.4s}, [x0]` ... `st1 {v2.4s}, [x0], #16`) and counts `subs x5, x5, #2;
b.gt 1b`, so an odd `m_max` processes `m_max + 1` entries: it reads and rewrites `Y[kx + m_max]`.
When `kx + m_max == 64` that is the first entry of the next 64-entry row. In FFmpeg the cell is a
low-band bin (`k < kx`) that synthesis takes from `X_low`, so the corruption is not observable,
and for the last row it lands in the memory after the row array. Each has a `rejects` annotation
on the 128-float row and a `_padded` twin with `row.len() == 130`, which verifies.

**Over-reads that rely on caller padding.** Each of these reads past the buffer its contract
describes; each has a `rejects` annotation with the exact contract and a `_padded` twin that
states the padding it needs.

| function | over-read | padding in `_padded` | `_padded` |
|---|---|---|---|
| `ff_vector_dmul_scalar_neon` | software-pipelined `ld1` loads the next 32 bytes before the loop test | `src.len() == len + 4` | verified |
| `ff_opus_postfilter_neon` | `ld1 {v0.4s}` reads 4 floats of the 3-float `gains` | `gains.len() == 4` | verified |
| `ff_alf_filter_chroma_kernel_{8,10,12}_neon` | `ldr q` reads 8 coefficients of the 6-entry `filter` and `clip` | `filter.len() == 8`, `clip.len() == 8` | verified |
| `ff_vp9_{put,avg}_{regular,sharp,smooth}4_h_{10,12}_neon` (12) | the 4-wide 8-tap filter loads 16 samples per row where 12 are granted (the 11 it needs plus the one extra pixel `vp9recon.c` already allows for) | last row `+ 4` samples | verified |
| `ff_detect_alpha16_{full,limited}_neon` | the width tail does a full 16-byte `ldr q` and masks the extra lanes, up to 14 bytes past the last row | `color` and `alpha` `+ 14` bytes | verified |
| `ff_detect_alpha_{full,limited}_neon` | the same masked 16-byte tail on 8-bit pixels, up to 15 bytes past the last row | `color` and `alpha` `+ 15` bytes | verified |
| `ff_detect_range_neon` | the same masked tail, up to 15 bytes | `data` `+ 15` bytes | verified |
| `ff_detect_range16_neon` | the same masked tail on 16-bit pixels, up to 14 bytes | `data` `+ 14` bytes | verified |

In FFmpeg these are benign: `av_malloc` buffers carry `AV_INPUT_BUFFER_PADDING_SIZE`, frame
lines are padded and aligned, VP9 reads through its emulated-edge buffer, and Opus `gains` and
ALF `filter`/`clip` sit inside larger structs.
