use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

#[derive(Clone, Copy)]
#[repr(align(64))]
struct Aligned<T>(T);

fn bytes(n: usize, seed: u8) -> Vec<u8> {
    (0..n).map(|i| (i as u8).wrapping_mul(31).wrapping_add(seed)).collect()
}

fn array<const N: usize>(seed: u8) -> [u8; N] {
    let mut out = [0u8; N];
    for (i, b) in out.iter_mut().enumerate() {
        *b = (i as u8).wrapping_mul(17).wrapping_add(seed);
    }
    out
}

fn key_schedule(rounds_field: u32) -> ([u32; 60], u32) {
    let mut words = [0u32; 60];
    for (i, w) in words.iter_mut().enumerate() {
        *w = (i as u32).wrapping_mul(0x9e37_79b9);
    }
    (words, rounds_field)
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "ccmlkem_ntt_forward",
            build: |_| {
                use ccmlkem_ntt_forward::*;
                let mut coeffs = [0i16; 256];
                for (i, c) in coeffs.iter_mut().enumerate() {
                    *c = (i as i16 * 13) % 3329;
                }
                Calls::new(coeffs, 512, |s| annotated(black_box(s)), |s| raw(black_box(s)))
            },
        },
        Case {
            function: "gcm_init",
            build: |_| {
                use gcm_init::*;
                #[derive(Clone)]
                struct State {
                    htable: [u8; 256],
                    h: [u8; 16],
                }
                let state = State { htable: [0; 256], h: array(3) };
                Calls::new(
                    state,
                    272,
                    |s| annotated(black_box(&mut s.htable), black_box(&s.h)),
                    |s| raw(black_box(&mut s.htable), black_box(&s.h)),
                )
            },
        },
        Case {
            function: "ccn_mulmod_p224",
            build: |_| {
                use ccn_mulmod_p224::*;
                #[derive(Clone)]
                struct State {
                    r: [u64; 4],
                    a: [u64; 4],
                    b: [u64; 4],
                }
                let state = State { r: [0; 4], a: [1, 2, 3, 4], b: [5, 6, 7, 8] };
                Calls::new(
                    state,
                    96,
                    |s| annotated(black_box(&mut s.r), black_box(&s.a), black_box(&s.b)),
                    |s| raw(black_box(&mut s.r), black_box(&s.a), black_box(&s.b)),
                )
            },
        },
        Case {
            function: "gcm_ghash",
            build: |size| {
                use gcm_ghash::*;
                #[derive(Clone)]
                struct State {
                    x: [u8; 16],
                    htable: [u8; 256],
                    input: Vec<u8>,
                }
                let len = size.pick(0, 1024, 16384);
                let state = State { x: array(1), htable: array(2), input: bytes(len, 3) };
                Calls::new(
                    state,
                    len + 272,
                    |s| annotated(black_box(&mut s.x), black_box(&s.htable), black_box(&s.input)),
                    |s| raw(black_box(&mut s.x), black_box(&s.htable), black_box(&s.input)),
                )
            },
        },
        Case {
            function: "ccaes_arm_encrypt_key",
            build: |_| {
                use ccaes_arm_encrypt_key::*;
                #[derive(Clone)]
                struct State {
                    ctx: ([u32; 60], u32),
                    ctx_c: Aligned<ctx_struct>,
                    rawkey: Vec<u8>,
                }
                let ctx = key_schedule(0);
                let state = State { ctx, ctx_c: Aligned(ctx_as_struct(&ctx)), rawkey: bytes(32, 5) };
                Calls::new(
                    state,
                    276,
                    |s| {
                        black_box(annotated(black_box(1), black_box(&mut s.ctx), black_box(&s.rawkey)));
                    },
                    |s| {
                        black_box(raw(black_box(1), black_box(&mut s.ctx_c.0), black_box(&s.rawkey)));
                    },
                )
            },
        },
        Case {
            function: "AccelerateCrypto_AES_encrypt",
            build: |_| {
                use AccelerateCrypto_AES_encrypt::*;
                #[derive(Clone)]
                struct State {
                    input: [u8; 16],
                    output: [u8; 16],
                    key: ([u32; 60], u32),
                    key_c: Aligned<key_struct>,
                }
                let key = key_schedule(160);
                let state = State { input: array(1), output: [0; 16], key, key_c: Aligned(key_as_struct(&key)) };
                Calls::new(
                    state,
                    32,
                    |s| {
                        black_box(annotated(black_box(&s.input), black_box(&mut s.output), black_box(&s.key)));
                    },
                    |s| {
                        black_box(raw(black_box(&s.input), black_box(&mut s.output), black_box(&s.key_c.0)));
                    },
                )
            },
        },
        Case {
            function: "ccaes_arm_encrypt_cbc",
            build: |size| {
                use ccaes_arm_encrypt_cbc::*;
                #[derive(Clone)]
                struct State {
                    key: ([u32; 60], u32),
                    key_c: Aligned<key_struct>,
                    iv: [u8; 16],
                    nblocks: usize,
                    input: Vec<u8>,
                    output: Vec<u8>,
                }
                let nblocks = size.pick(0, 64, 1024);
                let key = key_schedule(160);
                let state = State {
                    key,
                    key_c: Aligned(key_as_struct(&key)),
                    iv: array(9),
                    nblocks,
                    input: bytes(16 * nblocks, 1),
                    output: vec![0; 16 * nblocks],
                };
                Calls::new(
                    state,
                    32 * nblocks,
                    |s| {
                        black_box(annotated(
                            black_box(&s.key),
                            black_box(&mut s.iv),
                            black_box(s.nblocks),
                            black_box(&s.input),
                            black_box(&mut s.output),
                        ));
                    },
                    |s| {
                        black_box(raw(
                            black_box(&s.key_c.0),
                            black_box(&mut s.iv),
                            black_box(s.nblocks),
                            black_box(&s.input),
                            black_box(&mut s.output),
                        ));
                    },
                )
            },
        },
        Case {
            function: "aes_ctr_crypt",
            build: |size| {
                use aes_ctr_crypt::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    ctr: [u8; 16],
                    key: ([u32; 60], u32),
                    key_c: Aligned<key_struct>,
                }
                let len = size.pick(0, 1024, 16384);
                let key = key_schedule(160);
                let state = State { input: bytes(len, 1), output: vec![0; len], ctr: array(4), key, key_c: Aligned(key_as_struct(&key)) };
                Calls::new(
                    state,
                    2 * len,
                    |s| annotated(black_box(&s.input), black_box(&mut s.output), black_box(&mut s.ctr), black_box(&s.key)),
                    |s| raw(black_box(&s.input), black_box(&mut s.output), black_box(&mut s.ctr), black_box(&s.key_c.0)),
                )
            },
        },
        Case {
            function: "AccelerateCrypto_ecb_AES_encrypt",
            build: |size| {
                use AccelerateCrypto_ecb_AES_encrypt::*;
                #[derive(Clone)]
                struct State {
                    key: ([u32; 60], u32),
                    key_c: Aligned<key_struct>,
                    nblocks: usize,
                    input: Vec<u8>,
                    output: Vec<u8>,
                }
                let nblocks = size.pick(0, 64, 1024);
                let key = key_schedule(160);
                let state = State {
                    key,
                    key_c: Aligned(key_as_struct(&key)),
                    nblocks,
                    input: bytes(16 * nblocks, 1),
                    output: vec![0; 16 * nblocks],
                };
                Calls::new(
                    state,
                    32 * nblocks,
                    |s| {
                        black_box(annotated(black_box(&s.key), black_box(s.nblocks), black_box(&s.input), black_box(&mut s.output)));
                    },
                    |s| {
                        black_box(raw(black_box(&s.key_c.0), black_box(s.nblocks), black_box(&s.input), black_box(&mut s.output)));
                    },
                )
            },
        },
        Case {
            function: "ccaes_xts_encrypt_vng_vector",
            build: |size| {
                use ccaes_xts_encrypt_vng_vector::*;
                #[derive(Clone)]
                struct State {
                    output: Vec<u8>,
                    input: Vec<u8>,
                    tweak: [u64; 2],
                    nblocks: usize,
                    key: ([u32; 60], u32),
                    key_c: Aligned<key_struct>,
                }
                let nblocks = size.pick(0, 64, 1024);
                let key = key_schedule(160);
                let state = State {
                    output: vec![0; 16 * nblocks],
                    input: bytes(16 * nblocks, 1),
                    tweak: [3, 5],
                    nblocks,
                    key,
                    key_c: Aligned(key_as_struct(&key)),
                };
                Calls::new(
                    state,
                    32 * nblocks,
                    |s| {
                        annotated(
                            black_box(&mut s.output),
                            black_box(&s.input),
                            black_box(&mut s.tweak),
                            black_box(s.nblocks),
                            black_box(&s.key),
                        )
                    },
                    |s| {
                        raw(
                            black_box(&mut s.output),
                            black_box(&s.input),
                            black_box(&mut s.tweak),
                            black_box(s.nblocks),
                            black_box(&s.key_c.0),
                        )
                    },
                )
            },
        },
        Case {
            function: "ccm128_encrypt",
            build: |size| {
                use ccm128_encrypt::*;
                #[derive(Clone)]
                struct State {
                    input: Vec<u8>,
                    output: Vec<u8>,
                    tag: [u8; 16],
                    nblocks: usize,
                    key: ([u32; 60], u32),
                    key_c: Aligned<key_struct>,
                    ctr: [u8; 16],
                }
                let nblocks = size.pick(1, 64, 1024);
                let key = key_schedule(160);
                let state = State {
                    input: bytes(16 * nblocks, 1),
                    output: vec![0; 16 * nblocks],
                    tag: array(2),
                    nblocks,
                    key,
                    key_c: Aligned(key_as_struct(&key)),
                    ctr: array(6),
                };
                Calls::new(
                    state,
                    32 * nblocks,
                    |s| {
                        annotated(
                            black_box(&s.input),
                            black_box(&mut s.output),
                            black_box(&mut s.tag),
                            black_box(s.nblocks),
                            black_box(&s.key),
                            black_box(&mut s.ctr),
                            black_box(4),
                        )
                    },
                    |s| {
                        raw(
                            black_box(&s.input),
                            black_box(&mut s.output),
                            black_box(&mut s.tag),
                            black_box(s.nblocks),
                            black_box(&s.key_c.0),
                            black_box(&mut s.ctr),
                            black_box(4),
                        )
                    },
                )
            },
        },
    ]
}
