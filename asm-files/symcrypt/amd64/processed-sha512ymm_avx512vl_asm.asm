//
//  sha512ymm_avx512vl_asm.symcryptasm   Assembler code for SHA-512 hash function using
//  AVX512F and AVX512VL instruction set extensions and AVX registers (Ymm0-Ymm15).
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
// SHA-2 core round function that uses AVX512 instructions
//
// a, b, c, e, f, g [in]: hash function state
// d, h [in/out]		: hash function state
// xt1..xt4				: temporary XMM registers
// rnd [in]				: round number, used for indexing into the Wk array
// Wk [in]				: register pointing to message/constant buffer
// scale [in]			: granularity of elements in message buffer /constant array
//
ROUND_AVX512 MACRO  a, b, c, d, e, f, g, h, xt1, xt2, xt3, xt4, rnd, Wk, scale

//							SELECT(e, f, g)		CSIGMA0(a)		CSIGMA1(e)		MAJ(a, b, c)				
//-----------------------------------------------------------------------------------------------------------------
															
																vprorq		xt4, e, 14
	vmovq		xt2, QWORD ptr [Wk + rnd * scale]
																vprorq		xt1, e, 18
																vprorq		xt3, e, 41
																vpternlogq	xt3, xt4, xt1, HEX(96)
							vmovdqa		xt1, e
							vpternlogq	xt1, f, g, HEX(0ca)
																				vmovdqa		xt4, a
	vpaddq		h, h, xt2
	vpaddq		h, h, xt1
																				vpternlogq	xt4, b, c, HEX(0e8)
	vpaddq		h, h, xt3
	vpaddq		d, d, h
												vprorq		xt2, a, 28
	vpaddq		h, h, xt4
												vprorq		xt1, a, 34
												vprorq		xt3, a, 39
												vpternlogq	xt1, xt3, xt2, HEX(96)
	vpaddq		h, h, xt1

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
// t2,t3			: temporary YMM registers
// Wx [in]			: pointer to the message buffer
// k512	[in]		: pointer to the constants 
//
SHA512_MSG_EXPAND_4BLOCKS MACRO  y0, y1, y9, y14, rnd, t1, t2, t3, Wx, k512

		vpbroadcastq t1, QWORD ptr [k512 + 8 * (rnd - 16)]		// t1 = K_{t-16}
		vpaddq		t1, t1, y0									// t1 = W_{t-16} + K_{t-16}					
		vmovdqu		YMMWORD ptr [Wx + (rnd - 16) * 32], t1		// store W_{t-16} + K_{t-16}
		
		vprorq		t1, y14, 19
		vprorq		t2, y14, 61
		vpsrlq		t3, y14, 6
		vpternlogq	t1, t2, t3, HEX(96)							// t1 = LSIGMA1(W_{t-2})

		vpaddq		y0, y0, y9									// y0 = W_{t-16} + W_{t-7}
		vpaddq		y0, y0, t1									// y0 = W_{t-16} + W_{t-7} + LSIGMA1(W_{t-2})

		vprorq		t2, y1, 1
		vprorq		t3, y1, 8
		vpsrlq		t1, y1, 7
		vpternlogq	t2, t3, t1, HEX(96)							// t2 = LSIGMA0(W_{t-15})
		
		vpaddq		t1, t2, y0									// t1 = W_t = W_{t-16} + W_{t-7} + LSIGMA1(W_{t-2}) + LSIGMA0(W_{t-15}) 			

		vmovdqu		y0, YMMWORD ptr [Wx + (rnd - 14) * 32]		// y0 = W_{t-14}, load W_{t-15} for next round
		vmovdqu		YMMWORD ptr [Wx + rnd * 32], t1				// store W_t	

ENDM


