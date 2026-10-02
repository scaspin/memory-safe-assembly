#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("looprestoration.S", dst.as_mut_ptr(), stride, left.as_ptr(), lpf.as_ptr(), w, h, filter.as_ptr(), edges, bitdepth_max,
    [dst.len() * 1 == stride * h, left.len() == 4 * h, lpf.len() * 1 == stride * 2, filter.len() == 16, w >= 4, w <= 256, h >= 1, h <= 64, stride >= 128 * 1, stride % 16 == 0])]
fn wiener_filter7_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    left: &[u8],
    lpf: &[u8],
    w: usize,
    h: usize,
    filter: &[i16],
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration.S", dst.as_mut_ptr(), stride, left.as_ptr(), lpf.as_ptr(), w, h, filter.as_ptr(), edges, bitdepth_max,
    [dst.len() * 1 == stride * h, left.len() == 4 * h, lpf.len() * 1 == stride * 2, filter.len() == 16, w >= 4, w <= 256, h >= 1, h <= 64, stride >= 128 * 1, stride % 16 == 0])]
fn wiener_filter5_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    left: &[u8],
    lpf: &[u8],
    w: usize,
    h: usize,
    filter: &[i16],
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration.S", sumsq.as_mut_ptr(), sum.as_mut_ptr(), left.as_ptr(), src.as_ptr(), w, edges, bitdepth_max,
    [sumsq.len() == 400, sum.len() == 400, left.len() == 4, src.len() >= w + 22, w >= 4, w <= 256])]
fn sgr_box3_row_h_8bpc_neon(
    sumsq: &mut [i32],
    sum: &mut [i16],
    left: &[u8],
    src: &[u8],
    w: usize,
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration.S", sumsq.as_mut_ptr(), sum.as_mut_ptr(), left.as_ptr(), src.as_ptr(), w, edges, bitdepth_max,
    [sumsq.len() == 400, sum.len() == 400, left.len() == 4, src.len() >= w + 22, w >= 4, w <= 256])]
fn sgr_box5_row_h_8bpc_neon(
    sumsq: &mut [i32],
    sum: &mut [i16],
    left: &[u8],
    src: &[u8],
    w: usize,
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration.S", sumsq3.as_mut_ptr(), sum3.as_mut_ptr(), sumsq5.as_mut_ptr(), sum5.as_mut_ptr(), left.as_ptr(), src.as_ptr(), w, edges, bitdepth_max,
    [sumsq3.len() == 400, sum3.len() == 400, sumsq5.len() == 400, sum5.len() == 400, left.len() == 4, src.len() >= w + 22, w >= 4, w <= 256])]
fn sgr_box35_row_h_8bpc_neon(
    sumsq3: &mut [i32],
    sum3: &mut [i16],
    sumsq5: &mut [i32],
    sum5: &mut [i16],
    left: &[u8],
    src: &[u8],
    w: usize,
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, h, bitdepth_max,
    [tmp.len() == 2 * 384, src.len() * 1 == src_stride * h, a_ptrs.len() == 4, b_ptrs.len() == 4, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), a_ptrs[2] == a_buf.as_mut_ptr().add(o_a_buf2), a_ptrs[3] == a_buf.as_mut_ptr().add(o_a_buf3), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), o_a_buf2 + 400 <= a_buf.len(), o_a_buf3 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), b_ptrs[2] == b_buf.as_mut_ptr().add(o_b_buf2), b_ptrs[3] == b_buf.as_mut_ptr().add(o_b_buf3), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), o_b_buf2 + 400 <= b_buf.len(), o_b_buf3 + 400 <= b_buf.len(), w >= 4, w <= 256, h >= 1, h <= 2, src_stride >= w * 1, src_stride % 16 == 0])]
fn sgr_finish_filter1_2rows_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    h: usize,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    o_a_buf2: usize,
    o_a_buf3: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
    o_b_buf2: usize,
    o_b_buf3: usize,
);

#[bums::check_mem_safe("looprestoration.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, h, bitdepth_max,
    [tmp.len() == 2 * 384, src.len() * 1 == src_stride * h, a_ptrs.len() == 2, b_ptrs.len() == 2, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), w >= 4, w <= 256, h >= 1, h <= 2, src_stride >= w * 1, src_stride % 16 == 0])]
fn sgr_finish_filter2_2rows_8bpc_neon(
    tmp: &mut [i16],
    src: &[u8],
    src_stride: usize,
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    h: usize,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
);

