#[bums_macros::check_mem_safe("ntt_aarch64_asm.S", r.as_mut_ptr(), zetas_l123456.as_ptr(), zetas_l78.as_ptr())]
fn mldsa_ntt_aarch64_asm(r: &mut [i32; 256], zetas_l123456: &[i32; 144], zetas_l78: &[i32; 384]);

#[bums_macros::check_mem_safe("intt_aarch64_asm.S", r.as_mut_ptr(), zetas_l78.as_ptr(), zetas_l123456.as_ptr())]
fn mldsa_intt_aarch64_asm(r: &mut [i32; 256], zetas_l78: &[i32; 384], zetas_l123456: &[i32; 160]);

#[bums_macros::check_mem_safe("rej_uniform_aarch64_asm.S", r.as_mut_ptr(), buf.as_ptr(), buf.len(), table.as_ptr(), [buf.len() % 24 == 0, buf.len() <= 4294967295])]
fn mldsa_rej_uniform_aarch64_asm(r: &mut [i32; 256], buf: &[u8], table: &[u8; 256]) -> u64;

#[bums_macros::check_mem_safe("rej_uniform_eta2_aarch64_asm.S", r.as_mut_ptr(), buf.as_ptr(), buf.len(), table.as_ptr(), [buf.len() % 8 == 0, buf.len() >= 8, buf.len() <= 4294967295])]
fn mldsa_rej_uniform_eta2_aarch64_asm(r: &mut [i32; 256], buf: &[u8], table: &[u8; 4096]) -> u64;

#[bums_macros::check_mem_safe("rej_uniform_eta4_aarch64_asm.S", r.as_mut_ptr(), buf.as_ptr(), buf.len(), table.as_ptr(), [buf.len() % 8 == 0, buf.len() >= 8, buf.len() <= 4294967295])]
fn mldsa_rej_uniform_eta4_aarch64_asm(r: &mut [i32; 256], buf: &[u8], table: &[u8; 4096]) -> u64;

#[bums_macros::check_mem_safe("poly_decompose_32_aarch64_asm.S", a1.as_mut_ptr(), a0.as_mut_ptr())]
fn mldsa_poly_decompose_32_aarch64_asm(a1: &mut [i32; 256], a0: &mut [i32; 256]);

#[bums_macros::check_mem_safe("poly_decompose_88_aarch64_asm.S", a1.as_mut_ptr(), a0.as_mut_ptr())]
fn mldsa_poly_decompose_88_aarch64_asm(a1: &mut [i32; 256], a0: &mut [i32; 256]);

#[bums_macros::check_mem_safe("poly_caddq_aarch64_asm.S", a.as_mut_ptr())]
fn mldsa_poly_caddq_aarch64_asm(a: &mut [i32; 256]);

#[bums_macros::check_mem_safe("poly_use_hint_32_aarch64_asm.S", a.as_mut_ptr(), h.as_ptr())]
fn mldsa_poly_use_hint_32_aarch64_asm(a: &mut [i32; 256], h: &[i32; 256]);

#[bums_macros::check_mem_safe("poly_use_hint_88_aarch64_asm.S", a.as_mut_ptr(), h.as_ptr())]
fn mldsa_poly_use_hint_88_aarch64_asm(a: &mut [i32; 256], h: &[i32; 256]);

#[bums_macros::check_mem_safe("poly_chknorm_aarch64_asm.S", a.as_ptr(), bound)]
fn mldsa_poly_chknorm_aarch64_asm(a: &[i32; 256], bound: i32) -> i32;

#[bums_macros::check_mem_safe("polyz_unpack_17_aarch64_asm.S", r.as_mut_ptr(), buf.as_ptr(), indices.as_ptr())]
fn mldsa_polyz_unpack_17_aarch64_asm(r: &mut [i32; 256], buf: &[u8; 576], indices: &[u8; 64]);

#[bums_macros::check_mem_safe("polyz_unpack_19_aarch64_asm.S", r.as_mut_ptr(), buf.as_ptr(), indices.as_ptr())]
fn mldsa_polyz_unpack_19_aarch64_asm(r: &mut [i32; 256], buf: &[u8; 640], indices: &[u8; 64]);

#[bums_macros::check_mem_safe("pointwise_montgomery_aarch64_asm.S", a.as_mut_ptr(), b.as_ptr())]
fn mldsa_poly_pointwise_montgomery_aarch64_asm(a: &mut [i32; 256], b: &[i32; 256]);

#[bums_macros::check_mem_safe("mld_polyvecl_pointwise_acc_montgomery_l4_aarch64_asm.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn mldsa_polyvecl_pointwise_acc_montgomery_l4_aarch64_asm(
    r: &mut [i32; 256],
    a: &[i32; 1024],
    b: &[i32; 1024],
);

#[bums_macros::check_mem_safe("mld_polyvecl_pointwise_acc_montgomery_l5_aarch64_asm.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn mldsa_polyvecl_pointwise_acc_montgomery_l5_aarch64_asm(
    r: &mut [i32; 256],
    a: &[i32; 1280],
    b: &[i32; 1280],
);

#[bums_macros::check_mem_safe("mld_polyvecl_pointwise_acc_montgomery_l7_aarch64_asm.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn mldsa_polyvecl_pointwise_acc_montgomery_l7_aarch64_asm(
    r: &mut [i32; 256],
    a: &[i32; 1792],
    b: &[i32; 1792],
);
