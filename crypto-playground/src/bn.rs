use crate::utils::*;

//const INT_MAX: usize = usize::MAX;
//const BN_BITS2: usize = 64;
const BN_MAX_WORDS: usize = 16; // FIX, should be: INT_MAX / (4 * BN_BITS2);

#[allow(non_camel_case_types)]
pub type BIGNUM = BigNumSt;
#[allow(non_camel_case_types)]
type BN_ULONG = u64;

#[derive(Clone, PartialEq)]
enum BnFlag {
    Malloced,
    StaticData,
}

#[derive(Clone)]
pub struct BigNumSt {
    d: [u64; BN_MAX_WORDS],
    width: usize,
    dmax: usize,
    neg: bool,
    flags: BnFlag,
}

impl BIGNUM {
    pub fn new() -> Self {
        Self {
            d: [0; BN_MAX_WORDS],
            width: 0,
            dmax: 0,
            neg: false,
            flags: BnFlag::Malloced,
        }
    }

    pub fn set_word(&mut self, value: BN_ULONG) {
        let res = bn_wexpand(self, 1);
        if res.is_err() {
            return;
        }

        self.neg = false;
        self.d[0] = value;
        self.width = 1;
    }

    pub fn set_u64(&mut self, value: u64) {
        self.set_word(value);
    }
}

fn bn_set_minimal_width(bn: &mut BIGNUM) {
    bn.width = {
        let mut ret = bn.width;
        while ret > 0 && bn.d[ret - 1] == 0 {
            ret = ret - 1;
        }
        ret
    };

    if bn.width == 0 {
        bn.neg = false;
    }
}

fn bn_wexpand(bn: &mut BIGNUM, words: usize) -> Result<(), String> {
    if words <= bn.dmax {
        return Ok(());
    }

    if words > BN_MAX_WORDS {
        return Err("too long".to_string());
    }

    if bn.flags == BnFlag::StaticData {
        return Err("expand on static".to_string());
    }

    //let a = ms_calloc(words, core::mem::size_of::<BN_ULONG>());
    let a: &mut [u64; BN_MAX_WORDS] = &mut [0; BN_MAX_WORDS];
    ms_memcpy(a, &bn.d, core::mem::size_of::<BN_ULONG>() * bn.width);
    //ms_free(bn.d);

    bn.d = *a;
    bn.dmax = words;

    Ok(())
}

fn bn_fits_in_words(bn: &BIGNUM, num: usize) -> bool {
    let mut mask = 0;
    for i in num..bn.width {
        mask = mask | bn.d[i];
    }
    return mask == 0;
}

fn bn_uadd_consttime(r: &mut BIGNUM, a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    let mut temp_a = a.clone();
    let mut temp_b = b.clone();

    // swap order to short one is in a
    if a.width < b.width {
        temp_a = b.clone();
        temp_b = a.clone();
    }

    let max = temp_a.width;
    let min = temp_b.width;

    match bn_wexpand(r, max + 1) {
        Ok(_) => (),
        Err(e) => return Err(e),
    }

    r.width = max + 1;
    let mut carry = bn_add_words(&mut r.d[0..min], &temp_a.d[0..min], &temp_b.d[0..min]);
    for i in min..max {
        (r.d[i], carry) = ms_addc_u64(temp_a.d[i], 0, carry)
    }

    r.d[max] = carry as u64;
    Ok(())
}

fn bn_usub_consttime(r: &mut BIGNUM, a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    let mut b_width = b.width;
    if b_width > a.width {
        if !bn_fits_in_words(b, a.width) {
            return Err("something".to_string());
        }
        b_width = a.width;
    }

    match bn_wexpand(r, a.width) {
        Err(e) => return Err(e),
        _ => (),
    }

    let mut borrow = bn_sub_words(&mut r.d[0..b_width], &a.d[0..b_width], &b.d[0..b_width]);
    for i in b_width..a.width {
        (r.d[i], borrow) = ms_subc_u64(a.d[i], 0, borrow);
    }

    if borrow {
        return Err("r arg2 lt arg3".to_string());
    }

    r.width = a.width;
    r.neg = false;
    return Ok(());
}