#[bums::check_mem_safe("looprestoration.S", dst.as_mut_ptr(), a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, w1, bitdepth_max,
    [dst.len() >= w, dst.len() * 1 % 16 == 0, a_ptrs.len() == 3, b_ptrs.len() == 3, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), a_ptrs[2] == a_buf.as_mut_ptr().add(o_a_buf2), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), o_a_buf2 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), b_ptrs[2] == b_buf.as_mut_ptr().add(o_b_buf2), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), o_b_buf2 + 400 <= b_buf.len(), w >= 4, w <= 256])]
fn sgr_finish_weighted1_8bpc_neon(
    dst: &mut [u8],
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    w1: i32,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    o_a_buf2: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
    o_b_buf2: usize,
);

#[bums::check_mem_safe("looprestoration.S", dst.as_mut_ptr(), stride, a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, h, w1, bitdepth_max,
    [dst.len() * 1 == stride * h, a_ptrs.len() == 2, b_ptrs.len() == 2, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), w >= 4, w <= 256, h >= 1, h <= 2, stride >= w * 1, stride % 16 == 0])]
fn sgr_finish_weighted2_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    h: usize,
    w1: i32,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
);

#[bums::check_mem_safe("looprestoration.S", dst.as_mut_ptr(), stride, t1.as_ptr(), t2.as_ptr(), w, h, wt.as_ptr(), bitdepth_max,
    [dst.len() * 1 == stride * h, t1.len() == 2 * 384, t2.len() == 2 * 384, wt.len() == 2, w >= 8, w <= 256, w % 8 == 0, h >= 1, h <= 2, stride >= 128 * 1, stride % 16 == 0])]
fn sgr_weighted2_8bpc_neon(
    dst: &mut [u8],
    stride: usize,
    t1: &[i16],
    t2: &[i16],
    w: usize,
    h: usize,
    wt: &[i16],
    bitdepth_max: i32,
);
#[bums::check_mem_safe("looprestoration16.S", dst.as_mut_ptr(), stride, left.as_ptr(), lpf.as_ptr(), w, h, filter.as_ptr(), edges, bitdepth_max,
    [dst.len() * 2 == stride * h, left.len() == 4 * h, lpf.len() * 2 == stride * 2, filter.len() == 16, w >= 4, w <= 256, h >= 1, h <= 64, stride >= 128 * 2, stride % 16 == 0])]
fn wiener_filter7_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    left: &[u16],
    lpf: &[u16],
    w: usize,
    h: usize,
    filter: &[i16],
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration16.S", dst.as_mut_ptr(), stride, left.as_ptr(), lpf.as_ptr(), w, h, filter.as_ptr(), edges, bitdepth_max,
    [dst.len() * 2 == stride * h, left.len() == 4 * h, lpf.len() * 2 == stride * 2, filter.len() == 16, w >= 4, w <= 256, h >= 1, h <= 64, stride >= 128 * 2, stride % 16 == 0])]
fn wiener_filter5_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    left: &[u16],
    lpf: &[u16],
    w: usize,
    h: usize,
    filter: &[i16],
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration16.S", sumsq.as_mut_ptr(), sum.as_mut_ptr(), left.as_ptr(), src.as_ptr(), w, edges, bitdepth_max,
    [sumsq.len() == 400, sum.len() == 400, left.len() == 4, src.len() >= w + 22, w >= 4, w <= 256])]
fn sgr_box3_row_h_16bpc_neon(
    sumsq: &mut [i32],
    sum: &mut [i16],
    left: &[u16],
    src: &[u16],
    w: usize,
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration16.S", sumsq.as_mut_ptr(), sum.as_mut_ptr(), left.as_ptr(), src.as_ptr(), w, edges, bitdepth_max,
    [sumsq.len() == 400, sum.len() == 400, left.len() == 4, src.len() >= w + 22, w >= 4, w <= 256])]
fn sgr_box5_row_h_16bpc_neon(
    sumsq: &mut [i32],
    sum: &mut [i16],
    left: &[u16],
    src: &[u16],
    w: usize,
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration16.S", sumsq3.as_mut_ptr(), sum3.as_mut_ptr(), sumsq5.as_mut_ptr(), sum5.as_mut_ptr(), left.as_ptr(), src.as_ptr(), w, edges, bitdepth_max,
    [sumsq3.len() == 400, sum3.len() == 400, sumsq5.len() == 400, sum5.len() == 400, left.len() == 4, src.len() >= w + 22, w >= 4, w <= 256])]
