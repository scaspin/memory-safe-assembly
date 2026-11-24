use crate::x86::computer::*;

impl X86_64 {
    pub fn effective_address(&self, m: &MemoryOperand) -> Result<RegisterValue, String> {
        if m.segment {
            return Err("segment-relative addressing is not modelled".to_string());
        }
        let mut address = match (&m.base, &m.symbol) {
            (Some(Register::Rip), Some(symbol)) => self.symbol_value(symbol)?,
            (Some(Register::Rip), None) => {
                return Err("rip-relative access without a symbol".to_string());
            }
            (Some(Register::Gpr { index, .. }), _) => self.registers[*index].clone(),
            (None, _) => RegisterValue::new_imm(0),
            (Some(other), _) => return Err(format!("cannot address through {other:?}")),
        };
        if let (Some(symbol), Some(Register::Gpr { .. })) = (&m.symbol, &m.base) {
            let table = self.symbol_value(symbol)?;
            address = add_values(&table, &address);
        } else if let (Some(symbol), None) = (&m.symbol, &m.base) {
            address = self.symbol_value(symbol)?;
        }
        address.offset = address.offset.wrapping_add(m.displacement);

        if let Some(Register::Gpr { index, .. }) = m.index {
            let i = self.registers[index].clone();
            let scaled = match i.kind {
                RegisterKind::Number => unknown(),
                RegisterKind::Immediate => RegisterValue::new_imm(i.offset.wrapping_mul(m.scale)),
                RegisterKind::RegisterBase => {
                    let base = i.base.clone().map(|b| {
                        if m.scale == 1 {
                            b
                        } else {
                            generate_expression("*", b, AbstractExpression::Immediate(m.scale))
                        }
                    });
                    RegisterValue::new(
                        RegisterKind::RegisterBase,
                        base,
                        i.offset.wrapping_mul(m.scale),
                    )
                }
            };
            address = add_values(&address, &scaled);
        } else if let Some(index) = &m.index {
            return Err(format!("addressing indexed by {index:?} is not modelled"));
        }
        Ok(address)
    }

