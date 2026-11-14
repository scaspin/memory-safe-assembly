# Memory-safety bugs found with BUMS

This is the master list of memory-safety problems that BUMS annotations have exposed in real
assembly, across the case-study playgrounds. Each entry says where the bug lives, how to
reproduce it, whether it can crash a program, and how the annotation found it (or would have
prevented it).

All findings were collected 2026-11-12. Library versions:

| Library | Version checked |
|---|---|
| FFmpeg | `ee8cbd7d` (2026-10-14), the revision in `ffmpeg-playground/include/FFMPEG_REVISION`; Homebrew FFmpeg 7.1.1 for the older-release repros |
| rav1d | `/Users/shai/Documents/Princeton/rav1d` at `acd57b1b`, annotations from the `rav1d-int` worktree |
| ISA-L | master (the playground was built from `96be773`; the asm compared equal) |
| zlib-ng | 2.3.3 |
| OpenBLAS | develop `6c302c8` |
| candle | main `cfcbd71` |
| aws-lc | `/Users/shai/Documents/Princeton/aws-lc` at `f1468511a`; A4 re-run on main `13187c3` (2026-11-12) |
| aws-lc-rs | main `4d26a24` (1.19.0, 2026-11-12) |
| OpenSSL | Homebrew 3.4.1, 4.1.0 (and 1.1.1w), for the A4 cross-check |

## Contents

