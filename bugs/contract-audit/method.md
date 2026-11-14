# Contract audit brief

BUMS (`memsafe-checker`) proves hand-written assembly memory-safe *under a contract* written in a
`#[bums_macros::check_mem_safe("file.S", <args>, [<preconditions>])]` attribute on an `extern`-style
Rust declaration in `*-playground/src/**.rs`. A verified function is only safe in the real program if
the real caller (C in FFmpeg/zlib-ng/ISA-L/zstd/OpenBLAS/aws-lc, Rust in rav1d/graviola/candle)
actually guarantees every precondition. We already found one bug this way: FFmpeg's
`ff_nv24_to_yuv420p_chroma_neon` was annotated `h % 2 == 0`, but swscale passes slice heights,
which can be odd for NV24, and the asm consumes rows in pairs, so it reads one row past the slice
(crashed against a guard page).

## Your job
For every annotated function in your scope, check each precondition **and the contract implied by
the Rust signature** (fixed-size array params like `&[u8; 64]`, tuple/struct layouts, `usize` vs
signed, which pointer is passed where, `.add(k)` offsets in the argument list) against what the
real callers guarantee. Group functions by family (same macro/template, differing in width/bitdepth/
ISA suffix) and audit one representative per family, listing the members.

For each contract clause, classify:
- **UPHELD**: cite the caller code (file:line) that guarantees it (an assert, a table of the only
  sizes ever passed, a type, a documented API requirement that the library itself enforces, …).
- **NOT-UPHELD-SAFE**: callers can violate it, but reading the asm shows the function is still safe
  outside the contract (explain).
- **NOT-UPHELD-UNSAFE** (candidate bug): a reachable caller input violates it AND the asm then
  accesses memory out of bounds (explain the exact input and the access). Note whether the input is
  reachable from a public API / untrusted bitstream, and whether data is read or written.
- **API-CONTRACT**: only guaranteed by documentation the library does not enforce (e.g. "caller
  must pad by 64 bytes") — list them; these are interesting but not bugs.
- **UNCLEAR**: say what you could not determine.

Also flag **unique finds**: assumptions the asm silently relies on that no caller comment or check
states (e.g. padding past the end, alignment, a minimum length), even when callers happen to uphold
them today.

Do not re-report what we already know (listed in the scope section), except to confirm/refute it.

## Rules
- Read-only. Do NOT run cargo, rustc, bums-check, or any build; do not edit the repository.
  Scratch files go under `$CLAUDE_JOB_DIR/tmp/audit/<your-name>/`.
- Upstream sources (shallow checkouts, read-only): `$CLAUDE_JOB_DIR/tmp/src/{ffmpeg,zlib-ng,isa-l,zstd,graviola,openblas,candle}`;
  rav1d at `/Users/shai/Documents/Princeton/rav1d`; aws-lc at `/Users/shai/Documents/Princeton/aws-lc`;
  s2n-bignum at `/Users/shai/Documents/Princeton/s2n-bignum`. The assembly BUMS checked is in each
  playground (`asm/`, `include/`, or `target/bums-check/release/build/<crate>-*/out/`).
- Verdict per function: `<playground>/asm-status.tsv` where present. Only verified functions matter
  most; failing ones matter only if the failure was "fixed" by tightening a clause the caller doesn't uphold.
- Clause inventory (already extracted): `$CLAUDE_JOB_DIR/tmp/audit/<playground>.tsv`
  (columns: playground, file, line, function, clause, kind; kind is a rough classifier: modulo,
  choice, fixed, minimum, maximum, relation, equation, length). Prioritise modulo/choice/fixed/
  minimum/maximum/relation; `length` clauses matter when the asserted length is tighter than what
  callers allocate is *not* a problem, but looser-than-real is.
- Be concrete and cite file:line for every caller claim. Prefer depth on suspicious clauses over
  breadth on obviously-fine ones, but list every family with a one-line verdict.

## Output
Write `$CLAUDE_JOB_DIR/tmp/audit/<your-name>.md` with:
1. A table of candidate bugs (NOT-UPHELD-UNSAFE), most severe first, with the concrete triggering input.
2. Unique finds / API-CONTRACT assumptions.
3. NOT-UPHELD-SAFE list.
4. One line per family: UPHELD with the key citation.
Return a short summary (≤ 25 lines) of section 1 and 2 as your final message.
