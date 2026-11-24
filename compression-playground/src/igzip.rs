use bums_macros as bums;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("igzip_isal_adler32_neon.S", adler, start.as_ptr(), length,
    [start.len() == length, length <= 1099511627776]))]
fn adler32_neon(adler: u32, start: &[u8], length: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("adler32_sse-x86_64.S", adler, start.as_ptr(), length,
    [start.len() == length, length <= 1099511627776]))]
fn adler32_sse(adler: u32, start: &[u8], length: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("adler32_avx2_4-x86_64.S", adler, start.as_ptr(), length,
    [start.len() == length, length <= 1099511627776]))]
fn adler32_avx2_4(adler: u32, start: &[u8], length: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("igzip_deflate_hash_aarch64.S", hash_table.as_mut_ptr(), hash_mask, current_index, dict.as_ptr(), dict_len,
    [hash_table.len() == hash_mask + 1, hash_mask <= 65535, dict.len() == dict_len, dict_len <= 32768]))]
fn isal_deflate_hash_aarch64(hash_table: &mut [u16], hash_mask: u32, current_index: u32, dict: &[u8], dict_len: u32);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("igzip_deflate_hash-x86_64.S", hash_table.as_mut_ptr(), hash_mask, current_index, dict.as_ptr(), dict_len,
    [hash_table.len() == hash_mask + 1, hash_mask <= 65535, dict.len() == dict_len, dict_len <= 32768]))]
fn isal_deflate_hash_crc_01(hash_table: &mut [u16], hash_mask: u32, current_index: u32, dict: &[u8], dict_len: u32);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("isal_update_histogram.S", start.as_ptr(), length, histogram.as_mut_ptr(),
    [start.len() == length, length <= 2147483647]))]
fn isal_update_histogram_aarch64(start: &[u8], length: usize, histogram: &mut [u8; 18912]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("igzip_update_histogram_01-x86_64.S", start.as_ptr(), length, histogram.as_mut_ptr(),
    [start.len() == length, length <= 2147483647]))]
fn isal_update_histogram_01(start: &[u8], length: usize, histogram: &mut [u8; 18912]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("igzip_update_histogram_04-x86_64.S", start.as_ptr(), length, histogram.as_mut_ptr(),
    [start.len() == length, length <= 2147483647]))]
fn isal_update_histogram_04(start: &[u8], length: usize, histogram: &mut [u8; 18912]);

mod dictionary_of_at_least_four_bytes {
    use bums_macros as bums;

    #[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("igzip_deflate_hash_aarch64.S", hash_table.as_mut_ptr(), hash_mask, current_index, dict.as_ptr(), dict_len,
        [hash_table.len() == hash_mask + 1, hash_mask <= 65535, dict.len() == dict_len, dict_len >= 4, dict_len <= 32768]))]
    fn isal_deflate_hash_aarch64(hash_table: &mut [u16], hash_mask: u32, current_index: u32, dict: &[u8], dict_len: u32);

    #[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("igzip_deflate_hash-x86_64.S", hash_table.as_mut_ptr(), hash_mask, current_index, dict.as_ptr(), dict_len,
        [hash_table.len() == hash_mask + 1, hash_mask <= 65535, dict.len() == dict_len, dict_len >= 4, dict_len <= 32768]))]
    fn isal_deflate_hash_crc_01(hash_table: &mut [u16], hash_mask: u32, current_index: u32, dict: &[u8], dict_len: u32);
}
