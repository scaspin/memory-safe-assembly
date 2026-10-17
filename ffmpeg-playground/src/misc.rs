use bums_macros as bums;

#[bums::check_mem_safe("crc.S", ctx.as_ptr(), crc, buffer.as_ptr(), length,
    [ctx.len() == 33, buffer.len() == length, length <= 1099511627776])]
fn ff_crc32_pmull_eor3_aarch64(ctx: &[u32], crc: u32, buffer: &[u8], length: usize);

#[bums::check_mem_safe("audio_convert_neon.S", dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len, len % 16 == 0, len >= 16, len <= 1048576])]
fn swri_oldapi_conv_flt_to_s16_neon(dst: &mut [i16], src: &[f32], len: usize);

#[bums::check_mem_safe("audio_convert_neon.S", dst.as_mut_ptr(), src.as_ptr(), len, channels,
    [dst.len() == 2 * len, src.len() == 2, src[0] == l.as_ptr(), src[1] == r.as_ptr(), l.len() == len, r.len() == len,
     channels == 2, len % 16 == 0, len >= 16, len <= 1048576])]
fn swri_oldapi_conv_fltp_to_s16_2ch_neon(dst: &mut [i16], src: &[usize], len: usize, channels: usize, l: &[f32], r: &[f32]);

#[bums::check_mem_safe("audio_convert_neon.S", dst.as_mut_ptr(), src.as_ptr(), len, channels,
    [dst.len() == 6 * len, src.len() == 6, src[0] == c0.as_ptr(), src[1] == c1.as_ptr(), src[2] == c2.as_ptr(),
     src[3] == c3.as_ptr(), src[4] == c4.as_ptr(), src[5] == c5.as_ptr(),
     c0.len() == len, c1.len() == len, c2.len() == len, c3.len() == len, c4.len() == len, c5.len() == len,
     channels == 6, len % 16 == 0, len >= 16, len <= 1048576])]
fn swri_oldapi_conv_fltp_to_s16_nch_neon(dst: &mut [i16], src: &[usize], len: usize, channels: usize,
    c0: &[f32], c1: &[f32], c2: &[f32], c3: &[f32], c4: &[f32], c5: &[f32]);

#[bums::check_mem_safe("resample.S", acc.as_mut_ptr(), src.as_ptr(), filter.as_ptr(), length,
    [acc.len() == 1, src.len() == length, filter.len() == length, length % 4 == 0, length >= 4, length <= 65536])]
fn ff_resample_common_apply_filter_x4_float_neon(acc: &mut [f32], src: &[f32], filter: &[f32], length: usize);

#[bums::check_mem_safe("resample.S", acc.as_mut_ptr(), src.as_ptr(), filter.as_ptr(), length,
    [acc.len() == 1, src.len() == length, filter.len() == length, length % 8 == 0, length >= 8, length <= 65536])]
fn ff_resample_common_apply_filter_x8_float_neon(acc: &mut [f32], src: &[f32], filter: &[f32], length: usize);

#[bums::check_mem_safe("resample.S", acc.as_mut_ptr(), src.as_ptr(), filter.as_ptr(), length,
    [acc.len() == 1, src.len() == length, filter.len() == length, length % 4 == 0, length >= 4, length <= 65536])]
fn ff_resample_common_apply_filter_x4_s16_neon(acc: &mut [i32], src: &[i16], filter: &[i16], length: usize);

#[bums::check_mem_safe("resample.S", acc.as_mut_ptr(), src.as_ptr(), filter.as_ptr(), length,
    [acc.len() == 1, src.len() == length, filter.len() == length, length % 8 == 0, length >= 8, length <= 65536])]
fn ff_resample_common_apply_filter_x8_s16_neon(acc: &mut [i32], src: &[i16], filter: &[i16], length: usize);