fn sgr_box35_row_h_16bpc_neon(
    sumsq3: &mut [i32],
    sum3: &mut [i16],
    sumsq5: &mut [i32],
    sum5: &mut [i16],
    left: &[u16],
    src: &[u16],
    w: usize,
    edges: u32,
    bitdepth_max: i32,
);

#[bums::check_mem_safe("looprestoration16.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, h, bitdepth_max,
    [tmp.len() == 2 * 384, src.len() * 2 == src_stride * h, a_ptrs.len() == 4, b_ptrs.len() == 4, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), a_ptrs[2] == a_buf.as_mut_ptr().add(o_a_buf2), a_ptrs[3] == a_buf.as_mut_ptr().add(o_a_buf3), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), o_a_buf2 + 400 <= a_buf.len(), o_a_buf3 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), b_ptrs[2] == b_buf.as_mut_ptr().add(o_b_buf2), b_ptrs[3] == b_buf.as_mut_ptr().add(o_b_buf3), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), o_b_buf2 + 400 <= b_buf.len(), o_b_buf3 + 400 <= b_buf.len(), w >= 4, w <= 256, h >= 1, h <= 2, src_stride >= w * 2, src_stride % 16 == 0])]
fn sgr_finish_filter1_2rows_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    h: usize,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    o_a_buf2: usize,
    o_a_buf3: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
    o_b_buf2: usize,
    o_b_buf3: usize,
);

#[bums::check_mem_safe("looprestoration16.S", tmp.as_mut_ptr(), src.as_ptr(), src_stride, a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, h, bitdepth_max,
    [tmp.len() == 2 * 384, src.len() * 2 == src_stride * h, a_ptrs.len() == 2, b_ptrs.len() == 2, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), w >= 4, w <= 256, h >= 1, h <= 2, src_stride >= w * 2, src_stride % 16 == 0])]
fn sgr_finish_filter2_2rows_16bpc_neon(
    tmp: &mut [i16],
    src: &[u16],
    src_stride: usize,
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    h: usize,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
);

#[bums::check_mem_safe("looprestoration16.S", dst.as_mut_ptr(), a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, w1, bitdepth_max,
    [dst.len() >= w, dst.len() * 2 % 16 == 0, a_ptrs.len() == 3, b_ptrs.len() == 3, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), a_ptrs[2] == a_buf.as_mut_ptr().add(o_a_buf2), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), o_a_buf2 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), b_ptrs[2] == b_buf.as_mut_ptr().add(o_b_buf2), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), o_b_buf2 + 400 <= b_buf.len(), w >= 4, w <= 256])]
fn sgr_finish_weighted1_16bpc_neon(
    dst: &mut [u16],
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    w1: i32,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    o_a_buf2: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
    o_b_buf2: usize,
);

#[bums::check_mem_safe("looprestoration16.S", dst.as_mut_ptr(), stride, a_ptrs.as_mut_ptr(), b_ptrs.as_mut_ptr(), w, h, w1, bitdepth_max,
    [dst.len() * 2 == stride * h, a_ptrs.len() == 2, b_ptrs.len() == 2, a_ptrs[0] == a_buf.as_mut_ptr().add(o_a_buf0), a_ptrs[1] == a_buf.as_mut_ptr().add(o_a_buf1), o_a_buf0 + 400 <= a_buf.len(), o_a_buf1 + 400 <= a_buf.len(), b_ptrs[0] == b_buf.as_mut_ptr().add(o_b_buf0), b_ptrs[1] == b_buf.as_mut_ptr().add(o_b_buf1), o_b_buf0 + 400 <= b_buf.len(), o_b_buf1 + 400 <= b_buf.len(), w >= 4, w <= 256, h >= 1, h <= 2, stride >= w * 2, stride % 16 == 0])]
fn sgr_finish_weighted2_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    a_ptrs: &mut [usize],
    b_ptrs: &mut [usize],
    w: usize,
    h: usize,
    w1: i32,
    bitdepth_max: i32,
    a_buf: &mut [i32],
    o_a_buf0: usize,
    o_a_buf1: usize,
    b_buf: &mut [i16],
    o_b_buf0: usize,
    o_b_buf1: usize,
);

