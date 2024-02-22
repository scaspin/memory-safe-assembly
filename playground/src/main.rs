use bums_macros;

#[bums_macros::check_mem_safe(filename)]
fn somefunc(a: i32, b: i32) -> i64;

bums_macros::safe_global_asm!("example.S", "start");

fn main() {
    // inline asm
    bums_macros::safe_asm!(
        "begin:
            nop",
        "begin"
    );

    //global asm
    //FIX: uses different locations of example.S, give global address
    unsafe {
        start();
    }

    // linking
    unsafe {
        somefunc(1, 2);
    }
}
