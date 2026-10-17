use bums_macros as bums;

#[bums::check_mem_safe("aacencdsp_neon.S", out.as_mut_ptr(), input.as_ptr(), size,
    [out.len() == size, input.len() == size, size % 4 == 0, size >= 4, size <= 1048576])]
fn ff_abs_pow34_neon(out: &mut [f32], input: &[f32], size: usize);

#[bums::check_mem_safe("aacencdsp_neon.S", out.as_mut_ptr(), input.as_ptr(), scaled.as_ptr(), size, is_signed, maxval,
    [out.len() == size, input.len() == size, scaled.len() == size, size % 4 == 0, size >= 4, size <= 1048576, is_signed <= 1])]
fn ff_aac_quant_bands_neon(out: &mut [i32], input: &[f32], scaled: &[f32], size: usize, is_signed: usize, maxval: i32);

#[bums::check_mem_safe("aacpsdsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), n,
    [dst.len() == n, src.len() == 2 * n, n % 4 == 0, n >= 4, n <= 1048576])]
fn ff_ps_add_squares_neon(dst: &mut [f32], src: &[f32], n: usize);

#[bums::check_mem_safe("aacpsdsp_neon.S", dst.as_mut_ptr(), src0.as_ptr(), src1.as_ptr(), n,
    [dst.len() == 2 * n, src0.len() == 2 * n, src1.len() == n, n % 4 == 0, n >= 4, n <= 1048576])]
fn ff_ps_mul_pair_single_neon(dst: &mut [f32], src0: &[f32], src1: &[f32], n: usize);

#[bums::check_mem_safe("aacpsdsp_neon.S", out.as_mut_ptr(), input.as_ptr(), filter.as_ptr(), stride, n,
    [out.len() == 2 * (stride * (n - 1) + 1), input.len() == 26, filter.len() == 16 * n, n >= 1, n <= 64, stride >= 1, stride <= 65536])]
fn ff_ps_hybrid_analysis_neon(out: &mut [f32], input: &[f32], filter: &[f32], stride: usize, n: usize);

#[bums::check_mem_safe("aacpsdsp_neon.S", l.as_mut_ptr(), r.as_mut_ptr(), h.as_ptr(), h_step.as_ptr(), len,
    [l.len() == 2 * len, r.len() == 2 * len, h.len() == 8, h_step.len() == 8, len >= 1, len <= 1048576])]
fn ff_ps_stereo_interpolate_neon(l: &mut [f32], r: &mut [f32], h: &[f32], h_step: &[f32], len: usize);

#[bums::check_mem_safe("aacpsdsp_neon.S", l.as_mut_ptr(), r.as_mut_ptr(), h.as_ptr(), h_step.as_ptr(), len,
    [l.len() == 2 * len, r.len() == 2 * len, h.len() == 8, h_step.len() == 8, len >= 1, len <= 1048576])]
fn ff_ps_stereo_interpolate_ipdopd_neon(l: &mut [f32], r: &mut [f32], h: &[f32], h_step: &[f32], len: usize);

#[bums::check_mem_safe("ac3dsp_neon.S", exp.as_mut_ptr(), num_reuse_blocks, nb_coefs,
    [exp.len() == 256 * (num_reuse_blocks + 1), num_reuse_blocks <= 5, nb_coefs >= 1, nb_coefs <= 256])]
fn ff_ac3_exponent_min_neon(exp: &mut [u8], num_reuse_blocks: usize, nb_coefs: usize);

#[bums::check_mem_safe("ac3dsp_neon.S", exp.as_mut_ptr(), coef.as_ptr(), nb_coefs,
    [exp.len() == nb_coefs, coef.len() == nb_coefs, nb_coefs % 4 == 0, nb_coefs >= 4, nb_coefs <= 1048576])]
fn ff_ac3_extract_exponents_neon(exp: &mut [u8], coef: &[i32], nb_coefs: usize);

#[bums::check_mem_safe("ac3dsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len, src.len() == len, len % 32 == 0, len >= 32, len <= 1048576])]
fn ff_float_to_fixed24_neon(dst: &mut [i32], src: &[f32], len: usize);

#[bums::check_mem_safe("ac3dsp_neon.S", sum.as_mut_ptr(), coef0.as_ptr(), coef1.as_ptr(), len,
    [sum.len() == 4, coef0.len() == len, coef1.len() == len, len % 2 == 0, len >= 2, len <= 1048576])]
