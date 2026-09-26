#[bums_macros::check_mem_safe("sha3_keccak2_f1600.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak2_f1600(a: &mut [u64; 50], rc: &[u64; 24]);

#[bums_macros::check_mem_safe("sha3_keccak4_f1600_alt.S", a.as_mut_ptr(), rc.as_ptr(), rho8.as_ptr(), rho56.as_ptr())]
fn sha3_keccak4_f1600_alt(a: &mut [u64; 100], rc: &[u64; 24], rho8: &[u64; 4], rho56: &[u64; 4]);

#[bums_macros::check_mem_safe("sha3_keccak4_f1600_alt2.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak4_f1600_alt2(a: &mut [u64; 100], rc: &[u64; 24]);

#[bums_macros::check_mem_safe("sha3_keccak_f1600.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak_f1600(a: &mut [u64; 25], rc: &[u64; 24]);

#[bums_macros::check_mem_safe("sha3_keccak_f1600_alt.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak_f1600_alt(a: &mut [u64; 25], rc: &[u64; 24]);

#[bums_macros::check_mem_safe("sha3_keccak_f1600_alt2.S", a.as_mut_ptr(), rc.as_ptr())]
fn sha3_keccak_f1600_alt2(a: &mut [u64; 25], rc: &[u64; 24]);
