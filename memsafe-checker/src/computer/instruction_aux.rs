use crate::computer::*;

const SMALL_MASK_NODES: usize = 3;
const BYTE_INDEX_MASK: i64 = 0xff;

impl ARMCORTEXA {
    pub fn arithmetic(
        &mut self,
        op_string: &str,
        op: impl Fn(i64, i64) -> i64,
        operands: Vec<Operand>,
    ) {
        let reg0 = operands.first().expect("Need destination register").clone();
        match self.arithmetic_value(op_string, op, &operands) {
            Some(v) => self.set_register(&reg0, v.kind, v.base, v.offset),
            None => log::error!("no rule for {op_string} on these operand kinds"),
        }
    }

    pub fn carry_select(
        &mut self,
        op_string: &str,
        with_carry: impl Fn(i64, i64) -> i64,
        without_carry: impl Fn(i64, i64) -> i64,
        condition: &AbstractComparison,
        operands: &[Operand],
    ) -> Result<ExecuteReturnType, String> {
        let dest = operands.first().expect("Need destination register").clone();
        let set = self.arithmetic_value(op_string, with_carry, operands);
        let clear = self.arithmetic_value(op_string, without_carry, operands);
        match (set, clear) {
            (Some(set), Some(clear)) if set == clear => {
                self.set_register(&dest, set.kind, set.base, set.offset);
                Ok(ExecuteReturnType::Next)
            }
            (Some(set), Some(clear)) => {
                match (
                    comparison_to_ast(condition.clone()),
                    expression_to_ast(set.expression()),
                    expression_to_ast(clear.expression()),
                ) {
                    (Some(_cond), Some(set_ast), Some(clear_ast)) => {
                        let name = format!("carry_{}", self.next_carry());
                        let result = ast::Int::new_const(name.clone());
                        let constants_did_not_wrap = clear.offset <= set.offset;
                        if constants_did_not_wrap {
                            self.solver.assert(result.ge(&clear_ast));
                            self.solver.assert(result.le(&set_ast));
                        }
                        self.set_register(
                            &dest,
                            RegisterKind::RegisterBase,
                            Some(AbstractExpression::Abstract(name)),
                            0,
                        );
                        Ok(ExecuteReturnType::Next)
                    }
                    _ => Ok(ExecuteReturnType::Select(
                        condition.clone(),
                        dest,
                        set,
                        clear,
                    )),
                }
            }
            _ => Err(format!("no rule for {op_string} on these operand kinds")),
        }
    }

    fn capped(&mut self, e: AbstractExpression) -> AbstractExpression {
        if e.size() <= MAX_EXPRESSION_NODES
            || e.get_abstracts()
                .iter()
                .any(|name| self.memory.contains_key(name))
        {
            return e;
        }
        AbstractExpression::Abstract(format!("wide_{}", self.next_carry()))
    }

    fn carried_base(
        base: Option<AbstractExpression>,
        op_string: &str,
    ) -> Option<AbstractExpression> {
        match (base, op_string) {
            (Some(b), "-") => Some(generate_expression(
                "-",
                AbstractExpression::Immediate(0),
                b,
            )),
            (other, _) => other,
        }
    }

