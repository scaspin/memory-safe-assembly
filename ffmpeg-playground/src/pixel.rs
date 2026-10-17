use bums_macros as bums;

#[bums::check_mem_safe("huffyuvdsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), mask, w,
    [dst.len() == w, src.len() == w, w <= 1048576])]
fn ff_add_int16_neon(dst: &mut [u16], src: &[u16], mask: u32, w: usize);

#[bums::check_mem_safe("pixblockdsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), stride,
    [block.len() == 64, pixels.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_get_pixels_neon(block: &mut [i16], pixels: &[u8], stride: usize);

#[bums::check_mem_safe("pixblockdsp_neon.S", block.as_mut_ptr(), s1.as_ptr(), s2.as_ptr(), stride,
    [block.len() == 64, s1.len() == 7 * stride + 8, s2.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_diff_pixels_neon(block: &mut [i16], s1: &[u8], s2: &[u8], stride: usize);

#[bums::check_mem_safe("idctdsp_neon.S", block.as_ptr(), pixels.as_mut_ptr(), stride,
    [block.len() == 64, pixels.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_put_pixels_clamped_neon(block: &[i16], pixels: &mut [u8], stride: usize);

#[bums::check_mem_safe("idctdsp_neon.S", block.as_ptr(), pixels.as_mut_ptr(), stride,
    [block.len() == 64, pixels.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_put_signed_pixels_clamped_neon(block: &[i16], pixels: &mut [u8], stride: usize);

#[bums::check_mem_safe("idctdsp_neon.S", block.as_ptr(), pixels.as_mut_ptr(), stride,
    [block.len() == 64, pixels.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_add_pixels_clamped_neon(block: &[i16], pixels: &mut [u8], stride: usize);

#[bums::check_mem_safe("simple_idct_neon.S", data.as_mut_ptr(), [data.len() == 64])]
fn ff_simple_idct_neon(data: &mut [i16]);

#[bums::check_mem_safe("simple_idct_neon.S", dest.as_mut_ptr(), line_size, data.as_mut_ptr(),
    [dest.len() == 7 * line_size + 8, data.len() == 64, line_size >= 8, line_size <= 1073741824])]
fn ff_simple_idct_put_neon(dest: &mut [u8], line_size: usize, data: &mut [i16]);

#[bums::check_mem_safe("simple_idct_neon.S", dest.as_mut_ptr(), line_size, data.as_mut_ptr(),
    [dest.len() == 7 * line_size + 8, data.len() == 64, line_size >= 8, line_size <= 1073741824])]
fn ff_simple_idct_add_neon(dest: &mut [u8], line_size: usize, data: &mut [i16]);

#[bums::check_mem_safe("fdctdsp_neon.S", block.as_mut_ptr(), [block.len() == 64])]
fn ff_fdct_neon(block: &mut [i16]);

#[bums::check_mem_safe("mpegvideoencdsp_neon.S", pix.as_ptr(), line_size,
    [pix.len() == 15 * line_size + 16, line_size >= 16, line_size <= 1073741824])]
fn ff_pix_sum16_neon(pix: &[u8], line_size: usize);

#[bums::check_mem_safe("mpegvideoencdsp_neon.S", pix.as_ptr(), line_size,
    [pix.len() == 15 * line_size + 16, line_size >= 16, line_size <= 1073741824])]
fn ff_pix_norm1_neon(pix: &[u8], line_size: usize);

#[bums::check_mem_safe("mpegvideoencdsp_neon.S", pix.as_ptr(), line_size,
    [pix.len() == 15 * line_size + 16, line_size >= 16, line_size <= 1073741824])]
fn ff_pix_norm1_neon_dotprod(pix: &[u8], line_size: usize);

#[bums::check_mem_safe("pngdsp_neon.S", dst.as_mut_ptr(), src1.as_ptr(), src2.as_ptr(), w,
    [dst.len() == w, src1.len() == w, src2.len() == w, w <= 1073741824])]
fn ff_png_add_bytes_l2_neon(dst: &mut [u8], src1: &[u8], src2: &[u8], w: usize);

#[bums::check_mem_safe("pngdsp_neon.S", dst.as_mut_ptr().add(bpp), src.as_ptr(), top.as_ptr().add(bpp), w, bpp,
    [dst.len() == bpp + w, src.len() == w, top.len() == bpp + w, w >= 1, w <= 1073741824,
     (bpp - 3) * (bpp - 4) * (bpp - 6) * (bpp - 8) == 0])]
fn ff_png_add_paeth_prediction_neon(dst: &mut [u8], src: &[u8], top: &[u8], w: usize, bpp: usize);

#[bums::check_mem_safe("videodsp.S", mem.as_ptr(), stride, h,
    [mem.len() == stride * h, stride >= 1, stride <= 1073741824, h >= 1, h <= 4096])]
fn ff_prefetch_aarch64(mem: &[u8], stride: usize, h: usize);
