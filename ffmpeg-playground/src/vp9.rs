use bums_macros as bums;

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg16_16_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_avg16_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg32_16_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_avg32_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg4_16_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_avg4_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg64_16_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_avg64_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg8_16_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_avg8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular16_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular16_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 0) * src_stride + 24, dst_stride >= 16, src_stride >= 23, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular16_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular16_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular16_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 7) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular16_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular32_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular32_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 0) * src_stride + 40, dst_stride >= 32, src_stride >= 39, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular32_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular32_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular32_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 7) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular32_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular4_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular4_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 0) * src_stride + 12, dst_stride >= 4, src_stride >= 11, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular4_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular4_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular4_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 7) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular4_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular64_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular64_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 0) * src_stride + 72, dst_stride >= 64, src_stride >= 71, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular64_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular64_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular64_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 7) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular64_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular8_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular8_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 0) * src_stride + 16, dst_stride >= 8, src_stride >= 15, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular8_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular8_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_regular8_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 7) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_avg_regular8_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp16_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp16_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 0) * src_stride + 24, dst_stride >= 16, src_stride >= 23, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp16_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp16_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp16_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 7) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp16_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp32_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp32_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 0) * src_stride + 40, dst_stride >= 32, src_stride >= 39, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp32_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp32_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp32_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 7) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp32_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp4_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp4_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 0) * src_stride + 12, dst_stride >= 4, src_stride >= 11, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp4_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp4_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp4_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 7) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp4_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp64_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp64_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 0) * src_stride + 72, dst_stride >= 64, src_stride >= 71, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp64_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp64_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp64_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 7) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp64_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp8_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp8_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 0) * src_stride + 16, dst_stride >= 8, src_stride >= 15, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp8_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp8_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_sharp8_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 7) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_avg_sharp8_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth16_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth16_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 0) * src_stride + 24, dst_stride >= 16, src_stride >= 23, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth16_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth16_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth16_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 7) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth16_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth32_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth32_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 0) * src_stride + 40, dst_stride >= 32, src_stride >= 39, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth32_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth32_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth32_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 7) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth32_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth4_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth4_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 0) * src_stride + 12, dst_stride >= 4, src_stride >= 11, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth4_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth4_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth4_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 7) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth4_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth64_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth64_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 0) * src_stride + 72, dst_stride >= 64, src_stride >= 71, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth64_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth64_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth64_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 7) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth64_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth8_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth8_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 0) * src_stride + 16, dst_stride >= 8, src_stride >= 15, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth8_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth8_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_avg_smooth8_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 7) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_avg_smooth8_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_aarch64.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 128, src.len() == (h - 1) * src_stride + 128, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_copy128_aarch64(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_copy16_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_aarch64.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_copy32_aarch64(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_copy4_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_aarch64.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_copy64_aarch64(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 128])]
fn ff_vp9_copy8_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_iadst_iadst_16x16_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_iadst_iadst_16x16_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256])]
fn ff_vp9_iadst_iadst_16x16_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_iadst_iadst_4x4_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_iadst_iadst_4x4_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16])]
fn ff_vp9_iadst_iadst_4x4_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_iadst_iadst_8x8_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_iadst_iadst_8x8_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64])]
fn ff_vp9_iadst_iadst_8x8_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_iadst_idct_16x16_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_iadst_idct_16x16_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256])]
fn ff_vp9_iadst_idct_16x16_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_iadst_idct_4x4_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_iadst_idct_4x4_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16])]
fn ff_vp9_iadst_idct_4x4_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_iadst_idct_8x8_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_iadst_idct_8x8_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64])]
fn ff_vp9_iadst_idct_8x8_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_idct_iadst_16x16_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_idct_iadst_16x16_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256])]
fn ff_vp9_idct_iadst_16x16_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_idct_iadst_4x4_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_idct_iadst_4x4_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16])]
fn ff_vp9_idct_iadst_4x4_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_idct_iadst_8x8_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_idct_iadst_8x8_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64])]
fn ff_vp9_idct_iadst_8x8_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_idct_idct_16x16_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256, stride % 2 == 0])]
fn ff_vp9_idct_idct_16x16_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824, block.len() == 256, eob >= 1, eob <= 256])]
fn ff_vp9_idct_idct_16x16_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 31 * stride / 2 + 32, stride >= 64, stride <= 1073741824, block.len() == 1024, eob >= 1, eob <= 1024, stride % 2 == 0])]
fn ff_vp9_idct_idct_32x32_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 31 * stride / 2 + 32, stride >= 64, stride <= 1073741824, block.len() == 1024, eob >= 1, eob <= 1024, stride % 2 == 0])]
fn ff_vp9_idct_idct_32x32_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 31 * stride + 32, stride >= 32, stride <= 1073741824, block.len() == 1024, eob >= 1, eob <= 1024])]
fn ff_vp9_idct_idct_32x32_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_idct_idct_4x4_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_idct_idct_4x4_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16])]
fn ff_vp9_idct_idct_4x4_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_idct_idct_8x8_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64, stride % 2 == 0])]
fn ff_vp9_idct_idct_8x8_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64, eob >= 1, eob <= 64])]
fn ff_vp9_idct_idct_8x8_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_iwht_iwht_4x4_add_10_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_16bpp_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride / 2 + 4, stride >= 8, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16, stride % 2 == 0])]
fn ff_vp9_iwht_iwht_4x4_add_12_neon(dst: &mut [u16], stride: usize, block: &mut [i32], eob: usize);

