
#[bums_macros::check_mem_safe("ccn_add.S", r.len(), r.as_mut_ptr(), s.as_ptr(), t.as_ptr(), [s.len() == r.len(), t.len() == r.len()])]
fn ccn_add_asm(r: &mut [u64], s: &[u64], t: &[u64]) -> u64;

#[bums_macros::check_mem_safe("ccn_sub.S", r.len(), r.as_mut_ptr(), s.as_ptr(), t.as_ptr(), [s.len() == r.len(), t.len() == r.len()])]
fn ccn_sub_asm(r: &mut [u64], s: &[u64], t: &[u64]) -> u64;

#[bums_macros::check_mem_safe("ccn_add1-arm64.S", r.len(), r.as_mut_ptr(), s.as_ptr(), v, [s.len() == r.len()])]
fn ccn_add1_asm(r: &mut [u64], s: &[u64], v: u64) -> u64;

#[bums_macros::check_mem_safe("ccn_addmul1-arm64.S", r.len(), r.as_mut_ptr(), s.as_ptr(), v, [s.len() == r.len()])]
fn ccn_addmul1_asm(r: &mut [u64], s: &[u64], v: u64) -> u64;

#[bums_macros::check_mem_safe("ccn_mul1-arm64.S", r.len(), r.as_mut_ptr(), s.as_ptr(), v, [s.len() == r.len()])]
fn ccn_mul1_asm(r: &mut [u64], s: &[u64], v: u64) -> u64;

#[bums_macros::check_mem_safe("ccn_cmp-arm64.S", s.len(), s.as_ptr(), t.as_ptr(), [t.len() == s.len()])]
fn ccn_cmp_asm(s: &[u64], t: &[u64]) -> i32;

#[bums_macros::check_mem_safe("ccn_n-arm64.S", s.len(), s.as_ptr())]
fn ccn_n_asm(s: &[u64]) -> usize;

#[bums_macros::check_mem_safe("ccn_shift_left_arm64.S", r.len(), r.as_mut_ptr(), s.as_ptr(), k, [s.len() == r.len(), k < 64])]
fn ccn_shift_left(r: &mut [u64], s: &[u64], k: usize);

#[bums_macros::check_mem_safe("ccn_shift_right.S", r.len(), r.as_mut_ptr(), s.as_ptr(), k, [s.len() == r.len(), k < 64])]
fn ccn_shift_right_asm(r: &mut [u64], s: &[u64], k: usize);

#[bums_macros::check_mem_safe("ccn_mul.S", s.len(), r.as_mut_ptr(), s.as_ptr(), t.as_ptr(), [t.len() == s.len(), r.len() == 2 * s.len()])]
fn ccn_mul(r: &mut [u64], s: &[u64], t: &[u64]);

#[bums_macros::check_mem_safe("ccn_mulmod_p224-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_mulmod_p224(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ccn_mulmod_p256-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_mulmod_p256(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ccn_mulmod_p384-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_mulmod_p384(r: &mut [u64; 6], a: &[u64; 6], b: &[u64; 6]);

#[bums_macros::check_mem_safe("ccn_mulmod_p25519-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_mulmod_p25519(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ccn_mulmod_p25519-arm64.S", r.as_mut_ptr(), a.as_ptr())]
fn ccn_sqrmod_p25519(r: &mut [u64; 4], a: &[u64; 4]);

#[bums_macros::check_mem_safe("ccn_mulmod_p25519-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_addmod_p25519(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ccn_mulmod_p25519-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_submod_p25519(r: &mut [u64; 4], a: &[u64; 4], b: &[u64; 4]);

#[bums_macros::check_mem_safe("ccn_mulmod_p448-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_mulmod_p448(r: &mut [u64; 7], a: &[u64; 7], b: &[u64; 7]);

#[bums_macros::check_mem_safe("ccn_mulmod_p448-arm64.S", r.as_mut_ptr(), a.as_ptr())]
fn ccn_sqrmod_p448(r: &mut [u64; 7], a: &[u64; 7]);

#[bums_macros::check_mem_safe("ccn_mulmod_p448-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_addmod_p448(r: &mut [u64; 7], a: &[u64; 7], b: &[u64; 7]) -> u64;

#[bums_macros::check_mem_safe("ccn_mulmod_p448-arm64.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccn_submod_p448(r: &mut [u64; 7], a: &[u64; 7], b: &[u64; 7]) -> u64;
