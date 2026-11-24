use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr(),
    [r.len() == 4, a.len() == 4, b.len() == 4]))]
fn secp_scalar_mul(r: &mut [u64], a: &[u64], b: &[u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr(),
    [r.len() == 4, a.len() == 4, b.len() == 4]))]
fn secp_scalar_add(r: &mut [u64], a: &[u64], b: &[u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), b32.as_ptr(), overflow.as_mut_ptr(),
    [r.len() == 4, b32.len() == 32, overflow.len() == 1]))]
fn secp_scalar_set_b32(r: &mut [u64], b32: &[u8], overflow: &mut [i32]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", bin.as_mut_ptr(), a.as_ptr(),
    [bin.len() == 32, a.len() == 4]))]
fn secp_scalar_get_b32(bin: &mut [u8], a: &[u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), a.as_ptr(), b.as_ptr(),
    [r.len() == 5, a.len() == 5, b.len() == 5]))]
fn secp_fe_mul(r: &mut [u64], a: &[u64], b: &[u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), a.as_ptr(),
    [r.len() == 5, a.len() == 5]))]
fn secp_fe_sqr(r: &mut [u64], a: &[u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(),
    [r.len() == 5]))]
fn secp_fe_normalize(r: &mut [u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), a.as_ptr(),
    [r.len() == 5, a.len() == 32]))]
fn secp_fe_set_b32_mod(r: &mut [u64], a: &[u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", r.as_mut_ptr(), a.as_ptr(),
    [r.len() == 32, a.len() == 5]))]
fn secp_fe_get_b32(r: &mut [u8], a: &[u64]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", s.as_mut_ptr(), blocks.as_ptr(), n_blocks,
    [s.len() == 8, blocks.len() == 64 * n_blocks, n_blocks <= 1099511627776]))]
fn secp_sha256_transform(s: &mut [u32], blocks: &[u8], n_blocks: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", hash.as_mut_ptr(), data.as_ptr(), size,
    [hash.len() == 104, data.len() == size, size <= 1099511627776]))]
fn secp_sha256_write(hash: &mut [u8], data: &[u8], size: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("secp256k1_x86_asm.S", hash.as_mut_ptr(), out32.as_mut_ptr(),
    [hash.len() == 104, out32.len() == 32]))]
fn secp_sha256_finalize(hash: &mut [u8], out32: &mut [u8]);
