dgemm_tcopy_4:
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
lsl x16, x0, #3
and x11, x1, #0xfffffffffffffffc
and x12, x1, #0xfffffffffffffffe
mul x11, x11, x16
mul x12, x12, x16
add x11, x11, x4
add x12, x12, x4
lsl x5, x0, #5
asr x15, x0, #2
cmp x15, #0x0
b.le dgemm_tcopy_4_110
dgemm_tcopy_4_60:
mov x6, x2
add x7, x6, x3
add x8, x7, x3
add x9, x8, x3
add x2, x9, x3
mov x10, x4
add x4, x10, #0x80
asr x14, x1, #2
cmp x14, #0x0
b.le dgemm_tcopy_4_c8
nop
nop
nop
nop
nop
nop
dgemm_tcopy_4_a0:
ldp q0, q1, [x6], #0x20
ldp q2, q3, [x7], #0x20
st1 { v0.2d, v1.2d, v2.2d, v3.2d }, [x10]
add x16, x10, #0x40
ldp q4, q5, [x8], #0x20
ldp q6, q7, [x9], #0x20
st1 { v4.2d, v5.2d, v6.2d, v7.2d }, [x16]
add x10, x10, x5
subs x14, x14, #0x1
b.ne dgemm_tcopy_4_a0
dgemm_tcopy_4_c8:
tst x1, #0x2
b.le dgemm_tcopy_4_e8
ldr q0, [x6], #0x10
ldr q1, [x7], #0x10
ldr q2, [x8], #0x10
ldr q3, [x9], #0x10
st1 { v0.2d, v1.2d, v2.2d, v3.2d }, [x11]
add x11, x11, #0x40
dgemm_tcopy_4_e8:
tst x1, #0x1
b.le dgemm_tcopy_4_108
ldr d0, [x6], #0x8
ldr d1, [x7], #0x8
ldr d2, [x8], #0x8
ldr d3, [x9], #0x8
st1 { v0.1d, v1.1d, v2.1d, v3.1d }, [x12]
add x12, x12, #0x20
dgemm_tcopy_4_108:
subs x15, x15, #0x1
b.ne dgemm_tcopy_4_60
dgemm_tcopy_4_110:
tst x0, #0x3
b.le dgemm_tcopy_4_1fc
tst x0, #0x2
b.le dgemm_tcopy_4_188
mov x6, x2
add x7, x6, x3
add x2, x7, x3
mov x10, x4
add x4, x10, #0x40
asr x14, x1, #2
cmp x14, #0x0
b.le dgemm_tcopy_4_158
dgemm_tcopy_4_140:
ldp q0, q1, [x6], #0x20
ldp q2, q3, [x7], #0x20
st1 { v0.2d, v1.2d, v2.2d, v3.2d }, [x10]
add x10, x10, x5
subs x14, x14, #0x1
b.ne dgemm_tcopy_4_140
dgemm_tcopy_4_158:
tst x1, #0x2
b.le dgemm_tcopy_4_170
ldr q0, [x6], #0x10
ldr q1, [x7], #0x10
stp q0, q1, [x11]
add x11, x11, #0x20
dgemm_tcopy_4_170:
tst x1, #0x1
b.le dgemm_tcopy_4_188
ldr d0, [x6], #0x8
ldr d1, [x7], #0x8
stp d0, d1, [x12]
add x12, x12, #0x10
dgemm_tcopy_4_188:
tst x0, #0x1
b.le dgemm_tcopy_4_1fc
mov x6, x2
mov x10, x4
asr x14, x1, #2
cmp x14, #0x0
b.le dgemm_tcopy_4_1d4
nop
nop
nop
nop
nop
nop
nop
dgemm_tcopy_4_1c0:
ldp q0, q1, [x6], #0x20
stp q0, q1, [x10]
add x10, x10, x5
subs x14, x14, #0x1
b.ne dgemm_tcopy_4_1c0
dgemm_tcopy_4_1d4:
tst x1, #0x2
b.le dgemm_tcopy_4_1e8
ldr q0, [x6], #0x10
str q0, [x11]
add x11, x11, #0x10
dgemm_tcopy_4_1e8:
tst x1, #0x1
b.le dgemm_tcopy_4_1fc
ldr d0, [x6], #0x8
str d0, [x12]
add x12, x12, #0x8
dgemm_tcopy_4_1fc:
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
