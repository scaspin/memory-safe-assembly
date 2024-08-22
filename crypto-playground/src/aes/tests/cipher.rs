// Copyright 2018 Brian Smith.
// SPDX-License-Identifier: ISC
// Modifications copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0 OR ISC

//! Block and Stream Ciphers for Encryption and Decryption.
//!
//! # 🛑 Read Before Using
//!
//! This module provides access to block and stream cipher algorithms.
//! The modes provided here only provide confidentiality, but **do not**
//! provide integrity or authentication verification of ciphertext.
//!
//! These algorithms are provided solely for applications requring them
//! in order to maintain backwards compatability in legacy applications.
//!
//! If you are developing new applications requring data encryption see
//! the algorithms provided in [`aead`](crate::aead).
//!
//! # Examples
//!
//! ## Encryption Modes
//!
//! ### AES-128 CBC
//!
//! ```rust
//! # use std::error::Error;
//! #
//! # fn main() -> Result<(), Box<dyn Error>> {
//! use aws_lc_rs::cipher::{
//!     PaddedBlockDecryptingKey, PaddedBlockEncryptingKey, UnboundCipherKey, AES_128,
//! };
//! use std::io::Read;
//!
//! let original_message = "This is a secret message!".as_bytes();
//! let mut in_out_buffer = Vec::from(original_message);
//!
//! let key_bytes: &[u8] = &[
//!     0xff, 0x0b, 0xe5, 0x84, 0x64, 0x0b, 0x00, 0xc8, 0x90, 0x7a, 0x4b, 0xbf, 0x82, 0x7c, 0xb6,
//!     0xd1,
//! ];
//!
//! let key = UnboundCipherKey::new(&AES_128, key_bytes)?;
//! let mut encrypting_key = PaddedBlockEncryptingKey::cbc_pkcs7(key)?;
//! let context = encrypting_key.encrypt(&mut in_out_buffer)?;
//!
//! let key = UnboundCipherKey::new(&AES_128, key_bytes)?;
//! let mut decrypting_key = PaddedBlockDecryptingKey::cbc_pkcs7(key)?;
//! let plaintext = decrypting_key.decrypt(&mut in_out_buffer, context)?;
//! assert_eq!(original_message, plaintext);
//! #
//! #
//! # Ok(())
//! # }
//! ```
//!
//! ### AES-128 CTR
//!
//! ```rust
//! # use std::error::Error;
//! #
//! # fn main() -> Result<(), Box<dyn Error>> {
//! use aws_lc_rs::cipher::{DecryptingKey, EncryptingKey, UnboundCipherKey, AES_128};
//!
//! let original_message = "This is a secret message!".as_bytes();
//! let mut in_out_buffer = Vec::from(original_message);
//!
//! let key_bytes: &[u8] = &[
//!     0xff, 0x0b, 0xe5, 0x84, 0x64, 0x0b, 0x00, 0xc8, 0x90, 0x7a, 0x4b, 0xbf, 0x82, 0x7c, 0xb6,
//!     0xd1,
//! ];
//!
//! let key = UnboundCipherKey::new(&AES_128, key_bytes)?;
//! let mut encrypting_key = EncryptingKey::ctr(key)?;
//! let context = encrypting_key.encrypt(&mut in_out_buffer)?;
//!
//! let key = UnboundCipherKey::new(&AES_128, key_bytes)?;
//! let mut decrypting_key = DecryptingKey::ctr(key)?;
//! let plaintext = decrypting_key.decrypt(&mut in_out_buffer, context)?;
//! assert_eq!(original_message, plaintext);
//! #
//! # Ok(())
//! # }
//! ```
//!
//! ## Constructing a `DecryptionContext` for decryption.
//!
//! ```rust
//! # use std::error::Error;
//! # fn main() -> Result<(), Box<dyn Error>> {
//! use aws_lc_rs::cipher::{DecryptingKey, DecryptionContext, UnboundCipherKey, AES_128};
//! use aws_lc_rs::iv::{FixedLength, IV_LEN_128_BIT};
//!
//! let context = DecryptionContext::Iv128(FixedLength::<IV_LEN_128_BIT>::from(&[
//!     0x8d, 0xdb, 0x7d, 0xf1, 0x56, 0xf5, 0x1c, 0xde, 0x63, 0xe3, 0x4a, 0x34, 0xb0, 0xdf, 0x28,
//!     0xf0,
//! ]));
//!
//! let ciphertext: &[u8] = &[
//!     0x79, 0x8c, 0x04, 0x58, 0xcf, 0x98, 0xb1, 0xe9, 0x97, 0x6b, 0xa1, 0xce,
//! ];
//!
//! let mut in_out_buffer = Vec::from(ciphertext);
//!
//! let key = UnboundCipherKey::new(
//!     &AES_128,
//!     &[
//!         0x5b, 0xfc, 0xe7, 0x5e, 0x57, 0xc5, 0x4d, 0xda, 0x2d, 0xd4, 0x7e, 0x07, 0x0a, 0xef,
//!         0x43, 0x29,
//!     ],
//! )?;
//! let mut decrypting_key = DecryptingKey::ctr(key)?;
//! let plaintext = decrypting_key.decrypt(&mut in_out_buffer, context)?;
//! assert_eq!("Hello World!".as_bytes(), plaintext);
//!
//! # Ok(())
//! # }
//! ```
//!
//! ## Getting an immutable reference to the IV slice.
//!
//! `TryFrom<&DecryptionContext>` is implemented for `&[u8]` allowing immutable references
//! to IV bytes returned from cipher encryption operations. Note this is implemented as a `TryFrom` as it
//! may fail for future enum variants that aren't representable as a single slice.
//!
//! ```rust
//! # use std::error::Error;
//! # fn main() -> Result<(), Box<dyn Error>> {
//! # use aws_lc_rs::cipher::DecryptionContext;
//! # use aws_lc_rs::iv::FixedLength;
//! # let x: DecryptionContext = DecryptionContext::Iv128(FixedLength::from([0u8; 16]));
//! // x is type `DecryptionContext`
//! let iv: &[u8] = (&x).try_into()?;
//! # Ok(())
//! # }
//! ```

