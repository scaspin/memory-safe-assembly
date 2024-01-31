mod tests {
    use bums;
    use bums::common;
    use std::fs::File;
    use std::io::BufReader;

    #[test]
    fn check_sha256_armv8_ios64() -> std::io::Result<()> {
        use std::io::BufRead;

        let file = File::open("assets/processed-sha256-armv8-ios64.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("_sha256_block_data_order");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);

        // x0 -- context
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            register: String::from("x0"),
            start_offset: common::ValueType::REAL(0),
            end_offset: common::ValueType::REAL(64), // FIX: verify
        });
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::WRITE,
            register: String::from("x0"),
            start_offset: common::ValueType::REAL(0),
            end_offset: common::ValueType::REAL(64), // FIX: verify
        });

        let blocks = common::AbstractValue {
            name: "Blocks".to_string(),
            min: Some(1),
            max: None,
        };

        let length = common::AbstractValue {
            name: "Blocks lsl 6".to_string(),
            min: Some(1),
            max: None,
        };

        // x1 -- input blocks
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::WRITE,
            register: String::from("x1"),
            start_offset: common::ValueType::REAL(0),
            end_offset: common::ValueType::REAL(256),
        });
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            register: String::from("x1"),
            start_offset: common::ValueType::REAL(0),
            end_offset: common::ValueType::ABSTRACT(length.clone()),
        });

        // x2 -- number of blocks
        engine.add_abstract(String::from("x2"), blocks);
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            register: String::from("x2"),
            start_offset: common::ValueType::REAL(0),
            end_offset: common::ValueType::REAL(64),
        });

        engine.start(start_label)
    }

    #[test]
    fn stack_push_pop() -> std::io::Result<()> {
        use std::io::BufRead;

        let file = File::open("tests/asm-examples/stack_push_pop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("stack_test");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);
        engine.start(start_label)
    }
}
