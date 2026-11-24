use aws_lc_rs::cipher::{
    DecryptingKey, DecryptionContext, EncryptingKey, EncryptionContext, PaddedBlockEncryptingKey,
    UnboundCipherKey, AES_128,
};
use aws_lc_rs::iv::FixedLength;
use std::process::Command;

const KEY: [u8; 16] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
const LENGTHS: [usize; 4] = [32, 20, 17, 31];

fn ending_at_guard(len: usize) -> &'static mut [u8] {
    unsafe {
        let page = libc::sysconf(libc::_SC_PAGESIZE) as usize;
        let span = (len / page + 2) * page;
        let base = libc::mmap(
            std::ptr::null_mut(),
            span + page,
            libc::PROT_READ | libc::PROT_WRITE,
            libc::MAP_PRIVATE | libc::MAP_ANON,
            -1,
            0,
        ) as *mut u8;
        libc::mprotect(base.add(span) as *mut _, page, libc::PROT_NONE);
        let start = base.add(span - len);
        std::ptr::write_bytes(start, 0x5a, len);
        std::slice::from_raw_parts_mut(start, len)
    }
}

fn safe_cbc_encrypt(len: usize) -> String {
    let key = EncryptingKey::cbc(UnboundCipherKey::new(&AES_128, &KEY).unwrap()).unwrap();
    let buffer = ending_at_guard(len);
    let context = EncryptionContext::Iv128(FixedLength::from([0u8; 16]));
    match key.less_safe_encrypt(buffer, context) {
        Ok(_) => "Ok".into(),
        Err(e) => format!("Err({e:?})"),
    }
}

fn safe_cbc_decrypt(len: usize) -> String {
    let key = DecryptingKey::cbc(UnboundCipherKey::new(&AES_128, &KEY).unwrap()).unwrap();
    let buffer = ending_at_guard(len);
    let context = DecryptionContext::Iv128(FixedLength::from([0u8; 16]));
    match key.decrypt(buffer, context) {
        Ok(_) => "Ok".into(),
        Err(e) => format!("Err({e:?})"),
    }
}

fn safe_cbc_pkcs7(len: usize) -> String {
    let key = PaddedBlockEncryptingKey::cbc_pkcs7(UnboundCipherKey::new(&AES_128, &KEY).unwrap()).unwrap();
    let mut buffer = vec![0x5au8; len];
    match key.encrypt(&mut buffer) {
        Ok(_) => format!("Ok ({} bytes after padding)", buffer.len()),
        Err(e) => format!("Err({e:?})"),
    }
}

fn raw_aws_lc_sys(len: usize, enc: i32) {
    let input = ending_at_guard(len);
    let mut output = vec![0u8; len + 64];
    let mut iv = [0u8; 16];
    unsafe {
        let mut key = std::mem::zeroed::<aws_lc_sys::AES_KEY>();
        if enc == aws_lc_sys::AES_ENCRYPT as i32 {
            aws_lc_sys::AES_set_encrypt_key(KEY.as_ptr(), 128, &mut key);
        } else {
            aws_lc_sys::AES_set_decrypt_key(KEY.as_ptr(), 128, &mut key);
        }
        aws_lc_sys::AES_cbc_encrypt(input.as_ptr(), output.as_mut_ptr(), len, &key, iv.as_mut_ptr(), enc);
    }
}

fn raw_in_child(len: usize, enc: i32) -> String {
    let status = Command::new(std::env::current_exe().unwrap())
        .args(["raw", &len.to_string(), &enc.to_string()])
        .status()
        .unwrap();
    match std::os::unix::process::ExitStatusExt::signal(&status) {
        Some(libc::SIGBUS) | Some(libc::SIGSEGV) => "FAULT".into(),
        Some(sig) => format!("signal {sig}"),
        None => "ok".into(),
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() == 4 && args[1] == "raw" {
        raw_aws_lc_sys(args[2].parse().unwrap(), args[3].parse().unwrap());
        return;
    }

    println!("safe API (aws-lc-rs), buffer ends at a guard page");
    for len in LENGTHS {
        println!("  EncryptingKey::cbc  less_safe_encrypt  len={len:<3} -> {}", safe_cbc_encrypt(len));
        println!("  DecryptingKey::cbc  decrypt            len={len:<3} -> {}", safe_cbc_decrypt(len));
        println!("  PaddedBlockEncryptingKey::cbc_pkcs7    len={len:<3} -> {}", safe_cbc_pkcs7(len));
    }

    println!("raw unsafe aws_lc_sys::AES_cbc_encrypt, input ends at a guard page");
    for len in LENGTHS {
        println!("  encrypt len={len:<3} -> {}", raw_in_child(len, aws_lc_sys::AES_ENCRYPT as i32));
        println!("  decrypt len={len:<3} -> {}", raw_in_child(len, aws_lc_sys::AES_DECRYPT as i32));
    }
}
