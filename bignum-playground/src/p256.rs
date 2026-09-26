#[bums_macros::check_mem_safe("bignum_montinv_p256.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_montinv_p256(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("p256_montjscalarmul.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p256_montjscalarmul(res: &mut [u64; 12], scalar: &[u64; 4], point: &[u64; 12]);

#[bums_macros::check_mem_safe("p256_montjscalarmul_alt.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p256_montjscalarmul_alt(res: &mut [u64; 12], scalar: &[u64; 4], point: &[u64; 12]);
