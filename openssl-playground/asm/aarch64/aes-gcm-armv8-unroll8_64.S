.arch armv8-a+crypto
.text
.globl unroll8_eor3_aes_gcm_enc_128_kernel
.type unroll8_eor3_aes_gcm_enc_128_kernel,%function
.align 4
unroll8_eor3_aes_gcm_enc_128_kernel:
 cbz x1, .L128_enc_ret
 stp d8, d9, [sp, #-80]!
 lsr x9, x1, #3
 mov x16, x4
 mov x8, x5
 stp d10, d11, [sp, #16]
 stp d12, d13, [sp, #32]
 stp d14, d15, [sp, #48]
 mov x5, #0xc200000000000000
 stp x5, xzr, [sp, #64]
 add x10, sp, #64
 mov x15, #0x100000000
 movi v31.16b, #0x0
 mov v31.d[1], x15
 mov x5, x9
 ld1 { v0.16b}, [x16]
 sub x5, x5, #1
 and x5, x5, #0xffffffffffffff80
 rev32 v30.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q26, q27, [x8, #0]
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v7.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 ldp q28, q26, [x8, #32]
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ldp q27, q28, [x8, #64]
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 ldp q26, q27, [x8, #96]
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 ldp q28, q26, [x8, #128]
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ld1 { v19.16b}, [x3]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 ldr q27, [x8, #160]
 aese v3.16b, v26.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aese v4.16b, v26.16b
 add x5, x5, x0
 aese v0.16b, v26.16b
 aese v7.16b, v26.16b
 aese v5.16b, v26.16b
 aese v1.16b, v26.16b
 add x4, x0, x1, lsr #3
 cmp x0, x5
 b.ge .L128_enc_tail
 ldp q8, q9, [x0], #32
 ldp q10, q11, [x0], #32
 ldp q12, q13, [x0], #32
 ldp q14, q15, [x0], #32
 cmp x0, x5
.inst 0xce006d08
 rev32 v0.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce016d29
 stp q8, q9, [x2], #32
 rev32 v1.16b, v30.16b
.inst 0xce056dad
 add v30.4s, v30.4s, v31.4s
.inst 0xce026d4a
.inst 0xce066dce
.inst 0xce046d8c
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce036d6b
.inst 0xce076def
 stp q10, q11, [x2], #32
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 stp q12, q13, [x2], #32
 stp q14, q15, [x2], #32
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 b.ge .L128_enc_prepretail
.L128_enc_main_loop:
 rev32 v5.16b, v30.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 add v30.4s, v30.4s, v31.4s
 rev64 v9.16b, v9.16b
 rev64 v8.16b, v8.16b
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ext v19.16b, v19.16b, v19.16b, #8
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 rev64 v13.16b, v13.16b
 rev64 v11.16b, v11.16b
 ldp q26, q27, [x8, #0]
 eor v8.16b, v8.16b, v19.16b
 rev32 v7.16b, v30.16b
 rev64 v15.16b, v15.16b
 pmull2 v16.1q, v9.2d, v23.2d
 rev64 v10.16b, v10.16b
 pmull2 v17.1q, v8.2d, v25.2d
 pmull v23.1q, v9.1d, v23.1d
 trn1 v18.2d, v9.2d, v8.2d
 pmull v19.1q, v8.1d, v25.1d
 trn2 v8.2d, v9.2d, v8.2d
 pmull2 v29.1q, v10.2d, v22.2d
 pmull2 v9.1q, v11.2d, v20.2d
 eor v19.16b, v19.16b, v23.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 eor v17.16b, v17.16b, v16.16b
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v8.16b, v8.16b, v18.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull v22.1q, v10.1d, v22.1d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
.inst 0xce1d2631
 trn1 v29.2d, v11.2d, v10.2d
 trn2 v10.2d, v11.2d, v10.2d
 ldp q28, q26, [x8, #32]
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v20.1q, v11.1d, v20.1d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 pmull2 v18.1q, v8.2d, v24.2d
 eor v10.16b, v10.16b, v29.16b
 pmull v24.1q, v8.1d, v24.1d
 rev64 v14.16b, v14.16b
.inst 0xce165273
 pmull2 v29.1q, v10.2d, v21.2d
 eor v18.16b, v18.16b, v24.16b
 pmull v21.1q, v10.1d, v21.1d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
.inst 0xce157652
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 rev64 v12.16b, v12.16b
 ldp q27, q28, [x8, #64]
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v25.1q, v12.1d, v25.1d
 trn1 v16.2d, v13.2d, v12.2d
 trn2 v12.2d, v13.2d, v12.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 pmull2 v10.1q, v13.2d, v23.2d
 eor v12.16b, v12.16b, v16.16b
 pmull v23.1q, v13.1d, v23.1d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ldp q26, q27, [x8, #96]
 trn1 v13.2d, v15.2d, v14.2d
 pmull2 v16.1q, v12.2d, v24.2d
 pmull v24.1q, v12.1d, v24.1d
 pmull2 v11.1q, v14.2d, v22.2d
 pmull2 v12.1q, v15.2d, v20.2d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 pmull v22.1q, v14.1d, v22.1d
.inst 0xce082a31
 trn2 v14.2d, v15.2d, v14.2d
.inst 0xce195e73
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 eor v14.16b, v14.16b, v13.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
.inst 0xce184252
 ldr d16, [x10]
 pmull v20.1q, v15.1d, v20.1d
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull2 v13.1q, v14.2d, v21.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 pmull v21.1q, v14.1d, v21.1d
.inst 0xce165273
 ldp q8, q9, [x0], #32
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 rev32 v20.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
.inst 0xce153652
 ldp q28, q26, [x8, #128]
.inst 0xce0b3231
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 ldp q10, q11, [x0], #32
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 pmull v21.1q, v17.1d, v16.1d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 rev32 v22.16b, v30.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 ldp q12, q13, [x0], #32
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce114e52
 ldr q27, [x8, #160]
 ext v29.16b, v17.16b, v17.16b, #8
 rev32 v23.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
.inst 0xce1d5652
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aese v4.16b, v26.16b
 aese v1.16b, v26.16b
 ldp q14, q15, [x0], #32
 rev32 v25.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 cmp x0, x5
.inst 0xce046d8c
 aese v7.16b, v26.16b
 aese v6.16b, v26.16b
 aese v3.16b, v26.16b
.inst 0xce026d4a
 mov v2.16b, v23.16b
 aese v0.16b, v26.16b
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce076def
 aese v5.16b, v26.16b
 pmull v17.1q, v18.1d, v16.1d
.inst 0xce016d29
.inst 0xce036d6b
 mov v3.16b, v25.16b
 ext v21.16b, v18.16b, v18.16b, #8
.inst 0xce056dad
 mov v1.16b, v22.16b
.inst 0xce006d08
 mov v0.16b, v20.16b
 stp q8, q9, [x2], #32
 stp q10, q11, [x2], #32
.inst 0xce066dce
 stp q12, q13, [x2], #32
.inst 0xce115673
 stp q14, q15, [x2], #32
 b.lt .L128_enc_main_loop
.L128_enc_prepretail:
 rev32 v5.16b, v30.16b
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 ext v19.16b, v19.16b, v19.16b, #8
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 rev64 v8.16b, v8.16b
 rev64 v9.16b, v9.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 add v30.4s, v30.4s, v31.4s
 rev64 v11.16b, v11.16b
 rev64 v10.16b, v10.16b
 eor v8.16b, v8.16b, v19.16b
 rev32 v6.16b, v30.16b
 pmull2 v16.1q, v9.2d, v23.2d
 pmull v19.1q, v8.1d, v25.1d
 pmull2 v17.1q, v8.2d, v25.2d
 rev64 v13.16b, v13.16b
 trn1 v18.2d, v9.2d, v8.2d
 pmull v23.1q, v9.1d, v23.1d
 eor v17.16b, v17.16b, v16.16b
 trn2 v8.2d, v9.2d, v8.2d
 eor v19.16b, v19.16b, v23.16b
 eor v8.16b, v8.16b, v18.16b
 ldp q26, q27, [x8, #0]
 add v30.4s, v30.4s, v31.4s
 pmull2 v18.1q, v8.2d, v24.2d
 pmull v24.1q, v8.1d, v24.1d
 rev64 v12.16b, v12.16b
 rev64 v15.16b, v15.16b
 eor v18.16b, v18.16b, v24.16b
 rev32 v7.16b, v30.16b
 rev64 v14.16b, v14.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 pmull2 v9.1q, v11.2d, v20.2d
 pmull2 v29.1q, v10.2d, v22.2d
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull v22.1q, v10.1d, v22.1d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
.inst 0xce1d2631
 trn1 v29.2d, v11.2d, v10.2d
 trn2 v10.2d, v11.2d, v10.2d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 eor v10.16b, v10.16b, v29.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v20.1q, v11.1d, v20.1d
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 ldp q28, q26, [x8, #32]
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 pmull2 v29.1q, v10.2d, v21.2d
.inst 0xce165273
 pmull v21.1q, v10.1d, v21.1d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
.inst 0xce157652
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 ldp q27, q28, [x8, #64]
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 trn1 v16.2d, v13.2d, v12.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 pmull2 v8.1q, v12.2d, v25.2d
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 pmull2 v10.1q, v13.2d, v23.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 add v30.4s, v30.4s, v31.4s
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v12.16b, v12.16b, v16.16b
 pmull v23.1q, v13.1d, v23.1d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull2 v11.1q, v14.2d, v22.2d
 trn1 v13.2d, v15.2d, v14.2d
 pmull v22.1q, v14.1d, v22.1d
 trn2 v14.2d, v15.2d, v14.2d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
.inst 0xce082a31
.inst 0xce195e73
 eor v14.16b, v14.16b, v13.16b
 pmull2 v16.1q, v12.2d, v24.2d
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 pmull v24.1q, v12.1d, v24.1d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 pmull2 v12.1q, v15.2d, v20.2d
 ldp q26, q27, [x8, #96]
 pmull v20.1q, v15.1d, v20.1d
.inst 0xce184252
 pmull2 v13.1q, v14.2d, v21.2d
 pmull v21.1q, v14.1d, v21.1d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 ldr d16, [x10]
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce0b3231
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
.inst 0xce165273
.inst 0xce153652
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull v21.1q, v17.1d, v16.1d
.inst 0xce114e52
 ldp q28, q26, [x8, #128]
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 ext v29.16b, v17.16b, v17.16b, #8
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
.inst 0xce1d5652
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull v17.1q, v18.1d, v16.1d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 ext v18.16b, v18.16b, v18.16b, #8
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
.inst 0xce114a73
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 ldr q27, [x8, #160]
 aese v6.16b, v26.16b
 aese v2.16b, v26.16b
 aese v0.16b, v26.16b
 aese v1.16b, v26.16b
 aese v3.16b, v26.16b
 aese v5.16b, v26.16b
 aese v4.16b, v26.16b
 aese v7.16b, v26.16b
.L128_enc_tail:
 sub x5, x4, x0
 ldr q8, [x0], #16
 mov v29.16b, v27.16b
 ldp q20, q21, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
.inst 0xce007509
 ext v16.16b, v19.16b, v19.16b, #8
 ldp q22, q23, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 ext v23.16b, v23.16b, v23.16b, #8
 ldp q24, q25, [x3, #192]
 ext v25.16b, v25.16b, v25.16b, #8
 cmp x5, #112
 b.gt .L128_enc_blocks_more_than_7
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 movi v17.8b, #0
 cmp x5, #96
 sub v30.4s, v30.4s, v31.4s
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v2.16b
 mov v2.16b, v1.16b
 movi v19.8b, #0
 movi v18.8b, #0
 b.gt .L128_enc_blocks_more_than_6
 mov v7.16b, v6.16b
 cmp x5, #80
 sub v30.4s, v30.4s, v31.4s
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v1.16b
 b.gt .L128_enc_blocks_more_than_5
 cmp x5, #64
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v1.16b
 b.gt .L128_enc_blocks_more_than_4
 mov v7.16b, v6.16b
 sub v30.4s, v30.4s, v31.4s
 mov v6.16b, v5.16b
 mov v5.16b, v1.16b
 cmp x5, #48
 b.gt .L128_enc_blocks_more_than_3
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 mov v6.16b, v1.16b
 cmp x5, #32
 ldr q24, [x3, #96]
 b.gt .L128_enc_blocks_more_than_2
 cmp x5, #16
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v1.16b
 b.gt .L128_enc_blocks_more_than_1
 ldr q21, [x3, #48]
 sub v30.4s, v30.4s, v31.4s
 b .L128_enc_blocks_less_than_1
.L128_enc_blocks_more_than_7:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull2 v17.1q, v8.2d, v25.2d
 ins v18.d[0], v24.d[1]
 eor v27.8b, v27.8b, v8.8b
 movi v16.8b, #0
.inst 0xce017529
 pmull v18.1q, v27.1d, v18.1d
 pmull v19.1q, v8.1d, v25.1d
.L128_enc_blocks_more_than_6:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
.inst 0xce027529
 pmull v26.1q, v8.1d, v23.1d
 eor v27.8b, v27.8b, v8.8b
 movi v16.8b, #0
 pmull v27.1q, v27.1d, v24.1d
 pmull2 v28.1q, v8.2d, v23.2d
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L128_enc_blocks_more_than_5:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 pmull2 v28.1q, v8.2d, v22.2d
 eor v17.16b, v17.16b, v28.16b
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
.inst 0xce037529
 pmull v26.1q, v8.1d, v22.1d
 movi v16.8b, #0
 pmull2 v27.1q, v27.2d, v21.2d
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
.L128_enc_blocks_more_than_4:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 movi v16.8b, #0
 pmull2 v28.1q, v8.2d, v20.2d
 eor v27.8b, v27.8b, v8.8b
 pmull v26.1q, v8.1d, v20.1d
 eor v17.16b, v17.16b, v28.16b
 pmull v27.1q, v27.1d, v21.1d
 eor v19.16b, v19.16b, v26.16b
.inst 0xce047529
 eor v18.16b, v18.16b, v27.16b
.L128_enc_blocks_more_than_3:
 st1 { v9.16b}, [x2], #16
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ins v27.d[0], v8.d[1]
 ldr q24, [x3, #96]
 pmull v26.1q, v8.1d, v25.1d
 ldr q9, [x0], #16
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 eor v19.16b, v19.16b, v26.16b
.inst 0xce057529
 pmull2 v27.1q, v27.2d, v24.2d
 pmull2 v28.1q, v8.2d, v25.2d
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L128_enc_blocks_more_than_2:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 ins v27.d[0], v8.d[1]
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 movi v16.8b, #0
 eor v27.8b, v27.8b, v8.8b
.inst 0xce067529
 pmull2 v28.1q, v8.2d, v23.2d
 pmull v26.1q, v8.1d, v23.1d
 pmull v27.1q, v27.1d, v24.1d
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
 eor v19.16b, v19.16b, v26.16b
.L128_enc_blocks_more_than_1:
 st1 { v9.16b}, [x2], #16
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ins v27.d[0], v8.d[1]
.inst 0xce077529
 pmull2 v28.1q, v8.2d, v22.2d
 eor v27.8b, v27.8b, v8.8b
 ldr q21, [x3, #48]
 ins v27.d[1], v27.d[0]
 pmull v26.1q, v8.1d, v22.1d
 pmull2 v27.1q, v27.2d, v21.2d
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
 eor v19.16b, v19.16b, v26.16b
.L128_enc_blocks_less_than_1:
 rev32 v30.16b, v30.16b
 str q30, [x16]
 and x1, x1, #127
 sub x1, x1, #128
 neg x1, x1
 mvn x6, xzr
 ld1 { v26.16b}, [x2]
 and x1, x1, #127
 lsr x6, x6, x1
 mvn x7, xzr
 cmp x1, #64
 csel x13, x7, x6, lt
 csel x14, x6, xzr, lt
 mov v0.d[1], x14
 mov v0.d[0], x13
 and v9.16b, v9.16b, v0.16b
 rev64 v8.16b, v9.16b
 bif v9.16b, v26.16b, v0.16b
 st1 { v9.16b}, [x2]
 eor v8.16b, v8.16b, v16.16b
 ins v16.d[0], v8.d[1]
 eor v16.8b, v16.8b, v8.8b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 pmull v16.1q, v16.1d, v21.1d
 pmull2 v28.1q, v8.2d, v20.2d
 eor v18.16b, v18.16b, v16.16b
 ldr d16, [x10]
 pmull v26.1q, v8.1d, v20.1d
 eor v17.16b, v17.16b, v28.16b
 eor v19.16b, v19.16b, v26.16b
 ext v21.16b, v17.16b, v17.16b, #8
 pmull v29.1q, v17.1d, v16.1d
.inst 0xce114e52
.inst 0xce1d5652
 pmull v17.1q, v18.1d, v16.1d
 ext v21.16b, v18.16b, v18.16b, #8
.inst 0xce115673
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 st1 { v19.16b }, [x3]
 mov x0, x9
 ldp d10, d11, [sp, #16]
 ldp d12, d13, [sp, #32]
 ldp d14, d15, [sp, #48]
 ldp d8, d9, [sp], #80
 ret
.L128_enc_ret:
 mov w0, #0x0
 ret
.size unroll8_eor3_aes_gcm_enc_128_kernel,.-unroll8_eor3_aes_gcm_enc_128_kernel
.globl unroll8_eor3_aes_gcm_dec_128_kernel
.type unroll8_eor3_aes_gcm_dec_128_kernel,%function
.align 4
unroll8_eor3_aes_gcm_dec_128_kernel:
 cbz x1, .L128_dec_ret
 stp d8, d9, [sp, #-80]!
 lsr x9, x1, #3
 mov x16, x4
 mov x8, x5
 stp d10, d11, [sp, #16]
 stp d12, d13, [sp, #32]
 stp d14, d15, [sp, #48]
 mov x5, #0xc200000000000000
 stp x5, xzr, [sp, #64]
 add x10, sp, #64
 mov x5, x9
 ld1 { v0.16b}, [x16]
 ldp q26, q27, [x8, #0]
 sub x5, x5, #1
 mov x15, #0x100000000
 movi v31.16b, #0x0
 mov v31.d[1], x15
 ld1 { v19.16b}, [x3]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 rev32 v30.16b, v0.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 and x5, x5, #0xffffffffffffff80
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 rev32 v7.16b, v30.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q28, q26, [x8, #32]
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ldp q27, q28, [x8, #64]
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ldp q26, q27, [x8, #96]
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldp q28, q26, [x8, #128]
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 add x5, x5, x0
 add v30.4s, v30.4s, v31.4s
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v26.16b
 aese v1.16b, v26.16b
 aese v6.16b, v26.16b
 ldr q27, [x8, #160]
 aese v4.16b, v26.16b
 aese v3.16b, v26.16b
 aese v2.16b, v26.16b
 aese v5.16b, v26.16b
 aese v7.16b, v26.16b
 add x4, x0, x1, lsr #3
 cmp x0, x5
 b.ge .L128_dec_tail
 ldp q8, q9, [x0], #32
.inst 0xce006d00
.inst 0xce016d21
 stp q0, q1, [x2], #32
 rev32 v0.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q10, q11, [x0], #32
 ldp q12, q13, [x0], #32
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q14, q15, [x0], #32
.inst 0xce036d63
.inst 0xce026d42
 stp q2, q3, [x2], #32
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce066dc6
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce046d84
.inst 0xce056da5
 stp q4, q5, [x2], #32
.inst 0xce076de7
 stp q6, q7, [x2], #32
 rev32 v4.16b, v30.16b
 cmp x0, x5
 add v30.4s, v30.4s, v31.4s
 b.ge .L128_dec_prepretail
.L128_dec_main_loop:
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v9.16b, v9.16b
 rev64 v8.16b, v8.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v14.16b, v14.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v8.16b, v8.16b, v19.16b
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev64 v10.16b, v10.16b
 rev64 v12.16b, v12.16b
 ldp q26, q27, [x8, #0]
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 pmull2 v16.1q, v9.2d, v23.2d
 pmull2 v17.1q, v8.2d, v25.2d
 rev64 v11.16b, v11.16b
 rev32 v7.16b, v30.16b
 trn1 v18.2d, v9.2d, v8.2d
 rev64 v13.16b, v13.16b
 pmull v23.1q, v9.1d, v23.1d
 pmull v19.1q, v8.1d, v25.1d
 trn2 v8.2d, v9.2d, v8.2d
 pmull2 v29.1q, v10.2d, v22.2d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull2 v9.1q, v11.2d, v20.2d
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v17.16b, v17.16b, v16.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v8.16b, v8.16b, v18.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 eor v19.16b, v19.16b, v23.16b
.inst 0xce1d2631
 ldp q28, q26, [x8, #32]
 trn1 v29.2d, v11.2d, v10.2d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull v22.1q, v10.1d, v22.1d
 trn2 v10.2d, v11.2d, v10.2d
 pmull2 v18.1q, v8.2d, v24.2d
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 pmull v24.1q, v8.1d, v24.1d
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 pmull v20.1q, v11.1d, v20.1d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
.inst 0xce165273
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 eor v10.16b, v10.16b, v29.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v18.16b, v18.16b, v24.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 trn1 v16.2d, v13.2d, v12.2d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 pmull2 v29.1q, v10.2d, v21.2d
 pmull v21.1q, v10.1d, v21.1d
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 rev64 v15.16b, v15.16b
 pmull2 v8.1q, v12.2d, v25.2d
 ldp q27, q28, [x8, #64]
 pmull v25.1q, v12.1d, v25.1d
.inst 0xce157652
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 trn2 v12.2d, v13.2d, v12.2d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull2 v10.1q, v13.2d, v23.2d
 pmull v23.1q, v13.1d, v23.1d
 pmull2 v11.1q, v14.2d, v22.2d
 pmull v22.1q, v14.1d, v22.1d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 eor v12.16b, v12.16b, v16.16b
 trn1 v13.2d, v15.2d, v14.2d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 trn2 v14.2d, v15.2d, v14.2d
 ldp q26, q27, [x8, #96]
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull2 v16.1q, v12.2d, v24.2d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 eor v14.16b, v14.16b, v13.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull v24.1q, v12.1d, v24.1d
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 pmull2 v12.1q, v15.2d, v20.2d
.inst 0xce184252
.inst 0xce195e73
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
.inst 0xce082a31
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 pmull2 v13.1q, v14.2d, v21.2d
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull v20.1q, v15.1d, v20.1d
 pmull v21.1q, v14.1d, v21.1d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce0b3231
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ldp q28, q26, [x8, #128]
 ldr d16, [x10]
.inst 0xce165273
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 rev32 v20.16b, v30.16b
.inst 0xce153652
 add v30.4s, v30.4s, v31.4s
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 rev32 v22.16b, v30.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 ext v21.16b, v17.16b, v17.16b, #8
 pmull v29.1q, v17.1d, v16.1d
.inst 0xce114e52
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 ldp q8, q9, [x0], #32
 ldp q10, q11, [x0], #32
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 rev32 v23.16b, v30.16b
 ldp q12, q13, [x0], #32
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce1d5652
 ldp q14, q15, [x0], #32
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 add v30.4s, v30.4s, v31.4s
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v26.16b
 aese v1.16b, v26.16b
 ldr q27, [x8, #160]
 aese v6.16b, v26.16b
 pmull v17.1q, v18.1d, v16.1d
 aese v2.16b, v26.16b
 aese v7.16b, v26.16b
 aese v4.16b, v26.16b
 ext v21.16b, v18.16b, v18.16b, #8
 rev32 v25.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v26.16b
 aese v5.16b, v26.16b
.inst 0xce016d21
.inst 0xce006d00
.inst 0xce076de7
.inst 0xce066dc6
.inst 0xce026d42
 stp q0, q1, [x2], #32
 mov v1.16b, v22.16b
.inst 0xce046d84
.inst 0xce115673
 mov v0.16b, v20.16b
.inst 0xce036d63
 cmp x0, x5
 stp q2, q3, [x2], #32
.inst 0xce056da5
 mov v2.16b, v23.16b
 stp q4, q5, [x2], #32
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 stp q6, q7, [x2], #32
 mov v3.16b, v25.16b
 b.lt .L128_dec_main_loop
.L128_dec_prepretail:
 rev64 v11.16b, v11.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v8.16b, v8.16b
 rev64 v10.16b, v10.16b
 rev32 v5.16b, v30.16b
 ldp q26, q27, [x8, #0]
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 eor v8.16b, v8.16b, v19.16b
 rev64 v9.16b, v9.16b
 add v30.4s, v30.4s, v31.4s
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 rev64 v13.16b, v13.16b
 rev64 v12.16b, v12.16b
 rev64 v14.16b, v14.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 pmull2 v16.1q, v9.2d, v23.2d
 pmull v19.1q, v8.1d, v25.1d
 pmull2 v17.1q, v8.2d, v25.2d
 trn1 v18.2d, v9.2d, v8.2d
 trn2 v8.2d, v9.2d, v8.2d
 pmull2 v29.1q, v10.2d, v22.2d
 pmull v23.1q, v9.1d, v23.1d
 pmull2 v9.1q, v11.2d, v20.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v17.16b, v17.16b, v16.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 eor v8.16b, v8.16b, v18.16b
 pmull v22.1q, v10.1d, v22.1d
 rev32 v7.16b, v30.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
.inst 0xce1d2631
 trn1 v29.2d, v11.2d, v10.2d
 trn2 v10.2d, v11.2d, v10.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull2 v18.1q, v8.2d, v24.2d
 pmull v24.1q, v8.1d, v24.1d
 pmull v20.1q, v11.1d, v20.1d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 eor v19.16b, v19.16b, v23.16b
 eor v10.16b, v10.16b, v29.16b
 eor v18.16b, v18.16b, v24.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldp q28, q26, [x8, #32]
.inst 0xce165273
 pmull2 v29.1q, v10.2d, v21.2d
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 pmull v21.1q, v10.1d, v21.1d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
.inst 0xce157652
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 trn1 v16.2d, v13.2d, v12.2d
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 ldp q27, q28, [x8, #64]
 rev64 v15.16b, v15.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 pmull2 v10.1q, v13.2d, v23.2d
 pmull v23.1q, v13.1d, v23.1d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 trn1 v13.2d, v15.2d, v14.2d
 pmull2 v11.1q, v14.2d, v22.2d
 pmull v22.1q, v14.1d, v22.1d
 trn2 v14.2d, v15.2d, v14.2d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 eor v12.16b, v12.16b, v16.16b
.inst 0xce082a31
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 eor v14.16b, v14.16b, v13.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 pmull2 v16.1q, v12.2d, v24.2d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v24.1q, v12.1d, v24.1d
 pmull2 v12.1q, v15.2d, v20.2d
 pmull2 v13.1q, v14.2d, v21.2d
 pmull v21.1q, v14.1d, v21.1d
 ldp q26, q27, [x8, #96]
.inst 0xce184252
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ldr d16, [x10]
 pmull v20.1q, v15.1d, v20.1d
.inst 0xce195e73
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
.inst 0xce153652
.inst 0xce165273
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
.inst 0xce0b3231
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
.inst 0xce114e52
 ldp q28, q26, [x8, #128]
 pmull v29.1q, v17.1d, v16.1d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 ext v21.16b, v17.16b, v17.16b, #8
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
.inst 0xce1d5652
 ldr q27, [x8, #160]
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull v17.1q, v18.1d, v16.1d
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ext v21.16b, v18.16b, v18.16b, #8
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce115673
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v26.16b
 aese v3.16b, v26.16b
 aese v5.16b, v26.16b
 aese v0.16b, v26.16b
 aese v4.16b, v26.16b
 aese v1.16b, v26.16b
 aese v7.16b, v26.16b
.L128_dec_tail:
 mov v29.16b, v27.16b
 sub x5, x4, x0
 cmp x5, #112
 ldp q24, q25, [x3, #192]
 ext v25.16b, v25.16b, v25.16b, #8
 ldr q9, [x0], #16
 ldp q20, q21, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ext v16.16b, v19.16b, v19.16b, #8
 ldp q22, q23, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 ext v23.16b, v23.16b, v23.16b, #8
.inst 0xce00752c
 b.gt .L128_dec_blocks_more_than_7
 cmp x5, #96
 mov v7.16b, v6.16b
 movi v19.8b, #0
 movi v17.8b, #0
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v2.16b
 mov v2.16b, v1.16b
 movi v18.8b, #0
 sub v30.4s, v30.4s, v31.4s
 b.gt .L128_dec_blocks_more_than_6
 cmp x5, #80
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v1.16b
 b.gt .L128_dec_blocks_more_than_5
 cmp x5, #64
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 b.gt .L128_dec_blocks_more_than_4
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v1.16b
 cmp x5, #48
 b.gt .L128_dec_blocks_more_than_3
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 cmp x5, #32
 ldr q24, [x3, #96]
 mov v6.16b, v1.16b
 b.gt .L128_dec_blocks_more_than_2
 cmp x5, #16
 mov v7.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 b.gt .L128_dec_blocks_more_than_1
 sub v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #48]
 b .L128_dec_blocks_less_than_1
.L128_dec_blocks_more_than_7:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v18.d[0], v24.d[1]
 pmull v19.1q, v8.1d, v25.1d
 ins v27.d[0], v8.d[1]
 movi v16.8b, #0
 ldr q9, [x0], #16
 eor v27.8b, v27.8b, v8.8b
 pmull2 v17.1q, v8.2d, v25.2d
 st1 { v12.16b}, [x2], #16
.inst 0xce01752c
 pmull v18.1q, v27.1d, v18.1d
.L128_dec_blocks_more_than_6:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 eor v27.8b, v27.8b, v8.8b
 pmull v26.1q, v8.1d, v23.1d
 ldr q9, [x0], #16
 movi v16.8b, #0
 pmull v27.1q, v27.1d, v24.1d
 st1 { v12.16b}, [x2], #16
 pmull2 v28.1q, v8.2d, v23.2d
 eor v19.16b, v19.16b, v26.16b
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
.inst 0xce02752c
.L128_dec_blocks_more_than_5:
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 st1 { v12.16b}, [x2], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
.inst 0xce03752c
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 pmull v26.1q, v8.1d, v22.1d
 movi v16.8b, #0
 pmull2 v27.1q, v27.2d, v21.2d
 pmull2 v28.1q, v8.2d, v22.2d
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L128_dec_blocks_more_than_4:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 ins v27.d[0], v8.d[1]
 movi v16.8b, #0
 pmull2 v28.1q, v8.2d, v20.2d
 pmull v26.1q, v8.1d, v20.1d
 eor v17.16b, v17.16b, v28.16b
 st1 { v12.16b}, [x2], #16
 eor v27.8b, v27.8b, v8.8b
.inst 0xce04752c
 eor v19.16b, v19.16b, v26.16b
 pmull v27.1q, v27.1d, v21.1d
 eor v18.16b, v18.16b, v27.16b
.L128_dec_blocks_more_than_3:
 st1 { v12.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 ldr q24, [x3, #96]
 eor v27.8b, v27.8b, v8.8b
 ldr q9, [x0], #16
 ins v27.d[1], v27.d[0]
 pmull v26.1q, v8.1d, v25.1d
 pmull2 v28.1q, v8.2d, v25.2d
 movi v16.8b, #0
.inst 0xce05752c
 eor v19.16b, v19.16b, v26.16b
 pmull2 v27.1q, v27.2d, v24.2d
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
.L128_dec_blocks_more_than_2:
 rev64 v8.16b, v9.16b
 st1 { v12.16b}, [x2], #16
 eor v8.16b, v8.16b, v16.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 movi v16.8b, #0
 ins v27.d[0], v8.d[1]
 eor v27.8b, v27.8b, v8.8b
 pmull v26.1q, v8.1d, v23.1d
 pmull2 v28.1q, v8.2d, v23.2d
 pmull v27.1q, v27.1d, v24.1d
 ldr q9, [x0], #16
 eor v18.16b, v18.16b, v27.16b
 eor v19.16b, v19.16b, v26.16b
.inst 0xce06752c
 eor v17.16b, v17.16b, v28.16b
.L128_dec_blocks_more_than_1:
 st1 { v12.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 pmull2 v28.1q, v8.2d, v22.2d
 eor v27.8b, v27.8b, v8.8b
 eor v17.16b, v17.16b, v28.16b
 ldr q21, [x3, #48]
 ins v27.d[1], v27.d[0]
.inst 0xce07752c
 pmull v26.1q, v8.1d, v22.1d
 pmull2 v27.1q, v27.2d, v21.2d
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
.L128_dec_blocks_less_than_1:
 and x1, x1, #127
 sub x1, x1, #128
 neg x1, x1
 mvn x6, xzr
 and x1, x1, #127
 lsr x6, x6, x1
 cmp x1, #64
 mvn x7, xzr
 csel x13, x7, x6, lt
 csel x14, x6, xzr, lt
 mov v0.d[1], x14
 mov v0.d[0], x13
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ld1 { v26.16b}, [x2]
 and v9.16b, v9.16b, v0.16b
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 pmull2 v28.1q, v8.2d, v20.2d
 ins v16.d[0], v8.d[1]
 eor v17.16b, v17.16b, v28.16b
 eor v16.8b, v16.8b, v8.8b
 bif v12.16b, v26.16b, v0.16b
 pmull v16.1q, v16.1d, v21.1d
 st1 { v12.16b}, [x2]
 pmull v26.1q, v8.1d, v20.1d
 eor v18.16b, v18.16b, v16.16b
 ldr d16, [x10]
 eor v19.16b, v19.16b, v26.16b
 eor v14.16b, v17.16b, v19.16b
 pmull v21.1q, v17.1d, v16.1d
 ext v17.16b, v17.16b, v17.16b, #8
 eor v18.16b, v18.16b, v14.16b
.inst 0xce115652
 pmull v17.1q, v18.1d, v16.1d
 ext v18.16b, v18.16b, v18.16b, #8
.inst 0xce124673
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 st1 { v19.16b }, [x3]
 rev32 v30.16b, v30.16b
 str q30, [x16]
 mov x0, x9
 ldp d10, d11, [sp, #16]
 ldp d12, d13, [sp, #32]
 ldp d14, d15, [sp, #48]
 ldp d8, d9, [sp], #80
 ret
.L128_dec_ret:
 mov w0, #0x0
 ret
.size unroll8_eor3_aes_gcm_dec_128_kernel,.-unroll8_eor3_aes_gcm_dec_128_kernel
.globl unroll8_eor3_aes_gcm_enc_192_kernel
.type unroll8_eor3_aes_gcm_enc_192_kernel,%function
.align 4
unroll8_eor3_aes_gcm_enc_192_kernel:
 cbz x1, .L192_enc_ret
 stp d8, d9, [sp, #-80]!
 lsr x9, x1, #3
 mov x16, x4
 mov x8, x5
 stp d10, d11, [sp, #16]
 stp d12, d13, [sp, #32]
 stp d14, d15, [sp, #48]
 mov x5, #0xc200000000000000
 stp x5, xzr, [sp, #64]
 add x10, sp, #64
 mov x5, x9
 ld1 { v0.16b}, [x16]
 mov x15, #0x100000000
 movi v31.16b, #0x0
 mov v31.d[1], x15
 rev32 v30.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 sub x5, x5, #1
 and x5, x5, #0xffffffffffffff80
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q26, q27, [x8, #0]
 add x5, x5, x0
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v7.16b, v30.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ldp q28, q26, [x8, #32]
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ldp q27, q28, [x8, #64]
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 ldp q26, q27, [x8, #96]
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 add v30.4s, v30.4s, v31.4s
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q28, q26, [x8, #128]
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 add x4, x0, x1, lsr #3
 cmp x0, x5
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ld1 { v19.16b}, [x3]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 ldp q27, q28, [x8, #160]
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v28.16b
 aese v3.16b, v28.16b
 aese v4.16b, v28.16b
 aese v7.16b, v28.16b
 ldr q26, [x8, #192]
 aese v1.16b, v28.16b
 aese v5.16b, v28.16b
 aese v2.16b, v28.16b
 aese v0.16b, v28.16b
 b.ge .L192_enc_tail
 ldp q8, q9, [x0], #32
 ldp q10, q11, [x0], #32
 ldp q12, q13, [x0], #32
 ldp q14, q15, [x0], #32
.inst 0xce006908
 rev32 v0.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce03696b
.inst 0xce016929
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce04698c
.inst 0xce0569ad
.inst 0xce0769ef
 stp q8, q9, [x2], #32
.inst 0xce02694a
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 stp q10, q11, [x2], #32
 cmp x0, x5
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce0669ce
 stp q12, q13, [x2], #32
 rev32 v4.16b, v30.16b
 stp q14, q15, [x2], #32
 add v30.4s, v30.4s, v31.4s
 b.ge .L192_enc_prepretail
.L192_enc_main_loop:
 rev64 v12.16b, v12.16b
 ldp q26, q27, [x8, #0]
 rev64 v10.16b, v10.16b
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v8.16b, v8.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 rev64 v9.16b, v9.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 eor v8.16b, v8.16b, v19.16b
 rev64 v11.16b, v11.16b
 rev64 v13.16b, v13.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 rev32 v7.16b, v30.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 ldp q28, q26, [x8, #32]
 pmull2 v17.1q, v8.2d, v25.2d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 pmull2 v16.1q, v9.2d, v23.2d
 pmull v23.1q, v9.1d, v23.1d
 trn1 v18.2d, v9.2d, v8.2d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 pmull2 v29.1q, v10.2d, v22.2d
 pmull v19.1q, v8.1d, v25.1d
 trn2 v8.2d, v9.2d, v8.2d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 eor v17.16b, v17.16b, v16.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull2 v9.1q, v11.2d, v20.2d
 eor v8.16b, v8.16b, v18.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
.inst 0xce1d2631
 pmull v22.1q, v10.1d, v22.1d
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 trn1 v29.2d, v11.2d, v10.2d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 trn2 v10.2d, v11.2d, v10.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ldp q27, q28, [x8, #64]
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v19.16b, v19.16b, v23.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 pmull2 v18.1q, v8.2d, v24.2d
 pmull v24.1q, v8.1d, v24.1d
 pmull v20.1q, v11.1d, v20.1d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 eor v10.16b, v10.16b, v29.16b
 trn1 v16.2d, v13.2d, v12.2d
 eor v18.16b, v18.16b, v24.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
.inst 0xce165273
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull2 v29.1q, v10.2d, v21.2d
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 pmull v21.1q, v10.1d, v21.1d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
.inst 0xce157652
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 ldp q26, q27, [x8, #96]
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 rev64 v15.16b, v15.16b
 rev64 v14.16b, v14.16b
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v25.1q, v12.1d, v25.1d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 trn2 v12.2d, v13.2d, v12.2d
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull2 v10.1q, v13.2d, v23.2d
 eor v12.16b, v12.16b, v16.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull v23.1q, v13.1d, v23.1d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 trn1 v13.2d, v15.2d, v14.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull2 v11.1q, v14.2d, v22.2d
 pmull v22.1q, v14.1d, v22.1d
 trn2 v14.2d, v15.2d, v14.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 eor v14.16b, v14.16b, v13.16b
 pmull2 v16.1q, v12.2d, v24.2d
 ldp q28, q26, [x8, #128]
 pmull v24.1q, v12.1d, v24.1d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 pmull2 v12.1q, v15.2d, v20.2d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
.inst 0xce184252
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 add v30.4s, v30.4s, v31.4s
 ldr d16, [x10]
.inst 0xce082a31
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 pmull2 v13.1q, v14.2d, v21.2d
 pmull v20.1q, v15.1d, v20.1d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
.inst 0xce195e73
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 pmull v21.1q, v14.1d, v21.1d
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 ldp q27, q28, [x8, #160]
.inst 0xce165273
 rev32 v20.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
.inst 0xce153652
.inst 0xce0b3231
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ldp q8, q9, [x0], #32
 pmull v21.1q, v17.1d, v16.1d
 rev32 v22.16b, v30.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
.inst 0xce114e52
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 ldr q26, [x8, #192]
 ext v29.16b, v17.16b, v17.16b, #8
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 ldp q10, q11, [x0], #32
 aese v4.16b, v28.16b
.inst 0xce1d5652
 ldp q12, q13, [x0], #32
 ldp q14, q15, [x0], #32
 aese v2.16b, v28.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 rev32 v23.16b, v30.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v17.1q, v18.1d, v16.1d
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 add v30.4s, v30.4s, v31.4s
 aese v7.16b, v28.16b
 aese v0.16b, v28.16b
.inst 0xce04698c
 aese v6.16b, v28.16b
 aese v3.16b, v28.16b
 aese v1.16b, v28.16b
 rev32 v25.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce0769ef
.inst 0xce02694a
.inst 0xce006908
 mov v2.16b, v23.16b
.inst 0xce016929
 mov v1.16b, v22.16b
 stp q8, q9, [x2], #32
 ext v21.16b, v18.16b, v18.16b, #8
.inst 0xce0669ce
 mov v0.16b, v20.16b
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce0569ad
.inst 0xce115673
.inst 0xce03696b
 mov v3.16b, v25.16b
 stp q10, q11, [x2], #32
 stp q12, q13, [x2], #32
 cmp x0, x5
 stp q14, q15, [x2], #32
 b.lt .L192_enc_main_loop
.L192_enc_prepretail:
 rev32 v5.16b, v30.16b
 ldp q26, q27, [x8, #0]
 add v30.4s, v30.4s, v31.4s
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v8.16b, v8.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 rev64 v11.16b, v11.16b
 rev64 v10.16b, v10.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v8.16b, v8.16b, v19.16b
 rev32 v7.16b, v30.16b
 rev64 v9.16b, v9.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull2 v16.1q, v9.2d, v23.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull2 v17.1q, v8.2d, v25.2d
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 pmull v19.1q, v8.1d, v25.1d
 trn1 v18.2d, v9.2d, v8.2d
 trn2 v8.2d, v9.2d, v8.2d
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q28, q26, [x8, #32]
 pmull v23.1q, v9.1d, v23.1d
 eor v17.16b, v17.16b, v16.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 eor v8.16b, v8.16b, v18.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull2 v9.1q, v11.2d, v20.2d
 pmull2 v29.1q, v10.2d, v22.2d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 pmull v22.1q, v10.1d, v22.1d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 eor v19.16b, v19.16b, v23.16b
 pmull v20.1q, v11.1d, v20.1d
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
.inst 0xce1d2631
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 trn1 v29.2d, v11.2d, v10.2d
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull2 v18.1q, v8.2d, v24.2d
 trn2 v10.2d, v11.2d, v10.2d
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 rev64 v13.16b, v13.16b
 rev64 v14.16b, v14.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 eor v10.16b, v10.16b, v29.16b
 pmull v24.1q, v8.1d, v24.1d
 ldp q27, q28, [x8, #64]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v18.16b, v18.16b, v24.16b
.inst 0xce165273
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull2 v29.1q, v10.2d, v21.2d
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 rev64 v12.16b, v12.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 pmull v21.1q, v10.1d, v21.1d
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 trn1 v16.2d, v13.2d, v12.2d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
.inst 0xce157652
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 rev64 v15.16b, v15.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 ldp q26, q27, [x8, #96]
 pmull2 v11.1q, v14.2d, v22.2d
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v25.1q, v12.1d, v25.1d
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 trn2 v12.2d, v13.2d, v12.2d
 pmull2 v10.1q, v13.2d, v23.2d
 pmull v23.1q, v13.1d, v23.1d
 pmull v22.1q, v14.1d, v22.1d
 trn1 v13.2d, v15.2d, v14.2d
 eor v12.16b, v12.16b, v16.16b
 trn2 v14.2d, v15.2d, v14.2d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 eor v14.16b, v14.16b, v13.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 pmull2 v16.1q, v12.2d, v24.2d
 pmull v24.1q, v12.1d, v24.1d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
.inst 0xce184252
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
.inst 0xce082a31
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 ldr d16, [x10]
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull2 v13.1q, v14.2d, v21.2d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
.inst 0xce195e73
 pmull2 v12.1q, v15.2d, v20.2d
 pmull v21.1q, v14.1d, v21.1d
 pmull v20.1q, v15.1d, v20.1d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ldp q28, q26, [x8, #128]
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
.inst 0xce153652
.inst 0xce165273
.inst 0xce0b3231
.inst 0xce114e52
 ext v29.16b, v17.16b, v17.16b, #8
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull v21.1q, v17.1d, v16.1d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
.inst 0xce1d5652
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ldp q27, q28, [x8, #160]
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ext v21.16b, v18.16b, v18.16b, #8
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 pmull v17.1q, v18.1d, v16.1d
 ldr q26, [x8, #192]
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
.inst 0xce115673
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aese v7.16b, v28.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 add v30.4s, v30.4s, v31.4s
 aese v2.16b, v28.16b
 aese v0.16b, v28.16b
 aese v6.16b, v28.16b
 aese v4.16b, v28.16b
 aese v5.16b, v28.16b
.L192_enc_tail:
 ldp q20, q21, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 sub x5, x4, x0
 ldr q8, [x0], #16
 ldp q24, q25, [x3, #192]
 ext v25.16b, v25.16b, v25.16b, #8
 mov v29.16b, v26.16b
 ldp q22, q23, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 ext v23.16b, v23.16b, v23.16b, #8
 cmp x5, #112
.inst 0xce007509
 ext v16.16b, v19.16b, v19.16b, #8
 b.gt .L192_enc_blocks_more_than_7
 cmp x5, #96
 mov v7.16b, v6.16b
 movi v17.8b, #0
 mov v6.16b, v5.16b
 movi v19.8b, #0
 sub v30.4s, v30.4s, v31.4s
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v2.16b
 mov v2.16b, v1.16b
 movi v18.8b, #0
 b.gt .L192_enc_blocks_more_than_6
 mov v7.16b, v6.16b
 cmp x5, #80
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 b.gt .L192_enc_blocks_more_than_5
 cmp x5, #64
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v1.16b
 b.gt .L192_enc_blocks_more_than_4
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 cmp x5, #48
 b.gt .L192_enc_blocks_more_than_3
 mov v7.16b, v6.16b
 mov v6.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 ldr q24, [x3, #96]
 cmp x5, #32
 b.gt .L192_enc_blocks_more_than_2
 sub v30.4s, v30.4s, v31.4s
 cmp x5, #16
 mov v7.16b, v1.16b
 b.gt .L192_enc_blocks_more_than_1
 sub v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #48]
 b .L192_enc_blocks_less_than_1
.L192_enc_blocks_more_than_7:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ins v18.d[0], v24.d[1]
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 eor v27.8b, v27.8b, v8.8b
 movi v16.8b, #0
 pmull v19.1q, v8.1d, v25.1d
 pmull2 v17.1q, v8.2d, v25.2d
 pmull v18.1q, v27.1d, v18.1d
.inst 0xce017529
.L192_enc_blocks_more_than_6:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull v26.1q, v8.1d, v23.1d
.inst 0xce027529
 movi v16.8b, #0
 pmull2 v28.1q, v8.2d, v23.2d
 eor v27.8b, v27.8b, v8.8b
 pmull v27.1q, v27.1d, v24.1d
 eor v17.16b, v17.16b, v28.16b
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
.L192_enc_blocks_more_than_5:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 pmull2 v28.1q, v8.2d, v22.2d
 eor v27.8b, v27.8b, v8.8b
 eor v17.16b, v17.16b, v28.16b
 ins v27.d[1], v27.d[0]
 pmull v26.1q, v8.1d, v22.1d
 eor v19.16b, v19.16b, v26.16b
 pmull2 v27.1q, v27.2d, v21.2d
.inst 0xce037529
 movi v16.8b, #0
 eor v18.16b, v18.16b, v27.16b
.L192_enc_blocks_more_than_4:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 pmull2 v28.1q, v8.2d, v20.2d
 ins v27.d[0], v8.d[1]
 pmull v26.1q, v8.1d, v20.1d
 eor v17.16b, v17.16b, v28.16b
 eor v27.8b, v27.8b, v8.8b
 movi v16.8b, #0
 eor v19.16b, v19.16b, v26.16b
 pmull v27.1q, v27.1d, v21.1d
 eor v18.16b, v18.16b, v27.16b
.inst 0xce047529
.L192_enc_blocks_more_than_3:
 ldr q24, [x3, #96]
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ldr q9, [x0], #16
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 ins v27.d[0], v8.d[1]
.inst 0xce057529
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 pmull v26.1q, v8.1d, v25.1d
 pmull2 v28.1q, v8.2d, v25.2d
 pmull2 v27.1q, v27.2d, v24.2d
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L192_enc_blocks_more_than_2:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 ins v27.d[0], v8.d[1]
 eor v27.8b, v27.8b, v8.8b
 pmull v26.1q, v8.1d, v23.1d
 pmull2 v28.1q, v8.2d, v23.2d
 movi v16.8b, #0
 pmull v27.1q, v27.1d, v24.1d
 eor v19.16b, v19.16b, v26.16b
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
.inst 0xce067529
.L192_enc_blocks_more_than_1:
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull v26.1q, v8.1d, v22.1d
 eor v19.16b, v19.16b, v26.16b
 pmull2 v28.1q, v8.2d, v22.2d
 eor v27.8b, v27.8b, v8.8b
 ldr q9, [x0], #16
 ldr q21, [x3, #48]
 ins v27.d[1], v27.d[0]
.inst 0xce077529
 pmull2 v27.1q, v27.2d, v21.2d
 movi v16.8b, #0
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L192_enc_blocks_less_than_1:
 mvn x6, xzr
 and x1, x1, #127
 sub x1, x1, #128
 neg x1, x1
 and x1, x1, #127
 lsr x6, x6, x1
 cmp x1, #64
 mvn x7, xzr
 csel x13, x7, x6, lt
 csel x14, x6, xzr, lt
 mov v0.d[1], x14
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ld1 { v26.16b}, [x2]
 mov v0.d[0], x13
 and v9.16b, v9.16b, v0.16b
 rev64 v8.16b, v9.16b
 bif v9.16b, v26.16b, v0.16b
 st1 { v9.16b}, [x2]
 eor v8.16b, v8.16b, v16.16b
 ins v16.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v20.2d
 eor v17.16b, v17.16b, v28.16b
 pmull v26.1q, v8.1d, v20.1d
 eor v16.8b, v16.8b, v8.8b
 pmull v16.1q, v16.1d, v21.1d
 eor v18.16b, v18.16b, v16.16b
 ldr d16, [x10]
 eor v19.16b, v19.16b, v26.16b
 ext v21.16b, v17.16b, v17.16b, #8
 rev32 v30.16b, v30.16b
 str q30, [x16]
.inst 0xce114e52
 pmull v29.1q, v17.1d, v16.1d
.inst 0xce1d5652
 pmull v17.1q, v18.1d, v16.1d
 ext v21.16b, v18.16b, v18.16b, #8
.inst 0xce115673
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 st1 { v19.16b }, [x3]
 mov x0, x9
 ldp d10, d11, [sp, #16]
 ldp d12, d13, [sp, #32]
 ldp d14, d15, [sp, #48]
 ldp d8, d9, [sp], #80
 ret
.L192_enc_ret:
 mov w0, #0x0
 ret
.size unroll8_eor3_aes_gcm_enc_192_kernel,.-unroll8_eor3_aes_gcm_enc_192_kernel
.globl unroll8_eor3_aes_gcm_dec_192_kernel
.type unroll8_eor3_aes_gcm_dec_192_kernel,%function
.align 4
unroll8_eor3_aes_gcm_dec_192_kernel:
 cbz x1, .L192_dec_ret
 stp d8, d9, [sp, #-80]!
 lsr x9, x1, #3
 mov x16, x4
 mov x8, x5
 stp d10, d11, [sp, #16]
 stp d12, d13, [sp, #32]
 stp d14, d15, [sp, #48]
 mov x5, #0xc200000000000000
 stp x5, xzr, [sp, #64]
 add x10, sp, #64
 mov x5, x9
 ld1 { v0.16b}, [x16]
 ld1 { v19.16b}, [x3]
 mov x15, #0x100000000
 movi v31.16b, #0x0
 mov v31.d[1], x15
 rev32 v30.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q26, q27, [x8, #0]
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v7.16b, v30.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ldp q28, q26, [x8, #32]
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q27, q28, [x8, #64]
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ldp q26, q27, [x8, #96]
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 sub x5, x5, #1
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ldp q28, q26, [x8, #128]
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 and x5, x5, #0xffffffffffffff80
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 add x4, x0, x1, lsr #3
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 ld1 { v19.16b}, [x3]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 ldp q27, q28, [x8, #160]
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 add x5, x5, x0
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 cmp x0, x5
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldr q26, [x8, #192]
 aese v0.16b, v28.16b
 aese v1.16b, v28.16b
 aese v4.16b, v28.16b
 aese v6.16b, v28.16b
 aese v5.16b, v28.16b
 aese v7.16b, v28.16b
 aese v2.16b, v28.16b
 aese v3.16b, v28.16b
 b.ge .L192_dec_tail
 ldp q8, q9, [x0], #32
 ldp q10, q11, [x0], #32
 ldp q12, q13, [x0], #32
.inst 0xce016921
.inst 0xce006900
 stp q0, q1, [x2], #32
 rev32 v0.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce036963
.inst 0xce026942
 stp q2, q3, [x2], #32
 ldp q14, q15, [x0], #32
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce046984
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce0569a5
 stp q4, q5, [x2], #32
 cmp x0, x5
.inst 0xce0669c6
.inst 0xce0769e7
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 stp q6, q7, [x2], #32
 b.ge .L192_dec_prepretail
.L192_dec_main_loop:
 rev64 v9.16b, v9.16b
 ldp q26, q27, [x8, #0]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v8.16b, v8.16b
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v12.16b, v12.16b
 rev64 v11.16b, v11.16b
 eor v8.16b, v8.16b, v19.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev64 v13.16b, v13.16b
 rev32 v7.16b, v30.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull v19.1q, v8.1d, v25.1d
 pmull2 v16.1q, v9.2d, v23.2d
 ldp q28, q26, [x8, #32]
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 pmull v23.1q, v9.1d, v23.1d
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull2 v17.1q, v8.2d, v25.2d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 trn1 v18.2d, v9.2d, v8.2d
 rev64 v10.16b, v10.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 trn2 v8.2d, v9.2d, v8.2d
 eor v17.16b, v17.16b, v16.16b
 pmull2 v9.1q, v11.2d, v20.2d
 pmull2 v29.1q, v10.2d, v22.2d
 eor v8.16b, v8.16b, v18.16b
 eor v19.16b, v19.16b, v23.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 pmull v20.1q, v11.1d, v20.1d
.inst 0xce1d2631
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 pmull v22.1q, v10.1d, v22.1d
 trn1 v29.2d, v11.2d, v10.2d
 trn2 v10.2d, v11.2d, v10.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q27, q28, [x8, #64]
 eor v10.16b, v10.16b, v29.16b
.inst 0xce165273
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 trn1 v16.2d, v13.2d, v12.2d
 add v30.4s, v30.4s, v31.4s
 pmull2 v29.1q, v10.2d, v21.2d
 pmull2 v18.1q, v8.2d, v24.2d
 pmull v24.1q, v8.1d, v24.1d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull v21.1q, v10.1d, v21.1d
 pmull2 v8.1q, v12.2d, v25.2d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 eor v18.16b, v18.16b, v24.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 ldp q26, q27, [x8, #96]
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 rev64 v15.16b, v15.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce157652
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 rev64 v14.16b, v14.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 pmull2 v10.1q, v13.2d, v23.2d
 pmull v23.1q, v13.1d, v23.1d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v12.16b, v12.16b, v16.16b
 trn1 v13.2d, v15.2d, v14.2d
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 pmull2 v11.1q, v14.2d, v22.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull2 v16.1q, v12.2d, v24.2d
.inst 0xce082a31
.inst 0xce195e73
 pmull v22.1q, v14.1d, v22.1d
 trn2 v14.2d, v15.2d, v14.2d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldp q28, q26, [x8, #128]
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 eor v14.16b, v14.16b, v13.16b
 pmull v24.1q, v12.1d, v24.1d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
.inst 0xce184252
 pmull2 v13.1q, v14.2d, v21.2d
 pmull2 v12.1q, v15.2d, v20.2d
 pmull v21.1q, v14.1d, v21.1d
 ldr d16, [x10]
 pmull v20.1q, v15.1d, v20.1d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
.inst 0xce165273
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
.inst 0xce0b3231
 rev32 v20.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
.inst 0xce153652
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q27, q28, [x8, #160]
.inst 0xce114e52
 ldp q8, q9, [x0], #32
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 ldp q10, q11, [x0], #32
 rev32 v22.16b, v30.16b
 pmull v29.1q, v17.1d, v16.1d
 add v30.4s, v30.4s, v31.4s
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ext v21.16b, v17.16b, v17.16b, #8
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 ldp q12, q13, [x0], #32
 rev32 v23.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce1d5652
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 ldr q26, [x8, #192]
 ldp q14, q15, [x0], #32
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 ext v21.16b, v18.16b, v18.16b, #8
 aese v1.16b, v28.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aese v3.16b, v28.16b
.inst 0xce006900
 rev32 v25.16b, v30.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aese v2.16b, v28.16b
 add v30.4s, v30.4s, v31.4s
 aese v7.16b, v28.16b
 aese v5.16b, v28.16b
 pmull v17.1q, v18.1d, v16.1d
.inst 0xce016921
 stp q0, q1, [x2], #32
.inst 0xce036963
.inst 0xce026942
.inst 0xce0769e7
 stp q2, q3, [x2], #32
.inst 0xce0569a5
.inst 0xce115673
 mov v3.16b, v25.16b
.inst 0xce046984
 stp q4, q5, [x2], #32
 cmp x0, x5
.inst 0xce0669c6
 stp q6, q7, [x2], #32
 mov v0.16b, v20.16b
 mov v1.16b, v22.16b
 mov v2.16b, v23.16b
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 b.lt .L192_dec_main_loop
.L192_dec_prepretail:
 ldp q26, q27, [x8, #0]
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v8.16b, v8.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v11.16b, v11.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 eor v8.16b, v8.16b, v19.16b
 rev64 v10.16b, v10.16b
 rev64 v9.16b, v9.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 rev32 v7.16b, v30.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 pmull2 v16.1q, v9.2d, v23.2d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull2 v17.1q, v8.2d, v25.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q28, q26, [x8, #32]
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 pmull2 v29.1q, v10.2d, v22.2d
 pmull v22.1q, v10.1d, v22.1d
 pmull v23.1q, v9.1d, v23.1d
 eor v17.16b, v17.16b, v16.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v19.1q, v8.1d, v25.1d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 trn1 v18.2d, v9.2d, v8.2d
 trn2 v8.2d, v9.2d, v8.2d
 pmull2 v9.1q, v11.2d, v20.2d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 eor v8.16b, v8.16b, v18.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 rev64 v13.16b, v13.16b
 pmull v20.1q, v11.1d, v20.1d
.inst 0xce1d2631
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 trn1 v29.2d, v11.2d, v10.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 trn2 v10.2d, v11.2d, v10.2d
 pmull2 v18.1q, v8.2d, v24.2d
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull v24.1q, v8.1d, v24.1d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 eor v10.16b, v10.16b, v29.16b
 eor v19.16b, v19.16b, v23.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
.inst 0xce165273
 ldp q27, q28, [x8, #64]
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 pmull2 v29.1q, v10.2d, v21.2d
 pmull v21.1q, v10.1d, v21.1d
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v18.16b, v18.16b, v24.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 rev64 v15.16b, v15.16b
.inst 0xce157652
 rev64 v12.16b, v12.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 rev64 v14.16b, v14.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 trn1 v16.2d, v13.2d, v12.2d
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 ldp q26, q27, [x8, #96]
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 pmull2 v11.1q, v14.2d, v22.2d
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v22.1q, v14.1d, v22.1d
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 pmull2 v10.1q, v13.2d, v23.2d
 pmull v23.1q, v13.1d, v23.1d
 trn1 v13.2d, v15.2d, v14.2d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 trn2 v14.2d, v15.2d, v14.2d
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 eor v12.16b, v12.16b, v16.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v14.16b, v14.16b, v13.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull2 v16.1q, v12.2d, v24.2d
 pmull v24.1q, v12.1d, v24.1d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 pmull2 v13.1q, v14.2d, v21.2d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull2 v12.1q, v15.2d, v20.2d
.inst 0xce184252
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
.inst 0xce195e73
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldp q28, q26, [x8, #128]
 pmull v21.1q, v14.1d, v21.1d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ldr d16, [x10]
.inst 0xce082a31
 pmull v20.1q, v15.1d, v20.1d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
.inst 0xce0b3231
.inst 0xce165273
.inst 0xce153652
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
.inst 0xce114e52
 ext v21.16b, v17.16b, v17.16b, #8
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 pmull v29.1q, v17.1d, v16.1d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldp q27, q28, [x8, #160]
.inst 0xce1d5652
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull v17.1q, v18.1d, v16.1d
 ldr q26, [x8, #192]
 ext v21.16b, v18.16b, v18.16b, #8
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
.inst 0xce115673
 aese v5.16b, v28.16b
 aese v2.16b, v28.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v28.16b
 aese v4.16b, v28.16b
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v28.16b
 aese v1.16b, v28.16b
 aese v7.16b, v28.16b
.L192_dec_tail:
 sub x5, x4, x0
 ldp q20, q21, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q9, [x0], #16
 ldp q24, q25, [x3, #192]
 ext v25.16b, v25.16b, v25.16b, #8
 mov v29.16b, v26.16b
 ldp q22, q23, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 ext v23.16b, v23.16b, v23.16b, #8
 ext v16.16b, v19.16b, v19.16b, #8
.inst 0xce00752c
 cmp x5, #112
 b.gt .L192_dec_blocks_more_than_7
 mov v7.16b, v6.16b
 movi v17.8b, #0
 sub v30.4s, v30.4s, v31.4s
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 cmp x5, #96
 movi v19.8b, #0
 mov v3.16b, v2.16b
 mov v2.16b, v1.16b
 movi v18.8b, #0
 b.gt .L192_dec_blocks_more_than_6
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 cmp x5, #80
 b.gt .L192_dec_blocks_more_than_5
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v1.16b
 cmp x5, #64
 sub v30.4s, v30.4s, v31.4s
 b.gt .L192_dec_blocks_more_than_4
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v1.16b
 cmp x5, #48
 b.gt .L192_dec_blocks_more_than_3
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 cmp x5, #32
 mov v6.16b, v1.16b
 ldr q24, [x3, #96]
 b.gt .L192_dec_blocks_more_than_2
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v1.16b
 cmp x5, #16
 b.gt .L192_dec_blocks_more_than_1
 sub v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #48]
 b .L192_dec_blocks_less_than_1
.L192_dec_blocks_more_than_7:
 rev64 v8.16b, v9.16b
 ins v18.d[0], v24.d[1]
 eor v8.16b, v8.16b, v16.16b
 pmull2 v17.1q, v8.2d, v25.2d
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 pmull v19.1q, v8.1d, v25.1d
 eor v27.8b, v27.8b, v8.8b
 st1 { v12.16b}, [x2], #16
.inst 0xce01752c
 pmull v18.1q, v27.1d, v18.1d
 movi v16.8b, #0
.L192_dec_blocks_more_than_6:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 ins v27.d[0], v8.d[1]
 eor v27.8b, v27.8b, v8.8b
 movi v16.8b, #0
 pmull2 v28.1q, v8.2d, v23.2d
 st1 { v12.16b}, [x2], #16
.inst 0xce02752c
 eor v17.16b, v17.16b, v28.16b
 pmull v27.1q, v27.1d, v24.1d
 pmull v26.1q, v8.1d, v23.1d
 eor v18.16b, v18.16b, v27.16b
 eor v19.16b, v19.16b, v26.16b
.L192_dec_blocks_more_than_5:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 pmull2 v28.1q, v8.2d, v22.2d
 ldr q9, [x0], #16
 eor v17.16b, v17.16b, v28.16b
 pmull v26.1q, v8.1d, v22.1d
 pmull2 v27.1q, v27.2d, v21.2d
 eor v19.16b, v19.16b, v26.16b
 movi v16.8b, #0
 st1 { v12.16b}, [x2], #16
 eor v18.16b, v18.16b, v27.16b
.inst 0xce03752c
.L192_dec_blocks_more_than_4:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ldr q9, [x0], #16
 ins v27.d[0], v8.d[1]
 pmull v26.1q, v8.1d, v20.1d
 eor v27.8b, v27.8b, v8.8b
 eor v19.16b, v19.16b, v26.16b
 pmull v27.1q, v27.1d, v21.1d
 st1 { v12.16b}, [x2], #16
 pmull2 v28.1q, v8.2d, v20.2d
.inst 0xce04752c
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L192_dec_blocks_more_than_3:
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v25.2d
 eor v17.16b, v17.16b, v28.16b
 movi v16.8b, #0
 pmull v26.1q, v8.1d, v25.1d
 st1 { v12.16b}, [x2], #16
 eor v27.8b, v27.8b, v8.8b
.inst 0xce05752c
 eor v19.16b, v19.16b, v26.16b
 ldr q24, [x3, #96]
 ins v27.d[1], v27.d[0]
 pmull2 v27.1q, v27.2d, v24.2d
 eor v18.16b, v18.16b, v27.16b
.L192_dec_blocks_more_than_2:
 rev64 v8.16b, v9.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 pmull2 v28.1q, v8.2d, v23.2d
 eor v27.8b, v27.8b, v8.8b
 eor v17.16b, v17.16b, v28.16b
 pmull v26.1q, v8.1d, v23.1d
 pmull v27.1q, v27.1d, v24.1d
 movi v16.8b, #0
 eor v19.16b, v19.16b, v26.16b
 st1 { v12.16b}, [x2], #16
 eor v18.16b, v18.16b, v27.16b
.inst 0xce06752c
.L192_dec_blocks_more_than_1:
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ldr q21, [x3, #48]
 pmull v26.1q, v8.1d, v22.1d
 ins v27.d[0], v8.d[1]
 st1 { v12.16b}, [x2], #16
 pmull2 v28.1q, v8.2d, v22.2d
.inst 0xce07752c
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 pmull2 v27.1q, v27.2d, v21.2d
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L192_dec_blocks_less_than_1:
 rev32 v30.16b, v30.16b
 and x1, x1, #127
 sub x1, x1, #128
 str q30, [x16]
 neg x1, x1
 mvn x6, xzr
 and x1, x1, #127
 mvn x7, xzr
 lsr x6, x6, x1
 cmp x1, #64
 csel x13, x7, x6, lt
 csel x14, x6, xzr, lt
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 mov v0.d[1], x14
 ld1 { v26.16b}, [x2]
 mov v0.d[0], x13
 and v9.16b, v9.16b, v0.16b
 bif v12.16b, v26.16b, v0.16b
 rev64 v8.16b, v9.16b
 st1 { v12.16b}, [x2]
 eor v8.16b, v8.16b, v16.16b
 ins v16.d[0], v8.d[1]
 pmull v26.1q, v8.1d, v20.1d
 eor v16.8b, v16.8b, v8.8b
 pmull2 v28.1q, v8.2d, v20.2d
 eor v19.16b, v19.16b, v26.16b
 pmull v16.1q, v16.1d, v21.1d
 eor v17.16b, v17.16b, v28.16b
 eor v14.16b, v17.16b, v19.16b
 eor v18.16b, v18.16b, v16.16b
 ldr d16, [x10]
 pmull v21.1q, v17.1d, v16.1d
 ext v17.16b, v17.16b, v17.16b, #8
 eor v18.16b, v18.16b, v14.16b
.inst 0xce115652
 pmull v17.1q, v18.1d, v16.1d
 ext v18.16b, v18.16b, v18.16b, #8
.inst 0xce124673
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 st1 { v19.16b }, [x3]
 mov x0, x9
 ldp d10, d11, [sp, #16]
 ldp d12, d13, [sp, #32]
 ldp d14, d15, [sp, #48]
 ldp d8, d9, [sp], #80
 ret
.L192_dec_ret:
 mov w0, #0x0
 ret
.size unroll8_eor3_aes_gcm_dec_192_kernel,.-unroll8_eor3_aes_gcm_dec_192_kernel
.globl unroll8_eor3_aes_gcm_enc_256_kernel
.type unroll8_eor3_aes_gcm_enc_256_kernel,%function
.align 4
unroll8_eor3_aes_gcm_enc_256_kernel:
 cbz x1, .L256_enc_ret
 stp d8, d9, [sp, #-80]!
 lsr x9, x1, #3
 mov x16, x4
 mov x8, x5
 stp d10, d11, [sp, #16]
 stp d12, d13, [sp, #32]
 stp d14, d15, [sp, #48]
 mov x5, #0xc200000000000000
 stp x5, xzr, [sp, #64]
 add x10, sp, #64
 ld1 { v0.16b}, [x16]
 mov x5, x9
 mov x15, #0x100000000
 movi v31.16b, #0x0
 mov v31.d[1], x15
 sub x5, x5, #1
 and x5, x5, #0xffffffffffffff80
 add x5, x5, x0
 rev32 v30.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q26, q27, [x8, #0]
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v7.16b, v30.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q28, q26, [x8, #32]
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ldp q27, q28, [x8, #64]
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 ldp q26, q27, [x8, #96]
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ldp q28, q26, [x8, #128]
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 ld1 { v19.16b}, [x3]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 ldp q27, q28, [x8, #160]
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldp q26, q27, [x8, #192]
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 add v30.4s, v30.4s, v31.4s
 ldr q28, [x8, #224]
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aese v1.16b, v27.16b
 aese v4.16b, v27.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v27.16b
 aese v5.16b, v27.16b
 aese v6.16b, v27.16b
 aese v7.16b, v27.16b
 aese v3.16b, v27.16b
 add x4, x0, x1, lsr #3
 cmp x0, x5
 b.ge .L256_enc_tail
 ldp q8, q9, [x0], #32
 ldp q10, q11, [x0], #32
.inst 0xce007108
 rev32 v0.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce017129
.inst 0xce03716b
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q12, q13, [x0], #32
 ldp q14, q15, [x0], #32
.inst 0xce02714a
 cmp x0, x5
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 stp q8, q9, [x2], #32
 stp q10, q11, [x2], #32
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce04718c
.inst 0xce0771ef
.inst 0xce0671ce
.inst 0xce0571ad
 stp q12, q13, [x2], #32
 rev32 v4.16b, v30.16b
 stp q14, q15, [x2], #32
 add v30.4s, v30.4s, v31.4s
 b.ge .L256_enc_prepretail
.L256_enc_main_loop:
 ldp q26, q27, [x8, #0]
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 rev64 v11.16b, v11.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 rev64 v9.16b, v9.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev64 v8.16b, v8.16b
 rev64 v12.16b, v12.16b
 ext v19.16b, v19.16b, v19.16b, #8
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 rev32 v7.16b, v30.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ldp q28, q26, [x8, #32]
 eor v8.16b, v8.16b, v19.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 pmull2 v17.1q, v8.2d, v25.2d
 pmull v19.1q, v8.1d, v25.1d
 pmull2 v16.1q, v9.2d, v23.2d
 trn1 v18.2d, v9.2d, v8.2d
 trn2 v8.2d, v9.2d, v8.2d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 pmull v23.1q, v9.1d, v23.1d
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 rev64 v14.16b, v14.16b
 pmull2 v9.1q, v11.2d, v20.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ldp q27, q28, [x8, #64]
 rev64 v10.16b, v10.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v17.16b, v17.16b, v16.16b
 pmull2 v29.1q, v10.2d, v22.2d
 rev64 v13.16b, v13.16b
 pmull v20.1q, v11.1d, v20.1d
 eor v19.16b, v19.16b, v23.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 trn1 v16.2d, v13.2d, v12.2d
.inst 0xce1d2631
 pmull v22.1q, v10.1d, v22.1d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 trn1 v29.2d, v11.2d, v10.2d
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 trn2 v10.2d, v11.2d, v10.2d
 eor v8.16b, v8.16b, v18.16b
 ldp q26, q27, [x8, #96]
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 eor v10.16b, v10.16b, v29.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 rev64 v15.16b, v15.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull2 v29.1q, v10.2d, v21.2d
 pmull2 v18.1q, v8.2d, v24.2d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull v24.1q, v8.1d, v24.1d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 eor v18.16b, v18.16b, v24.16b
 pmull v21.1q, v10.1d, v21.1d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
.inst 0xce165273
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 ldp q28, q26, [x8, #128]
 pmull2 v8.1q, v12.2d, v25.2d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
.inst 0xce157652
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 pmull2 v10.1q, v13.2d, v23.2d
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull v23.1q, v13.1d, v23.1d
 trn1 v13.2d, v15.2d, v14.2d
 eor v12.16b, v12.16b, v16.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull2 v16.1q, v12.2d, v24.2d
 pmull v24.1q, v12.1d, v24.1d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 pmull2 v11.1q, v14.2d, v22.2d
 pmull v22.1q, v14.1d, v22.1d
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 trn2 v14.2d, v15.2d, v14.2d
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce184252
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 eor v14.16b, v14.16b, v13.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ldp q27, q28, [x8, #160]
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 pmull2 v12.1q, v15.2d, v20.2d
.inst 0xce195e73
 pmull v20.1q, v15.1d, v20.1d
 ldr d16, [x10]
 pmull2 v13.1q, v14.2d, v21.2d
 pmull v21.1q, v14.1d, v21.1d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
.inst 0xce153652
.inst 0xce165273
.inst 0xce082a31
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 add v30.4s, v30.4s, v31.4s
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
.inst 0xce0b3231
 ldp q26, q27, [x8, #192]
 rev32 v20.16b, v30.16b
 ext v21.16b, v17.16b, v17.16b, #8
 ldp q8, q9, [x0], #32
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 pmull v29.1q, v17.1d, v16.1d
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 rev32 v22.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
.inst 0xce114e52
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 ldr q28, [x8, #224]
 aese v7.16b, v27.16b
 ldp q10, q11, [x0], #32
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
.inst 0xce1d5652
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 ldp q12, q13, [x0], #32
 ldp q14, q15, [x0], #32
 aese v2.16b, v27.16b
 aese v4.16b, v27.16b
 rev32 v23.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v5.16b, v27.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 cmp x0, x5
.inst 0xce02714a
 rev32 v25.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v0.16b, v27.16b
 aese v6.16b, v27.16b
.inst 0xce0571ad
 ext v21.16b, v18.16b, v18.16b, #8
 pmull v17.1q, v18.1d, v16.1d
 aese v1.16b, v27.16b
.inst 0xce04718c
 rev32 v4.16b, v30.16b
.inst 0xce03716b
 mov v3.16b, v25.16b
.inst 0xce017129
.inst 0xce007108
 add v30.4s, v30.4s, v31.4s
 stp q8, q9, [x2], #32
 mov v2.16b, v23.16b
.inst 0xce0771ef
.inst 0xce154673
 stp q10, q11, [x2], #32
.inst 0xce0671ce
 mov v1.16b, v22.16b
 stp q12, q13, [x2], #32
 stp q14, q15, [x2], #32
 mov v0.16b, v20.16b
 b.lt .L256_enc_main_loop
.L256_enc_prepretail:
 rev32 v5.16b, v30.16b
 ldp q26, q27, [x8, #0]
 add v30.4s, v30.4s, v31.4s
 rev64 v10.16b, v10.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev64 v13.16b, v13.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 rev32 v7.16b, v30.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v8.16b, v8.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 rev64 v9.16b, v9.16b
 ldp q28, q26, [x8, #32]
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 eor v8.16b, v8.16b, v19.16b
 rev64 v11.16b, v11.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 ldp q27, q28, [x8, #64]
 trn1 v18.2d, v9.2d, v8.2d
 pmull2 v17.1q, v8.2d, v25.2d
 rev64 v14.16b, v14.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull2 v16.1q, v9.2d, v23.2d
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull v19.1q, v8.1d, v25.1d
 trn2 v8.2d, v9.2d, v8.2d
 pmull2 v29.1q, v10.2d, v22.2d
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 eor v17.16b, v17.16b, v16.16b
 pmull v23.1q, v9.1d, v23.1d
 pmull2 v9.1q, v11.2d, v20.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 eor v8.16b, v8.16b, v18.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 pmull v22.1q, v10.1d, v22.1d
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 pmull2 v18.1q, v8.2d, v24.2d
.inst 0xce1d2631
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 trn1 v29.2d, v11.2d, v10.2d
 trn2 v10.2d, v11.2d, v10.2d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 eor v19.16b, v19.16b, v23.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 pmull v20.1q, v11.1d, v20.1d
 pmull v24.1q, v8.1d, v24.1d
 eor v10.16b, v10.16b, v29.16b
 rev64 v12.16b, v12.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldp q26, q27, [x8, #96]
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 pmull2 v29.1q, v10.2d, v21.2d
 pmull v21.1q, v10.1d, v21.1d
.inst 0xce165273
 eor v18.16b, v18.16b, v24.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 rev64 v15.16b, v15.16b
 trn1 v16.2d, v13.2d, v12.2d
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
.inst 0xce157652
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v25.1q, v12.1d, v25.1d
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 ldp q28, q26, [x8, #128]
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 pmull2 v10.1q, v13.2d, v23.2d
 trn2 v12.2d, v13.2d, v12.2d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 pmull v23.1q, v13.1d, v23.1d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 eor v12.16b, v12.16b, v16.16b
 pmull2 v11.1q, v14.2d, v22.2d
 pmull v22.1q, v14.1d, v22.1d
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 trn1 v13.2d, v15.2d, v14.2d
 trn2 v14.2d, v15.2d, v14.2d
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
.inst 0xce195e73
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 eor v14.16b, v14.16b, v13.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull2 v16.1q, v12.2d, v24.2d
 pmull v24.1q, v12.1d, v24.1d
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull2 v12.1q, v15.2d, v20.2d
 pmull2 v13.1q, v14.2d, v21.2d
 pmull v21.1q, v14.1d, v21.1d
 pmull v20.1q, v15.1d, v20.1d
.inst 0xce184252
.inst 0xce082a31
 ldp q27, q28, [x8, #160]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
.inst 0xce0b3231
.inst 0xce153652
 ldr d16, [x10]
.inst 0xce165273
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 pmull v29.1q, v17.1d, v16.1d
.inst 0xce114e52
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 ldp q26, q27, [x8, #192]
 ext v21.16b, v17.16b, v17.16b, #8
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
.inst 0xce1d5652
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 pmull v17.1q, v18.1d, v16.1d
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 ldr q28, [x8, #224]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 ext v21.16b, v18.16b, v18.16b, #8
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v27.16b
.inst 0xce154673
 aese v5.16b, v27.16b
 aese v1.16b, v27.16b
 aese v3.16b, v27.16b
 aese v4.16b, v27.16b
 aese v7.16b, v27.16b
 aese v2.16b, v27.16b
 aese v6.16b, v27.16b
.L256_enc_tail:
 ldp q24, q25, [x3, #192]
 ext v25.16b, v25.16b, v25.16b, #8
 sub x5, x4, x0
 ldr q8, [x0], #16
 ldp q20, q21, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ext v16.16b, v19.16b, v19.16b, #8
 ldp q22, q23, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 ext v23.16b, v23.16b, v23.16b, #8
 mov v29.16b, v28.16b
 cmp x5, #112
.inst 0xce007509
 b.gt .L256_enc_blocks_more_than_7
 movi v19.8b, #0
 mov v7.16b, v6.16b
 movi v17.8b, #0
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v2.16b
 sub v30.4s, v30.4s, v31.4s
 mov v2.16b, v1.16b
 movi v18.8b, #0
 cmp x5, #96
 b.gt .L256_enc_blocks_more_than_6
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 cmp x5, #80
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 mov v3.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 b.gt .L256_enc_blocks_more_than_5
 mov v7.16b, v6.16b
 sub v30.4s, v30.4s, v31.4s
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 cmp x5, #64
 mov v4.16b, v1.16b
 b.gt .L256_enc_blocks_more_than_4
 cmp x5, #48
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 b.gt .L256_enc_blocks_more_than_3
 cmp x5, #32
 mov v7.16b, v6.16b
 ldr q24, [x3, #96]
 mov v6.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 b.gt .L256_enc_blocks_more_than_2
 mov v7.16b, v1.16b
 sub v30.4s, v30.4s, v31.4s
 cmp x5, #16
 b.gt .L256_enc_blocks_more_than_1
 sub v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #48]
 b .L256_enc_blocks_less_than_1
.L256_enc_blocks_more_than_7:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 pmull2 v17.1q, v8.2d, v25.2d
 ins v27.d[0], v8.d[1]
 ins v18.d[0], v24.d[1]
 movi v16.8b, #0
 eor v27.8b, v27.8b, v8.8b
.inst 0xce017529
 pmull v18.1q, v27.1d, v18.1d
 pmull v19.1q, v8.1d, v25.1d
.L256_enc_blocks_more_than_6:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 pmull v26.1q, v8.1d, v23.1d
 ins v27.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v23.2d
 ldr q9, [x0], #16
 eor v19.16b, v19.16b, v26.16b
 eor v27.8b, v27.8b, v8.8b
 pmull v27.1q, v27.1d, v24.1d
.inst 0xce027529
 movi v16.8b, #0
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L256_enc_blocks_more_than_5:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v22.2d
 eor v17.16b, v17.16b, v28.16b
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 ldr q9, [x0], #16
 pmull v26.1q, v8.1d, v22.1d
 pmull2 v27.1q, v27.2d, v21.2d
 movi v16.8b, #0
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
.inst 0xce037529
.L256_enc_blocks_more_than_4:
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v20.2d
.inst 0xce047529
 pmull v26.1q, v8.1d, v20.1d
 eor v27.8b, v27.8b, v8.8b
 eor v19.16b, v19.16b, v26.16b
 pmull v27.1q, v27.1d, v21.1d
 movi v16.8b, #0
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L256_enc_blocks_more_than_3:
 st1 { v9.16b}, [x2], #16
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v25.2d
 eor v17.16b, v17.16b, v28.16b
 eor v27.8b, v27.8b, v8.8b
 ldr q24, [x3, #96]
 ins v27.d[1], v27.d[0]
 ldr q9, [x0], #16
 pmull2 v27.1q, v27.2d, v24.2d
 pmull v26.1q, v8.1d, v25.1d
.inst 0xce057529
 movi v16.8b, #0
 eor v18.16b, v18.16b, v27.16b
 eor v19.16b, v19.16b, v26.16b
.L256_enc_blocks_more_than_2:
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 st1 { v9.16b}, [x2], #16
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 movi v16.8b, #0
 pmull2 v28.1q, v8.2d, v23.2d
.inst 0xce067529
 eor v27.8b, v27.8b, v8.8b
 eor v17.16b, v17.16b, v28.16b
 pmull v27.1q, v27.1d, v24.1d
 pmull v26.1q, v8.1d, v23.1d
 eor v18.16b, v18.16b, v27.16b
 eor v19.16b, v19.16b, v26.16b
.L256_enc_blocks_more_than_1:
 st1 { v9.16b}, [x2], #16
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 movi v16.8b, #0
 ins v27.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v22.2d
.inst 0xce077529
 eor v17.16b, v17.16b, v28.16b
 pmull v26.1q, v8.1d, v22.1d
 eor v27.8b, v27.8b, v8.8b
 ldr q21, [x3, #48]
 eor v19.16b, v19.16b, v26.16b
 ins v27.d[1], v27.d[0]
 pmull2 v27.1q, v27.2d, v21.2d
 eor v18.16b, v18.16b, v27.16b
.L256_enc_blocks_less_than_1:
 and x1, x1, #127
 sub x1, x1, #128
 neg x1, x1
 mvn x6, xzr
 and x1, x1, #127
 lsr x6, x6, x1
 cmp x1, #64
 mvn x7, xzr
 csel x14, x6, xzr, lt
 csel x13, x7, x6, lt
 mov v0.d[0], x13
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ld1 { v26.16b}, [x2]
 mov v0.d[1], x14
 and v9.16b, v9.16b, v0.16b
 rev64 v8.16b, v9.16b
 rev32 v30.16b, v30.16b
 bif v9.16b, v26.16b, v0.16b
 str q30, [x16]
 eor v8.16b, v8.16b, v16.16b
 st1 { v9.16b}, [x2]
 ins v16.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v20.2d
 pmull v26.1q, v8.1d, v20.1d
 eor v17.16b, v17.16b, v28.16b
 eor v19.16b, v19.16b, v26.16b
 eor v16.8b, v16.8b, v8.8b
 pmull v16.1q, v16.1d, v21.1d
 eor v18.16b, v18.16b, v16.16b
 ldr d16, [x10]
 ext v21.16b, v17.16b, v17.16b, #8
.inst 0xce114e52
 pmull v29.1q, v17.1d, v16.1d
.inst 0xce1d5652
 pmull v17.1q, v18.1d, v16.1d
 ext v21.16b, v18.16b, v18.16b, #8
.inst 0xce115673
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 st1 { v19.16b }, [x3]
 mov x0, x9
 ldp d10, d11, [sp, #16]
 ldp d12, d13, [sp, #32]
 ldp d14, d15, [sp, #48]
 ldp d8, d9, [sp], #80
 ret
.L256_enc_ret:
 mov w0, #0x0
 ret
.size unroll8_eor3_aes_gcm_enc_256_kernel,.-unroll8_eor3_aes_gcm_enc_256_kernel
.globl unroll8_eor3_aes_gcm_dec_256_kernel
.type unroll8_eor3_aes_gcm_dec_256_kernel,%function
.align 4
unroll8_eor3_aes_gcm_dec_256_kernel:
 cbz x1, .L256_dec_ret
 stp d8, d9, [sp, #-80]!
 lsr x9, x1, #3
 mov x16, x4
 mov x8, x5
 stp d10, d11, [sp, #16]
 stp d12, d13, [sp, #32]
 stp d14, d15, [sp, #48]
 mov x5, #0xc200000000000000
 stp x5, xzr, [sp, #64]
 add x10, sp, #64
 ld1 { v0.16b}, [x16]
 mov x15, #0x100000000
 movi v31.16b, #0x0
 mov v31.d[1], x15
 mov x5, x9
 sub x5, x5, #1
 rev32 v30.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 ldp q26, q27, [x8, #0]
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev32 v7.16b, v30.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 ldp q28, q26, [x8, #32]
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldp q27, q28, [x8, #64]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ldp q26, q27, [x8, #96]
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 ldp q28, q26, [x8, #128]
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 and x5, x5, #0xffffffffffffff80
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ld1 { v19.16b}, [x3]
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 ldp q27, q28, [x8, #160]
 add x4, x0, x1, lsr #3
 add x5, x5, x0
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 ldp q26, q27, [x8, #192]
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 add v30.4s, v30.4s, v31.4s
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 ldr q28, [x8, #224]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 cmp x0, x5
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v27.16b
 aese v1.16b, v27.16b
 aese v2.16b, v27.16b
 aese v0.16b, v27.16b
 aese v4.16b, v27.16b
 aese v6.16b, v27.16b
 aese v3.16b, v27.16b
 aese v7.16b, v27.16b
 b.ge .L256_dec_tail
 ldp q8, q9, [x0], #32
 ldp q10, q11, [x0], #32
 ldp q12, q13, [x0], #32
 ldp q14, q15, [x0], #32
 cmp x0, x5
.inst 0xce017121
.inst 0xce007100
 stp q0, q1, [x2], #32
 rev32 v0.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce037163
.inst 0xce0571a5
.inst 0xce047184
 rev32 v1.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce027142
 stp q2, q3, [x2], #32
 rev32 v2.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
.inst 0xce0671c6
 rev32 v3.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 stp q4, q5, [x2], #32
.inst 0xce0771e7
 stp q6, q7, [x2], #32
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 b.ge .L256_dec_prepretail
.L256_dec_main_loop:
 rev32 v5.16b, v30.16b
 ldp q26, q27, [x8, #0]
 add v30.4s, v30.4s, v31.4s
 rev64 v9.16b, v9.16b
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev32 v6.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev64 v8.16b, v8.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v12.16b, v12.16b
 rev64 v11.16b, v11.16b
 rev32 v7.16b, v30.16b
 rev64 v15.16b, v15.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 ldp q28, q26, [x8, #32]
 eor v8.16b, v8.16b, v19.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 rev64 v10.16b, v10.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 trn1 v18.2d, v9.2d, v8.2d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 pmull v19.1q, v8.1d, v25.1d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 ldp q27, q28, [x8, #64]
 pmull2 v29.1q, v10.2d, v22.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 pmull2 v16.1q, v9.2d, v23.2d
 pmull v23.1q, v9.1d, v23.1d
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 pmull2 v17.1q, v8.2d, v25.2d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 trn2 v8.2d, v9.2d, v8.2d
 pmull2 v9.1q, v11.2d, v20.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v17.16b, v17.16b, v16.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 eor v8.16b, v8.16b, v18.16b
 pmull v22.1q, v10.1d, v22.1d
 ldp q26, q27, [x8, #96]
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 eor v19.16b, v19.16b, v23.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
.inst 0xce1d2631
 trn1 v29.2d, v11.2d, v10.2d
 rev64 v13.16b, v13.16b
 pmull2 v18.1q, v8.2d, v24.2d
 pmull v24.1q, v8.1d, v24.1d
 trn2 v10.2d, v11.2d, v10.2d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 trn1 v16.2d, v13.2d, v12.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 eor v10.16b, v10.16b, v29.16b
 pmull v20.1q, v11.1d, v20.1d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull2 v29.1q, v10.2d, v21.2d
 pmull v21.1q, v10.1d, v21.1d
.inst 0xce165273
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v14.16b, v14.16b
 eor v18.16b, v18.16b, v24.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 ldp q28, q26, [x8, #128]
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
.inst 0xce157652
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 pmull2 v8.1q, v12.2d, v25.2d
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 pmull2 v10.1q, v13.2d, v23.2d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 pmull v23.1q, v13.1d, v23.1d
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull2 v11.1q, v14.2d, v22.2d
 trn1 v13.2d, v15.2d, v14.2d
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 ldp q27, q28, [x8, #160]
 pmull v22.1q, v14.1d, v22.1d
 trn2 v14.2d, v15.2d, v14.2d
 add v30.4s, v30.4s, v31.4s
.inst 0xce082a31
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 eor v14.16b, v14.16b, v13.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 ldp q8, q9, [x0], #32
 eor v12.16b, v12.16b, v16.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull2 v13.1q, v14.2d, v21.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 pmull2 v16.1q, v12.2d, v24.2d
 pmull v24.1q, v12.1d, v24.1d
 pmull2 v12.1q, v15.2d, v20.2d
 pmull v20.1q, v15.1d, v20.1d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 pmull v21.1q, v14.1d, v21.1d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
.inst 0xce195e73
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
.inst 0xce184252
.inst 0xce0b3231
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
.inst 0xce165273
 rev32 v20.16b, v30.16b
 ldr d16, [x10]
 add v30.4s, v30.4s, v31.4s
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 ldp q26, q27, [x8, #192]
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
.inst 0xce153652
 rev32 v22.16b, v30.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 ldp q10, q11, [x0], #32
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 ext v21.16b, v17.16b, v17.16b, #8
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 add v30.4s, v30.4s, v31.4s
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 rev32 v23.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 pmull v29.1q, v17.1d, v16.1d
.inst 0xce114e52
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldr q28, [x8, #224]
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
.inst 0xce1d5652
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ldp q12, q13, [x0], #32
 aese v1.16b, v27.16b
 aese v2.16b, v27.16b
 ldp q14, q15, [x0], #32
 aese v0.16b, v27.16b
 aese v5.16b, v27.16b
 rev32 v25.16b, v30.16b
.inst 0xce027142
.inst 0xce017121
 ext v21.16b, v18.16b, v18.16b, #8
 aese v7.16b, v27.16b
 add v30.4s, v30.4s, v31.4s
 pmull v17.1q, v18.1d, v16.1d
 aese v4.16b, v27.16b
.inst 0xce0571a5
.inst 0xce007100
 aese v3.16b, v27.16b
 stp q0, q1, [x2], #32
 mov v0.16b, v20.16b
.inst 0xce047184
.inst 0xce154673
.inst 0xce037163
 stp q2, q3, [x2], #32
 mov v3.16b, v25.16b
 mov v2.16b, v23.16b
 aese v6.16b, v27.16b
 mov v1.16b, v22.16b
 stp q4, q5, [x2], #32
.inst 0xce0771e7
.inst 0xce0671c6
 rev32 v4.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 cmp x0, x5
 stp q6, q7, [x2], #32
 b.lt .L256_dec_main_loop
.L256_dec_prepretail:
 ldp q26, q27, [x8, #0]
 rev32 v5.16b, v30.16b
 add v30.4s, v30.4s, v31.4s
 rev64 v12.16b, v12.16b
 ldr q21, [x3, #144]
 ldr q24, [x3, #192]
 rev32 v6.16b, v30.16b
 rev64 v8.16b, v8.16b
 add v30.4s, v30.4s, v31.4s
 ext v19.16b, v19.16b, v19.16b, #8
 ldr q23, [x3, #176]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #208]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v9.16b, v9.16b
 rev32 v7.16b, v30.16b
 rev64 v10.16b, v10.16b
 ldr q20, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 ldp q28, q26, [x8, #32]
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 eor v8.16b, v8.16b, v19.16b
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 pmull2 v16.1q, v9.2d, v23.2d
 trn1 v18.2d, v9.2d, v8.2d
 pmull v19.1q, v8.1d, v25.1d
 rev64 v11.16b, v11.16b
 pmull v23.1q, v9.1d, v23.1d
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 pmull2 v17.1q, v8.2d, v25.2d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 rev64 v14.16b, v14.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 pmull2 v29.1q, v10.2d, v22.2d
 trn2 v8.2d, v9.2d, v8.2d
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 ldp q27, q28, [x8, #64]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 pmull2 v9.1q, v11.2d, v20.2d
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 eor v17.16b, v17.16b, v16.16b
 eor v8.16b, v8.16b, v18.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 pmull v22.1q, v10.1d, v22.1d
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
.inst 0xce1d2631
 trn1 v29.2d, v11.2d, v10.2d
 trn2 v10.2d, v11.2d, v10.2d
 pmull2 v18.1q, v8.2d, v24.2d
 pmull v20.1q, v11.1d, v20.1d
 eor v19.16b, v19.16b, v23.16b
 pmull v24.1q, v8.1d, v24.1d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
.inst 0xce165273
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 eor v18.16b, v18.16b, v24.16b
 eor v10.16b, v10.16b, v29.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 pmull2 v29.1q, v10.2d, v21.2d
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 pmull v21.1q, v10.1d, v21.1d
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 ldp q26, q27, [x8, #96]
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v15.16b, v15.16b
 rev64 v13.16b, v13.16b
.inst 0xce157652
 trn1 v16.2d, v13.2d, v12.2d
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 ldr q21, [x3, #48]
 ldr q24, [x3, #96]
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull2 v8.1q, v12.2d, v25.2d
 pmull2 v10.1q, v13.2d, v23.2d
 pmull v25.1q, v12.1d, v25.1d
 trn2 v12.2d, v13.2d, v12.2d
 pmull v23.1q, v13.1d, v23.1d
 trn1 v13.2d, v15.2d, v14.2d
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 pmull2 v11.1q, v14.2d, v22.2d
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 ldp q28, q26, [x8, #128]
 pmull v22.1q, v14.1d, v22.1d
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
.inst 0xce082a31
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 trn2 v14.2d, v15.2d, v14.2d
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 eor v12.16b, v12.16b, v16.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 eor v14.16b, v14.16b, v13.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 pmull2 v16.1q, v12.2d, v24.2d
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 pmull v24.1q, v12.1d, v24.1d
 pmull2 v12.1q, v15.2d, v20.2d
 pmull2 v13.1q, v14.2d, v21.2d
 pmull v21.1q, v14.1d, v21.1d
 pmull v20.1q, v15.1d, v20.1d
 ldp q27, q28, [x8, #160]
.inst 0xce195e73
.inst 0xce184252
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
.inst 0xce0b3231
.inst 0xce165273
 ldr d16, [x10]
.inst 0xce153652
 aese v4.16b, v27.16b
 aesmc v4.16b, v4.16b
 aese v6.16b, v27.16b
 aesmc v6.16b, v6.16b
 aese v5.16b, v27.16b
 aesmc v5.16b, v5.16b
 aese v0.16b, v27.16b
 aesmc v0.16b, v0.16b
 aese v2.16b, v27.16b
 aesmc v2.16b, v2.16b
 aese v3.16b, v27.16b
 aesmc v3.16b, v3.16b
.inst 0xce114e52
 aese v7.16b, v27.16b
 aesmc v7.16b, v7.16b
 aese v1.16b, v27.16b
 aesmc v1.16b, v1.16b
 ldp q26, q27, [x8, #192]
 ext v21.16b, v17.16b, v17.16b, #8
 aese v2.16b, v28.16b
 aesmc v2.16b, v2.16b
 aese v1.16b, v28.16b
 aesmc v1.16b, v1.16b
 aese v0.16b, v28.16b
 aesmc v0.16b, v0.16b
 pmull v29.1q, v17.1d, v16.1d
 aese v3.16b, v28.16b
 aesmc v3.16b, v3.16b
 aese v7.16b, v28.16b
 aesmc v7.16b, v7.16b
 aese v6.16b, v28.16b
 aesmc v6.16b, v6.16b
 aese v4.16b, v28.16b
 aesmc v4.16b, v4.16b
 aese v5.16b, v28.16b
 aesmc v5.16b, v5.16b
 aese v3.16b, v26.16b
 aesmc v3.16b, v3.16b
.inst 0xce1d5652
 aese v3.16b, v27.16b
 aese v2.16b, v26.16b
 aesmc v2.16b, v2.16b
 aese v6.16b, v26.16b
 aesmc v6.16b, v6.16b
 pmull v17.1q, v18.1d, v16.1d
 aese v4.16b, v26.16b
 aesmc v4.16b, v4.16b
 aese v7.16b, v26.16b
 aesmc v7.16b, v7.16b
 aese v0.16b, v26.16b
 aesmc v0.16b, v0.16b
 ldr q28, [x8, #224]
 aese v1.16b, v26.16b
 aesmc v1.16b, v1.16b
 aese v4.16b, v27.16b
 ext v21.16b, v18.16b, v18.16b, #8
 aese v5.16b, v26.16b
 aesmc v5.16b, v5.16b
 aese v6.16b, v27.16b
 aese v2.16b, v27.16b
 aese v1.16b, v27.16b
 aese v5.16b, v27.16b
.inst 0xce154673
 add v30.4s, v30.4s, v31.4s
 aese v7.16b, v27.16b
 aese v0.16b, v27.16b
.L256_dec_tail:
 ext v16.16b, v19.16b, v19.16b, #8
 sub x5, x4, x0
 cmp x5, #112
 ldr q9, [x0], #16
 ldp q24, q25, [x3, #192]
 ext v25.16b, v25.16b, v25.16b, #8
 mov v29.16b, v28.16b
 ldp q20, q21, [x3, #128]
 ext v20.16b, v20.16b, v20.16b, #8
.inst 0xce00752c
 ldp q22, q23, [x3, #160]
 ext v22.16b, v22.16b, v22.16b, #8
 ext v23.16b, v23.16b, v23.16b, #8
 b.gt .L256_dec_blocks_more_than_7
 mov v7.16b, v6.16b
 sub v30.4s, v30.4s, v31.4s
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v3.16b
 movi v19.8b, #0
 movi v17.8b, #0
 movi v18.8b, #0
 mov v3.16b, v2.16b
 cmp x5, #96
 mov v2.16b, v1.16b
 b.gt .L256_dec_blocks_more_than_6
 mov v7.16b, v6.16b
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 cmp x5, #80
 sub v30.4s, v30.4s, v31.4s
 mov v4.16b, v3.16b
 mov v3.16b, v1.16b
 b.gt .L256_dec_blocks_more_than_5
 cmp x5, #64
 mov v7.16b, v6.16b
 sub v30.4s, v30.4s, v31.4s
 mov v6.16b, v5.16b
 mov v5.16b, v4.16b
 mov v4.16b, v1.16b
 b.gt .L256_dec_blocks_more_than_4
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 cmp x5, #48
 mov v6.16b, v5.16b
 mov v5.16b, v1.16b
 b.gt .L256_dec_blocks_more_than_3
 ldr q24, [x3, #96]
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v6.16b
 cmp x5, #32
 mov v6.16b, v1.16b
 b.gt .L256_dec_blocks_more_than_2
 sub v30.4s, v30.4s, v31.4s
 mov v7.16b, v1.16b
 cmp x5, #16
 b.gt .L256_dec_blocks_more_than_1
 sub v30.4s, v30.4s, v31.4s
 ldr q21, [x3, #48]
 b .L256_dec_blocks_less_than_1
.L256_dec_blocks_more_than_7:
 rev64 v8.16b, v9.16b
 ldr q9, [x0], #16
 st1 { v12.16b}, [x2], #16
 ins v18.d[0], v24.d[1]
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
.inst 0xce01752c
 pmull2 v17.1q, v8.2d, v25.2d
 eor v27.8b, v27.8b, v8.8b
 movi v16.8b, #0
 pmull v19.1q, v8.1d, v25.1d
 pmull v18.1q, v27.1d, v18.1d
.L256_dec_blocks_more_than_6:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 movi v16.8b, #0
 ins v27.d[0], v8.d[1]
 st1 { v12.16b}, [x2], #16
 pmull2 v28.1q, v8.2d, v23.2d
 pmull v26.1q, v8.1d, v23.1d
.inst 0xce02752c
 eor v19.16b, v19.16b, v26.16b
 eor v27.8b, v27.8b, v8.8b
 pmull v27.1q, v27.1d, v24.1d
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L256_dec_blocks_more_than_5:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 pmull2 v28.1q, v8.2d, v22.2d
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 eor v27.8b, v27.8b, v8.8b
 st1 { v12.16b}, [x2], #16
 pmull v26.1q, v8.1d, v22.1d
 ins v27.d[1], v27.d[0]
 pmull2 v27.1q, v27.2d, v21.2d
 eor v17.16b, v17.16b, v28.16b
.inst 0xce03752c
 eor v19.16b, v19.16b, v26.16b
 eor v18.16b, v18.16b, v27.16b
 movi v16.8b, #0
.L256_dec_blocks_more_than_4:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q9, [x0], #16
 movi v16.8b, #0
 pmull v26.1q, v8.1d, v20.1d
 pmull2 v28.1q, v8.2d, v20.2d
 eor v27.8b, v27.8b, v8.8b
 eor v17.16b, v17.16b, v28.16b
 pmull v27.1q, v27.1d, v21.1d
 eor v19.16b, v19.16b, v26.16b
 st1 { v12.16b}, [x2], #16
 eor v18.16b, v18.16b, v27.16b
.inst 0xce04752c
.L256_dec_blocks_more_than_3:
 ldr q25, [x3, #112]
 ext v25.16b, v25.16b, v25.16b, #8
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ldr q9, [x0], #16
 ldr q24, [x3, #96]
 ins v27.d[0], v8.d[1]
 st1 { v12.16b}, [x2], #16
.inst 0xce05752c
 eor v27.8b, v27.8b, v8.8b
 ins v27.d[1], v27.d[0]
 pmull v26.1q, v8.1d, v25.1d
 pmull2 v28.1q, v8.2d, v25.2d
 movi v16.8b, #0
 pmull2 v27.1q, v27.2d, v24.2d
 eor v19.16b, v19.16b, v26.16b
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
.L256_dec_blocks_more_than_2:
 rev64 v8.16b, v9.16b
 ldr q23, [x3, #80]
 ext v23.16b, v23.16b, v23.16b, #8
 ldr q9, [x0], #16
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 pmull v26.1q, v8.1d, v23.1d
 st1 { v12.16b}, [x2], #16
.inst 0xce06752c
 eor v27.8b, v27.8b, v8.8b
 eor v19.16b, v19.16b, v26.16b
 movi v16.8b, #0
 pmull v27.1q, v27.1d, v24.1d
 pmull2 v28.1q, v8.2d, v23.2d
 eor v18.16b, v18.16b, v27.16b
 eor v17.16b, v17.16b, v28.16b
.L256_dec_blocks_more_than_1:
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v27.d[0], v8.d[1]
 ldr q22, [x3, #64]
 ext v22.16b, v22.16b, v22.16b, #8
 eor v27.8b, v27.8b, v8.8b
 ldr q9, [x0], #16
 st1 { v12.16b}, [x2], #16
 ldr q21, [x3, #48]
 pmull v26.1q, v8.1d, v22.1d
 ins v27.d[1], v27.d[0]
 eor v19.16b, v19.16b, v26.16b
.inst 0xce07752c
 pmull2 v28.1q, v8.2d, v22.2d
 pmull2 v27.1q, v27.2d, v21.2d
 movi v16.8b, #0
 eor v17.16b, v17.16b, v28.16b
 eor v18.16b, v18.16b, v27.16b
.L256_dec_blocks_less_than_1:
 ld1 { v26.16b}, [x2]
 mvn x6, xzr
 and x1, x1, #127
 sub x1, x1, #128
 rev32 v30.16b, v30.16b
 str q30, [x16]
 neg x1, x1
 and x1, x1, #127
 lsr x6, x6, x1
 cmp x1, #64
 mvn x7, xzr
 csel x14, x6, xzr, lt
 csel x13, x7, x6, lt
 mov v0.d[0], x13
 mov v0.d[1], x14
 and v9.16b, v9.16b, v0.16b
 ldr q20, [x3, #32]
 ext v20.16b, v20.16b, v20.16b, #8
 bif v12.16b, v26.16b, v0.16b
 rev64 v8.16b, v9.16b
 eor v8.16b, v8.16b, v16.16b
 ins v16.d[0], v8.d[1]
 pmull2 v28.1q, v8.2d, v20.2d
 eor v16.8b, v16.8b, v8.8b
 pmull v26.1q, v8.1d, v20.1d
 eor v17.16b, v17.16b, v28.16b
 pmull v16.1q, v16.1d, v21.1d
 eor v18.16b, v18.16b, v16.16b
 ldr d16, [x10]
 eor v19.16b, v19.16b, v26.16b
 pmull v21.1q, v17.1d, v16.1d
 eor v14.16b, v17.16b, v19.16b
 ext v17.16b, v17.16b, v17.16b, #8
 st1 { v12.16b}, [x2]
 eor v18.16b, v18.16b, v14.16b
 eor v21.16b, v17.16b, v21.16b
 eor v18.16b, v18.16b, v21.16b
 pmull v17.1q, v18.1d, v16.1d
 ext v18.16b, v18.16b, v18.16b, #8
 eor v19.16b, v19.16b, v17.16b
 eor v19.16b, v19.16b, v18.16b
 ext v19.16b, v19.16b, v19.16b, #8
 rev64 v19.16b, v19.16b
 st1 { v19.16b }, [x3]
 mov x0, x9
 ldp d10, d11, [sp, #16]
 ldp d12, d13, [sp, #32]
 ldp d14, d15, [sp, #48]
 ldp d8, d9, [sp], #80
 ret
.L256_dec_ret:
 mov w0, #0x0
 ret
.size unroll8_eor3_aes_gcm_dec_256_kernel,.-unroll8_eor3_aes_gcm_dec_256_kernel
.byte 65,69,83,32,71,67,77,32,109,111,100,117,108,101,32,102,111,114,32,65,82,77,118,56,44,32,83,80,68,88,32,66,83,68,45,51,45,67,108,97,117,115,101,32,98,121,32,60,120,105,97,111,107,97,110,103,46,113,105,97,110,64,97,114,109,46,99,111,109,62,0
.align 2
.align 2