#[bums::check_mem_safe("vp9itxfm_neon.S", dst.as_mut_ptr(), stride, block.as_mut_ptr(), eob,
    [dst.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 16, eob >= 1, eob <= 16])]
fn ff_vp9_iwht_iwht_4x4_add_neon(dst: &mut [u8], stride: usize, block: &mut [i16], eob: usize);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_16_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_16_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(8), stride, e, i, h,
    [dst.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_16_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_16_8_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_16_8_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(8), stride, e, i, h,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_16_8_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_44_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_44_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_44_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_48_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_48_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_48_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_4_8_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_4_8_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_4_8_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_84_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_84_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_84_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_88_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_88_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_88_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_8_8_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_h_8_8_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4), stride, e, i, h,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_h_8_8_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8 * stride / 2), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_16_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8 * stride / 2), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_16_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(8 * stride), stride, e, i, h,
    [dst.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_16_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8 * stride / 2), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_16_8_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(8 * stride / 2), stride, e, i, h,
    [dst.len() == 15 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_16_8_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(8 * stride), stride, e, i, h,
    [dst.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_16_8_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_44_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_44_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4 * stride), stride, e, i, h,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_44_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_48_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_48_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4 * stride), stride, e, i, h,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_48_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_4_8_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_4_8_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4 * stride), stride, e, i, h,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_4_8_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_84_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_84_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4 * stride), stride, e, i, h,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_84_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_88_16_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 16, stride >= 32, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_88_16_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4 * stride), stride, e, i, h,
    [dst.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_88_16_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_8_8_10_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_16bpp_neon.S", dst.as_mut_ptr().add(4 * stride / 2), stride, e, i, h,
    [dst.len() == 7 * stride / 2 + 8, stride >= 16, stride <= 1073741824, stride % 2 == 0])]
