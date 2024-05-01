fn main() {
    println!("cargo:rerun-if-changed=assembly/sha256-armv8-apple.S");
    cc::Build::new()
        .file("assembly/sha256-armv8-apple.S")
        .compile("unique_name_for_this_lib_sha256");
    println!("cargo:rustc-link-object=sha256-armv8-apple.o");
    println!("cargo:rustc-link-lib=unique_name_for_this_lib_sha256");

    println!("cargo:rerun-if-changed=assembly/bn-armv8-apple.S");
    cc::Build::new()
        .file("assembly/bn-armv8-apple.S")
        .compile("bn_add");
    println!("cargo:rustc-link-object=bn-armv8-apple.o");
    println!("cargo:rustc-link-lib=bn_add");
}
