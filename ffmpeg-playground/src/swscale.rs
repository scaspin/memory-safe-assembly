use bums_macros as bums;

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 8 * w, src2.len() == 8 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_abgr32ToUV_half_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 4 * w, src2.len() == 4 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_abgr32ToUV_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 4 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_abgr32ToY_neon(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 8 * w, src2.len() == 8 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_argb32ToUV_half_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 4 * w, src2.len() == 4 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_argb32ToUV_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 4 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_argb32ToY_neon(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 6 * w, src2.len() == 6 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgr24ToUV_half_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 3 * w, src2.len() == 3 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgr24ToUV_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 3 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgr24ToY_neon(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 8 * w, src2.len() == 8 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgra32ToUV_half_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 4 * w, src2.len() == 4 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgra32ToUV_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 4 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgra32ToY_neon(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 4 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_bgra32ToY_neon_dotprod(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("range_convert_neon.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), width, coeff, offset,
    [dst_u.len() == width + 33, dst_v.len() == width + 33, width >= 1, width <= 16384])]
fn ff_chrRangeFromJpeg16_neon(dst_u: &mut [i32], dst_v: &mut [i32], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("range_convert_neon.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), width, coeff, offset,
    [dst_u.len() == width + 33, dst_v.len() == width + 33, width >= 1, width <= 16384])]
fn ff_chrRangeFromJpeg8_neon(dst_u: &mut [i16], dst_v: &mut [i16], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("range_convert_neon.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), width, coeff, offset,
    [dst_u.len() == width + 33, dst_v.len() == width + 33, width >= 1, width <= 16384])]
fn ff_chrRangeToJpeg16_neon(dst_u: &mut [i32], dst_v: &mut [i32], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("range_convert_neon.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), width, coeff, offset,
    [dst_u.len() == width + 33, dst_v.len() == width + 33, width >= 1, width <= 16384])]
fn ff_chrRangeToJpeg8_neon(dst_u: &mut [i16], dst_v: &mut [i16], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst1.as_mut_ptr(), dst2.as_mut_ptr(), width, height, ss, d1, d2,
    [src.len() == (height - 1) * ss + 2 * width, dst1.len() == (height - 1) * d1 + width, dst2.len() == (height - 1) * d2 + width, ss >= 2 * width, d1 >= width, d2 >= width, ss <= 1073741824, d1 <= 1073741824, d2 <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_deinterleave_bytes_neon(src: &[u8], dst1: &mut [u8], dst2: &mut [u8], width: usize, height: usize, ss: usize, d1: usize, d2: usize);

#[bums::check_mem_safe("hscale.S", shift, dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size == 4])]
fn ff_hscale16to15_4_neon_asm(shift: i32, dst: &mut [i16], dst_w: usize, src: &[u16], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", shift, dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 4 == 0, filter_size % 8 != 0, filter_size >= 4])]
fn ff_hscale16to15_X4_neon_asm(shift: i32, dst: &mut [i16], dst_w: usize, src: &[u16], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", shift, dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 8 == 0, filter_size >= 8])]
fn ff_hscale16to15_X8_neon_asm(shift: i32, dst: &mut [i16], dst_w: usize, src: &[u16], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", shift, dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size == 4])]
fn ff_hscale16to19_4_neon_asm(shift: i32, dst: &mut [i32], dst_w: usize, src: &[u16], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", shift, dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 4 == 0, filter_size % 8 != 0, filter_size >= 4])]
fn ff_hscale16to19_X4_neon_asm(shift: i32, dst: &mut [i32], dst_w: usize, src: &[u16], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", shift, dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 8 == 0, filter_size >= 8])]
fn ff_hscale16to19_X8_neon_asm(shift: i32, dst: &mut [i32], dst_w: usize, src: &[u16], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", ctx.as_ptr(), dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [ctx.len() == 1, dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size == 4])]
fn ff_hscale8to15_4_neon(ctx: &[u8], dst: &mut [i16], dst_w: usize, src: &[u8], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", ctx.as_ptr(), dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [ctx.len() == 1, dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 4 == 0, filter_size % 8 != 0, filter_size >= 4])]
fn ff_hscale8to15_X4_neon(ctx: &[u8], dst: &mut [i16], dst_w: usize, src: &[u8], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", ctx.as_ptr(), dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [ctx.len() == 1, dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 8 == 0, filter_size >= 8])]
fn ff_hscale8to15_X8_neon(ctx: &[u8], dst: &mut [i16], dst_w: usize, src: &[u8], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", ctx.as_ptr(), dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [ctx.len() == 1, dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size == 4])]
fn ff_hscale8to19_4_neon(ctx: &[u8], dst: &mut [i32], dst_w: usize, src: &[u8], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", ctx.as_ptr(), dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [ctx.len() == 1, dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 4 == 0, filter_size % 8 != 0, filter_size >= 4])]
fn ff_hscale8to19_X4_neon(ctx: &[u8], dst: &mut [i32], dst_w: usize, src: &[u8], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("hscale.S", ctx.as_ptr(), dst.as_mut_ptr(), dst_w, src.as_ptr(), filter.as_ptr(), filter_pos.as_ptr(), filter_size,
    [ctx.len() == 1, dst.len() == dst_w + 33, dst_w >= 1, dst_w <= 16384, src.len() == src_w, src_w >= filter_size, src_w <= 16384, filter.len() == (dst_w + 3) * filter_size, filter_pos.len() == dst_w + 3, filter_pos[..] <= (src_w - filter_size) as i32, filter_pos[..] >= 0, filter_size <= 256, filter_size % 8 == 0, filter_size >= 8])]
fn ff_hscale8to19_X8_neon(ctx: &[u8], dst: &mut [i32], dst_w: usize, src: &[u8], filter: &[i16], filter_pos: &[i32], filter_size: usize, src_w: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src1.as_ptr(), src2.as_ptr(), dest.as_mut_ptr(), width, height, s1, s2, ds,
    [src1.len() == (height - 1) * s1 + width, src2.len() == (height - 1) * s2 + width, dest.len() == (height - 1) * ds + 2 * width, s1 >= width, s2 >= width, ds >= 2 * width, s1 <= 1073741824, s2 <= 1073741824, ds <= 1073741824, width >= 1, width <= 16384, height >= 1, height <= 16384])]
fn ff_interleave_bytes_neon(src1: &[u8], src2: &[u8], dest: &mut [u8], width: usize, height: usize, s1: usize, s2: usize, ds: usize);

#[bums::check_mem_safe("range_convert_neon.S", dst.as_mut_ptr(), width, coeff, offset,
    [dst.len() == width + 33, width >= 1, width <= 16384])]
fn ff_lumRangeFromJpeg16_neon(dst: &mut [i32], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("range_convert_neon.S", dst.as_mut_ptr(), width, coeff, offset,
    [dst.len() == width + 33, width >= 1, width <= 16384])]
fn ff_lumRangeFromJpeg8_neon(dst: &mut [i16], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("range_convert_neon.S", dst.as_mut_ptr(), width, coeff, offset,
    [dst.len() == width + 33, width >= 1, width <= 16384])]
fn ff_lumRangeToJpeg16_neon(dst: &mut [i32], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("range_convert_neon.S", dst.as_mut_ptr(), width, coeff, offset,
    [dst.len() == width + 33, width >= 1, width <= 16384])]
fn ff_lumRangeToJpeg8_neon(dst: &mut [i16], width: usize, coeff: u32, offset: i64);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 6 * w, src2.len() == 6 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgb24ToUV_half_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 3 * w, src2.len() == 3 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgb24ToUV_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 3 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgb24ToY_neon(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size / 3 * 3, src_size % 3 == 0, src_size >= 3, src_size <= 1073741824])]
fn ff_rgb24tobgr24_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size / 3 * 4, src_size % 3 == 0, src_size >= 3, src_size <= 1073741824])]
fn ff_rgb24tobgr32_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), ydst.as_mut_ptr(), udst.as_mut_ptr(), vdst.as_mut_ptr(), width, height, lum, chrom, ss, rgb2yuv.as_ptr(),
    [src.len() == (height - 1) * ss + 3 * width, ydst.len() == (height - 1) * lum + width, udst.len() == (height / 2 - 1) * chrom + width / 2, vdst.len() == (height / 2 - 1) * chrom + width / 2, width % 16 == 0, width >= 16, width <= 16384, height % 2 == 0, height >= 2, height <= 16384, lum >= width, chrom >= width / 2, ss >= 3 * width, lum <= 1073741824, chrom <= 1073741824, ss <= 1073741824, rgb2yuv.len() == 176])]
fn ff_rgb24toyv12_neon(src: &[u8], ydst: &mut [u8], udst: &mut [u8], vdst: &mut [u8], width: usize, height: usize, lum: usize, chrom: usize, ss: usize, rgb2yuv: &[i32]);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size / 4 * 3, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_rgb32tobgr24_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 8 * w, src2.len() == 8 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgba32ToUV_half_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst_u.as_mut_ptr(), dst_v.as_mut_ptr(), unused0.as_ptr(), src1.as_ptr(), src2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst_u.len() == w, dst_v.len() == w, unused0.len() == 1, src1.len() == 4 * w, src2.len() == 4 * w, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgba32ToUV_neon(dst_u: &mut [i16], dst_v: &mut [i16], unused0: &[u8], src1: &[u8], src2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 4 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgba32ToY_neon(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("input.S", dst.as_mut_ptr(), src.as_ptr(), unused1.as_ptr(), unused2.as_ptr(), w, rgb2yuv.as_ptr(), opaque.as_ptr(),
    [dst.len() == w, src.len() == 4 * w, unused1.len() == 1, unused2.len() == 1, w >= 1, w <= 16384, rgb2yuv.len() == 176, opaque.len() == 1])]
fn ff_rgba32ToY_neon_dotprod(dst: &mut [i16], src: &[u8], unused1: &[u8], unused2: &[u8], w: usize, rgb2yuv: &[i32], opaque: &[u8]);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_0321_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_1203_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_1230_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_2013_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_2103_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_2130_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_3012_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_3102_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", src.as_ptr(), dst.as_mut_ptr(), src_size,
    [src.len() == src_size, dst.len() == src_size, src_size % 4 == 0, src_size >= 4, src_size <= 1073741824])]
fn ff_shuffle_bytes_3210_neon(src: &[u8], dst: &mut [u8], src_size: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", ydst.as_mut_ptr(), udst.as_mut_ptr(), vdst.as_mut_ptr(), src.as_ptr(), width, height, lum, chrom, ss,
    [ydst.len() == (height - 1) * lum + width, udst.len() == (height / 2 - 1) * chrom + width / 2, vdst.len() == (height / 2 - 1) * chrom + width / 2, src.len() == (height - 1) * ss + 2 * width, width % 2 == 0, width >= 2, width <= 16384, height % 2 == 0, height >= 2, height <= 16384, lum >= width, chrom >= width / 2, ss >= 2 * width, lum <= 1073741824, chrom <= 1073741824, ss <= 1073741824])]
fn ff_uyvytoyuv420_neon(ydst: &mut [u8], udst: &mut [u8], vdst: &mut [u8], src: &[u8], width: usize, height: usize, lum: usize, chrom: usize, ss: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", ydst.as_mut_ptr(), udst.as_mut_ptr(), vdst.as_mut_ptr(), src.as_ptr(), width, height, lum, chrom, ss,
    [ydst.len() == (height - 1) * lum + width, udst.len() == (height - 1) * chrom + width / 2, vdst.len() == (height - 1) * chrom + width / 2, src.len() == (height - 1) * ss + 2 * width, width % 2 == 0, width >= 2, width <= 16384, height % 2 == 0, height >= 2, height <= 16384, lum >= width, chrom >= width / 2, ss >= 2 * width, lum <= 1073741824, chrom <= 1073741824, ss <= 1073741824])]
fn ff_uyvytoyuv422_neon(ydst: &mut [u8], udst: &mut [u8], vdst: &mut [u8], src: &[u8], width: usize, height: usize, lum: usize, chrom: usize, ss: usize);

#[bums::check_mem_safe("output.S", src.as_ptr(), dest.as_mut_ptr(), dst_w, dither.as_ptr(), offset,
    [src.len() == dst_w + 33, dest.len() == dst_w, dst_w >= 1, dst_w <= 16384, dither.len() == 8, offset <= 7])]
