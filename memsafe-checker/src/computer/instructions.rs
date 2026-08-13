use crate::computer::*;

impl ARMCORTEXA {
    pub fn execute(
        &mut self,
        pc: usize,
        instruction: &Instruction,
    ) -> Result<ExecuteReturnType, String> {
        match instruction.ty {
            InstructionType::Arithmetic => match instruction.opcode.as_str() {
                "add" => {
                    self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                }
                "sub" => {
                    self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                }
                "mul" | "umulh" => {
                    self.arithmetic("*", |x, y| x * y, instruction.operands.clone());
                }
                "and" => {
                    self.arithmetic("&", |x, y| x & y, instruction.operands.clone());
                }
                "orr" => {
                    self.arithmetic("|", |x, y| x | y, instruction.operands.clone());
                }
                "orn" => {
                    self.arithmetic("!|", |x, y: i64| x | !y, instruction.operands.clone());
                }
                "eor" => {
                    // potential TODO: deal with case where registers are the same but not imm
                    self.arithmetic("^", |x, y| x ^ y, instruction.operands.clone());
                }
                "bic" => {
                    self.arithmetic("!&", |x, y: i64| x & !y, instruction.operands.clone());
                }
                "adds" => {
                    self.cmn(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                }
                "subs" => {
                    self.cmp(&instruction.operands[0], &instruction.operands[1]);
                    self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
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
                    self.arithmetic("&", |x, y| x & y, instruction.operands.clone());
                }
                "adc" => {
                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b {
                                self.arithmetic(
                                    "+",
                                    |x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                            } else {
                                self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                            }
                        }
                        _ => todo!("adcs carry is not real not supported yet"),
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
                            if *b {
                                self.arithmetic(
                                    "+",
                                    |x, y| x + y + 1,
                                    instruction.operands.clone(),
                                );
                                self.cmn(reg1, reg2);
                            } else {
                                self.arithmetic("+", |x, y| x + y, instruction.operands.clone());
                                self.cmn(reg1, reg2);
                            }
                        }
                        _ => todo!("adcs carry not real 2"),
                    }
                }
                "sbc" => match &self.carry {
                    Some(FlagValue::Real(b)) => {
                        if *b {
                            self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                        } else {
                            self.arithmetic("+", |x, y| x - y - 1, instruction.operands.clone());
                        }
                    }
                    _ => todo!("sbc todo"),
                },
                "sbcs" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let _ = reg_iter.next().expect("Need destination register");
                    let reg1 = reg_iter.next().expect("Need first choice register");
                    let reg2 = reg_iter.next().expect("Need second choice source register");

                    match &self.carry {
                        Some(FlagValue::Real(b)) => {
                            if *b {
                                self.arithmetic("-", |x, y| x - y, instruction.operands.clone());
                                self.cmp(reg1, reg2);
                            } else {
                                self.arithmetic(
                                    "-",
                                    |x, y| x - y - 1,
                                    instruction.operands.clone(),
                                );
                                self.cmp(reg1, reg2);
                            }
                        }
                        _ => todo!("sbcs todo"),
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
                _ => todo!("Unsupported arithmetic instruction: {:?}", instruction),
            },
            InstructionType::ControlFlow => match instruction.opcode.as_str() {
                // from sha256: add	x9, x9, _BORINGSSL_function_hit@PAGEOFF
                "add" => (), // FIX
                "adr" => {
                    if let Operand::Address(label, _) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index,
                        );
                    } else if let Operand::Label(label) = &instruction.operands[1] {
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
                "adrp" | "ldr" => {
                    // Form PC-relative address to 4KB page adds an immediate value that is shifted left by 12 bits, to the PC value to form a PC-relative address, with the bottom 12 bits masked out, and writes the result to the destination register.
                    // TODO: handle case for sha256 where we need @OFF page address
                    if let Operand::Address(label, _) = &instruction.operands[1] {
                        let (region, index) = self.label_to_memory_index(label.clone());
                        self.set_register(
                            &instruction.operands[0],
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(region)),
                            index << 12,
                        );
                    } else {
                        panic!("adrp not invoked correctly with register and label")
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
                        // Return to the instruction after this call, not the call site itself
                        // (otherwise `ret` would jump back here and re-execute the call forever).
                        self.set_register(
                            &Operand::Register(RePrefix::X, 30),
                            RegisterKind::Immediate,
                            None,
                            (pc + 1) as i64,
                        );
                        return Ok(ExecuteReturnType::JumpLabel(label.to_string()));
                    } else {
                        panic!("bl not invoked correctly");
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
                                // neg holds the signed comparison, not the raw N bit, so V stays out.
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(_)) => {
                                   if !z && !n {
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
                                // neg holds the signed comparison, not the raw N bit, so V stays out.
                                (FlagValue::Real(z), FlagValue::Real(n), FlagValue::Real(_)) => {
                                   if !z && *n {
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
                "b.ls" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.carry) {
                        (Some(zero), Some(carry)) => {
                            match  (zero, carry) {
                            // b.ls is unsigned: Z == 1 or C == 0.
                            (FlagValue::Real(z), FlagValue::Real(c)) => {
                               if *z || !c {
                                    return Ok(ExecuteReturnType::JumpLabel(label.clone()));
                               } else {
                                    return Ok(ExecuteReturnType::Next)
                               }
                            },
                            // Carry keeps the operands themselves, so prefer it over the difference.
                            (_, FlagValue::Abstract(c)) => {
                                let expression = generate_comparison("<=", *c.left.clone(), *c.right.clone());
                                return Ok(ExecuteReturnType::ConditionalJumpLabel(expression, label.clone()));
                            },
                            (FlagValue::Abstract(z), _) => {
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
                "b.le" => {
                    if let Operand::Label(label) = &instruction.operands[0] {
                        match (&self.zero, &self.neg) {
                        (Some(zero), Some(neg)) => {
                            match  (zero, neg) {
                            // neg holds the signed comparison, so b.le is Z == 1 or N == 1.
                            (FlagValue::Real(z), FlagValue::Real(n)) => {
                               if *z || *n {
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
                    panic!("b.le not invoked correctly with label");
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
                                if b {
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
                                    if !b {
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
                                    if b {
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
                                if !b {
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
                                    if z {
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
                                if b {
                                    self.set_register(dest, RegisterKind::Immediate, None, 1);
                                } else {
                                    self.set_register(dest, RegisterKind::Immediate, None, 0);
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
                // BIG TODO: reimplement these
                "tst" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    self.set_register(dst, RegisterKind::Number, None, 0);
                }
                "mov" | "movz" | "movk" => {
                    let mut reg_iter = instruction.operands.iter().clone();
                    let reg0 = reg_iter.next().expect("Need register output for mov");
                    let reg1 = reg_iter.next().expect("Need register output for mov");

                    let r1 = self.get_register(reg1);

                    self.set_register(reg0, r1.kind, r1.base, r1.offset);
                }
                _ => todo!(
                    "control flow instruction not yet implemented {:?}",
                    instruction
                ),
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
                            address.offset += offset.unwrap_or(0);

                            let res = self.load(dst.clone(), address.clone());
                            if let Err(e) = res {
                                return Err(e.to_string());
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0),
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
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
                            address.offset += offset.unwrap_or(0);

                            let res1 = self.load(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.load(dst2.clone(), address.clone());
                            if let Err(e) = res1 {
                                return Err(e.to_string());
                            }
                            if let Err(e) = res2 {
                                return Err(e.to_string());
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
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
                            address.offset += offset.unwrap_or(0);

                            let res = self.store(dst.clone(), address.clone());
                            if let Err(e) = res {
                                return Err(e.to_string());
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0),
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
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
                            address.offset += offset.unwrap_or(0);

                            let res1 = self.store(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.store(dst2.clone(), address.clone());
                            if let Err(e) = res1 {
                                return Err(e.to_string());
                            }
                            if let Err(e) = res2 {
                                return Err(e.to_string());
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
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
                _ => todo!("memory instruction not supported yet {:?}", instruction),
            },
            InstructionType::SIMDArithmetic => match instruction.opcode.as_str() {
                "rev64" | "rev64.16b" | "rev64.8h" => {
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
                            let arr = instruction.opcode.split(".").collect::<Vec<&str>>()[1];
                            match arr {
                                "16b" => {
                                    dest.kind = src.kind.clone();
                                    for i in 0..16 {
                                        let (base, offset) = src.get_byte(15 - i);
                                        dest.set_byte(i, base, offset);
                                    }
                                }
                                "8h" => {
                                    for i in 0..8 {
                                        let (base, offset) = src.get_halfword(7 - i);
                                        dest.set_halfword(i, base, offset);
                                    }
                                }
                                _ => todo!("support arr in rav1d for rev64"),
                            }
                        }
                        a => todo!("unsupported operand in simd rev64 {:?}", a),
                    }
                }
                "and" => {
                    self.vector_arithmetic(
                        "&",
                        |x, y| x & y,
                        |x, y| x & y,
                        |x, y| x & y,
                        |x, y| x & y,
                        instruction,
                    );
                }
                "add" => {
                    self.vector_arithmetic(
                        "+",
                        |x, y| x + y,
                        |x, y| x + y,
                        |x, y| x + y,
                        |x, y| x + y,
                        instruction,
                    );
                }
                "orr" => {
                    self.vector_arithmetic(
                        "|",
                        |x, y| x | y,
                        |x, y| x | y,
                        |x, y| x | y,
                        |x, y| x | y,
                        instruction,
                    );
                }
                "eor" => {
                    self.vector_arithmetic(
                        "^",
                        |x, y| x ^ y,
                        |x, y| x ^ y,
                        |x, y| x ^ y,
                        |x, y| x ^ y,
                        instruction,
                    );
                }
                "mul" => {
                    self.vector_arithmetic(
                        "*",
                        |x, y| x * y,
                        |x, y| x * y,
                        |x, y| x * y,
                        |x, y| x * y,
                        instruction,
                    );
                }
                "sub" => {
                    self.vector_arithmetic(
                        "-",
                        |x, y| x - y,
                        |x, y| x - y,
                        |x, y| x - y,
                        |x, y| x - y,
                        instruction,
                    );
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
                "aese" | "aesmc" | "movi" | "ext" | "ushr" | "dup" | "sshr" | "pmull"
                | "pmull2" | "zip1" | "zip2" | "trn1" | "trn2" | "bit" | "uaddl" | "uaddl2"
                | "sqrshrun" | "sqrshrun2" | "umull" | "umull2" | "umlal" | "umlal2" | "rshrn"
                | "rshrn2" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    self.set_register(dst, RegisterKind::Number, None, 0);
                }
                a => todo!("simd arithmetic instruction not supported yet {:?}", a),
            },
            InstructionType::SIMDManagement => match instruction.opcode.as_str() {
                "ld1r" => {
                    // ld1r {v1.16b}, [x5]
                    // load value from register and replicate it across all channels
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    if let Some(Operand::Memory(prefix, num, _, _, _)) = reg_iter.next() {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));

                        if let Err(e) = self.load_vector(dst.clone(), a) {
                            return Err(e.to_string());
                        }
                    }
                    // let new_value = self.get_register(dst);
                }
                // FIX: extract arrangement from opcode
                "ld1" | "ld1.16b" | "ld1.8h" => {
                    // multiple versions:
                    // ld1	{v24.2d,v25.2d,v26.2d,v27.2d}, [x10]
                    // ld1 {v0.16b}, [x2], #16
                    let mut destinations = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) => destinations.push(o),
                            Operand::VectorRegister(..) => addr = Some(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction ld1"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, offset, _, index)) = addr {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        for d in destinations {
                            if let Err(e) = self.load_vector(d.clone(), a.clone()) {
                                return Err(e.to_string());
                            }
                        }

                        if *index == Some(true)
                            && let Some(off) = offset
                        {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                a.base,
                                a.offset + off,
                            );
                        }
                    } else {
                        panic!("ld1 does not include address {:?}", instruction)
                    };
                }
                "st1" | "st1.d" => {
                    // multiple versions:
                    // st1  {v30.8h, v31.8h}, [x0], #32
                    // st1	{v3.4s},[x2],#16
                    let mut sources = Vec::new();
                    let mut addr = None;
                    for o in instruction.operands.iter() {
                        match o {
                            Operand::Vector(..) => sources.push(o),
                            Operand::VectorAccess(..) => addr = Some(o),
                            Operand::Memory(..) => addr = Some(o),
                            _ => panic!("not a valid operand for instruction st1"),
                        }
                    }

                    if let Some(Operand::Memory(prefix, num, num_offset, reg_offset, indexing)) =
                        addr
                    {
                        let a = self.get_register(&Operand::Register(prefix.clone(), *num));
                        for d in sources.clone() {
                            if let Err(e) = self.store_vector(d.clone(), a.clone()) {
                                return Err(e.to_string());
                            }
                        }

                        if *indexing == Some(true)
                            && let Some(i) = num_offset
                        {
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind.clone(),
                                a.base.clone(),
                                a.offset + i,
                            );
                        };

                        if let Some(reg) = reg_offset {
                            let reg = self.get_register(reg);
                            self.set_register(
                                &Operand::Register(prefix.clone(), *num),
                                a.kind,
                                a.base,
                                a.offset + reg.offset,
                            );
                        };
                    } else {
                        panic!("str1 does not include address {:?}", instruction);
                    };
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
                            address.offset += offset.unwrap_or(0);

                            let res1 = self.store_vector(dst1.clone(), address.clone());
                            address.offset += 8;
                            let res2 = self.store_vector(dst2.clone(), address.clone());
                            if let Err(e) = res1 {
                                return Err(e.to_string());
                            }
                            if let Err(e) = res2 {
                                return Err(e.to_string());
                            }

                            match mode {
                                // pre
                                Some(false) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
                                        address.kind,
                                        address.base,
                                        address.offset - offset.unwrap_or(0) - 8,
                                    );
                                }
                                // post
                                Some(true) => {
                                    self.set_register(
                                        &Operand::Register(w.clone(), *reg_num),
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
                // BIG TODO: reimplement these
                "movi" | "mov" | "fmov" | "aese" | "dup" | "ins" => {
                    let mut reg_iter = instruction.operands.iter();

                    let dst = reg_iter.next().expect("Need destination register");
                    self.set_register(dst, RegisterKind::Number, None, 0);
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
                    match x30.kind {
                        RegisterKind::RegisterBase => {
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
                        }
                        RegisterKind::Immediate => {
                            // x30 holds a concrete return pc pushed by a `bl`; resume there.
                            return Ok(ExecuteReturnType::JumpAddress(
                                x30.offset
                                    .try_into()
                                    .expect("ret: return address must be non-negative"),
                            ));
                        }
                        RegisterKind::Number => {
                            // x30 was never set (or was clobbered by unrelated arithmetic):
                            // treat this as the outermost return.
                            return Ok(ExecuteReturnType::JumpLabel("return".to_string()));
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
                _ => todo!("other instruction not implemented yet {:?}", instruction),
            },
            _ => panic!(),
        }

        Ok(ExecuteReturnType::Next)
    }
}
