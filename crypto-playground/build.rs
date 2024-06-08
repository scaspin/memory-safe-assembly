fn main() {
    println!("cargo:rerun-if-changed=assembly/aws-fips");
    let mut build = cc::Build::new();

    for entry in std::fs::read_dir("generated-asm/linux-aarch64/crypto/fipsmodule").unwrap() {
        match entry {
            Ok(entry) => {
		println!("cargo::rerun-if-changed={}", entry.path().display());
                build.include("include").file(entry.path());
            }
            Err(e) => println!("cargo::warning:{}", e),
        }
    }

    build.compile("linkedasms");
    println!("cargo:rustc-link-lib=linkedasms");
}
