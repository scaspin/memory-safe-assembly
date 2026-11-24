# ffmpeg-other contract audit (aarch64: audio, float_dsp, libavutil, misc, swscale, tx_float, yuv2rgb)

FFmpeg source: $CLAUDE_JOB_DIR/tmp/src/ffmpeg @ ee8cbd7d. The playground's include/ copies of yuv2rgb_neon.S,
rgb2rgb_neon.S, float_dsp_neon.S, hscale.S, input.S, range_convert_neon.S, output.S, sbrdsp_neon.S,
aacpsdsp_neon.S, audio_convert_neon.S, resample.S, tx_float_neon.S, crc.S are byte-identical to upstream (cmp).

## 1. Candidate bugs (NOT-UPHELD-UNSAFE), most severe first

| # | Function(s) | Clause | Triggering input | Access |
|---|---|---|---|---|
| 1 | ff_{nv12,nv21,yuv420p}_to_{argb,rgba,abgr,bgra,rgb24,bgr24,gbrp,rgb565/555 le/be}_neon, ff_yuva420p_to_{argb,rgba,abgr,bgra}_neon (all "2l" variants; status TIMEOUT) | `h % 2 == 0` | Threaded swscale with an RGB destination. dst_slice_align = 1 << chrDstVSubSample = 1 for RGB dst (libswscale/utils.c:1297); the aarch64 setter (libswscale/aarch64/swscale_unscaled.c SET_FF_YUVX_TO_RGBX_FUNC) only gates on even **src_h** and never raises dst_slice_align. Graph path: slice_h = FFALIGN(ceil(lines/threads), align) (libswscale/graph.c:232-233, align from graph.c:453) and run_legacy_unscaled calls convert_unscaled(c, in, ..., y, h) directly (graph.c:394-404), bypassing scale_internal's macro_height_src check. Legacy threaded sws_scale: ff_sws_slice_worker (swscale.c:1663-1690) does the same via scale_internal's scale_dst branch (only macro_height_**dst**, =1, is checked). Example: yuv420p 1920x1024 -> rgba, same size, threads=6 (vf_scale sets threads = filter threads, vf_scale.c:425-426): slice_h = 171, last slice y=855, h=169 (odd). | The 2-line loop (yuv2rgb_neon.S `subs height, height, #2; b.gt 1b`, ~l.972/1019/1114) runs ceil(h/2) iterations, i.e. h+1 rows. Last slice: **writes dst row 1024 (one full RGB row past the frame)** and reads luma row 1024 of the source. Chroma stays in bounds (rows 427..511 of 512). Interior odd slices also write the first row of the next slice (data race, wrong colour: odd slice start pairs rows across a chroma boundary). The asm itself documents "Precondition: slice height is even ... scale_internal()'s macro_height_src check rejects any odd srcSliceH" — that reasoning ignores dst slicing. libavfilter pool frames pad height to FFALIGN(h, pool align) (framepool.c:62) and av_frame_get_buffer to FFALIGN(h,32) (frame.c:110), so heights that are already multiples of the pool alignment (e.g. 1024) get no slack rows, only `align` bytes: heap overflow WRITE of ~4*W bytes. For other heights (1080 -> 1088) the extra row lands in padding. Reachable from untrusted media with any yuv420p/nv12 input -> rgb output under `ffmpeg -vf format=rgba` with >1 filter thread. Not from the bitstream itself (needs a conversion), but any transcoding/thumbnailing pipeline. |
| 2 | ff_rgb24toyv12_neon (wrapper `rgb24toyv12`, libswscale/aarch64/rgb2rgb.c; status TIMEOUT) | `height % 2 == 0` | sws_scale BGR24 -> YUV420P/YUVA420P, same size, even width >= 16, no SWS_ACCURATE_RND (swscale_unscaled.c:2454-2457), with **odd height** (e.g. 640x481 single full-frame call; the last slice may be odd: swscale.c:1046-1047 only constrains slices by the src macro height, which is 1 for BGR24), or odd srcSliceH mid-frame. bgr24ToYv12Wrapper passes srcSliceH unchanged (swscale_unscaled.c:2062-2073). | asm loops `subs w5, w5, #2; b.gt 1b` (rgb2rgb_neon.S, rgb24toyv12) with no odd-row handling: last iteration **reads one source row past the slice (3*width_align bytes) and writes one luma row past ydst (width_align bytes)**. The C reference ff_rgb24toyv12_c handles odd height explicitly (rgb2rgb_template.c:596-599: `if (y + 1 == height) { ydst2 = ydst1; src2 = src1; }`), so this is an ASM-only divergence. With av_image_alloc'd contiguous planes the Y-row overflow lands in the U plane (corrupt output); with separately allocated / exact planes it is a heap write overflow. Same root cause as the known nv24 bug. |
| 3 (low) | ff_hscale{8to15,8to19,16to15,16to19}_4_neon[_asm] (verified), also X4/X8 | `src_w >= filter_size`, `filter_pos[..] <= src_w - filter_size` | aarch64 forces filterAlign = 4 (utils.c:1722-1726), so every horizontal filter is padded to >= 4 taps (utils.c:504). When srcW (or chrSrcW = ceil(srcW/2), e.g. srcW <= 6 for 4:2:0 chroma) is < 4, the border fix keeps filterPos = 0 with filterPos + filterSize > srcW (utils.c:549-575 explicitly asserts only that the out-of-range taps have zero coefficients). | Reads up to 3 elements past the end of the source row (read-only, values multiplied by 0). The C hScale*_c reads the same taps, so this is FFmpeg-wide behaviour, not ASM-specific; only harmful for tiny images in exact-size user buffers. |

