# compression-playground contract audit (zlib-ng 2.3.3, ISA-L, zstd)

Paths: ISAL = $CLAUDE_JOB_DIR/tmp/src/isa-l (master; playground used 96be773, the asm checked below matches the
playground's asm/), ZNG = .../src/zlib-ng, ZSTD = .../src/zstd, PG = compression-playground.

## 1. Candidate bugs (NOT-UPHELD-UNSAFE)

| # | Function(s) | Clause | Triggering input | Access | Reachability |
|---|---|---|---|---|---|
| 1 | gf_vect_mul_sse / gf_vect_mul_avx / gf_vect_mul_avx2_gfni (x86, all verified) | `len >= 16` (sse/avx) / `len >= 32` (gfni), together with `len % 32 == 0` | `gf_vect_mul(0, tbl, src, dest)` | The asm only checks `len & 0x1f` (PG asm/gf_vect_mul_avx-x86_64.S:4-6, gf_vect_mul_avx2_gfni:4-5; ISAL erasure_code/gf_vect_mul_avx.asm:116-118) and then runs the do-while `loop32` once: it reads 32 bytes of src and **writes 32 bytes** to dest (non-temporal `vmovntdq`) before `cmp pos,len; jl/jb`. | Public `gf_vect_mul` dispatch (ISAL erasure_code/ec_multibinary.asm:87). The documented contract is "Len must be aligned to 32B" (include/gf_vect_mul.h:136,141). 0 meets it, and `gf_vect_mul_base` handles 0 as a no-op (ec_base.c:351-356). The NEON version rejects `len < 32` (aarch64/gf_vect_mul_neon.S:98-99), so only x86 is affected. The annotation excluded len=0 with `len >= 16/32`. No in-library caller passes 0, so this is an API edge case: it overflows a 32-byte write when the user's buffers are shorter than 32 bytes. |

No other reachable out-of-bounds access was found for verified functions.

## 2. Unique finds / API-CONTRACT assumptions

1. **pq_gen_neon / pq_check_neon do no input validation.** The x86 versions reject bad `vects` and `len` and return 1
   (raid/pq_gen_sse.asm:125-130, pq_gen_avx2.asm:128-133, pq_check_sse.asm:122-127). NEON instead does:
   - `len % 16 != 0`: `.Lloop16` is a do-while (aarch64/pq_gen_neon.S:246-283). For example, `len=8` stores 16 bytes
     to both P and Q, an **8-byte heap write overflow**, and reads 16 bytes of every source. `len=136` overflows the
     same way after the 128-byte loop. pq_check_neon (aarch64/pq_check_neon.S:290-330) has the same overread (no write).
   - `vects <= 2`: `sub w_vects,#3` wraps, the 32-bit write zero-extends to x_vects = 0xFFFFFFFF, and
     `add x_src, x_src, x_vects, lsl #3` then loads P and Q pointers from about array+32 GiB.
   The API docs require `len` to be 32B-aligned (pq_gen) or 16B-aligned (pq_check), and `vects > 3` (include/raid.h:91-92, 112-113).
   The dispatcher sends `pq_gen` straight to NEON with no checks (raid/aarch64/raid_aarch64_dispatcher.c). So this is API-CONTRACT, but the
   behaviour differs from x86: misuse there returns an error, and on arm64 it corrupts the heap. The annotations encode the docs
   (`len % 32 == 0` / `len % 16 == 0`, `vects >= 4`).
2. **`int`/`uint32_t` arguments are used as 64-bit registers throughout ISA-L asm.** Examples: `len` in crc32_iscsi_* (crc32_iscsi_avx2.asm:73,80
   uses rsi as UINT64, but the public prototype is `crc32_iscsi(unsigned char*, int len, unsigned)`, include/crc.h:137-139, and
   `mbin_interface` jumps straight in, crc_multibinary.asm:104-105). Also `len`/`vlen` in all gf_* (`x_len .req x0`, `%define len arg0`),
   `vects`/`len` in raid, and `hash_mask`/`dict_len` in isal_deflate_hash_crc_01 (`andq %rsi,%r9`, `negq %r8`). The SysV and AAPCS64 ABIs leave
   the upper 32 bits of a 32-bit argument unspecified. The annotations declare these as `usize` with `<= 2^31-1` (or `<= 2^40`), so BUMS
   assumes they are zero-extended. Real compilers zero-extend whenever the value came from a 32-bit operation, so this
   only bites for (a) negative `int len`, which C base versions treat as 0 but the asm treats as roughly 4 GiB or 2^64, and
   (b) a 64-bit value truncated at the call. Both are caller errors, so this is API-CONTRACT, but it is a modelling assumption worth stating.
3. **ec_encode_data / gf_*vect_dot_prod with `k == 0`.** Every dot_prod kernel runs its `next_vect` loop at least once
   (e.g. gf_vect_dot_prod_avx2.asm:149-171): it loads `src[0]` and 32 bytes of gftbls and dereferences `src[0]+pos`.
   ec_encode_data does not check k (ec_highlevel_func.c:157-191), while `ec_encode_data_base` handles k=0. The annotations assume
   `vlen >= 1`. The docs say nothing about k >= 1, so treat it as API-CONTRACT/UNCLEAR.
4. **`vec_i < vec` for gf_*vect_mad** is not checked anywhere (ec_encode_data_update_* passes the user's vec_i,
   ec_highlevel_func.c:573-600). The kernels index `mul_array + vec_i*32` and read outside g_tbls if it is violated. API-CONTRACT.
5. **GFNI dispatchers skip the minimum-length check.** ec_encode_data_avx2_gfni / _avx512_gfni and the _update_ variants
   (ec_highlevel_func.c:476-600) have no `len < 32/64` fallback, unlike the non-GFNI ones (:161, :197, :234, :301). The
   annotations assume `len >= 32` (avx2_gfni) / `>= 64` (avx512_gfni), so the short-length entry path was never verified.
   Reading the asm, it is safe: avx512_gfni builds a k-mask from len (gf_2vect_dot_prod_avx512_gfni.asm:189-194, masked ops suppress
   faults), and avx2_gfni falls through to `ENCODE_LT_32B_*` with `simd_load_avx2`/`simd_store_avx2`, which are exact-length partial
   accesses (gf_2vect_mad_avx2_gfni.asm:225-240, 275-287). This is the same tail code verified for `pos > 0`. See also section 3.
6. **gen_icf_map_lh1_04/06 (verified) depend on an invariant BUMS never checked.** The contract gives 32 KiB of readable history
   before next_in (`input.len() == 32768 + avail_in`) with arbitrary hash-table contents. The real caller does not guarantee 32 KiB of
   history: at stream start, or right after reset, there are fewer bytes before next_in. Safety comes from the hash-table
   contents. `reset_match_history` fills every entry with `total_in` (igzip.c, wmemset of `total_in & 0xffff`), so
   `dist = ((pos-1-entry) & dist_mask) + 1` never exceeds the bytes since the reset. isal_deflate also switches to the internal buffer whenever
   the user buffer lacks `hist_size` bytes of history (igzip.c:1573-1630, "compress from internal buffer if insufficient history").
   Real accesses are in bounds, but only through this content invariant.
7. **gen_icf_map_lh1 annotation fixes `hash_mask == 8191` (zs.18), which is the level-1 value.** The function is only reached from
   `icf_body_lazyhash1_fillgreedy_greedy` = `isal_deflate_icf_body_lvl3` (aarch64 dispatcher :184-192; x86 multibinary).
   It loads hash_mask from the stream (`movl 0x50(%rdi)`), and at level 3 that is `LVL3_HASH_MASK = 32767` (huff_codes.h:81,
   igzip_lib.h:123,128), or smaller (igzip.c:1405, 1549). The verified case therefore never covers the production mask. Table indices up to
   32767 (byte offset 0x1268 + 65534 inside level_buf) stay inside `hash_map.hash_table[32768]` and inside the modelled 277912-byte
   union, so this is NOT-UPHELD-SAFE, but the annotation should be `hash_mask <= 32767`.
8. zlib-ng compare256 relies on `strstart <= window_size - MIN_LOOKAHEAD` (match_tpl.h:118 Assert; enforced by fill_window's
   slide at deflate.c:1188 and by deflate_quick calling fill_window whenever `lookahead < MIN_LOOKAHEAD`, deflate_quick.c:73-77). It reads 256
   bytes that may be past valid input but inside the 2*w_size window. Upheld.

## 3. NOT-UPHELD-SAFE

- gf_vect_mul_* `len % 32 == 0`: x86 asm returns 1 before any access. gf_vect_mul_neon processes whole 32-byte blocks and
  returns 1 on the remainder (gf_vect_mul_neon.S:189-232).
- gf_*vect_{dot_prod,mad}_avx2_gfni `len >= 32` and *_avx512_gfni `len >= 64`: not enforced by callers (find 5), but the
  short paths use masked or exact-length partial accesses.
- Non-GFNI gf_* `len >= 16/32/64`: enforced by ec_encode_data_* (ec_highlevel_func.c:161, 197, 234, 301 and the update variants).
  The public gf_vect_dot_prod / gf_vect_mad dispatch with no check, but every kernel starts with `sub len,N; jl .return_fail` or
  `cmp x_len,#16; blt .return_fail` (gf_vect_dot_prod_avx2.asm:137-139, gf_2vect_dot_prod_neon.S:138-139).
- `vlen <= 255` / `vec <= 255`: k is not bounded by the API. The kernels are linear in k, so a bigger k with matching tables is fine.
- pq_gen_sse/pq_gen_avx `len % 32 == 0`: the asm accepts multiples of 16 (pq_gen_sse.asm:129), which is what the sse/avx docs require
  (raid.h:188, 209). The odd-multiple-of-16 path was not verified, but it is the same 16-byte tail loop. x86 asm rejects `vects < 4`.
- xor_gen_* `vects >= 3`, xor_check_sse `vects >= 2`: asm returns 1 otherwise (xor_gen_sse.asm:107-109, xor_check_sse.asm:104-106).
- gen_icf_map_lh1 `zs.17 (dist_mask) == 32767`: hist_bits can make it smaller (igzip.c:937-944), which only shrinks the read
  distance. `zs.2 (total_in) <= 32768`: total_in grows without bound, but the asm forms `file_start = next_in - total_in` and adds
  `total_in` back, so it cancels (PG asm lines 9-13). `zs.18 == 8191`: see find 7.
- isal_deflate_hash `dict_len >= 4` (the only verified variant): isal_deflate_process_dict accepts any dict_len >= 1 (igzip.c:1255).
  On AArch64, with dict_len < 4, `end_in = dict + dict_len - 4 < dict`, so `bcs exit_func` fires before any access
  (igzip_deflate_hash_aarch64.S). On x86 the signed `jg end_main`/`jg end` skip both loops. This confirms the known "engine limit".
- zlib-ng / ISA-L crc `len <= 2^40`: limited by the address space.

## 4. Families (one line each)

- ISA-L crc16_t10dif{,_copy}*, crc32_gzip_refl*, crc32_ieee*, crc32_iscsi*, crc32_mix*/crc32c_mix*, crc64_{ecma,iso,jones,rocksoft}_{norm,refl}* (x86 + pmull, all verified except 3crc_fold/iscsi_01 TIMEOUT): **UPHELD** by type (`uint64_t len`, include/crc.h, crc64.h). Find 2 applies to `int len` in crc32_iscsi.
- ISA-L gf_{1..6}vect_dot_prod_{sse,avx,avx2,avx512,neon}: **UPHELD**, len minimums at ec_highlevel_func.c:161/197/234/301 plus the asm's own return_fail. gftbls `32*k*rows` matches ec_init_tables. Finds 2 and 3 apply.
- ISA-L gf_{1..6}vect_mad_{sse,avx,avx2,avx512,neon}: **UPHELD** (ec_encode_data_update_* len checks, ec_highlevel_func.c:336-345, 611-615). vec_i is API-CONTRACT (find 4). The _sve variants are ERROR.
- ISA-L gf_*_{avx2,avx512}_gfni (dot_prod avx512_gfni and mad *_gfni verified; dot_prod avx2_gfni TIMEOUT/FAIL, known vacuous): length clause **NOT-UPHELD-SAFE** (find 5). The table is 32 B per coefficient (ec_init_tables_gfni, ec_highlevel_func.c:463-472), so `gftbls.len() == 32*vec*k` is correct.
- ISA-L gf_vect_mul_{sse,avx,avx2_gfni,neon}: **NOT-UPHELD-UNSAFE for len=0 on x86** (section 1). neon is fine.
- ISA-L pq_gen_{sse,avx,avx2,avx2_gfni,avx512,avx512_gfni}, pq_check_sse: **UPHELD/SAFE** (the asm validates).
- ISA-L pq_gen_neon, pq_check_neon (verified): **API-CONTRACT**, no validation, heap write overflow on misuse (find 1).
- ISA-L xor_gen_{sse,avx,avx512}, xor_check_sse: **UPHELD/SAFE** (asm validates vects, any len). NEON variants FAIL.
- ISA-L mem_zero_detect_{sse,avx,neon} (avx2/avx512 FAIL, known): **UPHELD** (`isal_zero_detect(void*, size_t)`).
- ISA-L gen_icf_map_lh1_04/06 (verified; h1_aarch64 TIMEOUT): input_size `(288, 4096]` and `<= avail_in` **UPHELD** (igzip_icf_body.c:308-312, structs.h:8). matches 4384 **UPHELD** (structs.h:22-23). History, hash_mask, dist_mask and total_in clauses are NOT-UPHELD-SAFE (finds 6 and 7).
- ISA-L isal_deflate_hash_{aarch64,crc_01}: masks UPHELD (set_hash_mask igzip.c:948-963 never exceeds the level's table). dict_len>=4 NOT-UPHELD-SAFE.
- ISA-L igzip others (adler32_*, update_histogram, encode_deflate_icf, set_long_icf_fg, deflate_body/finish, icf_body/finish_hash_hist, decode_huffman_code_block, build_heap/huff_tree): all FAIL/TIMEOUT. No contract was relaxed to make them pass, so they were not audited in depth.
- zlib-ng compare256_{sse2,avx2,avx512,neon}: **UPHELD** (find 8).
- zlib-ng crc32_{pclmulqdq,vpclmulqdq,armv8}, crc32_fold{,_copy,_reset,_final}_{pclmulqdq,vpclmulqdq,armv8}: **UPHELD**. The `([u8;64],u32)` layout matches `crc32_fold_s` (crc32.h:9,22-23). Callers are inflate.c:31,43 (window update, `copy` ≤ window space) and deflate_p.h:156. vpclmulqdq_copy FAIL is known. chorba TIMEOUT.
- zlib-ng slide_hash_{sse2,avx2,neon}: **UPHELD**. Offsets 0x40/0x60/0x68 match `internal_state` (deflate.h:145-200). prev is `w_size` u16 entries (deflate.c:167). head is 65536 (deflate.h:84, deflate.c:168). w_size ∈ {512..32768} (deflate.c:277-284; the annotation also allows 256, which is harmless).
- zlib-ng adler32{,_fold_copy}_*: TIMEOUT/FAIL. The contract (`len` = buffer length) is upheld by deflate_p.h:159 and inflate.c:35.
- zlib-ng chunkmemset_safe_*: all FAIL/TIMEOUT. The contract matches inflate.c:1092: `copy <= left`, and `from = put - offset` lies in this call's output because `offset <= out - left`. `left <= 2^31-1` is NOT-UPHELD (avail_out is a 32-bit uInt) but is moot.
- zstd HUF_decompress4X{1,2}_usingDTable_internal_fast_asm_loop: TIMEOUT. Every clause matches HUF_DecompressFastArgs_init (huf_decompress.c:194-273): lengths ≥ 8 at :236, ip at :240-243, op/q at :246-249, `op[3] < oend` at :252, `ilowest = src` at :269, dtLog == 11 → 2048 entries at :222. The X2 `dt[..] ∈ [2^24, 0x2FFFFFF]` (length byte 1 or 2) follows from HUF_buildDEltX2U32 `level << 24` with level ∈ {1,2} (:964-977).