#[bums::check_mem_safe("looprestoration16.S", dst.as_mut_ptr(), stride, t1.as_ptr(), t2.as_ptr(), w, h, wt.as_ptr(), bitdepth_max,
    [dst.len() * 2 == stride * h, t1.len() == 2 * 384, t2.len() == 2 * 384, wt.len() == 2, w >= 8, w <= 256, w % 8 == 0, h >= 1, h <= 2, stride >= 128 * 2, stride % 16 == 0])]
fn sgr_weighted2_16bpc_neon(
    dst: &mut [u16],
    stride: usize,
    t1: &[i16],
    t2: &[i16],
    w: usize,
    h: usize,
    wt: &[i16],
    bitdepth_max: i32,
);
#[bums::check_mem_safe("looprestoration_common.S", sumsq.as_mut_ptr(), sum.as_mut_ptr(), aa.as_mut_ptr(), bb.as_mut_ptr(), w, s, bitdepth_max,
    [sumsq.len() == 3, sum.len() == 3, sumsq[0] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf0), sumsq[1] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf1), sumsq[2] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf2), o_sumsq_buf0 + 400 <= sumsq_buf.len(), o_sumsq_buf1 + 400 <= sumsq_buf.len(), o_sumsq_buf2 + 400 <= sumsq_buf.len(), sum[0] == sum_buf.as_mut_ptr().add(o_sum_buf0), sum[1] == sum_buf.as_mut_ptr().add(o_sum_buf1), sum[2] == sum_buf.as_mut_ptr().add(o_sum_buf2), o_sum_buf0 + 400 <= sum_buf.len(), o_sum_buf1 + 400 <= sum_buf.len(), o_sum_buf2 + 400 <= sum_buf.len(), aa.len() == 400, bb.len() == 400, w >= 4, w <= 256])]
fn sgr_box3_vert_neon(
    sumsq: &mut [usize],
    sum: &mut [usize],
    aa: &mut [i32],
    bb: &mut [i16],
    w: usize,
    s: i32,
    bitdepth_max: i32,
    sumsq_buf: &mut [i32],
    o_sumsq_buf0: usize,
    o_sumsq_buf1: usize,
    o_sumsq_buf2: usize,
    sum_buf: &mut [i16],
    o_sum_buf0: usize,
    o_sum_buf1: usize,
    o_sum_buf2: usize,
);

#[bums::check_mem_safe("looprestoration_common.S", sumsq.as_mut_ptr(), sum.as_mut_ptr(), aa.as_mut_ptr(), bb.as_mut_ptr(), w, s, bitdepth_max,
    [sumsq.len() == 5, sum.len() == 5, sumsq[0] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf0), sumsq[1] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf1), sumsq[2] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf2), sumsq[3] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf3), sumsq[4] == sumsq_buf.as_mut_ptr().add(o_sumsq_buf4), o_sumsq_buf0 + 400 <= sumsq_buf.len(), o_sumsq_buf1 + 400 <= sumsq_buf.len(), o_sumsq_buf2 + 400 <= sumsq_buf.len(), o_sumsq_buf3 + 400 <= sumsq_buf.len(), o_sumsq_buf4 + 400 <= sumsq_buf.len(), sum[0] == sum_buf.as_mut_ptr().add(o_sum_buf0), sum[1] == sum_buf.as_mut_ptr().add(o_sum_buf1), sum[2] == sum_buf.as_mut_ptr().add(o_sum_buf2), sum[3] == sum_buf.as_mut_ptr().add(o_sum_buf3), sum[4] == sum_buf.as_mut_ptr().add(o_sum_buf4), o_sum_buf0 + 400 <= sum_buf.len(), o_sum_buf1 + 400 <= sum_buf.len(), o_sum_buf2 + 400 <= sum_buf.len(), o_sum_buf3 + 400 <= sum_buf.len(), o_sum_buf4 + 400 <= sum_buf.len(), aa.len() == 400, bb.len() == 400, w >= 4, w <= 256])]
fn sgr_box5_vert_neon(
    sumsq: &mut [usize],
    sum: &mut [usize],
    aa: &mut [i32],
    bb: &mut [i16],
    w: usize,
    s: i32,
    bitdepth_max: i32,
    sumsq_buf: &mut [i32],
    o_sumsq_buf0: usize,
    o_sumsq_buf1: usize,
    o_sumsq_buf2: usize,
    o_sumsq_buf3: usize,
    o_sumsq_buf4: usize,
    sum_buf: &mut [i16],
    o_sum_buf0: usize,
    o_sum_buf1: usize,
    o_sum_buf2: usize,
    o_sum_buf3: usize,
    o_sum_buf4: usize,
);
