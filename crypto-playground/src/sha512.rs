#[cfg(target_arch = "aarch64")]
#[bums_macros::check_mem_safe("sha512-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0])]
fn sha512_block_data_order_hw(context: &mut [u64; 8], input: &[u8]);

#[cfg_attr(target_arch = "aarch64", bums_macros::check_mem_safe("sha512-armv8.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0]))]
#[cfg_attr(target_arch = "x86_64", bums_macros::check_mem_safe("sha512-x86_64.S", context.as_mut_ptr(), input.as_ptr(), input.len() / 128, [input.len() >= 128, input.len() % 128 == 0]))]
fn sha512_block_data_order_nohw(context: &mut [u64; 8], input: &[u8]);