//
// Single block message expansion using YMM registers
//
// y0..y3 [in/out]	: 16 word message state
// t1..t4			: temporary YMM registers
// karr				: pointer to the round constants
// ind				: index used to calculate the offsets for loading constants and storing words to
//					  message buffer W, each increment points to next 4 round constant and message words.
//
SHA512_MSG_EXPAND_1BLOCK MACRO  y0, y1, y2, y3, t1, t2, t3, t4, karr, ind

		// Message word state before the expansion
		// y0 =  W3  W2  W1  W0
		// y1 =  W7  W6  W5  W4
		// y2 = W11 W10  W9  W8
		// y3 = W15 W14 W13 W12

		// After the expansion we will have
		// y1 =  W7  W6  W5  W4
		// y2 = W11 W10  W9  W8
		// y3 = W15 W14 W13 W12
		// y0 = W19 W18 W17 W16

		valignq		t1, y1, y0, 1						// t1 = W4 W3 W2 W1
		vprorq		t2, t1, 1
		vprorq		t3, t1, 8
		vpsrlq		t1, t1, 7
		vpternlogq	t1, t2, t3, HEX(96)					// t1 = LSIGMA0(W4 W3 W2 W1)
	
		valignq		t4, y3, y2, 1						// t4 = W12 W11 W10 W9
		vpaddq		y0, y0, t1							// y0 = (W3 W2 W1 W0) + LSIGMA0(W4 W3 W2 W1)
		vpaddq		y0, y0, t4							// y0 = (W3 W2 W1 W0) + LSIGMA0(W4 W3 W2 W1) + (W12 W11 W10 W9)
	
		vprorq		t2, y3, 19
		vprorq		t3, y3, 61
		vpsrlq		t1, y3, 6
		vpternlogq	t1, t2, t3, HEX(96)					// t1 = LSIGMA(W15 W14 W13 W12)
		vperm2i128	t1, t1, t1, HEX(81)					// t1 = 0 0 LSIGMA1(W15 W14)

		vpaddq		t1, y0, t1							// t1 = (W3 W2 W1 W0) + LSIGMA0(W4 W3 W2 W1) + (W12 W11 W10 W9) + (0 0 LSIGMA1(W15 W14))
														//    = * * W17 W16
		vprorq		t2, t1, 19
		vprorq		t3, t1, 61
		vpsrlq		t4, t1, 6
		vpternlogq	t2, t3, t4, HEX(96)					// t2 = * * LSIGMA1(W17 W16)
		vperm2i128	t3, t2, t2, HEX(28)					// t3 = LSIGMA1(W17 W16) 0 0

		vmovdqa		t4, YMMWORD ptr [karr + ind * 32]	// t4 = K19 K18 K17 K16
		vpaddq		y0, t1, t3							// y0 = W19 W18 W17 W16
		vpaddq		t4, t4, y0							// t4 = (K19 K18 K17 K16) + (W19 W18 W17 W16)
		vmovdqu		YMMWORD ptr [rsp + ind * 32], t4

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
// Copy the state words from 64-bit general-purpose registers to lower QWORDS of first
// eight XMM registers. 
//
// a..h [in]		: SHA-512 state words
// xmm0..xmm7 [out]	: These parameters are implicit. Lower QWORD of each register will contain
//					  the corresponding state word copied from the general purpose register.
//
// We're using vmovq instruction to stay in the YMM domain
// and clearing the other QWORDS of the YMM registers in the process, however only
// the least significant QWORD is used during AVX512 round processing.
//
SHA512_COPY_STATE_R64_TO_XMM MACRO  a, b, c, d, e, f, g, h

		vmovq	xmm0, a
		vmovq	xmm1, b
		vmovq	xmm2, c
		vmovq	xmm3, d
		vmovq	xmm4, e
		vmovq	xmm5, f
		vmovq	xmm6, g
		vmovq	xmm7, h

ENDM


//
// Copy the state words from first eight XMM registers to 64-bit general-purpose registers
//
// a..h [out]		: SHA-512 state words
// xmm0..xmm7 [in]	: These parameters are implicit. Lower QWORD of each register will be
//					  copied to the corresponding general purpose register.
//
SHA512_COPY_STATE_XMM_TO_R64 MACRO  a, b, c, d, e, f, g, h

		vmovq	a, xmm0
		vmovq	b, xmm1
		vmovq	c, xmm2
		vmovq	d, xmm3
		vmovq	e, xmm4
		vmovq	f, xmm5
		vmovq	g, xmm6
		vmovq	h, xmm7

ENDM


