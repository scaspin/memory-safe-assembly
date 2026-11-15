
.text
.type _bsaes_decrypt8,%function
.align 4
_bsaes_decrypt8:
 ldr q8, [x9], #16
 adrp x11, .LM0ISR
 add x11, x11, :lo12:.LM0ISR
 movi v9.16b, #0x55
 ldr q10, [x11], #16
 movi v16.16b, #0x33
 movi v17.16b, #0x0f
 sub x10, x10, #1
 eor v0.16b, v0.16b, v8.16b
 eor v1.16b, v1.16b, v8.16b
 eor v2.16b, v2.16b, v8.16b
 eor v4.16b, v4.16b, v8.16b
 eor v3.16b, v3.16b, v8.16b
 eor v5.16b, v5.16b, v8.16b
 tbl v0.16b, {v0.16b}, v10.16b
 tbl v1.16b, {v1.16b}, v10.16b
 tbl v2.16b, {v2.16b}, v10.16b
 tbl v4.16b, {v4.16b}, v10.16b
 eor v6.16b, v6.16b, v8.16b
 eor v7.16b, v7.16b, v8.16b
 tbl v3.16b, {v3.16b}, v10.16b
 tbl v5.16b, {v5.16b}, v10.16b
 tbl v6.16b, {v6.16b}, v10.16b
 ushr v8.2d, v0.2d, #1
 tbl v7.16b, {v7.16b}, v10.16b
 ushr v10.2d, v4.2d, #1
 ushr v18.2d, v2.2d, #1
 eor v8.16b, v8.16b, v1.16b
 ushr v19.2d, v6.2d, #1
 eor v10.16b, v10.16b, v5.16b
 eor v18.16b, v18.16b, v3.16b
 and v8.16b, v8.16b, v9.16b
 eor v19.16b, v19.16b, v7.16b
 and v10.16b, v10.16b, v9.16b
 and v18.16b, v18.16b, v9.16b
 eor v1.16b, v1.16b, v8.16b
 shl v8.2d, v8.2d, #1
 and v9.16b, v19.16b, v9.16b
 eor v5.16b, v5.16b, v10.16b
 shl v10.2d, v10.2d, #1
 eor v3.16b, v3.16b, v18.16b
 shl v18.2d, v18.2d, #1
 eor v0.16b, v0.16b, v8.16b
 shl v8.2d, v9.2d, #1
 eor v7.16b, v7.16b, v9.16b
 eor v4.16b, v4.16b, v10.16b
 eor v2.16b, v2.16b, v18.16b
 ushr v9.2d, v1.2d, #2
 eor v6.16b, v6.16b, v8.16b
 ushr v8.2d, v0.2d, #2
 ushr v10.2d, v5.2d, #2
 ushr v18.2d, v4.2d, #2
 eor v9.16b, v9.16b, v3.16b
 eor v8.16b, v8.16b, v2.16b
 eor v10.16b, v10.16b, v7.16b
 eor v18.16b, v18.16b, v6.16b
 and v9.16b, v9.16b, v16.16b
 and v8.16b, v8.16b, v16.16b
 and v10.16b, v10.16b, v16.16b
 and v16.16b, v18.16b, v16.16b
 eor v3.16b, v3.16b, v9.16b
 shl v9.2d, v9.2d, #2
 eor v2.16b, v2.16b, v8.16b
 shl v8.2d, v8.2d, #2
 eor v7.16b, v7.16b, v10.16b
 shl v10.2d, v10.2d, #2
 eor v6.16b, v6.16b, v16.16b
 shl v16.2d, v16.2d, #2
 eor v1.16b, v1.16b, v9.16b
 eor v0.16b, v0.16b, v8.16b
 eor v5.16b, v5.16b, v10.16b
 eor v4.16b, v4.16b, v16.16b
 ushr v8.2d, v3.2d, #4
 ushr v9.2d, v2.2d, #4
 ushr v10.2d, v1.2d, #4
 ushr v16.2d, v0.2d, #4
 eor v8.16b, v8.16b, v7.16b
 eor v9.16b, v9.16b, v6.16b
 eor v10.16b, v10.16b, v5.16b
 eor v16.16b, v16.16b, v4.16b
 and v8.16b, v8.16b, v17.16b
 and v9.16b, v9.16b, v17.16b
 and v10.16b, v10.16b, v17.16b
 and v16.16b, v16.16b, v17.16b
 eor v7.16b, v7.16b, v8.16b
 shl v8.2d, v8.2d, #4
 eor v6.16b, v6.16b, v9.16b
 shl v9.2d, v9.2d, #4
 eor v5.16b, v5.16b, v10.16b
 shl v10.2d, v10.2d, #4
 eor v4.16b, v4.16b, v16.16b
 shl v16.2d, v16.2d, #4
 eor v3.16b, v3.16b, v8.16b
 eor v2.16b, v2.16b, v9.16b
 eor v1.16b, v1.16b, v10.16b
 eor v0.16b, v0.16b, v16.16b
 b .Ldec_sbox
.align 4
.Ldec_loop:
 ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x9], #64
 ldp q8, q9, [x9], #32
 eor v0.16b, v16.16b, v0.16b
 ldr q10, [x9], #16
 eor v1.16b, v17.16b, v1.16b
 ldr q16, [x9], #16
 eor v2.16b, v18.16b, v2.16b
 eor v3.16b, v19.16b, v3.16b
 eor v4.16b, v8.16b, v4.16b
 eor v5.16b, v9.16b, v5.16b
 eor v6.16b, v10.16b, v6.16b
 eor v7.16b, v16.16b, v7.16b
 tbl v0.16b, {v0.16b}, v28.16b
 tbl v1.16b, {v1.16b}, v28.16b
 tbl v2.16b, {v2.16b}, v28.16b
 tbl v3.16b, {v3.16b}, v28.16b
 tbl v4.16b, {v4.16b}, v28.16b
 tbl v5.16b, {v5.16b}, v28.16b
 tbl v6.16b, {v6.16b}, v28.16b
 tbl v7.16b, {v7.16b}, v28.16b
