#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_adst_adst_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_adst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_adst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_adst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_adst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_adst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_adst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_adst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_adst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_adst_dct_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_dct_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_dct_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_dct_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_dct_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_dct_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_dct_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_dct_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_dct_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_adst_flipadst_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_flipadst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_flipadst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_flipadst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_flipadst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_flipadst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_flipadst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_flipadst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_flipadst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_identity_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_identity_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_identity_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_identity_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_identity_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_identity_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_identity_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_identity_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_adst_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_adst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_adst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_adst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_adst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_adst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_adst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_adst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_adst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_dct_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 16, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_16x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_dct_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 64, stride >= 16, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_16x64_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_dct_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 32, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_32x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 32, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_32x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 64, stride >= 32, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_32x64_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 32, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_dct_32x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_dct_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_dct_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_dct_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 64, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_64x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 64, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_64x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 64, stride >= 64, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_64x64_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_dct_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 8, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_dct_8x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_dct_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_dct_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_flipadst_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_flipadst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_flipadst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_flipadst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_flipadst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_flipadst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_flipadst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_flipadst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_flipadst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_identity_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_identity_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_identity_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_identity_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_identity_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_identity_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_identity_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_identity_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_identity_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_flipadst_adst_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_adst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_adst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_adst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_adst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_adst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_adst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_adst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_adst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_flipadst_dct_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_dct_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_dct_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_dct_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_dct_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_dct_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_dct_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_dct_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_dct_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_flipadst_flipadst_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_flipadst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_flipadst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_flipadst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_flipadst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_flipadst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_flipadst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_flipadst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_flipadst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_identity_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_identity_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_identity_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_identity_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_identity_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_identity_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_identity_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_identity_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_adst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_adst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_adst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_adst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_adst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_adst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_adst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_adst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_dct_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_dct_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_dct_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_dct_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_dct_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_dct_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_dct_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_dct_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_dct_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_flipadst_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_flipadst_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_flipadst_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_flipadst_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_flipadst_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_flipadst_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_flipadst_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_flipadst_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_identity_16x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 16, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_identity_identity_16x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_identity_16x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_identity_16x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 32, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_identity_identity_32x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 32, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_identity_identity_32x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 32, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_identity_32x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_identity_4x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_identity_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_identity_4x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_identity_8x16_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 8, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_identity_8x32_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_identity_8x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_identity_8x8_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_wht_wht_4x4_8bpc_neon(dst: &mut [u8], stride: usize, coeff: &mut [i16], eob: usize, bitdepth_max: i32);
#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_adst_adst_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_adst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_adst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_adst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_adst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_adst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_adst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_adst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_adst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_adst_dct_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_dct_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_dct_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_dct_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_dct_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_dct_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_dct_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_dct_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_dct_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_adst_flipadst_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_flipadst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_flipadst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_flipadst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_flipadst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_flipadst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_flipadst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_flipadst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_flipadst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_identity_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_identity_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_identity_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_adst_identity_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_identity_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_adst_identity_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_adst_identity_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_adst_identity_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_adst_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_adst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_adst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_adst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_adst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_adst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_adst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_adst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_adst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_dct_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 16, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_16x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_dct_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 64, stride >= 16, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_16x64_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_dct_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 32, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_32x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 32, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_32x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 64, stride >= 32, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_32x64_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 32, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_dct_32x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_dct_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_dct_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_dct_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 64, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_dct_dct_64x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 64, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_64x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 64, stride >= 64, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_dct_dct_64x64_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_dct_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 8, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_dct_8x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_dct_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_dct_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_flipadst_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_flipadst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_flipadst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_flipadst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_flipadst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_flipadst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_flipadst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_flipadst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_flipadst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_dct_identity_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_identity_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_identity_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_identity_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_dct_identity_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_identity_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_dct_identity_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_dct_identity_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_dct_identity_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_flipadst_adst_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_adst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_adst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_adst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_adst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_adst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_adst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_adst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_adst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_flipadst_dct_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_dct_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_dct_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_dct_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_dct_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_dct_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_dct_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_dct_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_dct_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_flipadst_flipadst_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_flipadst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_flipadst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_flipadst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_flipadst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_flipadst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_flipadst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_flipadst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_flipadst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_identity_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_identity_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_identity_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_flipadst_identity_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_identity_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_flipadst_identity_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_flipadst_identity_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_flipadst_identity_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_adst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_adst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_adst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_adst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_adst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_adst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_adst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_adst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_dct_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_dct_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_dct_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_dct_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_dct_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_dct_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_dct_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_dct_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_dct_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_flipadst_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_flipadst_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_flipadst_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_flipadst_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_flipadst_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_flipadst_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_flipadst_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_flipadst_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 16, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_identity_16x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 16, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_identity_identity_16x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 16, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_identity_16x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 16, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_identity_16x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 32, coeff.len() == 512, eob < 512])]
fn inv_txfm_add_identity_identity_32x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 32, coeff.len() == 1024, eob < 1024])]
fn inv_txfm_add_identity_identity_32x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 32, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_identity_32x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 4, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_identity_4x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_identity_identity_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 4, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_identity_4x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 16, stride >= 8, coeff.len() == 128, eob < 128])]
fn inv_txfm_add_identity_identity_8x16_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 32, stride >= 8, coeff.len() == 256, eob < 256])]
fn inv_txfm_add_identity_identity_8x32_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 8, coeff.len() == 32, eob < 32])]
fn inv_txfm_add_identity_identity_8x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 8, stride >= 8, coeff.len() == 64, eob < 64])]
fn inv_txfm_add_identity_identity_8x8_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);

#[bums::check_mem_safe("itx16.S", dst.as_mut_ptr(), stride, coeff.as_mut_ptr(), eob, bitdepth_max,
    [dst.len() == stride * 4, stride >= 4, coeff.len() == 16, eob < 16])]
fn inv_txfm_add_wht_wht_4x4_16bpc_neon(dst: &mut [u16], stride: usize, coeff: &mut [i32], eob: usize, bitdepth_max: i32);
