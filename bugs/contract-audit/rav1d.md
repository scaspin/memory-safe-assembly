# rav1d playground contract audit (rav1d-int worktree, aarch64 NEON)

Scope: `rav1d-int/rav1d-playground/src/asm/*.rs` (537 verified, 12 TIMEOUT, 1 FAIL). Callers: rav1d at
`/Users/shai/Documents/Princeton/rav1d` (HEAD acd57b1b). Asm: `rav1d-playground/include/src/arm/64/*.S`.
16bpc families are only cross-checked against their 8bpc representative (the known stride-unit issue makes those verdicts lenient anyway).

## 1. Candidate bugs (NOT-UPHELD-UNSAFE)

None found where a reachable rav1d input drives the asm outside an allocation the default allocator provides.
Every out-of-contract input I found is either handled by the asm (section 3) or lands in picture padding that
only the documented (unenforced) allocator contract guarantees (section 2). Closest to a bug:

| # | function(s) | input | access | status |
|---|---|---|---|---|
| A | fgy_32x32_{8,16}bpc, fguv_32x32_{422,444}_{8,16}bpc | picture height ph = 32k+1, film grain with overlap_flag, row_num>0 -> bh = 1 with type&1 | asm forces 2 rows for the y-overlap (`mov w7,#2`, filmgrain.S:1429-1430), so it **reads src row 1 and writes dst row 1**: one row below the visible picture | in bounds only because the allocator rounds heights up to 128 (picture.rs:91, API doc include/dav1d/picture.rs:566-568). A custom `Dav1dPicAllocator` that allocates exactly ph rows gets a 1-row heap write. The annotation itself states the need (`dst.len() >= stride*2*(ty%2)`). API-CONTRACT, write. |
| B | fguv_32x32_420_{8,16}bpc | odd luma height in last 32-row block (bh_luma = 2*bh_chroma - 1) | reads 2*bh luma rows (annotation `luma_row.len() == luma_stride*(h*2)`) -> one luma row past visible height | same 128-row padding, read only. API-CONTRACT. |

## 2. Unique finds / API-CONTRACT assumptions

1. **Picture padding (allocator contract, not enforced).** Many verdicts model each picture row as `stride` bytes
   long and each block as fully inside the plane. Real guarantees come only from
   `Dav1dPicAllocator::alloc_picture_callback` docs ("pixel width/height multiple of 128, padded by 64 bytes",
   include/dav1d/picture.rs:566-568); rav1d only asserts alignment and `len % 4096` (picture.rs:166-176), not
   that stride covers the 128-aligned width or that height is 128-aligned. Accesses relying on it:
   - fgy always processes 32 columns per block (no width arg), blocks start at every bx < pw (filmgrain.rs:1003),
     so it writes up to 31 px past pw; fguv 16/32 likewise.
   - fgy/fguv 1-row overrun (table above).
   - sgr_weighted2 (and the sgr finish functions) round w up to 8 (`add w9,w4,#7; bic`, looprestoration_tmpl.S:607-608)
     and read+write dst for roundup8(w); last LR unit has w = pw - x (lr_apply.rs:231) -> up to 7 px written past pw.
   - wiener/sgr row_h read vector overshoot past the unit, last row of picture into the +64 B padding.
   - itx/ipred/cfl_ac operate on whole transform blocks, which extend past f.bw*4 x f.bh*4 into padding at frame edges
     (cfl_ac reads `furthest_r/furthest_b` rounded up to tx size, recon.rs:2398-2408).
   - loopfilter lpf_*_sb loops while any mask bit remains (loopfilter.S lpf_func, `cbnz w6, 1b`) and
     loads/stores 16-px (v) / 16-row (h) groups -> up to roundup16(pw)/roundup16(ph).
   - put_8tap: rav1d requires only `x + w + 4 <= pw` for h-filtering, asm reads column x+w+4 (known 1-byte over-read).
   With rav1d's default allocator (aligned_w = (w+127)&!127, aligned_h = (h+127)&!127, +64 B) all are in bounds.
