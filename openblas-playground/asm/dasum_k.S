dasum_k:
fmov d0, xzr
fmov d1, d0
cmp x0, xzr
b.le dasum_k_80
cmp x2, xzr
b.le dasum_k_80
cmp x2, #0x1
b.ne dasum_k_84
asr x5, x0, #3
cmp x5, xzr
b.eq dasum_k_64
dasum_k_2c:
ld1 { v2.2d, v3.2d, v4.2d, v5.2d }, [x1]
add x1, x1, #0x40
fabs v2.2d, v2.2d
fabs v3.2d, v3.2d
fabs v4.2d, v4.2d
fabs v5.2d, v5.2d
prfm pldl1keep, [x1, #0x400]
fadd v2.2d, v2.2d, v3.2d
fadd v4.2d, v4.2d, v5.2d
fadd v0.2d, v0.2d, v2.2d
fadd v0.2d, v0.2d, v4.2d
subs x5, x5, #0x1
b.ne dasum_k_2c
faddp d0, v0.2d
dasum_k_64:
ands x5, x0, #0x7
b.le dasum_k_80
dasum_k_6c:
ldr d1, [x1], #0x8
fabs d1, d1
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne dasum_k_6c
dasum_k_80:
ret
dasum_k_84:
lsl x2, x2, #3
asr x5, x0, #2
cmp x5, xzr
b.le dasum_k_cc
dasum_k_94:
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fadd d0, d0, d1
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fadd d0, d0, d1
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fadd d0, d0, d1
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne dasum_k_94
dasum_k_cc:
ands x5, x0, #0x3
b.le dasum_k_80
dasum_k_d4:
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne dasum_k_d4
ret
