use bums_macros as bums;

#[bums::check_mem_safe("vc1dsp_neon.S", block.as_mut_ptr(),
    [block.len() == 64])]
fn ff_vc1_inv_trans_8x8_neon(block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 3 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_8x4_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 3 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_8x4_dc_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 7 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_4x8_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 7 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_4x8_dc_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_4x4_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 3 * stride + 4, stride >= 4, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_4x4_dc_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", dest.as_mut_ptr(), stride, block.as_mut_ptr(),
    [dest.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, block.len() == 64])]
fn ff_vc1_inv_trans_8x8_dc_neon(dest: &mut [u8], stride: usize, block: &mut [i16]);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_mut_ptr().add(4 * stride), stride, pq,
    [src.len() == 7 * stride + 4, stride >= 4, stride <= 1073741824, pq <= 31])]
fn ff_vc1_v_loop_filter4_neon(src: &mut [u8], stride: usize, pq: usize);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_mut_ptr().add(4), stride, pq,
    [src.len() == 3 * stride + 8, stride >= 8, stride <= 1073741824, pq <= 31])]
fn ff_vc1_h_loop_filter4_neon(src: &mut [u8], stride: usize, pq: usize);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_mut_ptr().add(4 * stride), stride, pq,
    [src.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, pq <= 31])]
fn ff_vc1_v_loop_filter8_neon(src: &mut [u8], stride: usize, pq: usize);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_mut_ptr().add(4), stride, pq,
    [src.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824, pq <= 31])]
fn ff_vc1_h_loop_filter8_neon(src: &mut [u8], stride: usize, pq: usize);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_mut_ptr().add(4 * stride), stride, pq,
    [src.len() == 7 * stride + 16, stride >= 16, stride <= 1073741824, pq <= 31])]
fn ff_vc1_v_loop_filter16_neon(src: &mut [u8], stride: usize, pq: usize);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_mut_ptr().add(4), stride, pq,
    [src.len() == 15 * stride + 8, stride >= 8, stride <= 1073741824, pq <= 31])]
fn ff_vc1_h_loop_filter16_neon(src: &mut [u8], stride: usize, pq: usize);

#[bums::check_mem_safe("vc1dsp_neon.S", src.as_ptr(), size, dst.as_mut_ptr(),
    [src.len() == size, dst.len() == size, size >= 4, size <= 1073741824])]
fn ff_vc1_unescape_buffer_helper_neon(src: &[u8], size: usize, dst: &mut [u8]);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn ff_pix_abs16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 17, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 17])]
fn ff_pix_abs16_x2_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 17, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 1) * stride + 17])]
fn ff_pix_abs16_xy2_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 1) * stride + 16])]
fn ff_pix_abs16_y2_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 8])]
fn ff_pix_abs8_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 9])]
fn ff_pix_abs8_x2_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 9, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 1) * stride + 9])]
fn ff_pix_abs8_xy2_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 1) * stride + 8])]
fn ff_pix_abs8_y2_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", multiplier, pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn nsse16_neon(multiplier: i32, pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", multiplier, pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 8])]
fn nsse8_neon(multiplier: i32, pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn pix_median_abs16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 8])]
fn pix_median_abs8_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn sse16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn sse16_neon_dotprod(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 4, stride >= 4, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 4])]
fn sse4_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 8])]
fn sse8_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn vsad16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == 1])]
fn vsad_intra16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == 1])]
fn vsad_intra8_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 16])]
fn vsse16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == (h - 1 + 0) * stride + 8])]
fn vsse8_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == 1])]
fn vsse_intra16_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 16, stride >= 16, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == 1])]
fn vsse_intra16_neon_dotprod(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("me_cmp_neon.S", ctx.as_ptr(), pix1.as_ptr(), pix2.as_ptr(), stride, h,
    [ctx.len() == 1, pix1.len() == (h - 1) * stride + 8, stride >= 8, stride <= 1073741824, h % 4 == 0, h >= 4, h <= 16, pix2.len() == 1])]
fn vsse_intra8_neon(ctx: &[u8], pix1: &[u8], pix2: &[u8], stride: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 0) * line_size + 16, line_size >= 16, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 0) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_x2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 0) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_x2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_xy2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_xy2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 16, line_size >= 16, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_y2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 16, line_size >= 16, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels16_y2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 0) * line_size + 8, line_size >= 8, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels8_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 0) * line_size + 9, line_size >= 9, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels8_x2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 1) * line_size + 9, line_size >= 9, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels8_xy2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 1) * line_size + 8, line_size >= 8, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_avg_pixels8_y2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 0) * line_size + 16, line_size >= 16, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 0) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_x2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 0) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_x2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_xy2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 17, line_size >= 17, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_xy2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 16, line_size >= 16, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_y2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 16, pixels.len() == (h - 1 + 1) * line_size + 16, line_size >= 16, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels16_y2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 0) * line_size + 8, line_size >= 8, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 0) * line_size + 9, line_size >= 9, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_x2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 0) * line_size + 9, line_size >= 9, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_x2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 1) * line_size + 9, line_size >= 9, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_xy2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 1) * line_size + 9, line_size >= 9, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_xy2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 1) * line_size + 8, line_size >= 8, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_y2_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", block.as_mut_ptr(), pixels.as_ptr(), line_size, h,
    [block.len() == (h - 1) * line_size + 8, pixels.len() == (h - 1 + 1) * line_size + 8, line_size >= 8, line_size <= 1073741824, h % 4 == 0, h >= 4, h <= 16])]
fn ff_put_pixels8_y2_no_rnd_neon(block: &mut [u8], pixels: &[u8], line_size: usize, h: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride,
    [dst.len() == 15 * stride + 16, src.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_put_h264_qpel16_mc00_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride,
    [dst.len() == 7 * stride + 8, src.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_put_h264_qpel8_mc00_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride,
    [dst.len() == 15 * stride + 16, src.len() == 15 * stride + 16, stride >= 16, stride <= 1073741824])]
fn ff_avg_h264_qpel16_mc00_neon(dst: &mut [u8], src: &[u8], stride: usize);

#[bums::check_mem_safe("hpeldsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), stride,
    [dst.len() == 7 * stride + 8, src.len() == 7 * stride + 8, stride >= 8, stride <= 1073741824])]
fn ff_avg_h264_qpel8_mc00_neon(dst: &mut [u8], src: &[u8], stride: usize);

