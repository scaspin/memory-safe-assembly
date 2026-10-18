dsum_k:
fmov d0, xzr
fmov d1, d0
cmp x0, xzr
b.le dsum_k_6c
cmp x2, xzr
b.le dsum_k_6c
cmp x2, #0x1
b.ne dsum_k_70
asr x5, x0, #3
cmp x5, xzr
b.eq dsum_k_54
dsum_k_2c:
ld1 { v2.2d, v3.2d, v4.2d, v5.2d }, [x1]
add x1, x1, #0x40
prfm pldl1keep, [x1, #0x400]
fadd v2.2d, v2.2d, v3.2d
fadd v4.2d, v4.2d, v5.2d
fadd v0.2d, v0.2d, v2.2d
fadd v0.2d, v0.2d, v4.2d
subs x5, x5, #0x1
b.ne dsum_k_2c
faddp d0, v0.2d
dsum_k_54:
ands x5, x0, #0x7
b.le dsum_k_6c
dsum_k_5c:
ldr d1, [x1], #0x8
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne dsum_k_5c
dsum_k_6c:
ret
dsum_k_70:
lsl x2, x2, #3
asr x5, x0, #2
cmp x5, xzr
b.le dsum_k_a8
dsum_k_80:
ld1 { v1.d }[0], [x1], x2
fadd d0, d0, d1
ld1 { v1.d }[0], [x1], x2
fadd d0, d0, d1
ld1 { v1.d }[0], [x1], x2
fadd d0, d0, d1
ld1 { v1.d }[0], [x1], x2
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne dsum_k_80
dsum_k_a8:
ands x5, x0, #0x3
b.le dsum_k_6c
dsum_k_b0:
ld1 { v1.d }[0], [x1], x2
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne dsum_k_b0
ret