    pub fn arithmetic_value(
        &mut self,
        op_string: &str,
        op: impl Fn(i64, i64) -> i64,
        operands: &[Operand],
    ) -> Option<RegisterValue> {
        let mut reg_iter = operands.iter();

        let _ = reg_iter.next().expect("Need destination register");
        let reg1 = reg_iter.next().expect("Need first source register");
        let reg2 = reg_iter.next().expect("Need second source register");

        let r1 = self.get_register(reg1);
        let mut r2 = self.get_register(reg2);

        if let Some(Operand::Bitwise(op, num)) = &reg_iter.next() {
            r2 = shift_operand(op, r2, reg2, *num);
        }

        let based = |base, offset| {
            Some(RegisterValue {
                kind: RegisterKind::RegisterBase,
                base,
                offset,
            })
        };

        if op_string == "|"
            && let Some(value) = or_sets_a_tag_bit(&r1, &r2)
        {
            return Some(value);
        }

        if !matches!(op_string, "+" | "-") && (r1.base.is_some() || r2.base.is_some()) {
            if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
                return Some(RegisterValue {
                    kind: RegisterKind::Number,
                    base: None,
                    offset: 0,
                });
            }
            let whole = generate_expression(op_string, r1.expression(), r2.expression());
            return based(Some(self.capped(whole)), 0);
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    let base = match r1.clone().base {
                        Some(reg1base) => match r2.clone().base {
                            Some(reg2base) => Some(
                                self.capped(generate_expression(op_string, reg1base, reg2base)),
                            ),
                            None => Some(reg1base),
                        },
                        None => Self::carried_base(r2.clone().base, op_string),
                    };
                    based(base, op(r1.offset, r2.offset))
                }
                RegisterKind::Number => Some(RegisterValue {
                    kind: RegisterKind::Number,
                    base: None,
                    offset: 0,
                }),
                RegisterKind::Immediate => Some(RegisterValue {
                    kind: RegisterKind::Immediate,
                    base: None,
                    offset: op(r1.offset, r2.offset),
                }),
            }
        } else if r1.kind == RegisterKind::Immediate {
            Some(RegisterValue {
                kind: r2.kind.clone(),
                base: Self::carried_base(r2.base.clone(), op_string),
                offset: op(r1.offset, r2.offset),
            })
        } else if r2.kind == RegisterKind::Immediate {
            Some(RegisterValue {
                kind: r1.kind.clone(),
                base: r1.base.clone(),
                offset: op(r1.offset, r2.offset),
            })
        } else if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            Some(RegisterValue {
                kind: RegisterKind::Number,
                base: None,
                offset: 0,
            })
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let base = match r2.clone().base {
                Some(reg1base) => match r1.clone().base {
                    Some(reg2base) => {
                        Some(self.capped(generate_expression(op_string, reg1base, reg2base)))
                    }
                    None => Some(reg1base),
                },
                None => r1.clone().base,
            };
            based(base, op(r1.offset, r2.offset))
        } else {
            None
        }
    }

    pub fn low_bits_left_after_clearing(
        &mut self,
        operands: &[Operand],
    ) -> Option<AbstractExpression> {
        let [
            Operand::Register(prefix, _),
            left,
            right @ Operand::Register(..),
        ] = operands
        else {
            return None;
        };
        let bits = match prefix {
            RePrefix::W => 32,
            RePrefix::X => 64,
            _ => return None,
        };
        let (left, right) = (self.get_register(left), self.get_register(right));
        if left.kind == RegisterKind::Number || right.kind == RegisterKind::Number {
            return None;
        }
        let (left, right) = (full_value(&left), full_value(&right));
        let unwrapped = match &right {
            AbstractExpression::Expression(op, inner, modulus)
                if op == "%" && **modulus == AbstractExpression::Immediate(1 << 32) =>
            {
                (**inner).clone()
            }
            other => other.clone(),
        };
        let AbstractExpression::Expression(op, masked, mask) = &unwrapped else {
            return None;
        };
        let (AbstractExpression::Immediate(mask), true) = (&**mask, op == "&" && **masked == left)
        else {
            return None;
        };
        let cleared = (*mask as u64).trailing_zeros().min(63);
        let word = if bits == 64 {
            u64::MAX
        } else {
            (1u64 << bits) - 1
        };
        let high = word & !((1u64 << cleared) - 1);
        let within_word = crate::widening::unsigned_range(&left)
            .is_some_and(|(low, top)| low >= 0 && (top as u64) <= word);
        ((*mask as u64) & word == high && cleared > 0 && within_word)
            .then(|| generate_expression("%", left, AbstractExpression::Immediate(1 << cleared)))
    }

    pub fn nonnegative_mask(&mut self, instruction: &Instruction) -> Option<AbstractExpression> {
        let [_, first, second, rest @ ..] = instruction.operands.as_slice() else {
            return None;
        };
        if !rest.is_empty() {
            return None;
        }
        let first = self.get_register(first);
        let second = self.get_register(second);
        let masks_an_unknown =
            first.kind == RegisterKind::Number || second.kind == RegisterKind::Number;
        [second, first]
            .into_iter()
            .filter_map(|value| match value.kind {
                RegisterKind::Immediate
                    if (0..=BYTE_INDEX_MASK).contains(&value.offset) && masks_an_unknown =>
                {
                    Some(AbstractExpression::Immediate(value.offset))
                }
                RegisterKind::RegisterBase => {
                    let mask = full_value(&value);
                    if crate::widening::unsigned_range(&mask).is_some_and(|(low, _)| low >= 0) {
                        return Some(mask);
                    }
                    if mask.size() > SMALL_MASK_NODES {
                        return None;
                    }
                    let ast = expression_to_ast(mask.clone())?;
                    self.unsat_within_budget(&[ast.lt(ast::Int::from_i64(0))])
                        .then_some(mask)
                }
                _ => None,
            })
            .reduce(|tighter, other| generate_expression("atmost", tighter, other))
    }

    pub fn bound_masked_result(
        &mut self,
        instruction: &Instruction,
        mask: Option<AbstractExpression>,
    ) {
        let (Some(mask), Some(destination @ Operand::Register(..))) =
            (mask, instruction.operands.first())
        else {
            return;
        };
        let value = self.get_register(destination);
        let exact = value.kind == RegisterKind::Immediate
            || value.base.as_ref().is_some_and(is_exactly_translatable);
        if exact {
            return;
        }
        let bounded = generate_expression(
            "atmost",
            generate_expression(
                "atleast",
                AbstractExpression::Abstract(self.fresh_symbol("masked")),
                AbstractExpression::Immediate(0),
            ),
            mask,
        );
        self.set_register(destination, RegisterKind::RegisterBase, Some(bounded), 0);
    }

    pub fn bitwise_operand_bits(&mut self, instruction: &Instruction) -> Option<i64> {
        let [_, first, second, rest @ ..] = instruction.operands.as_slice() else {
            return None;
        };
        let register_bits = match second {
            Operand::Register(RePrefix::W, _) => 32,
            _ => 64,
        };
        let unshifted = self.get_register(second);
        let shift = match rest.first() {
            Some(Operand::Bitwise(op, amount)) => Some((op.to_string(), *amount)),
            _ => None,
        };
        let shifted_out_bits = match &shift {
            Some((op, amount)) if op == "lsr" && *amount > 0 => Some(register_bits - amount),
            _ => None,
        };
        let shifted = match shift {
            Some((op, amount)) => shift_imm(op, unshifted, amount),
            None => unshifted,
        };
        let first = self.get_register(first);
        let width_of = |value: &RegisterValue| {
            if value.kind == RegisterKind::Number {
                return None;
            }
            let syntactic = crate::widening::unsigned_range(&full_value(value))
                .filter(|(low, _)| *low >= 0)
                .and_then(|(_, high)| [4, 8, 16, 31].into_iter().find(|&bits| high < 1i64 << bits));
            if syntactic.is_some_and(|bits| bits <= 16) {
                return syntactic;
            }
            let proved = [8, 16]
                .into_iter()
                .find(|&bits| self.fits_unsigned_within_budget(value, bits));
            proved.or(syntactic)
        };
        let first_bits = width_of(&first)?;
        let second_bits = width_of(&shifted).or(shifted_out_bits)?;
        Some(first_bits.max(second_bits)).filter(|bits| *bits <= 62)
    }

    fn fits_unsigned_within_budget(&self, value: &RegisterValue, bits: i64) -> bool {
        if value.kind != RegisterKind::RegisterBase {
            return false;
        }
        let Some(ast) = expression_to_ast(full_value(value)) else {
            return false;
        };
        let outside = ast::Bool::or(&[
            ast.lt(ast::Int::from_i64(0)),
            ast.ge(ast::Int::from_i64(1i64 << bits)),
        ]);
        crate::common::refuted_incrementally_within(
            &self.solver,
            &outside,
            crate::machine::BIT_WIDTH_RESOURCE_LIMIT,
        )
    }

    pub fn bound_bitwise_result(&mut self, instruction: &Instruction, bits: Option<i64>) {
        if let (Some(bits), Some(destination @ Operand::Register(..))) =
            (bits, instruction.operands.first())
        {
            let value = self.get_register(destination);
            let exact = value.kind == RegisterKind::Immediate
                || value.base.as_ref().is_some_and(is_exactly_translatable);
            if !exact {
                let bounded = generate_expression(
                    "atmost",
                    generate_expression(
                        "atleast",
                        AbstractExpression::Abstract(self.fresh_symbol("bitwise")),
                        AbstractExpression::Immediate(0),
                    ),
                    AbstractExpression::Immediate((1i64 << bits) - 1),
                );
                self.set_register(destination, RegisterKind::RegisterBase, Some(bounded), 0);
            }
            return;
        }
        let Some(destination @ Operand::Register(RePrefix::W, _)) = instruction.operands.first()
        else {
            return;
        };
        if instruction
            .operands
            .iter()
            .any(|o| matches!(o, Operand::Immediate(_)))
        {
            return;
        }
        let value = self.get_register(destination);
        let translatable = value
            .base
            .as_ref()
            .is_none_or(|b| expression_to_ast(b.clone()).is_some());
        if translatable {
            return;
        }
        let name = self.fresh_symbol("bitwise");
        let bounded = generate_expression(
            "atmost",
            generate_expression(
                "atleast",
                AbstractExpression::Abstract(name),
                AbstractExpression::Immediate(0),
            ),
            AbstractExpression::Immediate((1i64 << 32) - 1),
        );
        self.set_register(destination, RegisterKind::RegisterBase, Some(bounded), 0);
    }

    pub fn source_bit_widths(&mut self, instruction: &Instruction) -> Option<[u32; 2]> {
        let [
            _,
            left @ Operand::Register(..),
            right @ Operand::Register(..),
        ] = instruction.operands.as_slice()
        else {
            return None;
        };
        let sources = [left, right].map(|operand| (operand.clone(), self.get_register(operand)));
        let width = |(operand, value): &(Operand, RegisterValue)| {
            let Operand::Register(prefix, _) = operand else {
                return None;
            };
            if value.kind == RegisterKind::Number && value.base.is_none() {
                return (value.offset >= 0).then(|| 64 - value.offset.leading_zeros());
            }
            let expression = value.expression();
            let narrower = if *prefix == RePrefix::W { 31 } else { 62 };
            self.proven_bit_width(&expression)
                .filter(|&bits| bits <= narrower)
        };
        Some([width(&sources[0])?, width(&sources[1])?])
    }

    pub fn bound_by_source_widths(&mut self, instruction: &Instruction, widths: Option<[u32; 2]>) {
        let (Some([left, right]), Some(destination)) = (widths, instruction.operands.first())
        else {
            return;
        };
        let result = self.get_register(destination).expression();
        let ceiling = (1i64 << left.max(right)) - 1;
        for (op, bound) in [(">=", 0), ("<=", ceiling)] {
            if let Some(fact) = comparison_to_ast(AbstractComparison::new(
                op,
                result.clone(),
                AbstractExpression::Immediate(bound),
            )) {
                self.bound_fresh(fact);
            }
        }
    }

    pub fn fold_mask_within_aligned_region(&mut self, instruction: &Instruction) {
        let Some(destination @ Operand::Register(RePrefix::X, _)) = instruction.operands.first()
        else {
            return;
        };
        let value = self.get_register(destination);
        if value.kind != RegisterKind::RegisterBase || value.offset != 0 {
            return;
        }
        let Some(base @ AbstractExpression::Expression(op, _, _)) = &value.base else {
            return;
        };
        if op != "&" {
            return;
        }
        if let Some((region, offset)) = self.aligned_offset(base) {
            self.set_register(
                destination,
                RegisterKind::RegisterBase,
                Some(AbstractExpression::Abstract(region)),
                offset,
            );
        }
    }

    pub fn realign_below_stack_pointer(&mut self, instruction: &Instruction) {
        let Some(destination @ Operand::Register(RePrefix::X | RePrefix::Sp, _)) =
            instruction.operands.first()
        else {
            return;
        };
        let value = self.get_register(destination);
        let Some(AbstractExpression::Expression(op, inner, mask)) = &value.base else {
            return;
        };
        let AbstractExpression::Immediate(mask) = **mask else {
            return;
        };
        let alignment = mask.wrapping_neg();
        let rounds_down = alignment > 1 && alignment <= 1 << 16 && alignment & (alignment - 1) == 0;
        if op != "&" || value.offset != 0 || !rounds_down {
            return;
        }
        let entry = AbstractExpression::Abstract("sp".to_string());
        let Some(form) = crate::widening::Affine::of(inner) else {
            return;
        };
        if form.coefficient(&entry) != 1 || !form.mentions_only_as_term(&entry) {
            return;
        }
        let name = self.fresh_symbol("realigned");
        let dropped = ast::Int::new_const(name.clone());
        self.bound_fresh(dropped.ge(ast::Int::from_i64(0)));
        self.bound_fresh(dropped.lt(ast::Int::from_i64(alignment)));
        let lowered =
            generate_expression("-", (**inner).clone(), AbstractExpression::Abstract(name));
        self.set_register(destination, RegisterKind::RegisterBase, Some(lowered), 0);
    }

    pub fn shift_reg(&mut self, op: &str, reg1: &Operand, reg2: &Operand, reg3: &Operand) {
        let r2 = self.get_register(reg2);
        let r2 = if op == "asr" && matches!(reg2, Operand::Register(RePrefix::W, _)) {
            sign_extend_word(r2)
        } else {
            r2
        };

        let rotates_a_32_bit_constant = op == "ror"
            && matches!(reg2, Operand::Register(RePrefix::W, _))
            && r2.kind == RegisterKind::Immediate
            && r2.base.is_none();
        if rotates_a_32_bit_constant
            && let Operand::Bitwise(_, amount) | Operand::Immediate(amount) = reg3
        {
            let rotated = (r2.offset as u32).rotate_right(*amount as u32);
            self.set_register(reg1, RegisterKind::Immediate, None, rotated as i64);
            return;
        }

        let shifted_reg = match reg3 {
            Operand::Bitwise(op, shift) => shift_imm(op.to_string(), r2, *shift),
            Operand::Immediate(shift) => shift_imm(op.to_string(), r2, *shift),
            Operand::Register(..) => {
                let bits = if matches!(reg1, Operand::Register(RePrefix::W, _)) {
                    32
                } else {
                    64
                };
                let amount = self.get_register(reg3);
                if amount.kind == RegisterKind::Immediate && amount.base.is_none() {
                    shift_imm(op.to_string(), r2, amount.offset.rem_euclid(bits))
                } else {
                    let unknown = RegisterValue {
                        kind: RegisterKind::Number,
                        base: None,
                        offset: 0,
                    };
                    if bits == 32 {
                        self.field_of_unknown(unknown, 32, false)
                    } else {
                        unknown
                    }
                }
            }
            _ => {
                log::info!("shift by register amount {:?} is not modelled", reg3);
                RegisterValue {
                    kind: RegisterKind::Number,
                    base: None,
                    offset: 0,
                }
            }
        };

        let shifted_reg = match (op, reg3, reg2) {
            ("lsr", Operand::Immediate(k), Operand::Register(prefix, _)) if *k > 0 => {
                let bits = if *prefix == RePrefix::W { 32 } else { 64 };
                self.field_of_unknown(shifted_reg, bits - k, false)
            }
            ("asr", Operand::Immediate(k), Operand::Register(RePrefix::X, _)) => {
                let source = self.get_register(reg2);
                self.undone_left_shift(&source, *k).unwrap_or(shifted_reg)
            }
            _ => shifted_reg,
        };
        self.set_register(reg1, shifted_reg.kind, shifted_reg.base, shifted_reg.offset);
    }

    fn undone_left_shift(&self, shifted: &RegisterValue, k: i64) -> Option<RegisterValue> {
        if !(1..63).contains(&k) || shifted.kind == RegisterKind::Number {
            return None;
        }
        let AbstractExpression::Expression(op, unshifted, amount) = full_value(shifted) else {
            return None;
        };
        if op != "lsl" || *amount != AbstractExpression::Immediate(k) {
            return None;
        }
        let half = 1i64 << (63 - k);
        if !self.provably_between(&unshifted, -half, half - 1) {
            return None;
        }
        let (base, offset) = match *unshifted {
            AbstractExpression::Immediate(value) => (None, value),
            other => (Some(other), 0),
        };
        let kind = if base.is_some() {
            shifted.kind.clone()
        } else {
            RegisterKind::Immediate
        };
        Some(RegisterValue::new(kind, base, offset))
    }

    pub fn extend_loaded(&mut self, dst: &Operand, opcode: &str, width: i64) {
        if width >= 8 {
            return;
        }
        let value = self.get_register(dst);
        let signed = opcode.starts_with("ldrs") || opcode.starts_with("ldurs");
        let confined = value
            .base
            .as_ref()
            .map(peel_narrowing)
            .filter(|base| value.offset == 0 && confined_load_width(base) == Some(width));
        if let Some(base) = confined {
            if signed {
                let extended =
                    generate_expression("sext", base, AbstractExpression::Immediate(8 * width));
                self.set_register(dst, RegisterKind::RegisterBase, Some(extended), 0);
                self.mark_loaded(dst);
            }
            return;
        }
        let bits = 8 * width as u32;
        if value.kind == RegisterKind::RegisterBase {
            let whole = full_value(&value);
            let (least, most) = if signed {
                (-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1)
            } else {
                (0, (1i64 << bits) - 1)
            };
            if !self.provably_between(&whole, least, most) {
                let extension = if signed { "sext" } else { "zext" };
                let extended = generate_expression(
                    extension,
                    whole,
                    AbstractExpression::Immediate(bits as i64),
                );
                self.set_register(dst, RegisterKind::RegisterBase, Some(extended), 0);
                self.mark_loaded(dst);
            }
            return;
        }
        if value.kind != RegisterKind::Immediate {
            return;
        }
        let low = (value.offset as u64) & ((1u64 << bits) - 1);
        let extended = if signed {
            ((low << (64 - bits)) as i64) >> (64 - bits)
        } else {
            low as i64
        };
        self.set_register(dst, RegisterKind::Immediate, None, extended);
        self.mark_loaded(dst);
    }

    pub fn memory_address(
        &mut self,
        prefix: &RePrefix,
        num: usize,
        offset: &Option<i64>,
        register_offset: &Option<Box<Operand>>,
    ) -> RegisterValue {
        let mut address = self.get_register(&Operand::Register(prefix.clone(), num));
        address.offset += offset.unwrap_or(0);
        match register_offset {
            Some(register) => add_values(address, self.get_register(register)),
            None => address,
        }
    }

    pub fn indexed_address(
        &mut self,
        prefix: &RePrefix,
        num: usize,
        offset: &Option<i64>,
        register_offset: &Option<Box<Operand>>,
        mode: &Option<bool>,
    ) -> (RegisterValue, Option<RegisterValue>) {
        let target = self.memory_address(prefix, num, offset, register_offset);
        match mode {
            Some(true) => (
                self.get_register(&Operand::Register(prefix.clone(), num)),
                Some(target),
            ),
            Some(false) => {
                self.write_back(prefix, num, Some(target.clone()));
                (target.clone(), Some(target))
            }
            None => (target, None),
        }
    }

    pub fn write_back(&mut self, prefix: &RePrefix, num: usize, value: Option<RegisterValue>) {
        if let Some(value) = value {
            self.set_register(
                &Operand::Register(prefix.clone(), num),
                value.kind,
                value.base,
                value.offset,
            );
        }
    }

    pub fn flag_bits(operands: &[Operand]) -> u32 {
        let of = |operand: Option<&Operand>| match operand {
            Some(Operand::Register(RePrefix::W, _)) => Some(32),
            Some(Operand::Register(_, _)) => Some(64),
            Some(Operand::ShiftedRegister(inner, _, _)) => match **inner {
                Operand::Register(RePrefix::W, _) => Some(32),
                Operand::Register(_, _) => Some(64),
                _ => None,
            },
            _ => None,
        };
        of(operands.first())
            .or_else(|| of(operands.get(1)))
            .unwrap_or(64)
    }

    pub fn flag_operands(&mut self, operands: &[Operand]) -> (RegisterValue, RegisterValue) {
        let r1 = self.get_register(&operands[0]);
        let mut r2 = self.get_register(&operands[1]);
        if let Some(Operand::Bitwise(op, amount)) = operands.get(2) {
            r2 = shift_operand(op, r2, &operands[1], *amount);
        }
        (r1, r2)
    }

    pub fn cmp(&mut self, reg1: &Operand, reg2: &Operand) {
        let (r1, r2) = (self.get_register(reg1), self.get_register(reg2));
        let bits = Self::flag_bits(&[reg1.clone(), reg2.clone()]);
        self.cmp_values_sized(r1, r2, bits);
    }

    pub fn cmp_values(&mut self, r1: RegisterValue, r2: RegisterValue) {
        self.cmp_values_sized(r1, r2, 64);
    }

    pub fn cmp_values_sized(&mut self, r1: RegisterValue, r2: RegisterValue, bits: u32) {
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
            return;
        }

        if r1 == r2 && r1.kind != RegisterKind::Number {
            self.neg = Some(FlagValue::Real(false));
            self.zero = Some(FlagValue::Real(true));
            self.carry = Some(FlagValue::Real(true));
            self.overflow = Some(FlagValue::Real(false));
            return;
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => {
                    if r1.base.eq(&r2.base) {
                        self.neg = if r1.offset < r2.offset {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.zero = if r1.offset == r2.offset {
                            Some(FlagValue::Real(true))
                        } else {
                            Some(FlagValue::Real(false))
                        };
                        self.carry = Some(FlagValue::Real(r1.offset >= r2.offset));
                        self.overflow =
                            Some(FlagValue::Real(r1.offset.overflowing_sub(r2.offset).1));
                    } else {
                        let left = AbstractExpression::Register(Box::new(r1));
                        let right = AbstractExpression::Register(Box::new(r2));
                        let expression = AbstractExpression::Expression(
                            "-".to_string(),
                            Box::new(left.clone()),
                            Box::new(right.clone()),
                        );
                        let signed = signed_combination(bits, "-", &left, &right);
                        self.overflow =
                            Some(FlagValue::Abstract(signed_overflow(bits, signed.clone())));
                        self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                            "<",
                            signed,
                            AbstractExpression::Immediate(0),
                        )));
                        self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                            "==",
                            expression,
                            AbstractExpression::Immediate(0),
                        )));
                        self.carry = Some(FlagValue::Abstract(unsigned_no_borrow(left, right)));
                    }
                }
                RegisterKind::Number => self.set_unknown_flags(),
                RegisterKind::Immediate if bits == 32 => {
                    let (a, b) = (r1.offset as i32, r2.offset as i32);
                    self.neg = Some(FlagValue::Real(a < b));
                    self.zero = Some(FlagValue::Real(a == b));
                    self.carry = Some(FlagValue::Real((a as u32) >= (b as u32)));
                    self.overflow = Some(FlagValue::Real(a.overflowing_sub(b).1));
                }
                RegisterKind::Immediate => {
                    self.neg = if r1.offset < r2.offset {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    self.zero = if r1.offset == r2.offset {
                        Some(FlagValue::Real(true))
                    } else {
                        Some(FlagValue::Real(false))
                    };
                    self.carry = Some(FlagValue::Real((r1.offset as u64) >= (r2.offset as u64)));
                    self.overflow = Some(FlagValue::Real(r1.offset.overflowing_sub(r2.offset).1));
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            let left = AbstractExpression::Register(Box::new(r1));
            let right = AbstractExpression::Register(Box::new(r2));
            let expression = AbstractExpression::Expression(
                "-".to_string(),
                Box::new(left.clone()),
                Box::new(right.clone()),
            );
            let signed = signed_combination(bits, "-", &left, &right);
            self.overflow = Some(FlagValue::Abstract(signed_overflow(bits, signed.clone())));
            self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
                "<",
                signed,
                AbstractExpression::Immediate(0),
            )));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                expression,
                AbstractExpression::Immediate(0),
            )));
            self.carry = Some(FlagValue::Abstract(unsigned_no_borrow(left, right)));
        } else {
            self.set_unknown_flags();
        }
    }

    pub fn tst(&mut self, reg1: &Operand, reg2: &Operand) {
        let (r1, r2) = (self.get_register(reg1), self.get_register(reg2));
        let bits = Self::flag_bits(&[reg1.clone(), reg2.clone()]);
        self.tst_values_sized(r1, r2, bits);
    }

    pub fn tst_values_sized(&mut self, r1: RegisterValue, r2: RegisterValue, bits: u32) {
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
        } else if r1.base.is_none() && r2.base.is_none() {
            let result = r1.offset & r2.offset;
            let (negative, zero) = if bits == 32 {
                (result & (1 << 31) != 0, result & 0xffff_ffff == 0)
            } else {
                (result < 0, result == 0)
            };
            self.neg = Some(FlagValue::Real(negative));
            self.zero = Some(FlagValue::Real(zero));
        } else {
            let mut result = generate_expression("&", r1.expression(), r2.expression());
            if bits == 32 {
                result =
                    generate_expression("%", result, AbstractExpression::Immediate(1i64 << 32));
            }
            self.neg = Some(FlagValue::Abstract(if bits == 32 {
                AbstractComparison::new(
                    ">=",
                    result.clone(),
                    AbstractExpression::Immediate(1i64 << 31),
                )
            } else {
                AbstractComparison::new("<", result.clone(), AbstractExpression::Immediate(0))
            }));
            self.zero = Some(FlagValue::Abstract(AbstractComparison::new(
                "==",
                result,
                AbstractExpression::Immediate(0),
            )));
        }

        self.carry = Some(FlagValue::Real(false));
        self.overflow = Some(FlagValue::Real(false));
    }

    pub fn cmn(&mut self, reg1: &Operand, reg2: &Operand) {
        let (r1, r2) = (self.get_register(reg1), self.get_register(reg2));
        let bits = Self::flag_bits(&[reg1.clone(), reg2.clone()]);
        self.cmn_values_sized(r1, r2, bits);
    }

    pub fn cmn_values(&mut self, r1: RegisterValue, r2: RegisterValue) {
        self.cmn_values_sized(r1, r2, 64);
    }

    pub fn cmn_values_sized(&mut self, r1: RegisterValue, r2: RegisterValue, bits: u32) {
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
            return;
        }

        if r1.kind == r2.kind {
            match r1.kind {
                RegisterKind::RegisterBase => self.symbolic_sum_flags(r1, r2, bits, 0),
                RegisterKind::Number => self.set_unknown_flags(),
                RegisterKind::Immediate if bits == 32 => {
                    let (a, b) = (r1.offset as i32, r2.offset as i32);
                    self.neg = Some(FlagValue::Real((a as i64 + b as i64) < 0));
                    self.zero = Some(FlagValue::Real(a.wrapping_add(b) == 0));
                    self.carry = Some(FlagValue::Real((a as u32).overflowing_add(b as u32).1));
                    self.overflow = Some(FlagValue::Real(a.overflowing_add(b).1));
                }
                RegisterKind::Immediate => {
                    let (sum, signed_overflow) = r1.offset.overflowing_add(r2.offset);
                    self.neg = Some(FlagValue::Real((r1.offset as i128 + r2.offset as i128) < 0));
                    self.zero = Some(FlagValue::Real(sum == 0));
                    self.carry = Some(FlagValue::Real(
                        (r1.offset as u64).overflowing_add(r2.offset as u64).1,
                    ));
                    self.overflow = Some(FlagValue::Real(signed_overflow));
                }
            }
        } else if r1.kind == RegisterKind::RegisterBase || r2.kind == RegisterKind::RegisterBase {
            self.symbolic_sum_flags(r1, r2, bits, 0);
        } else {
            self.set_unknown_flags();
        }
    }

    fn symbolic_sum_flags(&mut self, r1: RegisterValue, r2: RegisterValue, bits: u32, carry: i64) {
        let left = AbstractExpression::Register(Box::new(r1));
        let right = AbstractExpression::Register(Box::new(r2));
        let with_carry = |e: AbstractExpression| match carry {
            0 => e,
            c => generate_expression("+", e, AbstractExpression::Immediate(c)),
        };
        let exact = with_carry(AbstractExpression::Expression(
            "+".to_string(),
            Box::new(left.clone()),
            Box::new(right.clone()),
        ));
        let signed = with_carry(signed_combination(bits, "+", &left, &right));
        self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
            "<",
            signed.clone(),
            AbstractExpression::Immediate(0),
        )));
        self.zero = Some(FlagValue::Abstract(wrapped_zero(exact, bits)));
        self.carry = self.unknown_flag("carry");
        self.overflow = Some(FlagValue::Abstract(signed_overflow(bits, signed)));
    }

    pub fn add_with_carry_flags(
        &mut self,
        r1: RegisterValue,
        r2: RegisterValue,
        bits: u32,
        carry_in: bool,
    ) {
        if carry_in {
            self.flags_one_past("+", r1, r2, bits);
        } else {
            self.cmn_values_sized(r1, r2, bits);
        }
    }

    pub fn subtract_with_carry_flags(
        &mut self,
        r1: RegisterValue,
        r2: RegisterValue,
        bits: u32,
        carry_in: bool,
    ) {
        if carry_in {
            self.cmp_values_sized(r1, r2, bits);
        } else {
            self.flags_one_past("-", r1, r2, bits);
        }
    }

    fn flags_one_past(&mut self, op: &str, r1: RegisterValue, r2: RegisterValue, bits: u32) {
        let adding = op == "+";
        if r1.kind == RegisterKind::Number || r2.kind == RegisterKind::Number {
            self.set_unknown_flags();
            return;
        }
        let constant = |r: &RegisterValue| r.kind == RegisterKind::Immediate && r.base.is_none();
        if constant(&r1) && constant(&r2) {
            let modulus = 1i128 << bits;
            let half = modulus / 2;
            let unsigned = |v: i64| (v as i128).rem_euclid(modulus);
            let signed = |v: i64| match unsigned(v) {
                u if u >= half => u - modulus,
                u => u,
            };
            let step = |x: i128, y: i128| if adding { x + y + 1 } else { x - y - 1 };
            let exact_unsigned = step(unsigned(r1.offset), unsigned(r2.offset));
            let exact_signed = step(signed(r1.offset), signed(r2.offset));
            self.neg = Some(FlagValue::Real(exact_signed < 0));
            self.zero = Some(FlagValue::Real(exact_unsigned.rem_euclid(modulus) == 0));
            self.carry = Some(FlagValue::Real(if adding {
                exact_unsigned >= modulus
            } else {
                exact_unsigned >= 0
            }));
            self.overflow = Some(FlagValue::Real(!(-half..half).contains(&exact_signed)));
            return;
        }
        if adding {
            self.symbolic_sum_flags(r1, r2, bits, 1);
            return;
        }
        let left = AbstractExpression::Register(Box::new(r1));
        let right = AbstractExpression::Register(Box::new(r2));
        let borrowed =
            |e: AbstractExpression| generate_expression("-", e, AbstractExpression::Immediate(1));
        let exact = borrowed(generate_expression("-", left.clone(), right.clone()));
        let signed = borrowed(signed_combination(bits, "-", &left, &right));
        self.neg = Some(FlagValue::Abstract(AbstractComparison::new(
            "<",
            signed.clone(),
            AbstractExpression::Immediate(0),
        )));
        self.overflow = Some(FlagValue::Abstract(signed_overflow(bits, signed)));
        self.zero = Some(FlagValue::Abstract(wrapped_zero(exact, bits)));
        let unsigned =
            |e| generate_expression("zext", e, AbstractExpression::Immediate(bits as i64));
        self.carry = Some(FlagValue::Abstract(AbstractComparison::new(
            ">=",
            unsigned(left),
            generate_expression("+", unsigned(right), AbstractExpression::Immediate(1)),
        )));
    }
}

