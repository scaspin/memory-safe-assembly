use bums_macros;

bums_macros::safe_global_asm!("example.S", "start");

fn main() {
    // inline
    bums_macros::safe_asm!(
        "begin:
            nop",
        "begin"
    );

    //global
    unsafe {
        start();
    }
}
