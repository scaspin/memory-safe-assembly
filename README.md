# Memory Safe Assembly

Bottom-up memory-safety for assembly language using symbolic execution
-  ```memsafe-checker``` mem safety checker written in rust
-  ```asm-files``` assembly files for cryptographic algorithms collected from various crypto libraries

### Framework Goals
- [x] Quick
- [x] Static (do not need access to hardware)
- [ ] Derive semantics with no programmer intervention (no need for someone to specify where input is, may need to derive from larger program?)
- [x] Responsive, i.e. indicating line numbers for "bad" behavior so code can be rewritten
- [ ] Derive assembly semantics directly from specification

### What does it mean for assembly to be memory safe?

No definition for memory safety for handwritten assembly code. Would like integration to programs written in
higher-level memory-safe languages without compromising program memory safety.
In particular, want to target cryptographic algorithms that mostly contain arithmetic or perhaps need constant time as a security property.
Simpler memory models that allow some simplifying assumptions since we don't need to support a wide range of behaviors.

- Isolation
    - Reads from inputs, writes to output buffers
    - Reads/writes from the stack
    - Reads from program memory
    - Cannot pointer chase (use a read value as an address for a subsequent read/write)
- No dependencies on input parameters
    - No branching or looping on explicit input values (for example, can't do if first byte is X do this, if second byte is Y do this, etc...)

### Symbolic execution
- Target programs allow for reduced search space -> only care about memory accesses and their "provenance", making sure addresses conform to isolation needs
- Still need path exploration for state variables such as macros and flags
- Impose types on top of registers
  - Immediate (including defs and immediates defined through execution)
  - Abstract
    - Numbers (such as those read from input)
    - Registers   
    - Address
      - Stack/frame
      - Inputs/output buffers
      - Memory/Program (to define abstract locations for labels and program variables)
