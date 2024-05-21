fn main() {
    println!("cargo:rerun-if-changed=assembly/aws-fips");
    let mut build = cc::Build::new();

    let path = "assembly/aws-fips/";
    let entries = std::fs::read_dir(path).unwrap();
    for entry in entries {
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