//
// Update the chaining value using the previous CV from the XMM registers 
// provided as input and current state in xmm0..xmm7.
//
// Xba, Xdc, Xfe, Xhg [in/out]	: previous CV on entry, next CV on exit
// xmm0..xmm7 [in/out]			: implicit parameters, current state on input, feed 
//								  forwarded state (i.e. next CV) on exit
// xt							: temporary register
//
SHA512_UPDATE_CV_XMM MACRO  Xba, Xdc, Xfe, Xhg, xt

		// The previous state is denoted by a..h and the current state is a'..h'.
		// * : don't care value
		
		vpshufd		xt, Xba, 14			// xt   = * b
		vpaddq		xmm0, xmm0, Xba		// xmm0 = * (a + a')
		vpaddq		xmm1, xmm1, xt		// xmm1 = * (b + b')
		vpshufd		xt, Xdc, 14			// xt   = * d
		vpaddq		xmm2, xmm2, Xdc		// xmm2 = * (c + c')
		vpaddq		xmm3, xmm3, xt		// xmm3 = * (d + d')
		vpshufd		xt, Xfe, 14			// xt   = * f
		vpaddq		xmm4, xmm4, Xfe		// xmm4 = * (e + e')
		vpaddq		xmm5, xmm5, xt		// xmm5 = * (f + f')
		vpshufd		xt, Xhg, 14			// xt   = * h
		vpaddq		xmm6, xmm6, Xhg		// xmm6 = * (g + g')
		vpaddq		xmm7, xmm7, xt		// xmm7 = * (h + h')
		vpunpcklqdq	Xba, xmm0, xmm1		// xmm14 = (b + b') (a + a')
		vpunpcklqdq	Xdc, xmm2, xmm3		// xmm12 = (d + d') (c + c')
		vpunpcklqdq	Xfe, xmm4, xmm5		// xmm15 = (f + f') (e + e')
		vpunpcklqdq	Xhg, xmm6, xmm7		// xmm13 = (h + h') (g + g')

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
NESTED_ENTRY SymCryptSha512AppendBlocks_ymm_avx512vl_asm, _TEXT

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

		// Load chaining value to YMM registers
		// CV will be stored in YMM registers during multi-block message processing
		vmovdqu		ymm14, YMMWORD ptr [Q1 + 0 * 32]		// ymm14 = d c b a
		vmovdqu		ymm15, YMMWORD ptr [Q1 + 1 * 32]		// ymm15 = h g f e

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
		vmovdqa ymm13, YMMWORD ptr [GET_SYMBOL_ADDRESS(BYTE_REVERSE_64X2)]
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 1, ymm13,  ymm2,  ymm3, ymm4, ymm5,  ymm9, ymm10, ymm11, ymm12
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 2, ymm13,  ymm5,  ymm2, ymm3, ymm4,  ymm9, ymm10, ymm11, ymm12 // ymm2 = W9, ymm3 = W10, ymm4 = W11
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 0, ymm13,  ymm0,  ymm1, ymm5, ymm6,  ymm9, ymm10, ymm11, ymm12 // ymm0 = W0, ymm1 = W1
		SHA512_MSG_LOAD_TRANSPOSE_YMM Q12, Q8, Q9, Q10, 3, ymm13,  ymm5,  ymm6, ymm7, ymm8,  ymm9, ymm10, ymm11, ymm12 // ymm5 = W12, ymm6 = W13, ymm7 = W14, ymm8 = W15

		lea		Q13, [W]
		lea		Q14, [GET_SYMBOL_ADDRESS(SymCryptSha512K)]

		// Note: We cannot use the AVX512 round function in the following block due to the lack of sufficient YMM registers,
		//		 so instead we use the BMI2 round function that acts on general-purpose registers.

