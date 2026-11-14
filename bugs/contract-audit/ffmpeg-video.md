# ffmpeg-video contract audit (aarch64; h264, h264dsp, hevc, hevc_mc, vvc, vvc_alf, vp8, vp9, misc_video, pixel)

FFmpeg ee8cbd7d. Asm = ffmpeg-playground/include/libavcodec/aarch64. (In progress: sections appended per module.)

## Shared facts used below
- Frame planes (get_buffer.c update_frame_pool): avcodec_align_dimensions2 aligns w to 16 / h to 32 for all YUV/GBR 8..16-bit formats used by these decoders (utils.c avcodec_align_dimensions2), linesize multiple of STRIDE_ALIGN (16 on aarch64 NEON), and each plane buffer gets `+16+STRIDE_ALIGN-1` bytes slack. H.264/VC1/VP5/VP6 also get `height += 2`, width >= 32.
- Over-reads past the right edge of a row that is not the last plane row land in the next row (in bounds).

## 1. Candidate bugs (NOT-UPHELD-UNSAFE)

None found beyond the already-known items. Confirmations of the known items:
- VP9 10/12-bit 4-wide `_h` over-read: CONFIRMED as the only VP9 h-filter gap. For 8-bit and for wider 16bpp filters, the "footprint + 1 pixel" allowance is exactly what vp9recon.c:318-327 provides. It switches to emulated edge when `x + !!mx*5 > w - bw && y + !!my*5 + 1 > h - bh` on ARCH_AARCH64, so the 1-pixel over-read never lands on the last row of a plane. Asm that reads more than 1 pixel (the 16bpp 4-wide case) is not covered by that guard.
- VVC epel hv `vf` 8-byte read, ALF chroma clip 8-of-6, and qpel_bi_h24 src2 stride (h24 is unregistered: hevcdsp_init_aarch64.c NEON8_FNASSIGN_QPEL_H maps width 24 to h12): not re-examined beyond confirming the registration.

## 2. Unique finds / API-CONTRACT assumptions (callers uphold them today)

1. **HEVC intra `ref_filter_3tap_{8,16,32}`: the asm reads 16 bytes past the 2N+1 reference array.** The tail load in `filter_3tap_array` is `ld1 {v0,v1}` (32 bytes) from `&in[n-18]`. For 32x32 (n=64) that reaches in[77]. This is safe only because pred_template.c:145,147 declares `left_array`/`top_array` as `2*MAX_TB_SIZE + 1 + 16`. The padding is documented only in an asm comment ("Caller pads input arrays by 16 bytes"). The annotation models it correctly (left/top len 81).
2. **HEVC pred_planar / angular mode 10/26 receive the *unpadded* filtered arrays.** pred_template.c:146,148: `filtered_left_array`/`filtered_top_array` have 65 entries, and after smoothing they are passed as top/left (pred_template.c:349-371). The annotations claim `top.len()==81, left.len()==81`, which is looser than the caller. The actual reads are planar_32 top/left[0..32] and mode 26 top[0..31] plus left[-1..31]. They stay within 65, so the code is safe, but the verification does not prove it under the real 65-byte bound. Tighten the annotations to 65 to make the proof match the caller.
3. **HEVC SAO (8-bit) uses edge_emu_buffer + edge_emu_buffer2 as one buffer.** The 8-bit edge-filter src region is `(height+2)*192+16` bytes. At height 64 that is about 12.7 KB, which exceeds `edge_emu_buffer` alone (`(64+7)*80*2 = 11360` bytes, hevcdec.h:429). It fits only because edge_emu_buffer2 follows it in HEVCLocalContext (hevcdec.h:430 comment: "The extended size ... is abused by SAO"). This is intra-struct overflow by design, written by the C code (copy_CTB) as well.
4. **SAO 16x16 edge/band filters round width up to 16 (8-bit) or 8 px (16-bit) and write that many pixels into the frame.** With width 12..60 they write up to 15 bytes past the CTB, and past picture width at the right edge. This is safe only because frame linesize is a multiple of 16 and covers FFALIGN(width,16) (utils.c avcodec_align_dimensions2 plus the get_buffer.c linesize loop). It holds for HEVC and VVC.
5. **H.264 chroma MC reads 16 bytes per row (needs 9).** Inside edge_emu_buffer (only 9 columns filled), bytes 9..15 are uninitialised but in bounds: alloc is `alloc_size*2*21` rows, h264_slice.c. In-frame it reads up to about 7 bytes past chroma width, covered by row padding and the +16 pool slack. Rows read = h+1, not the h+2 the annotation allows.
6. **HEVC/VVC MC in-frame path keeps a 1-row/1-column margin.** The condition `x_off >= pic_width - block_w - EXTRA_AFTER` (hevcdec.c:1765-1767, 1835-1854, 1928-1930, 2009-2011; vvc/inter.c:73-75) means in-frame blocks end at least 1 pixel before the picture edge. That covers the annotations' "whole rows + one row + 16 bytes" src model. With VVC subpictures the margin is relative to the subpicture rect, still inside the frame.
7. **VP8 MC: the emu buffer is 21*32=672 bytes (vp8.h EDGE_EMU_LINESIZE 32).** The annotation's alternative `srcstride==32 && src.len()==672/670/606` matches src = buf + mx_idx + 32*my_idx.
8. **ff_prefetch_aarch64:** the `mem.len()==stride*h` contract is meaningless. h264/vp8/vp9 callers prefetch addresses outside the frame (e.g. h264_mb.c prefetch_motion `+64`), but prfm never faults.

