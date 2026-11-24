zaxpy_k:
cmp x0, xzr
b.le zaxpy_k_178
mov x7, x5
fcmp d0, #0.0
b.ne zaxpy_k_1c
fcmp d1, #0.0
b.eq zaxpy_k_178
zaxpy_k_1c:
mov v0.d[1], v0.d[0]
eor v2.16b, v2.16b, v2.16b
fsub d2, d2, d1
mov v1.d[1], v2.d[0]
ext v1.16b, v1.16b, v1.16b, #0x8
cmp x4, #0x1
b.ne zaxpy_k_d4
cmp x6, #0x1
b.ne zaxpy_k_d4
asr x1, x0, #2
cmp x1, xzr
b.eq zaxpy_k_a4
mov v16.d[0], v0.d[0]
mov v16.d[1], v16.d[0]
mov v17.d[0], v1.d[1]
mov v17.d[1], v17.d[0]
zaxpy_k_5c:
ld2 { v2.2d, v3.2d }, [x3], #32
ld2 { v4.2d, v5.2d }, [x7], #32
fmla v4.2d, v2.2d, v16.2d
fmls v4.2d, v3.2d, v17.2d
fmla v5.2d, v2.2d, v17.2d
fmla v5.2d, v3.2d, v16.2d
st2 { v4.2d, v5.2d }, [x5], #32
ld2 { v18.2d, v19.2d }, [x3], #32
ld2 { v20.2d, v21.2d }, [x7], #32
fmla v20.2d, v18.2d, v16.2d
fmls v20.2d, v19.2d, v17.2d
fmla v21.2d, v18.2d, v17.2d
fmla v21.2d, v19.2d, v16.2d
st2 { v20.2d, v21.2d }, [x5], #32
prfm pldl1keep, [x3, #0x200]
prfm pldl1keep, [x5, #0x200]
subs x1, x1, #0x1
b.ne zaxpy_k_5c
zaxpy_k_a4:
ands x1, x0, #0x3
b.le zaxpy_k_178
zaxpy_k_ac:
ld1 { v2.2d }, [x3], #16
ld1 { v3.2d }, [x5]
ext v4.16b, v2.16b, v2.16b, #0x8
fmla v3.2d, v0.2d, v2.2d
fmla v3.2d, v1.2d, v4.2d
st1 { v3.2d }, [x5], #16
subs x1, x1, #0x1
b.ne zaxpy_k_ac
mov w0, wzr
ret
zaxpy_k_d4:
lsl x4, x4, #4
lsl x6, x6, #4
asr x1, x0, #2
cmp x1, xzr
b.le zaxpy_k_150
zaxpy_k_e8:
ld1 { v2.2d }, [x3], x4
ld1 { v3.2d }, [x5]
ext v4.16b, v2.16b, v2.16b, #0x8
fmla v3.2d, v0.2d, v2.2d
fmla v3.2d, v1.2d, v4.2d
st1 { v3.2d }, [x5], x6
ld1 { v2.2d }, [x3], x4
ld1 { v3.2d }, [x5]
ext v4.16b, v2.16b, v2.16b, #0x8
fmla v3.2d, v0.2d, v2.2d
fmla v3.2d, v1.2d, v4.2d
st1 { v3.2d }, [x5], x6
ld1 { v2.2d }, [x3], x4
ld1 { v3.2d }, [x5]
ext v4.16b, v2.16b, v2.16b, #0x8
fmla v3.2d, v0.2d, v2.2d
fmla v3.2d, v1.2d, v4.2d
st1 { v3.2d }, [x5], x6
ld1 { v2.2d }, [x3], x4
ld1 { v3.2d }, [x5]
ext v4.16b, v2.16b, v2.16b, #0x8
fmla v3.2d, v0.2d, v2.2d
fmla v3.2d, v1.2d, v4.2d
st1 { v3.2d }, [x5], x6
subs x1, x1, #0x1
b.ne zaxpy_k_e8
zaxpy_k_150:
ands x1, x0, #0x3
b.le zaxpy_k_178
zaxpy_k_158:
ld1 { v2.2d }, [x3], x4
ld1 { v3.2d }, [x5]
ext v4.16b, v2.16b, v2.16b, #0x8
fmla v3.2d, v0.2d, v2.2d
fmla v3.2d, v1.2d, v4.2d
st1 { v3.2d }, [x5], x6
subs x1, x1, #0x1
b.ne zaxpy_k_158
zaxpy_k_178:
mov w0, wzr
ret
