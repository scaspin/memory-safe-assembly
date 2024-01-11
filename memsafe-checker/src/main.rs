use clap::Parser;
use std::fmt;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::path::PathBuf;
use std::result::Result;
use std::str::FromStr;

mod computer;

#[derive(Parser)]
struct Args {
    file: PathBuf,
    label: String,
    context: String,
    input: String,
    length: String,
    length_value: usize,
}

struct Program {
    defs: Vec<String>,
    code: Vec<String>,
    labels: Vec<(String, usize)>,
    ifdefs: Vec<((String, usize), usize)>, 
}


struct Execution {
    program: Program,
    computer: computer::ARMCORTEXA,
    pc: usize,
    //permissions: 
}

impl Execution {

    fn new(reader: BufReader<R>) -> Execution  {
        // represent code this way, highly unoptimized
        let mut defs: Vec<String> = Vec::new();
        let mut code: Vec<String> = Vec::new();
        let mut labels: Vec<(String, usize)> = Vec::new();
        let mut ifdefs: Vec<((String, usize), usize)> = Vec::new();

        let mut parsed_code = Vec::new();

        // grab lines into array
        let mut line_number = 0;
        let mut inifdef = false;
        let mut lastifdef: (String, usize) = ("Start".to_string(), 0);
        let mut pc = 0;

        // first pass, move text into array
        for line in reader.lines() {
            let unwrapped = line?;
            let trimmed = unwrapped.trim();
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

                code.push(text.clone());

                if text.contains(":") {
                    labels.push((text.to_string(), line_number));
                    if text == start {
                        pc = line_number;
                    }
                } else {
                    let parsed = text.parse::<computer::Instruction>();
                    match parsed {
                        Ok(i) => parsed_code.push(i),
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

        let mut address = 0;
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
                    //address = address + (alignment as i64);
                    address = address + 4;
                }
            }
        }

        
        return Execution { program: Program {defs, code, labels, ifdefs}, computer, pc }
    }

    fn start(&self, label: String) -> std::io::Result<()> {
        let program_length = self.program.code.len();
        let pc = self.pc ; // FIX: use accesses to data structure

        while pc < program_length {
            let instruction = parsed_code[pc].clone();
            log::info!("{:?}", instruction);
    
            //println!("Running: {:?}", parsed_code[pc]);
            let execute_result = computer.execute(&parsed_code[pc]);
            match execute_result {
                Ok(some) => match some {
                    Some(jump) => match jump {
                        (Some(label), None) => {
                            if label == "Return".to_string() {
                                break;
                            }
                            for l in labels.iter() {
                                if l.0.contains(&label) {
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
                            log::error!("Execute did not return valid response for jump or continue")
                        }
                    },
                    None => pc = pc + 1,
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
        }
        Ok(())
    }
}   



fn main() -> std::io::Result<()> {
    env_logger::init();
    let args = Args::parse();
    let file = File::open(args.file)?;
    let reader = BufReader::new(file);
    let start = args.label;

    
    let engine = Execution::new(reader);
    // this is the context, i.e. A,B,C,D,E for the function
    // computer.set_context(args.context);
    // computer.set_input(args.input);
    // computer.set_length(args.length, args.length_value.try_into().unwrap());
    engine.start(start);

    println!("Symbolic execution done");

    Ok(())
}