fn ff_yuv2plane1_8_neon(src: &[i16], dest: &mut [u8], dst_w: usize, dither: &[u8], offset: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", ydst.as_mut_ptr(), udst.as_mut_ptr(), vdst.as_mut_ptr(), src.as_ptr(), width, height, lum, chrom, ss,
    [ydst.len() == (height - 1) * lum + width, udst.len() == (height / 2 - 1) * chrom + width / 2, vdst.len() == (height / 2 - 1) * chrom + width / 2, src.len() == (height - 1) * ss + 2 * width, width % 2 == 0, width >= 2, width <= 16384, height % 2 == 0, height >= 2, height <= 16384, lum >= width, chrom >= width / 2, ss >= 2 * width, lum <= 1073741824, chrom <= 1073741824, ss <= 1073741824])]
fn ff_yuyvtoyuv420_neon(ydst: &mut [u8], udst: &mut [u8], vdst: &mut [u8], src: &[u8], width: usize, height: usize, lum: usize, chrom: usize, ss: usize);

#[bums::check_mem_safe("rgb2rgb_neon.S", ydst.as_mut_ptr(), udst.as_mut_ptr(), vdst.as_mut_ptr(), src.as_ptr(), width, height, lum, chrom, ss,
    [ydst.len() == (height - 1) * lum + width, udst.len() == (height - 1) * chrom + width / 2, vdst.len() == (height - 1) * chrom + width / 2, src.len() == (height - 1) * ss + 2 * width, width % 2 == 0, width >= 2, width <= 16384, height % 2 == 0, height >= 2, height <= 16384, lum >= width, chrom >= width / 2, ss >= 2 * width, lum <= 1073741824, chrom <= 1073741824, ss <= 1073741824])]
