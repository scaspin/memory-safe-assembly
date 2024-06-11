pub mod aes;
pub mod awslc;
pub mod bn;
pub mod ghash;
pub mod sha256;
mod utils;

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
// TODO(alevy): This should be computed as in AWS-LC's 'crypto/fipsmodule/cpucap'
// Setting to 0 assumes no special crypto instructions (NEON, AES, PMULL, SHA1, SHA256, SHA512, SHA3, CPUID)
#[no_mangle]
pub static OPENSSL_armcap_P: usize = 0;
