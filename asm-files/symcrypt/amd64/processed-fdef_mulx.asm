//
//  fdef_mulx.symcryptasm   Assembler code for large integer arithmetic in the default data format
//  using the bmi2 instructions mulx, adcx and adox
//  Expresses asm in a generic enough way to enable generation of MASM and GAS using the
//  symcryptasm_processor.py script and C preprocessor
//
// Copyright (c) Microsoft Corporation. Licensed under the MIT license.
//

#include "symcryptasm_shared.cppasm"

ZEROREG MACRO  R
        xor     R,R
ENDM

ZEROREG_8 MACRO  R0, R1, R2, R3, R4, R5, R6, R7
    ZEROREG R0
    ZEROREG R1
    ZEROREG R2
    ZEROREG R3
    ZEROREG R4
    ZEROREG R5
    ZEROREG R6
    ZEROREG R7
ENDM

MULADD18 MACRO  R0, R1, R2, R3, R4, R5, R6, R7, pD, pA, pB, T0, T1, QH
    // R0:R[7:1]:D[0] = A[7:0] * B[0] + D[0] + R[7:0]
    // Pre: Cy = Ov = 0
    // Post: Cy = Ov = 0

    mov     QH, [pB]
    adox    R0, [pD]

    mulx    T1, T0, [pA + 0 * 8]
    adcx    R0, T0
    adox    R1, T1

    mulx    T1, T0, [pA + 1 * 8]
    adcx    R1, T0
    adox    R2, T1

    mulx    T1, T0, [pA + 2 * 8]
    adcx    R2, T0
    adox    R3, T1

    mulx    T1, T0, [pA + 3 * 8]
    adcx    R3, T0
    adox    R4, T1

    mulx    T1, T0, [pA + 4 * 8]
    adcx    R4, T0
    adox    R5, T1

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R5, T0
    adox    R6, T1

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R6, T0
    adox    R7, T1

    mulx    T1, T0, [pA + 7 * 8]
    adcx    R7, T0
    mov     [pD], R0

    mov     R0, 0
    adcx    R0, R0
    adox    R0, T1
ENDM

MULADD88 MACRO  R0, R1, R2, R3, R4, R5, R6, R7, pD, pA, pB, T0, T1, QH
    // pre & post: Cy = Ov = 0
    // R[7-0]:D[7-0] = A[7:0] * B[7:0] + R[7:0] + D[7:0]

    MULADD18    R0, R1, R2, R3, R4, R5, R6, R7, pD     , pA, pB     , T0, T1, QH
    MULADD18    R1, R2, R3, R4, R5, R6, R7, R0, pD +  8, pA, pB +  8, T0, T1, QH
    MULADD18    R2, R3, R4, R5, R6, R7, R0, R1, pD + 16, pA, pB + 16, T0, T1, QH
    MULADD18    R3, R4, R5, R6, R7, R0, R1, R2, pD + 24, pA, pB + 24, T0, T1, QH
    MULADD18    R4, R5, R6, R7, R0, R1, R2, R3, pD + 32, pA, pB + 32, T0, T1, QH
    MULADD18    R5, R6, R7, R0, R1, R2, R3, R4, pD + 40, pA, pB + 40, T0, T1, QH
    MULADD18    R6, R7, R0, R1, R2, R3, R4, R5, pD + 48, pA, pB + 48, T0, T1, QH
    MULADD18    R7, R0, R1, R2, R3, R4, R5, R6, pD + 56, pA, pB + 56, T0, T1, QH
ENDM


HALF_SQUARE_NODIAG8 MACRO  R0, R1, R2, R3, R4, R5, R6, R7, pD, pA, T0, T1, QH
    // pre & post: Cy = Ov = 0
    // R[7-0]:D[7-0] = D[7:0] + (A[0:7]^2 - \sum_{i=0}^7 (A[i] * 2^{64*i}) )/2
    // This is the component of the square that needs to be doubled, and then the diagonals added

    // Note that Dst[0] is not changed by this macro

    mov     QH, [pA + 0 * 8]            // QH = A0
    mov     R1, [pD + 1 * 8]
    mov     R2, [pD + 2 * 8]
    mov     R3, [pD + 3 * 8]
    mov     R4, [pD + 4 * 8]
    mov     R5, [pD + 5 * 8]
    mov     R6, [pD + 6 * 8]
    mov     R7, [pD + 7 * 8]
    xor     R0, R0

    mulx    T1, T0, [pA + 1 * 8]
    adcx    R1, T0
    adox    R2, T1

    mulx    T1, T0, [pA + 2 * 8]
    adcx    R2, T0
    adox    R3, T1

    mulx    T1, T0, [pA + 3 * 8]
    adcx    R3, T0
    adox    R4, T1

    mulx    T1, T0, [pA + 4 * 8]
    adcx    R4, T0
    adox    R5, T1

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R5, T0
    adox    R6, T1

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R6, T0
    adox    R7, T1

    mulx    T1, T0, [pA + 7 * 8]
    adcx    R7, T0
    mov     [pD + 1 * 8], R1

    adcx    R0, R0
    adox    R0, T1
    mov     [pD + 2 * 8], R2
    mov     QH, [pA + 1 * 8]        // QH = A1

    //=======

    mulx    T1, T0, [pA + 2 * 8]
    adcx    R3, T0
    adox    R4, T1

    mulx    T1, T0, [pA + 3 * 8]
    adcx    R4, T0
    adox    R5, T1

    mulx    T1, T0, [pA + 4 * 8]
    adcx    R5, T0
    adox    R6, T1

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R6, T0
    adox    R7, T1

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R7, T0
    adox    R0, T1

    mov     QH, [pA + 7 * 8]        // QH = A7
    mov     R1, 0
    mov     R2, 0
    mov     [pD + 3 * 8], R3

    mulx    T1, T0, [pA + 1 * 8]
    adcx    R0, T0
    adox    R1, T1                  // doesn't produce Ov as T1 <= 0xff..fe and R1=0

    mulx    T1, T0, [pA + 2 * 8]
    adcx    R1, T0
    mov     [pD + 4 * 8], R4

    adcx    R2, T1
    mov     QH, [pA + 2 * 8]        // QH = A2

    //======

    mulx    T1, T0, [pA + 3 * 8]
    adcx    R5, T0
    adox    R6, T1

    mulx    T1, T0, [pA + 4 * 8]
    adcx    R6, T0
    adox    R7, T1

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R7, T0
    adox    R0, T1

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R0, T0
    adox    R1, T1

    mov     QH, [pA + 4 * 8]        // QH = A4
    mov     R3, 0
    mov     R4, 0

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R1, T0
    adox    R2, T1

    mulx    T1,T0, [pA + 6 * 8]
    adcx    R2, T0
    adox    R3, T1                  // doesn't produce Ov as T1 <= 0xff..fe and R3=0

    mov     QH, [pA + 5 * 8]        // QH = A5
    mov     [pD + 5 * 8], R5

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R3, T0
    adcx    R4, T1

    mov     QH, [pA + 3 * 8]        // QH = A3
    mov     [pD + 6 * 8], R6

    //======

    mulx    T1, T0, [pA + 4 * 8]
    adcx    R7, T0
    adox    R0, T1

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R0, T0
    adox    R1, T1

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R1, T0
    adox    R2, T1

    mulx    T1, T0, [pA + 7 * 8]
    adcx    R2, T0
    adox    R3, T1

    mov     QH, [pA + 7 * 8]        // QH = A7
    mov     R5, 0
    mov     R6, 0
    mov     [pD + 7 * 8], R7

    mulx    T1, T0, [pA + 4 * 8]
    adcx    R3, T0
    adox    R4, T1

    mulx    T1, T0, [pA + 5 * 8]
    adcx    R4, T0
    adox    R5, T1                  // doesn't produce Ov as T1 <= 0xff..fe and R5=0

    mulx    T1, T0, [pA + 6 * 8]
    adcx    R5, T0
    adcx    R6, T1

    xor     R7, R7
