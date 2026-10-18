damax_k:
cmp x0, xzr
b.le damax_k_124
cmp x2, xzr
b.le damax_k_124
cmp x2, #0x1
b.ne damax_k_98
asr x5, x0, #2
cmp x5, xzr
b.eq damax_k_88
ld2 { v0.2d, v1.2d }, [x1], #32
fabs v0.2d, v0.2d
fabs v1.2d, v1.2d
fmax v0.2d, v0.2d, v1.2d
fmaxp d0, v0.2d
subs x5, x5, #0x1
b.eq damax_k_64
damax_k_40:
ld2 { v1.2d, v2.2d }, [x1], #32
fabs v1.2d, v1.2d
fabs v2.2d, v2.2d
fmax v1.2d, v1.2d, v2.2d
fmaxp d1, v1.2d
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne damax_k_40
damax_k_64:
ands x5, x0, #0x3
b.le damax_k_120
damax_k_6c:
ldr d1, [x1], #0x8
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne damax_k_6c
ret
damax_k_88:
ldr d0, [x1], #0x8
fabs d0, d0
subs x0, x0, #0x1
b damax_k_64
damax_k_98:
lsl x2, x2, #3
ld1 { v0.d }[0], [x1], x2
fabs d0, d0
subs x0, x0, #0x1
b.le damax_k_120
asr x5, x0, #2
cmp x5, xzr
b.le damax_k_100
damax_k_b8:
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne damax_k_b8
damax_k_100:
ands x5, x0, #0x3
b.le damax_k_120
damax_k_108:
ld1 { v1.d }[0], [x1], x2
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne damax_k_108
damax_k_120:
ret
damax_k_124:
fmov d0, xzr
ret
