sdot_k:
fmov s0, wzr
cmp x0, xzr
b.le sdot_k_d8
cmp x2, #0x1
b.ne sdot_k_70
cmp x4, #0x1
b.ne sdot_k_70
asr x5, x0, #2
cmp x5, xzr
b.eq sdot_k_50
sdot_k_28:
ld1 { v2.4s }, [x1], #16
ld1 { v3.4s }, [x3], #16
fmla v0.4s, v2.4s, v3.4s
prfm pldl1keep, [x1, #0x400]
prfm pldl1keep, [x3, #0x400]
subs x5, x5, #0x1
b.ne sdot_k_28
ext v1.16b, v0.16b, v0.16b, #0x8
fadd v0.2s, v0.2s, v1.2s
faddp s0, v0.2s
sdot_k_50:
ands x5, x0, #0x3
b.le sdot_k_d8
sdot_k_58:
ldr s2, [x1], #0x4
ldr s3, [x3], #0x4
fmadd s0, s2, s3, s0
subs x5, x5, #0x1
b.ne sdot_k_58
ret
sdot_k_70:
lsl x2, x2, #2
lsl x4, x4, #2
asr x5, x0, #2
cmp x5, xzr
b.le sdot_k_bc
sdot_k_84:
ld1 { v2.s }[0], [x1], x2
ld1 { v3.s }[0], [x3], x4
fmadd s0, s2, s3, s0
ld1 { v2.s }[0], [x1], x2
ld1 { v3.s }[0], [x3], x4
fmadd s0, s2, s3, s0
ld1 { v2.s }[0], [x1], x2
ld1 { v3.s }[0], [x3], x4
fmadd s0, s2, s3, s0
ld1 { v2.s }[0], [x1], x2
ld1 { v3.s }[0], [x3], x4
fmadd s0, s2, s3, s0
subs x5, x5, #0x1
b.ne sdot_k_84
sdot_k_bc:
ands x5, x0, #0x3
b.le sdot_k_d8
sdot_k_c4:
ld1 { v2.s }[0], [x1], x2
ld1 { v3.s }[0], [x3], x4
fmadd s0, s2, s3, s0
subs x5, x5, #0x1
b.ne sdot_k_c4
sdot_k_d8:
ret
