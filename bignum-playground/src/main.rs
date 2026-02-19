//! Rust FFI bindings for s2n-bignum ARM assembly functions
//!
//! s2n-bignum is a collection of formally verified bignum arithmetic
//! functions for cryptographic applications, written in pure assembly
//! for x86_64 and aarch64 (ARM).
//!
//! These bindings provide safe access to the ARM assembly implementations.
//! All functions are constant-time to avoid timing side-channels.
//!
//! For detailed documentation on each function, see the assembly source
//! files and formal proofs in the s2n-bignum repository:
//! https://github.com/awslabs/s2n-bignum

#![allow(non_camel_case_types)]

use bums_macros as bums;
use core::ffi::c_void;

fn main() {
    println!("Hello, world!");
}

// ============================================================================
// Generic bignum operations
// ============================================================================

unsafe extern "C" {
    /// Add, z := x + y
    /// Returns top carry.
    pub fn bignum_add(p: u64, z: *mut u64, m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Multiply bignum by a word-sized constant, z := c * x
    /// Returns top carry word.
    pub fn bignum_amontifier(k: u64, z: *mut u64, m: *const u64);

    /// Multiply and accumulate by a word, z := z + c * x
    /// Returns top carry word.
    pub fn bignum_amontmul(k: u64, z: *mut u64, x: *const u64, y: *const u64, m: *const u64);

    /// Multiply and accumulate by a word, z := z + c * x
    /// Returns top carry word.
    pub fn bignum_amontredc(k: u64, z: *mut u64, m: *const u64);

    /// Almost-Montgomery square, z := (x^2 / 2^{64k}) mod m
    pub fn bignum_amontsqr(k: u64, z: *mut u64, x: *const u64, m: *const u64);

    /// Bitwise AND, z := x AND y
    pub fn bignum_bitfield(z: *mut u64, n: u64, x: *const u64, l: u64, h: u64);

    /// Bitsize
    pub fn bignum_bitsize(k: u64, x: *const u64) -> u64;

    /// Conditional addition, z := x + c * y
    pub fn bignum_cdiv(k: u64, q: *mut u64, x: *const u64, m: *const u64, n: *mut u64);

    /// Conditional addition, z := x + c * y (c is 0 or 1)
    pub fn bignum_cdiv_exact(k: u64, z: *mut u64, x: *const u64, p: u64);

    /// Count leading zeros
    pub fn bignum_clz(k: u64, x: *const u64) -> u64;

    /// Multiply-add with single-word multiplier, z := z + c * y
    pub fn bignum_cmadd(p: u64, z: *mut u64, c: u64, m: u64, x: *const u64) -> u64;

    /// Conditional move, z := if c then x else y
    pub fn bignum_cmul(p: u64, z: *mut u64, c: u64, m: u64, x: *const u64);

    /// Compare bignums, x >= y
    pub fn bignum_cmp(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Conditional negation, z := if c then -x else x
    pub fn bignum_cmnegadd(p: u64, z: *mut u64, c: u64, m: u64, x: *const u64) -> u64;

    /// Copy bignum, z := x
    pub fn bignum_copy(p: u64, z: *mut u64, m: u64, x: *const u64);

    /// Conditional select, z := if c then x else y (c is 0 or 1)
    pub fn bignum_coprime(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Count trailing zeros
    pub fn bignum_ctz(k: u64, x: *const u64) -> u64;

    /// Convert from almost-Montgomery form, z := (x / 2^{64k}) mod m
    pub fn bignum_demont(k: u64, z: *mut u64, x: *const u64, m: *const u64);

    /// Convert from Montgomery form, z := (x / 2^{64k}) mod m
    pub fn bignum_deamont(k: u64, z: *mut u64, x: *const u64, m: *const u64);

    /// Digit-wise bignum, z := ...z[2]z[1]z[0]
    pub fn bignum_digit(x: *const u64, i: u64) -> u64;

    /// Digitize bignum
    pub fn bignum_digitsize(k: u64, x: *const u64) -> u64;

    /// Divide by 10 and return remainder
    pub fn bignum_divmod10(k: u64, z: *mut u64, x: *const u64) -> u64;

    /// Emontredc operation
    pub fn bignum_emontredc(k: u64, z: *mut u64, n: *const u64, m: *const u64);

    /// Test bignum for equality, x = y
    pub fn bignum_eq(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Test bignum for evenness
    pub fn bignum_even(k: u64, x: *const u64) -> u64;

    /// Convert from bytes (big-endian)
    pub fn bignum_frombebytes(k: u64, z: *mut u64, n: u64, x: *const u8);

    /// Convert from bytes (little-endian), z := x
    pub fn bignum_fromlebytes(k: u64, z: *mut u64, n: u64, x: *const u8);

    /// Test bignum x >= y
    pub fn bignum_ge(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Test bignum x > y
    pub fn bignum_gt(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Test bignum x is zero
    pub fn bignum_iszero(k: u64, x: *const u64) -> u64;

    /// Karatsuba multiply
    pub fn bignum_kmul_16_32(z: *mut u64, x: *const u64, y: *const u64);

    /// Karatsuba multiply
    pub fn bignum_kmul_32_64(z: *mut u64, x: *const u64, y: *const u64);

    /// Karatsuba square
    pub fn bignum_ksqr_16_32(z: *mut u64, x: *const u64);

    /// Karatsuba square
    pub fn bignum_ksqr_32_64(z: *mut u64, x: *const u64);

    /// Test bignum x < y
    pub fn bignum_le(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Test bignum x <= y
    pub fn bignum_lt(m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Multiply-add with single-digit multiplier
    pub fn bignum_madd(p: u64, z: *mut u64, m: u64, x: *const u64, c: u64, a: u64);

    /// Modular inverse, z := x^-1 mod m
    pub fn bignum_modifier(k: u64, z: *mut u64, m: *const u64);

    /// Modular exponentiation
    pub fn bignum_modexp(k: u64, z: *mut u64, a: *const u64, n: u64, x: *const u64, m: *const u64);

    /// Modular inverse, z := x^-1 mod m
    pub fn bignum_modinv(k: u64, z: *mut u64, a: *const u64, b: *const u64, t: *mut u64);

    /// Modular multiplication
    pub fn bignum_modoptneg(k: u64, z: *mut u64, p: u64, x: *const u64);

    /// Montgomery multiplication, z := (x * y / 2^{64k}) mod m
    pub fn bignum_montifier(k: u64, z: *mut u64, m: *const u64);

    /// Montgomery multiplication
    pub fn bignum_montmul(k: u64, z: *mut u64, x: *const u64, y: *const u64, m: *const u64);

    /// Montgomery reduction
    pub fn bignum_montredc(k: u64, z: *mut u64, m: *const u64);

    /// Montgomery square
    pub fn bignum_montsqr(k: u64, z: *mut u64, x: *const u64, m: *const u64);

    /// Multiply, z := x * y
    pub fn bignum_mul(p: u64, z: *mut u64, m: u64, x: *const u64, n: u64, y: *const u64);

    /// Multiply by 10
    pub fn bignum_mul10(k: u64, z: *mut u64, x: *const u64) -> u64;

    /// Conditional move, z := x if c else z
    pub fn bignum_mux(b: u64, p: u64, z: *mut u64, x: *const u64, y: *const u64);

    /// Conditional move for 16-word bignums
    pub fn bignum_mux16(b: u64, z: *mut u64, x: *const u64, y: *const u64);

    /// Negate, z := -x
    pub fn bignum_neg(p: u64, z: *mut u64, m: u64, x: *const u64);

    /// Negated modular inverse for Montgomery operations
    pub fn bignum_negmodinv(k: u64, z: *mut u64, a: *const u64);

    /// Nonzero test
    pub fn bignum_nonzero(k: u64, x: *const u64) -> u64;

    /// Normalize bignum (remove leading zeros)
    pub fn bignum_normalize(k: u64, z: *mut u64, x: *const u64) -> u64;

    /// Test bignum for oddness
    pub fn bignum_odd(k: u64, x: *const u64) -> u64;

    /// Create bignum from word
    pub fn bignum_of_word(k: u64, z: *mut u64, x: u64);

    /// Optional negation, z := (-1)^p * x
    pub fn bignum_optneg(p: u64, z: *mut u64, x: *const u64, c: u64);

    /// Optional subtraction
    pub fn bignum_optsubadd(p: u64, z: *mut u64, x: *const u64, y: *const u64, c: u64);

    /// Optional add
    pub fn bignum_optsub(p: u64, z: *mut u64, x: *const u64, y: *const u64, c: u64) -> u64;

    /// Power of 2 test
    pub fn bignum_pow2(k: u64, x: *const u64) -> u64;

    /// Left shift by one bit
    pub fn bignum_shl_small(k: u64, z: *mut u64, x: *const u64, n: u64) -> u64;

    /// Right shift by one bit
    pub fn bignum_shr_small(k: u64, z: *mut u64, x: *const u64, n: u64) -> u64;

    /// Square, z := x^2
    pub fn bignum_sqr(p: u64, z: *mut u64, m: u64, x: *const u64);

    /// Specialized squaring operations
    pub fn bignum_sqr_4_8(z: *mut u64, x: *const u64);
    pub fn bignum_sqr_4_8_alt(z: *mut u64, x: *const u64);
    pub fn bignum_sqr_6_12(z: *mut u64, x: *const u64);
    pub fn bignum_sqr_6_12_alt(z: *mut u64, x: *const u64);
    pub fn bignum_sqr_8_16(z: *mut u64, x: *const u64);
    pub fn bignum_sqr_8_16_alt(z: *mut u64, x: *const u64);

    /// Subtract, z := x - y
    /// Returns borrow.
    pub fn bignum_sub(p: u64, z: *mut u64, m: u64, x: *const u64, n: u64, y: *const u64) -> u64;

    /// Convert to bytes (big-endian)
    pub fn bignum_tobebytes(n: u64, z: *mut u8, k: u64, x: *const u64);

    /// Convert to bytes (little-endian)
    pub fn bignum_tolebytes(n: u64, z: *mut u8, k: u64, x: *const u64);

    /// Convert to Montgomery form, z := (2^{64k} * x) mod m
    pub fn bignum_tomont(k: u64, z: *mut u64, x: *const u64, m: *const u64);
}

// ============================================================================
// P-256 curve operations
// ============================================================================

extern "C" {
    /// Add modulo p_256, z := (x + y) mod p_256
    pub fn bignum_add_p256(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Convert from almost-Montgomery form modulo p_256
    pub fn bignum_deamont_p256(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Convert from Montgomery form modulo p_256
    pub fn bignum_demont_p256(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Double modulo p_256, z := (2 * x) mod p_256
    pub fn bignum_double_p256(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Convert from bytes modulo p_256
    pub fn bignum_fromlebytes_p256(z: *mut [u64; 4], x: *const [u8; 32]);

    /// Halve modulo p_256, z := (x / 2) mod p_256
    pub fn bignum_half_p256(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Montgomery multiplication modulo p_256
    pub fn bignum_montmul_p256(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);
    pub fn bignum_montmul_p256_alt(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Montgomery square modulo p_256
    pub fn bignum_montsqr_p256(z: *mut [u64; 4], x: *const [u64; 4]);
    pub fn bignum_montsqr_p256_alt(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Conditional move for p_256
    pub fn bignum_mux_4(b: u64, z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Negate modulo p_256
    pub fn bignum_neg_p256(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Optional negation modulo p_256
    pub fn bignum_optneg_p256(z: *mut [u64; 4], x: *const [u64; 4], p: u64);

    /// Subtract modulo p_256
    pub fn bignum_sub_p256(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Convert to bytes from p_256
    pub fn bignum_tolebytes_p256(z: *mut [u8; 32], x: *const [u64; 4]);

    /// Convert to Montgomery form modulo p_256
    pub fn bignum_tomont_p256(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Triple modulo p_256
    pub fn bignum_triple_p256(z: *mut [u64; 4], x: *const [u64; 4]);
}

// ============================================================================
// P-256k1 (secp256k1) curve operations
// ============================================================================

extern "C" {
    /// Add modulo p_256k1
    pub fn bignum_add_p256k1(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Double modulo p_256k1
    pub fn bignum_double_p256k1(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Halve modulo p_256k1
    pub fn bignum_half_p256k1(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Montgomery multiplication modulo p_256k1
    pub fn bignum_montmul_p256k1(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);
    pub fn bignum_montmul_p256k1_alt(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Montgomery square modulo p_256k1
    pub fn bignum_montsqr_p256k1(z: *mut [u64; 4], x: *const [u64; 4]);
    pub fn bignum_montsqr_p256k1_alt(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Negate modulo p_256k1
    pub fn bignum_neg_p256k1(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Subtract modulo p_256k1
    pub fn bignum_sub_p256k1(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Triple modulo p_256k1
    pub fn bignum_triple_p256k1(z: *mut [u64; 4], x: *const [u64; 4]);
    pub fn bignum_triple_p256k1_alt(z: *mut [u64; 4], x: *const [u64; 4]);
}

// ============================================================================
// P-384 curve operations
// ============================================================================

extern "C" {
    /// Add modulo p_384
    pub fn bignum_add_p384(z: *mut [u64; 6], x: *const [u64; 6], y: *const [u64; 6]);

    /// Convert from Montgomery form modulo p_384
    pub fn bignum_demont_p384(z: *mut [u64; 6], x: *const [u64; 6]);
    pub fn bignum_demont_p384_alt(z: *mut [u64; 6], x: *const [u64; 6]);

    /// Double modulo p_384
    pub fn bignum_double_p384(z: *mut [u64; 6], x: *const [u64; 6]);

    /// Convert from bytes modulo p_384
    pub fn bignum_fromlebytes_p384(z: *mut [u64; 6], x: *const [u8; 48]);

    /// Halve modulo p_384
    pub fn bignum_half_p384(z: *mut [u64; 6], x: *const [u64; 6]);

    /// Montgomery multiplication modulo p_384
    pub fn bignum_montmul_p384(z: *mut [u64; 6], x: *const [u64; 6], y: *const [u64; 6]);
    pub fn bignum_montmul_p384_alt(z: *mut [u64; 6], x: *const [u64; 6], y: *const [u64; 6]);

    /// Montgomery square modulo p_384
    pub fn bignum_montsqr_p384(z: *mut [u64; 6], x: *const [u64; 6]);
    pub fn bignum_montsqr_p384_alt(z: *mut [u64; 6], x: *const [u64; 6]);

    /// Conditional move for p_384
    pub fn bignum_mux_6(b: u64, z: *mut [u64; 6], x: *const [u64; 6], y: *const [u64; 6]);

    /// Negate modulo p_384
    pub fn bignum_neg_p384(z: *mut [u64; 6], x: *const [u64; 6]);

    /// Subtract modulo p_384
    pub fn bignum_sub_p384(z: *mut [u64; 6], x: *const [u64; 6], y: *const [u64; 6]);

    /// Convert to bytes from p_384
    pub fn bignum_tolebytes_p384(z: *mut [u8; 48], x: *const [u64; 6]);

    /// Convert to Montgomery form modulo p_384
    pub fn bignum_tomont_p384(z: *mut [u64; 6], x: *const [u64; 6]);
    pub fn bignum_tomont_p384_alt(z: *mut [u64; 6], x: *const [u64; 6]);

    /// Triple modulo p_384
    pub fn bignum_triple_p384(z: *mut [u64; 6], x: *const [u64; 6]);
    pub fn bignum_triple_p384_alt(z: *mut [u64; 6], x: *const [u64; 6]);
}

// ============================================================================
// P-521 curve operations
// ============================================================================

extern "C" {
    /// Add modulo p_521
    pub fn bignum_add_p521(z: *mut [u64; 9], x: *const [u64; 9], y: *const [u64; 9]);

    /// Double modulo p_521
    pub fn bignum_double_p521(z: *mut [u64; 9], x: *const [u64; 9]);

    /// Convert from bytes modulo p_521
    pub fn bignum_fromlebytes_p521(z: *mut [u64; 9], x: *const [u8; 66]);

    /// Halve modulo p_521
    pub fn bignum_half_p521(z: *mut [u64; 9], x: *const [u64; 9]);

    /// Multiply modulo p_521
    pub fn bignum_mul_p521(z: *mut [u64; 9], x: *const [u64; 9], y: *const [u64; 9]);
    pub fn bignum_mul_p521_alt(z: *mut [u64; 9], x: *const [u64; 9], y: *const [u64; 9]);

    /// Negate modulo p_521
    pub fn bignum_neg_p521(z: *mut [u64; 9], x: *const [u64; 9]);

    /// Square modulo p_521
    pub fn bignum_sqr_p521(z: *mut [u64; 9], x: *const [u64; 9]);
    pub fn bignum_sqr_p521_alt(z: *mut [u64; 9], x: *const [u64; 9]);

    /// Subtract modulo p_521
    pub fn bignum_sub_p521(z: *mut [u64; 9], x: *const [u64; 9], y: *const [u64; 9]);

    /// Convert to bytes from p_521
    pub fn bignum_tolebytes_p521(z: *mut [u8; 66], x: *const [u64; 9]);

    /// Triple modulo p_521
    pub fn bignum_triple_p521(z: *mut [u64; 9], x: *const [u64; 9]);
    pub fn bignum_triple_p521_alt(z: *mut [u64; 9], x: *const [u64; 9]);
}

// ============================================================================
// Curve25519 operations
// ============================================================================

extern "C" {
    /// Add modulo p_25519
    pub fn bignum_add_p25519(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Double modulo p_25519
    pub fn bignum_double_p25519(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Halve modulo p_25519
    pub fn bignum_half_p25519(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Modular inverse modulo p_25519
    pub fn bignum_inv_p25519(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Inverse square root modulo p_25519
    /// Returns 0 if successful, 1 if input is not a square
    pub fn bignum_invsqrt_p25519(z: *mut [u64; 4], x: *const [u64; 4]) -> i64;
    pub fn bignum_invsqrt_p25519_alt(z: *mut [u64; 4], x: *const [u64; 4]) -> i64;

    /// Multiply modulo p_25519
    pub fn bignum_mul_p25519(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);
    pub fn bignum_mul_p25519_alt(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Negate modulo p_25519
    pub fn bignum_neg_p25519(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Square modulo p_25519
    pub fn bignum_sqr_p25519(z: *mut [u64; 4], x: *const [u64; 4]);
    pub fn bignum_sqr_p25519_alt(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Subtract modulo p_25519
    pub fn bignum_sub_p25519(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Triple modulo p_25519
    pub fn bignum_triple_p25519(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Curve25519 ladder step
    pub fn curve25519_ladderstep(
        rr: *mut [u64; 16],
        point: *const [u64; 8],
        pp: *const [u64; 16],
        b: u64,
    );
    pub fn curve25519_ladderstep_alt(
        rr: *mut [u64; 16],
        point: *const [u64; 8],
        pp: *const [u64; 16],
        b: u64,
    );

    /// Curve25519 point scalar multiplication (projective coordinates)
    pub fn curve25519_pxscalarmul(
        res: *mut [u64; 8],
        scalar: *const [u64; 4],
        point: *const [u64; 4],
    );
    pub fn curve25519_pxscalarmul_alt(
        res: *mut [u64; 8],
        scalar: *const [u64; 4],
        point: *const [u64; 4],
    );

    /// X25519 function (u64 interface)
    pub fn curve25519_x25519(res: *mut [u64; 4], scalar: *const [u64; 4], point: *const [u64; 4]);
    pub fn curve25519_x25519_alt(
        res: *mut [u64; 4],
        scalar: *const [u64; 4],
        point: *const [u64; 4],
    );

    /// X25519 function (byte interface)
    pub fn curve25519_x25519_byte(
        res: *mut [u8; 32],
        scalar: *const [u8; 32],
        point: *const [u8; 32],
    );
    pub fn curve25519_x25519_byte_alt(
        res: *mut [u8; 32],
        scalar: *const [u8; 32],
        point: *const [u8; 32],
    );

    /// X25519 base point multiplication (u64 interface)
    pub fn curve25519_x25519base(res: *mut [u64; 4], scalar: *const [u64; 4]);
    pub fn curve25519_x25519base_alt(res: *mut [u64; 4], scalar: *const [u64; 4]);

    /// X25519 base point multiplication (byte interface)
    pub fn curve25519_x25519base_byte(res: *mut [u8; 32], scalar: *const [u8; 32]);
    pub fn curve25519_x25519base_byte_alt(res: *mut [u8; 32], scalar: *const [u8; 32]);
}

// ============================================================================
// Edwards25519 operations
// ============================================================================

extern "C" {
    /// Decode Edwards25519 point
    /// Returns 0 if successful, non-zero if invalid encoding
    pub fn edwards25519_decode(z: *mut [u64; 8], c: *const [u8; 32]) -> u64;
    pub fn edwards25519_decode_alt(z: *mut [u64; 8], c: *const [u8; 32]) -> u64;

    /// Encode Edwards25519 point
    pub fn edwards25519_encode(c: *mut [u8; 32], z: *const [u64; 8]);

    /// Edwards25519 point addition in extended coordinates
    pub fn edwards25519_epadd(p3: *mut [u64; 16], p1: *const [u64; 16], p2: *const [u64; 12]);
    pub fn edwards25519_epadd_alt(p3: *mut [u64; 16], p1: *const [u64; 16], p2: *const [u64; 12]);

    /// Edwards25519 point doubling in extended coordinates
    pub fn edwards25519_epdouble(p3: *mut [u64; 16], p1: *const [u64; 16]);
    pub fn edwards25519_epdouble_alt(p3: *mut [u64; 16], p1: *const [u64; 16]);

    /// Edwards25519 point scalar multiplication
    pub fn edwards25519_scalarmul(
        res: *mut [u64; 8],
        scalar: *const [u8; 32],
        point: *const [u64; 8],
    );
    pub fn edwards25519_scalarmul_alt(
        res: *mut [u64; 8],
        scalar: *const [u8; 32],
        point: *const [u64; 8],
    );

    /// Edwards25519 base point scalar multiplication
    pub fn edwards25519_scalarmulbase(res: *mut [u64; 8], scalar: *const [u8; 32]);
    pub fn edwards25519_scalarmulbase_alt(res: *mut [u64; 8], scalar: *const [u8; 32]);

    /// Edwards25519 double scalar multiplication
    pub fn edwards25519_scalarmuldouble(
        res: *mut [u64; 8],
        scalar1: *const [u8; 32],
        point1: *const [u64; 8],
        scalar2: *const [u8; 32],
        point2: *const [u64; 8],
    );
    pub fn edwards25519_scalarmuldouble_alt(
        res: *mut [u64; 8],
        scalar1: *const [u8; 32],
        point1: *const [u64; 8],
        scalar2: *const [u8; 32],
        point2: *const [u64; 8],
    );
}

// ============================================================================
// SM2 curve operations (Chinese standard)
// ============================================================================

unsafe extern "C" {
    /// Add modulo p_sm2
    pub fn bignum_add_sm2(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Double modulo p_sm2
    pub fn bignum_double_sm2(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Halve modulo p_sm2
    pub fn bignum_half_sm2(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Montgomery multiplication modulo p_sm2
    pub fn bignum_montmul_sm2(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);
    pub fn bignum_montmul_sm2_alt(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Montgomery square modulo p_sm2
    pub fn bignum_montsqr_sm2(z: *mut [u64; 4], x: *const [u64; 4]);
    pub fn bignum_montsqr_sm2_alt(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Negate modulo p_sm2
    pub fn bignum_neg_sm2(z: *mut [u64; 4], x: *const [u64; 4]);

    /// Subtract modulo p_sm2
    pub fn bignum_sub_sm2(z: *mut [u64; 4], x: *const [u64; 4], y: *const [u64; 4]);

    /// Triple modulo p_sm2
    pub fn bignum_triple_sm2(z: *mut [u64; 4], x: *const [u64; 4]);
    pub fn bignum_triple_sm2_alt(z: *mut [u64; 4], x: *const [u64; 4]);
}

// ============================================================================
// Word-level operations
// ============================================================================

unsafe extern "C" {
    /// Count leading zeros in a word
    pub fn word_clz(x: u64) -> u64;

    /// Count trailing zeros in a word
    pub fn word_ctz(x: u64) -> u64;

    /// Maximum of two words
    pub fn word_max(x: u64, y: u64) -> u64;

    /// Minimum of two words
    pub fn word_min(x: u64, y: u64) -> u64;

    /// Negated modular inverse for a word
    pub fn word_negmodinv(x: u64) -> u64;

    /// Reciprocal approximation for a word
    pub fn word_recip(x: u64) -> u64;
}

// ============================================================================
// Helper functions and constants
// ============================================================================

/// S2N_BIGNUM_STATIC marker for array sizes in C headers
/// Not needed in Rust as we use proper array types
pub const S2N_BIGNUM_STATIC: usize = 0;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_basic_operations() {
        // Example test - actual tests would need the library linked
        let x = [1u64, 2, 3, 4];
        let y = [5u64, 6, 7, 8];
        let mut z = [0u64; 4];

        unsafe {
            // Note: This would only work if s2n-bignum is properly linked
            // bignum_add_p256(&mut z, &x, &y);
        }
    }
}
