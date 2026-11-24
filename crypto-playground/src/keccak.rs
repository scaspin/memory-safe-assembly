#![allow(non_snake_case)]

#[bums_macros::check_mem_safe("keccak1600-armv8.S", state.as_mut_ptr())]
fn KeccakF1600_hw(state: &mut [u64; 25]);