fn wrapped_zero(exact: AbstractExpression, bits: u32) -> AbstractComparison {
    AbstractComparison::new(
        "==",
        generate_expression("sext", exact, AbstractExpression::Immediate(bits as i64)),
        AbstractExpression::Immediate(0),
    )
}

pub fn signed_combination(
    bits: u32,
    op: &str,
    left: &AbstractExpression,
    right: &AbstractExpression,
) -> AbstractExpression {
    let widen = |e: &AbstractExpression| match (bits, e) {
        (64, _) => e.clone(),
        (_, AbstractExpression::Immediate(n)) if i32::try_from(*n).is_ok() => e.clone(),
        (_, AbstractExpression::Register(r))
            if r.base.is_none() && i32::try_from(r.offset).is_ok() =>
        {
            e.clone()
        }
        _ => generate_expression(
            "sext",
            e.clone(),
            AbstractExpression::Immediate(bits as i64),
        ),
    };
    generate_expression(op, widen(left), widen(right))
}

fn signed_overflow(bits: u32, exact: AbstractExpression) -> AbstractComparison {
    if bits >= 64 {
        outside_signed_range(exact, 64)
    } else {
        narrow_signed_overflow(bits, exact)
    }
}

fn narrow_signed_overflow(bits: u32, exact: AbstractExpression) -> AbstractComparison {
    let half = 1i64 << (bits - 1);
    let shifted = AbstractExpression::Expression(
        "+".to_string(),
        Box::new(exact),
        Box::new(AbstractExpression::Immediate(half)),
    );
    let wrapped = AbstractExpression::Expression(
        "%".to_string(),
        Box::new(shifted.clone()),
        Box::new(AbstractExpression::Immediate(2 * half)),
    );
    AbstractComparison::new("!=", wrapped, shifted)
}

