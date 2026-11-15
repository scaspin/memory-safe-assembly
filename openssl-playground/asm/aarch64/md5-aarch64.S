
.text
.globl ossl_md5_block_asm_data_order
.type ossl_md5_block_asm_data_order,@function
ossl_md5_block_asm_data_order:
 stp x19,x20,[sp,#-80]!
 stp x21,x22,[sp,#16]
 stp x23,x24,[sp,#32]
 stp x25,x26,[sp,#48]
 stp x27,x28,[sp,#64]
 ldp w10, w11, [x0, #0]
 ldp w12, w13, [x0, #8]
.align 5
ossl_md5_blocks_loop:
 eor x17, x12, x13
 and x16, x17, x11
 ldp w15, w20, [x1]
 ldp w3, w21, [x1, #8]
 eor x14, x16, x13
 movz x9, #0xa478
 movk x9, #0xd76a, lsl #16
 add w8, w10, w15
 add w7, w8, w9
 add w6, w7, w14
 ror w6, w6, #25
 eor x5, x11, x12
 add w4, w11, w6
 and x8, x5, x4
 eor x17, x8, x12
 movz x16, #0xb756
 movk x16, #0xe8c7, lsl #16
 add w9, w13, w20
 add w7, w9, w16
 add w14, w7, w17
 ror w14, w14, #20
 eor x6, x4, x11
 add w5, w4, w14
 and x8, x6, x5
 eor x9, x8, x11
 movz x16, #0x70db
 movk x16, #0x2420, lsl #16
 add w7, w12, w3
 add w17, w7, w16
 add w14, w17, w9
 ror w14, w14, #15
 eor x6, x5, x4
 add w8, w5, w14
 and x7, x6, x8
 eor x16, x7, x4
 movz x9, #0xceee
 movk x9, #0xc1bd, lsl #16
 add w14, w11, w21
 add w6, w14, w9
 add w7, w6, w16
 ror w7, w7, #10
 eor x17, x8, x5
 add w9, w8, w7
 ldp w14, w22, [x1, #16]
 ldp w7, w23, [x1, #24]
 and x16, x17, x9
 eor x6, x16, x5
 movz x16, #0xfaf
 movk x16, #0xf57c, lsl #16
 add w17, w4, w14
 add w16, w17, w16
 add w4, w16, w6
 ror w4, w4, #25
 eor x16, x9, x8
 add w17, w9, w4
 and x16, x16, x17
 eor x6, x16, x8
 movz x4, #0xc62a
 movk x4, #0x4787, lsl #16
 add w16, w5, w22
 add w16, w16, w4
 add w5, w16, w6
 ror w5, w5, #20
 eor x4, x17, x9
 add w19, w17, w5
 and x6, x4, x19
 eor x5, x6, x9
 movz x4, #0x4613
 movk x4, #0xa830, lsl #16
 add w6, w8, w7
 add w8, w6, w4
 add w4, w8, w5
 ror w4, w4, #15
 eor x6, x19, x17
 add w8, w19, w4
 and x5, x6, x8
 eor x4, x5, x17
 movz x6, #0x9501
 movk x6, #0xfd46, lsl #16
 add w9, w9, w23
 add w5, w9, w6
 add w9, w5, w4
 ror w9, w9, #10
 eor x6, x8, x19
 add w4, w8, w9
 ldp w5, w24, [x1, #32]
 ldp w16, w25, [x1, #40]
 and x9, x6, x4
 eor x6, x9, x19
 movz x9, #0x98d8
 movk x9, #0x6980, lsl #16
 add w17, w17, w5
 add w9, w17, w9
 add w17, w9, w6
 ror w17, w17, #25
 eor x9, x4, x8
 add w6, w4, w17
 and x17, x9, x6
 eor x9, x17, x8
 movz x17, #0xf7af
 movk x17, #0x8b44, lsl #16
 add w19, w19, w24
 add w17, w19, w17
 add w19, w17, w9
 ror w19, w19, #20
 eor x9, x6, x4
 add w17, w6, w19
 and x9, x9, x17
 eor x9, x9, x4
 movz x11, #0x5bb1
 movk x11, #0xffff, lsl #16
 add w8, w8, w16
 add w8, w8, w11
 add w8, w8, w9
 ror w8, w8, #15
 eor x9, x17, x6
 add w8, w17, w8
 and x9, x9, x8
 eor x9, x9, x6
 movz x11, #0xd7be
 movk x11, #0x895c, lsl #16
 add w4, w4, w25
 add w4, w4, w11
 add w9, w4, w9
 ror w9, w9, #10
 eor x4, x8, x17
 add w9, w8, w9
 ldp w11, w26, [x1, #48]
 ldp w12, w27, [x1, #56]
 and x4, x4, x9
 eor x4, x4, x17
 movz x19, #0x1122
 movk x19, #0x6b90, lsl #16
 add w6, w6, w11
 add w6, w6, w19
 add w4, w6, w4
 ror w4, w4, #25
 eor x6, x9, x8
 add w4, w9, w4
 and x6, x6, x4
 eor x6, x6, x8
 movz x19, #0x7193
 movk x19, #0xfd98, lsl #16
 add w17, w17, w26
 add w17, w17, w19
 add w17, w17, w6
 ror w17, w17, #20
 eor x6, x4, x9
 add w17, w4, w17
 and x6, x6, x17
 eor x6, x6, x9
 movz x13, #0x438e
 movk x13, #0xa679, lsl #16
 add w8, w8, w12
 add w8, w8, w13
 add w8, w8, w6
 ror w8, w8, #15
 eor x6, x17, x4
 add w8, w17, w8
 and x6, x6, x8
 eor x6, x6, x4
 movz x13, #0x821
 movk x13, #0x49b4, lsl #16
 add w9, w9, w27
 add w9, w9, w13
 add w9, w9, w6
 ror w9, w9, #10
 bic x6, x8, x17
 add w9, w8, w9
 movz x13, #0x2562
 movk x13, #0xf61e, lsl #16
 add w4, w4, w20
 add w4, w4, w13
 and x13, x9, x17
 add w4, w4, w6
 add w4, w4, w13
 ror w4, w4, #27
 bic x6, x9, x8
 add w4, w9, w4
 movz x13, #0xb340
 movk x13, #0xc040, lsl #16
 add w17, w17, w7
 add w17, w17, w13
 and x13, x4, x8
 add w17, w17, w6
 add w17, w17, w13
 ror w17, w17, #23
 bic x6, x4, x9
 add w17, w4, w17
 movz x13, #0x5a51
 movk x13, #0x265e, lsl #16
 add w8, w8, w25
 add w8, w8, w13
 and x13, x17, x9
 add w8, w8, w6
 add w8, w8, w13
 ror w8, w8, #18
 bic x6, x17, x4
 add w8, w17, w8
 movz x13, #0xc7aa
 movk x13, #0xe9b6, lsl #16
 add w9, w9, w15
 add w9, w9, w13
 and x13, x8, x4
 add w9, w9, w6
 add w9, w9, w13
 ror w9, w9, #12
 bic x6, x8, x17
 add w9, w8, w9
 movz x13, #0x105d
 movk x13, #0xd62f, lsl #16
 add w4, w4, w22
 add w4, w4, w13
 and x13, x9, x17
 add w4, w4, w6
 add w4, w4, w13
 ror w4, w4, #27
 bic x6, x9, x8
 add w4, w9, w4
 movz x13, #0x1453
 movk x13, #0x244, lsl #16
 add w17, w17, w16
 add w17, w17, w13
 and x13, x4, x8
 add w17, w17, w6
 add w17, w17, w13
 ror w17, w17, #23
 bic x6, x4, x9
 add w17, w4, w17
 movz x13, #0xe681
 movk x13, #0xd8a1, lsl #16
 add w8, w8, w27
 add w8, w8, w13
 and x13, x17, x9
 add w8, w8, w6
 add w8, w8, w13
 ror w8, w8, #18
 bic x6, x17, x4
 add w8, w17, w8
 movz x13, #0xfbc8
 movk x13, #0xe7d3, lsl #16
 add w9, w9, w14
 add w9, w9, w13
 and x13, x8, x4
 add w9, w9, w6
 add w9, w9, w13
 ror w9, w9, #12
 bic x6, x8, x17
 add w9, w8, w9
 movz x13, #0xcde6
 movk x13, #0x21e1, lsl #16
 add w4, w4, w24
 add w4, w4, w13
 and x13, x9, x17
 add w4, w4, w6
 add w4, w4, w13
 ror w4, w4, #27
 bic x6, x9, x8
 add w4, w9, w4
 movz x13, #0x7d6
 movk x13, #0xc337, lsl #16
 add w17, w17, w12
 add w17, w17, w13
 and x13, x4, x8
 add w17, w17, w6
 add w17, w17, w13
 ror w17, w17, #23
 bic x6, x4, x9
 add w17, w4, w17
 movz x13, #0xd87
 movk x13, #0xf4d5, lsl #16
 add w8, w8, w21
 add w8, w8, w13
 and x13, x17, x9
 add w8, w8, w6
 add w8, w8, w13
 ror w8, w8, #18
 bic x6, x17, x4
 add w8, w17, w8
 movz x13, #0x14ed
 movk x13, #0x455a, lsl #16
 add w9, w9, w5
 add w9, w9, w13
 and x13, x8, x4
 add w9, w9, w6
 add w9, w9, w13
 ror w9, w9, #12
 bic x6, x8, x17
 add w9, w8, w9
 movz x13, #0xe905
 movk x13, #0xa9e3, lsl #16
 add w4, w4, w26
 add w4, w4, w13
 and x13, x9, x17
 add w4, w4, w6
 add w4, w4, w13
 ror w4, w4, #27
 bic x6, x9, x8
 add w4, w9, w4
 movz x13, #0xa3f8
 movk x13, #0xfcef, lsl #16
 add w17, w17, w3
 add w17, w17, w13
 and x13, x4, x8
 add w17, w17, w6
 add w17, w17, w13
 ror w17, w17, #23
 bic x6, x4, x9
 add w17, w4, w17
 movz x13, #0x2d9
 movk x13, #0x676f, lsl #16
 add w8, w8, w23
 add w8, w8, w13
 and x13, x17, x9
 add w8, w8, w6
 add w8, w8, w13
 ror w8, w8, #18
 bic x6, x17, x4
 add w8, w17, w8
 movz x13, #0x4c8a
 movk x13, #0x8d2a, lsl #16
 add w9, w9, w11
 add w9, w9, w13
 and x13, x8, x4
 add w9, w9, w6
 add w9, w9, w13
 eor x6, x8, x17
 ror w9, w9, #12
 movz x10, #0x3942
 add w9, w8, w9
 movk x10, #0xfffa, lsl #16
 add w4, w4, w22
 eor x6, x6, x9
 add w4, w4, w10
 add w4, w4, w6
 ror w4, w4, #28
 eor x6, x9, x8
 movz x10, #0xf681
 add w4, w9, w4
 movk x10, #0x8771, lsl #16
 add w17, w17, w5
 eor x6, x6, x4
 add w17, w17, w10
 add w17, w17, w6
 eor x6, x4, x9
 ror w17, w17, #21
 movz x13, #0x6122
 add w17, w4, w17
 movk x13, #0x6d9d, lsl #16
 add w8, w8, w25
 eor x6, x6, x17
 add w8, w8, w13
 add w8, w8, w6
 ror w8, w8, #16
 eor x6, x17, x4
 movz x13, #0x380c
 add w8, w17, w8
 movk x13, #0xfde5, lsl #16
 add w9, w9, w12
 eor x6, x6, x8
 add w9, w9, w13
 add w9, w9, w6
 eor x6, x8, x17
 ror w9, w9, #9
 movz x10, #0xea44
 add w9, w8, w9
 movk x10, #0xa4be, lsl #16
 add w4, w4, w20
 eor x6, x6, x9
 add w4, w4, w10
 add w4, w4, w6
 ror w4, w4, #28
 eor x6, x9, x8
 movz x10, #0xcfa9
 add w4, w9, w4
 movk x10, #0x4bde, lsl #16
 add w17, w17, w14
 eor x6, x6, x4
 add w17, w17, w10
 add w17, w17, w6
 eor x6, x4, x9
 ror w17, w17, #21
 movz x13, #0x4b60
 add w17, w4, w17
 movk x13, #0xf6bb, lsl #16
 add w8, w8, w23
 eor x6, x6, x17
 add w8, w8, w13
 add w8, w8, w6
 ror w8, w8, #16
 eor x6, x17, x4
 movz x13, #0xbc70
 add w8, w17, w8
 movk x13, #0xbebf, lsl #16
 add w9, w9, w16
 eor x6, x6, x8
 add w9, w9, w13
 add w9, w9, w6
 eor x6, x8, x17
 ror w9, w9, #9
 movz x10, #0x7ec6
 add w9, w8, w9
 movk x10, #0x289b, lsl #16
 add w4, w4, w26
 eor x6, x6, x9
 add w4, w4, w10
 add w4, w4, w6
 ror w4, w4, #28
 eor x6, x9, x8
 movz x10, #0x27fa
 add w4, w9, w4
 movk x10, #0xeaa1, lsl #16
 add w17, w17, w15
 eor x6, x6, x4
 add w17, w17, w10
 add w17, w17, w6
 eor x6, x4, x9
 ror w17, w17, #21
 movz x13, #0x3085
 add w17, w4, w17
 movk x13, #0xd4ef, lsl #16
 add w8, w8, w21
 eor x6, x6, x17
 add w8, w8, w13
 add w8, w8, w6
 ror w8, w8, #16
 eor x6, x17, x4
 movz x13, #0x1d05
 add w8, w17, w8
 movk x13, #0x488, lsl #16
 add w9, w9, w7
 eor x6, x6, x8
 add w9, w9, w13
 add w9, w9, w6
 eor x6, x8, x17
 ror w9, w9, #9
 movz x10, #0xd039
 add w9, w8, w9
 movk x10, #0xd9d4, lsl #16
 add w4, w4, w24
 eor x6, x6, x9
 add w4, w4, w10
 add w4, w4, w6
 ror w4, w4, #28
 eor x6, x9, x8
 movz x10, #0x99e5
 add w4, w9, w4
 movk x10, #0xe6db, lsl #16
 add w17, w17, w11
 eor x6, x6, x4
 add w17, w17, w10
 add w17, w17, w6
 eor x6, x4, x9
 ror w17, w17, #21
 movz x13, #0x7cf8
 add w17, w4, w17
 movk x13, #0x1fa2, lsl #16
 add w8, w8, w27
 eor x6, x6, x17
 add w8, w8, w13
 add w8, w8, w6
 ror w8, w8, #16
 eor x6, x17, x4
 movz x13, #0x5665
 add w8, w17, w8
 movk x13, #0xc4ac, lsl #16
 add w9, w9, w3
 eor x6, x6, x8
 add w9, w9, w13
 add w9, w9, w6
 ror w9, w9, #9
 movz x6, #0x2244
 movk x6, #0xf429, lsl #16
 add w9, w8, w9
 add w4, w4, w15
 orn x13, x9, x17
 add w4, w4, w6
 eor x6, x8, x13
 add w4, w4, w6
 ror w4, w4, #26
 movz x6, #0xff97
 movk x6, #0x432a, lsl #16
 add w4, w9, w4
 orn x10, x4, x8
 add w17, w17, w23
 eor x10, x9, x10
 add w17, w17, w6
 add w6, w17, w10
 ror w6, w6, #22
 movz x17, #0x23a7
 movk x17, #0xab94, lsl #16
 add w6, w4, w6
 add w8, w8, w12
 orn x10, x6, x9
 add w8, w8, w17
 eor x17, x4, x10
 add w8, w8, w17
 ror w8, w8, #17
 movz x17, #0xa039
 movk x17, #0xfc93, lsl #16
 add w8, w6, w8
 orn x13, x8, x4
 add w9, w9, w22
 eor x13, x6, x13
 add w9, w9, w17
 add w17, w9, w13
 ror w17, w17, #11
 movz x9, #0x59c3
 movk x9, #0x655b, lsl #16
 add w17, w8, w17
 add w4, w4, w11
 orn x13, x17, x6
 add w9, w4, w9
 eor x4, x8, x13
 add w9, w9, w4
 ror w9, w9, #26
 movz x4, #0xcc92
 movk x4, #0x8f0c, lsl #16
 add w9, w17, w9
 orn x10, x9, x8
 add w6, w6, w21
 eor x10, x17, x10
 add w4, w6, w4
 add w6, w4, w10
 ror w6, w6, #22
 movz x4, #0xf47d
 movk x4, #0xffef, lsl #16
 add w6, w9, w6
 add w8, w8, w16
 orn x10, x6, x17
 add w8, w8, w4
 eor x4, x9, x10
 add w8, w8, w4
 ror w8, w8, #17
 movz x4, #0x5dd1
 movk x4, #0x8584, lsl #16
 add w8, w6, w8
 orn x10, x8, x9
 add w15, w17, w20
 eor x17, x6, x10
 add w15, w15, w4
 add w4, w15, w17
 ror w4, w4, #11
 movz x15, #0x7e4f
 movk x15, #0x6fa8, lsl #16
 add w17, w8, w4
 add w4, w9, w5
 orn x9, x17, x6
 add w15, w4, w15
 eor x4, x8, x9
 add w9, w15, w4
 ror w9, w9, #26
 movz x15, #0xe6e0
 movk x15, #0xfe2c, lsl #16
 add w4, w17, w9
 orn x9, x4, x8
 add w6, w6, w27
 eor x9, x17, x9
 add w15, w6, w15
 add w6, w15, w9
 ror w6, w6, #22
 movz x9, #0x4314
 movk x9, #0xa301, lsl #16
 add w15, w4, w6
 add w6, w8, w7
 orn x7, x15, x17
 add w8, w6, w9
 eor x9, x4, x7
 add w6, w8, w9
 ror w6, w6, #17
 movz x7, #0x11a1
 movk x7, #0x4e08, lsl #16
 add w8, w15, w6
 orn x9, x8, x4
 add w6, w17, w26
 eor x17, x15, x9
 add w9, w6, w7
 add w7, w9, w17
 ror w7, w7, #11
 movz x6, #0x7e82
 movk x6, #0xf753, lsl #16
 add w9, w8, w7
 add w17, w4, w14
 orn x7, x9, x15
 add w14, w17, w6
 eor x4, x8, x7
 add w17, w14, w4
 ror w17, w17, #26
 movz x6, #0xf235
 movk x6, #0xbd3a, lsl #16
 add w7, w9, w17
 orn x14, x7, x8
 add w4, w15, w25
 eor x17, x9, x14
 add w15, w4, w6
 add w16, w15, w17
 ror w16, w16, #22
 movz x14, #0xd2bb
 movk x14, #0x2ad7, lsl #16
 add w4, w7, w16
 add w6, w8, w3
 orn x15, x4, x9
 add w17, w6, w14
 eor x16, x7, x15
 add w8, w17, w16
 ror w8, w8, #17
 movz x3, #0xd391
 movk x3, #0xeb86, lsl #16
 add w14, w4, w8
 orn x6, x14, x7
 add w15, w9, w24
 eor x17, x4, x6
 add w16, w15, w3
 add w8, w16, w17
 ror w8, w8, #11
 ldp w6, w15, [x0]
 ldp w5, w9, [x0, #8]
 add w3, w14, w8
 add w13, w4, w9
 add w12, w14, w5
 add w10, w7, w6
 add w11, w3, w15
 stp w12, w13, [x0, #8]
 stp w10, w11, [x0]
 add x1, x1, #64
 subs w2, w2, #1
 b.ne ossl_md5_blocks_loop
 ldp x21,x22,[sp,#16]
 ldp x23,x24,[sp,#32]
 ldp x25,x26,[sp,#48]
 ldp x27,x28,[sp,#64]
 ldp x19,x20,[sp],#80
 ret
