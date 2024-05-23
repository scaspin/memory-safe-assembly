fn main() {
    println!("cargo:rerun-if-changed=assembly/aws-fips");
    let mut build = cc::Build::new();

    for entry in std::fs::read_dir("assembly/aws-fips/").unwrap() {
        match entry {
            Ok(entry) => {
                build.file(entry.path());
            }
            Err(e) => println!("cargo::warning:{}", e),
        }
    }

    build.compile("linkedasms");
    println!("cargo:rustc-link-lib=linkedasms");
}
