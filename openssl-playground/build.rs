use std::{env, fs, path::Path};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let arch = env::var("CARGO_CFG_TARGET_ARCH")?;
    let source = Path::new("asm").join(&arch);
    println!("cargo:rerun-if-changed={}", source.display());
    let out_dir = env::var("OUT_DIR")?;
    for entry in fs::read_dir(&source)? {
        let path = entry?.path();
        if path.extension().is_some_and(|e| e == "S") {
            fs::copy(&path, Path::new(&out_dir).join(path.file_name().unwrap()))?;
        }
    }
    Ok(())
}
