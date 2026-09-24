# memory-safe-assembly

BUMS: a symbolic-execution engine (`memsafe-checker`, crate name `bums`) that proves memory
safety of hand-written aarch64 assembly. `#[bums_macros::check_mem_safe(...)]` annotations in
`crypto-playground/` run the checker at compile time, one Z3 symbolic execution per annotated
function. Current goal: verify all aws-lc aarch64 assembly.

## Commands

Always prefix cargo with the pinned toolchain:

```
RUSTUP_TOOLCHAIN=1.93-aarch64-apple-darwin
```

- **Tests:** `RUST_MIN_STACK=1073741824 cargo test -p bums --release`
  Six suites: lib, examples, flags, loop_acceleration, memory_bounds, w_registers.
  `loop_acceleration`'s rejection tests (`*_is_rejected`, `a_growing_stride_over_a_region_is_declined`)
  are the soundness guard — they must keep failing unsafe code.
- **Format:** `cargo fmt -p bums`. Never `--all`; it drags the playground crates into the diff.
- **Lint:** `cargo clippy -p bums --all-targets`.

## Verifying assembly

`awslc-probe/` is a scratch crate: write one annotation into its `src/lib.rs` and build it
release with `RUST_MIN_STACK` set. One build categorises every annotation in the file; a panic
in one function does not abort the rest, but a rustc SIGBUS truncates everything after it.

Per-function sweep script (currently at `~/.claude/jobs/911b7252/tmp/per_fn_sweep.py`, ephemeral
— move it into the repo if it matters): builds each annotation alone with a wall clock and a
memory cap, writes `per_fn_results.json`. This is the authoritative result. Single-function
probe with logs: `LOG=1 memprobe.sh <tag>` (`RUST_LOG=bums=info`).

**A probe reporting `failed=0` does not mean verified** — it only counts `VERIFICATION FAILED`
and misses panics and truncated runs. Confirm through the sweep.

## Working style

- **No comments in code.** Put the reasoning in names, or tell me in chat.
- Use Edit/Write for source changes rather than sed/heredoc scripting.
- Don't edit `README.md` files; report results in chat.
- Don't commit or push unless asked. No "Co-authored-by: Claude" lines.
- Don't run `cargo build -p crypto-playground` without asking.

## Gotchas

- **Memory.** Expanding these macros has hit 25–80 GB and crashed the machine. Cap runs at
  20 GB, run heavy things one at a time. Killing `cargo` orphans its `rustc` children, which
  keep growing — after any interrupted run, check `ps` for stray `rustc` and kill by pid.
- **The log is a depth-first walk with backtracking.** Adjacent lines are often different
  paths, and frequency-sorted output is not a time series. To find out what the solver knows
  at a failure, instrument the failure site (`solver.get_assertions()`); don't read trace order.
- **z3 `Solver::clone` drops push/pop frames.** Fork engines with `fork()`, never `self.clone()`.
- **BUMS parses GNU asm only.** Disassemble with
  `llvm-objdump --triple=aarch64-unknown-linux-gnu`; macOS dotted NEON syntax fails.
- The `rework` branch is checked out at the repo root, so worktrees can't take it. Commit on
  the worktree branch and cherry-pick.