fn ff_yuyvtoyuv422_neon(ydst: &mut [u8], udst: &mut [u8], vdst: &mut [u8], src: &[u8], width: usize, height: usize, lum: usize, chrom: usize, ss: usize);

#[bums::check_mem_safe("output.S", filter.as_ptr(), filter_size, src.as_ptr(), dest.as_mut_ptr(), dst_w, dither.as_ptr(), offset,
    [filter.len() == filter_size, src == [&[i16; dst_w + 33]; filter_size], dest.len() == dst_w, dither.len() == 8,
     filter_size >= 1, filter_size <= 64, dst_w >= 1, dst_w <= 16384, offset <= 7])]
fn ff_yuv2planeX_8_neon(filter: &[i16], filter_size: usize, src: &[*const i16], dest: &mut [u8], dst_w: usize, dither: &[u8], offset: usize);

#[bums::check_mem_safe("output.S", filter.as_ptr(), filter_size, src.as_ptr(), dest.as_mut_ptr(), dst_w, big_endian, output_bits,
    [filter.len() == filter_size, src == [&[i16; dst_w + 33]; filter_size], dest.len() == dst_w,
     filter_size >= 1, filter_size <= 64, dst_w >= 1, dst_w <= 16384, big_endian <= 1, output_bits >= 9, output_bits <= 14])]
