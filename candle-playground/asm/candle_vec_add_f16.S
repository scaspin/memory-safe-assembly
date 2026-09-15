candle_vec_add_f16:
cmp x3, #0x20
b.hs candle_vec_add_f16_10
mov x12, #0x0               // =0
b candle_vec_add_f16_8c
candle_vec_add_f16_10:
mov x11, #0x0               // =0
add x8, x1, #0x20
add x9, x0, #0x20
mov x10, x2
candle_vec_add_f16_20:
ldur q0, [x9, #-0x20]
ldur q1, [x8, #-0x20]
fadd v2.8h, v0.8h, v1.8h
st1 { v2.8h }, [x10]
add x12, x10, #0x10
ldur q0, [x9, #-0x10]
ldur q1, [x8, #-0x10]
fadd v2.8h, v0.8h, v1.8h
st1 { v2.8h }, [x12]
add x12, x10, #0x20
ldr q0, [x9]
ldr q1, [x8]
fadd v2.8h, v0.8h, v1.8h
st1 { v2.8h }, [x12]
add x13, x10, #0x30
ldr q0, [x9, #0x10]
ldr q1, [x8, #0x10]
fadd v2.8h, v0.8h, v1.8h
add x12, x11, #0x20
add x14, x11, #0x40
add x10, x10, #0x40
st1 { v2.8h }, [x13]
add x8, x8, #0x40
add x9, x9, #0x40
mov x11, x12
cmp x14, x3
b.ls candle_vec_add_f16_20
candle_vec_add_f16_8c:
subs x8, x3, x12
b.ls candle_vec_add_f16_bc
lsl x11, x12, #1
add x9, x2, x11
add x10, x1, x11
add x11, x0, x11
candle_vec_add_f16_a4:
ldr h0, [x11], #0x2
ldr h1, [x10], #0x2
fadd h2, h0, h1
str h2, [x9], #0x2
subs x8, x8, #0x1
b.ne candle_vec_add_f16_a4
candle_vec_add_f16_bc:
ret
