fn main() {
    cc::Build::new().file("assembly/add.S").compile("add");
    println!("cargo:rustc-link-object=add.o");
    println!("cargo:rustc-link-lib=add");

    cc::Build::new().file("assembly/store.S").compile("store");
    println!("cargo:rustc-link-object=store.o");
    println!("cargo:rustc-link-lib=store");
}
