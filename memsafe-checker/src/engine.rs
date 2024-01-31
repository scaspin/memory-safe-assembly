use crate::common;
use crate::computer;
use rand::Rng;

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
    loop_state: Vec<(String, Vec<common::MemoryAccess>)>,
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
        };
    }

    pub fn add_region(&mut self, region: common::MemorySafeRegion) {
        // self.memory_regions.push(region);
        self.computer.set_region(region);
    }

    pub fn add_immediate(&mut self, register: String, value: usize) {
        self.computer.set_immediate(register, value as u64);
    }

    pub fn add_abstract(&mut self, register: String, value: common::AbstractValue) {
        self.computer.set_abstract(register, value);
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
            let instruction = self.program.code[pc].clone();
            log::info!("{:?}", instruction);

            let execute_result = self.computer.execute(&instruction);
            match execute_result {
                Ok(some) => match some {
                    Some(jump) => match jump {
                        // (condition, label to jump to, line number to jump to)
                        (Some(condition), Some(label), None) => {
                            if self
                                .evaluate_jump_condition(condition, self.computer.rw_queue.clone())
                            {
                                for l in self.program.labels.iter() {
                                    if l.0.contains(&label.clone()) && label.contains(&l.0.clone())
                                    {
                                        pc = l.1;
                                        self.computer.clear_rw_queue();
                                    }
                                }
                            } else {
                                pc = pc + 1;
                            }
                        }
                        (Some(condition), None, Some(address)) => {
                            if self
                                .evaluate_jump_condition(condition, self.computer.rw_queue.clone())
                            {
                                if address == 0 {
                                    // program is done
                                    break;
                                }
                                pc = address as usize;
                                self.computer.clear_rw_queue();
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
                Err(_) => {
                    log::error!(
                        "Instruction could not execute at line {:?} : {:?}",
                        pc,
                        instruction
                    );
                    break;
                }
            }

            self.pc = pc;
        }

        self.computer.check_stack_pointer_restored();

        for state in &self.loop_state {
            println!("Condition: {:?}", state.0);
            for rw in &state.1 {
                println!("{}", rw);
            }
        }

        Ok(())
    }

    // if true, we jump
    // if false, we continue
    // BIG TODO
    fn evaluate_jump_condition(
        &mut self,
        expression: String,
        rw_list: Vec<common::MemoryAccess>,
    ) -> bool {
        let mut relevant_rw_list = Vec::new();
        for a in rw_list {
            if expression.contains(&a.base) {
                relevant_rw_list.push(a);
            }
        }
        self.loop_state.push((expression, relevant_rw_list));
        let mut rng = rand::thread_rng();
        let r = rng.gen::<bool>();
        r
    }
}