use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_ssse3-x86_64.S", adler, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn adler32_ssse3(adler: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_avx2-x86_64.S", adler, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn adler32_avx2(adler: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_avx512-x86_64.S", adler, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn adler32_avx512(adler: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_avx512_vnni-x86_64.S", adler, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn adler32_avx512_vnni(adler: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_adler32_neon.S", adler, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn adler32_neon(adler: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_sse42-x86_64.S", adler, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn adler32_fold_copy_sse42(adler: u32, dst: &mut [u8], src: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_avx2-x86_64.S", adler, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn adler32_fold_copy_avx2(adler: u32, dst: &mut [u8], src: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_avx512-x86_64.S", adler, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn adler32_fold_copy_avx512(adler: u32, dst: &mut [u8], src: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_adler32_avx512_vnni-x86_64.S", adler, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn adler32_fold_copy_avx512_vnni(adler: u32, dst: &mut [u8], src: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_adler32_neon.S", adler, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn adler32_fold_copy_neon(adler: u32, dst: &mut [u8], src: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_pclmulqdq-x86_64.S", crc, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_pclmulqdq(crc: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_vpclmulqdq-x86_64.S", crc, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_vpclmulqdq(crc: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_chorba_sse2-x86_64.S", crc, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_chorba_sse2(crc: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_chorba_sse41-x86_64.S", crc, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_chorba_sse41(crc: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_crc32_armv8.S", crc, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_armv8(crc: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_pclmulqdq-x86_64.S", crc as *mut _,
    []))]
fn crc32_fold_pclmulqdq_reset(crc: &mut ([u8; 64], u32)) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_pclmulqdq-x86_64.S", crc as *mut _, src.as_ptr(), len, init_crc,
    [src.len() == len,
     len <= 1099511627776]))]
fn crc32_fold_pclmulqdq(crc: &mut ([u8; 64], u32), src: &[u8], len: usize, init_crc: u32);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_pclmulqdq-x86_64.S", crc as *mut _, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn crc32_fold_pclmulqdq_copy(crc: &mut ([u8; 64], u32), dst: &mut [u8], src: &[u8], len: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_pclmulqdq-x86_64.S", crc as *mut _,
    []))]
fn crc32_fold_pclmulqdq_final(crc: &mut ([u8; 64], u32)) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_vpclmulqdq-x86_64.S", crc as *mut _,
    []))]
fn crc32_fold_vpclmulqdq_reset(crc: &mut ([u8; 64], u32)) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_vpclmulqdq-x86_64.S", crc as *mut _, src.as_ptr(), len, init_crc,
    [src.len() == len,
     len <= 1099511627776]))]
fn crc32_fold_vpclmulqdq(crc: &mut ([u8; 64], u32), src: &[u8], len: usize, init_crc: u32);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_vpclmulqdq-x86_64.S", crc as *mut _, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn crc32_fold_vpclmulqdq_copy(crc: &mut ([u8; 64], u32), dst: &mut [u8], src: &[u8], len: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_crc32_vpclmulqdq-x86_64.S", crc as *mut _,
    []))]
fn crc32_fold_vpclmulqdq_final(crc: &mut ([u8; 64], u32)) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_crc32_armv8.S", crc as *mut _, src.as_ptr(), len, init_crc,
    [src.len() == len,
     len <= 1099511627776]))]
fn crc32_fold_armv8(crc: &mut ([u8; 64], u32), src: &[u8], len: usize, init_crc: u32);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_crc32_armv8.S", crc as *mut _, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn crc32_fold_copy_armv8(crc: &mut ([u8; 64], u32), dst: &mut [u8], src: &[u8], len: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_compare256_sse2-x86_64.S", src0.as_ptr(), src1.as_ptr(),
    [src0.len() == 256,
     src1.len() == 256]))]
fn compare256_sse2(src0: &[u8], src1: &[u8]) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_compare256_avx2-x86_64.S", src0.as_ptr(), src1.as_ptr(),
    [src0.len() == 256,
     src1.len() == 256]))]
fn compare256_avx2(src0: &[u8], src1: &[u8]) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_compare256_avx512-x86_64.S", src0.as_ptr(), src1.as_ptr(),
    [src0.len() == 256,
     src1.len() == 256]))]
