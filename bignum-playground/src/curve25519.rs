#[bums_macros::check_mem_safe("bignum_madd_n25519.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr(), c.as_ptr())]
fn bignum_madd_n25519(z: &mut [u64; 4], x: &[u64; 4], y: &[u64; 4], c: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_madd_n25519_alt.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr(), c.as_ptr())]
fn bignum_madd_n25519_alt(z: &mut [u64; 4], x: &[u64; 4], y: &[u64; 4], c: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_mod_n25519.S", z.as_mut_ptr(), x.len(), x.as_ptr())]
fn bignum_mod_n25519(z: &mut [u64; 4], x: &[u64]);

#[bums_macros::check_mem_safe("bignum_neg_p25519.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_neg_p25519(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("curve25519_x25519_byte.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn curve25519_x25519_byte(res: &mut [u8; 32], scalar: &[u8; 32], point: &[u8; 32]);

#[bums_macros::check_mem_safe("curve25519_x25519_byte_alt.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn curve25519_x25519_byte_alt(res: &mut [u8; 32], scalar: &[u8; 32], point: &[u8; 32]);

#[bums_macros::check_mem_safe("curve25519_x25519base_byte.S", res.as_mut_ptr(), scalar.as_ptr())]
fn curve25519_x25519base_byte(res: &mut [u8; 32], scalar: &[u8; 32]);

#[bums_macros::check_mem_safe("curve25519_x25519base_byte_alt.S", res.as_mut_ptr(), scalar.as_ptr())]
fn curve25519_x25519base_byte_alt(res: &mut [u8; 32], scalar: &[u8; 32]);

#[bums_macros::check_mem_safe("edwards25519_decode.S", z.as_mut_ptr(), c.as_ptr())]
fn edwards25519_decode(z: &mut [u64; 8], c: &[u8; 32]) -> u64;

#[bums_macros::check_mem_safe("edwards25519_decode_alt.S", z.as_mut_ptr(), c.as_ptr())]
fn edwards25519_decode_alt(z: &mut [u64; 8], c: &[u8; 32]) -> u64;

#[bums_macros::check_mem_safe("edwards25519_encode.S", z.as_mut_ptr(), p.as_ptr())]
fn edwards25519_encode(z: &mut [u8; 32], p: &[u64; 8]);

#[bums_macros::check_mem_safe("edwards25519_scalarmulbase.S", res.as_mut_ptr(), scalar.as_ptr())]
fn edwards25519_scalarmulbase(res: &mut [u64; 8], scalar: &[u64; 4]);

#[bums_macros::check_mem_safe("edwards25519_scalarmulbase_alt.S", res.as_mut_ptr(), scalar.as_ptr())]
fn edwards25519_scalarmulbase_alt(res: &mut [u64; 8], scalar: &[u64; 4]);

#[bums_macros::check_mem_safe("edwards25519_scalarmuldouble.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr(), bscalar.as_ptr())]
fn edwards25519_scalarmuldouble(
    res: &mut [u64; 8],
    scalar: &[u64; 4],
    point: &[u64; 8],
    bscalar: &[u64; 4],
);

#[bums_macros::check_mem_safe("edwards25519_scalarmuldouble_alt.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr(), bscalar.as_ptr())]
fn edwards25519_scalarmuldouble_alt(
    res: &mut [u64; 8],
    scalar: &[u64; 4],
    point: &[u64; 8],
    bscalar: &[u64; 4],
);