Also suspicious but UNCLEAR (not proven):
- **ff_vector_fmac_scalar_neon `len % 16 == 0`** from the Opus hybrid path (libavcodec/opus/dec.c:319-321 and 349-351: lengths delay_samples / celt_output_samples derived from swr_convert output). The only stated invariant is `av_assert2((samples & 7) == 0)` (dec.c:273), i.e. multiple of 8, while the NEON loop is `subs w2, w2, #16 ... b.ne 1b` (float_dsp_neon.S): a length = 8 mod 16 never hits zero and runs ~2^28 iterations (massive OOB read+write). I could not compute the swresample delay for 16 kHz -> 48 kHz with silk_resample_delay priming (dec.c:71-73, 205-208) to decide whether 8 mod 16 is reachable. Worth a dynamic check (decode a hybrid Opus stream with a printf on these lengths).

## 2. Unique finds / API-CONTRACT assumptions

- yuv2rgb 2-line kernels: the precondition comment in yuv2rgb_neon.S (~l.940-947) is the only place the even-slice-height requirement is stated, and its justification is wrong for dst-sliced (threaded) scaling (see bug 1). The per-row `declare_func` path (still used for yuv422p) has no such requirement.
- ff_rgb24toyv12_neon: silently requires even height (bug 2); C does not.
- float_dsp (API-CONTRACT, libavutil/float_dsp.h): vector_fmul / fmac_scalar / fmul_add / fmul_reverse require len % 16 (doc) and the asm is do-while with `b.ne`/`b.eq` termination: len == 0 or a non-multiple is catastrophic (runs ~2^32/16 iterations). fmul_add/fmul_reverse actually need only % 8 (subs #8). All current callers I checked pass multiples of 16 (af_amix aligns to 16 at af_amix.c:361; af_amultiply samples_align = 16, af_amultiply.c:131; afir fadd guards `(nb_samples & 15) == 0`, afir_template.c:127; AAC/AC-3/WMA/atrac3plus/vorbis/dca/twinvq use fixed block sizes), except the Opus case above.
- Several callers rely on buffers being allocated past the logical length because they round len up: af_amix (FFALIGN(plane_size,16) over frames from ff_get_audio_buffer), af_volume (FFALIGN(nb_samples, 4/8)), pcm.c:616, libmp3lame.c:226 (checks plane padding explicitly), opus dec.c:622 (FFALIGN(decoded,8)). These are API-level padding assumptions shared with C, not asm-specific.
- ff_vector_fmul_scalar_neon: annotation requires len % 16 but API and callers use len % 4 (af_volume samples_align = 4 for FLT, af_volume.c:232; aac swb sizes). The asm has a 4-wide tail loop (`3:` ... `subs w2,w2,#4; b.gt 3b`) so %4 is safe; a len not multiple of 4 would over-read/over-write up to 3 floats (no caller seen).
- ToUV_half (all packed-RGB input families): w = chrSrcW = ceil(srcW/2) and the kernel reads 2*w pixels (annotation src.len() == 8*w / 6*w), i.e. srcW+1 pixels when srcW is odd: one pixel past the source row. C (input.c *_half_c) does the same: FFmpeg-wide assumption that source rows have >= 1 pixel of slack.
- rgbToRgbWrapper with src RGB32_1/BGR32_1 -> 24-bit (rgb32tobgr24 called on srcPtr + 1, swscale_unscaled.c:2023-2025, 2036-2039): the NEON kernel loads 4 bytes/pixel, so it reads 1 byte past the last pixel of the last row; the C rgb32tobgr24 reads only 3 bytes/pixel. ASM-specific 1-byte over-read (annotation `src.len() == src_size` is not upheld at this call site because the pointer is offset by ALT32_CORR = 1). Conversely dst RGB32_1/BGR32_1 from 24-bit (dstPtr + 1, line 2027-2033) makes rgb24tobgr32 write 1 byte past the destination's last row: shared with C (C writes dst[3]=255 too) -> FFmpeg-wide 1-byte write overflow when dst linesize == 4*w and the buffer is exact.
- ac3_sum_square_butterfly_{int32,float}: lengths are not multiples of 2/4 (start_freq[CPL_CH] = 37 + 12k, ac3enc.c:2446, passed as len at ac3enc_template.c:135-137; rematrixing band end clipped to nb_coefs = 73 + 3*bw_code, ac3enc_template.c:401-405). The asm rounds up (`subs #2/#4; b.gt`), reading up to 1 int32 / 3 floats past the band; always within the 256-coefficient mdct_coef row, so memory-safe, but the energies include extra coefficients (a functional divergence from C).
- AES (ff_aes_*_neon): annotation forces a 16-byte iv; av_aes_crypt allows iv == NULL (ECB). asm guards with `cbz x4` (aes.S:71,97,108): NULL path unverified but trivially safe.
- tx_float: annotation writes `s[1] == map.as_ptr()` on `s: &[u32]` while AVTXContext has `int len; int inv; int *map;` (map at byte offset 8, asm `ldr x4, [x0, #8]`). If BUMS indexes u32 cells, s[1] is `inv`, not `map`; verification passed, so BUMS presumably sizes the cell by the pointer RHS — worth confirming the macro's semantics (UNCLEAR, annotation hygiene).

## 3. NOT-UPHELD-SAFE

- uyvytoyuv420/422, yuyvtoyuv420/422 (TIMEOUT): `width % 2 == 0`, `height % 2 == 0` not upheld (src_w and srcSliceH arbitrary, swscale_unscaled.c:423-482) but the asm handles odd width (`write_last_odd_column`) and odd height (`is_final_odd_line`, `cbz w17`) explicitly (rgb2rgb_neon.S:871-963).
- vector_fmul_scalar %16 (see section 2: asm handles %4).
- butterflies_float, scalarproduct_float `len % 4`: asm safe for any len (tail by `tbz w2,#2` / `and w2,#12`; both only process whole groups within len).
- ac3_sum_square_butterfly (section 2).
- swri_oldapi_conv_fltp_to_s16_nch: annotation fixes channels == 6; callers pass 3..SWR_CH_MAX (audio_convert_init.c: count until src[ch] == NULL). The asm is structured generically (groups of 4, then 2, then 1 channel, advancing dst by 8/4/2 bytes with stride 2*channels). Looks safe by construction, but only 6 was verified.
- AES iv NULL (section 2).
- pixelutils sad8/16/32, detect_range/alpha, bwdif, nlmeans: strides typed usize in the annotation, but frames can have negative linesize (vflip); the asm just adds the signed stride, so the accessed rows are the frame's real rows.
- Upper bounds (`<= 16384` widths, `<= 1048576` lengths, `fft_sr len <= 4096`): tractability bounds, not upheld in general (av_image_check_size allows larger widths; tx registers fft_sr for 64..131072, tx_float_init.c:191-192). The loops are uniform in the bound, except fft_sr where sizes > 4096 take different recursion/table paths: those sizes are unverified (UNCLEAR rather than safe).

## 4. Families, one line each (UPHELD unless noted)

audio.rs
- abs_pow34 / aac_quant_bands (size%4): AAC swb widths are multiples of 4 or 1024 (aaccoder.c:110,113,396,589; aacenc_is.c:73-75). UPHELD.
- ps_add_squares / ps_mul_pair_single (n%4): n = nL - n0 = 32 (aacps.c:414, 429, 506, 514). UPHELD.
- ps_hybrid_analysis, ps_stereo_interpolate(_ipdopd): fixed N/stride (aacps.c:88,111); len = stop - start >= 1 guarded by `if (stop - start)` (aacps.c:711). UPHELD.
- ac3_exponent_min (reuse <= 5, nb_coefs <= 256), ac3_extract_exponents (%4: AC3_MAX_COEFS*blocks*channels), float_to_fixed24 (%32: same): UPHELD.
- ac3_sum_square_butterfly_{int32,float}: NOT-UPHELD-SAFE (section 2).
- lfe_fir0/1_float: lfe pointer is lfe_samples + DCA_LFE_HISTORY(8) (dca_core.c:2253-2254), annotation needs only 7/3 history. UPHELD. lfe_x96_fixed: len = nsamples/2, multiple of 32 (dca_core.c:2047-2049). UPHELD.
- opus_deemphasis (len%8): frame_size in {120,240,480,960} (dec_celt.c:461-465). UPHELD. opus_postfilter: known (pf_gains[3] 4th float), not re-reported.
- vorbis_inverse_coupling: blocksize/2 with blocksize 64..8192. UPHELD.
- mpadsp_apply_window_{fixed,float}: incr = channels (1/2). UPHELD.
- sbr_sum64x5, qmf_pre/post_shuffle, qmf_deint_neg/bfly, neg_odd_64, autocorrelate: fixed-size arrays in aacsbr_template.c:1388-1452 / aacsbr.c:162. UPHELD.
- sbr_sum_square (n even): n = 2*(t_env[e+1]-t_env[e]), t_env strictly increasing (aacsbr_template.c:751). UPHELD.
- sbr_hf_gen (start < end <= 38): 2*t_env bounds <= 32, strictly increasing (aacsbr_template.c:751, 1517). UPHELD.
- sbr_hf_g_filt: m_max, kx+m_max <= 64, ixh <= 33. UPHELD. sbr_hf_apply_noise_*: known (Y[64]).

float_dsp.rs
- vector_fmul, fmac_scalar, fmul_add, fmul_reverse (%16): UPHELD by every caller checked (section 2), Opus fmac_scalar UNCLEAR.
- vector_fmul_scalar: NOT-UPHELD-SAFE (%4 callers). vector_dmul_scalar: known 32 B over-read. vector_fmul_window (%4): AAC/WMA window lengths. UPHELD. butterflies / scalarproduct: NOT-UPHELD-SAFE (any len safe).

libavutil.rs
- crc32_aarch64 / crc_neon_pmull / crc_le_neon_pmull (ctx 17 u32): ctx is crc_table_pmull[...][17] or a user 257/1024-entry ctx (crc.c:353, aarch64/crc.h). UPHELD.
- base64_encode_neon (in_size >= 48, out size): base64.c:157-162. UPHELD.
- pixelutils_sad{8,16,32}: block sizes fixed by av_pixelutils_get_sad_fn; stride sign: NOT-UPHELD-SAFE.
- aes_{en,de}crypt_{10,12,14}: rounds from key size; iv NULL: NOT-UPHELD-SAFE.

misc.rs
- crc32_pmull_eor3 (ctx 33): TIMEOUT; ctx from crc_init_aarch64. UPHELD.
- conv_flt_to_s16 / fltp_to_s16_2ch (len%16): swresample passes off = len & ~15 (times ch_count for packed), audioconvert.c:238-249; simd only when in/out_simd_align_mask = 15. UPHELD. nch: channels == 6 NOT-UPHELD (likely safe).
- resample_common_apply_filter_x4/x8: lengths are filter_length & ~3 / & ~7 (aarch64/resample_init.c:28-49). UPHELD.
- detect_range/alpha (TIMEOUT/FAIL), bwdif, nlmeans: not audited in depth beyond stride sign.
- nv24_to_yuv420p_chroma: known bug, confirmed again (slices only constrained by src macro height 1).

swscale.rs
- {abgr32,argb32,bgr24,bgra32,rgb24,rgba32}To{Y,UV,UV_half}_neon (+ bgra/rgba ToY dotprod): w = srcW / chrSrcW; dst lines padded (slice.c:305, src_w*2+78). UPHELD, with the UV_half odd-width over-read noted (shared with C).
- {lum,chr}Range{From,To}Jpeg{8,16}: dst = hscale output lines of FFALIGN(dst_w*2+66,16) bytes (x2 / x4 for 16/32 bpc), slice.c:257-273, 311 -> >= dst_w + 33 elements. UPHELD.
- hscale*_4 (filter_size == 4: ASSIGN_SCALE_FUNC, aarch64/swscale.c:260-266; filter_pos len dstW+3, utils.c:233; filter (dstW+3)*filterSize, utils.c:581; dst lines as above): UPHELD except src_w >= filter_size (bug 3, low). X4/X8 FAIL/TIMEOUT.
- yuv2plane1_8 / yuv2planeX_8 / yuv2planeX_10 (FAIL): src lines = hscale output (>= dst_w+33, UPHELD). dest.len() == round8(dst_w) is API-level: swscale switches to C output funcs for the last two dst rows (swscale.c:523-531) so the 8-px overwrite only lands in the next row; not verified anyway.
- yuv2nv12cX: chrDstW, src lines padded. UPHELD.
- rgb24tobgr24 / rgb24tobgr32 / rgb32tobgr24 / shuffle_bytes_* (src_size % 3 / % 4): rgbToRgbWrapper passes (h-1)*stride + w*Bpp only when stride % Bpp == 0, else w*Bpp per row (swscale_unscaled.c:2036-2050). UPHELD, except the RGB32_1 +1 pointer offsets (section 2).
- rgb24toyv12: bug 2. uyvy/yuyv to yuv420/422: NOT-UPHELD-SAFE. interleave/deinterleave_bytes (TIMEOUT/MEMCAP): bounds only, not audited further.
- xyz12Torgb48le (TIMEOUT): w/h from frame, scratch buffer FFABS(stride)*h+32 (swscale.c:1130-1137). UPHELD.

tx_float.rs
- fft2/4/8/16/32(+ns), fft15(+ns): fixed lengths from TX_DEF (tx_float_init.c:177-189). UPHELD (map annotation layout question in section 2).
- fft_sr / fft_sr_ns: lengths 64..131072 registered; annotation covers 32..4096 only. Sizes 8192..131072 UNCLEAR (unverified paths).

yuv2rgb.rs (all TIMEOUT)
- 420/nv12/nv21/yuva420 2-line kernels: `h % 2` NOT-UPHELD-UNSAFE (bug 1); `w % 16` UPHELD by src_w gate.
- yuv422p kernels: per-row loop, any h safe; w % 16 UPHELD.
