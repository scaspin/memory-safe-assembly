dgemm_ncopy_4:
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
lsl x3, x3, #3
asr x10, x1, #2
cmp x10, #0x0
b.le dgemm_ncopy_4_108
dgemm_ncopy_4_40:
mov x5, x2
add x6, x5, x3
add x7, x6, x3
add x8, x7, x3
add x2, x8, x3
asr x9, x0, #2
cmp x9, #0x0
b.le dgemm_ncopy_4_c8
dgemm_ncopy_4_60:
ldp q0, q1, [x5], #0x20
mov v8.d[0], v0.d[0]
mov v10.d[0], v0.d[1]
mov v12.d[0], v1.d[0]
mov v14.d[0], v1.d[1]
ldp q2, q3, [x6], #0x20
mov v8.d[1], v2.d[0]
mov v10.d[1], v2.d[1]
mov v12.d[1], v3.d[0]
mov v14.d[1], v3.d[1]
ldp q4, q5, [x7], #0x20
mov v9.d[0], v4.d[0]
mov v11.d[0], v4.d[1]
mov v13.d[0], v5.d[0]
mov v15.d[0], v5.d[1]
ldp q6, q7, [x8], #0x20
mov v9.d[1], v6.d[0]
mov v11.d[1], v6.d[1]
mov v13.d[1], v7.d[0]
mov v15.d[1], v7.d[1]
st1 { v8.2d, v9.2d, v10.2d, v11.2d }, [x4]
add x4, x4, #0x40
st1 { v12.2d, v13.2d, v14.2d, v15.2d }, [x4]
add x4, x4, #0x40
subs x9, x9, #0x1
b.ne dgemm_ncopy_4_60
dgemm_ncopy_4_c8:
and x9, x0, #0x3
cmp x9, #0x0
b.le dgemm_ncopy_4_100
nop
nop
nop
dgemm_ncopy_4_e0:
ldr d0, [x5], #0x8
ldr d1, [x6], #0x8
ldr d2, [x7], #0x8
ldr d3, [x8], #0x8
st1 { v0.1d, v1.1d, v2.1d, v3.1d }, [x4]
add x4, x4, #0x20
subs x9, x9, #0x1
b.ne dgemm_ncopy_4_e0
dgemm_ncopy_4_100:
subs x10, x10, #0x1
b.ne dgemm_ncopy_4_40
dgemm_ncopy_4_108:
tst x1, #0x3
b.le dgemm_ncopy_4_210
tst x1, #0x2
b.le dgemm_ncopy_4_1b8
mov x5, x2
add x6, x5, x3
add x2, x6, x3
asr x9, x0, #2
cmp x9, #0x0
b.le dgemm_ncopy_4_178
nop
nop
nop
nop
dgemm_ncopy_4_140:
ldp q0, q1, [x5], #0x20
mov v8.d[0], v0.d[0]
mov v9.d[0], v0.d[1]
mov v10.d[0], v1.d[0]
mov v11.d[0], v1.d[1]
ldp q2, q3, [x6], #0x20
mov v8.d[1], v2.d[0]
mov v9.d[1], v2.d[1]
mov v10.d[1], v3.d[0]
mov v11.d[1], v3.d[1]
st1 { v8.2d, v9.2d, v10.2d, v11.2d }, [x4]
add x4, x4, #0x40
subs x9, x9, #0x1
b.ne dgemm_ncopy_4_140
dgemm_ncopy_4_178:
and x9, x0, #0x3
cmp x9, #0x0
b.le dgemm_ncopy_4_1b8
nop
nop
nop
nop
nop
nop
nop
dgemm_ncopy_4_1a0:
ldr d0, [x5], #0x8
ldr d1, [x6], #0x8
stp d0, d1, [x4]
add x4, x4, #0x10
subs x9, x9, #0x1
b.ne dgemm_ncopy_4_1a0
dgemm_ncopy_4_1b8:
tst x1, #0x1
b.le dgemm_ncopy_4_210
mov x5, x2
asr x9, x0, #2
cmp x9, #0x0
b.le dgemm_ncopy_4_1f0
nop
nop
nop
nop
dgemm_ncopy_4_1e0:
ldp q0, q1, [x5], #0x20
stp q0, q1, [x4], #0x20
subs x9, x9, #0x1
b.ne dgemm_ncopy_4_1e0
dgemm_ncopy_4_1f0:
and x9, x0, #0x3
cmp x9, #0x0
b.le dgemm_ncopy_4_210
nop
dgemm_ncopy_4_200:
ldr d0, [x5], #0x8
str d0, [x4], #0x8
subs x9, x9, #0x1
b.ne dgemm_ncopy_4_200
dgemm_ncopy_4_210:
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