fn ff_ac3_sum_square_butterfly_int32_neon(sum: &mut [i64], coef0: &[i32], coef1: &[i32], len: usize);

#[bums::check_mem_safe("ac3dsp_neon.S", sum.as_mut_ptr(), coef0.as_ptr(), coef1.as_ptr(), len,
    [sum.len() == 4, coef0.len() == len, coef1.len() == len, len % 4 == 0, len >= 4, len <= 1048576])]
fn ff_ac3_sum_square_butterfly_float_neon(sum: &mut [f32], coef0: &[f32], coef1: &[f32], len: usize);

#[bums::check_mem_safe("dcadsp_neon.S", pcm.as_mut_ptr(), lfe.as_ptr().add(7), filter.as_ptr(), npcmblocks,
    [pcm.len() == npcmblocks / 2 * 64, lfe.len() == npcmblocks / 2 + 7, filter.len() == 256, npcmblocks >= 2, npcmblocks <= 4096])]
fn ff_lfe_fir0_float_neon(pcm: &mut [f32], lfe: &[i32], filter: &[f32], npcmblocks: usize);

#[bums::check_mem_safe("dcadsp_neon.S", pcm.as_mut_ptr(), lfe.as_ptr().add(3), filter.as_ptr(), npcmblocks,
    [pcm.len() == npcmblocks / 4 * 128, lfe.len() == npcmblocks / 4 + 3, filter.len() == 256, npcmblocks >= 4, npcmblocks <= 4096])]
fn ff_lfe_fir1_float_neon(pcm: &mut [f32], lfe: &[i32], filter: &[f32], npcmblocks: usize);

#[bums::check_mem_safe("dcadsp_neon.S", dst.as_mut_ptr(), src.as_ptr(), hist.as_mut_ptr(), len,
    [dst.len() == 2 * len, src.len() == len, hist.len() == 1, len % 4 == 0, len >= 4, len <= 1048576])]
fn ff_lfe_x96_fixed_neon(dst: &mut [i32], src: &[i32], hist: &mut [i32], len: usize);

#[bums::check_mem_safe("opusdsp_neon.S", data.as_mut_ptr().add(period + 2), period, gains.as_ptr(), len,
    [data.len() == period + 2 + len, gains.len() == 3, period >= 15, period <= 1024, len % 4 == 0, len >= 4, len <= 1048576])]
fn ff_opus_postfilter_neon(data: &mut [f32], period: usize, gains: &[f32], len: usize);

#[bums::check_mem_safe("opusdsp_neon.S", out.as_mut_ptr(), input.as_ptr(), weights.as_ptr(), len,
    [out.len() == len, input.len() == len, weights.len() == 16, len % 8 == 0, len >= 8, len <= 1048576])]
fn ff_opus_deemphasis_neon(out: &mut [f32], input: &[f32], weights: &[f32], len: usize);

#[bums::check_mem_safe("vorbisdsp_neon.S", mag.as_mut_ptr(), ang.as_mut_ptr(), blocksize,
    [mag.len() == blocksize, ang.len() == blocksize, blocksize % 4 == 0, blocksize >= 4, blocksize <= 4096])]
fn ff_vorbis_inverse_coupling_neon(mag: &mut [f32], ang: &mut [f32], blocksize: usize);

#[bums::check_mem_safe("mpegaudiodsp_neon.S", synth_buf.as_mut_ptr(), window.as_ptr(), dither.as_mut_ptr(), samples.as_mut_ptr(), incr,
    [synth_buf.len() == 544, window.len() == 768, dither.len() == 1, samples.len() == 31 * incr + 1, incr >= 1, incr <= 64])]
fn ff_mpadsp_apply_window_fixed_neon(synth_buf: &mut [i32], window: &[i32], dither: &mut [i32], samples: &mut [i16], incr: usize);

#[bums::check_mem_safe("mpegaudiodsp_neon.S", synth_buf.as_mut_ptr(), window.as_ptr(), dither.as_mut_ptr(), samples.as_mut_ptr(), incr,
    [synth_buf.len() == 544, window.len() == 768, dither.len() == 1, samples.len() == 31 * incr + 1, incr >= 1, incr <= 64])]
