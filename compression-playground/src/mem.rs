use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("mem_zero_detect_avx-x86_64.S", mem.as_ptr(), len,
    [mem.len() == len,
     len <= 1099511627776]))]
fn mem_zero_detect_avx(mem: &[u8], len: usize) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("mem_zero_detect_avx2-x86_64.S", mem.as_ptr(), len,
    [mem.len() == len,
     len <= 1099511627776]))]
fn mem_zero_detect_avx2(mem: &[u8], len: usize) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("mem_zero_detect_avx512-x86_64.S", mem.as_ptr(), len,
    [mem.len() == len,
     len <= 1099511627776]))]
fn mem_zero_detect_avx512(mem: &[u8], len: usize) -> i32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("mem_zero_detect_neon.S", mem.as_ptr(), len,
    [mem.len() == len,
     len <= 1099511627776]))]
fn mem_zero_detect_neon(mem: &[u8], len: usize) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("mem_zero_detect_sse-x86_64.S", mem.as_ptr(), len,
    [mem.len() == len,
     len <= 1099511627776]))]
fn mem_zero_detect_sse(mem: &[u8], len: usize) -> i32;