ENDM

MONTGOMERY18 MACRO  R0, R1, R2, R3, R4, R5, R6, R7, modInv, pMod, pMont, T0, T1, QH
    // Mont[0] = (modinv * R0 mod 2^64)
    // R0:R[7:1]:<phantom> = Mont[0] * Mod[7:0] + R[7:0]
    // Pre: -
    // Post: -

    mov     QH, R0
    imul    QH, modInv

    // Rather than add the low half of the first mulx to R0 we can go ahead and set
    // up the Cy flag appropriately based on R0 directly (the addition will always
    // result in 0 by construction), so we can have the result while imul is running

    // This has a small but measurable perf improvement on SKLX (~2% improvement for
    // 512b modmul)
    // and it seems unlikely that it can make the performance worse
    // My best guess as to why is that allowing this to execute a few cycles early
    // can reduce port contention when the macro is being speculatively executed
    or      T0, -1          // Clear Cy and Ov
    adcx    R0, T0          // Set Cy when R0 is non-zero
    mov     R0, 0
    mov     [pMont], QH

    mulx    T1, T1, [pMod + 0 * 8]
    adox    R1, T1

    mulx    T1, T0, [pMod + 1 * 8]
    adcx    R1, T0
    adox    R2, T1

    mulx    T1, T0, [pMod + 2 * 8]
    adcx    R2, T0
    adox    R3, T1

    mulx    T1, T0, [pMod + 3 * 8]
    adcx    R3, T0
    adox    R4, T1

    mulx    T1, T0, [pMod + 4 * 8]
    adcx    R4, T0
    adox    R5, T1

    mulx    T1, T0, [pMod + 5 * 8]
    adcx    R5, T0
    adox    R6, T1

    mulx    T1, T0, [pMod + 6 * 8]
    adcx    R6, T0
    adox    R7, T1

    mulx    T1, T0, [pMod + 7 * 8]
    adcx    R7, T0

    adcx    R0, R0
    adox    R0, T1
ENDM

SYMCRYPT_SQUARE_DIAG MACRO  index, src_reg, dest_reg, T0, T1, T2, T3, QH
    mov     QH, [src_reg + 8 * index]
    mov     T0, [dest_reg + 16 * index]
    mov     T1, [dest_reg + 16 * index + 8]
    mulx    T3, T2, QH
    adcx    T2, T0
    adox    T2, T0
    adcx    T3, T1
    adox    T3, T1
    mov     [dest_reg + 16 * index], T2
    mov     [dest_reg + 16 * index + 8], T3
ENDM

// VOID
// SYMCRYPT_CALL
// SymCryptFdefRawMulMulx(
//     _In_reads_(nDigits1*SYMCRYPT_FDEF_DIGIT_NUINT32)                PCUINT32    pSrc1,
//                                                                     UINT32      nDigits1,
//     _In_reads_(nDigits2*SYMCRYPT_FDEF_DIGIT_NUINT32)                PCUINT32    pSrc2,
//                                                                     UINT32      nDigits2,
//     _Out_writes_((nDigits1+nDigits2)*SYMCRYPT_FDEF_DIGIT_NUINT32)   PUINT32     pDst )

#define QH rdx
#define DH edx
#define WH dx
#define BH dl
#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q2 r10
#define D2 r10d
#define W2 r10w
#define B2 r10b
#define Q5 r11
#define D5 r11d
#define W5 r11w
#define B5 r11b
#define Q6 rsi
#define D6 esi
#define W6 si
#define B6 sil
#define Q7 rdi
#define D7 edi
#define W7 di
#define B7 dil
#define Q8 rbp
#define D8 ebp
#define W8 bp
#define B8 bpl
#define Q9 rbx
#define D9 ebx
#define W9 bx
#define B9 bl
#define Q10 r12
#define D10 r12d
#define W10 r12w
#define B10 r12b
#define Q11 r13
#define D11 r13d
#define W11 r13w
#define B11 r13b
#define Q12 r14
#define D12 r14d
#define W12 r14w
#define B12 r14b
#define Q13 r15
#define D13 r15d
#define W13 r15w
#define B13 r15b
NESTED_ENTRY SymCryptFdefRawMulMulx, _TEXT

rex_push_reg Q6
push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12
push_reg Q13

END_PROLOGUE

mov Q2, QH
mov Q5, [rsp + 104]

        shl     Q4, 6
        mov     [rsp + 72 /*MEMSLOT0*/], Q4
        mov     [rsp + 80 /*MEMSLOT1*/], D2

        // First we wipe nDigits2 of the result (size of in)
        mov     Q6, Q5

        // Wipe destination for nDigit2 blocks
        xorps   xmm0,xmm0               // Zero register for 16-byte wipes
        mov     Q0, Q4

SymCryptFdefRawMulMulxWipeLoop:
        movaps      [Q6],xmm0
        movaps      [Q6+16],xmm0            // Wipe 32 bytes
        movaps      [Q6+32],xmm0            // Wipe 32 bytes
        movaps      [Q6+48],xmm0            // Wipe 32 bytes
        add         Q6, 64
        sub         Q0, 64
        jnz         SymCryptFdefRawMulMulxWipeLoop


SymCryptFdefRawMulxOuterLoop:

        ZEROREG_8   Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13      // Leaves Cy = Ov = 0

SymCryptFdefRawMulMulxInnerLoop:

        // Register allocation in loops:
        // Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13        8-word carry
        // Q0, Q2                                    temps for multiplication
        // Q1, Q3                                    pSrc1, pSrc2 running pointers
        // Q4                                        inner loop counter
        // QH                                        fixed input reg for multiplication
        // Q5                                        Destination running pointer inner loop
        // slot0                                     nDigits2*64
        // slot1                                     outer loop counter

        MULADD88  Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q5, Q1, Q3, Q0, Q2, QH

        add     Q3, 64              // Src2 ptr
        add     Q5, 64

        sub     D4, 64                            // sets Cy = Ov = 0 because 64*nDigits2 < 2^32
        jnz     SymCryptFdefRawMulMulxInnerLoop

        // Write the 8-word carry-out to the destination
        mov     [Q5 + 0*8], Q6
        mov     [Q5 + 1*8], Q7
        mov     [Q5 + 2*8], Q8
        mov     [Q5 + 3*8], Q9
        mov     [Q5 + 4*8], Q10
        mov     [Q5 + 5*8], Q11
        mov     [Q5 + 6*8], Q12
        mov     [Q5 + 7*8], Q13

        // set up for next iteration
        // reload 64*nDigits2
        mov     Q4, [rsp + 72 /*MEMSLOT0*/]

        // reset Q5 & increment
        sub     Q5, Q4
        add     Q5, 64
        // reset Q3
        sub     Q3, Q4

        // update PSrc1
        add     Q1, 64

        // nDigits1 loop counter
        mov     D2, [rsp + 80 /*MEMSLOT1*/]
        sub     D2, 1                              // sets Cy = Ov = 0 because nDigits1 < 2^32 / 64
        mov     [rsp + 80 /*MEMSLOT1*/], D2
        jnz     SymCryptFdefRawMulxOuterLoop


