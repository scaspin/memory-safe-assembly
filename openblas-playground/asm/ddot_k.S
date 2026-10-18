ddot_k:
fmov d0, xzr
fmov d6, d0
cmp x0, xzr
b.le ddot_k_e0
cmp x2, #0x1
b.ne ddot_k_78
cmp x4, #0x1
b.ne ddot_k_78
asr x5, x0, #2
cmp x5, xzr
b.eq ddot_k_58
ddot_k_2c:
ld1 { v2.2d, v3.2d }, [x1], #32
ld1 { v4.2d, v5.2d }, [x3], #32
fmul v2.2d, v2.2d, v4.2d
fmul v3.2d, v3.2d, v5.2d
fadd v0.2d, v0.2d, v2.2d
fadd v0.2d, v0.2d, v3.2d
prfm pldl1keep, [x1, #0x400]
prfm pldl1keep, [x3, #0x400]
subs x5, x5, #0x1
b.ne ddot_k_2c
faddp d0, v0.2d
ddot_k_58:
ands x5, x0, #0x3
b.le ddot_k_e0
ddot_k_60:
ldr d2, [x1], #0x8
ldr d3, [x3], #0x8
fmadd d0, d2, d3, d0
subs x5, x5, #0x1
b.ne ddot_k_60
ret
ddot_k_78:
lsl x2, x2, #3
lsl x4, x4, #3
asr x5, x0, #2
cmp x5, xzr
b.le ddot_k_c4
ddot_k_8c:
ld1 { v2.d }[0], [x1], x2
ld1 { v3.d }[0], [x3], x4
fmadd d0, d2, d3, d0
ld1 { v2.d }[0], [x1], x2
ld1 { v3.d }[0], [x3], x4
fmadd d0, d2, d3, d0
ld1 { v2.d }[0], [x1], x2
ld1 { v3.d }[0], [x3], x4
fmadd d0, d2, d3, d0
ld1 { v2.d }[0], [x1], x2
ld1 { v3.d }[0], [x3], x4
fmadd d0, d2, d3, d0
subs x5, x5, #0x1
b.ne ddot_k_8c
ddot_k_c4:
ands x5, x0, #0x3
b.le ddot_k_e0
ddot_k_cc:
ld1 { v2.d }[0], [x1], x2
ld1 { v3.d }[0], [x3], x4
fmadd d0, d2, d3, d0
subs x5, x5, #0x1
b.ne ddot_k_cc
ddot_k_e0:
ret
