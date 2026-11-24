# rav1d playground

Macro examples for [rav1d](https://github.com/memorysafety/rav1d)'s hand-written
aarch64 assembly. Every C-ABI function that the crate links gets one
`#[bums_macros::check_mem_safe]` declaration, so a release build runs the symbex
engine over the whole assembly surface at once and reports what it can and
cannot conclude.

The vendored assembly tracks rav1d 1.1.0 (`src/arm/` from upstream, unmodified).

## Layout

| path | what it is |
| --- | --- |
| `include/src/arm/` | rav1d's assembly, copied verbatim from upstream |
| `include/config.h` | the `#define`s upstream's `build.rs`/meson would set |
| `build.rs` | preprocesses, assembles, then disassembles each `.S` into `OUT_DIR` |
| `src/asm/` | generated `check_mem_safe` declarations, one module per subsystem |
| `gen-annotations.py` | generates `src/asm/` from `asm-symbols.tsv` |
| `report-annotations.py` | categorises a build's diagnostics into `asm-status.tsv` |
| `asm-symbols.tsv` | every exported `dav1d_*` symbol, per object file |
| `asm-status.tsv` | per-declaration verification outcome |
| `reference/` | rav1d's own FFI declarations, kept for cross-checking signatures |
| `src/main.rs` | hand-written examples predating the generated set |

The macro analyses the *disassembly*, not the source: `build.rs` assembles each
`.S`, runs `objdump -d` plus `nm` over the resulting object, and `clean-objdump.py`
turns that back into a flat listing keyed by symbol name. Passing `nm` output
matters because rav1d's `function` macro emits both a global (`_dav1d_foo`) and a
local (`foo`) label at the same address, and objdump prints only one of them —
without the symbol table the first function in every file is shadowed by the
assembler's `ltmp0`.

## Current status

545 declarations cover every C-ABI entry point in the 21 objects the crate links
(573 exported symbols, less the 28 register-convention helpers described at the
bottom). Re-running all of them takes about 30s of `rustc` time, with peak
resident memory around 100 MB. Per-function results are in `asm-status.tsv`.

Each declaration stops at the **first** construct the engine cannot model, so
the table below is a census of first blockers, not a partition of the work:
clearing the top row moves those 199 functions onto whatever they hit next.

| first blocker | count | what it is |
| --- | --- | --- |
| verified | 6 | proved safe under the stated preconditions |
| `adrp <reg>, <const-data label>` | 199 | jump table base address |
| `clz` | 121 | width dispatch, feeds the jump table index |
| `blr` | 120 | indirect call, `itx` dispatch through `adr`+`blr` |
| unresolved branch target (`No label`) | 22 | jump table target after `br` |
| `ubfx` | 20 | bitfield extract |
| `tst` | 18 | flag-setting AND |
| memory safety violation reported | 15 | see below |
| `csel le` / `csel ge` | 6 | condition codes not modelled |
| no memory region named `pw` | 6 | `filmgrain` scalar arg read as a pointer |
| `sub` misclassified as control flow | 4 | remaining operand-shape gap |
| proc macro panicked (uncategorised) | 4 | |
| flag read before it was set | 3 | branch on a flag no instruction set |
| `sxth` | 2 | sign extend halfword |
| address is an unknown value | 2 | `sgr` pointer-array targets |
| `neg` | 1 | |

Per module:

| module | verified | declared |
| --- | --- | --- |
| `itx` | 0 | 312 |
| `mc` | 0 | 103 |
| `ipred` | 4 | 62 |
| `looprestoration` | 0 | 22 |
| `filmgrain` | 0 | 16 |
| `cdef` | 0 | 12 |
| `loopfilter` | 0 | 8 |
| `msac` | 0 | 7 |
| `refmvs` | 0 | 3 |
| `main` (hand-written) | 2 | 4 |

The 15 memory-safety reports are all annotation-modelling limits rather than
findings in rav1d: `top_as_ptr, -2` and `topleft + max_base_xy` are mid-buffer
pointers the macro cannot express, and `a_ptrs`/`ref_sign` are pointer arrays
whose targets a declaration cannot bound.

### Jump tables are the whole story

A reachability pass over the disassembly (follow `b`/`bl`/`adr` edges and
fall-through, stop at `ret`/`b`/`br`) says how far any other work can get.
How many entry points can reach each construct at all:

| construct | entry points that can reach it |
| --- | --- |
| jump table (`adrp`/`br`) | 532 |
| indirect call (`blr`) | 291 |
| `clz` | 170 |
| `neg` | 148 |
| `ubfx` | 82 |
| `csel` | 75 |
| `tst` | 69 |
| `sxth` | 4 |
| `cset` | 3 |

And what implementing them in cheapest-first order would actually buy:

| after implementing | entry points with no remaining blocker |
| --- | --- |
| `neg` | 18 |
| ... plus `tst` | 22 |
| ... plus `csel` | 30 |
| ... plus `sxth`, `ubfx`, `cset`, `clz` | 30 |
| ... plus indirect calls (`blr`) | 41 |
| ... plus jump tables | 573 |

532 of 573 entry points can reach an `adrp`/`br` dispatch. Until that is
modelled, no amount of instruction coverage moves the number much — which is
why clearing all 221 SIMD failures raised `verified` from 4 to 6 rather than
into the hundreds.

What is missing for jump tables is two things: `adrp` against a const-data
label, and the table contents themselves, which `objdump -d` never emits
because the section holds no code. The disassembly pipeline would have to pull
that section separately (`objdump -s -j __TEXT,__const`) and feed it in.

### SIMD

The `unsupported SIMD instruction` category (221 functions, previously the
largest) is now empty. Most of it was never missing semantics: LLVM's
disassembler writes the arrangement on the opcode (`movi.8h v0, #128`) where
canonical ARM writes it on the operand (`movi v0.8h, #128`), and dispatch keyed
on the whole opcode string, so `movi.8h` missed the `movi` handler that already
existed. The parser now normalizes that spelling, and `Arrangement` carries the
lane geometry (`lanes`, `lane_bytes`, `bytes`) every SIMD handler reads.

## Engine bugs found while doing this

- **`label+offset` branch targets were off by one.** A label occupies a slot in
  the instruction vector, so `b foo+0x30` resolved to `foo_line + 12` instead of
  `foo_line + 1 + 12`, landing one instruction early. This produced *false
  positives in the safe direction*: seven `inv_txfm_add_dct_dct_*_16bpc` entry
  points reported as verified were actually skipping their `cbnz w3` dispatch
  into the jump-table path. Fixed; those seven now correctly fail on `adrp`.
- **Vector arithmetic results were discarded.** `vector_arithmetic` mutated a
  clone of the destination register and never wrote it back, so vector
  `add`/`sub`/`mul`/`and`/`orr`/`eor` and `rev64` were silent no-ops.
- **`rev64` reversed the whole register** rather than each 64-bit doubleword.
- **`H4` vector arithmetic indexed a 2-element array with a 4-iteration loop.**
- **Shifts written with a space** (`lsl #1`) tokenized as a label plus an
  immediate, which made `sub x0, x0, x1, lsl #1` classify as control flow.
- **`wzr` was not recognized** as the zero register (only `xzr` was).

## What "verified" covers

Vector loads and stores are now bounds-checked across every byte they touch,
not just their first: `ld1 {v0.16b, v1.16b}, [x2]` spans 32 bytes, and `ld1`/
`st1` with several destination registers previously checked all of them at the
*same* address. Each register now advances by its own width.

Branch guards are not related back to buffer lengths. Where a fast path is
guarded by a count derived from a length — `cmp x2, #2` with `x2 = len/16` —
the engine does not derive `len >= 48` on the taken path, so such paths report
unless the precondition states the bound directly.

## Regenerating

```sh
cargo build --release -p rav1d-playground            # runs the analysis
python3 gen-annotations.py asm-symbols.tsv           # after changing a signature template
cargo build --release -p rav1d-playground --message-format=json > build.json
python3 report-annotations.py build.json             # rewrites asm-status.tsv
```

To re-derive `asm-symbols.tsv` after a rav1d upgrade, run `nm -gU` over the
`*.o` files in the crate's `OUT_DIR` and keep the `T _dav1d_*` entries.

## How the signatures are modelled

The declarations mirror the FFI signatures rav1d itself declares (`wrap_fn_ptr!`
in the matching `src/*.rs`, mirrored in `reference/`), lowered to types the macro
can size at expansion time:

- a strided 2D plane becomes a flat slice plus an explicit stride argument, tied
  together by a `buf.len() == stride * rows` precondition;
- `c_int` dimensions that appear in preconditions become `usize`, so the runtime
  asserts the macro emits type-check;
- arrays of row pointers (sgr's `a_ptrs`/`b_ptrs`, `save_tmvs`'s `rr`) become
  `&[usize]`, which bounds the pointer array but not its targets;
- trailing `_dst`/`_src` arguments in rav1d's declarations exist only for the
  Rust fallbacks and are not passed to the assembly, so they are omitted.

Two shapes are deliberately approximated, and both under-approximate the region
the assembly may legitimately touch:

- **Mid-buffer pointers.** rav1d passes `topleft` pointing at the corner of an
  edge buffer and reads both above and below it; `src` for the 8-tap filters
  points past three rows and three columns of padding. The macro can express a
  pointer to the start of a slice or to its end, but not to a point inside it,
  so these are modelled from the passed pointer onwards.
- **Negative strides.** rav1d uses negative picture strides; strides here are
  `usize`.

## The 28 undeclared symbols

`itx.S` exports 28 transform kernels (`inv_dct_8h_x8_neon`,
`inv_txfm_dct_clear_8h_x64_neon`, and friends) that the sibling `.S` files `bl`
into. They take their operands in `v0`–`v15` rather than through the C ABI, so
there is no Rust signature to write for them; they are covered only indirectly,
as callees of the `inv_txfm_add_*` entry points.
