#[bums_macros::check_mem_safe("sha512-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0])]
fn sha512_block_data_order(context: &mut [u64; 8], input: &[u8]);
