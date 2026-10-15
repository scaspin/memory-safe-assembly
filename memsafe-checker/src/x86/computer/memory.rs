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
        }
        Ok(address)
    }

    fn symbol_value(&self, symbol: &str) -> Result<RegisterValue, String> {
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
            let max = expression_to_ast(region.get_length()).expect("stack length");
            (
                ast::Int::sub(&[&start, &max]),
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

    pub fn load(&mut self, address: &RegisterValue, width: i64) -> Result<RegisterValue, String> {
        self.mem_safe_access(
            address,
            RegionType::READ,
            AbstractExpression::Immediate(width),
        )?;
        self.note_access(RegionType::READ, address);
        let Some(AbstractExpression::Abstract(name)) = &address.base else {
            return Ok(unknown());
        };
        let (region, offset) = self.get_memory_pointer(name.clone(), address.offset);
        let Some(value) = self.memory.get(&region).and_then(|r| r.read(offset, width)) else {
            return Ok(unknown());
        };
        self.note_element_read(&region, offset);
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
            _ => self.forget_written(&region, &base, address.offset, width),
        }
        Ok(())
    }

    fn forget_written(&mut self, region: &str, base: &AbstractExpression, offset: i64, width: i64) {
        self.forget_where_written(base, offset, width);
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
        let width = match length {
            AbstractExpression::Immediate(n) => n,
            _ => 1 << 40,
        };
        let base = address.base.clone().expect("checked by the access");
        self.forget_written(&region, &base, address.offset, width);
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
