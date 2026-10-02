#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("cdef.S", tmp.as_mut_ptr().add(24), src.as_ptr(), src_stride, left.as_ptr(), top.as_ptr().add(2), bottom.as_ptr().add(2), h, edges,
    [tmp.len() == 104, src.len() == src_stride * h + 2, left.len() == 16, top.len() == src_stride + 4 + 6, bottom.len() == src_stride + 4 + 6, h >= 4, h <= 8, src_stride >= 4])]
fn cdef_padding4_8bpc_neon(
    tmp: &mut [u16],
    src: &[u8],
    src_stride: usize,
    left: &[u8],
    top: &[u8],
    bottom: &[u8],
    h: usize,
    edges: u32,
);

#[bums::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst_stride, tmp.as_ptr().add(24), pri_strength, sec_strength, dir, damping, h, edges, bitdepth_max,
    [dst.len() == dst_stride * h, tmp.len() == 104, h >= 4, h <= 8, dst_stride >= 4, dir >= 0, dir <= 7])]
fn cdef_filter4_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    tmp: &[u16],
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
    h: usize,
    edges: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("cdef.S", tmp.as_mut_ptr().add(40), src.as_ptr(), src_stride, left.as_ptr(), top.as_ptr().add(2), bottom.as_ptr().add(2), h, edges,
    [tmp.len() == 200, src.len() == src_stride * h + 2, left.len() == 16, top.len() == src_stride + 8 + 6, bottom.len() == src_stride + 8 + 6, h >= 4, h <= 8, src_stride >= 8])]
fn cdef_padding8_8bpc_neon(
    tmp: &mut [u16],
    src: &[u8],
    src_stride: usize,
    left: &[u8],
    top: &[u8],
    bottom: &[u8],
    h: usize,
    edges: u32,
);

#[bums::check_mem_safe("cdef.S", dst.as_mut_ptr(), dst_stride, tmp.as_ptr().add(40), pri_strength, sec_strength, dir, damping, h, edges, bitdepth_max,
    [dst.len() == dst_stride * h, tmp.len() == 200, h >= 4, h <= 8, dst_stride >= 8, dir >= 0, dir <= 7])]
fn cdef_filter8_8bpc_neon(
    dst: &mut [u8],
    dst_stride: usize,
    tmp: &[u16],
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
    h: usize,
    edges: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("cdef.S", src.as_ptr(), stride, variance.as_mut_ptr(), bitdepth_max,
    [src.len() == stride * 8, stride >= 8, variance.len() == 1])]
fn cdef_find_dir_8bpc_neon(src: &[u8], stride: usize, variance: &mut [u32], bitdepth_max: i32) -> i32;

#[bums::check_mem_safe("cdef.S", tmp.as_mut_ptr().add(24), src.as_ptr(), src_stride, left.as_ptr(), top.as_ptr().add(2), bottom.as_ptr().add(2), h, edges,
    [tmp.len() == 104, src.len() == src_stride * h + 2, left.len() == 16, top.len() == src_stride + 4 + 6, bottom.len() == src_stride + 4 + 6, h >= 4, h <= 8, src_stride >= 4])]
fn cdef_padding4_edged_8bpc_neon(
    tmp: &mut [u16],
    src: &[u8],
    src_stride: usize,
    left: &[u8],
    top: &[u8],
    bottom: &[u8],
    h: usize,
    edges: u32,
);

#[bums::check_mem_safe("cdef.S", tmp.as_mut_ptr().add(40), src.as_ptr(), src_stride, left.as_ptr(), top.as_ptr().add(2), bottom.as_ptr().add(2), h, edges,
    [tmp.len() == 200, src.len() == src_stride * h + 2, left.len() == 16, top.len() == src_stride + 8 + 6, bottom.len() == src_stride + 8 + 6, h >= 4, h <= 8, src_stride >= 8])]
fn cdef_padding8_edged_8bpc_neon(
    tmp: &mut [u16],
    src: &[u8],
    src_stride: usize,
    left: &[u8],
    top: &[u8],
    bottom: &[u8],
    h: usize,
    edges: u32,
);
#[bums::check_mem_safe("cdef16.S", tmp.as_mut_ptr().add(24), src.as_ptr(), src_stride, left.as_ptr(), top.as_ptr().add(2), bottom.as_ptr().add(2), h, edges,
    [tmp.len() == 104, src.len() == src_stride * h + 2, left.len() == 16, top.len() == src_stride + 4 + 6, bottom.len() == src_stride + 4 + 6, h >= 4, h <= 8, src_stride >= 4])]
fn cdef_padding4_16bpc_neon(
    tmp: &mut [u16],
    src: &[u16],
    src_stride: usize,
    left: &[u16],
    top: &[u16],
    bottom: &[u16],
    h: usize,
    edges: u32,
);

#[bums::check_mem_safe("cdef16.S", dst.as_mut_ptr(), dst_stride, tmp.as_ptr().add(24), pri_strength, sec_strength, dir, damping, h, edges, bitdepth_max,
    [dst.len() == dst_stride * h, tmp.len() == 104, h >= 4, h <= 8, dst_stride >= 4, dir >= 0, dir <= 7])]
fn cdef_filter4_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    tmp: &[u16],
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
    h: usize,
    edges: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("cdef16.S", tmp.as_mut_ptr().add(40), src.as_ptr(), src_stride, left.as_ptr(), top.as_ptr().add(2), bottom.as_ptr().add(2), h, edges,
    [tmp.len() == 200, src.len() == src_stride * h + 2, left.len() == 16, top.len() == src_stride + 8 + 6, bottom.len() == src_stride + 8 + 6, h >= 4, h <= 8, src_stride >= 8])]
fn cdef_padding8_16bpc_neon(
    tmp: &mut [u16],
    src: &[u16],
    src_stride: usize,
    left: &[u16],
    top: &[u16],
    bottom: &[u16],
    h: usize,
    edges: u32,
);

#[bums::check_mem_safe("cdef16.S", dst.as_mut_ptr(), dst_stride, tmp.as_ptr().add(40), pri_strength, sec_strength, dir, damping, h, edges, bitdepth_max,
    [dst.len() == dst_stride * h, tmp.len() == 200, h >= 4, h <= 8, dst_stride >= 8, dir >= 0, dir <= 7])]
fn cdef_filter8_16bpc_neon(
    dst: &mut [u16],
    dst_stride: usize,
    tmp: &[u16],
    pri_strength: i32,
    sec_strength: i32,
    dir: i32,
    damping: i32,
    h: usize,
    edges: usize,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("cdef16.S", src.as_ptr(), stride, variance.as_mut_ptr(), bitdepth_max,
    [src.len() == stride * 8, stride >= 8, variance.len() == 1])]
fn cdef_find_dir_16bpc_neon(src: &[u16], stride: usize, variance: &mut [u32], bitdepth_max: i32) -> i32;
