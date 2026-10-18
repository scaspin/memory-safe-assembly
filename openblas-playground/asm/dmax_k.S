dmax_k:
cmp x0, xzr
b.le dmax_k_f4
cmp x2, xzr
b.le dmax_k_f4
cmp x2, #0x1
b.ne dmax_k_80
asr x5, x0, #2
cmp x5, xzr
b.eq dmax_k_74
ld2 { v0.2d, v1.2d }, [x1], #32
fmax v0.2d, v0.2d, v1.2d
fmaxp d0, v0.2d
subs x5, x5, #0x1
b.eq dmax_k_54
dmax_k_38:
ld2 { v1.2d, v2.2d }, [x1], #32
fmax v1.2d, v1.2d, v2.2d
fmaxp d1, v1.2d
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne dmax_k_38
dmax_k_54:
ands x5, x0, #0x3
b.le dmax_k_f0
dmax_k_5c:
ldr d1, [x1], #0x8
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne dmax_k_5c
ret
dmax_k_74:
ldr d0, [x1], #0x8
subs x0, x0, #0x1
b dmax_k_54
dmax_k_80:
lsl x2, x2, #3
ld1 { v0.d }[0], [x1], x2
subs x0, x0, #0x1
b.le dmax_k_f0
asr x5, x0, #2
cmp x5, xzr
b.le dmax_k_d4
dmax_k_9c:
ld1 { v1.d }[0], [x1], x2
fcmp d0, d1
fcsel d0, d0, d1, ge
ld1 { v1.d }[0], [x1], x2
fcmp d0, d1
fcsel d0, d0, d1, ge
ld1 { v1.d }[0], [x1], x2
fcmp d0, d1
fcsel d0, d0, d1, ge
ld1 { v1.d }[0], [x1], x2
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne dmax_k_9c
dmax_k_d4:
ands x5, x0, #0x3
b.le dmax_k_f0
dmax_k_dc:
ld1 { v1.d }[0], [x1], x2
fcmp d0, d1
fcsel d0, d0, d1, ge
subs x5, x5, #0x1
b.ne dmax_k_dc
dmax_k_f0:
ret
dmax_k_f4:
fmov d0, xzr
ret