BEGIN_EPILOGUE
pop Q13
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
pop Q6
ret
NESTED_END SymCryptFdefRawMulMulx, _TEXT
#undef QH
#undef DH
#undef WH
#undef BH
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q5
#undef D5
#undef W5
#undef B5
#undef Q6
#undef D6
#undef W6
#undef B6
#undef Q7
#undef D7
#undef W7
#undef B7
#undef Q8
#undef D8
#undef W8
#undef B8
#undef Q9
#undef D9
#undef W9
#undef B9
#undef Q10
#undef D10
#undef W10
#undef B10
#undef Q11
#undef D11
#undef W11
#undef B11
#undef Q12
#undef D12
#undef W12
#undef B12
#undef Q13
#undef D13
#undef W13
#undef B13

// VOID
// SYMCRYPT_CALL
// SymCryptFdefRawSquareMulx(
//     _In_reads_(nDigits*SYMCRYPT_FDEF_DIGIT_NUINT32)         PCUINT32    pSrc,
//                                                             UINT32      nDigits,
//     _Out_writes_(2*nDigits*SYMCRYPT_FDEF_DIGIT_NUINT32)     PUINT32     pDst )

#define QH rdx
#define DH edx
#define WH dx
#define BH dl
#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q2 r10
#define D2 r10d
#define W2 r10w
#define B2 r10b
#define Q5 r11
#define D5 r11d
#define W5 r11w
#define B5 r11b
#define Q6 rsi
#define D6 esi
#define W6 si
#define B6 sil
#define Q7 rdi
#define D7 edi
#define W7 di
#define B7 dil
#define Q8 rbp
#define D8 ebp
#define W8 bp
#define B8 bpl
#define Q9 rbx
#define D9 ebx
#define W9 bx
#define B9 bl
#define Q10 r12
#define D10 r12d
#define W10 r12w
#define B10 r12b
#define Q11 r13
#define D11 r13d
#define W11 r13w
#define B11 r13b
#define Q12 r14
#define D12 r14d
#define W12 r14w
#define B12 r14b
#define Q13 r15
#define D13 r15d
#define W13 r15w
#define B13 r15b
NESTED_ENTRY SymCryptFdefRawSquareMulx, _TEXT

rex_push_reg Q6
push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12
push_reg Q13

END_PROLOGUE

mov Q2, QH

        // Q1 = pSrc
        // Q2 = nDigits
        // Q3 = pDst

        // Save parameters for phase 2

        mov     [rsp + 72 /*MEMSLOT0*/], Q1   // save pSrc
        mov     [rsp + 80 /*MEMSLOT1*/], Q2   // save nDigits
        mov     [rsp + 88 /*MEMSLOT2*/], Q3   // save pDst

        shl     Q2, 6       // nDigits * 64 = # bytes in Src to process
        mov     [rsp + 96 /*MEMSLOT3*/], Q2   // save # bytes in Src to process

        // Wipe destination for nDigits blocks
        xor     Q0, Q0
        mov     Q5, Q3
        mov     Q4, Q2

SymCryptFdefRawSquareMulxWipeLoop:
        // we use 8-byte writes as we will be reading this very soon in 8-byte chunks, and this way the store-load
        // forwarding works
        mov     [Q5     ], Q0
        mov     [Q5 +  8], Q0
        mov     [Q5 + 16], Q0
        mov     [Q5 + 24], Q0
        mov     [Q5 + 32], Q0
        mov     [Q5 + 40], Q0
        mov     [Q5 + 48], Q0
        mov     [Q5 + 56], Q0
        add     Q5, 64
        sub     Q4, 64
        jnz     SymCryptFdefRawSquareMulxWipeLoop

        // Cy = Ov = 0 here because the last 'sub Q4,64' yielded 0

SymCryptFdefRawSquareMulxOuterLoop:

        HALF_SQUARE_NODIAG8 Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q3, Q1, Q0, Q4, QH

        sub     Q2, 64
        jz      SymCryptFdefRawSquareMulxPhase2     // end of phase 1

        lea     Q5, [Q1 + 64]
        lea     Q3, [Q3 + 64]

SymCryptFdefRawSquareMulxInnerLoop:
        // Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13        8-word carry
        // Q0, Q4                                    temps for multiplication
        // Q1                                        pSrc running pointer outer loop
        // Q2                                        # bytes left in pSrc to process in the inner loop
        // Q3                                        pDst running pointer inner loop
        // QH                                        fixed input reg for multiplication
        // Q5                                        pSrc running pointer inner loop

        // slot0                                     pSrc (used for final pass)
        // slot1                                     nDigits (used for final pass)
        // slot2                                     pDst (used for final pass)
        // slot3                                     # bytes to process from pSrc in this iteration

        MULADD88    Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q3, Q1, Q5, Q0, Q4, QH

        add     Q3, 64
        add     Q5, 64

        sub     Q2, 64                  // Sets Cy = Ov = 0 because nDigits < 2^32 / bits_per_digit
        jnz     SymCryptFdefRawSquareMulxInnerLoop

        // Write the 8-word carry-out to the destination
        mov     [Q3 + 0*8], Q6
        mov     [Q3 + 1*8], Q7
        mov     [Q3 + 2*8], Q8
        mov     [Q3 + 3*8], Q9
        mov     [Q3 + 4*8], Q10
        mov     [Q3 + 5*8], Q11
        mov     [Q3 + 6*8], Q12
        mov     [Q3 + 7*8], Q13

        mov     Q2, [rsp + 96 /*MEMSLOT3*/]   // restore # bytes in Src to process next

        add     Q1, 64                                  // Shift outer Src pointer by 1 digit
        sub     Q3, Q2                                  // reset output ptr
        add     Q3, 128                                 // Shift output ptr by 2 digits

        sub     Q2, 64                                  // Reduce number of bytes to process by 1 digit
        mov     [rsp + 96 /*MEMSLOT3*/], Q2

        jmp     SymCryptFdefRawSquareMulxOuterLoop


SymCryptFdefRawSquareMulxPhase2:
        // Cy = Ov = 0 because last 'sub Q2, 64' resulted in 0

        // Write the 8-word carry-out to the destination
        mov     [Q3 +  8*8], Q6
        mov     [Q3 +  9*8], Q7
        mov     [Q3 + 10*8], Q8
        mov     [Q3 + 11*8], Q9
        mov     [Q3 + 12*8], Q10
        mov     [Q3 + 13*8], Q11
        mov     [Q3 + 14*8], Q12
        mov     [Q3 + 15*8], Q13

        // Compute diagonals, and add double the result so far

        mov     Q1, [rsp + 72 /*MEMSLOT0*/]
        mov     Q2, [rsp + 80 /*MEMSLOT1*/]
        mov     Q3, [rsp + 88 /*MEMSLOT2*/]

        // We can't keep the carries in Cy and Ov because there is no way to do a loop counter
        // without touching the Ov flag.
        // So we set the Ov carry in Q0, and retain a zero in Q4
        xor     Q0, Q0
        xor     Q4, Q4

