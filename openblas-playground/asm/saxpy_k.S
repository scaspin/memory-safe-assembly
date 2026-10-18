saxpy_k:
cmp x0, xzr
b.le saxpy_k_f4
fcmp s0, #0.0
b.eq saxpy_k_f4
cmp x4, #0x1
b.ne saxpy_k_78
cmp x6, #0x1
b.ne saxpy_k_78
asr x1, x0, #3
cmp x1, xzr
b.eq saxpy_k_50
saxpy_k_2c:
ld1 { v1.4s, v2.4s }, [x3], #32
ld1 { v3.4s, v4.4s }, [x5]
fmla v3.4s, v1.4s, v0.s[0]
fmla v4.4s, v2.4s, v0.s[0]
st1 { v3.4s, v4.4s }, [x5], #32
prfm pldl1keep, [x3, #0x200]
prfm pldl1keep, [x5, #0x200]
subs x1, x1, #0x1
b.ne saxpy_k_2c
saxpy_k_50:
ands x1, x0, #0x7
b.le saxpy_k_f4
saxpy_k_58:
ldr s1, [x3], #0x4
ldr s2, [x5]
fmadd s2, s1, s0, s2
str s2, [x5], #0x4
subs x1, x1, #0x1
b.ne saxpy_k_58
mov w0, wzr
ret
saxpy_k_78:
lsl x4, x4, #2
lsl x6, x6, #2
asr x1, x0, #2
cmp x1, xzr
b.le saxpy_k_d4
saxpy_k_8c:
ld1 { v1.s }[0], [x3], x4
ldr s2, [x5]
fmadd s2, s1, s0, s2
st1 { v2.s }[0], [x5], x6
ld1 { v1.s }[0], [x3], x4
ldr s2, [x5]
fmadd s2, s1, s0, s2
st1 { v2.s }[0], [x5], x6
ld1 { v1.s }[0], [x3], x4
ldr s2, [x5]
fmadd s2, s1, s0, s2
st1 { v2.s }[0], [x5], x6
ld1 { v1.s }[0], [x3], x4
ldr s2, [x5]
fmadd s2, s1, s0, s2
st1 { v2.s }[0], [x5], x6
subs x1, x1, #0x1
b.ne saxpy_k_8c
saxpy_k_d4:
ands x1, x0, #0x3
b.le saxpy_k_f4
saxpy_k_dc:
ld1 { v1.s }[0], [x3], x4
ldr s2, [x5]
fmadd s2, s1, s0, s2
st1 { v2.s }[0], [x5], x6
subs x1, x1, #0x1
b.ne saxpy_k_dc
saxpy_k_f4:
mov w0, wzr
ret