expand_process_first_block:

		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm2, ymm7, (16 + 0), ymm9, ymm10, ymm11, Q13, Q14
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm3, ymm8, (16 + 1), ymm2, ymm10, ymm11, Q13, Q14
		ROUND_512	 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, 0, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q7, Q0, Q1, Q2, Q3, Q4, Q5, Q6, 1, Q8, Q9, Q10, Q11, Q12, Q13, 32	
		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm4, ymm9, (16 + 2), ymm3, ymm10, ymm11, Q13, Q14
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm5, ymm2, (16 + 3), ymm4, ymm10, ymm11, Q13, Q14
		ROUND_512	 Q6, Q7, Q0, Q1, Q2, Q3, Q4, Q5, 2, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q5, Q6, Q7, Q0, Q1, Q2, Q3, Q4, 3, Q8, Q9, Q10, Q11, Q12, Q13, 32		
		
		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm6, ymm3, (16 + 4), ymm5, ymm10, ymm11, Q13, Q14
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm7, ymm4, (16 + 5), ymm6, ymm10, ymm11, Q13, Q14
		ROUND_512	 Q4, Q5, Q6, Q7, Q0, Q1, Q2, Q3, 4, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q3, Q4, Q5, Q6, Q7, Q0, Q1, Q2, 5, Q8, Q9, Q10, Q11, Q12, Q13, 32
		SHA512_MSG_EXPAND_4BLOCKS	ymm0, ymm1, ymm8, ymm5, (16 + 6), ymm7, ymm10, ymm11, Q13, Q14
		SHA512_MSG_EXPAND_4BLOCKS	ymm1, ymm0, ymm9, ymm6, (16 + 7), ymm8, ymm10, ymm11, Q13, Q14
		ROUND_512	 Q2, Q3, Q4, Q5, Q6, Q7, Q0, Q1, 6, Q8, Q9, Q10, Q11, Q12, Q13, 32
		ROUND_512	 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q0, 7, Q8, Q9, Q10, Q11, Q12, Q13, 32

		lea		Q8, [GET_SYMBOL_ADDRESS(SymCryptSha512K) + 64 * 8]
		add		Q13, 8 * 32	// next message words
		add		Q14, 8 * 8	// next constants	
		cmp		Q14, Q8
		jb		expand_process_first_block

		//
		// We have two more YMM registers (ymm12, ymm13) available for the remainder of multi-block message processing.
		// Spread the CV to four registers in order to make the feed-forwarding more efficient. Currently, the CV is 
		// in ymm14 and ymm15:
		//
		//		ymm14 = d c b a		 
		//		ymm15 = h g f e	
		//
		// Feed forwarding with 2 words per register requires less packing-unpacking compared to 4 words per register.
		// We use the lower two QWORDS of ymm14, ymm12, ymm15, ymm13 as the CV after the following two instructions.
		vpermq		ymm12, ymm14, HEX(0e)		// ymm12 = * * d c
		vpermq		ymm13, ymm15, HEX(0e)		// ymm13 = * * h g

		// The state will be in YMM registers in the remaining of this block and the next blocks until we do another
		// message expansion with YMM registers or be done with multi-block processing.
		SHA512_COPY_STATE_R64_TO_XMM Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7

		// Final 16 rounds
final_rounds:
		SHA512_MSG_ADD_CONST_8X 0, ymm8, ymm9, Q13, Q14
		ROUND_AVX512	xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	 xmm8, xmm9, xmm10, xmm11, 0, Q13, 32		
		ROUND_AVX512	xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6,  xmm8, xmm9, xmm10, xmm11, 1, Q13, 32
		ROUND_AVX512	xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5,	 xmm8, xmm9, xmm10, xmm11, 2, Q13, 32
		ROUND_AVX512	xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4,	 xmm8, xmm9, xmm10, xmm11, 3, Q13, 32
		ROUND_AVX512	xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3,	 xmm8, xmm9, xmm10, xmm11, 4, Q13, 32
		ROUND_AVX512	xmm3, xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2,  xmm8, xmm9, xmm10, xmm11, 5, Q13, 32
		ROUND_AVX512	xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	xmm0, xmm1,  xmm8, xmm9, xmm10, xmm11, 6, Q13, 32
		ROUND_AVX512	xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm0,  xmm8, xmm9, xmm10, xmm11, 7, Q13, 32	
		
		lea		Q8, [GET_SYMBOL_ADDRESS(SymCryptSha512K) + 80 * 8]	
		add		Q13, 8 * 32	
		add		Q14, 8 * 8
		cmp		Q14, Q8
		jb		final_rounds

		// Update the CV using the previous state from xmm14, xmm12, xmm15, xmm13 (2 words per register) and
		// current state from xmm0..xmm7 (1 word per register).
		SHA512_UPDATE_CV_XMM xmm14, xmm12, xmm15, xmm13,  xmm9

		// We've processed one block, update the variable.
		// Note: We always have more than one block, no need to check the result of the decrement. 
		dec qword ptr [numBlocks]

		lea		Q13, [W + 8]	// second message block words
		
block_begin:

		mov		D14, 80 / 8

		ALIGN(16)
