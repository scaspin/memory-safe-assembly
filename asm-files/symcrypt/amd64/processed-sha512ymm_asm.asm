//
//  sha512ymm_asm.symcryptasm   Assembler code for SHA-512 hash function. Based on
//  the intrinsics implementation SymCryptSha512AppendBlocks_ymm_4blocks() defined in
//  sha512-ymm.c
//
//  Expresses asm in a generic enough way to enable generation of MASM and GAS using the
//  symcryptasm_processor.py script and C preprocessor
//
// Copyright (c) Microsoft Corporation. Licensed under the MIT license.


#include "symcryptasm_shared.cppasm"

EXTERN(SymCryptSha512K:QWORD)
EXTERN(BYTE_REVERSE_64X2:QWORD)
EXTERN(BYTE_ROTATE_64:QWORD)


SET(SHA2_INPUT_BLOCK_BYTES_LOG2,	7)
SET(SHA2_INPUT_BLOCK_BYTES,			128)
SET(SHA2_ROUNDS,					80)
SET(SHA2_BYTES_PER_WORD,			8)
SET(SHA2_SIMD_REG_SIZE,				32)
SET(SHA2_SINGLE_BLOCK_THRESHOLD,	(3 * SHA2_INPUT_BLOCK_BYTES))	// Minimum number of message bytes required for using vectorized implementation


//
//  sha2common_asm.symcryptasm   Generic assembler routines used in SHA-2 implementations
//
//  Expresses asm in a generic enough way to enable generation of MASM and GAS using the
//  symcryptasm_processor.py script and C preprocessor
//
// Copyright (c) Microsoft Corporation. Licensed under the MIT license.



SET(SHA2_SIMD_LANES,				((SHA2_SIMD_REG_SIZE) / (SHA2_BYTES_PER_WORD)))
SET(SHA2_EXPANDED_MESSAGE_SIZE,		((SHA2_ROUNDS) * (SHA2_SIMD_REG_SIZE)))


// Local variables used by all SHA-2 implementations
#define W				rsp
#define LocalsBase		(W + SHA2_EXPANDED_MESSAGE_SIZE)
#define numBlocks		(LocalsBase +  0 * 8)
#define numBytesToWipe	(LocalsBase +  1 * 8)


//
// Load one message word (4- or 8-bytes depending on the size of register t1), 
// do the endianness transformation and store it in message buffer.
// 
// ptr [in] : register pointing to the beginning of a message
// ind [in]	: message index within a block (ind = 0..15)
// res [out]: output message word
//
LOAD_MSG_WORD MACRO  ptr, res, ind

	    mov		res, [ptr + (ind) * SHA2_BYTES_PER_WORD]
	    bswap	res
	    mov		[W + (ind) * SHA2_BYTES_PER_WORD], res
    
ENDM


//
// Get the number of message blocks that could be processed in parallel using SIMD implementation
//
// cbMsg [in/out]	: message size in bytes on input, set to min(r1 / SHA2_INPUT_BLOCK_BYTES, SHA2_SIMD_LANES) on output
// t				: temporary register
//
GET_SIMD_BLOCK_COUNT MACRO  cbMsg, t

		shr		cbMsg, SHA2_INPUT_BLOCK_BYTES_LOG2				
		mov		t, SHA2_SIMD_LANES
		cmp		cbMsg, t
		cmova	cbMsg, t

ENDM

//
// Get the number of processed message bytes
//
// The return value is a multiple of SHA2_INPUT_BLOCK_BYTES, depending
// on the level of parallelism in the vectorized implementation and available
// message bytes to process.
//
// cbMsg [in]		: message length in bytes
// cbProcessed [out]: number of processed bytes
// t				: temporary register
//
GET_PROCESSED_BYTES MACRO  cbMsg, cbProcessed, t

		mov		cbProcessed, cbMsg
		mov		t, SHA2_SIMD_LANES * SHA2_INPUT_BLOCK_BYTES
		cmp		cbProcessed, t
		cmova	cbProcessed, t
		and		cbProcessed, -SHA2_INPUT_BLOCK_BYTES

ENDM


//
// SHA-2 core round function that uses BMI2 instructions
//
// a, b, c, e, f, g [in]: hash function state
// d, h [in/out]		: hash function state
// rnd [in]				: round number, used for indexing into the Wk array
// t1..t5				: temporary registers
// Wk [in]				: register pointing to message/constant buffer
// scale [in]			: granularity of elements in message buffer /constant array
// c0_r1, c0_r2, c0_r3	: rotation constants for CSIGMA0 function
// c1_r1, c1_r2, c1_r3	: rotation constants for CSIGMA1 function
//
ROUND_T5_BMI2_V1 MACRO  a, b, c, d, e, f, g, h, rnd, t1, t2, t3, t4, t5, Wk, scale, c0_r1, c0_r2, c0_r3, c1_r1, c1_r2, c1_r3
					
	//					SELECT			CSIGMA0			CSIGMA1			MAJ
	//-------------------------------------------------------------------------------					
														 rorx t5, e, c1_r1					 														 
														 rorx t4, e, c1_r2													
						mov	 t1, f
						andn t2, e, g				
														 rorx t3, e, c1_r3
		add h, [Wk + (rnd) * (scale)]
						and  t1, e
														 xor  t5, t4
						xor  t1, t2										
														 xor  t5, t3
		add h, t1						
										 rorx t2, a, c0_r1															
																		mov t3, b
																		mov t4, b
										 rorx t1, a, c0_r2																	
		add h, t5
																		or	t3, c	
																		and t4, c
																		and t3, a
																		or	t4, t3
		add d, h
										 xor  t2, t1
										 rorx t5, a, c0_r3		 
										 xor  t2, t5																		
		add h, t4																																		
		add h, t2
																																																		
