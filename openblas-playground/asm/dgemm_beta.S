dgemm_beta:
ldr x6, [sp]
sub sp, sp, #0xb0
stp d8, d9, [sp]
stp d10, d11, [sp, #0x10]
stp d12, d13, [sp, #0x20]
stp d14, d15, [sp, #0x30]
stp d16, d17, [sp, #0x40]
stp x18, x19, [sp, #0x50]
stp x20, x21, [sp, #0x60]
stp x22, x23, [sp, #0x70]
stp x24, x25, [sp, #0x80]
stp x26, x27, [sp, #0x90]
str x28, [sp, #0xa0]
fmov d11, d0
cmp x1, #0x0
b.le dgemm_beta_140
fcmp d0, #0.0
b.eq dgemm_beta_178
lsl x6, x6, #3
nop
nop
nop
nop
nop
dgemm_beta_60:
mov x8, x7
add x7, x7, x6
asr x16, x0, #4
cmp x16, #0x0
b.le dgemm_beta_e0
add x9, x8, #0x20
add x10, x9, #0x20
add x11, x10, #0x20
dgemm_beta_80:
ldp q0, q1, [x8]
ldp q2, q3, [x9]
ldp q4, q5, [x10]
ldp q6, q7, [x11]
fmul v0.2d, v0.2d, v11.d[0]
fmul v1.2d, v1.2d, v11.d[0]
fmul v2.2d, v2.2d, v11.d[0]
fmul v3.2d, v3.2d, v11.d[0]
prfm pldl1keep, [x8, #0x280]
fmul v4.2d, v4.2d, v11.d[0]
fmul v5.2d, v5.2d, v11.d[0]
prfm pldl1keep, [x10, #0x280]
fmul v6.2d, v6.2d, v11.d[0]
fmul v7.2d, v7.2d, v11.d[0]
st1 { v0.2d, v1.2d }, [x8]
add x8, x8, #0x80
st1 { v2.2d, v3.2d }, [x9]
add x9, x9, #0x80
st1 { v4.2d, v5.2d }, [x10]
add x10, x10, #0x80
st1 { v6.2d, v7.2d }, [x11]
add x11, x11, #0x80
subs x16, x16, #0x1
b.ne dgemm_beta_80
dgemm_beta_e0:
and x16, x0, #0xf
cmp x16, #0x0
b.le dgemm_beta_120
nop
nop
nop
nop
nop
dgemm_beta_100:
ldr d12, [x8]
fmul d12, d12, d11
str d12, [x8]
add x8, x8, #0x8
subs x16, x16, #0x1
b.ne dgemm_beta_100
nop
nop
dgemm_beta_120:
subs x1, x1, #0x1
b.ne dgemm_beta_60
nop
nop
nop
nop
nop
nop
dgemm_beta_140:
mov x0, #0x0
ldp d8, d9, [sp]
ldp d10, d11, [sp, #0x10]
ldp d12, d13, [sp, #0x20]
ldp d14, d15, [sp, #0x30]
ldp d16, d17, [sp, #0x40]
ldp x18, x19, [sp, #0x50]
ldp x20, x21, [sp, #0x60]
ldp x22, x23, [sp, #0x70]
ldp x24, x25, [sp, #0x80]
ldp x26, x27, [sp, #0x90]
ldr x28, [sp, #0xa0]
add sp, sp, #0xb0
ret
dgemm_beta_178:
movi v0.2d, #0000000000000000
movi v1.2d, #0000000000000000
movi v2.2d, #0000000000000000
movi v3.2d, #0000000000000000
movi v4.2d, #0000000000000000
movi v5.2d, #0000000000000000
movi v6.2d, #0000000000000000
movi v7.2d, #0000000000000000
lsl x6, x6, #3
nop
dgemm_beta_1a0:
mov x8, x7
add x7, x7, x6
asr x16, x0, #4
cmp x16, #0x0
b.le dgemm_beta_1e0
add x9, x8, #0x40
nop
nop
dgemm_beta_1c0:
st1 { v0.2d, v1.2d, v2.2d, v3.2d }, [x8]
add x8, x8, #0x80
st1 { v4.2d, v5.2d, v6.2d, v7.2d }, [x9]
add x9, x9, #0x80
subs x16, x16, #0x1
b.ne dgemm_beta_1c0
nop
nop
dgemm_beta_1e0:
and x16, x0, #0xf
cmp x16, #0x0
b.le dgemm_beta_220
nop
nop
nop
nop
nop
dgemm_beta_200:
str d11, [x8]
add x8, x8, #0x8
subs x16, x16, #0x1
b.ne dgemm_beta_200
nop
nop
nop
nop
dgemm_beta_220:
subs x1, x1, #0x1
b.ne dgemm_beta_1a0
nop
nop
nop
nop
nop
nop
mov x0, #0x0
ldp d8, d9, [sp]
ldp d10, d11, [sp, #0x10]
ldp d12, d13, [sp, #0x20]
ldp d14, d15, [sp, #0x30]
ldp d16, d17, [sp, #0x40]
ldp x18, x19, [sp, #0x50]
ldp x20, x21, [sp, #0x60]
ldp x22, x23, [sp, #0x70]
ldp x24, x25, [sp, #0x80]
ldp x26, x27, [sp, #0x90]
ldr x28, [sp, #0xa0]
add sp, sp, #0xb0
ret
