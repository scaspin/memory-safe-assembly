mod tests {
    use bums;
    use bums::common;
    use std::fs::File;
    use std::io::{BufRead, BufReader};

    // #[test]
    // fn sha256_armv8_ios64() -> std::io::Result<()> {
    //     let file = File::open("tests/asm-examples/processed-sha256-armv8-ios64.S")?;
    //     let reader = BufReader::new(file);
    //     let start_label = String::from("_sha256_block_data_order");

    //     let mut program = Vec::new();
    //     for line in reader.lines() {
    //         program.push(line.unwrap_or(String::from("")));
    //     }

    //     let mut engine = bums::engine::ExecutionEngine::new(program);

    //     // x0 -- context
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::READ,
    //         base: String::from("x0"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::REAL(64), // FIX: verify
    //     });
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::WRITE,
    //         base: String::from("x0"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::REAL(64), // FIX: verify
    //     });

    //     let blocks = common::AbstractValue {
    //         name: "Blocks".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };

    //     let length = common::AbstractValue {
    //         name: "Blocks lsl 6".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };

    //     let base = common::AbstractValue {
    //         name: "Base".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };

    //     // x1 -- input blocks
    //     engine.add_abstract(String::from("x1"), base);
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::WRITE,
    //         base: String::from("Base"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::REAL(256),
    //     });
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::READ,
    //         base: String::from("Base"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::ABSTRACT(length.clone()),
    //     });

    //     // x2 -- number of blocks
    //     engine.add_abstract(String::from("x2"), blocks);
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::READ,
    //         base: String::from("x2"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::REAL(64),
    //     });

    //     engine.start(start_label)
    // }

    // #[test]
    // fn stack_push_pop() -> std::io::Result<()> {
    //     let file = File::open("tests/asm-examples/stack-push-pop.S")?;
    //     let reader = BufReader::new(file);
    //     let start_label = String::from("stack_test");

    //     let mut program = Vec::new();
    //     for line in reader.lines() {
    //         program.push(line.unwrap_or(String::from("")));
    //     }

    //     let mut engine = bums::engine::ExecutionEngine::new(program);
    //     engine.start(start_label)
    // }

    #[test]
    fn abstract_loop() -> std::io::Result<()> {
        env_logger::init();

        let file = File::open("tests/asm-examples/abstract-loop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);

        // let length = common::AbstractValue {
        //     name: "Length".to_string(),
        //     min: Some(0),
        //     max: None,
        // };

        // let base = common::AbstractValue {
        //     name: "Base".to_string(),
        //     min: None,
        //     max: None,
        // };

        let length = common::AbstractExpression::Abstract("Length".to_string());
        let base = common::AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: base,
            start: common::AbstractExpression::Immediate(0),
            end: length.clone(),
        });

        engine.add_abstract(String::from("x2"), length);
        engine.start(start_label)
    }
    // #[test]
    // fn double_loop() -> std::io::Result<()> {
    //     // env_logger::init();

    //     let file = File::open("tests/asm-examples/double-abstract-loop.S")?;
    //     let reader = BufReader::new(file);
    //     let start_label = String::from("start");

    //     let mut program = Vec::new();
    //     for line in reader.lines() {
    //         program.push(line.unwrap_or(String::from("")));
    //     }

    //     let mut engine = bums::engine::ExecutionEngine::new(program);

    //     let length1 = common::AbstractValue {
    //         name: "Length1".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };

    //     let length2 = common::AbstractValue {
    //         name: "Length2".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };

    //     let base1 = common::AbstractValue {
    //         name: "Base1".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };
    //     let base2 = common::AbstractValue {
    //         name: "Base2".to_string(),
    //         min: Some(1),
    //         max: None,
    //     };

    //     engine.add_abstract(String::from("x1"), base1);
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::READ,
    //         base: String::from("Base1"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::ABSTRACT(length1.clone()),
    //     });
    //     engine.add_abstract(String::from("x2"), base2);
    //     engine.add_region(common::MemorySafeRegion {
    //         region_type: common::RegionType::READ,
    //         base: String::from("Base2"),
    //         start_offset: common::ValueType::REAL(0),
    //         end_offset: common::ValueType::ABSTRACT(length2.clone()),
    //     });

    //     engine.start(start_label)
    // }
}
