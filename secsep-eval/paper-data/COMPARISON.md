# BUMS vs SecSep, and BUMS among related work

A full write-up of the comparison between BUMS and SecSep/Octal (Song et al., *Securing Cryptographic
Software via Typed Assembly Language*, CCS 2025), the related-work measurements (s2n-bignum, Vale, Valgrind,
AddressSanitizer), and the BUMS engine changes the comparison produced. Every number here comes from a file in
`paper-data/data/` (listed per section) and can be regenerated with the scripts in `secsep-eval/tools/`.
Methodology details and per-file provenance are in `MANIFEST.md`.

Work lives on branch `secsep-eval` of the `msa-secsep` worktree (comparison and engine changes in commit
`b87770b2`; the related-work and dynamic-tool round after it is not yet committed).

---

## 1. Summary

**What SecSep is.** A transformation that separates secret from public stack data so that a ProSpeCT-style
hardware defense can protect speculative execution cheaply. Its core, Octal, is a typed assembly language: Octal
infers dependent, valid-region and taint types for clang-compiled x86-64 code and claims that *well-typed programs
are memory-safe*. That claim is what overlaps with BUMS and what is compared here. Their speculative-security
results (gem5 overhead, declassification) are a different property; their runtime overhead is reported for context
in Section 7.

**Headline results, on the 21 functions both tools annotate** (SecSep's six benchmarks: their own salsa20 and
BoringSSL's sha512, chacha20, poly1305, x25519, ed25519_sign, compiled by clang 16):

| | SecSep / Octal | BUMS |
|---|---|---|
| Functions verified | 21/21 | 21/21 (12/21 on the engine before this work) |
| Annotation clauses | 142 | 62 |
| Annotation tokens | 1,677 | 948 (includes the hand-written Rust signature) |
| Time, sum over the 21 functions | 4,245 s CPU | 1,396 s wall |
| Faster per function | | 21/21, typically 10 to 1000x |
| Mutants rejected (12 out-of-bounds faults) | 12/12, of which 1 by its type checker | 12/12, each at the faulting instruction |
| What a verdict means | safe for the callers in the analysed program, with preconditions it may infer silently | safe for every caller that meets the stated contract |
| Runs on hand-written assembly | parser rejects 0.5 to 80% of each BoringSSL x86 file; no AArch64 | yes, AArch64 and x86-64 |
| Runtime cost | rewrites the code: 1.0% software, 1.2% with its hardware defense (gem5) | none in the code; only the wrapper's per-call precondition checks |

**Where SecSep wins.**
- It types every stack slot and struct field, so in principle it sees overflows at a finer grain than a whole
  frame or buffer.
- It infers missing preconditions instead of asking the user (useful when the whole program is known). It
  inferred, for example, `table_select`'s index bound and poly1305's `buf_used <= 16`, both of which a BUMS user
  writes by hand.
- It reuses each function's inferred interface at its callers; BUMS re-executes callees inside each caller.
- It produces a transformation with measured security value, not just a verdict.

**Where BUMS wins.**
- Faster on every one of the 21 functions; SecSep spends 95 to 99% of its time in SMT queries.
- Smaller contracts (62 vs 142 clauses), most of the gap in poly1305 (13 vs 84) where SecSep annotates each of a
  struct's 17 fields.
- Verdicts hold for every caller meeting a stated contract. Octal accepted an md5 variant that reads out of bounds
  when `num == 0`, after silently inferring `num >= 1` and checking it only against the one caller in `main`.
- Every rejection names the faulting instruction and address; 11 of Octal's 12 rejections are internal inference
  exceptions with no location.
- Works on hand-written assembly and on AArch64, which Octal cannot parse or does not support.
- Changes no code, so no runtime overhead in the protected code.

**Among related work** (Section 9): on the same 71 s2n-bignum functions, BUMS needs 208 annotation clauses where
s2n-bignum's memory-safety (`_SAFE`) proofs take 9,405 lines; Valgrind catches all 12 mutants only with
exact-size heap tests (3/12 with SecSep's own driver); AddressSanitizer catches 2/12, because it cannot see
accesses made by assembly.

---

## 2. Setup

- **SecSep artifact:** github.com/MATCHA-MIT/secsep at commit `81c0e63` (submodules: benchmark, octal, scale,
  gem5). Octal built natively (OCaml 5.1, z3 4.15.2, dune `-j 1` because dune 3.24 segfaults on this machine).
  The Docker path (LLVM 16 build, ~128 GB) was not used; SecSep's benchmark repo ships the inference inputs
  (`analysis/<bench>/`: assembly, struct layouts, stack-frame layouts, call graph). Regenerated transformed
  outputs match their shipped files byte for byte (24 of 24).
- **Machine:** Apple M1 Pro, 16 GB, macOS. BUMS z3 crate 0.20.2.
- **Per-function timing for SecSep:** Octal only reports per-phase totals, so `Sys.time` timers were added
  around each per-function call in its four solver-backed phases (`secsep-eval/octal-timers.patch`; no algorithmic
  change).
- **BUMS side:** `secsep-playground` annotates the 21 functions with `check_mem_safe` contracts over SecSep's
  compiled assembly (plus BoringSSL's hand-written md5); verdicts from `bums-check`, one function at a time.

---

## 3. Coverage, and what BUMS needed to reach 21/21

Data: `per_function.csv`, `bums_progression.csv`.

| Benchmark | Function | Clauses SecSep / BUMS | SecSep CPU (s) | BUMS (s) | Baseline engine | Engine change that unblocked it |
|---|---|---|---|---|---|---|
| salsa20 | salsa20_words | 2 / 2 | 13.1 | 0.1 | verified | |
| salsa20 | salsa20 | 4 / 4 | 10.1 | 1.6 | verified | |
| sha512 | sha512_block_data_order | 4 / 4 | 90.1 | 1.1 | verified | |
| sha512 | SHA512 | 3 / 3 | 110.0 | 12.3 | FAIL | memset/memcpy contracts with unsigned-length guard |
| chacha20 | chacha_core | 2 / 2 | 1.0 | 0.1 | verified | |
| chacha20 | CRYPTO_chacha_20 | 10 / 7 | 200.2 | 56.0 | FAIL | forced-exit discharge; down-counter floors; multi-back-edge inside-body rule |
| x25519 | fe_mul_impl | 7 / 3 | 8.5 | 0.1 | verified | |
| x25519 | fe_tobytes | 1 / 2 | 18.2 | 0.1 | verified | |
| x25519 | fe_loose_invert | 1 / 2 | 210.8 | 3.1 | verified | |
| x25519 | X25519 | 5 / 3 | 512.1 | 125.0 | FAIL | repeated helper calls counted per call site |
| poly1305 | CRYPTO_poly1305_init | 3 / 2 | 1.5 | 0.1 | verified | |
| poly1305 | CRYPTO_poly1305_update | 21 / 4 | 827.8 | 231.5 | FAIL | unsigned struct fields >= 0; narrow stores keep uncovered constant bytes |
| poly1305 | CRYPTO_poly1305_finish | 18 / 3 | 11.4 | 7.7 | FAIL | symbolic 64-bit `not` |
| poly1305 | poly1305_donna_mul | 19 / 1 | 3.8 | 0.1 | verified | |
| poly1305 | poly1305_update | 23 / 3 | 86.7 | 24.1 | FAIL | symbolic 64-bit `not` |
| ed25519_sign | ge_madd | 7 / 3 | 26.2 | 0.2 | verified | |
| ed25519_sign | ge_p2_dbl | 3 / 2 | 15.3 | 0.1 | verified | |
| ed25519_sign | table_select | 1 / 5 | 91.8 | 0.1 | FAIL | loader models `.ascii` data (the 24 KB k25519Precomp table) |
| ed25519_sign | x25519_ge_scalarmult_base | 2 / 2 | 219.0 | 21.6 | FAIL | loader models `.ascii` data |
| ed25519_sign | x25519_sc_reduce | 1 / 1 | 9.0 | 0.1 | verified | |
| ed25519_sign | ED25519_sign | 5 / 4 | 1,778.3 | 910.5 | FAIL | memset/memcpy contracts with unsigned-length guard |

### Engine changes (all with tests; every newly verified function mutation-checked)

| Change | Why it was needed | Soundness evidence |
|---|---|---|
| Loader models `.ascii`/`.asciz`/`.string` | the table was sized 640 bytes instead of 24 KB, rejecting valid code | loader test |
| memset/memcpy/memmove contracts | 4 functions call libc through the PLT | 11 libc tests incl. overflow rejections |
| Unsigned-length guard for libc calls and `rep` string ops | a symbolic length that may be negative was silently accepted (width <= 0 counted as no access) | rejection tests for both; CVE-2019-6488/2018-11237 tests unchanged |
| Unsigned struct fields >= 0 | poly1305's `buf_used` | |
| Narrow stores keep the constant bytes they do not overwrite | precision; the read assembles values byte by byte | updated store test asserts the exact value and the symbolic case |
| Repeated helper calls counted per call site | X25519's ladder hit the 1001-jump cap | recursion still rejected |
| Symbolic 64-bit `not` (`~x = -x - 1`; 32/16-bit stay unknown) | clang's `~rcx + n` tail guard became undecidable, sending BUMS down an infeasible path | test fails without the change; 32-bit stays unknown (zero-extension) |
| Forced-exit discharge | a path the solver proves must leave the loop was held to the next iteration's obligations, refuting chacha's summary | rejection test for an overrunning last block |
| Down-counter floor bounds (`x >= 1`, `x >= 0`), re-established on continuing paths, kept after the loop only if they hold at the exit | chacha's remainder must stay positive | keeping a head-only bound at exit made post-loop code vacuous; caught by a rejection test and fixed |
| Multi-back-edge inside-body rule | chacha's latch block sits above the body, so every tail jump to it is backward; one was summarised as a latch | test fails without the rule with chacha's exact error |
| **x86 stack lower bound** (`min(live rsp, entry) - 128`) | the x86 stack region was `MAX` long, so any access below `rsp` verified (found by checking SecSep's transformed code, Section 7) | 6 frame tests incl. an 8 MB write rejected; all 21 functions still verify |

Final state: test suite 848 passed, 1 failed (`secsep-eval/bums-tests3.log`; the failure is a nonlinear column-walk test that flips under load and
passes alone), clippy clean.

---

## 4. Performance

Data: `per_function.csv`, `per_benchmark.csv`, `secsep_phases.csv`; figures `fig_time_per_function`,
`fig_benchmark_time`, `fig_secsep_phase_share`.

| Benchmark | Fns | SecSep CPU (s) | BUMS wall (s) | Ratio | SecSep whole-program wall (s) | SMT queries | SMT share | Peak RSS |
|---|---|---|---|---|---|---|---|---|
| salsa20 | 2 | 23.1 | 1.7 | 14x | 30.1 | 4,403 | 97% | 199 MB |
| sha512 | 2 | 200.1 | 13.4 | 15x | 188.8 | 11,150 | 97% | 261 MB |
| chacha20 | 2 | 201.2 | 56.1 | 4x | 177.9 | 11,741 | 96% | 229 MB |
| x25519 | 4 | 749.7 | 128.3 | 6x | 853.5 | 19,842 | 99% | 456 MB |
| poly1305 | 5 | 931.3 | 263.5 | 4x | 1,378.7 | 46,450 | 98% | 909 MB |
| ed25519_sign | 6 | 2,139.6 | 932.6 | 2x | 2,265.5 | 73,477 | 95% | 804 MB |
| **Total** | **21** | **4,245** | **1,396** | **3x** | **4,894** | | | |

- Per function, BUMS is faster on all 21, typically by 10 to 1000x (`table_select` 0.1 s vs 92 s,
  `fe_loose_invert` 3.1 s vs 211 s). The gap narrows on large callers because BUMS re-executes callees inside each
  caller while Octal reuses inferred interfaces; `ED25519_sign` is the closest case (about 2x).
- SecSep's transformation itself takes under 2 s per benchmark.
- BUMS wall times on long functions vary with machine load (`ED25519_sign` measured 891 to 2,226 s across runs).

---

## 5. Annotation effort

Data: `per_benchmark.csv`, `secsep_annotations_by_function.csv`, `secsep_global_markers.csv`,
`secsep_paper_table1.csv`; figures `fig_annotation_burden`, `fig_annotation_vs_time_*`.

**Same 21 functions, both tools annotating each:**

| Benchmark | SecSep clauses | BUMS clauses | SecSep tokens | BUMS tokens |
|---|---|---|---|---|
| salsa20 | 6 | 6 | 62 | 78 |
| sha512 | 7 | 7 | 72 | 90 |
| chacha20 | 12 | 9 | 101 | 120 |
| x25519 | 14 | 10 | 118 | 168 |
| poly1305 | 84 | 13 | 1,084 | 260 |
| ed25519_sign | 19 | 17 | 240 | 232 |
| **Total** | **142** | **62** | **1,677** | **948** |

Clauses: SecSep `@valid`/`@size`/`@taint`/`@const`/`@overlap`/`@sym`/`@unit` tags plus `@secsep_in`/`@secsep_out`
constraints; BUMS argument bindings plus bracketed preconditions. Tokens: identifiers, numbers and symbols; BUMS
tokens include the Rust signature, which is written by hand.

- On four of six benchmarks the contract sizes are close. The difference is poly1305: SecSep annotates each field
  of the 17-field state struct, BUMS declares it once as a typed parameter.
- **SecSep's annotations across its benchmarks:** 43 annotated functions (36 non-default), 160 per-variable lines:
  `@valid` 144, `@taint` 20, `@size` 14, `@const` 12, `@overlap` 5, `@sym` 2, `@unit` 2; one explicit constraint
  (chacha's `out - in >= 32`). Global markers: `SECRET_SYM` 17, `PUBLIC_SYM` 1, `PUBLIC_CONSTSYM` 4.
- **Source changes SecSep needed (their Section 8.4):** remove poly1305's irreducible `goto` and its
  struct/byte-array casts, zero-initialise a salsa20 array, add semantic hints to chacha. BUMS checked the
  resulting compiled assembly; it did not need those changes, but this comparison did not test BUMS on the
  unmodified sources.

---

## 6. What a verdict means

Data: `md5_case_study.csv`, `secsep_inferred_preconditions.csv`.

Octal analyses the whole program from `main`, infers each function's preconditions ("reverse-engineering"
loads and stores, their Section 6.3), adds them to the function's interface, and checks them only against the
call sites in the analysed program. BUMS checks each function against its stated contract, for every caller.

**The md5 case** (BoringSSL's hand-written `md5_block_asm_data_order`; driver `main` passes `num = 4`):

| Variant | Octal | BUMS |
|---|---|---|
| unmodified | type-checks | verifies |
| m1: one extra block read | rejected (inference exception) | rejected: read at `data + 64` out of bounds |
| **m2: `num == 0` guard removed** (reads 64 bytes when `num = 0`) | **accepted**: inferred `num >= 1`, checked only against `main` | **rejected**: read at `data + 0` not within a region of length 0 |
| m3: m2 with `main` passing `num = 0` | rejected at the call site | (same function as m2) |

Octal can see the bug (m3); it moves the obligation to callers and checks only the callers it has. A different
caller passing `num = 0` would read out of bounds, yet the function would remain "well-typed". To accept m2, a
BUMS user must write `[num >= 1]` into the contract, a visible change.

**Inference on SecSep's own benchmarks.** Most of each function's final precondition clauses restate layout
facts (region bounds, no-wraparound, non-overlap, alignment). Beyond those, Octal infers real contract clauses:
for `table_select`, bounds tying the index `pos` to the 24 KB `k25519Precomp` table (the `[pos >= 0, pos < 32]` a
BUMS user writes), and for `CRYPTO_poly1305_update`/`_finish`, bounds on the loaded `buf_used` field
(`buf_used <= 16`, which the BUMS annotation states as `state.2 < 16`). Inference saves writing these, at the cost
of the caller-relative meaning above.

---

## 7. SecSep's transformation: rewrites, runtime overhead, and BUMS on its output

Data: `secsep_rewrites.csv`, `secsep_runtime_overhead.csv`, `transform_check.csv`.

**Rewrites** (all secret-stack accesses moved by delta = -8 MB):

| Benchmark | Functions | Instructions rewritten | Emitted | Stores | Loads | Push/pop | Calls |
|---|---|---|---|---|---|---|---|
| salsa20 | 3 | 74 | 96 | 26 | 13 | 33 | 2 |
| sha512 | 3 | 225 | 295 | 88 | 102 | 28 | 7 |
| chacha20 | 3 | 39 | 65 | 7 | 8 | 22 | 2 |
| x25519 | 5 | 1,564 | 1,663 | 770 | 709 | 56 | 20 |
| poly1305 | 7 | 183 | 498 | 55 | 42 | 47 | 39 |
| ed25519_sign | 11 | 2,411 | 3,257 | 1,052 | 1,119 | 129 | 69 |

**Runtime overhead** (gem5 v22.1 simulation of an 8-issue out-of-order core; read from their Figure 12, averages
exact, per-benchmark bars approximately +-0.2 points; their artifact ships no raw gem5 results, checked at the
pinned `secsep-gem5` commit `e8eea99`):

| | Software overhead (defense off) | With ProSpeCT-style defense |
|---|---|---|
| SecSep, average | 1.0% | 1.2% |
| SecSep, per benchmark | 0.2% (x25519) to 2.3% (ed25519_sign) | 0.1% to 2.5% |
| SecSep without callee preservation | 0.1% | 26.2% |
| ProSpeCT, secret stack (secure) | 0.4% | 151.1% |
| ProSpeCT, public stack (insecure) | 4.2% | 4.4% |

SecSep's overhead is a cost on every execution of the protected code, because it changes that code. BUMS changes
no code; its only runtime cost is the generated wrapper's per-call precondition checks (the BUMS wrapper-overhead
harness exists in the `evaluation` worktree; its earlier results were lost with a cleared scratchpad and need a
clean rerun on a quiet machine).

**BUMS on SecSep's transformed assembly.** Checked raw and with the -8 MB offset folded back (every displacement
within 1 MB of -0x800000 has 0x800000 added; `add $-8388608` becomes `add $0`):

| Variant | Result | Meaning |
|---|---|---|
| Raw | 20 rejected, 1 verified (`chacha_core`, which the transform leaves untouched) | rejected at the secret-stack stores (`write ... at sp - 8388616 not provably within the stack frame`) |
| Folded | 19 of 21 verified; the 2 poly1305 functions hit BUMS's branch-depth limit (32) | every secret-stack access lands on the mirror of a legitimate frame or argument slot, both bounds checked |

Folding cannot show that the right stack was chosen (a missing or doubled shift folds to the same address). The
first raw run also **verified**, which exposed the x86 stack gap in BUMS (Section 3, last row); the raw result
above is after the fix.

---

## 8. Applicability to other code

Data: `octal_parser_coverage.csv`; figure `fig_parser_coverage`.

| Code | Share of instructions Octal cannot parse or does not support |
|---|---|
| SecSep's own compiled benchmarks (6 files) | 0.0% to 0.2% |
| BoringSSL hand-written x86 (14 linux files) | 0.5% (md5) to 80.4% (aesni-gcm) |
| BoringSSL hand-written x86 (14 apple files) | 1.4% to 83.9% |
| OpenBLAS x86 kernels (17 files) | 10.1% to 62.9% |

- Unsupported: AVX, `mulx`/`adcx`/`adox`, `rorx`/`andn`, AES-NI/PCLMUL, `_CET_ENDBR`, Apple `L$` labels. Their
  prototype "only covers the instructions in the benchmarks used for evaluation" (their Section 8.1).
- No AArch64, so BUMS's AArch64 case studies (rav1d, FFmpeg, corecrypto, aws-lc, s2n-bignum) are out of scope.
- Each function needs a hand-built inference input (register types, every stack slot, pointer regions) and a driver
  `main`; functions that realign the stack do not fit its stack model. Only md5 was simple enough to run by hand.

---

## 9. Related work

Data: `related_work.csv` (rendered as `related_work.md` and `tables/related_work.tex`).

| Tool | Input | Property | Automation | Measured |
|---|---|---|---|---|
| **BUMS** | existing assembly (AArch64, x86-64) | memory safety against a per-function contract | automatic once annotated | 21/21 SecSep and 69/71 s2n-bignum functions; 12/12 mutants localised |
| SecSep / Octal | compiled C + annotations + LLVM metadata (x86-64) | memory safety by typing (caller-relative) and secret/public stack separation | inference and checking automatic, whole program | Sections 3 to 8 |
| s2n-bignum (HOL Light) | assembly written for verification (x86-64, AArch64) | functional correctness for all; separate `_SAFE` (constant time + memory safety) for 88/331 AArch64 and 66/341 x86 proof files | interactive | counted below |
| Vale / EverCrypt | assembly written in the Vale DSL (x86-64, ppc64le) | functional correctness, memory safety, side channels | semi-automatic (F*/Z3 + lemmas) | counted below (same algorithm, different code) |
| Islaris | machine code via Isla (Armv8, RISC-V) | functional correctness and memory safety (Iris) | interactive (Coq) | not measured |
| Binsec, angr | binaries | bug finding; proof only with full path coverage | automatic with harness and bounds | not run |
| AddressSanitizer | instrumented C/C++ | runtime out-of-bounds detection in instrumented code | test-driven | 2/12 mutants |
| Valgrind memcheck | unmodified binaries | runtime heap out-of-bounds detection | test-driven | 12/12 with exact-size tests, 3/12 with SecSep's driver |

### 9.1 s2n-bignum: same 71 functions

Data: `s2n_bignum_vs_bums.csv`, `s2n_bignum_safety_effort.csv`; tables `s2n_bignum_effort.tex`.

All 71 s2n-bignum functions in BUMS's `bignum-playground` (AArch64) have both a `_SUBROUTINE_CORRECT` and a
`_SUBROUTINE_SAFE` theorem (67 proof files). BUMS verdicts from the rework-branch sweep of 2026-11-05: 69/71
verified, 2 time out at 300 s (`p384_montjscalarmul`, `p521_jscalarmul`).

| | BUMS | s2n-bignum |
|---|---|---|
| Memory-safety effort | **208 clauses** (3,153 tokens), proof automatic | **9,405 lines** of `_SAFE` statement + proof (3,580 + 5,825) |
| of which automatic one-tactic proofs | | 37 files, 1,993 lines, median 34 per file |
| of which hand-scaffolded loop/branch proofs | | 29 files, 7,169 lines, median 212 per file |
| Functional correctness (not comparable, stronger) | | 3,780 specification + 84,283 tactic lines |

- **What `_SAFE` covers.** Constant time and memory safety together, as one theorem, so its lines cannot be split
  between the two. Their tutorial explains why correctness alone is not memory safety: the correctness spec's
  `MAYCHANGE` cannot catch reads of unpermitted memory, or memory used as scratch space and restored.
- **No enumeration of input sizes.** Straight-line code and fixed-trip loops are proved by symbolic simulation
  (`PROVE_SAFETY_SPEC_TAC`). Length-dependent loops (`bignum_mul`, `bignum_ge`, `bignum_optsub`,
  `copy_row_from_table`, `emontredc_8n`) get a hand-built skeleton with loop invariants
  (`ENSURES_EVENTS_WHILE_UP2_TAC`), valid for every length. Many routines are written per fixed size (`_p384` is
  6 words, `bignum_mul_8_16`), which is what makes the one-tactic style applicable to them.
- **Independent or dependent?** Logically independent: no safety proof uses a `_CORRECT` theorem as a lemma
  (0/67). Practically dependent: every safety specification (67/67) is generated by `mk_safety_spec` from the
  `_CORRECT` theorem (preconditions and `MAYCHANGE`) plus buffer sizes generated from the C header comments
  (`subroutine_signatures`). In 66 files this happens at check time, so the correctness proof must run before the
  safety theorem can be stated; in 1 it was generated offline and pasted. The scaffolding "typically follows the
  flow of the functional correctness proof" (their tutorial). Only 8 files reuse other correctness-side
  definitions, all infrastructure (machine-code fragments, constant tables).
- **Reading the comparison.** The memory-safety-specific human effort on identical code is 208 clauses for BUMS
  vs 9,405 lines for s2n-bignum, concentrated in loops: the 29 scaffolded proofs describe loop structure that BUMS
  infers. s2n-bignum's buffer signatures are effectively an annotation as well.
- Counting rules: comments and the embedded machine-code listing excluded; shared proof libraries (`needs`) not
  counted, so totals are lower bounds.

### 9.2 Vale / EverCrypt: same algorithms

Data: `vale_effort.csv`, `vale_vs_bums_primitive.csv` (HACL* commit `f557259`, x64 only).

| Primitive | Vale procedures | Vale spec lines | Vale code + proof lines | F* lemma lines | BUMS functions | BUMS clauses |
|---|---|---|---|---|---|---|
| AES / AES-GCM | 150 | 3,881 | 6,744 | 8,032 | 48 | 341 |
| SHA-256 | 44 | 704 | 1,555 | 2,080 | 4 | 16 |
| Poly1305 | 9 | 172 | 491 | 1,730 | 2 | 14 |
| Curve25519 | 55 | 1,222 | 2,727 | 1,184 | 25 | 69 |

Vale verifies implementations written in Vale (functional correctness, memory safety, side channels); BUMS
checks existing aws-lc, s2n-bignum, graviola and corecrypto assembly. Same algorithm, different code and often a
different ISA, so this is context, not a head-to-head.

### 9.3 Dynamic tools on the 12 mutants

Data: `dynamic_tools.csv`, `dynamic_tools_summary.csv`; figure `fig_mutation_tools`; harness in
`secsep-eval/dynamic/`.

Setup: emulated x86-64 Ubuntu 24.04 (colima/QEMU), clang 18 AddressSanitizer, Valgrind 3.22. The assembly is
identical to what BUMS and Octal checked (only `main` renamed and two internal functions exported). Two test
settings: **exact-size tests** (a C harness per benchmark calling every annotated function and the public API over
23 lengths, 0 to 1000, each buffer `malloc`'d at exactly its contract size) and **SecSep's driver** (the
benchmark's own `main`, global and stack buffers). A detection is a Valgrind "Invalid read/write" or an ASan
bounds report; an ASan SEGV, stack overflow or bad free is recorded separately.

| Mutant | Fault | BUMS | SecSep | Valgrind exact | Valgrind driver | ASan exact | ASan driver |
|---|---|---|---|---|---|---|---|
| salsa20-A | read word 16 of a 16-word input | at instruction | inference exception | detected | missed | missed | missed |
| salsa20-B | byte loop runs to `message[len]` | at instruction | inference exception | detected | missed | heap corruption | missed |
| sha512-A | tail length mask 255 instead of 127 | at instruction | inference exception | detected | detected | detected (memset) | detected (memset) |
| sha512-B | block count doubled | at instruction | **type checker** | detected | missed | missed | missed |
| chacha20-A | vector read one byte late | at instruction | inference exception | detected | missed | missed | missed |
| chacha20-B | every block 64 bytes (min removed) | at instruction | inference exception | detected | detected | crash | timeout |
| poly1305-A | unrolled tail read at +4 | at instruction | inference exception | detected | missed | missed | missed |
| poly1305-B | single-byte loop counts `n & 7` | at instruction | inference exception | detected | detected | crash | crash |
| x25519-A | peer key read at +29 (4 bytes) | at instruction | inference exception | detected | missed | missed | missed |
| x25519-B | store `s[32]` of a 32-byte output | at instruction | inference exception | detected | missed | heap corruption | missed |
| ed25519_sign-A | read `s[61..64]` of a 64-byte input | at instruction | inference exception | detected | missed | missed | missed |
| ed25519_sign-B | message copy reads one byte past | at instruction | inference exception | detected | missed | detected (memcpy) | missed |
| **Total** | | **12/12** | 12/12 rejected, 1 by checker | **12/12** | **3/12** | **2/12** | **1/12** |

- Octal's 11 non-checker rejections: 7 "slot annotation is None" (valid-region inference could not attribute an
  access to any typed slot), 2 "Unsat invariance", 1 "unsat context", 1 taint-inference "cannot find var".
- No tool reported anything on the 6 unmutated originals.
- **Valgrind** sees every instruction and, with the right tests, localises the fault (it named `salsa20_words` at
  the mutated source line). But it checks only heap bounds and only the inputs a test runs: with SecSep's own
  driver it finds 3 of 12.
- **AddressSanitizer** instruments only compiled C, so it cannot see accesses made by assembly; its two detections
  come from its `memset`/`memcpy` interceptors. Four more mutants show up only as a crash or later heap corruption.
- **BUMS** needs no test inputs: the contract covers every input.

---

## 10. Caveats and threats to validity

1. **Timing units.** BUMS times are wall-clock per function and load-sensitive on long functions; SecSep
   per-function times are CPU time from added timers. Short BUMS times are at the 0.1 s resolution of
   `bums-check`.
2. **Engine changes.** BUMS reached 21/21 after the changes in Section 3 (baseline 12/21). They are general, each
   with tests, not benchmark-specific; report both numbers.
3. **Mutation study size.** 12 mutants is small. Octal's rejections are mostly inference exceptions, which it also
   raises on code it cannot infer, so report "rejected" and "localised the fault" separately. Both tools accept
   every unmutated original.
4. **Inferred-precondition classification** is heuristic (e.g. poly1305's 16-byte alignment uses mask 15 and lands
   in "other").
5. **Transformed-code check.** 19/21 after folding; the two poly1305 functions are inconclusive (branch depth).
   Folding cannot detect a wrong choice of stack.
6. **x86 stack fix.** It changes every x86 verdict BUMS has produced; other x86 playgrounds (openblas, rav1d x86,
   compression) have not been re-swept on it.
7. **Related-work counts.** s2n-bignum and Vale line counts exclude shared libraries (lower bounds); s2n-bignum's
   `_SAFE` covers constant time as well; Vale is same algorithm, different code. s2n-bignum's BUMS verdicts come
   from a sweep in another session (rework engine, 2026-11-05).
8. **Not comparable:** gem5 runtime overhead and declassification (speculative security); Octal on AArch64.
9. **SecSep runtime numbers** are read from their Figure 12 (no raw data shipped).

---

## 11. Reproducing

```
cd msa-secsep/secsep-eval
python3 tools/build_paper_data.py      # per-function, per-benchmark, SecSep stats, mutation, md5, transform check
python3 tools/s2n_bignum_effort.py     # s2n-bignum vs BUMS on the same functions
python3 tools/s2n_safety_effort.py     # s2n-bignum _SAFE proofs: size, style, dependence
python3 tools/vale_effort.py           # needs related/hacl-star (sparse checkout of vale/)
python3 tools/build_dynamic.py         # needs dynamic/results/summary.tsv from dynamic/run_in_vm.sh
python3 tools/build_related_work.py
python3 tools/make_figures.py
```

- SecSep timing: `scripts/run.py full --name <bench> --analysis-dir ../benchmark/analysis --delta 0x800000` with
  `octal-timers.patch` applied.
- BUMS: `bums-check secsep-playground --target x86_64-apple-darwin --jobs 1`.
- Mutants: `tools/make_mutants.py` (each pattern must match exactly once in its function).
- Dynamic tools: `dynamic/prepare.py`, then `dynamic/run_in_vm.sh` inside an x86-64 Linux VM
  (`colima start --profile secsep-x86 --arch x86_64`, currently stopped).

---

## 12. Open items

- Commit the related-work and dynamic-tool round on `secsep-eval` (scripts, data, figures; `.gitignore` already
  allowlists them).
- Re-sweep the other x86 playgrounds on the bounded x86 stack.
- Rerun the BUMS wrapper-overhead harness on a quiet machine, keep results in the repository, and pair it with
  Section 7's runtime table.
- Optional: run BUMS on SecSep's *unmodified* sources (BoringSSL with the original poly1305 `goto` and casts) to
  test the claim that BUMS needs none of their source changes; run Binsec or angr on the mutants as automated
  symbolic-execution baselines.
