candle_f16_vec_reduce:
ldp q0, q1, [x0]
ldp q2, q3, [x0, #0x20]
fcvtl v4.4s, v0.4h
fcvtl2 v0.4s, v0.8h
fadd v4.4s, v4.4s, v0.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s5, v4.s[0]
movi d0, #0000000000000000
fadd s0, s5, s0
fcvtl v4.4s, v1.4h
fcvtl2 v1.4s, v1.8h
fadd v4.4s, v4.4s, v1.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s5, v4.s[0]
fadd s0, s0, s5
fcvtl v4.4s, v2.4h
fcvtl2 v1.4s, v2.8h
fadd v4.4s, v4.4s, v1.4s
faddp v4.4s, v4.4s, v4.4s
faddp v4.4s, v4.4s, v4.4s
mov s5, v4.s[0]
fadd s0, s0, s5
fcvtl v2.4s, v3.4h
fcvtl2 v1.4s, v3.8h
fadd v2.4s, v2.4s, v1.4s
faddp v2.4s, v2.4s, v2.4s
faddp v2.4s, v2.4s, v2.4s
mov s4, v2.s[0]
fadd s0, s0, s4
str s0, [x1]
ret
