// Copyright 2018 Brian Smith.
// SPDX-License-Identifier: ISC
// Modifications copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0 OR ISC

/// An array of 16 bytes that can (in the `x86_64` and `AAarch64` ABIs, at least)
/// be efficiently passed by value and returned by value (i.e. in registers),
/// and which meets the alignment requirements of `u32` and `u64` (at least)
/// for the target.
#[repr(C)]
#[derive(Copy, Clone)]
pub(crate) struct Block {
    subblocks: [u64; 2],
}

/// Block length
pub(crate) const BLOCK_LEN: usize = 16;

impl Block {
    #[inline]
    pub(crate) fn zero() -> Self {
        Self { subblocks: [0, 0] }
    }
}

impl From<&'_ [u8; BLOCK_LEN]> for Block {
    #[inline]
    fn from(bytes: &[u8; BLOCK_LEN]) -> Self {
        unsafe { core::mem::transmute_copy(bytes) }
    }
}

impl AsRef<[u8; BLOCK_LEN]> for Block {
    #[allow(clippy::transmute_ptr_to_ptr)]
    #[inline]
    fn as_ref(&self) -> &[u8; BLOCK_LEN] {
        unsafe { core::mem::transmute(self) }
    }
}
