use bums_macros;

#[bums_macros::check_mem_safe("example")]
fn somefunc(a: i32, b: i32) -> i32;

#[bums_macros::check_mem_safe("example")]
fn somefuncwitharray(a: [u8; 4]);

#[bums_macros::check_mem_safe("example")]
fn somefuncwithslice(a: &[u8]);

#[bums_macros::check_mem_safe("example", a.as_mut_ptr(), a.len())]
fn somefuncwithweirdcallingconventionwrite(a: &mut [u8]);

#[bums_macros::check_mem_safe("example", a.as_ptr(), a.len())]
fn somefuncwithweirdcallingconventionread(a: &[u8]);

bums_macros::safe_global_asm!("example.S", "start");

fn main() {
    somefunc(1, 2);
    somefuncwitharray([1, 2, 3, 4]);
    let slice = vec![1, 2, 3];
    somefuncwithslice(&slice);
    somefuncwithweirdcallingconventionread(&slice);

    let mut funslice = vec![1, 2, 3];
    somefuncwithweirdcallingconventionwrite(&mut funslice);

    // wip: inline asm
    bums_macros::safe_asm!(
        "begin:
            nop",
        "begin"
    );

    // wip: global asm
    // FIX: uses different locations of example.S, give global address
    unsafe {
        start();
    }
}