fn ff_vp9_loop_filter_v_8_8_12_neon(dst: &mut [u16], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9lpf_neon.S", dst.as_mut_ptr().add(4 * stride), stride, e, i, h,
    [dst.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_vp9_loop_filter_v_8_8_neon(dst: &mut [u8], stride: usize, e: u32, i: u32, h: u32);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular16_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular16_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 0) * src_stride + 24, dst_stride >= 16, src_stride >= 23, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_put_regular16_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular16_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular16_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 7) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_put_regular16_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular32_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular32_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 0) * src_stride + 40, dst_stride >= 32, src_stride >= 39, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_regular32_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular32_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular32_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 7) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_regular32_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular4_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular4_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 0) * src_stride + 12, dst_stride >= 4, src_stride >= 11, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_put_regular4_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular4_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular4_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 7) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_put_regular4_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular64_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular64_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 0) * src_stride + 72, dst_stride >= 64, src_stride >= 71, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_regular64_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular64_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular64_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 7) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_regular64_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular8_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular8_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 0) * src_stride + 16, dst_stride >= 8, src_stride >= 15, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_put_regular8_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular8_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_regular8_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 7) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_put_regular8_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp16_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp16_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 0) * src_stride + 24, dst_stride >= 16, src_stride >= 23, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp16_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp16_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp16_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 7) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp16_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp32_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp32_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 0) * src_stride + 40, dst_stride >= 32, src_stride >= 39, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp32_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp32_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp32_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 7) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp32_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp4_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp4_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 0) * src_stride + 12, dst_stride >= 4, src_stride >= 11, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp4_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp4_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp4_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 7) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp4_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp64_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp64_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 0) * src_stride + 72, dst_stride >= 64, src_stride >= 71, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp64_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp64_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp64_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 7) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp64_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp8_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp8_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 0) * src_stride + 16, dst_stride >= 8, src_stride >= 15, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp8_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp8_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_sharp8_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 7) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_put_sharp8_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth16_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 0) * src_stride / 2 + 24, dst_stride >= 32, src_stride >= 46, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth16_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 0) * src_stride + 24, dst_stride >= 16, src_stride >= 23, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth16_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth16_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 16, src.len() == (h - 1 + 7) * src_stride / 2 + 16, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth16_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 16, src.len() == (h - 1 + 7) * src_stride + 16, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 40, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth16_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth32_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 0) * src_stride / 2 + 40, dst_stride >= 64, src_stride >= 78, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth32_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 0) * src_stride + 40, dst_stride >= 32, src_stride >= 39, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth32_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth32_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 32, src.len() == (h - 1 + 7) * src_stride / 2 + 32, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth32_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 32, src.len() == (h - 1 + 7) * src_stride + 32, dst_stride >= 32, src_stride >= 32, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth32_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth4_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 0) * src_stride / 2 + 12, dst_stride >= 8, src_stride >= 22, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth4_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 0) * src_stride + 12, dst_stride >= 4, src_stride >= 11, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth4_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth4_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 4, src.len() == (h - 1 + 7) * src_stride / 2 + 4, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth4_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 4, src.len() == (h - 1 + 7) * src_stride + 4, dst_stride >= 4, src_stride >= 4, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth4_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth64_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 0) * src_stride / 2 + 72, dst_stride >= 128, src_stride >= 142, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth64_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 0) * src_stride + 72, dst_stride >= 64, src_stride >= 71, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth64_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth64_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 64, src.len() == (h - 1 + 7) * src_stride / 2 + 64, dst_stride >= 128, src_stride >= 128, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth64_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 64, src.len() == (h - 1 + 7) * src_stride + 64, dst_stride >= 64, src_stride >= 64, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 72, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth64_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth8_h_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride / 2 + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 0) * src_stride / 2 + 16, dst_stride >= 16, src_stride >= 30, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth8_h_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(0 * src_stride + 3), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 0) * src_stride + 16, dst_stride >= 8, src_stride >= 15, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth8_h_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth8_v_10_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_16bpp_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride / 2 + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride / 2 + 8, src.len() == (h - 1 + 7) * src_stride / 2 + 8, dst_stride >= 16, src_stride >= 16, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15, dst_stride % 2 == 0, src_stride % 2 == 0])]
fn ff_vp9_put_smooth8_v_12_neon(dst: &mut [u16], dst_stride: usize, src: &[u16], src_stride: usize, h: usize, mx: usize, my: usize);

#[bums::check_mem_safe("vp9mc_neon.S", dst.as_mut_ptr(), dst_stride, src.as_ptr().add(3 * src_stride + 0), src_stride, h, mx, my,
    [dst.len() == (h - 1) * dst_stride + 8, src.len() == (h - 1 + 7) * src_stride + 8, dst_stride >= 8, src_stride >= 8, dst_stride <= 1073741824, src_stride <= 1073741824, h % 4 == 0, h >= 4, h <= 24, mx <= 15, my <= 15])]
fn ff_vp9_put_smooth8_v_neon(dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, h: usize, mx: usize, my: usize);

