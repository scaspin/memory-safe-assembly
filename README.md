# Memory Safe Assembly

Bottom-up memory-safety checks for assembly using symbolic execution

Repository structure:
-  ```memsafe-checker``` directory is the ```bums``` crate for the symbolic execution engine
-  ```bums-macros``` directory contains the **check_mem_safe** macro that derives safety constraints from function calls and invokes the symbolic execution
-  ```crypto-playground``` shows examples of how to use the macros exposed by ```bums-macros``` to check cryptography from [aws-lc-rs](https://github.com/aws/aws-lc-rs)
-  ```rav1d-playground``` shows examples of how to use the macros exposed by ```bums-macros``` to check video decoding code from [rav1d](https://github.com/memorysafety/rav1d)
-  ```asm-files``` assembly files for cryptographic algorithms collected from various crypto libraries
-  ```scrape-asm``` contains code for searching for assembly in top crates from crates.io