#![allow(clippy::module_name_repetitions)]

pub(crate) mod aes;
pub(crate) mod block;
pub(crate) mod chacha;
pub(crate) mod fips;
pub(crate) mod iv;
pub(crate) mod key;

use aws_lc_rs::error::Unspecified;
use aws_lc_rs::hkdf;
use aws_lc_rs::hkdf::KeyType;
use aws_lc_sys::{AES_cbc_encrypt, AES_ctr128_encrypt, AES_DECRYPT, AES_ENCRYPT, AES_KEY};
use core::fmt::Debug;
use core::mem::MaybeUninit;
use fips::indicator_check;
use iv::{FixedLength, IV_LEN_128_BIT};
use key::SymmetricCipherKey;
use zeroize::Zeroize;

/// The cipher block padding strategy.
#[non_exhaustive]
#[derive(Debug, PartialEq, Eq, Clone, Copy)]
enum PaddingStrategy {
    /// PKCS#7 Padding. ([See RFC 5652](https://datatracker.ietf.org/doc/html/rfc5652#section-6.3))
    PKCS7,
}

impl PaddingStrategy {
    fn add_padding<InOut>(self, block_len: usize, in_out: &mut InOut) -> Result<(), Unspecified>
    where
        InOut: AsMut<[u8]> + for<'in_out> Extend<&'in_out u8>,
    {
        match self {
            PaddingStrategy::PKCS7 => {
                let mut padding_buffer = [0u8; MAX_CIPHER_BLOCK_LEN];

                let in_out_len = in_out.as_mut().len();
                // This implements PKCS#7 padding scheme, used by aws-lc if we were using EVP_CIPHER API's
                let remainder = in_out_len % block_len;
                let padding_size = block_len - remainder;
                let v: u8 = padding_size.try_into().map_err(|_| Unspecified)?;
                padding_buffer.fill(v);
                // Possible heap allocation here :(
                in_out.extend(padding_buffer[0..padding_size].iter());
            }
        }
        Ok(())
    }

