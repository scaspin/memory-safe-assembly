fn main() {
    // Compile your assembly code
    println!("cargo:rerun-if-changed=assembly/sha256-armv8-apple.S");
    cc::Build::new()
        .file("assembly/sha256-armv8-apple.S")
        .compile("sha256");
    // Link the generated object file with the Rust project
    println!("cargo:rustc-link-object=sha256-armv8-apple.o");
    println!("cargo:rustc-link-lib=sha256");

    // Compile your assembly code
    println!("cargo:rerun-if-changed=assembly/sha1-armv8-apple.S");
    cc::Build::new()
        .file("assembly/sha1-armv8-apple.S")
        .compile("sha1");
    // Link the generated object file with the Rust project
    println!("cargo:rustc-link-object=sha1-armv8-apple.o");
    println!("cargo:rustc-link-lib=sha1");
}
