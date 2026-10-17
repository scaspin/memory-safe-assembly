use bums_macros as bums;

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 8, src.len() == (h + 2) * stride + 16, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, x <= 7, y <= 7])]
fn ff_put_h264_chroma_mc8_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 8, src.len() == (h + 2) * stride + 16, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, x <= 7, y <= 7])]
fn ff_avg_h264_chroma_mc8_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 4, src.len() == (h + 2) * stride + 16, stride >= 5, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_put_h264_chroma_mc4_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 4, src.len() == (h + 2) * stride + 16, stride >= 5, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_avg_h264_chroma_mc4_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 2, src.len() == (h + 2) * stride + 16, stride >= 3, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_put_h264_chroma_mc2_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 2, src.len() == (h + 2) * stride + 16, stride >= 3, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_avg_h264_chroma_mc2_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 8, src.len() == (h + 2) * stride + 16, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, x <= 7, y <= 7])]
fn ff_put_rv40_chroma_mc8_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 8, src.len() == (h + 2) * stride + 16, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, x <= 7, y <= 7])]
fn ff_avg_rv40_chroma_mc8_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 4, src.len() == (h + 2) * stride + 16, stride >= 5, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_put_rv40_chroma_mc4_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 4, src.len() == (h + 2) * stride + 16, stride >= 5, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_avg_rv40_chroma_mc4_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 8, src.len() == (h + 2) * stride + 16, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, x <= 7, y <= 7])]
fn ff_put_vc1_chroma_mc8_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 8, src.len() == (h + 2) * stride + 16, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, x <= 7, y <= 7])]
fn ff_avg_vc1_chroma_mc8_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 4, src.len() == (h + 2) * stride + 16, stride >= 5, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_put_vc1_chroma_mc4_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264cmc_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride, h, x, y,
    [dst.len() == (h - 1) * stride + 4, src.len() == (h + 2) * stride + 16, stride >= 5, stride <= 1073741824, h % 2 == 0, h >= 2, h <= 16, x <= 7, y <= 7])]
fn ff_avg_vc1_chroma_mc4_neon(dst: &mut [u8], src: &[u8], stride: usize, h: usize, x: usize, y: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_128_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_top_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_left_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_hor_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_vert_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 16 * stride + 17, stride >= 17, stride <= 1073741824])]
fn ff_pred16x16_plane_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_hor_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_vert_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_plane_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_128_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_top_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_left_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_l0t_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_l00_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_0lt_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride + 1), stride,
    [src.len() == 8 * stride + 9, stride >= 9, stride <= 1073741824])]
fn ff_pred8x8_0l0_dc_neon(src: &mut [u8], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 16 * stride / 2 + 17, stride >= 34, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred16x16_top_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 16 * stride / 2 + 17, stride >= 34, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred16x16_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 16 * stride / 2 + 17, stride >= 34, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred16x16_hor_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 16 * stride / 2 + 17, stride >= 34, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred16x16_vert_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 16 * stride / 2 + 17, stride >= 34, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred16x16_plane_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_hor_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_vert_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_plane_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_128_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_top_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_left_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_l0t_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_l00_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_0lt_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264pred_neon.S", src.as_mut_ptr().add(stride / 2 + 1), stride,
    [src.len() == 8 * stride / 2 + 9, stride >= 18, stride <= 1073741824, stride % 2 == 0])]
fn ff_pred8x8_0l0_dc_neon_10(src: &mut [u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc10_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc20_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc30_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc01_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc11_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc21_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc31_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc02_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc12_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc22_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc32_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc03_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc13_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc23_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc33_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc10_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc20_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc30_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc01_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc11_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc21_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc31_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc02_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc12_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc22_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc32_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc03_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc13_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc23_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 7 * stride + 8, src.len() == 14 * stride + 16, stride >= 13, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc33_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc10_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc20_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc30_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc01_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc11_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc21_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc31_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc02_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc12_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc22_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc32_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc03_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc13_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc23_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc33_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc10_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc20_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc30_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc01_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc11_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc21_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc31_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc02_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc12_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc22_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc32_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc03_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc13_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc23_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride + 2), stride,
    [dst.len() == 15 * stride + 16, src.len() == 22 * stride + 16, stride >= 21, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc33_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc10_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc20_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc30_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc01_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc11_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc31_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc02_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc03_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc13_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel8_mc33_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc10_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc20_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc30_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc01_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc11_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc31_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc02_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc03_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc13_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 7 * stride / 2 + 8, src.len() == 14 * stride / 2 + 8, stride >= 26, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel8_mc33_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc10_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc20_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc30_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc01_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc11_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc31_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc02_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc03_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc13_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_put_h264_qpel16_mc33_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc10_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc20_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc30_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc01_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc11_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc31_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc02_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc03_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc13_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

#[bums::check_mem_safe("h264qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(2 * stride / 2 + 2), stride,
    [dst.len() == 15 * stride / 2 + 16, src.len() == 22 * stride / 2 + 8, stride >= 42, stride <= 1073741824, stride % 2 == 0])]
fn ff_avg_h264_qpel16_mc33_neon_10(dst: &mut [u16], src: &[u16], stride: usize);

