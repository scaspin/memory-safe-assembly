#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("loopfilter.S", dst.as_mut_ptr().add(8 * stride), stride, mask.as_ptr(), lvl.as_ptr().add(4 * b4_stride), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() == stride * 16, mask.len() == 3, lvl.len() == 4 * b4_stride + 128, lut.len() == 144, w >= 1, w <= 32, stride >= 128, b4_stride >= 1])]
fn lpf_v_sb_y_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("loopfilter.S", dst.as_mut_ptr().add(8 * stride), stride, mask.as_ptr(), lvl.as_ptr().add(4 * b4_stride), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() == stride * 16, mask.len() == 3, mask[0] <= 65535, mask[1] <= 65535, stride >= 64, lvl.len() == 4 * b4_stride + 128, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_v_sb_uv_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("loopfilter.S", dst.as_mut_ptr().add(8), stride, mask.as_ptr(), lvl.as_ptr().add(4), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() == stride * 128, mask.len() == 3, stride >= 16, lvl.len() == 124 * b4_stride + 8, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_h_sb_y_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("loopfilter.S", dst.as_mut_ptr().add(8), stride, mask.as_ptr(), lvl.as_ptr().add(4), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() == stride * 64, mask.len() == 3, mask[0] <= 65535, mask[1] <= 65535, stride >= 16, lvl.len() == 124 * b4_stride + 8, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_h_sb_uv_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);
#[bums::check_mem_safe("loopfilter16.S", dst.as_mut_ptr().add(4 * stride), stride, mask.as_ptr(), lvl.as_ptr().add(4 * b4_stride), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() * 2 == stride * 16, mask.len() == 3, stride >= 256, stride % 2 == 0, lvl.len() == 4 * b4_stride + 128, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_v_sb_y_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("loopfilter16.S", dst.as_mut_ptr().add(4 * stride), stride, mask.as_ptr(), lvl.as_ptr().add(4 * b4_stride), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() * 2 == stride * 16, mask.len() == 3, mask[0] <= 65535, mask[1] <= 65535, stride >= 128, stride % 2 == 0, lvl.len() == 4 * b4_stride + 128, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_v_sb_uv_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("loopfilter16.S", dst.as_mut_ptr().add(8), stride, mask.as_ptr(), lvl.as_ptr().add(4), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() * 2 == stride * 128, mask.len() == 3, stride >= 32, stride % 2 == 0, lvl.len() == 124 * b4_stride + 8, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_h_sb_y_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("loopfilter16.S", dst.as_mut_ptr().add(8), stride, mask.as_ptr(), lvl.as_ptr().add(4), b4_stride, lut.as_ptr(), w, bitdepth_max,
    [dst.len() * 2 == stride * 64, mask.len() == 3, mask[0] <= 65535, mask[1] <= 65535, stride >= 32, stride % 2 == 0, lvl.len() == 124 * b4_stride + 8, lut.len() == 144, w >= 1, stride >= 4, b4_stride >= 1])]
fn lpf_h_sb_uv_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    mask: &[u32],
    lvl: &[u8],
    b4_stride: usize,
    lut: &[u8],
    w: usize,
    bitdepth_max: i32,
);
