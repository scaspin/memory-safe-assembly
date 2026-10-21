# memory-safe-assembly

BUMS: a symbolic-execution engine (`memsafe-checker`, crate name `bums`) that proves memory
safety of hand-written AArch64 and x86-64 assembly. `#[bums_macros::check_mem_safe(...)]`
annotations in the `*-playground/` crates (crypto, bignum, corecrypto, graviola, rav1d, ffmpeg,
openblas, candle) run the checker at compile time, one Z3 symbolic execution per annotated
function. The engine is generic over `Machine` (src/machine.rs); loop acceleration lives in
src/engine/summary.rs and src/engine/loops.rs. FORMALISM.md describes the rules.

## Commands

Always prefix cargo with the pinned toolchain:

```
RUSTUP_TOOLCHAIN=1.93-aarch64-apple-darwin
```

- **Tests:** `RUST_MIN_STACK=1073741824 cargo test -p bums --release`
  x86 tests run natively (the engine is pure Rust). The rejection tests (`*_is_rejected`,
  `*catches*`, soundness_probes.rs, x86_cves.rs vulnerable variants) are the soundness guard:
  they must keep failing unsafe code.
- **Format:** `cargo fmt -p bums -p bums_macros`. Never `--all`; it drags the playground crates into the diff.
- **Lint:** `cargo clippy -p bums -p bums_macros --all-targets`.
- **x86 playgrounds:** `cargo check --release --target x86_64-apple-darwin -p <crate>`
  (rav1d's x86 build needs `nasm` and `llvm-objdump`).

## Verifying assembly

`awslc-probe/` is a scratch crate: write one annotation into its `src/lib.rs` and build it
release with `RUST_MIN_STACK` set. One build categorises every annotation in the file; a panic
in one function does not abort the rest, but a rustc SIGBUS truncates everything after it.

Verdicts only appear in `--release` builds; debug builds turn them into proc-macro warnings
that stable Rust drops. rav1d-playground/asm-status.tsv and ffmpeg-playground/asm-status.tsv
record per-function results. Check large playgrounds per module or per function with a wall
clock and a memory cap.

**A probe reporting `failed=0` does not mean verified** — it only counts `VERIFICATION FAILED`
and misses panics and truncated runs. Confirm through the sweep.

## Working style

- **No comments in code.** Put the reasoning in names, or tell me in chat.
- Use Edit/Write for source changes rather than sed/heredoc scripting.
- Don't edit `README.md` files; report results in chat.
- Don't commit or push unless asked. No "Co-authored-by: Claude" lines.
- Don't build a whole playground crate without asking; check it piecewise under a memory cap.

## Gotchas

- **Memory.** Expanding these macros has hit 25–80 GB and crashed the machine. Cap runs at
  20 GB, run heavy things one at a time. Killing `cargo` orphans its `rustc` children, which
  keep growing — after any interrupted run, check `ps` for stray `rustc` and kill by pid.
- **The log is a depth-first walk with backtracking.** Adjacent lines are often different
  paths, and frequency-sorted output is not a time series. To find out what the solver knows
  at a failure, instrument the failure site (`solver.get_assertions()`); don't read trace order.
- **z3 `Solver::clone` drops push/pop frames.** Fork engines with `fork()`, never `self.clone()`.
- **BUMS parses GNU syntax for AArch64 and AT&T for x86-64.** Disassemble with
  `llvm-objdump --triple=aarch64-unknown-linux-gnu`; macOS dotted NEON syntax fails.
- **Verdicts must not depend on iteration order:** use BTreeMap/BTreeSet in anything that can
  influence a verdict.
