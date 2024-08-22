// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0 OR ISC

use crate::aes::tests::cipher::aes::encrypt_block_aes;
use crate::aes::tests::cipher::block::Block;
use crate::aes::tests::cipher::chacha::ChaCha20Key;
use aws_lc_rs::cipher::{AES_128_KEY_LEN, AES_256_KEY_LEN};
use aws_lc_rs::error::Unspecified;
use aws_lc_sys::{AES_set_decrypt_key, AES_set_encrypt_key, AES_KEY};
use core::mem::{size_of, MaybeUninit};
use core::ptr::copy_nonoverlapping;
// TODO: Uncomment when MSRV >= 1.64
// use core::ffi::c_uint;
use std::os::raw::c_uint;
use zeroize::Zeroize;

#[derive(Clone)]
pub(crate) enum SymmetricCipherKey {
    Aes128 { enc_key: AES_KEY, dec_key: AES_KEY },
    Aes256 { enc_key: AES_KEY, dec_key: AES_KEY },
    ChaCha20 { raw_key: ChaCha20Key },
}

unsafe impl Send for SymmetricCipherKey {}

// The AES_KEY value is only used as a `*const AES_KEY` in calls to `AES_encrypt`.
unsafe impl Sync for SymmetricCipherKey {}

impl Drop for SymmetricCipherKey {
    fn drop(&mut self) {
        // Aes128Key, Aes256Key and ChaCha20Key implement Drop separately.
        match self {
            SymmetricCipherKey::Aes128 { enc_key, dec_key }
            | SymmetricCipherKey::Aes256 { enc_key, dec_key } => unsafe {
                let enc_bytes: &mut [u8; size_of::<AES_KEY>()] = (enc_key as *mut AES_KEY)
                    .cast::<[u8; size_of::<AES_KEY>()]>()
                    .as_mut()
                    .unwrap();
                enc_bytes.zeroize();
                let dec_bytes: &mut [u8; size_of::<AES_KEY>()] = (dec_key as *mut AES_KEY)
                    .cast::<[u8; size_of::<AES_KEY>()]>()
                    .as_mut()
                    .unwrap();
                dec_bytes.zeroize();
            },
            SymmetricCipherKey::ChaCha20 { .. } => {}
        }
    }
}

impl SymmetricCipherKey {
    pub(crate) fn print(&mut self) -> &[u8] {
        match self {
            SymmetricCipherKey::Aes128 { enc_key, .. }
            | SymmetricCipherKey::Aes256 { enc_key, .. } => unsafe {
                let enc_bytes: &[u8; size_of::<AES_KEY>()] = (enc_key as *mut AES_KEY)
                    .cast::<[u8; size_of::<AES_KEY>()]>()
                    .as_mut()
                    .unwrap();
                enc_bytes
            },
            SymmetricCipherKey::ChaCha20 { .. } => &[0],
        }
    }

    pub(crate) fn aes128(key_bytes: &[u8]) -> Result<Self, Unspecified> {
        if key_bytes.len() != AES_128_KEY_LEN {
            return Err(Unspecified);
        }

        unsafe {
            let mut enc_key = MaybeUninit::<AES_KEY>::uninit();
            #[allow(clippy::cast_possible_truncation)]
            if 0 != AES_set_encrypt_key(
                key_bytes.as_ptr(),
                (key_bytes.len() * 8) as c_uint,
                enc_key.as_mut_ptr(),
            ) {
                return Err(Unspecified);
            }
            let enc_key = enc_key.assume_init();

            let mut dec_key = MaybeUninit::<AES_KEY>::uninit();
            #[allow(clippy::cast_possible_truncation)]
            if 0 != AES_set_decrypt_key(
                key_bytes.as_ptr(),
                (key_bytes.len() * 8) as c_uint,
                dec_key.as_mut_ptr(),
            ) {
                return Err(Unspecified);
            }
            let dec_key = dec_key.assume_init();

            let mut kb = MaybeUninit::<[u8; AES_128_KEY_LEN]>::uninit();
            copy_nonoverlapping(key_bytes.as_ptr(), kb.as_mut_ptr().cast(), AES_128_KEY_LEN);
            Ok(SymmetricCipherKey::Aes128 { enc_key, dec_key })
        }
    }

    pub(crate) fn aes256(key_bytes: &[u8]) -> Result<Self, Unspecified> {
        if key_bytes.len() != AES_256_KEY_LEN {
            return Err(Unspecified);
        }
        unsafe {
            let mut enc_key = MaybeUninit::<AES_KEY>::uninit();
            #[allow(clippy::cast_possible_truncation)]
            if 0 != AES_set_encrypt_key(
                key_bytes.as_ptr(),
                (key_bytes.len() * 8) as c_uint,
                enc_key.as_mut_ptr(),
            ) {
                return Err(Unspecified);
            }
            let enc_key = enc_key.assume_init();

            let mut dec_key = MaybeUninit::<AES_KEY>::uninit();
            #[allow(clippy::cast_possible_truncation)]
            if 0 != AES_set_decrypt_key(
                key_bytes.as_ptr(),
                (key_bytes.len() * 8) as c_uint,
                dec_key.as_mut_ptr(),
            ) {
                return Err(Unspecified);
            }
            let dec_key = dec_key.assume_init();

            let mut kb = MaybeUninit::<[u8; AES_256_KEY_LEN]>::uninit();
            copy_nonoverlapping(key_bytes.as_ptr(), kb.as_mut_ptr().cast(), AES_256_KEY_LEN);
            Ok(SymmetricCipherKey::Aes256 { enc_key, dec_key })
        }
    }

    pub(crate) fn chacha20(key_bytes: &[u8]) -> Result<Self, Unspecified> {
        if key_bytes.len() != 32 {
            return Err(Unspecified);
        }
        let mut kb = MaybeUninit::<[u8; 32]>::uninit();
        unsafe {
            copy_nonoverlapping(key_bytes.as_ptr(), kb.as_mut_ptr().cast(), 32);
            Ok(SymmetricCipherKey::ChaCha20 {
                raw_key: ChaCha20Key(kb.assume_init()),
            })
        }
    }

    #[allow(dead_code)]
    #[inline]
    pub(crate) fn encrypt_block(&self, block: Block) -> Block {
        match self {
            SymmetricCipherKey::Aes128 { enc_key, .. }
            | SymmetricCipherKey::Aes256 { enc_key, .. } => encrypt_block_aes(enc_key, block),
            SymmetricCipherKey::ChaCha20 { .. } => panic!("Unsupported algorithm!"),
        }
    }
}