// FIX TO INTEGERS
fn bn_cmp_words_consttime(a: &[BN_ULONG], a_len: usize, b: &[BN_ULONG], b_len: usize) -> i64 {
    //OPENSSL_STATIC_ASSERT(sizeof(BN_ULONG) <= sizeof(crypto_word_t),
    //                    crypto_word_t_is_too_small)

    let mut ret = 0;
    let min = {
        if a_len < b_len {
            a_len
        } else {
            b_len
        }
    };

    for i in 0..min {
        let eq = constant_time_eq(a[i] as i64, b[i] as i64);
        let lt = constant_time_lt(a[i] as i64, b[i] as i64);
        ret = constant_time_select(eq, ret, constant_time_select(lt, -1, 1));
    }

    if a_len < b_len {
        let mut mask = 0;
        for i in a_len..b_len {
            mask = mask | b[i];
        }
        ret = constant_time_select(constant_time_is_zero(mask as i64), ret, -1);
    } else if b_len < a_len {
        let mut mask = 0;
        for i in b_len..a_len {
            mask = a[i];
        }
        ret = constant_time_select(constant_time_is_zero(mask as i64), ret, 1);
    }

    return ret;
}

fn bn_uadd(r: &mut BIGNUM, a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    let res = bn_uadd_consttime(r, a, b);
    match res {
        Ok(_) => {
            bn_set_minimal_width(r);
            Ok(())
        }
        Err(e) => return Err(e),
    }
}

fn bn_usub(r: &mut BIGNUM, a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    let res = bn_usub_consttime(r, a, b);
    match res {
        Ok(_) => {
            bn_set_minimal_width(r);
            Ok(())
        }
        Err(e) => return Err(e),
    }
}

fn bn_ucmp(a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    if bn_cmp_words_consttime(&a.d, a.width, &b.d, b.width) == 1 {
        return Ok(());
    }
    return Err("something".to_string());
}

pub fn bn_add(r: &mut BIGNUM, a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    let mut temp_a = a.clone();
    let mut temp_b = b.clone();

    if a.neg ^ b.neg {
        if a.neg {
            temp_a = b.clone();
            temp_b = a.clone();
        }

        if bn_ucmp(&temp_a, &temp_b).is_ok() {
            match bn_usub(r, &temp_b, &temp_a) {
                Err(e) => return Err(e),
                _ => (),
            }
            r.neg = true;
        } else {
            match bn_usub(r, &temp_a, &temp_b) {
                Err(e) => return Err(e),
                _ => (),
            }
            r.neg = false;
        }
        return Ok(());
    }

    let ret = bn_uadd(r, &temp_a, &temp_b);
    r.neg = a.neg;
    return ret;
}

pub fn bn_sub(r: &mut BIGNUM, a: &BIGNUM, b: &BIGNUM) -> Result<(), String> {
    let mut add = false;
    let mut neg = false;

    let mut temp_a = a.clone();
    let mut temp_b = b.clone();

    if a.neg {
        if b.neg {
            temp_a = b.clone();
            temp_b = a.clone();
        } else {
            add = true;
            neg = true;
        }
    } else {
        if b.neg {
            add = true;
            neg = false;
        }
    }

    if add {
        match bn_uadd(r, &temp_a, &temp_b) {
            Err(e) => return Err(e),
            _ => (),
        }

        r.neg = neg;
        return Ok(());
    }

    if bn_cmp_words_consttime(&temp_a.d, temp_a.width, &temp_b.d, temp_b.width) < 0 {
        match bn_usub(r, &temp_b, &temp_a) {
            Err(e) => return Err(e),
            _ => (),
        }

        r.neg = true;
    } else {
        match bn_usub(r, &temp_a, &temp_b) {
            Err(e) => return Err(e),
            _ => (),
        }

        r.neg = false;
    }

    return Ok(());
}

#[bums_macros::check_mem_safe("crypto-playground/generated-asm/linux-aarch64/crypto/fipsmodule/bn-armv8.S", output.as_mut_ptr(), a.as_ptr(), b.as_ptr(), output.len())]
fn bn_add_words(output: &mut [u64], a: &[u64], b: &[u64]) -> bool;

#[bums_macros::check_mem_safe("crypto-playground/generated-asm/linux-aarch64/crypto/fipsmodule/bn-armv8.S", output.as_mut_ptr(), a.as_ptr(), b.as_ptr(), output.len())]
fn bn_sub_words(output: &mut [u64], a: &[u64], b: &[u64]) -> bool;

#[cfg(test)]
mod tests {
    use super::*;
    use aws_lc_sys;

