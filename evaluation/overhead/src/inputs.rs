pub struct Rng(u64);

impl Rng {
    pub fn new(seed: u64) -> Rng {
        Rng(seed ^ 0x9e37_79b9_7f4a_7c15)
    }

    pub fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9e37_79b9_7f4a_7c15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
        z ^ (z >> 31)
    }

    pub fn below(&mut self, n: usize) -> usize {
        (self.next() % n as u64) as usize
    }

    pub fn scalar(&mut self, constants: &[i128]) -> i128 {
        if !constants.is_empty() && self.below(2) == 0 {
            let base = constants[self.below(constants.len())];
            return match self.below(6) {
                0 => base - 1,
                1 => base + 1,
                2 => base * (1 + self.below(8) as i128),
                _ => base,
            };
        }
        DOMAIN[self.below(DOMAIN.len())]
    }
}

pub const DOMAIN: [i128; 52] = [
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 24, 31, 32, 33, 40, 48, 63, 64, 65, 80, 96,
    100, 127, 128, 129, 160, 192, 255, 256, 257, 320, 384, 511, 512, 513, 768, 1000, 1023, 1024, 2048, 4096, 8192,
    16384,
];

pub trait Fill {
    fn fill(rng: &mut Rng) -> Self;
}

macro_rules! fill_integers {
    ($($t:ty),*) => {$(
        impl Fill for $t {
            fn fill(rng: &mut Rng) -> $t {
                if rng.below(2) == 0 { DOMAIN[rng.below(DOMAIN.len())] as $t } else { rng.next() as $t }
            }
        }
    )*};
}
fill_integers!(u8, u16, u32, u64, usize, i8, i16, i32, i64, isize);

impl Fill for u128 {
    fn fill(rng: &mut Rng) -> u128 {
        ((rng.next() as u128) << 64) | rng.next() as u128
    }
}

impl Fill for i128 {
    fn fill(rng: &mut Rng) -> i128 {
        u128::fill(rng) as i128
    }
}

impl Fill for f32 {
    fn fill(rng: &mut Rng) -> f32 {
        (rng.next() % 2_000_001) as f32 / 1_000_000.0 - 1.0
    }
}

impl Fill for f64 {
    fn fill(rng: &mut Rng) -> f64 {
        (rng.next() % 2_000_001) as f64 / 1_000_000.0 - 1.0
    }
}

impl Fill for bool {
    fn fill(rng: &mut Rng) -> bool {
        rng.next() & 1 == 1
    }
}

impl<T: Fill, const N: usize> Fill for [T; N] {
    fn fill(rng: &mut Rng) -> [T; N] {
        std::array::from_fn(|_| T::fill(rng))
    }
}

macro_rules! fill_tuples {
    ($(($($name:ident),+)),*) => {$(
        impl<$($name: Fill),+> Fill for ($($name,)+) {
            fn fill(rng: &mut Rng) -> ($($name,)+) {
                ($($name::fill(rng),)+)
            }
        }
    )*};
}
fill_tuples!((A), (A, B), (A, B, C), (A, B, C, D), (A, B, C, D, E), (A, B, C, D, E, F), (A, B, C, D, E, F, G),
    (A, B, C, D, E, F, G, H), (A, B, C, D, E, F, G, H, I), (A, B, C, D, E, F, G, H, I, J),
    (A, B, C, D, E, F, G, H, I, J, K), (A, B, C, D, E, F, G, H, I, J, K, L));

pub fn buffer<T: Fill>(rng: &mut Rng, len: usize) -> Vec<T> {
    (0..len).map(|_| T::fill(rng)).collect()
}
