use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

fn halves(n: usize, seed: u16) -> Vec<u16> {
    (0..n).map(|i| 0x3c00 + ((i as u16).wrapping_mul(7).wrapping_add(seed) & 0x3ff)).collect()
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "candle_vec_dot_f16",
            build: |size| {
                use candle_vec_dot_f16::*;
                #[derive(Clone)]
                struct State {
                    a: Vec<u16>,
                    b: Vec<u16>,
                    c: [u32; 1],
                }
                let n = size.pick(0, 256, 8192);
                Calls::new(
                    State { a: halves(n, 1), b: halves(n, 2), c: [0] },
                    4 * n + 4,
                    |s| annotated(black_box(&s.a), black_box(&s.b), black_box(&mut s.c)),
                    |s| raw(black_box(&s.a), black_box(&s.b), black_box(&mut s.c)),
                )
            },
        },
        Case {
            function: "candle_f16_vecops_vec_add",
            build: |size| {
                use candle_f16_vecops_vec_add::*;
                #[derive(Clone)]
                struct State {
                    lhs: Vec<u16>,
                    rhs: Vec<u16>,
                    res: Vec<u16>,
                }
                let n = size.pick(0, 168, 8192);
                Calls::new(
                    State { lhs: halves(n, 1), rhs: halves(n, 2), res: vec![0; n] },
                    6 * n,
                    |s| annotated(black_box(&s.lhs), black_box(&s.rhs), black_box(&mut s.res)),
                    |s| raw(black_box(&s.lhs), black_box(&s.rhs), black_box(&mut s.res)),
                )
            },
        },
    ]
}