    fn remove_padding(self, block_len: usize, in_out: &mut [u8]) -> Result<&mut [u8], Unspecified> {
        match self {
            PaddingStrategy::PKCS7 => {
                let block_size: u8 = block_len.try_into().map_err(|_| Unspecified)?;

                if in_out.is_empty() || in_out.len() < block_len {
                    return Err(Unspecified);
                }

                let padding: u8 = in_out[in_out.len() - 1];
                if padding == 0 || padding > block_size {
                    return Err(Unspecified);
                }

                for item in in_out.iter().skip(in_out.len() - padding as usize) {
                    if *item != padding {
                        return Err(Unspecified);
                    }
                }

                let final_len = in_out.len() - padding as usize;
                Ok(&mut in_out[0..final_len])
            }
        }
    }
}

/// The number of bytes in an AES 128-bit key
pub const AES_128_KEY_LEN: usize = 16;

/// The number of bytes in an AES 256-bit key
pub const AES_256_KEY_LEN: usize = 32;

const MAX_CIPHER_KEY_LEN: usize = AES_256_KEY_LEN;

/// The number of bytes for an AES-CBC initialization vector (IV)
pub const AES_CBC_IV_LEN: usize = 16;

/// The number of bytes for an AES-CTR initialization vector (IV)
pub const AES_CTR_IV_LEN: usize = 16;
const AES_BLOCK_LEN: usize = 16;

const MAX_CIPHER_BLOCK_LEN: usize = AES_BLOCK_LEN;

/// The cipher operating mode.
#[non_exhaustive]
#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum OperatingMode {
    /// Cipher block chaining (CBC) mode.
    CBC,

    /// Counter (CTR) mode.
    CTR,
}

macro_rules! define_cipher_context {
    ($name:ident, $other:ident) => {
        /// The contextual data used to encrypt or decrypt data.
        #[non_exhaustive]
        pub enum $name {
            /// A 128-bit Initialization Vector.
            Iv128(FixedLength<IV_LEN_128_BIT>),
        }

        impl<'a> TryFrom<&'a $name> for &'a [u8] {
            type Error = Unspecified;

            fn try_from(value: &'a $name) -> Result<Self, Unspecified> {
                match value {
                    $name::Iv128(iv) => Ok(iv.as_ref()),
                }
            }
        }

        impl Debug for $name {
            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
                match self {
                    Self::Iv128(v) => write!(f, "Iv128 {:?}", v),
                }
            }
        }

        impl From<$other> for $name {
            fn from(value: $other) -> Self {
                match value {
                    $other::Iv128(iv) => $name::Iv128(iv),
                }
            }
        }
    };
}

define_cipher_context!(EncryptionContext, DecryptionContext);
define_cipher_context!(DecryptionContext, EncryptionContext);

#[non_exhaustive]
#[derive(Debug, PartialEq, Eq, Clone, Copy)]
/// Cipher algorithm identifier.
pub enum AlgorithmId {
    /// AES 128-bit
    Aes128,

    /// AES 256-bit
    Aes256,
}

/// A cipher algorithm.
#[derive(Debug, PartialEq, Eq)]
pub struct Algorithm {
    id: AlgorithmId,
    key_len: usize,
    block_len: usize,
}

/// AES 128-bit cipher
pub static AES_128: Algorithm = Algorithm {
    id: AlgorithmId::Aes128,
    key_len: AES_128_KEY_LEN,
    block_len: AES_BLOCK_LEN,
};

