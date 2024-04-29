use std::collections::HashMap;
use std::io::{Error, ErrorKind};
use z3::ast::Ast;
use z3::*;

use crate::common::*;
use crate::computer::*;

#[derive(Clone)]
struct Program {
    // defs: Vec<String>,
    code: Vec<Instruction>,
    labels: Vec<(String, usize)>,
    // ifdefs: Vec<((String, usize), usize)>,
}

#[derive(Clone)]
pub struct ExecutionEngine<'ctx> {
    program: Program,
    computer: ARMCORTEXA<'ctx>,
    abstracts: HashMap<String, String>,
    in_loop: bool,
    jump_history: Vec<(
        usize,
        bool,
        AbstractComparison,
        Vec<MemoryAccess>,
        (
            [RegisterValue; 33],
            Option<FlagValue>,
            Option<FlagValue>,
            Option<FlagValue>,
            Option<FlagValue>,
        ),
    )>,
    fail_fast: bool,
}

impl<'ctx> ExecutionEngine<'ctx> {
    pub fn new(lines: Vec<String>, context: &'ctx Context) -> ExecutionEngine<'ctx> {
        // represent code this way, highly unoptimized
        let mut defs: Vec<String> = Vec::new();
        let mut code: Vec<Instruction> = Vec::new();
        let mut labels: Vec<(String, usize)> = Vec::new();
        let mut ifdefs: Vec<((String, usize), usize)> = Vec::new();

        // grab lines into array
        let mut line_number = 0;
        let mut inifdef = false;
        let mut lastifdef: (String, usize) = ("Start".to_string(), 0);

        // first pass, move text into array
        for line in lines {
            let trimmed = line.trim();
            let nocomment = trimmed.split_once("//");
            let text: String;
            match nocomment {
                Some(strings) => text = strings.0.to_string(),
                None => text = trimmed.to_string(),
            }

            if text.is_empty() {
                continue;
            } else if text.starts_with('.') {
                defs.push(text);
            } else {
                // check if ifdef but keep them in the code
                if text.starts_with('#') {
                    if inifdef {
                        ifdefs.push((lastifdef.clone(), line_number));
                        inifdef = false;
                    } else {
                        inifdef = true;
                        lastifdef = (text.clone(), line_number);
                    }
                }

                // code.push(text.clone());

                if text.contains(":") && !text.contains(".") {
                    let label = text.strip_suffix(":").unwrap();
                    labels.push((label.to_string(), line_number));
                    // if text == start {
                    //     pc = line_number;
                    // }
                    code.push(Instruction::new(text))
                } else {
                    let parsed = text.parse::<Instruction>();
                    match parsed {
                        Ok(i) => code.push(i),
                        Err(_) => todo!(),
                    }
                }

                line_number = line_number + 1;

                //if text.contains(':') || text.contains("_") || text.contains("@") {
                // handle these later
                //    continue;
                //}
            }
        }

        let mut computer = ARMCORTEXA::new(context);

        // load computer static memory
        let mut address = 4;
        for def in defs.iter() {
            let v: Vec<&str> = def.split(|c| c == '\t' || c == ',').collect();
            if v[0] == ".align" {
                //alignment = v[1].parse::<usize>().unwrap();
                // do nothing for now
            } else if v[0] == ".byte" || v[0] == ".long" {
                for i in v.iter().skip(1) {
                    let num: i64;
                    if i.contains("x") {
                        num = i64::from_str_radix(i.strip_prefix("0x").unwrap(), 16).unwrap();
                    } else {
                        if i.is_empty() {
                            continue;
                        }
                        num = i.parse::<i64>().unwrap();
                    }
                    computer.add_memory(address, num);
                    // address = address + (alignment as i64);
                    // heap grows down
                    address = address + 4;
                }
            }
        }

        return ExecutionEngine {
            program: Program {
                // defs,
                code,
                labels,
                // ifdefs,
            },
            computer,
            jump_history: Vec::new(),
            in_loop: false,
            abstracts: HashMap::new(),
            fail_fast: true,
        };
    }

    pub fn add_region(&mut self, region: MemorySafeRegion) {
        // FIX make better so don't have to convert to string
        match region.end.clone() {
            AbstractExpression::Immediate(i) => self.add_region_from(
                region.region_type,
                region.base.to_string(),
                (Some(i.try_into().unwrap()), None, None),
            ),
            AbstractExpression::Expression(..) => self.add_region_from(
                region.region_type,
                region.base.to_string(),
                (None, None, Some(region.end.clone())),
            ),
            _ => self.add_region_from(
                region.region_type,
                region.base.to_string(),
                (None, Some(region.end.to_string()), None),
            ),
        }
    }

    pub fn add_region_from(
        &mut self,
        ty: RegionType,
        base: String,
        length: (Option<usize>, Option<String>, Option<AbstractExpression>),
    ) {
        match length {
            (Some(num), None, None) => {
                // FIX: decide whether to include alignment or not
                let region_size = ((num.clone() as i64) - 1) * self.computer.alignment;

                self.computer.set_region(MemorySafeRegion {
                    region_type: ty,
                    base: base.clone(),
                    start: AbstractExpression::Immediate(0),
                    end: AbstractExpression::Immediate(region_size.clone()),
                });

                let zero = ast::Int::from_i64(self.computer.context, 0);
                // define bound of region with respect to the pointer
                let bound = ast::Int::from_i64(self.computer.context, region_size);
                let abs_base = ast::Int::new_const(self.computer.context, base.clone());
                let lower_bound = ast::Int::add(self.computer.context, &[&abs_base, &zero]);
                let upper_bound = ast::Int::add(self.computer.context, &[&abs_base, &bound]);

                let pointer =
                    ast::Int::new_const(self.computer.context, "pointer_".to_owned() + &base);

                // basics are positive
                self.computer.solver.assert(&lower_bound.ge(&zero));
                self.computer.solver.assert(&upper_bound.ge(&zero));
                self.computer.solver.assert(&abs_base.ge(&zero));

                // address is positive
                self.computer.solver.assert(&pointer.ge(&zero));
                // can access this region starting with 0
                self.computer.solver.assert(&pointer.ge(&lower_bound));
                // can access this region up to and including address of upper bound
                self.computer.solver.assert(&pointer.le(&upper_bound));
            }
            (None, Some(abs), None) => {
                self.abstracts
                    .insert(abs.clone(), ("?_".to_owned() + &abs.clone()).to_string());

                let zero = ast::Int::from_i64(self.computer.context, 0);
                let align = ast::Int::from_i64(self.computer.context, self.computer.alignment);
                let bound = ast::Int::new_const(self.computer.context, abs.clone());
                let bound_aligned = ast::Int::sub(self.computer.context, &[&bound, &align]);
                let abstract_pointer_from_base =
                    ast::Int::new_const(self.computer.context, base.clone());
                self.computer
                    .solver
                    .assert(&abstract_pointer_from_base.ge(&zero));

                // upper bound is the base pointer + bound value - alignment
                let upper_bound = ast::Int::add(
                    self.computer.context,
                    &[&abstract_pointer_from_base, &bound_aligned],
                );

                self.computer.set_region(MemorySafeRegion {
                    region_type: ty,
                    base: base.clone(),
                    start: AbstractExpression::Immediate(0),
                    end: AbstractExpression::Expression(
                        "-".to_string(),
                        Box::new(AbstractExpression::Abstract(abs)),
                        Box::new(AbstractExpression::Immediate(self.computer.alignment)),
                    ),
                });

                let pointer =
                    ast::Int::new_const(self.computer.context, "pointer_".to_owned() + &base);

                // can access this region starting with 0
                self.computer.solver.assert(&pointer.ge(&zero));
                self.computer.solver.assert(&bound.ge(&zero));
                self.computer
                    .solver
                    .assert(&abstract_pointer_from_base.ge(&zero));

                // can access this region up to and including address of upper bound
                self.computer.solver.assert(&pointer.le(&upper_bound));
            }
            (None, None, Some(expr)) => {
                let zero = ast::Int::from_i64(self.computer.context, 0);
                let align = ast::Int::from_i64(self.computer.context, self.computer.alignment);
                let bound = expression_to_ast(self.computer.context, expr.clone()).unwrap();
                let bound_aligned = ast::Int::sub(self.computer.context, &[&bound, &align]);
                let abstract_pointer_from_base =
                    ast::Int::new_const(self.computer.context, base.clone());
                for a in expr.get_abstracts() {
                    self.abstracts
                        .insert(a.clone(), ("?_".to_owned() + &a.clone()).to_string());
                    let temp = ast::Int::new_const(self.computer.context, a);
                    self.computer.solver.assert(&temp.ge(&zero));
                }

                // upper bound is the base pointer + bound value - alignment
                let upper_bound = ast::Int::add(
                    self.computer.context,
                    &[&abstract_pointer_from_base, &bound_aligned],
                );

                self.computer.set_region(MemorySafeRegion {
                    region_type: ty,
                    base: base.clone(),
                    start: AbstractExpression::Immediate(0),
                    end: expr,
                });

                let pointer =
                    ast::Int::new_const(self.computer.context, "pointer_".to_owned() + &base);

                // can access this region starting with 0
                self.computer
                    .solver
                    .assert(&abstract_pointer_from_base.ge(&zero));

                // can access this region up to and including address of upper bound
                self.computer.solver.assert(&pointer.le(&upper_bound));
            }
            (_, _, _) => (), // should never happen! just to be safe
        }
    }

    pub fn add_immediate(&mut self, register: String, value: usize) {
        self.computer.set_immediate(register, value as u64);
        // ast::Int::from_i64(self.computer.context, value as i64);
    }

    pub fn add_abstract(&mut self, register: String, value: AbstractExpression) {
        self.computer.set_abstract(register, value);
    }

    pub fn add_abstract_from(&mut self, register: usize, value: String) {
        let name = ("x".to_owned() + &register.to_string()).to_string();
        self.computer
            .set_abstract(name.clone(), AbstractExpression::Abstract(value));
    }

    pub fn dont_fail_fast(&mut self) {
        self.fail_fast = false;
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.computer.change_alignment(value);
    }

    pub fn start(&mut self, start: String) -> std::io::Result<()> {
        let pc;
        match self.get_linenumber_of_label(start) {
            Some(n) => pc = n,
            None => {
                return Err(Error::new(
                    ErrorKind::Other,
                    "Start label not found in program",
                ))
            }
        }

        // run is recursive
        let res = self.run(pc);
        match res {
            Ok(_) => (),
            Err(err) => return Err(Error::new(ErrorKind::Other, err)),
        }

        Ok(())
    }

    fn run(&mut self, start_pc: usize) -> std::io::Result<()> {
        let mut pc = start_pc;
        let length = self.program.code.len();
        while pc < length {
            let mut instruction = self.program.code[pc].clone();

            // skip instruction if it is a label
            if instruction.op.contains(":") {
                pc = pc + 1;
                instruction = self.program.code[pc].clone();
            }

            log::info!("{:?}: {:?}", pc, instruction);

            let execute_result = self.computer.execute(&instruction);

            match execute_result {
                Ok(some) => {
                    match some {
                        None => {
                            pc = pc + 1;
                            continue;
                        }
                        Some(jump) => match jump {
                            // (condition, label to jump to, line number to jump to)
                            (Some(condition), Some(label), None) => {
                                let jump_dest;
                                let rw_list = self.computer.read_rw_queue();
                                match self.get_linenumber_of_label(label.clone()) {
                                    Some(i) => jump_dest = i,
                                    None => return Err(Error::new(ErrorKind::Other, "No label")),
                                }

                                if self.looping_too_deep() {
                                    return Err(Error::new(
                                        ErrorKind::Other,
                                        "could not resolve loop",
                                    ));
                                }

                                match self.evaluate_branch_condition(
                                    pc.clone(),
                                    condition.clone(),
                                    rw_list.clone(),
                                ) {
                                    None => {
                                        let mut clone = self.clone();
                                        self.jump_history.push((
                                            jump_dest,
                                            true,
                                            condition.clone(),
                                            rw_list.clone(),
                                            self.computer.get_state(),
                                        ));
                                        self.computer.clear_rw_queue();
                                        log::info!(
                                            "exploring jump branch starting line: {:?}",
                                            jump_dest
                                        );

                                        self.computer.solver.push();
                                        self.add_constraint(condition.clone(), true);
                                        let res1 = self.run(jump_dest);
                                        self.computer.solver.pop(1);

                                        clone.jump_history.push((
                                            pc,
                                            false,
                                            condition.clone(),
                                            rw_list,
                                            self.computer.get_state(),
                                        ));
                                        clone.computer.clear_rw_queue();
                                        log::info!(
                                            "exploring non-jump branch starting line: {:?}",
                                            pc + 1
                                        );

                                        self.computer.solver.push();
                                        clone.add_constraint(condition, false);
                                        let res2 = clone.run(pc + 1);
                                        self.computer.solver.pop(1);

                                        match (res1, res2) {
                                            (Ok(_), Ok(_)) => return Ok(()),
                                            (Err(err), Ok(_)) => {
                                                log::error!("{:?}: {:?}", pc, err);
                                                return Err(Error::new(ErrorKind::Other, err));
                                            }
                                            (Ok(_), Err(err)) => {
                                                log::error!("{:?}: {:?}", pc, err);
                                                return Err(Error::new(ErrorKind::Other, err));
                                            }
                                            (Err(e1), Err(e2)) => {
                                                return Err(Error::new(
                                                    ErrorKind::Other,
                                                    e1.to_string() + &e2.to_string(),
                                                ));
                                            }
                                        }
                                    }
                                    Some(true) => {
                                        let linenum = self.get_linenumber_of_label(label.clone());
                                        match linenum {
                                            Some(n) => {
                                                self.jump_history.push((
                                                    pc,
                                                    true,
                                                    condition.clone(),
                                                    self.computer.read_rw_queue(),
                                                    self.computer.get_state(),
                                                ));
                                                self.computer.clear_rw_queue();
                                                self.add_constraint(condition, true);
                                                pc = n;
                                            }
                                            None => {
                                                log::error!("No label line for label {}", label);
                                                return Err(Error::new(
                                                    ErrorKind::Other,
                                                    "No label",
                                                ));
                                            }
                                        }
                                    }
                                    Some(false) => {
                                        self.jump_history.push((
                                            pc,
                                            false,
                                            condition.clone(),
                                            self.computer.read_rw_queue(),
                                            self.computer.get_state(),
                                        ));
                                        self.computer.clear_rw_queue();
                                        log::info!("exploring line: {}", pc + 1);
                                        self.add_constraint(condition, false);
                                        pc = pc + 1;
                                    }
                                }
                            }
                            (Some(condition), None, Some(address)) => {
                                let jump_dest = address.try_into().unwrap();
                                let rw_list = self.computer.read_rw_queue();
                                match self.evaluate_branch_condition(
                                    pc.clone(),
                                    condition.clone(),
                                    rw_list.clone(),
                                ) {
                                    None => {
                                        let mut clone = self.clone();
                                        self.jump_history.push((
                                            jump_dest,
                                            true,
                                            condition.clone(),
                                            rw_list.clone(),
                                            self.computer.get_state(),
                                        ));
                                        self.computer.clear_rw_queue();
                                        log::info!(
                                            "exploring jump branch starting line: {:?}",
                                            jump_dest
                                        );

                                        self.computer.solver.push();
                                        self.add_constraint(condition.clone(), true);
                                        let res1 = self.run(jump_dest);
                                        self.computer.solver.pop(1);

                                        clone.jump_history.push((
                                            pc,
                                            false,
                                            condition.clone(),
                                            rw_list,
                                            self.computer.get_state(),
                                        ));
                                        clone.computer.clear_rw_queue();
                                        log::info!(
                                            "exploring non-jump branch starting line: {:?}",
                                            pc + 1
                                        );
                                        self.computer.solver.push();
                                        clone.add_constraint(condition, false);
                                        let res2 = clone.run(pc + 1);
                                        self.computer.solver.pop(1);

                                        match (res1, res2) {
                                            (Ok(_), Ok(_)) => return Ok(()),
                                            (Err(err), Ok(_)) => {
                                                log::error!("{:?}: {:?}", pc, err);
                                                return Err(Error::new(ErrorKind::Other, err));
                                            }
                                            (Ok(_), Err(err)) => {
                                                log::error!("{:?}: {:?}", pc, err);
                                                return Err(Error::new(ErrorKind::Other, err));
                                            }
                                            (Err(e1), Err(e2)) => {
                                                return Err(Error::new(
                                                    ErrorKind::Other,
                                                    e1.to_string() + &e2.to_string(),
                                                ));
                                            }
                                        }
                                    }
                                    Some(true) => {
                                        self.jump_history.push((
                                            pc,
                                            true,
                                            condition.clone(),
                                            self.computer.read_rw_queue(),
                                            self.computer.get_state(),
                                        ));
                                        self.computer.clear_rw_queue();
                                        self.add_constraint(condition, true);
                                        pc = jump_dest;
                                        continue;
                                    }
                                    Some(false) => {
                                        self.jump_history.push((
                                            pc,
                                            false,
                                            condition.clone(),
                                            self.computer.read_rw_queue(),
                                            self.computer.get_state(),
                                        ));
                                        self.computer.clear_rw_queue();
                                        log::info!("exploring line: {}", pc + 1);
                                        self.add_constraint(condition, false);
                                        pc = pc + 1;
                                        continue;
                                    }
                                }
                            }
                            (None, Some(label), None) => {
                                log::info!("returning: {}", pc);
                                if &label == "Return" {
                                    break;
                                }
                                let newline = self.get_linenumber_of_label(label.clone());
                                match newline {
                                    Some(n) => {
                                        log::info!("jumping to: {}", n);
                                        pc = n;
                                    }
                                    None => {
                                        log::error!("No label line for label {}", label);
                                        return Err(Error::new(ErrorKind::Other, "No label"));
                                    }
                                }
                            }
                            (None, None, Some(address)) => {
                                pc = address as usize;
                            }
                            (Some(_), None, None)
                            | (None, None, None)
                            | (None, Some(_), Some(_))
                            | (Some(_), Some(_), Some(_)) => {
                                log::error!(
                                    "Execute did not return valid response for jump or continue"
                                );
                                return Err(Error::new(
                                    ErrorKind::Other,
                                    "Execute did not return valid response for jump or continue",
                                ));
                            }
                        },
                    }
                }
                Err(err) => {
                    log::error!(
                        "At line {:?} instruction {:?} error {:?}",
                        pc,
                        instruction,
                        err
                    );
                    if self.fail_fast {
                        return Err(Error::new(ErrorKind::Other, err));
                    }
                    pc = pc + 1;
                }
            }
        }
        Ok(self.computer.check_stack_pointer_restored())
    }

    fn get_linenumber_of_label(&self, label: String) -> Option<usize> {
        for l in self.program.labels.iter() {
            if l.0.contains(&label.clone()) && label.contains(&l.0.clone()) {
                return Some(l.1);
            }
        }
        None
    }

    fn add_constraint(&self, constraint: AbstractComparison, decision: bool) {
        let c = comparison_to_ast(self.computer.context, constraint)
            .unwrap()
            .simplify();

        println!("c: {:?}", c.clone());
        if decision {
            self.computer.solver.assert(&c);
        } else {
            self.computer.solver.assert(&c.not());
        }
    }

    fn looping_too_deep(&self) -> bool {
        // jump out if too deep in tree

        if self.jump_history.len() > 10 {
            let mut loop_count = 0;
            let pc = self.jump_history.last().unwrap().0;
            for h in self.jump_history.clone() {
                let (last_jump, _, _, _, _) = h;

                if last_jump == pc {
                    loop_count = loop_count + 1;
                }
            }
            if loop_count > 7 {
                return true;
            }
        }
        return false;
    }

    // if true, we jump
    // if false, we continue
    // if None, we explore both paths
    fn evaluate_branch_condition(
        &mut self,
        pc: usize,
        expression: AbstractComparison,
        rw_list: Vec<MemoryAccess>,
    ) -> Option<bool> {
        log::info!("jump condition: {}", expression.clone());
        log::info!("memory accesses: {:?}", rw_list.clone());

        if !self.in_loop {
            if let Some((last_jump_label, branch_decision, _, last_rw_list, last_state)) =
                self.jump_history.last()
            {
                let current_state = self.computer.get_state();
                // LOOP has repeated at least twice
                if last_jump_label == &pc && last_rw_list.len() == rw_list.len() {
                    // JUMP TO Kth ITERATION

                    self.computer.solver.push();
                    let loop_var_name = (pc.to_string()) + "_loop_?";
                    let zero = ast::Int::from_i64(self.computer.context, 0);
                    let q = ast::Int::new_const(self.computer.context, loop_var_name.clone());
                    self.computer.solver.assert(&q.ge(&zero));

                    // find the variable that the loop estimates
                    let simplified = comparison_to_ast(self.computer.context, expression.clone())
                        .unwrap()
                        .simplify();
                    for a in self.abstracts.keys() {
                        if simplified.to_string().contains(a) {
                            let original_abstract =
                                ast::Int::new_const(self.computer.context, a.to_string());
                            self.computer.solver.assert(&q.ge(&original_abstract));
                            self.computer.solver.assert(&q.le(&original_abstract));
                        }
                    }

                    for i in 0..(last_state.0.len()) {
                        let last = &last_state.0[i];
                        let cur = &current_state.0[i];
                        let diff: i64 = match cur.kind {
                            RegisterKind::RegisterBase
                            | RegisterKind::Abstract
                            | RegisterKind::Address => {
                                if last.base == cur.base {
                                    cur.offset - last.offset
                                } else {
                                    0
                                }
                            }
                            RegisterKind::Immediate => cur.offset - last.offset,
                            _ => 0,
                        };

                        if diff > 0 {
                            let new_base = AbstractExpression::Expression(
                                "+".to_string(),
                                Box::new(cur.base.clone()?),
                                Box::new(AbstractExpression::Expression(
                                    "*".to_string(),
                                    Box::new(AbstractExpression::Abstract(loop_var_name.clone())),
                                    Box::new(AbstractExpression::Immediate(diff)),
                                )),
                            );

                            let new_reg = RegisterValue {
                                name: cur.name.clone(),
                                kind: cur.kind.clone(),
                                base: Some(new_base),
                                offset: 0,
                            };

                            self.computer.registers[i] = new_reg;
                        }
                    }

                    self.in_loop = true;
                    return Some(*branch_decision);
                } else {
                    return None;
                }
            } else {
                return None;
            }
        // in loop protocol
        } else {
            // K+1 loop is a repeat of K loop!
            if let Some((
                last_jump_label,
                branch_decision,
                last_jump_exp,
                last_rw_list,
                last_state,
            )) = self.jump_history.last()
            {
                if last_jump_label == &pc
                    && last_jump_exp == &expression
                    && last_rw_list == &rw_list
                // && last_state == &self.computer.get_state()
                {
                    self.computer.solver.pop(1);
                    let condition =
                        comparison_to_ast(self.computer.context, expression.clone()).unwrap();
                    self.computer.solver.assert(&condition.simplify());
                    match self.computer.solver.check() {
                        SatResult::Sat => {
                            log::info!(
                                "satisfiable with model: {:?}",
                                self.computer.solver.get_model().unwrap()
                            );
                            self.in_loop = false;
                            return Some(!branch_decision);
                        }
                        SatResult::Unsat => {
                            log::info!(
                                "unsatisfiable with unsat core: {:?}",
                                self.computer.solver.get_unsat_core()
                            );
                        }
                        z3::SatResult::Unknown => log::info!(
                            "unknown with reason: {:?}",
                            self.computer.solver.get_reason_unknown()
                        ),
                    }
                } else {
                    // JUMP after Kth STEP -- need to check loop advanced ok for first iteration
                    let last_state = last_state;
                    let current_state = self.computer.get_state();
                    let loop_var_name = (pc.to_string()) + "_loop_?";
                    for i in 0..(last_state.0.len()) {
                        let last = &last_state.0[i];
                        let cur = &current_state.0[i];
                        let diff: i64 = match cur.kind {
                            RegisterKind::RegisterBase
                            | RegisterKind::Abstract
                            | RegisterKind::Address => {
                                if last.base == cur.base {
                                    cur.offset - last.offset
                                } else {
                                    0
                                }
                            }
                            RegisterKind::Immediate => cur.offset - last.offset,
                            _ => 0,
                        };

                        // check diff matches, if not BAD
                        // if does, reset for k+1
                        let base_step = AbstractExpression::Expression(
                            "*".to_string(),
                            Box::new(AbstractExpression::Abstract(loop_var_name.clone())),
                            Box::new(AbstractExpression::Immediate(diff)),
                        );
                        if let Some(base) = &cur.base {
                            if base.contains(&loop_var_name) && base.contains_expression(&base_step)
                            {
                                let new_reg = RegisterValue {
                                    name: cur.name.clone(),
                                    kind: cur.kind.clone(),
                                    base: cur.base.clone(),
                                    offset: 0,
                                };
                                self.computer.registers[i] = new_reg;
                            }
                        }
                    }
                }
                return Some(*branch_decision);
            } else {
                return None;
            }
        }
    }
}
