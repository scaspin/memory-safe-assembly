candle_q5k_vec_dot:
cmp x4, x2
csel x12, x4, x2, lo
cbz x12, candle_q5k_vec_dot_2fc
mov x8, #0x0                // =0
mov w9, #0x30303030         // =808464432
mov w10, #0xf0f0f0f         // =252645135
add x11, x3, #0xc4
mov w13, #0xb0              // =176
mul x12, x12, x13
movi d0, #0000000000000000
movi v1.16b, #0x10
movi v2.16b, #0xf
candle_q5k_vec_dot_30:
add x15, x1, x8
ldur s3, [x11, #-0xc4]
ldp q6, q7, [x11, #0x40]
ldp w16, w13, [x15, #0x4]
ldr w14, [x15, #0xc]
ldr h4, [x15]
fcvt s16, h4
ldr h4, [x15, #0x2]
fcvt s5, h4
fmul s4, s3, s16
addp v6.8h, v6.8h, v7.8h
add x17, x15, #0x10
and w0, w10, w14, lsr #4
and w2, w9, w13, lsr #2
and w13, w13, #0x3f3f3f3f
orr w0, w2, w0
and w14, w14, w10
and w2, w9, w16, lsr #2
fmov s7, w13
add x13, x15, #0x30
sub x3, x11, #0xc0
orr w14, w2, w14
ld1 { v16.16b, v17.16b }, [x17]
ld1 { v18.16b, v19.16b }, [x13]
add x17, x15, #0x50
lsr w13, w14, #24
ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3]
mov v7.s[1], w0
sub x0, x11, #0x80
shl v24.16b, v16.16b, #0x4
and v24.16b, v24.16b, v1.16b
shl v25.16b, v17.16b, #0x4
shl v26.16b, v16.16b, #0x3
and v25.16b, v25.16b, v1.16b
and v26.16b, v26.16b, v1.16b
shl v27.16b, v17.16b, #0x3
and v28.16b, v18.16b, v2.16b
orr v24.16b, v28.16b, v24.16b
and v28.16b, v19.16b, v2.16b
orr v25.16b, v28.16b, v25.16b
and v27.16b, v27.16b, v1.16b
usra v26.16b, v18.16b, #0x4
usra v27.16b, v19.16b, #0x4
movi v18.2d, #0000000000000000
movi v19.2d, #0000000000000000
sdot v18.4s, v24.16b, v20.16b
sdot v19.4s, v25.16b, v21.16b
add v18.4s, v19.4s, v18.4s
and w2, w16, #0x3f
movi v19.2d, #0000000000000000
sdot v19.4s, v26.16b, v22.16b
addv s18, v18.4s
movi v24.2d, #0000000000000000
sdot v24.4s, v27.16b, v23.16b
add v19.4s, v24.4s, v19.4s
ld1 { v20.16b, v21.16b }, [x17]
fmov w17, s18
addv s18, v19.4s
ld1 { v22.16b, v23.16b, v24.16b, v25.16b }, [x0]
mul w17, w17, w2
ubfx w0, w16, #8, #6
add x2, x15, #0x70
sub x3, x11, #0x40
shl v19.16b, v16.16b, #0x2
and v19.16b, v19.16b, v1.16b
fmov w4, s18
shl v18.16b, v17.16b, #0x2
and v18.16b, v18.16b, v1.16b
add v26.16b, v16.16b, v16.16b
and v26.16b, v26.16b, v1.16b
and v27.16b, v20.16b, v2.16b
orr v19.16b, v27.16b, v19.16b
and v27.16b, v21.16b, v2.16b
orr v18.16b, v27.16b, v18.16b
add v27.16b, v17.16b, v17.16b
and v27.16b, v27.16b, v1.16b
usra v26.16b, v20.16b, #0x4
madd w17, w4, w0, w17
usra v27.16b, v21.16b, #0x4
movi v20.2d, #0000000000000000
sdot v20.4s, v19.16b, v22.16b
movi v19.2d, #0000000000000000
sdot v19.4s, v18.16b, v23.16b
add v18.4s, v19.4s, v20.4s
ubfx w0, w16, #16, #6
movi v19.2d, #0000000000000000
sdot v19.4s, v26.16b, v24.16b
movi v20.2d, #0000000000000000
sdot v20.4s, v27.16b, v25.16b
addv s18, v18.4s
add v19.4s, v20.4s, v19.4s
addv s19, v19.4s
ubfx w16, w16, #24, #6
ld1 { v20.16b, v21.16b }, [x2]
fmov w2, s18
add x15, x15, #0x90
ld1 { v22.16b, v23.16b, v24.16b, v25.16b }, [x3]
fmov w3, s19
and v18.16b, v16.16b, v1.16b
and v19.16b, v17.16b, v1.16b
ushr v26.16b, v16.16b, #0x1
and v26.16b, v26.16b, v1.16b
and v27.16b, v20.16b, v2.16b
orr v18.16b, v27.16b, v18.16b
and v27.16b, v21.16b, v2.16b
orr v19.16b, v27.16b, v19.16b
ushr v27.16b, v17.16b, #0x1
and v27.16b, v27.16b, v1.16b
usra v26.16b, v20.16b, #0x4
madd w17, w2, w0, w17
usra v27.16b, v21.16b, #0x4
movi v20.2d, #0000000000000000
sdot v20.4s, v18.16b, v22.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v19.16b, v23.16b
madd w16, w3, w16, w17
add v18.4s, v18.4s, v20.4s
and w17, w14, #0x3f
movi v19.2d, #0000000000000000
sdot v19.4s, v26.16b, v24.16b
movi v20.2d, #0000000000000000
addv s18, v18.4s
sdot v20.4s, v27.16b, v25.16b
add v19.4s, v20.4s, v19.4s
addv s19, v19.4s
ld1 { v20.16b, v21.16b }, [x15]
fmov w15, s18
ubfx w0, w14, #8, #6
ld1 { v22.16b, v23.16b, v24.16b, v25.16b }, [x11]
fmov w2, s19
ushr v18.16b, v16.16b, #0x2
and v18.16b, v18.16b, v1.16b
ushr v19.16b, v17.16b, #0x2
and v19.16b, v19.16b, v1.16b
ushr v26.16b, v16.16b, #0x3
madd w15, w15, w17, w16
and v26.16b, v26.16b, v1.16b
ushr v16.16b, v17.16b, #0x3
and v16.16b, v16.16b, v1.16b
and v17.16b, v20.16b, v2.16b
and v27.16b, v21.16b, v2.16b
orr v17.16b, v17.16b, v18.16b
orr v18.16b, v27.16b, v19.16b
usra v26.16b, v20.16b, #0x4
usra v16.16b, v21.16b, #0x4
movi v19.2d, #0000000000000000
sdot v19.4s, v17.16b, v22.16b
madd w15, w2, w0, w15
movi v17.2d, #0000000000000000
sdot v17.4s, v18.16b, v23.16b
add v17.4s, v17.4s, v19.4s
addv s17, v17.4s
ubfx w14, w14, #16, #6
fmov w16, s17
movi v17.2d, #0000000000000000
sdot v17.4s, v26.16b, v24.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v16.16b, v25.16b
add v16.4s, v18.4s, v17.4s
madd w14, w16, w14, w15
addv s16, v16.4s
fmov w15, s16
madd w13, w15, w13, w14
ushll v7.8h, v7.8b, #0x0
smull v16.4s, v6.4h, v7.4h
fmul s3, s3, s5
smlal2 v16.4s, v6.8h, v7.8h
addv s5, v16.4s
scvtf s6, w13
scvtf s5, s5
fmul s4, s4, s6
fmul s3, s3, s5
fsub s3, s4, s3
fadd s0, s0, s3
add x8, x8, #0xb0
add x11, x11, #0x124
cmp x12, x8
b.ne candle_q5k_vec_dot_30
ret
candle_q5k_vec_dot_2fc:
movi d0, #0000000000000000
ret