ENDM


ROUND_T5_BMI2_V2 MACRO  a, b, c, d, e, f, g, h, rnd, t1, t2, t3, t4, t5, Wk, scale, c0_r1, c0_r2, c0_r3, c1_r1, c1_r2, c1_r3

	//					SELECT			CSIGMA0			CSIGMA1			MAJ
	//-------------------------------------------------------------------------------	
						mov	 t1, f
						andn t2, e, g				
														 rorx t5, e, c1_r1					 														 
						and  t1, e
														 rorx t4, e, c1_r2													
														 rorx t3, e, c1_r3	
		add h, [Wk + (rnd) * (scale)]
														 xor t5, t4
						xor  t1, t2										
														 xor  t5, t3
		add h, t1						
		add h, t5
																		mov t3, b
										 rorx t1, a, c0_r2																	
										 rorx t2, a, c0_r1															
																		mov t4, b
																		or	t3, c	
																		and t4, c
		add d, h
																		and t3, a
																		or	t4, t3
										 xor  t2, t1
										 rorx t5, a, c0_r3		 
										 xor  t2, t5																		
		add h, t4																																		
		add h, t2
																																																		
ENDM



ROUND_256 MACRO  a, b, c, d, e, f, g, h, rnd, t1, t2, t3, t4, t5, Wk, scale

	ROUND_T5_BMI2_V1 a, b, c, d, e, f, g, h, rnd, t1, t2, t3, t4, t5, Wk, scale, 2, 13, 22, 6, 11, 25

ENDM


ROUND_512 MACRO  a, b, c, d, e, f, g, h, rnd, t1, t2, t3, t4, t5, Wk, scale

	ROUND_T5_BMI2_V1 a, b, c, d, e, f, g, h, rnd, t1, t2, t3, t4, t5, Wk, scale, 28, 34, 39, 14, 18, 41

ENDM



SHA2_UPDATE_CV_HELPER MACRO  rcv, r0, r1, r2, r3, r4, r5, r6, r7

		add r0, [rcv + 0 * SHA2_BYTES_PER_WORD]
		mov [rcv + 0 * SHA2_BYTES_PER_WORD], r0
		add r1, [rcv + 1 * SHA2_BYTES_PER_WORD]
		mov [rcv + 1 * SHA2_BYTES_PER_WORD], r1
		add r2, [rcv + 2 * SHA2_BYTES_PER_WORD]
		mov [rcv + 2 * SHA2_BYTES_PER_WORD], r2
		add r3, [rcv + 3 * SHA2_BYTES_PER_WORD]
		mov [rcv + 3 * SHA2_BYTES_PER_WORD], r3
		add r4, [rcv + 4 * SHA2_BYTES_PER_WORD]
		mov [rcv + 4 * SHA2_BYTES_PER_WORD], r4
		add r5, [rcv + 5 * SHA2_BYTES_PER_WORD]
		mov [rcv + 5 * SHA2_BYTES_PER_WORD], r5
		add r6, [rcv + 6 * SHA2_BYTES_PER_WORD]
		mov [rcv + 6 * SHA2_BYTES_PER_WORD], r6
		add r7, [rcv + 7 * SHA2_BYTES_PER_WORD]		
		mov [rcv + 7 * SHA2_BYTES_PER_WORD], r7

ENDM

#define SHA256_UPDATE_CV(rcv) 	SHA2_UPDATE_CV_HELPER rcv, D0, D1, D2, D3, D4, D5, D6, D7

#define SHA512_UPDATE_CV(rcv) 	SHA2_UPDATE_CV_HELPER rcv, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7


