//
//  fdef_asm.symcryptasm   Assembler code for large integer arithmetic in the default data format for the arm64 architecture
//  Expresses asm in a generic enough way to enable generation of MASM and GAS using the
//  symcryptasm_processor.py script and C preprocessor
//
// Copyright (c) Microsoft Corporation. Licensed under the MIT license.
//

#include "symcryptasm_shared.cppasm"

// A digit consists of 4 words of 64 bits each

//UINT32
//SYMCRYPT_CALL
//SymCryptFdefRawAddAsm(
//    _In_reads_bytes_(nDigits * SYMCRYPT_FDEF_DIGIT_SIZE )   PCUINT32    Src1,
//    _In_reads_bytes_(nDigits * SYMCRYPT_FDEF_DIGIT_SIZE )   PCUINT32    Src2,
//    _Out_writes_bytes_(nDigits * SYMCRYPT_FDEF_DIGIT_SIZE ) PUINT32     Dst,
//                                                            UINT32      nDigits )

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
#define X_3 x3
#define W_3 w3
#define X_4 x4
#define W_4 w4
#define X_5 x5
#define W_5 w5
#define X_6 x6
#define W_6 w6
#define X_7 x7
#define W_7 w7
    LEAF_ENTRY ARM64EC_NAME_MANGLE(SymCryptFdefRawAddAsm)

    ldp     X_4, X_6, [X_0]         // Load two words of pSrc1
    ldp     X_5, X_7, [X_1]         // Load two words of pSrc2
    adds    X_4, X_4, X_5
    adcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2]         // Store the result in the destination

    ldp     X_4, X_6, [X_0, #16]    // Load two words of pSrc1
    sub     X_3, X_3, #1            // Decrement the digit count by one
    ldp     X_5, X_7, [X_1, #16]    // Load two words of pSrc2
    adcs    X_4, X_4, X_5
    adcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #16]    // Store the result in the destination

    cbz     X_3, SymCryptFdefRawAddAsmEnd

LABEL(SymCryptFdefRawAddAsmLoop)
    // carry is in the carry flag
    // only update pointers to srcs and destination once per loop to reduce uops and dependencies
    ldp     X_4, X_6, [X_0, #32]!   // Load two words of pSrc1
    ldp     X_5, X_7, [X_1, #32]!   // Load two words of pSrc2
    adcs    X_4, X_4, X_5
    adcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #32]!   // Store the result in the destination

    ldp     X_4, X_6, [X_0, #16]    // Load two words of pSrc1
    sub     X_3, X_3, #1            // Decrement the digit count by one
    ldp     X_5, X_7, [X_1, #16]    // Load two words of pSrc2
    adcs    X_4, X_4, X_5
    adcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #16]    // Store the result in the destination

    cbnz    X_3, SymCryptFdefRawAddAsmLoop

    ALIGN(4)
LABEL(SymCryptFdefRawAddAsmEnd)
    cset    X_0, cs                 // Set the return value equal to the carry

    ret
    LEAF_END ARM64EC_NAME_MANGLE(SymCryptFdefRawAddAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2
#undef X_3
#undef W_3
#undef X_4
#undef W_4
#undef X_5
#undef W_5
#undef X_6
#undef W_6
#undef X_7
#undef W_7

//UINT32
//SYMCRYPT_CALL
//SymCryptFdefRawSubAsm(
//    _In_reads_bytes_(nDigits * SYMCRYPT_FDEF_DIGIT_SIZE )   PCUINT32    pSrc1,
//    _In_reads_bytes_(nDigits * SYMCRYPT_FDEF_DIGIT_SIZE )   PCUINT32    pSrc2,
//    _Out_writes_bytes_(nDigits * SYMCRYPT_FDEF_DIGIT_SIZE ) PUINT32     pDst,
//                                                            UINT32      nDigits )

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
#define X_3 x3
#define W_3 w3
#define X_4 x4
#define W_4 w4
#define X_5 x5
#define W_5 w5
#define X_6 x6
#define W_6 w6
#define X_7 x7
#define W_7 w7
    LEAF_ENTRY ARM64EC_NAME_MANGLE(SymCryptFdefRawSubAsm)

    ldp     X_4, X_6, [X_0]         // Load two words of pSrc1
    ldp     X_5, X_7, [X_1]         // Load two words of pSrc2
    subs    X_4, X_4, X_5
    sbcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2]         // Store the result in the destination

    ldp     X_4, X_6, [X_0, #16]    // Load two words of pSrc1
    sub     X_3, X_3, #1            // Decrement the digit count by one
    ldp     X_5, X_7, [X_1, #16]    // Load two words of pSrc2
    sbcs    X_4, X_4, X_5
    sbcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #16]    // Store the result in the destination

    cbz     X_3, SymCryptFdefRawSubAsmEnd

LABEL(SymCryptFdefRawSubAsmLoop)
    // borrow is in the carry flag (flipped)
    // only update pointers to srcs and destination once per loop to reduce uops and dependencies
    ldp     X_4, X_6, [X_0, #32]!   // Load two words of pSrc1
    ldp     X_5, X_7, [X_1, #32]!   // Load two words of pSrc2
    sbcs    X_4, X_4, X_5
    sbcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #32]!   // Store the result in the destination

    ldp     X_4, X_6, [X_0, #16]    // Load two words of pSrc1
    sub     X_3, X_3, #1            // Decrement the digit count by one
    ldp     X_5, X_7, [X_1, #16]    // Load two words of pSrc2
    sbcs    X_4, X_4, X_5
    sbcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #16]    // Store the result in the destination

    cbnz    X_3, SymCryptFdefRawSubAsmLoop

    ALIGN(4)
LABEL(SymCryptFdefRawSubAsmEnd)
    cset    X_0, cc                 // If the carry is clear (borrow), set the return value to 1

    ret
    LEAF_END ARM64EC_NAME_MANGLE(SymCryptFdefRawSubAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2
#undef X_3
#undef W_3
#undef X_4
#undef W_4
#undef X_5
#undef W_5
#undef X_6
#undef W_6
#undef X_7
#undef W_7

//VOID
//SYMCRYPT_CALL
//SymCryptFdefMaskedCopyAsm(
//    _In_reads_bytes_( nDigits*SYMCRYPT_FDEF_DIGIT_SIZE )        PCBYTE      pbSrc,
//    _Inout_updates_bytes_( nDigits*SYMCRYPT_FDEF_DIGIT_SIZE )   PBYTE       pbDst,
//                                                                UINT32      nDigits,
//                                                                UINT32      mask )

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
#define X_3 x3
#define W_3 w3
#define X_4 x4
#define W_4 w4
    LEAF_ENTRY ARM64EC_NAME_MANGLE(SymCryptFdefMaskedCopyAsm)

    dup     v0.4s, W_3              // broadcast the mask to v0

LABEL(SymCryptFdefMaskedCopyAsmLoop)
    ldp     q1, q3, [X_0], #32      // Load 4 words of the source
    ldp     q2, q4, [X_1]           // Load 4 words of the destination
    bit     v2.16b, v1.16b, v0.16b  // if the mask is 1s, overwrite the destination with source
    bit     v4.16b, v3.16b, v0.16b  // if the mask is 1s, overwrite the destination with source
    stp     q2, q4, [X_1], #32      // Store the two words in the destination

    sub     X_2, X_2, #1            // Decrement the digit count by one

    cbnz    X_2, SymCryptFdefMaskedCopyAsmLoop

    // Done, no return value

    ret
    LEAF_END ARM64EC_NAME_MANGLE(SymCryptFdefMaskedCopyAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2
#undef X_3
#undef W_3
#undef X_4
#undef W_4

//VOID
//SYMCRYPT_CALL
//SymCryptFdefRawMulAsm(
//    _In_reads_(nDigits1*SYMCRYPT_FDEF_DIGIT_NUINT32)                PCUINT32    pSrc1,
//                                                                    UINT32      nDigits1,
//    _In_reads_(nDigits2*SYMCRYPT_FDEF_DIGIT_NUINT32)                PCUINT32    pSrc2,
//                                                                    UINT32      nDigits2,
//    _Out_writes_((nDigits1+nDigits2)*SYMCRYPT_FDEF_DIGIT_NUINT32)   PUINT32     pDst )
//
// Basic structure:
//   for each word in Src1:
//       Dst += Src2 * word
//
// Register assignments
//       X_0  = pSrc1 (moving forward one word every outer loop)
//       X_1  = word count of pSrc1
//       X_2  = pSrc2 (moving forward one *digit* every inner loop)
//       X_3  = digit count of pSrc2 and pDst
//       X_4  = pDst (moving forward one *digit* every inner loop)
//       X_5  = Stored pDst (moving forward one word every outer loop)
//       X_6  = Current word loaded from pSrc1
//       X_7, X_8   = Current words loaded in pairs from pSrc2
//       X_9, X_10  = Current words loaded in pairs from pDst
//       X_11, X_12 = Scratch registers for holding the results of multiplies
//       X_13 = Stored pSrc2
//       X_14 = Stored digit count of pSrc2
//       X_15 = Scratch register for holding the results of multiplies

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
#define X_3 x3
#define W_3 w3
#define X_4 x4
#define W_4 w4
#define X_5 x5
#define W_5 w5
#define X_6 x6
#define W_6 w6
#define X_7 x7
#define W_7 w7
#define X_8 x8
#define W_8 w8
#define X_9 x9
#define W_9 w9
#define X_10 x10
#define W_10 w10
#define X_11 x11
#define W_11 w11
#define X_12 x12
#define W_12 w12
#define X_13 x15
#define W_13 w15
#define X_14 x16
#define W_14 w16
#define X_15 x17
#define W_15 w17
    LEAF_ENTRY ARM64EC_NAME_MANGLE(SymCryptFdefRawMulAsm)

    lsl     X_1, X_1, #2                // Calculate word count

    sub     X_2, X_2, #32               // offset pSrc2 so we can use pre-increment form of loads
    sub     X_4, X_4, #32               // offset pDst so we can use pre-increment form of loads

    mov     X_5, X_4                    // store pDst
    mov     X_13, X_2                   // store pSrc2
    mov     X_14, X_3                   // store nDigits2 for later

    //
    // First iteration of main loop (no adding of previous values from pDst)
    //
    ands    X_12, X_12, xzr             // Clearing the carry flag and setting X_12 = 0
    ldr     X_6, [X_0]                  // load the first word from pSrc1

LABEL(SymCryptFdefRawMulAsmLoopInner1)
    sub     X_3, X_3, #1                // move one digit up

    ldp     X_7, X_8, [X_2, #32]!       // load 2 words from pSrc2

    mul     X_11, X_6, X_7              // Bits <63:0> of pSrc1[0]*pSrc2[j]
    adcs    X_11, X_11, X_12            // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_12, X_6, X_7              // Bits <127:64> of pSrc1[0]*pSrc2[j]

    mul     X_15, X_6, X_8              // Bits <63:0> of pSrc1[0]*pSrc2[j+1]
    adcs    X_15, X_15, X_12            // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_12, X_6, X_8              // Bits <127:64> of pSrc1[0]*pSrc2[j+1]

    stp     X_11, X_15, [X_4, #32]!     // Store to destination
    ldp     X_7, X_8, [X_2, #16]        // load 2 words from pSrc2

    mul     X_11, X_6, X_7              // Bits <63:0> of pSrc1[0]*pSrc2[j+2]
    adcs    X_11, X_11, X_12            // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_12, X_6, X_7              // Bits <127:64> of pSrc1[0]*pSrc2[j+2]

    mul     X_15, X_6, X_8              // Bits <63:0> of pSrc1[0]*pSrc2[j+3]
    adcs    X_15, X_15, X_12            // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_12, X_6, X_8              // Bits <127:64> of pSrc1[0]*pSrc2[j+3]

    stp     X_11, X_15, [X_4, #16]      // Store to destination

    cbnz    X_3, SymCryptFdefRawMulAsmLoopInner1

    adc     X_12, X_12, xzr             // Store the next word into the destination (with the carry if any)
    str     X_12, [X_4, #32]

    sub     X_1, X_1, #1                // move one word up
    add     X_0, X_0, #8                // move start of pSrc1 one word up
    add     X_5, X_5, #8                // move start of pDst one word up

    //
    // MAIN LOOP
    //
LABEL(SymCryptFdefRawMulAsmLoopOuter)
    mov     X_3, X_14                   // set nDigits2
    mov     X_2, X_13                   // set pSrc2
    mov     X_4, X_5                    // set pDst

    ands    X_12, X_12, xzr             // Clearing the carry flag and setting X_12 = 0
    ldr     X_6, [X_0]                  // load the next word from pSrc1

LABEL(SymCryptFdefRawMulAsmLoopInner)
    sub     X_3, X_3, #1                // move one digit up

    ldp     X_7, X_8, [X_2, #32]!       // load 2 words from pSrc2
    ldp     X_9, X_10, [X_4, #32]!      // load 2 words from pDst

    adcs    X_9, X_9, X_12              // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_11, X_6, X_7              // Bits <127:64> of pSrc1[i]*pSrc2[j]
    adcs    X_10, X_11, X_10            // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_12, X_6, X_8              // Bits <127:64> of pSrc1[i]*pSrc2[j+1]
    adc     X_12, X_12, xzr             // Add the carry if any and don't update the flags

    mul     X_11, X_6, X_7              // Bits <63:0> of pSrc1[i]*pSrc2[j]
    adds    X_9, X_9, X_11              // add the word from the destination and update the flags (this can overflow)
    mul     X_11, X_6, X_8              // Bits <63:0> of pSrc1[i]*pSrc2[j+1]
    adcs    X_10, X_10, X_11            // add the word from the destination and update the flags (this can overflow)

    stp     X_9, X_10, [X_4]            // Store to destination

    ldp     X_7, X_8, [X_2, #16]        // load 2 words from pSrc2
    ldp     X_9, X_10, [X_4, #16]       // load 2 words from pDst

    adcs    X_9, X_9, X_12              // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_11, X_6, X_7              // Bits <127:64> of pSrc1[i]*pSrc2[j+2]
    adcs    X_10, X_11, X_10            // Adding the previous word (if there was a carry from the last addition it is added)
    umulh   X_12, X_6, X_8              // Bits <127:64> of pSrc1[i]*pSrc2[j+3]
    adc     X_12, X_12, xzr             // Add the carry if any and don't update the flags

    mul     X_11, X_6, X_7              // Bits <63:0> of pSrc1[i]*pSrc2[j+2]
    adds    X_9, X_9, X_11              // add the word from the destination and update the flags (this can overflow)
    mul     X_11, X_6, X_8              // Bits <63:0> of pSrc1[i]*pSrc2[j+3]
    adcs    X_10, X_10, X_11            // add the word from the destination and update the flags (this can overflow)

    stp     X_9, X_10, [X_4, #16]       // Store to destination

    cbnz    X_3, SymCryptFdefRawMulAsmLoopInner

    adc     X_12, X_12, xzr             // Store the next word into the destination (with the carry if any)
    str     X_12, [X_4, #32]

    subs    X_1, X_1, #1                // move one word up
    add     X_0, X_0, #8                // move start of pSrc1 one word up
    add     X_5, X_5, #8                // move start of pDst one word up

    bne     SymCryptFdefRawMulAsmLoopOuter

    // Done, no return value

    ret
    LEAF_END ARM64EC_NAME_MANGLE(SymCryptFdefRawMulAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2
#undef X_3
#undef W_3
#undef X_4
#undef W_4
#undef X_5
#undef W_5
#undef X_6
#undef W_6
#undef X_7
#undef W_7
#undef X_8
#undef W_8
#undef X_9
#undef W_9
#undef X_10
#undef W_10
#undef X_11
#undef W_11
#undef X_12
#undef W_12
#undef X_13
#undef W_13
#undef X_14
#undef W_14
#undef X_15
#undef W_15

    // Macro for the first loop of the first pass of RawSquareAsm.
    // It takes one word from the source, multiplies it with the mulword,
    // adds the high level word of the previous macro call, and stores it into
    // the destination.
    //
    // No carry flag is propagated from the previous macro call as the maximum is
    // (2^64-1)^2 + 2^64-1 = 2^128 - 2^64
    MACRO
    SQR_SINGLEADD_64 $index, $src_reg, $dst_reg, $mul_word, $src_carry, $dst_carry, $scratch0, $scratch1
    ldr     $scratch0, [$src_reg, #8*$index]   // pSrc[i+j]

    mul     $scratch1, $mul_word, $scratch0    // Bits <63:0> of pSrc[i]*pSrc[i+j]
    adds    $scratch1, $scratch1, $src_carry   // Adding the previous word
    umulh   $dst_carry, $mul_word, $scratch0   // Bits <127:64> of pSrc[i]*pSrc[i+j]
    adc     $dst_carry, $dst_carry, xzr       // Add the intermediate carry and don't update the flags

    str     $scratch1, [$dst_reg, #8*$index]   // Store to destination

    MEND

    // Macro for the remaining loops of the first pass of RawSquareAsm.
    // The only difference to the above is that it also adds the word loaded
    // from the destination buffer.
    //
    // No carry flag is propagated from the previous macro call as the maximum is
    // (2^64-1)^2 + 2(2^64-1) = 2^128 - 1
    MACRO
    SQR_DOUBLEADD_64 $index, $src_reg, $dst_reg, $mul_word, $src_carry, $dst_carry, $scratch0, $scratch1, $scratch2
    ldr     $scratch0, [$src_reg, #8*$index]   // pSrc[i+j]
    ldr     $scratch2, [$dst_reg, #8*$index]   // pDst[2*(i+j)]

    mul     $scratch1, $mul_word, $scratch0    // Bits <63:0> of pSrc[i]*pSrc[i+j]
    adds    $scratch1, $scratch1, $src_carry   // Adding the previous word
    umulh   $dst_carry, $mul_word, $scratch0   // Bits <127:64> of pSrc[i]*pSrc[i+j]
    adc     $dst_carry, $dst_carry, xzr       // Add the intermediate carry and don't update the flags

    adds    $scratch1, $scratch1, $scratch2    // Add the word from the destination
    adc     $dst_carry, $dst_carry, xzr       // Add the intermediate carry and don't update the flags

    str     $scratch1, [$dst_reg, #8*$index]   // Store to destination

    MEND

    // Macro for the third pass loop of RawSquareAsm.
    // It takes one mulword from the source, squares it, and
    // adds it to the even columns of the destination. The carries are propagated
    // to the odd columns.
    //
    // Here we can have a (1-bit) carry to the next call because the maximum value for
    // a pair of columns is (2^64-1)^2+(2^128-1)+1 = 2^129 - 2^65 + 1 < 2^129 - 1
    MACRO
    SQR_DIAGONAL_PROP $index, $src_reg, $dst_reg, $squarelo, $squarehi, $scratch0, $scratch1
    ldr     $squarehi, [$src_reg, #8*$index]               // mulword
    mul     $squarelo, $squarehi, $squarehi                // Bits <63:0> of m^2
    umulh   $squarehi, $squarehi, $squarehi                // Bits <127:64> of m^2

    ldp     $scratch0, $scratch1, [$dst_reg, #16*$index]    // Load

    // Adding the square to the even column
    adcs    $squarelo, $squarelo, $scratch0                // carry from previous and update the flags

    // Propagating the sum to the next column
    adcs    $squarehi, $squarehi, $scratch1                // This can generate a carry

    stp     $squarelo, $squarehi, [$dst_reg, #16*$index]    // Store

    MEND

//VOID
//SYMCRYPT_CALL
//SymCryptFdefRawSquareAsm(
//    _In_reads_(nDigits*SYMCRYPT_FDEF_DIGIT_NUINT32)     PCUINT32    pSrc,
//                                                        UINT32      nDigits,
//    _Out_writes_(2*nDigits*SYMCRYPT_FDEF_DIGIT_NUINT32) PUINT32     pDst )
//
// Register assignments
//       X_0  = pSrc
//       X_1  = word count of pSrc
//       X_2  = pSrc (moving forward one digit / 4 words every inner loop)
//       X_3  = digit count of pSrc
//       X_4  = pDst (moving forward one digit every inner loop)
//       X_5  = pDst (moving forward one word every outer loop)
//       X_6  = Current word loaded from pSrc
//       X_7, X_8   = Current words loaded in pairs from pSrc2
//       X_9, X_10  = Current words loaded in pairs from pDst
//       X_11, X_12 = "128-bit" sliding register to hold the result of multiplies
//       X_13 = Stored pSrc
//       X_14 = Digit count of pSrc
//       X_15 = Stored digit count of pSrc
//       X_16 = Stored pDst

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
#define X_3 x3
#define W_3 w3
#define X_4 x4
#define W_4 w4
#define X_5 x5
#define W_5 w5
#define X_6 x6
#define W_6 w6
#define X_7 x7
#define W_7 w7
#define X_8 x8
#define W_8 w8
#define X_9 x9
#define W_9 w9
#define X_10 x10
#define W_10 w10
#define X_11 x11
#define W_11 w11
#define X_12 x12
#define W_12 w12
#define X_13 x15
#define W_13 w15
#define X_14 x16
#define W_14 w16
#define X_15 x17
#define W_15 w17
#define X_16 x19
#define W_16 w19
    NESTED_ENTRY ARM64EC_NAME_MANGLE(SymCryptFdefRawSquareAsm)
    PROLOG_SAVE_REG_PAIR fp, lr, #-32! // allocate 32 bytes of stack; store FP/LR
    PROLOG_SAVE_REG      X_16, #16

    mov     X_3, X_1                    // digit count into X_3

    lsl     X_1, X_1, #2                // Calculate word count

    mov     X_4, X_2                    // pDst
    mov     X_5, X_2                    // store pDst
    mov     X_16, X_2                   // store pDst
    mov     X_13, X_0                   // store pSrc
    mov     X_2, X_0                    // inner loop pSrc
    mov     X_14, X_3                   // store nDigits for later
    mov     X_15, X_3                   // store nDigits for later

    //
    // First iteration of main loop (no adding of previous values from pDst)
    //
    ands    X_12, X_12, xzr             // Clearing the carry flag and setting X_12 = 0
    ldr     X_6, [X_0]                  // load the first word from pSrc1
    str     X_12, [X_4]                 // store 0 for the first word

    b       SymCryptFdefRawSquareAsmInnerLoopInit_Word1

LABEL(SymCryptFdefRawSquareAsmInnerLoopInit_Word0)
    SQR_SINGLEADD_64 0, X_2, X_4, X_6, X_12, X_12, X_7, X_8

LABEL(SymCryptFdefRawSquareAsmInnerLoopInit_Word1)
    SQR_SINGLEADD_64 1, X_2, X_4, X_6, X_12, X_12, X_7, X_8

    SQR_SINGLEADD_64 2, X_2, X_4, X_6, X_12, X_12, X_7, X_8

    SQR_SINGLEADD_64 3, X_2, X_4, X_6, X_12, X_12, X_7, X_8

    sub     X_3, X_3, #1                // move one digit up
    add     X_2, X_2, #32
    add     X_4, X_4, #32

    cbnz    X_3, SymCryptFdefRawSquareAsmInnerLoopInit_Word0

    str     X_12, [X_4]                 // Store the next word into the destination

    sub     X_1, X_1, #2                // move two words up (we started at the word 1)

    mov     X_8, #1                     // Cyclic counter

    //
    // MAIN LOOP
    //
LABEL(SymCryptFdefRawSquareAsmOuterLoop)

    add     X_5, X_5, #8                // move start of pDst one word up

    mov     X_3, X_14                   // set nDigits
    mov     X_2, X_0                    // set pSrc
    mov     X_4, X_5                    // set pDst

    ands    X_12, X_12, xzr             // Clearing the carry flag and setting X_12 = 0
    ldr     X_6, [X_0, X_8, LSL #3]     // load the next word from pSrc

    // Cyclic counter and jump logic
    add     X_8, X_8, #1
    cmp     X_8, #1
    beq     SymCryptFdefRawSquareAsmInnerLoop_Word1
    cmp     X_8, #2
    beq     SymCryptFdefRawSquareAsmInnerLoop_Word2
    cmp     X_8, #3
    beq     SymCryptFdefRawSquareAsmInnerLoop_Word3

    // The following instructions are only executed when X_8 == 4
    mov     X_8, xzr                // Set it to 0

    add     X_0, X_0, #32           // move start of pSrc 4 words up
    add     X_5, X_5, #32           // move pDst 4 words up

    mov     X_2, X_0                // set pSrc
    mov     X_4, X_5                // set pDst

    sub     X_14, X_14, #1          // remove 1 digit
    mov     X_3, X_14               // set the new digit counter

LABEL(SymCryptFdefRawSquareAsmInnerLoop_Word0)
    SQR_DOUBLEADD_64 0, X_2, X_4, X_6, X_12, X_12, X_7, X_9, X_10

LABEL(SymCryptFdefRawSquareAsmInnerLoop_Word1)
    SQR_DOUBLEADD_64 1, X_2, X_4, X_6, X_12, X_12, X_7, X_9, X_10

LABEL(SymCryptFdefRawSquareAsmInnerLoop_Word2)
    SQR_DOUBLEADD_64 2, X_2, X_4, X_6, X_12, X_12, X_7, X_9, X_10

LABEL(SymCryptFdefRawSquareAsmInnerLoop_Word3)
    SQR_DOUBLEADD_64 3, X_2, X_4, X_6, X_12, X_12, X_7, X_9, X_10

    sub     X_3, X_3, #1                // move one digit up
    add     X_2, X_2, #32
    add     X_4, X_4, #32

    cbnz    X_3, SymCryptFdefRawSquareAsmInnerLoop_Word0

    str     X_12, [X_4]                 // Store the next word into the destination

    sub     X_1, X_1, #1                // move one word up
    cbnz    X_1, SymCryptFdefRawSquareAsmOuterLoop

    ands    X_12, X_12, xzr             // Setting X_12 = 0
    str     X_12, [X_5, #40]            // Store 0 to destination for the top word

    ////////////////////////////////////////////////////////////////
    // Second Pass - Shifting all results 1 bit left
    ////////////////////////////////////////////////////////////////

    mov     X_3, X_15       // nDigits
    lsl     X_3, X_3, #1    // Double digits
    mov     X_4, X_16       // pDst pointer
    ands    X_7, X_7, xzr   // Clear the flags

LABEL(SymCryptFdefRawSquareAsmSecondPass)

    sub     X_3, X_3, #1    // move one digit up

    ldp     X_7, X_8, [X_4]
    adcs    X_7, X_7, X_7   // Shift left and add the carry
    adcs    X_8, X_8, X_8
    stp     X_7, X_8, [X_4], #16

    ldp     X_9, X_10, [X_4]
    adcs    X_9, X_9, X_9   // Shift left and add the carry
    adcs    X_10, X_10, X_10
    stp     X_9, X_10, [X_4], #16

    cbnz    X_3, SymCryptFdefRawSquareAsmSecondPass

    //////////////////////////////////////////////////////////////////////////////
    // Third Pass - Adding the squares on the even columns and propagating the sum
    //////////////////////////////////////////////////////////////////////////////

    ands    X_7, X_7, xzr   // Clear the flags
    mov     X_0, X_13       // src pointer
    mov     X_4, X_16       // pDst pointer
    mov     X_3, X_15       // nDigits

LABEL(SymCryptFdefRawSquareAsmThirdPass)
    SQR_DIAGONAL_PROP 0, X_0, X_4, X_6, X_7, X_8, X_9
    SQR_DIAGONAL_PROP 1, X_0, X_4, X_6, X_7, X_8, X_9
    SQR_DIAGONAL_PROP 2, X_0, X_4, X_6, X_7, X_8, X_9
    SQR_DIAGONAL_PROP 3, X_0, X_4, X_6, X_7, X_8, X_9

    sub     X_3, X_3, #1        // move one digit up
    add     X_0, X_0, #32       // One digit up (not updated in SQR_DIAGONAL_PROP)
    add     X_4, X_4, #64       // Two digits up (not updated in SQR_DIAGONAL_PROP)

    cbnz    X_3, SymCryptFdefRawSquareAsmThirdPass

    // Done, no return value

    EPILOG_RESTORE_REG      X_16, #16
    EPILOG_RESTORE_REG_PAIR fp, lr, #32! // deallocate 32 bytes of stack; restore FP/LR
    EPILOG_RETURN
    NESTED_END ARM64EC_NAME_MANGLE(SymCryptFdefRawSquareAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2
#undef X_3
#undef W_3
#undef X_4
#undef W_4
#undef X_5
#undef W_5
#undef X_6
#undef W_6
#undef X_7
#undef W_7
#undef X_8
#undef W_8
#undef X_9
#undef W_9
#undef X_10
#undef W_10
#undef X_11
#undef W_11
#undef X_12
#undef W_12
#undef X_13
#undef W_13
#undef X_14
#undef W_14
#undef X_15
#undef W_15
#undef X_16
#undef W_16

//VOID
//SYMCRYPT_CALL
//SymCryptFdefMontgomeryReduceAsm(
//    _In_                            PCSYMCRYPT_MODULUS      pmMod,
//    _Inout_                         PUINT32                 pSrc,
//    _Out_                           PUINT32                 pDst )
//
// Register assignments
//       X_0  = pMod (moving forward one *digit* every inner loop)
//       X_1  = pSrc (moving forward one *digit* every inner loop)
//       X_2  = pDst (used only in the end for subtract / result)
//       X_3  = digit count of pSrc and pMod
//       X_4  = word count of pSrc
//       X_5  = Inv64 of the modulus
//       X_6  = m = pSrc[i]*Inv64
//       X_7  = hc = high carry variable
//       X_8, X_9   = Current words loaded in pairs from pSrc
//       X_10, X_11 = Current words loaded in pairs from pMod
//       X_12, X_13 = c variable = "128-bit" register to hold the result of multiplies
//                  It is flipped between [X_12:X_13] and [X_13:X_12] instead of doing c>>=64
//       X_14 = Temporary intermediate result
//       X_15 = Stored digit count of pSrc
//       X_16 = Stored pMod pointer
//       X_17 = Stored pSrc pointer (moving forward one word every outer loop)

#define X_0 x0
#define W_0 w0
#define X_1 x1
#define W_1 w1
#define X_2 x2
#define W_2 w2
#define X_3 x3
#define W_3 w3
#define X_4 x4
#define W_4 w4
#define X_5 x5
#define W_5 w5
#define X_6 x6
#define W_6 w6
#define X_7 x7
#define W_7 w7
#define X_8 x8
#define W_8 w8
#define X_9 x9
#define W_9 w9
#define X_10 x10
#define W_10 w10
#define X_11 x11
#define W_11 w11
#define X_12 x12
#define W_12 w12
#define X_13 x15
#define W_13 w15
#define X_14 x16
#define W_14 w16
#define X_15 x17
#define W_15 w17
#define X_16 x19
#define W_16 w19
#define X_17 x20
#define W_17 w20
    NESTED_ENTRY ARM64EC_NAME_MANGLE(SymCryptFdefMontgomeryReduceAsm)
    PROLOG_SAVE_REG_PAIR fp, lr, #-32! // allocate 32 bytes of stack; store FP/LR
    PROLOG_SAVE_REG_PAIR X_16, X_17, #16

    ldr     W_3, [X_0, #SymCryptModulusNdigitsOffsetArm64]          // # of Digits
    ldr     X_5, [X_0, #SymCryptModulusMontgomeryInv64OffsetArm64]  // Inv64 of modulus
    add     X_0, X_0, #SymCryptModulusValueOffsetArm64              // pMod

    lsl     X_4, X_3, #2                // Multiply by 4 to get the number of words

    sub     X_0, X_0, #32               // offset pMod so we can use pre-increment form of loads
    sub     X_1, X_1, #32               // offset pSrc so we can use pre-increment form of loads
    sub     X_2, X_2, #32               // offset pDst so we can use pre-increment form of loads

    mov     X_15, X_3                   // Store the digit count for later
    mov     X_16, X_0                   // Store the pMod pointer
    mov     X_17, X_1                   // Store the pSrc pointer

    and     X_7, X_7, xzr               // Set hc to 0

    //
    // Main loop
    //
LABEL(SymCryptFdefMontgomeryReduceAsmOuter)
    ldr     X_8, [X_1, #32]             // Load 1 word from pSrc
    mul     X_6, X_8, X_5               // <63:0> bits of pSrc[i]*Inv64 = m

    and     X_12, X_12, xzr             // Set c to 0

LABEL(SymCryptFdefMontgomeryReduceAsmInner)
    ldp     X_10, X_11, [X_0, #32]!     // pMod[j]
    ldp     X_8, X_9, [X_1, #32]!       // pSrc[j]

    mul     X_14, X_6, X_10             // <63:0> of pMod[j]*m
    adds    X_14, X_14, X_8             // Adding pSrc[j]
    umulh   X_13, X_6, X_10             // <127:64> of pMod[j]*m
    adc     X_13, X_13, xzr             // Add the carry if any (***)
    adds    X_12, X_12, X_14            // Add the lower bits of c
    adc     X_13, X_13, xzr             // Add the carry if any (***)
    // ***: These cannot produce extra carry as the maximum is
    //      (2^64 - 1)*(2^64-1) + 2^64-1 + 2^64-1 = 2^128 - 1
    str     X_12, [X_1]                 // pSrc[j] = (UINT64) c

    mul     X_14, X_6, X_11             // <63:0> of pMod[j]*m
    adds    X_14, X_14, X_9             // Adding pSrc[j]
    umulh   X_12, X_6, X_11             // <127:64> of pMod[j]*m
    adc     X_12, X_12, xzr             // Add the carry if any (***)
    adds    X_13, X_13, X_14            // Add the lower bits of c
    adc     X_12, X_12, xzr             // Add the carry if any (***)
    str     X_13, [X_1, #8]             // pSrc[j] = (UINT64) c

    ldp     X_10, X_11, [X_0, #16]      // pMod[j]
    ldp     X_8, X_9, [X_1, #16]        // pSrc[j]

    mul     X_14, X_6, X_10             // <63:0> of pMod[j]*m
    adds    X_14, X_14, X_8             // Adding pSrc[j]
    umulh   X_13, X_6, X_10             // <127:64> of pMod[j]*m
    adc     X_13, X_13, xzr             // Add the carry if any (***)
    adds    X_12, X_12, X_14            // Add the lower bits of c
    adc     X_13, X_13, xzr             // Add the carry if any (***)
    str     X_12, [X_1, #16]            // pSrc[j] = (UINT64) c

    mul     X_14, X_6, X_11             // <63:0> of pMod[j]*m
    adds    X_14, X_14, X_9             // Adding pSrc[j]
    umulh   X_12, X_6, X_11             // <127:64> of pMod[j]*m
    adc     X_12, X_12, xzr             // Add the carry if any (***)
    adds    X_13, X_13, X_14            // Add the lower bits of c
    adc     X_12, X_12, xzr             // Add the carry if any (***)
    str     X_13, [X_1, #24]            // pSrc[j] = (UINT64) c

    subs    X_3, X_3, #1                // Move one digit up
    bne     SymCryptFdefMontgomeryReduceAsmInner

    ldr     X_8, [X_1, #32]             // pSrc[nWords]
    adds    X_12, X_12, X_8             // c + pSrc[nWords]
    adc     X_13, xzr, xzr              // Add the carry if any

    adds    X_12, X_12, X_7             // c + pSrc[nWords] + hc
    adc     X_7, X_13, xzr              // Add the carry if any and store into hc

    str     X_12, [X_1, #32]            // pSrc[nWords] = c

    subs    X_4, X_4, #1                // Move one word up

    add     X_17, X_17, #8              // Move stored pSrc pointer one word up
    mov     X_0, X_16                   // Restore pMod pointer
    mov     X_1, X_17                   // Restore pSrc pointer

    mov     X_3, X_15                   // Restore the digit counter

    bne     SymCryptFdefMontgomeryReduceAsmOuter

    //
    // Subtraction
    //

    mov     X_14, X_2               // Store pDst pointer

    // Prepare the pointers for subtract
    mov     X_0, X_17               // pSrc
    mov     X_1, X_16               // pMod

    mov     X_10, X_7               // X_10 = hc
    mov     X_3, X_15               // Restore the digit counter
    subs    X_4, X_4, X_4           // Set the carry flag (i.e. no borrow)

LABEL(SymCryptFdefMontgomeryReduceRawSubAsmLoop)
    sub     X_3, X_3, #1            // Decrement the digit count by one
    // borrow is in the carry flag (flipped)

    ldp     X_4, X_6, [X_0, #32]!   // Load two words of pSrc1
    ldp     X_5, X_7, [X_1, #32]!   // Load two words of pSrc2
    sbcs    X_4, X_4, X_5
    sbcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #32]!   // Store the result in the destination

    ldp     X_4, X_6, [X_0, #16]    // Load two words of pSrc1
    ldp     X_5, X_7, [X_1, #16]    // Load two words of pSrc2
    sbcs    X_4, X_4, X_5
    sbcs    X_6, X_6, X_7
    stp     X_4, X_6, [X_2, #16]    // Store the result in the destination

    cbnz    X_3, SymCryptFdefMontgomeryReduceRawSubAsmLoop

    cset    X_0, cc                 // If the carry is clear (borrow), set the return value to 1

    orr     X_11, X_10, X_0         // X_11 = hc|d

    // Prepare the pointers for masked copy
    mov     X_0, X_17               // pSrc
    mov     X_1, X_14               // pDst

    mov     X_2, X_15               // Restore the digit counter
    subs    X_4, X_10, X_11         // If (X_11 > X_10) clear the carry flag (i.e. borrow)

LABEL(SymCryptFdefMontgomeryReduceMaskedCopyAsmLoop)
    sub     X_2, X_2, #1            // decrement the digit count by one

    ldp     X_4, X_6, [X_0, #32]!   // Load two words of the source
    ldp     X_5, X_7, [X_1, #32]!   // Load two words of the destination
    csel    X_4, X_4, X_5, cc       // If the carry is clear, select the source operands
    csel    X_6, X_6, X_7, cc
    stp     X_4, X_6, [X_1]         // Store the two words in the destination

    ldp     X_4, X_6, [X_0, #16]
    ldp     X_5, X_7, [X_1, #16]
    csel    X_4, X_4, X_5, cc
    csel    X_6, X_6, X_7, cc
    stp     X_4, X_6, [X_1, #16]

    cbnz    X_2, SymCryptFdefMontgomeryReduceMaskedCopyAsmLoop

    // Done, no return value

    EPILOG_RESTORE_REG_PAIR X_16, X_17, #16
    EPILOG_RESTORE_REG_PAIR fp, lr, #32! // deallocate 32 bytes of stack; restore FP/LR
    EPILOG_RETURN
    NESTED_END ARM64EC_NAME_MANGLE(SymCryptFdefMontgomeryReduceAsm)
#undef X_0
#undef W_0
#undef X_1
#undef W_1
#undef X_2
#undef W_2
#undef X_3
#undef W_3
#undef X_4
#undef W_4
#undef X_5
#undef W_5
#undef X_6
#undef W_6
#undef X_7
#undef W_7
#undef X_8
#undef W_8
#undef X_9
#undef W_9
#undef X_10
#undef W_10
#undef X_11
#undef W_11
#undef X_12
#undef W_12
#undef X_13
#undef W_13
#undef X_14
#undef W_14
#undef X_15
#undef W_15
#undef X_16
#undef W_16
#undef X_17
#undef W_17

    FILE_END()