- [How annotations find bugs](#how-annotations-find-bugs)
- [Summary table](#summary-table)
- [A. Confirmed by crash](#a-confirmed-by-crash)
- [B. Found by a failing verification](#b-found-by-a-failing-verification)
- [C. Found by auditing annotation clauses against callers](#c-found-by-auditing-annotation-clauses-against-callers)
- [D. Known CVEs that BUMS rejects](#d-known-cves-that-bums-rejects)
- [E. Assumptions that are documented but not enforced](#e-assumptions-that-are-documented-but-not-enforced)
- [F. Reported earlier, withdrawn](#f-reported-earlier-withdrawn)
- [How annotations prevent these bugs](#how-annotations-prevent-these-bugs)
- [Files in this directory](#files-in-this-directory)

## How annotations find bugs

A `#[bums_macros::check_mem_safe("file.S", <args>, [<preconditions>])]` attribute is a contract
for one assembly function:

- **Arguments.** Each Rust parameter becomes a register value; slices become memory regions of
  `len * size_of(elem)` bytes.
- **Preconditions.** The `[...]` list states what the caller promises, for example
  `h % 2 == 0` or `len >= 32`.

BUMS executes the assembly symbolically under those preconditions. It proves that every load
and store stays inside a declared region, or reports the first access it cannot prove, as
`line N (insn): read of K bytes at <address> not provably within region of length <len>`.

That gives two ways a bug shows up:

1. **The verification fails** under a contract that matches what the real caller does. The
   unprovable access is the bug. Sections [B](#b-found-by-a-failing-verification) and
   [D](#d-known-cves-that-bums-rejects) came out this way.
2. **The verification succeeds, but only because of a precondition the real caller does not
   guarantee.** The proof is then correct but does not cover a reachable input. We audited every
   precondition clause in every playground against the actual C/Rust callers
   (`contract-audit/`), and each "not upheld" clause was checked for what the assembly does
   outside the contract. Sections [A](#a-confirmed-by-crash) and
   [C](#c-found-by-auditing-annotation-clauses-against-callers) came out this way. The three
   crash-confirmed swscale bugs all hid behind a "height is even" clause, which holds for the
   frame but not for the slice the kernel actually receives.

A refinement of (2), the **wrapper audit**, drove the aws-lc findings (A4, A5). These asm
functions are mostly not the intended public API — wrapper code is. For each one we traced
outward to every public entry point and asked whether the precondition is enforced on that path.
The bug class is a *thin* public wrapper that reaches the asm skipping a check its *buffering*
sibling performs: `AES_cbc_encrypt`/`EVP_Cipher` vs `EVP_*Update` (A4), `SHA256_TransformBlocks`
vs `SHA256_Update` (A5). The audit found this pattern is real but narrow — it hits only the
documented low-level entry points, not the whole asm surface (see
[the near-misses](#wrapper-audit-near-misses-checked-and-cleared) for why ECB and GCM, which
look identical, are safe).

## Summary table

"Crash?" means: **yes** = reproduced as a fault; **can** = an out-of-bounds write or a read
that can run off a mapping, not reproduced; **edge** = a small read past an object, which faults
only at a page boundary; **no** = stays inside the allocation.

| # | Where | Bug | Access | Crash? | Found by |
|---|---|---|---|---|---|
| A1 | FFmpeg `ff_nv12_to_rgba_neon` and the other NV12/NV21 → RGB 2-line kernels | odd destination slice under threaded scaling | **heap write**, one RGB row | **yes** | caller audit |
| A2 | FFmpeg `ff_rgb24toyv12_neon` | odd picture height | read, one source row | **yes** | caller audit |
| A3 | FFmpeg `ff_nv24_to_yuv420p_chroma_neon` | odd slice height | read, one source row | **yes** | caller audit |
| A4 | aws-lc `aes_hw_cbc_encrypt` via `AES_cbc_encrypt` / `EVP_Cipher` (aarch64); same in OpenSSL `EVP_Cipher` | length not a multiple of 16 | read, up to 15 B past `in` (C fallback writes past `out`) | **yes** | caller audit |
| A5 | aws-lc `sha256_block_data_order` via `SHA256_TransformBlocks` (aarch64, x86-64) | `num_blocks == 0` | unbounded read past `data` | **yes** | wrapper audit |
| B1 | rav1d `save_tmvs_neon` | 8-byte load of 7-byte `ref_sign` | read, 1 B | no | failing verification |
| B2 | rav1d `ipred_z2_fill1_{8,16}bpc_neon` | 64-wide path reads before `buf` | read, ≤ 4 B | edge | failing verification |
| B3 | FFmpeg `ff_vector_dmul_scalar_neon` | reads 32 B past `src` | read | edge | failing verification |
| B4 | FFmpeg `ff_opus_postfilter_neon` | reads 4th float of `pf_gains[3]` | read, 4 B | edge | failing verification |
| B5 | FFmpeg `ff_sbr_hf_apply_noise_{0..3}_neon` | touches `Y[64]` when `kx + m_max == 64`, odd `m_max` | read/write | can | failing verification |
| B6 | FFmpeg `ff_vvc_put_epel_hv*_8_neon` (12 fns) | 8-byte load of 4-tap `vf` | read, 4 B | edge | failing verification |
| B7 | FFmpeg `ff_alf_filter_chroma_kernel_{8,10,12}_neon` | reads 8 clip values of 6 | read, 4 B | edge | failing verification |
| B8 | FFmpeg `ff_vp9_{put,avg}_{regular,sharp,smooth}4_h_{10,12}_neon` (12 fns) | 16-byte loads past FFmpeg's 1-pixel slack | read | edge | failing verification |
| B9 | FFmpeg `ff_hevc_put_hevc_qpel_bi_h24_8_neon` | `src2` advances 464 B per row pair instead of 256 | read | can (dead code) | failing verification |
| B10 | corecrypto `ccaes_arm_decrypt_key` | reads `[sp, #-16]` after popping its frame | read, red zone | no on Apple | finding (non-blocking) |
| C1 | ISA-L `gf_vect_mul_{sse,avx,avx2_gfni}` | `len == 0` passes the alignment check | **write** 32 B | can | caller audit |
| C2 | OpenBLAS x86-64 `?amax/?amin/?max/?min` (`amax_sse2.S`, `amax_sse.S`, `zamax_sse.S`) | negative `incx` not handled | read before `x` | can | caller audit |
| C3 | candle `<f16 as VecOps>::vec_add` | safe API passes only `lhs.len()` | **write** past `res` | can | caller audit |
| C4 | candle `<f16/f32 as GgmlType>::vec_dot` | length check is `debug_assert!` only | read | can | caller audit |
| C5 | FFmpeg Opus `vector_fmac_scalar` call | length may be 8 mod 16 | read/write | unclear | caller audit |
| D1–D3 | glibc / OpenSSL | CVE-2019-6488, CVE-2018-11237, CVE-2026-28386 | read/write | yes (historic) | failing verification |

---

## A. Confirmed by crash

Reproduce all three at once:

```sh
sh bugs/repros/swscale/run.sh
```

The script fetches FFmpeg `ee8cbd7d`, builds only `libswscale` and `libavutil` (static, about
2 minutes), builds two small harnesses, and runs each bug next to an even-sized control.
Expected output:

```
control  nv24 slices 2+2              : exit 0
BUG      nv24 slices 3+1              : exit 138
control  bgr24->yuv420p 640x480       : exit 0
BUG      bgr24->yuv420p 640x481       : exit 138
control  nv12->rgba 1920x1024, 1 thr  : exit 0
BUG      nv12->rgba 1920x1024, 6 thr  : exit 138
safe     yuv420p->rgba 1920x1024, 6   : exit 0
```

Exit 138 is SIGBUS: the harness puts every buffer the bug overruns right before a `PROT_NONE`
guard page, so the first out-of-bounds byte faults. Set `WORK=<dir>` to choose where the
checkout and build go (default `bugs/repros/swscale/work`).

A2 and A3 also reproduce against a stock FFmpeg 7.1.1 (`brew install ffmpeg`):

```sh
cc bugs/repros/swscale/nv24_slice.c $(pkg-config --cflags --libs libswscale libavutil) -o nv24_slice
./nv24_slice 3      # bus error
cc bugs/repros/swscale/odd_rows.c $(pkg-config --cflags --libs libswscale libavutil) -o odd_rows
./odd_rows rgb24 640 481   # bus error
```

### A1. NV12/NV21 → RGB writes one row past the frame under threaded scaling (heap write)

- **Where.** `libswscale/aarch64/yuv2rgb_neon.S`, macro `declare_2l_packed` (the "2-lines"
  kernels `ff_{nv12,nv21}_to_{argb,rgba,abgr,bgra,rgb24,bgr24,…}_neon`). The loop is
  `subs height, height, #2; b.gt 1b`, so it always produces rows in pairs. Its comment says
  "Precondition: slice height is even."
- **Why it is reachable.** In the graph scaler, `libswscale/graph.c:228-235` splits the
  destination into `ceil(lines / threads)` rows rounded to `dst_slice_align`. For YUV→RGB that
  alignment is set to 2 only inside the generic C setup
  (`libswscale/swscale_unscaled.c:2426-2431`), which covers YUV420P, YUV422P and YUVA420P. NV12
  and NV21 get the NEON kernel from the aarch64 init, and their alignment stays
  `1 << chrDstVSubSample = 1` (`libswscale/utils.c:1297`).
- **Trigger.** `sws_scale_frame` (graph API, no `sws_init_context`) NV12 → RGBA, 1920×1024,
  `threads = 6`. The slices are 171 rows, and the last is 169. The kernel writes 170 rows of the
  last slice, which is one row (7680 B) past the end of the destination. Every interior odd
  slice also writes over the next slice's first row, which is a data race and corrupts output.
- **Fault.** `st4 {v4.8b-v7.8b}, [x17], #32` in `ff_nv12_to_rgba_neon`, on a worker thread.
- **Not affected.** YUV420P → RGBA with the same sizes (protected by the generic alignment),
  and FFmpeg 7.1.1 (which has no NEON YUV→RGB kernel for these formats).
- **Annotation.** `ffmpeg-playground/src/yuv2rgb.rs:9` declares `h % 2 == 0`. The kernel is
  correct for that contract; the contract is false for the inputs swscale produces.
- **Fix in FFmpeg.** Set `c->dst_slice_align = 2` wherever the aarch64 init installs a 2-line
  kernel, or teach the kernel to finish an odd last row.

### A2. `ff_rgb24toyv12_neon` reads one row past an odd-height source

- **Where.** `libswscale/aarch64/rgb2rgb_neon.S:143`. It processes two rows per iteration with
  `x10 = src + srcStride` (line 164) and has no odd-row tail. The C fallback handles odd heights
  explicitly (`libswscale/rgb2rgb_template.c:596-599`).
- **Trigger.** A single-threaded `sws_scale` from BGR24 to YUV420P, same size, even width,
  without `SWS_ACCURATE_RND`, and an odd height, for example 640×481. This is the ordinary
  public API with no slicing involved.
- **Fault.** `ld3 {v26.16b-v28.16b}, [x10], #48`: the second-row load, one row past the
  source. The same iteration also writes one luma row past `ydst`, but the read faults first.
- **Annotation.** `ffmpeg-playground/src/swscale.rs:165` declares `height % 2 == 0`.

### A3. `ff_nv24_to_yuv420p_chroma_neon` reads one row past an odd slice

- **Where.** `libswscale/aarch64/swscale_unscaled_neon.S:23`. The loop does
  `subs w7, w7, #2; b.gt 1b` and reads rows `x4` and `x9 = x4 + stride` together.
- **Why it is reachable.** The wrapper is installed only for even `src_h` and widths that are a
  multiple of 16, but it is called with `srcSliceH`. `scale_internal` checks slice alignment
  only against the source's vertical chroma subsampling, and NV24 has none, so any slice height
  is accepted.
- **Trigger.** `sws_scale` NV24 → YUV420P with two calls: rows 0–2, then row 3. The second
  call reads row 4, which the caller never provided.
- **Fault.** `ld2 {v2.16b, v3.16b}, [x9], #32` at the first byte of the guard page.
- **Annotation.** `ffmpeg-playground/src/misc.rs:88-92` declares `h % 2 == 0`.

### A4. aws-lc CBC reads past `in` when the length is not a multiple of 16 (aarch64)

Reproduce (builds aws-lc's `libcrypto` from a local checkout, about 3 minutes):

```sh
AWSLC=/Users/shai/Documents/Princeton/aws-lc sh bugs/repros/aws-lc/run.sh
```

**Minimal crash** (`bugs/repros/aws-lc/minimal.c`). The whole bug is one call,
`AES_cbc_encrypt(in, out, 20, …)` reading past an input buffer of exactly 20 bytes. The only
scaffolding is a guard page right after that buffer, so the illegal read lands on unmapped
memory instead of silently-readable heap:

```c
#include <openssl/aes.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void) {
    size_t len = 20;                       // >= 16, not a multiple of 16
    long pg = sysconf(_SC_PAGESIZE);
    unsigned char *p = mmap(0, 2*pg, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
    mprotect(p + pg, pg, PROT_NONE);       // guard page right after the first page
    unsigned char *in = p + pg - len;      // exactly `len` readable bytes, then the guard
    memset(in, 0x5a, len);
    unsigned char out[64], iv[16] = {0};
    unsigned char key[16] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
    AES_KEY k;
    AES_set_encrypt_key(key, 128, &k);
    AES_cbc_encrypt(in, out, len, &k, iv, AES_ENCRYPT);  // reads in[16..32), past in[20)
    return 0;
}
```

```sh
cc -I<aws-lc>/include bugs/repros/aws-lc/minimal.c <path-to>/libcrypto.a -Wl,-w -o minimal
./minimal    # SIGBUS (exit 138) on a machine with AES instructions
```

`in` holds exactly 20 bytes, which is all the caller promised for `len = 20`. The assembly
still reads `in[16..32)`, 12 bytes past the buffer. Without the guard page that read lands on
adjacent heap or stack and usually returns normally; a build with `-fsanitize=address` aborts
too. The guard page just makes the existing over-read observable.

**OpenSSL has the same bug.** The ARMv8 CBC assembly began in OpenSSL (`aesv8-armx.pl`); aws-lc
inherited it from BoringSSL. On an Apple arm64 machine, `bugs/repros/aws-lc/minimal_openssl.c`
(same buffer, reached through `EVP_Cipher` with `EVP_aes_128_cbc()`) faults on Homebrew OpenSSL
3.4.1 and 4.1.0 at `aes_v8_cbc_encrypt+396: ld1 {v16.16b}, [x0], x8` — the same instruction and
offset as aws-lc's `aes_hw_cbc_encrypt+396`, only the symbol name differs. So BUMS verifying
aws-lc's `aesv8-armx.S` is effectively verifying OpenSSL's copy too. The two libraries route the
*legacy* `AES_cbc_encrypt` C API differently, though (both are documented UB when `len % 16 != 0`):

| Call (buffer is exactly `len`, `len = 20`) | aws-lc | OpenSSL 3.4.1 / 4.1.0 |
|---|---|---|
| `AES_cbc_encrypt`, encrypt | over-reads `in` (hw asm) | over-**writes** `out` ~12 B (C `CRYPTO_cbc128_encrypt` pads a tail block) |
| `AES_cbc_encrypt`, decrypt | over-reads `in` | over-reads `in` |
| `EVP_Cipher` (`EVP_aes_128_cbc`), either direction | over-reads `in` (hw asm) | over-reads `in` (hw asm) |
| `EVP_CipherUpdate` / `EVP_DecryptUpdate` | safe (buffers partial blocks) | safe |

The harness tries three public entry points, encrypt and decrypt, lengths 32 (control), 20,
17 and 31. Each case runs in a forked child, once with a guard page right after `in` and once
right after `out`. Result on an Apple arm64 machine (aws-lc `f1468511a`):

| Entry point | len 32 | len 17 / 20 / 31, guard after `in` | guard after `out` |
|---|---|---|---|
| `AES_cbc_encrypt` (encrypt and decrypt) | ok | **fault** | ok |
| `EVP_Cipher` with `EVP_aes_128_cbc()` (encrypt and decrypt) | ok | **fault** | ok |
| `EVP_CipherUpdate` | ok | ok | ok |

- **Where.** `aes_hw_cbc_encrypt` (`generated-src/ios-aarch64/crypto/fipsmodule/aesv8-armx.S`,
  from `aesv8-armx.pl`). It aborts only when `len < 16`, rounds the remaining length down with
  `and x2, x2, #-16`, and loads the next input block with `ld1 {v16.16b}, [x0], x8`, where
  `x8` is 0 only when `len` is exactly 16. For `len = 20` it loads `in[16..32)`, 12 bytes past
  the buffer. Output is written only in whole blocks, so nothing is written past `out`.
- **Fault.** `aes_hw_cbc_encrypt+396: ld1 {v16.16b}, [x0], x8`, at the first byte of the guard
  page.
- **Reachable from.** `AES_cbc_encrypt` calls `aes_hw_cbc_encrypt` directly whenever the CPU
  has AES instructions (`crypto/fipsmodule/aes/mode_wrappers.c:95-105`), and `EVP_Cipher` on a
  CBC context reaches the same function. Both document a length that is not a multiple of the
  block size as undefined (`include/openssl/aes.h:127`, `include/openssl/cipher.h:459-461`) and
  neither checks it. `EVP_CipherUpdate` buffers partial blocks itself and is safe.
- **Other targets (not run).** The caller audit found the same pattern in `vpaes_cbc_encrypt`
  (processes ceil(len/16) blocks, reads and writes up to 15 B past both buffers) and in x86
  aesni CBC encrypt (zero-pads the tail, writes up to 15 B past `out`).
- **Still present upstream.** The same results reproduce on aws-lc main `13187c3`
  (2026-11-12).
- **Not reachable from safe Rust.** aws-lc-rs main `4d26a24` (1.19.0, 2026-11-12) returns
  `Err(Unspecified)` for CBC/ECB when `in_out.len() % block_len != 0` (`aws-lc-rs/src/cipher.rs:1345`
  for encrypt, `:1421` for decrypt) before calling `AES_cbc_encrypt` (`cipher/aes.rs:291-315`);
  PKCS7 mode pads first, and the streaming API uses `EVP_EncryptUpdate`/`EVP_DecryptUpdate`.
  Only the raw `unsafe` bindings in `aws-lc-sys` can reach the bug. Confirmed by
  `bugs/repros/aws-lc-rs` (`cargo run --release` there): with the buffer ending at a guard page,
  `EncryptingKey::cbc` / `DecryptingKey::cbc` return `Err(Unspecified)` for lengths 17/20/31,
  `PaddedBlockEncryptingKey::cbc_pkcs7` pads and succeeds, and `aws_lc_sys::AES_cbc_encrypt`
  with the same lengths faults.
- **Annotation.** `crypto-playground/src/aes.rs:54-56` declares `input.len() % 16 == 0`.
- **Severity.** This is documented undefined behaviour, so the API is being misused, but the
  misuse is reachable through public functions and crashes. What happens depends on the backend
  `AES_cbc_encrypt` picks:
  - with AES instructions (this repro): reads up to 15 B past `in`;
  - vpaes encrypt, through `CRYPTO_cbc128_encrypt` (`crypto/fipsmodule/modes/cbc.c:79-86`):
    pads the tail and **writes a full 16-byte block**, up to 15 B past `out`;
  - `aes_nohw_cbc_encrypt`: only `assert(len % 16 == 0)` (`aes_nohw.c:1233`), so release
    builds silently drop the tail.

### A5. aws-lc `SHA256_TransformBlocks(state, data, 0)` runs off the end (aarch64 and x86-64)

Reproduce (`bugs/repros/aws-lc/sha256_transformblocks_zero.c`, links the same local aws-lc build):

```c
#include <openssl/sha.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void) {
    long pg = sysconf(_SC_PAGESIZE);
    unsigned char *p = mmap(0, 2*pg, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
    mprotect(p + pg, pg, PROT_NONE);
    unsigned char *data = p + pg;           // 0 readable bytes; guard starts here
    uint32_t state[8] = {0};
    SHA256_TransformBlocks(state, data, 0);  // documented low-level public API
    return 0;
}
```

```sh
cc -I<aws-lc>/include bugs/repros/aws-lc/sha256_transformblocks_zero.c <path>/libcrypto.a -Wl,-w -o sha0
./sha0    # SIGBUS (exit 138)
```

- **Where.** `sha256_block_data_order` (`sha256-armv8.S`, from `sha512-armv8.pl`; x86-64
  `sha256-x86_64.S` is the same shape). The prologue computes the end pointer
  `add x2, x1, x2, lsl #6` — for `num_blocks = 0`, `end = data`. The loop is a do-while that
  reads a block *before* the bound test (`.Loop:` reads `[x1], #64`, then `cmp x1, x2; b.ne .Loop`),
  so it reads one block even when `num_blocks == 0` and then keeps going (`x1` chases `x2` all the
  way around the address space). The hw variant does `sub x2, x2, #1`, underflowing 0 to 2^64-1.
- **Fault.** `sha256_block_data_order_hw+20: ld1 {v4.16b-v7.16b}, [x1], #64`, the first block
  load, at the first byte of the guard page.
- **OOB access.** Unbounded **read** past `data` (SHA writes only the 32-byte `state`; input is
  read-only). With `data` on a page boundary it faults on the first block.
- **Reachable from.** `SHA256_TransformBlocks` is `OPENSSL_EXPORT` (`include/openssl/sha.h:170`),
  documented "you should not use this function unless you are implementing a derivative of
  SHA-256", and its wrapper passes `num_blocks` straight to the asm with no `>= 1` guard
  (`crypto/fipsmodule/sha/sha256.c:419-422`). The safe path is `SHA256_Update`/`Final`, which
  buffer through `md32_common` and only ever call the block function with `n >= 1`.
- **Annotation.** `crypto-playground/src/sha256.rs:210-215` (and `x86_64.rs:33-36`) declare
  `input.len() >= 64`, i.e. at least one block.
- **Scope.** aws-lc / BoringSSL only: `SHA256_TransformBlocks` does not exist in OpenSSL (no
  decl in 3.4.1 or 4.1.0 headers). `SHA1_Transform`, `SHA256_Transform`, `MD5_Transform`
  hard-code a single block, and there is no public `SHA1_/MD5_TransformBlocks`, so those have no
  hole. Not surfaced in aws-lc-rs.
- **Severity.** Same class as A4: a documented low-level public C API that skips the minimum-
  block check the asm assumes. A real OOB needs an external caller passing `num_blocks = 0`;
  every aws-lc-internal caller passes `>= 1`.

### Wrapper audit: near-misses checked and cleared

The same "does a public wrapper reach the asm with a precondition-violating input" audit covered
the rest of aws-lc's symmetric and bignum/EC/hash asm. Two cases reach the asm with a violated
precondition but do **not** OOB — the asm self-protects — and they sharpen why A4 is real:

- **AES-ECB (`aes_hw_ecb_encrypt`).** `EVP_Cipher` passes a non-block-multiple `len` to the asm
  with no `len % 16` check (`aes_hw_ecb_cipher` only checks `len >= 16`), exactly like CBC. But
  the aesni ECB asm's *first* instruction is `andq $-16, %rdx`: it truncates `len` to a block
  multiple and touches at most `len` bytes. The CBC asm has no such truncation and a partial-tail
  path — that one missing `and -16` is the whole difference between A4 and a safe function.
- **AES-GCM kernels (`aes_gcm_enc_kernel` / `dec_kernel`, annotated `len > 64`).**
  `hw_gcm_encrypt` passes `len & ~15` to the kernel, so a 16/32/48/64-byte GCM message reaches it
  and violates the `> 64` clause. The kernel's tail loads the first block unconditionally and
  gates every further load on bytes-remaining (`cmp x5, #48/#32/#16`), so a 16-byte message does
  exactly one 16-byte load. **Tested:** EVP AES-128-GCM one-shot of 16/32/48/64 bytes with both
  buffers ending at a guard page — all safe. The `> 64` clause is BUMS conservatism, not a real
  minimum.

Everything else is **enforced** (CTR passes only whole blocks + a 16-byte scratch tail;
`aesv8_gcm_8x_*` only runs at `len >= 256`; key setup rejects bad bit sizes; ChaCha/Poly1305
lengths are structural) or **internal-only** (`bn_mul_mont`'s `num` is bounded by
`BN_MONT_CTX`; `ecp_nistz256_*`, the s2n-bignum montmul chain, `bignum_copy_row_from_table*`,
and the fixed-size p256/p384/p521/curve25519 ops are only reached with validated sizes). So the
"thin public wrapper skips the buffering layer's check" pattern is real but narrow: it showed up
at `AES_cbc_encrypt`/`EVP_Cipher` (A4) and `SHA256_TransformBlocks` (A5), both documented
low-level entry points, not across the whole asm surface.

---

## B. Found by a failing verification

These failed verification under a contract that matches the caller. The failure message is
the bug report. To see it, run the function with `bums-check`:

```sh
cargo build --release -p bums-check
target/release/bums-check ffmpeg-playground --features float_dsp --filter '^ff_vector_dmul_scalar_neon$' --jobs 1 --mem-gb 3
```

None of these was turned into a crashing program. Section B was not re-run on 2026-11-12; the
messages below are from the recorded runs in `*/asm-status.tsv`.

| # | Annotation | BUMS message |
|---|---|---|
| B1 | `rav1d-playground/src/asm/refmvs.rs:11` (rav1d-int) | `line 47 (ld1): read of 8 bytes at ref_sign_as_ptr + 0 not provably within region of length ref_sign_len * 1` |
| B2 | `rav1d-playground/src/asm/ipred.rs:308` (rav1d-int) | `read of 16 bytes at left_as_ptr + 17 not provably within region …` |
| B3 | `ffmpeg-playground/src/float_dsp.rs:17` | `line 79 (ld1): read of 16 bytes at src_as_ptr + 64 not provably within region of length src_len * 8` |
| B4 | `ffmpeg-playground/src/audio.rs:65` | `line 27 (ld1): read of 16 bytes at gains_as_ptr + 0 not provably within region of length gains_len * 4` |
| B5 | `ffmpeg-playground/src/audio.rs:119` | `line 315 (ld1): read of 16 bytes at row_as_mut_ptr + 2 * kx * 4 + 0 not provably within region of length row_len * 4` |
| B6 | `ffmpeg-playground/src/vvc.rs:149` (and the other widths) | `line 4892 (ld1): read of 8 bytes at vf_as_ptr + 0 not provably within region of length vf_len * 1` |
| B7 | `ffmpeg-playground/src/vvc_alf.rs:9` | `line 603 (ldr): read of 16 bytes at clip_as_ptr + 0 not provably within region of length clip_len * 2` |
| B8 | `ffmpeg-playground/src/vp9.rs:837` (and the 11 others) | `line 90 (ld1): read of 16 bytes at src_as_ptr + … + 10 not provably within region of length src_len * 2` |
| B9 | `ffmpeg-playground/src/hevc_mc.rs:809` | `line 926 (ld1): read of 16 bytes at src2_as_ptr + loop0_? * 464 - 464 not provably within region of length src2_len * 2` |

Notes per bug:

- **B1 `save_tmvs_neon`.** The byte read past `mfmv_sign: [u8; 7]` is `pocdiff[0]`, the next
  field of the same struct, so the read is harmless in rav1d's layout. It is still a read
  outside the Rust object.
- **B2 `ipred_z2_fill1`.** The 64-wide path checks the base of the first row but loads the
  paired row at `(xpos - dx) >> 6` unchecked. With `top = &buf[65]` of `buf[3 * 65]`, 15
  combinations of (w, h, dx) read up to 4 bytes before `buf`, for example 64×16, angle 171,
  dx = 372, rows 10/11. It surfaced only after the annotation's `dx, dy <= 102` (the upsampled
  bound) was corrected to the real `1..=1023`.
- **B5 `sbr_hf_apply_noise`.** The decoder allows `kx + m_max == 64` with odd `m_max`, which
  makes the 2-wide NEON loop touch `Y[64]`.
- **B8 VP9.** FFmpeg intentionally allows a 1-pixel over-read on aarch64 and guards it in
  `libavcodec/vp9recon.c:318-327`. The 10/12-bit 4-wide `_h` kernels read more than that 1
  pixel, which the guard does not account for.
- **B9 `qpel_bi_h24`.** In `libavcodec/aarch64/h26x/qpel_neon.S:606-705`, the first `src2`
  load post-increments by 256, so the load for columns 16–23 reads row r+2 instead of row r. The
  pointer then advances 464 B per row pair instead of 256. With height 64 that reads past the
  8 KB `src2` buffer; with height ≤ 32 it reads wrong data. The function is exported but never
  registered: `hevcdsp_init_aarch64.c` maps width 24 to `h12`. It is still present in master.
- **B10 corecrypto red zone.** The read is legal under Apple's arm64 ABI (128-byte red zone)
  and not under AAPCS64. BUMS reports it as a non-blocking finding (a "bums finding in …"
  warning) rather than a failure.

---

## C. Found by auditing annotation clauses against callers

In each of these the verified contract excludes an input that a public API accepts. The
findings come from reading the source and the assembly; none was turned into a crashing program.

### C1. ISA-L `gf_vect_mul` with `len == 0` writes 32 bytes (x86-64)

- **Where.** `erasure_code/gf_vect_mul_{sse,avx}.asm`, `gf_vect_mul_avx2_gfni.asm`. The only
  length check is `and len, 0x1f; jne fail` (`compression-playground/asm/gf_vect_mul_avx-x86_64.S:4-6`).
  `loop32` is a do-while, so for `len == 0` it reads 32 B of `src` and writes 32 B to `dest`
  before testing the count.
- **Reachable from.** The public `gf_vect_mul(int len, …)` dispatches here
  (`erasure_code/ec_multibinary.asm:87`). The header only requires `len` to be "aligned to 32B"
  (`include/gf_vect_mul.h`), and 0 is aligned. The C version `gf_vect_mul_base` does nothing for
  0 (`erasure_code/ec_base.c:350-358`). No ISA-L-internal caller passes 0.
- **Annotation.** `compression-playground/src/erasure_code.rs:940-948` declares `len >= 16`.
- **Repro sketch (x86-64 with ISA-L installed; not run).**
  ```c
  unsigned char tbl[32], *src = guarded(0), *dst = guarded(0);
  gf_vect_mul_init(2, tbl);
  gf_vect_mul(0, tbl, src, dst);   /* writes 32 bytes into the guard page */
  ```

### C2. OpenBLAS `?amax`/`?amin`/`?max`/`?min` read before `x` for negative `incx` (x86-64)

- **Where.** `interface/max.c` returns early only for `n <= 0` or `incx == 0`, then calls
  `MAX_K(n, x, incx)` without moving `x` to the far end, which other BLAS interfaces do for
  negative increments. `kernel/x86_64/amax_sse2.S` scales `INCX` (line 61), takes the contiguous
  path only for `INCX == SIZE` (line 83), and otherwise steps with `addq INCX, X`. The same
  applies to `amax_sse.S` and `zamax_sse.S`. The aarch64 kernels return 0 for this call.
- **Trigger.** `damax_(&n, x, &(-1))` reads `n - 1` elements before `x`; also `cblas_damax`.
- **Annotation.** `openblas-playground/src/lib.rs:13-14` declares `inc_x >= 1`.
- **Repro sketch (x86-64 OpenBLAS; not run).**
  ```c
  blasint n = 1 << 20, inc = -1;
  double *x = guarded_after(n * sizeof(double));
  damax_(&n, x + 0, &inc);   /* walks down from x into memory before the buffer */
  ```

### C3. candle `<f16 as VecOps>::vec_add` writes past `res` from safe Rust

- **Where.** `candle-core/src/cpu/kernels.rs:134-136` passes only `lhs.len()` to
  `vec_add_f16`. The module is public (`candle-core/src/cpu/mod.rs:5`) and the method is safe.
  bf16 `vec_add`, `vec_mul` and `scalar_add` have the same pattern but are not annotated.
- **Trigger.** `f16::vec_add(&[f16::ZERO; 64], &[], &mut [])` reads past `rhs` and writes past
  `res`. That is undefined behaviour reachable from safe code. No candle-internal caller does
  it.
- **Annotation.** `candle-playground/src/lib.rs:15` declares
  `lhs.len() == rhs.len(), lhs.len() == res.len()`.

### C4. candle `vec_dot` length check is debug-only

- **Where.** `candle-core/src/quantized/k_quants.rs:2724-2725` checks `xs.len() >= n` and
  `ys.len() >= n` with `debug_assert!`, which compiles away in release builds.
- **Trigger.** `<f16 as GgmlType>::vec_dot(1 << 20, &[], &[])` reads out of bounds in release.
  The internal matmul passes correct lengths.
- **Annotation.** `candle-playground/src/lib.rs:18` declares `n <= xs.len(), n <= ys.len()`.

### C5. FFmpeg Opus `vector_fmac_scalar` length (unclear)

The Opus hybrid path calls `fdsp->vector_fmac_scalar` with lengths that come out of
`swr_convert` (`libavcodec/opus/dec.c:319,349`). Only a multiple of 8 is asserted
(`dec.c:273`), but the NEON loop is `subs #16; b.ne`. A length that is 8 mod 16 would loop
about 2^28 times, reading and writing out of bounds. Whether the resampler can produce such a
length is not established; this needs a dynamic test.

---

## D. Known CVEs that BUMS rejects

The vulnerable assembly is in `bugs/asm-cves/` (`prepare.py` regenerates it from upstream).
`memsafe-checker/tests/x86_cves.rs` checks each vulnerable variant fails and each fixed variant
verifies:

```sh
RUST_MIN_STACK=1073741824 cargo test -p bums --release --test x86_cves
```

| CVE | Code | Bug | Test |
|---|---|---|---|
| CVE-2019-6488 | glibc x32 `memmove`/`memset` (AVX) | 32-bit length in a 64-bit register: reads/writes past the buffers | `cve_2019_6488_x32_*_past_its_buffer(s)`, `…_with_the_fix_is_safe` |
| CVE-2018-11237 | glibc AVX-512 `mempcpy` | writes past the destination | `cve_2018_11237_avx512_mempcpy_writes_past_its_destination`; `…memmove_was_never_affected` |
| CVE-2026-28386 | OpenSSL AES-CFB128 AVX-512 | reads past the IV in the middle of a block | `cve_2026_28386_cfb128_reads_past_the_iv_mid_block` |

---

## E. Assumptions that are documented but not enforced

These do not crash with the library's own callers, but the assembly relies on something no
code check guarantees. Details are in `contract-audit/`.

- **aws-lc CBC with a length that is not a multiple of 16** is now reproduced: see
  [A4](#a4-aws-lc-cbc-reads-past-in-when-the-length-is-not-a-multiple-of-16-aarch64).
- **ISA-L `pq_gen_neon` / `pq_check_neon`** do not check `len % 16` or `vects > 3`; the x86
  versions return an error. On arm64, `len = 8` overflows P and Q by 8 B, and `vects <= 2` wraps
  the vector count and loads pointers from about 32 GiB past the array.
- **ISA-L 32-bit arguments read as 64-bit registers.** `crc32_iscsi(…, int len, …)` and others
  pass `int` lengths straight to kernels that use the full register. A negative `len` reads
  about 4 GiB.
- **ISA-L `ec_encode_data` with k = 0.** Every dot-product kernel runs its loop once and reads
  `src[0]`.
- **rav1d film grain at odd heights.** For a picture height of 32k+1 with overlap, `fgy` and
  `fguv_422/444` force two rows (`mov w7, #2`) and write one row below the picture. It is safe
  only because rav1d's allocator rounds heights to 128 (`src/picture.rs:91`). A custom
  `Dav1dPicAllocator` that allocates the exact height would overflow.
- **rav1d edge buffers.** `ipred_z1_filter_edge` reads past the `[Pixel; 257]` the Rust code
  sees (safe because of 62 bytes of padding in `ScratchEdgeBuf`, `src/internal.rs:1050`);
  `msac` refill reads `[buf_end - 8]` and is safe only because initialisation consumes short
  tiles first.
- **FFmpeg padding.** HEVC `ref_filter_3tap` reads 16 entries past the 65-entry reference
  array (padded by `pred_template.c:145,147`). RGB32_1 → 24-bit reads 1 B past the image (asm
  only). `hscale` on images narrower than 4 pixels reads up to 3 elements past the row (C does
  the same).

---

## F. Reported earlier, withdrawn

| Report | Why withdrawn |
|---|---|
| FFmpeg `conv_fltp_to_s16_nch_neon` "uninitialised `channels`" | `libswresample/aarch64/audio_convert_init.c` has had one commit (2014) and always counts the planes before the call |
| FFmpeg HEVC SAO `offset_val` over-read | stays inside the 148-byte `SAOParams` |
| rav1d 8-tap MC 1-byte over-read | the byte is always inside the picture or `emu_edge` allocation (`src/recon.rs:1750-1786`, `src/picture.rs:109-136`); the annotation should use `w + 8` |
| zlib-ng `crc32_fold_vpclmulqdq_copy` | engine limitation: the compiler wrote `+448` as `or $0x1c0`, which BUMS cannot model (`memsafe-checker/src/common.rs:1784`) |
| ISA-L `isal_deflate_hash_aarch64`, `mem_zero_detect_avx2` | engine limitations; the assembly is safe |
| FFmpeg `ff_vvc_put_qpel_hv128_8_neon` | engine limitation; it is two calls to `hv64`, which verifies |

---

## How annotations prevent these bugs

1. **A fixed function verifies, a broken one fails.** For every CVE in section D, the
   vulnerable variant is rejected and the patched one verifies. That makes a failing
   `check_mem_safe` a regression test: re-introducing the bug turns the build red.
2. **The precondition list is the complete list of what callers must guarantee.** Every bug in
   sections A and C sits exactly on one clause:

   | Bug | Clause the proof relied on | What the caller actually guarantees |
   |---|---|---|
   | A1 | `h % 2 == 0` | frame height even; slice height arbitrary for NV12/NV21 → RGB |
   | A2 | `height % 2 == 0` | nothing |
   | A3 | `h % 2 == 0` | frame height even; slice height arbitrary |
   | A4 | `input.len() % 16 == 0` | documented, not checked |
   | C1 | `len >= 16` | `len % 32 == 0` (0 allowed) |
   | C2 | `inc_x >= 1` | `incx != 0` |
   | C3 | `lhs.len() == rhs.len() == res.len()` | nothing (safe fn) |
   | C4 | `n <= xs.len(), n <= ys.len()` | `debug_assert!` only |

   Removing the clause, or replacing it with what the caller does guarantee, makes the
   verification fail at the access that causes the bug. That is expected from the proofs, but
   the relaxed annotations were not re-run here: A3 currently times out, and the others were
   found by reading the assembly.
3. **Turning a clause into a check closes the bug.** The fixes follow directly from the
   clauses:
   - A1: set `dst_slice_align = 2` for every 2-line kernel the aarch64 init installs.
   - A2, A3: handle an odd last row, or only install the kernel when the slice is even.
   - A4: reject or truncate a length that is not a multiple of 16 in `AES_cbc_encrypt` and
     `EVP_Cipher`, before calling the assembly.
   - C1: return early for `len == 0` (as `gf_vect_mul_base` does).
   - C2: move `x` to the far end for `incx < 0` (as the other BLAS interfaces do), or return 0.
   - C3, C4: replace `debug_assert!` with `assert!`, or pass `min` of the lengths.
4. **Write each clause about what the kernel receives, and cite the caller.** All three crashes
   came from a clause stated about the frame ("height is even") when the kernel is called on a
   slice. A clause written as "slice height is even, because <caller file:line>" would have
   failed the audit immediately.

## Files in this directory

| Path | Contents |
|---|---|
| `README.md` | this list |
| `repros/swscale/run.sh` | builds FFmpeg `ee8cbd7d` libswscale and runs A1–A3 with controls |
| `repros/swscale/odd_rows.c` | guard-page harness for A1 (`yuv`, with `NV12=1 GRAPH_API=1`) and A2 (`rgb24`) |
| `repros/swscale/nv24_slice.c` | guard-page harness for A3 |
| `repros/aws-lc/run.sh` | builds aws-lc `libcrypto` from a local checkout and runs A4 |
| `repros/aws-lc/cbc_tail.c` | guard-page harness for A4 (three entry points, both directions) |
| `repros/aws-lc/minimal.c` | smallest standalone crash for A4: one `AES_cbc_encrypt` call |
| `repros/aws-lc/minimal_openssl.c` | same crash through OpenSSL's `EVP_Cipher` (shared `aesv8-armx` assembly) |
| `repros/aws-lc/sha256_transformblocks_zero.c` | A5: `SHA256_TransformBlocks(.., 0)` runs off the end |
| `repros/aws-lc-rs/` | Rust crate: aws-lc-rs 1.19.0 safe API rejects A4's inputs; raw `aws-lc-sys` faults |
| `contract-audit/*.md` | per-area audit of every annotation clause against callers (FFmpeg video, FFmpeg other, rav1d, compression, crypto/BLAS), with file:line citations |
| `contract-audit/method.md` | the instructions the audit followed |
| `asm-cves/` | assembly for the CVEs in section D, and `prepare.py` |
