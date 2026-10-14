use crate::computer::*;

fn address_base(address: &RegisterValue) -> Result<AbstractExpression, MemorySafetyError> {
    address.base.clone().ok_or_else(|| {
        MemorySafetyError::new(
            "Cannot prove access safe: address is an unknown value, \
             derived from an instruction the engine does not model",
        )
    })
}

fn untranslatable(base: &AbstractExpression, ty: RegionType, width: i64) -> MemorySafetyError {
    MemorySafetyError::new(&format!(
        "{ty} of {width} bytes at {base} uses an operation the engine does not model"
    ))
}

fn content_symbol(region: &str, offset: i64, width: i64, epoch: usize) -> RegisterValue {
    let name = if epoch == 0 {
        format!("{region}[{offset}:{width}]")
    } else {
        format!("{region}[{offset}:{width}]#{epoch}")
    };
    RegisterValue {
        kind: RegisterKind::RegisterBase,
        base: Some(AbstractExpression::Abstract(name)),
        offset: 0,
    }
}

fn format_address(base: &AbstractExpression, offset: i64) -> String {
    if offset < 0 {
        format!("{base} - {}", -offset)
    } else {
        format!("{base} + {offset}")
    }
}

fn region_base(
    address: &RegisterValue,
    ty: RegionType,
    width: i64,
) -> Result<AbstractExpression, MemorySafetyError> {
    address.base.clone().ok_or_else(|| {
        MemorySafetyError::new(&format!(
            "{ty} of {width} bytes through an address with no known region ({})",
            address.offset
        ))
    })
}

