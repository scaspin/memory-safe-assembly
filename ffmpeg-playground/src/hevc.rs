use bums_macros as bums;

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 3 * stride + 4, coeffs.len() == 16, stride >= 4, stride <= 1073741824])]
fn ff_hevc_add_residual_4x4_8_neon(dst: &mut [u8], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 16, col_limit >= 1, col_limit <= 4])]
fn ff_hevc_idct_4x4_8_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_idct_4x4_dc_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_dequant_4x4_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 7 * stride + 8, coeffs.len() == 64, stride >= 8, stride <= 1073741824])]
fn ff_hevc_add_residual_8x8_8_neon(dst: &mut [u8], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 64, col_limit >= 1, col_limit <= 8])]
fn ff_hevc_idct_8x8_8_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 64])]
fn ff_hevc_idct_8x8_dc_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 64])]
fn ff_hevc_dequant_8x8_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 15 * stride + 16, coeffs.len() == 256, stride >= 16, stride <= 1073741824])]
fn ff_hevc_add_residual_16x16_8_neon(dst: &mut [u8], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 256, col_limit >= 1, col_limit <= 16])]
fn ff_hevc_idct_16x16_8_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 256])]
fn ff_hevc_idct_16x16_dc_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 256])]
fn ff_hevc_dequant_16x16_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 31 * stride + 32, coeffs.len() == 1024, stride >= 32, stride <= 1073741824])]
fn ff_hevc_add_residual_32x32_8_neon(dst: &mut [u8], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 1024, col_limit >= 1, col_limit <= 32])]
fn ff_hevc_idct_32x32_8_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 1024])]
fn ff_hevc_idct_32x32_dc_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 1024])]
fn ff_hevc_dequant_32x32_8_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4 * stride), stride, beta, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, beta <= 255])]
fn ff_hevc_h_loop_filter_luma_8_neon(pix: &mut [u8], stride: usize, beta: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4 * stride), stride, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2])]
fn ff_hevc_h_loop_filter_chroma_8_neon(pix: &mut [u8], stride: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4), stride, beta, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, beta <= 255])]
fn ff_hevc_v_loop_filter_luma_8_neon(pix: &mut [u8], stride: usize, beta: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4), stride, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2])]
fn ff_hevc_v_loop_filter_chroma_8_neon(pix: &mut [u8], stride: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(193), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * stride_dst, src.len() == (height + 2) * 192 + 16, offset_val.len() == 8, eo <= 3, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 64, stride_dst >= 8, stride_dst <= 1073741824])]
fn ff_hevc_sao_edge_filter_8x8_8_neon(dst: &mut [u8], src: &[u8], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(193), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * stride_dst, src.len() == (height + 2) * 192 + 16, offset_val.len() == 8, eo <= 3, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64, height % 4 == 0, height >= 4, height <= 64, stride_dst >= 64, stride_dst <= 1073741824])]
fn ff_hevc_sao_edge_filter_16x16_8_neon(dst: &mut [u8], src: &[u8], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(321), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * stride_dst, src.len() == (height + 2) * 320 + 16, offset_val.len() == 8, eo <= 3, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 8, stride_dst <= 1073741824])]
fn ff_vvc_sao_edge_filter_8x8_8_neon(dst: &mut [u8], src: &[u8], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(321), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * stride_dst, src.len() == (height + 2) * 320 + 16, offset_val.len() == 8, eo <= 3, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64 || width == 68 || width == 72 || width == 76 || width == 80 || width == 84 || width == 88 || width == 92 || width == 96 || width == 100 || width == 104 || width == 108 || width == 112 || width == 116 || width == 120 || width == 124 || width == 128, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 128, stride_dst <= 1073741824])]
fn ff_vvc_sao_edge_filter_16x16_8_neon(dst: &mut [u8], src: &[u8], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 3 * stride / 2 + 4, coeffs.len() == 16, stride >= 8, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_4x4_10_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 16, col_limit >= 1, col_limit <= 4])]
fn ff_hevc_idct_4x4_10_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_idct_4x4_dc_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_dequant_4x4_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 7 * stride / 2 + 8, coeffs.len() == 64, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_8x8_10_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 64, col_limit >= 1, col_limit <= 8])]
fn ff_hevc_idct_8x8_10_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 64])]
fn ff_hevc_idct_8x8_dc_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 64])]
fn ff_hevc_dequant_8x8_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 15 * stride / 2 + 16, coeffs.len() == 256, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_16x16_10_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 256, col_limit >= 1, col_limit <= 16])]
fn ff_hevc_idct_16x16_10_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 256])]
fn ff_hevc_idct_16x16_dc_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 256])]
fn ff_hevc_dequant_16x16_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 31 * stride / 2 + 32, coeffs.len() == 1024, stride >= 64, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_32x32_10_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(), col_limit,
    [coeffs.len() == 1024, col_limit >= 1, col_limit <= 32])]
