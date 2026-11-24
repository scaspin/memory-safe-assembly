candle_q4k_vec_dot_4:
sub sp, sp, #0x140
stp d11, d10, [sp, #0xc0]
stp d9, d8, [sp, #0xd0]
stp x28, x27, [sp, #0xe0]
stp x26, x25, [sp, #0xf0]
stp x24, x23, [sp, #0x100]
stp x22, x21, [sp, #0x110]
stp x20, x19, [sp, #0x120]
stp x29, x30, [sp, #0x130]
str x8, [sp, #0x10]
ldr x8, [sp, #0x150]
ldr x9, [sp, #0x140]
cmp x4, x2
csel x10, x4, x2, lo
cmp x6, x10
csel x10, x6, x10, lo
cmp x9, x10
csel x9, x9, x10, lo
cmp x8, x9
csel x8, x8, x9, lo
str x8, [sp, #0x60]
cbz x8, candle_q4k_vec_dot_4_498
mov x10, #0x0               // =0
mov w11, #0x3f3f3f3f        // =1061109567
ldr x9, [sp, #0x148]
mov w13, #0x30303030        // =808464432
mov w14, #0xf0f0f0f         // =252645135
add x15, x1, #0x10
add x16, x3, #0x10
add x17, x5, #0x10
add x0, x7, #0x10
add x8, sp, #0x80
orr x8, x8, #0x1
stp x8, x9, [sp, #0x30]
add x8, sp, #0x90
orr x9, x8, #0x1
add x8, sp, #0xb0
orr x8, x8, #0x1
stp x8, x9, [sp, #0x20]
add x8, sp, #0xa0
movi v0.16b, #0xf
orr x8, x8, #0x1
str x8, [sp, #0x18]
movi v1.2d, #0000000000000000
stp x5, x7, [sp, #0x50]
stp x1, x3, [sp, #0x40]
candle_q4k_vec_dot_4_b8:
mov x21, #0x0               // =0
ldr x8, [sp, #0x38]
mov w9, #0x124              // =292
madd x22, x10, x9, x8
add x8, x22, #0x104
add x9, x22, #0x114
ldr s2, [x22], #0x4
ldr q17, [x8]
ldr q18, [x9]
add x8, x10, x10, lsl #3
mov w9, #0x4                // =4
bfi x9, x8, #4, #60
add x12, x1, x9
ldp w4, w23, [x12]
ldr w24, [x12, #0x8]
and w12, w24, w14
and w2, w13, w4, lsr #2
orr w12, w2, w12
and w2, w4, w11
stp w2, w12, [sp, #0x80]
lsl x12, x8, #4
add x8, x7, x9
add x6, x5, x9
stp w24, wzr, [sp, #0x88]
add x9, x3, x9
ldp w2, w25, [x9]
ldr w28, [x9, #0x8]
and w9, w28, w14
and w4, w13, w2, lsr #2
orr w9, w4, w9
and w2, w2, w11
stp w2, w9, [sp, #0x90]
stp w28, wzr, [sp, #0x98]
ldp w9, w26, [x6]
ldr w20, [x6, #0x8]
and w4, w20, w14
and w2, w13, w9, lsr #2
orr w2, w2, w4
and w9, w9, w11
stp w9, w2, [sp, #0xa0]
stp w20, wzr, [sp, #0xa8]
ldp w9, w30, [x8]
ldr w8, [x8, #0x8]
and w4, w8, w14
and w2, w13, w9, lsr #2
orr w2, w2, w4
and w9, w9, w11
stp w9, w2, [sp, #0xb0]
stp w8, wzr, [sp, #0xb8]
add x9, x1, x12
add x4, x3, x12
add x2, x5, x12
add x12, x7, x12
ldrh w3, [x9]
ldrh w1, [x4]
stp w3, w1, [sp, #0x74]
ldp x7, x5, [sp, #0x18]
ldp x3, x1, [sp, #0x28]
ldrh w19, [x2]
movi v3.2d, #0000000000000000
ldrh w27, [x12]
movi v4.2d, #0000000000000000
movi v5.2d, #0000000000000000
ldrh w9, [x9, #0x2]
movi v6.2d, #0000000000000000
ldrh w4, [x4, #0x2]
movi v7.2d, #0000000000000000
movi v16.2d, #0000000000000000
ldrh w2, [x2, #0x2]
stp w4, w2, [sp, #0x6c]
movi v19.2d, #0000000000000000
movi v20.2d, #0000000000000000
ldrh w12, [x12, #0x2]
str w12, [sp, #0x7c]
candle_q4k_vec_dot_4_1e0:
mov x12, x22
ld1 { v23.16b, v24.16b }, [x12], #32
add x2, x15, x21
add x4, x16, x21
ld1 { v21.16b, v22.16b }, [x12]
ld1 { v25.16b, v26.16b }, [x2]
add x2, x17, x21
add x12, x0, x21
and v27.16b, v25.16b, v0.16b
and v28.16b, v26.16b, v0.16b
movi v29.2d, #0000000000000000
sdot v29.4s, v27.16b, v23.16b
sdot v29.4s, v28.16b, v24.16b
ldurb w6, [x1, #-0x1]
ushr v27.16b, v25.16b, #0x4
ushr v25.16b, v26.16b, #0x4
movi v26.2d, #0000000000000000
sdot v26.4s, v27.16b, v21.16b
sdot v26.4s, v25.16b, v22.16b
dup v25.4s, w6
ldrb w6, [x1], #0x2
dup v27.4s, w6
ld1 { v30.16b, v31.16b }, [x4]
mla v20.4s, v25.4s, v29.4s
and v25.16b, v30.16b, v0.16b
and v28.16b, v31.16b, v0.16b
movi v29.2d, #0000000000000000
sdot v29.4s, v25.16b, v23.16b
sdot v29.4s, v28.16b, v24.16b
ldurb w4, [x3, #-0x1]
mla v19.4s, v27.4s, v26.4s
ushr v25.16b, v30.16b, #0x4
ushr v26.16b, v31.16b, #0x4
movi v27.2d, #0000000000000000
sdot v27.4s, v25.16b, v21.16b
sdot v27.4s, v26.16b, v22.16b
dup v25.4s, w4
ldrb w4, [x3], #0x2
dup v26.4s, w4
ld1 { v30.16b, v31.16b }, [x2]
and v28.16b, v30.16b, v0.16b
and v8.16b, v31.16b, v0.16b
movi v9.2d, #0000000000000000
sdot v9.4s, v28.16b, v23.16b
sdot v9.4s, v8.16b, v24.16b
ldurb w2, [x7, #-0x1]
ushr v28.16b, v30.16b, #0x4
mla v16.4s, v25.4s, v29.4s
ushr v25.16b, v31.16b, #0x4
movi v29.2d, #0000000000000000
sdot v29.4s, v28.16b, v21.16b
sdot v29.4s, v25.16b, v22.16b
ldrb w4, [x7], #0x2
dup v25.4s, w2
ld1 { v30.16b, v31.16b }, [x12]
and v28.16b, v30.16b, v0.16b
and v8.16b, v31.16b, v0.16b
movi v10.2d, #0000000000000000
sdot v10.4s, v28.16b, v23.16b
sdot v10.4s, v8.16b, v24.16b
mla v7.4s, v26.4s, v27.4s
mla v6.4s, v25.4s, v9.4s
dup v23.4s, w4
ldurb w12, [x5, #-0x1]
mla v5.4s, v23.4s, v29.4s
ushr v23.16b, v30.16b, #0x4
ushr v24.16b, v31.16b, #0x4
movi v25.2d, #0000000000000000
sdot v25.4s, v23.16b, v21.16b
sdot v25.4s, v24.16b, v22.16b
dup v21.4s, w12
ldrb w12, [x5], #0x2
dup v22.4s, w12
add x21, x21, #0x20
mla v4.4s, v21.4s, v10.4s
mla v3.4s, v22.4s, v25.4s
add x22, x22, #0x40
cmp x21, #0x80
b.ne candle_q4k_vec_dot_4_1e0
add x10, x10, #0x1
addp v17.8h, v17.8h, v18.8h
and w12, w23, w11
and w1, w14, w24, lsr #4
and w2, w13, w23, lsr #2
orr w1, w1, w2
fmov s18, w12
mov v18.s[1], w1
ushll v18.8h, v18.8b, #0x0
and w12, w25, w11
and w1, w14, w28, lsr #4
and w2, w13, w25, lsr #2
orr w1, w1, w2
fmov s21, w12
mov v21.s[1], w1
ushll v23.8h, v21.8b, #0x0
and w12, w26, w11
and w1, w14, w20, lsr #4
and w2, w13, w26, lsr #2
orr w1, w1, w2
fmov s21, w12
mov v21.s[1], w1
ushll v24.8h, v21.8b, #0x0
and w12, w30, w11
and w8, w14, w8, lsr #4
and w1, w13, w30, lsr #2
orr w8, w8, w1
fmov s21, w12
mov v21.s[1], w8
ushll v25.8h, v21.8b, #0x0
ldp s26, s21, [sp, #0x74]
fcvt s22, h26
fcvt s26, h21
fmov s21, w19
fcvt s27, h21
fmov s21, w27
fcvt s28, h21
smull v21.4s, v17.4h, v18.4h
smlal2 v21.4s, v17.8h, v18.8h
fmov s29, w9
fcvt s18, h29
addv s21, v21.4s
smull v29.4s, v17.4h, v23.4h
smlal2 v29.4s, v17.8h, v23.8h
ldr s23, [sp, #0x6c]
fcvt s30, h23
addv s23, v29.4s
smull v29.4s, v17.4h, v24.4h
smlal2 v29.4s, v17.8h, v24.8h
ldr s24, [sp, #0x70]
fcvt s31, h24
addv s24, v29.4s
smull v29.4s, v17.4h, v25.4h
smlal2 v29.4s, v17.8h, v25.8h
ldr s17, [sp, #0x7c]
fcvt s25, h17
addv s17, v29.4s
add v19.4s, v19.4s, v20.4s
addv s19, v19.4s
add v7.4s, v7.4s, v16.4s
addv s7, v7.4s
add v5.4s, v5.4s, v6.4s
addv s5, v5.4s
add v3.4s, v3.4s, v4.4s
mov v22.s[1], v26.s[0]
addv s3, v3.4s
mov v22.s[2], v27.s[0]
mov v22.s[3], v28.s[0]
fmul v4.4s, v22.4s, v2.s[0]
mov v18.s[1], v30.s[0]
mov v18.s[2], v31.s[0]
mov v18.s[3], v25.s[0]
mov v21.s[1], v23.s[0]
mov v21.s[2], v24.s[0]
mov v21.s[3], v17.s[0]
fmul v2.4s, v18.4s, v2.s[0]
scvtf v6.4s, v21.4s
fmul v2.4s, v2.4s, v6.4s
fsub v1.4s, v1.4s, v2.4s
mov v19.s[1], v7.s[0]
mov v19.s[2], v5.s[0]
mov v19.s[3], v3.s[0]
scvtf v2.4s, v19.4s
fmul v2.4s, v4.4s, v2.4s
add x15, x15, #0x90
fadd v1.4s, v2.4s, v1.4s
add x16, x16, #0x90
add x17, x17, #0x90
add x0, x0, #0x90
ldp x7, x8, [sp, #0x58]
cmp x10, x8
ldp x3, x5, [sp, #0x48]
ldr x1, [sp, #0x40]
b.ne candle_q4k_vec_dot_4_b8
b candle_q4k_vec_dot_4_49c
candle_q4k_vec_dot_4_498:
movi v1.2d, #0000000000000000
candle_q4k_vec_dot_4_49c:
ldr x8, [sp, #0x10]
str q1, [x8]
ldp x29, x30, [sp, #0x130]
ldp x20, x19, [sp, #0x120]
ldp x22, x21, [sp, #0x110]
ldp x24, x23, [sp, #0x100]
ldp x26, x25, [sp, #0xf0]
ldp x28, x27, [sp, #0xe0]
ldp d9, d8, [sp, #0xd0]
ldp d11, d10, [sp, #0xc0]
add sp, sp, #0x140
ret