2. **Negative strides.** `Rav1dPictureDataComponentInner::new` accepts negative picture strides (include/dav1d/picture.rs:168-176),
   but every annotation types stride as `usize` (`dst.len() == stride*h`). Asm is sign-agnostic (plain adds), so this is
   mirrored geometry, not a hole, but no verdict covers stride < 0.
3. **ScratchEdgeBuf padding is load-bearing.** ipred_z1_filter_edge reads 16-byte chunks until `end < 17`
   (ipred.S:1512-1518): with sz = end = 128 (64x64 z1) it reads in[128..143], i.e. edge[257..271], past the
   Rust-visible `&[Pixel; 257]`. Safe only because `ScratchEdgeBuf` is `[u8; 257*2 + 62]` (internal.rs:1046-1050,
   "62 padding bytes"). The annotation `in_0.len() == 145` encodes exactly this. Comment-only invariant.
4. **msac: `data.len() >= 8` is load-bearing but satisfied by init, not by the data.** refill_eob does
   `ldr x8, [x4, #-8]` (msac.S:337) = 8 bytes ending at buf_end; with a tile of < 8 bytes that would read before the tile.
   Tiles of 1-7 bytes are reachable from the bitstream. It is safe because rav1d's init refill consumes
   min(7, len) bytes bytewise (msac.rs:304-325, cnt=-15 -> 7 bytes), so for len <= 7 buf_pos == buf_end and the asm
   takes `pad_with_ones` (msac.S:334-335) without loading; for len >= 8 [buf_end-8, buf_end) is inside the tile.
   Unstated invariant coupling Rust init to asm refill.
5. **save_tmvs (known) confirmed:** `ld1` 8 bytes from `mfmv_sign: [u8; 7]`; the 8th byte is `pocdiff[0]`, the next
   field of `RefMvsFrame` (refmvs.rs:117-118). In-struct over-read, benign. (FAIL verdict stands.)
6. **splat_mv tolerates no null rows**: the wrapper writes `ptr::null_mut()` for invalid r indices (refmvs.rs:391-401)
   and the asm dereferences every row unconditionally (refmvs.S:51-54). Only rows (by&31)+5 .. +bh4 are passed, which
   rav1d_refmvs_tile_sbrow_init always fills with valid indices (refmvs.rs:1345-1348); a block never crosses its SB.
   Upheld today, but by layout, not by a check.
7. **CDF slice lengths unchecked in the wrapper**: rav1d_msac_decode_symbol_adapt{4,8,16} take `&mut [u16]` and only
   `debug_assert!` n_symbols (msac.rs:530-606); the asm loads/stores 4/8/16 entries regardless of slice length. All call
   sites pass fixed-size CdfContext arrays of 4/8/16 (cdf.rs:57-136, e.g. partition `COUNT + 6 = 16`), so upheld by types only.
8. **ipred_z1_fill2 annotation `topleft.len() == 64 + 64 * (64 + 15) * 2 + 16`** looks like a typo, but rav1d's
   `TOP_OUT_SIZE` has the same expression (ipred.rs: ipred_z1_neon), so it matches the real (10 KB) stack buffer. Fine,
   but the z3 analogue uses `64 + 64 + (64+15)*2` (286), the dav1d size.

## 3. NOT-UPHELD-SAFE

- **ipred_reverse_{8,16}bpc** (`n >= 16, n % 16 == 0`; 16bpc `n % 8 == 0`): callers pass n = height (4, 8) in z2,
  `h + min(w,h)` (e.g. 12, 20, 40) and `h + max(w,h)` (8 for 4x4) in z3 (ipred.rs z2/z3 neon). Asm handles 16 px per
  iteration (`subs w2,w2,#16; b.gt`, ipred.S:1938-1950), i.e. reads p-roundup16(n)..p and writes roundup16(n). All
  destinations fit: z3 `flipped[1..]` (144) and `left_out` (286) with n <= 128; z2 `buf[1..]`/`buf[131..]` of 195 with
  n <= 64 (131+64 = 195 exactly); reads stay >= edge[0] since n <= 128 = topleft_off.
