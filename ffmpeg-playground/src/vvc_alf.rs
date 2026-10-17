use bums_macros as bums;

#[bums::check_mem_safe("alf.S", dst.as_mut_ptr(), p.as_ptr(), filter.as_ptr(), clip.as_ptr(), is_near_vb,
    [dst.len() == 8, p.len() == 7, p[0] == r0.as_ptr().add(3), r0.len() == 14, p[1] == r1.as_ptr().add(3), r1.len() == 14, p[2] == r2.as_ptr().add(3), r2.len() == 14, p[3] == r3.as_ptr().add(3), r3.len() == 14, p[4] == r4.as_ptr().add(3), r4.len() == 14, p[5] == r5.as_ptr().add(3), r5.len() == 14, p[6] == r6.as_ptr().add(3), r6.len() == 14, filter.len() == 24, clip.len() == 24, is_near_vb <= 1])]
fn ff_alf_filter_luma_kernel_8_neon(dst: &mut [u8], p: &[usize], filter: &[i16], clip: &[i16], is_near_vb: usize, r0: &[u8], r1: &[u8], r2: &[u8], r3: &[u8], r4: &[u8], r5: &[u8], r6: &[u8]);

#[bums::check_mem_safe("alf.S", dst.as_mut_ptr(), p.as_ptr(), filter.as_ptr(), clip.as_ptr(), is_near_vb,
    [dst.len() == 4, p.len() == 5, p[0] == r0.as_ptr().add(2), r0.len() == 8, p[1] == r1.as_ptr().add(2), r1.len() == 8, p[2] == r2.as_ptr().add(2), r2.len() == 8, p[3] == r3.as_ptr().add(2), r3.len() == 8, p[4] == r4.as_ptr().add(2), r4.len() == 8, filter.len() == 6, clip.len() == 6, is_near_vb <= 1])]
fn ff_alf_filter_chroma_kernel_8_neon(dst: &mut [u8], p: &[usize], filter: &[i16], clip: &[i16], is_near_vb: usize, r0: &[u8], r1: &[u8], r2: &[u8], r3: &[u8], r4: &[u8]);

#[bums::check_mem_safe("alf.S", dst.as_mut_ptr(), p.as_ptr(), filter.as_ptr(), clip.as_ptr(), is_near_vb,
    [dst.len() == 8, p.len() == 7, p[0] == r0.as_ptr().add(3), r0.len() == 14, p[1] == r1.as_ptr().add(3), r1.len() == 14, p[2] == r2.as_ptr().add(3), r2.len() == 14, p[3] == r3.as_ptr().add(3), r3.len() == 14, p[4] == r4.as_ptr().add(3), r4.len() == 14, p[5] == r5.as_ptr().add(3), r5.len() == 14, p[6] == r6.as_ptr().add(3), r6.len() == 14, filter.len() == 24, clip.len() == 24, is_near_vb <= 1])]
fn ff_alf_filter_luma_kernel_10_neon(dst: &mut [u16], p: &[usize], filter: &[i16], clip: &[i16], is_near_vb: usize, r0: &[u16], r1: &[u16], r2: &[u16], r3: &[u16], r4: &[u16], r5: &[u16], r6: &[u16]);

#[bums::check_mem_safe("alf.S", dst.as_mut_ptr(), p.as_ptr(), filter.as_ptr(), clip.as_ptr(), is_near_vb,
    [dst.len() == 4, p.len() == 5, p[0] == r0.as_ptr().add(2), r0.len() == 8, p[1] == r1.as_ptr().add(2), r1.len() == 8, p[2] == r2.as_ptr().add(2), r2.len() == 8, p[3] == r3.as_ptr().add(2), r3.len() == 8, p[4] == r4.as_ptr().add(2), r4.len() == 8, filter.len() == 6, clip.len() == 6, is_near_vb <= 1])]
fn ff_alf_filter_chroma_kernel_10_neon(dst: &mut [u16], p: &[usize], filter: &[i16], clip: &[i16], is_near_vb: usize, r0: &[u16], r1: &[u16], r2: &[u16], r3: &[u16], r4: &[u16]);

#[bums::check_mem_safe("alf.S", dst.as_mut_ptr(), p.as_ptr(), filter.as_ptr(), clip.as_ptr(), is_near_vb,
    [dst.len() == 8, p.len() == 7, p[0] == r0.as_ptr().add(3), r0.len() == 14, p[1] == r1.as_ptr().add(3), r1.len() == 14, p[2] == r2.as_ptr().add(3), r2.len() == 14, p[3] == r3.as_ptr().add(3), r3.len() == 14, p[4] == r4.as_ptr().add(3), r4.len() == 14, p[5] == r5.as_ptr().add(3), r5.len() == 14, p[6] == r6.as_ptr().add(3), r6.len() == 14, filter.len() == 24, clip.len() == 24, is_near_vb <= 1])]