fn ff_hevc_idct_32x32_10_neon(coeffs: &mut [i16], col_limit: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 1024])]
fn ff_hevc_idct_32x32_dc_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 1024])]
fn ff_hevc_dequant_32x32_10_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4 * stride / 2), stride, beta, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0, beta <= 255])]
fn ff_hevc_h_loop_filter_luma_10_neon(pix: &mut [u16], stride: usize, beta: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4 * stride / 2), stride, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0])]
fn ff_hevc_h_loop_filter_chroma_10_neon(pix: &mut [u16], stride: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4), stride, beta, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0, beta <= 255])]
fn ff_hevc_v_loop_filter_luma_10_neon(pix: &mut [u16], stride: usize, beta: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4), stride, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0])]
fn ff_hevc_v_loop_filter_chroma_10_neon(pix: &mut [u16], stride: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(97), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 96 + 8, offset_val.len() == 8, eo <= 3, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 64, stride_dst >= 16, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_hevc_sao_edge_filter_8x8_10_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(97), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 96 + 8, offset_val.len() == 8, eo <= 3, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64, height % 4 == 0, height >= 4, height <= 64, stride_dst >= 128, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_hevc_sao_edge_filter_16x16_10_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(161), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 160 + 8, offset_val.len() == 8, eo <= 3, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 16, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_vvc_sao_edge_filter_8x8_10_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(161), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 160 + 8, offset_val.len() == 8, eo <= 3, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64 || width == 68 || width == 72 || width == 76 || width == 80 || width == 84 || width == 88 || width == 92 || width == 96 || width == 100 || width == 104 || width == 108 || width == 112 || width == 116 || width == 120 || width == 124 || width == 128, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 256, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_vvc_sao_edge_filter_16x16_10_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 3 * stride / 2 + 4, coeffs.len() == 16, stride >= 8, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_4x4_12_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_idct_4x4_dc_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_dequant_4x4_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 7 * stride / 2 + 8, coeffs.len() == 64, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_8x8_12_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 64])]
fn ff_hevc_idct_8x8_dc_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 64])]
fn ff_hevc_dequant_8x8_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 15 * stride / 2 + 16, coeffs.len() == 256, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_16x16_12_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 256])]
fn ff_hevc_idct_16x16_dc_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 256])]
fn ff_hevc_dequant_16x16_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", dst.as_mut_ptr(), coeffs.as_ptr(), stride,
    [dst.len() == 31 * stride / 2 + 32, coeffs.len() == 1024, stride >= 64, stride <= 1073741824, stride % 2 == 0])]
