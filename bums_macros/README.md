# Macro to abstract calls to the symbex engine

This crate exposes the ```#[check_mem_safe()]``` macro that attaches to Rust function declarations and transforms them to "safe" extern calls to assembly.
Example uses of the macro can be found in the crypto- and rav1d- playgrounds.

Must be run in ```--release``` mode so that the macro will throw a compile error when the analysis cannot conclude the linked assembly is safe.
This can happen if parameters are not passed in correctly, not all preconditions are defined, the assembly includes unsupported behavior such as system calls, or the assembly has critical memory safety bugs.


## Usage

```rust
#[bums_macros::check_mem_safe("filename.S", param1.as_mut_ptr(), param2.as_ptr(), [param1.len() > param2.len()])]
fn function_name(param1: &mut [u32; 8], param2: &[u8]) -> bool;
```

1. Identify the filename and name of the assembly function to link, in the example "filename.S" and "function_name", ignoring any preceding underscores. The function name should be exported/or be a global label in the source.
2. Write a function signature that includes all the safe Rust types the assembly will access or return.
3. Attach the macro to the function, and include, in order:
     1. The filename as a String
     2. The mapping of Rust parameters to Assembly parameters (arrays to pointers, arrays to lengths, etc...) in the order in which they are placed in registers
     3. Any preconditions on the parameters using Rust syntax


#### Notes on passing slice length
When the length of a buffer/slice is a parameter, there are a few ways to express that using the macro:

1. The best way to express a relationship between a parameter and its length is by not having a parameter for the length and only deriving the length within the macro.
```rust
#[bums_macros::check_mem_safe("filename.S", param1.as_ptr(), param1.as_len())]
fn function_name(param1: &[u8]);
```

2. If there must be a second parameter in the function call, then a precondition needs to be defined that connects the two parameters. If the function is called at runtime with an incorrect length, the assertion will fail at runtime before the assembly is executed.
```rust
#[bums_macros::check_mem_safe("filename.S", param1.as_ptr(), param2, [param2 == param1.len())]
fn function_name(param1: &[u8], length: usize);
```


#### Notes on passing structs/enums/etc...
The macro must be able to calculate the size of each parameter in the function call. To enable doing this at compile-time, all types passed must be primitives or composites of primitive types, since procedural macros do not have access to external declarations at macro expansion time. The one exception to this restriction is slices that can be passed as both a pointer and a length across multiple parameters. A developer must rewrite any enum or struct using primitives.
```rust
// My struct
// struct S {
//  id: i128,
//  value: u64,
//  num_members: usize
//  members: &[u8];
// };

#[bums_macros::check_mem_safe("filename.S", param.as_ptr(), [param.1 < 20, param.2 == param3.len())]
fn manipulate_struct(param1: &(i128, u64, usize, &[u8]));

```

