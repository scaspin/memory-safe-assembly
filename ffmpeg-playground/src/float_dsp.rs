use bums_macros as bums;

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src0.as_ptr(), src1.as_ptr(), len,
    [dst.len() == len, src0.len() == len, src1.len() == len, len % 16 == 0, len >= 16, len <= 1048576])]
fn ff_vector_fmul_neon(dst: &mut [f32], src0: &[f32], src1: &[f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len, len % 16 == 0, len >= 16, len <= 1048576])]
fn ff_vector_fmac_scalar_neon(dst: &mut [f32], src: &[f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len, len % 16 == 0, len >= 16, len <= 1048576])]
fn ff_vector_fmul_scalar_neon(dst: &mut [f32], src: &[f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len, len % 8 == 0, len >= 8, len <= 1048576])]
fn ff_vector_dmul_scalar_neon(dst: &mut [f64], src: &[f64], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src0.as_ptr(), src1.as_ptr(), win.as_ptr(), len,
    [dst.len() == 2 * len, src0.len() == len, src1.len() == len, win.len() == 2 * len, len % 4 == 0, len >= 4, len <= 1048576])]
fn ff_vector_fmul_window_neon(dst: &mut [f32], src0: &[f32], src1: &[f32], win: &[f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src0.as_ptr(), src1.as_ptr(), src2.as_ptr(), len,
    [dst.len() == len, src0.len() == len, src1.len() == len, src2.len() == len, len % 16 == 0, len >= 16, len <= 1048576])]
fn ff_vector_fmul_add_neon(dst: &mut [f32], src0: &[f32], src1: &[f32], src2: &[f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", dst.as_mut_ptr(), src0.as_ptr(), src1.as_ptr(), len,
    [dst.len() == len, src0.len() == len, src1.len() == len, len % 16 == 0, len >= 16, len <= 1048576])]
fn ff_vector_fmul_reverse_neon(dst: &mut [f32], src0: &[f32], src1: &[f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", v1.as_mut_ptr(), v2.as_mut_ptr(), len,
    [v1.len() == len, v2.len() == len, len % 4 == 0, len >= 4, len <= 1048576])]
fn ff_butterflies_float_neon(v1: &mut [f32], v2: &mut [f32], len: usize);

#[bums::check_mem_safe("float_dsp_neon.S", v1.as_ptr(), v2.as_ptr(), len,
    [v1.len() == len, v2.len() == len, len % 4 == 0, len >= 4, len <= 1048576])]
fn ff_scalarproduct_float_neon(v1: &[f32], v2: &[f32], len: usize);
