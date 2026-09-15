candle_q3k_vec_dot:
cmp x4, x2
csel x12, x4, x2, lo
cbz x12, candle_q3k_vec_dot_3d8
stp d9, d8, [sp, #-0x40]!
stp x24, x23, [sp, #0x10]
stp x22, x21, [sp, #0x20]
stp x20, x19, [sp, #0x30]
mov x8, #0x0                // =0
mov w9, #0x30303030         // =808464432
mov w10, #0xf0f0f0f         // =252645135
add x11, x3, #0xc4
mov w13, #0x6e              // =110
mul x12, x12, x13
movi d0, #0000000000000000
movi v1.16b, #0x4
movi v2.16b, #0x3
mov w13, #-0x20000000       // =-536870912
candle_q3k_vec_dot_44:
add x17, x1, x8
ldur s3, [x11, #-0xc4]
mov x15, x17
ld1 { v5.16b, v6.16b }, [x15], #32
ldp w0, w16, [x17, #0x60]
ldr w3, [x17, #0x68]
ldr h4, [x17, #0x6c]
sub x4, x11, #0xc0
and w14, w10, w16, lsr #4
and w2, w9, w3, lsr #2
orr w14, w2, w14
and w2, w10, w0, lsr #4
and w5, w3, w9
and w6, w16, w10
and w7, w9, w3, lsl #2
orr w16, w2, w5
orr w2, w7, w6
and w0, w0, w10
and w3, w9, w3, lsl #4
ld1 { v16.16b, v17.16b }, [x15]
lsr w15, w16, #24
orr w5, w0, w3
ld1 { v22.16b, v23.16b, v24.16b, v25.16b }, [x4]
lsr w0, w2, #24
sub x3, x11, #0x80
ld1 { v18.16b, v19.16b, v20.16b, v21.16b }, [x3]
lsr w3, w5, #24
sub w4, w3, #0x20
sub x3, x11, #0x40
mvn v7.16b, v5.16b
shl v26.16b, v7.16b, #0x2
and v26.16b, v26.16b, v1.16b
sub w0, w0, #0x20
mvn v27.16b, v6.16b
shl v28.16b, v27.16b, #0x2
and v28.16b, v28.16b, v1.16b
add v29.16b, v7.16b, v7.16b
and v29.16b, v29.16b, v1.16b
sub w15, w15, #0x20
add v30.16b, v27.16b, v27.16b
and v30.16b, v30.16b, v1.16b
and v31.16b, v16.16b, v2.16b
sub v26.16b, v31.16b, v26.16b
and v31.16b, v17.16b, v2.16b
sub v28.16b, v31.16b, v28.16b
ushr v31.16b, v16.16b, #0x2
and v31.16b, v31.16b, v2.16b
ushr v8.16b, v17.16b, #0x2
and v8.16b, v8.16b, v2.16b
movi v9.2d, #0000000000000000
sub v29.16b, v31.16b, v29.16b
sdot v9.4s, v26.16b, v22.16b
movi v26.2d, #0000000000000000
sdot v26.4s, v28.16b, v23.16b
movi v28.2d, #0000000000000000
addv s31, v9.4s
fmov w6, s31
movi v31.2d, #0000000000000000
sub w7, w5, #0x20
sxtb w7, w7
mul w6, w6, w7
addv s26, v26.4s
sdot v28.4s, v29.16b, v24.16b
fmov w7, s26
add w19, w13, w5, lsl #16
asr w19, w19, #24
add w5, w13, w5, lsl #8
bic v26.16b, v1.16b, v5.16b
asr w5, w5, #24
bic v29.16b, v1.16b, v6.16b
ushr v7.16b, v7.16b, #0x1
and v7.16b, v7.16b, v1.16b
ushr v27.16b, v27.16b, #0x1
and v27.16b, v27.16b, v1.16b
sub v30.16b, v8.16b, v30.16b
ushr v8.16b, v16.16b, #0x4
and v8.16b, v8.16b, v2.16b
sub v26.16b, v8.16b, v26.16b
ushr v8.16b, v17.16b, #0x4
and v8.16b, v8.16b, v2.16b
sdot v31.4s, v30.16b, v25.16b
sub v22.16b, v8.16b, v29.16b
ushr v23.16b, v16.16b, #0x6
sub v7.16b, v23.16b, v7.16b
ushr v16.16b, v17.16b, #0x6
sub v16.16b, v16.16b, v27.16b
addv s17, v28.4s
movi v23.2d, #0000000000000000
sdot v23.4s, v26.16b, v18.16b
movi v24.2d, #0000000000000000
sdot v24.4s, v22.16b, v19.16b
movi v22.2d, #0000000000000000
addv s25, v31.4s
sdot v22.4s, v7.16b, v20.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v16.16b, v21.16b
addv s16, v23.4s
sub w20, w2, #0x20
fmov w21, s17
sxtb w20, w20
addv s18, v24.4s
add w22, w13, w2, lsl #16
asr w22, w22, #24
addv s19, v22.4s
fmov w23, s25
add w2, w13, w2, lsl #8
asr w2, w2, #24
addv s22, v7.4s
madd w6, w7, w19, w6
madd w5, w21, w5, w6
fmov w6, s16
madd w4, w23, w4, w5
madd w4, w6, w20, w4
add x17, x17, #0x40
ld1 { v16.16b, v17.16b }, [x17]
fmov w17, s18
ushr v7.16b, v5.16b, #0x4
ld1 { v23.16b, v24.16b, v25.16b, v26.16b }, [x3]
fmov w3, s19
ushr v5.16b, v6.16b, #0x4
ld1 { v18.16b, v19.16b, v20.16b, v21.16b }, [x11]
madd w17, w17, w22, w4
mvn v6.16b, v7.16b
shl v27.16b, v6.16b, #0x2
and v27.16b, v27.16b, v1.16b
mvn v28.16b, v5.16b
shl v29.16b, v28.16b, #0x2
fmov w4, s22
and v22.16b, v29.16b, v1.16b
add v29.16b, v6.16b, v6.16b
and v29.16b, v29.16b, v1.16b
add v30.16b, v28.16b, v28.16b
and v30.16b, v30.16b, v1.16b
madd w17, w3, w2, w17
and v31.16b, v16.16b, v2.16b
sub v27.16b, v31.16b, v27.16b
and v31.16b, v17.16b, v2.16b
sub v22.16b, v31.16b, v22.16b
ushr v31.16b, v16.16b, #0x2
and v31.16b, v31.16b, v2.16b
sub v29.16b, v31.16b, v29.16b
ushr v31.16b, v17.16b, #0x2
and v31.16b, v31.16b, v2.16b
sub v30.16b, v31.16b, v30.16b
movi v31.2d, #0000000000000000
madd w17, w4, w0, w17
sdot v31.4s, v27.16b, v23.16b
movi v27.2d, #0000000000000000
sdot v27.4s, v22.16b, v24.16b
movi v22.2d, #0000000000000000
addv s31, v31.4s
sdot v22.4s, v29.16b, v25.16b
fmov w0, s31
movi v29.2d, #0000000000000000
sub w2, w16, #0x20
sxtb w2, w2
addv s27, v27.4s
sdot v29.4s, v30.16b, v26.16b
add w3, w13, w16, lsl #16
asr w3, w3, #24
add w16, w13, w16, lsl #8
asr w16, w16, #24
bic v7.16b, v1.16b, v7.16b
addv s22, v22.4s
bic v5.16b, v1.16b, v5.16b
ushr v6.16b, v6.16b, #0x1
and v6.16b, v6.16b, v1.16b
ushr v23.16b, v28.16b, #0x1
and v23.16b, v23.16b, v1.16b
addv s24, v29.4s
ushr v25.16b, v16.16b, #0x4
and v25.16b, v25.16b, v2.16b
sub v7.16b, v25.16b, v7.16b
ushr v25.16b, v17.16b, #0x4
and v25.16b, v25.16b, v2.16b
fmov w4, s27
sub v5.16b, v25.16b, v5.16b
ushr v25.16b, v16.16b, #0x6
sub v6.16b, v25.16b, v6.16b
ushr v16.16b, v17.16b, #0x6
sub v16.16b, v16.16b, v23.16b
fmov w5, s22
movi v17.2d, #0000000000000000
sdot v17.4s, v7.16b, v18.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v19.16b
movi v5.2d, #0000000000000000
fmov w6, s24
sdot v5.4s, v6.16b, v20.16b
movi v6.2d, #0000000000000000
sdot v6.4s, v16.16b, v21.16b
addv s16, v17.4s
sub w7, w14, #0x20
fmov w19, s16
sxtb w7, w7
addv s7, v7.4s
add w20, w13, w14, lsl #16
asr w20, w20, #24
addv s5, v5.4s
fmov w21, s7
add w22, w13, w14, lsl #8
asr w22, w22, #24
addv s6, v6.4s
add w14, w14, w13
asr w14, w14, #24
fmov w23, s5
madd w17, w0, w2, w17
madd w17, w4, w3, w17
madd w16, w5, w16, w17
madd w15, w6, w15, w16
madd w15, w19, w7, w15
fmov w16, s6
madd w15, w21, w20, w15
madd w15, w23, w22, w15
madd w14, w16, w14, w15
scvtf s5, w14
fcvt s6, h4
fmul s3, s3, s6
fmul s3, s3, s5
fadd s0, s0, s3
add x8, x8, #0x6e
add x11, x11, #0x124
cmp x12, x8
b.ne candle_q3k_vec_dot_44
ldp x20, x19, [sp, #0x30]
ldp x22, x21, [sp, #0x20]
ldp x24, x23, [sp, #0x10]
ldp d9, d8, [sp], #0x40
ret
candle_q3k_vec_dot_3d8:
movi d0, #0000000000000000
ret
