mod tests {
    use bums;
    use bums::common::*;
    use std::fs::File;
    use std::io::{BufRead, BufReader};
    use z3::*;

    #[test]
    fn bn_add() -> std::io::Result<()> {
        // env_logger::init();

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
        let size = AbstractExpression::Expression(
            "*".to_string(),
            Box::new(AbstractExpression::Abstract("size".to_string())),
            Box::new(AbstractExpression::Immediate(4)),
        );

        engine.add_region(RegionType::RW, "x0".to_string(), size.clone());

        engine.add_region(RegionType::READ, "x1".to_string(), size.clone());
        engine.add_region(RegionType::READ, "x2".to_string(), size.clone());
        engine.add_abstract(String::from("x3"), size);

        let res = engine.start(start_label);
        assert!(res.is_ok());
        Ok(())
    }

    #[test]
    fn bn_sub() -> std::io::Result<()> {
        // env_logger::init();

        let file = File::open("tests/asm-examples/bn-armv8-apple.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("_bn_sub_words");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut cfg = Config::new();
        cfg.set_proof_generation(true);
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        // size is number of words!
        let size = AbstractExpression::Expression(
            "*".to_string(),
            Box::new(AbstractExpression::Abstract("size".to_string())),
            Box::new(AbstractExpression::Immediate(4)),
        );

        engine.add_region(RegionType::RW, "x0".to_string(), size.clone());

        engine.add_region(RegionType::READ, "x1".to_string(), size.clone());

        engine.add_region(RegionType::READ, "x2".to_string(), size.clone());

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
        engine.add_region(
            RegionType::RW,
            "x0".to_string(),
            AbstractExpression::Immediate(32),
        );

        let blocks = AbstractExpression::Abstract("Blocks".to_string());
        let length = AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(blocks.clone()),
            Box::new(AbstractExpression::Immediate(6)),
        );
        let base = AbstractExpression::Abstract("Base".to_string());

        // x1 -- input blocks
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(RegionType::READ, "Base".to_string(), length);

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
        engine.add_region(
            RegionType::READ,
            "x0".to_string(),
            AbstractExpression::Immediate(32),
        );
        engine.add_region(
            RegionType::WRITE,
            "x0".to_string(),
            AbstractExpression::Immediate(32),
        );

        let blocks = AbstractExpression::Abstract("Blocks".to_string());
        let length = AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(blocks.clone()),
            Box::new(AbstractExpression::Immediate(6)),
        );
        let base = AbstractExpression::Abstract("Base".to_string());

        // x1 -- input blocks
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(RegionType::READ, "Base".to_string(), length);

        // x2 -- number of blocks
        engine.add_abstract(String::from("x2"), blocks);

        //engine.dont_fail_fast();
        let res = engine.start(start_label);
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn stack_push_pop() -> std::io::Result<()> {
        // env_logger::init();

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

    /*
     * This should fail since first memory access can succeed when length is 0,
     */
    #[test]
    fn basic_abstract_loop() -> std::io::Result<()> {
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

        let length = AbstractExpression::Abstract("Length".to_string());
        let base = AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(RegionType::READ, "Base".to_string(), length.clone());

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

        let length = AbstractExpression::Abstract("Length".to_string());
        let base = AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(RegionType::READ, "Base".to_string(), length.clone());

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

        let length1 = AbstractExpression::Abstract("Length1".to_string());
        let length2 = AbstractExpression::Abstract("Length2".to_string());
        let base1 = AbstractExpression::Abstract("Base1".to_string());

        engine.add_abstract(String::from("x1"), base1.clone());
        engine.add_region(RegionType::READ, "Base1".to_string(), length1);
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

        let length = AbstractExpression::Abstract("Length".to_string());
        let base = AbstractExpression::Abstract("Base".to_string());
        // Base is the base address of the input buffer
        engine.add_abstract(String::from("x1"), base.clone());
        engine.add_region(RegionType::READ, "Base".to_string(), length.clone());

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
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Abstract("length".to_string()),
        );

        let res = engine.start("start".to_string());
        assert!(res.is_err());
        Ok(())
    }

    #[test]
    fn z3_abstract_bound_unsafe_zero() -> std::io::Result<()> {
        // env_logger::init();

        let mut program = Vec::new();
        program.push("start:".to_string());

        program.push("ldr x1,[x0,#0]".to_string());

        let cfg = Config::new();
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "base".to_string());
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Abstract("length".to_string()),
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
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Immediate(8),
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
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Immediate(2),
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
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Immediate(16),
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

        let length = AbstractExpression::Expression(
            "lsl".to_string(),
            Box::new(AbstractExpression::Abstract("blocks".to_string())),
            Box::new(AbstractExpression::Immediate(2)),
        );
        engine.add_region(RegionType::READ, "base".to_string(), length);

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
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Immediate(3),
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
        engine.add_region(
            RegionType::READ,
            "base".to_string(),
            AbstractExpression::Abstract("length".to_string()),
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

    #[test]
    fn test_simd_gcm_init_neon() -> std::io::Result<()> {
        env_logger::init();

        let file = File::open("tests/asm-examples/ghash-neon-armv8.S")?;
        let reader = BufReader::new(file);
        let start_label = String::from("_gcm_init_neon");

        let mut program = Vec::new();
        for line in reader.lines() {
            program.push(line.unwrap_or(String::from("")));
        }

        let mut cfg = Config::new();
        cfg.set_proof_generation(true);
        let ctx = Context::new(&cfg);
        let mut engine = bums::engine::ExecutionEngine::new(program, &ctx);

        engine.add_abstract_from(0, "htable".to_string());
        engine.add_region(
            RegionType::RW,
            "htable".to_string(),
            AbstractExpression::Immediate(128 * 16),
        );

        engine.add_abstract_from(1, "h".to_string());
        engine.add_region(
            RegionType::READ,
            "h".to_string(),
            AbstractExpression::Immediate(64 * 16),
        );

        let res = engine.start(start_label);
        assert!(res.is_ok());
        Ok(())
    }
}
