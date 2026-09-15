candle_q4_0_vec_dot:
stp x29, x30, [sp, #-0x10]!
mov x29, sp
movi v0.2d, #0000000000000000
cmp x0, #0x20
b.lo candle_q4_0_vec_dot_9c
mov x8, #0x0                // =0
lsr x9, x0, #5
add x10, x1, #0x2
movi v1.16b, #0xf
movi v2.16b, #0xf8
candle_q4_0_vec_dot_28:
cmp x2, x8
b.eq candle_q4_0_vec_dot_ac
cmp x4, x8
b.eq candle_q4_0_vec_dot_c4
add x8, x8, #0x1
ldr q3, [x10]
and v4.16b, v3.16b, v1.16b
add v4.16b, v4.16b, v2.16b
movi v5.16b, #0xf8
usra v5.16b, v3.16b, #0x4
ldur q3, [x3, #0x2]
ldur q6, [x3, #0x12]
movi v7.2d, #0000000000000000
sdot v7.4s, v4.16b, v3.16b
movi v3.2d, #0000000000000000
sdot v3.4s, v5.16b, v6.16b
add v3.4s, v3.4s, v7.4s
scvtf v3.4s, v3.4s
ldur h4, [x10, #-0x2]
fcvt s5, h4
ldr h4, [x3]
fcvt s6, h4
fmul s4, s5, s6
fmul v3.4s, v3.4s, v4.s[0]
fadd v0.4s, v0.4s, v3.4s
add x10, x10, #0x12
add x3, x3, #0x22
cmp x9, x8
b.ne candle_q4_0_vec_dot_28
candle_q4_0_vec_dot_9c:
faddp v0.4s, v0.4s, v0.4s
faddp s0, v0.2s
ldp x29, x30, [sp], #0x10
ret
candle_q4_0_vec_dot_ac:
adrp x8, _anon_c3dda552ada3a0a09e77151fe2896871_64_llvm_2202591988034746622@PAGE
add x8, x8, #0x0
mov x0, x2
mov x1, x2
mov x2, x8
brk #0x1
candle_q4_0_vec_dot_c4:
adrp x2, _anon_c3dda552ada3a0a09e77151fe2896871_65_llvm_2202591988034746622@PAGE
add x2, x2, #0x0
mov x0, x4
mov x1, x4
brk #0x1
