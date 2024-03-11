use std::io::{Error, ErrorKind};

use crate::common;
use crate::computer;

struct Program {
    defs: Vec<String>,
    code: Vec<common::Instruction>,
    labels: Vec<(String, usize)>,
    ifdefs: Vec<((String, usize), usize)>,
}

pub struct ExecutionEngine {
    program: Program,
    computer: computer::ARMCORTEXA,
    pc: usize,
    loop_state: Vec<(common::AbstractExpression, Vec<common::MemoryAccess>)>,
    fail_fast: bool,
}

impl ExecutionEngine {
    pub fn new(lines: Vec<String>) -> ExecutionEngine {
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

        let mut computer = computer::ARMCORTEXA::new();

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
                defs,
                code,
                labels,
                ifdefs,
            },
            computer,
            pc: 0,
            loop_state: Vec::new(),
            fail_fast: true,
        };
    }

    pub fn add_region(&mut self, region: common::MemorySafeRegion) {
        // self.memory_regions.push(region);
        self.computer.set_region(region);
    }

    pub fn add_region_from(&mut self, base: String, length: (Option<usize>, Option<String>)) {
        match length {
            (Some(num), _) => {
                self.computer.set_region(
                    common::MemorySafeRegion{
                        region_type: common::RegionType::WRITE,
                        base: common::AbstractExpression::Abstract(base.clone()),
                        start: common::AbstractExpression::Immediate(0),
                        end: common::AbstractExpression::Immediate((num.clone() as i64)*4),
                    }
                );
                self.computer.set_region(
                    common::MemorySafeRegion{
                        region_type: common::RegionType::READ,
                        base: common::AbstractExpression::Abstract(base),
                        start: common::AbstractExpression::Immediate(0),
                        end: common::AbstractExpression::Immediate((num as i64)*4),
                    }
                );
            },
            (None, Some(abs)) => {
                self.computer.set_region(
                    common::MemorySafeRegion{
                        region_type: common::RegionType::WRITE,
                        base: common::AbstractExpression::Abstract(base.clone()),
                        start: common::AbstractExpression::Immediate(0),
                        end: common::AbstractExpression::Abstract(abs.clone()),
                    }
                );
                self.computer.set_region(
                    common::MemorySafeRegion{
                        region_type: common::RegionType::READ,
                        base: common::AbstractExpression::Abstract(base),
                        start: common::AbstractExpression::Immediate(0),
                        end: common::AbstractExpression::Abstract(abs),
                    }
                );
            },
            (_,_) => ()  // should never happen! just to be safe
        }
    }

    pub fn add_immediate(&mut self, register: String, value: usize) {
        self.computer.set_immediate(register, value as u64);
    }

    pub fn add_abstract(&mut self, register: String, value: common::AbstractExpression) {
        self.computer.set_abstract(register, value);
    }

    pub fn dont_fail_fast(&mut self) {
        self.fail_fast = false;
    }

    pub fn change_alignment(&mut self, value: i64) {
        self.computer.change_alignment(value);
    }

    pub fn start(&mut self, start: String) -> std::io::Result<()> {
        let program_length = self.program.code.len();
        let mut pc = 0;

        for label in self.program.labels.clone() {
            if label.0 == start {
                pc = label.1;
            }
        }

        while pc < program_length {
            let mut instruction = self.program.code[pc].clone();

            // skip instruction if it is a label
            if instruction.op.contains(":") {
                pc = pc + 1;
                instruction = self.program.code[pc].clone();
            }

            log::info!("{:?}", instruction);

            let execute_result = self.computer.execute(&instruction);
            match execute_result {
                Ok(some) => match some {
                    Some(jump) => match jump {
                        // (condition, label to jump to, line number to jump to)
                        (Some(condition), Some(label), None) => {
                            if self
                                .evaluate_jump_condition(condition, self.computer.read_rw_queue())
                            {
                                for l in self.program.labels.iter() {
                                    if l.0.contains(&label.clone()) && label.contains(&l.0.clone())
                                    {
                                        pc = l.1;
                                    }
                                }
                            } else {
                                pc = pc + 1;
                            }
                        }
                        (Some(condition), None, Some(address)) => {
                            if self
                                .evaluate_jump_condition(condition, self.computer.read_rw_queue())
                            {
                                if address == 0 {
                                    // program is done
                                    break;
                                }
                                pc = address as usize;
                            } else {
                                pc = pc + 1;
                            }
                        }
                        (None, Some(label), None) => {
                            if label == "Return".to_string() {
                                break;
                            }
                            for l in self.program.labels.iter() {
                                if l.0.contains(&label.clone()) && label.contains(&l.0.clone()) {
                                    pc = l.1;
                                }
                            }
                        }
                        (None, None, Some(address)) => {
                            if address == 0 {
                                // program is done
                                break;
                            }
                            pc = address as usize;
                        }
                        (Some(condition), None, None) => {
                            log::error!("No jump target for jump condition {}", condition)
                        }
                        (None, None, None)
                        | (None, Some(_), Some(_))
                        | (Some(_), Some(_), Some(_)) => {
                            log::error!(
                                "Execute did not return valid response for jump or continue"
                            )
                        }
                    },
                    None => {
                        pc = pc + 1;
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

            self.pc = pc;
        }

        self.computer.check_stack_pointer_restored();

        Ok(())
    }

    // if true, we jump
    // if false, we continue
    // BIG TODO
    fn evaluate_jump_condition(
        &mut self,
        expression: common::AbstractExpression,
        rw_list: Vec<common::MemoryAccess>,
    ) -> bool {
        log::info!("jump condition: {}", expression.clone());
        // log::info!("memory accesses: {:?}", rw_list.clone());

        // figure out relevant registers
        let relevant_registers = expression.get_register_names();

        for e in &self.loop_state {
            if e.0 == expression && e.1 == rw_list {
                // TODO replace ? with value
                let (left, right) = expression.reduce_solution();
                if left.contains("?") || right.contains("?") {
                    // FIX: cannot call solve for if it doesn't have key
                    let solved = common::solve_for("?", left, right);
                    self.computer.replace_abstract("?", solved);
                }
                for reg in relevant_registers {
                    self.computer.untrack_register(reg);
                }
                return false;
            }
        }

        self.loop_state.push((expression.clone(), rw_list));
        for r in relevant_registers {
            self.computer.track_register(r);
        }
        self.computer.clear_rw_queue();

        let (left, right) = expression.reduce_solution();
        self.computer
            .add_constraint(common::AbstractExpression::Expression(
                "<".to_string(),
                Box::new(left),
                Box::new(right),
            ));

        return true;
    }
}