.Ldec_sbox:
 eor v1.16b, v1.16b, v4.16b
 eor v3.16b, v3.16b, v4.16b
 subs x10, x10, #1
 eor v4.16b, v4.16b, v7.16b
 eor v2.16b, v2.16b, v7.16b
 eor v1.16b, v1.16b, v6.16b
 eor v6.16b, v6.16b, v4.16b
 eor v2.16b, v2.16b, v5.16b
 eor v0.16b, v0.16b, v1.16b
 eor v7.16b, v7.16b, v6.16b
 eor v8.16b, v6.16b, v2.16b
 and v9.16b, v4.16b, v6.16b
 eor v10.16b, v2.16b, v6.16b
 eor v3.16b, v3.16b, v0.16b
 eor v5.16b, v5.16b, v0.16b
 eor v16.16b, v7.16b, v4.16b
 eor v17.16b, v4.16b, v0.16b
 and v18.16b, v0.16b, v2.16b
 eor v19.16b, v7.16b, v4.16b
 eor v1.16b, v1.16b, v3.16b
 eor v20.16b, v3.16b, v0.16b
 eor v21.16b, v5.16b, v2.16b
 eor v22.16b, v3.16b, v7.16b
 and v8.16b, v17.16b, v8.16b
 orr v17.16b, v3.16b, v5.16b
 eor v23.16b, v1.16b, v6.16b
 eor v24.16b, v20.16b, v16.16b
 eor v25.16b, v1.16b, v5.16b
 orr v26.16b, v20.16b, v21.16b
 and v20.16b, v20.16b, v21.16b
 and v27.16b, v7.16b, v1.16b
 eor v21.16b, v21.16b, v23.16b
 orr v28.16b, v16.16b, v23.16b
 orr v29.16b, v22.16b, v25.16b
 eor v26.16b, v26.16b, v8.16b
 and v16.16b, v16.16b, v23.16b
 and v22.16b, v22.16b, v25.16b
 and v21.16b, v24.16b, v21.16b
 eor v8.16b, v28.16b, v8.16b
 eor v23.16b, v5.16b, v2.16b
 eor v24.16b, v1.16b, v6.16b
 eor v16.16b, v16.16b, v22.16b
 eor v22.16b, v3.16b, v0.16b
 eor v25.16b, v29.16b, v21.16b
 eor v21.16b, v26.16b, v21.16b
 eor v8.16b, v8.16b, v20.16b
 eor v26.16b, v23.16b, v24.16b
 eor v16.16b, v16.16b, v20.16b
 eor v28.16b, v22.16b, v19.16b
 eor v20.16b, v25.16b, v20.16b
 eor v9.16b, v21.16b, v9.16b
 eor v8.16b, v8.16b, v18.16b
 eor v18.16b, v5.16b, v1.16b
 eor v21.16b, v16.16b, v17.16b
 eor v16.16b, v16.16b, v17.16b
 eor v17.16b, v20.16b, v27.16b
 eor v20.16b, v3.16b, v7.16b
 eor v25.16b, v9.16b, v8.16b
 eor v27.16b, v0.16b, v4.16b
 and v29.16b, v9.16b, v17.16b
 eor v30.16b, v8.16b, v29.16b
 eor v31.16b, v21.16b, v29.16b
 eor v29.16b, v21.16b, v29.16b
 bsl v30.16b, v17.16b, v21.16b
 bsl v31.16b, v9.16b, v8.16b
 bsl v16.16b, v30.16b, v29.16b
 bsl v21.16b, v29.16b, v30.16b
 eor v8.16b, v31.16b, v30.16b
 and v1.16b, v1.16b, v31.16b
 and v9.16b, v16.16b, v31.16b
 and v6.16b, v6.16b, v30.16b
 eor v16.16b, v17.16b, v21.16b
 and v4.16b, v4.16b, v30.16b
 eor v17.16b, v8.16b, v30.16b
 and v21.16b, v24.16b, v8.16b
 eor v9.16b, v9.16b, v25.16b
 and v19.16b, v19.16b, v8.16b
 eor v24.16b, v30.16b, v16.16b
 eor v25.16b, v30.16b, v16.16b
 and v7.16b, v7.16b, v17.16b
 and v10.16b, v10.16b, v16.16b
 eor v29.16b, v9.16b, v16.16b
 eor v30.16b, v31.16b, v9.16b
 and v0.16b, v24.16b, v0.16b
 and v9.16b, v18.16b, v9.16b
 and v2.16b, v25.16b, v2.16b
 eor v10.16b, v10.16b, v6.16b
 eor v18.16b, v29.16b, v16.16b
 and v5.16b, v30.16b, v5.16b
 eor v24.16b, v8.16b, v29.16b
 and v25.16b, v26.16b, v29.16b
 and v26.16b, v28.16b, v29.16b
 eor v8.16b, v8.16b, v29.16b
 eor v17.16b, v17.16b, v18.16b
 eor v5.16b, v1.16b, v5.16b
 and v23.16b, v24.16b, v23.16b
 eor v21.16b, v21.16b, v25.16b
 eor v19.16b, v19.16b, v26.16b
 eor v0.16b, v4.16b, v0.16b
 and v3.16b, v17.16b, v3.16b
 eor v1.16b, v9.16b, v1.16b
 eor v9.16b, v25.16b, v23.16b
 eor v5.16b, v5.16b, v21.16b
 eor v2.16b, v6.16b, v2.16b
 and v6.16b, v8.16b, v22.16b
 eor v3.16b, v7.16b, v3.16b
 and v8.16b, v20.16b, v18.16b
 eor v10.16b, v10.16b, v9.16b
 eor v0.16b, v0.16b, v19.16b
 eor v9.16b, v1.16b, v9.16b
 eor v1.16b, v2.16b, v21.16b
 eor v3.16b, v3.16b, v19.16b
 and v16.16b, v27.16b, v16.16b
 eor v17.16b, v26.16b, v6.16b
 eor v6.16b, v8.16b, v7.16b
 eor v7.16b, v1.16b, v9.16b
 eor v1.16b, v5.16b, v3.16b
 eor v2.16b, v10.16b, v3.16b
 eor v4.16b, v16.16b, v4.16b
 eor v8.16b, v6.16b, v17.16b
 eor v5.16b, v9.16b, v3.16b
 eor v9.16b, v0.16b, v1.16b
 eor v6.16b, v7.16b, v1.16b
 eor v0.16b, v4.16b, v17.16b
 eor v4.16b, v8.16b, v7.16b
 eor v7.16b, v9.16b, v2.16b
 eor v8.16b, v3.16b, v0.16b
 eor v7.16b, v7.16b, v5.16b
 eor v3.16b, v4.16b, v7.16b
 eor v4.16b, v7.16b, v0.16b
 eor v7.16b, v8.16b, v3.16b
 bcc .Ldec_done
 ext v8.16b, v0.16b, v0.16b, #8
 ext v9.16b, v1.16b, v1.16b, #8
 ldr q28, [x11]
 ext v10.16b, v6.16b, v6.16b, #8
 ext v16.16b, v3.16b, v3.16b, #8
 ext v17.16b, v5.16b, v5.16b, #8
 ext v18.16b, v4.16b, v4.16b, #8
 eor v8.16b, v8.16b, v0.16b
 eor v9.16b, v9.16b, v1.16b
 eor v10.16b, v10.16b, v6.16b
 eor v16.16b, v16.16b, v3.16b
 eor v17.16b, v17.16b, v5.16b
 ext v19.16b, v2.16b, v2.16b, #8
 ext v20.16b, v7.16b, v7.16b, #8
 eor v18.16b, v18.16b, v4.16b
 eor v6.16b, v6.16b, v8.16b
 eor v8.16b, v2.16b, v10.16b
 eor v4.16b, v4.16b, v9.16b
 eor v2.16b, v19.16b, v2.16b
 eor v9.16b, v20.16b, v7.16b
 eor v0.16b, v0.16b, v16.16b
 eor v1.16b, v1.16b, v16.16b
 eor v6.16b, v6.16b, v17.16b
 eor v8.16b, v8.16b, v16.16b
 eor v7.16b, v7.16b, v18.16b
 eor v4.16b, v4.16b, v16.16b
 eor v2.16b, v3.16b, v2.16b
 eor v1.16b, v1.16b, v17.16b
 eor v3.16b, v5.16b, v9.16b
 eor v5.16b, v8.16b, v17.16b
 eor v7.16b, v7.16b, v17.16b
 ext v8.16b, v0.16b, v0.16b, #12
 ext v9.16b, v6.16b, v6.16b, #12
 ext v10.16b, v4.16b, v4.16b, #12
 ext v16.16b, v1.16b, v1.16b, #12
 ext v17.16b, v5.16b, v5.16b, #12
 ext v18.16b, v7.16b, v7.16b, #12
 eor v0.16b, v0.16b, v8.16b
 eor v6.16b, v6.16b, v9.16b
 eor v4.16b, v4.16b, v10.16b
 ext v19.16b, v2.16b, v2.16b, #12
 ext v20.16b, v3.16b, v3.16b, #12
 eor v1.16b, v1.16b, v16.16b
 eor v5.16b, v5.16b, v17.16b
 eor v7.16b, v7.16b, v18.16b
 eor v2.16b, v2.16b, v19.16b
 eor v16.16b, v16.16b, v0.16b
 eor v3.16b, v3.16b, v20.16b
 eor v17.16b, v17.16b, v4.16b
 eor v10.16b, v10.16b, v6.16b
 ext v0.16b, v0.16b, v0.16b, #8
 eor v9.16b, v9.16b, v1.16b
 ext v1.16b, v1.16b, v1.16b, #8
 eor v8.16b, v8.16b, v3.16b
 eor v16.16b, v16.16b, v3.16b
 eor v18.16b, v18.16b, v5.16b
 eor v19.16b, v19.16b, v7.16b
 ext v21.16b, v5.16b, v5.16b, #8
 ext v5.16b, v7.16b, v7.16b, #8
 eor v7.16b, v20.16b, v2.16b
 ext v4.16b, v4.16b, v4.16b, #8
 ext v20.16b, v3.16b, v3.16b, #8
 eor v17.16b, v17.16b, v3.16b
 ext v2.16b, v2.16b, v2.16b, #8
 eor v3.16b, v10.16b, v3.16b
 ext v10.16b, v6.16b, v6.16b, #8
 eor v0.16b, v0.16b, v8.16b
 eor v1.16b, v1.16b, v16.16b
 eor v5.16b, v5.16b, v18.16b
 eor v3.16b, v3.16b, v4.16b
 eor v7.16b, v20.16b, v7.16b
 eor v6.16b, v2.16b, v19.16b
 eor v4.16b, v21.16b, v17.16b
 eor v2.16b, v10.16b, v9.16b
 bne .Ldec_loop
 ldr q28, [x11, #16]!
 b .Ldec_loop
.align 4
.Ldec_done:
 ushr v8.2d, v0.2d, #1
 movi v9.16b, #0x55
 ldr q10, [x9]
 ushr v16.2d, v2.2d, #1
 movi v17.16b, #0x33
 ushr v18.2d, v6.2d, #1
 movi v19.16b, #0x0f
 eor v8.16b, v8.16b, v1.16b
 ushr v20.2d, v3.2d, #1
 eor v16.16b, v16.16b, v7.16b
 eor v18.16b, v18.16b, v4.16b
 and v8.16b, v8.16b, v9.16b
 eor v20.16b, v20.16b, v5.16b
 and v16.16b, v16.16b, v9.16b
 and v18.16b, v18.16b, v9.16b
 shl v21.2d, v8.2d, #1
 eor v1.16b, v1.16b, v8.16b
 and v8.16b, v20.16b, v9.16b
 eor v7.16b, v7.16b, v16.16b
 shl v9.2d, v16.2d, #1
 eor v4.16b, v4.16b, v18.16b
 shl v16.2d, v18.2d, #1
 eor v0.16b, v0.16b, v21.16b
 shl v18.2d, v8.2d, #1
 eor v5.16b, v5.16b, v8.16b
 eor v2.16b, v2.16b, v9.16b
 eor v6.16b, v6.16b, v16.16b
 ushr v8.2d, v1.2d, #2
 eor v3.16b, v3.16b, v18.16b
 ushr v9.2d, v0.2d, #2
 ushr v16.2d, v7.2d, #2
 ushr v18.2d, v2.2d, #2
 eor v8.16b, v8.16b, v4.16b
 eor v9.16b, v9.16b, v6.16b
 eor v16.16b, v16.16b, v5.16b
 eor v18.16b, v18.16b, v3.16b
 and v8.16b, v8.16b, v17.16b
 and v9.16b, v9.16b, v17.16b
 and v16.16b, v16.16b, v17.16b
 and v17.16b, v18.16b, v17.16b
 eor v4.16b, v4.16b, v8.16b
 shl v8.2d, v8.2d, #2
 eor v6.16b, v6.16b, v9.16b
 shl v9.2d, v9.2d, #2
 eor v5.16b, v5.16b, v16.16b
 shl v16.2d, v16.2d, #2
 eor v3.16b, v3.16b, v17.16b
 shl v17.2d, v17.2d, #2
 eor v1.16b, v1.16b, v8.16b
 eor v0.16b, v0.16b, v9.16b
 eor v7.16b, v7.16b, v16.16b
 eor v2.16b, v2.16b, v17.16b
 ushr v8.2d, v4.2d, #4
 ushr v9.2d, v6.2d, #4
 ushr v16.2d, v1.2d, #4
 ushr v17.2d, v0.2d, #4
 eor v8.16b, v8.16b, v5.16b
 eor v9.16b, v9.16b, v3.16b
 eor v16.16b, v16.16b, v7.16b
 eor v17.16b, v17.16b, v2.16b
 and v8.16b, v8.16b, v19.16b
 and v9.16b, v9.16b, v19.16b
 and v16.16b, v16.16b, v19.16b
 and v17.16b, v17.16b, v19.16b
 eor v5.16b, v5.16b, v8.16b
 shl v8.2d, v8.2d, #4
 eor v3.16b, v3.16b, v9.16b
 shl v9.2d, v9.2d, #4
 eor v7.16b, v7.16b, v16.16b
 shl v16.2d, v16.2d, #4
 eor v2.16b, v2.16b, v17.16b
 shl v17.2d, v17.2d, #4
 eor v4.16b, v4.16b, v8.16b
 eor v6.16b, v6.16b, v9.16b
 eor v7.16b, v7.16b, v10.16b
 eor v1.16b, v1.16b, v16.16b
 eor v2.16b, v2.16b, v10.16b
 eor v0.16b, v0.16b, v17.16b
 eor v4.16b, v4.16b, v10.16b
 eor v6.16b, v6.16b, v10.16b
 eor v3.16b, v3.16b, v10.16b
 eor v5.16b, v5.16b, v10.16b
 eor v1.16b, v1.16b, v10.16b
 eor v0.16b, v0.16b, v10.16b
 ret
.size _bsaes_decrypt8,.-_bsaes_decrypt8
.section .rodata
.type _bsaes_consts,%object
.align 6
_bsaes_consts:
.LM0ISR:
.quad 0x0a0e0206070b0f03, 0x0004080c0d010509
.LISR:
.quad 0x0504070602010003, 0x0f0e0d0c080b0a09
.LISRM0:
.quad 0x01040b0e0205080f, 0x0306090c00070a0d
.LM0SR:
.quad 0x0a0e02060f03070b, 0x0004080c05090d01
.LSR:
.quad 0x0504070600030201, 0x0f0e0d0c0a09080b
.LSRM0:
.quad 0x0304090e00050a0f, 0x01060b0c0207080d
.LM0_bigendian:
.quad 0x02060a0e03070b0f, 0x0004080c0105090d
.LM0_littleendian:
.quad 0x0105090d0004080c, 0x03070b0f02060a0e
.LREVM0SR:
.quad 0x090d01050c000408, 0x03070b0f060a0e02
.align 6
.size _bsaes_consts,.-_bsaes_consts
.previous
.type _bsaes_encrypt8,%function
.align 4
_bsaes_encrypt8:
 ldr q8, [x9], #16
 adrp x11, .LM0SR
 add x11, x11, :lo12:.LM0SR
 ldr q9, [x11], #16
_bsaes_encrypt8_alt:
 eor v0.16b, v0.16b, v8.16b
 eor v1.16b, v1.16b, v8.16b
 sub x10, x10, #1
 eor v2.16b, v2.16b, v8.16b
 eor v4.16b, v4.16b, v8.16b
 eor v3.16b, v3.16b, v8.16b
 eor v5.16b, v5.16b, v8.16b
 tbl v0.16b, {v0.16b}, v9.16b
 tbl v1.16b, {v1.16b}, v9.16b
 tbl v2.16b, {v2.16b}, v9.16b
 tbl v4.16b, {v4.16b}, v9.16b
 eor v6.16b, v6.16b, v8.16b
 eor v7.16b, v7.16b, v8.16b
 tbl v3.16b, {v3.16b}, v9.16b
 tbl v5.16b, {v5.16b}, v9.16b
 tbl v6.16b, {v6.16b}, v9.16b
 ushr v8.2d, v0.2d, #1
 movi v10.16b, #0x55
 tbl v7.16b, {v7.16b}, v9.16b
 ushr v9.2d, v4.2d, #1
 movi v16.16b, #0x33
 ushr v17.2d, v2.2d, #1
 eor v8.16b, v8.16b, v1.16b
 movi v18.16b, #0x0f
 ushr v19.2d, v6.2d, #1
 eor v9.16b, v9.16b, v5.16b
 eor v17.16b, v17.16b, v3.16b
 and v8.16b, v8.16b, v10.16b
 eor v19.16b, v19.16b, v7.16b
 and v9.16b, v9.16b, v10.16b
 and v17.16b, v17.16b, v10.16b
 eor v1.16b, v1.16b, v8.16b
 shl v8.2d, v8.2d, #1
 and v10.16b, v19.16b, v10.16b
 eor v5.16b, v5.16b, v9.16b
 shl v9.2d, v9.2d, #1
 eor v3.16b, v3.16b, v17.16b
 shl v17.2d, v17.2d, #1
 eor v0.16b, v0.16b, v8.16b
 shl v8.2d, v10.2d, #1
 eor v7.16b, v7.16b, v10.16b
 eor v4.16b, v4.16b, v9.16b
 eor v2.16b, v2.16b, v17.16b
 ushr v9.2d, v1.2d, #2
 eor v6.16b, v6.16b, v8.16b
 ushr v8.2d, v0.2d, #2
 ushr v10.2d, v5.2d, #2
 ushr v17.2d, v4.2d, #2
 eor v9.16b, v9.16b, v3.16b
 eor v8.16b, v8.16b, v2.16b
 eor v10.16b, v10.16b, v7.16b
 eor v17.16b, v17.16b, v6.16b
 and v9.16b, v9.16b, v16.16b
 and v8.16b, v8.16b, v16.16b
 and v10.16b, v10.16b, v16.16b
 and v16.16b, v17.16b, v16.16b
 eor v3.16b, v3.16b, v9.16b
 shl v9.2d, v9.2d, #2
 eor v2.16b, v2.16b, v8.16b
 shl v8.2d, v8.2d, #2
 eor v7.16b, v7.16b, v10.16b
 shl v10.2d, v10.2d, #2
 eor v6.16b, v6.16b, v16.16b
 shl v16.2d, v16.2d, #2
 eor v1.16b, v1.16b, v9.16b
 eor v0.16b, v0.16b, v8.16b
 eor v5.16b, v5.16b, v10.16b
 eor v4.16b, v4.16b, v16.16b
 ushr v8.2d, v3.2d, #4
 ushr v9.2d, v2.2d, #4
 ushr v10.2d, v1.2d, #4
 ushr v16.2d, v0.2d, #4
 eor v8.16b, v8.16b, v7.16b
 eor v9.16b, v9.16b, v6.16b
 eor v10.16b, v10.16b, v5.16b
 eor v16.16b, v16.16b, v4.16b
 and v8.16b, v8.16b, v18.16b
 and v9.16b, v9.16b, v18.16b
 and v10.16b, v10.16b, v18.16b
 and v16.16b, v16.16b, v18.16b
 eor v7.16b, v7.16b, v8.16b
 shl v8.2d, v8.2d, #4
 eor v6.16b, v6.16b, v9.16b
 shl v9.2d, v9.2d, #4
 eor v5.16b, v5.16b, v10.16b
 shl v10.2d, v10.2d, #4
 eor v4.16b, v4.16b, v16.16b
 shl v16.2d, v16.2d, #4
 eor v3.16b, v3.16b, v8.16b
 eor v2.16b, v2.16b, v9.16b
 eor v1.16b, v1.16b, v10.16b
 eor v0.16b, v0.16b, v16.16b
 b .Lenc_sbox
.align 4
.Lenc_loop:
 ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x9], #64
 ldp q8, q9, [x9], #32
 eor v0.16b, v16.16b, v0.16b
 ldr q10, [x9], #16
 eor v1.16b, v17.16b, v1.16b
 ldr q16, [x9], #16
 eor v2.16b, v18.16b, v2.16b
 eor v3.16b, v19.16b, v3.16b
 eor v4.16b, v8.16b, v4.16b
 eor v5.16b, v9.16b, v5.16b
 eor v6.16b, v10.16b, v6.16b
 eor v7.16b, v16.16b, v7.16b
 tbl v0.16b, {v0.16b}, v28.16b
 tbl v1.16b, {v1.16b}, v28.16b
 tbl v2.16b, {v2.16b}, v28.16b
 tbl v3.16b, {v3.16b}, v28.16b
 tbl v4.16b, {v4.16b}, v28.16b
 tbl v5.16b, {v5.16b}, v28.16b
 tbl v6.16b, {v6.16b}, v28.16b
 tbl v7.16b, {v7.16b}, v28.16b
