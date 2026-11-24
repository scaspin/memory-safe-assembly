use std::hint::black_box;

use crate::harness::{Calls, Case};
use crate::wrappers::*;

fn doubles(n: usize, seed: f64) -> Vec<u64> {
    (0..n).map(|i| (seed + i as f64 * 0.001).to_bits()).collect()
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "dasum_k",
            build: |size| {
                use dasum_k::*;
                let n = size.pick(0, 128, 4096);
                Calls::new(
                    doubles(n, 1.0),
                    8 * n,
                    |s| {
                        black_box(annotated(black_box(s.len()), black_box(s), black_box(1)));
                    },
                    |s| {
                        black_box(raw(black_box(s.len()), black_box(s), black_box(1)));
                    },
                )
            },
        },
        Case {
            function: "ddot_k",
            build: |size| {
                use ddot_k::*;
                #[derive(Clone)]
                struct State {
                    x: Vec<u64>,
                    y: Vec<u64>,
                }
                let n = size.pick(0, 64, 2048);
                Calls::new(
                    State { x: doubles(n, 1.0), y: doubles(n, 0.5) },
                    16 * n,
                    |s| {
                        black_box(annotated(black_box(s.x.len()), black_box(&s.x), black_box(1), black_box(&s.y), black_box(1)));
                    },
                    |s| {
                        black_box(raw(black_box(s.x.len()), black_box(&s.x), black_box(1), black_box(&s.y), black_box(1)));
                    },
                )
            },
        },
        Case {
            function: "dscal_k",
            build: |size| {
                use dscal_k::*;
                let n = size.pick(0, 128, 4096);
                Calls::new(
                    doubles(n, 1.0),
                    8 * n,
                    |s| annotated(black_box(s.len()), black_box(s), black_box(1), black_box(0)),
                    |s| raw(black_box(s.len()), black_box(s), black_box(1), black_box(0)),
                )
            },
        },
        Case {
            function: "daxpy_k",
            build: |size| {
                use daxpy_k::*;
                #[derive(Clone)]
                struct State {
                    x: Vec<u64>,
                    y: Vec<u64>,
                }
                let n = size.pick(0, 64, 2048);
                Calls::new(
                    State { x: doubles(n, 1.0), y: doubles(n, 0.5) },
                    16 * n,
                    |s| annotated(black_box(s.x.len()), black_box(&s.x), black_box(1), black_box(&mut s.y), black_box(1)),
                    |s| raw(black_box(s.x.len()), black_box(&s.x), black_box(1), black_box(&mut s.y), black_box(1)),
                )
            },
        },
    ]
}
