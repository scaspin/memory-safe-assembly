use bums_macros;

//fn safe_asm(filename: &str) {
//    //bums_macros::safe_asm!(filename);
//}

fn main() {
    bums_macros::safe_asm!("example.S", start, x1: vec[_;length], x2: length)
}
