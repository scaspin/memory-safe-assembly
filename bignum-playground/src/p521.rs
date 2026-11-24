#[bums_macros::check_mem_safe("bignum_add_p521.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_add_p521(z: &mut [u64; 9], x: &[u64; 9], y: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_fromlebytes_p521.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_fromlebytes_p521(z: &mut [u64; 9], x: &[u8; 66]);

#[bums_macros::check_mem_safe("bignum_inv_p521.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_inv_p521(z: &mut [u64; 9], x: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_mul_p521.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_mul_p521(z: &mut [u64; 9], x: &[u64; 9], y: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_mul_p521_alt.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_mul_p521_alt(z: &mut [u64; 9], x: &[u64; 9], y: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_neg_p521.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_neg_p521(z: &mut [u64; 9], x: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_sqr_p521.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_sqr_p521(z: &mut [u64; 9], x: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_sqr_p521_alt.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_sqr_p521_alt(z: &mut [u64; 9], x: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_sub_p521.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_sub_p521(z: &mut [u64; 9], x: &[u64; 9], y: &[u64; 9]);

#[bums_macros::check_mem_safe("bignum_tolebytes_p521.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_tolebytes_p521(z: &mut [u8; 66], x: &[u64; 9]);

#[bums_macros::check_mem_safe("p521_jdouble.S", p3.as_mut_ptr(), p1.as_ptr())]
fn p521_jdouble(p3: &mut [u64; 27], p1: &[u64; 27]);

#[bums_macros::check_mem_safe("p521_jdouble_alt.S", p3.as_mut_ptr(), p1.as_ptr())]
fn p521_jdouble_alt(p3: &mut [u64; 27], p1: &[u64; 27]);

#[bums_macros::check_mem_safe("p521_jscalarmul.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p521_jscalarmul(res: &mut [u64; 27], scalar: &[u64; 9], point: &[u64; 27]);

#[bums_macros::check_mem_safe("p521_jscalarmul_alt.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p521_jscalarmul_alt(res: &mut [u64; 27], scalar: &[u64; 9], point: &[u64; 27]);