inner_loop:
		//																							   Wk  scale
		ROUND_AVX512	xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	 xmm8, xmm9, xmm10, xmm11, 0, Q13, 32		
		ROUND_AVX512	xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6,  xmm8, xmm9, xmm10, xmm11, 1, Q13, 32
		ROUND_AVX512	xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5,	 xmm8, xmm9, xmm10, xmm11, 2, Q13, 32
		ROUND_AVX512	xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4,	 xmm8, xmm9, xmm10, xmm11, 3, Q13, 32
		ROUND_AVX512	xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3,	 xmm8, xmm9, xmm10, xmm11, 4, Q13, 32
		ROUND_AVX512	xmm3, xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2,  xmm8, xmm9, xmm10, xmm11, 5, Q13, 32
		ROUND_AVX512	xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	xmm0, xmm1,  xmm8, xmm9, xmm10, xmm11, 6, Q13, 32
		ROUND_AVX512	xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm0,  xmm8, xmm9, xmm10, xmm11, 7, Q13, 32	

		add		Q13, 8 * 32			// advance to next message words
		sub		D14, 1
		jnz		inner_loop

		add		Q13, (8 - 80 * 32)	// advance to the beginning of message words for the next block				
				
		// Update the CV using the previous state from xmm14, xmm12, xmm15, xmm13 (2 words per register) and
		// current state from xmm0..xmm7 (1 word per register).
		SHA512_UPDATE_CV_XMM xmm14, xmm12, xmm15, xmm13,  xmm9

		dec		QWORD ptr [numBlocks]
		jnz		block_begin

		// We need to copy the state to general-purpose registers as both single-block processing or
		// the beginning of multi-block processing assume the state is in those registers.
		SHA512_COPY_STATE_XMM_TO_R64 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7

		vperm2i128	ymm14, ymm14, ymm12, HEX(20)
		vperm2i128	ymm15, ymm15, ymm13, HEX(20)

		// Update pbData and cbData
		mov		Q8, [rsp + 2832 /*MEMSLOT2*/]
		GET_PROCESSED_BYTES Q8, Q9, Q10		// Q9 = bytesProcessed
		sub		Q8, Q9
		add		QWORD ptr [rsp + 2824 /*MEMSLOT1*/], Q9
		mov		QWORD ptr [rsp + 2832 /*MEMSLOT2*/], Q8
		cmp		Q8, SHA2_SINGLE_BLOCK_THRESHOLD
		jae		process_blocks

		// Write the chaining value to memory
		mov			Q9, [rsp + 2816 /*MEMSLOT0*/]
		vmovdqu		YMMWORD ptr [Q9 + 0 * 32], ymm14
		vmovdqu		YMMWORD ptr [Q9 + 1 * 32], ymm15


		ALIGN(16)
single_block_entry:

		cmp		Q8, SHA2_INPUT_BLOCK_BYTES		// Q8 = cbData
		jb		done

single_block_start:

		mov Q13, [rsp + 2824 /*MEMSLOT1*/]
		lea	Q14, [GET_SYMBOL_ADDRESS(SymCryptSha512K)]

		SHA512_COPY_STATE_R64_TO_XMM Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7

		//
		// Load first 16 message words into ymm12..ymm15 and do the endianness transformation
		// Store the constant added words to message buffer W
		//
		vmovdqa		ymm8, YMMWORD ptr [GET_SYMBOL_ADDRESS(BYTE_REVERSE_64X2)]
		vmovdqu		ymm12, YMMWORD ptr [r14 + 0 * 32]
		vmovdqu		ymm13, YMMWORD ptr [r14 + 1 * 32]
		vmovdqu		ymm14, YMMWORD ptr [r14 + 2 * 32]
		vmovdqu		ymm15, YMMWORD ptr [r14 + 3 * 32]
		vpshufb		ymm12, ymm12, ymm8
		vpshufb		ymm13, ymm13, ymm8
		vpshufb		ymm14, ymm14, ymm8
		vpshufb		ymm15, ymm15, ymm8
		vmovdqa		ymm8,  YMMWORD ptr [r15 + 0 * 32]
		vmovdqa		ymm9,  YMMWORD ptr [r15 + 1 * 32]
		vmovdqa		ymm10, YMMWORD ptr [r15 + 2 * 32]
		vmovdqa		ymm11, YMMWORD ptr [r15 + 3 * 32]
		vpaddq		ymm8, ymm12, ymm8
		vpaddq		ymm9, ymm13, ymm9
		vpaddq		ymm10, ymm14, ymm10
		vpaddq		ymm11, ymm15, ymm11
		vmovdqu		YMMWORD ptr [rsp + 0 * 32], ymm8
		vmovdqu		YMMWORD ptr [rsp + 1 * 32], ymm9
		vmovdqu		YMMWORD ptr [rsp + 2 * 32], ymm10
		vmovdqu		YMMWORD ptr [rsp + 3 * 32], ymm11
		