SymCryptFdefRawSquareMulxDiagonalsLoop:
        // Cy = carry in
        // Q0 = carry in (1 bit)
        // Ov = 0

        // First word is different to handle the carry
        // SYMCRYPT_SQUARE_DIAG    0, Q1, Q3, Q5, Q6, Q7, Q8, QH
        mov     QH, [Q1]
        mov     Q5, [Q3]
        mov     Q6, [Q3 + 8]
        mulx    Q8, Q7, QH
        adcx    Q7, Q0              // add both carries
        adcx    Q8, Q4              // Q4 = 0 - now Cy = 0 because result of multiply <= ff..fe00..01

        adcx    Q7, Q5
        adox    Q7, Q5
        adcx    Q8, Q6
        adox    Q8, Q6
        mov     [Q3], Q7
        mov     [Q3 + 8], Q8

        SYMCRYPT_SQUARE_DIAG 1, Q1, Q3, Q5, Q6, Q7, Q8, QH
        SYMCRYPT_SQUARE_DIAG 2, Q1, Q3, Q5, Q6, Q7, Q8, QH
        SYMCRYPT_SQUARE_DIAG 3, Q1, Q3, Q5, Q6, Q7, Q8, QH
        SYMCRYPT_SQUARE_DIAG 4, Q1, Q3, Q5, Q6, Q7, Q8, QH
        SYMCRYPT_SQUARE_DIAG 5, Q1, Q3, Q5, Q6, Q7, Q8, QH
        SYMCRYPT_SQUARE_DIAG 6, Q1, Q3, Q5, Q6, Q7, Q8, QH
        SYMCRYPT_SQUARE_DIAG 7, Q1, Q3, Q5, Q6, Q7, Q8, QH

        // Move the Ov flag into Q0
        mov     D0, D4
        adox    D0, D4

        // There is no way to do a loop counter without overwriting the Ov flag
        // Even the 'dec' instruction touches it, and LAHF/SAHF doesn't load/store the Ov flag.
        // We can't push/pop efl in a function body

        lea     Q1, [Q1 + 64]
        lea     Q3, [Q3 + 128]
        dec     Q2
        jnz     SymCryptFdefRawSquareMulxDiagonalsLoop


BEGIN_EPILOGUE
pop Q13
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
pop Q6
ret
NESTED_END SymCryptFdefRawSquareMulx, _TEXT
#undef QH
#undef DH
#undef WH
#undef BH
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q5
#undef D5
#undef W5
#undef B5
#undef Q6
#undef D6
#undef W6
#undef B6
#undef Q7
#undef D7
#undef W7
#undef B7
#undef Q8
#undef D8
#undef W8
#undef B8
#undef Q9
#undef D9
#undef W9
#undef B9
#undef Q10
#undef D10
#undef W10
#undef B10
#undef Q11
#undef D11
#undef W11
#undef B11
#undef Q12
#undef D12
#undef W12
#undef B12
#undef Q13
#undef D13
#undef W13
#undef B13

// VOID
// SYMCRYPT_CALL
// SymCryptFdefMontgomeryReduceMulx(
//     _In_                            PCSYMCRYPT_MODULUS      pmMod,
//     _In_                            PUINT32                 pSrc,
//     _Out_                           PUINT32                 pDst )
#define QH rdx
#define DH edx
#define WH dx
#define BH dl
#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q2 r10
#define D2 r10d
#define W2 r10w
#define B2 r10b
#define Q5 r11
#define D5 r11d
#define W5 r11w
#define B5 r11b
#define Q6 rsi
#define D6 esi
#define W6 si
#define B6 sil
#define Q7 rdi
#define D7 edi
#define W7 di
#define B7 dil
#define Q8 rbp
#define D8 ebp
#define W8 bp
#define B8 bpl
#define Q9 rbx
#define D9 ebx
#define W9 bx
#define B9 bl
#define Q10 r12
#define D10 r12d
#define W10 r12w
#define B10 r12b
#define Q11 r13
#define D11 r13d
#define W11 r13w
#define B11 r13b
#define Q12 r14
#define D12 r14d
#define W12 r14w
#define B12 r14b
#define Q13 r15
#define D13 r15d
#define W13 r15w
#define B13 r15b
NESTED_ENTRY SymCryptFdefMontgomeryReduceMulx, _TEXT

rex_push_reg Q6
push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12
push_reg Q13

END_PROLOGUE

mov Q2, QH

        mov     [rsp + 72 /*MEMSLOT0*/], Q1
        mov     [rsp + 80 /*MEMSLOT1*/], Q2
        mov     [rsp + 88 /*MEMSLOT2*/], Q3

        mov     D0, [Q1 + SymCryptModulusNdigitsOffsetAmd64]
        mov     [rsp + 96 /*MEMSLOT3*/], D0
        // CntOuter = nDigits - using first half of slot3

        xor     D4, D4
        mov     [rsp + 96 /*MEMSLOT3*/ + 4], D4
        // HighCarry = 0 - using second half of slot3

SymCryptFdefMontgomeryReduceMulxOuterLoop:
        // Q1 = pmMod
        // Q2 = pSrc = tmp buffer that we will reduce
        mov     Q6, [Q2 + 0 * 8]
        mov     Q7, [Q2 + 1 * 8]
        mov     Q8, [Q2 + 2 * 8]
        mov     Q9, [Q2 + 3 * 8]
        mov     Q10, [Q2 + 4 * 8]
        mov     Q11, [Q2 + 5 * 8]
        mov     Q12, [Q2 + 6 * 8]
        mov     Q13, [Q2 + 7 * 8]

        mov     Q3, [Q1 + SymCryptModulusMontgomeryInv64OffsetAmd64]            // inv64
        mov     D4, [Q1 + SymCryptModulusNdigitsOffsetAmd64]
        lea     Q1, [Q1 + SymCryptModulusValueOffsetAmd64]                      // modulus value

        // Q2 = value to reduce
        // Q6 - Q13 = Q2[0..7]
        // Q1 = modulus value
        // Q3 = modinv

        MONTGOMERY18    Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13,  Q3, Q1, Q2 + (0 * 8), Q0, Q5, QH
        MONTGOMERY18    Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q6,  Q3, Q1, Q2 + (1 * 8), Q0, Q5, QH
        MONTGOMERY18    Q8, Q9, Q10, Q11, Q12, Q13, Q6, Q7,  Q3, Q1, Q2 + (2 * 8), Q0, Q5, QH
        MONTGOMERY18    Q9, Q10, Q11, Q12, Q13, Q6, Q7, Q8,  Q3, Q1, Q2 + (3 * 8), Q0, Q5, QH
        MONTGOMERY18    Q10, Q11, Q12, Q13, Q6, Q7, Q8, Q9,  Q3, Q1, Q2 + (4 * 8), Q0, Q5, QH
        MONTGOMERY18    Q11, Q12, Q13, Q6, Q7, Q8, Q9, Q10,  Q3, Q1, Q2 + (5 * 8), Q0, Q5, QH
        MONTGOMERY18    Q12, Q13, Q6, Q7, Q8, Q9, Q10, Q11,  Q3, Q1, Q2 + (6 * 8), Q0, Q5, QH
        MONTGOMERY18    Q13, Q6, Q7, Q8, Q9, Q10, Q11, Q12,  Q3, Q1, Q2 + (7 * 8), Q0, Q5, QH

        // Q6 - Q13 = carry from multiply-add
        // Q2[0..7] = Montgomery factors

        mov     Q3, Q2         // factor to multiply by
        add     Q1, 64
        add     Q2, 64

        dec     D4
        jz      SymCryptFdefMontgomeryReduceMulxInnerLoopDone

