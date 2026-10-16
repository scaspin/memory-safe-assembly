
#[bums_macros::check_mem_safe("bignum_add_p384.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_add_p384(z: &mut [u64; 6], x: &[u64; 6], y: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montmul_p384.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_montmul_p384(z: &mut [u64; 6], x: &[u64; 6], y: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_montsqr_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_montsqr_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_neg_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_neg_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("bignum_tomont_p384.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_tomont_p384(z: &mut [u64; 6], x: &[u64; 6]);

#[bums_macros::check_mem_safe("p384_montjdouble.S", p3.as_mut_ptr(), p1.as_ptr())]
fn p384_montjdouble(p3: &mut [u64; 18], p1: &[u64; 18]);

#[bums_macros::check_mem_safe("bignum_add_p256.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_add_p256(z: &mut [u64; 4], x: &[u64; 4], y: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_demont_p256.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_demont_p256(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_montmul_p256.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr())]
fn bignum_montmul_p256(z: &mut [u64; 4], x: &[u64; 4], y: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_montsqr_p256.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_montsqr_p256(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_neg_p256.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_neg_p256(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_tomont_p256.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_tomont_p256(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_inv_p256.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_inv_p256(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("p256_montjadd.S", p3.as_mut_ptr(), p1.as_ptr(), p2.as_ptr())]
fn p256_montjadd(p3: &mut [u64; 12], p1: &[u64; 12], p2: &[u64; 12]);

#[bums_macros::check_mem_safe("p256_montjdouble.S", p3.as_mut_ptr(), p1.as_ptr())]
fn p256_montjdouble(p3: &mut [u64; 12], p1: &[u64; 12]);

#[bums_macros::check_mem_safe("p256_montjmixadd.S", p3.as_mut_ptr(), p1.as_ptr(), p2.as_ptr())]
fn p256_montjmixadd(p3: &mut [u64; 12], p1: &[u64; 12], p2: &[u64; 8]);

#[bums_macros::check_mem_safe("bignum_madd_n25519.S", z.as_mut_ptr(), x.as_ptr(), y.as_ptr(), c.as_ptr())]
fn bignum_madd_n25519(z: &mut [u64; 4], x: &[u64; 4], y: &[u64; 4], c: &[u64; 4]);

#[bums_macros::check_mem_safe("bignum_mod_n25519.S", z.as_mut_ptr(), x.len(), x.as_ptr())]
fn bignum_mod_n25519(z: &mut [u64; 4], x: &[u64]);

#[bums_macros::check_mem_safe("bignum_neg_p25519.S", z.as_mut_ptr(), x.as_ptr())]
fn bignum_neg_p25519(z: &mut [u64; 4], x: &[u64; 4]);

#[bums_macros::check_mem_safe("edwards25519_decode.S", z.as_mut_ptr(), c.as_ptr())]
fn edwards25519_decode(z: &mut [u64; 8], c: &[u8; 32]) -> u64;

#[bums_macros::check_mem_safe("edwards25519_scalarmulbase.S", res.as_mut_ptr(), scalar.as_ptr())]
fn edwards25519_scalarmulbase(res: &mut [u64; 8], scalar: &[u64; 4]);

#[bums_macros::check_mem_safe("edwards25519_scalarmuldouble.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr(), bscalar.as_ptr())]
fn edwards25519_scalarmuldouble(
    res: &mut [u64; 8],
    scalar: &[u64; 4],
    point: &[u64; 8],
    bscalar: &[u64; 4],
);

#[bums_macros::check_mem_safe("bignum_mul.S", z.len(), z.as_mut_ptr(), x.len(), x.as_ptr(), y.len(), y.as_ptr())]
fn bignum_mul(z: &mut [u64], x: &[u64], y: &[u64]);

#[bums_macros::check_mem_safe("bignum_optsub.S", z.len(), z.as_mut_ptr(), x.as_ptr(), p, y.as_ptr(), [x.len() == z.len(), y.len() == z.len()])]
fn bignum_optsub(z: &mut [u64], x: &[u64], p: u64, y: &[u64]) -> u64;

#[bums_macros::check_mem_safe("bignum_copy_row_from_table.S", z.as_mut_ptr(), table.as_ptr(), height, z.len(), idx, [table.len() == height as usize * z.len()])]
fn bignum_copy_row_from_table(z: &mut [u64], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_copy_row_from_table_16.S", z.as_mut_ptr(), table.as_ptr(), height, idx, [height >= 1, table.len() == height as usize * 16])]
fn bignum_copy_row_from_table_16(z: &mut [u64; 16], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_copy_row_from_table_32.S", z.as_mut_ptr(), table.as_ptr(), height, idx, [height >= 1, table.len() == height as usize * 32])]
fn bignum_copy_row_from_table_32(z: &mut [u64; 32], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_copy_row_from_table_8n.S", z.as_mut_ptr(), table.as_ptr(), height, z.len(), idx, [table.len() == height as usize * z.len(), z.len() % 8 == 0])]
fn bignum_copy_row_from_table_8n(z: &mut [u64], table: &[u64], height: u64, idx: u64);

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

#[bums_macros::check_mem_safe("sha3_keccak_f1600.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak_f1600(a: &mut [u64; 25], rc: &[u64; 24]);

#[bums_macros::check_mem_safe("sha3_keccak_f1600_alt.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak_f1600_alt(a: &mut [u64; 25], rc: &[u64; 24]);

#[bums_macros::check_mem_safe("sha3_keccak2_f1600.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak2_f1600(a: &mut [u64; 50], rc: &[u64; 24]);
