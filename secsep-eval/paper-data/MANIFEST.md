# BUMS vs SecSep (Octal): paper data package

Everything here is generated from the raw results in `secsep-eval/` by two scripts:

```
cd msa-secsep/secsep-eval
python3 tools/build_paper_data.py   # data/*.csv and tables/*.tex
python3 tools/make_figures.py       # figures/*.pdf and *.png
```

SecSep: Song et al., "Securing Cryptographic Software via Typed Assembly Language", CCS 2025
(artifact github.com/MATCHA-MIT/secsep, commit 81c0e63). Octal claims "well-typed programs are memory-safe";
that claim is what overlaps with BUMS and what is compared. Their speculative-execution results
(gem5 overhead, declassification) are a different property and are not compared.

How each tool is used here: SecSep annotates every function in the program's call graph and checks the
whole program from `main`. BUMS checks each function against its own contract, with every pointer
parameter its own region; all comparisons use the same 21 functions, annotated in both tools.

## Headline numbers

| | SecSep (Octal) | BUMS |
|---|---|---|
| Functions verified (the 21 both tools annotate) | 21/21 | 21/21 (12/21 before the engine changes listed below) |
| Annotation clauses, same 21 functions | 142 | 62 |
| Annotation tokens, same 21 functions | 1,677 | 948 (includes the Rust signature) |
| Time, sum over the 21 functions | 4,245 s CPU | 1,396 s wall |
| Faster per function | | 21/21 functions, typically 10 to 1000x; ED25519_sign about 2x (load-sensitive, see caveat 1) |
| Mutants rejected (12 out-of-bounds faults) | 12/12, of which 1/12 by the type checker | 12/12, each at the faulting instruction |
| Unsupported or unparsed instructions, BoringSSL hand-written x86 | 0.5 to 80% per file | (BUMS verifies these in other playgrounds) |
| md5 mutant without the num == 0 guard | accepted (inferred num >= 1, checked only against main) | rejected (the stated contract allows num = 0) |

## Figures (`figures/`, vector PDF + 300 dpi PNG, single-column width 3.4 in)

| File | Suggested caption |
|---|---|
| `fig_time_per_function` | Per-function verification time, BUMS vs SecSep (log). BUMS times below 0.1 s are drawn at 0.1 s (bums-check resolution). |
| `fig_benchmark_time` | Time summed over each benchmark's functions (count in parentheses): SecSep inference + type check CPU vs BUMS wall; labels give the ratio. |
| `fig_annotation_burden` | Annotation clauses summed over each benchmark's functions, both tools annotating the same functions. Clauses: SecSep @tags + @secsep_in/out; BUMS argument bindings + bracketed preconditions. |
| `fig_annotation_vs_time_clauses` / `_tokens` | Annotation size vs time per function. Tokens include the BUMS Rust signature. |
| `fig_mutation` | Twelve single-instruction out-of-bounds mutants (two per benchmark). Filled: rejected at the faulting instruction; open circle: type checker rejects the function; triangle: inference raised an exception with no location. |
| `fig_parser_coverage` | Share of instructions Octal's parser rejects or does not support, on SecSep's own compiled benchmarks vs BoringSSL's hand-written x86 (linux). |
| `fig_secsep_phase_share` | Where SecSep's time goes: phase shares of inference + check CPU time and the share spent inside SMT calls. |

## Tables (`tables/`, LaTeX, booktabs)

- `per_benchmark.tex`: per benchmark, functions compared, clauses, tokens and time for both tools, with totals.
- `per_function.tex`: 21 functions, clauses and time for both tools, SecSep SMT queries.
- `mutation.tex`: per-mutant verdict symbols for BUMS and SecSep; needs `\usepackage{pifont}`.

## Data (`data/`)

