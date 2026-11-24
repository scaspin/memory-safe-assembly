use bums_macros as bums;

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels48_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 0, my >= 0, my <= 0])]
fn ff_hevc_put_hevc_pel_pixels64_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_pel_bi_pixels64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 4, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 6, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 8, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 12, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 16, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24 || width == 48, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 48, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, src2.as_ptr(), height, denom, wx0, wx1, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 64, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 64, dststride <= 1073741824, src2.len() == 4096, denom <= 14])]
fn ff_hevc_put_hevc_pel_bi_w_pixels32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, denom: i32, wx0: i32, wx1: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_h64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_v64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v48_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_v64_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_v64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_h64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 48 || width == 64, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 48 || width == 64, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h4_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h6_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h8_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h12_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h16_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h24_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h32_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h48_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 0, my <= 7])]
fn ff_hevc_put_hevc_epel_h64_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv48_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv64_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv4_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv6_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv8_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv12_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv16_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv24_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv32_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv48_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7])]
fn ff_hevc_put_hevc_epel_hv64_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_epel_uni_hv64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 0, my <= 7, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_h64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_hv64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 7, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 9, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 27, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 35, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 51, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 1), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 67, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_epel_bi_hv64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("epel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(1 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 4) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 7, my >= 1, my <= 7, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_epel_uni_w_v64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12 || width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 48 || width == 64, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12 || width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 48 || width == 64, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_h32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12 || width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 48 || width == 64, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_h32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v48_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_v64_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_v64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_pel_uni_pixels64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_v64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr(), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 0, my >= 0, my <= 0, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_pel_uni_w_pixels64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 4, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 8, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 6, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 16, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 12, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 64, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 24, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 32, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 0), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 48, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 0, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_v48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h4_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h6_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h8_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h12_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h16_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h32_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h48_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824])]
fn ff_hevc_put_hevc_qpel_uni_hv64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h64_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32 || width == 48 || width == 64, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(0 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 1) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 0, my <= 3, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_h64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(0 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 1) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 0, my <= 3])]
fn ff_hevc_put_hevc_qpel_h24_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv4_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv6_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv8_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv12_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv16_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv24_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv32_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv48_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv64_8_neon(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv4_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv6_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv8_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv12_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv16_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv24_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv32_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv48_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), src.as_ptr().add(3 * srcstride + 3), srcstride, height, mx, my, width,
    [dst.len() == 4096, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3])]
fn ff_hevc_put_hevc_qpel_hv64_8_neon_i8mm(dst: &mut [i16], src: &[u8], srcstride: usize, height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv4_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv6_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv8_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv12_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv16_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv24_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv32_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv48_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv64_8_neon(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, height, denom, wx, ox, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824, denom <= 14])]
fn ff_hevc_put_hevc_qpel_uni_w_hv64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, height: usize, denom: i32, wx: i32, ox: i32, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 11, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 4, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 4, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv4_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 13, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 6, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 6, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv6_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 15, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 8, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 8, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv8_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 19, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 12, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 12, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv12_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 23, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 16, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 16, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv16_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 31, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 24, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 24, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv24_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 39, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 32, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 32, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv32_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 55, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 48, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 48, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv48_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

#[bums::check_mem_safe("qpel_neon.S", dst.as_mut_ptr(), dststride, src.as_ptr().add(3 * srcstride + 3), srcstride, src2.as_ptr(), height, mx, my, width,
    [dst.len() == (height - 1) * dststride + width, src.len() == (height + 8) * srcstride + 16, srcstride >= 71, srcstride <= 1073741824, height % 2 == 0, height >= 2, height <= 64, width == 64, mx >= 1, mx <= 3, my >= 1, my <= 3, dststride >= 64, dststride <= 1073741824, src2.len() == 4096])]
fn ff_hevc_put_hevc_qpel_bi_hv64_8_neon_i8mm(dst: &mut [u8], dststride: usize, src: &[u8], srcstride: usize, src2: &[i16], height: usize, mx: usize, my: usize, width: usize);