//
//	Load message words, do the endianness transformation and transpose for one or more message blocks.
//
//	P [in]			: register pointing to the beginning of a message
//	N [in]			: number of blocks ( N = 3 or 4 )
//	t, v			: temporary registers
//  ind				: index of which quarter of the block we're processing (ind = 0..3)
//  kreverse		: YMM register containing the value used to do the endianness transform
//  y1..y4	[out]	: YMM registers containing the transposed message words
//  t1..t4			: temporary YMM registers
SHA512_MSG_LOAD_TRANSPOSE_YMM MACRO  P, N, t, v, ind, kreverse, y1, y2, y3, y4, t1, t2, t3, t4

		// Make t point to the third or the fourth block depending on the
		// number of message blocks we have
		mov t, 2 * SHA2_INPUT_BLOCK_BYTES + (ind) * 32
		mov v, 3 * SHA2_INPUT_BLOCK_BYTES + (ind) * 32
		cmp N, 4
		cmove t, v

		// We have at least three message blocks
		vmovdqu	y1, YMMWORD ptr [P + 0 * SHA2_INPUT_BLOCK_BYTES + (ind) * 32]
		vpshufb	y1, y1, kreverse
		vmovdqu	y2, YMMWORD ptr [P + 1 * SHA2_INPUT_BLOCK_BYTES + (ind) * 32]
		vpshufb	y2, y2, kreverse
		vmovdqu	y3, YMMWORD ptr [P + 2 * SHA2_INPUT_BLOCK_BYTES + (ind) * 32]
		vpshufb	y3, y3, kreverse
		
		// If there are only three blocks then t points to the third block and
		// that block is read again, otherwise fourth block is loaded. Rereading
		// a block when we don't have the fourth block is to avoid conditional 
		// loading, the value will not be used.
		vmovdqu	y4, YMMWORD ptr [P + t]
		vpshufb	y4, y4, kreverse
		
		SHA512_MSG_TRANSPOSE_YMM ind, y1, y2, y3, y4, t1, t2, t3, t4

ENDM

//
// Transpose message words from 4 blocks so that each YMM register contains message
// words with the same index within a message block. This macro transforms four message words at a time,
// hence needs to be called four times in order to transform 16 message words.
//
// The transformation is the same whether we have 4 or less blocks. If we have less than 4 blocks,
// the corresponding high order lanes contain garbage, and will not be used in round processing.
//
// ind [in]			: index to which quarter the transformation will take place (ind = 0..3)
// y1..y4 [in/out] : YMM registers each containing 4 message words from different blocks
//						  (y1 = W[4 * ind + 0], y2 = W[4 * ind + 1], y3 = W[4 * ind + 2], y4 = W[4 * ind + 3])
// t1..t4			: temporary YMM registers
//
SHA512_MSG_TRANSPOSE_YMM MACRO  ind, y1, y2, y3, y4, t1, t2, t3, t4

		vpunpcklqdq t1, y1, y2
		vpunpcklqdq t2, y3, y4
		vpunpckhqdq t3, y1, y2
		vpunpckhqdq t4, y3, y4
		vperm2i128	y1, t1, t2, HEX(20)
		vperm2i128	y2, t3, t4, HEX(20)
		vperm2i128	y3, t1, t2, HEX(31)
		vperm2i128	y4, t3, t4, HEX(31)
		vmovdqu		YMMWORD ptr [W + (ind) * 128 + 0 * 32], y1
		vmovdqu		YMMWORD ptr [W + (ind) * 128 + 1 * 32], y2
		vmovdqu		YMMWORD ptr [W + (ind) * 128 + 2 * 32], y3
		vmovdqu		YMMWORD ptr [W + (ind) * 128 + 3 * 32], y4

ENDM




//
// Rotate each 64-bit value in a YMM register
//
// x [in]	: YMM register holding four 64-bit integers
// c [in]	: rotation count
// res [out]: YMM register holding the rotated values
// t1		: temporary YMM register
//
ROR64_YMM MACRO  x, c, res, t1

	vpsrlq	res, x, c
	vpsllq  t1, x, 64 - c
	vpxor	res, res, t1		
	
ENDM


//
// LSIGMA function as defined in FIPS 180-4 acting on four parallel 64-bit values in a YMM register.
//
// x [in]		: YMM register holding four 64-bit integers
// c1..c3 [in]	: rotation and shift counts
// res [out]	: output of the LSIGMA function as four 64-bit integer values
// t1, t2		: temporary YMM registers
//
LSIGMA_YMM MACRO  x, c1, c2, c3, res, t1, t2

		ROR64_YMM	x, c1, res, t1
		ROR64_YMM	x, c2, t2, t1
		vpsrlq		t1, x, c3
		vpxor		res, res, t2
		vpxor		res, res, t1

ENDM


//
// LSIGMA0 function for SHA-512 as defined in FIPS 180-4 acting on four parallel 64-bit values in a YMM register.
//
// This specialized version makes use of byte shuffling instruction for rotating the values by 8. Other rotation and shift counts
// are hardcoded in the macro as it only implements the LSIGMA0 function for SHA-512.
//
// x [in]		: YMM register holding four 64-bit integers
// t1 [out]		: output of the LSIGMA function as four 64-bit integer values
// t2,t3		: temporary YMM registers
// krot8 [in]	: YMM register having the lookup table for byte rotation
//
LSIGMA0_YMM MACRO  x, t1, t2, t3, krot8

		ROR64_YMM	x, 1, t1, t2
		vpsrlq		t3, x, 7
		vpshufb		t2, x, krot8
		vpxor		t1, t1, t2
		vpxor		t1, t1, t3

ENDM