| File | Contents | Source |
|---|---|---|
| `per_function.csv` | annotation clauses/tokens, BUMS baseline and final status, BUMS wall time, SecSep CPU time split infer/check, SMT queries, engine change that unblocked the function | `tools/ann.json`, `bums-run1.tsv` (baseline engine), `bums-run10.tsv` (final engine), Octal per-function timers in `octal-out-clean/*/*.log` |
| `per_benchmark.csv` | per-function data summed per benchmark; SecSep whole-program wall time and their paper's #Anno for reference | `per_function.csv`, `secsep-timing/*.log` |
| `secsep_phases.csv` | per benchmark and phase: CPU time, SMT queries, SMT time; total wall; peak RSS | `octal-out-clean/*/*.stat`, `secsep-timing/*.log` (`/usr/bin/time -l`) |
| `secsep_paper_table1.csv` | their Table 1 as published (incl. ProSpeCT columns) | the paper |
| `secsep_runtime_overhead.csv` | SecSep's runtime overhead from gem5: software (defense off) and comprehensive (ProSpeCT-style defense on), per benchmark and average, plus the other schemes' averages | read from the paper's Figure 12 (averages exact from bar labels; per-benchmark bars approx. +-0.2 pt). The artifact ships no raw gem5 results (checked the pinned secsep-gem5 commit e8eea99). |
| `secsep_annotations_by_function.csv` | @valid/@size/@taint/@const/@overlap/@sym/@unit counts per annotated function | benchmark C sources |
| `secsep_global_markers.csv` | SECRET_SYM/PUBLIC_SYM/... marker counts | benchmark C sources |
| `secsep_inferred_preconditions.csv` | each function's final precondition clauses, classified layout / non-overlap / 8-byte alignment / other, with notes on the "other" ones | `octal-out-clean/*/*.interface` via `tools/ctx_stats.py` |
| `secsep_rewrites.csv` | instructions rewritten by the SecSep transformation, by kind | `*.transform.log` via `tools/tf_log_stats.py` |
| `mutation.csv` | per mutant: fault, BUMS verdict and message, Octal failing phase and error, classification | `mutation/` (`tools/make_mutants.py`) |
| `md5_case_study.csv` | the md5 guard-removal case: Octal's inferred precondition vs BUMS's stated contract | `handasm/`, `octal-out-clean/md5*` |
| `transform_check.csv` | BUMS on SecSep's transformed assembly, raw and with the 8 MB secret-stack offset folded back | `tf-check/` (`tools/fold_secret_stack.py`) |
| `octal_parser_coverage.csv` | per file: instructions, unsupported or unparsed, share, most common failures | `octal-parse-coverage.tsv` (parser probe in `secsep/octal/probe`) |
| `bums_progression.csv` | per function: BUMS baseline vs final status and the engine change responsible | as per_function |

## Methodology

- **Machine:** Apple M1 Pro, 16 GB, macOS. Octal built natively (OCaml 5.1, z3 4.15.2); BUMS z3 crate 0.20.2. Inputs are SecSep's shipped clang-16 analysis files; their transformed outputs were regenerated and match their shipped files byte for byte.
- **SecSep time:** per function, CPU time across Octal's four solver-backed phases (dependent type, valid region, taint, type check), from `Sys.time` timers added to Octal around each per-function call (no change to its algorithms). A caller reuses the interfaces inferred for its callees. Whole-program wall time of `run.py full` is in `per_benchmark.csv` for reference (includes transformation, under 2 s).
- **BUMS time:** wall time of one `bums-check` child per function, one function at a time, no logging. BUMS re-executes a function's callees inside it, so a caller's time includes its callees.
- **Annotations:** SecSep clauses = @tags plus @secsep_in/out constraints in the function's comment block. BUMS clauses = argument bindings plus bracketed preconditions in `check_mem_safe`. Tokens = identifiers, numbers and symbols; BUMS tokens include the Rust signature.
- **Mutants:** one instruction changed per mutant (the generator refuses any pattern that does not match exactly once inside the named function); the same file goes to both tools. Octal runs its full pipeline; BUMS checks the function containing the fault against its contract. Both tools accept every unmutated original.
- **Transformed-code check:** SecSep moves secret stack data to a mirror at rsp - 0x800000. The fold adds 0x800000 back to every displacement within 1 MB of -0x800000 and turns `add $-8388608` into `add $0`, then BUMS checks frame and argument bounds. This shows every secret-stack access lands on the mirror of a legitimate slot; it cannot show that the right stack was chosen.

## Engine changes made during this comparison (all in BUMS, branch secsep-eval, uncommitted)

Each has rejection tests and every newly verified function was mutation-checked:
loader models `.ascii`/`.asciz`/`.string`; memset/memcpy/memmove contracts; a shared unsigned-length guard for libc calls and `rep` string instructions; unsigned struct fields >= 0; narrow stores keep uncovered constant bytes; per-call-site jump counting; symbolic 64-bit `not`; forced-exit discharge of loop summaries; down-counter floor bounds (kept after the loop only if they hold at the exit); multi-back-edge inside-body rule in loop detection; x86 stack lower bound (`min(live rsp, entry) - 128`; before it, any access below rsp verified).

## Caveats a reviewer will ask about

1. BUMS wall times on long functions vary with machine load (ED25519_sign measured 891 to 2,226 s across runs); SecSep per-function numbers are CPU time. Short BUMS times are at the 0.1 s resolution of `bums-check`.
2. BUMS needed engine changes to reach 21/21 (baseline 12/21); report both, and note the changes are general (tests, not benchmark-specific hacks).
3. Inferred-precondition classification is heuristic; poly1305's 16-byte alignment clauses use mask 15 and land in "other" (see the note column).
4. Mutation study: 12 mutants is small; SecSep's rejections are mostly inference exceptions, which it would also raise on safe code it cannot infer. Report "rejected" and "localized the fault" separately.
5. Transformed-code check: 19/21 verify after folding; the two poly1305 functions hit BUMS's branch-depth limit (32) and are inconclusive.
6. The x86 stack fix changes every x86 verdict BUMS has produced; other x86 playgrounds were not re-swept on it.
7. Not comparable: gem5 runtime overhead and declassification (speculative security); Octal on AArch64 (unsupported).
