dgemv_t:
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
b.le dgemv_t_210
cmp x0, xzr
b.le dgemv_t_210
lsl x4, x4, #3
lsl x2, x2, #3
mov x11, x1
cmp x6, #0x1
b.ne dgemv_t_188
dgemv_t_58:
fmov d1, xzr
fmov d2, xzr
fmov d3, xzr
fmov d4, xzr
mov x9, x3
mov x10, x5
asr x12, x0, #5
cmp x12, xzr
b.eq dgemv_t_104
dgemv_t_7c:
ld1 { v5.2d, v6.2d, v7.2d, v8.2d }, [x9], #64
ld1 { v9.2d, v10.2d, v11.2d, v12.2d }, [x10], #64
fmla v1.2d, v5.2d, v9.2d
prfm pldl1keep, [x9, #0x300]
fmla v2.2d, v6.2d, v10.2d
prfm pldl1keep, [x10, #0x300]
fmla v3.2d, v7.2d, v11.2d
fmla v4.2d, v8.2d, v12.2d
ld1 { v13.2d, v14.2d, v15.2d, v16.2d }, [x9], #64
ld1 { v17.2d, v18.2d, v19.2d, v20.2d }, [x10], #64
fmla v1.2d, v13.2d, v17.2d
prfm pldl1keep, [x9, #0x300]
fmla v2.2d, v14.2d, v18.2d
prfm pldl1keep, [x10, #0x300]
fmla v3.2d, v15.2d, v19.2d
fmla v4.2d, v16.2d, v20.2d
ld1 { v5.2d, v6.2d, v7.2d, v8.2d }, [x9], #64
ld1 { v9.2d, v10.2d, v11.2d, v12.2d }, [x10], #64
fmla v1.2d, v5.2d, v9.2d
prfm pldl1keep, [x9, #0x300]
fmla v2.2d, v6.2d, v10.2d
prfm pldl1keep, [x10, #0x300]
fmla v3.2d, v7.2d, v11.2d
fmla v4.2d, v8.2d, v12.2d
ld1 { v13.2d, v14.2d, v15.2d, v16.2d }, [x9], #64
ld1 { v17.2d, v18.2d, v19.2d, v20.2d }, [x10], #64
fmla v1.2d, v13.2d, v17.2d
prfm pldl1keep, [x9, #0x300]
fmla v2.2d, v14.2d, v18.2d
prfm pldl1keep, [x10, #0x300]
fmla v3.2d, v15.2d, v19.2d
fmla v4.2d, v16.2d, v20.2d
subs x12, x12, #0x1
b.ne dgemv_t_7c
dgemv_t_104:
ands x12, x0, #0x1f
asr x12, x12, #3
cmp x12, xzr
b.eq dgemv_t_134
dgemv_t_114:
ld1 { v13.2d, v14.2d, v15.2d, v16.2d }, [x9], #64
ld1 { v17.2d, v18.2d, v19.2d, v20.2d }, [x10], #64
fmla v1.2d, v13.2d, v17.2d
fmla v2.2d, v14.2d, v18.2d
fmla v3.2d, v15.2d, v19.2d
fmla v4.2d, v16.2d, v20.2d
subs x12, x12, #0x1
b.ne dgemv_t_114
dgemv_t_134:
faddp d1, v1.2d
faddp d2, v2.2d
faddp d3, v3.2d
faddp d4, v4.2d
fadd d1, d1, d2
fadd d3, d3, d4
fadd d1, d1, d3
ands x12, x0, #0x7
b.le dgemv_t_16c
dgemv_t_158:
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10], #8
fmadd d1, d2, d3, d1
subs x12, x12, #0x1
b.ne dgemv_t_158
dgemv_t_16c:
ld1 { v2.d }[0], [x7]
add x3, x3, x4
subs x11, x11, #0x1
fmadd d2, d0, d1, d2
st1 { v2.d }[0], [x7], x2
b.ne dgemv_t_58
b dgemv_t_210
dgemv_t_188:
lsl x6, x6, #3
dgemv_t_18c:
fmov d1, xzr
mov x9, x3
mov x10, x5
asr x12, x0, #2
cmp x12, xzr
b.le dgemv_t_1dc
dgemv_t_1a4:
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10], x6
fmadd d1, d2, d3, d1
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10], x6
fmadd d1, d2, d3, d1
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10], x6
fmadd d1, d2, d3, d1
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10], x6
fmadd d1, d2, d3, d1
subs x12, x12, #0x1
b.ne dgemv_t_1a4
dgemv_t_1dc:
ands x12, x0, #0x3
b.le dgemv_t_1f8
dgemv_t_1e4:
ld1 { v2.d }[0], [x9], #8
ld1 { v3.d }[0], [x10], x6
fmadd d1, d2, d3, d1
subs x12, x12, #0x1
b.ne dgemv_t_1e4
dgemv_t_1f8:
ld1 { v2.d }[0], [x7]
add x3, x3, x4
subs x11, x11, #0x1
fmadd d2, d0, d1, d2
st1 { v2.d }[0], [x7], x2
b.ne dgemv_t_18c
dgemv_t_210:
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
mov w0, wzr
ret
