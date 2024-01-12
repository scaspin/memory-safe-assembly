mod common {

    pub enum RegionType {
        READ,
        WRITE, 
        RW,
    }
    
    // TODO: allow different types within one region at different offsets
    // for example for sha256 input is also output may be 1000 bits long but output is 256
    // so shouldn't write into the input buffer past 256 bits
    pub struct MemorySafeRegion {
        region_type: RegionType,
        register: String,
        start_offset : usize,
        end_offset: usize,
    }
}