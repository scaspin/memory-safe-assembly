#[bums_macros::check_mem_safe("bignum_copy_row_from_table.S", z.as_mut_ptr(), table.as_ptr(), height, z.len(), idx, [table.len() == height * z.len()])]
fn bignum_copy_row_from_table(z: &mut [u64], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_copy_row_from_table_16.S", z.as_mut_ptr(), table.as_ptr(), height, idx, [height >= 1, table.len() == height * 16])]
fn bignum_copy_row_from_table_16(z: &mut [u64; 16], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_copy_row_from_table_32.S", z.as_mut_ptr(), table.as_ptr(), height, idx, [height >= 1, table.len() == height * 32])]
fn bignum_copy_row_from_table_32(z: &mut [u64; 32], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_copy_row_from_table_8n.S", z.as_mut_ptr(), table.as_ptr(), height, z.len(), idx, [table.len() == height * z.len(), z.len() % 8 == 0])]
fn bignum_copy_row_from_table_8n(z: &mut [u64], table: &[u64], height: u64, idx: u64);

#[bums_macros::check_mem_safe("bignum_ge.S", x.len(), x.as_ptr(), y.len(), y.as_ptr())]
fn bignum_ge(x: &[u64], y: &[u64]) -> u64;

#[bums_macros::check_mem_safe("bignum_mul.S", z.len(), z.as_mut_ptr(), x.len(), x.as_ptr(), y.len(), y.as_ptr())]
fn bignum_mul(z: &mut [u64], x: &[u64], y: &[u64]);

#[bums_macros::check_mem_safe("bignum_optsub.S", z.len(), z.as_mut_ptr(), x.as_ptr(), p, y.as_ptr(), [x.len() == z.len(), y.len() == z.len()])]
fn bignum_optsub(z: &mut [u64], x: &[u64], p: u64, y: &[u64]) -> u64;

#[bums_macros::check_mem_safe("bignum_sqr.S", z.len(), z.as_mut_ptr(), x.len(), x.as_ptr())]
fn bignum_sqr(z: &mut [u64], x: &[u64]);
