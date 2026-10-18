zscal_k:
b zscal_k_14
zscal_k_14:
fmov s20, wzr
fmov s21, wzr
fmov s22, wzr
fmov s23, wzr
fmul s24, s22, s21
fmla s24, s23, v20.s[0]
fmul s25, s22, s21
fmul s26, s23, s20
fadd s25, s25, s26
mov x6, x3
cmp x0, xzr
b.le zscal_k_1f0
ldr x7, [sp]
cmp x7, #0x1
b.eq zscal_k_64
fcmp d0, #0.0
b.ne zscal_k_60
fcmp d1, #0.0
b.eq zscal_k_254
zscal_k_60:
fcmp d1, #0.0
zscal_k_64:
mov v0.d[1], v0.d[0]
cmp x4, #0x1
b.ne zscal_k_114
asr x5, x0, #2
cmp x5, xzr
b.eq zscal_k_d8
mov v16.d[0], v0.d[0]
mov v16.d[1], v16.d[0]
mov v17.d[0], v1.d[0]
mov v17.d[1], v17.d[0]
zscal_k_8c:
ld2 { v2.2d, v3.2d }, [x3], #32
fmul v4.2d, v2.2d, v16.2d
fmul v6.2d, v3.2d, v17.2d
fsub v4.2d, v4.2d, v6.2d
fmul v5.2d, v2.2d, v17.2d
fmul v6.2d, v3.2d, v16.2d
fadd v5.2d, v5.2d, v6.2d
st2 { v4.2d, v5.2d }, [x6], #32
ld2 { v18.2d, v19.2d }, [x3], #32
fmul v20.2d, v18.2d, v16.2d
fmul v6.2d, v19.2d, v17.2d
fsub v20.2d, v20.2d, v6.2d
fmul v21.2d, v18.2d, v17.2d
fmul v6.2d, v19.2d, v16.2d
fadd v21.2d, v21.2d, v6.2d
st2 { v20.2d, v21.2d }, [x6], #32
prfm pldl1keep, [x3, #0x400]
subs x5, x5, #0x1
b.ne zscal_k_8c
zscal_k_d8:
ands x5, x0, #0x3
b.le zscal_k_1f0
zscal_k_e0:
ld1 { v2.2d }, [x3]
fmul d3, d0, v2.d[0]
fmul d5, d1, v2.d[1]
fsub d3, d3, d5
fmul d4, d1, v2.d[0]
fmul d5, d0, v2.d[1]
fadd d4, d4, d5
mov v3.d[1], v4.d[0]
st1 { v3.2d }, [x3], #16
subs x5, x5, #0x1
b.ne zscal_k_e0
mov w0, wzr
ret
zscal_k_114:
lsl x4, x4, #4
asr x5, x0, #2
cmp x5, xzr
b.le zscal_k_1bc
zscal_k_124:
ld1 { v2.2d }, [x3]
fmul d3, d0, v2.d[0]
fmul d5, d1, v2.d[1]
fsub d3, d3, d5
fmul d4, d1, v2.d[0]
fmul d5, d0, v2.d[1]
fadd d4, d4, d5
mov v3.d[1], v4.d[0]
st1 { v3.2d }, [x3], x4
ld1 { v2.2d }, [x3]
fmul d3, d0, v2.d[0]
fmul d5, d1, v2.d[1]
fsub d3, d3, d5
fmul d4, d1, v2.d[0]
fmul d5, d0, v2.d[1]
fadd d4, d4, d5
mov v3.d[1], v4.d[0]
st1 { v3.2d }, [x3], x4
ld1 { v2.2d }, [x3]
fmul d3, d0, v2.d[0]
fmul d5, d1, v2.d[1]
fsub d3, d3, d5
fmul d4, d1, v2.d[0]
fmul d5, d0, v2.d[1]
fadd d4, d4, d5
mov v3.d[1], v4.d[0]
st1 { v3.2d }, [x3], x4
ld1 { v2.2d }, [x3]
fmul d3, d0, v2.d[0]
fmul d5, d1, v2.d[1]
fsub d3, d3, d5
fmul d4, d1, v2.d[0]
fmul d5, d0, v2.d[1]
fadd d4, d4, d5
mov v3.d[1], v4.d[0]
st1 { v3.2d }, [x3], x4
subs x5, x5, #0x1
b.ne zscal_k_124
zscal_k_1bc:
ands x5, x0, #0x3
b.le zscal_k_1f0
zscal_k_1c4:
ld1 { v2.2d }, [x3]
fmul d3, d0, v2.d[0]
fmul d5, d1, v2.d[1]
fsub d3, d3, d5
fmul d4, d1, v2.d[0]
fmul d5, d0, v2.d[1]
fadd d4, d4, d5
mov v3.d[1], v4.d[0]
st1 { v3.2d }, [x3], x4
subs x5, x5, #0x1
b.ne zscal_k_1c4
zscal_k_1f0:
mov w0, wzr
ret
lsl x4, x4, #4
eor v2.16b, v2.16b, v2.16b
fsub d2, d2, d1
mov v1.d[1], v2.d[0]
zscal_k_208:
ld1 { v2.2d }, [x3]
fmul v2.2d, v2.2d, v1.2d
ext v2.16b, v2.16b, v2.16b, #0x8
st1 { v2.2d }, [x3]
add x3, x3, x4
subs x0, x0, #0x1
b.ne zscal_k_208
mov w0, wzr
ret
lsl x4, x4, #4
mov v0.d[1], v0.d[0]
zscal_k_234:
ld1 { v2.2d }, [x3]
fmul v2.2d, v2.2d, v0.2d
st1 { v2.2d }, [x3]
add x3, x3, x4
subs x0, x0, #0x1
b.ne zscal_k_234
mov w0, wzr
ret
zscal_k_254:
lsl x4, x4, #4
zscal_k_258:
stp d0, d1, [x3]
add x3, x3, x4
subs x0, x0, #0x1
b.ne zscal_k_258
mov w0, wzr
ret
