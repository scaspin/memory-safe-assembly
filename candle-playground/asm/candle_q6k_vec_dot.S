candle_q6k_vec_dot:
cmp x4, x2
csel x9, x4, x2, lo
cbz x9, candle_q6k_vec_dot_31c
stp d13, d12, [sp, #-0x30]!
stp d11, d10, [sp, #0x10]
stp d9, d8, [sp, #0x20]
mov x8, #0x0                // =0
mov w10, #0xd2              // =210
mul x9, x9, x10
add x10, x3, #0x84
movi d0, #0000000000000000
movi v1.16b, #0x30
movi v2.16b, #0xf
candle_q6k_vec_dot_34:
add x11, x1, x8
add x12, x11, #0x80
sub x15, x10, #0x80
add x13, x10, #0x80
ld1 { v3.8h, v4.8h }, [x13]
ldr q6, [x11, #0xc0]
ld1 { v20.16b, v21.16b }, [x12]
add x13, x11, #0xa0
mov x14, x11
ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x14], #64
ld1 { v22.16b, v23.16b, v24.16b, v25.16b }, [x15]
sub x15, x10, #0x40
shl v5.16b, v20.16b, #0x4
and v5.16b, v5.16b, v1.16b
shl v7.16b, v21.16b, #0x4
and v7.16b, v7.16b, v1.16b
shl v26.16b, v20.16b, #0x2
shl v27.16b, v21.16b, #0x2
and v26.16b, v26.16b, v1.16b
and v27.16b, v27.16b, v1.16b
and v28.16b, v16.16b, v2.16b
orr v28.16b, v5.16b, v28.16b
and v5.16b, v17.16b, v2.16b
and v29.16b, v18.16b, v2.16b
orr v7.16b, v7.16b, v5.16b
orr v26.16b, v26.16b, v29.16b
and v5.16b, v19.16b, v2.16b
orr v27.16b, v27.16b, v5.16b
ldr h5, [x11, #0xd0]
movi v29.2d, #0000000000000000
sdot v29.4s, v28.16b, v22.16b
movi v28.2d, #0000000000000000
sdot v28.4s, v7.16b, v23.16b
smov w12, v6.b[1]
movi v7.2d, #0000000000000000
sdot v7.4s, v26.16b, v24.16b
movi v26.2d, #0000000000000000
sdot v26.4s, v27.16b, v25.16b
ld1 { v8.16b, v9.16b, v10.16b, v11.16b }, [x15]
addv s23, v29.4s
and v22.16b, v20.16b, v1.16b
and v25.16b, v21.16b, v1.16b
ushr v24.16b, v20.16b, #0x2
and v27.16b, v24.16b, v1.16b
addv s28, v28.4s
ushr v20.16b, v21.16b, #0x2
and v20.16b, v20.16b, v1.16b
usra v22.16b, v16.16b, #0x4
usra v25.16b, v17.16b, #0x4
usra v27.16b, v18.16b, #0x4
addv s24, v7.4s
usra v20.16b, v19.16b, #0x4
movi v7.2d, #0000000000000000
sdot v7.4s, v22.16b, v8.16b
movi v29.2d, #0000000000000000
movi v30.2d, #0000000000000000
sdot v29.4s, v25.16b, v9.16b
sdot v30.4s, v27.16b, v10.16b
movi v31.2d, #0000000000000000
sdot v31.4s, v20.16b, v11.16b
ld1 { v21.16b, v22.16b }, [x13]
fmov w13, s23
addv s23, v26.4s
ld1 { v17.16b, v18.16b, v19.16b, v20.16b }, [x14]
fmov w14, s28
mov x16, x10
ld1 { v25.16b, v26.16b, v27.16b, v28.16b }, [x16], #64
addv s16, v7.4s
addv s29, v29.4s
addv s30, v30.4s
addv s31, v31.4s
shl v7.16b, v21.16b, #0x4
and v7.16b, v7.16b, v1.16b
shl v8.16b, v22.16b, #0x4
and v8.16b, v8.16b, v1.16b
shl v9.16b, v21.16b, #0x2
and v9.16b, v9.16b, v1.16b
shl v10.16b, v22.16b, #0x2
and v10.16b, v10.16b, v1.16b
and v11.16b, v17.16b, v2.16b
orr v7.16b, v7.16b, v11.16b
and v11.16b, v18.16b, v2.16b
orr v8.16b, v8.16b, v11.16b
and v11.16b, v19.16b, v2.16b
orr v9.16b, v9.16b, v11.16b
and v11.16b, v20.16b, v2.16b
movi v12.2d, #0000000000000000
sdot v12.4s, v7.16b, v25.16b
movi v13.2d, #0000000000000000
sdot v13.4s, v8.16b, v26.16b
addv s7, v12.4s
addv s8, v13.4s
ldr h12, [x11, #0xc8]
mov v12.h[1], v6.h[1]
mov v12.s[1], v6.s[1]
mov v7.s[1], v8.s[0]
mov v16.s[1], v29.s[0]
mov v7.s[2], v24.s[0]
mov v16.s[2], v30.s[0]
mov v16.s[3], v31.s[0]
movi v24.2d, #0000000000000000
orr v29.16b, v10.16b, v11.16b
sdot v24.4s, v9.16b, v27.16b
movi v30.2d, #0000000000000000
sdot v30.4s, v29.16b, v28.16b
ldrsb w17, [x11, #0xca]
ldrsb w15, [x11, #0xcb]
addv s24, v24.4s
fmov w0, s24
ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x16]
sshll v28.8h, v12.8b, #0x0
mul w16, w0, w17
addv s29, v30.4s
fmov w17, s29
and v29.16b, v21.16b, v1.16b
mov v7.s[3], v23.s[0]
and v23.16b, v22.16b, v1.16b
ushr v30.16b, v21.16b, #0x2
and v30.16b, v30.16b, v1.16b
ushr v21.16b, v22.16b, #0x2
and v21.16b, v21.16b, v1.16b
sshll2 v22.4s, v28.8h, #0x0
usra v29.16b, v17.16b, #0x4
usra v23.16b, v18.16b, #0x4
usra v30.16b, v19.16b, #0x4
usra v21.16b, v20.16b, #0x4
movi v17.2d, #0000000000000000
sdot v17.4s, v29.16b, v24.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v23.16b, v25.16b
ldrsb w0, [x11, #0xcc]
ldrsb w2, [x11, #0xcd]
addv s17, v17.4s
sshll v19.4s, v28.4h, #0x0
fmov w3, s17
mul w0, w3, w0
addv s17, v18.4s
fmov w3, s17
movi v17.2d, #0000000000000000
mul v16.4s, v16.4s, v22.4s
sdot v17.4s, v30.16b, v26.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v21.16b, v27.16b
sshll v20.8h, v6.8b, #0x0
sshll2 v21.8h, v6.16b, #0x0
fmov w4, s6
ldrsb w5, [x11, #0xce]
ldrsb w11, [x11, #0xcf]
addv s6, v17.4s
fmov w6, s6
mul w5, w6, w5
sxtb w4, w4
addv s6, v18.4s
fmov w6, s6
mla v16.4s, v7.4s, v19.4s
addv s6, v16.4s
fmov w7, s6
madd w12, w14, w12, w7
madd w13, w13, w4, w16
madd w14, w17, w15, w0
madd w15, w3, w2, w5
add w14, w14, w15
add w13, w13, w14
add w12, w12, w13
smull v6.4s, v3.4h, v20.4h
smlal2 v6.4s, v3.8h, v20.8h
smlal v6.4s, v4.4h, v21.4h
smlal2 v6.4s, v4.8h, v21.8h
addv s3, v6.4s
madd w11, w6, w11, w12
fmov w12, s3
ldur s3, [x10, #-0x84]
sub w11, w11, w12, lsl #5
scvtf s4, w11
fcvt s6, h5
fmul s3, s6, s3
fmul s3, s3, s4
fadd s0, s0, s3
add x8, x8, #0xd2
add x10, x10, #0x124
cmp x9, x8
b.ne candle_q6k_vec_dot_34
ldp d9, d8, [sp, #0x20]
ldp d11, d10, [sp, #0x10]
ldp d13, d12, [sp], #0x30
ret
candle_q6k_vec_dot_31c:
movi d0, #0000000000000000
ret