SymCryptFdefMontgomeryReduceMulxInnerLoop:

        // Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13        8-word carry
        // Q0, Q5                                    temps for multiplication
        // Q1                                        running pointer pMod inner loop
        // Q2                                        running pointer pSrc inner loop
        // Q3                                        Montgomery factors for this row
        // D4                                        loop ctr
        // QH                                        fixed input reg for multiplication

        MULADD88    Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13,  Q2, Q1, Q3, Q0, Q5, QH
            // pre & post: Cy = Ov = 0
            // Q13..Q6:Q2[7-0] = R[7-0]:D[7-0] = A[7:0] * B[7:0] + R[7:0] + D[7:0]
            // QH is volatile

        add     Q1, 64
        add     Q2, 64
        dec     D4
        jnz     SymCryptFdefMontgomeryReduceMulxInnerLoop


SymCryptFdefMontgomeryReduceMulxInnerLoopDone:

        // We have an 8-word carry here, which we need to add to the in-memory buffer and retain a carry
        // We also saved a 1-bit carry from the previous outer loop
        mov     D5, [rsp + 96 /*MEMSLOT3*/ + 4]
        // move carry into Cy flag
        neg     D5

        // We do this in separate instructions to help the instruction decoder build up a lead...
        mov     Q0, [Q2 + 0 * 8]
        adc     Q0, Q6
        mov     [Q2 + 0 * 8], Q0

        mov     Q5, [Q2 + 1 * 8]
        adc     Q5, Q7
        mov     [Q2 + 1 * 8], Q5

        mov     Q0, [Q2 + 2 * 8]
        adc     Q0, Q8
        mov     [Q2 + 2 * 8], Q0

        mov     Q5, [Q2 + 3 * 8]
        adc     Q5, Q9
        mov     [Q2 + 3 * 8], Q5

        mov     Q0, [Q2 + 4 * 8]
        adc     Q0, Q10
        mov     [Q2 + 4 * 8], Q0

        mov     Q5, [Q2 + 5 * 8]
        adc     Q5, Q11
        mov     [Q2 + 5 * 8], Q5

        mov     Q0, [Q2 + 6 * 8]
        adc     Q0, Q12
        mov     [Q2 + 6 * 8], Q0

        mov     Q5, [Q2 + 7 * 8]
        adc     Q5, Q13
        mov     [Q2 + 7 * 8], Q5

        adc     D4, D4                // D4 = carry (D4 was previously zero)
        mov     [rsp + 96 /*MEMSLOT3*/ + 4], D4

        mov     Q2, [rsp + 80 /*MEMSLOT1*/]
        add     Q2, 64
        mov     [rsp + 80 /*MEMSLOT1*/], Q2

        mov     Q1, [rsp + 72 /*MEMSLOT0*/]

        mov     D0, [rsp + 96 /*MEMSLOT3*/]
        dec     D0
        mov     [rsp + 96 /*MEMSLOT3*/], D0

        jnz     SymCryptFdefMontgomeryReduceMulxOuterLoop

        // D4 = output carry

        mov     D6, [Q1 + SymCryptModulusNdigitsOffsetAmd64]
        lea     Q1, [Q1 + SymCryptModulusValueOffsetAmd64]                    // modulus value

        mov     Q3, [rsp + 88 /*MEMSLOT2*/]

        // Q2 = result buffer pointer
        // D6 = # digits
        // Q1 = modulus value
        // Q3 = Dst

        // copy these values for the masked copy loop
        mov     D7, D6      // nDigits
        mov     Q8, Q2      // result buffer
        mov     Q9, Q3      // destination pointer

        // pDst = Reduction result - Modulus

SymCryptFdefMontgomeryReduceMulxSubLoop:
        mov     Q0,[Q2 + 0 * 8]
        sbb     Q0,[Q1 + 0 * 8]
        mov     [Q3 + 0 * 8], Q0

        mov     Q5,[Q2 + 1 * 8]
        sbb     Q5,[Q1 + 1 * 8]
        mov     [Q3 + 1 * 8], Q5

        mov     Q0,[Q2 + 2 * 8]
        sbb     Q0,[Q1 + 2 * 8]
        mov     [Q3 + 2 * 8], Q0

        mov     Q5,[Q2 + 3 * 8]
        sbb     Q5,[Q1 + 3 * 8]
        mov     [Q3 + 3 * 8], Q5

        mov     Q0,[Q2 + 4 * 8]
        sbb     Q0,[Q1 + 4 * 8]
        mov     [Q3 + 4 * 8], Q0

        mov     Q5,[Q2 + 5 * 8]
        sbb     Q5,[Q1 + 5 * 8]
        mov     [Q3 + 5 * 8], Q5

        mov     Q0,[Q2 + 6 * 8]
        sbb     Q0,[Q1 + 6 * 8]
        mov     [Q3 + 6 * 8], Q0

        mov     Q5,[Q2 + 7 * 8]
        sbb     Q5,[Q1 + 7 * 8]
        mov     [Q3 + 7 * 8], Q5

        lea     Q2, [Q2 + 64]
        lea     Q1, [Q1 + 64]
        lea     Q3, [Q3 + 64]
        dec     D6
        jnz     SymCryptFdefMontgomeryReduceMulxSubLoop

        // now a masked copy from the reduction buffer to the destination.
        // copy if high carry = 0 and Cy = 1
        sbb     D4, 0
        // D4 = copy mask, ff...ff  if copy, 0 of no copy

        movd    xmm0, D4           // xmm0[0] = mask
        pcmpeqd xmm1, xmm1          // xmm1 = ff...ff
        pshufd  xmm0, xmm0, 0       // xmm0[0..3] = mask
        pxor    xmm1, xmm0          // xmm1 = not Mask

SymCryptFdefMontgomeryReduceMulxMaskedCopyLoop:
        movdqa  xmm2, [Q8 + 0 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q9 + 0 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q9 + 0 * 16], xmm2

        movdqa  xmm2, [Q8 + 1 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q9 + 1 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q9 + 1 * 16], xmm2

        movdqa  xmm2, [Q8 + 2 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q9 + 2 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q9 + 2 * 16], xmm2

        movdqa  xmm2, [Q8 + 3 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q9 + 3 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q9 + 3 * 16], xmm2

        // Move on to the next digit

        add     Q8, 64
        add     Q9, 64
        dec     D7
        jnz     SymCryptFdefMontgomeryReduceMulxMaskedCopyLoop


BEGIN_EPILOGUE
pop Q13
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
pop Q6
ret
NESTED_END SymCryptFdefMontgomeryReduceMulx, _TEXT
#undef QH
#undef DH
#undef WH
#undef BH
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q5
#undef D5
#undef W5
#undef B5
#undef Q6
#undef D6
#undef W6
#undef B6
#undef Q7
#undef D7
#undef W7
#undef B7
#undef Q8
#undef D8
#undef W8
#undef B8
#undef Q9
#undef D9
#undef W9
#undef B9
#undef Q10
#undef D10
#undef W10
#undef B10
#undef Q11
#undef D11
#undef W11
#undef B11
#undef Q12
#undef D12
#undef W12
#undef B12
#undef Q13
#undef D13
#undef W13
#undef B13