pub(super) fn narrow_wrapped_sign(overflow: &AbstractComparison) -> Option<AbstractComparison> {
    let AbstractExpression::Expression(modulo, shifted, modulus) = &*overflow.left else {
        return None;
    };
    let AbstractExpression::Expression(plus, exact, half) = &**shifted else {
        return None;
    };
    let (AbstractExpression::Immediate(modulus), AbstractExpression::Immediate(half)) =
        (&**modulus, &**half)
    else {
        return None;
    };
    let recognised = overflow.op == "!="
        && modulo == "%"
        && plus == "+"
        && *overflow.right == **shifted
        && *half > 0
        && half.checked_mul(2) == Some(*modulus);
    recognised.then(|| {
        AbstractComparison::new(
            ">=",
            AbstractExpression::Expression(
                "%".to_string(),
                exact.clone(),
                Box::new(AbstractExpression::Immediate(*modulus)),
            ),
            AbstractExpression::Immediate(*half),
        )
    })
}

fn unsigned_no_borrow(left: AbstractExpression, right: AbstractExpression) -> AbstractComparison {
    let unsigned = |e| generate_expression("zext", e, AbstractExpression::Immediate(64));
    AbstractComparison::new(">=", unsigned(left), unsigned(right))
}

pub fn count_leading_zeros(value: RegisterValue, width: u32) -> RegisterValue {
    match value.kind {
        RegisterKind::Immediate => {
            let count = if width == 32 {
                (value.offset as u32).leading_zeros()
            } else {
                (value.offset as u64).leading_zeros()
            };
            RegisterValue::new_imm(count as i64)
        }
        RegisterKind::RegisterBase => RegisterValue {
            kind: RegisterKind::RegisterBase,
            base: Some(generate_expression(
                "clz",
                value.expression(),
                AbstractExpression::Immediate(width as i64),
            )),
            offset: 0,
        },
        RegisterKind::Number => value,
    }
}

