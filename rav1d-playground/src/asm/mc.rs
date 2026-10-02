#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_smooth_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_sharp_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_regular_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_sharp_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_regular_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_smooth_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 1) + w + 2, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_bilin_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_smooth_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_sharp_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_regular_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_sharp_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_regular_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_smooth_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 1) + w + 2, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_bilin_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn avg_8bpc_neon(dst: &mut [u8], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, weight, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_avg_8bpc_neon(dst: &mut [u8], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, weight: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_ptr(), bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn mask_8bpc_neon(dst: &mut [u8], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &[u8], bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_mut_ptr(), sign, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h / 4, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_mask_420_8bpc_neon(dst: &mut [u8], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &mut [u8], sign: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_mut_ptr(), sign, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h / 2, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_mask_422_8bpc_neon(dst: &mut [u8], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &mut [u8], sign: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_mut_ptr(), sign, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h / 1, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_mask_444_8bpc_neon(dst: &mut [u8], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &mut [u8], sign: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp.as_ptr(), w, h, mask.as_ptr(),
    [dst.len() == stride * h, tmp.len() == w * h, mask.len() == w * h, w >= 4, h >= 4, w <= 32, h <= 32, 32 % h == 0, 32 % w == 0, stride >= w])]
fn blend_8bpc_neon(dst: &mut [u8], stride: usize, tmp: &[u8], w: usize, h: usize, mask: &[u8]);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp.as_ptr(), w, h,
    [dst.len() == stride * h, tmp.len() == w * h, w >= 2, h >= 4, w <= 32, h <= 32, 32 % h == 0, 32 % w == 0, stride >= w])]
fn blend_v_8bpc_neon(dst: &mut [u8], stride: usize, tmp: &[u8], w: usize, h: usize);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), stride, tmp.as_ptr(), w, h,
    [dst.len() == stride * h, tmp.len() == w * h, w >= 2, h >= 2, w <= 128, h <= 32, stride >= w])]
fn blend_h_8bpc_neon(dst: &mut [u8], stride: usize, tmp: &[u8], w: usize, h: usize);

#[bums::check_mem_safe("mc.S", bw, bh, iw, ih, x, y, dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride,
    [bw >= 1, bh >= 1, iw >= 1, ih >= 1, dst.len() == 320 * (256 + 7), dst_stride % 32 == 0, bw * 1 <= dst_stride, (bh - 1) * dst_stride + (bw + 32) * 1 <= dst.len() * 1, src_stride % 32 == 0, iw * 1 <= src_stride, (ih - 1) * src_stride + (iw + 32) * 1 <= src.len() * 1])]
fn emu_edge_8bpc_neon(
    bw: usize,
    bh: usize,
    iw: usize,
    ih: usize,
    x: isize,
    y: isize,
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, abcd.as_ptr(), mx, my, bitdepth_max,
    [dst.len() == dst_stride * 8, src.len() == src_stride * 15, abcd.len() == 4, dst_stride >= 8, src_stride >= 15])]
fn warp_affine_8x8_8bpc_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, abcd: &[i16], mx: i32, my: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), tmp_stride, src.as_ptr(), src_stride, abcd.as_ptr(), mx, my, bitdepth_max,
    [tmp.len() == tmp_stride * 8, src.len() == src_stride * 15, abcd.len() == 4, tmp_stride >= 8, src_stride >= 15])]
fn warp_affine_8x8t_8bpc_neon(tmp: &mut [i16], tmp_stride: usize, src: &[u8], src_stride: usize, abcd: &[i16], mx: i32, my: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, w, h,
    [dst.len() == dst_stride * h, src.len() == src_stride * h, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w])]
fn put_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, w: usize, h: usize);

#[bums::check_mem_safe("mc.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, w, h,
    [tmp.len() == w * h, src.len() == src_stride * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w])]
fn prep_neon(tmp: &mut [i16], src: &[u8], src_stride: usize, w: usize, h: usize);
#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_smooth_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_sharp_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_regular_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_sharp_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_regular_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_smooth_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 1) + w + 2, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_bilin_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_smooth_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_sharp_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_regular_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_sharp_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_regular_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_smooth_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 1) + w + 2, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_bilin_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn avg_16bpc_neon(dst: &mut [u16], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, weight, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_avg_16bpc_neon(dst: &mut [u16], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, weight: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_ptr(), bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn mask_16bpc_neon(dst: &mut [u16], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &[u8], bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_mut_ptr(), sign, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h / 4, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_mask_420_16bpc_neon(dst: &mut [u16], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &mut [u8], sign: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_mut_ptr(), sign, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h / 2, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_mask_422_16bpc_neon(dst: &mut [u16], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &mut [u8], sign: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp1.as_ptr(), tmp2.as_ptr(), w, h, mask.as_mut_ptr(), sign, bitdepth_max,
    [dst.len() == stride * h, tmp1.len() == w * h, tmp2.len() == w * h, mask.len() == w * h / 1, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, stride >= w])]