// --------------------------------
// 1024-bit size specific functions
// --------------------------------

//VOID
//SYMCRYPT_CALL
//SymCryptFdefRawMul(
//    _In_reads_(nWords1)             PCUINT32    pSrc1,
//    _In_reads_(nWords2)             PCUINT32    pSrc2,
//                                    UINT32      nDigits,
//    _Out_writes_(nWords1 + nWords2) PUINT32     pDst )

#define QH rdx
#define DH edx
#define WH dx
#define BH dl
#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q2 r10
#define D2 r10d
#define W2 r10w
#define B2 r10b
#define Q5 r11
#define D5 r11d
#define W5 r11w
#define B5 r11b
#define Q6 rsi
#define D6 esi
#define W6 si
#define B6 sil
#define Q7 rdi
#define D7 edi
#define W7 di
#define B7 dil
#define Q8 rbp
#define D8 ebp
#define W8 bp
#define B8 bpl
#define Q9 rbx
#define D9 ebx
#define W9 bx
#define B9 bl
#define Q10 r12
#define D10 r12d
#define W10 r12w
#define B10 r12b
#define Q11 r13
#define D11 r13d
#define W11 r13w
#define B11 r13b
#define Q12 r14
#define D12 r14d
#define W12 r14w
#define B12 r14b
NESTED_ENTRY SymCryptFdefRawMulMulx1024, _TEXT

rex_push_reg Q6
push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12

END_PROLOGUE

mov Q2, QH

        // First we wipe nDigits of the result (size of in)
        // Q1 = pSrc1
        // Q2 = pSrc2
        // Q3 = nDigits
        // Q4 = pDst

        // Wipe destination for nDigit2 blocks
        xorps       xmm0,xmm0               // Zero register for 16-byte wipes

        movaps      [Q4],xmm0
        movaps      [Q4+16],xmm0            // Wipe 32 bytes
        movaps      [Q4+32],xmm0            // Wipe 32 bytes
        movaps      [Q4+48],xmm0            // Wipe 32 bytes

        movaps      [Q4+64],xmm0
        movaps      [Q4+80],xmm0            // Wipe 32 bytes
        movaps      [Q4+96],xmm0            // Wipe 32 bytes
        movaps      [Q4+112],xmm0           // Wipe 32 bytes

        // Digit 1 from src2

        ZEROREG_8   Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12      // Leaves Cy = Ov = 0

        MULADD88  Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q4, Q1, Q2, Q0, Q3, QH

        add     Q2, 64              // Src2 ptr
        add     Q4, 64
        xor     Q0, Q0              // sets Cy = Ov = 0

        MULADD88  Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q4, Q1, Q2, Q0, Q3, QH

        add     Q4, 64

        // Write the 8-word carry-out to the destination
        mov     [Q4 + 0*8], Q5
        mov     [Q4 + 1*8], Q6
        mov     [Q4 + 2*8], Q7
        mov     [Q4 + 3*8], Q8
        mov     [Q4 + 4*8], Q9
        mov     [Q4 + 5*8], Q10
        mov     [Q4 + 6*8], Q11
        mov     [Q4 + 7*8], Q12

        // Digit 2 from src2

        // set up

        // Mov Q4 one digit back
        sub     Q4, 64

        // reload pSrc2
        sub     Q2, 64

        // update PSrc1
        add     Q1, 64

        ZEROREG_8   Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12      // Leaves Cy = Ov = 0

        MULADD88  Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q4, Q1, Q2, Q0, Q3, QH

        add     Q2, 64              // Src2 ptr
        add     Q4, 64
        xor     Q0, Q0              // sets Cy = Ov = 0

        MULADD88  Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q4, Q1, Q2, Q0, Q3, QH

        add     Q4, 64

        // Write the 8-word carry-out to the destination
        mov     [Q4 + 0*8], Q5
        mov     [Q4 + 1*8], Q6
        mov     [Q4 + 2*8], Q7
        mov     [Q4 + 3*8], Q8
        mov     [Q4 + 4*8], Q9
        mov     [Q4 + 5*8], Q10
        mov     [Q4 + 6*8], Q11
        mov     [Q4 + 7*8], Q12


BEGIN_EPILOGUE
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
pop Q6
ret
NESTED_END SymCryptFdefRawMulMulx1024, _TEXT
#undef QH
#undef DH
#undef WH
#undef BH
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q5
#undef D5
#undef W5
#undef B5
#undef Q6
#undef D6
#undef W6
#undef B6
#undef Q7
#undef D7
#undef W7
#undef B7
#undef Q8
#undef D8
#undef W8
#undef B8
#undef Q9
#undef D9
#undef W9
#undef B9
#undef Q10
#undef D10
#undef W10
#undef B10
#undef Q11
#undef D11
#undef W11
#undef B11
#undef Q12
#undef D12
#undef W12
#undef B12

// VOID
// SYMCRYPT_CALL
// SymCryptFdefRawSquareMulx1024(
//     _In_reads_(nDigits*SYMCRYPT_FDEF_DIGIT_NUINT32)         PCUINT32    pSrc,
//                                                             UINT32      nDigits,
//     _Out_writes_(2*nDigits*SYMCRYPT_FDEF_DIGIT_NUINT32)     PUINT32     pDst )

#define QH rdx
#define DH edx
#define WH dx
#define BH dl
#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q2 r10
#define D2 r10d
#define W2 r10w
#define B2 r10b
#define Q5 r11
#define D5 r11d
#define W5 r11w
#define B5 r11b
#define Q6 rsi
#define D6 esi
#define W6 si
#define B6 sil
#define Q7 rdi
#define D7 edi
#define W7 di
#define B7 dil
#define Q8 rbp
#define D8 ebp
#define W8 bp
#define B8 bpl
#define Q9 rbx
#define D9 ebx
#define W9 bx
#define B9 bl
#define Q10 r12
#define D10 r12d
#define W10 r12w
#define B10 r12b
#define Q11 r13
#define D11 r13d
#define W11 r13w
#define B11 r13b
#define Q12 r14
#define D12 r14d
#define W12 r14w
#define B12 r14b
NESTED_ENTRY SymCryptFdefRawSquareMulx1024, _TEXT

rex_push_reg Q6
push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12

END_PROLOGUE