pub fn extract_bits(value: RegisterValue, lsb: i64, width: i64, signed: bool) -> RegisterValue {
    let unknown = RegisterValue {
        kind: RegisterKind::Number,
        base: None,
        offset: 0,
    };
    if lsb < 0 || width <= 0 || width >= 64 || lsb + width > 64 {
        return unknown;
    }
    let modulus = 1i64 << width;
    let half = 1i64 << (width - 1);
    match value.kind {
        RegisterKind::Immediate => {
            let field = (((value.offset as u64) >> lsb) & ((1u64 << width) - 1)) as i64;
            let offset = if signed && field >= half {
                field - modulus
            } else {
                field
            };
            RegisterValue {
                kind: RegisterKind::Immediate,
                base: None,
                offset,
            }
        }
        RegisterKind::RegisterBase => {
            let mut expression = full_value(&value);
            if lsb > 0 {
                expression =
                    generate_expression("lsr", expression, AbstractExpression::Immediate(lsb));
            }
            expression =
                generate_expression("%", expression, AbstractExpression::Immediate(modulus));
            if signed {
                expression = generate_expression(
                    "-",
                    generate_expression(
                        "%",
                        generate_expression("+", expression, AbstractExpression::Immediate(half)),
                        AbstractExpression::Immediate(modulus),
                    ),
                    AbstractExpression::Immediate(half),
                );
            }
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(expression),
                offset: 0,
            }
        }
        RegisterKind::Number => unknown,
    }
}

