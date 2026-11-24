candle_q8_0_vec_dot:
stp x29, x30, [sp, #-0x10]!
mov x29, sp
movi v0.2d, #0000000000000000
cmp x0, #0x20
b.lo candle_q8_0_vec_dot_84
mov x8, #0x0                // =0
lsr x9, x0, #5
candle_q8_0_vec_dot_1c:
cmp x2, x8
b.eq candle_q8_0_vec_dot_94
cmp x4, x8
b.eq candle_q8_0_vec_dot_ac
add x8, x8, #0x1
ldur q1, [x1, #0x2]
ldur q2, [x1, #0x12]
ldur q3, [x3, #0x2]
ldur q4, [x3, #0x12]
movi v5.2d, #0000000000000000
sdot v5.4s, v1.16b, v3.16b
movi v1.2d, #0000000000000000
sdot v1.4s, v2.16b, v4.16b
add v1.4s, v1.4s, v5.4s
scvtf v1.4s, v1.4s
ldr h2, [x1]
fcvt s3, h2
ldr h2, [x3]
fcvt s4, h2
fmul s2, s3, s4
fmul v1.4s, v1.4s, v2.s[0]
fadd v0.4s, v0.4s, v1.4s
add x1, x1, #0x22
add x3, x3, #0x22
cmp x9, x8
b.ne candle_q8_0_vec_dot_1c
candle_q8_0_vec_dot_84:
faddp v0.4s, v0.4s, v0.4s
faddp s0, v0.2s
ldp x29, x30, [sp], #0x10
ret
candle_q8_0_vec_dot_94:
adrp x8, _anon_c3dda552ada3a0a09e77151fe2896871_66_llvm_2202591988034746622@PAGE
add x8, x8, #0x0
mov x0, x2
mov x1, x2
mov x2, x8
brk #0x1
candle_q8_0_vec_dot_ac:
adrp x2, _anon_c3dda552ada3a0a09e77151fe2896871_67_llvm_2202591988034746622@PAGE
add x2, x2, #0x0
mov x0, x4
mov x1, x4
brk #0x1
