fn main() {
    // Compile your assembly code
    println!("cargo:rerun-if-changed=assembly/sha256-armv8-apple.S");
    cc::Build::new()
        .file("assembly/sha256-armv8-apple.S")
        .compile("unique_name_for_this_lib_sha256");
    // Link the generated object file with the Rust project
    println!("cargo:rustc-link-object=sha256-armv8-apple.o");
    println!("cargo:rustc-link-lib=unique_name_for_this_lib_sha256");
}
