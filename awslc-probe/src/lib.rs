#![allow(dead_code, non_snake_case, unused_imports)]

#[bums_macros::check_mem_safe("p521_jscalarmul_alt.S", res.as_mut_ptr(), scalar.as_ptr(), point.as_ptr())]
fn p521_jscalarmul_alt(res: &mut [u64; 27], scalar: &[u64; 9], point: &[u64; 27]);
