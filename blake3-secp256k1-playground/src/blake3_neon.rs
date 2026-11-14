use bums_macros as bums;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("blake3_neon.S", inputs.as_ptr(), num_inputs, blocks, key.as_ptr(), counter, increment_counter, flags, flags_start, flags_end, out.as_mut_ptr(),
    [inputs == [&[u8; 64 * blocks]; num_inputs], key.len() == 8, out.len() == 32 * num_inputs,
     blocks >= 1, blocks <= 16, num_inputs <= 1048576, increment_counter <= 1, flags <= 255, flags_start <= 255, flags_end <= 255]))]
fn blake3_hash_many_neon(inputs: &[&[u8]], num_inputs: usize, blocks: usize, key: &[u32], counter: u64, increment_counter: usize, flags: usize, flags_start: usize, flags_end: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("blake3_neon.S", cv.as_mut_ptr(), block.as_ptr(), used_len, counter, flags,
    [cv.len() == 8, block.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_in_place_portable(cv: &mut [u32], block: &[u8], used_len: usize, counter: u64, flags: usize);
