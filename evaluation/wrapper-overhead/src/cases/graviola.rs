use std::hint::black_box;

use crate::cases::crypto::words;
use crate::harness::{Calls, Case};
use crate::wrappers::*;

fn limbs(n: usize, seed: u64) -> Vec<u64> {
    (0..n).map(|i| (i as u64 + seed).wrapping_mul(0x9e37_79b9_7f4a_7c15)).collect()
}

pub fn cases() -> Vec<Case> {
    vec![
        Case {
            function: "bignum_montsqr_p384",
            build: |_| {
                use bignum_montsqr_p384::*;
                #[derive(Clone)]
                struct State {
                    z: [u64; 6],
                    x: [u64; 6],
                }
                Calls::new(
                    State { z: [0; 6], x: words::<6>(1) },
                    96,
                    |s| annotated(black_box(&mut s.z), black_box(&s.x)),
                    |s| raw(black_box(&mut s.z), black_box(&s.x)),
                )
            },
        },
        Case {
            function: "bignum_add_p384",
            build: |_| {
                use bignum_add_p384::*;
                #[derive(Clone)]
                struct State {
                    z: [u64; 6],
                    x: [u64; 6],
                    y: [u64; 6],
                }
                Calls::new(
                    State { z: [0; 6], x: words::<6>(1), y: words::<6>(2) },
                    144,
                    |s| annotated(black_box(&mut s.z), black_box(&s.x), black_box(&s.y)),
                    |s| raw(black_box(&mut s.z), black_box(&s.x), black_box(&s.y)),
                )
            },
        },
        Case {
            function: "bignum_mul",
            build: |size| {
                use bignum_mul::*;
                #[derive(Clone)]
                struct State {
                    z: Vec<u64>,
                    x: Vec<u64>,
                    y: Vec<u64>,
                }
                let k = size.pick(1, 32, 128);
                Calls::new(
                    State { z: vec![0; 2 * k], x: limbs(k, 3), y: limbs(k, 4) },
                    32 * k,
                    |s| annotated(black_box(&mut s.z), black_box(&s.x), black_box(&s.y)),
                    |s| raw(black_box(&mut s.z), black_box(&s.x), black_box(&s.y)),
                )
            },
        },
        Case {
            function: "bignum_copy_row_from_table_8n",
            build: |size| {
                use bignum_copy_row_from_table_8n::*;
                #[derive(Clone)]
                struct State {
                    z: Vec<u64>,
                    table: Vec<u64>,
                    height: u64,
                }
                let (width, height) = size.pick((8, 1), (8, 16), (32, 64));
                Calls::new(
                    State { z: vec![0; width], table: limbs(width * height, 5), height: height as u64 },
                    8 * width * (height + 1),
                    |s| annotated(black_box(&mut s.z), black_box(&s.table), black_box(s.height), black_box(0)),
                    |s| raw(black_box(&mut s.z), black_box(&s.table), black_box(s.height), black_box(0)),
                )
            },
        },
    ]
}