mov Q2, QH

        // Wipe 128 bytes of destination
        xorps       xmm0,xmm0               // Zero register for 16-byte wipes

        movaps      [Q3],xmm0
        movaps      [Q3+16],xmm0
        movaps      [Q3+32],xmm0
        movaps      [Q3+48],xmm0

        movaps      [Q3+64],xmm0
        movaps      [Q3+80],xmm0
        movaps      [Q3+96],xmm0
        movaps      [Q3+112],xmm0

        xor     Q0, Q0                      // Sets Cy = Ov = 0

        HALF_SQUARE_NODIAG8 Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12,  Q3, Q1, Q0, Q2, QH

        lea     Q4, [Q1 + 64]               // Q4 = pSrc + 64
        lea     Q3, [Q3 + 64]               // Q3 = pDst + 64

        // Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12        8-word carry
        // Q0, Q2                                   temps for multiplication
        // Q1                                       pSrc (constant)
        // Q4                                       pSrc + 64 (constant)
        // Q3                                       pDst running pointer
        // QH                                       fixed input reg for multiplication

        MULADD88    Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q3, Q1, Q4, Q0, Q2, QH

        add     Q3, 64                      // Q3 = pDst + 128

        // Write the 8-word carry-out to the destination
        mov     [Q3 + 0*8], Q5
        mov     [Q3 + 1*8], Q6
        mov     [Q3 + 2*8], Q7
        mov     [Q3 + 3*8], Q8
        mov     [Q3 + 4*8], Q9
        mov     [Q3 + 5*8], Q10
        mov     [Q3 + 6*8], Q11
        mov     [Q3 + 7*8], Q12

        // Q3 which is the destination pointer is shifted here by 2 digits

        xor     Q0, Q0                        // Sets Cy = Ov = 0

        HALF_SQUARE_NODIAG8 Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12,  Q3, Q4, Q0, Q2, QH

        // Write the 8-word carry-out to the destination
        mov     [Q3 +  8*8], Q5
        mov     [Q3 +  9*8], Q6
        mov     [Q3 + 10*8], Q7
        mov     [Q3 + 11*8], Q8
        mov     [Q3 + 12*8], Q9
        mov     [Q3 + 13*8], Q10
        mov     [Q3 + 14*8], Q11
        mov     [Q3 + 15*8], Q12

        // Compute diagonals, and add double the result so far

        sub     Q3, 128         // Q3 = pDst - sets Cy = Ov = 0

        SYMCRYPT_SQUARE_DIAG 0, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 1, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 2, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 3, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 4, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 5, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 6, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 7, Q1, Q3, Q0, Q2, Q4, Q5, QH

        SYMCRYPT_SQUARE_DIAG 8, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 9, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 10, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 11, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 12, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 13, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 14, Q1, Q3, Q0, Q2, Q4, Q5, QH
        SYMCRYPT_SQUARE_DIAG 15, Q1, Q3, Q0, Q2, Q4, Q5, QH


BEGIN_EPILOGUE
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
pop Q6
ret
NESTED_END SymCryptFdefRawSquareMulx1024, _TEXT
#undef QH
#undef DH
#undef WH
#undef BH
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q5
#undef D5
#undef W5
#undef B5
#undef Q6
#undef D6
#undef W6
#undef B6
#undef Q7
#undef D7
#undef W7
#undef B7
#undef Q8
#undef D8
#undef W8
#undef B8
#undef Q9
#undef D9
#undef W9
#undef B9
#undef Q10
#undef D10
#undef W10
#undef B10
#undef Q11
#undef D11
#undef W11
#undef B11
#undef Q12
#undef D12
#undef W12
#undef B12

// VOID
// SYMCRYPT_CALL
// SymCryptFdefMontgomeryReduceMulx1024(
//     _In_                            PCSYMCRYPT_MODULUS      pmMod,
//     _Inout_                         PUINT32                 pSrc,
//     _Out_                           PUINT32                 pDst )
#define QH rdx
#define DH edx
#define WH dx
#define BH dl
#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q2 r10
#define D2 r10d
#define W2 r10w
#define B2 r10b
#define Q5 r11
#define D5 r11d
#define W5 r11w
#define B5 r11b
#define Q6 rsi
#define D6 esi
#define W6 si
#define B6 sil
#define Q7 rdi
#define D7 edi
#define W7 di
#define B7 dil
#define Q8 rbp
#define D8 ebp
#define W8 bp
#define B8 bpl
#define Q9 rbx
#define D9 ebx
#define W9 bx
#define B9 bl
#define Q10 r12
#define D10 r12d
#define W10 r12w
#define B10 r12b
#define Q11 r13
#define D11 r13d
#define W11 r13w
#define B11 r13b
#define Q12 r14
#define D12 r14d
#define W12 r14w
#define B12 r14b
#define Q13 r15
#define D13 r15d
#define W13 r15w
#define B13 r15b
NESTED_ENTRY SymCryptFdefMontgomeryReduceMulx1024, _TEXT

rex_push_reg Q6
push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12
push_reg Q13

END_PROLOGUE

mov Q2, QH

        mov     [rsp + 72 /*MEMSLOT0*/], Q3

        mov     D0, 2
        mov     [rsp + 80 /*MEMSLOT1*/], D0
        // CntOuter = nDigits - using first half of slot3

        xor     D4, D4
        lea     Q1, [Q1 + SymCryptModulusValueOffsetAmd64]                      // modulus value

