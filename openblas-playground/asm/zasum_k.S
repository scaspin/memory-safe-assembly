zasum_k:
fmov d0, xzr
cmp x0, xzr
b.le zasum_k_7c
cmp x2, xzr
b.le zasum_k_7c
cmp x2, #0x1
b.ne zasum_k_80
asr x5, x0, #2
cmp x5, xzr
b.eq zasum_k_5c
zasum_k_28:
ld1 { v1.2d, v2.2d, v3.2d, v4.2d }, [x1], #64
fabs v1.2d, v1.2d
fabs v2.2d, v2.2d
fabs v3.2d, v3.2d
fabs v4.2d, v4.2d
fadd v1.2d, v1.2d, v2.2d
fadd v3.2d, v3.2d, v4.2d
fadd v0.2d, v0.2d, v1.2d
fadd v0.2d, v0.2d, v3.2d
prfm pldl1keep, [x1, #0x400]
subs x5, x5, #0x1
b.ne zasum_k_28
faddp d0, v0.2d
zasum_k_5c:
ands x5, x0, #0x3
b.le zasum_k_7c
zasum_k_64:
ld1 { v1.2d }, [x1], #16
fabs v1.2d, v1.2d
faddp d1, v1.2d
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne zasum_k_64
zasum_k_7c:
ret
zasum_k_80:
lsl x2, x2, #4
asr x5, x0, #2
cmp x5, xzr
b.le zasum_k_d8
zasum_k_90:
ld1 { v1.2d }, [x1], x2
fabs v1.2d, v1.2d
faddp d1, v1.2d
fadd d0, d0, d1
ld1 { v1.2d }, [x1], x2
fabs v1.2d, v1.2d
faddp d1, v1.2d
fadd d0, d0, d1
ld1 { v1.2d }, [x1], x2
fabs v1.2d, v1.2d
faddp d1, v1.2d
fadd d0, d0, d1
ld1 { v1.2d }, [x1], x2
fabs v1.2d, v1.2d
faddp d1, v1.2d
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne zasum_k_90
zasum_k_d8:
ands x5, x0, #0x3
b.le zasum_k_7c
zasum_k_e0:
ld1 { v1.2d }, [x1], x2
fabs v1.2d, v1.2d
faddp d1, v1.2d
fadd d0, d0, d1
subs x5, x5, #0x1
b.ne zasum_k_e0
ret
