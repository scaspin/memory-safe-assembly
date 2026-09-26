use crate::computer::*;

pub(crate) enum TableLoad {
    NotATable,
    Concrete(RegisterValue),
    Split(Vec<AbstractComparison>),
}

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
                        self.mark_loaded(&t);
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
                self.mark_loaded(&t);
                Ok(())
            }
        } else {
            res
        }
    }

    fn mark_loaded(&mut self, register: &Operand) {
        if let Operand::Register(RePrefix::X | RePrefix::W, n) = register {
            self.loaded[*n] = true;
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
            let (section, address) = self.memory_labels.get(&label)?.clone();
            Some((section, label, address))
        })
    }

    fn get_memory_pointer(&self, base: String, offset: i64) -> (String, i64) {
        match self.memory_labels.get(&base) {
            Some((section, address)) if !self.memory.contains_key(&base) => {
                (section.clone(), address + offset)
            }
            _ => (base, offset),
        }
    }

    fn data_symbol_at(&self, section: &str, offset: i64) -> Option<(String, String, i64)> {
        self.memory_labels
            .iter()
            .filter(|(_, (placed_in, start))| placed_in == section && *start <= offset)
            .max_by_key(|(name, (_, start))| (*start, *name))
            .map(|(name, (_, start))| (name.clone(), section.to_string(), *start))
    }

    pub(crate) fn table_load(&self, address: &RegisterValue, width: i64) -> TableLoad {
        const MAX_ENTRIES: i64 = 64;
        const MAX_CASES: usize = 16;
        let Some(base) = &address.base else {
            return TableLoad::NotATable;
        };
        if matches!(base, AbstractExpression::Abstract(_)) {
            return TableLoad::NotATable;
        }
        let Some((symbol, section, start)) = base
            .get_abstracts()
            .into_iter()
            .find_map(|section| self.data_symbol_at(&section, address.offset))
        else {
            return TableLoad::NotATable;
        };
        let Some(region) = self.memory.get(&section) else {
            return TableLoad::NotATable;
        };
        let AbstractExpression::Immediate(section_length) = region.get_length() else {
            return TableLoad::NotATable;
        };
        if region.content.is_empty() {
            return TableLoad::NotATable;
        }
        let length = self
            .data_symbol_sizes
            .get(&symbol)
            .copied()
            .unwrap_or(section_length - start);
        if width <= 0
            || length / width > MAX_ENTRIES
            || self
                .mem_safe_access(base.clone(), address.offset, RegionType::READ, width)
                .is_err()
        {
            return TableLoad::NotATable;
        }

        let index = generate_expression(
            "+",
            generate_expression(
                "-",
                base.clone(),
                AbstractExpression::Abstract(section.clone()),
            ),
            AbstractExpression::Immediate(address.offset - start),
        );
        let Some(index_ast) = expression_to_ast(index.clone()) else {
            return TableLoad::NotATable;
        };
        let misaligned = index_ast
            .modulo(ast::Int::from_i64(width))
            .eq(ast::Int::from_i64(0))
            .not();
        let outside = ast::Bool::or(&[
            &index_ast.lt(ast::Int::from_i64(0)),
            &index_ast.gt(ast::Int::from_i64(length - width)),
        ]);
        if self.solver.check_assumptions(&[misaligned]) != SatResult::Unsat
            || self.solver.check_assumptions(&[outside]) != SatResult::Unsat
        {
            return TableLoad::NotATable;
        }
        let mut entries = Vec::new();
        for entry in (0..=length - width).step_by(width as usize) {
            let pinned = index_ast.eq(ast::Int::from_i64(entry));
            if self.solver.check_assumptions(&[pinned]) == SatResult::Sat {
                if entries.len() == MAX_CASES {
                    return TableLoad::NotATable;
                }
                entries.push(entry);
            }
        }
        match entries.as_slice() {
            [] => TableLoad::NotATable,
            [entry] => TableLoad::Concrete(RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract(section)),
                start + entry,
            )),
            _ => TableLoad::Split(
                entries
                    .iter()
                    .map(|entry| {
                        AbstractComparison::new(
                            "==",
                            index.clone(),
                            AbstractExpression::Immediate(*entry),
                        )
                    })
                    .collect(),
            ),
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

    fn fits_a_word(&self, e: &AbstractExpression) -> bool {
        fn worth_asking(e: &AbstractExpression, budget: &mut i32) -> bool {
            *budget -= 1;
            if *budget < 0 {
                return false;
            }
            match e {
                AbstractExpression::Immediate(_) | AbstractExpression::Abstract(_) => true,
                AbstractExpression::Register(r) => match &r.base {
                    Some(b) => worth_asking(b, budget),
                    None => true,
                },
                AbstractExpression::Expression(op, a, b) => {
                    matches!(op.as_str(), "+" | "-" | "*")
                        && worth_asking(a, budget)
                        && worth_asking(b, budget)
                }
                _ => false,
            }
        }

        worth_asking(e, &mut 24) && self.fits_in_32(&Some(e.clone()), 0)
    }

    fn without_redundant_narrowing(&self, e: &AbstractExpression) -> AbstractExpression {
        match e {
            AbstractExpression::Expression(op, left, right) => {
                let inner = self.without_redundant_narrowing(left);
                if op == "%"
                    && **right == AbstractExpression::Immediate(1i64 << 32)
                    && self.fits_a_word(&inner)
                {
                    return inner;
                }
                generate_expression(op, inner, self.without_redundant_narrowing(right))
            }
            AbstractExpression::Register(r) => match &r.base {
                Some(base) => AbstractExpression::Register(Box::new(RegisterValue {
                    base: Some(self.without_redundant_narrowing(base)),
                    ..(**r).clone()
                })),
                None => e.clone(),
            },
            other => other.clone(),
        }
    }

    fn mem_safe_access(
        &self,
        base_expr: AbstractExpression,
        mut offset: i64,
        ty: RegionType,
        width: i64,
    ) -> Result<(), MemorySafetyError> {
        let base_expr = self.without_redundant_narrowing(&base_expr);
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

        let (l, u, extent, below_red_zone) = if region_name == "sp" {
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
                (self.red_zone > 0)
                    .then(|| displacement.lt(ast::Int::from_i64(low - self.red_zone))),
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
                None,
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
                if b == SatResult::Unsat
                    && let Some(below) = &below_red_zone
                    && self.solver.check_assumptions(&with(below)) == SatResult::Unsat
                    && self.solver.check_assumptions(&selects) == SatResult::Sat
                {
                    self.note_finding(&format!(
                        "{ty} of {width} bytes at {} is below the stack pointer, in the \
                         {}-byte red zone this analysis was told to allow",
                        format_address(&base_expr, offset),
                        self.red_zone
                    ));
                    return Ok(());
                }
                log::info!(
                    "below-region is {a:?} and past-end is {b:?}, model: {:?}",
                    self.solver.get_model()
                );
                let holding = self
                    .data_symbol_at(&region_name, offset)
                    .map(|(symbol, ..)| format!(" holding {symbol}"))
                    .unwrap_or_default();
                Err(MemorySafetyError::new(&format!(
                    "{ty} of {width} bytes at {} not provably within {extent}{holding}",
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

#[cfg(test)]
mod narrowing_tests {
    use super::*;

    fn narrowed(inner: AbstractExpression) -> AbstractExpression {
        generate_expression("%", inner, AbstractExpression::Immediate(1i64 << 32))
    }

    #[test]
    fn a_narrowing_comes_off_only_where_the_path_bounds_it() {
        let computer = ARMCORTEXA::new();
        for (op, bound) in [(">=", 0), ("<=", 128)] {
            let fact =
                AbstractComparison::new(op, abstract_of("h"), AbstractExpression::Immediate(bound));
            computer
                .solver
                .assert(comparison_to_ast(fact).expect("a literal bound translates"));
        }
        assert_eq!(
            computer.without_redundant_narrowing(&narrowed(abstract_of("h"))),
            abstract_of("h")
        );
        let product = generate_expression("*", abstract_of("stride"), narrowed(abstract_of("h")));
        assert_eq!(
            computer.without_redundant_narrowing(&product).to_string(),
            "stride * h"
        );
        assert_eq!(
            computer.without_redundant_narrowing(&narrowed(narrowed(abstract_of("h")))),
            abstract_of("h")
        );
        let counter = narrowed(abstract_of("loop0_?"));
        assert_eq!(computer.without_redundant_narrowing(&counter), counter);
        let moving = narrowed(generate_expression(
            "-",
            abstract_of("h"),
            abstract_of("loop0_?"),
        ));
        assert_eq!(computer.without_redundant_narrowing(&moving), moving);
    }

    #[test]
    fn a_narrowing_round_is_not_spent_on_a_term_that_cannot_be_bounded() {
        let computer = ARMCORTEXA::new();
        assert!(!computer.fits_a_word(&abstract_of("base[0:4]")));
        assert!(!computer.fits_a_word(&generate_expression(
            "lsr",
            abstract_of("h"),
            AbstractExpression::Immediate(4)
        )));
        assert!(!computer.fits_a_word(&abstract_of("h")));
    }
}
