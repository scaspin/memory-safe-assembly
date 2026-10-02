#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("refmvs.S", rr.as_mut_ptr(), rmv.as_ptr(), bx4, bw4, bh4,
    [rr.len() == bh4, rmv.len() == 2, bw4 >= 1, bw4 <= 32, bh4 >= 1, bh4 <= 32])]
fn splat_mv_neon(rr: &mut [usize], rmv: &[u64], bx4: usize, bw4: usize, bh4: usize);

#[bums::check_mem_safe("refmvs.S", rp.as_mut_ptr(), stride, rr.as_ptr(), ref_sign.as_ptr(), col_end8, row_end8, col_start8, row_start8,
    [rp.len() == stride * 16, rr.len() == 31, ref_sign.len() == 7, col_end8 >= col_start8, row_end8 >= row_start8, stride >= 1])]
fn save_tmvs_neon(
    rp: &mut [u64],
    stride: usize,
    rr: &[usize],
    ref_sign: &[u8],
    col_end8: usize,
    row_end8: usize,
    col_start8: usize,
    row_start8: usize,
);

#[bums::check_mem_safe("refmvs.S", rf.as_ptr(), tile_row_idx, col_start8, col_end8, row_start8, row_end8,
    [rf.len() == 26, col_end8 >= col_start8, row_end8 >= row_start8])]
fn load_tmvs_neon(
    rf: &[usize],
    tile_row_idx: i32,
    col_start8: usize,
    col_end8: usize,
    row_start8: usize,
    row_end8: usize,
);