/// AES 256-bit cipher
pub static AES_256: Algorithm = Algorithm {
    id: AlgorithmId::Aes256,
    key_len: AES_256_KEY_LEN,
    block_len: AES_BLOCK_LEN,
};

impl Algorithm {
    fn id(&self) -> &AlgorithmId {
        &self.id
    }

    const fn block_len(&self) -> usize {
        self.block_len
    }

    pub fn new_encryption_context(
        &self,
        mode: OperatingMode,
    ) -> Result<EncryptionContext, Unspecified> {
        match self.id {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => match mode {
                OperatingMode::CBC | OperatingMode::CTR => {
                    Ok(EncryptionContext::Iv128(FixedLength::new()?))
                }
            },
        }
    }

    fn is_valid_encryption_context(&self, mode: OperatingMode, input: &EncryptionContext) -> bool {
        match self.id {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => match mode {
                OperatingMode::CBC | OperatingMode::CTR => {
                    matches!(input, EncryptionContext::Iv128(_))
                }
            },
        }
    }

    fn is_valid_decryption_context(&self, mode: OperatingMode, input: &DecryptionContext) -> bool {
        match self.id {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => match mode {
                OperatingMode::CBC | OperatingMode::CTR => {
                    matches!(input, DecryptionContext::Iv128(_))
                }
            },
        }
    }
}

#[allow(clippy::missing_fields_in_debug)]
impl Debug for UnboundCipherKey {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> Result<(), core::fmt::Error> {
        f.debug_struct("UnboundCipherKey")
            .field("algorithm", &self.algorithm)
            .finish()
    }
}

impl From<hkdf::Okm<'_, &'static Algorithm>> for UnboundCipherKey {
    fn from(okm: hkdf::Okm<&'static Algorithm>) -> Self {
        let mut key_bytes = [0; MAX_CIPHER_KEY_LEN];
        let key_bytes = &mut key_bytes[..okm.len().key_len];
        let algorithm = *okm.len();
        okm.fill(key_bytes).unwrap();
        Self::new(algorithm, key_bytes).unwrap()
    }
}

impl KeyType for &'static Algorithm {
    fn len(&self) -> usize {
        self.key_len
    }
}

/// A key bound to a particular cipher algorithm.
pub struct UnboundCipherKey {
    algorithm: &'static Algorithm,
    pub key: SymmetricCipherKey,
}

impl UnboundCipherKey {
    /// Constructs an [`UnboundCipherKey`].
    ///
    /// # Errors
    ///
    /// * [`Unspecified`] if `key_bytes.len()` does not match the
    /// length required by `algorithm`.
    pub fn new(algorithm: &'static Algorithm, key_bytes: &[u8]) -> Result<Self, Unspecified> {
        let key = match algorithm.id() {
            AlgorithmId::Aes128 => SymmetricCipherKey::aes128(key_bytes),
            AlgorithmId::Aes256 => SymmetricCipherKey::aes256(key_bytes),
        }?;
        Ok(UnboundCipherKey { algorithm, key })
    }

    #[inline]
    #[must_use]
    /// Returns the algorithm associated with this key.
    pub fn algorithm(&self) -> &'static Algorithm {
        self.algorithm
    }

    #[inline]
    #[must_use]
    /// Returns the algorithm associated with this key.
    pub fn key(&mut self) -> &[u8] {
        self.key.print()
    }
}

/// A cipher encryption key that performs block padding.
pub struct PaddedBlockEncryptingKey {
    key: UnboundCipherKey,
    mode: OperatingMode,
    padding: PaddingStrategy,
}

impl PaddedBlockEncryptingKey {
    /// Constructs a new `PaddedBlockEncryptingKey` cipher with chaining block cipher (CBC) mode.
    /// Plaintext data is padded following the PKCS#7 scheme.
    ///
    // # FIPS
    // Use this function with an `UnboundCipherKey` constructed with one of the following algorithms:
    // * `AES_128`
    // * `AES_256`
    //
    /// # Errors
    /// * [`Unspecified`]: Returned if there is an error cosntructing a `PaddedBlockEncryptingKey`.
    pub fn cbc_pkcs7(key: UnboundCipherKey) -> Result<PaddedBlockEncryptingKey, Unspecified> {
        PaddedBlockEncryptingKey::new(key, OperatingMode::CBC, PaddingStrategy::PKCS7)
    }

