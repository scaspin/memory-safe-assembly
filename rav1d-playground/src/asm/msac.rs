#![allow(dead_code)]

use bums_macros as bums;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), cdf.as_mut_ptr(), n_symbols,
    [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len(), cdf.len() >= 4, n_symbols + 1 <= cdf.len(), n_symbols >= 1, n_symbols <= 3])]
fn msac_decode_symbol_adapt4_neon(s: &mut [usize], cdf: &mut [u16], n_symbols: usize, data: &[u8], pos: usize) -> u32;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), cdf.as_mut_ptr(), n_symbols,
    [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len(), cdf.len() >= 8, n_symbols + 1 <= cdf.len(), n_symbols >= 1, n_symbols <= 7])]
fn msac_decode_symbol_adapt8_neon(s: &mut [usize], cdf: &mut [u16], n_symbols: usize, data: &[u8], pos: usize) -> u32;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), cdf.as_mut_ptr(), n_symbols,
    [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len(), cdf.len() >= 16, n_symbols + 1 <= cdf.len(), n_symbols >= 1, n_symbols <= 15])]
fn msac_decode_symbol_adapt16_neon(s: &mut [usize], cdf: &mut [u16], n_symbols: usize, data: &[u8], pos: usize) -> u32;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), cdf.as_mut_ptr(), [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len(), cdf.len() == 2])]
fn msac_decode_bool_adapt_neon(s: &mut [usize], cdf: &mut [u16], data: &[u8], pos: usize) -> u32;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), f, [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len()])]
fn msac_decode_bool_neon(s: &mut [usize], f: u32, data: &[u8], pos: usize) -> u32;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len()])]
fn msac_decode_bool_equi_neon(s: &mut [usize], data: &[u8], pos: usize) -> u32;

#[bums::check_mem_safe("msac.S", s.as_mut_ptr(), cdf.as_mut_ptr(), [s.len() == 6, s[0] == data.as_ptr().add(pos), s[1] == data.as_ptr().add(data.len()), data.len() >= 8, pos <= data.len(), cdf.len() == 5])]
fn msac_decode_hi_tok_neon(s: &mut [usize], cdf: &mut [u16], data: &[u8], pos: usize) -> u32;
