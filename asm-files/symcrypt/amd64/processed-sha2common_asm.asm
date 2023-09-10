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

