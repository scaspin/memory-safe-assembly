
#[bums_macros::check_mem_safe("ntt_forward.S", coeffs.as_mut_ptr())]
fn ccmlkem_ntt_forward(coeffs: &mut [i16; 256]);

#[bums_macros::check_mem_safe("ntt_inverse.S", coeffs.as_mut_ptr())]
fn ccmlkem_ntt_inverse(coeffs: &mut [i16; 256]);

#[bums_macros::check_mem_safe("poly.S", coeffs.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccmlkem_poly_add(coeffs: &mut [i16; 256], a: &[i16; 256], b: &[i16; 256]);

#[bums_macros::check_mem_safe("poly.S", coeffs.as_mut_ptr(), a.as_ptr(), b.as_ptr())]
fn ccmlkem_poly_sub(coeffs: &mut [i16; 256], a: &[i16; 256], b: &[i16; 256]);

#[bums_macros::check_mem_safe("poly.S", coeffs.as_mut_ptr())]
fn ccmlkem_poly_reduce(coeffs: &mut [i16; 256]);

#[bums_macros::check_mem_safe("poly.S", coeffs.as_mut_ptr())]
fn ccmlkem_poly_toplant(coeffs: &mut [i16; 256]);

#[bums_macros::check_mem_safe("poly.S", out.as_mut_ptr(), coeffs.as_ptr())]
fn ccmlkem_poly_encode(out: &mut [u8; 384], coeffs: &[i16; 256]);

#[bums_macros::check_mem_safe("poly.S", coeffs.as_mut_ptr(), input.as_ptr())]
fn ccmlkem_poly_decode(coeffs: &mut [i16; 256], input: &[u8; 384]);

#[bums_macros::check_mem_safe("compress.S", out.as_mut_ptr(), coeffs.as_ptr())]
fn ccmlkem_poly_compress_d1(out: &mut [u8; 32], coeffs: &[i16; 256]);

#[bums_macros::check_mem_safe("compress.S", out.as_mut_ptr(), coeffs.as_ptr())]
fn ccmlkem_poly_compress_d4(out: &mut [u8; 128], coeffs: &[i16; 256]);

#[bums_macros::check_mem_safe("compress.S", out.as_mut_ptr(), coeffs.as_ptr())]
fn ccmlkem_poly_compress_d5(out: &mut [u8; 160], coeffs: &[i16; 256]);

#[bums_macros::check_mem_safe("compress.S", out.as_mut_ptr(), coeffs.as_ptr())]
fn ccmlkem_poly_compress_d10(out: &mut [u8; 320], coeffs: &[i16; 256]);

#[bums_macros::check_mem_safe("compress.S", out.as_mut_ptr(), coeffs.as_ptr())]
fn ccmlkem_poly_compress_d11(out: &mut [u8; 352], coeffs: &[i16; 256]);

#[bums_macros::check_mem_safe("decompress.S", coeffs.as_mut_ptr(), input.as_ptr())]
fn ccmlkem_poly_decompress_d1(coeffs: &mut [i16; 256], input: &[u8; 32]);

#[bums_macros::check_mem_safe("decompress.S", coeffs.as_mut_ptr(), input.as_ptr())]
fn ccmlkem_poly_decompress_d4(coeffs: &mut [i16; 256], input: &[u8; 128]);

#[bums_macros::check_mem_safe("decompress.S", coeffs.as_mut_ptr(), input.as_ptr())]
fn ccmlkem_poly_decompress_d5(coeffs: &mut [i16; 256], input: &[u8; 160]);

#[bums_macros::check_mem_safe("decompress.S", coeffs.as_mut_ptr(), input.as_ptr())]
fn ccmlkem_poly_decompress_d10(coeffs: &mut [i16; 256], input: &[u8; 320]);

#[bums_macros::check_mem_safe("decompress.S", coeffs.as_mut_ptr(), input.as_ptr())]
fn ccmlkem_poly_decompress_d11(coeffs: &mut [i16; 256], input: &[u8; 352]);
