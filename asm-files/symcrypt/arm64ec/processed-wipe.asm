//
//  wipe.symcryptasm   Assembler code for wiping a buffer
//  Expresses asm in a generic enough way to enable generation of MASM and GAS using the
//  symcryptasm_processor.py script and C preprocessor
//
// Copyright (c) Microsoft Corporation. Licensed under the MIT license.


#include "symcryptasm_shared.cppasm"

    TEXTAREA()

    EXTERN(ARM64EC_NAME_MANGLE(memset))

//VOID
//SYMCRYPT_CALL
//SymCryptWipe( _Out_writes_bytes_( cbData )    PVOID  pbData,
//                                              SIZE_T cbData )

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
    LEAF_ENTRY ARM64EC_NAME_MANGLE(SymCryptWipeAsm)

// we just jump to memset.
// this is enough to stop the compiler optimizing the memset away.

    mov     X_2, X_1
    mov     X_1, #0
    b       ARM64EC_NAME_MANGLE(memset)

    ret
    LEAF_END ARM64EC_NAME_MANGLE(SymCryptWipeAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2

    FILE_END()
