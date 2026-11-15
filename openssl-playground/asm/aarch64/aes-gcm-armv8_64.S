.arch armv8-a+crypto
.text
.globl aes_gcm_enc_128_kernel
.type aes_gcm_enc_128_kernel,%function
.align 4
aes_gcm_enc_128_kernel:
 cbz x1, .L128_enc_ret
 stp x19, x20, [sp, #-112]!
 mov x16, x4
 mov x8, x5
 stp x21, x22, [sp, #16]
 stp x23, x24, [sp, #32]
 stp d8, d9, [sp, #48]
 stp d10, d11, [sp, #64]
 stp d12, d13, [sp, #80]
 stp d14, d15, [sp, #96]
 ldp x10, x11, [x16]
 ldp x13, x14, [x8, #160]
 ld1 {v11.16b}, [x3]
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 lsr x5, x1, #3
 mov x15, x5
 ld1 {v18.4s}, [x8], #16
 add x4, x0, x1, lsr #3
 sub x5, x5, #1
 lsr x12, x11, #32
 ldr q15, [x3, #112]
 ext v15.16b, v15.16b, v15.16b, #8
 fmov d1, x10
 rev w12, w12
 add w12, w12, #1
 orr w11, w11, w11
 ld1 {v19.4s}, [x8], #16
 rev w9, w12
 add w12, w12, #1
 fmov d3, x10
 orr x9, x11, x9, lsl #32
 ld1 { v0.16b}, [x16]
 fmov v1.d[1], x9
 rev w9, w12
 fmov d2, x10
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 fmov v2.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 ld1 {v20.4s}, [x8], #16
 add w12, w12, #1
 fmov v3.d[1], x9
 ldr q14, [x3, #80]
 ext v14.16b, v14.16b, v14.16b, #8
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ld1 {v21.4s}, [x8], #16
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ldr q12, [x3, #32]
 ext v12.16b, v12.16b, v12.16b, #8
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 ld1 {v22.4s}, [x8], #16
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 ld1 {v23.4s}, [x8], #16
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 trn2 v17.2d, v14.2d, v15.2d
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 ld1 {v24.4s}, [x8], #16
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 ld1 {v25.4s}, [x8], #16
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 trn1 v9.2d, v14.2d, v15.2d
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 ld1 {v26.4s}, [x8], #16
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 ldr q13, [x3, #64]
 ext v13.16b, v13.16b, v13.16b, #8
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 eor v17.16b, v17.16b, v9.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 ld1 {v27.4s}, [x8], #16
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 and x5, x5, #0xffffffffffffffc0
 trn2 v16.2d, v12.2d, v13.2d
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 add x5, x5, x0
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 cmp x0, x5
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 trn1 v8.2d, v12.2d, v13.2d
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aese v0.16b, v27.16b
 eor v16.16b, v16.16b, v8.16b
 aese v1.16b, v27.16b
 aese v3.16b, v27.16b
 b.ge .L128_enc_tail
 ldp x6, x7, [x0, #0]
 ldp x21, x22, [x0, #32]
 ldp x19, x20, [x0, #16]
 ldp x23, x24, [x0, #48]
 eor x6, x6, x13
 eor x7, x7, x14
 eor x21, x21, x13
 fmov d4, x6
 eor x19, x19, x13
 eor x22, x22, x14
 fmov v4.d[1], x7
 fmov d5, x19
 eor x20, x20, x14
 eor x23, x23, x13
 fmov v5.d[1], x20
 fmov d6, x21
 eor x24, x24, x14
 rev w9, w12
 fmov v6.d[1], x22
 orr x9, x11, x9, lsl #32
 eor v4.16b, v4.16b, v0.16b
 fmov d0, x10
 add w12, w12, #1
 fmov v0.d[1], x9
 rev w9, w12
 eor v5.16b, v5.16b, v1.16b
 fmov d1, x10
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 add x0, x0, #64
 fmov v1.d[1], x9
 fmov d7, x23
 rev w9, w12
 st1 { v4.16b}, [x2], #16
 fmov v7.d[1], x24
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 eor v6.16b, v6.16b, v2.16b
 st1 { v5.16b}, [x2], #16
 fmov d2, x10
 cmp x0, x5
 fmov v2.d[1], x9
 rev w9, w12
 st1 { v6.16b}, [x2], #16
 orr x9, x11, x9, lsl #32
 eor v7.16b, v7.16b, v3.16b
 st1 { v7.16b}, [x2], #16
 b.ge .L128_enc_prepretail
.L128_enc_main_loop:
 ldp x23, x24, [x0, #48]
 rev64 v4.16b, v4.16b
 rev64 v6.16b, v6.16b
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 fmov d3, x10
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v5.16b, v5.16b
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 add w12, w12, #1
 fmov v3.d[1], x9
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 mov d31, v6.d[1]
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 mov d30, v5.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 eor v4.16b, v4.16b, v11.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor x24, x24, x14
 pmull2 v28.1q, v5.2d, v14.2d
 eor v31.8b, v31.8b, v6.8b
 ldp x6, x7, [x0, #0]
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 rev w9, w12
 eor v30.8b, v30.8b, v5.8b
 mov d8, v4.d[1]
 orr x9, x11, x9, lsl #32
 pmull2 v9.1q, v4.2d, v15.2d
 add w12, w12, #1
 mov d10, v17.d[1]
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 pmull v11.1q, v4.1d, v15.1d
 eor v8.8b, v8.8b, v4.8b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor v9.16b, v9.16b, v28.16b
 pmull v28.1q, v6.1d, v13.1d
 pmull v10.1q, v8.1d, v10.1d
 rev64 v7.16b, v7.16b
 pmull v30.1q, v30.1d, v17.1d
 pmull v29.1q, v5.1d, v14.1d
 ins v31.d[1], v31.d[0]
 pmull2 v8.1q, v6.2d, v13.2d
 eor x7, x7, x14
 eor v10.16b, v10.16b, v30.16b
 mov d30, v7.d[1]
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 eor v11.16b, v11.16b, v29.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 eor x6, x6, x13
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 eor v30.8b, v30.8b, v7.8b
 pmull2 v4.1q, v7.2d, v12.2d
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v8.16b
 pmull2 v31.1q, v31.2d, v16.2d
 pmull v29.1q, v7.1d, v12.1d
 movi v8.8b, #0xc2
 pmull v30.1q, v30.1d, v16.1d
 eor v11.16b, v11.16b, v28.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 shl d8, d8, #56
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 eor v9.16b, v9.16b, v4.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 ldp x19, x20, [x0, #16]
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v31.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 ldp x21, x22, [x0, #32]
 pmull v31.1q, v9.1d, v8.1d
 eor v11.16b, v11.16b, v29.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 eor x19, x19, x13
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v30.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 eor x23, x23, x13
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 eor v30.16b, v11.16b, v9.16b
 fmov d4, x6
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 fmov v4.d[1], x7
 add x0, x0, #64
 fmov d7, x23
 ext v9.16b, v9.16b, v9.16b, #8
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 fmov d5, x19
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v30.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 eor x20, x20, x14
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 fmov v5.d[1], x20
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 fmov v7.d[1], x24
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 cmp x0, x5
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v31.16b
 aese v0.16b, v27.16b
 eor x21, x21, x13
 eor x22, x22, x14
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 fmov d6, x21
 aese v1.16b, v27.16b
 fmov v6.d[1], x22
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 eor v4.16b, v4.16b, v0.16b
 fmov d0, x10
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 fmov v0.d[1], x9
 rev w9, w12
 eor v10.16b, v10.16b, v9.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v5.16b, v5.16b, v1.16b
 add w12, w12, #1
 orr x9, x11, x9, lsl #32
 fmov d1, x10
 pmull v9.1q, v10.1d, v8.1d
 fmov v1.d[1], x9
 rev w9, w12
 aese v2.16b, v27.16b
 st1 { v4.16b}, [x2], #16
 eor v6.16b, v6.16b, v2.16b
 orr x9, x11, x9, lsl #32
 aese v3.16b, v27.16b
 add w12, w12, #1
 ext v10.16b, v10.16b, v10.16b, #8
 fmov d2, x10
 eor v11.16b, v11.16b, v9.16b
 st1 { v5.16b}, [x2], #16
 fmov v2.d[1], x9
 st1 { v6.16b}, [x2], #16
 rev w9, w12
 orr x9, x11, x9, lsl #32
 eor v7.16b, v7.16b, v3.16b
 eor v11.16b, v11.16b, v10.16b
 st1 { v7.16b}, [x2], #16
 b.lt .L128_enc_main_loop
.L128_enc_prepretail:
 rev64 v4.16b, v4.16b
 fmov d3, x10
 rev64 v5.16b, v5.16b
 ext v11.16b, v11.16b, v11.16b, #8
 add w12, w12, #1
 fmov v3.d[1], x9
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 rev64 v6.16b, v6.16b
 pmull v29.1q, v5.1d, v14.1d
 rev64 v7.16b, v7.16b
 eor v4.16b, v4.16b, v11.16b
 pmull2 v28.1q, v5.2d, v14.2d
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 mov d30, v5.d[1]
 pmull v11.1q, v4.1d, v15.1d
 mov d8, v4.d[1]
 mov d31, v6.d[1]
 mov d10, v17.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 eor v30.8b, v30.8b, v5.8b
 eor v8.8b, v8.8b, v4.8b
 pmull2 v9.1q, v4.2d, v15.2d
 eor v31.8b, v31.8b, v6.8b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 pmull v30.1q, v30.1d, v17.1d
 eor v11.16b, v11.16b, v29.16b
 pmull v10.1q, v8.1d, v10.1d
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 ins v31.d[1], v31.d[0]
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v30.16b
 mov d30, v7.d[1]
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 eor v9.16b, v9.16b, v28.16b
 pmull2 v31.1q, v31.2d, v16.2d
 pmull2 v8.1q, v6.2d, v13.2d
 eor v30.8b, v30.8b, v7.8b
 pmull2 v4.1q, v7.2d, v12.2d
 pmull v28.1q, v6.1d, v13.1d
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v8.16b
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 pmull v29.1q, v7.1d, v12.1d
 movi v8.8b, #0xc2
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 eor v11.16b, v11.16b, v28.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 pmull v30.1q, v30.1d, v16.1d
 eor v10.16b, v10.16b, v31.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 eor v9.16b, v9.16b, v4.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v30.16b
 shl d8, d8, #56
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 eor v11.16b, v11.16b, v29.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 pmull v28.1q, v9.1d, v8.1d
 eor v10.16b, v10.16b, v9.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v11.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v28.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v9.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 pmull v28.1q, v10.1d, v8.1d
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 ext v10.16b, v10.16b, v10.16b, #8
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v28.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aese v1.16b, v27.16b
 eor v11.16b, v11.16b, v10.16b
 aese v2.16b, v27.16b
.L128_enc_tail:
 sub x5, x4, x0
 ldp x6, x7, [x0], #16
 cmp x5, #48
 ext v8.16b, v11.16b, v11.16b, #8
 eor x6, x6, x13
 eor x7, x7, x14
 fmov d4, x6
 fmov v4.d[1], x7
 eor v5.16b, v4.16b, v0.16b
 b.gt .L128_enc_blocks_more_than_3
 sub w12, w12, #1
 movi v11.8b, #0
 mov v3.16b, v2.16b
 cmp x5, #32
 mov v2.16b, v1.16b
 movi v9.8b, #0
 movi v10.8b, #0
 b.gt .L128_enc_blocks_more_than_2
 mov v3.16b, v1.16b
 cmp x5, #16
 sub w12, w12, #1
 b.gt .L128_enc_blocks_more_than_1
 sub w12, w12, #1
 b .L128_enc_blocks_less_than_1
.L128_enc_blocks_more_than_3:
 st1 { v5.16b}, [x2], #16
 ldp x6, x7, [x0], #16
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 eor x7, x7, x14
 eor x6, x6, x13
 fmov d5, x6
 movi v8.8b, #0
 fmov v5.d[1], x7
 pmull v11.1q, v4.1d, v15.1d
 mov d22, v4.d[1]
 pmull2 v9.1q, v4.2d, v15.2d
 mov d10, v17.d[1]
 eor v5.16b, v5.16b, v1.16b
 eor v22.8b, v22.8b, v4.8b
 pmull v10.1q, v22.1d, v10.1d
.L128_enc_blocks_more_than_2:
 st1 { v5.16b}, [x2], #16
 rev64 v4.16b, v5.16b
 ldp x6, x7, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 eor x6, x6, x13
 fmov d5, x6
 eor x7, x7, x14
 pmull2 v20.1q, v4.2d, v14.2d
 fmov v5.d[1], x7
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v14.1d
 eor v9.16b, v9.16b, v20.16b
 eor v22.8b, v22.8b, v4.8b
 eor v5.16b, v5.16b, v2.16b
 eor v11.16b, v11.16b, v21.16b
 pmull v22.1q, v22.1d, v17.1d
 movi v8.8b, #0
 eor v10.16b, v10.16b, v22.16b
.L128_enc_blocks_more_than_1:
 st1 { v5.16b}, [x2], #16
 rev64 v4.16b, v5.16b
 ldp x6, x7, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 eor x7, x7, x14
 eor x6, x6, x13
 fmov d5, x6
 pmull2 v20.1q, v4.2d, v13.2d
 fmov v5.d[1], x7
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v13.1d
 eor v22.8b, v22.8b, v4.8b
 eor v5.16b, v5.16b, v3.16b
 ins v22.d[1], v22.d[0]
 pmull2 v22.1q, v22.2d, v16.2d
 eor v11.16b, v11.16b, v21.16b
 eor v9.16b, v9.16b, v20.16b
 eor v10.16b, v10.16b, v22.16b
 movi v8.8b, #0
.L128_enc_blocks_less_than_1:
 and x1, x1, #127
 mvn x13, xzr
 mvn x14, xzr
 sub x1, x1, #128
 neg x1, x1
 and x1, x1, #127
 lsr x14, x14, x1
 cmp x1, #64
 csel x6, x13, x14, lt
 csel x7, x14, xzr, lt
 fmov d0, x6
 fmov v0.d[1], x7
 and v5.16b, v5.16b, v0.16b
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 mov d8, v4.d[1]
 pmull v21.1q, v4.1d, v12.1d
 ld1 { v18.16b}, [x2]
 eor v8.8b, v8.8b, v4.8b
 rev w9, w12
 pmull2 v20.1q, v4.2d, v12.2d
 pmull v8.1q, v8.1d, v16.1d
 eor v11.16b, v11.16b, v21.16b
 eor v9.16b, v9.16b, v20.16b
 eor v10.16b, v10.16b, v8.16b
 movi v8.8b, #0xc2
 eor v30.16b, v11.16b, v9.16b
 shl d8, d8, #56
 eor v10.16b, v10.16b, v30.16b
 pmull v31.1q, v9.1d, v8.1d
 ext v9.16b, v9.16b, v9.16b, #8
 eor v10.16b, v10.16b, v31.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v9.1q, v10.1d, v8.1d
 ext v10.16b, v10.16b, v10.16b, #8
 bif v5.16b, v18.16b, v0.16b
 eor v11.16b, v11.16b, v9.16b
 st1 { v5.16b}, [x2]
 str w9, [x16, #12]
 eor v11.16b, v11.16b, v10.16b
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 mov x0, x15
 st1 { v11.16b }, [x3]
 ldp x21, x22, [sp, #16]
 ldp x23, x24, [sp, #32]
 ldp d8, d9, [sp, #48]
 ldp d10, d11, [sp, #64]
 ldp d12, d13, [sp, #80]
 ldp d14, d15, [sp, #96]
 ldp x19, x20, [sp], #112
 ret
.L128_enc_ret:
 mov w0, #0x0
 ret
.size aes_gcm_enc_128_kernel,.-aes_gcm_enc_128_kernel
.globl aes_gcm_dec_128_kernel
.type aes_gcm_dec_128_kernel,%function
.align 4
aes_gcm_dec_128_kernel:
 cbz x1, .L128_dec_ret
 stp x19, x20, [sp, #-112]!
 mov x16, x4
 mov x8, x5
 stp x21, x22, [sp, #16]
 stp x23, x24, [sp, #32]
 stp d8, d9, [sp, #48]
 stp d10, d11, [sp, #64]
 stp d12, d13, [sp, #80]
 stp d14, d15, [sp, #96]
 lsr x5, x1, #3
 mov x15, x5
 ldp x10, x11, [x16]
 ldp x13, x14, [x8, #160]
 sub x5, x5, #1
 ld1 {v18.4s}, [x8], #16
 and x5, x5, #0xffffffffffffffc0
 ld1 { v0.16b}, [x16]
 ldr q13, [x3, #64]
 ext v13.16b, v13.16b, v13.16b, #8
 lsr x12, x11, #32
 fmov d2, x10
 ld1 {v19.4s}, [x8], #16
 orr w11, w11, w11
 rev w12, w12
 fmov d1, x10
 add w12, w12, #1
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 rev w9, w12
 orr x9, x11, x9, lsl #32
 ld1 {v20.4s}, [x8], #16
 add w12, w12, #1
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 orr x9, x11, x9, lsl #32
 fmov v2.d[1], x9
 rev w9, w12
 fmov d3, x10
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 fmov v3.d[1], x9
 add x4, x0, x1, lsr #3
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ld1 {v21.4s}, [x8], #16
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 ld1 {v22.4s}, [x8], #16
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ld1 {v23.4s}, [x8], #16
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 ld1 {v24.4s}, [x8], #16
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 ld1 { v11.16b}, [x3]
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 ld1 {v25.4s}, [x8], #16
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 ld1 {v26.4s}, [x8], #16
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 ldr q14, [x3, #80]
 ext v14.16b, v14.16b, v14.16b, #8
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 ld1 {v27.4s}, [x8], #16
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 ldr q12, [x3, #32]
 ext v12.16b, v12.16b, v12.16b, #8
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 trn1 v8.2d, v12.2d, v13.2d
 ldr q15, [x3, #112]
 ext v15.16b, v15.16b, v15.16b, #8
 trn2 v16.2d, v12.2d, v13.2d
 add x5, x5, x0
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 eor v16.16b, v16.16b, v8.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 trn2 v17.2d, v14.2d, v15.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 trn1 v9.2d, v14.2d, v15.2d
 aese v2.16b, v27.16b
 aese v3.16b, v27.16b
 aese v0.16b, v27.16b
 cmp x0, x5
 aese v1.16b, v27.16b
 eor v17.16b, v17.16b, v9.16b
 b.ge .L128_dec_tail
 ld1 {v4.16b, v5.16b}, [x0], #32
 eor v1.16b, v5.16b, v1.16b
 ld1 {v6.16b}, [x0], #16
 eor v0.16b, v4.16b, v0.16b
 rev64 v4.16b, v4.16b
 rev w9, w12
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 ld1 {v7.16b}, [x0], #16
 rev64 v5.16b, v5.16b
 mov x19, v1.d[0]
 mov x20, v1.d[1]
 mov x6, v0.d[0]
 cmp x0, x5
 mov x7, v0.d[1]
 fmov d0, x10
 fmov v0.d[1], x9
 rev w9, w12
 eor x19, x19, x13
 fmov d1, x10
 add w12, w12, #1
 orr x9, x11, x9, lsl #32
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 orr x9, x11, x9, lsl #32
 eor x20, x20, x14
 eor x6, x6, x13
 eor v2.16b, v6.16b, v2.16b
 eor x7, x7, x14
 stp x6, x7, [x2], #16
 stp x19, x20, [x2], #16
 b.ge .L128_dec_prepretail
.L128_dec_main_loop:
 eor v3.16b, v7.16b, v3.16b
 ext v11.16b, v11.16b, v11.16b, #8
 mov x21, v2.d[0]
 pmull2 v28.1q, v5.2d, v14.2d
 mov x22, v2.d[1]
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 fmov d2, x10
 rev64 v6.16b, v6.16b
 fmov v2.d[1], x9
 rev w9, w12
 mov x23, v3.d[0]
 eor v4.16b, v4.16b, v11.16b
 mov d30, v5.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 rev64 v7.16b, v7.16b
 pmull v29.1q, v5.1d, v14.1d
 mov x24, v3.d[1]
 orr x9, x11, x9, lsl #32
 pmull v11.1q, v4.1d, v15.1d
 fmov d3, x10
 eor v30.8b, v30.8b, v5.8b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 fmov v3.d[1], x9
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 mov d10, v17.d[1]
 pmull2 v9.1q, v4.2d, v15.2d
 eor v11.16b, v11.16b, v29.16b
 pmull v29.1q, v7.1d, v12.1d
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 mov d8, v4.d[1]
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v28.16b
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 pmull v28.1q, v6.1d, v13.1d
 eor v8.8b, v8.8b, v4.8b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 eor x23, x23, x13
 pmull v30.1q, v30.1d, v17.1d
 eor x22, x22, x14
 mov d31, v6.d[1]
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v28.16b
 pmull v10.1q, v8.1d, v10.1d
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor v31.8b, v31.8b, v6.8b
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v30.16b
 pmull2 v8.1q, v6.2d, v13.2d
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 ins v31.d[1], v31.d[0]
 pmull2 v4.1q, v7.2d, v12.2d
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 mov d30, v7.d[1]
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 eor v9.16b, v9.16b, v8.16b
 pmull2 v31.1q, v31.2d, v16.2d
 eor x24, x24, x14
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 eor v30.8b, v30.8b, v7.8b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 eor x21, x21, x13
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 movi v8.8b, #0xc2
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 eor v11.16b, v11.16b, v29.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v31.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 stp x21, x22, [x2], #16
 pmull v30.1q, v30.1d, v16.1d
 eor v9.16b, v9.16b, v4.16b
 ld1 {v4.16b}, [x0], #16
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 add w12, w12, #1
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 shl d8, d8, #56
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v30.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 stp x23, x24, [x2], #16
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v30.16b, v11.16b, v9.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 rev w9, w12
 pmull v31.1q, v9.1d, v8.1d
 ld1 {v5.16b}, [x0], #16
 ext v9.16b, v9.16b, v9.16b, #8
 aese v0.16b, v27.16b
 orr x9, x11, x9, lsl #32
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v30.16b
 aese v1.16b, v27.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 eor v0.16b, v4.16b, v0.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 ld1 {v6.16b}, [x0], #16
 add w12, w12, #1
 eor v10.16b, v10.16b, v31.16b
 eor v1.16b, v5.16b, v1.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 ld1 {v7.16b}, [x0], #16
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 rev64 v5.16b, v5.16b
 eor v10.16b, v10.16b, v9.16b
 mov x7, v0.d[1]
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 mov x6, v0.d[0]
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 fmov d0, x10
 pmull v8.1q, v10.1d, v8.1d
 fmov v0.d[1], x9
 rev w9, w12
 aese v2.16b, v27.16b
 orr x9, x11, x9, lsl #32
 ext v10.16b, v10.16b, v10.16b, #8
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 eor x7, x7, x14
 eor v11.16b, v11.16b, v8.16b
 mov x20, v1.d[1]
 eor x6, x6, x13
 eor v2.16b, v6.16b, v2.16b
 mov x19, v1.d[0]
 add w12, w12, #1
 aese v3.16b, v27.16b
 fmov d1, x10
 cmp x0, x5
 rev64 v4.16b, v4.16b
 eor v11.16b, v11.16b, v10.16b
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 eor x20, x20, x14
 stp x6, x7, [x2], #16
 eor x19, x19, x13
 stp x19, x20, [x2], #16
 orr x9, x11, x9, lsl #32
 b.lt .L128_dec_main_loop
.L128_dec_prepretail:
 ext v11.16b, v11.16b, v11.16b, #8
 mov x21, v2.d[0]
 mov d30, v5.d[1]
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 eor v3.16b, v7.16b, v3.16b
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 mov x22, v2.d[1]
 eor v4.16b, v4.16b, v11.16b
 fmov d2, x10
 rev64 v6.16b, v6.16b
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 fmov v2.d[1], x9
 rev w9, w12
 mov x23, v3.d[0]
 eor v30.8b, v30.8b, v5.8b
 pmull v11.1q, v4.1d, v15.1d
 mov d10, v17.d[1]
 mov x24, v3.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 mov d31, v6.d[1]
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 orr x9, x11, x9, lsl #32
 pmull v29.1q, v5.1d, v14.1d
 mov d8, v4.d[1]
 fmov d3, x10
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 fmov v3.d[1], x9
 pmull v30.1q, v30.1d, v17.1d
 eor v31.8b, v31.8b, v6.8b
 rev64 v7.16b, v7.16b
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 eor v8.8b, v8.8b, v4.8b
 pmull2 v9.1q, v4.2d, v15.2d
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 ins v31.d[1], v31.d[0]
 pmull2 v28.1q, v5.2d, v14.2d
 pmull v10.1q, v8.1d, v10.1d
 eor v11.16b, v11.16b, v29.16b
 pmull v29.1q, v7.1d, v12.1d
 pmull2 v31.1q, v31.2d, v16.2d
 eor v9.16b, v9.16b, v28.16b
 eor v10.16b, v10.16b, v30.16b
 pmull2 v4.1q, v7.2d, v12.2d
 pmull2 v8.1q, v6.2d, v13.2d
 mov d30, v7.d[1]
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v31.16b
 pmull v28.1q, v6.1d, v13.1d
 eor v9.16b, v9.16b, v8.16b
 movi v8.8b, #0xc2
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 eor v30.8b, v30.8b, v7.8b
 eor v11.16b, v11.16b, v28.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v4.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor x23, x23, x13
 pmull v30.1q, v30.1d, v16.1d
 eor x21, x21, x13
 eor v11.16b, v11.16b, v29.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 shl d8, d8, #56
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v30.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v30.16b, v11.16b, v9.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v30.16b
 pmull v31.1q, v9.1d, v8.1d
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v31.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v9.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 pmull v8.1q, v10.1d, v8.1d
 eor x24, x24, x14
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 ext v10.16b, v10.16b, v10.16b, #8
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v8.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 eor x22, x22, x14
 aese v0.16b, v27.16b
 stp x21, x22, [x2], #16
 aese v2.16b, v27.16b
 add w12, w12, #1
 stp x23, x24, [x2], #16
 aese v3.16b, v27.16b
 eor v11.16b, v11.16b, v10.16b
.L128_dec_tail:
 sub x5, x4, x0
 ld1 { v5.16b}, [x0], #16
 eor v0.16b, v5.16b, v0.16b
 mov x7, v0.d[1]
 mov x6, v0.d[0]
 cmp x5, #48
 eor x7, x7, x14
 ext v8.16b, v11.16b, v11.16b, #8
 eor x6, x6, x13
 b.gt .L128_dec_blocks_more_than_3
 mov v3.16b, v2.16b
 sub w12, w12, #1
 movi v11.8b, #0
 movi v9.8b, #0
 mov v2.16b, v1.16b
 movi v10.8b, #0
 cmp x5, #32
 b.gt .L128_dec_blocks_more_than_2
 cmp x5, #16
 mov v3.16b, v1.16b
 sub w12, w12, #1
 b.gt .L128_dec_blocks_more_than_1
 sub w12, w12, #1
 b .L128_dec_blocks_less_than_1
.L128_dec_blocks_more_than_3:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 mov d10, v17.d[1]
 stp x6, x7, [x2], #16
 eor v0.16b, v5.16b, v1.16b
 mov d22, v4.d[1]
 mov x7, v0.d[1]
 pmull v11.1q, v4.1d, v15.1d
 mov x6, v0.d[0]
 pmull2 v9.1q, v4.2d, v15.2d
 eor v22.8b, v22.8b, v4.8b
 movi v8.8b, #0
 eor x7, x7, x14
 pmull v10.1q, v22.1d, v10.1d
 eor x6, x6, x13
.L128_dec_blocks_more_than_2:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 eor v0.16b, v5.16b, v2.16b
 stp x6, x7, [x2], #16
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v14.1d
 pmull2 v20.1q, v4.2d, v14.2d
 mov x6, v0.d[0]
 mov x7, v0.d[1]
 eor v22.8b, v22.8b, v4.8b
 movi v8.8b, #0
 pmull v22.1q, v22.1d, v17.1d
 eor x6, x6, x13
 eor v11.16b, v11.16b, v21.16b
 eor v9.16b, v9.16b, v20.16b
 eor v10.16b, v10.16b, v22.16b
 eor x7, x7, x14
.L128_dec_blocks_more_than_1:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 mov d22, v4.d[1]
 eor v0.16b, v5.16b, v3.16b
 eor v22.8b, v22.8b, v4.8b
 stp x6, x7, [x2], #16
 mov x6, v0.d[0]
 mov x7, v0.d[1]
 ins v22.d[1], v22.d[0]
 pmull v21.1q, v4.1d, v13.1d
 pmull2 v20.1q, v4.2d, v13.2d
 pmull2 v22.1q, v22.2d, v16.2d
 movi v8.8b, #0
 eor v11.16b, v11.16b, v21.16b
 eor v9.16b, v9.16b, v20.16b
 eor x7, x7, x14
 eor x6, x6, x13
 eor v10.16b, v10.16b, v22.16b
.L128_dec_blocks_less_than_1:
 mvn x14, xzr
 and x1, x1, #127
 mvn x13, xzr
 sub x1, x1, #128
 neg x1, x1
 and x1, x1, #127
 lsr x14, x14, x1
 cmp x1, #64
 csel x10, x14, xzr, lt
 csel x9, x13, x14, lt
 fmov d0, x9
 mov v0.d[1], x10
 and v5.16b, v5.16b, v0.16b
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 ldp x4, x5, [x2]
 and x7, x7, x10
 pmull2 v20.1q, v4.2d, v12.2d
 mov d8, v4.d[1]
 eor v8.8b, v8.8b, v4.8b
 eor v9.16b, v9.16b, v20.16b
 pmull v8.1q, v8.1d, v16.1d
 pmull v21.1q, v4.1d, v12.1d
 bic x4, x4, x9
 and x6, x6, x9
 rev w9, w12
 eor v10.16b, v10.16b, v8.16b
 movi v8.8b, #0xc2
 eor v11.16b, v11.16b, v21.16b
 bic x5, x5, x10
 shl d8, d8, #56
 eor v30.16b, v11.16b, v9.16b
 pmull v31.1q, v9.1d, v8.1d
 eor v10.16b, v10.16b, v30.16b
 orr x6, x6, x4
 str w9, [x16, #12]
 orr x7, x7, x5
 stp x6, x7, [x2]
 ext v9.16b, v9.16b, v9.16b, #8
 eor v10.16b, v10.16b, v31.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v8.1q, v10.1d, v8.1d
 ext v10.16b, v10.16b, v10.16b, #8
 eor v11.16b, v11.16b, v8.16b
 eor v11.16b, v11.16b, v10.16b
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 mov x0, x15
 st1 { v11.16b }, [x3]
 ldp x21, x22, [sp, #16]
 ldp x23, x24, [sp, #32]
 ldp d8, d9, [sp, #48]
 ldp d10, d11, [sp, #64]
 ldp d12, d13, [sp, #80]
 ldp d14, d15, [sp, #96]
 ldp x19, x20, [sp], #112
 ret
.L128_dec_ret:
 mov w0, #0x0
 ret
.size aes_gcm_dec_128_kernel,.-aes_gcm_dec_128_kernel
.globl aes_gcm_enc_192_kernel
.type aes_gcm_enc_192_kernel,%function
.align 4
aes_gcm_enc_192_kernel:
 cbz x1, .L192_enc_ret
 stp x19, x20, [sp, #-112]!
 mov x16, x4
 mov x8, x5
 stp x21, x22, [sp, #16]
 stp x23, x24, [sp, #32]
 stp d8, d9, [sp, #48]
 stp d10, d11, [sp, #64]
 stp d12, d13, [sp, #80]
 stp d14, d15, [sp, #96]
 ldp x10, x11, [x16]
 ldp x13, x14, [x8, #192]
 ld1 {v18.4s}, [x8], #16
 ld1 {v19.4s}, [x8], #16
 ld1 {v20.4s}, [x8], #16
 lsr x12, x11, #32
 ld1 {v21.4s}, [x8], #16
 orr w11, w11, w11
 ld1 {v22.4s}, [x8], #16
 rev w12, w12
 add w12, w12, #1
 fmov d3, x10
 rev w9, w12
 add w12, w12, #1
 fmov d1, x10
 orr x9, x11, x9, lsl #32
 ld1 { v0.16b}, [x16]
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 fmov d2, x10
 orr x9, x11, x9, lsl #32
 fmov v2.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 ld1 {v23.4s}, [x8], #16
 fmov v3.d[1], x9
 ld1 {v24.4s}, [x8], #16
 ld1 {v25.4s}, [x8], #16
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 ld1 { v11.16b}, [x3]
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 ld1 {v26.4s}, [x8], #16
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ldr q15, [x3, #112]
 ext v15.16b, v15.16b, v15.16b, #8
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ld1 {v27.4s}, [x8], #16
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 ld1 {v28.4s}, [x8], #16
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 ldr q12, [x3, #32]
 ext v12.16b, v12.16b, v12.16b, #8
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 ld1 {v29.4s}, [x8], #16
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 ldr q14, [x3, #80]
 ext v14.16b, v14.16b, v14.16b, #8
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 trn1 v9.2d, v14.2d, v15.2d
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 trn2 v17.2d, v14.2d, v15.2d
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 ldr q13, [x3, #64]
 ext v13.16b, v13.16b, v13.16b, #8
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 trn2 v16.2d, v12.2d, v13.2d
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 trn1 v8.2d, v12.2d, v13.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 lsr x5, x1, #3
 mov x15, x5
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 sub x5, x5, #1
 eor v16.16b, v16.16b, v8.16b
 and x5, x5, #0xffffffffffffffc0
 eor v17.16b, v17.16b, v9.16b
 aese v2.16b, v29.16b
 add x4, x0, x1, lsr #3
 add x5, x5, x0
 aese v1.16b, v29.16b
 cmp x0, x5
 aese v0.16b, v29.16b
 add w12, w12, #1
 aese v3.16b, v29.16b
 b.ge .L192_enc_tail
 rev w9, w12
 ldp x6, x7, [x0, #0]
 orr x9, x11, x9, lsl #32
 ldp x21, x22, [x0, #32]
 ldp x23, x24, [x0, #48]
 ldp x19, x20, [x0, #16]
 add x0, x0, #64
 cmp x0, x5
 eor x6, x6, x13
 eor x7, x7, x14
 eor x22, x22, x14
 fmov d4, x6
 eor x24, x24, x14
 fmov v4.d[1], x7
 eor x21, x21, x13
 eor x19, x19, x13
 fmov d5, x19
 eor x20, x20, x14
 fmov v5.d[1], x20
 eor x23, x23, x13
 fmov d6, x21
 add w12, w12, #1
 eor v4.16b, v4.16b, v0.16b
 fmov d0, x10
 fmov v0.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 fmov d7, x23
 st1 { v4.16b}, [x2], #16
 fmov v6.d[1], x22
 eor v5.16b, v5.16b, v1.16b
 fmov d1, x10
 st1 { v5.16b}, [x2], #16
 fmov v7.d[1], x24
 fmov v1.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 eor v6.16b, v6.16b, v2.16b
 fmov d2, x10
 fmov v2.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 st1 { v6.16b}, [x2], #16
 eor v7.16b, v7.16b, v3.16b
 st1 { v7.16b}, [x2], #16
 b.ge .L192_enc_prepretail
.L192_enc_main_loop:
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 rev64 v5.16b, v5.16b
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ldp x19, x20, [x0, #16]
 ext v11.16b, v11.16b, v11.16b, #8
 fmov d3, x10
 rev64 v4.16b, v4.16b
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 fmov v3.d[1], x9
 pmull2 v30.1q, v5.2d, v14.2d
 rev64 v7.16b, v7.16b
 ldp x21, x22, [x0, #32]
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 ldp x23, x24, [x0, #48]
 pmull v31.1q, v5.1d, v14.1d
 eor v4.16b, v4.16b, v11.16b
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 rev64 v6.16b, v6.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor x24, x24, x14
 pmull v11.1q, v4.1d, v15.1d
 mov d8, v4.d[1]
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 eor x21, x21, x13
 eor v8.8b, v8.8b, v4.8b
 eor v11.16b, v11.16b, v31.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor x19, x19, x13
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 mov d31, v6.d[1]
 pmull2 v9.1q, v4.2d, v15.2d
 mov d4, v5.d[1]
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 mov d10, v17.d[1]
 eor v9.16b, v9.16b, v30.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor v31.8b, v31.8b, v6.8b
 pmull2 v30.1q, v6.2d, v13.2d
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 eor v4.8b, v4.8b, v5.8b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 pmull2 v5.1q, v7.2d, v12.2d
 eor x20, x20, x14
 ins v31.d[1], v31.d[0]
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 add w12, w12, #1
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v30.16b
 pmull v4.1q, v4.1d, v17.1d
 eor x22, x22, x14
 pmull2 v31.1q, v31.2d, v16.2d
 eor x23, x23, x13
 mov d30, v7.d[1]
 pmull v10.1q, v8.1d, v10.1d
 rev w9, w12
 pmull v8.1q, v6.1d, v13.1d
 orr x9, x11, x9, lsl #32
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 eor v30.8b, v30.8b, v7.8b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 ldp x6, x7, [x0, #0]
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v8.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 add x0, x0, #64
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 movi v8.8b, #0xc2
 pmull v6.1q, v7.1d, v12.1d
 eor x7, x7, x14
 eor v10.16b, v10.16b, v4.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 eor x6, x6, x13
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 shl d8, d8, #56
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v5.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 fmov d5, x19
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v31.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 fmov v5.d[1], x20
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v6.16b
 pmull v30.1q, v30.1d, v16.1d
 cmp x0, x5
 fmov d4, x6
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 fmov v4.d[1], x7
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 fmov d7, x23
 eor v10.16b, v10.16b, v30.16b
 eor v30.16b, v11.16b, v9.16b
 add w12, w12, #1
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 fmov v7.d[1], x24
 pmull v31.1q, v9.1d, v8.1d
 ext v9.16b, v9.16b, v9.16b, #8
 fmov d6, x21
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v30.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v31.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v29.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v9.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 eor v4.16b, v4.16b, v0.16b
 fmov d0, x10
 aese v1.16b, v29.16b
 fmov v0.d[1], x9
 rev w9, w12
 pmull v9.1q, v10.1d, v8.1d
 fmov v6.d[1], x22
 st1 { v4.16b}, [x2], #16
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 orr x9, x11, x9, lsl #32
 eor v5.16b, v5.16b, v1.16b
 add w12, w12, #1
 fmov d1, x10
 aese v2.16b, v29.16b
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 ext v10.16b, v10.16b, v10.16b, #8
 orr x9, x11, x9, lsl #32
 st1 { v5.16b}, [x2], #16
 eor v11.16b, v11.16b, v9.16b
 aese v3.16b, v29.16b
 eor v6.16b, v6.16b, v2.16b
 fmov d2, x10
 st1 { v6.16b}, [x2], #16
 fmov v2.d[1], x9
 rev w9, w12
 eor v11.16b, v11.16b, v10.16b
 orr x9, x11, x9, lsl #32
 eor v7.16b, v7.16b, v3.16b
 st1 { v7.16b}, [x2], #16
 b.lt .L192_enc_main_loop
.L192_enc_prepretail:
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 rev64 v4.16b, v4.16b
 fmov d3, x10
 ext v11.16b, v11.16b, v11.16b, #8
 add w12, w12, #1
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 rev64 v5.16b, v5.16b
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 fmov v3.d[1], x9
 eor v4.16b, v4.16b, v11.16b
 mov d10, v17.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 rev64 v6.16b, v6.16b
 pmull2 v30.1q, v5.2d, v14.2d
 pmull v11.1q, v4.1d, v15.1d
 mov d8, v4.d[1]
 pmull v31.1q, v5.1d, v14.1d
 rev64 v7.16b, v7.16b
 pmull2 v9.1q, v4.2d, v15.2d
 eor v8.8b, v8.8b, v4.8b
 mov d4, v5.d[1]
 eor v11.16b, v11.16b, v31.16b
 mov d31, v6.d[1]
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v30.16b
 pmull2 v30.1q, v6.2d, v13.2d
 eor v4.8b, v4.8b, v5.8b
 eor v31.8b, v31.8b, v6.8b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v30.16b
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 mov d30, v7.d[1]
 pmull2 v5.1q, v7.2d, v12.2d
 ins v31.d[1], v31.d[0]
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 pmull v10.1q, v8.1d, v10.1d
 eor v30.8b, v30.8b, v7.8b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 pmull2 v31.1q, v31.2d, v16.2d
 pmull v4.1q, v4.1d, v17.1d
 pmull v30.1q, v30.1d, v16.1d
 eor v9.16b, v9.16b, v5.16b
 pmull v8.1q, v6.1d, v13.1d
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v4.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 eor v11.16b, v11.16b, v8.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v31.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 pmull v6.1q, v7.1d, v12.1d
 movi v8.8b, #0xc2
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v30.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 eor v11.16b, v11.16b, v6.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v9.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 shl d8, d8, #56
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v11.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 pmull v30.1q, v9.1d, v8.1d
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v30.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v9.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 pmull v30.1q, v10.1d, v8.1d
 ext v10.16b, v10.16b, v10.16b, #8
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 eor v11.16b, v11.16b, v30.16b
 aese v0.16b, v29.16b
 aese v3.16b, v29.16b
 aese v2.16b, v29.16b
 aese v1.16b, v29.16b
 eor v11.16b, v11.16b, v10.16b
.L192_enc_tail:
 sub x5, x4, x0
 ldp x6, x7, [x0], #16
 eor x6, x6, x13
 eor x7, x7, x14
 fmov d4, x6
 fmov v4.d[1], x7
 cmp x5, #48
 eor v5.16b, v4.16b, v0.16b
 ext v8.16b, v11.16b, v11.16b, #8
 b.gt .L192_enc_blocks_more_than_3
 sub w12, w12, #1
 movi v10.8b, #0
 mov v3.16b, v2.16b
 movi v9.8b, #0
 cmp x5, #32
 mov v2.16b, v1.16b
 movi v11.8b, #0
 b.gt .L192_enc_blocks_more_than_2
 sub w12, w12, #1
 mov v3.16b, v1.16b
 cmp x5, #16
 b.gt .L192_enc_blocks_more_than_1
 sub w12, w12, #1
 b .L192_enc_blocks_less_than_1
.L192_enc_blocks_more_than_3:
 st1 { v5.16b}, [x2], #16
 ldp x6, x7, [x0], #16
 rev64 v4.16b, v5.16b
 eor x6, x6, x13
 eor v4.16b, v4.16b, v8.16b
 eor x7, x7, x14
 fmov d5, x6
 fmov v5.d[1], x7
 mov d22, v4.d[1]
 pmull v11.1q, v4.1d, v15.1d
 mov d10, v17.d[1]
 eor v22.8b, v22.8b, v4.8b
 movi v8.8b, #0
 pmull2 v9.1q, v4.2d, v15.2d
 pmull v10.1q, v22.1d, v10.1d
 eor v5.16b, v5.16b, v1.16b
.L192_enc_blocks_more_than_2:
 st1 { v5.16b}, [x2], #16
 rev64 v4.16b, v5.16b
 ldp x6, x7, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 eor x7, x7, x14
 pmull2 v20.1q, v4.2d, v14.2d
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v14.1d
 eor x6, x6, x13
 fmov d5, x6
 fmov v5.d[1], x7
 eor v9.16b, v9.16b, v20.16b
 eor v22.8b, v22.8b, v4.8b
 eor v11.16b, v11.16b, v21.16b
 pmull v22.1q, v22.1d, v17.1d
 movi v8.8b, #0
 eor v5.16b, v5.16b, v2.16b
 eor v10.16b, v10.16b, v22.16b
.L192_enc_blocks_more_than_1:
 st1 { v5.16b}, [x2], #16
 ldp x6, x7, [x0], #16
 rev64 v4.16b, v5.16b
 eor x6, x6, x13
 eor v4.16b, v4.16b, v8.16b
 movi v8.8b, #0
 mov d22, v4.d[1]
 eor v22.8b, v22.8b, v4.8b
 eor x7, x7, x14
 fmov d5, x6
 pmull2 v20.1q, v4.2d, v13.2d
 fmov v5.d[1], x7
 ins v22.d[1], v22.d[0]
 eor v9.16b, v9.16b, v20.16b
 pmull v21.1q, v4.1d, v13.1d
 pmull2 v22.1q, v22.2d, v16.2d
 eor v5.16b, v5.16b, v3.16b
 eor v11.16b, v11.16b, v21.16b
 eor v10.16b, v10.16b, v22.16b
.L192_enc_blocks_less_than_1:
 ld1 { v18.16b}, [x2]
 rev w9, w12
 and x1, x1, #127
 sub x1, x1, #128
 mvn x14, xzr
 neg x1, x1
 mvn x13, xzr
 and x1, x1, #127
 lsr x14, x14, x1
 cmp x1, #64
 csel x6, x13, x14, lt
 csel x7, x14, xzr, lt
 fmov d0, x6
 fmov v0.d[1], x7
 and v5.16b, v5.16b, v0.16b
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 mov d8, v4.d[1]
 pmull v21.1q, v4.1d, v12.1d
 pmull2 v20.1q, v4.2d, v12.2d
 eor v8.8b, v8.8b, v4.8b
 eor v11.16b, v11.16b, v21.16b
 eor v9.16b, v9.16b, v20.16b
 pmull v8.1q, v8.1d, v16.1d
 eor v10.16b, v10.16b, v8.16b
 movi v8.8b, #0xc2
 eor v30.16b, v11.16b, v9.16b
 shl d8, d8, #56
 bif v5.16b, v18.16b, v0.16b
 eor v10.16b, v10.16b, v30.16b
 pmull v31.1q, v9.1d, v8.1d
 ext v9.16b, v9.16b, v9.16b, #8
 eor v10.16b, v10.16b, v31.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v9.1q, v10.1d, v8.1d
 ext v10.16b, v10.16b, v10.16b, #8
 eor v11.16b, v11.16b, v9.16b
 str w9, [x16, #12]
 st1 { v5.16b}, [x2]
 eor v11.16b, v11.16b, v10.16b
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 mov x0, x15
 st1 { v11.16b }, [x3]
 ldp x21, x22, [sp, #16]
 ldp x23, x24, [sp, #32]
 ldp d8, d9, [sp, #48]
 ldp d10, d11, [sp, #64]
 ldp d12, d13, [sp, #80]
 ldp d14, d15, [sp, #96]
 ldp x19, x20, [sp], #112
 ret
.L192_enc_ret:
 mov w0, #0x0
 ret
.size aes_gcm_enc_192_kernel,.-aes_gcm_enc_192_kernel
.globl aes_gcm_dec_192_kernel
.type aes_gcm_dec_192_kernel,%function
.align 4
aes_gcm_dec_192_kernel:
 cbz x1, .L192_dec_ret
 stp x19, x20, [sp, #-112]!
 mov x16, x4
 mov x8, x5
 stp x21, x22, [sp, #16]
 stp x23, x24, [sp, #32]
 stp d8, d9, [sp, #48]
 stp d10, d11, [sp, #64]
 stp d12, d13, [sp, #80]
 stp d14, d15, [sp, #96]
 add x4, x0, x1, lsr #3
 ldp x10, x11, [x16]
 ldp x13, x14, [x8, #192]
 ld1 { v0.16b}, [x16]
 ld1 {v18.4s}, [x8], #16
 lsr x5, x1, #3
 mov x15, x5
 ld1 {v19.4s}, [x8], #16
 lsr x12, x11, #32
 orr w11, w11, w11
 fmov d3, x10
 rev w12, w12
 fmov d1, x10
 add w12, w12, #1
 ld1 {v20.4s}, [x8], #16
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 rev w9, w12
 add w12, w12, #1
 orr x9, x11, x9, lsl #32
 ld1 {v21.4s}, [x8], #16
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 fmov d2, x10
 orr x9, x11, x9, lsl #32
 fmov v2.d[1], x9
 rev w9, w12
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 orr x9, x11, x9, lsl #32
 fmov v3.d[1], x9
 ld1 {v22.4s}, [x8], #16
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ld1 {v23.4s}, [x8], #16
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ldr q15, [x3, #112]
 ext v15.16b, v15.16b, v15.16b, #8
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 ldr q13, [x3, #64]
 ext v13.16b, v13.16b, v13.16b, #8
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 ldr q14, [x3, #80]
 ext v14.16b, v14.16b, v14.16b, #8
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 ldr q12, [x3, #32]
 ext v12.16b, v12.16b, v12.16b, #8
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 ld1 {v24.4s}, [x8], #16
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 ld1 {v25.4s}, [x8], #16
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 ld1 {v26.4s}, [x8], #16
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 ld1 {v27.4s}, [x8], #16
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 ld1 { v11.16b}, [x3]
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 add w12, w12, #1
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 trn1 v9.2d, v14.2d, v15.2d
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 ld1 {v28.4s}, [x8], #16
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 trn2 v17.2d, v14.2d, v15.2d
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 trn2 v16.2d, v12.2d, v13.2d
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 ld1 {v29.4s}, [x8], #16
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 sub x5, x5, #1
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 and x5, x5, #0xffffffffffffffc0
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 add x5, x5, x0
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 cmp x0, x5
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 trn1 v8.2d, v12.2d, v13.2d
 aese v3.16b, v29.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 eor v16.16b, v16.16b, v8.16b
 aese v2.16b, v29.16b
 aese v1.16b, v29.16b
 eor v17.16b, v17.16b, v9.16b
 aese v0.16b, v29.16b
 b.ge .L192_dec_tail
 ld1 {v4.16b, v5.16b}, [x0], #32
 eor v1.16b, v5.16b, v1.16b
 eor v0.16b, v4.16b, v0.16b
 rev w9, w12
 ld1 {v6.16b, v7.16b}, [x0], #32
 mov x19, v1.d[0]
 mov x20, v1.d[1]
 mov x6, v0.d[0]
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 mov x7, v0.d[1]
 rev64 v4.16b, v4.16b
 fmov d0, x10
 rev64 v5.16b, v5.16b
 cmp x0, x5
 eor x19, x19, x13
 fmov v0.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 fmov d1, x10
 eor x20, x20, x14
 add w12, w12, #1
 fmov v1.d[1], x9
 eor x6, x6, x13
 rev w9, w12
 eor x7, x7, x14
 stp x6, x7, [x2], #16
 orr x9, x11, x9, lsl #32
 stp x19, x20, [x2], #16
 add w12, w12, #1
 eor v2.16b, v6.16b, v2.16b
 b.ge .L192_dec_prepretail
.L192_dec_main_loop:
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ext v11.16b, v11.16b, v11.16b, #8
 pmull v31.1q, v5.1d, v14.1d
 mov x21, v2.d[0]
 mov x22, v2.d[1]
 eor v3.16b, v7.16b, v3.16b
 rev64 v7.16b, v7.16b
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 fmov d2, x10
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 eor v4.16b, v4.16b, v11.16b
 pmull2 v30.1q, v5.2d, v14.2d
 fmov v2.d[1], x9
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 mov x24, v3.d[1]
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 mov x23, v3.d[0]
 pmull2 v9.1q, v4.2d, v15.2d
 fmov d3, x10
 mov d8, v4.d[1]
 pmull v11.1q, v4.1d, v15.1d
 mov d10, v17.d[1]
 rev w9, w12
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 orr x9, x11, x9, lsl #32
 fmov v3.d[1], x9
 eor v8.8b, v8.8b, v4.8b
 mov d4, v5.d[1]
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 eor x22, x22, x14
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 eor v4.8b, v4.8b, v5.8b
 pmull v10.1q, v8.1d, v10.1d
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 rev64 v6.16b, v6.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 pmull v4.1q, v4.1d, v17.1d
 eor v11.16b, v11.16b, v31.16b
 eor x21, x21, x13
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v4.16b
 mov d31, v6.d[1]
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v30.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 pmull2 v30.1q, v6.2d, v13.2d
 eor v31.8b, v31.8b, v6.8b
 pmull v8.1q, v6.1d, v13.1d
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 eor v9.16b, v9.16b, v30.16b
 mov d30, v7.d[1]
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 pmull2 v5.1q, v7.2d, v12.2d
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor v30.8b, v30.8b, v7.8b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 ins v31.d[1], v31.d[0]
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 pmull v30.1q, v30.1d, v16.1d
 eor v11.16b, v11.16b, v8.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 pmull2 v31.1q, v31.2d, v16.2d
 eor v9.16b, v9.16b, v5.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 movi v8.8b, #0xc2
 pmull v6.1q, v7.1d, v12.1d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v31.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v6.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v30.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 eor v30.16b, v11.16b, v9.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 shl d8, d8, #56
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 ld1 {v4.16b}, [x0], #16
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v30.16b
 pmull v31.1q, v9.1d, v8.1d
 ld1 {v5.16b}, [x0], #16
 eor x23, x23, x13
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v0.16b, v29.16b
 add w12, w12, #1
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v31.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ld1 {v6.16b}, [x0], #16
 aese v1.16b, v29.16b
 ld1 {v7.16b}, [x0], #16
 rev w9, w12
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 stp x21, x22, [x2], #16
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v9.16b
 cmp x0, x5
 eor v0.16b, v4.16b, v0.16b
 eor x24, x24, x14
 eor v1.16b, v5.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 orr x9, x11, x9, lsl #32
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v8.1q, v10.1d, v8.1d
 mov x19, v1.d[0]
 mov x6, v0.d[0]
 stp x23, x24, [x2], #16
 rev64 v5.16b, v5.16b
 aese v2.16b, v29.16b
 mov x7, v0.d[1]
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 mov x20, v1.d[1]
 fmov d0, x10
 add w12, w12, #1
 ext v10.16b, v10.16b, v10.16b, #8
 eor v2.16b, v6.16b, v2.16b
 fmov v0.d[1], x9
 rev w9, w12
 eor x6, x6, x13
 orr x9, x11, x9, lsl #32
 eor v11.16b, v11.16b, v8.16b
 fmov d1, x10
 add w12, w12, #1
 eor x19, x19, x13
 fmov v1.d[1], x9
 rev w9, w12
 eor x20, x20, x14
 eor x7, x7, x14
 stp x6, x7, [x2], #16
 eor v11.16b, v11.16b, v10.16b
 add w12, w12, #1
 rev64 v4.16b, v4.16b
 orr x9, x11, x9, lsl #32
 aese v3.16b, v29.16b
 stp x19, x20, [x2], #16
 b.lt .L192_dec_main_loop
.L192_dec_prepretail:
 mov x22, v2.d[1]
 ext v11.16b, v11.16b, v11.16b, #8
 eor v3.16b, v7.16b, v3.16b
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 mov x21, v2.d[0]
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 mov d10, v17.d[1]
 eor v4.16b, v4.16b, v11.16b
 fmov d2, x10
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 mov x23, v3.d[0]
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 mov x24, v3.d[1]
 pmull v11.1q, v4.1d, v15.1d
 mov d8, v4.d[1]
 fmov d3, x10
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 rev64 v6.16b, v6.16b
 pmull2 v9.1q, v4.2d, v15.2d
 fmov v2.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 eor v8.8b, v8.8b, v4.8b
 mov d4, v5.d[1]
 pmull v31.1q, v5.1d, v14.1d
 eor x24, x24, x14
 fmov v3.d[1], x9
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 eor x21, x21, x13
 pmull2 v30.1q, v5.2d, v14.2d
 eor x22, x22, x14
 eor v4.8b, v4.8b, v5.8b
 pmull v10.1q, v8.1d, v10.1d
 eor x23, x23, x13
 stp x21, x22, [x2], #16
 rev64 v7.16b, v7.16b
 stp x23, x24, [x2], #16
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v30.16b
 pmull v4.1q, v4.1d, v17.1d
 add w12, w12, #1
 pmull2 v30.1q, v6.2d, v13.2d
 eor v11.16b, v11.16b, v31.16b
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v4.16b
 mov d31, v6.d[1]
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v30.16b
 eor v31.8b, v31.8b, v6.8b
 pmull v8.1q, v6.1d, v13.1d
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 mov d30, v7.d[1]
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 ins v31.d[1], v31.d[0]
 pmull v6.1q, v7.1d, v12.1d
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor v30.8b, v30.8b, v7.8b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 pmull2 v31.1q, v31.2d, v16.2d
 eor v11.16b, v11.16b, v8.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 pmull2 v5.1q, v7.2d, v12.2d
 movi v8.8b, #0xc2
 pmull v30.1q, v30.1d, v16.1d
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 shl d8, d8, #56
 eor v9.16b, v9.16b, v5.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v31.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 pmull v31.1q, v9.1d, v8.1d
 eor v11.16b, v11.16b, v6.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v30.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 eor v30.16b, v11.16b, v9.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v30.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v31.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v9.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v8.1q, v10.1d, v8.1d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 ext v10.16b, v10.16b, v10.16b, #8
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v29.16b
 eor v11.16b, v11.16b, v8.16b
 aese v2.16b, v29.16b
 aese v1.16b, v29.16b
 aese v3.16b, v29.16b
 eor v11.16b, v11.16b, v10.16b
.L192_dec_tail:
 sub x5, x4, x0
 ld1 { v5.16b}, [x0], #16
 eor v0.16b, v5.16b, v0.16b
 mov x7, v0.d[1]
 mov x6, v0.d[0]
 ext v8.16b, v11.16b, v11.16b, #8
 cmp x5, #48
 eor x7, x7, x14
 eor x6, x6, x13
 b.gt .L192_dec_blocks_more_than_3
 movi v11.8b, #0
 movi v9.8b, #0
 mov v3.16b, v2.16b
 mov v2.16b, v1.16b
 sub w12, w12, #1
 movi v10.8b, #0
 cmp x5, #32
 b.gt .L192_dec_blocks_more_than_2
 mov v3.16b, v1.16b
 cmp x5, #16
 sub w12, w12, #1
 b.gt .L192_dec_blocks_more_than_1
 sub w12, w12, #1
 b .L192_dec_blocks_less_than_1
.L192_dec_blocks_more_than_3:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 stp x6, x7, [x2], #16
 eor v4.16b, v4.16b, v8.16b
 eor v0.16b, v5.16b, v1.16b
 pmull v11.1q, v4.1d, v15.1d
 mov x6, v0.d[0]
 mov d22, v4.d[1]
 mov x7, v0.d[1]
 mov d10, v17.d[1]
 eor v22.8b, v22.8b, v4.8b
 pmull2 v9.1q, v4.2d, v15.2d
 eor x6, x6, x13
 movi v8.8b, #0
 pmull v10.1q, v22.1d, v10.1d
 eor x7, x7, x14
.L192_dec_blocks_more_than_2:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 movi v8.8b, #0
 eor v0.16b, v5.16b, v2.16b
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v14.1d
 stp x6, x7, [x2], #16
 eor v22.8b, v22.8b, v4.8b
 mov x7, v0.d[1]
 eor v11.16b, v11.16b, v21.16b
 mov x6, v0.d[0]
 pmull2 v20.1q, v4.2d, v14.2d
 pmull v22.1q, v22.1d, v17.1d
 eor v9.16b, v9.16b, v20.16b
 eor x7, x7, x14
 eor x6, x6, x13
 eor v10.16b, v10.16b, v22.16b
.L192_dec_blocks_more_than_1:
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 ld1 { v5.16b}, [x0], #16
 mov d22, v4.d[1]
 pmull2 v20.1q, v4.2d, v13.2d
 eor v0.16b, v5.16b, v3.16b
 stp x6, x7, [x2], #16
 eor v22.8b, v22.8b, v4.8b
 eor v9.16b, v9.16b, v20.16b
 pmull v21.1q, v4.1d, v13.1d
 mov x7, v0.d[1]
 ins v22.d[1], v22.d[0]
 mov x6, v0.d[0]
 pmull2 v22.1q, v22.2d, v16.2d
 movi v8.8b, #0
 eor v11.16b, v11.16b, v21.16b
 eor x7, x7, x14
 eor x6, x6, x13
 eor v10.16b, v10.16b, v22.16b
.L192_dec_blocks_less_than_1:
 mvn x13, xzr
 ldp x4, x5, [x2]
 and x1, x1, #127
 sub x1, x1, #128
 neg x1, x1
 and x1, x1, #127
 mvn x14, xzr
 lsr x14, x14, x1
 cmp x1, #64
 csel x9, x13, x14, lt
 csel x10, x14, xzr, lt
 fmov d0, x9
 and x6, x6, x9
 bic x4, x4, x9
 orr x6, x6, x4
 mov v0.d[1], x10
 rev w9, w12
 and v5.16b, v5.16b, v0.16b
 str w9, [x16, #12]
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 bic x5, x5, x10
 and x7, x7, x10
 pmull2 v20.1q, v4.2d, v12.2d
 mov d8, v4.d[1]
 pmull v21.1q, v4.1d, v12.1d
 eor v8.8b, v8.8b, v4.8b
 eor v9.16b, v9.16b, v20.16b
 pmull v8.1q, v8.1d, v16.1d
 eor v11.16b, v11.16b, v21.16b
 eor v10.16b, v10.16b, v8.16b
 movi v8.8b, #0xc2
 eor v30.16b, v11.16b, v9.16b
 shl d8, d8, #56
 eor v10.16b, v10.16b, v30.16b
 pmull v31.1q, v9.1d, v8.1d
 orr x7, x7, x5
 stp x6, x7, [x2]
 ext v9.16b, v9.16b, v9.16b, #8
 eor v10.16b, v10.16b, v31.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v8.1q, v10.1d, v8.1d
 eor v11.16b, v11.16b, v8.16b
 ext v10.16b, v10.16b, v10.16b, #8
 eor v11.16b, v11.16b, v10.16b
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 mov x0, x15
 st1 { v11.16b }, [x3]
 ldp x21, x22, [sp, #16]
 ldp x23, x24, [sp, #32]
 ldp d8, d9, [sp, #48]
 ldp d10, d11, [sp, #64]
 ldp d12, d13, [sp, #80]
 ldp d14, d15, [sp, #96]
 ldp x19, x20, [sp], #112
 ret
.L192_dec_ret:
 mov w0, #0x0
 ret
.size aes_gcm_dec_192_kernel,.-aes_gcm_dec_192_kernel
.globl aes_gcm_enc_256_kernel
.type aes_gcm_enc_256_kernel,%function
.align 4
aes_gcm_enc_256_kernel:
 cbz x1, .L256_enc_ret
 stp x19, x20, [sp, #-112]!
 mov x16, x4
 mov x8, x5
 stp x21, x22, [sp, #16]
 stp x23, x24, [sp, #32]
 stp d8, d9, [sp, #48]
 stp d10, d11, [sp, #64]
 stp d12, d13, [sp, #80]
 stp d14, d15, [sp, #96]
 add x4, x0, x1, lsr #3
 lsr x5, x1, #3
 mov x15, x5
 ldp x10, x11, [x16]
 ldp x13, x14, [x8, #224]
 ld1 { v0.16b}, [x16]
 sub x5, x5, #1
 ld1 {v18.4s}, [x8], #16
 and x5, x5, #0xffffffffffffffc0
 ld1 {v19.4s}, [x8], #16
 add x5, x5, x0
 lsr x12, x11, #32
 fmov d2, x10
 orr w11, w11, w11
 rev w12, w12
 cmp x0, x5
 fmov d1, x10
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 add w12, w12, #1
 rev w9, w12
 fmov d3, x10
 orr x9, x11, x9, lsl #32
 add w12, w12, #1
 ld1 {v20.4s}, [x8], #16
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 orr x9, x11, x9, lsl #32
 ld1 {v21.4s}, [x8], #16
 fmov v2.d[1], x9
 rev w9, w12
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 orr x9, x11, x9, lsl #32
 fmov v3.d[1], x9
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ld1 {v22.4s}, [x8], #16
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 ld1 {v23.4s}, [x8], #16
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ld1 {v24.4s}, [x8], #16
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 ldr q14, [x3, #80]
 ext v14.16b, v14.16b, v14.16b, #8
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 ld1 {v25.4s}, [x8], #16
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 ld1 {v26.4s}, [x8], #16
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 ldr q13, [x3, #64]
 ext v13.16b, v13.16b, v13.16b, #8
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 ld1 {v27.4s}, [x8], #16
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 ldr q15, [x3, #112]
 ext v15.16b, v15.16b, v15.16b, #8
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 ld1 {v28.4s}, [x8], #16
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 ld1 {v29.4s}, [x8], #16
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 add w12, w12, #1
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 ld1 { v11.16b}, [x3]
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 trn2 v17.2d, v14.2d, v15.2d
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 ld1 {v30.4s}, [x8], #16
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 ldr q12, [x3, #32]
 ext v12.16b, v12.16b, v12.16b, #8
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 ld1 {v31.4s}, [x8], #16
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 trn1 v9.2d, v14.2d, v15.2d
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 trn2 v16.2d, v12.2d, v13.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v29.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v29.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v30.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v30.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v29.16b
 aesmc v0.16b, v0.16b
 eor v17.16b, v17.16b, v9.16b
 aese v3.16b, v29.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v31.16b
 trn1 v8.2d, v12.2d, v13.2d
 aese v0.16b, v30.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v30.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v31.16b
 aese v0.16b, v31.16b
 aese v3.16b, v31.16b
 eor v16.16b, v16.16b, v8.16b
 b.ge .L256_enc_tail
 ldp x19, x20, [x0, #16]
 rev w9, w12
 ldp x6, x7, [x0, #0]
 ldp x23, x24, [x0, #48]
 ldp x21, x22, [x0, #32]
 add x0, x0, #64
 eor x19, x19, x13
 eor x20, x20, x14
 fmov d5, x19
 eor x6, x6, x13
 eor x7, x7, x14
 eor x24, x24, x14
 fmov d4, x6
 cmp x0, x5
 fmov v4.d[1], x7
 eor x23, x23, x13
 eor x21, x21, x13
 fmov v5.d[1], x20
 fmov d6, x21
 add w12, w12, #1
 orr x9, x11, x9, lsl #32
 fmov d7, x23
 eor x22, x22, x14
 fmov v6.d[1], x22
 eor v4.16b, v4.16b, v0.16b
 fmov d0, x10
 fmov v0.d[1], x9
 rev w9, w12
 add w12, w12, #1
 eor v5.16b, v5.16b, v1.16b
 fmov d1, x10
 orr x9, x11, x9, lsl #32
 fmov v1.d[1], x9
 rev w9, w12
 st1 { v4.16b}, [x2], #16
 fmov v7.d[1], x24
 orr x9, x11, x9, lsl #32
 eor v6.16b, v6.16b, v2.16b
 st1 { v5.16b}, [x2], #16
 add w12, w12, #1
 fmov d2, x10
 fmov v2.d[1], x9
 st1 { v6.16b}, [x2], #16
 rev w9, w12
 orr x9, x11, x9, lsl #32
 eor v7.16b, v7.16b, v3.16b
 st1 { v7.16b}, [x2], #16
 b.ge .L256_enc_prepretail
.L256_enc_main_loop:
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 rev64 v4.16b, v4.16b
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 fmov d3, x10
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ext v11.16b, v11.16b, v11.16b, #8
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 fmov v3.d[1], x9
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 ldp x23, x24, [x0, #48]
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 ldp x21, x22, [x0, #32]
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 eor v4.16b, v4.16b, v11.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor x23, x23, x13
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 mov d10, v17.d[1]
 pmull2 v9.1q, v4.2d, v15.2d
 eor x22, x22, x14
 mov d8, v4.d[1]
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 rev64 v5.16b, v5.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 pmull v11.1q, v4.1d, v15.1d
 eor v8.8b, v8.8b, v4.8b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 rev64 v7.16b, v7.16b
 pmull2 v4.1q, v5.2d, v14.2d
 pmull v10.1q, v8.1d, v10.1d
 rev64 v6.16b, v6.16b
 pmull v8.1q, v5.1d, v14.1d
 eor v9.16b, v9.16b, v4.16b
 mov d4, v5.d[1]
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor v11.16b, v11.16b, v8.16b
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 mov d8, v6.d[1]
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v4.8b, v4.8b, v5.8b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 eor v8.8b, v8.8b, v6.8b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 pmull v4.1q, v4.1d, v17.1d
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 ins v8.d[1], v8.d[0]
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v4.16b
 pmull2 v4.1q, v6.2d, v13.2d
 pmull v5.1q, v6.1d, v13.1d
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 pmull v6.1q, v7.1d, v12.1d
 eor v9.16b, v9.16b, v4.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 ldp x19, x20, [x0, #16]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 mov d4, v7.d[1]
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 eor v11.16b, v11.16b, v5.16b
 pmull2 v8.1q, v8.2d, v16.2d
 pmull2 v5.1q, v7.2d, v12.2d
 eor v4.8b, v4.8b, v7.8b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 eor x19, x19, x13
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v8.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 eor x21, x21, x13
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 movi v8.8b, #0xc2
 pmull v4.1q, v4.1d, v16.1d
 eor v9.16b, v9.16b, v5.16b
 fmov d5, x19
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ldp x6, x7, [x0, #0]
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 shl d8, d8, #56
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 eor v11.16b, v11.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v4.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 add w12, w12, #1
 aese v0.16b, v29.16b
 aesmc v0.16b, v0.16b
 eor v4.16b, v11.16b, v9.16b
 aese v1.16b, v29.16b
 aesmc v1.16b, v1.16b
 add x0, x0, #64
 pmull v7.1q, v9.1d, v8.1d
 rev w9, w12
 ext v9.16b, v9.16b, v9.16b, #8
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 eor x6, x6, x13
 aese v1.16b, v30.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 eor x7, x7, x14
 fmov d4, x6
 orr x9, x11, x9, lsl #32
 eor v7.16b, v9.16b, v7.16b
 aese v0.16b, v30.16b
 aesmc v0.16b, v0.16b
 eor x20, x20, x14
 aese v2.16b, v29.16b
 aesmc v2.16b, v2.16b
 eor x24, x24, x14
 aese v3.16b, v29.16b
 aesmc v3.16b, v3.16b
 add w12, w12, #1
 aese v0.16b, v31.16b
 fmov v4.d[1], x7
 eor v10.16b, v10.16b, v7.16b
 aese v2.16b, v30.16b
 aesmc v2.16b, v2.16b
 fmov d7, x23
 aese v1.16b, v31.16b
 fmov v5.d[1], x20
 fmov d6, x21
 cmp x0, x5
 fmov v6.d[1], x22
 pmull v9.1q, v10.1d, v8.1d
 eor v4.16b, v4.16b, v0.16b
 fmov d0, x10
 fmov v0.d[1], x9
 rev w9, w12
 add w12, w12, #1
 eor v5.16b, v5.16b, v1.16b
 fmov d1, x10
 orr x9, x11, x9, lsl #32
 aese v3.16b, v30.16b
 aesmc v3.16b, v3.16b
 fmov v1.d[1], x9
 aese v2.16b, v31.16b
 rev w9, w12
 st1 { v4.16b}, [x2], #16
 orr x9, x11, x9, lsl #32
 eor v11.16b, v11.16b, v9.16b
 fmov v7.d[1], x24
 ext v10.16b, v10.16b, v10.16b, #8
 st1 { v5.16b}, [x2], #16
 add w12, w12, #1
 aese v3.16b, v31.16b
 eor v6.16b, v6.16b, v2.16b
 fmov d2, x10
 st1 { v6.16b}, [x2], #16
 fmov v2.d[1], x9
 rev w9, w12
 eor v11.16b, v11.16b, v10.16b
 orr x9, x11, x9, lsl #32
 eor v7.16b, v7.16b, v3.16b
 st1 { v7.16b}, [x2], #16
 b.lt .L256_enc_main_loop
.L256_enc_prepretail:
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 rev64 v6.16b, v6.16b
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 fmov d3, x10
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 rev64 v4.16b, v4.16b
 fmov v3.d[1], x9
 ext v11.16b, v11.16b, v11.16b, #8
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 eor v4.16b, v4.16b, v11.16b
 rev64 v5.16b, v5.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 mov d10, v17.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 pmull v11.1q, v4.1d, v15.1d
 mov d8, v4.d[1]
 pmull2 v9.1q, v4.2d, v15.2d
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 eor v8.8b, v8.8b, v4.8b
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 pmull v10.1q, v8.1d, v10.1d
 pmull2 v4.1q, v5.2d, v14.2d
 pmull v8.1q, v5.1d, v14.1d
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v4.16b
 mov d4, v5.d[1]
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v8.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v4.8b, v4.8b, v5.8b
 mov d8, v6.d[1]
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 rev64 v7.16b, v7.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 pmull v4.1q, v4.1d, v17.1d
 eor v8.8b, v8.8b, v6.8b
 add w12, w12, #1
 pmull v5.1q, v6.1d, v13.1d
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v4.16b
 pmull2 v4.1q, v6.2d, v13.2d
 eor v11.16b, v11.16b, v5.16b
 ins v8.d[1], v8.d[0]
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v4.16b
 mov d4, v7.d[1]
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 pmull2 v8.1q, v8.2d, v16.2d
 eor v4.8b, v4.8b, v7.8b
 pmull2 v5.1q, v7.2d, v12.2d
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 pmull v4.1q, v4.1d, v16.1d
 eor v10.16b, v10.16b, v8.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 movi v8.8b, #0xc2
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 eor v9.16b, v9.16b, v5.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 shl d8, d8, #56
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v4.16b
 pmull v6.1q, v7.1d, v12.1d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v4.1q, v9.1d, v8.1d
 ext v9.16b, v9.16b, v9.16b, #8
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v11.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v29.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v30.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v29.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v9.16b
 aese v3.16b, v29.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v30.16b
 aesmc v0.16b, v0.16b
 pmull v4.1q, v10.1d, v8.1d
 aese v2.16b, v29.16b
 aesmc v2.16b, v2.16b
 ext v10.16b, v10.16b, v10.16b, #8
 aese v3.16b, v30.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v31.16b
 eor v11.16b, v11.16b, v4.16b
 aese v2.16b, v30.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v31.16b
 aese v0.16b, v31.16b
 aese v2.16b, v31.16b
 eor v11.16b, v11.16b, v10.16b
.L256_enc_tail:
 ext v8.16b, v11.16b, v11.16b, #8
 sub x5, x4, x0
 ldp x6, x7, [x0], #16
 eor x6, x6, x13
 eor x7, x7, x14
 cmp x5, #48
 fmov d4, x6
 fmov v4.d[1], x7
 eor v5.16b, v4.16b, v0.16b
 b.gt .L256_enc_blocks_more_than_3
 cmp x5, #32
 mov v3.16b, v2.16b
 movi v11.8b, #0
 movi v9.8b, #0
 sub w12, w12, #1
 mov v2.16b, v1.16b
 movi v10.8b, #0
 b.gt .L256_enc_blocks_more_than_2
 mov v3.16b, v1.16b
 sub w12, w12, #1
 cmp x5, #16
 b.gt .L256_enc_blocks_more_than_1
 sub w12, w12, #1
 b .L256_enc_blocks_less_than_1
.L256_enc_blocks_more_than_3:
 st1 { v5.16b}, [x2], #16
 ldp x6, x7, [x0], #16
 rev64 v4.16b, v5.16b
 eor x6, x6, x13
 eor v4.16b, v4.16b, v8.16b
 eor x7, x7, x14
 mov d22, v4.d[1]
 fmov d5, x6
 fmov v5.d[1], x7
 eor v22.8b, v22.8b, v4.8b
 movi v8.8b, #0
 mov d10, v17.d[1]
 pmull v11.1q, v4.1d, v15.1d
 pmull2 v9.1q, v4.2d, v15.2d
 pmull v10.1q, v22.1d, v10.1d
 eor v5.16b, v5.16b, v1.16b
.L256_enc_blocks_more_than_2:
 st1 { v5.16b}, [x2], #16
 ldp x6, x7, [x0], #16
 rev64 v4.16b, v5.16b
 eor x6, x6, x13
 eor v4.16b, v4.16b, v8.16b
 fmov d5, x6
 eor x7, x7, x14
 fmov v5.d[1], x7
 movi v8.8b, #0
 pmull2 v20.1q, v4.2d, v14.2d
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v14.1d
 eor v22.8b, v22.8b, v4.8b
 eor v5.16b, v5.16b, v2.16b
 eor v9.16b, v9.16b, v20.16b
 pmull v22.1q, v22.1d, v17.1d
 eor v11.16b, v11.16b, v21.16b
 eor v10.16b, v10.16b, v22.16b
.L256_enc_blocks_more_than_1:
 st1 { v5.16b}, [x2], #16
 rev64 v4.16b, v5.16b
 ldp x6, x7, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 movi v8.8b, #0
 eor x6, x6, x13
 mov d22, v4.d[1]
 pmull2 v20.1q, v4.2d, v13.2d
 eor x7, x7, x14
 eor v22.8b, v22.8b, v4.8b
 eor v9.16b, v9.16b, v20.16b
 ins v22.d[1], v22.d[0]
 fmov d5, x6
 fmov v5.d[1], x7
 pmull2 v22.1q, v22.2d, v16.2d
 pmull v21.1q, v4.1d, v13.1d
 eor v5.16b, v5.16b, v3.16b
 eor v10.16b, v10.16b, v22.16b
 eor v11.16b, v11.16b, v21.16b
.L256_enc_blocks_less_than_1:
 and x1, x1, #127
 mvn x13, xzr
 sub x1, x1, #128
 neg x1, x1
 ld1 { v18.16b}, [x2]
 mvn x14, xzr
 and x1, x1, #127
 lsr x14, x14, x1
 cmp x1, #64
 csel x6, x13, x14, lt
 csel x7, x14, xzr, lt
 fmov d0, x6
 fmov v0.d[1], x7
 and v5.16b, v5.16b, v0.16b
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 bif v5.16b, v18.16b, v0.16b
 pmull2 v20.1q, v4.2d, v12.2d
 mov d8, v4.d[1]
 rev w9, w12
 pmull v21.1q, v4.1d, v12.1d
 eor v9.16b, v9.16b, v20.16b
 eor v8.8b, v8.8b, v4.8b
 pmull v8.1q, v8.1d, v16.1d
 eor v11.16b, v11.16b, v21.16b
 eor v10.16b, v10.16b, v8.16b
 movi v8.8b, #0xc2
 eor v4.16b, v11.16b, v9.16b
 shl d8, d8, #56
 eor v10.16b, v10.16b, v4.16b
 pmull v7.1q, v9.1d, v8.1d
 ext v9.16b, v9.16b, v9.16b, #8
 eor v10.16b, v10.16b, v7.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v9.1q, v10.1d, v8.1d
 ext v10.16b, v10.16b, v10.16b, #8
 str w9, [x16, #12]
 st1 { v5.16b}, [x2]
 eor v11.16b, v11.16b, v9.16b
 eor v11.16b, v11.16b, v10.16b
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 mov x0, x15
 st1 { v11.16b }, [x3]
 ldp x21, x22, [sp, #16]
 ldp x23, x24, [sp, #32]
 ldp d8, d9, [sp, #48]
 ldp d10, d11, [sp, #64]
 ldp d12, d13, [sp, #80]
 ldp d14, d15, [sp, #96]
 ldp x19, x20, [sp], #112
 ret
.L256_enc_ret:
 mov w0, #0x0
 ret
.size aes_gcm_enc_256_kernel,.-aes_gcm_enc_256_kernel
.globl aes_gcm_dec_256_kernel
.type aes_gcm_dec_256_kernel,%function
.align 4
aes_gcm_dec_256_kernel:
 cbz x1, .L256_dec_ret
 stp x19, x20, [sp, #-112]!
 mov x16, x4
 mov x8, x5
 stp x21, x22, [sp, #16]
 stp x23, x24, [sp, #32]
 stp d8, d9, [sp, #48]
 stp d10, d11, [sp, #64]
 stp d12, d13, [sp, #80]
 stp d14, d15, [sp, #96]
 lsr x5, x1, #3
 mov x15, x5
 ldp x10, x11, [x16]
 ldp x13, x14, [x8, #224]
 ld1 {v18.4s}, [x8], #16
 sub x5, x5, #1
 ld1 {v19.4s}, [x8], #16
 and x5, x5, #0xffffffffffffffc0
 add x4, x0, x1, lsr #3
 ld1 {v20.4s}, [x8], #16
 lsr x12, x11, #32
 ld1 {v21.4s}, [x8], #16
 orr w11, w11, w11
 ld1 {v22.4s}, [x8], #16
 add x5, x5, x0
 rev w12, w12
 add w12, w12, #1
 fmov d3, x10
 rev w9, w12
 add w12, w12, #1
 fmov d1, x10
 orr x9, x11, x9, lsl #32
 ld1 { v0.16b}, [x16]
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 fmov d2, x10
 orr x9, x11, x9, lsl #32
 fmov v2.d[1], x9
 rev w9, w12
 orr x9, x11, x9, lsl #32
 ld1 {v23.4s}, [x8], #16
 fmov v3.d[1], x9
 add w12, w12, #1
 ld1 {v24.4s}, [x8], #16
 ld1 {v25.4s}, [x8], #16
 ld1 {v26.4s}, [x8], #16
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 ldr q14, [x3, #80]
 ext v14.16b, v14.16b, v14.16b, #8
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 ldr q15, [x3, #112]
 ext v15.16b, v15.16b, v15.16b, #8
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 ldr q13, [x3, #64]
 ext v13.16b, v13.16b, v13.16b, #8
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 ld1 {v27.4s}, [x8], #16
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 ld1 { v11.16b}, [x3]
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 ld1 {v28.4s}, [x8], #16
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 ld1 {v29.4s}, [x8], #16
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 ldr q12, [x3, #32]
 ext v12.16b, v12.16b, v12.16b, #8
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 ld1 {v30.4s}, [x8], #16
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 cmp x0, x5
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ld1 {v31.4s}, [x8], #16
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v29.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v29.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v29.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v29.16b
 aesmc v2.16b, v2.16b
 trn1 v9.2d, v14.2d, v15.2d
 trn2 v17.2d, v14.2d, v15.2d
 trn1 v8.2d, v12.2d, v13.2d
 trn2 v16.2d, v12.2d, v13.2d
 aese v1.16b, v30.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v30.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v30.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v30.16b
 aesmc v3.16b, v3.16b
 eor v17.16b, v17.16b, v9.16b
 aese v1.16b, v31.16b
 aese v2.16b, v31.16b
 eor v16.16b, v16.16b, v8.16b
 aese v3.16b, v31.16b
 aese v0.16b, v31.16b
 b.ge .L256_dec_tail
 ld1 {v4.16b, v5.16b}, [x0], #32
 rev w9, w12
 eor v0.16b, v4.16b, v0.16b
 eor v1.16b, v5.16b, v1.16b
 rev64 v5.16b, v5.16b
 ld1 {v6.16b}, [x0], #16
 mov x7, v0.d[1]
 mov x6, v0.d[0]
 rev64 v4.16b, v4.16b
 add w12, w12, #1
 fmov d0, x10
 orr x9, x11, x9, lsl #32
 fmov v0.d[1], x9
 rev w9, w12
 add w12, w12, #1
 mov x19, v1.d[0]
 orr x9, x11, x9, lsl #32
 mov x20, v1.d[1]
 eor x7, x7, x14
 eor x6, x6, x13
 stp x6, x7, [x2], #16
 fmov d1, x10
 ld1 {v7.16b}, [x0], #16
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 eor x19, x19, x13
 orr x9, x11, x9, lsl #32
 eor x20, x20, x14
 stp x19, x20, [x2], #16
 eor v2.16b, v6.16b, v2.16b
 cmp x0, x5
 b.ge .L256_dec_prepretail
.L256_dec_main_loop:
 mov x21, v2.d[0]
 ext v11.16b, v11.16b, v11.16b, #8
 eor v3.16b, v7.16b, v3.16b
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 mov x22, v2.d[1]
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 fmov d2, x10
 fmov v2.d[1], x9
 eor v4.16b, v4.16b, v11.16b
 rev w9, w12
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 mov x24, v3.d[1]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 mov x23, v3.d[0]
 pmull2 v9.1q, v4.2d, v15.2d
 mov d8, v4.d[1]
 fmov d3, x10
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 orr x9, x11, x9, lsl #32
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 fmov v3.d[1], x9
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 eor v8.8b, v8.8b, v4.8b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 eor x22, x22, x14
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 mov d10, v17.d[1]
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 rev64 v6.16b, v6.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 eor x21, x21, x13
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 stp x21, x22, [x2], #16
 pmull v11.1q, v4.1d, v15.1d
 pmull2 v4.1q, v5.2d, v14.2d
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 rev64 v7.16b, v7.16b
 pmull v10.1q, v8.1d, v10.1d
 eor x23, x23, x13
 pmull v8.1q, v5.1d, v14.1d
 eor x24, x24, x14
 eor v9.16b, v9.16b, v4.16b
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 mov d4, v5.d[1]
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v8.16b
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 add w12, w12, #1
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 mov d8, v6.d[1]
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 eor v4.8b, v4.8b, v5.8b
 pmull v5.1q, v6.1d, v13.1d
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v8.8b, v8.8b, v6.8b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v5.16b
 pmull v4.1q, v4.1d, v17.1d
 rev w9, w12
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 ins v8.d[1], v8.d[0]
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 add w12, w12, #1
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v4.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 pmull2 v4.1q, v6.2d, v13.2d
 mov d6, v7.d[1]
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 pmull2 v8.1q, v8.2d, v16.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v9.16b, v9.16b, v4.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 pmull v4.1q, v7.1d, v12.1d
 orr x9, x11, x9, lsl #32
 eor v10.16b, v10.16b, v8.16b
 pmull2 v5.1q, v7.2d, v12.2d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 eor v6.8b, v6.8b, v7.8b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 eor v9.16b, v9.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull v6.1q, v6.1d, v16.1d
 movi v8.8b, #0xc2
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 eor v11.16b, v11.16b, v4.16b
 aese v0.16b, v29.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 shl d8, d8, #56
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v6.16b
 aese v0.16b, v30.16b
 aesmc v0.16b, v0.16b
 pmull v7.1q, v9.1d, v8.1d
 eor v6.16b, v11.16b, v9.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 ld1 {v4.16b}, [x0], #16
 aese v0.16b, v31.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ld1 {v5.16b}, [x0], #16
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 eor v0.16b, v4.16b, v0.16b
 aese v1.16b, v29.16b
 aesmc v1.16b, v1.16b
 stp x23, x24, [x2], #16
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 ld1 {v6.16b}, [x0], #16
 aese v1.16b, v30.16b
 aesmc v1.16b, v1.16b
 ld1 {v7.16b}, [x0], #16
 aese v2.16b, v29.16b
 aesmc v2.16b, v2.16b
 mov x7, v0.d[1]
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v9.16b
 aese v1.16b, v31.16b
 mov x6, v0.d[0]
 aese v2.16b, v30.16b
 aesmc v2.16b, v2.16b
 fmov d0, x10
 aese v3.16b, v29.16b
 aesmc v3.16b, v3.16b
 fmov v0.d[1], x9
 pmull v8.1q, v10.1d, v8.1d
 eor v1.16b, v5.16b, v1.16b
 rev w9, w12
 aese v2.16b, v31.16b
 orr x9, x11, x9, lsl #32
 cmp x0, x5
 add w12, w12, #1
 eor x6, x6, x13
 eor x7, x7, x14
 mov x20, v1.d[1]
 eor v2.16b, v6.16b, v2.16b
 eor v11.16b, v11.16b, v8.16b
 aese v3.16b, v30.16b
 aesmc v3.16b, v3.16b
 mov x19, v1.d[0]
 fmov d1, x10
 ext v10.16b, v10.16b, v10.16b, #8
 fmov v1.d[1], x9
 rev w9, w12
 add w12, w12, #1
 aese v3.16b, v31.16b
 orr x9, x11, x9, lsl #32
 rev64 v5.16b, v5.16b
 eor x20, x20, x14
 stp x6, x7, [x2], #16
 eor x19, x19, x13
 stp x19, x20, [x2], #16
 rev64 v4.16b, v4.16b
 eor v11.16b, v11.16b, v10.16b
 b.lt .L256_dec_main_loop
.L256_dec_prepretail:
 ext v11.16b, v11.16b, v11.16b, #8
 mov x21, v2.d[0]
 eor v3.16b, v7.16b, v3.16b
 aese v0.16b, v18.16b
 aesmc v0.16b, v0.16b
 mov x22, v2.d[1]
 aese v1.16b, v18.16b
 aesmc v1.16b, v1.16b
 fmov d2, x10
 fmov v2.d[1], x9
 rev w9, w12
 eor v4.16b, v4.16b, v11.16b
 rev64 v6.16b, v6.16b
 orr x9, x11, x9, lsl #32
 mov x23, v3.d[0]
 aese v1.16b, v19.16b
 aesmc v1.16b, v1.16b
 mov x24, v3.d[1]
 pmull v11.1q, v4.1d, v15.1d
 mov d8, v4.d[1]
 fmov d3, x10
 pmull2 v9.1q, v4.2d, v15.2d
 fmov v3.d[1], x9
 aese v2.16b, v18.16b
 aesmc v2.16b, v2.16b
 mov d10, v17.d[1]
 aese v0.16b, v19.16b
 aesmc v0.16b, v0.16b
 eor v8.8b, v8.8b, v4.8b
 pmull2 v4.1q, v5.2d, v14.2d
 aese v2.16b, v19.16b
 aesmc v2.16b, v2.16b
 rev64 v7.16b, v7.16b
 aese v3.16b, v18.16b
 aesmc v3.16b, v3.16b
 pmull v10.1q, v8.1d, v10.1d
 eor v9.16b, v9.16b, v4.16b
 pmull v8.1q, v5.1d, v14.1d
 aese v3.16b, v19.16b
 aesmc v3.16b, v3.16b
 mov d4, v5.d[1]
 aese v0.16b, v20.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v20.16b
 aesmc v1.16b, v1.16b
 eor v11.16b, v11.16b, v8.16b
 aese v2.16b, v20.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v21.16b
 aesmc v0.16b, v0.16b
 mov d8, v6.d[1]
 aese v3.16b, v20.16b
 aesmc v3.16b, v3.16b
 eor v4.8b, v4.8b, v5.8b
 pmull v5.1q, v6.1d, v13.1d
 aese v0.16b, v22.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v21.16b
 aesmc v3.16b, v3.16b
 eor v8.8b, v8.8b, v6.8b
 pmull v4.1q, v4.1d, v17.1d
 aese v0.16b, v23.16b
 aesmc v0.16b, v0.16b
 eor v11.16b, v11.16b, v5.16b
 aese v3.16b, v22.16b
 aesmc v3.16b, v3.16b
 pmull2 v5.1q, v7.2d, v12.2d
 eor v10.16b, v10.16b, v4.16b
 pmull2 v4.1q, v6.2d, v13.2d
 aese v3.16b, v23.16b
 aesmc v3.16b, v3.16b
 ins v8.d[1], v8.d[0]
 aese v2.16b, v21.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v21.16b
 aesmc v1.16b, v1.16b
 eor v9.16b, v9.16b, v4.16b
 pmull v4.1q, v7.1d, v12.1d
 aese v2.16b, v22.16b
 aesmc v2.16b, v2.16b
 mov d6, v7.d[1]
 aese v1.16b, v22.16b
 aesmc v1.16b, v1.16b
 pmull2 v8.1q, v8.2d, v16.2d
 aese v2.16b, v23.16b
 aesmc v2.16b, v2.16b
 eor v6.8b, v6.8b, v7.8b
 aese v1.16b, v23.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v24.16b
 aesmc v3.16b, v3.16b
 eor v10.16b, v10.16b, v8.16b
 aese v2.16b, v24.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v24.16b
 aesmc v0.16b, v0.16b
 movi v8.8b, #0xc2
 aese v1.16b, v24.16b
 aesmc v1.16b, v1.16b
 eor v11.16b, v11.16b, v4.16b
 pmull v6.1q, v6.1d, v16.1d
 aese v3.16b, v25.16b
 aesmc v3.16b, v3.16b
 eor v9.16b, v9.16b, v5.16b
 aese v1.16b, v25.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v25.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v6.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v25.16b
 aesmc v2.16b, v2.16b
 eor v6.16b, v11.16b, v9.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 shl d8, d8, #56
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 eor v10.16b, v10.16b, v6.16b
 pmull v7.1q, v9.1d, v8.1d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ext v9.16b, v9.16b, v9.16b, #8
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 eor v10.16b, v10.16b, v7.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 eor x22, x22, x14
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 eor x23, x23, x13
 aese v2.16b, v29.16b
 aesmc v2.16b, v2.16b
 eor v10.16b, v10.16b, v9.16b
 aese v0.16b, v29.16b
 aesmc v0.16b, v0.16b
 add w12, w12, #1
 aese v1.16b, v29.16b
 aesmc v1.16b, v1.16b
 eor x21, x21, x13
 aese v2.16b, v30.16b
 aesmc v2.16b, v2.16b
 pmull v8.1q, v10.1d, v8.1d
 eor x24, x24, x14
 aese v3.16b, v29.16b
 aesmc v3.16b, v3.16b
 stp x21, x22, [x2], #16
 aese v1.16b, v30.16b
 aesmc v1.16b, v1.16b
 ext v10.16b, v10.16b, v10.16b, #8
 aese v0.16b, v30.16b
 aesmc v0.16b, v0.16b
 stp x23, x24, [x2], #16
 aese v3.16b, v30.16b
 aesmc v3.16b, v3.16b
 eor v11.16b, v11.16b, v8.16b
 aese v1.16b, v31.16b
 aese v0.16b, v31.16b
 aese v3.16b, v31.16b
 aese v2.16b, v31.16b
 eor v11.16b, v11.16b, v10.16b
.L256_dec_tail:
 sub x5, x4, x0
 ld1 { v5.16b}, [x0], #16
 eor v0.16b, v5.16b, v0.16b
 mov x6, v0.d[0]
 mov x7, v0.d[1]
 ext v8.16b, v11.16b, v11.16b, #8
 cmp x5, #48
 eor x6, x6, x13
 eor x7, x7, x14
 b.gt .L256_dec_blocks_more_than_3
 sub w12, w12, #1
 mov v3.16b, v2.16b
 movi v10.8b, #0
 movi v11.8b, #0
 cmp x5, #32
 movi v9.8b, #0
 mov v2.16b, v1.16b
 b.gt .L256_dec_blocks_more_than_2
 sub w12, w12, #1
 mov v3.16b, v1.16b
 cmp x5, #16
 b.gt .L256_dec_blocks_more_than_1
 sub w12, w12, #1
 b .L256_dec_blocks_less_than_1
.L256_dec_blocks_more_than_3:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 stp x6, x7, [x2], #16
 mov d10, v17.d[1]
 eor v4.16b, v4.16b, v8.16b
 eor v0.16b, v5.16b, v1.16b
 mov d22, v4.d[1]
 mov x6, v0.d[0]
 mov x7, v0.d[1]
 eor v22.8b, v22.8b, v4.8b
 movi v8.8b, #0
 pmull2 v9.1q, v4.2d, v15.2d
 pmull v10.1q, v22.1d, v10.1d
 eor x6, x6, x13
 pmull v11.1q, v4.1d, v15.1d
 eor x7, x7, x14
.L256_dec_blocks_more_than_2:
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 stp x6, x7, [x2], #16
 eor v0.16b, v5.16b, v2.16b
 mov d22, v4.d[1]
 pmull v21.1q, v4.1d, v14.1d
 pmull2 v20.1q, v4.2d, v14.2d
 eor v22.8b, v22.8b, v4.8b
 mov x6, v0.d[0]
 mov x7, v0.d[1]
 eor v11.16b, v11.16b, v21.16b
 movi v8.8b, #0
 pmull v22.1q, v22.1d, v17.1d
 eor v9.16b, v9.16b, v20.16b
 eor x6, x6, x13
 eor v10.16b, v10.16b, v22.16b
 eor x7, x7, x14
.L256_dec_blocks_more_than_1:
 stp x6, x7, [x2], #16
 rev64 v4.16b, v5.16b
 ld1 { v5.16b}, [x0], #16
 eor v4.16b, v4.16b, v8.16b
 movi v8.8b, #0
 mov d22, v4.d[1]
 eor v0.16b, v5.16b, v3.16b
 pmull2 v20.1q, v4.2d, v13.2d
 eor v22.8b, v22.8b, v4.8b
 pmull v21.1q, v4.1d, v13.1d
 mov x6, v0.d[0]
 ins v22.d[1], v22.d[0]
 mov x7, v0.d[1]
 pmull2 v22.1q, v22.2d, v16.2d
 eor x6, x6, x13
 eor v11.16b, v11.16b, v21.16b
 eor v9.16b, v9.16b, v20.16b
 eor v10.16b, v10.16b, v22.16b
 eor x7, x7, x14
.L256_dec_blocks_less_than_1:
 and x1, x1, #127
 mvn x14, xzr
 sub x1, x1, #128
 mvn x13, xzr
 ldp x4, x5, [x2]
 neg x1, x1
 and x1, x1, #127
 lsr x14, x14, x1
 cmp x1, #64
 csel x9, x13, x14, lt
 csel x10, x14, xzr, lt
 fmov d0, x9
 and x6, x6, x9
 mov v0.d[1], x10
 bic x4, x4, x9
 rev w9, w12
 bic x5, x5, x10
 orr x6, x6, x4
 and x7, x7, x10
 orr x7, x7, x5
 and v5.16b, v5.16b, v0.16b
 rev64 v4.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 pmull v21.1q, v4.1d, v12.1d
 mov d8, v4.d[1]
 eor v8.8b, v8.8b, v4.8b
 pmull2 v20.1q, v4.2d, v12.2d
 pmull v8.1q, v8.1d, v16.1d
 eor v9.16b, v9.16b, v20.16b
 eor v11.16b, v11.16b, v21.16b
 eor v10.16b, v10.16b, v8.16b
 movi v8.8b, #0xc2
 eor v6.16b, v11.16b, v9.16b
 shl d8, d8, #56
 eor v10.16b, v10.16b, v6.16b
 pmull v7.1q, v9.1d, v8.1d
 ext v9.16b, v9.16b, v9.16b, #8
 eor v10.16b, v10.16b, v7.16b
 eor v10.16b, v10.16b, v9.16b
 pmull v8.1q, v10.1d, v8.1d
 ext v10.16b, v10.16b, v10.16b, #8
 eor v11.16b, v11.16b, v8.16b
 stp x6, x7, [x2]
 str w9, [x16, #12]
 eor v11.16b, v11.16b, v10.16b
 ext v11.16b, v11.16b, v11.16b, #8
 rev64 v11.16b, v11.16b
 mov x0, x15
 st1 { v11.16b }, [x3]
 ldp x21, x22, [sp, #16]
 ldp x23, x24, [sp, #32]
 ldp d8, d9, [sp, #48]
 ldp d10, d11, [sp, #64]
 ldp d12, d13, [sp, #80]
 ldp d14, d15, [sp, #96]
 ldp x19, x20, [sp], #112
 ret
.L256_dec_ret:
 mov w0, #0x0
 ret
.size aes_gcm_dec_256_kernel,.-aes_gcm_dec_256_kernel
.section .rodata
.byte 71,72,65,83,72,32,102,111,114,32,65,82,77,118,56,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60,104,116,116,112,115,58,47,47,103,105,116,104,117,98,46,99,111,109,47,100,111,116,45,97,115,109,62,0
.align 2
.align 2