fn ff_mpadsp_apply_window_float_neon(synth_buf: &mut [f32], window: &[f32], dither: &mut [i32], samples: &mut [f32], incr: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", z.as_mut_ptr(), [z.len() == 320])]
fn ff_sbr_sum64x5_neon(z: &mut [f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", x.as_ptr(), n,
    [x.len() == 2 * n, n % 2 == 0, n >= 2, n <= 4096])]
fn ff_sbr_sum_square_neon(x: &[f32], n: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", x.as_mut_ptr(), [x.len() == 64])]
fn ff_sbr_neg_odd_64_neon(x: &mut [f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", z.as_mut_ptr(), [z.len() == 128])]
fn ff_sbr_qmf_pre_shuffle_neon(z: &mut [f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", w.as_mut_ptr(), z.as_ptr(), [w.len() == 64, z.len() == 64])]
fn ff_sbr_qmf_post_shuffle_neon(w: &mut [f32], z: &[f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", v.as_mut_ptr(), src.as_ptr(), [v.len() == 64, src.len() == 64])]
fn ff_sbr_qmf_deint_neg_neon(v: &mut [f32], src: &[f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", v.as_mut_ptr(), src0.as_ptr(), src1.as_ptr(),
    [v.len() == 128, src0.len() == 64, src1.len() == 64])]
fn ff_sbr_qmf_deint_bfly_neon(v: &mut [f32], src0: &[f32], src1: &[f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", x_high.as_mut_ptr(), x_low.as_ptr().add(4), alpha0.as_ptr(), alpha1.as_ptr(), start, end,
    [x_high.len() == 2 * end, x_low.len() == 2 * end + 4, alpha0.len() == 2, alpha1.len() == 2, start < end, end <= 38])]
fn ff_sbr_hf_gen_neon(x_high: &mut [f32], x_low: &[f32], alpha0: &[f32], alpha1: &[f32], start: usize, end: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", y.as_mut_ptr(), x_high.as_ptr(), g_filt.as_ptr(), m_max, ixh,
    [y.len() == 2 * m_max, x_high.len() == 80 * m_max, g_filt.len() == m_max, m_max >= 1, m_max <= 64, ixh < 40])]
fn ff_sbr_hf_g_filt_neon(y: &mut [f32], x_high: &[f32], g_filt: &[f32], m_max: usize, ixh: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", x.as_ptr(), phi.as_mut_ptr(), [x.len() == 80, phi.len() == 12])]
fn ff_sbr_autocorrelate_neon(x: &[f32], phi: &mut [f32]);

#[bums::check_mem_safe("sbrdsp_neon.S", row.as_mut_ptr().add(2 * kx), s_m.as_ptr(), q_filt.as_ptr(), noise, kx, m_max,
    [row.len() == 128, s_m.len() == 48, q_filt.len() == 48, noise <= 511, kx + m_max <= 64, m_max >= 1, m_max <= 48])]
fn ff_sbr_hf_apply_noise_0_neon(row: &mut [f32], s_m: &[f32], q_filt: &[f32], noise: usize, kx: usize, m_max: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", row.as_mut_ptr().add(2 * kx), s_m.as_ptr(), q_filt.as_ptr(), noise, kx, m_max,
    [row.len() == 128, s_m.len() == 48, q_filt.len() == 48, noise <= 511, kx + m_max <= 64, m_max >= 1, m_max <= 48])]
fn ff_sbr_hf_apply_noise_1_neon(row: &mut [f32], s_m: &[f32], q_filt: &[f32], noise: usize, kx: usize, m_max: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", row.as_mut_ptr().add(2 * kx), s_m.as_ptr(), q_filt.as_ptr(), noise, kx, m_max,
    [row.len() == 128, s_m.len() == 48, q_filt.len() == 48, noise <= 511, kx + m_max <= 64, m_max >= 1, m_max <= 48])]
fn ff_sbr_hf_apply_noise_2_neon(row: &mut [f32], s_m: &[f32], q_filt: &[f32], noise: usize, kx: usize, m_max: usize);

#[bums::check_mem_safe("sbrdsp_neon.S", row.as_mut_ptr().add(2 * kx), s_m.as_ptr(), q_filt.as_ptr(), noise, kx, m_max,
    [row.len() == 128, s_m.len() == 48, q_filt.len() == 48, noise <= 511, kx + m_max <= 64, m_max >= 1, m_max <= 48])]
fn ff_sbr_hf_apply_noise_3_neon(row: &mut [f32], s_m: &[f32], q_filt: &[f32], noise: usize, kx: usize, m_max: usize);
