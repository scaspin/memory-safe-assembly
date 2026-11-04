use bums_macros as bums;

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("huf_decompress_amd64.S", args.as_mut_ptr(),
    [args.len() == 19, src.len() == n, n <= 1099511627776,
     l1 >= 8, l2 >= 8, l3 >= 8, l4 >= 8, n == l1 + l2 + l3 + l4 + 6,
     args[0] == src.as_ptr().add(l1 - 2), args[1] == src.as_ptr().add(l1 + l2 - 2),
     args[2] == src.as_ptr().add(l1 + l2 + l3 - 2), args[3] == src.as_ptr().add(n - 8),
     dst.len() == d, d <= 1099511627776, 4 * q >= d, 4 * q <= d + 3, 3 * q < d,
     args[4] == dst.as_mut_ptr(), args[5] == dst.as_mut_ptr().add(q),
     args[6] == dst.as_mut_ptr().add(2 * q), args[7] == dst.as_mut_ptr().add(3 * q),
     dt.len() == 2048, args[12] == dt.as_ptr(),
     args[13] == src.as_ptr(), args[14] == dst.as_mut_ptr().add(d)]))]
fn HUF_decompress4X1_usingDTable_internal_fast_asm_loop(args: &mut [usize], src: &[u8], dst: &mut [u8], dt: &[u16],
    n: usize, l1: usize, l2: usize, l3: usize, l4: usize, d: usize, q: usize);

#[cfg_attr(target_arch = "x86_64", bums::check_mem_safe("huf_decompress_amd64.S", args.as_mut_ptr(),
    [args.len() == 19, src.len() == n, n <= 1099511627776,
     l1 >= 8, l2 >= 8, l3 >= 8, l4 >= 8, n == l1 + l2 + l3 + l4 + 6,
     args[0] == src.as_ptr().add(l1 - 2), args[1] == src.as_ptr().add(l1 + l2 - 2),
     args[2] == src.as_ptr().add(l1 + l2 + l3 - 2), args[3] == src.as_ptr().add(n - 8),
     dst.len() == d, d <= 1099511627776, 4 * q >= d, 4 * q <= d + 3, 3 * q < d,
     args[4] == dst.as_mut_ptr(), args[5] == dst.as_mut_ptr().add(q),
     args[6] == dst.as_mut_ptr().add(2 * q), args[7] == dst.as_mut_ptr().add(3 * q),
     dt.len() == 2048, dt[..] >= 16777216, dt[..] <= 50331647, args[12] == dt.as_ptr(),
     args[13] == src.as_ptr(), args[14] == dst.as_mut_ptr().add(d)]))]
fn HUF_decompress4X2_usingDTable_internal_fast_asm_loop(args: &mut [usize], src: &[u8], dst: &mut [u8], dt: &[u32],
    n: usize, l1: usize, l2: usize, l3: usize, l4: usize, d: usize, q: usize);
