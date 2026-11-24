candle_q2k_vec_dot:
cmp x4, x2
csel x9, x4, x2, lo
cbz x9, candle_q2k_vec_dot_2bc
sub sp, sp, #0x60
stp d15, d14, [sp, #0x20]
stp d13, d12, [sp, #0x30]
stp d11, d10, [sp, #0x40]
stp d9, d8, [sp, #0x50]
mov x8, #0x0                // =0
mov w10, #0x124             // =292
mul x9, x9, x10
mov x10, #0x0
movi v0.16b, #0x0
str q0, [sp, #0x10]
mov x10, #0x0
movi v0.16b, #0x0
str q0, [sp]
mov x10, #0x0
movi v3.16b, #0x0
mov x10, #0x0
movi v4.16b, #0x0
add x10, x1, #0x30
movi d0, #0000000000000000
movi v5.16b, #0x3
candle_q2k_vec_dot_60:
add x11, x3, x8
sub x13, x10, #0x20
add x14, x11, #0x4
add x12, x11, #0x104
ld1 { v16.16b, v17.16b }, [x13]
ld1 { v18.16b, v19.16b }, [x14]
add x15, x11, #0x24
add x13, x11, #0x44
add x14, x11, #0x64
add x16, x11, #0x84
add x0, x11, #0xa4
add x17, x11, #0xc4
ld1 { v29.8h, v30.8h }, [x12]
ldr s26, [x11], #0xe4
ldur q20, [x10, #-0x30]
and v7.16b, v16.16b, v5.16b
and v21.16b, v17.16b, v5.16b
ldr h31, [x10, #0x22]
ldr h8, [x10, #0x20]
movi v22.2d, #0000000000000000
sdot v22.4s, v7.16b, v18.16b
movi v23.2d, #0000000000000000
sdot v23.4s, v21.16b, v19.16b
ld1 { v18.16b, v19.16b }, [x15]
ushr v7.16b, v16.16b, #0x2
and v7.16b, v7.16b, v5.16b
ushr v21.16b, v17.16b, #0x2
and v21.16b, v21.16b, v5.16b
movi v24.2d, #0000000000000000
sdot v24.4s, v7.16b, v18.16b
movi v9.2d, #0000000000000000
sdot v9.4s, v21.16b, v19.16b
ld1 { v18.16b, v19.16b }, [x13]
ushr v7.16b, v16.16b, #0x4
and v7.16b, v7.16b, v5.16b
ushr v21.16b, v17.16b, #0x4
and v21.16b, v21.16b, v5.16b
movi v10.2d, #0000000000000000
sdot v10.4s, v7.16b, v18.16b
movi v11.2d, #0000000000000000
sdot v11.4s, v21.16b, v19.16b
ld1 { v18.16b, v19.16b }, [x14]
ushr v7.16b, v16.16b, #0x6
ushr v16.16b, v17.16b, #0x6
movi v21.2d, #0000000000000000
sdot v21.4s, v7.16b, v18.16b
movi v12.2d, #0000000000000000
sdot v12.4s, v16.16b, v19.16b
ld1 { v27.16b, v28.16b }, [x10]
ld1 { v13.16b, v14.16b }, [x16]
and v18.16b, v27.16b, v5.16b
movi v15.2d, #0000000000000000
movi v6.2d, #0000000000000000
and v1.16b, v28.16b, v5.16b
addv s7, v22.4s
movi v2.16b, #0xf
and v17.16b, v20.16b, v2.16b
ushr v20.16b, v20.16b, #0x4
ushll v16.8h, v20.8b, #0x0
smull v2.4s, v16.4h, v29.4h
smlal2 v2.4s, v16.8h, v29.8h
addv s25, v23.4s
addv s24, v24.4s
addv s23, v9.4s
addv s16, v10.4s
addv s22, v11.4s
addv s21, v21.4s
addv s19, v12.4s
fcvt s9, h31
fmul s31, s9, s26
ushll2 v20.8h, v20.16b, #0x0
smlal v2.4s, v20.4h, v30.4h
sdot v15.4s, v18.16b, v13.16b
smlal2 v2.4s, v20.8h, v30.8h
addv s2, v2.4s
scvtf s2, s2
fmul s20, s31, s2
fcvt s2, h8
sdot v6.4s, v1.16b, v14.16b
fmul s18, s26, s2
ld1 { v1.16b, v2.16b }, [x0]
ushr v26.16b, v27.16b, #0x2
and v29.16b, v26.16b, v5.16b
addv s26, v15.4s
ushr v30.16b, v28.16b, #0x2
and v30.16b, v30.16b, v5.16b
movi v31.2d, #0000000000000000
sdot v31.4s, v29.16b, v1.16b
movi v29.2d, #0000000000000000
sdot v29.4s, v30.16b, v2.16b
ld1 { v1.16b, v2.16b }, [x17]
ushr v30.16b, v27.16b, #0x4
and v30.16b, v30.16b, v5.16b
ushr v8.16b, v28.16b, #0x4
addv s6, v6.4s
and v8.16b, v8.16b, v5.16b
movi v9.2d, #0000000000000000
sdot v9.4s, v30.16b, v1.16b
movi v30.2d, #0000000000000000
sdot v30.4s, v8.16b, v2.16b
addv s1, v31.4s
addv s2, v9.4s
addv s30, v30.4s
ld1 { v8.16b, v9.16b }, [x11]
ushr v31.16b, v27.16b, #0x6
addv s29, v29.4s
ushr v27.16b, v28.16b, #0x6
movi v28.2d, #0000000000000000
sdot v28.4s, v31.16b, v8.16b
movi v31.2d, #0000000000000000
ldr q10, [sp, #0x10]
tbl v10.16b, { v17.16b }, v10.16b
sdot v31.4s, v27.16b, v9.16b
ldr q27, [sp]
tbl v27.16b, { v17.16b }, v27.16b
mov v26.s[1], v6.s[0]
mov v26.s[2], v1.s[0]
addv s1, v28.4s
tbl v6.16b, { v17.16b }, v3.16b
mov v7.s[1], v25.s[0]
mov v7.s[2], v24.s[0]
addv s24, v31.4s
mov v7.s[3], v23.s[0]
mov v2.s[1], v30.s[0]
mov v26.s[3], v29.s[0]
mov v2.s[2], v1.s[0]
mov v16.s[1], v22.s[0]
mov v2.s[3], v24.s[0]
tbl v1.16b, { v17.16b }, v4.16b
mov v16.s[2], v21.s[0]
mov v16.s[3], v19.s[0]
mul v2.4s, v2.4s, v6.4s
mul v6.4s, v26.4s, v10.4s
mla v6.4s, v7.4s, v27.4s
mla v2.4s, v16.4s, v1.4s
add v1.4s, v6.4s, v2.4s
addv s1, v1.4s
fsub s0, s0, s20
scvtf s1, s1
fmul s1, s18, s1
fadd s0, s0, s1
add x8, x8, #0x124
add x10, x10, #0x54
cmp x9, x8
b.ne candle_q2k_vec_dot_60
ldp d9, d8, [sp, #0x50]
ldp d11, d10, [sp, #0x40]
ldp d13, d12, [sp, #0x30]
ldp d15, d14, [sp, #0x20]
add sp, sp, #0x60
ret
candle_q2k_vec_dot_2bc:
movi d0, #0000000000000000
ret
