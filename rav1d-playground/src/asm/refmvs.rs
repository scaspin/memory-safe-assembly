#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("refmvs.S", rr.as_ptr(), rmv.as_ptr(), bx4, bw4, bh4,
    [rr == [&mut [u8; 12 * (bx4 + bw4)]; bh4], rmv.len() == 2, bw4 >= 1, bw4 <= 32, 32 % bw4 == 0, bh4 >= 1, bh4 <= 32, bx4 <= 1024])]
fn splat_mv_neon(rr: &mut [&mut [u8]], rmv: &[u64], bx4: usize, bw4: usize, bh4: usize);

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
    [rf.len() == 26,
     field::<i32>(rf, 16) == iw8, field::<i32>(rf, 20) == ih8, field::<isize>(rf, 184) == stride,
     field::<i32>(rf, 152) == n_mfmvs, field::<i32>(rf, 200) == n_tile_threads,
     field::<usize>(rf, 176) == rp_proj.as_mut_ptr(), field::<usize>(rf, 168) == rp_ref.as_ptr(),
     field::<[u8; 3]>(rf, 53)[..] <= 6,
     field::<[i32; 21]>(rf, 68)[..] >= 0, field::<[i32; 21]>(rf, 68)[..] <= 31,
     rp_ref == [&[u8; 5 * stride * ih8]; 7],
     rp_ref.iter().all(|row| row.iter().skip(4).step_by(5).all(|e| *e <= 7)),
     rp_proj.len() == 80 * stride * n_tile_rows,
     n_mfmvs >= 0, n_mfmvs <= 3, n_tile_threads >= 1, n_tile_rows >= 1,
     tile_row_idx >= 0, n_tile_threads == 1 || tile_row_idx < n_tile_rows,
     iw8 >= 1, ih8 >= 1, iw8 <= stride, stride <= 16384,
     col_start8 >= 0, col_start8 < col_end8, col_end8 <= iw8,
     row_start8 >= 0, row_start8 < row_end8, row_start8 < ih8, row_end8 - row_start8 <= 16, row_start8 % 16 + (row_end8 - row_start8) <= 16])]
fn load_tmvs_neon(
    rf: &[usize],
    tile_row_idx: i32,
    col_start8: i32,
    col_end8: i32,
    row_start8: i32,
    row_end8: i32,
    iw8: i32,
    ih8: i32,
    stride: usize,
    n_mfmvs: i32,
    n_tile_threads: i32,
    n_tile_rows: usize,
    rp_proj: &mut [u8],
    rp_ref: &[*const u8],
);
