// Copyright 2018 Brian Smith.
// SPDX-License-Identifier: ISC
// Modifications copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0 OR ISC
#![allow(dead_code)]

//! Initialization Vector (IV) cryptographic primitives

use aws_lc_rs::error::Unspecified;
use aws_lc_rs::rand;
use zeroize::Zeroize;

/// Length of a 128-bit IV in bytes.
pub const IV_LEN_128_BIT: usize = 16;

/// An initialization vector that must be unique for the lifetime of the associated key
/// it is used with.
#[derive(Debug)]
pub struct FixedLength<const L: usize>([u8; L]);

impl<const L: usize> FixedLength<L> {
    /// Returns the size of the iv in bytes.
    #[allow(clippy::must_use_candidate)]
    pub fn size(&self) -> usize {
        L
    }

    /// Constructs a new [`FixedLength`] from pseudo-random bytes.
    ///
    /// # Errors
    ///
    /// * [`Unspecified`]: Returned if there is a failure generating `L` bytes.
    pub fn new() -> Result<Self, Unspecified> {
        let mut iv_bytes = [0u8; L];
        rand::fill(&mut iv_bytes)?;
        Ok(Self(iv_bytes))
    }
}

impl<const L: usize> Drop for FixedLength<L> {
    fn drop(&mut self) {
        self.0.zeroize();
    }
}

impl<const L: usize> AsRef<[u8; L]> for FixedLength<L> {
    #[inline]
    fn as_ref(&self) -> &[u8; L] {
        &self.0
    }
}

impl<const L: usize> From<&[u8; L]> for FixedLength<L> {
    #[inline]
    fn from(bytes: &[u8; L]) -> Self {
        FixedLength(bytes.to_owned())
    }
}

impl<const L: usize> From<[u8; L]> for FixedLength<L> {
    #[inline]
    fn from(bytes: [u8; L]) -> Self {
        FixedLength(bytes)
    }
}

impl<const L: usize> TryFrom<&[u8]> for FixedLength<L> {
    type Error = Unspecified;

    fn try_from(value: &[u8]) -> Result<Self, Self::Error> {
        let value: &[u8; L] = value.try_into()?;
        Ok(Self::from(*value))
    }
}

impl<const L: usize> TryFrom<FixedLength<L>> for [u8; L] {
    type Error = Unspecified;

    fn try_from(value: FixedLength<L>) -> Result<Self, Self::Error> {
        Ok(value.0)
    }
}