#[bums::check_mem_safe("vf_colordetect_neon.S", data.as_ptr(), stride, width, height, mpeg_min, mpeg_max,
    [data.len() == (height - 1) * stride + width, stride >= width, stride <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_detect_range_neon(data: &[u8], stride: usize, width: usize, height: usize, mpeg_min: i32, mpeg_max: i32);

#[bums::check_mem_safe("vf_colordetect_neon.S", data.as_ptr(), stride, width, height, mpeg_min, mpeg_max,
    [data.len() == (height - 1) * stride + 2 * width, stride >= 2 * width, stride <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_detect_range16_neon(data: &[u8], stride: usize, width: usize, height: usize, mpeg_min: i32, mpeg_max: i32);

#[bums::check_mem_safe("vf_colordetect_neon.S", color.as_ptr(), cstride, alpha.as_ptr(), astride, width, height, alpha_max, mpeg_range, offset,
    [color.len() == (height - 1) * cstride + 1 * width, alpha.len() == (height - 1) * astride + 1 * width, cstride >= 1 * width, astride >= 1 * width,
     cstride <= 1073741824, astride <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_detect_alpha_full_neon(color: &[u8], cstride: usize, alpha: &[u8], astride: usize, width: usize, height: usize, alpha_max: i32, mpeg_range: i32, offset: i32);

#[bums::check_mem_safe("vf_colordetect_neon.S", color.as_ptr(), cstride, alpha.as_ptr(), astride, width, height, alpha_max, mpeg_range, offset,
    [color.len() == (height - 1) * cstride + 1 * width, alpha.len() == (height - 1) * astride + 1 * width, cstride >= 1 * width, astride >= 1 * width,
     cstride <= 1073741824, astride <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_detect_alpha_limited_neon(color: &[u8], cstride: usize, alpha: &[u8], astride: usize, width: usize, height: usize, alpha_max: i32, mpeg_range: i32, offset: i32);

#[bums::check_mem_safe("vf_colordetect_neon.S", color.as_ptr(), cstride, alpha.as_ptr(), astride, width, height, alpha_max, mpeg_range, offset,
    [color.len() == (height - 1) * cstride + 2 * width, alpha.len() == (height - 1) * astride + 2 * width, cstride >= 2 * width, astride >= 2 * width,
     cstride <= 1073741824, astride <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_detect_alpha16_full_neon(color: &[u8], cstride: usize, alpha: &[u8], astride: usize, width: usize, height: usize, alpha_max: i32, mpeg_range: i32, offset: i32);

#[bums::check_mem_safe("vf_colordetect_neon.S", color.as_ptr(), cstride, alpha.as_ptr(), astride, width, height, alpha_max, mpeg_range, offset,
    [color.len() == (height - 1) * cstride + 2 * width, alpha.len() == (height - 1) * astride + 2 * width, cstride >= 2 * width, astride >= 2 * width,
     cstride <= 1073741824, astride <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_detect_alpha16_limited_neon(color: &[u8], cstride: usize, alpha: &[u8], astride: usize, width: usize, height: usize, alpha_max: i32, mpeg_range: i32, offset: i32);

#[bums::check_mem_safe("vf_bwdif_neon.S", dst.as_mut_ptr(), prev.as_ptr().add(4 * s), cur.as_ptr().add(4 * s), next.as_ptr().add(4 * s), w,
    prefs, mrefs, prefs2, mrefs2, prefs3, mrefs3, prefs4, mrefs4, parity, clip_max,
    [dst.len() == w, prev.len() == 8 * s + w, cur.len() == 8 * s + w, next.len() == 8 * s + w, w % 16 == 0, s >= w, s <= 1048576, w <= 16384,
     prefs == s as i64, mrefs == -(s as i64), prefs2 == 2 * s as i64, mrefs2 == -(2 * s as i64),
     prefs3 == 3 * s as i64, mrefs3 == -(3 * s as i64), prefs4 == 4 * s as i64, mrefs4 == -(4 * s as i64), parity <= 1, clip_max <= 255])]
fn ff_bwdif_filter_line_neon(dst: &mut [u8], prev: &[u8], cur: &[u8], next: &[u8], w: usize, prefs: i64, mrefs: i64, prefs2: i64, mrefs2: i64,
    prefs3: i64, mrefs3: i64, prefs4: i64, mrefs4: i64, parity: usize, clip_max: usize, s: usize);

#[bums::check_mem_safe("vf_bwdif_neon.S", dst.as_mut_ptr(), prev.as_ptr().add(2 * s), cur.as_ptr().add(2 * s), next.as_ptr().add(2 * s), w,
    prefs, mrefs, prefs2, mrefs2, parity, clip_max, spat,
    [dst.len() == w, prev.len() == 4 * s + w, cur.len() == 4 * s + w, next.len() == 4 * s + w, w % 16 == 0, s >= w, s <= 1048576, w <= 16384,
     prefs == s as i64, mrefs == -(s as i64), prefs2 == 2 * s as i64, mrefs2 == -(2 * s as i64), parity <= 1, clip_max <= 255, spat <= 1])]
fn ff_bwdif_filter_edge_neon(dst: &mut [u8], prev: &[u8], cur: &[u8], next: &[u8], w: usize, prefs: i64, mrefs: i64, prefs2: i64, mrefs2: i64,
    parity: usize, clip_max: usize, spat: usize, s: usize);

#[bums::check_mem_safe("vf_bwdif_neon.S", dst.as_mut_ptr(), cur.as_ptr().add(3 * s), w, prefs, mrefs, prefs3, mrefs3, parity, clip_max,
    [dst.len() == w, cur.len() == 6 * s + w, w % 16 == 0, s >= w, s <= 1048576, w <= 16384,
     prefs == s as i64, mrefs == -(s as i64), prefs3 == 3 * s as i64, mrefs3 == -(3 * s as i64), parity <= 1, clip_max <= 255])]