    #[allow(clippy::unnecessary_wraps)]
    fn new(
        key: UnboundCipherKey,
        mode: OperatingMode,
        padding: PaddingStrategy,
    ) -> Result<PaddedBlockEncryptingKey, Unspecified> {
        Ok(PaddedBlockEncryptingKey { key, mode, padding })
    }

    /// Returns the cipher algorithm.
    #[must_use]
    pub fn algorithm(&self) -> &Algorithm {
        self.key.algorithm()
    }

    /// Returns the cipher operating mode.
    #[must_use]
    pub fn mode(&self) -> OperatingMode {
        self.mode
    }

    /// Pads and encrypts data provided in `in_out` in-place.
    /// Returns a references to the encryted data.
    ///
    /// # Errors
    /// * [`Unspecified`]: Returned if encryption fails.
    pub fn encrypt<InOut>(&self, in_out: &mut InOut) -> Result<DecryptionContext, Unspecified>
    where
        InOut: AsMut<[u8]> + for<'a> Extend<&'a u8>,
    {
        let context = self.key.algorithm.new_encryption_context(self.mode)?;
        self.less_safe_encrypt(in_out, context)
    }

    /// Pads and encrypts data provided in `in_out` in-place.
    /// Returns a references to the encryted data.
    ///
    /// # Errors
    /// * [`Unspecified`]: Returned if encryption fails.
    pub fn less_safe_encrypt<InOut>(
        &self,
        in_out: &mut InOut,
        context: EncryptionContext,
    ) -> Result<DecryptionContext, Unspecified>
    where
        InOut: AsMut<[u8]> + for<'a> Extend<&'a u8>,
    {
        if !self
            .key
            .algorithm()
            .is_valid_encryption_context(self.mode, &context)
        {
            return Err(Unspecified);
        }

        self.padding
            .add_padding(self.algorithm().block_len(), in_out)?;
        encrypt(&self.key, self.mode, in_out.as_mut(), context)
    }
}

impl Debug for PaddedBlockEncryptingKey {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.debug_struct("PaddedBlockEncryptingKey")
            .field("key", &self.key)
            .field("mode", &self.mode)
            .field("padding", &self.padding)
            .finish()
    }
}

/// A cipher decryption key that performs block padding.
pub struct PaddedBlockDecryptingKey {
    key: UnboundCipherKey,
    mode: OperatingMode,
    padding: PaddingStrategy,
}

impl PaddedBlockDecryptingKey {
    /// Constructs a new `PaddedBlockDecryptingKey` cipher with chaining block cipher (CBC) mode.
    /// Decrypted data is unpadded following the PKCS#7 scheme.
    ///
    // # FIPS
    // Use this function with an `UnboundCipherKey` constructed with one of the following algorithms:
    // * `AES_128`
    // * `AES_256`
    //
    /// # Errors
    /// * [`Unspecified`]: Returned if there is an error constructing the `PaddedBlockDecryptingKey`.
    pub fn cbc_pkcs7(key: UnboundCipherKey) -> Result<PaddedBlockDecryptingKey, Unspecified> {
        PaddedBlockDecryptingKey::new(key, OperatingMode::CBC, PaddingStrategy::PKCS7)
    }

    #[allow(clippy::unnecessary_wraps)]
    fn new(
        key: UnboundCipherKey,
        mode: OperatingMode,
        padding: PaddingStrategy,
    ) -> Result<PaddedBlockDecryptingKey, Unspecified> {
        Ok(PaddedBlockDecryptingKey { key, mode, padding })
    }

