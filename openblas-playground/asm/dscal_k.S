dscal_k:
cmp x0, xzr
b.le dscal_k_104
ldr x9, [sp]
cmp x9, #0x1
b.eq dscal_k_1c
fcmp d0, #0.0
b.eq dscal_k_10c
dscal_k_1c:
cmp x4, #0x1
b.ne dscal_k_7c
asr x1, x0, #3
cmp x1, xzr
b.eq dscal_k_58
mov v0.d[1], v0.d[0]
dscal_k_34:
ld1 { v1.2d, v2.2d, v3.2d, v4.2d }, [x3]
fmul v1.2d, v1.2d, v0.2d
fmul v2.2d, v2.2d, v0.2d
fmul v3.2d, v3.2d, v0.2d
fmul v4.2d, v4.2d, v0.2d
st1 { v1.2d, v2.2d, v3.2d, v4.2d }, [x3], #64
prfm pldl1keep, [x3, #0x400]
subs x1, x1, #0x1
b.ne dscal_k_34
dscal_k_58:
ands x1, x0, #0x7
b.le dscal_k_104
dscal_k_60:
ldr d1, [x3]
fmul d1, d1, d0
str d1, [x3], #0x8
subs x1, x1, #0x1
b.ne dscal_k_60
mov w0, wzr
ret
dscal_k_7c:
lsl x4, x4, #3
mov x5, x3
asr x1, x0, #2
cmp x1, xzr
b.le dscal_k_e8
dscal_k_90:
ldr d1, [x3]
add x3, x3, x4
fmul d1, d1, d0
str d1, [x5]
add x5, x5, x4
ldr d2, [x3]
add x3, x3, x4
fmul d2, d2, d0
str d2, [x5]
add x5, x5, x4
ldr d3, [x3]
add x3, x3, x4
fmul d3, d3, d0
str d3, [x5]
add x5, x5, x4
ldr d4, [x3]
add x3, x3, x4
fmul d4, d4, d0
str d4, [x5]
add x5, x5, x4
subs x1, x1, #0x1
b.ne dscal_k_90
dscal_k_e8:
ands x1, x0, #0x3
b.le dscal_k_104
dscal_k_f0:
ldr d1, [x3]
fmul d1, d1, d0
st1 { v1.d }[0], [x3], x4
subs x1, x1, #0x1
b.ne dscal_k_f0
dscal_k_104:
mov w0, wzr
ret
dscal_k_10c:
lsl x4, x4, #3
dscal_k_110:
st1 { v0.d }[0], [x3], x4
subs x0, x0, #0x1
b.ne dscal_k_110
mov w0, wzr
ret