fn or_sets_a_tag_bit(left: &RegisterValue, right: &RegisterValue) -> Option<RegisterValue> {
    const STACK_ALIGNMENT: i64 = 16;
    let (address, tag) = match (&left.kind, &right.kind) {
        (RegisterKind::RegisterBase, RegisterKind::Immediate) => (left, right.offset),
        (RegisterKind::Immediate, RegisterKind::RegisterBase) => (right, left.offset),
        _ => return None,
    };
    if address.base.as_ref()? != &AbstractExpression::Abstract("sp".to_string()) {
        return None;
    }
    if tag <= 0 || tag >= STACK_ALIGNMENT || address.offset.rem_euclid(STACK_ALIGNMENT) & tag != 0 {
        return None;
    }
    Some(RegisterValue {
        kind: RegisterKind::RegisterBase,
        base: address.base.clone(),
        offset: address.offset + tag,
    })
}

pub fn insert_bits(
    destination: RegisterValue,
    field: RegisterValue,
    lsb: i64,
    width: i64,
    bits: i64,
) -> RegisterValue {
    let unknown = RegisterValue {
        kind: RegisterKind::Number,
        base: None,
        offset: 0,
    };
    if lsb < 0 || width <= 0 || lsb + width > bits || bits > 64 {
        return unknown;
    }
    let low_bits = extract_bits(field, 0, width, false);
    if low_bits.kind == RegisterKind::Number {
        return unknown;
    }
    let placed = shift_imm("lsl".to_string(), low_bits, lsb);
    match destination.kind {
        RegisterKind::Immediate => {
            let span = low_bits_mask(width) << lsb;
            let kept = (destination.offset as u64) & !span & low_bits_mask(bits);
            add_values(placed, RegisterValue::new_imm(kept as i64))
        }
        RegisterKind::RegisterBase => {
            let replaced = shift_imm(
                "lsl".to_string(),
                extract_bits(destination.clone(), lsb, width, false),
                lsb,
            );
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base: Some(generate_expression(
                    "+",
                    generate_expression("-", full_value(&destination), full_value(&replaced)),
                    full_value(&placed),
                )),
                offset: 0,
            }
        }
        RegisterKind::Number => unknown,
    }
}