    /// Returns the cipher algorithm.
    #[must_use]
    pub fn algorithm(&self) -> &Algorithm {
        self.key.algorithm()
    }

    /// Returns the cipher operating mode.
    #[must_use]
    pub fn mode(&self) -> OperatingMode {
        self.mode
    }

    /// Decrypts and unpads data provided in `in_out` in-place.
    /// Returns a references to the decrypted data.
    ///
    /// # Errors
    /// * [`Unspecified`]: Returned if decryption fails.
    pub fn decrypt<'in_out>(
        &self,
        in_out: &'in_out mut [u8],
        context: DecryptionContext,
    ) -> Result<&'in_out mut [u8], Unspecified> {
        if !self
            .key
            .algorithm()
            .is_valid_decryption_context(self.mode, &context)
        {
            return Err(Unspecified);
        }

        let block_len = self.algorithm().block_len();
        let padding = self.padding;
        let mut in_out = decrypt(&self.key, self.mode, in_out, context)?;
        in_out = padding.remove_padding(block_len, in_out)?;
        Ok(in_out)
    }
}

impl Debug for PaddedBlockDecryptingKey {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.debug_struct("PaddedBlockDecryptingKey")
            .field("key", &self.key)
            .field("mode", &self.mode)
            .field("padding", &self.padding)
            .finish()
    }
}

/// A cipher encryption key that does not perform block padding.
pub struct EncryptingKey {
    pub key: UnboundCipherKey,
    mode: OperatingMode,
}

impl EncryptingKey {
    /// Constructs an `EncryptingKey` operating in counter (CTR) mode using the provided key.
    ///
    // # FIPS
    // Use this function with an `UnboundCipherKey` constructed with one of the following algorithms:
    // * `AES_128`
    // * `AES_256`
    //
    /// # Errors
    /// * [`Unspecified`]: Returned if there is an error constructing the `EncryptingKey`.
    pub fn ctr(key: UnboundCipherKey) -> Result<EncryptingKey, Unspecified> {
        EncryptingKey::new(key, OperatingMode::CTR)
    }

    #[allow(clippy::unnecessary_wraps)]
    fn new(key: UnboundCipherKey, mode: OperatingMode) -> Result<EncryptingKey, Unspecified> {
        Ok(EncryptingKey { key, mode })
    }

    /// Returns the cipher algorithm.
    #[must_use]
    pub fn algorithm(&self) -> &Algorithm {
        self.key.algorithm()
    }

    /// Returns the cipher operating mode.
    #[must_use]
    pub fn mode(&self) -> OperatingMode {
        self.mode
    }

    /// Encrypts the data provided in `in_out` in-place.
    /// Returns a references to the decrypted data.
    ///
    /// # Errors
    /// * [`Unspecified`]: Returned if cipher mode requires input to be a multiple of the block length,
    /// and `in_out.len()` is not. Otherwise returned if encryption fails.
    pub fn encrypt(&self, in_out: &mut [u8]) -> Result<DecryptionContext, Unspecified> {
        let context = self.key.algorithm.new_encryption_context(self.mode)?;
        self.less_safe_encrypt(in_out, context)
    }

    /// Encrypts the data provided in `in_out` in-place using the provided `CipherContext`.
    /// Returns a references to the decrypted data.
    ///
    /// # Errors
    /// * [`Unspecified`]: Returned if cipher mode requires input to be a multiple of the block length,
    /// and `in_out.len()` is not. Otherwise returned if encryption fails.
    pub fn less_safe_encrypt(
        &self,
        in_out: &mut [u8],
        context: EncryptionContext,
    ) -> Result<DecryptionContext, Unspecified> {
        if !self
            .key
            .algorithm()
            .is_valid_encryption_context(self.mode, &context)
        {
            return Err(Unspecified);
        }
        encrypt(&self.key, self.mode, in_out, context)
    }
}

impl Debug for EncryptingKey {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.debug_struct("EncryptingKey")
            .field("key", &self.key)
            .field("mode", &self.mode)
            .finish()
    }
}

