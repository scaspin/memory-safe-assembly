use std::path::Path;

use bums::loader::{DataValue, Listing};

fn rav1d_listings() -> Vec<(String, Listing)> {
    let dir =
        Path::new(env!("CARGO_MANIFEST_DIR")).join("../rav1d-playground/asm/disassembled-asm");
    let mut listings = Vec::new();
    for entry in std::fs::read_dir(&dir).expect("rav1d disassembly is checked in") {
        let path = entry.unwrap().path();
        if path.extension().is_some_and(|e| e == "S") {
            let text = std::fs::read_to_string(&path).unwrap();
            let name = path.file_name().unwrap().to_string_lossy().to_string();
            listings.push((name, Listing::parse(text.lines())));
        }
    }
    assert!(!listings.is_empty());
    listings
}

#[test]
fn every_offset_label_sits_at_its_offset() {
    let mut checked = 0;
    for (file, listing) in rav1d_listings() {
        for (label, _) in &listing.labels {
            let Some(hex) = label.strip_prefix("L_") else {
                continue;
            };
            let offset = i64::from_str_radix(hex, 16).unwrap();
            assert_eq!(listing.address_of(label), Some(offset), "{file}: {label}");
            assert!(
                listing.line_for_address(offset).is_some(),
                "{file}: {label}"
            );
            checked += 1;
        }
    }
    assert!(checked > 1000, "only {checked} labels checked");
}

#[test]
fn every_table_entry_leads_to_an_instruction() {
    let mut entries = 0;
    for (file, listing) in rav1d_listings() {
        for section in &listing.data {
            for (name, symbol) in &listing.data_symbols {
                if symbol.section != section.name || !name.ends_with("_tbl") {
                    continue;
                }
                let Some(size) = symbol.size else {
                    continue;
                };
                let table = section.address + symbol.offset;
                for item in &section.items {
                    if item.offset < symbol.offset || item.offset >= symbol.offset + size {
                        continue;
                    }
                    let DataValue::LabelDifference {
                        value: entry,
                        ref base,
                        ..
                    } = item.value
                    else {
                        continue;
                    };
                    assert_eq!(base, name, "{file}: entry relative to another table");
                    assert!(
                        listing.line_for_address(table + entry).is_some(),
                        "{file}: {name} entry at {} lands on {:#x}",
                        item.offset,
                        table + entry
                    );
                    entries += 1;
                }
            }
        }
    }
    assert!(entries > 500, "only {entries} table entries checked");
}