fn low_bits_mask(width: i64) -> u64 {
    if width >= 64 {
        u64::MAX
    } else {
        (1u64 << width) - 1
    }
}

pub fn add_values(left: RegisterValue, right: RegisterValue) -> RegisterValue {
    match (&left.kind, &right.kind) {
        (RegisterKind::Number, _) | (_, RegisterKind::Number) => RegisterValue {
            kind: RegisterKind::Number,
            base: None,
            offset: 0,
        },
        (RegisterKind::Immediate, RegisterKind::Immediate) => RegisterValue {
            kind: RegisterKind::Immediate,
            base: None,
            offset: left.offset + right.offset,
        },
        _ => {
            let symbolic = |value: &RegisterValue| match value.kind {
                RegisterKind::RegisterBase => value.base.clone(),
                _ => None,
            };
            let base = match (symbolic(&left), symbolic(&right)) {
                (Some(l), Some(r)) => Some(generate_expression("+", l, r)),
                (Some(b), None) | (None, Some(b)) => Some(b),
                (None, None) => None,
            };
            RegisterValue {
                kind: RegisterKind::RegisterBase,
                base,
                offset: left.offset + right.offset,
            }
        }
    }
}

pub fn sign_extend_word(word: RegisterValue) -> RegisterValue {
    match word.kind {
        RegisterKind::Number => word,
        RegisterKind::Immediate => RegisterValue::new_imm(word.offset as i32 as i64),
        _ => RegisterValue::new(
            RegisterKind::RegisterBase,
            Some(generate_expression(
                "sext",
                full_value(&word),
                AbstractExpression::Immediate(32),
            )),
            0,
        ),
    }
}

