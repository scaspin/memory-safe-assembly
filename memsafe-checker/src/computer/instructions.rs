use crate::computer::*;

impl<'ctx> ARMCORTEXA<'_> {
    pub fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        match instruction.ty {
            InstructionType::Arithmetic => match instruction.opcode.as_str() {
                "add" => {
                    self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                }
                "sub" => {
                    self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                }
                "mul" | "umulh" => {
                    self.arithmetic("*", &|x, y| x * y, instruction.operands.clone());
                }
                "and" => {
                    self.arithmetic("&", &|x, y| x & y, instruction.operands.clone());
                }
                "orr" => {
                    self.arithmetic("|", &|x, y| x | y, instruction.operands.clone());
                }
                "orn" => {
                    self.arithmetic("!|", &|x, y: i64| x | !y, instruction.operands.clone());
                }
                "eor" => {
                    // potential TODO: deal with case where registers are the same but not imm
                    self.arithmetic("^", &|x, y| x ^ y, instruction.operands.clone());
                }
                "bic" => {
                    self.arithmetic("!&", &|x, y: i64| x & !y, instruction.operands.clone());
                }
                "adds" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                }
                "subs" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                }
                "tst" => {
                    todo!();
                }
                "ror" | "lsl" | "lsr" => {
                    let mut reg_iter = instruction.operands.iter();

                    let reg0 = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first source register");
                    let reg2 = reg_iter.next().expect("Need second source register");

                    self.shift_reg(reg0, reg1, reg2);
                }
                "ands" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("&", &|x, y| x & y, instruction.operands.clone());
                }
                "adc" => {
                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b == true {
                                self.arithmetic(
                                    "+",
                                    &|x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                            } else {
                                self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                            }
                        }
                        _ => todo!(),
                        // Some(FlagValue::Abstract(c)) => {
                        //     let opt0 = self.arithmetic("+", &|x, y| x + y, instruction.operands);
                        //     let opt1 = self.arithmetic("+", &|x, y| x + y + 1, instruction.operands);

                        //     return Ok(ExecuteReturnType::Select(c.clone(), reg0.clone(), opt0, opt1));
                        // }
                        // None => {
                        //     let opt0 = self.arithmetic("+", &|x, y| x + y, instruction.operands);
                        //     let opt1 = self.arithmetic("+", &|x, y| x + y + 1, instruction.operands);

                        //     return Ok(ExecuteReturnType::Select(
                        //         AbstractComparison::new(
                        //             "==",
                        //             AbstractExpression::Abstract("carry".to_string()),
                        //             AbstractExpression::Immediate(1),
                        //         ),
                        //         reg0.clone(),
                        //         opt0,
                        //         opt1,
                        //     ));
                        // }
                    }
                }
                "adcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b == true {
                                self.arithmetic(
                                    "+",
                                    &|x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                                self.cmn(reg1, reg2);
                            } else {
                                self.arithmetic("+", &|x, y| x + y, instruction.operands.clone());
                                self.cmn(reg1, reg2);
                            }
                        }
                        _ => todo!(),
                    }
                }
                "sbc" => match &self.carry {
                    Some(FlagValue::Real(b)) => {
                        if *b == true {
                            self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                        } else {
                            self.arithmetic("+", &|x, y| x - y - 1, instruction.operands.clone());
                        }
                    }
                    _ => todo!(),
                },
                "sbcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b == true {
                                self.arithmetic("-", &|x, y| x - y, instruction.operands.clone());
                                self.cmp(reg1, reg2);
                            } else {
                                self.arithmetic(
                                    "-",
                                    &|x, y| x - y - 1,
                                    instruction.operands.clone(),
                                );
                                self.cmp(reg1, reg2);
                            }
                        }
                        _ => todo!(),
                    }
                }
                "clz" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for clz");
                    let reg1 = reg_iter.next().expect("Need register output for clz");

                    let r1 = self.get_register(reg1);
                    match r1.kind {
                        RegisterKind::Immediate => {
                            self.set_register(
                                reg0,
                                RegisterKind::Number,
                                None,
                                r1.offset.leading_zeros() as i64,
                            );
                        }
                        _ => {
                            self.set_register(reg0, RegisterKind::Number, None, 0);
                        }
                    }
                }
                "mov" | "movz" | "movk" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for mov");
                    let reg1 = reg_iter.next().expect("Need register output for mov");

                    let mut r1 = self.get_register(reg1);

                    if let Some(a) = reg_iter.next() {
                        match a {
                            Operand::Bitwise(op, shift) => {
                                r1 = instruction_aux::shift_imm(op.to_string(), r1, *shift);
                            }
                            _ => todo!("not sure what else can show up here"),
                        }
                    }

                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                "rev" | "rev32" | "rbit" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for rev");
                    let reg1 = reg_iter.next().expect("Need register output for rev");

                    let mut r1 = self.get_register(reg1);

                    if let Some(base) = r1.base {
                        r1.base = Some(generate_expression("rev", base, AbstractExpression::Empty));
                    }

                    r1.offset = r1.offset.swap_bytes();
                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                _ => todo!("Unsupported arithmetic instruction: {:?}", instruction),
            },
            InstructionType::ControlFlow => match instruction.opcode.as_str() {
                "adr" => {
                    if let Operand::Label(label) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index,
                        );
                    } else {
                        panic!("adr not invoked correctly with register and label")
                    }
                }
                "adrp" => {
                    // Form PC-relative address to 4KB page adds an immediate value that is shifted left by 12 bits, to the PC value to form a PC-relative address, with the bottom 12 bits masked out, and writes the result to the destination register.
                    // TODO: handle case for sha256 where we need @OFF page address
                    if let Operand::Label(label) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index << 12,
                        );
                    } else {
                        panic!("adr not invoked correctly with register and label")
                    }
                }
                "cbz" => {
                    // Compare and Branch on Zero compares the value in a register with zero, and conditionally branches to a label at a PC-relative offset if the comparison is equal. It provides a hint that this is not a subroutine call or return. This instruction does not affect condition flags.
                    let register = self.get_register(&instruction.operands[0]);
                    if let Operand::Label(label) = &instruction.operands[1] {
                        if (register.base.is_none()
                            || register.base == Some(AbstractExpression::Empty))
                            && register.offset == 0
                        {
                            return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                        } else if register.kind == RegisterKind::RegisterBase {
                            return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                AbstractComparison::new(
                                    "==",
                                    AbstractExpression::Immediate(0),
                                    AbstractExpression::Register(Box::new(register)),
                                ),
                                label.to_string(),
                            ));
                        } else {
                            return Ok(ExecuteReturnType::Next);
                        }
                    } else {
                        panic!("cbz not invoked correctly with register and label");
                    }
                }
                "cbnz" => {
                    let register = self.get_register(&instruction.operands[0]);
                    if let Operand::Label(label) = &instruction.operands[1] {
                        if (register.base.is_none()
                            || register.base == Some(AbstractExpression::Empty))
                            && register.offset == 0
                        {
                            return Ok(ExecuteReturnType::Next);
                        } else if register.kind == RegisterKind::RegisterBase {
                            return Ok(ExecuteReturnType::ConditionalJumpLabel(
                                AbstractComparison::new(
                                    "!=",
                                    AbstractExpression::Immediate(0),
                                    AbstractExpression::Register(Box::new(register)),
                                ),
                                label.to_string(),
                            ));
                        } else {
                            return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                        }
                    } else {
                        panic!("cbnz not invoked correctly with register and label");
                    }
                }
                "b" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                    } else {
                        panic!("b not invoked correctly");
                    }
                }
                "bl" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        self.set_register(
                            &Operand::Register(RePrefix::X, 30),
                            RegisterKind::Immediate,
                            None,
                            pc as i64,
                        );
                        return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                    } else {
                        panic!("b not invoked correctly");
                    }
                }
                "b.ne" | "bne" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.zero {
                            // if zero is set to false, then cmp -> not equal and we branch
                            Some(flag) => match flag {
                                FlagValue::Real(b) => {
                                    if !b {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(s) => {
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone().not(), label.clone()));
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("bne not invoked correctly with label");
                }
                "b.eq" | "beq" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match &self.zero {
                            // if zero is set to false, then cmp -> not equal and we branch
                            Some(flag) => match flag {
                                FlagValue::Real(b) => {
                                    if *b {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                    } else {
                                        return Ok(ExecuteReturnType::Next);
                                    }
                                }
                                FlagValue::Abstract(s) => {
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(s.clone(), label.clone()));
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("beq not invoked correctly with label");
                }
                "bgt" | "bt" | "b.gt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => {
                                match  (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                                   if !z && n == v {  // Z = 0 AND N = V
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()))
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                (FlagValue::Abstract(z) , _, _ ) =>  {
                                    let expression = generate_comparison(">", *z.left.clone(), *z.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                                },
                                (_,_,_) => todo!("match on undefined flags!")
                                }
                            },
                            (_, _, _) => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("b.gt not invoked correctly with label");
                }
                "b.lt" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg, &self.overflow) {
                            (Some(zero), Some(neg), Some(ove)) => {
                                match  (zero, neg, ove) {
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(v)) => {
                                   if !z && n != v {  // Z = 0 AND N = V
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()))
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                (FlagValue::Abstract(z) , _, _ ) =>  {
                                    let expression = generate_comparison("<", *z.left.clone(), *z.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel( expression, label.clone()));
                                },
                                (_,_,_) => todo!("match on undefined flags!")
                                }
                            },
                            (_, _, _) => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                }
                "b.ls" | "b.le" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.carry) {
                        (Some(zero), Some(carry)) => {
                            match  (zero, carry) {
                            (FlagValue::Real(z), FlagValue::Real(c)) => {
                               if !z && *c {
                                    return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            (FlagValue::Abstract(z) , _ ) | (_, FlagValue::Abstract(z) ) =>  {
                                let expression = generate_comparison("<=", *z.left.clone(), *z.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                            },
                            }
                        },
                        (_, _) => return Err(
                            "Flag cannot be branched on since it has not been set within the program yet"
                                .to_string(),
                        ),
                    }
                    }
                    panic!("b.ls not invoked correctly with label");
                }
                "b.cs" | "b.hs" | "bcs" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match&self.carry{
                            Some(carry) => {
                                match  carry {
                                FlagValue::Real(c) => {
                                   if *c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                FlagValue::Abstract(c) =>  {
                                    let expression = generate_comparison("<", *c.left.clone(), *c.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                                },
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("b.cs not invoked correctly");
                }
                "b.cc" | "b.lo" | "blo" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match&self.carry{
                            Some(carry) => {
                                match  carry {
                                FlagValue::Real(c) => {
                                   if !*c {
                                        return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                                   } else {
                                        return Ok(ExecuteReturnType::Next)
                                   }
                                },
                                FlagValue::Abstract(c) =>  {
                                    let expression = generate_comparison(">=", *c.left.clone(), *c.right.clone());
                                    return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                                },
                                }
                            },
                            None => return Err(
                                "Flag cannot be branched on since it has not been set within the program yet"
                                    .to_string(),
                            ),
                        }
                    }
                    panic!("b.cc/lo/blo not invoked correctly");
                }
                "cset" => {
                    // match on condition based on flags
                    let mut reg_iter = instruction.operands.iter();

                    let register = register_to_tuple(reg_iter.next().expect("cset register"));
                    let Operand::Label(cond) = reg_iter.next().expect("cset condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "cs" => match self.carry.clone().expect("Need carry flag set cset cs") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    self.set_register_from_tuple(
                                        register,
                                        RegisterKind::Immediate,
                                        None,
                                        1,
                                    );
                                } else {
                                    self.set_register_from_tuple(
                                        register,
                                        RegisterKind::Immediate,
                                        None,
                                        0,
                                    );
                                }
                            }
                            FlagValue::Abstract(_) => {
                                log::error!("Can't support this yet :)");
                                todo!("Abstract Flag Expression3");
                            }
                        },
                        "cc" | "lo" => {
                            match self.carry.clone().expect("Need carry flag set cset cc") {
                                FlagValue::Real(b) => {
                                    if b == false {
                                        self.set_register_from_tuple(
                                            register,
                                            RegisterKind::Immediate,
                                            None,
                                            1,
                                        );
                                    } else {
                                        self.set_register_from_tuple(
                                            register,
                                            RegisterKind::Immediate,
                                            None,
                                            0,
                                        );
                                    }
                                }
                                FlagValue::Abstract(_) => {
                                    log::error!("Can't support this yet :)");
                                    todo!("Abstract Flag Expression3");
                                }
                            }
                        }
                        a => todo!("unimplemented condition code for set {}", a),
                    }
                }
                "csel" => {
                    // match on condition based on flags
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let opt1 = self.get_register(reg_iter.next().expect("csel register"));
                    let opt2 = self.get_register(reg_iter.next().expect("csel register"));
                    let Operand::Label(cond) = reg_iter.next().expect("csel condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "cc" | "lo" => {
                            match self.carry.clone().expect("Need carry flag set csel cc") {
                                FlagValue::Real(b) => {
                                    if b == true {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                FlagValue::Abstract(a) => {
                                    return Ok(ExecuteReturnType::Select(
                                        a,
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                            }
                        }
                        "cs" => match self.carry.clone() {
                            Some(FlagValue::Real(b)) => {
                                if b == false {
                                    self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                } else {
                                    self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                }
                            }
                            Some(FlagValue::Abstract(a)) => {
                                return Ok(ExecuteReturnType::Select(
                                    a.not(),
                                    dest.clone(),
                                    opt1,
                                    opt2,
                                ));
                            }
                            None => {
                                return Ok(ExecuteReturnType::Select(
                                    AbstractComparison::new(
                                        "==",
                                        AbstractExpression::Abstract("c_flag".to_string()),
                                        AbstractExpression::Immediate(1),
                                    ),
                                    dest.clone(),
                                    opt1,
                                    opt2,
                                ));
                            }
                        },
                        "eq" => {
                            match self.zero.clone().expect("Need zero flag set") {
                                FlagValue::Real(z) => {
                                    if z == true {
                                        self.set_register(dest, opt1.kind, opt1.base, opt1.offset);
                                    } else {
                                        self.set_register(dest, opt2.kind, opt2.base, opt2.offset);
                                    }
                                }
                                FlagValue::Abstract(z) => {
                                    return Ok(ExecuteReturnType::Select(
                                        z,
                                        dest.clone(),
                                        opt1,
                                        opt2,
                                    ));
                                }
                            };
                        }
                        a => todo!("csel with condition code not yet implemented {}", a),
                    }
                }
                "csetm" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest = reg_iter.next().expect("cset register");
                    let Operand::Label(cond) = reg_iter.next().expect("cset condition code") else {
                        panic!("not a valid condition code")
                    };

                    match cond.as_str() {
                        "eq" => match self.zero.clone().expect("Need zero flag set") {
                            FlagValue::Real(b) => {
                                if b == true {
                                    self.set_register(&dest, RegisterKind::Immediate, None, 1);
                                } else {
                                    self.set_register(&dest, RegisterKind::Immediate, None, 0);
                                }
                            }
                            FlagValue::Abstract(a) => {
                                let opt1 = RegisterValue {
                                    kind: RegisterKind::Immediate,
                                    base: None,
                                    offset: 1,
                                };
                                let opt2 = RegisterValue {
                                    kind: RegisterKind::Immediate,
                                    base: None,
                                    offset: 1,
                                };

                                return Ok(ExecuteReturnType::Select(a, dest.clone(), opt1, opt2));
                            }
                        },
                        _ => todo!("unsupported condition code for csetm {:?}", cond),
                    }
                }
                a => todo!("arithmetic instruction not yet implemented {:?}", a),
            },
            InstructionType::Memory => match instruction.opcode.as_str() {
                "ldr" | "ldrb" => {
                    // TODO: split, have to rewrite load or do post-processing after load to extract meaningful byte
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res = self.load(dst.clone(), address.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0),
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "ldp" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst1 = reg_iter.next().expect("ldr dst");
                    let dst2 = reg_iter.next().expect("ldr src");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res1 = self.load(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.load(dst2.clone(), address.clone());
                            match res1 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                            match res2 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "str" | "strb" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("ldr dst");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res = self.store(dst.clone(), address.clone());
                            match res {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0),
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                "stp" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst1 = reg_iter.next().expect("ldr dst");
                    let dst2 = reg_iter.next().expect("ldr src");
                    let src_addr = reg_iter.next().expect("ldr src");

                    match src_addr {
                        Operand::Memory(w, reg_num, offset, _, mode) => {
                            let mut address = self
                                .get_register(&Operand::Register(w.clone(), *reg_num))
                                .clone();
                            address.offset = address.offset + offset.unwrap_or(0);

                            let res1 = self.store(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.store(dst2.clone(), address.clone());
                            match res1 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                            match res2 {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        src_addr,
                                        address.kind,
                                        address.base,
                                        address.offset,
                                    );
                                }
                                None => {}
                            }
                        }
                        _ => {
                            panic!("ldr not with correct syntax for memory operand");
                        }
                    }
                }
                _ => todo!(),
            },
            InstructionType::SIMDArithmetic => match instruction.opcode.as_str() {
                "rev64" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dest_op = reg_iter.next().expect("rev64 dst");
                    let dest = &mut self.get_simd_register(dest_op);
                    let src = self.get_simd_register(reg_iter.next().expect("rev64 src"));

                    match dest_op {
                        Operand::Vector(_, _, arr) => match arr {
                            Arrangement::H8 => {
                                for i in 0..8 {
                                    let (base, offset) = src.get_halfword(7 - i);
                                    dest.set_halfword(i, base, offset);
                                }
                            }
                            Arrangement::B16 => {
                                for i in 0..16 {
                                    let (base, offset) = src.get_byte(15 - i);
                                    dest.set_byte(i, base, offset);
                                }
                            }
                            _ => todo!("rev64 support more arrangement modes"),
                        },
                        Operand::VectorRegister(_, _) => {
                            // Rav1d syntax
                            dest.kind = src.kind.clone();
                            for i in 0..16 {
                                let (base, offset) = src.get_byte(15 - i);
                                dest.set_byte(i, base, offset);
                            }
                        }
                        a => todo!("unsupported operand in simd rev64 {:?}", a),
                    }
                }
                "and" => {
                    self.vector_arithmetic(
                        "&",
                        &|x, y| x & y,
                        &|x, y| x & y,
                        &|x, y| x & y,
                        &|x, y| x & y,
                        instruction,
                    );
                }
                "add" => {
                    self.vector_arithmetic(
                        "+",
                        &|x, y| x + y,
                        &|x, y| x + y,
                        &|x, y| x + y,
                        &|x, y| x + y,
                        instruction,
                    );
                }
                "orr" => {
                    self.vector_arithmetic(
                        "|",
                        &|x, y| x | y,
                        &|x, y| x | y,
                        &|x, y| x | y,
                        &|x, y| x | y,
                        instruction,
                    );
                }
                "eor" => {
                    self.vector_arithmetic(
                        "^",
                        &|x, y| x ^ y,
                        &|x, y| x ^ y,
                        &|x, y| x ^ y,
                        &|x, y| x ^ y,
                        instruction,
                    );
                }
                "mul" => {
                    self.vector_arithmetic(
                        "*",
                        &|x, y| x * y,
                        &|x, y| x * y,
                        &|x, y| x * y,
                        &|x, y| x * y,
                        instruction,
                    );
                }
                "sub" => {
                    self.vector_arithmetic(
                        "-",
                        &|x, y| x - y,
                        &|x, y| x - y,
                        &|x, y| x - y,
                        &|x, y| x - y,
                        instruction,
                    );
                }
                "movi" | "mov" | "fmov" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    let src =
                        self.get_simd_register(reg_iter.next().expect("Need source register"));

                    self.set_simd_register(dst, src);
                }
                "shl" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    let mut dst_reg = self.get_simd_register(dst);
                    let src_name = reg_iter.next().expect("need src register shl");
                    let src_reg = self.get_simd_register(src_name);

                    let Operand::Vector(_, _, arr) = src_name else {
                        panic!("need appropriate vector notation for shl")
                    };
                    let Operand::Immediate(shift) = reg_iter.next().expect("Need shift amount")
                    else {
                        panic!("cannot call shl without a shift amount")
                    };
                    let small_shift = u32::try_from(*shift).expect("shift shoudl fit into u32");

                    match arr {
                        Arrangement::D2 => {
                            for i in 0..2 {
                                let (bases, offsets) = src_reg.get_double(i);
                                let mut offset = u64::from_be_bytes(offsets);
                                (offset, _) = offset.overflowing_shl(small_shift);
                                dst_reg.set_double(i, bases, offset.to_be_bytes());
                            }
                        }
                        _ => todo!("unsupported shl vector type"),
                    }

                    self.set_simd_register(dst, dst_reg);
                }
                // "ushr" | "sshr" => {
                //     // FIX figure out how to do sshr over byte strings
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need source register");
                //     let reg3 = instruction.r3.clone().expect("Need immediate");
                //     let imm = self.operand(reg3);

                //     if let Some((_, arrange)) = reg1.split_once(".") {
                //         match arrange {
                //             "2d" => {
                //                 for i in 0..2 {
                //                     let (bases, offsets) = self.simd_registers
                //                         [get_register_index(reg2.clone())]
                //                     .get_double(i);
                //                     let mut offset = u64::from_be_bytes(offsets);
                //                     (offset, _) = offset.overflowing_shr(
                //                         imm.offset.try_into().expect("computer22"),
                //                     );
                //                     // TODO: figure out best way to modify bases
                //                     let dest =
                //                         &mut self.simd_registers[get_register_index(reg1.clone())];
                //                     dest.set_double(i, bases, offset.to_be_bytes());
                //                 }
                //             }
                //             "4s" => {
                //                 for i in 0..4 {
                //                     let (bases, offsets) = self.simd_registers
                //                         [get_register_index(reg2.clone())]
                //                     .get_word(i);
                //                     let mut offset = u32::from_be_bytes(offsets);
                //                     (offset, _) = offset.overflowing_shr(
                //                         imm.offset.try_into().expect("computer23"),
                //                     );
                //                     // TODO: figure out best way to modify bases
                //                     let dest =
                //                         &mut self.simd_registers[get_register_index(reg1.clone())];
                //                     dest.set_word(i, bases, offset.to_be_bytes());
                //                 }
                //             }
                //             _ => todo!("unsupported ushr vector type"),
                //         }
                //     }
                // }
                // "ext" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need source register");
                //     let reg3 = instruction.r3.clone().expect("Need immediate");
                //     let reg4 = instruction.r4.clone().expect("Need immediate");
                //     let imm = self.operand(reg4);

                //     if let Some((_, arrange)) = reg1.split_once(".") {
                //         match arrange {
                //             "8b" => {
                //                 let amt = imm.offset as usize;
                //                 assert!(amt < 8);
                //                 for i in 0..amt {
                //                     let (base, offset) = self.simd_registers
                //                         [get_register_index(reg2.clone())]
                //                     .get_byte(i);
                //                     let dest =
                //                         &mut self.simd_registers[get_register_index(reg1.clone())];
                //                     dest.set_byte(i, base.clone(), offset);
                //                 }
                //                 for i in amt..8 {
                //                     let (base, offset) = self.simd_registers
                //                         [get_register_index(reg3.clone())]
                //                     .get_byte(i);
                //                     let dest =
                //                         &mut self.simd_registers[get_register_index(reg1.clone())];
                //                     dest.set_byte(i, base.clone(), offset);
                //                 }
                //             }
                //             "16b" => {
                //                 let amt = imm.offset as usize;
                //                 assert!(amt < 16);
                //                 for i in 0..amt {
                //                     let (base, offset) = self.simd_registers
                //                         [get_register_index(reg2.clone())]
                //                     .get_byte(i);
                //                     let dest =
                //                         &mut self.simd_registers[get_register_index(reg1.clone())];
                //                     dest.set_byte(i, base.clone(), offset);
                //                 }
                //                 for i in amt..16 {
                //                     let (base, offset) = self.simd_registers
                //                         [get_register_index(reg3.clone())]
                //                     .get_byte(i);
                //                     let dest =
                //                         &mut self.simd_registers[get_register_index(reg1.clone())];
                //                     dest.set_byte(i, base.clone(), offset);
                //                 }
                //             }
                //             _ => todo!("unsupported ext vector type"),
                //         }
                //     }
                // }
                // "dup" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let mut reg2 = instruction.r2.clone().expect("Need source register");
                //     if reg2.contains("[") {
                //         let left_brac = reg2.find("[").expect("need left bracket");
                //         let right_brac = reg2.find("]").expect("need right bracket");
                //         let index_string = reg2
                //             .get((left_brac + 1)..right_brac)
                //             .expect("need brackets");
                //         let index = index_string
                //             .parse::<usize>()
                //             .expect("index into vector must be an integer");

                //         reg2 = reg2.split_at(left_brac).0.to_string();
                //         if let Some((vector1, arrangement1)) = reg1.split_once(".") {
                //             if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //                 assert!(arrangement1.contains(arrangement2));
                //                 let src = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "b" => {
                //                         let elem = src.get_byte(index);
                //                         for i in 0..16 {
                //                             dest.set_byte(i, elem.0.clone(), elem.1);
                //                         }
                //                     }
                //                     "h" => {
                //                         let elem = src.get_halfword(index);
                //                         for i in 0..8 {
                //                             dest.set_halfword(i, elem.0.clone(), elem.1);
                //                         }
                //                     }
                //                     "s" => {
                //                         let elem = src.get_word(index);
                //                         for i in 0..4 {
                //                             dest.set_word(i, elem.0.clone(), elem.1);
                //                         }
                //                     }
                //                     "d" => {
                //                         let elem = src.get_double(index);
                //                         for i in 0..2 {
                //                             dest.set_double(i, elem.0.clone(), elem.1);
                //                         }
                //                     }
                //                     _ => log::error!(
                //                         "Not a valid vector arrangement {:?}",
                //                         arrangement1
                //                     ),
                //                 }
                //             }
                //         };
                //     } else {
                //         if let Some((vector1, arrangement1)) = reg1.split_once(".") {
                //             let dest =
                //                 &mut self.simd_registers[get_register_index(vector1.to_string())];
                //             let src = &mut self.registers[get_register_index(reg2)];

                //             dest.set_register(
                //                 arrangement1.to_string(),
                //                 src.kind.clone(),
                //                 src.base.clone(),
                //                 src.offset as u128,
                //             );
                //         };
                //     }
                // }
                // "rev32" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need source register");

                //     let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
                //     let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

                //     dest.kind = src.kind.clone();
                //     for i in 0..8 {
                //         let (base, offset) = src.get_byte(7 - i);
                //         dest.set_byte(i, base, offset);
                //     }

                //     for i in 8..16 {
                //         let (base, offset) = src.get_byte(15 - i);
                //         dest.set_byte(i, base, offset);
                //     }
                // }
                // "ins" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let mut reg2 = instruction.r2.clone().expect("Need source register");

                //     // vector, element
                //     if reg2.contains("v") {
                //         let left_brac = reg2.find("[").expect("need left bracket");
                //         let right_brac = reg2.find("]").expect("need right bracket");
                //         let index_string = reg2
                //             .get((left_brac + 1)..right_brac)
                //             .expect("need brackets");
                //         let index = index_string
                //             .parse::<usize>()
                //             .expect("index into vector must be an integer");

                //         reg2 = reg2.split_at(left_brac).0.to_string();
                //         if let Some((vector1, arrangement1)) = reg1.split_once(".") {
                //             if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //                 assert!(arrangement1.contains(arrangement2));
                //                 let src = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "b" => {
                //                         let (base, offset) = src.get_byte(index);
                //                         dest.set_byte(index, base, offset);
                //                     }
                //                     "h" => {
                //                         let (base, offset) = src.get_halfword(index);
                //                         dest.set_halfword(index, base, offset);
                //                     }
                //                     "s" => {
                //                         let (base, offset) = src.get_word(index);
                //                         dest.set_word(index, base, offset);
                //                     }
                //                     "d" => {
                //                         let (base, offset) = src.get_double(index);
                //                         dest.set_double(index, base, offset);
                //                     }
                //                     _ => log::error!(
                //                         "Not a valid vector arrangement {:?}",
                //                         arrangement1
                //                     ),
                //                 }
                //             }
                //         }
                //     // vector, general
                //     } else {
                //         todo!("vector general ins unsupported");
                //     }
                // }
                // "pmull" | "pmull2" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need first source register");
                //     let reg3 = instruction.r3.clone().expect("Need second source register");

                //     if let Some((vector1, _)) = reg1.split_once(".") {
                //         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //             if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                //                 assert_eq!(arrangement2, arrangement3);

                //                 let src1 = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let src2 = self.simd_registers
                //                     [get_register_index(vector3.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "8b" => {
                //                         for i in 0..8 {
                //                             let base = generate_expression_from_options(
                //                                 "*",
                //                                 src1.get_byte(i).0,
                //                                 src2.get_byte(i).0,
                //                             );
                //                             let offset = src1.get_byte(i).1 * src2.get_byte(i).1;

                //                             dest.set_byte(i, base, offset);
                //                         }
                //                     }
                //                     "4h" => {
                //                         for i in 0..8 {
                //                             let (bases1, offsets1) = self.simd_registers
                //                                 [get_register_index(reg2.clone())]
                //                             .get_halfword(i);

                //                             let (bases2, offsets2) = self.simd_registers
                //                                 [get_register_index(reg3.clone())]
                //                             .get_halfword(i);
                //                             let a = u16::from_be_bytes(offsets1);
                //                             let b = u16::from_be_bytes(offsets2);
                //                             let offset = a * b;

                //                             let mut new_bases = [BASE_INIT; 2];
                //                             for i in 0..2 {
                //                                 new_bases[i] = generate_expression_from_options(
                //                                     "*",
                //                                     bases1[i].clone(),
                //                                     bases2[i].clone(),
                //                                 );
                //                             }

                //                             let dest = &mut self.simd_registers
                //                                 [get_register_index(reg1.clone())];
                //                             dest.set_halfword(i, new_bases, offset.to_be_bytes());
                //                         }
                //                     }
                //                     _ => todo!("pmull unsupported vector access"),
                //                 }
                //             }
                //         }
                //     }
                // }
                // "zip1" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need first source register");
                //     let reg3 = instruction.r3.clone().expect("Need second source register");

                //     if let Some((vector1, _)) = reg1.split_once(".") {
                //         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //             if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                //                 assert_eq!(arrangement2, arrangement3);

                //                 let src1 = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let src2 = self.simd_registers
                //                     [get_register_index(vector3.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "2d" => {
                //                         let elem = src1.get_double(0);
                //                         dest.set_double(0, elem.0, elem.1);

                //                         let elem = src2.get_double(0);
                //                         dest.set_double(1, elem.0, elem.1);
                //                     }
                //                     "16b" => {
                //                         for i in 0..16 {
                //                             if i % 2 == 0 {
                //                                 let elem = src1.get_byte(0);
                //                                 dest.set_byte(i, elem.0, elem.1);
                //                             } else {
                //                                 let elem = src2.get_byte(0);
                //                                 dest.set_byte(i, elem.0, elem.1);
                //                             }
                //                         }
                //                     }
                //                     _ => todo!("zip1 unsupported vector access"),
                //                 }
                //             }
                //         }
                //     }
                // }
                // "zip2" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need first source register");
                //     let reg3 = instruction.r3.clone().expect("Need second source register");

                //     if let Some((vector1, _)) = reg1.split_once(".") {
                //         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //             if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                //                 assert_eq!(arrangement2, arrangement3);

                //                 let src1 = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let src2 = self.simd_registers
                //                     [get_register_index(vector3.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "2d" => {
                //                         let elem = src1.get_double(1);
                //                         dest.set_double(0, elem.0, elem.1);

                //                         let elem = src2.get_double(1);
                //                         dest.set_double(1, elem.0, elem.1);
                //                     }
                //                     "16b" => {
                //                         //FIX
                //                         for i in 0..16 {
                //                             if i % 2 == 1 {
                //                                 let elem = src1.get_byte(0);
                //                                 dest.set_byte(i, elem.0, elem.1);
                //                             } else {
                //                                 let elem = src2.get_byte(0);
                //                                 dest.set_byte(i, elem.0, elem.1);
                //                             }
                //                         }
                //                     }
                //                     _ => todo!("zip2 unsupported vector access"),
                //                 }
                //             }
                //         }
                //     }
                // }
                // "aese" | "aesmc" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need first source register");

                //     let src = &self.simd_registers[get_register_index(reg2.clone())].clone();
                //     let dest = &mut self.simd_registers[get_register_index(reg1.clone())];

                //     match (src.kind.clone(), dest.kind.clone()) {
                //         (RegisterKind::Number, RegisterKind::Number) => {
                //             // don't need to do anything
                //             ()
                //         }
                //         _ => todo!(),
                //     }
                // }
                // "trn1" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need first source register");
                //     let reg3 = instruction.r3.clone().expect("Need second source register");

                //     if let Some((vector1, _)) = reg1.split_once(".") {
                //         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //             if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                //                 assert_eq!(arrangement2, arrangement3);

                //                 let src1 = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let src2 = self.simd_registers
                //                     [get_register_index(vector3.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "2d" => {
                //                         let elem = src1.get_double(0);
                //                         dest.set_double(0, elem.0, elem.1);

                //                         let elem = src2.get_double(0);
                //                         dest.set_double(1, elem.0, elem.1);
                //                     }
                //                     _ => todo!("trn1 unsupported vector access"),
                //                 }
                //             }
                //         }
                //     }
                // }
                // "trn2" => {
                //     let reg1 = instruction.r1.clone().expect("Need dst register");
                //     let reg2 = instruction.r2.clone().expect("Need first source register");
                //     let reg3 = instruction.r3.clone().expect("Need second source register");

                //     if let Some((vector1, _)) = reg1.split_once(".") {
                //         if let Some((vector2, arrangement2)) = reg2.split_once(".") {
                //             if let Some((vector3, arrangement3)) = reg3.split_once(".") {
                //                 assert_eq!(arrangement2, arrangement3);

                //                 let src1 = self.simd_registers
                //                     [get_register_index(vector2.to_string())]
                //                 .clone();
                //                 let src2 = self.simd_registers
                //                     [get_register_index(vector3.to_string())]
                //                 .clone();
                //                 let dest = &mut self.simd_registers
                //                     [get_register_index(vector1.to_string())];

                //                 match arrangement2 {
                //                     "2d" => {
                //                         let elem = src1.get_double(1);
                //                         dest.set_double(0, elem.0, elem.1);

                //                         let elem = src2.get_double(1);
                //                         dest.set_double(1, elem.0, elem.1);
                //                     }
                //                     _ => todo!("trn2 unsupported vector access"),
                //                 }
                //             }
                //         }
                //     }
                // }
                // "bit" | "uaddl" | "uaddl2" | "sqrshrun" | "sqrshrun2" | "umull" | "umull2"
                // | "umlal" | "umlal2" | "rshrn" | "rshrn2" => {
                // let dest = instruction.r1.clone().expect("need dest");
                // let reg = &mut self.simd_registers[get_register_index(dest.to_string())];
                // reg.set(
                //     "16b".to_string(),
                //     RegisterKind::Number,
                //     [BASE_INIT; 16],
                //     [0; 16],
                // );
                // },
                a => todo!("simd arithmetic instruction not supported yet {:?}", a),
            },
            InstructionType::SIMDManagement => match instruction.opcode.as_str() {
                "ld1r" => {
                    // ld1r {v1.16b}, [x5]
                    // load value from register and replicate it across all channels
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    let addr = self.get_register(reg_iter.next().expect("need src register ld1r"));

                    match self.load_vector(dst.clone(), addr) {
                        Err(e) => return Err(e.to_string()),
                        _ => (),
                    }
                    // let new_value = self.get_register(dst);
                }
                "ld1" => {
                    // multiple versions:
                    // ld1	{v24.2d,v25.2d,v26.2d,v27.2d}, [x10]
                    // ld1 {v0.16b}, [x2], #16
                    let mut destinations = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) => destinations.push(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction ld1"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, Some(offset), _, index)) = addr {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        for d in destinations {
                            match self.load_vector(d.clone(), a.clone()) {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                        }

                        if *index == Some(true) {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                a.base,
                                a.offset + offset,
                            );
                        }
                    } else {
                        panic!("ld1 does not include address")
                    };
                }
                "st1" => {
                    // multiple versions:
                    // st1  {v30.8h, v31.8h}, [x0], #32
                    // st1	{v3.4s},[x2],#16
                    let mut sources = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) => sources.push(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction ld1"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, Some(offset), _, index)) = addr {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        for d in sources {
                            match self.store_vector(d.clone(), a.clone()) {
                                Err(e) => return Err(e.to_string()),
                                _ => (),
                            }
                        }

                        if *index == Some(true) {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                a.base,
                                a.offset + offset,
                            );
                        }
                    } else {
                        panic!("ld1 does not include address")
                    };
                }
                a => todo!("simd instruction {} not supported yet", a),
            },
            InstructionType::Other => match instruction.opcode.as_str() {
                "cmp" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                }
                "cmn" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                }
                "ret" => {
                    let x30 = self.get_register(&Operand::Register(RePrefix::X, 30));
                    if x30.kind == RegisterKind::RegisterBase {
                        if let Some(AbstractExpression::Abstract(address)) = x30.base {
                            if address == "return" && x30.offset == 0 {
                                return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
                            } else {
                                return Ok(ExecuteReturnType::JumpLabel(address.to_string()));
                            }
                        }
                        return Ok(ExecuteReturnType::JumpAddress(
                            x30.offset.try_into().expect("computer4"),
                        ));
                    } else {
                        panic!("return register not set before calling ret")
                    }
                }
                a => todo!("other instruction not implemented yet {:?}", a),
            },
            _ => panic!(),
        }

        Ok(ExecuteReturnType::Next)
    }
}
