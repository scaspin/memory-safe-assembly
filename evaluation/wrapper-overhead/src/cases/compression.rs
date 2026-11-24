use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

fn bytes(n: usize, seed: u8) -> Vec<u8> {
    (0..n).map(|i| (i as u8).wrapping_mul(31).wrapping_add(seed)).collect()
}

struct SlideState {
    s: ([u8; 64], u32, [u8; 28], usize, usize),
    s_c: slide_hash_neon::s_struct,
    prev: Vec<u16>,
    head: Vec<u16>,
    w_size: u32,
}

impl SlideState {
    fn new(w_size: u32, prev: Vec<u16>, head: Vec<u16>) -> SlideState {
        let s = ([0u8; 64], w_size, [0u8; 28], 0usize, 0usize);
        let mut state = SlideState { s, s_c: slide_hash_neon::s_as_struct(&s), prev, head, w_size };
        state.s.3 = state.prev.as_mut_ptr() as usize;
        state.s.4 = state.head.as_mut_ptr() as usize;
        state.s_c = slide_hash_neon::s_as_struct(&state.s);
        state
    }
}

impl Clone for SlideState {
    fn clone(&self) -> SlideState {
        SlideState::new(self.w_size, self.prev.clone(), self.head.clone())
    }
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "compare256_neon",
            build: |_| {
                use compare256_neon::*;
                #[derive(Clone)]
                struct State {
                    src0: Vec<u8>,
                    src1: Vec<u8>,
                }
                let src0 = bytes(256, 1);
                let mut src1 = src0.clone();
                src1[200] ^= 1;
                Calls::new(
                    State { src0, src1 },
                    512,
                    |s| {
                        black_box(annotated(black_box(&s.src0), black_box(&s.src1)));
                    },
                    |s| {
                        black_box(raw(black_box(&s.src0), black_box(&s.src1)));
                    },
                )
            },
        },
        Case {
            function: "crc32_gzip_refl_pmull",
            build: |size| {
                use crc32_gzip_refl_pmull::*;
                let len = size.pick(0, 1024, 32768);
                Calls::new(
                    bytes(len, 2),
                    len,
                    |s| {
                        black_box(annotated(black_box(7), black_box(s), black_box(s.len())));
                    },
                    |s| {
                        black_box(raw(black_box(7), black_box(s), black_box(s.len())));
                    },
                )
            },
        },
        Case {
            function: "crc32_fold_armv8",
            build: |size| {
                use crc32_fold_armv8::*;
                #[derive(Clone)]
                struct State {
                    crc: ([u8; 64], u32),
                    crc_c: crc_struct,
                    src: Vec<u8>,
                }
                let len = size.pick(0, 1024, 32768);
                let crc = ([0u8; 64], 0u32);
                let state = State { crc, crc_c: crc_as_struct(&crc), src: bytes(len, 3) };
                Calls::new(
                    state,
                    len + 68,
                    |s| annotated(black_box(&mut s.crc), black_box(&s.src), black_box(s.src.len()), black_box(0)),
                    |s| raw(black_box(&mut s.crc_c), black_box(&s.src), black_box(s.src.len()), black_box(0)),
                )
            },
        },
        Case {
            function: "crc32_fold_copy_armv8",
            build: |size| {
                use crc32_fold_copy_armv8::*;
                #[derive(Clone)]
                struct State {
                    crc: ([u8; 64], u32),
                    crc_c: crc_struct,
                    dst: Vec<u8>,
                    src: Vec<u8>,
                }
                let len = size.pick(0, 512, 16384);
                let crc = ([0u8; 64], 0u32);
                let state = State { crc, crc_c: crc_as_struct(&crc), dst: vec![0; len], src: bytes(len, 4) };
                Calls::new(
                    state,
                    2 * len + 68,
                    |s| annotated(black_box(&mut s.crc), black_box(&mut s.dst), black_box(&s.src), black_box(s.src.len())),
                    |s| raw(black_box(&mut s.crc_c), black_box(&mut s.dst), black_box(&s.src), black_box(s.src.len())),
                )
            },
        },
        Case {
            function: "slide_hash_neon",
            build: |size| {
                use slide_hash_neon::*;
                let w_size: u32 = size.pick(256, 4096, 32768);
                let prev: Vec<u16> = (0..w_size as usize).map(|i| (i * 7) as u16).collect();
                let head: Vec<u16> = (0..65536usize).map(|i| (i * 13) as u16).collect();
                let state = SlideState::new(w_size, prev, head);
                Calls::new(
                    state,
                    2 * (w_size as usize + 65536) + 112,
                    |s| annotated(black_box(&mut s.s), black_box(&mut s.prev), black_box(&mut s.head), black_box(s.w_size)),
                    |s| raw(black_box(&mut s.s_c), black_box(&mut s.prev), black_box(&mut s.head), black_box(s.w_size)),
                )
            },
        },
        Case {
            function: "gf_vect_mul_neon",
            build: |size| {
                use gf_vect_mul_neon::*;
                #[derive(Clone)]
                struct State {
                    gftbl: Vec<u8>,
                    src: Vec<u8>,
                    dest: Vec<u8>,
                }
                let len = size.pick(32, 512, 16384);
                let state = State { gftbl: bytes(32, 5), src: bytes(len, 6), dest: vec![0; len] };
                Calls::new(
                    state,
                    2 * len + 32,
                    |s| {
                        black_box(annotated(black_box(s.src.len()), black_box(&s.gftbl), black_box(&s.src), black_box(&mut s.dest)));
                    },
                    |s| {
                        black_box(raw(black_box(s.src.len()), black_box(&s.gftbl), black_box(&s.src), black_box(&mut s.dest)));
                    },
                )
            },
        },
        Case {
            function: "gf_2vect_dot_prod_neon",
            build: |size| {
                use gf_2vect_dot_prod_neon::*;
                #[derive(Clone)]
                struct State {
                    len: usize,
                    gftbls: Vec<u8>,
                    src: Vec<Vec<u8>>,
                    dest: Vec<Vec<u8>>,
                }
                let len = size.pick(16, 256, 8192);
                let vlen = 2;
                let state = State {
                    len,
                    gftbls: bytes(32 * vlen * 2, 7),
                    src: (0..vlen).map(|i| bytes(len, i as u8)).collect(),
                    dest: vec![vec![0; len]; 2],
                };
                Calls::new(
                    state,
                    4 * len + 128,
                    |s| {
                        let src = [&s.src[0][..], &s.src[1][..]];
                        let (d0, d1) = s.dest.split_at_mut(1);
                        let mut dest = [&mut d0[0][..], &mut d1[0][..]];
                        annotated(black_box(s.len), black_box(2), black_box(&s.gftbls), black_box(&src), black_box(&mut dest))
                    },
                    |s| {
                        let src = [&s.src[0][..], &s.src[1][..]];
                        let (d0, d1) = s.dest.split_at_mut(1);
                        let mut dest = [&mut d0[0][..], &mut d1[0][..]];
                        raw(black_box(s.len), black_box(2), black_box(&s.gftbls), black_box(&src), black_box(&mut dest))
                    },
                )
            },
        },
        Case {
            function: "gf_2vect_mad_neon",
            build: |size| {
                use gf_2vect_mad_neon::*;
                #[derive(Clone)]
                struct State {
                    gftbls: Vec<u8>,
                    src: Vec<u8>,
                    dest: Vec<Vec<u8>>,
                }
                let len = size.pick(16, 256, 8192);
                let vec = 2;
                let state = State { gftbls: bytes(32 * vec * 2, 8), src: bytes(len, 9), dest: vec![vec![0; len]; 2] };
                Calls::new(
                    state,
                    3 * len + 128,
                    |s| {
                        let (d0, d1) = s.dest.split_at_mut(1);
                        let mut dest = [&mut d0[0][..], &mut d1[0][..]];
                        annotated(
                            black_box(s.src.len()),
                            black_box(2),
                            black_box(1),
                            black_box(&s.gftbls),
                            black_box(&s.src),
                            black_box(&mut dest),
                        )
                    },
                    |s| {
                        let (d0, d1) = s.dest.split_at_mut(1);
                        let mut dest = [&mut d0[0][..], &mut d1[0][..]];
                        raw(
                            black_box(s.src.len()),
                            black_box(2),
                            black_box(1),
                            black_box(&s.gftbls),
                            black_box(&s.src),
                            black_box(&mut dest),
                        )
                    },
                )
            },
        },
    ]
}