//
// Message expansion for 4 consecutive message blocks and adds constants to round (rnd - 16)
//
// y0 [in/out]		: W_{rnd - 16}, on macro exit it is loaded with W_{rnd - 14} and used as y1 for the
//					  subsequent macro invocation.
// y1 [in]			: W_{rnd - 15}
// y9 [in]			: W_{rnd - 7}
// y14 [in]			: W_{rnd - 2}
// rnd [in]			: round number, rnd = 16..24, uses the previous 16 message word state to generate the next one
// t1 [out]			: expanded message word
// t2..t6			: temporary YMM registers
// krot8 [in]		: YMM register for performing byte rotation
// Wx [in]			: pointer to the message buffer
// k512	[in]		: pointer to the constants 
//
SHA512_MSG_EXPAND_4BLOCKS MACRO  y0, y1, y9, y14, rnd, t1, t2, t3, t4, t5, t6, krot8, Wx, k512

		vpbroadcastq t6, QWORD ptr [k512 + 8 * (rnd - 16)]		// t6 = K_{t-16}
		vpaddq		t6, t6, y0									// t6 = W_{t-16} + K_{t-16}
		vmovdqu		YMMWORD ptr [Wx + (rnd - 16) * 32], t6		// store W_{t-16} + K_{t-16}
		
		LSIGMA_YMM	y14, 19, 61, 6, t4, t5, t3					// t4 = LSIGMA1(W_{t-2})
		LSIGMA0_YMM y1, t2, t1, t6, krot8						// t2 = LSIGMA0(W_{t-15})
		vpaddq		t5, y9, y0									// t5 = W_{t-16} + W_{t-7}
		vpaddq		t3, t2, t4									// t3 = LSIGMA0(W_{t-15}) + LSIGMA1(W_{t-2})
		vpaddq		t1, t3, t5									// t1 = W_t = W_{t-16} + W_{t-7} + LSIGMA0(W_{t-15}) + LSIGMA1(W_{t-2})
		vmovdqu		y0, YMMWORD ptr [Wx + (rnd - 14) * 32]		// y0 = W_{t-14}, load W_{t-15} for next round
		vmovdqu		YMMWORD ptr [Wx + rnd * 32], t1				// store W_t	

ENDM


//
// Add one set of constants to four message words from multiple blocks in a YMM register
//
// rnd [in]		: round index, rnd = 0..7 (Wx and k512 are adjusted so that this macro always acts on the next 8 rounds)
// t1, t2		: temporary YMM registers
// Wx [in]		: pointer to the message buffer
// k512	[in]	: pointer to the constants array
//
SHA512_MSG_ADD_CONST MACRO  rnd, t1, t2, Wx, k512

		vpbroadcastq t2, QWORD ptr [k512 + 8 * (rnd)]
		vmovdqu t1, YMMWORD ptr [Wx + 32 * (rnd)]
		vpaddq  t1, t1, t2
		vmovdqu YMMWORD ptr [Wx + 32 * (rnd)], t1

ENDM


//
// Constant addition for 8 consecutive rounds
//
// Repeats the SHA512_MSG_ADD_CONST macro for 8 consecutive indices.
// Uses the same parameters as SHA512_MSG_ADD_CONST.
//
SHA512_MSG_ADD_CONST_8X MACRO  rnd, t1, t2, Wx, k512

		SHA512_MSG_ADD_CONST (rnd + 0), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 1), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 2), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 3), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 4), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 5), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 6), t1, t2, Wx, k512
		SHA512_MSG_ADD_CONST (rnd + 7), t1, t2, Wx, k512

ENDM

//
// Single block message expansion using YMM registers
//
// y0..y3 [in/out]	: 16 word message state
// t1..t6			: temporary YMM registers
// krot8			: shuffling constant for right rotation of QWORDS by 8
// karr				: pointer to the round constants
// ind				: index used to calculate the offsets for loading constants and storing words to
//					  message buffer W, each increment points to next 4 round constant and message words.
//
//					Message word state before the expansion
//					y0 =  W3  W2  W1  W0
//					y1 =  W7  W6  W5  W4
//					y2 = W11 W10  W9  W8
//					y3 = W15 W14 W13 W12
//
//					After the expansion we will have
//					y1 =  W7  W6  W5  W4
//					y2 = W11 W10  W9  W8
//					y3 = W15 W14 W13 W12
//					y0 = W19 W18 W17 W16
//
// Note: This macro is split into four parts for improved performance when interleaved with the round function
//
SHA512_MSG_EXPAND_1BLOCK_0 MACRO  y0, y1, y2, y3, t1, t2, t3, t4, t5, t6, krot8, karr, ind
		
		vpblendd	t1, y1, y0, HEX(0fc)				// t1 =  W3  W2  W1   W4
		vpblendd	t5, y3, y2, HEX(0fc)				// t5 = W11 W10  W9  W12
		LSIGMA0_YMM t1, t2, t3, t6, krot8				// t2 = LSIGMA0(W3 W2 W1 W4)

