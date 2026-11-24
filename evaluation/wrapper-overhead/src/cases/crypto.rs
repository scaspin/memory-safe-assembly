use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

pub fn bytes(n: usize, seed: u8) -> Vec<u8> {
    (0..n).map(|i| (i as u8).wrapping_mul(31).wrapping_add(seed)).collect()
}

pub fn words<const N: usize>(seed: u64) -> [u64; N] {
    let mut out = [0u64; N];
    for (i, w) in out.iter_mut().enumerate() {
        *w = (i as u64 + seed).wrapping_mul(0x9e37_79b9_7f4a_7c15);
    }
    out
}

pub fn key_schedule(rounds: u32) -> ([u32; 60], u32) {
    let mut words = [0u32; 60];
    for (i, w) in words.iter_mut().enumerate() {
        *w = (i as u32).wrapping_mul(0x9e37_79b9);
    }
    (words, rounds)
}

fn htable() -> [u128; 16] {
    let mut table = [0u128; 16];
    for (i, h) in table.iter_mut().enumerate() {
        *h = (i as u128 + 1).wrapping_mul(0x9e37_79b9_7f4a_7c15_f39c_c060_5ced_c834);
    }
    table
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "KeccakF1600_hw",
            build: |_| {
                use KeccakF1600_hw::*;
                Calls::new(words::<25>(1), 200, |s| annotated(black_box(s)), |s| raw(black_box(s)))
            },
        },
        Case {
            function: "gcm_gmult_neon",
            build: |_| {
                use gcm_gmult_neon::*;
                #[derive(Clone)]
                struct State {
                    context: [u8; 16],
                    h: [u128; 16],
                }
                Calls::new(
                    State { context: [3; 16], h: htable() },
                    16 + 256,
                    |s| annotated(black_box(&mut s.context), black_box(&s.h)),
                    |s| raw(black_box(&mut s.context), black_box(&s.h)),
                )
            },
        },
        Case {
            function: "mldsa_ntt_aarch64_asm",
            build: |_| {
                use mldsa_ntt_aarch64_asm::*;
                #[derive(Clone)]
                struct State {
                    r: [i32; 256],
                    l123456: [i32; 144],
                    l78: [i32; 384],
                }
                let mut state = State { r: [0; 256], l123456: [0; 144], l78: [0; 384] };
                for (i, v) in state.r.iter_mut().enumerate() {
                    *v = (i as i32 * 7919) % 8380417;
                }
                for (i, v) in state.l123456.iter_mut().enumerate() {
                    *v = (i as i32 * 104729) % 8380417;
                }
                for (i, v) in state.l78.iter_mut().enumerate() {
                    *v = (i as i32 * 1299709) % 8380417;
                }
                Calls::new(
                    state,
                    4 * (256 + 144 + 384),
                    |s| annotated(black_box(&mut s.r), black_box(&s.l123456), black_box(&s.l78)),
                    |s| raw(black_box(&mut s.r), black_box(&s.l123456), black_box(&s.l78)),
                )
            },
        },
        Case {
            function: "md5_block_asm_data_order",
            build: |size| {
                use md5_block_asm_data_order::*;
                #[derive(Clone)]
                struct State {
                    context: [u32; 16],
                    input: Vec<u8>,
                }
                let len = size.pick(64, 1024, 16384);
                Calls::new(
                    State { context: [0x6745_2301; 16], input: bytes(len, 2) },
                    len + 64,
                    |s| annotated(black_box(&mut s.context), black_box(&s.input)),
                    |s| raw(black_box(&mut s.context), black_box(&s.input)),
                )
            },
        },
        Case {
            function: "sha512_block_data_order_hw",
            build: |size| {
                use sha512_block_data_order_hw::*;
                #[derive(Clone)]
                struct State {
                    context: [u64; 8],
                    input: Vec<u8>,
                }
                let len = size.pick(128, 1024, 16384);
                Calls::new(
                    State { context: words::<8>(3), input: bytes(len, 3) },
                    len + 64,
                    |s| annotated(black_box(&mut s.context), black_box(&s.input)),
                    |s| raw(black_box(&mut s.context), black_box(&s.input)),
                )
            },
        },
        Case {
            function: "aes_hw_encrypt",
            build: |_| {
                use aes_hw_encrypt::*;
                #[derive(Clone)]
                struct State {
                    input: [u8; 16],
                    output: [u8; 16],
                    keys: ([u32; 60], u32),
                    keys_c: keys_struct,
                }
                let keys = key_schedule(10);
                Calls::new(
                    State { input: [5; 16], output: [0; 16], keys, keys_c: keys_as_struct(&keys) },
                    32 + 244,
                    |s| annotated(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys)),
                    |s| raw(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys_c)),
                )
            },
        },
        Case {
            function: "aes_hw_set_encrypt_key",
            build: |size| {
                use aes_hw_set_encrypt_key::*;
                #[derive(Clone)]
                struct State {
                    user_key: Vec<u8>,
                    bits: usize,
                    key: [u32; 61],
                }
                let bits = size.pick(128, 192, 256);
                Calls::new(
                    State { user_key: bytes(bits / 8, 4), bits, key: [0; 61] },
                    bits / 8 + 244,
                    |s| {
                        black_box(annotated(black_box(&s.user_key), black_box(s.bits), black_box(&mut s.key)));
                    },
                    |s| {
                        black_box(raw(black_box(&s.user_key), black_box(s.bits), black_box(&mut s.key)));
                    },
                )
            },
        },
        Case {
            function: "vpaes_encrypt",
            build: |_| {
                use vpaes_encrypt::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    keys: ([u32; 60], u32),
                    keys_c: keys_struct,
                }
                let keys = key_schedule(9);
                Calls::new(
                    State { input: bytes(16, 5), output: vec![0; 16], keys, keys_c: keys_as_struct(&keys) },
                    32 + 244,
                    |s| annotated(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys)),
                    |s| raw(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys_c)),
                )
            },
        },
        Case {
            function: "aes_hw_ctr32_encrypt_blocks",
            build: |size| {
                use aes_hw_ctr32_encrypt_blocks::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    keys: ([u32; 60], u32),
                    keys_c: keys_struct,
                    ivec: [u8; 16],
                }
                let len = size.pick(16, 1024, 16384);
                let keys = key_schedule(10);
                Calls::new(
                    State { input: bytes(len, 6), output: vec![0; len], keys, keys_c: keys_as_struct(&keys), ivec: [9; 16] },
                    2 * len + 244 + 16,
                    |s| annotated(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys), black_box(&mut s.ivec)),
                    |s| raw(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys_c), black_box(&mut s.ivec)),
                )
            },
        },
        Case {
            function: "aesv8_gcm_8x_enc_128",
            build: |size| {
                use aesv8_gcm_8x_enc_128::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    xi: [u8; 16],
                    ivec: [u8; 16],
                    keys: ([u32; 60], u32),
                    keys_c: keys_struct,
                    htable: [u128; 16],
                }
                let len = size.pick(144, 1024, 16384);
                let keys = key_schedule(10);
                let state = State {
                    input: bytes(len, 7),
                    output: vec![0; len],
                    xi: [1; 16],
                    ivec: [2; 16],
                    keys,
                    keys_c: keys_as_struct(&keys),
                    htable: htable(),
                };
                Calls::new(
                    state,
                    2 * len + 32 + 244 + 256,
                    |s| {
                        black_box(annotated(
                            black_box(&s.input),
                            black_box(&mut s.output),
                            black_box(&mut s.xi),
                            black_box(&mut s.ivec),
                            black_box(&s.keys),
                            black_box(&s.htable),
                        ));
                    },
                    |s| {
                        black_box(raw(
                            black_box(&s.input),
                            black_box(&mut s.output),
                            black_box(&mut s.xi),
                            black_box(&mut s.ivec),
                            black_box(&s.keys_c),
                            black_box(&s.htable),
                        ));
                    },
                )
            },
        },
        Case {
            function: "aes_hw_cbc_encrypt",
            build: |size| {
                use aes_hw_cbc_encrypt::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    keys: ([u32; 60], u32),
                    keys_c: keys_struct,
                    ivec: [u8; 16],
                }
                let len = size.pick(16, 1024, 16384);
                let keys = key_schedule(10);
                let state = State { input: bytes(len, 1), output: vec![0; len], keys, keys_c: keys_as_struct(&keys), ivec: [7; 16] };
                Calls::new(
                    state,
                    len,
                    |s| annotated(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys), black_box(&mut s.ivec), black_box(1)),
                    |s| raw(black_box(&s.input), black_box(&mut s.output), black_box(&s.keys_c), black_box(&mut s.ivec), black_box(1)),
                )
            },
        },
        Case {
            function: "aes_gcm_enc_kernel",
            build: |size| {
                use aes_gcm_enc_kernel::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    xi: [u8; 16],
                    ivec: [u8; 16],
                    keys: ([u32; 60], u32),
                    keys_c: keys_struct,
                    htable: [u128; 16],
                }
                let len = size.pick(80, 1024, 16384);
                let keys = key_schedule(10);
                let state = State {
                    input: bytes(len, 8),
                    output: vec![0; len],
                    xi: [1; 16],
                    ivec: [2; 16],
                    keys,
                    keys_c: keys_as_struct(&keys),
                    htable: htable(),
                };
                Calls::new(
                    state,
                    2 * len + 32 + 244 + 256,
                    |s| {
                        annotated(
                            black_box(&s.input),
                            black_box(&mut s.output),
                            black_box(&mut s.xi),
                            black_box(&mut s.ivec),
                            black_box(&s.keys),
                            black_box(&s.htable),
                        )
                    },
                    |s| {
                        raw(
                            black_box(&s.input),
                            black_box(&mut s.output),
                            black_box(&mut s.xi),
                            black_box(&mut s.ivec),
                            black_box(&s.keys_c),
                            black_box(&s.htable),
                        )
                    },
                )
            },
        },
    ]
}