- **ipred_cfl_ac_444 (`w_pad <= 3, h_pad <= 3`) and cfl_ac_422 (`h_pad <= 3`)**: 4:4:4 32-wide/high and 4:2:2
  32-high chroma blocks give w_pad/h_pad in {0,2,4,6} (cbw4 = 8, visible >= 2 because f.bw/f.bh are even
  (decode.rs:5202), intra tx >= 8x8 for 32x32, recon.rs:2398-2405). The w32 table has wpad4/wpad6 entries
  (ipred.S jumptable ipred_cfl_ac_444_w32_tbl) that were never verified; they read fewer columns/rows than wpad0 and the
  hpad loop writes the same cw*ch <= 1024 ac entries. Safe by inspection, unverified.
- **lpf_{v,h}_sb_uv (`mask[0], mask[1] <= 65535`, uv stride >= 64 / 64 rows)**: for 4:4:4 (v) and 4:2:2/4:4:4 (h)
  rav1d combines the halves as `a | b << 16` (lf_apply.rs:461-466, 507-509), giving 32-bit masks covering 128 px/rows.
  Same lpf_func loop as luma, whose annotation is verified with unrestricted 32-bit masks and 128-px stride; extent is
  bounded by in-frame mask bits. Safe by analogy, unverified for uv.
- **blend_v (`h <= 32, 32 % h == 0`)**: obmc gives h = v_mul * min(clip(l_b_dim[1],2,16), b_dim[1]) up to 64 for luma
  and 4:2:2 chroma (recon.rs:1950-1981). Asm loops 2 rows per iteration (`subs w4,w4,#2`, mc.S:714-850); safe.
- **put_8tap / put_bilin (`128 % h == 0`)**: obmc above-neighbour MC uses h4 = (oh4*3+3)>>2 (recon.rs:1918) giving
  h = 12, 24 (luma) and 6, 12 (chroma). Asm explicitly handles 6-row multiples (comments "8x6", 4-then-2-row tail,
  mc.S:1859-1880, 1939-1963); every loop step is 2 or 4 rows with a 2-row exit. Safe; unverified for those h.
- **warp_affine_8x8{,t} (alpha, gamma, delta in ±8191, beta ±4681)**: rav1d only enforces 4|a|+7|b| < 0x10000 and
  4|g|+4|d| < 0x10000 (warpmv.rs:72-73), so |alpha| up to 16383, |beta| up to 9362. With the asm's +512 rounding
  (mc.S `add w12, w5, #512` + `asr #10`) and mx+4a+7b in [-63, 65535] (recon.rs:2025-2029, upheld), the filter index
  stays in [0,192] of mc_warp_filter[193] for the full diamond. Safe by arithmetic, unverified outside the box.
- **wiener_filter5, sgr_* (`w <= 256`)**: the last LR unit is w - x < unit_size*1.5 = 384 (lr_apply.rs:193, 231).
  Asm stack/tmp buffers are sized for 384 (`sub_sp 384*2*6`, looprestoration.S:58; Rust STRIDE 384+16,
  looprestoration.rs:1275) and annotations' sum/aa buffers are 400; w in 257..383 unverified, designed-safe.
- **sgr_weighted2 (`w % 8 == 0`)**: last unit width arbitrary; asm rounds to 8 (see 2.1); tmp is 64*384 so in bounds,
  dst overrun is picture padding.
- **msac `data.len() >= 8`**: see 2.4.
- **splat_mv `bx4 <= 1024`**: frames up to 65536 px give bx4 up to 16383; asm computes bx4*12 in 32 bits
  (refmvs.S:44-48), no overflow; row writes are exactly 12*bw4 bytes (st1 8B + str 4B for bw4=1) inside the
  `index_mut((ri + bx4.., ..bw4))` guard (refmvs.rs:393). Safe.

