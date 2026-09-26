#[bums_macros::check_mem_safe("bignum_add_p384.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_add_p384(z: &mut [u64; 6], x: &[u64; 6], y: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_deamont_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_deamont_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_deamont_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_deamont_p384_alt(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_littleendian_6.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_littleendian_6(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_littleendian_6.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_fromlebytes_6(z: &mut [u64; 6], x: &[u8; 48]);

#[bums_macros::check_mem_safe("bignum_littleendian_6.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_tolebytes_6(z: &mut [u8; 48], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montinv_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_montinv_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montmul_p384.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_montmul_p384(z: &mut [u64; 6], x: &[u64; 6], y: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montmul_p384_alt.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_montmul_p384_alt(z: &mut [u64; 6], x: &[u64; 6], y: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montsqr_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_montsqr_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montsqr_p384_alt.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_montsqr_p384_alt(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_neg_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_neg_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_nonzero_6.S", x.as_ptr())]
fn bignum_nonzero_6(x: &[u64; 6]) -> u64;

#[bums_macros::check_mem_safe("bignum_sub_p384.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_sub_p384(z: &mut [u64; 6], x: &[u64; 6], y: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_tomont_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_tomont_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_tomont_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_tomont_p384_alt(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("p384_montjdouble.S", p3.as_mut_ptr(), p1.as_ptr())]
fn p384_montjdouble(p3: &mut [u64; 18], p1: &[u64; 18]);

#[bums_macros::check_mem_safe("p384_montjdouble_alt.S", p3.as_mut_ptr(), p1.as_ptr())]
fn p384_montjdouble_alt(p3: &mut [u64; 18], p1: &[u64; 18]);

#[bums_macros::check_mem_safe("p384_montjscalarmul.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p384_montjscalarmul(res: &mut [u64; 18], scalar: &[u64; 6], point: &[u64; 18]);

#[bums_macros::check_mem_safe("p384_montjscalarmul_alt.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p384_montjscalarmul_alt(res: &mut [u64; 18], scalar: &[u64; 6], point: &[u64; 18]);
