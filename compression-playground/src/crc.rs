use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc16_t10dif_01-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_01(seed: u16, buf: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc16_t10dif_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_avx2(seed: u16, buf: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc16_t10dif_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_by16_10(seed: u16, buf: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc16_t10dif_copy_by4-x86_64.S", seed, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_copy_by4(seed: u16, dst: &mut [u8], src: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc16_t10dif_copy_by4_02-x86_64.S", seed, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_copy_by4_02(seed: u16, dst: &mut [u8], src: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc16_t10dif_copy_pmull.S", seed, dst.as_mut_ptr(), src.as_ptr(), len,
    [dst.len() == len,
     src.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_copy_pmull(seed: u16, dst: &mut [u8], src: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc16_t10dif_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc16_t10dif_pmull(seed: u16, buf: &[u8], len: usize) -> u16;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_gzip_refl_3crc_fold.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_gzip_refl_3crc_fold(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_gzip_refl_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_gzip_refl_avx2(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_gzip_refl_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_gzip_refl_by16_10(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_gzip_refl_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_gzip_refl_by8(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_gzip_refl_crc_ext.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_gzip_refl_crc_ext(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_gzip_refl_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_gzip_refl_pmull(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_ieee_01-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_ieee_01(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_ieee_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_ieee_avx2(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_ieee_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_ieee_by16_10(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_ieee_norm_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_ieee_norm_pmull(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_iscsi_01-x86_64.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_01(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_iscsi_3crc_fold.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_3crc_fold(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_iscsi_avx2-x86_64.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_avx2(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_iscsi_by16_10-x86_64.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_by16_10(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc32_iscsi_by8_02-x86_64.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_by8_02(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_iscsi_crc_ext.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_crc_ext(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_iscsi_refl_pmull.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_refl_pmull(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_iscsi_refl_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_iscsi_refl_pmull_internal(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_iscsi_x6.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32_iscsi_x6(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_mix_default.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_mix_default(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32_mix_neoverse_n1.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc32_mix_neoverse_n1(seed: u32, buf: &[u8], len: usize) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32c_mix_default.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32c_mix_default(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc32c_mix_neoverse_n1.S", buf.as_ptr(), len, seed,
    [buf.len() == len,
     len <= 2147483647]))]
fn crc32c_mix_neoverse_n1(buf: &[u8], len: usize, seed: u32) -> u32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_ecma_norm_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_norm_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_ecma_norm_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_norm_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_ecma_norm_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_norm_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_ecma_norm_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_norm_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_ecma_refl_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_refl_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_ecma_refl_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_refl_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_ecma_refl_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_refl_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_ecma_refl_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_ecma_refl_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_iso_norm_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_norm_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_iso_norm_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_norm_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_iso_norm_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_norm_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_iso_norm_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_norm_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_iso_refl_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_refl_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_iso_refl_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_refl_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_iso_refl_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_refl_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_iso_refl_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_iso_refl_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_jones_norm_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_norm_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_jones_norm_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_norm_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_jones_norm_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_norm_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_jones_norm_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_norm_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_jones_refl_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_refl_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_jones_refl_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_refl_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_jones_refl_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_refl_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_jones_refl_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_jones_refl_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_rocksoft_norm_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_norm_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_rocksoft_norm_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_norm_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_rocksoft_norm_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_norm_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_rocksoft_norm_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_norm_pmull(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_rocksoft_refl_avx2-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_refl_avx2(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_rocksoft_refl_by16_10-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_refl_by16_10(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("crc64_rocksoft_refl_by8-x86_64.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_refl_by8(seed: u64, buf: &[u8], len: usize) -> u64;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("crc64_rocksoft_refl_pmull.S", seed, buf.as_ptr(), len,
    [buf.len() == len,
     len <= 1099511627776]))]
fn crc64_rocksoft_refl_pmull(seed: u64, buf: &[u8], len: usize) -> u64;
