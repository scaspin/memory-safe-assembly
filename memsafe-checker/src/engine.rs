// use std::collections::HashMap;
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
    // abstracts: HashMap<String, String>,
    in_loop: bool,
    jump_history: Vec<(
        usize,              // pc
        bool,               // jump decision (true = took, false = continue)
        AbstractComparison, // comparison used
        Vec<MemoryAccess>,
        (
            // relevent state
            [RegisterValue; 33],
            // [SimdRegister; 32],
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
        // let _ = env_logger::try_init();
        // log::info!("--------");
        // log::info!("NEW EXEC");
        // log::info!("-------");

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
            } else if text.starts_with("# ") {
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

                if text.ends_with(":") && !text.contains(".") {
                    let mut label = text.strip_suffix(":").expect("engine1");
                    label = label.strip_prefix("_").unwrap_or(label);
                    labels.push((label.to_string(), line_number));
                    defs.push(text.to_string());
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
            let v: Vec<&str> = def.split(|c| c == '\t' || c == ',' || c == ' ').collect();
            if v[0] == ".align" {
                //let alignment = v[1].parse::<usize>().expect("engine");
                // do nothing for now
            } else if v[0] == ".byte" {
                for i in v.iter().skip(1) {
                    let num: i64;
                    if i.contains("x") {
                        num = u64::from_str_radix(i.strip_prefix("0x").expect("engine2"), 16)
                            .expect("engine3") as i64;
                    } else {
                        if i.is_empty() {
                            continue;
                        }
                        num = i.parse::<i64>().expect("engine4");
                    }
                    computer.add_memory_value("memory".to_string(), address, num);
                    // address = address + (alignment as i64);
                    // heap grows down
                    address = address + 4;
                }
            } else if v[0] == ".quad" || v[0] == ".long" {
                for i in v.iter().skip(1) {
                    let num: i64;
                    if i.contains("x") {
                        num = u64::from_str_radix(i.strip_prefix("0x").expect("engine2"), 16)
                            .expect("engine3") as i64;
                    } else {
                        if i.is_empty() {
                            continue;
                        }
                        num = i.parse::<i64>().expect("engine4");
                    }
                    computer.add_memory_value("memory".to_string(), address, num);
                    address = address + 8;
                }
            } else if v[0] == ".globl" || v[0] == ".private_extern" {
                computer.memory_labels.insert(v[1].to_string(), address);
            } else if def.contains(":") {
                computer
                    .memory_labels
                    .insert(def.strip_suffix(":").unwrap_or(def).to_string(), address);
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
            // abstracts: HashMap::new(),
            fail_fast: true,
        };
    }

    pub fn add_region(&mut self, ty: RegionType, base: String, length: AbstractExpression) {
        let zero = ast::Int::from_i64(self.computer.context, 0);
        for a in length.get_abstracts() {
            let temp = ast::Int::new_const(self.computer.context, a);
            self.computer.solver.assert(&temp.ge(&zero));
        }

        self.computer.add_memory_region(base.clone(), ty, length);
    }

    pub fn add_immediate(&mut self, register: String, value: usize) {
        self.computer.set_immediate(register, value as u64);
    }

    pub fn add_abstract(&mut self, register: String, value: AbstractExpression) {
        self.computer.set_abstract(register, value);
    }

    pub fn add_abstract_to_memory(
        &mut self,
        region: String,
        address: i64,
        value: AbstractExpression,
    ) {
        self.computer
            .add_memory_value_abstract(region, address, value);
    }

    pub fn add_abstract_expression_from(&mut self, register: usize, value: AbstractExpression) {
        if register < 8 {
            let name = ("x".to_owned() + &register.to_string()).to_string();
            self.computer.set_abstract(name.clone(), value);
        } else {
            let stack_index = ((register as i64) - 3) * -8;
            self.computer.set_stack_element(stack_index, Some(value), 0);
        }
    }

    pub fn add_abstract_from(&mut self, register: usize, value: String) {
        if register < 8 {
            let name = ("x".to_owned() + &register.to_string()).to_string();
            self.computer
                .set_abstract(name.clone(), AbstractExpression::Abstract(value));
        } else {
            let stack_index = ((register as i64) - 3) * -8;
            self.computer.set_stack_element(
                stack_index,
                Some(AbstractExpression::Abstract(value)),
                0,
            );
        }
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

            let execute_result = self.computer.execute(pc, &instruction);

            match execute_result {
                Ok(res) => match res {
                    ExecuteReturnType::Next => {
                        pc = pc + 1;

                        continue;
                    }
                    ExecuteReturnType::JumpLabel(label) => {
                        log::info!("jumping to: {}", pc);
                        if &label == "return" {
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
                                return Err(Error::new(ErrorKind::Other, "No label 1"));
                            }
                        }
                    }
                    ExecuteReturnType::JumpAddress(address) => {
                        pc = address as usize;
                    }
                    ExecuteReturnType::ConditionalJumpLabel(condition, label) => {
                        if self.looping_too_deep() {
                            return Err(Error::new(ErrorKind::Other, "could not resolve loop"));
                        }
                        let jump_dest;
                        let rw_list = self.computer.read_rw_queue();
                        match self.get_linenumber_of_label(label.clone()) {
                            Some(i) => jump_dest = i,
                            None => {
                                if label.contains("+") {
                                    let mut parts = label.split("+");
                                    let l = parts.next().expect("Need base label for jump targer");
                                    let offset =
                                        parts.next().expect("Need offset for jump target with +");

                                    match self.get_linenumber_of_label(l.to_string()) {
                                        Some(i) => {
                                            let parsed_offset = usize::from_str_radix(
                                                offset.trim_start_matches("0x"),
                                                16,
                                            )
                                            .expect("unable to parse label offset");
                                            jump_dest = i + (parsed_offset / 4);
                                        }
                                        None => {
                                            return Err(Error::new(
                                                ErrorKind::Other,
                                                format!("No label found: {:?}", l),
                                            ))
                                        }
                                    }
                                } else {
                                    return Err(Error::new(
                                        ErrorKind::Other,
                                        format!("No label found: {:?}", label),
                                    ));
                                }
                            }
                        }

                        match self.evaluate_branch_condition(
                            pc.clone(),
                            condition.clone(),
                            rw_list.clone(),
                        ) {
                            None => {
                                let clone = &mut self.clone();
                                self.jump_history.push((
                                    pc,
                                    true,
                                    condition.clone(),
                                    rw_list.clone(),
                                    self.computer.get_state(),
                                ));
                                self.computer.clear_rw_queue();
                                log::info!("exploring jump branch starting line: {:?}", jump_dest);

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
                                log::info!("exploring non-jump branch starting line: {:?}", pc + 1);

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
                                        if label.contains("+") {
                                            let mut parts = label.split("+");
                                            let l = parts
                                                .next()
                                                .expect("Need base label for jump targer");
                                            let offset = parts
                                                .next()
                                                .expect("Need offset for jump target with +");

                                            match self.get_linenumber_of_label(l.to_string()) {
                                                Some(i) => {
                                                    let parsed_offset = usize::from_str_radix(
                                                        offset.trim_start_matches("0x"),
                                                        16,
                                                    )
                                                    .expect("unable to parse label offset");
                                                    self.computer.clear_rw_queue();
                                                    self.add_constraint(condition, true);
                                                    pc = i + (parsed_offset / 4);
                                                }
                                                None => {
                                                    return Err(Error::new(
                                                        ErrorKind::Other,
                                                        format!("No label found: {:?}", l),
                                                    ))
                                                }
                                            }
                                        } else {
                                            log::error!("No label line for label {}", label);
                                            return Err(Error::new(
                                                ErrorKind::Other,
                                                format!("No label 2 {:?}", label),
                                            ));
                                        }
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
                    ExecuteReturnType::ConditionalJumpAddress(condition, address) => {
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
                                    pc,
                                    true,
                                    condition.clone(),
                                    rw_list.clone(),
                                    self.computer.get_state(),
                                ));
                                self.computer.clear_rw_queue();
                                log::info!("exploring jump branch starting line: {:?}", jump_dest);

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
                                log::info!("exploring non-jump branch starting line: {:?}", pc + 1);
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
                    ExecuteReturnType::Select(condition, register, option1, option2) => {
                        match (
                        self.computer.solver.check_assumptions(&[comparison_to_ast(
                            self.computer.context,
                            condition.clone(),
                        )
                        .expect(
                            "need result of conversion of comparison to ast for evaluation at jump 0",
                        )]),
                        self.computer.solver.check_assumptions(&[comparison_to_ast(
                            self.computer.context,
                            condition.clone().not(),
                        )
                        .expect(
                            "need result of conversion of comparison to ast for evaluation at jump 0",
                        )]),
                    ) {
                        (SatResult::Sat, SatResult::Unsat) => {
                            self.add_constraint(condition.clone(), true);
                            self.computer.set_register(
                                register.clone(),
                                option1.kind,
                                option1.base,
                                option1.offset,
                            );
                            pc = pc+1;
                        }
                        (SatResult::Unsat, SatResult::Sat) => {
                            self.add_constraint(condition.clone(), false);
                            self.computer.set_register(
                                register.clone(),
                                option2.kind,
                                option2.base,
                                option2.offset,
                            );
                            pc = pc+1;
                        }
                        _ => {
                            let clone = &mut self.clone();

                            self.add_constraint(condition.clone(), true);
                            self.computer.set_register(
                                register.clone(),
                                option1.kind,
                                option1.base,
                                option1.offset,
                            );
                            let res1 = self.run(pc + 1);

                            clone.add_constraint(condition, false);
                            self.computer.set_register(
                                register,
                                option2.kind,
                                option2.base,
                                option2.offset,
                            );
                            let res2 = clone.run(pc + 1);
                            match (res1, res2) {
                                (Ok(_), Ok(_)) => return Ok(()),
                                (Err(err), Ok(_)) | (Ok(_), Err(err)) => {
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
                    }
                    }
                },
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
        let label = label.strip_prefix("_").unwrap_or(&label);
        for l in self.program.labels.iter() {
            if l.0.contains(&label) && label.contains(&l.0.clone()) {
                return Some(l.1);
            }
        }
        None
    }

    fn add_constraint(&self, constraint: AbstractComparison, decision: bool) {
        let c = comparison_to_ast(self.computer.context, constraint)
            .expect("engine6")
            .simplify();
        if decision {
            self.computer.solver.assert(&c);
        } else {
            self.computer.solver.assert(&c.not());
        }
    }

    pub fn add_invariant(&self, constraint: AbstractComparison) {
        let c = comparison_to_ast(self.computer.context, constraint)
            .expect("engine6.5")
            .simplify();
        self.computer.solver.assert(&c);
    }

    fn looping_too_deep(&self) -> bool {
        // jump out if too deep in tree

        if self.jump_history.len() > 30 {
            let mut loop_count = 0;
            let pc = self.jump_history.last().expect("engine7").0;
            for h in self.jump_history.clone() {
                let (last_jump, _, _, _, _) = h;

                if last_jump == pc {
                    loop_count = loop_count + 1;
                }
            }
            if loop_count > 20 {
                log::error!(
                    // FIX: infinite loops not technically an error, just need to handle them better
                    "stuck in an infinite loop: {:?}",
                    self.jump_history
                        .clone()
                        .into_iter()
                        .map(|(c, _, _, _, _)| -> usize { c })
                        .collect::<Vec<usize>>()
                );
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

        // check whether both branches are valid, only take valid branch
        match (
            self.computer.solver.check_assumptions(&[comparison_to_ast(
                self.computer.context,
                expression.clone(),
            )
            .expect("need result of conversion of comparison to ast for evaluation at jump 0")]),
            self.computer.solver.check_assumptions(&[comparison_to_ast(
                self.computer.context,
                expression.clone().not(),
            )
            .expect("need result of conversion of comparison to ast for evaluation at jump 1")]),
        ) {
            (SatResult::Sat, SatResult::Unsat) => return Some(true),
            (SatResult::Sat, SatResult::Sat) => (), // normal! explore both!
            (SatResult::Unsat, _) => return Some(false),
            (_, _) => todo!(), // not sure how this would happen!
        }

        //check if loop can be resolved without loop protocol
        // i.e. there are explicit lower and upper bounds
        let mut is_abstract = false;
        for a in expression.get_abstracts() {
            if a.contains("len") || a.contains("loop") {
                is_abstract = true;
            }
        }

        if !is_abstract {
            return None;
        }

        if !self.in_loop {
            for j in self.jump_history.clone().into_iter().rev() {
                let (last_jump_label, branch_decision, _, last_rw_list, last_state) = j;
                if last_jump_label == pc && last_rw_list.len() == rw_list.len() {
                    // JUMP TO Kth ITERATION
                    let one = ast::Int::from_i64(self.computer.context, 1);
                    let two = ast::Int::from_i64(self.computer.context, 2);

                    self.computer.solver.push();
                    let loop_var_name = (pc.to_string()) + "_loop_?";
                    let q = ast::Int::new_const(self.computer.context, loop_var_name.clone());
                    self.computer.solver.assert(&q.gt(&two));

                    // find the variable that the loop estimates
                    let simplified = comparison_to_ast(self.computer.context, expression.clone())
                        .expect("engine8")
                        .simplify();

                    let some_multiple = ast::Int::new_const(
                        self.computer.context,
                        ("multiple_".to_owned() + &pc.to_string()).to_string(),
                    );
                    self.computer.solver.assert(&some_multiple.gt(&one));

                    for a in expression.get_abstracts() {
                        if simplified.to_string().contains(&a) {
                            let original_abstract =
                                ast::Int::new_const(self.computer.context, a.to_string());

                            let kplus = ast::Int::add(self.computer.context, &[&q, &one]);
                            let relation =
                                ast::Int::mul(self.computer.context, &[&kplus, &some_multiple]);
                            self.computer
                                .solver
                                .assert(&original_abstract.ge(&relation));
                            self.computer
                                .solver
                                .assert(&original_abstract.le(&relation));
                        }
                    }

                    let mut max_diff = 0;
                    let current_state = self.computer.get_state();
                    for i in 0..(last_state.0.len()) {
                        let last = &last_state.0[i];
                        let cur = &current_state.0[i];
                        let diff: i64 = match cur.kind {
                            RegisterKind::RegisterBase | RegisterKind::Number => {
                                if last.base == cur.base {
                                    cur.offset - last.offset
                                } else {
                                    0
                                }
                            }
                            RegisterKind::Immediate => cur.offset - last.offset,
                        };

                        if diff != 0 {
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
                                kind: cur.kind.clone(),
                                base: Some(new_base),
                                offset: 0,
                            };

                            self.computer.registers[i] = new_reg;

                            if diff > max_diff {
                                max_diff = diff;
                            }
                        }
                    }

                    let diff = ast::Int::from_i64(self.computer.context, max_diff);
                    self.computer.solver.assert(&some_multiple.ge(&diff));
                    self.computer.solver.assert(&some_multiple.le(&diff));

                    // for i in 0..(last_state.1.len()) {
                    //     let last = &last_state.1[i];
                    //     let cur = &current_state.1[i];
                    //     let diff: [u8; 16] = match cur.kind {
                    //         RegisterKind::RegisterBase | RegisterKind::Number => {
                    //             if last.base == cur.base {
                    //                 (0..16)
                    //                     .map(|i| cur.offset[i] - last.offset[i])
                    //                     .collect::<Vec<_>>()
                    //                     .try_into()
                    //                     .expect("engine9")
                    //             } else {
                    //                 [0; 16]
                    //             }
                    //         }
                    //         RegisterKind::Immediate => (0..16)
                    //             .map(|i| cur.offset[i] - last.offset[i])
                    //             .collect::<Vec<_>>()
                    //             .try_into()
                    //             .expect("enginea"),
                    //     };

                    //     let mut new_reg = SimdRegister {
                    //         kind: cur.kind.clone(),
                    //         base: cur.base.clone(),
                    //         offset: cur.offset,
                    //     };

                    //     for j in 0..16 {
                    //         let d = diff[j];
                    //         if d > 0 {
                    //             let new_base = generate_expression_from_options(
                    //                 "+",
                    //                 cur.base[j].clone(),
                    //                 Some(generate_expression(
                    //                     "*",
                    //                     AbstractExpression::Abstract(loop_var_name.clone()),
                    //                     AbstractExpression::Immediate(d as i64),
                    //                 )),
                    //             );

                    //             new_reg.base[j] = new_base;
                    //         }
                    //     }
                    //     self.computer.simd_registers[i] = new_reg;
                    // }

                    self.in_loop = true;
                    return Some(branch_decision);
                }
            }

            return None;

        // in loop protocol
        } else {
            // K+1 loop is a repeat of K loop!
            for j in self.jump_history.clone().into_iter().rev() {
                let (last_jump_label, branch_decision, last_jump_exp, last_rw_list, last_state) = j;

                if last_jump_label == pc && last_jump_exp == expression && last_rw_list == rw_list
                // && last_state == &self.computer.get_state()
                {
                    self.computer.solver.pop(1);
                    let condition = comparison_to_ast(self.computer.context, expression.clone())
                        .expect("engineb");
                    self.computer.solver.assert(&condition.simplify());
                    self.in_loop = false;
                    return Some(!branch_decision);
                } else if last_jump_label == pc {
                    // JUMP after Kth STEP -- need to check loop advanced ok for first iteration
                    let current_state = self.computer.get_state();
                    let loop_var_name = (pc.to_string()) + "_loop_?";
                    for i in 0..(last_state.0.len()) {
                        let last = &last_state.0[i];
                        let cur = &current_state.0[i];
                        let diff: i64 = cur.offset - last.offset;

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
                                    kind: cur.kind.clone(),
                                    base: cur.base.clone(),
                                    offset: 0,
                                };
                                self.computer.registers[i] = new_reg;
                            }
                        }
                    }

                    return Some(branch_decision);
                    // todo!();
                    // for i in 0..(last_state.1.len()) {
                    //     let last = &last_state.1[i];
                    //     let cur = &current_state.1[i];
                    //     let diff: [u8; 16] = match cur.kind {
                    //         RegisterKind::RegisterBase | RegisterKind::Number => {
                    //             if last.base == cur.base {
                    //                 (0..16)
                    //                     .map(|i| cur.offset[i] - last.offset[i])
                    //                     .collect::<Vec<_>>()
                    //                     .try_into()
                    //                     .expect("engined")
                    //             } else {
                    //                 [0; 16]
                    //             }
                    //         }
                    //         RegisterKind::Immediate => (0..16)
                    //             .map(|i| cur.offset[i] - last.offset[i])
                    //             .collect::<Vec<_>>()
                    //             .try_into()
                    //             .expect("enginee"),
                    //     };

                    //     let base = cur.base.clone();

                    //     if base
                    //         .iter()
                    //         .any(|s| s.is_some() && s.clone().expect("enginef").contains(&loop_var_name))
                    //     {
                    //         let mut new_reg = SimdRegister {
                    //             kind: cur.kind.clone(),
                    //             base: cur.base.clone(),
                    //             offset: cur.offset,
                    //         };

                    //         for j in 0..16 {
                    //             let d = diff[j];
                    //             if d > 0 {
                    //                 let new_base = generate_expression_from_options(
                    //                     "+",
                    //                     cur.base[j].clone(),
                    //                     Some(generate_expression(
                    //                         "*",
                    //                         AbstractExpression::Abstract(loop_var_name.clone()),
                    //                         AbstractExpression::Immediate(d as i64),
                    //                     )),
                    //                 );

                    //                 new_reg.base[j] = new_base;
                    //             }
                    //         }
                    //         self.computer.simd_registers[i] = new_reg;
                    //     }
                    // }
                }
            }
            return None;
        }
    }
}
