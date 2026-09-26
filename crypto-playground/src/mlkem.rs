#[bums_macros::check_mem_safe("ntt.S", p.as_mut_ptr(), twiddles12345.as_ptr(), twiddles56.as_ptr())]
fn mlkem_ntt_asm(p: &mut [i16; 256], twiddles12345: &[i16; 80], twiddles56: &[i16; 384]);

#[bums_macros::check_mem_safe("intt.S", p.as_mut_ptr(), twiddles12345.as_ptr(), twiddles56.as_ptr())]
fn mlkem_intt_asm(p: &mut [i16; 256], twiddles12345: &[i16; 80], twiddles56: &[i16; 384]);

#[bums_macros::check_mem_safe("poly_mulcache_compute_asm.S", cache.as_mut_ptr(), poly.as_ptr(), zetas.as_ptr(), zetas_twisted.as_ptr())]
fn mlkem_poly_mulcache_compute_asm(
    cache: &mut [i16; 128],
    poly: &[i16; 256],
    zetas: &[i16; 128],
    zetas_twisted: &[i16; 128],
);

#[bums_macros::check_mem_safe("poly_reduce_asm.S", p.as_mut_ptr())]
fn mlkem_poly_reduce_asm(p: &mut [i16; 256]);

#[bums_macros::check_mem_safe("poly_tobytes_asm.S", r.as_mut_ptr(), a.as_ptr())]
fn mlkem_poly_tobytes_asm(r: &mut [u8; 384], a: &[i16; 256]);

#[bums_macros::check_mem_safe("poly_tomont_asm.S", p.as_mut_ptr())]
fn mlkem_poly_tomont_asm(p: &mut [i16; 256]);

#[bums_macros::check_mem_safe("polyvec_basemul_acc_montgomery_cached_asm_k2.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr(), b_cache.as_ptr())]
fn mlkem_polyvec_basemul_acc_montgomery_cached_asm_k2(
    r: &mut [i16; 256],
    a: &[i16; 512],
    b: &[i16; 512],
    b_cache: &[i16; 256],
);

#[bums_macros::check_mem_safe("polyvec_basemul_acc_montgomery_cached_asm_k3.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr(), b_cache.as_ptr())]
fn mlkem_polyvec_basemul_acc_montgomery_cached_asm_k3(
    r: &mut [i16; 256],
    a: &[i16; 768],
    b: &[i16; 768],
    b_cache: &[i16; 384],
);

#[bums_macros::check_mem_safe("polyvec_basemul_acc_montgomery_cached_asm_k4.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr(), b_cache.as_ptr())]
fn mlkem_polyvec_basemul_acc_montgomery_cached_asm_k4(
    r: &mut [i16; 256],
    a: &[i16; 1024],
    b: &[i16; 1024],
    b_cache: &[i16; 512],
);

#[bums_macros::check_mem_safe("rej_uniform_asm.S", r.as_mut_ptr(), buf.as_ptr(), buf.len(), table.as_ptr(), [buf.len() % 24 == 0, buf.len() <= 4294967295])]
fn mlkem_rej_uniform_asm(r: &mut [i16; 256], buf: &[u8], table: &[u8; 4096]) -> u64;
