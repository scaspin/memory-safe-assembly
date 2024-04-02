use std::collections::HashMap;
use std::io::{Error, ErrorKind};
use z3::ast::Ast;
use z3::*;

use crate::common;
use crate::computer;

#[derive(Clone)]
struct Program {
    // defs: Vec<String>,
    code: Vec<common::Instruction>,
    labels: Vec<(String, usize)>,
    // ifdefs: Vec<((String, usize), usize)>,
}

#[derive(Clone)]
pub struct ExecutionEngine<'ctx> {
    program: Program,
    computer: computer::ARMCORTEXA<'ctx>,
    abstracts: HashMap<String, String>,
    in_loop: bool,
    jump_history: Vec<(
        usize,
        bool,
        common::AbstractComparison,
        Vec<common::MemoryAccess>,
    )>,
    fail_fast: bool,
}

impl<'ctx> ExecutionEngine<'ctx> {
    pub fn new(lines: Vec<String>, context: &'ctx Context) -> ExecutionEngine<'ctx> {
        // represent code this way, highly unoptimized
        let mut defs: Vec<String> = Vec::new();
        let mut code: Vec<common::Instruction> = Vec::new();
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

                if text.contains(":") {
                    let label = text.strip_suffix(":").unwrap();
                    labels.push((label.to_string(), line_number));
                    // if text == start {
                    //     pc = line_number;
                    // }
                    code.push(common::Instruction::new(text))
                } else {
                    let parsed = text.parse::<common::Instruction>();
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

        let mut computer = computer::ARMCORTEXA::new(context);

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

    pub fn add_region(&mut self, region: common::MemorySafeRegion) {
        // FIX make better so don't have to convert to string
        match region.end.clone() {
            common::AbstractExpression::Immediate(i) => self.add_region_from(
                region.region_type,
                region.base.to_string(),
                (Some(i.try_into().unwrap()), None, None),
            ),
            common::AbstractExpression::Expression(..) => self.add_region_from(
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
        ty: common::RegionType,
        base: String,
        length: (
            Option<usize>,
            Option<String>,
            Option<common::AbstractExpression>,
        ),
    ) {
        match length {
            (Some(num), None, None) => {
                // FIX: decide whether to include alignment or not
                let region_size = ((num.clone() as i64) - 1) * self.computer.alignment;

                self.computer.set_region(common::MemorySafeRegion {
                    region_type: ty,
                    base: base.clone(),
                    start: common::AbstractExpression::Immediate(0),
                    end: common::AbstractExpression::Immediate(region_size.clone()),
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

                // upper bound is the base pointer + bound value - alignment
                let upper_bound = ast::Int::add(
                    self.computer.context,
                    &[&abstract_pointer_from_base, &bound_aligned],
                );

                self.computer.set_region(common::MemorySafeRegion {
                    region_type: ty,
                    base: base.clone(),
                    start: common::AbstractExpression::Immediate(0),
                    end: common::AbstractExpression::Expression(
                        "-".to_string(),
                        Box::new(common::AbstractExpression::Abstract(abs)),
                        Box::new(common::AbstractExpression::Immediate(
                            self.computer.alignment,
                        )),
                    ),
                });

                let pointer =
                    ast::Int::new_const(self.computer.context, "pointer_".to_owned() + &base);

                // can access this region starting with 0
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
                let bound = common::expression_to_ast(self.computer.context, expr.clone()).unwrap();
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

                self.computer.set_region(common::MemorySafeRegion {
                    region_type: ty,
                    base: base.clone(),
                    start: common::AbstractExpression::Immediate(0),
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

    pub fn add_abstract(&mut self, register: String, value: common::AbstractExpression) {
        self.computer.set_abstract(register, value);
    }

    pub fn add_abstract_from(&mut self, register: usize, value: String) {
        let name = ("x".to_owned() + &register.to_string()).to_string();
        self.computer
            .set_abstract(name.clone(), common::AbstractExpression::Abstract(value));
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

    fn add_constraint(&self, constraint: common::AbstractComparison, decision: bool) {
        let c = common::comparison_to_ast(self.computer.context, constraint)
            .unwrap()
            .simplify();
        if decision {
            self.computer.solver.assert(&c);
        } else {
            self.computer.solver.assert(&c.not());
        }
    }

    // if true, we jump
    // if false, we continue
    // if None, we explore both paths
    fn evaluate_branch_condition(
        &mut self,
        pc: usize,
        expression: common::AbstractComparison,
        rw_list: Vec<common::MemoryAccess>,
    ) -> Option<bool> {
        log::info!("jump condition: {}", expression.clone());
        log::info!("memory accesses: {:?}", rw_list.clone());

        if !self.in_loop {
            if let Some((last_jump_label, branch_decision, _, last_rw_list)) =
                self.jump_history.last()
            {
                // LOOP has repeated at least twice
                if last_jump_label == &pc && last_rw_list.len() == rw_list.len() {
                    let mut max_step = 0;
                    for i in 0..last_rw_list.len() {
                        let diff = rw_list[i].offset - last_rw_list[i].offset;
                        if diff > max_step {
                            max_step = diff;
                        };
                    }

                    self.computer.solver.push();
                    let step = ast::Int::from_i64(self.computer.context, max_step as i64);
                    let zero = ast::Int::from_i64(self.computer.context, 0);

                    // TODO: make sure ? is greater than current counter
                    // get the minimal abstracts we depend on
                    let simplified =
                        common::comparison_to_ast(self.computer.context, expression.clone())
                            .unwrap()
                            .simplify();

                    for a in self.abstracts.keys() {
                        if simplified.to_string().contains(a) {
                            let new_abstract_name =
                                self.abstracts.get(&a.to_string()).unwrap().to_string();

                            for r in expression.get_register_names() {
                                self.computer.track_register(r, new_abstract_name.clone());
                            }

                            let q = ast::Int::new_const(self.computer.context, new_abstract_name);
                            let original_abstract =
                                ast::Int::new_const(self.computer.context, a.to_string());

                            // TODO: do we want to define this since it implies an upper bound on ? or is that not sound?
                            // do the equalities need to change for a different type of condition
                            let steps = ast::Int::mul(self.computer.context, &[&q, &step]);
                            self.computer.solver.assert(&steps.ge(&original_abstract));
                            self.computer.solver.assert(&steps.le(&original_abstract));

                            self.computer.solver.assert(&q.ge(&zero));
                            self.computer.solver.assert(&q.modulo(&step).ge(&zero));
                            self.computer.solver.assert(&q.modulo(&step).le(&zero));

                            self.in_loop = true;
                            return Some(*branch_decision);
                        }
                    }
                }
                return None;
            } else {
                return None;
            }
        } else {
            // TODO: maybe add shortcut out when there are no memory accesses in the loop?
            if let Some((last_jump_label, branch_decision, last_jump_exp, last_rw_list)) =
                self.jump_history.last()
            {
                if last_jump_label == &pc
                    && last_jump_exp == &expression
                    && last_rw_list == &rw_list
                {
                    self.computer.solver.pop(1);
                    let condition =
                        common::comparison_to_ast(self.computer.context, expression.clone())
                            .unwrap();
                    self.computer.solver.assert(&condition.simplify());
                    match self.computer.solver.check() {
                        SatResult::Sat => {
                            log::info!(
                                "satisfiable with model: {:?}",
                                self.computer.solver.get_model().unwrap()
                            );
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
                }

                // unwind loop to run next one
                if expression.contains("?") {
                    let mut old_abstract_name = "?".to_string();
                    for a in expression.get_abstracts() {
                        if a.contains("?") {
                            old_abstract_name = a;
                        }
                    }
                    if !(old_abstract_name == "?") {
                        for r in expression.get_register_names() {
                            self.computer
                                .track_register(r, old_abstract_name.to_string());
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
