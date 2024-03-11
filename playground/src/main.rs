use bums_macros;

#[bums_macros::check_mem_safe(example)]
fn somefuncwithslice(a: &[u8]);

#[bums_macros::check_mem_safe(example)]
fn somefuncwitharray(a: [u8; 4]);

#[bums_macros::check_mem_safe(example)]
fn somefunc(a: i32, b: i32);

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

    somefunc(1, 2);
}
