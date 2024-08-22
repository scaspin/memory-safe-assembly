// Copyright 2016 Brian Smith.
// Portions Copyright (c) 2016, Google Inc.
// SPDX-License-Identifier: ISC
// Modifications copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0 OR ISC

use crate::aes::tests::cipher::block::{Block, BLOCK_LEN};
use aws_lc_sys::CRYPTO_chacha_20;
use zeroize::Zeroize;

use aws_lc_rs::error;

pub(crate) const KEY_LEN: usize = 32usize;
pub(crate) const NONCE_LEN: usize = 96 / 8;

#[derive(Clone)]
pub(crate) struct ChaCha20Key(pub(super) [u8; KEY_LEN]);

impl From<[u8; KEY_LEN]> for ChaCha20Key {
    fn from(bytes: [u8; KEY_LEN]) -> Self {
        ChaCha20Key(bytes)
    }
}

impl Drop for ChaCha20Key {
    fn drop(&mut self) {
        self.0.zeroize();
    }
}

#[allow(clippy::needless_pass_by_value)]
impl ChaCha20Key {
    #[inline]
    pub(crate) fn encrypt_in_place(&self, nonce: &[u8; NONCE_LEN], in_out: &mut [u8], ctr: u32) {
        encrypt_in_place_chacha20(self, nonce, in_out, ctr);
    }
}

#[inline]
#[allow(clippy::needless_pass_by_value)]
pub(crate) fn encrypt_block_chacha20(
    key: &ChaCha20Key,
    block: Block,
    nonce: &[u8; NONCE_LEN],
    counter: u32,
) -> Result<Block, error::Unspecified> {
    let mut cipher_text = [0u8; BLOCK_LEN];
    encrypt_chacha20(
        key,
        block.as_ref().as_slice(),
        &mut cipher_text,
        nonce,
        counter,
    )?;

    crate::aes::tests::cipher::fips::set_fips_service_status_unapproved();

    Ok(Block::from(&cipher_text))
}

#[inline]
pub(crate) fn encrypt_chacha20(
    key: &ChaCha20Key,
    plaintext: &[u8],
    ciphertext: &mut [u8],
    nonce: &[u8; NONCE_LEN],
    counter: u32,
) -> Result<(), error::Unspecified> {
    if ciphertext.len() < plaintext.len() {
        return Err(error::Unspecified);
    }
    let key_bytes = &key.0;
    unsafe {
        CRYPTO_chacha_20(
            ciphertext.as_mut_ptr(),
            plaintext.as_ptr(),
            plaintext.len(),
            key_bytes.as_ptr(),
            nonce.as_ptr(),
            counter,
        );
    };
    Ok(())
}

#[inline]
pub(crate) fn encrypt_in_place_chacha20(
    key: &ChaCha20Key,
    nonce: &[u8; NONCE_LEN],
    in_out: &mut [u8],
    counter: u32,
) {
    let key_bytes = &key.0;
    unsafe {
        CRYPTO_chacha_20(
            in_out.as_mut_ptr(),
            in_out.as_ptr(),
            in_out.len(),
            key_bytes.as_ptr(),
            nonce.as_ptr(),
            counter,
        );
    }
    crate::aes::tests::cipher::fips::set_fips_service_status_unapproved();
}
