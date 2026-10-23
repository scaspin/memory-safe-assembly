use std::{env, path::PathBuf};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let arch = env::var("CARGO_CFG_TARGET_ARCH")?;
    let out_dir = PathBuf::from(env::var("OUT_DIR")?);
    let root = PathBuf::from(format!("asm/{arch}"));
    println!("cargo::rerun-if-changed={}", root.display());
    let Ok(components) = std::fs::read_dir(&root) else {
        println!("cargo::warning=no rendered corecrypto assembly in {}; run `git submodule update --init corecrypto-playground/corecrypto` and `python3 import-corecrypto.py`", root.display());
        return Ok(());
    };
    for component in components.flatten() {
        for entry in std::fs::read_dir(component.path())?.flatten() {
            println!("cargo::rerun-if-changed={}", entry.path().display());
            std::fs::copy(entry.path(), out_dir.join(entry.file_name()))?;
        }
    }
    Ok(())
}
