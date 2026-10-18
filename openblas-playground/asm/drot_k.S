drot_k:
cmp x0, xzr
b.le drot_k_170
mov v0.d[1], v0.d[0]
cmp x2, #0x1
b.ne drot_k_ac
cmp x4, #0x1
b.ne drot_k_ac
asr x5, x0, #2
cmp x5, xzr
b.eq drot_k_6c
mov v1.d[1], v1.d[0]
drot_k_2c:
ld1 { v2.2d, v3.2d }, [x1]
fmul v6.2d, v0.2d, v2.2d
fmul v7.2d, v0.2d, v3.2d
ld1 { v4.2d, v5.2d }, [x3]
fmla v6.2d, v1.2d, v4.2d
fmla v7.2d, v1.2d, v5.2d
st1 { v6.2d, v7.2d }, [x1], #32
fmul v16.2d, v0.2d, v4.2d
fmul v17.2d, v0.2d, v5.2d
fmls v16.2d, v1.2d, v2.2d
fmls v17.2d, v1.2d, v3.2d
st1 { v16.2d, v17.2d }, [x3], #32
prfm pldl1keep, [x1, #0x200]
prfm pldl1keep, [x3, #0x200]
subs x5, x5, #0x1
b.ne drot_k_2c
drot_k_6c:
ands x5, x0, #0x3
b.le drot_k_170
eor v2.16b, v2.16b, v2.16b
fsub d2, d2, d1
mov v1.d[1], v2.d[0]
drot_k_80:
ld1 { v2.d }[0], [x1]
ld1 { v2.d }[1], [x3]
ext v3.16b, v2.16b, v2.16b, #0x8
fmul v4.2d, v2.2d, v0.2d
fmla v4.2d, v3.2d, v1.2d
st1 { v4.d }[0], [x1], #8
st1 { v4.d }[1], [x3], #8
subs x5, x5, #0x1
b.ne drot_k_80
mov w0, wzr
ret
drot_k_ac:
lsl x2, x2, #3
lsl x4, x4, #3
eor v2.16b, v2.16b, v2.16b
fsub d2, d2, d1
mov v1.d[1], v2.d[0]
asr x5, x0, #2
cmp x5, xzr
b.le drot_k_144
drot_k_cc:
ld1 { v2.d }[0], [x1]
ld1 { v2.d }[1], [x3]
ext v3.16b, v2.16b, v2.16b, #0x8
fmul v4.2d, v2.2d, v0.2d
fmla v4.2d, v3.2d, v1.2d
st1 { v4.d }[0], [x1], x2
st1 { v4.d }[1], [x3], x4
ld1 { v2.d }[0], [x1]
ld1 { v2.d }[1], [x3]
ext v3.16b, v2.16b, v2.16b, #0x8
fmul v4.2d, v2.2d, v0.2d
fmla v4.2d, v3.2d, v1.2d
st1 { v4.d }[0], [x1], x2
st1 { v4.d }[1], [x3], x4
ld1 { v2.d }[0], [x1]
ld1 { v2.d }[1], [x3]
ext v3.16b, v2.16b, v2.16b, #0x8
fmul v4.2d, v2.2d, v0.2d
fmla v4.2d, v3.2d, v1.2d
st1 { v4.d }[0], [x1], x2
st1 { v4.d }[1], [x3], x4
ld1 { v2.d }[0], [x1]
ld1 { v2.d }[1], [x3]
ext v3.16b, v2.16b, v2.16b, #0x8
fmul v4.2d, v2.2d, v0.2d
fmla v4.2d, v3.2d, v1.2d
st1 { v4.d }[0], [x1], x2
st1 { v4.d }[1], [x3], x4
subs x5, x5, #0x1
b.ne drot_k_cc
drot_k_144:
ands x5, x0, #0x3
b.le drot_k_170
drot_k_14c:
ld1 { v2.d }[0], [x1]
ld1 { v2.d }[1], [x3]
ext v3.16b, v2.16b, v2.16b, #0x8
fmul v4.2d, v2.2d, v0.2d
fmla v4.2d, v3.2d, v1.2d
st1 { v4.d }[0], [x1], x2
st1 { v4.d }[1], [x3], x4
subs x5, x5, #0x1
b.ne drot_k_14c
drot_k_170:
mov w0, wzr
ret
