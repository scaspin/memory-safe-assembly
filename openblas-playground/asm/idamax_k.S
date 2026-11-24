idamax_k:
cmp x0, xzr
b.le idamax_k_228
cmp x2, xzr
b.le idamax_k_228
cmp x2, #0x1
b.ne idamax_k_168
mov x7, x1
lsl x2, x2, #3
ld1 { v0.d }[0], [x1], x2
mov x4, #0x1
mov x3, x4
fabs d0, d0
subs x0, x0, #0x1
b.le idamax_k_220
asr x5, x0, #3
cmp x5, xzr
b.eq idamax_k_13c
add x4, x4, #0x1
idamax_k_48:
ldp q2, q3, [x1], #0x20
ldp q4, q5, [x1], #0x20
fabs v2.2d, v2.2d
fabs v3.2d, v3.2d
fabs v4.2d, v4.2d
fabs v5.2d, v5.2d
fmax v2.2d, v2.2d, v3.2d
fmax v4.2d, v4.2d, v5.2d
fmax v2.2d, v2.2d, v4.2d
fmaxp d1, v2.2d
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
add x4, x4, #0x8
prfm pldl1keep, [x1, #0x400]
subs x5, x5, #0x1
b.ne idamax_k_48
sub x6, x3, #0x1
add x6, x6, #0x4
lsl x6, x6, #3
add x7, x7, x6
ldp q2, q3, [x7]
fabs v2.2d, v2.2d
fabs v3.2d, v3.2d
mov v4.d[0], v2.d[0]
mov v5.d[0], v2.d[1]
mov v6.d[0], v3.d[0]
mov v7.d[0], v3.d[1]
add x6, x3, #0x7
fcmp d0, d7
csel x3, x6, x3, eq
sub x6, x6, #0x1
fcmp d0, d6
csel x3, x6, x3, eq
sub x6, x6, #0x1
fcmp d0, d5
csel x3, x6, x3, eq
sub x6, x6, #0x1
fcmp d0, d4
csel x3, x6, x3, eq
sub x7, x7, #0x20
ldp q2, q3, [x7]
fabs v2.2d, v2.2d
fabs v3.2d, v3.2d
mov v4.d[0], v2.d[0]
mov v5.d[0], v2.d[1]
mov v6.d[0], v3.d[0]
mov v7.d[0], v3.d[1]
sub x6, x6, #0x1
fcmp d0, d7
csel x3, x6, x3, eq
sub x6, x6, #0x1
fcmp d0, d6
csel x3, x6, x3, eq
sub x6, x6, #0x1
fcmp d0, d5
csel x3, x6, x3, eq
sub x6, x6, #0x1
fcmp d0, d4
csel x3, x6, x3, eq
sub x4, x4, #0x1
idamax_k_13c:
ands x5, x0, #0x7
b.le idamax_k_220
idamax_k_144:
ld1 { v1.d }[0], [x1], x2
add x4, x4, #0x1
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
subs x5, x5, #0x1
b.ne idamax_k_144
b idamax_k_220
idamax_k_168:
lsl x2, x2, #3
ld1 { v0.d }[0], [x1], x2
mov x4, #0x1
mov x3, x4
fabs d0, d0
subs x0, x0, #0x1
b.le idamax_k_220
asr x5, x0, #2
cmp x5, xzr
b.le idamax_k_1f8
idamax_k_190:
ld1 { v1.d }[0], [x1], x2
add x4, x4, #0x1
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
ld1 { v1.d }[0], [x1], x2
add x4, x4, #0x1
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
ld1 { v1.d }[0], [x1], x2
add x4, x4, #0x1
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
ld1 { v1.d }[0], [x1], x2
add x4, x4, #0x1
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
subs x5, x5, #0x1
b.ne idamax_k_190
idamax_k_1f8:
ands x5, x0, #0x3
b.le idamax_k_220
idamax_k_200:
ld1 { v1.d }[0], [x1], x2
add x4, x4, #0x1
fabs d1, d1
fcmp d0, d1
fcsel d0, d0, d1, ge
csel x3, x3, x4, ge
subs x5, x5, #0x1
b.ne idamax_k_200
idamax_k_220:
mov x0, x3
ret
idamax_k_228:
mov x0, xzr
ret
