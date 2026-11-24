zdotu_k:
fmov d0, xzr
fmov d1, d0
fmov d20, d0
fmov d21, d1
cmp x0, xzr
b.le zdotu_k_16c
cmp x2, #0x1
b.ne zdotu_k_b4
cmp x4, #0x1
b.ne zdotu_k_b4
asr x5, x0, #2
cmp x5, xzr
b.eq zdotu_k_84
zdotu_k_34:
ld2 { v2.2d, v3.2d }, [x1], #32
ld2 { v16.2d, v17.2d }, [x3], #32
fmla v0.2d, v2.2d, v16.2d
fmla v1.2d, v2.2d, v17.2d
ld2 { v4.2d, v5.2d }, [x1], #32
ld2 { v18.2d, v19.2d }, [x3], #32
fmla v0.2d, v4.2d, v18.2d
fmla v1.2d, v4.2d, v19.2d
prfm pldl1keep, [x1, #0x400]
prfm pldl1keep, [x3, #0x400]
fmls v0.2d, v3.2d, v17.2d
fmls v20.2d, v5.2d, v19.2d
fmla v1.2d, v3.2d, v16.2d
fmla v21.2d, v5.2d, v18.2d
subs x5, x5, #0x1
b.ne zdotu_k_34
fadd v0.2d, v0.2d, v20.2d
faddp d0, v0.2d
fadd v1.2d, v1.2d, v21.2d
faddp d1, v1.2d
zdotu_k_84:
ands x5, x0, #0x3
b.le zdotu_k_16c
zdotu_k_8c:
ld1 { v2.2d }, [x1], #16
ld1 { v3.2d }, [x3], #16
mov v4.d[0], v2.d[1]
fmla d0, d2, v3.d[0]
fmls d0, d4, v3.d[1]
fmla d1, d4, v3.d[0]
fmla d1, d2, v3.d[1]
subs x5, x5, #0x1
b.ne zdotu_k_8c
ret
zdotu_k_b4:
lsl x2, x2, #4
lsl x4, x4, #4
asr x5, x0, #2
cmp x5, xzr
b.le zdotu_k_140
zdotu_k_c8:
ld1 { v2.2d }, [x1], x2
ld1 { v3.2d }, [x3], x4
ext v4.16b, v2.16b, v2.16b, #0x8
fmla d0, d2, v3.d[0]
fmls d0, d4, v3.d[1]
fmla d1, d4, v3.d[0]
fmla d1, d2, v3.d[1]
ld1 { v2.2d }, [x1], x2
ld1 { v3.2d }, [x3], x4
ext v4.16b, v2.16b, v2.16b, #0x8
fmla d0, d2, v3.d[0]
fmls d0, d4, v3.d[1]
fmla d1, d4, v3.d[0]
fmla d1, d2, v3.d[1]
ld1 { v2.2d }, [x1], x2
ld1 { v3.2d }, [x3], x4
ext v4.16b, v2.16b, v2.16b, #0x8
fmla d0, d2, v3.d[0]
fmls d0, d4, v3.d[1]
fmla d1, d4, v3.d[0]
fmla d1, d2, v3.d[1]
ld1 { v2.2d }, [x1], x2
ld1 { v3.2d }, [x3], x4
ext v4.16b, v2.16b, v2.16b, #0x8
fmla d0, d2, v3.d[0]
fmls d0, d4, v3.d[1]
fmla d1, d4, v3.d[0]
fmla d1, d2, v3.d[1]
subs x5, x5, #0x1
b.ne zdotu_k_c8
zdotu_k_140:
ands x5, x0, #0x3
b.le zdotu_k_16c
zdotu_k_148:
ld1 { v2.2d }, [x1], x2
ld1 { v3.2d }, [x3], x4
ext v4.16b, v2.16b, v2.16b, #0x8
fmla d0, d2, v3.d[0]
fmls d0, d4, v3.d[1]
fmla d1, d4, v3.d[0]
fmla d1, d2, v3.d[1]
subs x5, x5, #0x1
b.ne zdotu_k_148
zdotu_k_16c:
ret
