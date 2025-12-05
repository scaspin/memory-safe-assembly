use addr2line::Context;
use gimli::{Dwarf, EndianRcSlice, LittleEndian, RunTimeEndian};

#[allow(dead_code)]
pub fn find_symbol_line(path: &Path, n_value: u64) -> Option<u32> {
    use std::borrow::Cow;
    use std::error::Error;
    use std::fs::File;

    use addr2line::Context;
    use object::ObjectSection;
    use object::{Object, ObjectSymbol};
    fn load_debug_file(original_path: &Path) -> std::io::Result<Vec<u8>> {
        let data = std::fs::read(original_path)?;

        // Check if DWARF exists in the main binary
        if has_dwarf(&data) {
            return Ok(data);
        }

        // Try loading dSYM
        if let Some(dsym_path) = find_dsym(original_path) {
            return std::fs::read(dsym_path);
        }

        // No DWARF available
        Ok(data)
    }

    fn has_dwarf(data: &[u8]) -> bool {
        if let Ok(obj) = object::File::parse(data) {
            obj.section_by_name(".debug_info")
                .and_then(|sec| sec.data().ok())
                .map(|b| !b.is_empty())
                .unwrap_or(false)
        } else {
            false
        }
    }

#[allow(dead_code)]
fn find_dsym(binary: &Path) -> Option<PathBuf> {
    let filename = binary.file_name()?.to_string_lossy();
    let mut dsym = binary.to_path_buf();
    dsym.set_extension("dSYM");

    let dwarf_path = dsym
        .join("Contents/Resources/DWARF")
        .join(filename.to_string());

    if dwarf_path.exists() {
        Some(dwarf_path)
    } else {
        None
    }
}

    // Load file into memory
    let file_data = load_debug_file(Path::new(path)).ok()?;
    let obj = object::File::parse(&*file_data).ok()?;

    // --- Load DWARF sections into addr2line context ---
    let ctx = {
        fn load_section<'a>(
            obj: &'a object::File<'a>,
            section_name: &str,
        ) -> gimli::EndianSlice<'a, gimli::RunTimeEndian> {
            if let Some(sec) = obj.section_by_name(section_name) {
                match sec.uncompressed_data() {
                    Ok(Cow::Borrowed(bytes)) => {
                        gimli::EndianSlice::new(bytes, gimli::RunTimeEndian::Little)
                    }
                    Ok(Cow::Owned(_)) => {
                        // Object crate currently only returns Borrowed for uncompressed sections
                        // but we defensively handle it:
                        let data = sec.data().unwrap_or(&[]);
                        gimli::EndianSlice::new(data, gimli::RunTimeEndian::Little)
                    }
                    Err(_) => gimli::EndianSlice::new(&[], gimli::RunTimeEndian::Little),
                }
            } else {
                gimli::EndianSlice::new(&[], gimli::RunTimeEndian::Little)
            }
        }

        // fn get_section<'a>(
        //     obj: &'a object::File<'a>,
        //     name: &str,
        // ) -> gimli::EndianSlice<'a, gimli::RunTimeEndian> {
        //     if let Some(sec) = obj.section_by_name(name) {
        //         if let Ok(data) = sec.data() {
        //             return gimli::EndianSlice::new(data, gimli::RunTimeEndian::Little);
        //         }
        //     }
        //     gimli::EndianSlice::new(&[], gimli::RunTimeEndian::Little)
        // }

        // println!(".debug_info = {}", get_section(&obj, ".debug_info").slice().len());
        // println!(".debug_line = {}", get_section(&obj, ".debug_line").slice().len());
        // println!(".debug_str = {}", get_section(&obj, ".debug_str").slice().len());

        Context::from_sections(
            load_section(&obj, ".debug_info").into(),
            load_section(&obj, ".debug_abbrev").into(),
            load_section(&obj, ".debug_ranges").into(),
            load_section(&obj, ".debug_rnglists").into(),
            load_section(&obj, ".debug_line").into(),
            load_section(&obj, ".debug_line_str").into(),
            load_section(&obj, ".debug_str").into(),
            load_section(&obj, ".debug_str_offsets").into(),
            load_section(&obj, ".debug_addr").into(),
            load_section(&obj, ".debug_loc").into(),
            load_section(&obj, ".debug_loclists").into(),
        )
        .ok()?
    };
    println!("addr: {:?}", n_value);

    // --- Resolve address to source location ---
    if let Ok(location) = ctx.find_location(n_value) {
        if let Some(loc) = location {
            return loc.line
        }
    }
    
    None
}