    extern "C" {
        #[link_name = "aws_lc_0_14_1_bn_add_words"]
        fn aws_bn_add_words(output: *mut u8, a: *const u8, b: *const u8, len: usize);

        #[link_name = "aws_lc_0_14_1_bn_sub_words"]
        fn aws_bn_sub_words(output: *mut u8, a: *const u8, b: *const u8, len: usize);
    }

    #[test]
    fn test_bn_add_asm_impls() {
        let ours = {
            let out = &mut [0; 3];
            let a = &[0, 1, 2];
            let b = &[0, 1, 2];
            bn_add_words(out, a, b);
            out.clone()
        };

        let theirs = {
            let out = &mut [0; 3];
            let a = [0, 1, 2];
            let b = [0, 1, 2];
            unsafe {
                aws_bn_add_words(out.as_mut_ptr(), a.as_ptr(), b.as_ptr(), out.len());
            }
            out.clone()
        };
        assert_eq!(ours[0], theirs[0].into());
        assert_eq!(ours[1], theirs[1].into());
        assert_eq!(ours[2], theirs[2].into());
    }

    #[test]
    fn test_bn_sub_asm_impls() {
        let ours = {
            let out = &mut [0; 3];
            let a = [2, 2, 2];
            let b = [0, 1, 2];
            bn_sub_words(out, &a, &b);
            out.clone()
        };

        let theirs = {
            let out = &mut [0; 3];
            let a = [2, 2, 2];
            let b = [0, 1, 2];
            unsafe {
                aws_bn_sub_words(out.as_mut_ptr(), a.as_ptr(), b.as_ptr(), out.len());
            }
            out.clone()
        };

        assert_eq!(ours[0], theirs[0].into());
        assert_eq!(ours[1], theirs[1].into());
        assert_eq!(ours[2], theirs[2].into());
    }

    #[test]
    fn test_add_asm_works() {
        let out = &mut [0; 3];
        let a = &[0, 1, 2];
        let b = &[0, 1, 2];
        bn_add_words(out, a, b);
        assert_eq!(out, &mut [0, 2, 4]);
    }

    #[test]
    fn test_sub_asm_works() {
        let out = &mut [0; 3];
        let a = &[5, 5, 5];
        let b = &[0, 1, 2];
        bn_sub_words(out, a, b);
        assert_eq!(out, &mut [5, 4, 3]);
    }

    #[test]
    fn test_add_impl() {
        let them = unsafe {
            let out = aws_lc_sys::BN_new();
            aws_lc_sys::BN_init(out);
            let a = aws_lc_sys::BN_new();
            aws_lc_sys::BN_set_u64(a, 123);
            let b = aws_lc_sys::BN_new();
            aws_lc_sys::BN_set_u64(b, 321);
            aws_lc_sys::BN_add(out, a, b);
            *out
        };

        let ours = {
            let out = &mut BIGNUM::new();
            let a = &mut BIGNUM::new();
            let b = &mut BIGNUM::new();

            a.set_u64(123);
            b.set_u64(321);
            let res = bn_add(out, a, b);
            assert!(res.is_ok());
            out.clone()
        };

        assert_eq!(unsafe { *them.d }, ours.d[0]);
        assert_eq!(them.width, ours.width.try_into().unwrap());
        assert_eq!(them.dmax, ours.dmax.try_into().unwrap());
    }

    #[test]
    fn test_sub_impl() {
        let them = unsafe {
            let out = aws_lc_sys::BN_new();
            aws_lc_sys::BN_init(out);
            let a = aws_lc_sys::BN_new();
            aws_lc_sys::BN_set_u64(a, 321);
            let b = aws_lc_sys::BN_new();
            aws_lc_sys::BN_set_u64(b, 123);
            aws_lc_sys::BN_sub(out, a, b);
            *out
        };

        let ours = {
            let out = &mut BIGNUM::new();
            let a = &mut BIGNUM::new();
            let b = &mut BIGNUM::new();

            a.set_u64(321);
            b.set_u64(123);
            let res = bn_sub(out, a, b);
            assert!(res.is_ok());
            out.clone()
        };

        assert_eq!(unsafe { *them.d }, ours.d[0]);
        assert_eq!(them.width, ours.width.try_into().unwrap());
        assert_eq!(them.dmax, ours.dmax.try_into().unwrap());
    }
}