/// A cipher decryption key that does not perform block padding.
pub struct DecryptingKey {
    key: UnboundCipherKey,
    mode: OperatingMode,
}

impl DecryptingKey {
    /// Constructs a cipher decrypting key operating in counter (CTR) mode using the provided key and context.
    ///
    // # FIPS
    // Use this function with an `UnboundCipherKey` constructed with one of the following algorithms:
    // * `AES_128`
    // * `AES_256`
    //
    /// # Errors
    /// * [`Unspecified`]: Returned if there is an error during decryption.
    pub fn ctr(key: UnboundCipherKey) -> Result<DecryptingKey, Unspecified> {
        DecryptingKey::new(key, OperatingMode::CTR)
    }

    #[allow(clippy::unnecessary_wraps)]
    fn new(key: UnboundCipherKey, mode: OperatingMode) -> Result<DecryptingKey, Unspecified> {
        Ok(DecryptingKey { key, mode })
    }

    /// Returns the cipher algorithm.
    #[must_use]
    pub fn algorithm(&self) -> &Algorithm {
        self.key.algorithm()
    }

    /// Returns the cipher operating mode.
    #[must_use]
    pub fn mode(&self) -> OperatingMode {
        self.mode
    }

    /// Decrypts the data provided in `in_out` in-place.
    /// Returns a references to the decrypted data.
    ///
    /// # Errors
    /// * [`Unspecified`]: Returned if cipher mode requires input to be a multiple of the block length,
    /// and `in_out.len()` is not. Also returned if decryption fails.
    pub fn decrypt<'in_out>(
        &self,
        in_out: &'in_out mut [u8],
        context: DecryptionContext,
    ) -> Result<&'in_out mut [u8], Unspecified> {
        decrypt(&self.key, self.mode, in_out, context)
    }
}

impl Debug for DecryptingKey {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.debug_struct("DecryptingKey")
            .field("key", &self.key)
            .field("mode", &self.mode)
            .finish()
    }
}

fn encrypt(
    key: &UnboundCipherKey,
    mode: OperatingMode,
    in_out: &mut [u8],
    context: EncryptionContext,
) -> Result<DecryptionContext, Unspecified> {
    let block_len = key.algorithm().block_len();

    match mode {
        OperatingMode::CTR => {}
        _ => {
            if (in_out.len() % block_len) != 0 {
                return Err(Unspecified);
            }
        }
    }

    match mode {
        OperatingMode::CBC => match key.algorithm().id() {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => encrypt_aes_cbc_mode(key, context, in_out),
        },
        OperatingMode::CTR => match key.algorithm().id() {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => encrypt_aes_ctr_mode(key, context, in_out),
        },
    }
}

fn decrypt<'in_out>(
    key: &UnboundCipherKey,
    mode: OperatingMode,
    in_out: &'in_out mut [u8],
    context: DecryptionContext,
) -> Result<&'in_out mut [u8], Unspecified> {
    let block_len = key.algorithm().block_len();

    match mode {
        OperatingMode::CTR => {}
        _ => {
            if (in_out.len() % block_len) != 0 {
                return Err(Unspecified);
            }
        }
    }

    match mode {
        OperatingMode::CBC => match key.algorithm().id() {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => decrypt_aes_cbc_mode(key, context, in_out),
        },
        OperatingMode::CTR => match key.algorithm().id() {
            AlgorithmId::Aes128 | AlgorithmId::Aes256 => decrypt_aes_ctr_mode(key, context, in_out),
        },
    }
}

