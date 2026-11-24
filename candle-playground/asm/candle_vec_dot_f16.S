candle_vec_dot_f16:
movi v1.8h, #0x0
movi d0, #0000000000000000
cmp x3, #0x20
b.hs candle_vec_dot_f16_d8
mov x12, #0x0               // =0
mov v3.16b, v1.16b
mov v5.16b, v1.16b
mov v6.16b, v1.16b
movi d2, #0000000000000000
mov v7.16b, v1.16b
candle_vec_dot_f16_28:
fcvtl v4.4s, v7.4h
fcvtl2 v1.4s, v7.8h
fadd v4.4s, v4.4s, v1.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s16, v4.s[0]
fadd s0, s16, s0
fcvtl v4.4s, v6.4h
fcvtl2 v1.4s, v6.8h
fadd v4.4s, v4.4s, v1.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s7, v4.s[0]
fadd s0, s0, s7
fcvtl v4.4s, v5.4h
fcvtl2 v1.4s, v5.8h
fadd v4.4s, v4.4s, v1.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s6, v4.s[0]
fadd s0, s0, s6
fcvtl v4.4s, v3.4h
fcvtl2 v1.4s, v3.8h
fadd v4.4s, v4.4s, v1.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s5, v4.s[0]
fadd s0, s0, s5
fadd s0, s2, s0
subs x8, x3, x12
b.ls candle_vec_dot_f16_d0
lsl x10, x12, #1
add x9, x1, x10
add x10, x0, x10
candle_vec_dot_f16_b0:
ldr h1, [x10], #0x2
fcvt s2, h1
ldr h1, [x9], #0x2
fcvt s3, h1
fmul s1, s2, s3
fadd s0, s0, s1
subs x8, x8, #0x1
b.ne candle_vec_dot_f16_b0
candle_vec_dot_f16_d0:
str s0, [x2]
ret
candle_vec_dot_f16_d8:
mov x11, #0x0               // =0
mov x9, #0x0                // =0
add x8, x1, #0x20
add x10, x0, #0x20
movi d4, #0000000000000000
mov v3.16b, v1.16b
mov v5.16b, v1.16b
mov v6.16b, v1.16b
movi d2, #0000000000000000
mov v7.16b, v1.16b
b candle_vec_dot_f16_120
candle_vec_dot_f16_104:
add x8, x8, #0x40
add x10, x10, #0x40
add x12, x11, #0x20
add x13, x11, #0x40
mov x11, x12
cmp x13, x3
b.hi candle_vec_dot_f16_28
candle_vec_dot_f16_120:
ldp q16, q17, [x10, #-0x20]
ldp q18, q19, [x8, #-0x20]
fmla v7.8h, v16.8h, v18.8h
fmla v6.8h, v17.8h, v19.8h
ldp q16, q17, [x10]
ldp q18, q19, [x8]
fmla v5.8h, v16.8h, v18.8h
fmla v3.8h, v17.8h, v19.8h
add x9, x9, #0x1
cmp x9, #0x10
b.ne candle_vec_dot_f16_104
mov x9, #0x0                // =0
fcvtl v16.4s, v7.4h
fcvtl2 v7.4s, v7.8h
fadd v16.4s, v16.4s, v7.4s
faddp v16.4s, v16.4s, v16.4s
faddp v16.4s, v16.4s, v16.4s
mov s17, v16.s[0]
fcvtl v7.4s, v6.4h
fcvtl2 v6.4s, v6.8h
fadd v7.4s, v7.4s, v6.4s
faddp v7.4s, v7.4s, v7.4s
faddp v7.4s, v7.4s, v7.4s
mov s16, v7.s[0]
fcvtl v6.4s, v5.4h
fcvtl2 v5.4s, v5.8h
fadd v6.4s, v6.4s, v5.4s
faddp v6.4s, v6.4s, v6.4s
faddp v6.4s, v6.4s, v6.4s
mov s7, v6.s[0]
fcvtl v5.4s, v3.4h
fcvtl2 v3.4s, v3.8h
fadd v5.4s, v5.4s, v3.4s
faddp v5.4s, v5.4s, v5.4s
faddp v5.4s, v5.4s, v5.4s
mov s6, v5.s[0]
fadd s3, s17, s4
fadd s3, s3, s16
fadd s3, s3, s7
fadd s3, s3, s6
fadd s2, s2, s3
mov v3.16b, v1.16b
mov v5.16b, v1.16b
mov v6.16b, v1.16b
mov v7.16b, v1.16b
b candle_vec_dot_f16_104
