pub mod aes;
pub mod bn;
pub mod ghash;
pub mod keccak;
pub mod md5;
pub mod sha1;
pub mod sha256;
pub mod sha512;
pub mod chacha;
pub mod p256;
mod utils;

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
#[unsafe(no_mangle)]
pub static OPENSSL_armcap_P: usize = 0;
