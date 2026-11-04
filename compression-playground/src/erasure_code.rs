use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_dot_prod_avx-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_avx(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_dot_prod_avx2-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_avx2(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_dot_prod_avx2_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_avx2_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_dot_prod_avx512-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_avx512(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_dot_prod_avx512_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_avx512_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_2vect_dot_prod_neon.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_neon(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_dot_prod_sse-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 2,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 2],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_dot_prod_sse(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_mad_avx-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_mad_avx(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_mad_avx2-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_2vect_mad_avx2(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_mad_avx2_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_2vect_mad_avx2_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_mad_avx512-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_2vect_mad_avx512(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_mad_avx512_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_2vect_mad_avx512_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_2vect_mad_neon.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_mad_neon(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_2vect_mad_sse-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_mad_sse(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_2vect_mad_sve.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 2,
     src.len() == len,
     dest == [&mut [u8; len]; 2],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_2vect_mad_sve(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_dot_prod_avx-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_avx(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_dot_prod_avx2-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_avx2(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_dot_prod_avx2_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_avx2_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_dot_prod_avx512-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_avx512(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_dot_prod_avx512_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_avx512_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_3vect_dot_prod_neon.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_neon(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_dot_prod_sse-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 3,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 3],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_dot_prod_sse(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_mad_avx-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_mad_avx(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_mad_avx2-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_3vect_mad_avx2(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_mad_avx2_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_3vect_mad_avx2_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_mad_avx512-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_3vect_mad_avx512(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_mad_avx512_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_3vect_mad_avx512_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_3vect_mad_neon.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_mad_neon(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_3vect_mad_sse-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_mad_sse(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_3vect_mad_sve.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 3,
     src.len() == len,
     dest == [&mut [u8; len]; 3],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_3vect_mad_sve(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_dot_prod_avx-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_avx(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_dot_prod_avx2-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_avx2(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_dot_prod_avx2_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_avx2_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_dot_prod_avx512-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_avx512(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_dot_prod_avx512_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_avx512_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_4vect_dot_prod_neon.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_neon(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_dot_prod_sse-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 4,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 4],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_dot_prod_sse(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_mad_avx-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_mad_avx(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_mad_avx2-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_4vect_mad_avx2(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_mad_avx2_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_4vect_mad_avx2_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_mad_avx512-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_4vect_mad_avx512(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_mad_avx512_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_4vect_mad_avx512_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_4vect_mad_neon.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_mad_neon(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_4vect_mad_sse-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_mad_sse(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_4vect_mad_sve.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 4,
     src.len() == len,
     dest == [&mut [u8; len]; 4],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_4vect_mad_sve(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_dot_prod_avx-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_avx(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_dot_prod_avx2-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_avx2(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_dot_prod_avx2_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_avx2_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_dot_prod_avx512-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_avx512(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_dot_prod_avx512_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_avx512_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_5vect_dot_prod_neon.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_neon(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_dot_prod_sse-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 5,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 5],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_dot_prod_sse(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_mad_avx-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_mad_avx(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_mad_avx2-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_5vect_mad_avx2(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_mad_avx2_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_5vect_mad_avx2_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_mad_avx512-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_5vect_mad_avx512(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_mad_avx512_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_5vect_mad_avx512_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_5vect_mad_neon.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_mad_neon(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_5vect_mad_sse-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_mad_sse(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_5vect_mad_sve.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 5,
     src.len() == len,
     dest == [&mut [u8; len]; 5],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_5vect_mad_sve(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_dot_prod_avx-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 6,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 6],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_6vect_dot_prod_avx(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_dot_prod_avx2-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 6,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 6],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_6vect_dot_prod_avx2(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_dot_prod_avx2_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 6,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 6],
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_6vect_dot_prod_avx2_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_dot_prod_avx512-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 6,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 6],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_6vect_dot_prod_avx512(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_dot_prod_avx512_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 6,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 6],
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_6vect_dot_prod_avx512_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_dot_prod_sse-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vlen * 6,
     src == [&[u8; len]; vlen],
     dest == [&mut [u8; len]; 6],
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_6vect_dot_prod_sse(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_mad_avx-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_6vect_mad_avx(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_mad_avx2-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_6vect_mad_avx2(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_mad_avx2_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_6vect_mad_avx2_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_mad_avx512-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_6vect_mad_avx512(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_mad_avx512_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_6vect_mad_avx512_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_6vect_mad_neon.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_6vect_mad_neon(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_6vect_mad_sse-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_6vect_mad_sse(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_6vect_mad_sve.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_ptr(),
    [gftbls.len() == 32 * vec * 6,
     src.len() == len,
     dest == [&mut [u8; len]; 6],
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_6vect_mad_sve(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &[&mut [u8]]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_dot_prod_avx-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_dot_prod_avx(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_dot_prod_avx2-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_vect_dot_prod_avx2(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_dot_prod_avx2_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 32,
     len <= 2147483647]))]
fn gf_vect_dot_prod_avx2_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_dot_prod_avx512-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_vect_dot_prod_avx512(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_dot_prod_avx512_gfni-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 64,
     len <= 2147483647]))]
fn gf_vect_dot_prod_avx512_gfni(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_vect_dot_prod_neon.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_dot_prod_neon(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_dot_prod_sse-x86_64.S", len, vlen, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vlen * 1,
     src == [&[u8; len]; vlen],
     dest.len() == len,
     vlen >= 1,
     vlen <= 255,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_dot_prod_sse(len: usize, vlen: usize, gftbls: &[u8], src: &[&[u8]], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mad_avx-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_mad_avx(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mad_avx2-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_vect_mad_avx2(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mad_avx2_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 32,
     len <= 2147483647]))]
fn gf_vect_mad_avx2_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mad_avx512-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_vect_mad_avx512(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mad_avx512_gfni-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 64,
     len <= 2147483647]))]
fn gf_vect_mad_avx512_gfni(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_vect_mad_neon.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_mad_neon(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mad_sse-x86_64.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_mad_sse(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_vect_mad_sve.S", len, vec, vec_i, gftbls.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbls.len() == 32 * vec * 1,
     src.len() == len,
     dest.len() == len,
     vec >= 1,
     vec <= 255,
     vec_i < vec,
     len >= 16,
     len <= 2147483647]))]
fn gf_vect_mad_sve(len: usize, vec: usize, vec_i: usize, gftbls: &[u8], src: &[u8], dest: &mut [u8]);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mul_avx-x86_64.S", len, gftbl.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbl.len() == 32,
     src.len() == len,
     dest.len() == len,
     len >= 16,
     len <= 2147483647,
     len % 32 == 0]))]
fn gf_vect_mul_avx(len: usize, gftbl: &[u8], src: &[u8], dest: &mut [u8]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mul_avx2_gfni-x86_64.S", len, gftbl.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbl.len() == 32,
     src.len() == len,
     dest.len() == len,
     len >= 32,
     len <= 2147483647,
     len % 32 == 0]))]
fn gf_vect_mul_avx2_gfni(len: usize, gftbl: &[u8], src: &[u8], dest: &mut [u8]) -> i32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_vect_mul_neon.S", len, gftbl.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbl.len() == 32,
     src.len() == len,
     dest.len() == len,
     len >= 16,
     len <= 2147483647,
     len % 32 == 0]))]
fn gf_vect_mul_neon(len: usize, gftbl: &[u8], src: &[u8], dest: &mut [u8]) -> i32;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("gf_vect_mul_sse-x86_64.S", len, gftbl.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbl.len() == 32,
     src.len() == len,
     dest.len() == len,
     len >= 16,
     len <= 2147483647,
     len % 32 == 0]))]
fn gf_vect_mul_sse(len: usize, gftbl: &[u8], src: &[u8], dest: &mut [u8]) -> i32;

#[cfg_attr(target_arch = "aarch64", bums::check_mem_safe("gf_vect_mul_sve.S", len, gftbl.as_ptr(), src.as_ptr(), dest.as_mut_ptr(),
    [gftbl.len() == 32,
     src.len() == len,
     dest.len() == len,
     len >= 16,
     len <= 2147483647,
     len % 32 == 0]))]
fn gf_vect_mul_sve(len: usize, gftbl: &[u8], src: &[u8], dest: &mut [u8]) -> i32;
