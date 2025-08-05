pub mod common;
pub mod computer;
pub mod engine;
pub mod instruction_parser;

#[macro_export]
macro_rules! extract_three_registers {
    ($self:ident, $instruction:ident) => {{
        let mut reg_iter = &mut $instruction.operands.iter();

        let reg0 = reg_iter.next().expect("Need destination register");
        let reg1 = reg_iter.next().expect("Need first source register");
        let reg2 = reg_iter.next().expect("Need second source register");

        (
            $self.get_register(reg0),
            $self.get_register(reg1),
            $self.get_register(reg2),
        )
    }};
}