fn w_mask_444_16bpc_neon(dst: &mut [u16], stride: usize, tmp1: &[i16], tmp2: &[i16], w: usize, h: usize, mask: &mut [u8], sign: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp.as_ptr(), w, h, mask.as_ptr(),
    [dst.len() == stride * h, tmp.len() == w * h, mask.len() == w * h, w >= 4, h >= 4, w <= 32, h <= 32, 32 % h == 0, 32 % w == 0, stride >= w])]
fn blend_16bpc_neon(dst: &mut [u16], stride: usize, tmp: &[u16], w: usize, h: usize, mask: &[u8]);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp.as_ptr(), w, h,
    [dst.len() == stride * h, tmp.len() == w * h, w >= 2, h >= 4, w <= 32, h <= 32, 32 % h == 0, 32 % w == 0, stride >= w])]
fn blend_v_16bpc_neon(dst: &mut [u16], stride: usize, tmp: &[u16], w: usize, h: usize);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), stride, tmp.as_ptr(), w, h,
    [dst.len() == stride * h, tmp.len() == w * h, w >= 2, h >= 2, w <= 128, h <= 32, stride >= w])]
fn blend_h_16bpc_neon(dst: &mut [u16], stride: usize, tmp: &[u16], w: usize, h: usize);

#[bums::check_mem_safe("mc16.S", bw, bh, iw, ih, x, y, dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride,
    [bw >= 1, bh >= 1, iw >= 1, ih >= 1, dst.len() == 320 * (256 + 7), dst_stride % 64 == 0, bw * 2 <= dst_stride, (bh - 1) * dst_stride + (bw + 32) * 2 <= dst.len() * 2, src_stride % 64 == 0, iw * 2 <= src_stride, (ih - 1) * src_stride + (iw + 32) * 2 <= src.len() * 2])]
fn emu_edge_16bpc_neon(
    bw: usize,
    bh: usize,
    iw: usize,
    ih: usize,
    x: isize,
    y: isize,
    dst: &mut [u16],
    dst_stride: usize,
    src: &[u16],
    src_stride: usize,
);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, abcd.as_ptr(), mx, my, bitdepth_max,
    [dst.len() == dst_stride * 8, src.len() == src_stride * 15, abcd.len() == 4, dst_stride >= 8, src_stride >= 15])]
fn warp_affine_8x8_16bpc_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, abcd: &[i16], mx: i32, my: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", tmp.as_mut_ptr(), tmp_stride, src.as_ptr(), src_stride, abcd.as_ptr(), mx, my, bitdepth_max,
    [tmp.len() == tmp_stride * 8, src.len() == src_stride * 15, abcd.len() == 4, tmp_stride >= 8, src_stride >= 15])]
fn warp_affine_8x8t_16bpc_neon(tmp: &mut [i16], tmp_stride: usize, src: &[u16], src_stride: usize, abcd: &[i16], mx: i32, my: i32, bitdepth_max: i32);

#[bums::check_mem_safe("mc16.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, w, h,
    [dst.len() == dst_stride * h, src.len() == src_stride * h, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w])]
fn put_16bpc_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, w: usize, h: usize);
#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_smooth_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_sharp_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_regular_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_sharp_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_regular_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_smooth_8bpc_neon_dotprod(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_smooth_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_sharp_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_regular_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_sharp_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_regular_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_smooth_8bpc_neon_dotprod(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_smooth_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_regular_sharp_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_regular_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_smooth_sharp_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_regular_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [dst.len() == dst_stride * h, src.len() == src_stride * (h + 6) + w + 7, w >= 2, h >= 2, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, dst_stride >= w, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn put_8tap_sharp_smooth_8bpc_neon_i8mm(
    dst: &mut [u8],
    dst_stride: usize,
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_smooth_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_regular_sharp_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_regular_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_smooth_sharp_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_regular_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("mc_dotprod.S", tmp.as_mut_ptr(), src.as_ptr().add(3 * src_stride + 3), src_stride, w, h, mx, my, bitdepth_max,
    [tmp.len() == w * h, src.len() == src_stride * (h + 6) + w + 7, w >= 4, h >= 4, w <= 128, h <= 128, 128 % h == 0, 128 % w == 0, src_stride >= w, mx >= 0, mx <= 15, my >= 0, my <= 15])]
fn prep_8tap_sharp_smooth_8bpc_neon_i8mm(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    w: usize,
    h: usize,
    mx: i32,
    my: i32,
    bitdepth_max: i32,
);