fn ff_alf_filter_luma_kernel_12_neon(dst: &mut [u16], p: &[usize], filter: &[i16], clip: &[i16], is_near_vb: usize, r0: &[u16], r1: &[u16], r2: &[u16], r3: &[u16], r4: &[u16], r5: &[u16], r6: &[u16]);

#[bums::check_mem_safe("alf.S", dst.as_mut_ptr(), p.as_ptr(), filter.as_ptr(), clip.as_ptr(), is_near_vb,
    [dst.len() == 4, p.len() == 5, p[0] == r0.as_ptr().add(2), r0.len() == 8, p[1] == r1.as_ptr().add(2), r1.len() == 8, p[2] == r2.as_ptr().add(2), r2.len() == 8, p[3] == r3.as_ptr().add(2), r3.len() == 8, p[4] == r4.as_ptr().add(2), r4.len() == 8, filter.len() == 6, clip.len() == 6, is_near_vb <= 1])]
fn ff_alf_filter_chroma_kernel_12_neon(dst: &mut [u16], p: &[usize], filter: &[i16], clip: &[i16], is_near_vb: usize, r0: &[u16], r1: &[u16], r2: &[u16], r3: &[u16], r4: &[u16]);

#[bums::check_mem_safe("alf.S", sum0.as_mut_ptr(), sum1.as_mut_ptr(), grad.as_ptr(), gshift, steps,
    [sum0.len() == 4, sum1.len() == 4, grad.len() == (steps - 1) * (16 + gshift) + 24, gshift <= 1024, steps >= 3, steps <= 4])]
fn ff_alf_classify_sum_neon(sum0: &mut [i32], sum1: &mut [i32], grad: &[i16], gshift: usize, steps: usize);


#[bums::check_mem_safe("alf.S", class_idx.as_mut_ptr(), transpose_idx.as_mut_ptr(), src.as_ptr().add(3 * stride + 4), stride, width, height, vb_pos, gradient_tmp.as_mut_ptr(),
    [class_idx.len() == 1, transpose_idx.len() == 1, src.len() == (height + 5) * stride + width + 12, gradient_tmp.len() == 34848,
     width % 4 == 0, width >= 4, width <= 128, height % 4 == 0, height >= 4, height <= 128,
     stride >= width + 12, stride <= 1048576, vb_pos <= 128])]
fn ff_alf_classify_grad_8_neon(class_idx: &mut [i32], transpose_idx: &mut [i32], src: &[u8], stride: usize, width: usize, height: usize, vb_pos: usize, gradient_tmp: &mut [i16]);

#[bums::check_mem_safe("alf.S", class_idx.as_mut_ptr(), transpose_idx.as_mut_ptr(), src.as_ptr().add(3 * stride + 8), stride, width, height, vb_pos, gradient_tmp.as_mut_ptr(),
    [class_idx.len() == 1, transpose_idx.len() == 1, src.len() == (height + 5) * stride + 2 * width + 24, gradient_tmp.len() == 34848,
     width % 4 == 0, width >= 4, width <= 128, height % 4 == 0, height >= 4, height <= 128,
     stride >= 2 * width + 24, stride <= 1048576, stride % 2 == 0, vb_pos <= 128])]
fn ff_alf_classify_grad_10_neon(class_idx: &mut [i32], transpose_idx: &mut [i32], src: &[u8], stride: usize, width: usize, height: usize, vb_pos: usize, gradient_tmp: &mut [i16]);

#[bums::check_mem_safe("alf.S", class_idx.as_mut_ptr(), transpose_idx.as_mut_ptr(), src.as_ptr().add(3 * stride + 8), stride, width, height, vb_pos, gradient_tmp.as_mut_ptr(),
    [class_idx.len() == 1, transpose_idx.len() == 1, src.len() == (height + 5) * stride + 2 * width + 24, gradient_tmp.len() == 34848,
     width % 4 == 0, width >= 4, width <= 128, height % 4 == 0, height >= 4, height <= 128,
     stride >= 2 * width + 24, stride <= 1048576, stride % 2 == 0, vb_pos <= 128])]
fn ff_alf_classify_grad_12_neon(class_idx: &mut [i32], transpose_idx: &mut [i32], src: &[u8], stride: usize, width: usize, height: usize, vb_pos: usize, gradient_tmp: &mut [i16]);
