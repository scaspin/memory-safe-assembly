mod tests {
    use bums;
    use bums::common;
    use std::fs::File;
    use std::io::{BufRead, BufReader};
    use z3::*;

    #[test]
    fn bn_add() -> std::io::Result<()> {
        env_logger::init();

        let file = File::open("tests/asm-examples/bn-armv8-apple.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("_bn_add_words");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut cfg = Config::new();
        cfg.set_proof_generation(true);
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        // size is number of words!
        let size = common::AbstractExpression::Expression(
            "*".to_string(),
            Box::new(common::AbstractExpression::Abstract("size".to_string())),
            Box::new(common::AbstractExpression::Immediate(4)),
        );

        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "x0".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: size.clone(),
        });
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::WRITE,
            base: "x0".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: size.clone(),
        });

        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "x1".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: size.clone(),
        });
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "x2".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: size.clone(),
        });

        engine.add_abstract(String::from("x3"), size);

        let res = engine.start(start_label);
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn sha256_armv8_ios64() -> std::io::Result<()> {
        //env_logger::init();

        let file = File::open("tests/asm-examples/processed-sha256-armv8-ios64.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("_sha256_block_data_order");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut cfg = Config::new();
        cfg.set_proof_generation(true);
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        // x0 -- context
        engine.add_region_from(
            common::RegionType::READ,
            "x0".to_string(),
            (Some(32), None, None),
        );
        engine.add_region_from(
            common::RegionType::WRITE,
            "x0".to_string(),
            (Some(32), None, None),
        );

        let blocks = common::AbstractExpression::Abstract("Blocks".to_string());
        let length = common::AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(blocks.clone()),
            Box::new(common::AbstractExpression::Immediate(6)),
        );
        let base = common::AbstractExpression::Abstract("Base".to_string());

        // x1 -- input blocks
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "Base".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: length,
        });

        // x2 -- number of blocks
        engine.add_abstract(String::from("x2"), blocks);

        //engine.dont_fail_fast();
        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn test_sha256_armv8_linux() -> std::io::Result<()> {
        //env_logger::init();

        let file = File::open("tests/asm-examples/processed-sha256-armv8-linux.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("sha256_block_data_order");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut cfg = Config::new();
        cfg.set_proof_generation(true);
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        // x0 -- context
        engine.add_region_from(
            common::RegionType::READ,
            "x0".to_string(),
            (Some(32), None, None),
        );
        engine.add_region_from(
            common::RegionType::WRITE,
            "x0".to_string(),
            (Some(32), None, None),
        );

        let blocks = common::AbstractExpression::Abstract("Blocks".to_string());
        let length = common::AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(blocks.clone()),
            Box::new(common::AbstractExpression::Immediate(6)),
        );
        let base = common::AbstractExpression::Abstract("Base".to_string());

        // x1 -- input blocks
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "Base".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: length,
        });

        // x2 -- number of blocks
        engine.add_abstract(String::from("x2"), blocks);

        //engine.dont_fail_fast();
        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
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

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);
        let res = engine.start(start_label);
        assert!(res.is_ok());
        res
    }

    #[test]
    fn basic_abstract_loop_no_constraints() -> std::io::Result<()> {
        // env_logger::init();

        let file = File::open("tests/asm-examples/abstract-loop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        let length = common::AbstractExpression::Abstract("Length".to_string());
        let base = common::AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (None, Some("length".to_string()), None),
        );

        engine.add_abstract(String::from("x2"), length);

        engine.change_alignment(1);
        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
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

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        let length = common::AbstractExpression::Abstract("Length".to_string());
        let base = common::AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "Base".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: length.clone(),
        });

        engine.add_abstract(String::from("x2"), length);

        engine.change_alignment(1);
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

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        let length1 = common::AbstractExpression::Abstract("Length1".to_string());
        let length2 = common::AbstractExpression::Abstract("Length2".to_string());
        let base1 = common::AbstractExpression::Abstract("Base1".to_string());

        engine.add_abstract(String::from("x1"), base1.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "Base1".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: length1,
        });
        engine.add_abstract(String::from("x2"), length2.clone());

        engine.change_alignment(1);
        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn double_loop() -> std::io::Result<()> {
        // env_logger::init();

        let file = File::open("tests/asm-examples/double-abstract-loop.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("start");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        let length = common::AbstractExpression::Abstract("Length".to_string());
        let base = common::AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(common::MemorySafeRegion {
            region_type: common::RegionType::READ,
            base: "Base".to_string(),
            start: common::AbstractExpression::Immediate(0),
            end: length.clone(),
        });

        engine.add_abstract(String::from("x2"), length);
        engine.change_alignment(1);
        let res = engine.start(start_label);
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn z3_abstract_bound_unsafe() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        for _ in 0..5 {
            program.push("ldr x1,[x0,#4]".to_string());
        }

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (None, Some("length".to_string()), None),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn z3_abstract_bound_unsafe_zero() -> std::io::Result<()> {
        let mut program = Vec::new();
        program.push("start:".to_string());

        program.push("ldr x1,[x0,#0]".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (None, Some("length".to_string()), None),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn z3_real_bound_safe() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());

        program.push("ldr x1,[x0,#0]".to_string());
        program.push("ldr x1,[x0,#4]".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (Some(2), None, None),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn z3_real_bound_unsafe() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("ldr x1,[x0,#0]".to_string());
        program.push("ldr x1,[x0,#8]".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (Some(2), None, None),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn z3_simple_loop_with_no_mem_access() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("add x1,#0,#0".to_string());
        program.push("add x2,#0,#4".to_string());
        program.push("loop:".to_string());
        program.push("add x1,x1,#1".to_string());
        program.push("cmp x1,x2".to_string());
        program.push("b.ne loop".to_string());
        program.push("ret".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        let res = engine.start("start".to_string());
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn z3_simple_loop_with_mem_access_safe() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("add x1,#0,#0".to_string());
        program.push("add x2,#0,#4".to_string());
        program.push("loop:".to_string());
        program.push("ldr x3,[x0,#0]".to_string());
        program.push("add x1,x1,#1".to_string());
        program.push("add x0,x0,#4".to_string());
        program.push("cmp x1,x2".to_string());
        program.push("b.ne loop".to_string());
        program.push("ret".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (Some(4), None, None),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn z3_complex_loop_with_mem_access_safe() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("add x1,x0,x1,lsl#2".to_string());
        program.push("loop:".to_string());
        program.push("cmp x0,x1".to_string());
        program.push("b.eq end".to_string());
        program.push("ldr x3,[x0,#0]".to_string());
        program.push("add x0,x0,#4".to_string());
        program.push("b loop".to_string());
        program.push("end:".to_string());
        program.push("ret".to_string());

        let mut cfg = Config::new();
        cfg.set_proof_generation(true);
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_abstract_from(1, "blocks".to_string());

        let length = common::AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(common::AbstractExpression::Abstract("blocks".to_string())),
            Box::new(common::AbstractExpression::Immediate(2)),
        );
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (None, None, Some(length)),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn z3_complex_loop_with_mem_access_unsafe() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("add x1,x0,x1,lsl#4".to_string());
        program.push("loop:".to_string());
        program.push("cmp x0,x1".to_string());
        program.push("b.eq end".to_string());
        program.push("ldr x3,[x0,#0]".to_string());
        program.push("add x0,x0,#4".to_string());
        program.push("b loop".to_string());
        program.push("end:".to_string());
        program.push("ret".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (Some(3), None, None),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn z3_complex_loop_with_no_mem_access() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("add x1,x0,x1,lsl#4".to_string());
        program.push("loop:".to_string());
        program.push("cmp x0,x1".to_string());
        program.push("b.eq end".to_string());
        program.push("add x0,x0,#4".to_string());
        program.push("b loop".to_string());
        program.push("end:".to_string());
        program.push("ret".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region_from(
            common::RegionType::READ,
            "base".to_string(),
            (None, Some("length".to_string()), None),
        );
        engine.add_abstract_from(1, "length".to_string());

        let res = engine.start("start".to_string());
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn z3_example_branch() -> std::io::Result<()> {
        //env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());
        program.push("cmp x1,x2".to_string());
        program.push("b.ne branch".to_string());
        program.push("add x0,x0,#4".to_string());
        program.push("b end".to_string());
        program.push("branch:".to_string());
        program.push("add x0,x0,#2".to_string());
        program.push("end:".to_string());
        program.push("ret".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "left".to_string());
        engine.add_abstract_from(1, "right".to_string());

        let res = engine.start("start".to_string());
        assert!(res.is_ok());
        Ok(())
    }
}
