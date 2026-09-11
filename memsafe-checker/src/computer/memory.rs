use crate::computer::*;

fn format_address(base: &AbstractExpression, offset: i64) -> String {
    if offset < 0 {
        format!("{base} - {}", -offset)
    } else {
        format!("{base} + {offset}")
    }
}

impl ARMCORTEXA {
    pub fn load(
        &mut self,
        t: Operand,
        address: RegisterValue,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            address.base.clone().expect("Need a name for region"),
            address.offset,
            RegionType::READ,
            width,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                let (region_name, offset) = self.get_memory_pointer(base.clone(), address.offset);
                let region = self
                    .memory
                    .get(&region_name)
                    .unwrap_or_else(|| panic!("Need memory region to load from {:?}", region_name));
                match region.get(offset) {
                    Some(v) => {
                        self.set_register(&t, v.kind.clone(), v.base.clone(), v.offset);
                        self.rw_queue.push(MemoryAccess {
                            kind: RegionType::READ,
                            base: AbstractExpression::Abstract(base.clone()),
                            offset: address.offset,
                        });
                        log::info!(
                            "Load from address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        Ok(())
                    }
                    None => Err(MemorySafetyError::new(&format!(
                        "read of never-written memory at {}",
                        format_address(&AbstractExpression::Abstract(base), address.offset)
                    ))),
                }
            } else {
                log::info!(
                    "Loading from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::READ,
                    base: address.base.expect("Need base"),
                    offset: address.offset,
                });
                self.set_register(&t, RegisterKind::Number, None, 0);
                Ok(())
            }
        } else {
            res
        }
    }

    pub fn load_vector(
        &mut self,
        t: Operand,
        address: RegisterValue,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            address.base.clone().expect("Need a name for region"),
            address.offset,
            RegionType::READ,
            width,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                let (region_name, offset) = self.get_memory_pointer(base.clone(), address.offset);
                let region = self
                    .memory
                    .get(&region_name)
                    .unwrap_or_else(|| panic!("Need memory region to load from {:?}", region_name));
                match region.get(offset) {
                    Some(v) => {
                        self.set_register(&t, v.kind.clone(), v.base, v.offset);
                        self.rw_queue.push(MemoryAccess {
                            kind: RegionType::READ,
                            base: AbstractExpression::Abstract(base.clone()),
                            offset: address.offset,
                        });
                        log::info!(
                            "Load from address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        Ok(())
                    }
                    None => Err(MemorySafetyError::new(&format!(
                        "read of never-written memory at {}",
                        format_address(&AbstractExpression::Abstract(base), address.offset)
                    ))),
                }
            } else {
                log::info!(
                    "Loading from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::READ,
                    base: address.base.expect("Need base"),
                    offset: address.offset,
                });
                self.set_register(&t, RegisterKind::Number, None, 0);
                Ok(())
            }
        } else {
            res
        }
    }

    pub fn store(
        &mut self,
        register: Operand,
        address: RegisterValue,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let region = address.base.clone();
        let res = self.mem_safe_access(
            region.clone().expect("Need region base"),
            address.offset,
            RegionType::WRITE,
            width,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let register = &self.get_register(&register);
                let region = self
                    .memory
                    .get_mut(&region)
                    .expect("region named by get_memory_pointer");
                region.insert(offset, register.clone());

                log::info!(
                    "Store to address {:?} + {}",
                    base.clone(),
                    address.offset.clone()
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: AbstractExpression::Abstract(base),
                    offset: address.offset,
                });
                Ok(())
            } else {
                log::info!(
                    "Storing from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: address.base.expect("Need base"),
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            res
        }
    }

    pub fn store_vector(
        &mut self,
        register: Operand,
        address: RegisterValue,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let region = address.base.clone();
        let res = self.mem_safe_access(
            region.clone().expect("Need region base"),
            address.offset,
            RegionType::WRITE,
            width,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let register = self.get_register(&register);
                let region = self
                    .memory
                    .get_mut(&region)
                    .expect("region named by get_memory_pointer");
                region.insert(offset, register.clone());

                log::info!(
                    "Store to address {:?} + {}",
                    base.clone(),
                    address.offset.clone()
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: AbstractExpression::Abstract(base),
                    offset: address.offset,
                });
                Ok(())
            } else {
                log::info!(
                    "Storing from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: address.base.expect("Need base"),
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            res
        }
    }

    fn get_memory_pointer(&self, base: String, offset: i64) -> (String, i64) {
        if self.memory.contains_key(&base) {
            (base, offset)
        } else if let Some(address) = self.memory_labels.get(&base) {
            ("memory".to_string(), address + offset)
        } else {
            ("memory".to_string(), offset)
        }
    }

    fn mem_safe_access(
        &self,
        base_expr: AbstractExpression,
        mut offset: i64,
        ty: RegionType,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let (region, base, base_access) = match base_expr.clone() {
            AbstractExpression::Abstract(regbase) => {
                if let Some(region) = self.memory.get(&regbase.clone()) {
                    (
                        region,
                        ast::Int::new_const(regbase.clone()),
                        ast::Int::new_const(regbase),
                    )
                } else if let Some(address) = self.memory_labels.get(&regbase.clone()) {
                    offset += address;
                    (
                        self.memory
                            .get("memory")
                            .expect("labelled data lives in the memory region"),
                        ast::Int::new_const(regbase.clone()),
                        ast::Int::new_const(regbase),
                    )
                } else {
                    return Err(MemorySafetyError::new(&format!(
                        "{ty} of {width} bytes at {} has no declared region for base {regbase}",
                        format_address(&base_expr, offset)
                    )));
                }
            }
            _ => {
                let abstracts = base_expr.get_abstracts();
                let mut result: Option<(&MemorySafeRegion, z3::ast::Int, z3::ast::Int)> = None;
                for r in self.memory.keys() {
                    if abstracts.contains(r) {
                        result = Some((
                            self.memory.get(r).expect("region named by its own key"),
                            expression_to_ast(AbstractExpression::Abstract(r.to_string()))
                                .expect("an abstract always translates"),
                            expression_to_ast(base_expr.clone()).unwrap_or_else(|| {
                                panic!("no translation for access base {base_expr}")
                            }),
                        ));
                        break;
                    }
                    for r in self.memory_labels.clone() {
                        if abstracts.contains(&r.0)
                            && let Some(address) = self.memory_labels.get(&r.0.clone())
                        {
                            offset = *address;
                            result = Some((
                                self.memory
                                    .get("memory")
                                    .expect("labelled data lives in the memory region"),
                                expression_to_ast(AbstractExpression::Abstract(r.0.to_string()))
                                    .expect("an abstract always translates"),
                                expression_to_ast(base_expr.clone()).unwrap_or_else(|| {
                                    panic!("no translation for access base {base_expr}")
                                }),
                            ));
                            break;
                        }
                    }
                }
                if let Some(res) = result {
                    res
                } else {
                    return Err(MemorySafetyError::new(&format!(
                        "no region declared for {ty} at {}",
                        format_address(&base_expr, offset)
                    )));
                }
            }
        };

        if ty == RegionType::WRITE && region.kind == RegionType::READ {
            return Err(MemorySafetyError::new(&format!(
                "write at {base_expr} targets a {} region",
                region.kind
            )));
        }

        let mut abs_offset = ast::Int::from_i64(offset);
        if base_expr.contains("sp") {
            abs_offset = ast::Int::from_i64(offset.abs());
        }
        let access = ast::Int::add(&[&base_access, &abs_offset]);
        let last_byte = ast::Int::add(&[&access, &ast::Int::from_i64(width - 1)]);

        let lowerbound_value = ast::Int::from_i64(0);
        let low_access = ast::Int::add(&[&base, &lowerbound_value]);
        let upperbound_value = expression_to_ast(region.get_length())
            .unwrap_or_else(|| panic!("no translation for region length {}", region.get_length()));
        let up_access = ast::Int::add(&[&base, &upperbound_value]);
        let l = access.lt(&low_access);
        let u = last_byte.ge(&up_access);

        match (
            self.solver.check_assumptions(std::slice::from_ref(&l)),
            self.solver.check_assumptions(std::slice::from_ref(&u)),
        ) {
            (SatResult::Unsat, SatResult::Unsat) => {
                if self.solver.check() == SatResult::Sat {
                    log::info!(
                        "{ty} at {} proved in bounds",
                        format_address(&base_expr, offset)
                    );
                    return Ok(());
                }
                Err(MemorySafetyError::new(&format!(
                    "{ty} of {width} bytes at {} unprovable: path has no model",
                    format_address(&base_expr, offset)
                )))
            }
            (a, b) => {
                log::info!(
                    "below-region is {a:?} and past-end is {b:?}, model: {:?}",
                    self.solver.get_model()
                );
                Err(MemorySafetyError::new(&format!(
                    "{ty} of {width} bytes at {} not provably within region of length {}",
                    format_address(&base_expr, offset),
                    region.get_length()
                )))
            }
        }
    }
}
