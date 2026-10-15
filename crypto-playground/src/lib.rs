pub mod aes;
pub mod bn;
pub mod ghash;
#[cfg(target_arch = "aarch64")]
pub mod keccak;
pub mod md5;
#[cfg(target_arch = "aarch64")]
pub mod mldsa;
#[cfg(target_arch = "aarch64")]
pub mod mlkem;
pub mod sha1;
pub mod sha256;
pub mod sha512;
#[cfg(target_arch = "aarch64")]
pub mod chacha;
pub mod p256;
pub mod rand;
mod utils;
#[cfg(target_arch = "x86_64")]
pub mod x86_64;

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
#[unsafe(no_mangle)]
pub static OPENSSL_armcap_P: usize = 0;

#[cfg(target_arch = "x86_64")]
#[unsafe(no_mangle)]
pub static OPENSSL_ia32cap_P: [u32; 4] = [0; 4];
