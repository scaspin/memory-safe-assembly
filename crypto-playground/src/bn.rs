// aws_lc_rs imports
// use aws_lc::{BN_bin2bn, BN_bn2bin, BN_new, BN_num_bits, BN_num_bytes, BN_set_u64, BIGNUM};

type BIGNUM = [u8];

#[bums_macros::check_mem_safe("assembly/bn-armv8-apple.S", output.as_mut_ptr(), a.as_ptr(), b.as_ptr(), output.len())]
fn bn_add_words(output: &[u8], a: &[u8], b: &[u8]);

#[bums_macros::check_mem_safe("assembly/bn-armv8-apple.S", output.as_mut_ptr(), a.as_ptr(), b.as_ptr(), output.len())]
fn bn_sub_words(output: &[u8], a: &[u8], b: &[u8]);
