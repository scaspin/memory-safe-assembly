daxpy_k:
cmp x0, xzr
b.le daxpy_k_fc
fcmp d0, #0.0
b.eq daxpy_k_fc
cmp x4, #0x1
b.ne daxpy_k_80
cmp x6, #0x1
b.ne daxpy_k_80
asr x1, x0, #3
cmp x1, xzr
b.eq daxpy_k_58
daxpy_k_2c:
ld1 { v1.2d, v2.2d, v3.2d, v4.2d }, [x3], #64
ld1 { v16.2d, v17.2d, v18.2d, v19.2d }, [x5]
fmla v16.2d, v1.2d, v0.d[0]
fmla v17.2d, v2.2d, v0.d[0]
fmla v18.2d, v3.2d, v0.d[0]
fmla v19.2d, v4.2d, v0.d[0]
st1 { v16.2d, v17.2d, v18.2d, v19.2d }, [x5], #64
prfm pldl1keep, [x3, #0x200]
prfm pldl1keep, [x5, #0x200]
subs x1, x1, #0x1
b.ne daxpy_k_2c
daxpy_k_58:
ands x1, x0, #0x7
b.le daxpy_k_fc
daxpy_k_60:
ldr d1, [x3], #0x8
ldr d2, [x5]
fmadd d2, d1, d0, d2
str d2, [x5], #0x8
subs x1, x1, #0x1
b.ne daxpy_k_60
mov w0, wzr
ret
daxpy_k_80:
lsl x4, x4, #3
lsl x6, x6, #3
asr x1, x0, #2
cmp x1, xzr
b.le daxpy_k_dc
daxpy_k_94:
ld1 { v1.d }[0], [x3], x4
ldr d2, [x5]
fmadd d2, d1, d0, d2
st1 { v2.d }[0], [x5], x6
ld1 { v1.d }[0], [x3], x4
ldr d2, [x5]
fmadd d2, d1, d0, d2
st1 { v2.d }[0], [x5], x6
ld1 { v1.d }[0], [x3], x4
ldr d2, [x5]
fmadd d2, d1, d0, d2
st1 { v2.d }[0], [x5], x6
ld1 { v1.d }[0], [x3], x4
ldr d2, [x5]
fmadd d2, d1, d0, d2
st1 { v2.d }[0], [x5], x6
subs x1, x1, #0x1
b.ne daxpy_k_94
daxpy_k_dc:
ands x1, x0, #0x3
b.le daxpy_k_fc
daxpy_k_e4:
ld1 { v1.d }[0], [x3], x4
ldr d2, [x5]
fmadd d2, d1, d0, d2
st1 { v2.d }[0], [x5], x6
subs x1, x1, #0x1
b.ne daxpy_k_e4
daxpy_k_fc:
mov w0, wzr
ret
