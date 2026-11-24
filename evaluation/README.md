# Evaluation

One command runs the whole evaluation: it verifies every case study with `bums-check`, measures
the runtime overhead of the checked wrappers, and writes the tables and figures.

```
evaluation/evaluate.sh --open
```

Everything for one evaluation lands in one directory, `evaluation/results/<date>/` by default
(ignored by git). A full sweep takes about a day at the default 2 jobs × 3 GB; see
[Running parts of it](#running-parts-of-it) to redraw figures from an existing sweep in a minute.

Requirements: the pinned Rust toolchain (`1.93-aarch64-apple-darwin`), Python 3 with
`matplotlib` and `numpy`, and for rav1d's x86 build `nasm` and `llvm-objdump`. Apple corecrypto's
assembly is licensed, so the `prepare` stage renders it locally from its submodule.

## Layout

```
evaluation/
  evaluate.sh          the driver: stages, sweep passes, memory watchdog
  report/              Python package that turns a sweep into tables and figures
    suites.py          the one list of case studies (crate, ISA, flags, case study, domain)
    results.py         reads bums-check TSVs
    tables.py          verified / not verified per case study
    failures.py        why each check failed, classified from its message
    timing.py          verification time vs size, time breakdown by phase
    annotations.py     annotation size vs time, against SecSep/Octal
    distribution.py    distribution of verification times
    preconditions.py   number and kinds of preconditions per suite
    overhead.py        runtime overhead of the checked wrappers
  wrapper-overhead/    the overhead benchmark (Rust crate generated from the annotations)
  slow/<suite>.txt     functions that verify but need the long pass
  published/           the sweep behind the paper's figures (rework-5f5018a4)
```

To add a case study, add one line to `report/suites.py`; the sweep and every table and figure
pick it up. `python3 -m report.suites` (from `evaluation/`) prints the list the sweep uses.

## Stages

`evaluate.sh` runs these in order; `--stages` picks a subset.

| stage | what it does | output |
|---|---|---|
| `prepare` | renders corecrypto's assembly if it is missing | `corecrypto-playground/asm/` |
| `tests` | `cargo test` of the checker; the evaluation stops if any test fails | `tests.log` |
| `sweep` | checks every suite, then records each function's static size | `run1/`, `sizes/`, `sweep.log` |
| `overhead` | benchmarks raw vs checked wrappers; run it on an otherwise idle machine | `overhead/` |
| `report` | tables, failure reasons and figures | `report/` |
| `secsep` | redraws the SecSep/Octal comparison figures (not in the default set) | `secsep-eval/paper-data/figures/` |

The sweep checks each suite in two passes. The main pass gives every function `--timeout`
(300 s). Functions listed in `slow/<suite>.txt` are skipped there and checked in a second pass
with `--slow-timeout` (2700 s) and a larger step budget; a function belongs on that list only once
it has verified within those limits. With `--runs N`, later runs re-time only what run 1
verified, so the figures can use medians. A watchdog kills the sweep's `bums-check` children if
free memory drops below 1.5 GB. Each suite's TSV is written when the suite finishes, so an
interrupted sweep resumes where it stopped; delete a TSV to check that suite again.

## Options

| option | default | meaning |
|---|---|---|
| `--stages "A B"` | `prepare tests sweep overhead report` | stages to run |
| `--out DIR` | `evaluation/results/<date>` | evaluation directory |
| `--from DIR` | | report on an existing sweep (implies `--stages report`) |
| `--only "S1 S2"` | all | restrict the sweep to these suites |
| `--runs N` | 1 | sweep repetitions |
| `--jobs N` | 2 | functions checked in parallel |
| `--mem-gb G` | 3 | resident memory cap per function |
| `--timeout S` | 300 | per-function limit, main pass |
| `--slow-timeout S` | 2700 | per-function limit, slow pass |
| `--open` | off | open every figure when the report is written |

## Running parts of it

```
evaluation/evaluate.sh --from evaluation/published/rework-5f5018a4 --open    # redraw the paper's sweep
evaluation/evaluate.sh --only "graviola candle" --stages "sweep report"      # a quick partial sweep
evaluation/evaluate.sh --stages overhead --out evaluation/results/2026-11-15 # re-measure overhead only
cd evaluation && python3 -m report results/2026-11-15 --open                 # the report on its own
```

## The report

`report/summary.md` collects the tables; the CSVs hold the full data.

| file | content |
|---|---|
| `summary.md` | per-case-study results, failure reasons, precondition totals, figure list |
| `case-studies.csv` | per suite: checks, verified, rejected, FAIL/TIMEOUT/MEMCAP/ERROR, time min/mean/median/max |
| `failures.csv` | every check not verified: suite, function, status, reason class, first failure message, and the hand-written diagnosis where one exists (`compression-playground/unverified.tsv`) |
| `precondition-kinds.csv` | per suite: annotations, those without preconditions, and clauses by kind |
| `figures/failure-reasons` | checks not verified per suite, by reason |
| `figures/time-vs-size`, `size-comparison` | verification time against instructions executed (and static size), log-log fits with and without loops |
| `figures/time-breakdown` | share of verification time per phase, summed per suite |
| `figures/time-breakdown-{fastest,median,slowest}` | the same for one representative function per suite |
| `figures/annotation-vs-time` | annotation clauses against checking time, with SecSep/Octal for reference |
| `figures/time-distribution-{log,linear-overflow,linear-full}` | three views of the distribution of checking times |
| `figures/precondition-kinds` | the mix of precondition kinds per suite |
| `figures/precondition-counts` | precondition clauses per function, by domain |
| `figures/wrapper-overhead`, `wrapper-overhead-added` | runtime overhead of the checked wrapper, relative and in added nanoseconds |

Every figure is written as PDF and PNG.

### Terms

A **check** is one annotation: one function on one ISA. `verified` means the checker proved
every memory access in bounds under the annotation's preconditions. `rejected` is the expected
outcome of a `rejects` annotation, an exact contract the function is known to violate (each has a
`_padded` twin that verifies under the caller's padding), so it counts with the verified.

A failing check is classified by its **first failure**:

| reason | message it comes from |
|---|---|
| time limit / memory limit | `TIMEOUT`, `MEMCAP` |
| access not provably in bounds | `read/write of N bytes at ... not provably within ...` (a real over-read, a missing precondition, or an invariant the engine cannot express) |
| pointer with no known region | an access through a value the engine cannot tie to a parameter |
| path explosion | `branch depth exceeded`, `exploration limit reached` |
| return / callee-saved contract | a callee-saved register or the stack pointer not restored |
| gather with unbounded lanes | an AVX gather whose indices have no bound |
| unsupported instruction or feature | `not yet implemented`, panics, untranslatable expressions |

### TSV columns

| column | meaning |
|---|---|
| function, file | the annotated declaration |
| status | `verified`, `rejected`, `FAIL`, `TIMEOUT`, `MEMCAP` or `ERROR` |
| seconds | wall-clock time of the child process |
| message | the errors, empty when verified |
| instructions, loops, steps, queries | distinct instructions executed, loops summarized, instructions executed, SMT queries |
| execution, loop_resolution, forking, smt_execution, smt_loops, parsing, serialization | seconds per phase; each counts only time not spent in a phase nested inside it |
