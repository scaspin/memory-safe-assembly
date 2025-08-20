use crate::computer::*;

impl<'ctx> ARMCORTEXA<'_> {
    /*
     * t: register name to load into
     * address: register with address as value
     */
    pub fn load(&mut self, t: Operand, address: RegisterValue) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            address.base.clone().expect("Need a name for region"),
            address.offset,
            RegionType::READ,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                let (region_name, offset) = self.get_memory_pointer(base.clone(), address.offset);
                let region = self
                    .memory
                    .get(&region_name)
                    .expect(format!("Need memory region to load from {:?}", region_name).as_str());
                match region.get(offset) {
                    Some(v) => {
                        self.set_register(&t, v.kind.clone(), v.base.clone(), v.offset);
                        self.rw_queue.push(MemoryAccess {
                            kind: RegionType::READ,
                            base: base.clone(),
                            offset: address.offset,
                        });
                        log::info!(
                            "Load from address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        return Ok(());
                    }
                    None => {
                        log::error!("No element at this address in region {:?}", region);
                        return Err(MemorySafetyError::new(
                            "Cannot read element at this address from region",
                        ));
                    }
                }
            } else {
                log::info!(
                    "Loading from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::READ,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                self.set_register(&t, RegisterKind::Number, None, 0);
                Ok(())
            }
        } else {
            return res;
        }
    }

    pub fn load_vector(
        &mut self,
        t: Operand,
        address: RegisterValue,
    ) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            address.base.clone().expect("Need a name for region"),
            address.offset,
            RegionType::READ,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = address.base {
                let (region_name, offset) = self.get_memory_pointer(base.clone(), address.offset);
                let region = self
                    .memory
                    .get(&region_name)
                    .expect(format!("Need memory region to load from {:?}", region_name).as_str());
                match region.get(offset) {
                    Some(v) => {
                        self.set_register(&t, v.kind.clone(), v.base, v.offset);
                        self.rw_queue.push(MemoryAccess {
                            kind: RegionType::READ,
                            base: base.clone(),
                            offset: address.offset,
                        });
                        log::info!(
                            "Load from address {:?} + {}",
                            base.clone(),
                            address.offset.clone()
                        );
                        return Ok(());
                    }
                    None => {
                        log::error!("No element at this address in region {:?}", region);
                        return Err(MemorySafetyError::new(
                            "Cannot read element at this address from region",
                        ));
                    }
                }
            } else {
                log::info!(
                    "Loading from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::READ,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                self.set_register(&t, RegisterKind::Number, None, 0);
                Ok(())
            }
        } else {
            return res;
        }
    }

    /*
     * t: register to be stored
     * address: where to store it
     */
    pub fn store(
        &mut self,
        register: Operand,
        address: RegisterValue,
    ) -> Result<(), MemorySafetyError> {
        let region = address.base.clone();
        let res = self.mem_safe_access(
            region.clone().expect("Need region base"),
            address.offset,
            RegionType::WRITE,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let register = &self.get_register(&register);
                let region = self.memory.get_mut(&region).expect("No region");
                region.insert(offset.clone(), register.clone());

                log::info!(
                    "Store to address {:?} + {}",
                    base.clone(),
                    address.offset.clone()
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base,
                    offset: address.offset,
                });
                return Ok(());
            } else {
                log::info!(
                    "Storing from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            return res;
        }
    }

    pub fn store_vector(
        &mut self,
        register: Operand,
        address: RegisterValue,
    ) -> Result<(), MemorySafetyError> {
        let region = address.base.clone();
        let res = self.mem_safe_access(
            region.clone().expect("Need region base"),
            address.offset,
            RegionType::WRITE,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let register = self.get_register(&register);
                let region = self.memory.get_mut(&region).expect("No region");
                region.insert(offset.clone(), register.clone());

                log::info!(
                    "Store to address {:?} + {}",
                    base.clone(),
                    address.offset.clone()
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base,
                    offset: address.offset,
                });
                return Ok(());
            } else {
                log::info!(
                    "Storing from an abstract but safe region of memory {:?}",
                    address
                );
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base: address.base.expect("Need base").to_string(),
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            return res;
        }
    }

    fn get_memory_pointer(&self, base: String, offset: i64) -> (String, i64) {
        if let Some(_) = self.memory.get(&base) {
            return (base, offset);
        } else {
            if let Some(address) = self.memory_labels.get(&base) {
                return ("memory".to_string(), address + offset);
            } else {
                return ("memory".to_string(), offset);
            }
        }
    }

    // SAFETY CHECKS
    fn mem_safe_access(
        &self,
        base_expr: AbstractExpression,
        mut offset: i64,
        ty: RegionType,
    ) -> Result<(), MemorySafetyError> {
        let mut symbolic_base = false;
        let (region, base, base_access) = match base_expr.clone() {
            AbstractExpression::Abstract(regbase) => {
                println!("memory : {:?}", self.memory);
                if let Some(region) = self.memory.get(&regbase.clone()) {
                    (
                        region,
                        ast::Int::new_const(self.context, regbase.clone()),
                        ast::Int::new_const(self.context, regbase),
                    )
                } else {
                    if let Some(address) = self.memory_labels.get(&regbase.clone()) {
                        offset = offset + address;
                        (
                            self.memory
                                .get(&"memory".to_string())
                                .expect("memory should exist"),
                            ast::Int::new_const(self.context, regbase.clone()),
                            ast::Int::new_const(self.context, regbase),
                        )
                    } else {
                        todo!("memory regions in access check");
                    }
                }
            }
            _ => {
                symbolic_base = true;
                let abstracts = base_expr.get_abstracts();
                let mut result: Option<(&MemorySafeRegion, z3::ast::Int<'_>, z3::ast::Int<'_>)> =
                    None;
                for r in self.memory.keys() {
                    if abstracts.contains(r) {
                        result = Some((
                            self.memory.get(r).expect("Region not in memory 2"),
                            expression_to_ast(
                                self.context,
                                AbstractExpression::Abstract(r.to_string()),
                            )
                            .expect("computer25"),
                            expression_to_ast(self.context, base_expr.clone())
                                .expect("computer251"),
                        ));
                        break;
                    }
                    for r in self.memory_labels.clone() {
                        if abstracts.contains(&r.0) {
                            if let Some(address) = self.memory_labels.get(&r.0.clone()) {
                                offset = *address;
                                result = Some((
                                    self.memory.get("memory").expect("Region not in memory 2"),
                                    expression_to_ast(
                                        self.context,
                                        AbstractExpression::Abstract(r.0.to_string()),
                                    )
                                    .expect("computer25"),
                                    expression_to_ast(self.context, base_expr.clone())
                                        .expect("computer251"),
                                ));
                                break;
                            }
                        }
                    }
                }
                if let Some(res) = result {
                    res
                } else {
                    return Err(MemorySafetyError::new(
                        format!(
                            "No matching region found for access {:?}, {:?}",
                            base_expr, offset
                        )
                        .as_str(),
                    ));
                }
            }
        };

        if ty == RegionType::WRITE && region.kind == RegionType::READ {
            return Err(MemorySafetyError::new(&format!(
                "Access does not match region type {:#?} {:?} {:?}",
                region.kind, ty, base_expr
            )));
        }

        let mut abs_offset = ast::Int::from_i64(self.context, offset);
        if base_expr.contains("sp") {
            abs_offset = ast::Int::from_i64(self.context, offset.abs());
        }
        let access = ast::Int::add(self.context, &[&base_access, &abs_offset]);

        // let width = ast::Int::from_i64(self.context, 2);    // how wide is memory access, two bytes
        let lowerbound_value = ast::Int::from_i64(self.context, 0);
        let low_access = ast::Int::add(self.context, &[&base, &lowerbound_value]);
        let upperbound_value =
            expression_to_ast(self.context, region.get_length()).expect("computer26");
        let up_access = ast::Int::add(self.context, &[&base, &upperbound_value]);
        let l = access.lt(&low_access);
        let u = {
            if offset == 0 && !symbolic_base {
                access.ge(&up_access)
            } else {
                access.gt(&up_access)
            }
        };

        match (
            self.solver.check_assumptions(&[l.clone()]),
            self.solver.check_assumptions(&[u.clone()]),
        ) {
            (SatResult::Unsat, SatResult::Unsat) => {
                log::info!("Memory safe with solver's check!");
                log::info!("Unsat core {:?}", self.solver.get_unsat_core());
                return Ok(());
            }
            (a, b) => {
                log::info!("Load from address {:?} + {} unsafe", base_expr, offset);
                log::info!(
                    "impossibility lower bound {:?}, impossibility upper bound {:?}, model: {:?}",
                    a,
                    b,
                    self.solver.get_model()
                );
                log::info!("Memory unsafe with solver's check!");
            }
        }
        return Err(MemorySafetyError::new(
            format!(
                "Accessing address outside allowable memory regions {:?}, {:?}",
                base_expr, offset
            )
            .as_str(),
        ));
    }
}