fn ff_hevc_add_residual_32x32_12_neon(dst: &mut [u16], coeffs: &[i16], stride: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 1024])]
fn ff_hevc_idct_32x32_dc_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_dequant_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 1024])]
fn ff_hevc_dequant_32x32_12_neon(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4 * stride / 2), stride, beta, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0, beta <= 255])]
fn ff_hevc_h_loop_filter_luma_12_neon(pix: &mut [u16], stride: usize, beta: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4 * stride / 2), stride, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0])]
fn ff_hevc_h_loop_filter_chroma_12_neon(pix: &mut [u16], stride: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4), stride, beta, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0, beta <= 255])]
fn ff_hevc_v_loop_filter_luma_12_neon(pix: &mut [u16], stride: usize, beta: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("hevcdsp_deblock_neon.S", pix.as_mut_ptr().add(4), stride, tc.as_ptr(), no_p.as_ptr(), no_q.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, tc.len() == 2, no_p.len() == 2, no_q.len() == 2, stride % 2 == 0])]
fn ff_hevc_v_loop_filter_chroma_12_neon(pix: &mut [u16], stride: usize, tc: &[i32], no_p: &[u8], no_q: &[u8]);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(97), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 96 + 8, offset_val.len() == 8, eo <= 3, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 64, stride_dst >= 16, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_hevc_sao_edge_filter_8x8_12_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(97), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 96 + 8, offset_val.len() == 8, eo <= 3, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64, height % 4 == 0, height >= 4, height <= 64, stride_dst >= 128, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_hevc_sao_edge_filter_16x16_12_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(161), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 160 + 8, offset_val.len() == 8, eo <= 3, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 16, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_vvc_sao_edge_filter_8x8_12_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr().add(161), stride_dst, offset_val.as_ptr(), eo, width, height,
    [dst.len() == height * (stride_dst / 2), src.len() == (height + 2) * 160 + 8, offset_val.len() == 8, eo <= 3, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64 || width == 68 || width == 72 || width == 76 || width == 80 || width == 84 || width == 88 || width == 92 || width == 96 || width == 100 || width == 104 || width == 108 || width == 112 || width == 116 || width == 120 || width == 124 || width == 128, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 256, stride_dst <= 1073741824, stride_dst % 2 == 0])]
fn ff_vvc_sao_edge_filter_16x16_12_neon(dst: &mut [u16], src: &[u16], stride_dst: usize, offset_val: &[i16], eo: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride_dst, stride_src, offset_val.as_ptr(), left_class, width, height,
    [dst.len() == height * stride_dst, src.len() == height * stride_src + 16, offset_val.len() == 8, left_class <= 31, width % 4 == 0, width >= 4, width <= 8, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 8, stride_src >= 8, stride_dst <= 1073741824, stride_src <= 1073741824])]
fn ff_h26x_sao_band_filter_8x8_8_neon(dst: &mut [u8], src: &[u8], stride_dst: usize, stride_src: usize, offset_val: &[i16], left_class: usize, width: usize, height: usize);

#[bums::check_mem_safe("sao_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride_dst, stride_src, offset_val.as_ptr(), left_class, width, height,
    [dst.len() == height * stride_dst, src.len() == height * stride_src + 16, offset_val.len() == 8, left_class <= 31, width == 12 || width == 16 || width == 20 || width == 24 || width == 28 || width == 32 || width == 36 || width == 40 || width == 44 || width == 48 || width == 52 || width == 56 || width == 60 || width == 64 || width == 68 || width == 72 || width == 76 || width == 80 || width == 84 || width == 88 || width == 92 || width == 96 || width == 100 || width == 104 || width == 108 || width == 112 || width == 116 || width == 120 || width == 124 || width == 128, height % 4 == 0, height >= 4, height <= 128, stride_dst >= 128, stride_src >= 128, stride_dst <= 1073741824, stride_src <= 1073741824])]
fn ff_h26x_sao_band_filter_16x16_8_neon(dst: &mut [u8], src: &[u8], stride_dst: usize, stride_src: usize, offset_val: &[i16], left_class: usize, width: usize, height: usize);

#[bums::check_mem_safe("hevcdsp_idct_neon.S", coeffs.as_mut_ptr(),
    [coeffs.len() == 16])]
fn ff_hevc_transform_luma_4x4_neon_8(coeffs: &mut [i16]);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride, c_idx,
    [src.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, top.len() == 81, left.len() == 81, c_idx <= 2])]
fn ff_hevc_pred_dc_4x4_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize, c_idx: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride,
    [src.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, top.len() == 81, left.len() == 81])]
