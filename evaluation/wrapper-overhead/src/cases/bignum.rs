use std::hint::black_box;

use crate::cases::crypto::{bytes, key_schedule, words};
use crate::harness::{Calls, Case};
use crate::wrappers::*;

fn limbs(n: usize, seed: u64) -> Vec<u64> {
    (0..n).map(|i| (i as u64 + seed).wrapping_mul(0x9e37_79b9_7f4a_7c15)).collect()
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "bignum_neg_p25519",
            build: |_| {
                use bignum_neg_p25519::*;
                #[derive(Clone)]
                struct State {
                    z: [u64; 4],
                    x: [u64; 4],
                }
                Calls::new(
                    State { z: [0; 4], x: words::<4>(1) },
                    64,
                    |s| annotated(black_box(&mut s.z), black_box(&s.x)),
                    |s| raw(black_box(&mut s.z), black_box(&s.x)),
                )
            },
        },
        Case {
            function: "bignum_madd_n25519_alt",
            build: |_| {
                use bignum_madd_n25519_alt::*;
                #[derive(Clone)]
                struct State {
                    z: [u64; 4],
                    x: [u64; 4],
                    y: [u64; 4],
                    c: [u64; 4],
                }
                Calls::new(
                    State { z: [0; 4], x: words::<4>(1), y: words::<4>(2), c: words::<4>(3) },
                    128,
                    |s| annotated(black_box(&mut s.z), black_box(&s.x), black_box(&s.y), black_box(&s.c)),
                    |s| raw(black_box(&mut s.z), black_box(&s.x), black_box(&s.y), black_box(&s.c)),
                )
            },
        },
        Case {
            function: "bignum_emontredc_8n",
            build: |size| {
                use bignum_emontredc_8n::*;
                #[derive(Clone)]
                struct State {
                    z: Vec<u64>,
                    m: Vec<u64>,
                }
                let k = size.pick(8, 64, 256);
                Calls::new(
                    State { z: limbs(2 * k, 4), m: limbs(k, 5) },
                    24 * k,
                    |s| {
                        black_box(annotated(black_box(&mut s.z), black_box(&s.m), black_box(0x1234_5678_9abc_def1)));
                    },
                    |s| {
                        black_box(raw(black_box(&mut s.z), black_box(&s.m), black_box(0x1234_5678_9abc_def1)));
                    },
                )
            },
        },
        Case {
            function: "bignum_mod_n25519",
            build: |size| {
                use bignum_mod_n25519::*;
                #[derive(Clone)]
                struct State {
                    z: [u64; 4],
                    x: Vec<u64>,
                }
                let k = size.pick(0, 128, 2048);
                Calls::new(
                    State { z: [0; 4], x: limbs(k, 6) },
                    32 + 8 * k,
                    |s| annotated(black_box(&mut s.z), black_box(&s.x)),
                    |s| raw(black_box(&mut s.z), black_box(&s.x)),
                )
            },
        },
        Case {
            function: "aes_hw_xts_encrypt",
            build: |size| {
                use aes_hw_xts_encrypt::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    key1: ([u32; 60], u32),
                    key2: ([u32; 60], u32),
                    key1_c: key1_struct,
                    key2_c: key2_struct,
                    iv: [u8; 16],
                }
                let len = size.pick(16, 1024, 16384);
                let key1 = key_schedule(10);
                let key2 = key_schedule(14);
                let state = State {
                    input: bytes(len, 9),
                    output: vec![0; len],
                    key1,
                    key2,
                    key1_c: key1_as_struct(&key1),
                    key2_c: key2_as_struct(&key2),
                    iv: [4; 16],
                };
                Calls::new(
                    state,
                    2 * len + 2 * 244 + 16,
                    |s| annotated(black_box(&s.input), black_box(&mut s.output), black_box(&s.key1), black_box(&s.key2), black_box(&s.iv)),
                    |s| raw(black_box(&s.input), black_box(&mut s.output), black_box(&s.key1_c), black_box(&s.key2_c), black_box(&s.iv)),
                )
            },
        },
    ]
}