ENDM
SHA512_MSG_EXPAND_1BLOCK_1 MACRO  y0, y1, y2, y3, t1, t2, t3, t4, t5, t6, krot8, karr, ind

		vpaddq		t2, t2, t5							// t2 = (W11 W10 W9 W12) + LSIGMA0(W3 W2 W1 W4)
		LSIGMA_YMM	y3, 19, 61, 6, t4, t1, t3			// t4 = LSIGMA1(W15 W14 W13 W12)							
		vpermq		t2, t2, HEX(39)						// t2 = (W12 W11 W10 W9) + LSIGMA0(W4 W3 W2 W1)

ENDM
SHA512_MSG_EXPAND_1BLOCK_2 MACRO  y0, y1, y2, y3, t1, t2, t3, t4, t5, t6, krot8, karr, ind

		vperm2i128	t3, t4, t4, HEX(81)					// t3 = 0 0 LSIGMA1(W15 W14)
		vpaddq		t2, y0, t2							// t2 = (W3 W2 W1 W0) + (W12 W11 W10 W9) + LSIGMA0(W4 W3 W2 W1)
		vpaddq		t2, t2, t3							// t2 = (W3 W2 W1 W0) + (W12 W11 W10 W9) + LSIGMA0(W4 W3 W2 W1) + (0 0 LSIGMA1(W15 W14))
														//    = * * W17 W16		
		LSIGMA_YMM	t2, 19, 61, 6, t4, t5, t3			// t4 = * * LSIGMA1(W17 W16)

ENDM
SHA512_MSG_EXPAND_1BLOCK_3 MACRO  y0, y1, y2, y3, t1, t2, t3, t4, t5, t6, krot8, karr, ind
		
		vperm2i128	t4, t4, t4, HEX(08)					// t4 = LSIGMA1(W17 W16) 0 0
		vmovdqa		t6, YMMWORD ptr [karr + 32 * ind]	// t6 = K19 K18 K17 K16
		vpaddq		y0, t2, t4							// y0 = W19 W18 W17 W16
		vpaddq		t6, t6, y0							// t6 = (K19 K18 K17 K16) + (W19 W18 W17 W16)
		vmovdqu		YMMWORD ptr [W + 32 * ind], t6

ENDM



//VOID
//SYMCRYPT_CALL
//SymCryptSha512AppendBlocks(
//    _Inout_                 SYMCRYPT_SHA512_CHAINING_STATE* pChain,
//    _In_reads_(cbData)      PCBYTE                          pbData,
//                            SIZE_T                          cbData,
//    _Out_                   SIZE_T*                         pcbRemaining)


#define Q0 rax
#define D0 eax
#define W0 ax
#define B0 al
#define Q1 rcx
#define D1 ecx
#define W1 cx
#define B1 cl
#define Q2 rdx
#define D2 edx
#define W2 dx
#define B2 dl
#define Q3 r8
#define D3 r8d
#define W3 r8w
#define B3 r8b
#define Q4 r9
#define D4 r9d
#define W4 r9w
#define B4 r9b
#define Q5 r10
#define D5 r10d
#define W5 r10w
#define B5 r10b
#define Q6 r11
#define D6 r11d
#define W6 r11w
#define B6 r11b
#define Q7 rsi
#define D7 esi
#define W7 si
#define B7 sil
#define Q8 rdi
#define D8 edi
#define W8 di
#define B8 dil
#define Q9 rbp
#define D9 ebp
#define W9 bp
#define B9 bpl
#define Q10 rbx
#define D10 ebx
#define W10 bx
#define B10 bl
#define Q11 r12
#define D11 r12d
#define W11 r12w
#define B11 r12b
#define Q12 r13
#define D12 r13d
#define W12 r13w
#define B12 r13b
#define Q13 r14
#define D13 r14d
#define W13 r14w
#define B13 r14b
#define Q14 r15
#define D14 r15d
#define W14 r15w
#define B14 r15b
NESTED_ENTRY SymCryptSha512AppendBlocks_ymm_avx2_asm, _TEXT

rex_push_reg Q7
push_reg Q8
push_reg Q9
push_reg Q10
push_reg Q11
push_reg Q12
push_reg Q13
push_reg Q14
alloc_stack 2744
save_xmm128 xmm6, 2576
save_xmm128 xmm7, 2592
save_xmm128 xmm8, 2608
save_xmm128 xmm9, 2624
save_xmm128 xmm10, 2640
save_xmm128 xmm11, 2656
save_xmm128 xmm12, 2672
save_xmm128 xmm13, 2688
save_xmm128 xmm14, 2704
save_xmm128 xmm15, 2720

