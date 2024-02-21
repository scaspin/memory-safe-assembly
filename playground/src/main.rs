use bums_macros;
use std::arch::global_asm;

bums_macros::safe_global_asm!("example.S","start");

fn main() {
    // inline
    bums_macros::safe_asm!(
        " start:
        add x1,x1,#1"
    );

    //global
    unsafe {
        start();
    }
}
