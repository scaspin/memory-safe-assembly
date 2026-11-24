dgemv_n:
ldr x2, [sp]
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
cmp x1, xzr
b.le dgemv_n_240
cmp x0, xzr
b.le dgemv_n_240
lsl x4, x4, #3
lsl x6, x6, #3
mov x11, x1
cmp x2, #0x1
b.ne dgemv_n_1ac
dgemv_n_58:
ld1 { v1.d }[0], [x5], x6
fmul d1, d0, d1
mov v1.d[1], v1.d[0]
mov x9, x3
mov x10, x7
mov x13, x7
asr x12, x0, #5
cmp x12, xzr
b.eq dgemv_n_144
dgemv_n_7c:
ld1 { v2.2d, v3.2d }, [x9], #32
ld1 { v4.2d, v5.2d }, [x10], #32
fmla v4.2d, v1.2d, v2.2d
prfm pldl1keep, [x9, #0x300]
fmla v5.2d, v1.2d, v3.2d
st1 { v4.2d, v5.2d }, [x13], #32
ld1 { v6.2d, v7.2d }, [x9], #32
ld1 { v8.2d, v9.2d }, [x10], #32
fmla v8.2d, v1.2d, v6.2d
prfm pldl1keep, [x10, #0x300]
fmla v9.2d, v1.2d, v7.2d
st1 { v8.2d, v9.2d }, [x13], #32
ld1 { v10.2d, v11.2d }, [x9], #32
ld1 { v12.2d, v13.2d }, [x10], #32
fmla v12.2d, v1.2d, v10.2d
prfm pldl1keep, [x9, #0x300]
fmla v13.2d, v1.2d, v11.2d
st1 { v12.2d, v13.2d }, [x13], #32
ld1 { v14.2d, v15.2d }, [x9], #32
ld1 { v16.2d, v17.2d }, [x10], #32
fmla v16.2d, v1.2d, v14.2d
prfm pldl1keep, [x10, #0x300]
fmla v17.2d, v1.2d, v15.2d
st1 { v16.2d, v17.2d }, [x13], #32
ld1 { v2.2d, v3.2d }, [x9], #32
ld1 { v4.2d, v5.2d }, [x10], #32
fmla v4.2d, v1.2d, v2.2d
prfm pldl1keep, [x9, #0x300]
fmla v5.2d, v1.2d, v3.2d
st1 { v4.2d, v5.2d }, [x13], #32
ld1 { v6.2d, v7.2d }, [x9], #32
ld1 { v8.2d, v9.2d }, [x10], #32
fmla v8.2d, v1.2d, v6.2d
prfm pldl1keep, [x10, #0x300]
fmla v9.2d, v1.2d, v7.2d
st1 { v8.2d, v9.2d }, [x13], #32
ld1 { v10.2d, v11.2d }, [x9], #32
ld1 { v12.2d, v13.2d }, [x10], #32
fmla v12.2d, v1.2d, v10.2d
prfm pldl1keep, [x9, #0x300]
fmla v13.2d, v1.2d, v11.2d
st1 { v12.2d, v13.2d }, [x13], #32
ld1 { v14.2d, v15.2d }, [x9], #32
ld1 { v16.2d, v17.2d }, [x10], #32
fmla v16.2d, v1.2d, v14.2d
prfm pldl1keep, [x10, #0x300]
fmla v17.2d, v1.2d, v15.2d
st1 { v16.2d, v17.2d }, [x13], #32
subs x12, x12, #0x1
b.ne dgemv_n_7c
dgemv_n_144:
ands x12, x0, #0x1f
asr x12, x12, #2
cmp x12, xzr
b.eq dgemv_n_17c
dgemv_n_154:
ld1 { v2.2d }, [x9], #16
ld1 { v3.2d }, [x10], #16
fmla v3.2d, v1.2d, v2.2d
st1 { v3.2d }, [x13], #16
ld1 { v4.2d }, [x9], #16
ld1 { v5.2d }, [x10], #16
fmla v5.2d, v1.2d, v4.2d
st1 { v5.2d }, [x13], #16
subs x12, x12, #0x1
b.ne dgemv_n_154
dgemv_n_17c:
ands x12, x0, #0x3
b.le dgemv_n_19c
dgemv_n_184:
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10]
fmadd d3, d1, d2, d3
st1 { v3.d }[0], [x10], #8
subs x12, x12, #0x1
b.ne dgemv_n_184
dgemv_n_19c:
add x3, x3, x4
subs x11, x11, #0x1
b.ne dgemv_n_58
b dgemv_n_240
dgemv_n_1ac:
lsl x2, x2, #3
dgemv_n_1b0:
ld1 { v1.d }[0], [x5], x6
fmul d1, d0, d1
mov x9, x3
mov x10, x7
asr x12, x0, #2
cmp x12, xzr
b.le dgemv_n_214
dgemv_n_1cc:
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10]
fmadd d3, d1, d2, d3
st1 { v3.d }[0], [x10], x2
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10]
fmadd d3, d1, d2, d3
st1 { v3.d }[0], [x10], x2
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10]
fmadd d3, d1, d2, d3
st1 { v3.d }[0], [x10], x2
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10]
fmadd d3, d1, d2, d3
st1 { v3.d }[0], [x10], x2
subs x12, x12, #0x1
b.ne dgemv_n_1cc
dgemv_n_214:
ands x12, x0, #0x3
b.le dgemv_n_234
dgemv_n_21c:
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10]
fmadd d3, d1, d2, d3
st1 { v3.d }[0], [x10], x2
subs x12, x12, #0x1
b.ne dgemv_n_21c
dgemv_n_234:
add x3, x3, x4
subs x11, x11, #0x1
b.ne dgemv_n_1b0
dgemv_n_240:
mov w0, wzr
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