END_PROLOGUE


        // Q1 = pChain
        // Q2 = pbData
        // Q3 = cbData
        // Q4 = pcbRemaining

		vzeroupper

		mov		[rsp + 2816 /*MEMSLOT0*/], Q1
		mov		[rsp + 2824 /*MEMSLOT1*/], Q2
		mov		[rsp + 2832 /*MEMSLOT2*/], Q3
		mov		[rsp + 2840 /*MEMSLOT3*/], Q4


		// We have two implementations using different message buffer sizes. The code below checks the 
		// input message size and helps avoid wiping the larger buffer if we're not using it.
		//
		// If we're processing SHA2_SINGLE_BLOCK_THRESHOLD or more bytes, vectorized message expansion is 
		// used, which expands the message words for 4 blocks. Message expansion for single block processing
		// uses a buffer of 16 message words. Both buffers start at address W (rsp).
		//
		// numBytesToWipe variable holds the number of bytes to wipe from the expanded message buffer
		// before returning from this call.
		//
		// Q3 [in]  : cbData
		// D8 [out] : numBytesToWipe
		mov		D8, 16 * SHA2_BYTES_PER_WORD
		mov		D9, SHA2_EXPANDED_MESSAGE_SIZE
		cmp		Q3, SHA2_SINGLE_BLOCK_THRESHOLD	
		cmovae	D8, D9		
		mov		[numBytesToWipe], D8

		mov		Q10, Q1
		mov		Q0, [Q10 +  0]
		mov		Q1, [Q10 +  8]
		mov		Q2, [Q10 + 16]
		mov		Q3, [Q10 + 24]
		mov		Q4, [Q10 + 32]
		mov		Q5, [Q10 + 40]
		mov		Q6, [Q10 + 48]
		mov		Q7, [Q10 + 56]

		// If message size is less than SHA2_SINGLE_BLOCK_THRESHOLD then use single block message expansion, 
		// otherwise use vectorized message expansion.
		mov		Q8, [rsp + 2832 /*MEMSLOT2*/]
		cmp		Q8, SHA2_SINGLE_BLOCK_THRESHOLD
		jb		single_block_entry

		ALIGN(16)
process_blocks:
		// Calculate the number of blocks to process, Q8 = cbData
		GET_SIMD_BLOCK_COUNT Q8, Q9		// Q8 = min(cbData / 128, 4)
		mov		[numBlocks], Q8

		// Load and transpose message words
		//
		// Inputs
		// Q12 : pbData
		// Q8  : numBlocks
		//
		// We avoid overwriting some of the message words after they're transposed to make
		// them ready for message expansion that follows. These are W0, W1, W9, W10, W11, W12, W13, W14, and W15.
		//
		mov Q12, [rsp + 2824 /*MEMSLOT1*/]
		vmovdqa ymm15, YMMWORD ptr [GET_SYMBOL_ADDRESS(BYTE_REVERSE_64X2)]
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 0, ymm15,  ymm0,  ymm1, ymm2, ymm3,  ymm9, ymm10, ymm11, ymm12 // ymm0 = W0, ymm1 = W1
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 1, ymm15,  ymm2,  ymm3, ymm4, ymm5,  ymm9, ymm10, ymm11, ymm12
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 2, ymm15,  ymm13, ymm2, ymm3, ymm4,  ymm9, ymm10, ymm11, ymm12 // ymm2 = W9, ymm3 = W10, ymm4 = W11
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 3, ymm15,  ymm5,  ymm6, ymm7, ymm8,  ymm9, ymm10, ymm11, ymm12 // ymm5 = W12, ymm6 = W13, ymm7 = W14, ymm8 = W15

		lea		Q13, [W]
		lea		Q14, [GET_SYMBOL_ADDRESS(SymCryptSha512K)]
		vmovdqa ymm15, YMMWORD ptr [GET_SYMBOL_ADDRESS(BYTE_ROTATE_64)]

expand_process_first_block:

		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm2, ymm7, (16 + 0), ymm9, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, 0, Q8, Q9, Q10, Q11, Q12, Q13, 32
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm3, ymm8, (16 + 1), ymm2, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6, 1, Q8, Q9, Q10, Q11, Q12, Q13, 32	
		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm4, ymm9, (16 + 2), ymm3, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5, 2, Q8, Q9, Q10, Q11, Q12, Q13, 32
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm5, ymm2, (16 + 3), ymm4, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4, 3, Q8, Q9, Q10, Q11, Q12, Q13, 32		
		
		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm6, ymm3, (16 + 4), ymm5, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3, 4, Q8, Q9, Q10, Q11, Q12, Q13, 32
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm7, ymm4, (16 + 5), ymm6, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2, 5, Q8, Q9, Q10, Q11, Q12, Q13, 32
		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm8, ymm5, (16 + 6), ymm7, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1, 6, Q8, Q9, Q10, Q11, Q12, Q13, 32
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm9, ymm6, (16 + 7), ymm8, ymm10, ymm11, ymm12, ymm13, ymm14, ymm15, Q13, Q14
		ROUND_512	 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0, 7, Q8, Q9, Q10, Q11, Q12, Q13, 32

		lea		Q8, [GET_SYMBOL_ADDRESS(SymCryptSha512K) + 64 * 8]
		add		Q13, 8 * 32	// next message words
		add		Q14, 8 * 8	// next constants	
		cmp		Q14, Q8
		jb		expand_process_first_block

		// Final 16 rounds
