use capstone::{arch::arm64::ArchMode, arch::BuildsCapstone, Capstone};
use goblin::mach::Mach;
use goblin::*;
use log::info;
use rustc_demangle::demangle;
use std::fs;
use std::path::{Path, PathBuf};

#[derive(Debug)]
pub struct ParsedFunction {
    pub _name: String,
    pub program: Vec<String>,
    pub data: Vec<u64>,
    pub start_line: usize,
}

// loop over project root and find file with function name in symbols
pub fn find_and_disassemble_aarch64_function(
    project_root: String,
    function_name: &str,
) -> Result<ParsedFunction, Box<dyn std::error::Error>> {
    let target_dir = project_root;
    let target_path = Path::new(&target_dir);

    let (binary_path, line) = find_binary_with_function(target_path, function_name)?;

    info!("Found binary: {}", binary_path.display());

    let instructions = disassemble_file_aarch64(&binary_path)?;
    let (filedata, _const_addr) = reconstruct_file_data(&binary_path)?;

    Ok(ParsedFunction {
        _name: function_name.to_string(),
        program: instructions,
        data: filedata,
        start_line: line,
    })
}

fn find_binary_with_function(
    target_dir: &Path,
    function_name: &str,
) -> Result<(PathBuf, usize), Box<dyn std::error::Error>> {
    for entry in walkdir::WalkDir::new(target_dir)
        .into_iter()
        .filter_map(Result::ok)
        .filter(|e| e.file_type().is_file())
    {
        let (found, line) = function_in_binary(entry.clone(), function_name);
        if found {
            return Ok((entry.path().to_path_buf(), line));
        }
    }

    Err(format!("Could not find binary with function `{}`", function_name).into())
}

fn function_in_binary(entry: walkdir::DirEntry, function_name: &str) -> (bool, usize) {
    let path = entry.path();

    let file_data = std::fs::read(path).expect("Could not read file.");
    let bytes = file_data.as_slice();
    if let Ok(s) = Object::parse(&bytes) {
        match s {
            Object::Mach(mach) => match mach {
                Mach::Binary(macho) => {
                    for s in macho.symbols() {
                        if let Ok((name, nlist)) = s {
                            let demangled = demangle(name).to_string();
                            if demangled.contains(function_name) || name.contains(function_name) {
                                info!("Found symbol: {} in {:?}", demangled, path);
                                return (true, nlist.n_strx);
                            }
                        }
                    }
                }
                _ => return (false, 0),
            },
            Object::Elf(_)
            | Object::Archive(_)
            | Object::PE(_)
            | Object::COFF(_)
            | Object::Unknown(_) => {
                return (false, 0);
            }
            _ => {}
        }
    }
    (false, 0)
}

// take a filepath and return the instructions in the text section
fn disassemble_file_aarch64<P: AsRef<Path>>(
    binary_path: P,
) -> Result<Vec<String>, Box<dyn std::error::Error>> {
    use object::{Object, ObjectSection};

    let binary_data = fs::read(binary_path).expect("Failed to read file");
    let macho_file = object::File::parse(&*binary_data).expect("Failed to parse Mach-O");

    // Loop through sections to find the __text section
    for section in macho_file.sections() {
        if section.name().unwrap_or("") == "__text" {
            let data = section.data().expect("Failed to get section data");
            let addr = section.address();

            // Disassemble the ARM64 instructions
            let cs = Capstone::new()
                .arm64()
                .mode(ArchMode::Arm)
                .build()
                .expect("Failed to create Capstone object");

            // Disassemble the code starting from `address`
            let insns = cs.disasm_all(data, addr).expect("Failed to disassemble");

            // Return instructions
            let mut instructions = Vec::new();
            for i in insns.iter() {
                instructions.push(format!(
                    "0x{:016x}: {:8} {}",
                    i.address(),
                    i.mnemonic().unwrap_or(""),
                    i.op_str().unwrap_or("")
                ));
            }
            return Ok(instructions);
        }
    }
    return Err("No __text section found".into());
}

// take a filepath and return the instructions in the const section
fn reconstruct_file_data<P: AsRef<Path>>(
    binary_path: P,
) -> Result<(Vec<u64>, u64), Box<dyn std::error::Error>> {
    use object::{Object, ObjectSection};

    let binary_data = fs::read(binary_path).expect("Failed to read file");
    let macho_file = object::File::parse(&*binary_data).expect("Failed to parse Mach-O");

    for section in macho_file.sections() {
        if section.name().unwrap_or("") == "__const" {
            //FIX: should this be __data?
            let data = section.data().expect("Failed to get section data");
            let addr = section.address();

            return Ok((
                data.chunks(8)
                    .map(|chunk| {
                        let mut buffer = [0u8; 8];
                        buffer[..chunk.len()].copy_from_slice(chunk);
                        u64::from_le_bytes(buffer)
                    })
                    .collect(),
                addr,
            ));
        }
    }

    return Ok((Vec::new(), 0)); // a program can have no data section
}

#[cfg(test)]
mod test {
    use super::*;
    #[test]
    fn test_disassemble_bn_add_words_no_data() {
        let binary_path = "../crypto-playground".to_string();
        let function_name = "bn_add_words";
        let res = find_and_disassemble_aarch64_function(binary_path, function_name).unwrap();

        assert!(res.program.len() == 38);
        assert!(res.data.len() == 0);
        assert!(res.start_line == 1);
    }

    #[test]
    fn test_disassemble_bn_sub_words_no_data() {
        let binary_path = "../crypto-playground".to_string();
        let function_name = "bn_sub_words";
        let res = find_and_disassemble_aarch64_function(binary_path, function_name).unwrap();

        assert!(res.program.len() == 38);
        assert!(res.data.len() == 0);
        assert!(res.start_line == 15);
    }

    #[test]
    fn test_disassemble_sha1() {
        let binary_path = "../crypto-playground".to_string();
        let function_name = "sha1_block_data_order";
        let res = find_and_disassemble_aarch64_function(binary_path, function_name).unwrap();

        assert!(res.program.len() == 1139);
        assert!(res.data.len() == 17);
        assert!(res.start_line == 1);
    }
}