    pub(super) fn symbol_value(&self, symbol: &str) -> Result<RegisterValue, String> {
        let name = symbol.trim_start_matches('_');
        let (base, offset) = if self.memory.contains_key(name) {
            (name.to_string(), 0)
        } else {
            self.symbol_address(symbol)
                .ok_or_else(|| format!("reference to undefined symbol {name}"))?
        };
        Ok(RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(abstract_of(base)),
            offset,
        ))
    }

    pub fn mem_safe_access(
        &self,
        address: &RegisterValue,
        ty: RegionType,
        width: AbstractExpression,
    ) -> Result<String, String> {
        let base_expr = match (&address.kind, &address.base) {
            (RegisterKind::RegisterBase, Some(b)) => b.clone(),
            _ => {
                return Err(format!(
                    "{ty} through a pointer with no known region ({address:?})"
                ));
            }
        };
        let Some((name, symbol, label_offset)) = self.region_of(&base_expr) else {
            return Err(format!("no region declared for {ty} at {base_expr}"));
        };
        let offset = address.offset + label_offset;
        let region = &self.memory[&name];
        let start = ast::Int::new_const(symbol);
        let access = expression_to_ast(base_expr.clone())
            .ok_or_else(|| format!("no translation for access base {base_expr}"))?;

        if ty != RegionType::READ && region.kind == RegionType::READ {
            return Err(format!(
                "write at {} targets a {} region",
                format_address(&base_expr, address.offset),
                region.kind
            ));
        }

        let width_ast = expression_to_ast(width.clone())
            .ok_or_else(|| format!("no translation for access width {width}"))?;
        let first = ast::Int::add(&[&access, &ast::Int::from_i64(offset)]);
        let last = ast::Int::sub(&[
            &ast::Int::add(&[&first, &width_ast]),
            &ast::Int::from_i64(1),
        ]);

        let (low, high) = if name == STACK {
            let stack_pointer = &self.registers[RSP];
            let deepest = (stack_pointer.kind == RegisterKind::RegisterBase)
                .then(|| expression_to_ast(stack_pointer.expression()))
                .flatten()
                .ok_or_else(|| {
                    format!(
                        "{ty} at {} has no frame to measure: the stack pointer is unknown",
                        format_address(&base_expr, address.offset)
                    )
                })?;
            let allocated = deepest.lt(&start).ite(&deepest, &start);
            (
                ast::Int::sub(&[&allocated, &ast::Int::from_i64(SYSV_RED_ZONE)]),
                ast::Int::add(&[&start, &ast::Int::from_i64(self.stack_top)]),
            )
        } else {
            let length = expression_to_ast(region.get_length()).ok_or_else(|| {
                format!("no translation for region length {}", region.get_length())
            })?;
            (start.clone(), ast::Int::add(&[&start, &length]))
        };

        let touches = width_ast.gt(ast::Int::from_i64(0));
        let below = ast::Bool::and(&[&touches, &first.lt(&low)]);
        let past = ast::Bool::and(&[&touches, &last.ge(&high)]);
        let shown = format_address(&base_expr, address.offset);
        let mut selects = self.select_assumptions(&base_expr);
        selects.extend(self.select_assumptions(&width));
        let with = |extra: &ast::Bool| {
            let mut all = selects.clone();
            all.push(extra.clone());
            all
        };
        match (
            check(&self.solver, &with(&below)),
            check(&self.solver, &with(&past)),
        ) {
            (SatResult::Unsat, SatResult::Unsat) => {
                if check(&self.solver, &selects) == SatResult::Sat {
                    log::info!("{ty} at {shown} proved in bounds");
                    Ok(name)
                } else {
                    Err(format!(
                        "{ty} of {width} bytes at {shown} unprovable: path has no model"
                    ))
                }
            }
            (a, b) => {
                log::info!(
                    "below-region is {a:?} and past-end is {b:?}, model: {:?}",
                    self.solver.get_model()
                );
                let extent = if name == STACK {
                    format!("the stack frame (entry rsp + {})", self.stack_top)
                } else {
                    format!("region of length {}", region.get_length())
                };
                Err(format!(
                    "{ty} of {width} bytes at {shown} not provably within {extent}"
                ))
            }
        }
    }

    fn note_access(&mut self, kind: RegionType, address: &RegisterValue) {
        self.rw_queue.push(MemoryAccess {
            kind,
            base: address.base.clone().expect("checked by the access"),
            offset: address.offset,
        });
    }

    pub fn add_pointer_elements(&mut self, region: &str, target: &str) {
        if !self.memory.contains_key(target) {
            panic!("pointer elements need a region {target} to point into");
        }
        self.pointer_elements
            .insert(region.to_string(), target.to_string());
    }

    fn writable_rows(&self, region: &str) -> bool {
        self.memory
            .get(region)
            .is_some_and(|rows| rows.kind != RegionType::READ)
            && self.pointer_elements.values().any(|rows| rows == region)
    }

    fn constant_table_range(
        &self,
        region: &str,
        address: &RegisterValue,
        width: i64,
    ) -> Option<(i64, i64)> {
        const MOST_ENTRIES: i64 = 4096;
        let table = self.memory.get(region)?;
        if table.kind != RegionType::READ || !(1..=4).contains(&width) {
            return None;
        }
        let AbstractExpression::Immediate(length) = table.get_length() else {
            return None;
        };
        let base = address.base.clone()?;
        let (_, symbol, label_offset) = self.region_of(&base)?;
        let within = ast::Int::sub(&[
            &ast::Int::add(&[
                &expression_to_ast(base)?,
                &ast::Int::from_i64(address.offset + label_offset),
            ]),
            &ast::Int::new_const(symbol),
        ]);
        let proves =
            |fact: ast::Bool| self.solver.check_assumptions(&[fact.not()]) == SatResult::Unsat;
        let at_most = |bound: i64| proves(within.le(ast::Int::from_i64(bound)));
        let at_least = |bound: i64| proves(within.ge(ast::Int::from_i64(bound)));
        let (mut low, mut high) = (0, length - width);
        if !at_least(low) || !at_most(high) {
            return None;
        }
        let (mut floor, mut ceiling) = (low, high);
        while floor < ceiling {
            let middle = floor + (ceiling - floor) / 2;
            if at_most(middle) {
                ceiling = middle;
            } else {
                floor = middle + 1;
            }
        }
        high = ceiling;
        let (mut floor, mut ceiling) = (low, high);
        while floor < ceiling {
            let middle = floor + (ceiling - floor + 1) / 2;
            if at_least(middle) {
                floor = middle;
            } else {
                ceiling = middle - 1;
            }
        }
        low = floor;
        let keeps_residue = |stride: i64| {
            proves(
                within
                    .modulo(ast::Int::from_i64(stride))
                    .eq(ast::Int::from_i64(low.rem_euclid(stride))),
            )
        };
        let stride = [64, 32, 16, 8, 4, 2, 1]
            .into_iter()
            .filter(|stride| *stride >= width)
            .find(|stride| keeps_residue(*stride))?;
        if (high - low) / stride > MOST_ENTRIES {
            return None;
        }
        let entries: Option<Vec<i64>> = (low..=high)
            .step_by(stride as usize)
            .map(|at| match table.read(at, width) {
                Some(entry) if entry.kind == RegisterKind::Immediate && entry.base.is_none() => {
                    Some(entry.offset & ((1i64 << (8 * width)) - 1))
                }
                _ => None,
            })
            .collect();
        let entries = entries?;
        Some((*entries.iter().min()?, *entries.iter().max()?))
    }

    fn holds_written_content(&self, region: &str, address: &RegisterValue, width: i64) -> bool {
        let Some(AbstractExpression::Abstract(name)) = &address.base else {
            return false;
        };
        let (named, offset) = self.get_memory_pointer(name.clone(), address.offset);
        named == region
            && self
                .memory
                .get(region)
                .is_some_and(|r| r.read(offset, width).is_some())
    }

    fn element_fields(
        &self,
        region: &str,
        address: &RegisterValue,
        width: i64,
    ) -> Option<(i64, Vec<ElementRange>)> {
        let fields: Vec<ElementRange> = self
            .element_ranges
            .get(region)?
            .iter()
            .filter(|range| range.field.is_some() && range.width >= width)
            .cloned()
            .collect();
        let element = fields.first()?.width;
        if fields.is_empty() || self.holds_written_content(region, address, width) {
            return None;
        }
        let base = address.base.clone()?;
        let (_, symbol, label_offset) = self.region_of(&base)?;
        let access = expression_to_ast(base)?;
        let within = ast::Int::sub(&[
            &ast::Int::add(&[&access, &ast::Int::from_i64(address.offset + label_offset)]),
            &ast::Int::new_const(symbol),
        ]);
        (0..=element - width)
            .step_by(width as usize)
            .find_map(|byte| {
                let elsewhere = within
                    .modulo(ast::Int::from_i64(element))
                    .eq(ast::Int::from_i64(byte))
                    .not();
                (self.solver.check_assumptions(&[elsewhere]) == SatResult::Unsat)
                    .then(|| (byte, fields.clone()))
            })
    }

    fn element_bound(
        &self,
        region: &str,
        address: &RegisterValue,
        width: i64,
    ) -> Option<(AbstractExpression, AbstractExpression)> {
        let ranges = self.element_ranges.get(region)?;
        if self.holds_written_content(region, address, width) {
            return None;
        }
        let base = address.base.clone()?;
        let (_, symbol, label_offset) = self.region_of(&base)?;
        let access = expression_to_ast(base)?;
        let within = ast::Int::sub(&[
            &ast::Int::add(&[&access, &ast::Int::from_i64(address.offset + label_offset)]),
            &ast::Int::new_const(symbol),
        ]);
        let at = |stride: i64, remainder: i64| {
            let elsewhere = within
                .modulo(ast::Int::from_i64(stride))
                .eq(ast::Int::from_i64(remainder))
                .not();
            self.solver.check_assumptions(&[elsewhere]) == SatResult::Unsat
        };
        let unsigned: Vec<&ElementRange> = ranges
            .iter()
            .filter(|range| !range.signed && range.field.is_none())
            .collect();
        let element = unsigned.first()?.width;
        let whole = width == element && at(element, 0);
        let top_byte = width == 1 && element > 1 && at(element, element - 1);
        if !whole && !top_byte {
            return None;
        }
        let shift = 8 * (element - 1);
        let (mut low, mut high) = (
            AbstractExpression::Immediate(0),
            AbstractExpression::Immediate(if whole && element < 8 {
                (1i64 << (8 * element)) - 1
            } else if whole {
                i64::MAX
            } else {
                255
            }),
        );
        for range in unsigned.iter().filter(|range| range.width == element) {
            let one = AbstractExpression::Immediate(1);
            let (op, bound) = match range.op.as_str() {
                "<" => ("<=", generate_expression("-", range.bound.clone(), one)),
                ">" => (">=", generate_expression("+", range.bound.clone(), one)),
                op => (op, range.bound.clone()),
            };
            let bound = match (top_byte, &bound) {
                (false, _) => Some(bound),
                (true, AbstractExpression::Immediate(b)) if *b >= 0 => {
                    Some(AbstractExpression::Immediate(b >> shift))
                }
                _ => None,
            };
            match (op, bound) {
                ("<=", Some(bound)) => high = bound,
                (">=", Some(bound)) => low = bound,
                _ => (),
            }
        }
        Some((low, high))
    }

    fn element_pointer(
        &self,
        region: &str,
        address: &RegisterValue,
        width: i64,
    ) -> Option<RegisterValue> {
        let target = self.pointer_elements.get(region)?;
        let base = address.base.clone()?;
        let (_, symbol, label_offset) = self.region_of(&base)?;
        let access = expression_to_ast(base)?;
        let within = ast::Int::sub(&[
            &ast::Int::add(&[&access, &ast::Int::from_i64(address.offset + label_offset)]),
            &ast::Int::new_const(symbol),
        ]);
        let misaligned = within
            .modulo(ast::Int::from_i64(8))
            .eq(ast::Int::from_i64(0))
            .not();
        let pristine = self.memory.get(region).is_some_and(|r| r.pristine());
        (width == 8 && pristine && self.solver.check_assumptions(&[misaligned]) == SatResult::Unsat)
            .then(|| {
                RegisterValue::new(
                    RegisterKind::RegisterBase,
                    Some(AbstractExpression::Abstract(target.clone())),
                    0,
                )
            })
    }

    pub fn load(&mut self, address: &RegisterValue, width: i64) -> Result<RegisterValue, String> {
        let region = self.mem_safe_access(
            address,
            RegionType::READ,
            AbstractExpression::Immediate(width),
        )?;
        self.note_access(RegionType::READ, address);
        if self.writable_rows(&region) {
            return Ok(unknown());
        }
        if let Some(row) = self.element_pointer(&region, address, width) {
            return Ok(row);
        }
        if let Some((low, high)) = self.element_bound(&region, address, width) {
            return Ok(self.unknown_between(low, high));
        }
        if let Some((byte, fields)) = self.element_fields(&region, address, width) {
            let element = self.fresh("element");
            let high = if width < 8 {
                (1i64 << (8 * width)) - 1
            } else {
                i64::MAX
            };
            let mut facts = vec![
                AbstractComparison::new(">=", element.clone(), AbstractExpression::Immediate(0)),
                AbstractComparison::new("<=", element.clone(), AbstractExpression::Immediate(high)),
            ];
            facts.extend(
                fields
                    .iter()
                    .filter_map(|range| range.field_fact_within(&element, byte, width)),
            );
            for fact in facts {
                if let Some(asserted) = comparison_to_ast(fact) {
                    self.bound_fresh(asserted);
                }
            }
            return Ok(RegisterValue::new(
                RegisterKind::RegisterBase,
                Some(element),
                0,
            ));
        }
        let Some(AbstractExpression::Abstract(name)) = &address.base else {
            if let Some((low, high)) = self.constant_table_range(&region, address, width) {
                return Ok(self.unknown_between(
                    AbstractExpression::Immediate(low),
                    AbstractExpression::Immediate(high),
                ));
            }
            return Ok(unknown());
        };
        let (region, offset) = self.get_memory_pointer(name.clone(), address.offset);
        let Some((value, cells)) = self
            .memory
            .get(&region)
            .and_then(|r| Some((r.read(offset, width)?, r.overlapping(offset, width))))
        else {
            return Ok(unknown());
        };
        for cell in cells {
            self.note_element_read(&region, cell);
        }
        Ok(self.narrow_checked(&value, width))
    }

    pub fn store(
        &mut self,
        address: &RegisterValue,
        width: i64,
        value: RegisterValue,
    ) -> Result<(), String> {
        let region = self.mem_safe_access(
            address,
            RegionType::WRITE,
            AbstractExpression::Immediate(width),
        )?;
        self.note_access(RegionType::WRITE, address);
        let base = address.base.clone().expect("checked by the access");
        match &base {
            AbstractExpression::Abstract(name) => {
                let (region, offset) = self.get_memory_pointer(name.clone(), address.offset);
                let kept = match width {
                    1 | 2 | 4 => self.narrow_checked(&value, width),
                    _ => value,
                };
                self.store_cell(&MemoryCell { region, offset }, kept, width);
            }
            _ => self.forget_written(&region, &base, address.offset, width, Some(&value)),
        }
        Ok(())
    }

    fn forget_written(
        &mut self,
        region: &str,
        base: &AbstractExpression,
        offset: i64,
        width: i64,
        value: Option<&RegisterValue>,
    ) {
        self.forget_where_written(base, offset, width, value);
        if region == STACK {
            self.blind_stack_writes.push((base.clone(), offset, width));
        }
    }

    pub fn store_range(
        &mut self,
        address: &RegisterValue,
        length: AbstractExpression,
    ) -> Result<(), String> {
        let region = self.mem_safe_access(address, RegionType::WRITE, length.clone())?;
        self.note_access(RegionType::WRITE, address);
        let base = address.base.clone().expect("checked by the access");
        match length {
            AbstractExpression::Immediate(n) => {
                self.forget_written(&region, &base, address.offset, n, None)
            }
            spanned => {
                self.forget_where_spanned(&base, address.offset, &spanned, None);
                if region == STACK {
                    self.blind_stack_writes
                        .push((base, address.offset, 1 << 40));
                }
            }
        }
        Ok(())
    }

    pub fn load_range(
        &mut self,
        address: &RegisterValue,
        length: AbstractExpression,
    ) -> Result<(), String> {
        self.mem_safe_access(address, RegionType::READ, length)?;
        self.note_access(RegionType::READ, address);
        Ok(())
    }
}

pub fn add_values(a: &RegisterValue, b: &RegisterValue) -> RegisterValue {
    match (&a.kind, &b.kind) {
        (RegisterKind::Number, _) | (_, RegisterKind::Number) => unknown(),
        _ => {
            let base = match (&a.base, &b.base) {
                (Some(x), Some(y)) => Some(generate_expression("+", x.clone(), y.clone())),
                (Some(x), None) | (None, Some(x)) => Some(x.clone()),
                (None, None) => None,
            };
            let kind = if base.is_some() {
                RegisterKind::RegisterBase
            } else {
                RegisterKind::Immediate
            };
            RegisterValue::new(kind, base, a.offset.wrapping_add(b.offset))
        }
    }
}
