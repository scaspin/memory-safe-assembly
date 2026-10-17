#![allow(clippy::all)]
use bums_macros as bums;

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4 * stride), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824, alpha <= 255, beta <= 255, tc0.len() == 4])]
fn ff_h264_v_loop_filter_luma_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824, alpha <= 255, beta <= 255, tc0.len() == 4])]
fn ff_h264_h_loop_filter_luma_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4 * stride), stride, alpha, beta,
    [pix.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824, alpha <= 255, beta <= 255])]
fn ff_h264_v_loop_filter_luma_intra_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824, alpha <= 255, beta <= 255])]
fn ff_h264_h_loop_filter_luma_intra_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4 * stride), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, alpha <= 255, beta <= 255, tc0.len() == 4])]
fn ff_h264_v_loop_filter_chroma_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, alpha <= 255, beta <= 255, tc0.len() == 4])]
fn ff_h264_h_loop_filter_chroma_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824, alpha <= 255, beta <= 255, tc0.len() == 4])]
fn ff_h264_h_loop_filter_chroma422_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4 * stride), stride, alpha, beta,
    [pix.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, alpha <= 255, beta <= 255])]
fn ff_h264_v_loop_filter_chroma_intra_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 7 * stride + 12, stride >= 12, stride <= 1073741824, alpha <= 255, beta <= 255])]
fn ff_h264_h_loop_filter_chroma_intra_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 15 * stride + 12, stride >= 12, stride <= 1073741824, alpha <= 255, beta <= 255])]
fn ff_h264_h_loop_filter_chroma422_intra_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 3 * stride + 12, stride >= 12, stride <= 1073741824, alpha <= 255, beta <= 255])]
fn ff_h264_h_loop_filter_chroma_mbaff_intra_neon(pix: &mut [u8], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(2 * stride), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0, tc0.len() == 4])]
fn ff_h264_v_loop_filter_chroma_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0, tc0.len() == 4])]
fn ff_h264_h_loop_filter_chroma_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta, tc0.as_ptr(),
    [pix.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0, tc0.len() == 4])]
fn ff_h264_h_loop_filter_chroma422_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize, tc0: &[i8]);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(2 * stride), stride, alpha, beta,
    [pix.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0])]
fn ff_h264_v_loop_filter_chroma_intra_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 7 * stride / 2 + 12, stride >= 24, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0])]
fn ff_h264_h_loop_filter_chroma_intra_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 15 * stride / 2 + 12, stride >= 24, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0])]
fn ff_h264_h_loop_filter_chroma422_intra_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", pix.as_mut_ptr().add(4), stride, alpha, beta,
    [pix.len() == 3 * stride / 2 + 12, stride >= 24, stride <= 1073741824, alpha <= 255, beta <= 255, stride % 2 == 0])]
fn ff_h264_h_loop_filter_chroma_mbaff_intra_neon_10(pix: &mut [u16], stride: usize, alpha: usize, beta: usize);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), stride, height, log2_den, weight, offset,
    [dst.len() == (height - 1) * stride + 16, stride >= 16, stride <= 1073741824, height >= 8, height <= 16, height % 2 == 0, log2_den <= 7])]
fn ff_weight_h264_pixels_16_neon(dst: &mut [u8], stride: usize, height: usize, log2_den: usize, weight: i32, offset: i32);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), src.as_mut_ptr(), stride, height, log2_den, weightd, weights, offset,
    [dst.len() == (height - 1) * stride + 16, src.len() == (height - 1) * stride + 16, stride >= 16, stride <= 1073741824, height >= 8, height <= 16, height % 2 == 0, log2_den <= 7])]
fn ff_biweight_h264_pixels_16_neon(dst: &mut [u8], src: &mut [u8], stride: usize, height: usize, log2_den: usize, weightd: i32, weights: i32, offset: i32);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), stride, height, log2_den, weight, offset,
    [dst.len() == (height - 1) * stride + 8, stride >= 8, stride <= 1073741824, height >= 4, height <= 16, height % 2 == 0, log2_den <= 7])]
fn ff_weight_h264_pixels_8_neon(dst: &mut [u8], stride: usize, height: usize, log2_den: usize, weight: i32, offset: i32);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), src.as_mut_ptr(), stride, height, log2_den, weightd, weights, offset,
    [dst.len() == (height - 1) * stride + 8, src.len() == (height - 1) * stride + 8, stride >= 8, stride <= 1073741824, height >= 4, height <= 16, height % 2 == 0, log2_den <= 7])]
fn ff_biweight_h264_pixels_8_neon(dst: &mut [u8], src: &mut [u8], stride: usize, height: usize, log2_den: usize, weightd: i32, weights: i32, offset: i32);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), stride, height, log2_den, weight, offset,
    [dst.len() == (height - 1) * stride + 4, stride >= 4, stride <= 1073741824, height >= 2, height <= 8, height % 2 == 0, log2_den <= 7])]
