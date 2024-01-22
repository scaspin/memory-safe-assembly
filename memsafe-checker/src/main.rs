use std::fs::File;
use std::io::BufReader;


mod common;
mod computer;

struct Program {
    defs: Vec<String>,
    code: Vec<common::Instruction>,
    labels: Vec<(String, usize)>,
    ifdefs: Vec<((String, usize), usize)>,
}

struct ExecutionEngine {
    program: Program,
    computer: computer::ARMCORTEXA,
    pc: usize,
    // memory_regions: Vec<MemorySafeRegion> , // FIX: necessary?
}

impl ExecutionEngine {

    fn new(lines: Vec<String>) -> ExecutionEngine {
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
        };
    }

    fn add_region(&mut self, region: common::MemorySafeRegion) {
        // self.memory_regions.push(region);
        self.computer.set_region(region);
    }

    fn add_immediate(&mut self, register: String, value: usize) {
        self.computer.set_immediate(register, value as u64);
    }

    fn add_abstract(&mut self, register: String, value: common::AbstractValue) {
        self.computer.set_abstract(register, value);
    }

    fn start(&mut self, start: String) -> std::io::Result<()> {
        let program_length = self.program.code.len();
        let mut pc = 0;

        for label in self.program.labels.clone() {
            if label.0 == start {
                pc = label.1;
            }
        }

        let mut count = 0;
        while pc < program_length {
            let instruction = self.program.code[pc].clone();
            log::info!("{:?}", instruction);

            // println!("Running: {:?}", instruction.clone());

            // if (pc == 868  || pc == 869) && count < 6 {
            //     println!("Running: {:?}", instruction.clone());
            //     println!("Computer: {:?}", self.computer);
            //     count = count + 1;
            // }
            // println!("Computer: {:?}", self.computer);

            let execute_result = self.computer.execute(&instruction);
            match execute_result {
                Ok(some) => match some {
                    Some(jump) => match jump {
                        (Some(label), None) => {
                            // println!("jump to label: {:?}", label.clone());
                            if label == "Return".to_string() {
                                break;
                            }
                            for l in self.program.labels.iter() {
                                if l.0.contains(&label.clone()) && label.contains(&l.0.clone()){
                                    pc = l.1;
                                }
                            }
                        }
                        (None, Some(address)) => {
                            if address == 0 {
                                // program is done
                                break;
                            }
                            pc = address as usize;
                        }
                        (None, None) | (Some(_), Some(_)) => {
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

            // println!("at line: {:?}", pc.clone());
            self.pc = pc;
        }
        Ok(())
    }
}

fn check_sha256_armv8_ios64() -> std::io::Result<()> {
    use std::io::BufRead;

    let file = File::open("assets/processed-sha256-armv8-ios64.S")?;
    let reader = BufReader::new(file);
    let start_label = String::from("_sha256_block_data_order");

    let mut program = Vec::new();
    for line in reader.lines() {
        program.push(line.unwrap_or(String::from("")));
    }

    let mut engine = ExecutionEngine::new(program);

    // x0 -- context
    engine.add_region(common::MemorySafeRegion {
        region_type: common::RegionType::READ,
        register: String::from("x0"),
        start_offset: common::ValueType::REAL(0),
        end_offset: common::ValueType::REAL(64), // FIX: verify
    });
    engine.add_region(common::MemorySafeRegion {
        region_type: common::RegionType::WRITE,
        register: String::from("x0"),
        start_offset: common::ValueType::REAL(0),
        end_offset: common::ValueType::REAL(64), // FIX: verify
    });

    let abstract_input_length = common::AbstractValue{ name: "InputLength".to_string(), min: Some(0), max: None};
    // x1 -- input blocks
    // engine.add_input(String::from("x1")); // necessary to support various input designs
    engine.add_region(common::MemorySafeRegion {
        region_type: common::RegionType::WRITE,
        register: String::from("x1"),
        start_offset: common::ValueType::REAL(0),
        end_offset: common::ValueType::REAL(256),
    });
    engine.add_region(common::MemorySafeRegion {
        region_type: common::RegionType::READ,
        register: String::from("x1"),
        start_offset: common::ValueType::REAL(0),
        end_offset: common::ValueType::ABSTRACT(abstract_input_length),
    });

    // x2 -- number of blocks
    engine.add_abstract(String::from("x2"), abstract_input_length);
    engine.add_region(common::MemorySafeRegion {
        region_type: common::RegionType::READ,
        register: String::from("x2"),
        start_offset: common::ValueType::REAL(0),
        end_offset: common::ValueType::REAL(256), 
    });

    engine.start(start_label)
}

fn main() -> std::io::Result<()> {
    env_logger::init();

    let res = check_sha256_armv8_ios64();
    println!("{:?}", res);
    res
}
