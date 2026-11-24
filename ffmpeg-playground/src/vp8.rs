use bums_macros as bums;

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr().add(4 * stride), stride, flim_e, flim_i, hev_thresh,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp8_v_loop_filter16_neon(dst: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr().add(4 * stride), stride, flim_e, flim_i, hev_thresh,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp8_v_loop_filter16_inner_neon(dst: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr().add(4 * stride), stride, flim,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp8_v_loop_filter16_simple_neon(dst: &mut [u8], stride: usize, flim: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst_u.as_mut_ptr().add(4 * stride), dst_v.as_mut_ptr().add(4 * stride), stride, flim_e, flim_i, hev_thresh,
    [dst_u.len() == 7 * stride + 8, dst_v.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_v_loop_filter8uv_neon(dst_u: &mut [u8], dst_v: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst_u.as_mut_ptr().add(4 * stride), dst_v.as_mut_ptr().add(4 * stride), stride, flim_e, flim_i, hev_thresh,
    [dst_u.len() == 7 * stride + 8, dst_v.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_v_loop_filter8uv_inner_neon(dst_u: &mut [u8], dst_v: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr().add(4), stride, flim_e, flim_i, hev_thresh,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_h_loop_filter16_neon(dst: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr().add(4), stride, flim_e, flim_i, hev_thresh,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_h_loop_filter16_inner_neon(dst: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr().add(4), stride, flim,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_h_loop_filter16_simple_neon(dst: &mut [u8], stride: usize, flim: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst_u.as_mut_ptr().add(4), dst_v.as_mut_ptr().add(4), stride, flim_e, flim_i, hev_thresh,
    [dst_u.len() == 7 * stride + 8, dst_v.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_h_loop_filter8uv_neon(dst_u: &mut [u8], dst_v: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst_u.as_mut_ptr().add(4), dst_v.as_mut_ptr().add(4), stride, flim_e, flim_i, hev_thresh,
    [dst_u.len() == 7 * stride + 8, dst_v.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp8_h_loop_filter8uv_inner_neon(dst_u: &mut [u8], dst_v: &mut [u8], stride: usize, flim_e: i32, flim_i: i32, hev_thresh: i32);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h - 1 + 0) * srcstride + 16, dststride >= 16, srcstride >= 16, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_pixels16_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h - 1 + 0) * srcstride + 8, dststride >= 8, srcstride >= 8, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_pixels8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 16, srcstride >= 16, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel16_v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 16, srcstride >= 21, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_epel16_h6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 16, srcstride >= 21, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel16_h6v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 8, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel8_v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 13, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_epel8_h6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 13, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel8_h6v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 4) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 8, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel8_v4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 11, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_epel8_h4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 1), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 11, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel8_h4v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 4) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 11, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel8_h4v4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 4) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 8, srcstride >= 13, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel8_h6v4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 4, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel4_v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 9, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_epel4_h6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 9, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel4_h6v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(2 * srcstride + 1), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 6) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 7, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel4_h4v6_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 2), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 4) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 9, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel4_h6v4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 7, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_epel4_h4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 4) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 4, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel4_v4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 4) * srcstride + 16 || (srcstride == 32 && src.len() == 672), dststride >= 4, srcstride >= 7, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_put_vp8_epel4_h4v4_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 670), dststride >= 16, srcstride >= 17, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin16_h_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h + 2) * srcstride + 16 || (srcstride == 32 && src.len() == 606), dststride >= 16, srcstride >= 16, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin16_v_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 16, src.len() == (h + 2) * srcstride + 16 || (srcstride == 32 && src.len() == 606), dststride >= 16, srcstride >= 17, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 8, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin16_hv_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 670), dststride >= 8, srcstride >= 9, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin8_h_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 2) * srcstride + 16 || (srcstride == 32 && src.len() == 606), dststride >= 8, srcstride >= 8, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin8_v_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 8, src.len() == (h + 2) * srcstride + 16 || (srcstride == 32 && src.len() == 606), dststride >= 8, srcstride >= 9, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin8_hv_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 1) * srcstride + 16 || (srcstride == 32 && src.len() == 670), dststride >= 4, srcstride >= 5, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin4_h_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 2) * srcstride + 16 || (srcstride == 32 && src.len() == 606), dststride >= 4, srcstride >= 4, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin4_v_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 0), srcstride, h, mx, my,
    [dst.len() == (h - 1) * dststride + 4, src.len() == (h + 2) * srcstride + 16 || (srcstride == 32 && src.len() == 606), dststride >= 4, srcstride >= 5, dststride <= 1073741824, srcstride <= 1073741824, h % 4 == 0, h >= 4, h <= 8, mx >= 0, mx <= 7, my >= 0, my <= 7])]
fn ff_put_vp8_bilin4_hv_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", block.as_mut_ptr(), dc.as_mut_ptr(), [block.len() == 256, dc.len() == 16])]
fn ff_vp8_luma_dc_wht_neon(block: &mut [i16], dc: &mut [i16]);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 3 * stride + 4, block.len() == 16, stride >= 4, stride <= 1073741824])]
fn ff_vp8_idct_add_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 3 * stride + 4, block.len() == 16, stride >= 4, stride <= 1073741824])]
fn ff_vp8_idct_dc_add_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 3 * stride + 16, block.len() == 64, stride >= 16, stride <= 1073741824])]
fn ff_vp8_idct_dc_add4y_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("vp8dsp_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 7 * stride + 8, block.len() == 64, stride >= 8, stride <= 1073741824])]
fn ff_vp8_idct_dc_add4uv_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