fn ff_weight_h264_pixels_4_neon(dst: &mut [u8], stride: usize, height: usize, log2_den: usize, weight: i32, offset: i32);

#[bums::check_mem_safe("h264dsp_neon.S", dst.as_mut_ptr(), src.as_mut_ptr(), stride, height, log2_den, weightd, weights, offset,
    [dst.len() == (height - 1) * stride + 4, src.len() == (height - 1) * stride + 4, stride >= 4, stride <= 1073741824, height >= 2, height <= 8, height % 2 == 0, log2_den <= 7])]
fn ff_biweight_h264_pixels_4_neon(dst: &mut [u8], src: &mut [u8], stride: usize, height: usize, log2_den: usize, weightd: i32, weights: i32, offset: i32);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 3 * stride + 4, block.len() == 16, stride >= 4, stride <= 1073741824])]
fn ff_h264_idct_add_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 3 * stride + 4, block.len() == 16, stride >= 4, stride <= 1073741824])]
fn ff_h264_idct_dc_add_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 7 * stride + 8, block.len() == 64, stride >= 8, stride <= 1073741824])]
fn ff_h264_idct8_add_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block.as_mut_ptr(), stride,
    [dst.len() == 7 * stride + 8, block.len() == 64, stride >= 8, stride <= 1073741824])]
fn ff_h264_idct8_dc_add_neon(dst: &mut [u8], block: &mut [i16], stride: usize);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dst.len() == 15 * stride + 16, block_offset.len() == 48, block.len() == 256, nnzc.len() == 40, stride >= 16, stride <= 1073741824,
     block_offset[0] == 0, block_offset[1] == (4) as i32, block_offset[2] == (4 * stride) as i32, block_offset[3] == (4 * stride + 4) as i32, block_offset[4] == (8) as i32, block_offset[5] == (12) as i32, block_offset[6] == (4 * stride + 8) as i32, block_offset[7] == (4 * stride + 12) as i32, block_offset[8] == (8 * stride) as i32, block_offset[9] == (8 * stride + 4) as i32, block_offset[10] == (12 * stride) as i32, block_offset[11] == (12 * stride + 4) as i32, block_offset[12] == (8 * stride + 8) as i32, block_offset[13] == (8 * stride + 12) as i32, block_offset[14] == (12 * stride + 8) as i32, block_offset[15] == (12 * stride + 12) as i32])]
fn ff_h264_idct_add16_neon(dst: &mut [u8], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8]);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dst.len() == 15 * stride + 16, block_offset.len() == 48, block.len() == 256, nnzc.len() == 40, stride >= 16, stride <= 1073741824,
     block_offset[0] == 0, block_offset[1] == (4) as i32, block_offset[2] == (4 * stride) as i32, block_offset[3] == (4 * stride + 4) as i32, block_offset[4] == (8) as i32, block_offset[5] == (12) as i32, block_offset[6] == (4 * stride + 8) as i32, block_offset[7] == (4 * stride + 12) as i32, block_offset[8] == (8 * stride) as i32, block_offset[9] == (8 * stride + 4) as i32, block_offset[10] == (12 * stride) as i32, block_offset[11] == (12 * stride + 4) as i32, block_offset[12] == (8 * stride + 8) as i32, block_offset[13] == (8 * stride + 12) as i32, block_offset[14] == (12 * stride + 8) as i32, block_offset[15] == (12 * stride + 12) as i32])]
fn ff_h264_idct_add16intra_neon(dst: &mut [u8], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8]);

#[bums::check_mem_safe("h264idct_neon.S", dst.as_mut_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dst.len() == 15 * stride + 16, block_offset.len() == 48, block.len() == 256, nnzc.len() == 40, stride >= 16, stride <= 1073741824,
     block_offset[0] == 0, block_offset[4] == (8) as i32, block_offset[8] == (8 * stride) as i32, block_offset[12] == (8 * stride + 8) as i32])]
fn ff_h264_idct8_add4_neon(dst: &mut [u8], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8]);

#[bums::check_mem_safe("h264idct_neon.S", dest.as_ptr(), block_offset.as_ptr(), block.as_mut_ptr(), stride, nnzc.as_ptr(),
    [dest.len() == 2, dest[0] == u.as_mut_ptr(), dest[1] == v.as_mut_ptr(), u.len() == 7 * stride + 8, v.len() == 7 * stride + 8,
     block_offset.len() == 48, block.len() == 768, nnzc.len() == 120, stride >= 8, stride <= 1073741824,
     block_offset[16] == 0, block_offset[17] == (4) as i32, block_offset[18] == (4 * stride) as i32, block_offset[19] == (4 * stride + 4) as i32, block_offset[32] == 0, block_offset[33] == (4) as i32, block_offset[34] == (4 * stride) as i32, block_offset[35] == (4 * stride + 4) as i32])]
fn ff_h264_idct_add8_neon(dest: &[usize], block_offset: &[i32], block: &mut [i16], stride: usize, nnzc: &[u8], u: &mut [u8], v: &mut [u8]);

