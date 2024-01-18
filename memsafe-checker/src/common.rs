use std::fmt;
use std::io::Write;

#[derive(Debug, Clone, Copy)]
pub enum RegionType {
    READ,
    WRITE,
    READWRITE,
}

impl fmt::Display for RegionType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            RegionType::READ => write!(f, "Read"),
            RegionType::WRITE => write!(f, "Write"),
            RegionType::READWRITE => write!(f, "Read/Write"),
        }
    }
}

// TODO: allow different types within one region at different offsets
// for example for sha256 input is also output may be 1000 bits long but output is 256
// so shouldn't write into the input buffer past 256 bits
pub struct MemorySafeRegion {
    pub region_type: RegionType,
    pub register: String,
    pub start_offset: usize,
    pub end_offset: usize,
}