fn ff_bwdif_filter_intra_neon(dst: &mut [u8], cur: &[u8], w: usize, prefs: i64, mrefs: i64, prefs3: i64, mrefs3: i64, parity: usize, clip_max: usize, s: usize);

#[bums::check_mem_safe("swscale_unscaled_neon.S", dst1.as_mut_ptr(), ds1, dst2.as_mut_ptr(), ds2, src.as_ptr(), ss, w, h,
    [dst1.len() == (h / 2 - 1) * ds1 + w, dst2.len() == (h / 2 - 1) * ds2 + w, src.len() == (h - 1) * ss + 4 * w,
     ds1 >= w, ds2 >= w, ss >= 4 * w, ds1 <= 1073741824, ds2 <= 1073741824, ss <= 1073741824,
     w >= 1, w <= 8192, h % 2 == 0, h >= 2, h <= 16384])]
fn ff_nv24_to_yuv420p_chroma_neon(dst1: &mut [u8], ds1: usize, dst2: &mut [u8], ds2: usize, src: &[u8], ss: usize, w: usize, h: usize);

#[bums::check_mem_safe("vf_nlmeans_neon.S", ii.as_mut_ptr().add(stride + 4), stride, s1.as_ptr(), linesize1, s2.as_ptr(), linesize2, w, h,
    [ii.len() == h * stride + 4 + w, s1.len() == (h - 1) * linesize1 + w, s2.len() == (h - 1) * linesize2 + w,
     w % 16 == 0, w >= 16, w <= 16384, h >= 1, h <= 16384, stride >= w + 4, stride <= 268435456,
     linesize1 >= w, linesize2 >= w, linesize1 <= 1073741824, linesize2 <= 1073741824])]
fn ff_compute_safe_ssd_integral_image_neon(ii: &mut [u32], stride: usize, s1: &[u8], linesize1: usize, s2: &[u8], linesize2: usize, w: usize, h: usize);

#[bums::check_mem_safe("vf_nlmeans_neon.S", iia.as_ptr(), iib.as_ptr(), iid.as_ptr(), iie.as_ptr(), src.as_ptr(), total_weight.as_mut_ptr(), sum.as_mut_ptr(), weight_lut.as_ptr(), max_meaningful_diff, startx, endx,
    [iia.len() == endx, iib.len() == endx, iid.len() == endx, iie.len() == endx, src.len() == endx,
     total_weight.len() == endx, sum.len() == endx, weight_lut.len() == max_meaningful_diff + 1,
     max_meaningful_diff <= 1073741824, startx <= endx, endx <= 16384])]
fn ff_compute_weights_line_neon(iia: &[u32], iib: &[u32], iid: &[u32], iie: &[u32], src: &[u8], total_weight: &mut [f32], sum: &mut [f32], weight_lut: &[f32], max_meaningful_diff: usize, startx: usize, endx: usize);

#[bums::check_mem_safe("vf_bwdif_neon.S", dst.as_mut_ptr(), d_stride, prev.as_ptr().add(4 * s_stride), cur.as_ptr().add(4 * s_stride), next.as_ptr().add(4 * s_stride), s_stride, w, parity, clip_max,
    [w % 16 == 0 || (d_stride >= (w + 15) / 16 * 16 && s_stride >= (w + 15) / 16 * 16),
     dst.len() == 2 * d_stride + (w + 15) / 16 * 16, prev.len() == 10 * s_stride + (w + 15) / 16 * 16,
     cur.len() == 10 * s_stride + (w + 15) / 16 * 16, next.len() == 10 * s_stride + (w + 15) / 16 * 16,
     d_stride >= w, s_stride >= w, d_stride <= 16777216, s_stride <= 16777216, w <= 16384, parity <= 1, clip_max == 255])]
fn ff_bwdif_filter_line3_neon(dst: &mut [u8], d_stride: usize, prev: &[u8], cur: &[u8], next: &[u8], s_stride: usize, w: usize, parity: usize, clip_max: usize);