final_rounds:
		SHA512_MSG_ADD_CONST_8X 0, ymm0, ymm1, Q13, Q14
		ROUND_512	 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,  0, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6,  1, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5,  2, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4,  3, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3,  4, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2,  5, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1,  6, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0,  7, Q8, Q9, Q10, Q11, Q12, Q13, 32
			
		lea		Q8, [GET_SYMBOL_ADDRESS(SymCryptSha512K) + 80 * 8]
		add		Q13, 8 * 32	// next message words
		add		Q14, 8 * 8	// next constants	
		cmp		Q14, Q8
		jb		final_rounds
			
		mov Q8, [rsp + 2816 /*MEMSLOT0*/]
		SHA512_UPDATE_CV(Q8)

		// We've processed one block, update the variable.
		// Note: We always have more than one block, no need to check the result of the decrement. 
		dec qword ptr [numBlocks]

		lea		Q13, [W + 8]	// second message block words
		
block_begin:

		mov		D14, 80 / 8

		ALIGN(16)
inner_loop:
		//																		Wk  scale
		ROUND_512	 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,  0, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6,  1, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5,  2, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4,  3, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3,  4, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2,  5, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1,  6, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0,  7, Q8, Q9, Q10, Q11, Q12, Q13, 32

		add		Q13, 8 * 32			// advance to next message words
		sub		D14, 1
		jnz		inner_loop

		add		Q13, (8 - 80 * 32)	// advance to the beginning of message words for the next block				
		
		mov Q8, [rsp + 2816 /*MEMSLOT0*/]
		SHA512_UPDATE_CV(Q8)
		
		dec		QWORD ptr [numBlocks]
		jnz		block_begin

		// Update pbData and cbData
		mov		Q8, [rsp + 2832 /*MEMSLOT2*/]
		GET_PROCESSED_BYTES Q8, Q9, Q10		// Q9 = bytesProcessed
		sub		Q8, Q9
		add		QWORD ptr [rsp + 2824 /*MEMSLOT1*/], Q9
		mov		QWORD ptr [rsp + 2832 /*MEMSLOT2*/], Q8
		cmp		Q8, SHA2_SINGLE_BLOCK_THRESHOLD
		jae		process_blocks

		ALIGN(16)
single_block_entry:

		cmp		Q8, SHA2_INPUT_BLOCK_BYTES		// Q8 = cbData
		jb		done

		// Load the constants once before the block processing loop begins
		// These registers are not touched during block processing
		vmovdqa	ymm14, YMMWORD ptr [GET_SYMBOL_ADDRESS(BYTE_REVERSE_64X2)]
		vmovdqa ymm15, YMMWORD ptr [GET_SYMBOL_ADDRESS(BYTE_ROTATE_64)]

single_block_start:

		mov Q13, [rsp + 2824 /*MEMSLOT1*/]
		lea	Q14, [GET_SYMBOL_ADDRESS(SymCryptSha512K)]

		//
		// Load first 16 message words into ymm0..ymm3 and do the endianness transformation
		// Store the constant added words to message buffer W
		//
		vmovdqu ymm0, YMMWORD ptr [Q13 + 0 * 32]
		vmovdqu ymm1, YMMWORD ptr [Q13 + 1 * 32]
		vmovdqu ymm2, YMMWORD ptr [Q13 + 2 * 32]
		vmovdqu ymm3, YMMWORD ptr [Q13 + 3 * 32]
		vpshufb ymm0, ymm0, ymm14
		vpshufb ymm1, ymm1, ymm14
		vpshufb ymm2, ymm2, ymm14
		vpshufb ymm3, ymm3, ymm14
		vmovdqu ymm4, YMMWORD ptr [Q14 + 0 * 32]
		vmovdqu ymm5, YMMWORD ptr [Q14 + 1 * 32]
		vmovdqu ymm6, YMMWORD ptr [Q14 + 2 * 32]
		vmovdqu ymm7, YMMWORD ptr [Q14 + 3 * 32]
		vpaddq	ymm4, ymm4, ymm0
		vpaddq	ymm5, ymm5, ymm1
		vpaddq	ymm6, ymm6, ymm2
		vpaddq	ymm7, ymm7, ymm3
		vmovdqu YMMWORD ptr [W + 0 * 32], ymm4
		vmovdqu YMMWORD ptr [W + 1 * 32], ymm5
		vmovdqu YMMWORD ptr [W + 2 * 32], ymm6
		vmovdqu YMMWORD ptr [W + 3 * 32], ymm7