inner_loop_single:

		add		Q14, 16 * 8

		ROUND_AVX512	xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	 xmm8, xmm9, xmm10, xmm11,  0, W, 8		
		ROUND_AVX512	xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6,  xmm8, xmm9, xmm10, xmm11,  1, W, 8
		ROUND_AVX512	xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5,	 xmm8, xmm9, xmm10, xmm11,  2, W, 8
		ROUND_AVX512	xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4,	 xmm8, xmm9, xmm10, xmm11,  3, W, 8																								   
		SHA512_MSG_EXPAND_1BLOCK ymm12, ymm13, ymm14, ymm15,  ymm8, ymm9, ymm10, ymm11, Q14, 0

		ROUND_AVX512	xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3,	 xmm8, xmm9, xmm10, xmm11,  4, W, 8
		ROUND_AVX512	xmm3, xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2,  xmm8, xmm9, xmm10, xmm11,  5, W, 8
		ROUND_AVX512	xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	xmm0, xmm1,  xmm8, xmm9, xmm10, xmm11,  6, W, 8
		ROUND_AVX512	xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm0,  xmm8, xmm9, xmm10, xmm11,  7, W, 8		
		SHA512_MSG_EXPAND_1BLOCK ymm13, ymm14, ymm15, ymm12,  ymm8, ymm9, ymm10, ymm11, Q14, 1

		ROUND_AVX512	xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	 xmm8, xmm9, xmm10, xmm11,  8, W, 8		
		ROUND_AVX512	xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6,  xmm8, xmm9, xmm10, xmm11,  9, W, 8
		ROUND_AVX512	xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5,	 xmm8, xmm9, xmm10, xmm11, 10, W, 8
		ROUND_AVX512	xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4,	 xmm8, xmm9, xmm10, xmm11, 11, W, 8		
		SHA512_MSG_EXPAND_1BLOCK ymm14, ymm15, ymm12, ymm13,  ymm8, ymm9, ymm10, ymm11, Q14, 2

		ROUND_AVX512	xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3,	 xmm8, xmm9, xmm10, xmm11, 12, W, 8
		ROUND_AVX512	xmm3, xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2,  xmm8, xmm9, xmm10, xmm11, 13, W, 8
		ROUND_AVX512	xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	xmm0, xmm1,  xmm8, xmm9, xmm10, xmm11, 14, W, 8		
		ROUND_AVX512	xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm0,  xmm8, xmm9, xmm10, xmm11, 15, W, 8	
		SHA512_MSG_EXPAND_1BLOCK ymm15, ymm12, ymm13, ymm14,  ymm8, ymm9, ymm10, ymm11, Q14, 3
		
		lea		Q8, [GET_SYMBOL_ADDRESS(SymCryptSha512K) + 64 * 8]
		cmp		Q14, Q8
		jb		inner_loop_single


		lea Q13, [W]
		lea Q14, [W + 16 * 8]

single_block_final_rounds:

		ROUND_AVX512	xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	 xmm8, xmm9, xmm10, xmm11,  0, Q13, 8		
		ROUND_AVX512	xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6,  xmm8, xmm9, xmm10, xmm11,  1, Q13, 8
		ROUND_AVX512	xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4, xmm5,	 xmm8, xmm9, xmm10, xmm11,  2, Q13, 8
		ROUND_AVX512	xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3, xmm4,	 xmm8, xmm9, xmm10, xmm11,  3, Q13, 8																								   
		ROUND_AVX512	xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2, xmm3,	 xmm8, xmm9, xmm10, xmm11,  4, Q13, 8
		ROUND_AVX512	xmm3, xmm4, xmm5, xmm6, xmm7, xmm0, xmm1, xmm2,  xmm8, xmm9, xmm10, xmm11,  5, Q13, 8
		ROUND_AVX512	xmm2, xmm3, xmm4, xmm5, xmm6, xmm7,	xmm0, xmm1,  xmm8, xmm9, xmm10, xmm11,  6, Q13, 8
		ROUND_AVX512	xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm0,  xmm8, xmm9, xmm10, xmm11,  7, Q13, 8		
		
		add Q13, 8 * 8
		cmp Q13, Q14
		jb single_block_final_rounds
				
		SHA512_COPY_STATE_XMM_TO_R64 Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7

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
NESTED_END SymCryptSha512AppendBlocks_ymm_avx512vl_asm, _TEXT
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