fn ff_yuv2planeX_10_neon(filter: &[i16], filter_size: usize, src: &[*const i16], dest: &mut [u16], dst_w: usize, big_endian: usize, output_bits: usize);

#[bums::check_mem_safe("output.S", is_swapped, chr_dither.as_ptr(), chr_filter.as_ptr(), chr_filter_size, chr_u_src.as_ptr(), chr_v_src.as_ptr(), dest.as_mut_ptr(), chr_dst_w,
    [chr_dither.len() == 8, chr_filter.len() == chr_filter_size,
     chr_u_src == [&[i16; chr_dst_w + 33]; chr_filter_size], chr_v_src == [&[i16; chr_dst_w + 33]; chr_filter_size],
     dest.len() == 2 * chr_dst_w, is_swapped <= 1, chr_filter_size >= 1, chr_filter_size <= 64, chr_dst_w >= 1, chr_dst_w <= 16384])]
fn ff_yuv2nv12cX_neon_asm(is_swapped: usize, chr_dither: &[u8], chr_filter: &[i16], chr_filter_size: usize, chr_u_src: &[*const i16], chr_v_src: &[*const i16], dest: &mut [u8], chr_dst_w: usize);

#[bums::check_mem_safe("xyz2rgb_neon.S", c.as_ptr(), dst.as_mut_ptr(), dst_stride, src.as_ptr(), src_stride, w, h,
    [c.len() == 5, c[0] == gamma_in.as_ptr(), c[1] == gamma_out.as_ptr(), gamma_in.len() == 4096, gamma_out.len() == 65536,
     dst.len() == (h - 1) * dst_stride + 6 * w, src.len() == (h - 1) * src_stride + 6 * w,
     dst_stride >= 6 * w, src_stride >= 6 * w, dst_stride <= 1073741824, src_stride <= 1073741824,
     w >= 1, w <= 16384, h >= 1, h <= 16384])]
fn ff_xyz12Torgb48le_neon_asm(c: &[u64], dst: &mut [u8], dst_stride: usize, src: &[u8], src_stride: usize, w: usize, h: usize, gamma_in: &[u16], gamma_out: &[u16]);

