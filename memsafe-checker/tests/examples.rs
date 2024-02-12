mod tests {
    use bums;
    use bums::common;
    use std::fs::File;
    use std::io::{BufRead, BufReader};

    #[test]
    fn sha256_armv8_ios64() -> std::io::Result<()> {
        // env_logger::init();

        let file = File::open("tests/asm-examples/processed-sha256-armv8-ios64.S")?;
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
            base: common::AbstractExpression::Abstract("x0".to_string()),
            start: common::AbstractExpression::Immediate(0),
            end: common::AbstractExpression::Immediate(64), // FIX: verify
        });
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::WRITE,
            base: common::AbstractExpression::Abstract("x0".to_string()),
            start: common::AbstractExpression::Immediate(0),
            end: common::AbstractExpression::Immediate(64), // FIX: verify
        });

        let blocks = common::AbstractExpression::Abstract("Blocks".to_string());
        let length = common::AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(blocks.clone()),
            Box::new(common::AbstractExpression::Immediate(4)),
        );
        let base = common::AbstractExpression::Abstract("Base".to_string());

        // x1 -- input blocks
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::WRITE,
            base: base.clone(),
            start: common::AbstractExpression::Immediate(0),
            end: common::AbstractExpression::Immediate(256),
        });
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: base,
            start: common::AbstractExpression::Immediate(0),
            end: length,
        });

        // x2 -- number of blocks
        engine.add_abstract(String::from("x2"), blocks);
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: common::AbstractExpression::Abstract("x2".to_string()),
            start: common::AbstractExpression::Immediate(0),
            end: common::AbstractExpression::Immediate(64),
        });

        engine.start(start_label)
    }

    #[test]
    fn stack_push_pop() -> std::io::Result<()> {
        let file = File::open("tests/asm-examples/stack-push-pop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("stack_test");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);
        engine.start(start_label)
    }

    #[test]
    fn abstract_loop() -> std::io::Result<()> {
        // env_logger::init();

        let file = File::open("tests/asm-examples/abstract-loop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);

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

    #[test]
    fn bad_increment_abstract_loop() -> std::io::Result<()> {
        // env_logger::init();

        let file = File::open("tests/asm-examples/bad-abstract-loop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);

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
        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
    }

    // x1 region isn't bounded by length 2, so loop
    // over x1 from 0 to a random abstract length2
    // doesn't work, since we're missing length 2
    // being connected to the memory region
    #[test]
    fn loop_on_input_abstract_loop() -> std::io::Result<()> {
        //env_logger::init();
        let file = File::open("tests/asm-examples/abstract-loop-on-input.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);

        let length1 = common::AbstractExpression::Abstract("Length1".to_string());
        let length2 = common::AbstractExpression::Abstract("Length2".to_string());
        let base1 = common::AbstractExpression::Abstract("Base1".to_string());

        engine.add_abstract(String::from("x1"), base1.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: base1,
            start: common::AbstractExpression::Immediate(0),
            end: length1,
        });
        engine.add_abstract(String::from("x2"), length2.clone());

        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn double_loop() -> std::io::Result<()> {
        let file = File::open("tests/asm-examples/double-abstract-loop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut engine = bums::engine::ExecutionEngine::new(program);

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
}