## 4. Families: one line each

- cdef padding4/8 (+edged), filter4/8 {8,16}bpc: UPHELD. tmp 104/200 with offsets 24/40 = TMP_LEN 12*8+8 / 12*16+8 and
  `2*TMP_STRIDE + 8` (cdef.rs:646-647, 742-744); H fixed 4/8.
- cdef_find_dir: UPHELD (8x8 block, variance &mut u32).
- msac symbol_adapt4/8/16, bool, bool_adapt, bool_equi: UPHELD except data.len()>=8 (safe, 2.4); cdf lengths by type (2.7);
  `cdf[n] <= 32` by the saturating count update; n_symbols >= 1 at every call site (decode.rs, e.g. pal_sz-1 >= 1, min(t_dim.max,2) >= 1).
  hi_tok: TIMEOUT.
- refmvs splat_mv: UPHELD (see 3 for bx4). save_tmvs: known FAIL, confirmed benign. load_tmvs: TIMEOUT.
- loopfilter y {v,h} {8,16}: UPHELD (w <= 32 per SB, have_top/have_left skip frame edge, lf_apply.rs:368-432); uv: section 3.
- filmgrain generate_grain_y/uv: UPHELD by types (`&mut GrainLut`, filmgrain.rs:57-96; ar_coeff_lag <= 3 from the header parser). Not checked deeply.
  fgy/fguv: offsets 0..255 UPHELD (get_random_number(8), filmgrain.rs:1006); clip/ty/uv/is_id bounds UPHELD; h <= 32/16 UPHELD
  (FG_BLOCK_SIZE); row extent API-CONTRACT (section 1-2).
- looprestoration wiener5/7, sgr box/finish/weighted: w bound NOT-UPHELD-SAFE (3); h <= 64 UPHELD (stripe_h <= 64, lr_apply.rs:58);
  lpf / edges via lr_line_buf (decode.rs:4512-4527). wiener7: TIMEOUT.
- mc put/prep 8tap (all filter combos, neon/dotprod/i8mm), bilin, put/prep copy: UPHELD for w (2..128 powers of two) and mx,my
  0..15; h see section 3 (obmc); src margins by the emu_edge condition in recon.rs mc(); 1-byte over-read known.
- mc avg/w_avg/mask/w_mask_{420,422,444}: UPHELD (compound blocks, w,h in {4..128} powers of two, tmp buffers 128*128).
- mc blend (interintra, <= 32x32), blend_h (obmc, h <= 32, w <= 64): UPHELD; blend_v: section 3.
- warp_affine 8x8/8x8t: src stride 32 emu buffer or picture (recon.rs:2031-2046) UPHELD; parameters section 3.
- emu_edge: TIMEOUT (not audited further).
- itx (all 16x16/... types, 8/16bpc, wht): UPHELD. coeff len = min(w,32)*min(h,32) from t.cf / frame-thread slice; eob < len
  from decode_coefs; dst block in picture (padding at edges, 2.1).
- ipred dc/v/h/paeth/smooth*/filter/cfl/pal: UPHELD (tx dims 4..64, filter and cfl <= 32, filter angle 0..4,
  topleft = edge[128] of 257 (recon.rs:2217), ac 32*32, pal idx w*h/2).
- ipred z1/z3 fill2, z2 fill2/fill3, upsample/filter_edge: UPHELD (buffers ipred.rs ipred_z{1,2,3}_neon; dx/dy <= 102 when
  upsampled since only angles within 40 deg upsample; sz = min(max_width, width) >= 4 since f.bw even). fill1 z1/z2/z3: TIMEOUT
  (z2_fill1 underread known).
- ipred_reverse, cfl_ac_444/422: section 3.
