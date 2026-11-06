# Evaluation

This directory measures how long BUMS takes to verify every annotated function in the case
studies and where that time goes. `run.sh` checks the case studies with `bums-check` and
`plot.py` turns the results into figures and a summary table.

## Running

```
evaluation/run.sh
python3 evaluation/plot.py
```

`run.sh` builds `bums-check`, then checks each suite in turn:

| suite | crate | target |
|---|---|---|
| corecrypto, graviola, crypto, bignum, openblas, candle, rav1d, compression | `<suite>-playground` | AArch64 |
| crypto-x86, openblas-x86, rav1d-x86, compression-x86 | the same crates | `x86_64-apple-darwin` |
| ffmpeg | `ffmpeg-playground --all-features` | AArch64 |

Run 1 checks every annotated function, so its verdicts are the sweep of the whole tree. Later
runs check again only the functions run 1 verified, to time them repeatedly. After the runs,
`run.sh` records the static size of every function with `bums-check --sizes`.

Each step skips output that already exists, so an interrupted evaluation resumes where it
stopped. Delete a suite's TSV to check it again.

Settings come from the environment:

| variable | default | meaning |
|---|---|---|
| `RUNS` | 3 | number of runs |
| `JOBS` | 4 | functions checked in parallel |
| `TIMEOUT` | 300 | seconds per function before it counts as TIMEOUT |
| `SLOW_TIMEOUT` | 1800 | the same for the functions listed in `slow/` |
| `OUT` | `evaluation/results` | where results go (ignored by git) |
| `SLOW` | `evaluation/slow` | functions given `SLOW_TIMEOUT`, one file per suite |
| `ONLY` | all | space-separated suite names to run |
| `EXTRA_SUITES` | none | more suites, each `name\|crate-dir\|bums-check flags` |

A full evaluation takes several hours, mostly in run 1, where every timeout costs the full
`TIMEOUT`. Memory stays within `JOBS` times `bums-check`'s per-function cap (4 GB by default).

## Timeouts

Run 1 checks every annotated function; nothing is skipped. A function that exceeds its timeout
is recorded as TIMEOUT and counts as unverified, the same as FAIL, MEMCAP and ERROR.

## Slow functions

`slow/<suite>.txt` lists functions that verify but need longer than `TIMEOUT`, such as the
scalar multiplications in bignum, which run a loop of several thousand instructions through
calls. Each run checks them in a second pass with `SLOW_TIMEOUT` and adds their rows to the
suite's TSV, so they count as verified with their real time. A function belongs here only once
it has verified within `SLOW_TIMEOUT`; one that never finishes stays a TIMEOUT under `TIMEOUT`.

## Results

```
results/
  run<N>/<suite>.tsv    one row per function checked in that run
  run<N>/<suite>.skip   the functions a later run leaves out because run 1 did not verify them
  sizes/<suite>.tsv     function, file, statically reachable instructions
```

The run TSV columns are:

| column | meaning |
|---|---|
| function, file | the annotated declaration |
| status | `verified`, `FAIL`, `TIMEOUT`, `MEMCAP` or `ERROR` |
| seconds | wall-clock time of the child process |
| message | the first error, empty when verified |
| instructions | distinct instructions executed |
| loops | distinct loop headers summarized |
| steps | instructions executed, counting repeats |
| queries | SMT queries |
| execution | seconds in symbolic execution |
| loop_resolution | seconds detecting, summarizing and checking loops |
| forking | seconds copying state at branches |
| smt_execution | seconds in the solver on behalf of execution |
| smt_loops | seconds in the solver on behalf of loop resolution |
| parsing | seconds parsing the annotation and the assembly |
| serialization | seconds translating expressions for the solver |

Each phase counts only the time not spent in a phase nested inside it, so the phase columns add
up to the checker's own time. `plot.py` uses them only for verified functions, since a failed
check stops at its first error.

## Figures

`plot.py [results] [--out DIR] [--split-audio] [--sizes DIR]` reads every run, keeps the
functions verified in all of them, and takes the median time per function. It writes into the
results directory by default:

| file | content |
|---|---|
| `time-vs-size.pdf` | verification time against instructions executed, by domain, with a log-log fit for functions with and without loops |
| `size-comparison.pdf` | the same against executed and against static size, side by side |
| `time-breakdown.pdf` | share of time per phase, summed over each suite |
| `time-breakdown-{fastest,median,slowest}.pdf` | share of time per phase for one representative function per suite |
| `points.tsv` | the per-function data behind the figures |

It also prints a table of verified, checked and loop-carrying functions and the median time
per suite. `--split-audio` separates FFmpeg's audio files from its video code. The plots need
`matplotlib` and `numpy`.
