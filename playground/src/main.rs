use bums_macros;

#[bums_macros::check_mem_safe("assembly/example.S")]
fn somefunc(a: i32, b: i32) -> i32;

#[bums_macros::check_mem_safe("assembly/example.S", a.as_ptr())]
fn somefuncwithslice(a: &[u8]);

#[bums_macros::check_mem_safe("assembly/example.S", a.as_mut_ptr(), a.len())]
fn somefuncwithweirdcallingconventionwrite(a: &mut [u8]);

#[bums_macros::check_mem_safe("assembly/example.S", a.as_ptr(), a.len())]
fn somefuncwithweirdcallingconventionread(a: &[u8]);

#[bums_macros::check_mem_safe("assembly/store.S")]
fn store(a: i32, b: i32, vec: *mut u32);

#[bums_macros::check_mem_safe("assembly/store.S", vec.as_mut_ptr())]
fn store_slice(vec: &mut [u8]);

#[bums_macros::check_mem_safe("assembly/add.S")]
fn add(a: i32, b: i32) -> i32;

fn main() {
    println!("Hello, World");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_addition() {
        assert_eq!(3, add(1, 2));
    }

    #[test]
    fn test_store() {
        let vec = &mut [0];
        store(2, 3, vec.as_mut_ptr());
        assert_eq!(5, vec[0])
    }

    #[test]
    fn test_store_slice() {
        let vec = &mut [0];
        store_slice(vec);
        assert!(vec[0] != 0)
    }
}