SymCryptFdefMontgomeryReduceMulx1024OuterLoop:
        // Q1 = pmMod
        // Q2 = pSrc = tmp buffer that we will reduce
        mov     Q6, [Q2 + 0 * 8]
        mov     Q7, [Q2 + 1 * 8]
        mov     Q8, [Q2 + 2 * 8]
        mov     Q9, [Q2 + 3 * 8]
        mov     Q10, [Q2 + 4 * 8]
        mov     Q11, [Q2 + 5 * 8]
        mov     Q12, [Q2 + 6 * 8]
        mov     Q13, [Q2 + 7 * 8]

        mov     Q3, [Q1 - SymCryptModulusValueOffsetAmd64 + SymCryptModulusMontgomeryInv64OffsetAmd64]            // inv64

        // Q2 = value to reduce
        // Q6 - Q13 = Q2[0..7]
        // Q1 = modulus value
        // Q3 = modinv

        MONTGOMERY18    Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13,  Q3, Q1, Q2 + (0 * 8), Q0, Q5, QH
        MONTGOMERY18    Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q6,  Q3, Q1, Q2 + (1 * 8), Q0, Q5, QH
        MONTGOMERY18    Q8, Q9, Q10, Q11, Q12, Q13, Q6, Q7,  Q3, Q1, Q2 + (2 * 8), Q0, Q5, QH
        MONTGOMERY18    Q9, Q10, Q11, Q12, Q13, Q6, Q7, Q8,  Q3, Q1, Q2 + (3 * 8), Q0, Q5, QH
        MONTGOMERY18    Q10, Q11, Q12, Q13, Q6, Q7, Q8, Q9,  Q3, Q1, Q2 + (4 * 8), Q0, Q5, QH
        MONTGOMERY18    Q11, Q12, Q13, Q6, Q7, Q8, Q9, Q10,  Q3, Q1, Q2 + (5 * 8), Q0, Q5, QH
        MONTGOMERY18    Q12, Q13, Q6, Q7, Q8, Q9, Q10, Q11,  Q3, Q1, Q2 + (6 * 8), Q0, Q5, QH
        MONTGOMERY18    Q13, Q6, Q7, Q8, Q9, Q10, Q11, Q12,  Q3, Q1, Q2 + (7 * 8), Q0, Q5, QH

        // Q6 - Q13 = carry from multiply-add
        // Q2[0..7] = Montgomery factors

        mov     Q3, Q2         // factor to multiply by
        add     Q1, 64
        add     Q2, 64

        // Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13        8-word carry
        // Q0, Q5                                    temps for multiplication
        // Q1                                        running pointer pMod inner loop
        // Q2                                        running pointer pSrc inner loop
        // Q3                                        Montgomery factors for this row
        // D4                                        loop ctr
        // QH                                        fixed input reg for multiplication

        MULADD88    Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13,  Q2, Q1, Q3, Q0, Q5, QH
            // pre & post: Cy = Ov = 0
            // Q13..Q6:Q2[7-0] = R[7-0]:D[7-0] = A[7:0] * B[7:0] + R[7:0] + D[7:0]
            // QH is volatile

        add     Q1, 64
        add     Q2, 64

        // We have an 8-word carry here, which we need to add to the in-memory buffer and retain a carry
        // We also saved a 1-bit carry from the previous outer loop in D4
        // move carry into Cy flag
        neg     D4
        mov     D4, 0

        // We do this in separate instructions to help the instruction decoder build up a lead...
        mov     Q0, [Q2 + 0 * 8]
        adc     Q0, Q6
        mov     [Q2 + 0 * 8], Q0

        mov     Q5, [Q2 + 1 * 8]
        adc     Q5, Q7
        mov     [Q2 + 1 * 8], Q5

        mov     Q0, [Q2 + 2 * 8]
        adc     Q0, Q8
        mov     [Q2 + 2 * 8], Q0

        mov     Q5, [Q2 + 3 * 8]
        adc     Q5, Q9
        mov     [Q2 + 3 * 8], Q5

        mov     Q0, [Q2 + 4 * 8]
        adc     Q0, Q10
        mov     [Q2 + 4 * 8], Q0

        mov     Q5, [Q2 + 5 * 8]
        adc     Q5, Q11
        mov     [Q2 + 5 * 8], Q5

        mov     Q0, [Q2 + 6 * 8]
        adc     Q0, Q12
        mov     [Q2 + 6 * 8], Q0

        mov     Q5, [Q2 + 7 * 8]
        adc     Q5, Q13
        mov     [Q2 + 7 * 8], Q5

        adc     D4, D4                  // D4 = carry (D4 was previously zero)

        sub     Q2, 64                  // Q2 = tmp buffer that we will reduce (64B are now zeroed)
        sub     Q1, 128                 // Q1 = modulus value

        mov     D0, [rsp + 80 /*MEMSLOT1*/]
        sub     D0, 1
        mov     [rsp + 80 /*MEMSLOT1*/], D0

        jnz     SymCryptFdefMontgomeryReduceMulx1024OuterLoop

        // D4 = output carry

        mov     Q3, [rsp + 72 /*MEMSLOT0*/]

        // Q2 = result buffer pointer
        // Q1 = modulus value
        // Q3 = Dst

        // pDst = Reduction result - Modulus

        mov     Q0,[Q2 + 0 * 8]
        sbb     Q0,[Q1 + 0 * 8]
        mov     [Q3 + 0 * 8], Q0

        mov     Q5,[Q2 + 1 * 8]
        sbb     Q5,[Q1 + 1 * 8]
        mov     [Q3 + 1 * 8], Q5

        mov     Q0,[Q2 + 2 * 8]
        sbb     Q0,[Q1 + 2 * 8]
        mov     [Q3 + 2 * 8], Q0

        mov     Q5,[Q2 + 3 * 8]
        sbb     Q5,[Q1 + 3 * 8]
        mov     [Q3 + 3 * 8], Q5

        mov     Q0,[Q2 + 4 * 8]
        sbb     Q0,[Q1 + 4 * 8]
        mov     [Q3 + 4 * 8], Q0

        mov     Q5,[Q2 + 5 * 8]
        sbb     Q5,[Q1 + 5 * 8]
        mov     [Q3 + 5 * 8], Q5

        mov     Q0,[Q2 + 6 * 8]
        sbb     Q0,[Q1 + 6 * 8]
        mov     [Q3 + 6 * 8], Q0

        mov     Q5,[Q2 + 7 * 8]
        sbb     Q5,[Q1 + 7 * 8]
        mov     [Q3 + 7 * 8], Q5

        mov     Q0,[Q2 + 8 * 8]
        sbb     Q0,[Q1 + 8 * 8]
        mov     [Q3 + 8 * 8], Q0

        mov     Q5,[Q2 + 9 * 8]
        sbb     Q5,[Q1 + 9 * 8]
        mov     [Q3 + 9 * 8], Q5

        mov     Q0,[Q2 + 10 * 8]
        sbb     Q0,[Q1 + 10 * 8]
        mov     [Q3 + 10 * 8], Q0

        mov     Q5,[Q2 + 11 * 8]
        sbb     Q5,[Q1 + 11 * 8]
        mov     [Q3 + 11 * 8], Q5

        mov     Q0,[Q2 + 12 * 8]
        sbb     Q0,[Q1 + 12 * 8]
        mov     [Q3 + 12 * 8], Q0

        mov     Q5,[Q2 + 13 * 8]
        sbb     Q5,[Q1 + 13 * 8]
        mov     [Q3 + 13 * 8], Q5

        mov     Q0,[Q2 + 14 * 8]
        sbb     Q0,[Q1 + 14 * 8]
        mov     [Q3 + 14 * 8], Q0

        mov     Q5,[Q2 + 15 * 8]
        sbb     Q5,[Q1 + 15 * 8]
        mov     [Q3 + 15 * 8], Q5

        // now a masked copy from the reduction buffer to the destination.
        // copy if high carry = 0 and Cy = 1
        sbb     D4, 0
        // D4 = copy mask, ff...ff  if copy, 0 of no copy

        movd    xmm0, D4            // xmm0[0] = mask
        pcmpeqd xmm1, xmm1          // xmm1 = ff...ff
        pshufd  xmm0, xmm0, 0       // xmm0[0..3] = mask
        pxor    xmm1, xmm0          // xmm1 = not Mask


        movdqa  xmm2, [Q2 + 0 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 0 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 0 * 16], xmm2

        movdqa  xmm2, [Q2 + 1 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 1 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 1 * 16], xmm2

        movdqa  xmm2, [Q2 + 2 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 2 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 2 * 16], xmm2

        movdqa  xmm2, [Q2 + 3 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 3 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 3 * 16], xmm2

        movdqa  xmm2, [Q2 + 4 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 4 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 4 * 16], xmm2

        movdqa  xmm2, [Q2 + 5 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 5 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 5 * 16], xmm2

        movdqa  xmm2, [Q2 + 6 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 6 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 6 * 16], xmm2

        movdqa  xmm2, [Q2 + 7 * 16]    // xmm2 = pSrc[0]
        movdqa  xmm3, [Q3 + 7 * 16]    // xmm3 = pDst[0]
        pand    xmm2, xmm0
        pand    xmm3, xmm1
        por     xmm2, xmm3
        movdqa  [Q3 + 7 * 16], xmm2


BEGIN_EPILOGUE
pop Q13
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
pop Q6
ret
NESTED_END SymCryptFdefMontgomeryReduceMulx1024, _TEXT
#undef QH
#undef DH
#undef WH
#undef BH
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q5
#undef D5
#undef W5
#undef B5
#undef Q6
#undef D6
#undef W6
#undef B6
#undef Q7
#undef D7
#undef W7
#undef B7
#undef Q8
#undef D8
#undef W8
#undef B8
#undef Q9
#undef D9
#undef W9
#undef B9
#undef Q10
#undef D10
#undef W10
#undef B10
#undef Q11
#undef D11
#undef W11
#undef B11
#undef Q12
#undef D12
#undef W12
#undef B12
#undef Q13
#undef D13
#undef W13
#undef B13

FILE_END()
