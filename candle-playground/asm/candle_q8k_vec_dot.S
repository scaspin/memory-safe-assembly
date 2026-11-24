candle_q8k_vec_dot:
cmp x4, x2
csel x8, x4, x2, lo
cbz x8, candle_q8k_vec_dot_16c
add x9, x1, #0x84
add x10, x3, #0x84
movi d0, #0000000000000000
candle_q8k_vec_dot_18:
ldur s1, [x9, #-0x84]
ldur s2, [x10, #-0x84]
ldp q6, q3, [x9, #-0x80]
ldp q7, q4, [x10, #-0x80]
movi v5.2d, #0000000000000000
sdot v5.4s, v6.16b, v7.16b
movi v6.2d, #0000000000000000
sdot v6.4s, v3.16b, v4.16b
add v3.4s, v6.4s, v5.4s
ldp q7, q4, [x9, #-0x60]
ldur q5, [x10, #-0x60]
movi v6.2d, #0000000000000000
sdot v6.4s, v7.16b, v5.16b
ldur q5, [x10, #-0x50]
movi v7.2d, #0000000000000000
sdot v7.4s, v4.16b, v5.16b
add v4.4s, v6.4s, v7.4s
add v3.4s, v3.4s, v4.4s
ldp q7, q4, [x9, #-0x40]
ldur q5, [x10, #-0x40]
movi v6.2d, #0000000000000000
sdot v6.4s, v7.16b, v5.16b
ldur q5, [x10, #-0x30]
movi v7.2d, #0000000000000000
sdot v7.4s, v4.16b, v5.16b
add v4.4s, v6.4s, v7.4s
ldur q5, [x9, #-0x20]
ldur q6, [x10, #-0x20]
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v6.16b
add v4.4s, v4.4s, v7.4s
add v3.4s, v3.4s, v4.4s
ldp q7, q4, [x9, #-0x10]
ldur q5, [x10, #-0x10]
movi v6.2d, #0000000000000000
sdot v6.4s, v7.16b, v5.16b
ldr q5, [x10]
movi v7.2d, #0000000000000000
sdot v7.4s, v4.16b, v5.16b
add v4.4s, v6.4s, v7.4s
ldr q5, [x9, #0x10]
ldr q6, [x10, #0x10]
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v6.16b
add v4.4s, v4.4s, v7.4s
ldr q5, [x9, #0x20]
ldr q6, [x10, #0x20]
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v6.16b
add v4.4s, v4.4s, v7.4s
add v3.4s, v3.4s, v4.4s
ldp q7, q4, [x9, #0x30]
ldr q5, [x10, #0x30]
movi v6.2d, #0000000000000000
sdot v6.4s, v7.16b, v5.16b
ldr q5, [x10, #0x40]
movi v7.2d, #0000000000000000
sdot v7.4s, v4.16b, v5.16b
add v4.4s, v6.4s, v7.4s
ldr q5, [x9, #0x50]
ldr q6, [x10, #0x50]
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v6.16b
add v4.4s, v4.4s, v7.4s
ldr q5, [x9, #0x60]
ldr q6, [x10, #0x60]
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v6.16b
add v4.4s, v4.4s, v7.4s
ldr q5, [x9, #0x70]
ldr q6, [x10, #0x70]
movi v7.2d, #0000000000000000
sdot v7.4s, v5.16b, v6.16b
add v4.4s, v4.4s, v7.4s
add v3.4s, v3.4s, v4.4s
fmul s1, s1, s2
addv s2, v3.4s
scvtf s2, s2
fmul s1, s1, s2
fadd s0, s0, s1
add x9, x9, #0x124
add x10, x10, #0x124
subs x8, x8, #0x1
b.ne candle_q8k_vec_dot_18
ret
candle_q8k_vec_dot_16c:
movi d0, #0000000000000000
ret
