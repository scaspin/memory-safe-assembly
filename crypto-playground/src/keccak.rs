#![allow(non_snake_case)]

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_ptr(), inp.len(), r, [r >= 8, r % 8 == 0, r <= 200, inp.len() >= r])]
fn SHA3_Absorb_hw(a: &mut [u64; 25], inp: &[u8], r: usize) -> usize;

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), out.as_mut_ptr(), out.len(), r, [r >= 8, r % 8 == 0, r <= 200, out.len() >= 8, out.len() % 8 == 0])]
fn SHA3_Squeeze_hw(a: &mut [u64; 25], out: &mut [u8], r: usize);

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), inp.as_ptr(), inp.len(), r, [r >= 8, r % 8 == 0, r <= 200, inp.len() >= r])]
fn SHA3_Absorb_cext(a: &mut [u64; 25], inp: &[u8], r: usize) -> usize;

#[bums_macros::check_mem_safe("keccak1600-armv8.S", a.as_mut_ptr(), out.as_mut_ptr(), out.len(), r, [r >= 8, r % 8 == 0, r <= 200, out.len() >= 8, out.len() % 8 == 0])]
fn SHA3_Squeeze_cext(a: &mut [u64; 25], out: &mut [u8], r: usize);
