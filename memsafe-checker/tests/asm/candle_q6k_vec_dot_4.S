candle_q6k_vec_dot_4:
sub sp, sp, #0x140
stp d15, d14, [sp, #0xa0]
stp d13, d12, [sp, #0xb0]
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
ldr x10, [sp, #0x140]
cmp x4, x2
csel x11, x4, x2, lo
cmp x6, x11
csel x11, x6, x11, lo
cmp x10, x11
csel x10, x10, x11, lo
cmp x8, x10
csel x8, x8, x10, lo
str x8, [sp, #0x78]
cbz x8, candle_q6k_vec_dot_4_788
mov x10, #0x0               // =0
mov x11, #0x0               // =0
ldr x9, [sp, #0x148]
add x8, x1, #0x80
stp x8, x9, [sp, #0x50]
add x9, x1, #0xc0
add x8, x3, #0x80
stp x8, x9, [sp, #0x40]
movi d0, #0000000000000000
add x9, x3, #0xc0
movi v1.16b, #0x30
add x8, x5, #0x80
stp x8, x9, [sp, #0x30]
add x9, x7, #0xc7
movi v5.16b, #0xf
add x8, x7, #0x80
stp x8, x9, [sp, #0x20]
add x8, x5, #0xc0
str x8, [sp, #0x18]
movi d3, #0000000000000000
movi d4, #0000000000000000
movi d2, #0000000000000000
stp x5, x7, [sp, #0x68]
str x3, [sp, #0x60]
candle_q6k_vec_dot_4_c0:
mov w4, #0x0                // =0
mov w26, #0x0               // =0
mov w25, #0x0               // =0
mov w24, #0x0               // =0
mov w8, #0xd2               // =210
mul x8, x11, x8
add x23, x1, x8
add x22, x3, x8
add x20, x5, x8
ldr x9, [sp, #0x58]
mov w12, #0x124             // =292
madd x27, x11, x12, x9
add x12, x27, #0x104
ldr s6, [x27], #0x4
ld1 { v16.8h, v17.8h }, [x12]
add x21, x7, x8
ldr q20, [x23, #0xc0]
ldr q19, [x22, #0xc0]
ldr q7, [x20, #0xc0]
str q7, [sp, #0x80]
mov w6, #0x1                // =1
ldp x28, x2, [sp, #0x18]
ldr q7, [x21, #0xc0]
str q7, [sp, #0x90]
mov x30, x7
ldp x0, x17, [sp, #0x28]
ldp x16, x15, [sp, #0x38]
ldp x13, x19, [sp, #0x48]
mov x9, x1
candle_q6k_vec_dot_4_134:
add x8, x1, x10
add x14, x19, x10
add x12, x13, x10
mov x7, x27
ld1 { v25.16b, v26.16b, v27.16b, v28.16b }, [x7], #64
ld1 { v29.16b, v30.16b }, [x14]
ld1 { v21.16b, v22.16b, v23.16b, v24.16b }, [x7]
add x7, x3, x10
ld1 { v8.16b, v9.16b, v10.16b, v11.16b }, [x8]
shl v31.16b, v29.16b, #0x4
and v31.16b, v31.16b, v1.16b
shl v12.16b, v30.16b, #0x4
and v12.16b, v12.16b, v1.16b
shl v13.16b, v29.16b, #0x2
shl v14.16b, v30.16b, #0x2
and v13.16b, v13.16b, v1.16b
and v14.16b, v14.16b, v1.16b
and v15.16b, v8.16b, v5.16b
orr v15.16b, v31.16b, v15.16b
and v31.16b, v9.16b, v5.16b
and v7.16b, v10.16b, v5.16b
orr v18.16b, v12.16b, v31.16b
orr v31.16b, v13.16b, v7.16b
and v7.16b, v11.16b, v5.16b
orr v12.16b, v14.16b, v7.16b
movi v7.2d, #0000000000000000
movi v13.2d, #0000000000000000
sdot v7.4s, v15.16b, v25.16b
sdot v13.4s, v18.16b, v26.16b
addv s7, v7.4s
fmov w8, s7
ldrsb w14, [x12]
addv s7, v13.4s
madd w8, w8, w14, w4
ldrsb w14, [x12, #0x1]
movi v18.2d, #0000000000000000
sdot v18.4s, v31.16b, v27.16b
movi v31.2d, #0000000000000000
sdot v31.4s, v12.16b, v28.16b
fmov w4, s7
addv s7, v18.4s
madd w8, w4, w14, w8
fmov w14, s7
ldrsb w4, [x12, #0x2]
addv s7, v31.4s
madd w8, w14, w4, w8
ldrsb w14, [x12, #0x3]
and v18.16b, v29.16b, v1.16b
and v31.16b, v30.16b, v1.16b
usra v18.16b, v8.16b, #0x4
usra v31.16b, v9.16b, #0x4
fmov w4, s7
movi v7.2d, #0000000000000000
sdot v7.4s, v18.16b, v21.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v31.16b, v22.16b
addv s7, v7.4s
madd w8, w4, w14, w8
fmov w14, s7
ldrsb w4, [x12, #0x4]
addv s7, v18.4s
madd w8, w14, w4, w8
ldrsb w14, [x12, #0x5]
fmov w4, s7
madd w14, w4, w14, w8
add x4, x15, x10
add x8, x16, x10
ushr v7.16b, v29.16b, #0x2
ushr v18.16b, v30.16b, #0x2
and v7.16b, v7.16b, v1.16b
and v18.16b, v18.16b, v1.16b
usra v7.16b, v10.16b, #0x4
usra v18.16b, v11.16b, #0x4
movi v29.2d, #0000000000000000
movi v31.2d, #0000000000000000
sdot v29.4s, v7.16b, v23.16b
sdot v31.4s, v18.16b, v24.16b
ld1 { v8.16b, v9.16b, v10.16b, v11.16b }, [x7]
addv s7, v29.4s
fmov w7, s7
ld1 { v29.16b, v30.16b }, [x4]
ldrsb w4, [x12, #0x6]
ldrsb w12, [x12, #0x7]
shl v7.16b, v29.16b, #0x4
and v7.16b, v7.16b, v1.16b
shl v18.16b, v30.16b, #0x4
and v18.16b, v18.16b, v1.16b
and v12.16b, v8.16b, v5.16b
and v13.16b, v9.16b, v5.16b
orr v7.16b, v7.16b, v12.16b
orr v18.16b, v18.16b, v13.16b
movi v12.2d, #0000000000000000
sdot v12.4s, v7.16b, v25.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v18.16b, v26.16b
madd w4, w7, w4, w14
addv s18, v12.4s
fmov w7, s18
ldrsb w14, [x8]
addv s7, v7.4s
madd w14, w7, w14, w26
fmov w7, s7
ldrsb w26, [x8, #0x1]
madd w14, w7, w26, w14
addv s7, v31.4s
fmov w7, s7
shl v7.16b, v29.16b, #0x2
and v7.16b, v7.16b, v1.16b
shl v18.16b, v30.16b, #0x2
and v18.16b, v18.16b, v1.16b
and v31.16b, v10.16b, v5.16b
orr v7.16b, v7.16b, v31.16b
and v31.16b, v11.16b, v5.16b
orr v18.16b, v18.16b, v31.16b
movi v31.2d, #0000000000000000
sdot v31.4s, v7.16b, v27.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v18.16b, v28.16b
addv s18, v31.4s
madd w4, w7, w12, w4
fmov w12, s18
ldrsb w7, [x8, #0x2]
and v18.16b, v29.16b, v1.16b
and v31.16b, v30.16b, v1.16b
madd w12, w12, w7, w14
ldrsb w14, [x8, #0x3]
ushr v12.16b, v29.16b, #0x2
and v12.16b, v12.16b, v1.16b
ushr v29.16b, v30.16b, #0x2
and v29.16b, v29.16b, v1.16b
usra v18.16b, v8.16b, #0x4
addv s7, v7.4s
usra v31.16b, v9.16b, #0x4
usra v12.16b, v10.16b, #0x4
usra v29.16b, v11.16b, #0x4
movi v30.2d, #0000000000000000
sdot v30.4s, v18.16b, v21.16b
fmov w7, s7
movi v7.2d, #0000000000000000
sdot v7.4s, v31.16b, v22.16b
addv s18, v30.4s
madd w12, w7, w14, w12
ldrsb w14, [x8, #0x4]
fmov w7, s18
addv s7, v7.4s
madd w12, w7, w14, w12
ldrsb w14, [x8, #0x5]
movi v18.2d, #0000000000000000
sdot v18.4s, v12.16b, v23.16b
fmov w7, s7
movi v7.2d, #0000000000000000
sdot v7.4s, v29.16b, v24.16b
addv s18, v18.4s
madd w12, w7, w14, w12
ldrsb w14, [x8, #0x6]
fmov w7, s18
madd w14, w7, w14, w12
add x7, x5, x10
add x12, x17, x10
ld1 { v29.16b, v30.16b }, [x12]
add x12, x28, x10
addv s7, v7.4s
ld1 { v8.16b, v9.16b, v10.16b, v11.16b }, [x7]
fmov w7, s7
ldrsb w8, [x8, #0x7]
shl v7.16b, v29.16b, #0x4
and v7.16b, v7.16b, v1.16b
shl v18.16b, v30.16b, #0x4
shl v31.16b, v29.16b, #0x2
and v18.16b, v18.16b, v1.16b
and v31.16b, v31.16b, v1.16b
shl v12.16b, v30.16b, #0x2
and v12.16b, v12.16b, v1.16b
and v13.16b, v8.16b, v5.16b
and v14.16b, v9.16b, v5.16b
orr v7.16b, v7.16b, v13.16b
orr v18.16b, v18.16b, v14.16b
and v13.16b, v10.16b, v5.16b
orr v31.16b, v31.16b, v13.16b
and v13.16b, v11.16b, v5.16b
orr v12.16b, v12.16b, v13.16b
madd w26, w7, w8, w14
movi v13.2d, #0000000000000000
sdot v13.4s, v7.16b, v25.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v18.16b, v26.16b
addv s18, v13.4s
fmov w8, s18
ldrsb w14, [x12]
addv s7, v7.4s
madd w8, w8, w14, w25
ldrsb w14, [x12, #0x1]
movi v18.2d, #0000000000000000
fmov w7, s7
sdot v18.4s, v31.16b, v27.16b
movi v7.2d, #0000000000000000
sdot v7.4s, v12.16b, v28.16b
addv s18, v18.4s
madd w8, w7, w14, w8
fmov w14, s18
ldrsb w7, [x12, #0x2]
and v18.16b, v29.16b, v1.16b
and v31.16b, v30.16b, v1.16b
ushr v12.16b, v29.16b, #0x2
madd w8, w14, w7, w8
ldrsb w14, [x12, #0x3]
and v12.16b, v12.16b, v1.16b
ushr v29.16b, v30.16b, #0x2
and v29.16b, v29.16b, v1.16b
usra v18.16b, v8.16b, #0x4
usra v31.16b, v9.16b, #0x4
addv s7, v7.4s
usra v12.16b, v10.16b, #0x4
usra v29.16b, v11.16b, #0x4
movi v30.2d, #0000000000000000
sdot v30.4s, v18.16b, v21.16b
movi v18.2d, #0000000000000000
fmov w7, s7
sdot v18.4s, v31.16b, v22.16b
addv s7, v30.4s
madd w8, w7, w14, w8
ldrsb w14, [x12, #0x4]
addv s18, v18.4s
fmov w7, s7
madd w8, w7, w14, w8
ldrsb w14, [x12, #0x5]
movi v7.2d, #0000000000000000
sdot v7.4s, v12.16b, v23.16b
movi v31.2d, #0000000000000000
fmov w7, s18
sdot v31.4s, v29.16b, v24.16b
addv s7, v7.4s
madd w8, w7, w14, w8
fmov w14, s7
ldrsb w7, [x12, #0x6]
madd w14, w14, w7, w8
add x8, x0, x10
add x7, x2, x10
ld1 { v29.16b, v30.16b }, [x7]
add x7, x30, x10
addv s7, v31.4s
ldrsb w12, [x12, #0x7]
ld1 { v8.16b, v9.16b, v10.16b, v11.16b }, [x7]
fmov w7, s7
shl v7.16b, v29.16b, #0x4
and v7.16b, v7.16b, v1.16b
shl v18.16b, v30.16b, #0x4
and v18.16b, v18.16b, v1.16b
shl v31.16b, v29.16b, #0x2
and v31.16b, v31.16b, v1.16b
shl v12.16b, v30.16b, #0x2
and v12.16b, v12.16b, v1.16b
and v13.16b, v8.16b, v5.16b
orr v7.16b, v7.16b, v13.16b
and v13.16b, v9.16b, v5.16b
orr v18.16b, v18.16b, v13.16b
and v13.16b, v10.16b, v5.16b
orr v31.16b, v31.16b, v13.16b
movi v13.2d, #0000000000000000
sdot v13.4s, v7.16b, v25.16b
movi v7.2d, #0000000000000000
madd w25, w7, w12, w14
sdot v7.4s, v18.16b, v26.16b
and v18.16b, v11.16b, v5.16b
addv s13, v13.4s
fmov w12, s13
ldursb w14, [x8, #-0x7]
orr v12.16b, v12.16b, v18.16b
addv s7, v7.4s
madd w12, w12, w14, w24
ldursb w14, [x8, #-0x6]
movi v18.2d, #0000000000000000
sdot v18.4s, v31.16b, v27.16b
fmov w7, s7
movi v7.2d, #0000000000000000
sdot v7.4s, v12.16b, v28.16b
addv s18, v18.4s
madd w12, w7, w14, w12
ldursb w14, [x8, #-0x5]
fmov w7, s18
madd w12, w7, w14, w12
ldursb w14, [x8, #-0x4]
and v18.16b, v29.16b, v1.16b
and v25.16b, v30.16b, v1.16b
ushr v26.16b, v29.16b, #0x2
addv s7, v7.4s
and v26.16b, v26.16b, v1.16b
ushr v27.16b, v30.16b, #0x2
and v27.16b, v27.16b, v1.16b
usra v18.16b, v8.16b, #0x4
usra v25.16b, v9.16b, #0x4
fmov w7, s7
usra v26.16b, v10.16b, #0x4
usra v27.16b, v11.16b, #0x4
movi v7.2d, #0000000000000000
sdot v7.4s, v18.16b, v21.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v25.16b, v22.16b
addv s7, v7.4s
madd w12, w7, w14, w12
fmov w14, s7
ldursb w7, [x8, #-0x3]
addv s7, v18.4s
madd w12, w14, w7, w12
fmov w14, s7
ldursb w7, [x8, #-0x2]
movi v7.2d, #0000000000000000
sdot v7.4s, v26.16b, v23.16b
movi v18.2d, #0000000000000000
sdot v18.4s, v27.16b, v24.16b
addv s7, v7.4s
madd w12, w14, w7, w12
fmov w14, s7
ldursb w7, [x8, #-0x1]
madd w12, w14, w7, w12
addv s7, v18.4s
fmov w14, s7
ldrsb w8, [x8]
madd w24, w14, w8, w12
mov x8, x6
add x1, x1, #0x40
add x19, x19, #0x20
add x13, x13, #0x8
add x3, x3, #0x40
add x15, x15, #0x20
add x16, x16, #0x8
add x5, x5, #0x40
add x17, x17, #0x20
add x0, x0, #0x8
add x2, x2, #0x20
add x30, x30, #0x40
add x28, x28, #0x8
add x27, x27, #0x80
mov w6, #0x0                // =0
tbnz w8, #0x0, candle_q6k_vec_dot_4_134
add x11, x11, #0x1
sshll v7.8h, v20.8b, #0x0
sshll2 v18.8h, v20.16b, #0x0
smull v20.4s, v16.4h, v7.4h
smlal2 v20.4s, v16.8h, v7.8h
smlal v20.4s, v17.4h, v18.4h
smlal2 v20.4s, v17.8h, v18.8h
addv s7, v20.4s
fmov w8, s7
sshll v7.8h, v19.8b, #0x0
sshll2 v18.8h, v19.16b, #0x0
smull v19.4s, v16.4h, v7.4h
smlal2 v19.4s, v16.8h, v7.8h
smlal v19.4s, v17.4h, v18.4h
smlal2 v19.4s, v17.8h, v18.8h
addv s7, v19.4s
fmov w12, s7
ldr q18, [sp, #0x80]
sshll v7.8h, v18.8b, #0x0
sshll2 v18.8h, v18.16b, #0x0
smull v19.4s, v16.4h, v7.4h
smlal2 v19.4s, v16.8h, v7.8h
smlal v19.4s, v17.4h, v18.4h
smlal2 v19.4s, v17.8h, v18.8h
addv s7, v19.4s
fmov w13, s7
ldr q18, [sp, #0x90]
sshll v7.8h, v18.8b, #0x0
sshll2 v18.8h, v18.16b, #0x0
smull v19.4s, v16.4h, v7.4h
smlal2 v19.4s, v16.8h, v7.8h
smlal v19.4s, v17.4h, v18.4h
smlal2 v19.4s, v17.8h, v18.8h
addv s7, v19.4s
fmov w14, s7
ldr h7, [x23, #0xd0]
fcvt s16, h7
fmul s7, s6, s16
sub w8, w4, w8, lsl #5
scvtf s16, w8
fmul s7, s7, s16
fadd s0, s0, s7
ldr h7, [x22, #0xd0]
fcvt s16, h7
fmul s7, s6, s16
sub w8, w26, w12, lsl #5
scvtf s16, w8
fmul s7, s7, s16
fadd s3, s3, s7
ldr h7, [x20, #0xd0]
fcvt s16, h7
fmul s7, s6, s16
sub w8, w25, w13, lsl #5
scvtf s16, w8
fmul s7, s7, s16
fadd s4, s4, s7
ldr h7, [x21, #0xd0]
fcvt s16, h7
fmul s6, s6, s16
sub w8, w24, w14, lsl #5
scvtf s7, w8
fmul s6, s6, s7
fadd s2, s2, s6
add x10, x10, #0xd2
ldp x7, x8, [sp, #0x70]
cmp x11, x8
ldp x3, x5, [sp, #0x60]
mov x1, x9
b.ne candle_q6k_vec_dot_4_c0
b candle_q6k_vec_dot_4_798
candle_q6k_vec_dot_4_788:
movi d2, #0000000000000000
movi d4, #0000000000000000
movi d3, #0000000000000000
movi d0, #0000000000000000
candle_q6k_vec_dot_4_798:
ldr x8, [sp, #0x10]
stp s0, s3, [x8]
stp s4, s2, [x8, #0x8]
ldp x29, x30, [sp, #0x130]
ldp x20, x19, [sp, #0x120]
ldp x22, x21, [sp, #0x110]
ldp x24, x23, [sp, #0x100]
ldp x26, x25, [sp, #0xf0]
ldp x28, x27, [sp, #0xe0]
ldp d9, d8, [sp, #0xd0]
ldp d11, d10, [sp, #0xc0]
ldp d13, d12, [sp, #0xb0]
ldp d15, d14, [sp, #0xa0]
add sp, sp, #0x140
ret
