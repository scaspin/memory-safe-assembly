extern "C" {
    fn sha256_block_data_order(context: *mut u32, input: *const u8, input_length: usize);
}

fn convert(data: &[u32; 8]) -> [u8; 32] {
    let mut res = [0; 32];
    for i in 0..8 {
        res[4*i..][..4].copy_from_slice(&data[i].to_le_bytes());
    }
    res
}

fn incomplete_sha256_digest(msg: &[u8], output: &mut [u8]) {
    let mut context: &mut [u32; 8] = &mut [
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
        0x5be0cd19,
    ];

    println!("context before: {:?}", context);
    unsafe {sha256_block_data_order(context.as_mut_ptr(), msg.as_ptr(), 1)};
    println!("context after: {:?}", context);
    output.copy_from_slice(&convert(context));
}

fn main() {
    let message1: &[u8] = &[
        1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 17, 0, 5, 6, 7, 8, 9, 10,
    ];
    let mut v = vec![0; 32];
    let mut output: &mut [u8] = v.as_mut_slice();
    incomplete_sha256_digest(&message1, &mut output);
    println!("hi");
    println!("output 1: {:?}", output);
    
    let message2: &[u8] = &[
        1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 17, 0, 5, 6, 7, 8, 9, 10,
    ];
    let mut v = vec![0; 32];
    let mut output2: &mut [u8] = v.as_mut_slice();
    incomplete_sha256_digest(&message2, &mut output2);
    println!("output 2: {:?}", output2);
}
