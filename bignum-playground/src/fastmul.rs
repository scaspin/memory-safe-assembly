#[bums_macros::check_mem_safe("bignum_emontredc_8n.S", m.len(), z.as_mut_ptr(), m.as_ptr(), w, [z.len() == 2 * m.len(), m.len() % 8 == 0])]
fn bignum_emontredc_8n(z: &mut [u64], m: &[u64], w: u64) -> u64;

#[bums_macros::check_mem_safe("bignum_kmul_16_32.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr(), t.as_mut_ptr())]
fn bignum_kmul_16_32(z: &mut [u64; 32], x: &[u64; 16], y: &[u64; 16], t: &mut [u64; 32]);

#[bums_macros::check_mem_safe("bignum_kmul_32_64.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr(), t.as_mut_ptr())]
fn bignum_kmul_32_64(z: &mut [u64; 64], x: &[u64; 32], y: &[u64; 32], t: &mut [u64; 96]);

#[bums_macros::check_mem_safe("bignum_ksqr_16_32.S", z.as_mut_ptr(), x.as_ptr(), t.as_mut_ptr())]
fn bignum_ksqr_16_32(z: &mut [u64; 32], x: &[u64; 16], t: &mut [u64; 24]);

#[bums_macros::check_mem_safe("bignum_ksqr_32_64.S", z.as_mut_ptr(), x.as_ptr(), t.as_mut_ptr())]
fn bignum_ksqr_32_64(z: &mut [u64; 64], x: &[u64; 32], t: &mut [u64; 72]);