fn encrypt_aes_ctr_mode(
    key: &UnboundCipherKey,
    context: EncryptionContext,
    in_out: &mut [u8],
) -> Result<DecryptionContext, Unspecified> {
    #[allow(clippy::match_wildcard_for_single_variants)]
    let key = match &key.key {
        SymmetricCipherKey::Aes128 { enc_key, .. } | SymmetricCipherKey::Aes256 { enc_key, .. } => {
            enc_key
        }
        _ => return Err(Unspecified),
    };

    let mut iv = {
        let mut iv = [0u8; AES_CTR_IV_LEN];
        iv.copy_from_slice((&context).try_into()?);
        iv
    };

    let mut buffer = [0u8; AES_BLOCK_LEN];

    aes_ctr128_encrypt(key, &mut iv, &mut buffer, in_out);
    iv.zeroize();

    Ok(context.into())
}

fn decrypt_aes_ctr_mode<'in_out>(
    key: &UnboundCipherKey,
    context: DecryptionContext,
    in_out: &'in_out mut [u8],
) -> Result<&'in_out mut [u8], Unspecified> {
    // it's the same in CTR, just providing a nice named wrapper to match
    encrypt_aes_ctr_mode(key, context.into(), in_out).map(|_| in_out)
}

fn encrypt_aes_cbc_mode(
    key: &UnboundCipherKey,
    context: EncryptionContext,
    in_out: &mut [u8],
) -> Result<DecryptionContext, Unspecified> {
    #[allow(clippy::match_wildcard_for_single_variants)]
    let key = match &key.key {
        SymmetricCipherKey::Aes128 { enc_key, .. } | SymmetricCipherKey::Aes256 { enc_key, .. } => {
            enc_key
        }
        _ => return Err(Unspecified),
    };

    let mut iv = {
        let mut iv = [0u8; AES_CBC_IV_LEN];
        iv.copy_from_slice((&context).try_into()?);
        iv
    };

    aes_cbc_encrypt(key, &mut iv, in_out);
    iv.zeroize();

    Ok(context.into())
}

#[allow(clippy::needless_pass_by_value)]
fn decrypt_aes_cbc_mode<'in_out>(
    key: &UnboundCipherKey,
    context: DecryptionContext,
    in_out: &'in_out mut [u8],
) -> Result<&'in_out mut [u8], Unspecified> {
    #[allow(clippy::match_wildcard_for_single_variants)]
    let key = match &key.key {
        SymmetricCipherKey::Aes128 { dec_key, .. } | SymmetricCipherKey::Aes256 { dec_key, .. } => {
            dec_key
        }
        _ => return Err(Unspecified),
    };

    let mut iv = {
        let mut iv = [0u8; AES_CBC_IV_LEN];
        iv.copy_from_slice((&context).try_into()?);
        iv
    };

    aes_cbc_decrypt(key, &mut iv, in_out);
    iv.zeroize();

    Ok(in_out)
}

fn aes_ctr128_encrypt(key: &AES_KEY, iv: &mut [u8], block_buffer: &mut [u8], in_out: &mut [u8]) {
    let mut num = MaybeUninit::<u32>::new(0);

    indicator_check!(unsafe {
        AES_ctr128_encrypt(
            in_out.as_ptr(),
            in_out.as_mut_ptr(),
            in_out.len(),
            key,
            iv.as_mut_ptr(),
            block_buffer.as_mut_ptr(),
            num.as_mut_ptr(),
        );
    });

    Zeroize::zeroize(block_buffer);
}

fn aes_cbc_encrypt(key: &AES_KEY, iv: &mut [u8], in_out: &mut [u8]) {
    indicator_check!(unsafe {
        AES_cbc_encrypt(
            in_out.as_ptr(),
            in_out.as_mut_ptr(),
            in_out.len(),
            key,
            iv.as_mut_ptr(),
            AES_ENCRYPT,
        );
    });
}

fn aes_cbc_decrypt(key: &AES_KEY, iv: &mut [u8], in_out: &mut [u8]) {
    indicator_check!(unsafe {
        AES_cbc_encrypt(
            in_out.as_ptr(),
            in_out.as_mut_ptr(),
            in_out.len(),
            key,
            iv.as_mut_ptr(),
            AES_DECRYPT,
        );
    });
}