impl ARMCORTEXA {
    pub fn load(
        &mut self,
        t: Operand,
        address: RegisterValue,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let res = self.mem_safe_access(
            region_base(&address, RegionType::READ, width)?,
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
                let value = match region.read(offset, width) {
                    Some(v) => {
                        self.note_element_read(&region_name, offset);
                        Some(v)
                    }
                    None if region.overwritten(offset, width) => {
                        Some(RegisterValue::new(RegisterKind::Number, None, 0))
                    }
                    None => Some(content_symbol(&region_name, offset, width, region.epoch)),
                };
                match value {
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
            region_base(&address, RegionType::READ, width)?,
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
            region_base(&address, RegionType::WRITE, width)?,
            address.offset,
            RegionType::WRITE,
            width,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let register = self.get_register(&register);
                self.store_cell(&MemoryCell { region, offset }, register, width);

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
                let base = address.base.expect("Need base");
                self.forget_where_written(&base, address.offset, width);
                if self
                    .region_of(&base)
                    .is_some_and(|(region, _, _)| region == "sp")
                {
                    self.blind_stack_writes
                        .push((base.clone(), address.offset, width));
                }
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base,
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
            region_base(&address, RegionType::WRITE, width)?,
            address.offset,
            RegionType::WRITE,
            width,
        );

        if res.is_ok() {
            if let Some(AbstractExpression::Abstract(base)) = region.clone() {
                let (region, offset) = self.get_memory_pointer(base.clone(), address.offset);

                let register = self.get_register(&register);
                self.store_cell(&MemoryCell { region, offset }, register, width);

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
                let base = address.base.expect("Need base");
                self.forget_where_written(&base, address.offset, width);
                if self
                    .region_of(&base)
                    .is_some_and(|(region, _, _)| region == "sp")
                {
                    self.blind_stack_writes
                        .push((base.clone(), address.offset, width));
                }
                self.rw_queue.push(MemoryAccess {
                    kind: RegionType::WRITE,
                    base,
                    offset: address.offset,
                });
                Ok(())
            }
        } else {
            res
        }
    }

    fn region_of(&self, base: &AbstractExpression) -> Option<(String, String, i64)> {
        let abstracts = base.get_abstracts();
        if let Some(region) = abstracts.iter().find(|a| self.memory.contains_key(*a)) {
            return Some((region.clone(), region.clone(), 0));
        }
        abstracts.into_iter().find_map(|label| {
            let address = *self.memory_labels.get(&label)?;
            Some(("memory".to_string(), label, address))
        })
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

    pub(crate) fn finite_values(&self, symbol: &str, cap: usize) -> Option<Vec<i64>> {
        let var = ast::Int::new_const(symbol.to_string());
        let mut found: Vec<i64> = Vec::new();
        loop {
            let excluded: Vec<ast::Bool> = found
                .iter()
                .map(|v| var.eq(ast::Int::from_i64(*v)).not())
                .collect();
            match self.solver.check_assumptions(&excluded) {
                SatResult::Unsat => return Some(found),
                SatResult::Unknown => return None,
                SatResult::Sat => {
                    let value = self.solver.get_model()?.eval(&var, true)?.as_i64()?;
                    if found.contains(&value) || found.len() >= cap {
                        return None;
                    }
                    found.push(value);
                }
            }
        }
    }

    pub(crate) fn model_symbols(&self) -> Vec<String> {
        if self.solver.check() != SatResult::Sat {
            return Vec::new();
        }
        let Some(model) = self.solver.get_model() else {
            return Vec::new();
        };
        model.iter().map(|decl| decl.name()).collect()
    }

    fn safe_for_every_stride(&self, l: &ast::Bool, u: &ast::Bool, symbols: &[String]) -> bool {
        for symbol in symbols {
            let Some(values) = self.finite_values(symbol, 8) else {
                continue;
            };
            if values.is_empty() {
                continue;
            }
            let var = ast::Int::new_const(symbol.to_string());
            let settled = values.iter().all(|v| {
                let pin = var.eq(ast::Int::from_i64(*v));
                self.solver.check_assumptions(&[pin.clone(), l.clone()]) == SatResult::Unsat
                    && self.solver.check_assumptions(&[pin, u.clone()]) == SatResult::Unsat
            });
            if settled {
                log::info!("bounds settled by splitting {symbol} over {values:?}");
                return true;
            }
        }
        false
    }

    fn aligned_offset(&self, e: &AbstractExpression) -> Option<(String, i64)> {
        match e {
            AbstractExpression::Abstract(name) if self.memory.contains_key(name) => {
                Some((name.clone(), 0))
            }
            AbstractExpression::Expression(op, left, right) => {
                let (name, base) = self.aligned_offset(left)?;
                let AbstractExpression::Immediate(k) = **right else {
                    return None;
                };
                match op.as_str() {
                    "+" => Some((name, base + k)),
                    "&" => {
                        let align = self.memory.get(&name)?.alignment();
                        let clears_only_low_bits = k | (align - 1) == -1;
                        (align > 1 && clears_only_low_bits && (0..align).contains(&base))
                            .then_some((name, base & k))
                    }
                    _ => None,
                }
            }
            _ => None,
        }
    }

    fn aligned_parts(&self, e: &AbstractExpression) -> Option<(String, AbstractExpression)> {
        match e {
            AbstractExpression::Abstract(name) if self.memory.contains_key(name) => {
                Some((name.clone(), AbstractExpression::Immediate(0)))
            }
            AbstractExpression::Expression(op, left, right) if op == "+" => {
                let joined = |offset, term| match offset {
                    AbstractExpression::Immediate(0) => term,
                    offset => generate_expression("+", offset, term),
                };
                if let Some((name, offset)) = self.aligned_parts(left) {
                    return Some((name, joined(offset, (**right).clone())));
                }
                let (name, offset) = self.aligned_parts(right)?;
                Some((name, joined(offset, (**left).clone())))
            }
            AbstractExpression::Expression(op, left, right) => {
                let (name, offset) = self.aligned_parts(left)?;
                let AbstractExpression::Immediate(k) = **right else {
                    return None;
                };
                let align = self.memory.get(&name)?.alignment();
                let keeps_base = match op.as_str() {
                    "&" => align > 1 && k | (align - 1) == -1,
                    "^" => align > 1 && (0..align).contains(&k),
                    _ => false,
                };
                keeps_base.then(|| {
                    (
                        name,
                        generate_expression(op, offset, AbstractExpression::Immediate(k)),
                    )
                })
            }
            _ => None,
        }
    }

    pub fn select_assumptions(&self, e: &AbstractExpression) -> Vec<ast::Bool> {
        let mut seen = std::collections::HashSet::new();
        let mut pending = e.get_abstracts();
        let mut assumptions = Vec::new();
        while let Some(name) = pending.pop() {
            if !seen.insert(name.clone()) {
                continue;
            }
            if let Some(bounding) = self.symbols_bounding_counter.get(&name) {
                pending.extend(bounding.iter().cloned());
            }
            let Some((condition, taken, skipped)) = self.select_definitions.get(&name) else {
                continue;
            };
            pending.extend(taken.get_abstracts());
            pending.extend(skipped.get_abstracts());
            if !is_translatable(taken) || !is_translatable(skipped) {
                continue;
            }
            if let (Some(condition), Some(taken), Some(skipped)) = (
                comparison_to_ast(condition.clone()),
                expression_to_ast(taken.clone()),
                expression_to_ast(skipped.clone()),
            ) {
                let chosen = ast::Int::new_const(name);
                assumptions.push(ast::Bool::or(&[&condition.not(), &chosen.eq(taken)]));
                assumptions.push(ast::Bool::or(&[&condition, &chosen.eq(skipped)]));
            }
        }
        assumptions
    }

    fn mem_safe_access(
        &self,
        base_expr: AbstractExpression,
        mut offset: i64,
        ty: RegionType,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let base_expr = match self.aligned_offset(&base_expr) {
            Some((name, folded)) => {
                offset += folded;
                AbstractExpression::Abstract(name)
            }
            None => match self.aligned_parts(&base_expr) {
                Some((name, within)) => {
                    generate_expression("+", AbstractExpression::Abstract(name), within)
                }
                None => base_expr,
            },
        };
        let Some((region_name, symbol, label_offset)) = self.region_of(&base_expr) else {
            return Err(MemorySafetyError::new(&format!(
                "no region declared for {ty} at {}",
                format_address(&base_expr, offset)
            )));
        };
        offset += label_offset;
        let region = &self.memory[&region_name];
        let base = ast::Int::new_const(symbol);
        let base_access = expression_to_ast(base_expr.clone())
            .ok_or_else(|| untranslatable(&base_expr, ty, width))?;

        if ty == RegionType::WRITE && region.kind == RegionType::READ {
            return Err(MemorySafetyError::new(&format!(
                "write at {base_expr} targets a {} region",
                region.kind
            )));
        }

        let (l, u, extent) = if region_name == "sp" {
            let Some((low, high)) = self.stack_bounds() else {
                return Err(MemorySafetyError::new(&format!(
                    "{ty} of {width} bytes at {} has no frame to measure: \
                     the stack pointer is not the entry value plus a known amount",
                    format_address(&base_expr, offset)
                )));
            };
            let displacement = ast::Int::add(&[
                &ast::Int::sub(&[&base_access, &base]),
                &ast::Int::from_i64(offset),
            ]);
            let last_byte = ast::Int::add(&[&displacement, &ast::Int::from_i64(width - 1)]);
            (
                displacement.lt(ast::Int::from_i64(low)),
                last_byte.ge(ast::Int::from_i64(high)),
                format!("stack frame [{low}, {high})"),
            )
        } else {
            let upperbound_value = expression_to_ast(region.get_length()).unwrap_or_else(|| {
                panic!("no translation for region length {}", region.get_length())
            });
            let access = ast::Int::add(&[&base_access, &ast::Int::from_i64(offset)]);
            let last_byte = ast::Int::add(&[&access, &ast::Int::from_i64(width - 1)]);
            let up_access = ast::Int::add(&[&base, &upperbound_value]);
            (
                access.lt(&base),
                last_byte.ge(&up_access),
                format!("region of length {}", region.get_length()),
            )
        };

        let selects = self.select_assumptions(&base_expr);
        let with = |extra: &ast::Bool| {
            let mut all = selects.clone();
            all.push(extra.clone());
            all
        };

        match (
            self.solver.check_assumptions(&with(&l)),
            self.solver.check_assumptions(&with(&u)),
        ) {
            (SatResult::Unsat, SatResult::Unsat) => {
                if self.solver.check_assumptions(&selects) == SatResult::Unsat {
                    return Err(MemorySafetyError::new(&format!(
                        "{ty} of {width} bytes at {} unprovable: path has no model",
                        format_address(&base_expr, offset)
                    )));
                }
                log::info!(
                    "{ty} at {} proved in bounds",
                    format_address(&base_expr, offset)
                );
                Ok(())
            }
            (a, b) => {
                if a == SatResult::Unknown || b == SatResult::Unknown {
                    let mut symbols = base_expr.get_abstracts();
                    symbols.append(&mut region.get_length().get_abstracts());
                    symbols.append(&mut self.model_symbols());
                    symbols.sort();
                    symbols.dedup();
                    if self.safe_for_every_stride(&l, &u, &symbols) {
                        log::info!(
                            "{ty} at {} proved in bounds",
                            format_address(&base_expr, offset)
                        );
                        return Ok(());
                    }
                }
                log::info!(
                    "below-region is {a:?} and past-end is {b:?}, model: {:?}",
                    self.solver.get_model()
                );
                Err(MemorySafetyError::new(&format!(
                    "{ty} of {width} bytes at {} not provably within {extent}",
                    format_address(&base_expr, offset),
                )))
            }
        }
    }

    pub fn mem_safe_vector_access(
        &self,
        address: &RegisterValue,
        width: i64,
        ty: RegionType,
    ) -> Result<(), MemorySafetyError> {
        self.mem_safe_access(address_base(address)?, address.offset, ty, width)
    }
}