fn ff_hevc_pred_planar_4x4_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride, c_idx,
    [src.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, top.len() == 81, left.len() == 81, c_idx <= 2])]
fn ff_hevc_pred_dc_8x8_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize, c_idx: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride,
    [src.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, top.len() == 81, left.len() == 81])]
fn ff_hevc_pred_planar_8x8_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride, c_idx,
    [src.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824, top.len() == 81, left.len() == 81, c_idx <= 2])]
fn ff_hevc_pred_dc_16x16_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize, c_idx: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride,
    [src.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824, top.len() == 81, left.len() == 81])]
fn ff_hevc_pred_planar_16x16_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride, c_idx,
    [src.len() == 31 * stride + 32, stride >= 32, stride <= 1073741824, top.len() == 81, left.len() == 81, c_idx <= 2])]
fn ff_hevc_pred_dc_32x32_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize, c_idx: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride,
    [src.len() == 31 * stride + 32, stride >= 32, stride <= 1073741824, top.len() == 81, left.len() == 81])]
fn ff_hevc_pred_planar_32x32_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize);

#[bums::check_mem_safe("hevcpred_neon.S", filtered_left.as_mut_ptr().add(1), filtered_top.as_mut_ptr().add(1), left.as_ptr().add(1), top.as_ptr().add(1), size,
    [filtered_left.len() == 65, filtered_top.len() == 65, left.len() == 81, top.len() == 81, size == 8])]
fn ff_hevc_ref_filter_3tap_8x8_8_neon(filtered_left: &mut [u8], filtered_top: &mut [u8], left: &[u8], top: &[u8], size: usize);

#[bums::check_mem_safe("hevcpred_neon.S", filtered_left.as_mut_ptr().add(1), filtered_top.as_mut_ptr().add(1), left.as_ptr().add(1), top.as_ptr().add(1), size,
    [filtered_left.len() == 65, filtered_top.len() == 65, left.len() == 81, top.len() == 81, size == 16])]
fn ff_hevc_ref_filter_3tap_16x16_8_neon(filtered_left: &mut [u8], filtered_top: &mut [u8], left: &[u8], top: &[u8], size: usize);

#[bums::check_mem_safe("hevcpred_neon.S", filtered_left.as_mut_ptr().add(1), filtered_top.as_mut_ptr().add(1), left.as_ptr().add(1), top.as_ptr().add(1), size,
    [filtered_left.len() == 65, filtered_top.len() == 65, left.len() == 81, top.len() == 81, size == 32])]
fn ff_hevc_ref_filter_3tap_32x32_8_neon(filtered_left: &mut [u8], filtered_top: &mut [u8], left: &[u8], top: &[u8], size: usize);

#[bums::check_mem_safe("hevcpred_neon.S", filtered_top.as_mut_ptr().add(1), left.as_mut_ptr().add(1), top.as_ptr().add(1),
    [filtered_top.len() == 65, left.len() == 81, top.len() == 81])]
fn ff_hevc_ref_filter_strong_8_neon(filtered_top: &mut [u8], left: &mut [u8], top: &[u8]);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride, c_idx, log2_size,
    [src.len() == 31 * stride + 32, stride >= 32, stride <= 1073741824, top.len() == 81, left.len() == 81, c_idx <= 2, log2_size >= 2, log2_size <= 5])]
fn ff_hevc_pred_angular_mode_10_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize, c_idx: usize, log2_size: usize);

#[bums::check_mem_safe("hevcpred_neon.S", src.as_mut_ptr(), top.as_ptr().add(1), left.as_ptr().add(1), stride, c_idx, log2_size,
    [src.len() == 31 * stride + 32, stride >= 32, stride <= 1073741824, top.len() == 81, left.len() == 81, c_idx <= 2, log2_size >= 2, log2_size <= 5])]
fn ff_hevc_pred_angular_mode_26_8_neon(src: &mut [u8], top: &[u8], left: &[u8], stride: usize, c_idx: usize, log2_size: usize);