.Lenc_sbox:
 eor v5.16b, v5.16b, v6.16b
 eor v3.16b, v3.16b, v0.16b
 subs x10, x10, #1
 eor v2.16b, v2.16b, v1.16b
 eor v5.16b, v5.16b, v0.16b
 eor v8.16b, v3.16b, v7.16b
 eor v6.16b, v6.16b, v2.16b
 eor v7.16b, v7.16b, v5.16b
 eor v8.16b, v8.16b, v4.16b
 eor v3.16b, v6.16b, v3.16b
 eor v4.16b, v4.16b, v5.16b
 eor v6.16b, v1.16b, v5.16b
 eor v2.16b, v2.16b, v7.16b
 eor v1.16b, v8.16b, v1.16b
 eor v8.16b, v7.16b, v4.16b
 eor v9.16b, v3.16b, v0.16b
 eor v10.16b, v7.16b, v6.16b
 eor v16.16b, v5.16b, v3.16b
 eor v17.16b, v6.16b, v2.16b
 eor v18.16b, v5.16b, v1.16b
 eor v19.16b, v2.16b, v4.16b
 eor v20.16b, v1.16b, v0.16b
 orr v21.16b, v8.16b, v9.16b
 orr v22.16b, v10.16b, v16.16b
 eor v23.16b, v8.16b, v17.16b
 eor v24.16b, v9.16b, v18.16b
 and v19.16b, v19.16b, v20.16b
 orr v20.16b, v17.16b, v18.16b
 and v8.16b, v8.16b, v9.16b
 and v9.16b, v17.16b, v18.16b
 and v17.16b, v23.16b, v24.16b
 and v10.16b, v10.16b, v16.16b
 eor v16.16b, v21.16b, v19.16b
 eor v18.16b, v20.16b, v19.16b
 and v19.16b, v2.16b, v1.16b
 and v20.16b, v6.16b, v5.16b
 eor v21.16b, v22.16b, v17.16b
 eor v9.16b, v9.16b, v10.16b
 eor v10.16b, v16.16b, v17.16b
 eor v16.16b, v18.16b, v8.16b
 and v17.16b, v4.16b, v0.16b
 orr v18.16b, v7.16b, v3.16b
 eor v21.16b, v21.16b, v8.16b
 eor v8.16b, v9.16b, v8.16b
 eor v9.16b, v10.16b, v19.16b
 eor v10.16b, v3.16b, v0.16b
 eor v16.16b, v16.16b, v17.16b
 eor v17.16b, v5.16b, v1.16b
 eor v19.16b, v21.16b, v20.16b
 eor v20.16b, v8.16b, v18.16b
 eor v8.16b, v8.16b, v18.16b
 eor v18.16b, v7.16b, v4.16b
 eor v21.16b, v9.16b, v16.16b
 eor v22.16b, v6.16b, v2.16b
 and v23.16b, v9.16b, v19.16b
 eor v24.16b, v10.16b, v17.16b
 eor v25.16b, v0.16b, v1.16b
 eor v26.16b, v7.16b, v6.16b
 eor v27.16b, v18.16b, v22.16b
 eor v28.16b, v3.16b, v5.16b
 eor v29.16b, v16.16b, v23.16b
 eor v30.16b, v20.16b, v23.16b
 eor v23.16b, v20.16b, v23.16b
 eor v31.16b, v4.16b, v2.16b
 bsl v29.16b, v19.16b, v20.16b
 bsl v30.16b, v9.16b, v16.16b
 bsl v8.16b, v29.16b, v23.16b
 bsl v20.16b, v23.16b, v29.16b
 eor v9.16b, v30.16b, v29.16b
 and v5.16b, v5.16b, v30.16b
 and v8.16b, v8.16b, v30.16b
 and v1.16b, v1.16b, v29.16b
 eor v16.16b, v19.16b, v20.16b
 and v2.16b, v2.16b, v29.16b
 eor v19.16b, v9.16b, v29.16b
 and v17.16b, v17.16b, v9.16b
 eor v8.16b, v8.16b, v21.16b
 and v20.16b, v22.16b, v9.16b
 eor v21.16b, v29.16b, v16.16b
 eor v22.16b, v29.16b, v16.16b
 and v23.16b, v25.16b, v16.16b
 and v6.16b, v6.16b, v19.16b
 eor v25.16b, v8.16b, v16.16b
 eor v29.16b, v30.16b, v8.16b
 and v4.16b, v21.16b, v4.16b
 and v8.16b, v28.16b, v8.16b
 and v0.16b, v22.16b, v0.16b
 eor v21.16b, v23.16b, v1.16b
 eor v22.16b, v9.16b, v25.16b
 eor v9.16b, v9.16b, v25.16b
 eor v23.16b, v25.16b, v16.16b
 and v3.16b, v29.16b, v3.16b
 and v24.16b, v24.16b, v25.16b
 and v25.16b, v27.16b, v25.16b
 and v10.16b, v22.16b, v10.16b
 and v9.16b, v9.16b, v18.16b
 eor v18.16b, v19.16b, v23.16b
 and v19.16b, v26.16b, v23.16b
 eor v3.16b, v5.16b, v3.16b
 eor v17.16b, v17.16b, v24.16b
 eor v10.16b, v24.16b, v10.16b
 and v16.16b, v31.16b, v16.16b
 eor v20.16b, v20.16b, v25.16b
 eor v9.16b, v25.16b, v9.16b
 eor v4.16b, v2.16b, v4.16b
 and v7.16b, v18.16b, v7.16b
 eor v18.16b, v19.16b, v6.16b
 eor v5.16b, v8.16b, v5.16b
 eor v0.16b, v1.16b, v0.16b
 eor v1.16b, v21.16b, v10.16b
 eor v8.16b, v3.16b, v17.16b
 eor v2.16b, v16.16b, v2.16b
 eor v3.16b, v6.16b, v7.16b
 eor v6.16b, v18.16b, v9.16b
 eor v4.16b, v4.16b, v20.16b
 eor v10.16b, v5.16b, v10.16b
 eor v0.16b, v0.16b, v17.16b
 eor v9.16b, v2.16b, v9.16b
 eor v3.16b, v3.16b, v20.16b
 eor v7.16b, v6.16b, v1.16b
 eor v5.16b, v8.16b, v4.16b
 eor v6.16b, v10.16b, v1.16b
 eor v2.16b, v4.16b, v0.16b
 eor v4.16b, v3.16b, v10.16b
 eor v9.16b, v9.16b, v7.16b
 eor v3.16b, v0.16b, v5.16b
 eor v0.16b, v1.16b, v4.16b
 eor v1.16b, v4.16b, v8.16b
 eor v4.16b, v9.16b, v5.16b
 eor v6.16b, v6.16b, v3.16b
 bcc .Lenc_done
 ext v8.16b, v0.16b, v0.16b, #12
 ext v9.16b, v4.16b, v4.16b, #12
 ldr q28, [x11]
 ext v10.16b, v6.16b, v6.16b, #12
 ext v16.16b, v1.16b, v1.16b, #12
 ext v17.16b, v3.16b, v3.16b, #12
 ext v18.16b, v7.16b, v7.16b, #12
 eor v0.16b, v0.16b, v8.16b
 eor v4.16b, v4.16b, v9.16b
 eor v6.16b, v6.16b, v10.16b
 ext v19.16b, v2.16b, v2.16b, #12
 ext v20.16b, v5.16b, v5.16b, #12
 eor v1.16b, v1.16b, v16.16b
 eor v3.16b, v3.16b, v17.16b
 eor v7.16b, v7.16b, v18.16b
 eor v2.16b, v2.16b, v19.16b
 eor v16.16b, v16.16b, v0.16b
 eor v5.16b, v5.16b, v20.16b
 eor v17.16b, v17.16b, v6.16b
 eor v10.16b, v10.16b, v4.16b
 ext v0.16b, v0.16b, v0.16b, #8
 eor v9.16b, v9.16b, v1.16b
 ext v1.16b, v1.16b, v1.16b, #8
 eor v8.16b, v8.16b, v5.16b
 eor v16.16b, v16.16b, v5.16b
 eor v18.16b, v18.16b, v3.16b
 eor v19.16b, v19.16b, v7.16b
 ext v3.16b, v3.16b, v3.16b, #8
 ext v7.16b, v7.16b, v7.16b, #8
 eor v20.16b, v20.16b, v2.16b
 ext v6.16b, v6.16b, v6.16b, #8
 ext v21.16b, v5.16b, v5.16b, #8
 eor v17.16b, v17.16b, v5.16b
 ext v2.16b, v2.16b, v2.16b, #8
 eor v10.16b, v10.16b, v5.16b
 ext v22.16b, v4.16b, v4.16b, #8
 eor v0.16b, v0.16b, v8.16b
 eor v1.16b, v1.16b, v16.16b
 eor v5.16b, v7.16b, v18.16b
 eor v4.16b, v3.16b, v17.16b
 eor v3.16b, v6.16b, v10.16b
 eor v7.16b, v21.16b, v20.16b
 eor v6.16b, v2.16b, v19.16b
 eor v2.16b, v22.16b, v9.16b
 bne .Lenc_loop
 ldr q28, [x11, #16]!
 b .Lenc_loop
.align 4
.Lenc_done:
 ushr v8.2d, v0.2d, #1
 movi v9.16b, #0x55
 ldr q10, [x9]
 ushr v16.2d, v3.2d, #1
 movi v17.16b, #0x33
 ushr v18.2d, v4.2d, #1
 movi v19.16b, #0x0f
 eor v8.16b, v8.16b, v1.16b
 ushr v20.2d, v2.2d, #1
 eor v16.16b, v16.16b, v7.16b
 eor v18.16b, v18.16b, v6.16b
 and v8.16b, v8.16b, v9.16b
 eor v20.16b, v20.16b, v5.16b
 and v16.16b, v16.16b, v9.16b
 and v18.16b, v18.16b, v9.16b
 shl v21.2d, v8.2d, #1
 eor v1.16b, v1.16b, v8.16b
 and v8.16b, v20.16b, v9.16b
 eor v7.16b, v7.16b, v16.16b
 shl v9.2d, v16.2d, #1
 eor v6.16b, v6.16b, v18.16b
 shl v16.2d, v18.2d, #1
 eor v0.16b, v0.16b, v21.16b
 shl v18.2d, v8.2d, #1
 eor v5.16b, v5.16b, v8.16b
 eor v3.16b, v3.16b, v9.16b
 eor v4.16b, v4.16b, v16.16b
 ushr v8.2d, v1.2d, #2
 eor v2.16b, v2.16b, v18.16b
 ushr v9.2d, v0.2d, #2
 ushr v16.2d, v7.2d, #2
 ushr v18.2d, v3.2d, #2
 eor v8.16b, v8.16b, v6.16b
 eor v9.16b, v9.16b, v4.16b
 eor v16.16b, v16.16b, v5.16b
 eor v18.16b, v18.16b, v2.16b
 and v8.16b, v8.16b, v17.16b
 and v9.16b, v9.16b, v17.16b
 and v16.16b, v16.16b, v17.16b
 and v17.16b, v18.16b, v17.16b
 eor v6.16b, v6.16b, v8.16b
 shl v8.2d, v8.2d, #2
 eor v4.16b, v4.16b, v9.16b
 shl v9.2d, v9.2d, #2
 eor v5.16b, v5.16b, v16.16b
 shl v16.2d, v16.2d, #2
 eor v2.16b, v2.16b, v17.16b
 shl v17.2d, v17.2d, #2
 eor v1.16b, v1.16b, v8.16b
 eor v0.16b, v0.16b, v9.16b
 eor v7.16b, v7.16b, v16.16b
 eor v3.16b, v3.16b, v17.16b
 ushr v8.2d, v6.2d, #4
 ushr v9.2d, v4.2d, #4
 ushr v16.2d, v1.2d, #4
 ushr v17.2d, v0.2d, #4
 eor v8.16b, v8.16b, v5.16b
 eor v9.16b, v9.16b, v2.16b
 eor v16.16b, v16.16b, v7.16b
 eor v17.16b, v17.16b, v3.16b
 and v8.16b, v8.16b, v19.16b
 and v9.16b, v9.16b, v19.16b
 and v16.16b, v16.16b, v19.16b
 and v17.16b, v17.16b, v19.16b
 eor v5.16b, v5.16b, v8.16b
 shl v8.2d, v8.2d, #4
 eor v2.16b, v2.16b, v9.16b
 shl v9.2d, v9.2d, #4
 eor v7.16b, v7.16b, v16.16b
 shl v16.2d, v16.2d, #4
 eor v3.16b, v3.16b, v17.16b
 shl v17.2d, v17.2d, #4
 eor v6.16b, v6.16b, v8.16b
 eor v4.16b, v4.16b, v9.16b
 eor v7.16b, v7.16b, v10.16b
 eor v1.16b, v1.16b, v16.16b
 eor v3.16b, v3.16b, v10.16b
 eor v0.16b, v0.16b, v17.16b
 eor v6.16b, v6.16b, v10.16b
 eor v4.16b, v4.16b, v10.16b
 eor v2.16b, v2.16b, v10.16b
 eor v5.16b, v5.16b, v10.16b
 eor v1.16b, v1.16b, v10.16b
 eor v0.16b, v0.16b, v10.16b
 ret
.size _bsaes_encrypt8,.-_bsaes_encrypt8
.type _bsaes_key_convert,%function
.align 4
_bsaes_key_convert:
 adrp x11, .LM0_littleendian
 add x11, x11, :lo12:.LM0_littleendian
 ldr q0, [x9], #16
 ldr q1, [x11]
 ldr q15, [x9], #16
 movi v7.16b, #0x63
 movi v16.16b, #0x01
 movi v17.16b, #0x02
 movi v18.16b, #0x04
 movi v19.16b, #0x08
 movi v20.16b, #0x10
 movi v21.16b, #0x20
 movi v22.16b, #0x40
 movi v23.16b, #0x80
 rev32 v0.16b, v0.16b
 sub x10, x10, #1
 str q0, [x17], #16
.align 4
.Lkey_loop:
 tbl v0.16b, {v15.16b}, v1.16b
 ldr q15, [x9], #16
 eor v0.16b, v0.16b, v7.16b
 cmtst v24.16b, v0.16b, v16.16b
 cmtst v25.16b, v0.16b, v17.16b
 cmtst v26.16b, v0.16b, v18.16b
 cmtst v27.16b, v0.16b, v19.16b
 cmtst v28.16b, v0.16b, v20.16b
 cmtst v29.16b, v0.16b, v21.16b
 cmtst v30.16b, v0.16b, v22.16b
 cmtst v31.16b, v0.16b, v23.16b
 sub x10, x10, #1
 st1 {v24.16b,v25.16b,v26.16b,v27.16b}, [x17], #64
 st1 {v28.16b,v29.16b,v30.16b,v31.16b}, [x17], #64
 cbnz x10, .Lkey_loop
 rev32 v15.16b, v15.16b
 adrp x11, .LM0_bigendian
 add x11, x11, :lo12:.LM0_bigendian
 ret
.size _bsaes_key_convert,.-_bsaes_key_convert
.globl ossl_bsaes_cbc_encrypt
.type ossl_bsaes_cbc_encrypt,%function
.align 4
ossl_bsaes_cbc_encrypt:
 cmp x2, #128
 bhs .Lcbc_do_bsaes
 b AES_cbc_encrypt
.Lcbc_do_bsaes:
 stp x29, x30, [sp, #-48]!
 stp d8, d9, [sp, #16]
 stp d10, d15, [sp, #32]
 lsr x2, x2, #4
 ldr w15, [x3, #240]
 mov x14, sp
 add x17, sp, #96
 sub x17, x17, x15, lsl #7
 mov x9, x3
 mov x10, x15
 mov sp, x17
 bl _bsaes_key_convert
 ldr q6, [sp]
 str q15, [x17]
 eor v6.16b, v6.16b, v7.16b
 str q6, [sp]
 ldr q15, [x4]
 b .Lcbc_dec_loop
.align 4
.Lcbc_dec_loop:
 subs x2, x2, #0x8
 bmi .Lcbc_dec_loop_finish
 ldr q0, [x0], #16
 mov x9, sp
 ldr q1, [x0], #16
 mov x10, x15
 ldr q2, [x0], #16
 ldr q3, [x0], #16
 ldr q4, [x0], #16
 ldr q5, [x0], #16
 ldr q6, [x0], #16
 ldr q7, [x0], #-7*16
 bl _bsaes_decrypt8
 ldr q16, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 eor v1.16b, v1.16b, v16.16b
 str q0, [x1], #16
 ldr q0, [x0], #16
 str q1, [x1], #16
 ldr q1, [x0], #16
 eor v1.16b, v4.16b, v1.16b
 ldr q4, [x0], #16
 eor v2.16b, v2.16b, v4.16b
 eor v0.16b, v6.16b, v0.16b
 ldr q4, [x0], #16
 str q0, [x1], #16
 str q1, [x1], #16
 eor v0.16b, v7.16b, v4.16b
 ldr q1, [x0], #16
 str q2, [x1], #16
 ldr q2, [x0], #16
 ldr q15, [x0], #16
 str q0, [x1], #16
 eor v0.16b, v5.16b, v2.16b
 eor v1.16b, v3.16b, v1.16b
 str q1, [x1], #16
 str q0, [x1], #16
 b .Lcbc_dec_loop
.Lcbc_dec_loop_finish:
 adds x2, x2, #8
 beq .Lcbc_dec_done
 ldr q0, [x0], #16
 cmp x2, #2
 blo .Lcbc_dec_one
 ldr q1, [x0], #16
 mov x9, sp
 mov x10, x15
 beq .Lcbc_dec_two
 ldr q2, [x0], #16
 cmp x2, #4
 blo .Lcbc_dec_three
 ldr q3, [x0], #16
 beq .Lcbc_dec_four
 ldr q4, [x0], #16
 cmp x2, #6
 blo .Lcbc_dec_five
 ldr q5, [x0], #16
 beq .Lcbc_dec_six
 ldr q6, [x0], #-6*16
 bl _bsaes_decrypt8
 ldr q5, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 ldr q8, [x0], #16
 ldr q9, [x0], #16
 ldr q10, [x0], #16
 str q0, [x1], #16
 ldr q0, [x0], #16
 eor v1.16b, v1.16b, v5.16b
 ldr q5, [x0], #16
 eor v6.16b, v6.16b, v8.16b
 ldr q15, [x0]
 eor v4.16b, v4.16b, v9.16b
 eor v2.16b, v2.16b, v10.16b
 str q1, [x1], #16
 eor v0.16b, v7.16b, v0.16b
 str q6, [x1], #16
 eor v1.16b, v3.16b, v5.16b
 str q4, [x1], #16
 str q2, [x1], #16
 str q0, [x1], #16
 str q1, [x1]
 b .Lcbc_dec_done
.align 4
.Lcbc_dec_six:
 sub x0, x0, #0x60
 bl _bsaes_decrypt8
 ldr q3, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 ldr q5, [x0], #16
 ldr q8, [x0], #16
 ldr q9, [x0], #16
 str q0, [x1], #16
 ldr q0, [x0], #16
 eor v1.16b, v1.16b, v3.16b
 ldr q15, [x0]
 eor v3.16b, v6.16b, v5.16b
 eor v4.16b, v4.16b, v8.16b
 eor v2.16b, v2.16b, v9.16b
 str q1, [x1], #16
 eor v0.16b, v7.16b, v0.16b
 str q3, [x1], #16
 str q4, [x1], #16
 str q2, [x1], #16
 str q0, [x1]
 b .Lcbc_dec_done
.align 4
.Lcbc_dec_five:
 sub x0, x0, #0x50
 bl _bsaes_decrypt8
 ldr q3, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 ldr q5, [x0], #16
 ldr q7, [x0], #16
 ldr q8, [x0], #16
 str q0, [x1], #16
 ldr q15, [x0]
 eor v0.16b, v1.16b, v3.16b
 eor v1.16b, v6.16b, v5.16b
 eor v3.16b, v4.16b, v7.16b
 str q0, [x1], #16
 eor v0.16b, v2.16b, v8.16b
 str q1, [x1], #16
 str q3, [x1], #16
 str q0, [x1]
 b .Lcbc_dec_done
.align 4
.Lcbc_dec_four:
 sub x0, x0, #0x40
 bl _bsaes_decrypt8
 ldr q2, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 ldr q3, [x0], #16
 ldr q5, [x0], #16
 str q0, [x1], #16
 ldr q15, [x0]
 eor v0.16b, v1.16b, v2.16b
 eor v1.16b, v6.16b, v3.16b
 eor v2.16b, v4.16b, v5.16b
 str q0, [x1], #16
 str q1, [x1], #16
 str q2, [x1]
 b .Lcbc_dec_done
.align 4
.Lcbc_dec_three:
 sub x0, x0, #0x30
 bl _bsaes_decrypt8
 ldr q2, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 ldr q3, [x0], #16
 ldr q15, [x0]
 str q0, [x1], #16
 eor v0.16b, v1.16b, v2.16b
 eor v1.16b, v6.16b, v3.16b
 str q0, [x1], #16
 str q1, [x1]
 b .Lcbc_dec_done
.align 4
.Lcbc_dec_two:
 sub x0, x0, #0x20
 bl _bsaes_decrypt8
 ldr q2, [x0], #16
 eor v0.16b, v0.16b, v15.16b
 ldr q15, [x0]
 str q0, [x1], #16
 eor v0.16b, v1.16b, v2.16b
 str q0, [x1]
 b .Lcbc_dec_done
.align 4
.Lcbc_dec_one:
 sub x0, x0, #0x10
 stp x1, x4, [sp, #-32]!
 str x14, [sp, #16]
 mov v8.16b, v15.16b
 mov v15.16b, v0.16b
 mov x2, x3
 bl AES_decrypt
 ldr x14, [sp, #16]
 ldp x1, x4, [sp], #32
 ldr q0, [x1]
 eor v0.16b, v0.16b, v8.16b
 str q0, [x1]
.align 4
.Lcbc_dec_done:
 movi v0.16b, #0
 movi v1.16b, #0
.Lcbc_dec_bzero:
 stp q0, q1, [sp], #32
 cmp sp, x14
 bne .Lcbc_dec_bzero
 str q15, [x4]
 ldp d8, d9, [sp, #16]
 ldp d10, d15, [sp, #32]
 ldp x29, x30, [sp], #48
 ret
.size ossl_bsaes_cbc_encrypt,.-ossl_bsaes_cbc_encrypt
.globl ossl_bsaes_ctr32_encrypt_blocks
.type ossl_bsaes_ctr32_encrypt_blocks,%function
.align 4
ossl_bsaes_ctr32_encrypt_blocks:
 cmp x2, #8
 blo .Lctr_enc_short
 stp x29, x30, [sp, #-80]!
 stp d8, d9, [sp, #16]
 stp d10, d11, [sp, #32]
 stp d12, d13, [sp, #48]
 stp d14, d15, [sp, #64]
 ldr w15, [x3, #240]
 mov x14, sp
 add x17, sp, #96
 sub x17, x17, x15, lsl #7
 mov x9, x3
 mov x10, x15
 mov sp, x17
 bl _bsaes_key_convert
 eor v7.16b, v7.16b, v15.16b
 str q7, [x17]
 ldr q0, [x4]
 add x13, x11, #32
 ldr q4, [sp]
 movi v8.4s, #1
 movi v9.16b, #0
 rev32 v15.16b, v0.16b
 rev32 v0.16b, v0.16b
 ext v11.16b, v9.16b, v8.16b, #4
 rev32 v4.16b, v4.16b
 add v12.4s, v11.4s, v11.4s
 str q4, [sp]
 add v13.4s, v11.4s, v12.4s
 add v14.4s, v12.4s, v12.4s
 b .Lctr_enc_loop
.align 4
.Lctr_enc_loop:
 add v1.4s, v15.4s, v11.4s
 add x9, sp, #0x10
 add v2.4s, v15.4s, v12.4s
 ldr q9, [x13]
 ldr q8, [sp]
 add v3.4s, v15.4s, v13.4s
 mov x10, x15
 sub x11, x13, #64
 add v6.4s, v2.4s, v14.4s
 add v4.4s, v15.4s, v14.4s
 add v7.4s, v3.4s, v14.4s
 add v15.4s, v4.4s, v14.4s
 add v5.4s, v1.4s, v14.4s
 bl _bsaes_encrypt8_alt
 subs x2, x2, #8
 blo .Lctr_enc_loop_done
 ldr q16, [x0], #16
 ldr q17, [x0], #16
 eor v1.16b, v1.16b, v17.16b
 ldr q17, [x0], #16
 eor v0.16b, v0.16b, v16.16b
 eor v4.16b, v4.16b, v17.16b
 str q0, [x1], #16
 ldr q16, [x0], #16
 str q1, [x1], #16
 mov v0.16b, v15.16b
 str q4, [x1], #16
 ldr q1, [x0], #16
 eor v4.16b, v6.16b, v16.16b
 eor v1.16b, v3.16b, v1.16b
 ldr q3, [x0], #16
 eor v3.16b, v7.16b, v3.16b
 ldr q6, [x0], #16
 eor v2.16b, v2.16b, v6.16b
 ldr q6, [x0], #16
 eor v5.16b, v5.16b, v6.16b
 str q4, [x1], #16
 str q1, [x1], #16
 str q3, [x1], #16
 str q2, [x1], #16
 str q5, [x1], #16
 bne .Lctr_enc_loop
 b .Lctr_enc_done
.align 4
.Lctr_enc_loop_done:
 add x2, x2, #8
 ldr q16, [x0], #16
 eor v0.16b, v0.16b, v16.16b
 str q0, [x1], #16
 cmp x2, #2
 blo .Lctr_enc_done
 ldr q17, [x0], #16
 eor v1.16b, v1.16b, v17.16b
 str q1, [x1], #16
 beq .Lctr_enc_done
 ldr q18, [x0], #16
 eor v4.16b, v4.16b, v18.16b
 str q4, [x1], #16
 cmp x2, #4
 blo .Lctr_enc_done
 ldr q19, [x0], #16
 eor v6.16b, v6.16b, v19.16b
 str q6, [x1], #16
 beq .Lctr_enc_done
 ldr q20, [x0], #16
 eor v3.16b, v3.16b, v20.16b
 str q3, [x1], #16
 cmp x2, #6
 blo .Lctr_enc_done
 ldr q21, [x0], #16
 eor v7.16b, v7.16b, v21.16b
 str q7, [x1], #16
 beq .Lctr_enc_done
 ldr q22, [x0]
 eor v2.16b, v2.16b, v22.16b
 str q2, [x1], #16
.Lctr_enc_done:
 movi v0.16b, #0
 movi v1.16b, #0
.Lctr_enc_bzero:
 stp q0, q1, [sp], #32
 cmp sp, x14
 bne .Lctr_enc_bzero
 ldp d8, d9, [sp, #16]
 ldp d10, d11, [sp, #32]
 ldp d12, d13, [sp, #48]
 ldp d14, d15, [sp, #64]
 ldp x29, x30, [sp], #80
 ret
.Lctr_enc_short:
 stp x29, x30, [sp, #-96]!
 stp x19, x20, [sp, #16]
 stp x21, x22, [sp, #32]
 str x23, [sp, #48]
 mov x19, x0
 mov x20, x1
 mov x21, x2
 mov x22, x3
 ldr w23, [x4, #12]
 ldr q1, [x4]
 rev w23, w23
 str q1, [sp, #80]
.Lctr_enc_short_loop:
 add x0, sp, #80
 add x1, sp, #64
 mov x2, x22
 bl AES_encrypt
 ldr q0, [x19], #16
 ldr q1, [sp, #64]
 add x23, x23, #1
 rev w0, w23
 str w0, [sp, #80+12]
 eor v0.16b, v0.16b, v1.16b
 str q0, [x20], #16
 subs x21, x21, #1
 bne .Lctr_enc_short_loop
 movi v0.16b, #0
 movi v1.16b, #0
 stp q0, q1, [sp, #64]
 ldr x23, [sp, #48]
 ldp x21, x22, [sp, #32]
 ldp x19, x20, [sp, #16]
 ldp x29, x30, [sp], #96
 ret
.size ossl_bsaes_ctr32_encrypt_blocks,.-ossl_bsaes_ctr32_encrypt_blocks
.globl ossl_bsaes_xts_encrypt
.type ossl_bsaes_xts_encrypt,%function
.align 4
ossl_bsaes_xts_encrypt:
 stp x29, x30, [sp, #-192]!
 stp x19, x20, [sp, #80]
 stp x21, x22, [sp, #96]
 str x23, [sp, #112]
 stp d8, d9, [sp, #128]
 stp d10, d11, [sp, #144]
 stp d12, d13, [sp, #160]
 stp d14, d15, [sp, #176]
 mov x19, sp
 mov x20, x0
 mov x21, x1
 mov x22, x2
 mov x23, x3
 sub sp, sp, #16
 mov x0, x5
 mov x1, sp
 mov x2, x4
 bl AES_encrypt
 ldr q11, [sp], #16
 ldr w1, [x23, #240]
 add x17, sp, #96
 sub x17, x17, x1, lsl #7
 mov x9, x23
 mov x10, x1
 mov sp, x17
 bl _bsaes_key_convert
 eor v15.16b, v15.16b, v7.16b
 str q15, [x17]
 subs x22, x22, #0x80
 blo .Lxts_enc_short
 b .Lxts_enc_loop
.align 4
.Lxts_enc_loop:
 ldr q8, .Lxts_magic
 mov x10, x1
 add x2, x19, #16
 ldr q0, [x20], #16
 sshr v1.2d, v11.2d, #63
 mov x9, sp
 ldr q6, .Lxts_magic+16
 add v2.2d, v11.2d, v11.2d
 cmtst v3.2d, v11.2d, v6.2d
 and v1.16b, v1.16b, v8.16b
 ext v1.16b, v1.16b, v1.16b, #8
 and v3.16b, v3.16b, v8.16b
 ldr q4, [x20], #16
 eor v12.16b, v2.16b, v1.16b
 eor v1.16b, v4.16b, v12.16b
 eor v0.16b, v0.16b, v11.16b
 cmtst v2.2d, v12.2d, v6.2d
 add v4.2d, v12.2d, v12.2d
 add x0, x19, #16
 ext v3.16b, v3.16b, v3.16b, #8
 and v2.16b, v2.16b, v8.16b
 eor v13.16b, v4.16b, v3.16b
 ldr q3, [x20], #16
 ext v4.16b, v2.16b, v2.16b, #8
 eor v2.16b, v3.16b, v13.16b
 ldr q3, [x20], #16
 add v5.2d, v13.2d, v13.2d
 cmtst v7.2d, v13.2d, v6.2d
 and v7.16b, v7.16b, v8.16b
 ldr q9, [x20], #16
 ext v7.16b, v7.16b, v7.16b, #8
 ldr q10, [x20], #16
 eor v14.16b, v5.16b, v4.16b
 ldr q16, [x20], #16
 add v4.2d, v14.2d, v14.2d
 eor v3.16b, v3.16b, v14.16b
 eor v15.16b, v4.16b, v7.16b
 add v5.2d, v15.2d, v15.2d
 ldr q7, [x20], #16
 cmtst v4.2d, v14.2d, v6.2d
 and v17.16b, v4.16b, v8.16b
 cmtst v18.2d, v15.2d, v6.2d
 eor v4.16b, v9.16b, v15.16b
 ext v9.16b, v17.16b, v17.16b, #8
 eor v9.16b, v5.16b, v9.16b
 add v17.2d, v9.2d, v9.2d
 and v18.16b, v18.16b, v8.16b
 eor v5.16b, v10.16b, v9.16b
 str q9, [x2], #16
 ext v10.16b, v18.16b, v18.16b, #8
 cmtst v9.2d, v9.2d, v6.2d
 and v9.16b, v9.16b, v8.16b
 eor v10.16b, v17.16b, v10.16b
 cmtst v17.2d, v10.2d, v6.2d
 eor v6.16b, v16.16b, v10.16b
 str q10, [x2], #16
 ext v9.16b, v9.16b, v9.16b, #8
 add v10.2d, v10.2d, v10.2d
 eor v9.16b, v10.16b, v9.16b
 str q9, [x2], #16
 eor v7.16b, v7.16b, v9.16b
 add v9.2d, v9.2d, v9.2d
 and v8.16b, v17.16b, v8.16b
 ext v8.16b, v8.16b, v8.16b, #8
 eor v8.16b, v9.16b, v8.16b
 str q8, [x2]
 bl _bsaes_encrypt8
 ldr q8, [x0], #16
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 ldr q9, [x0], #16
 eor v4.16b, v4.16b, v13.16b
 eor v6.16b, v6.16b, v14.16b
 ldr q10, [x0], #16
 eor v3.16b, v3.16b, v15.16b
 subs x22, x22, #0x80
 str q0, [x21], #16
 ldr q11, [x0]
 str q1, [x21], #16
 eor v0.16b, v7.16b, v8.16b
 eor v1.16b, v2.16b, v9.16b
 str q4, [x21], #16
 eor v2.16b, v5.16b, v10.16b
 str q6, [x21], #16
 str q3, [x21], #16
 str q0, [x21], #16
 str q1, [x21], #16
 str q2, [x21], #16
 bpl .Lxts_enc_loop
.Lxts_enc_short:
 adds x22, x22, #0x70
 bmi .Lxts_enc_done
 ldr q8, .Lxts_magic
 sshr v1.2d, v11.2d, #63
 add v2.2d, v11.2d, v11.2d
 ldr q9, .Lxts_magic+16
 subs x22, x22, #0x10
 ldr q0, [x20], #16
 and v1.16b, v1.16b, v8.16b
 cmtst v3.2d, v11.2d, v9.2d
 ext v1.16b, v1.16b, v1.16b, #8
 and v3.16b, v3.16b, v8.16b
 eor v12.16b, v2.16b, v1.16b
 ext v1.16b, v3.16b, v3.16b, #8
 add v2.2d, v12.2d, v12.2d
 cmtst v3.2d, v12.2d, v9.2d
 eor v13.16b, v2.16b, v1.16b
 and v22.16b, v3.16b, v8.16b
 bmi .Lxts_enc_1
 ext v2.16b, v22.16b, v22.16b, #8
 add v3.2d, v13.2d, v13.2d
 ldr q1, [x20], #16
 cmtst v4.2d, v13.2d, v9.2d
 subs x22, x22, #0x10
 eor v14.16b, v3.16b, v2.16b
 and v23.16b, v4.16b, v8.16b
 bmi .Lxts_enc_2
 ext v3.16b, v23.16b, v23.16b, #8
 add v4.2d, v14.2d, v14.2d
 ldr q2, [x20], #16
 cmtst v5.2d, v14.2d, v9.2d
 eor v0.16b, v0.16b, v11.16b
 subs x22, x22, #0x10
 eor v15.16b, v4.16b, v3.16b
 and v24.16b, v5.16b, v8.16b
 bmi .Lxts_enc_3
 ext v4.16b, v24.16b, v24.16b, #8
 add v5.2d, v15.2d, v15.2d
 ldr q3, [x20], #16
 cmtst v6.2d, v15.2d, v9.2d
 eor v1.16b, v1.16b, v12.16b
 subs x22, x22, #0x10
 eor v16.16b, v5.16b, v4.16b
 and v25.16b, v6.16b, v8.16b
 bmi .Lxts_enc_4
 ext v5.16b, v25.16b, v25.16b, #8
 add v6.2d, v16.2d, v16.2d
 add x0, x19, #16
 cmtst v7.2d, v16.2d, v9.2d
 ldr q4, [x20], #16
 eor v2.16b, v2.16b, v13.16b
 str q16, [x0], #16
 subs x22, x22, #0x10
 eor v17.16b, v6.16b, v5.16b
 and v26.16b, v7.16b, v8.16b
 bmi .Lxts_enc_5
 ext v7.16b, v26.16b, v26.16b, #8
 add v18.2d, v17.2d, v17.2d
 ldr q5, [x20], #16
 eor v3.16b, v3.16b, v14.16b
 str q17, [x0], #16
 subs x22, x22, #0x10
 eor v18.16b, v18.16b, v7.16b
 bmi .Lxts_enc_6
 ldr q6, [x20], #16
 eor v4.16b, v4.16b, v15.16b
 eor v5.16b, v5.16b, v16.16b
 str q18, [x0]
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 sub x22, x22, #0x10
 eor v6.16b, v6.16b, v17.16b
 bl _bsaes_encrypt8
 ldr q16, [x0], #16
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 ldr q17, [x0], #16
 eor v4.16b, v4.16b, v13.16b
 eor v6.16b, v6.16b, v14.16b
 eor v3.16b, v3.16b, v15.16b
 ldr q11, [x0]
 str q0, [x21], #16
 str q1, [x21], #16
 eor v0.16b, v7.16b, v16.16b
 eor v1.16b, v2.16b, v17.16b
 str q4, [x21], #16
 str q6, [x21], #16
 str q3, [x21], #16
 str q0, [x21], #16
 str q1, [x21], #16
 b .Lxts_enc_done
.align 4
.Lxts_enc_6:
 eor v4.16b, v4.16b, v15.16b
 eor v5.16b, v5.16b, v16.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_encrypt8
 ldr q16, [x0], #16
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 eor v4.16b, v4.16b, v13.16b
 eor v6.16b, v6.16b, v14.16b
 ldr q11, [x0]
 eor v3.16b, v3.16b, v15.16b
 str q0, [x21], #16
 str q1, [x21], #16
 eor v0.16b, v7.16b, v16.16b
 str q4, [x21], #16
 str q6, [x21], #16
 str q3, [x21], #16
 str q0, [x21], #16
 b .Lxts_enc_done
.align 4
.Lxts_enc_5:
 eor v3.16b, v3.16b, v14.16b
 eor v4.16b, v4.16b, v15.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_encrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 ldr q11, [x0]
 eor v4.16b, v4.16b, v13.16b
 eor v6.16b, v6.16b, v14.16b
 eor v3.16b, v3.16b, v15.16b
 str q0, [x21], #16
 str q1, [x21], #16
 str q4, [x21], #16
 str q6, [x21], #16
 str q3, [x21], #16
 b .Lxts_enc_done
.align 4
.Lxts_enc_4:
 eor v2.16b, v2.16b, v13.16b
 eor v3.16b, v3.16b, v14.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_encrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 eor v4.16b, v4.16b, v13.16b
 eor v6.16b, v6.16b, v14.16b
 mov v11.16b, v15.16b
 str q0, [x21], #16
 str q1, [x21], #16
 str q4, [x21], #16
 str q6, [x21], #16
 b .Lxts_enc_done
.align 4
.Lxts_enc_3:
 eor v1.16b, v1.16b, v12.16b
 eor v2.16b, v2.16b, v13.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_encrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 eor v4.16b, v4.16b, v13.16b
 mov v11.16b, v14.16b
 str q0, [x21], #16
 str q1, [x21], #16
 str q4, [x21], #16
 b .Lxts_enc_done
.align 4
.Lxts_enc_2:
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_encrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 mov v11.16b, v13.16b
 str q0, [x21], #16
 str q1, [x21], #16
 b .Lxts_enc_done
.align 4
.Lxts_enc_1:
 eor v0.16b, v0.16b, v11.16b
 sub x0, sp, #16
 sub x1, sp, #16
 mov x2, x23
 mov v13.d[0], v11.d[1]
 mov v14.d[0], v12.d[1]
 str q0, [sp, #-16]!
 bl AES_encrypt
 ldr q0, [sp], #16
 trn1 v13.2d, v11.2d, v13.2d
 trn1 v11.2d, v12.2d, v14.2d
 eor v0.16b, v0.16b, v13.16b
 str q0, [x21], #16
.Lxts_enc_done:
 adds x22, x22, #0x10
 beq .Lxts_enc_ret
 sub x6, x21, #0x10
.Lxts_enc_steal:
 ldrb w0, [x20], #1
 ldrb w1, [x21, #-0x10]
 strb w0, [x21, #-0x10]
 strb w1, [x21], #1
 subs x22, x22, #1
 bhi .Lxts_enc_steal
 ldr q0, [x6]
 eor v0.16b, v0.16b, v11.16b
 str q0, [sp, #-16]!
 mov x0, sp
 mov x1, sp
 mov x2, x23
 mov x21, x6
 mov v13.d[0], v11.d[1]
 bl AES_encrypt
 trn1 v11.2d, v11.2d, v13.2d
 ldr q0, [sp], #16
 eor v0.16b, v0.16b, v11.16b
 str q0, [x21]
.Lxts_enc_ret:
 movi v0.16b, #0
 movi v1.16b, #0
.Lxts_enc_bzero:
 stp q0, q1, [sp], #32
 cmp sp, x19
 bne .Lxts_enc_bzero
 ldp x19, x20, [sp, #80]
 ldp x21, x22, [sp, #96]
 ldr x23, [sp, #112]
 ldp d8, d9, [sp, #128]
 ldp d10, d11, [sp, #144]
 ldp d12, d13, [sp, #160]
 ldp d14, d15, [sp, #176]
 ldp x29, x30, [sp], #192
 ret
.size ossl_bsaes_xts_encrypt,.-ossl_bsaes_xts_encrypt
.align 5
.Lxts_magic:
.quad 1, 0x87, 0x4000000000000000, 0x4000000000000000
.globl ossl_bsaes_xts_decrypt
.type ossl_bsaes_xts_decrypt,%function
.align 4
ossl_bsaes_xts_decrypt:
 stp x29, x30, [sp, #-192]!
 stp x19, x20, [sp, #80]
 stp x21, x22, [sp, #96]
 str x23, [sp, #112]
 stp d8, d9, [sp, #128]
 stp d10, d11, [sp, #144]
 stp d12, d13, [sp, #160]
 stp d14, d15, [sp, #176]
 mov x19, sp
 mov x20, x0
 mov x21, x1
 mov x22, x2
 mov x23, x3
 sub sp, sp, #16
 mov x0, x5
 mov x1, sp
 mov x2, x4
 bl AES_encrypt
 ldr q11, [sp], #16
 ldr w1, [x23, #240]
 add x17, sp, #96
 sub x17, x17, x1, lsl #7
 mov x9, x23
 mov x10, x1
 mov sp, x17
 bl _bsaes_key_convert
 ldr q6, [sp]
 str q15, [x17]
 eor v6.16b, v6.16b, v7.16b
 str q6, [sp]
 sub x30, x22, #0x10
 tst x22, #0xf
 csel x22, x30, x22, ne
 subs x22, x22, #0x80
 blo .Lxts_dec_short
 b .Lxts_dec_loop
.align 4
.Lxts_dec_loop:
 ldr q8, .Lxts_magic
 mov x10, x1
 add x2, x19, #16
 ldr q0, [x20], #16
 sshr v1.2d, v11.2d, #63
 mov x9, sp
 ldr q6, .Lxts_magic+16
 add v2.2d, v11.2d, v11.2d
 cmtst v3.2d, v11.2d, v6.2d
 and v1.16b, v1.16b, v8.16b
 ext v1.16b, v1.16b, v1.16b, #8
 and v3.16b, v3.16b, v8.16b
 ldr q4, [x20], #16
 eor v12.16b, v2.16b, v1.16b
 eor v1.16b, v4.16b, v12.16b
 eor v0.16b, v0.16b, v11.16b
 cmtst v2.2d, v12.2d, v6.2d
 add v4.2d, v12.2d, v12.2d
 add x0, x19, #16
 ext v3.16b, v3.16b, v3.16b, #8
 and v2.16b, v2.16b, v8.16b
 eor v13.16b, v4.16b, v3.16b
 ldr q3, [x20], #16
 ext v4.16b, v2.16b, v2.16b, #8
 eor v2.16b, v3.16b, v13.16b
 ldr q3, [x20], #16
 add v5.2d, v13.2d, v13.2d
 cmtst v7.2d, v13.2d, v6.2d
 and v7.16b, v7.16b, v8.16b
 ldr q9, [x20], #16
 ext v7.16b, v7.16b, v7.16b, #8
 ldr q10, [x20], #16
 eor v14.16b, v5.16b, v4.16b
 ldr q16, [x20], #16
 add v4.2d, v14.2d, v14.2d
 eor v3.16b, v3.16b, v14.16b
 eor v15.16b, v4.16b, v7.16b
 add v5.2d, v15.2d, v15.2d
 ldr q7, [x20], #16
 cmtst v4.2d, v14.2d, v6.2d
 and v17.16b, v4.16b, v8.16b
 cmtst v18.2d, v15.2d, v6.2d
 eor v4.16b, v9.16b, v15.16b
 ext v9.16b, v17.16b, v17.16b, #8
 eor v9.16b, v5.16b, v9.16b
 add v17.2d, v9.2d, v9.2d
 and v18.16b, v18.16b, v8.16b
 eor v5.16b, v10.16b, v9.16b
 str q9, [x2], #16
 ext v10.16b, v18.16b, v18.16b, #8
 cmtst v9.2d, v9.2d, v6.2d
 and v9.16b, v9.16b, v8.16b
 eor v10.16b, v17.16b, v10.16b
 cmtst v17.2d, v10.2d, v6.2d
 eor v6.16b, v16.16b, v10.16b
 str q10, [x2], #16
 ext v9.16b, v9.16b, v9.16b, #8
 add v10.2d, v10.2d, v10.2d
 eor v9.16b, v10.16b, v9.16b
 str q9, [x2], #16
 eor v7.16b, v7.16b, v9.16b
 add v9.2d, v9.2d, v9.2d
 and v8.16b, v17.16b, v8.16b
 ext v8.16b, v8.16b, v8.16b, #8
 eor v8.16b, v9.16b, v8.16b
 str q8, [x2]
 bl _bsaes_decrypt8
 eor v6.16b, v6.16b, v13.16b
 eor v0.16b, v0.16b, v11.16b
 ldr q8, [x0], #16
 eor v7.16b, v7.16b, v8.16b
 str q0, [x21], #16
 eor v0.16b, v1.16b, v12.16b
 ldr q1, [x0], #16
 eor v1.16b, v3.16b, v1.16b
 subs x22, x22, #0x80
 eor v2.16b, v2.16b, v15.16b
 eor v3.16b, v4.16b, v14.16b
 ldr q4, [x0], #16
 str q0, [x21], #16
 ldr q11, [x0]
 eor v0.16b, v5.16b, v4.16b
 str q6, [x21], #16
 str q3, [x21], #16
 str q2, [x21], #16
 str q7, [x21], #16
 str q1, [x21], #16
 str q0, [x21], #16
 bpl .Lxts_dec_loop
.Lxts_dec_short:
 adds x22, x22, #0x70
 bmi .Lxts_dec_done
 ldr q8, .Lxts_magic
 sshr v1.2d, v11.2d, #63
 add v2.2d, v11.2d, v11.2d
 ldr q9, .Lxts_magic+16
 subs x22, x22, #0x10
 ldr q0, [x20], #16
 and v1.16b, v1.16b, v8.16b
 cmtst v3.2d, v11.2d, v9.2d
 ext v1.16b, v1.16b, v1.16b, #8
 and v3.16b, v3.16b, v8.16b
 eor v12.16b, v2.16b, v1.16b
 ext v1.16b, v3.16b, v3.16b, #8
 add v2.2d, v12.2d, v12.2d
 cmtst v3.2d, v12.2d, v9.2d
 eor v13.16b, v2.16b, v1.16b
 and v22.16b, v3.16b, v8.16b
 bmi .Lxts_dec_1
 ext v2.16b, v22.16b, v22.16b, #8
 add v3.2d, v13.2d, v13.2d
 ldr q1, [x20], #16
 cmtst v4.2d, v13.2d, v9.2d
 subs x22, x22, #0x10
 eor v14.16b, v3.16b, v2.16b
 and v23.16b, v4.16b, v8.16b
 bmi .Lxts_dec_2
 ext v3.16b, v23.16b, v23.16b, #8
 add v4.2d, v14.2d, v14.2d
 ldr q2, [x20], #16
 cmtst v5.2d, v14.2d, v9.2d
 eor v0.16b, v0.16b, v11.16b
 subs x22, x22, #0x10
 eor v15.16b, v4.16b, v3.16b
 and v24.16b, v5.16b, v8.16b
 bmi .Lxts_dec_3
 ext v4.16b, v24.16b, v24.16b, #8
 add v5.2d, v15.2d, v15.2d
 ldr q3, [x20], #16
 cmtst v6.2d, v15.2d, v9.2d
 eor v1.16b, v1.16b, v12.16b
 subs x22, x22, #0x10
 eor v16.16b, v5.16b, v4.16b
 and v25.16b, v6.16b, v8.16b
 bmi .Lxts_dec_4
 ext v5.16b, v25.16b, v25.16b, #8
 add v6.2d, v16.2d, v16.2d
 add x0, x19, #16
 cmtst v7.2d, v16.2d, v9.2d
 ldr q4, [x20], #16
 eor v2.16b, v2.16b, v13.16b
 str q16, [x0], #16
 subs x22, x22, #0x10
 eor v17.16b, v6.16b, v5.16b
 and v26.16b, v7.16b, v8.16b
 bmi .Lxts_dec_5
 ext v7.16b, v26.16b, v26.16b, #8
 add v18.2d, v17.2d, v17.2d
 ldr q5, [x20], #16
 eor v3.16b, v3.16b, v14.16b
 str q17, [x0], #16
 subs x22, x22, #0x10
 eor v18.16b, v18.16b, v7.16b
 bmi .Lxts_dec_6
 ldr q6, [x20], #16
 eor v4.16b, v4.16b, v15.16b
 eor v5.16b, v5.16b, v16.16b
 str q18, [x0]
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 sub x22, x22, #0x10
 eor v6.16b, v6.16b, v17.16b
 bl _bsaes_decrypt8
 ldr q16, [x0], #16
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 ldr q17, [x0], #16
 eor v6.16b, v6.16b, v13.16b
 eor v4.16b, v4.16b, v14.16b
 eor v2.16b, v2.16b, v15.16b
 ldr q11, [x0]
 str q0, [x21], #16
 str q1, [x21], #16
 eor v0.16b, v7.16b, v16.16b
 eor v1.16b, v3.16b, v17.16b
 str q6, [x21], #16
 str q4, [x21], #16
 str q2, [x21], #16
 str q0, [x21], #16
 str q1, [x21], #16
 b .Lxts_dec_done
.align 4
.Lxts_dec_6:
 eor v4.16b, v4.16b, v15.16b
 eor v5.16b, v5.16b, v16.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_decrypt8
 ldr q16, [x0], #16
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 eor v6.16b, v6.16b, v13.16b
 eor v4.16b, v4.16b, v14.16b
 ldr q11, [x0]
 eor v2.16b, v2.16b, v15.16b
 str q0, [x21], #16
 str q1, [x21], #16
 eor v0.16b, v7.16b, v16.16b
 str q6, [x21], #16
 str q4, [x21], #16
 str q2, [x21], #16
 str q0, [x21], #16
 b .Lxts_dec_done
.align 4
.Lxts_dec_5:
 eor v3.16b, v3.16b, v14.16b
 eor v4.16b, v4.16b, v15.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_decrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 ldr q11, [x0]
 eor v6.16b, v6.16b, v13.16b
 eor v4.16b, v4.16b, v14.16b
 eor v2.16b, v2.16b, v15.16b
 str q0, [x21], #16
 str q1, [x21], #16
 str q6, [x21], #16
 str q4, [x21], #16
 str q2, [x21], #16
 b .Lxts_dec_done
.align 4
.Lxts_dec_4:
 eor v2.16b, v2.16b, v13.16b
 eor v3.16b, v3.16b, v14.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_decrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 eor v6.16b, v6.16b, v13.16b
 eor v4.16b, v4.16b, v14.16b
 mov v11.16b, v15.16b
 str q0, [x21], #16
 str q1, [x21], #16
 str q6, [x21], #16
 str q4, [x21], #16
 b .Lxts_dec_done
.align 4
.Lxts_dec_3:
 eor v1.16b, v1.16b, v12.16b
 eor v2.16b, v2.16b, v13.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_decrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 eor v6.16b, v6.16b, v13.16b
 mov v11.16b, v14.16b
 str q0, [x21], #16
 str q1, [x21], #16
 str q6, [x21], #16
 b .Lxts_dec_done
.align 4
.Lxts_dec_2:
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 mov x9, sp
 mov x10, x1
 add x0, x19, #16
 bl _bsaes_decrypt8
 eor v0.16b, v0.16b, v11.16b
 eor v1.16b, v1.16b, v12.16b
 mov v11.16b, v13.16b
 str q0, [x21], #16
 str q1, [x21], #16
 b .Lxts_dec_done
.align 4
.Lxts_dec_1:
 eor v0.16b, v0.16b, v11.16b
 sub x0, sp, #16
 sub x1, sp, #16
 mov x2, x23
 mov v13.d[0], v11.d[1]
 mov v14.d[0], v12.d[1]
 str q0, [sp, #-16]!
 bl AES_decrypt
 ldr q0, [sp], #16
 trn1 v13.2d, v11.2d, v13.2d
 trn1 v11.2d, v12.2d, v14.2d
 eor v0.16b, v0.16b, v13.16b
 str q0, [x21], #16
.Lxts_dec_done:
 adds x22, x22, #0x10
 beq .Lxts_dec_ret
 ldr q8, .Lxts_magic
 sshr v6.2d, v11.2d, #63
 and v6.16b, v6.16b, v8.16b
 add v12.2d, v11.2d, v11.2d
 ext v6.16b, v6.16b, v6.16b, #8
 eor v12.16b, v12.16b, v6.16b
 ldr q0, [x20], #16
 eor v0.16b, v0.16b, v12.16b
 str q0, [sp, #-16]!
 mov x0, sp
 mov x1, sp
 mov x2, x23
 mov v13.d[0], v11.d[1]
 mov v14.d[0], v12.d[1]
 bl AES_decrypt
 trn1 v12.2d, v12.2d, v14.2d
 trn1 v11.2d, v11.2d, v13.2d
 ldr q0, [sp], #16
 eor v0.16b, v0.16b, v12.16b
 str q0, [x21]
 mov x6, x21
.Lxts_dec_steal:
 ldrb w1, [x21]
 ldrb w0, [x20], #1
 strb w1, [x21, #0x10]
 strb w0, [x21], #1
 subs x22, x22, #1
 bhi .Lxts_dec_steal
 ldr q0, [x6]
 eor v0.16b, v0.16b, v11.16b
 str q0, [sp, #-16]!
 mov x0, sp
 mov x1, sp
 mov x2, x23
 mov x21, x6
 bl AES_decrypt
 trn1 v11.2d, v11.2d, v13.2d
 ldr q0, [sp], #16
 eor v0.16b, v0.16b, v11.16b
 str q0, [x21]
.Lxts_dec_ret:
 movi v0.16b, #0
 movi v1.16b, #0
.Lxts_dec_bzero:
 stp q0, q1, [sp], #32
 cmp sp, x19
 bne .Lxts_dec_bzero
 ldp x19, x20, [sp, #80]
 ldp x21, x22, [sp, #96]
 ldr x23, [sp, #112]
 ldp d8, d9, [sp, #128]
 ldp d10, d11, [sp, #144]
 ldp d12, d13, [sp, #160]
 ldp d14, d15, [sp, #176]
 ldp x29, x30, [sp], #192
 ret
.size ossl_bsaes_xts_decrypt,.-ossl_bsaes_xts_decrypt