## 3. NOT-UPHELD-SAFE

- **ff_weight_h264_pixels_4_neon / ff_biweight_h264_pixels_4_neon, `height <= 8`:** in 4:2:2 (8-bit High 4:2:2), 8x16 partitions call weight_op[2]/weight_avg[2] for chroma with chroma_height = 16 (h264_mc_template.c:99-106, h264_mb.c:395). The asm loop (h264dsp_neon.S weight_4/biweight_4: `subs #4`, `b.lt` tail for 2) is height-generic, and the caller's dst covers 16 rows. Safe.
- **ff_put/avg_pixels16_neon, pixels8 (hpeldsp), `h <= 16`:** indeo3.c:264-280 passes `h = cell->height << 2`, a multiple of 4 that can exceed 16. The loop (`subs w3,#4; b.ne`) is generic, and the caller checks the MV and cell lie inside the plane (indeo3.c:252-258). Safe. The `h % 4` clause is upheld: VP6 passes 12, others 8/16, SVQ3 4/8/16.
- **VVC avg/w_avg `dst_stride >= 128` (bytes, 8-bit), and HEVC/VVC SAO 16x16 `stride_dst >= 64/128`, band `stride_src/dst >= 128`:** small pictures have linesize 16..112. The asm writes exactly `width` px per row (vvc/inter.S vvc_avg) or ceil16(width) ≤ linesize per row (SAO). Rows do not overlap. Safe.
- **h264 chroma mc8 `h % 4 == 0`:** stricter than the asm needs (2 rows per iteration); callers pass 4/8/16 anyway (upheld).

## 4. Per-family verdicts (all UPHELD unless noted)

### h264 (148)
- chroma mc8/mc4/mc2 (h264, rv40, vc1; 14): UPHELD. Heights are `height >> (chroma_idc==1)` from {16,8,4} (h264_mb.c:307-318), so {16,8,4,2}. x,y = `&7`. Src is edge_emu (9 x 8*chroma_idc+1 rows) or in-frame with the luma `-3` margin (h264_mb.c:232-247).
- pred16x16 / pred8x8 8-bit and 10-bit (34): UPHELD per mode. The L-shaped region is generous, each mode reads only the neighbours h264 guarantees available (ff_h264_check_intra_pred_mode remaps unavailable modes). Registration is limited to chroma_format_idc<=1 for pred8x8 (h264pred_init.c:83-105).
- qpel8/qpel16 8-bit and 10-bit (100): UPHELD. Emu covers 21x21 (h264_mb.c:241-247). The in-frame check uses the 16-wide partition with a -3 margin, and frames get height+2 and width>=32.
- hpel h264_qpel mc00 (misc_video): UPHELD.

### h264dsp (32)
- loop filters luma/chroma/422/mbaff 8-bit and 10-bit: UPHELD. Registration matches chroma format (h264dsp_init_aarch64.c), tc0 is int8[4].
- weight/biweight 16/8: UPHELD (heights 16/8 and 16/8/4). weight/biweight 4: NOT-UPHELD-SAFE (h=16, 4:2:2), see section 3.
- idct add/dc_add/idct8/add16/add16intra/add8/idct8_add4: UPHELD. block_offset comes from the h264 block_offset table (h264_slice.c init_scan_tables / h264dec block_offset) with mb_linesize, nnzc is scan8 cache size, add8 only for chroma_format_idc<=1. The 3 TIMEOUTs are not verdicts.

### hevc (85)
- add_residual / idct / idct_dc / dequant / transform_luma: UPHELD (fixed TU sizes 4..32, coeffs int16 lc->tu buffers). col_limit is 1..N per hevc transform code.
- deblock luma/chroma 8/10/12: UPHELD. tc[2], no_p[2], no_q[2] in filter.c. Edges are on the 8-px grid inside the picture.
- SAO edge 8x8 / 16x16 (HEVC and VVC, 8/10/12): UPHELD. width/height are CTB-clipped and multiples of 4 (MinCb >= 8). tab mapping is sao_tab (filter.c:274/339). Src is the edge_emu buffer pair (see section 2 item 3) or the VVC sao.buffer (ctu.h:455, 332 KB).
- SAO band 8x8/16x16: UPHELD (stride clauses NOT-UPHELD-SAFE).
- pred dc/planar/angular 10/26, ref_filter_3tap/strong: UPHELD, with caveats in section 2 items 1-2.