pub fn full_value(register: &RegisterValue) -> AbstractExpression {
    match (&register.kind, &register.base) {
        (RegisterKind::RegisterBase, Some(base)) if register.offset == 0 => base.clone(),
        (RegisterKind::RegisterBase, Some(base)) => generate_expression(
            "+",
            base.clone(),
            AbstractExpression::Immediate(register.offset),
        ),
        _ => AbstractExpression::Immediate(register.offset),
    }
}

pub fn shift_operand(
    op: &str,
    value: RegisterValue,
    operand: &Operand,
    shift: i64,
) -> RegisterValue {
    let value = if op == "asr" && matches!(operand, Operand::Register(RePrefix::W, _)) {
        sign_extend_word(value)
    } else {
        value
    };
    shift_imm(op.to_string(), value, shift)
}

pub fn shift_imm(op: String, register: RegisterValue, shift: i64) -> RegisterValue {
    match op.as_str() {
        "lsl" => {
            let new_offset = register.offset << shift;
            RegisterValue {
                kind: register.kind,
                base: register
                    .base
                    .map(|b| generate_expression(&op, b, AbstractExpression::Immediate(shift))),
                offset: new_offset,
            }
        }
        "lsr" | "asr" | "ror" => match register.base {
            None => {
                let amount = shift as u32;
                let shifted = match op.as_str() {
                    "lsr" => (register.offset as u64).checked_shr(amount).unwrap_or(0) as i64,
                    "asr" => register
                        .offset
                        .checked_shr(amount)
                        .unwrap_or(if register.offset < 0 { -1 } else { 0 }),
                    _ => (register.offset as u64).rotate_right(amount) as i64,
                };
                RegisterValue {
                    kind: register.kind,
                    base: None,
                    offset: shifted,
                }
            }
            Some(_) => {
                let whole_value = register.expression();
                RegisterValue {
                    kind: register.kind,
                    base: Some(generate_expression(
                        &op,
                        whole_value,
                        AbstractExpression::Immediate(shift),
                    )),
                    offset: 0,
                }
            }
        },
        "" => {
            let new_offset = register.offset + shift;
            RegisterValue {
                kind: register.kind,
                base: register.base,
                offset: new_offset,
            }
        }
        "uxtw" | "sxtw" | "uxtb" | "uxth" | "sxtb" | "sxth" | "uxtx" | "sxtx" => {
            let bits: u32 = match &op[3..] {
                "b" => 8,
                "h" => 16,
                "w" => 32,
                _ => 64,
            };
            let signed = op.starts_with('s');
            let extended = match register.kind {
                _ if bits == 64 => register,
                RegisterKind::Immediate => {
                    let low = (register.offset as u64) & ((1u64 << bits) - 1);
                    let value = if signed {
                        ((low << (64 - bits)) as i64) >> (64 - bits)
                    } else {
                        low as i64
                    };
                    RegisterValue::new_imm(value)
                }
                RegisterKind::RegisterBase => {
                    let whole = register.expression();
                    if !signed && bits == 32 && register.offset == 0 && is_narrowed(&whole) {
                        register
                    } else {
                        RegisterValue {
                            kind: RegisterKind::RegisterBase,
                            base: Some(generate_expression(
                                if signed { "sext" } else { "zext" },
                                whole,
                                AbstractExpression::Immediate(bits as i64),
                            )),
                            offset: 0,
                        }
                    }
                }
                RegisterKind::Number => register,
            };
            if shift == 0 {
                extended
            } else {
                shift_imm("lsl".to_string(), extended, shift)
            }
        }
        _ => todo!("unsupported extend or shift operator {op}"),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn logical_shift_of_a_negative_constant_fills_with_zeros() {
        let shifted = shift_imm("lsr".to_string(), RegisterValue::new_imm(-1), 60);
        assert_eq!(shifted.offset, 15);
        assert_eq!(shifted.base, None);
    }

    #[test]
    fn arithmetic_shift_of_a_negative_constant_keeps_the_sign() {
        let shifted = shift_imm("asr".to_string(), RegisterValue::new_imm(-16), 2);
        assert_eq!(shifted.offset, -4);
    }

    #[test]
    fn right_shift_applies_to_base_and_offset_together() {
        let mut value = RegisterValue::new_empty("n");
        value.offset = 7;
        let whole = value.expression();
        let shifted = shift_imm("lsr".to_string(), value, 3);
        assert_eq!(shifted.offset, 0);
        assert_eq!(
            shifted.base,
            Some(generate_expression(
                "lsr",
                whole,
                AbstractExpression::Immediate(3)
            ))
        );
    }
}