inner_loop_single:

		add		Q14, 16 * 8
		//                                                                                    krot8 karr ind
		ROUND_512 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,  0, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_0 ymm0, ymm1, ymm2, ymm3,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 0
		ROUND_512 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6,  1, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_1 ymm0, ymm1, ymm2, ymm3,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 0
		ROUND_512 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5,  2, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_2 ymm0, ymm1, ymm2, ymm3,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 0
		ROUND_512 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4,  3, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_3 ymm0, ymm1, ymm2, ymm3,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 0

		ROUND_512 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3,  4, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_0 ymm1, ymm2, ymm3, ymm0,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 1
		ROUND_512 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2,  5, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_1 ymm1, ymm2, ymm3, ymm0,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 1
		ROUND_512 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1,  6, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_2 ymm1, ymm2, ymm3, ymm0,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 1
		ROUND_512 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0,  7, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_3 ymm1, ymm2, ymm3, ymm0,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 1
		
		ROUND_512 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,  8, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_0 ymm2, ymm3, ymm0, ymm1,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 2
		ROUND_512 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6,  9, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_1 ymm2, ymm3, ymm0, ymm1,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 2
		ROUND_512 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5, 10, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_2 ymm2, ymm3, ymm0, ymm1,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 2
		ROUND_512 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4, 11, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_3 ymm2, ymm3, ymm0, ymm1,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 2

		ROUND_512 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3, 12, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_0 ymm3, ymm0, ymm1, ymm2,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 3
		ROUND_512 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2, 13, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_1 ymm3, ymm0, ymm1, ymm2,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 3
		ROUND_512 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1, 14, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_2 ymm3, ymm0, ymm1, ymm2,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 3
		ROUND_512 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0, 15, Q8, Q9, Q10, Q11, Q12, W, 8
		SHA512_MSG_EXPAND_1BLOCK_3 ymm3, ymm0, ymm1, ymm2,  ymm4, ymm5, ymm6, ymm7, ymm8, ymm9, ymm15, Q14, 3
		
		lea		Q8, [GET_SYMBOL_ADDRESS(SymCryptSha512K) + 64 * 8]
		cmp		Q14, Q8
		jb		inner_loop_single

		lea Q13, [W]
		lea Q14, [W + 16 * 8]

single_block_final_rounds:

		ROUND_512	 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,  0, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6,  1, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5,  2, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4,  3, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3,  4, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2,  5, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1,  6, Q8, Q9, Q10, Q11, Q12, Q13, 8
		ROUND_512	 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0,  7, Q8, Q9, Q10, Q11, Q12, Q13, 8
		
		add Q13, 8 * 8
		cmp Q13, Q14
		jb single_block_final_rounds

		mov Q8, [rsp + 2816 /*MEMSLOT0*/]
		SHA512_UPDATE_CV(Q8)

		// Update pbData and cbData
		mov		Q8, [rsp + 2832 /*MEMSLOT2*/]
		sub		Q8, SHA2_INPUT_BLOCK_BYTES
		add		QWORD ptr [rsp + 2824 /*MEMSLOT1*/], SHA2_INPUT_BLOCK_BYTES
		mov		QWORD ptr [rsp + 2832 /*MEMSLOT2*/], Q8
		cmp		Q8, SHA2_INPUT_BLOCK_BYTES
		jae		single_block_start

done:

		//mov	Q8, [rsp + 2832 /*MEMSLOT2*/]
		mov		Q9, [rsp + 2840 /*MEMSLOT3*/]
		mov		QWORD ptr [Q9], Q8

		vzeroupper

		// Wipe expanded message words
		mov		rdi, rsp
		xor		rax, rax
		mov		ecx, [numBytesToWipe]
		
		// wipe first 128 bytes, the size of the smaller buffer
		pxor	xmm0, xmm0
		movaps	[rdi + 0 * 16], xmm0
		movaps	[rdi + 1 * 16], xmm0
		movaps	[rdi + 2 * 16], xmm0
		movaps	[rdi + 3 * 16], xmm0
		movaps	[rdi + 4 * 16], xmm0
		movaps	[rdi + 5 * 16], xmm0
		movaps	[rdi + 6 * 16], xmm0
		movaps	[rdi + 7 * 16], xmm0
		add		rdi, 8 * 16

		//	if we used vectorized message expansion, wipe the larger buffer
		sub		ecx, 8 * 16	// already wiped above
		jz		nowipe
		rep		stosb

nowipe:



movdqa xmm6, xmmword ptr [rsp + 2576]
movdqa xmm7, xmmword ptr [rsp + 2592]
movdqa xmm8, xmmword ptr [rsp + 2608]
movdqa xmm9, xmmword ptr [rsp + 2624]
movdqa xmm10, xmmword ptr [rsp + 2640]
movdqa xmm11, xmmword ptr [rsp + 2656]
movdqa xmm12, xmmword ptr [rsp + 2672]
movdqa xmm13, xmmword ptr [rsp + 2688]
movdqa xmm14, xmmword ptr [rsp + 2704]
movdqa xmm15, xmmword ptr [rsp + 2720]
add rsp, 2744
BEGIN_EPILOGUE
pop Q14
pop Q13
pop Q12
pop Q11
pop Q10
pop Q9
pop Q8
pop Q7
ret
NESTED_END SymCryptSha512AppendBlocks_ymm_avx2_asm, _TEXT
#undef Q0
#undef D0
#undef W0
#undef B0
#undef Q1
#undef D1
#undef W1
#undef B1
#undef Q2
#undef D2
#undef W2
#undef B2
#undef Q3
#undef D3
#undef W3
#undef B3
#undef Q4
#undef D4
#undef W4
#undef B4
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
#undef Q14
#undef D14
#undef W14
#undef B14

FILE_END()
