use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_sse2.S", cv.as_mut_ptr(), block.as_ptr(), used_len, counter, flags,
    [cv.len() == 8, block.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_in_place_sse2(cv: &mut [u32], block: &[u8], used_len: usize, counter: u64, flags: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_sse2.S", cv.as_ptr(), block.as_ptr(), used_len, counter, flags, out.as_mut_ptr(),
    [cv.len() == 8, block.len() == 64, out.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_xof_sse2(cv: &[u32], block: &[u8], used_len: usize, counter: u64, flags: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_sse2.S", inputs.as_ptr(), num_inputs, blocks, key.as_ptr(), counter, increment_counter, flags, flags_start, flags_end, out.as_mut_ptr(),
    [inputs == [&[u8; 64 * blocks]; num_inputs], key.len() == 8, out.len() == 32 * num_inputs,
     blocks >= 1, blocks <= 16, num_inputs <= 1048576, increment_counter <= 1, flags <= 255, flags_start <= 255, flags_end <= 255]))]
fn blake3_hash_many_sse2(inputs: &[&[u8]], num_inputs: usize, blocks: usize, key: &[u32], counter: u64, increment_counter: usize, flags: usize, flags_start: usize, flags_end: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_sse41.S", cv.as_mut_ptr(), block.as_ptr(), used_len, counter, flags,
    [cv.len() == 8, block.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_in_place_sse41(cv: &mut [u32], block: &[u8], used_len: usize, counter: u64, flags: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_sse41.S", cv.as_ptr(), block.as_ptr(), used_len, counter, flags, out.as_mut_ptr(),
    [cv.len() == 8, block.len() == 64, out.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_xof_sse41(cv: &[u32], block: &[u8], used_len: usize, counter: u64, flags: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_sse41.S", inputs.as_ptr(), num_inputs, blocks, key.as_ptr(), counter, increment_counter, flags, flags_start, flags_end, out.as_mut_ptr(),
    [inputs == [&[u8; 64 * blocks]; num_inputs], key.len() == 8, out.len() == 32 * num_inputs,
     blocks >= 1, blocks <= 16, num_inputs <= 1048576, increment_counter <= 1, flags <= 255, flags_start <= 255, flags_end <= 255]))]
fn blake3_hash_many_sse41(inputs: &[&[u8]], num_inputs: usize, blocks: usize, key: &[u32], counter: u64, increment_counter: usize, flags: usize, flags_start: usize, flags_end: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_avx2.S", inputs.as_ptr(), num_inputs, blocks, key.as_ptr(), counter, increment_counter, flags, flags_start, flags_end, out.as_mut_ptr(),
    [inputs == [&[u8; 64 * blocks + 16]; num_inputs], key.len() == 8, out.len() == 32 * num_inputs,
     blocks >= 1, blocks <= 16, num_inputs <= 1048576, increment_counter <= 1, flags <= 255, flags_start <= 255, flags_end <= 255]))]
fn blake3_hash_many_avx2(inputs: &[&[u8]], num_inputs: usize, blocks: usize, key: &[u32], counter: u64, increment_counter: usize, flags: usize, flags_start: usize, flags_end: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_avx512.S", cv.as_mut_ptr(), block.as_ptr(), used_len, counter, flags,
    [cv.len() == 8, block.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_in_place_avx512(cv: &mut [u32], block: &[u8], used_len: usize, counter: u64, flags: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_avx512.S", cv.as_ptr(), block.as_ptr(), used_len, counter, flags, out.as_mut_ptr(),
    [cv.len() == 8, block.len() == 64, out.len() == 64, used_len <= 64, flags <= 255]))]
fn blake3_compress_xof_avx512(cv: &[u32], block: &[u8], used_len: usize, counter: u64, flags: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_avx512.S", inputs.as_ptr(), num_inputs, blocks, key.as_ptr(), counter, increment_counter, flags, flags_start, flags_end, out.as_mut_ptr(),
    [inputs == [&[u8; 64 * blocks + 48]; num_inputs], key.len() == 8, out.len() == 32 * num_inputs,
     blocks >= 1, blocks <= 16, num_inputs <= 1048576, increment_counter <= 1, flags <= 255, flags_start <= 255, flags_end <= 255]))]
fn blake3_hash_many_avx512(inputs: &[&[u8]], num_inputs: usize, blocks: usize, key: &[u32], counter: u64, increment_counter: usize, flags: usize, flags_start: usize, flags_end: usize, out: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("blake3_avx512.S", cv.as_ptr(), block.as_ptr(), used_len, counter, flags, out.as_mut_ptr(), outblocks,
    [cv.len() == 8, block.len() == 64, out.len() == 64 * outblocks, used_len <= 64, flags <= 255, outblocks >= 1, outblocks <= 1048576]))]
fn blake3_xof_many_avx512(cv: &[u32], block: &[u8], used_len: usize, counter: u64, flags: usize, out: &mut [u8], outblocks: usize);