### hevc_mc (355)
- All pel/qpel/epel put/uni/bi/uni_w/bi_w x h/v/hv x widths, i8mm variants: UPHELD.
  - Width lists match the shared registrations: qpel_h12 serves 12/24, qpel_h32 serves 32/48/64, *_SHARED_32 cover 32/48/64, pel_bi_w_pixels24 serves 24/48 and 32 serves 32/64 (hevcdsp_init_aarch64.c NEON8_FNASSIGN_*).
  - Heights are even: luma {4..64}, 4:2:0 chroma {2..32}, 4:2:2/4:4:4 chroma = luma heights.
  - dst/src2 is lc->tmp int16[4096] with MAX_PB_SIZE stride. Src footprint comes via emu (EDGE_EMU_BUFFER_STRIDE 80, 142 rows at 8-bit) or the in-frame margin (section 2 item 6). denom <= 7+7 (hevcdec weight-table parse).
  - qpel_bi_h24 is known and unregistered.

### vvc (128)
- MC put luma/chroma/qpel/epel/pel_pixels/uni/uni_w (8/10/12, i8mm): UPHELD.
  - Width lists match dsp_init.c sharing: qpel_v8 serves 8..128, *_h32 and *_x16 serve 32/64/128.
  - Heights are powers of two (luma >= 4, so `%4` holds for 10/12 luma v/hv; chroma >= 2). Width-2 chroma is index 0, the C fallback.
  - Emu: inter.c:73-87, buffer EDGE_EMU_BUFFER_STRIDE^2*2 with stride (128+32)*8. epel hv is known (FAIL).
- avg/w_avg: UPHELD (widths/heights are powers of two 2..128). Stride clause is NOT-UPHELD-SAFE.
- dmvr/dmvr_h/v/hv: UPHELD. pred_w/h = block+4 with block in {8,16} (inter.c:784-797), bilinear emu margin 1.
- bdof, sad, prof_grad: UPHELD (8/16 subblocks, tmp int16[128*128], PROF_TEMP_OFFSET).

### vvc_alf (10)
- luma/chroma kernels: UPHELD. The template passes 7 or 5 row pointers into the padded ALF buffer, 8 or 4 px per call. Luma widths are multiples of 8 (virtual boundaries on 8-px units). Chroma clip 8-of-6 is known.
- classify_grad / classify_sum: UPHELD. gradient_tmp is int[66*66*4] = 69696 B. vb_pos is in [4,124] (filter.c:1026, virtual boundaries multiple of 8). steps is 3 or 4. sme2 is out of scope.

### vp8 (45)
- epel/bilin/pixels MC: UPHELD. Heights are {16,8,4} (vp8.c inter_predict, chroma 8x8/8x4/4x8/4x4). Emu buffer 21*32 is matched by the annotation alternative. In-frame margin is `subpel_idx[2]` (> needed).
- loop filters, idct/dc_add/dc_add4y/4uv, luma_dc_wht: UPHELD (MB-aligned, block int16[16] / [4][16], dc[16]).

### vp9 (286)
- copy/avg 4..64 (and copy128? only registered sizes): UPHELD. h is the block height in {4..64}.
- `_h` 8-tap: UPHELD. Called directly (h in {4..64}) and from the hv wrapper with h+8 rows into a `((1+(sz<64))*sz+8)*sz` temp (vp9dsp_init_aarch64.c define_8tap_2d_fn), so h <= 16/24/40/72. The 1-pixel over-read is guarded at vp9recon.c:318-327. The 16bpp 4-wide case is known.
- `_v` 8-tap: UPHELD (no extra row; emu switches at `y + 5 > h - bh`).
- itxfm 4/8/16/32 (8-bit int16, 16bpp int32 coeffs): UPHELD. Called only `if (eob)` and eob <= n*n.
- loop filters (4/8/16, 44/48/84/88, 16_8/16_16): UPHELD (8x8-grid edges, frames aligned 16/32).

### misc_video (68)
- vc1 inv_trans / loop filters: UPHELD (pq 5-bit, MB-aligned).
- me_cmp (sad/sse/vsad/vsse/nsse, x2/y2/xy2): UPHELD for encoder callers (h in {8,16}).
- hpeldsp put/avg pixels8/16 (+x2/y2/xy2/no_rnd): UPHELD except `h<=16`, which is NOT-UPHELD-SAFE (indeo3).
- vc1_unescape_buffer_helper: FAIL, not audited.

### pixel (16)
- get_pixels/diff_pixels/put_pixels_clamped/simple_idct put/add/fdct/pix_sum/norm1: UPHELD (8x8 or 16x16 blocks).
- png_add_bytes_l2, add_int16: UPHELD (row widths).
- png_add_paeth: FAIL, not audited. prefetch: see section 2 item 8.
