candle_q4k_vec_dot:
cmp x4, x2
csel x12, x4, x2, lo
cbz x12, candle_q4k_vec_dot_290
stp x22, x21, [sp, #-0x20]!
stp x20, x19, [sp, #0x10]
mov x8, #0x0                // =0
mov w9, #0x30303030         // =808464432
mov w10, #0xf0f0f0f         // =252645135
add x11, x1, #0x70
mov w13, #0x124             // =292
mul x12, x12, x13
movi d0, #0000000000000000
movi v1.16b, #0xf
candle_q4k_vec_dot_34:
add x17, x3, x8
add x14, x17, #0x104
add x15, x17, #0x114
add x16, x17, #0x4
add x1, x17, #0x24
add x0, x17, #0x44
add x2, x17, #0x64
add x4, x17, #0x84
add x6, x17, #0xa4
add x7, x17, #0xc4
ldr s3, [x17], #0xe4
ldr q4, [x14]
ldr q5, [x15]
ldp w5, w15, [x11, #-0x6c]
ldur w19, [x11, #-0x64]
and w13, w19, w10
and w14, w9, w5, lsr #2
orr w14, w14, w13
ubfx w13, w5, #24, #6
ldur h2, [x11, #-0x70]
fcvt s6, h2
ldur h7, [x11, #-0x6e]
fmul s2, s3, s6
fcvt s6, h7
fmul s3, s3, s6
sub x20, x11, #0x60
and w21, w15, #0x3f3f3f3f
and w19, w10, w19, lsr #4
addp v4.8h, v4.8h, v5.8h
and w15, w9, w15, lsr #2
orr w19, w19, w15
fmov s5, w21
ld1 { v6.16b, v7.16b }, [x20]
lsr w15, w14, #24
sub x20, x11, #0x40
ld1 { v16.16b, v17.16b }, [x16]
and v18.16b, v6.16b, v1.16b
mov v5.s[1], w19
and v19.16b, v7.16b, v1.16b
movi v20.2d, #0000000000000000
sdot v20.4s, v18.16b, v16.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v19.16b, v17.16b
ushll v5.8h, v5.8b, #0x0
add v16.4s, v18.4s, v20.4s
addv s16, v16.4s
ld1 { v17.16b, v18.16b }, [x1]
ushr v19.16b, v6.16b, #0x4
fmov w16, s16
ushr v6.16b, v7.16b, #0x4
movi v7.2d, #0000000000000000
sdot v7.4s, v19.16b, v17.16b
movi v16.2d, #0000000000000000
sdot v16.4s, v6.16b, v18.16b
smull v6.4s, v4.4h, v5.4h
add v7.4s, v16.4s, v7.4s
addv s7, v7.4s
and w1, w5, #0x3f
mul w16, w16, w1
ubfx w1, w5, #8, #6
smlal2 v6.4s, v4.8h, v5.8h
ld1 { v16.16b, v17.16b }, [x20]
sub x19, x11, #0x20
ld1 { v4.16b, v5.16b }, [x0]
fmov w0, s7
and v7.16b, v16.16b, v1.16b
and v18.16b, v17.16b, v1.16b
movi v19.2d, #0000000000000000
sdot v19.4s, v7.16b, v4.16b
movi v7.2d, #0000000000000000
addv s6, v6.4s
sdot v7.4s, v18.16b, v5.16b
add v4.4s, v7.4s, v19.4s
addv s5, v4.4s
ld1 { v18.16b, v19.16b }, [x2]
scvtf s4, s6
ushr v6.16b, v16.16b, #0x4
ushr v7.16b, v17.16b, #0x4
movi v16.2d, #0000000000000000
sdot v16.4s, v6.16b, v18.16b
movi v6.2d, #0000000000000000
fmov w2, s5
sdot v6.4s, v7.16b, v19.16b
add v5.4s, v6.4s, v16.4s
addv s5, v5.4s
ld1 { v6.16b, v7.16b }, [x19]
fmov w19, s5
ld1 { v16.16b, v17.16b }, [x4]
and v5.16b, v6.16b, v1.16b
and v18.16b, v7.16b, v1.16b
movi v19.2d, #0000000000000000
sdot v19.4s, v5.16b, v16.16b
movi v5.2d, #0000000000000000
sdot v5.4s, v18.16b, v17.16b
add v5.4s, v5.4s, v19.4s
ld1 { v16.16b, v17.16b }, [x6]
addv s5, v5.4s
ushr v18.16b, v6.16b, #0x4
ushr v6.16b, v7.16b, #0x4
movi v7.2d, #0000000000000000
sdot v7.4s, v18.16b, v16.16b
movi v18.2d, #0000000000000000
fmov w4, s5
sdot v18.4s, v6.16b, v17.16b
ld1 { v5.16b, v6.16b }, [x11]
ld1 { v16.16b, v17.16b }, [x7]
add v7.4s, v18.4s, v7.4s
and v18.16b, v5.16b, v1.16b
and v19.16b, v6.16b, v1.16b
movi v20.2d, #0000000000000000
sdot v20.4s, v18.16b, v16.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v19.16b, v17.16b
ubfx w5, w5, #16, #6
addv s7, v7.4s
fmov w6, s7
and w7, w14, #0x3f
ubfx w20, w14, #8, #6
add v7.4s, v18.4s, v20.4s
addv s7, v7.4s
ushr v16.16b, v5.16b, #0x4
ushr v5.16b, v6.16b, #0x4
ld1 { v17.16b, v18.16b }, [x17]
fmov w17, s7
movi v6.2d, #0000000000000000
sdot v6.4s, v16.16b, v17.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v18.16b
add v5.4s, v7.4s, v6.4s
addv s5, v5.4s
ubfx w14, w14, #16, #6
madd w16, w0, w1, w16
madd w16, w2, w5, w16
madd w13, w19, w13, w16
madd w13, w4, w7, w13
fmov w16, s5
madd w13, w6, w20, w13
madd w13, w17, w14, w13
madd w13, w16, w15, w13
scvtf s5, w13
fmul s3, s3, s4
fsub s0, s0, s3
fmul s2, s2, s5
fadd s0, s0, s2
add x11, x11, #0x90
add x8, x8, #0x124
cmp x12, x8
b.ne candle_q4k_vec_dot_34
ldp x20, x19, [sp, #0x10]
ldp x22, x21, [sp], #0x20
ret
candle_q4k_vec_dot_290:
movi d0, #0000000000000000
ret
