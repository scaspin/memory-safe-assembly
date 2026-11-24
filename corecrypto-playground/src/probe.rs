#![allow(non_snake_case)]
#[bums_macros::check_mem_safe("sha3_keccak_arm64hw.S", state.as_mut_ptr())]
fn AccelerateCrypto_SHA3_keccak_hwassist(state: &mut [u64; 24]);
