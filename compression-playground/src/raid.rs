use bums_macros as bums;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("pq_check_neon.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 16 == 0]))]
fn pq_check_neon(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_check_sse-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 16 == 0]))]
fn pq_check_sse(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_gen_avx-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_avx(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_gen_avx2-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_avx2(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_gen_avx2_gfni-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_avx2_gfni(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_gen_avx512-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_avx512(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_gen_avx512_gfni-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_avx512_gfni(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("pq_gen_neon.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_neon(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("pq_gen_sse-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 4,
     vects <= 256,
     len <= 2147483647,
     len % 32 == 0]))]
fn pq_gen_sse(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("xor_check_neon.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 2,
     vects <= 256,
     len <= 2147483647]))]
fn xor_check_neon(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("xor_check_sse-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 2,
     vects <= 256,
     len <= 2147483647]))]
fn xor_check_sse(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("xor_gen_avx-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 3,
     vects <= 256,
     len <= 2147483647]))]
fn xor_gen_avx(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("xor_gen_avx512-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 3,
     vects <= 256,
     len <= 2147483647]))]
fn xor_gen_avx512(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("xor_gen_neon.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 3,
     vects <= 256,
     len <= 2147483647]))]
fn xor_gen_neon(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("xor_gen_sse-x86_64.S", vects, len, array.as_ptr(),
    [array == [&mut [u8; len]; vects],
     vects >= 3,
     vects <= 256,
     len <= 2147483647]))]
fn xor_gen_sse(vects: usize, len: usize, array: &mut [&mut [u8]]) -> i32;