fn compare256_avx512(src0: &[u8], src1: &[u8]) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_compare256_neon.S", src0.as_ptr(), src1.as_ptr(),
    [src0.len() == 256,
     src1.len() == 256]))]
fn compare256_neon(src0: &[u8], src1: &[u8]) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_chunkset_sse2-x86_64.S", buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist), len, left,
    [buf.len() == pos + left,
     pos <= 2147483647,
     left <= 2147483647,
     dist >= 1,
     dist <= pos,
     len >= 1,
     len <= left]))]
fn chunkmemset_safe_sse2(buf: &mut [u8], pos: usize, dist: usize, len: u32, left: u32) -> *mut u8;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_chunkset_ssse3-x86_64.S", buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist), len, left,
    [buf.len() == pos + left,
     pos <= 2147483647,
     left <= 2147483647,
     dist >= 1,
     dist <= pos,
     len >= 1,
     len <= left]))]
fn chunkmemset_safe_ssse3(buf: &mut [u8], pos: usize, dist: usize, len: u32, left: u32) -> *mut u8;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_chunkset_avx2-x86_64.S", buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist), len, left,
    [buf.len() == pos + left,
     pos <= 2147483647,
     left <= 2147483647,
     dist >= 1,
     dist <= pos,
     len >= 1,
     len <= left]))]
fn chunkmemset_safe_avx2(buf: &mut [u8], pos: usize, dist: usize, len: u32, left: u32) -> *mut u8;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_chunkset_avx512-x86_64.S", buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist), len, left,
    [buf.len() == pos + left,
     pos <= 2147483647,
     left <= 2147483647,
     dist >= 1,
     dist <= pos,
     len >= 1,
     len <= left]))]
fn chunkmemset_safe_avx512(buf: &mut [u8], pos: usize, dist: usize, len: u32, left: u32) -> *mut u8;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_chunkset_neon.S", buf.as_mut_ptr().add(pos), buf.as_mut_ptr().add(pos - dist), len, left,
    [buf.len() == pos + left,
     pos <= 2147483647,
     left <= 2147483647,
     dist >= 1,
     dist <= pos,
     len >= 1,
     len <= left]))]
fn chunkmemset_safe_neon(buf: &mut [u8], pos: usize, dist: usize, len: u32, left: u32) -> *mut u8;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_slide_hash_sse2-x86_64.S", s as *mut _,
    [s.1 == w_size,
     s.3 == prev.as_mut_ptr(),
     s.4 == head.as_mut_ptr(),
     prev.len() == w_size,
     head.len() == 65536,
     w_size == 256 || w_size == 512 || w_size == 1024 || w_size == 2048 || w_size == 4096 || w_size == 8192 || w_size == 16384 || w_size == 32768]))]
fn slide_hash_sse2(s: &mut ([u8; 64], u32, [u8; 28], usize, usize), prev: &mut [u16], head: &mut [u16], w_size: u32);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("zng_slide_hash_avx2-x86_64.S", s as *mut _,
    [s.1 == w_size,
     s.3 == prev.as_mut_ptr(),
     s.4 == head.as_mut_ptr(),
     prev.len() == w_size,
     head.len() == 65536,
     w_size == 256 || w_size == 512 || w_size == 1024 || w_size == 2048 || w_size == 4096 || w_size == 8192 || w_size == 16384 || w_size == 32768]))]
fn slide_hash_avx2(s: &mut ([u8; 64], u32, [u8; 28], usize, usize), prev: &mut [u16], head: &mut [u16], w_size: u32);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("zng_slide_hash_neon.S", s as *mut _,
    [s.1 == w_size,
     s.3 == prev.as_mut_ptr(),
     s.4 == head.as_mut_ptr(),
     prev.len() == w_size,
     head.len() == 65536,
     w_size == 256 || w_size == 512 || w_size == 1024 || w_size == 2048 || w_size == 4096 || w_size == 8192 || w_size == 16384 || w_size == 32768]))]
fn slide_hash_neon(s: &mut ([u8; 64], u32, [u8; 28], usize, usize), prev: &mut [u16], head: &mut [u16], w_size: u32);
