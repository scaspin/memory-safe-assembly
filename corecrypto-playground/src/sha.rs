
#[bums_macros::check_mem_safe("sha1_compress_arm64.S", state.as_mut_ptr(), nblocks, data.as_ptr(), [data.len() == 64 * nblocks])]
fn AccelerateCrypto_SHA1_compress(state: &mut [u32; 5], nblocks: usize, data: &[u8]);

#[bums_macros::check_mem_safe("sha256_compress_arm64.S", state.as_mut_ptr(), nblocks, data.as_ptr(), [data.len() == 64 * nblocks])]
fn AccelerateCrypto_SHA256_compress(state: &mut [u32; 8], nblocks: usize, data: &[u8]);

#[bums_macros::check_mem_safe("sha256_compress_arm64neon.S", state.as_mut_ptr(), nblocks, data.as_ptr(), [data.len() == 64 * nblocks])]
fn AccelerateCrypto_SHA256_compress_arm64neon(state: &mut [u32; 8], nblocks: usize, data: &[u8]);

#[bums_macros::check_mem_safe("sha512_compress_arm64.S", state.as_mut_ptr(), nblocks, data.as_ptr(), [data.len() == 128 * nblocks])]
fn AccelerateCrypto_SHA512_compress(state: &mut [u64; 8], nblocks: usize, data: &[u8]);

#[bums_macros::check_mem_safe("sha512_compress_arm64hw.S", state.as_mut_ptr(), nblocks, data.as_ptr(), [data.len() == 128 * nblocks])]
fn AccelerateCrypto_SHA512_compress_hwassist(state: &mut [u64; 8], nblocks: usize, data: &[u8]);

#[bums_macros::check_mem_safe("sha3_keccak_arm64.S", state.as_mut_ptr())]
fn AccelerateCrypto_SHA3_keccak(state: &mut [u64; 25]);

#[bums_macros::check_mem_safe("sha3_keccak_arm64hw.S", state.as_mut_ptr())]
fn AccelerateCrypto_SHA3_keccak_hwassist(state: &mut [u64; 25]);
