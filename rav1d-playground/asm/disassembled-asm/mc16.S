_ltmp0:
clz	w4, w4
clz	w7, w6
sub	w7, w7, #18
mov	w9, #1
mov	w8, #-16384
lsl	w9, w9, w7
add	w7, w7, #1
sub	w8, w8, w9
neg	w7, w7
dup.8h	v28, w8
dup.8h	v29, w7
adr	x7, #948
sub	w4, w4, #24
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
ldrh	w4, [x7, x4, lsl #1]
sub	x7, x7, w4, uxtw
br	x7
add	x7, x0, x1
lsl	x1, x1, #1
subs	w5, w5, #4
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x7], x1
st1.d	{ v5 }[0], [x0], x1
st1.d	{ v5 }[1], [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
b	ltmp0
add	x7, x0, x1
lsl	x1, x1, #1
st1.8h	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v5 }, [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
b	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v6, v0, v29
sshl.8h	v7, v1, v29
st1.8h	{ v4, v5 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v6, v7 }, [x0], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
b	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v6, v0, v29
sshl.8h	v7, v1, v29
subs	w5, w5, #1
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
b	ltmp0
add	x7, x0, #64
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v6, v0, v29
sshl.8h	v7, v1, v29
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v16, v0, v29
sshl.8h	v17, v1, v29
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v18, v0, v29
sshl.8h	v19, v1, v29
subs	w5, w5, #1
st1.8h	{ v16, v17, v18, v19 }, [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
b	ltmp0
add	x7, x0, #64
mov	x8, #128
sub	x1, x1, #128
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v6, v0, v29
sshl.8h	v7, v1, v29
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v16, v0, v29
sshl.8h	v17, v1, v29
st1.8h	{ v4, v5, v6, v7 }, [x0], x8
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v18, v0, v29
sshl.8h	v19, v1, v29
st1.8h	{ v16, v17, v18, v19 }, [x7], x8
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v6, v0, v29
sshl.8h	v7, v1, v29
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v16, v0, v29
sshl.8h	v17, v1, v29
subs	w5, w5, #1
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v18, v0, v29
sshl.8h	v19, v1, v29
st1.8h	{ v16, v17, v18, v19 }, [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sqadd.8h	v0, v0, v2
sqadd.8h	v1, v1, v3
smax.8h	v0, v0, v28
smax.8h	v1, v1, v28
sqsub.8h	v0, v0, v28
sqsub.8h	v1, v1, v28
sshl.8h	v4, v0, v29
sshl.8h	v5, v1, v29
b	ltmp0
ret
<unknown>
<unknown>
<unknown>
_w_avg_16bpc_neon:
clz	w4, w4
dup.8h	v31, w7
movi.8h	v30, #0
clz	w7, w7
sub	w7, w7, #18
mov	w8, #8192
lsr	w8, w8, w7
neg	w7, w7
dup.8h	v28, w8
dup.8h	v29, w7
dup.4s	v27, w6
neg.4s	v27, v27
adr	x7, #2316
sub	w4, w4, #24
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
ldrh	w4, [x7, x4, lsl #1]
sub	x7, x7, w4, uxtw
br	x7
add	x7, x0, x1
lsl	x1, x1, #1
subs	w5, w5, #4
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x7], x1
st1.d	{ v5 }[0], [x0], x1
st1.d	{ v5 }[1], [x7], x1
b.le	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	w_avg_16bpc_neon
add	x7, x0, x1
lsl	x1, x1, #1
st1.8h	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v5 }, [x7], x1
b.le	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v27
mul.4s	v0, v0, v27
mul.4s	v7, v7, v27
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #4
sshr.4s	v0, v0, #4
sshr.4s	v7, v7, #4
sshr.4s	v1, v1, #4
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
st1.8h	{ v4, v5 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v6, v7 }, [x0], x1
b.le	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v27
mul.4s	v0, v0, v27
mul.4s	v7, v7, v27
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #4
sshr.4s	v0, v0, #4
sshr.4s	v7, v7, #4
sshr.4s	v1, v1, #4
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
subs	w5, w5, #1
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
b.le	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	w_avg_16bpc_neon
add	x7, x0, #64
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v27
mul.4s	v0, v0, v27
mul.4s	v7, v7, v27
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #4
sshr.4s	v0, v0, #4
sshr.4s	v7, v7, #4
sshr.4s	v1, v1, #4
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v16, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v17, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v16, v16, v27
mul.4s	v0, v0, v27
mul.4s	v17, v17, v27
mul.4s	v1, v1, v27
sshr.4s	v16, v16, #4
sshr.4s	v0, v0, #4
sshr.4s	v17, v17, #4
sshr.4s	v1, v1, #4
saddw.4s	v16, v16, v2
saddw2.4s	v0, v0, v2
saddw.4s	v17, v17, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v16, v16, v0
uzp1.8h	v17, v17, v1
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
add.8h	v16, v16, v28
add.8h	v17, v17, v28
smin.8h	v16, v16, v31
smin.8h	v17, v17, v31
smax.8h	v16, v16, v30
smax.8h	v17, v17, v30
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v18, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v19, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v18, v18, v27
mul.4s	v0, v0, v27
mul.4s	v19, v19, v27
mul.4s	v1, v1, v27
sshr.4s	v18, v18, #4
sshr.4s	v0, v0, #4
sshr.4s	v19, v19, #4
sshr.4s	v1, v1, #4
saddw.4s	v18, v18, v2
saddw2.4s	v0, v0, v2
saddw.4s	v19, v19, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v18, v18, v0
uzp1.8h	v19, v19, v1
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
add.8h	v18, v18, v28
add.8h	v19, v19, v28
smin.8h	v18, v18, v31
smin.8h	v19, v19, v31
smax.8h	v18, v18, v30
smax.8h	v19, v19, v30
subs	w5, w5, #1
st1.8h	{ v16, v17, v18, v19 }, [x7], x1
b.le	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	w_avg_16bpc_neon
add	x7, x0, #64
mov	x8, #128
sub	x1, x1, #128
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v27
mul.4s	v0, v0, v27
mul.4s	v7, v7, v27
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #4
sshr.4s	v0, v0, #4
sshr.4s	v7, v7, #4
sshr.4s	v1, v1, #4
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v16, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v17, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v16, v16, v27
mul.4s	v0, v0, v27
mul.4s	v17, v17, v27
mul.4s	v1, v1, v27
sshr.4s	v16, v16, #4
sshr.4s	v0, v0, #4
sshr.4s	v17, v17, #4
sshr.4s	v1, v1, #4
saddw.4s	v16, v16, v2
saddw2.4s	v0, v0, v2
saddw.4s	v17, v17, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v16, v16, v0
uzp1.8h	v17, v17, v1
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
add.8h	v16, v16, v28
add.8h	v17, v17, v28
smin.8h	v16, v16, v31
smin.8h	v17, v17, v31
smax.8h	v16, v16, v30
smax.8h	v17, v17, v30
st1.8h	{ v4, v5, v6, v7 }, [x0], x8
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v18, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v19, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v18, v18, v27
mul.4s	v0, v0, v27
mul.4s	v19, v19, v27
mul.4s	v1, v1, v27
sshr.4s	v18, v18, #4
sshr.4s	v0, v0, #4
sshr.4s	v19, v19, #4
sshr.4s	v1, v1, #4
saddw.4s	v18, v18, v2
saddw2.4s	v0, v0, v2
saddw.4s	v19, v19, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v18, v18, v0
uzp1.8h	v19, v19, v1
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
add.8h	v18, v18, v28
add.8h	v19, v19, v28
smin.8h	v18, v18, v31
smin.8h	v19, v19, v31
smax.8h	v18, v18, v30
smax.8h	v19, v19, v30
st1.8h	{ v16, v17, v18, v19 }, [x7], x8
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v27
mul.4s	v0, v0, v27
mul.4s	v7, v7, v27
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #4
sshr.4s	v0, v0, #4
sshr.4s	v7, v7, #4
sshr.4s	v1, v1, #4
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v16, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v17, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v16, v16, v27
mul.4s	v0, v0, v27
mul.4s	v17, v17, v27
mul.4s	v1, v1, v27
sshr.4s	v16, v16, #4
sshr.4s	v0, v0, #4
sshr.4s	v17, v17, #4
sshr.4s	v1, v1, #4
saddw.4s	v16, v16, v2
saddw2.4s	v0, v0, v2
saddw.4s	v17, v17, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v16, v16, v0
uzp1.8h	v17, v17, v1
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
add.8h	v16, v16, v28
add.8h	v17, v17, v28
smin.8h	v16, v16, v31
smin.8h	v17, v17, v31
smax.8h	v16, v16, v30
smax.8h	v17, v17, v30
subs	w5, w5, #1
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v18, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v19, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v18, v18, v27
mul.4s	v0, v0, v27
mul.4s	v19, v19, v27
mul.4s	v1, v1, v27
sshr.4s	v18, v18, #4
sshr.4s	v0, v0, #4
sshr.4s	v19, v19, #4
sshr.4s	v1, v1, #4
saddw.4s	v18, v18, v2
saddw2.4s	v0, v0, v2
saddw.4s	v19, v19, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v18, v18, v0
uzp1.8h	v19, v19, v1
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
add.8h	v18, v18, v28
add.8h	v19, v19, v28
smin.8h	v18, v18, v31
smin.8h	v19, v19, v31
smax.8h	v18, v18, v30
smax.8h	v19, v19, v30
st1.8h	{ v16, v17, v18, v19 }, [x7], x1
b.le	w_avg_16bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v27
mul.4s	v0, v0, v27
mul.4s	v5, v5, v27
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #4
sshr.4s	v0, v0, #4
sshr.4s	v5, v5, #4
sshr.4s	v1, v1, #4
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	w_avg_16bpc_neon
ret
<unknown>
<unknown>
stllrb	w20, [sp]
_mask_16bpc_neon:
clz	w4, w4
dup.8h	v31, w7
movi.8h	v30, #0
clz	w7, w7
sub	w7, w7, #18
mov	w8, #8192
lsr	w8, w8, w7
neg	w7, w7
dup.8h	v28, w8
dup.8h	v29, w7
adr	x7, #2924
sub	w4, w4, #24
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
ldrh	w4, [x7, x4, lsl #1]
sub	x7, x7, w4, uxtw
br	x7
add	x7, x0, x1
lsl	x1, x1, #1
subs	w5, w5, #4
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x7], x1
st1.d	{ v5 }[0], [x0], x1
st1.d	{ v5 }[1], [x7], x1
b.le	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	mask_16bpc_neon
add	x7, x0, x1
lsl	x1, x1, #1
st1.8h	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v5 }, [x7], x1
b.le	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v24
mul.4s	v0, v0, v25
mul.4s	v7, v7, v26
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #6
sshr.4s	v0, v0, #6
sshr.4s	v7, v7, #6
sshr.4s	v1, v1, #6
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
st1.8h	{ v4, v5 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v6, v7 }, [x0], x1
b.le	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v24
mul.4s	v0, v0, v25
mul.4s	v7, v7, v26
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #6
sshr.4s	v0, v0, #6
sshr.4s	v7, v7, #6
sshr.4s	v1, v1, #6
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
subs	w5, w5, #1
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
b.le	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	mask_16bpc_neon
add	x7, x0, #64
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v24
mul.4s	v0, v0, v25
mul.4s	v7, v7, v26
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #6
sshr.4s	v0, v0, #6
sshr.4s	v7, v7, #6
sshr.4s	v1, v1, #6
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v16, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v17, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v16, v16, v24
mul.4s	v0, v0, v25
mul.4s	v17, v17, v26
mul.4s	v1, v1, v27
sshr.4s	v16, v16, #6
sshr.4s	v0, v0, #6
sshr.4s	v17, v17, #6
sshr.4s	v1, v1, #6
saddw.4s	v16, v16, v2
saddw2.4s	v0, v0, v2
saddw.4s	v17, v17, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v16, v16, v0
uzp1.8h	v17, v17, v1
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
add.8h	v16, v16, v28
add.8h	v17, v17, v28
smin.8h	v16, v16, v31
smin.8h	v17, v17, v31
smax.8h	v16, v16, v30
smax.8h	v17, v17, v30
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v18, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v19, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v18, v18, v24
mul.4s	v0, v0, v25
mul.4s	v19, v19, v26
mul.4s	v1, v1, v27
sshr.4s	v18, v18, #6
sshr.4s	v0, v0, #6
sshr.4s	v19, v19, #6
sshr.4s	v1, v1, #6
saddw.4s	v18, v18, v2
saddw2.4s	v0, v0, v2
saddw.4s	v19, v19, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v18, v18, v0
uzp1.8h	v19, v19, v1
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
add.8h	v18, v18, v28
add.8h	v19, v19, v28
smin.8h	v18, v18, v31
smin.8h	v19, v19, v31
smax.8h	v18, v18, v30
smax.8h	v19, v19, v30
subs	w5, w5, #1
st1.8h	{ v16, v17, v18, v19 }, [x7], x1
b.le	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	mask_16bpc_neon
add	x7, x0, #64
mov	x8, #128
sub	x1, x1, #128
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v24
mul.4s	v0, v0, v25
mul.4s	v7, v7, v26
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #6
sshr.4s	v0, v0, #6
sshr.4s	v7, v7, #6
sshr.4s	v1, v1, #6
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v16, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v17, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v16, v16, v24
mul.4s	v0, v0, v25
mul.4s	v17, v17, v26
mul.4s	v1, v1, v27
sshr.4s	v16, v16, #6
sshr.4s	v0, v0, #6
sshr.4s	v17, v17, #6
sshr.4s	v1, v1, #6
saddw.4s	v16, v16, v2
saddw2.4s	v0, v0, v2
saddw.4s	v17, v17, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v16, v16, v0
uzp1.8h	v17, v17, v1
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
add.8h	v16, v16, v28
add.8h	v17, v17, v28
smin.8h	v16, v16, v31
smin.8h	v17, v17, v31
smax.8h	v16, v16, v30
smax.8h	v17, v17, v30
st1.8h	{ v4, v5, v6, v7 }, [x0], x8
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v18, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v19, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v18, v18, v24
mul.4s	v0, v0, v25
mul.4s	v19, v19, v26
mul.4s	v1, v1, v27
sshr.4s	v18, v18, #6
sshr.4s	v0, v0, #6
sshr.4s	v19, v19, #6
sshr.4s	v1, v1, #6
saddw.4s	v18, v18, v2
saddw2.4s	v0, v0, v2
saddw.4s	v19, v19, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v18, v18, v0
uzp1.8h	v19, v19, v1
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
add.8h	v18, v18, v28
add.8h	v19, v19, v28
smin.8h	v18, v18, v31
smin.8h	v19, v19, v31
smax.8h	v18, v18, v30
smax.8h	v19, v19, v30
st1.8h	{ v16, v17, v18, v19 }, [x7], x8
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v6, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v7, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v6, v6, v24
mul.4s	v0, v0, v25
mul.4s	v7, v7, v26
mul.4s	v1, v1, v27
sshr.4s	v6, v6, #6
sshr.4s	v0, v0, #6
sshr.4s	v7, v7, #6
sshr.4s	v1, v1, #6
saddw.4s	v6, v6, v2
saddw2.4s	v0, v0, v2
saddw.4s	v7, v7, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v6, v6, v0
uzp1.8h	v7, v7, v1
srshl.8h	v6, v6, v29
srshl.8h	v7, v7, v29
add.8h	v6, v6, v28
add.8h	v7, v7, v28
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
smax.8h	v6, v6, v30
smax.8h	v7, v7, v30
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v16, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v17, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v16, v16, v24
mul.4s	v0, v0, v25
mul.4s	v17, v17, v26
mul.4s	v1, v1, v27
sshr.4s	v16, v16, #6
sshr.4s	v0, v0, #6
sshr.4s	v17, v17, #6
sshr.4s	v1, v1, #6
saddw.4s	v16, v16, v2
saddw2.4s	v0, v0, v2
saddw.4s	v17, v17, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v16, v16, v0
uzp1.8h	v17, v17, v1
srshl.8h	v16, v16, v29
srshl.8h	v17, v17, v29
add.8h	v16, v16, v28
add.8h	v17, v17, v28
smin.8h	v16, v16, v31
smin.8h	v17, v17, v31
smax.8h	v16, v16, v30
smax.8h	v17, v17, v30
subs	w5, w5, #1
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v18, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v19, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v18, v18, v24
mul.4s	v0, v0, v25
mul.4s	v19, v19, v26
mul.4s	v1, v1, v27
sshr.4s	v18, v18, #6
sshr.4s	v0, v0, #6
sshr.4s	v19, v19, #6
sshr.4s	v1, v1, #6
saddw.4s	v18, v18, v2
saddw2.4s	v0, v0, v2
saddw.4s	v19, v19, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v18, v18, v0
uzp1.8h	v19, v19, v1
srshl.8h	v18, v18, v29
srshl.8h	v19, v19, v29
add.8h	v18, v18, v28
add.8h	v19, v19, v28
smin.8h	v18, v18, v31
smin.8h	v19, v19, v31
smax.8h	v18, v18, v30
smax.8h	v19, v19, v30
st1.8h	{ v16, v17, v18, v19 }, [x7], x1
b.le	mask_16bpc_neon
ld1.16b	{ v27 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
neg.16b	v27, v27
ld1.8h	{ v2, v3 }, [x3], #32
sshll.8h	v26, v27, #0
sshll2.8h	v27, v27, #0
sshll.4s	v24, v26, #0
sshll2.4s	v25, v26, #0
sshll.4s	v26, v27, #0
sshll2.4s	v27, v27, #0
ssubl.4s	v4, v2, v0
ssubl2.4s	v0, v2, v0
ssubl.4s	v5, v3, v1
ssubl2.4s	v1, v3, v1
mul.4s	v4, v4, v24
mul.4s	v0, v0, v25
mul.4s	v5, v5, v26
mul.4s	v1, v1, v27
sshr.4s	v4, v4, #6
sshr.4s	v0, v0, #6
sshr.4s	v5, v5, #6
sshr.4s	v1, v1, #6
saddw.4s	v4, v4, v2
saddw2.4s	v0, v0, v2
saddw.4s	v5, v5, v3
saddw2.4s	v1, v1, v3
uzp1.8h	v4, v4, v0
uzp1.8h	v5, v5, v1
srshl.8h	v4, v4, v29
srshl.8h	v5, v5, v29
add.8h	v4, v4, v28
add.8h	v5, v5, v28
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
b	mask_16bpc_neon
ret
<unknown>
<unknown>
and	w20, w16, w8, ror #2
_w_mask_444_16bpc_neon:
ldr	w8, [sp]
clz	w9, w4
adr	x10, #856
dup.8h	v31, w8
sub	w9, w9, #24
clz	w8, w8
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
sub	w8, w8, #12
mov	w9, #524288
neg	w8, w8
mov	w11, #27615
dup.4s	v30, w9
dup.4s	v29, w8
dup.8h	v0, w11
movi.16b	v1, #64
add	x12, x0, x1
lsl	x1, x1, #1
br	x10
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #4
sabd.8h	v20, v4, v6
sabd.8h	v21, v5, v7
ssubl.4s	v16, v6, v4
ssubl2.4s	v17, v6, v4
ssubl.4s	v18, v7, v5
ssubl2.4s	v19, v7, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v7, v5, #6
sshll.4s	v6, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v6, v6, v30
add.4s	v7, v7, v30
ushll.4s	v22, v20, #0
ushll2.4s	v23, v20, #0
ushll.4s	v24, v21, #0
ushll2.4s	v25, v21, #0
mla.4s	v4, v16, v22
mla.4s	v5, v17, v23
mla.4s	v6, v18, v24
mla.4s	v7, v19, v25
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v6, v6, v29
srshl.4s	v7, v7, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v6
sqxtun2.8h	v5, v7
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
uzp1.16b	v20, v20, v21
sub.16b	v20, v1, v20
st1.16b	{ v20 }, [x6], #16
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x12], x1
st1.d	{ v5 }[0], [x0], x1
st1.d	{ v5 }[1], [x12], x1
b.gt	w_mask_444_16bpc_neon
ret
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #2
sabd.8h	v20, v4, v6
sabd.8h	v21, v5, v7
ssubl.4s	v16, v6, v4
ssubl2.4s	v17, v6, v4
ssubl.4s	v18, v7, v5
ssubl2.4s	v19, v7, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v7, v5, #6
sshll.4s	v6, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v6, v6, v30
add.4s	v7, v7, v30
ushll.4s	v22, v20, #0
ushll2.4s	v23, v20, #0
ushll.4s	v24, v21, #0
ushll2.4s	v25, v21, #0
mla.4s	v4, v16, v22
mla.4s	v5, v17, v23
mla.4s	v6, v18, v24
mla.4s	v7, v19, v25
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v6, v6, v29
srshl.4s	v7, v7, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v6
sqxtun2.8h	v5, v7
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
uzp1.16b	v20, v20, v21
sub.16b	v20, v1, v20
st1.16b	{ v20 }, [x6], #16
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v5 }, [x12], x1
b.gt	w_mask_444_16bpc_neon
ret
mov	w11, w4
sub	x1, x1, w4, uxtw #1
add	x10, x6, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
mov	w8, w4
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v16, v17 }, [x3], #32
ld1.8h	{ v6, v7 }, [x7], #32
ld1.8h	{ v18, v19 }, [x9], #32
subs	w8, w8, #16
sabd.8h	v20, v4, v16
sabd.8h	v21, v5, v17
ssubl.4s	v22, v16, v4
ssubl2.4s	v23, v16, v4
ssubl.4s	v24, v17, v5
ssubl2.4s	v25, v17, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v27, v5, #6
sshll.4s	v26, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v26, v26, v30
add.4s	v27, v27, v30
ushll.4s	v16, v20, #0
ushll2.4s	v17, v20, #0
ushll.4s	v28, v21, #0
mla.4s	v4, v22, v16
ushll2.4s	v16, v21, #0
mla.4s	v5, v23, v17
mla.4s	v26, v24, v28
mla.4s	v27, v25, v16
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v26, v26, v29
srshl.4s	v27, v27, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v26
sqxtun2.8h	v5, v27
sabd.8h	v22, v6, v18
sabd.8h	v23, v7, v19
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
ssubl.4s	v16, v18, v6
ssubl2.4s	v17, v18, v6
ssubl.4s	v18, v19, v7
ssubl2.4s	v19, v19, v7
uqsub.8h	v22, v0, v22
uqsub.8h	v23, v0, v23
sshll.4s	v24, v6, #6
sshll2.4s	v25, v6, #6
sshll.4s	v26, v7, #6
sshll2.4s	v27, v7, #6
ushr.8h	v22, v22, #10
ushr.8h	v23, v23, #10
add.4s	v24, v24, v30
add.4s	v25, v25, v30
add.4s	v26, v26, v30
add.4s	v27, v27, v30
ushll.4s	v6, v22, #0
ushll2.4s	v7, v22, #0
ushll.4s	v28, v23, #0
mla.4s	v24, v16, v6
ushll2.4s	v6, v23, #0
mla.4s	v25, v17, v7
mla.4s	v26, v18, v28
mla.4s	v27, v19, v6
srshl.4s	v24, v24, v29
srshl.4s	v25, v25, v29
srshl.4s	v26, v26, v29
srshl.4s	v27, v27, v29
sqxtun.4h	v6, v24
sqxtun2.8h	v6, v25
sqxtun.4h	v7, v26
sqxtun2.8h	v7, v27
umin.8h	v6, v6, v31
umin.8h	v7, v7, v31
uzp1.16b	v20, v20, v21
uzp1.16b	v21, v22, v23
sub.16b	v20, v1, v20
sub.16b	v21, v1, v21
st1.16b	{ v20 }, [x6], #16
st1.16b	{ v21 }, [x10], #16
st1.8h	{ v4, v5 }, [x0], #32
st1.8h	{ v6, v7 }, [x12], #32
b.gt	w_mask_444_16bpc_neon
subs	w5, w5, #2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, w4, uxtw
add	x10, x10, w4, uxtw
add	x0, x0, x1
add	x12, x12, x1
b.gt	w_mask_444_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
_w_mask_422_16bpc_neon:
ldr	w8, [sp]
clz	w9, w4
adr	x10, #880
dup.8h	v31, w8
sub	w9, w9, #24
clz	w8, w8
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
sub	w8, w8, #12
mov	w9, #524288
neg	w8, w8
mov	w11, #27615
dup.4s	v30, w9
dup.4s	v29, w8
dup.8h	v0, w11
dup.8b	v2, w7
movi.8b	v3, #129
sub.8b	v3, v3, v2
add	x12, x0, x1
lsl	x1, x1, #1
br	x10
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #4
sabd.8h	v20, v4, v6
sabd.8h	v21, v5, v7
ssubl.4s	v16, v6, v4
ssubl2.4s	v17, v6, v4
ssubl.4s	v18, v7, v5
ssubl2.4s	v19, v7, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v7, v5, #6
sshll.4s	v6, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v6, v6, v30
add.4s	v7, v7, v30
ushll.4s	v22, v20, #0
ushll2.4s	v23, v20, #0
ushll.4s	v24, v21, #0
ushll2.4s	v25, v21, #0
mla.4s	v4, v16, v22
mla.4s	v5, v17, v23
mla.4s	v6, v18, v24
mla.4s	v7, v19, v25
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v6, v6, v29
srshl.4s	v7, v7, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v6
sqxtun2.8h	v5, v7
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
addp.8h	v20, v20, v21
xtn.8b	v20, v20
uhsub.8b	v20, v3, v20
st1.8b	{ v20 }, [x6], #8
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x12], x1
st1.d	{ v5 }[0], [x0], x1
st1.d	{ v5 }[1], [x12], x1
b.gt	w_mask_422_16bpc_neon
ret
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #2
sabd.8h	v20, v4, v6
sabd.8h	v21, v5, v7
ssubl.4s	v16, v6, v4
ssubl2.4s	v17, v6, v4
ssubl.4s	v18, v7, v5
ssubl2.4s	v19, v7, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v7, v5, #6
sshll.4s	v6, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v6, v6, v30
add.4s	v7, v7, v30
ushll.4s	v22, v20, #0
ushll2.4s	v23, v20, #0
ushll.4s	v24, v21, #0
ushll2.4s	v25, v21, #0
mla.4s	v4, v16, v22
mla.4s	v5, v17, v23
mla.4s	v6, v18, v24
mla.4s	v7, v19, v25
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v6, v6, v29
srshl.4s	v7, v7, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v6
sqxtun2.8h	v5, v7
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
addp.8h	v20, v20, v21
xtn.8b	v20, v20
uhsub.8b	v20, v3, v20
st1.8b	{ v20 }, [x6], #8
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v5 }, [x12], x1
b.gt	w_mask_422_16bpc_neon
ret
mov	w11, w4
sub	x1, x1, w4, uxtw #1
add	x10, x6, x11, lsr #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
mov	w8, w4
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v16, v17 }, [x3], #32
ld1.8h	{ v6, v7 }, [x7], #32
ld1.8h	{ v18, v19 }, [x9], #32
subs	w8, w8, #16
sabd.8h	v20, v4, v16
sabd.8h	v21, v5, v17
ssubl.4s	v22, v16, v4
ssubl2.4s	v23, v16, v4
ssubl.4s	v24, v17, v5
ssubl2.4s	v25, v17, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v27, v5, #6
sshll.4s	v26, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v26, v26, v30
add.4s	v27, v27, v30
ushll.4s	v16, v20, #0
ushll2.4s	v17, v20, #0
ushll.4s	v28, v21, #0
mla.4s	v4, v22, v16
ushll2.4s	v16, v21, #0
mla.4s	v5, v23, v17
mla.4s	v26, v24, v28
mla.4s	v27, v25, v16
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v26, v26, v29
srshl.4s	v27, v27, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v26
sqxtun2.8h	v5, v27
sabd.8h	v22, v6, v18
sabd.8h	v23, v7, v19
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
ssubl.4s	v16, v18, v6
ssubl2.4s	v17, v18, v6
ssubl.4s	v18, v19, v7
ssubl2.4s	v19, v19, v7
uqsub.8h	v22, v0, v22
uqsub.8h	v23, v0, v23
sshll.4s	v24, v6, #6
sshll2.4s	v25, v6, #6
sshll.4s	v26, v7, #6
sshll2.4s	v27, v7, #6
ushr.8h	v22, v22, #10
ushr.8h	v23, v23, #10
add.4s	v24, v24, v30
add.4s	v25, v25, v30
add.4s	v26, v26, v30
add.4s	v27, v27, v30
ushll.4s	v6, v22, #0
ushll2.4s	v7, v22, #0
ushll.4s	v28, v23, #0
mla.4s	v24, v16, v6
ushll2.4s	v6, v23, #0
mla.4s	v25, v17, v7
mla.4s	v26, v18, v28
mla.4s	v27, v19, v6
srshl.4s	v24, v24, v29
srshl.4s	v25, v25, v29
srshl.4s	v26, v26, v29
srshl.4s	v27, v27, v29
sqxtun.4h	v6, v24
sqxtun2.8h	v6, v25
sqxtun.4h	v7, v26
sqxtun2.8h	v7, v27
umin.8h	v6, v6, v31
umin.8h	v7, v7, v31
addp.8h	v20, v20, v21
addp.8h	v21, v22, v23
xtn.8b	v20, v20
xtn.8b	v21, v21
uhsub.8b	v20, v3, v20
uhsub.8b	v21, v3, v21
st1.8b	{ v20 }, [x6], #8
st1.8b	{ v21 }, [x10], #8
st1.8h	{ v4, v5 }, [x0], #32
st1.8h	{ v6, v7 }, [x12], #32
b.gt	w_mask_422_16bpc_neon
subs	w5, w5, #2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, x11, lsr #1
add	x10, x10, x11, lsr #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	w_mask_422_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
_w_mask_420_16bpc_neon:
ldr	w8, [sp]
clz	w9, w4
adr	x10, #876
dup.8h	v31, w8
sub	w9, w9, #24
clz	w8, w8
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
sub	w8, w8, #12
mov	w9, #524288
neg	w8, w8
mov	w11, #27615
dup.4s	v30, w9
dup.4s	v29, w8
dup.8h	v0, w11
dup.8h	v2, w7
movi.8h	v3, #1, lsl #8
sub.8h	v3, v3, v2
add	x12, x0, x1
lsl	x1, x1, #1
br	x10
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #4
sabd.8h	v20, v4, v6
sabd.8h	v21, v5, v7
ssubl.4s	v16, v6, v4
ssubl2.4s	v17, v6, v4
ssubl.4s	v18, v7, v5
ssubl2.4s	v19, v7, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v7, v5, #6
sshll.4s	v6, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v6, v6, v30
add.4s	v7, v7, v30
ushll.4s	v22, v20, #0
ushll2.4s	v23, v20, #0
ushll.4s	v24, v21, #0
ushll2.4s	v25, v21, #0
mla.4s	v4, v16, v22
mla.4s	v5, v17, v23
mla.4s	v6, v18, v24
mla.4s	v7, v19, v25
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v6, v6, v29
srshl.4s	v7, v7, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v6
sqxtun2.8h	v5, v7
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
trn1.2d	v24, v20, v21
trn2.2d	v25, v20, v21
add.8h	v24, v24, v25
addp.8h	v20, v24, v24
sub.4h	v20, v3, v20
rshrn.8b	v20, v20, #2
st1.s	{ v20 }[0], [x6], #4
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x12], x1
st1.d	{ v5 }[0], [x0], x1
st1.d	{ v5 }[1], [x12], x1
b.gt	w_mask_420_16bpc_neon
ret
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #2
sabd.8h	v20, v4, v6
sabd.8h	v21, v5, v7
ssubl.4s	v16, v6, v4
ssubl2.4s	v17, v6, v4
ssubl.4s	v18, v7, v5
ssubl2.4s	v19, v7, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v7, v5, #6
sshll.4s	v6, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v6, v6, v30
add.4s	v7, v7, v30
ushll.4s	v22, v20, #0
ushll2.4s	v23, v20, #0
ushll.4s	v24, v21, #0
ushll2.4s	v25, v21, #0
mla.4s	v4, v16, v22
mla.4s	v5, v17, v23
mla.4s	v6, v18, v24
mla.4s	v7, v19, v25
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v6, v6, v29
srshl.4s	v7, v7, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v6
sqxtun2.8h	v5, v7
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
add.8h	v20, v20, v21
addp.8h	v20, v20, v20
sub.4h	v20, v3, v20
rshrn.8b	v20, v20, #2
st1.s	{ v20 }[0], [x6], #4
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v5 }, [x12], x1
b.gt	w_mask_420_16bpc_neon
ret
mov	w11, w4
sub	x1, x1, w4, uxtw #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
mov	w8, w4
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v16, v17 }, [x3], #32
ld1.8h	{ v6, v7 }, [x7], #32
ld1.8h	{ v18, v19 }, [x9], #32
subs	w8, w8, #16
sabd.8h	v20, v4, v16
sabd.8h	v21, v5, v17
ssubl.4s	v22, v16, v4
ssubl2.4s	v23, v16, v4
ssubl.4s	v24, v17, v5
ssubl2.4s	v25, v17, v5
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
sshll2.4s	v27, v5, #6
sshll.4s	v26, v5, #6
sshll2.4s	v5, v4, #6
sshll.4s	v4, v4, #6
ushr.8h	v20, v20, #10
ushr.8h	v21, v21, #10
add.4s	v4, v4, v30
add.4s	v5, v5, v30
add.4s	v26, v26, v30
add.4s	v27, v27, v30
ushll.4s	v16, v20, #0
ushll2.4s	v17, v20, #0
ushll.4s	v28, v21, #0
mla.4s	v4, v22, v16
ushll2.4s	v16, v21, #0
mla.4s	v5, v23, v17
mla.4s	v26, v24, v28
mla.4s	v27, v25, v16
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
srshl.4s	v26, v26, v29
srshl.4s	v27, v27, v29
sqxtun.4h	v4, v4
sqxtun2.8h	v4, v5
sqxtun.4h	v5, v26
sqxtun2.8h	v5, v27
sabd.8h	v22, v6, v18
sabd.8h	v23, v7, v19
umin.8h	v4, v4, v31
umin.8h	v5, v5, v31
ssubl.4s	v16, v18, v6
ssubl2.4s	v17, v18, v6
ssubl.4s	v18, v19, v7
ssubl2.4s	v19, v19, v7
uqsub.8h	v22, v0, v22
uqsub.8h	v23, v0, v23
sshll.4s	v24, v6, #6
sshll2.4s	v25, v6, #6
sshll.4s	v26, v7, #6
sshll2.4s	v27, v7, #6
ushr.8h	v22, v22, #10
ushr.8h	v23, v23, #10
add.4s	v24, v24, v30
add.4s	v25, v25, v30
add.4s	v26, v26, v30
add.4s	v27, v27, v30
ushll.4s	v6, v22, #0
ushll2.4s	v7, v22, #0
ushll.4s	v28, v23, #0
mla.4s	v24, v16, v6
ushll2.4s	v6, v23, #0
mla.4s	v25, v17, v7
mla.4s	v26, v18, v28
mla.4s	v27, v19, v6
srshl.4s	v24, v24, v29
srshl.4s	v25, v25, v29
srshl.4s	v26, v26, v29
srshl.4s	v27, v27, v29
sqxtun.4h	v6, v24
sqxtun2.8h	v6, v25
sqxtun.4h	v7, v26
sqxtun2.8h	v7, v27
umin.8h	v6, v6, v31
umin.8h	v7, v7, v31
add.8h	v20, v20, v22
add.8h	v21, v21, v23
addp.8h	v20, v20, v21
sub.8h	v20, v3, v20
rshrn.8b	v20, v20, #2
st1.8b	{ v20 }, [x6], #8
st1.8h	{ v4, v5 }, [x0], #32
st1.8h	{ v6, v7 }, [x12], #32
b.gt	w_mask_420_16bpc_neon
subs	w5, w5, #2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	w_mask_420_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
_blend_16bpc_neon:
adr	x6, #420
clz	w3, w3
sub	w3, w3, #26
ldrh	w3, [x6, x3, lsl #1]
sub	x6, x6, w3, uxtw
add	x8, x0, x1
br	x6
lsl	x1, x1, #1
ld1.8b	{ v2 }, [x5], #8
ld1.8h	{ v1 }, [x2], #16
ld1.d	{ v0 }[0], [x0]
neg.8b	v2, v2
subs	w4, w4, #2
ld1.d	{ v0 }[1], [x8]
sshll.8h	v2, v2, #0
shl.8h	v2, v2, #9
sub.8h	v1, v0, v1
sqrdmulh.8h	v1, v1, v2
add.8h	v0, v0, v1
st1.d	{ v0 }[0], [x0], x1
st1.d	{ v0 }[1], [x8], x1
b.gt	blend_16bpc_neon
ret
lsl	x1, x1, #1
ld1.16b	{ v4 }, [x5], #16
ld1.8h	{ v2, v3 }, [x2], #32
neg.16b	v5, v4
ld1.8h	{ v0 }, [x0]
ld1.8h	{ v1 }, [x8]
sshll.8h	v4, v5, #0
sshll2.8h	v5, v5, #0
shl.8h	v4, v4, #9
shl.8h	v5, v5, #9
sub.8h	v2, v0, v2
sub.8h	v3, v1, v3
subs	w4, w4, #2
sqrdmulh.8h	v2, v2, v4
sqrdmulh.8h	v3, v3, v5
add.8h	v0, v0, v2
add.8h	v1, v1, v3
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v1 }, [x8], x1
b.gt	blend_16bpc_neon
ret
lsl	x1, x1, #1
ld1.16b	{ v16, v17 }, [x5], #32
ld1.8h	{ v4, v5, v6, v7 }, [x2], #64
subs	w4, w4, #2
neg.16b	v18, v16
neg.16b	v19, v17
ld1.8h	{ v0, v1 }, [x0]
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
ld1.8h	{ v2, v3 }, [x8]
shl.8h	v16, v16, #9
shl.8h	v17, v17, #9
shl.8h	v18, v18, #9
shl.8h	v19, v19, #9
sub.8h	v4, v0, v4
sub.8h	v5, v1, v5
sub.8h	v6, v2, v6
sub.8h	v7, v3, v7
sqrdmulh.8h	v4, v4, v16
sqrdmulh.8h	v5, v5, v17
sqrdmulh.8h	v6, v6, v18
sqrdmulh.8h	v7, v7, v19
add.8h	v0, v0, v4
add.8h	v1, v1, v5
add.8h	v2, v2, v6
add.8h	v3, v3, v7
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v2, v3 }, [x8], x1
b.gt	blend_16bpc_neon
ret
ld1.16b	{ v16, v17 }, [x5], #32
ld1.8h	{ v4, v5, v6, v7 }, [x2], #64
subs	w4, w4, #1
neg.16b	v18, v16
neg.16b	v19, v17
sshll.8h	v16, v18, #0
sshll2.8h	v17, v18, #0
sshll.8h	v18, v19, #0
sshll2.8h	v19, v19, #0
ld1.8h	{ v0, v1, v2, v3 }, [x0]
shl.8h	v16, v16, #9
shl.8h	v17, v17, #9
shl.8h	v18, v18, #9
shl.8h	v19, v19, #9
sub.8h	v4, v0, v4
sub.8h	v5, v1, v5
sub.8h	v6, v2, v6
sub.8h	v7, v3, v7
sqrdmulh.8h	v4, v4, v16
sqrdmulh.8h	v5, v5, v17
sqrdmulh.8h	v6, v6, v18
sqrdmulh.8h	v7, v7, v19
add.8h	v0, v0, v4
add.8h	v1, v1, v5
add.8h	v2, v2, v6
add.8h	v3, v3, v7
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
b.gt	blend_16bpc_neon
ret
<unknown>
<unknown>
_blend_h_16bpc_neon:
adr	x6, #564
adrp	x5, blend_h_16bpc_neon
add	x5, x5, #0
add	x5, x5, w4, uxtw
sub	w4, w4, w4, lsr #2
clz	w7, w3
add	x8, x0, x1
lsl	x1, x1, #1
sub	w7, w7, #24
ldrh	w7, [x6, x7, lsl #1]
sub	x6, x6, w7, uxtw
br	x6
ld2r.8b	{ v2, v3 }, [x5], #2
ld1.4h	{ v1 }, [x2], #8
ext.8b	v2, v2, v3, #6
subs	w4, w4, #2
neg.8b	v2, v2
ld1.s	{ v0 }[0], [x0]
ld1.s	{ v0 }[1], [x8]
sshll.8h	v2, v2, #0
shl.4h	v2, v2, #9
sub.4h	v1, v0, v1
sqrdmulh.4h	v1, v1, v2
add.4h	v0, v0, v1
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[1], [x8], x1
b.gt	blend_h_16bpc_neon
ret
ld2r.8b	{ v2, v3 }, [x5], #2
ld1.8h	{ v1 }, [x2], #16
ext.8b	v2, v2, v3, #4
subs	w4, w4, #2
neg.8b	v2, v2
ld1.d	{ v0 }[0], [x0]
ld1.d	{ v0 }[1], [x8]
sshll.8h	v2, v2, #0
shl.8h	v2, v2, #9
sub.8h	v1, v0, v1
sqrdmulh.8h	v1, v1, v2
add.8h	v0, v0, v1
st1.d	{ v0 }[0], [x0], x1
st1.d	{ v0 }[1], [x8], x1
b.gt	blend_h_16bpc_neon
ret
ld2r.8b	{ v4, v5 }, [x5], #2
ld1.8h	{ v2, v3 }, [x2], #32
neg.8b	v4, v4
neg.8b	v5, v5
ld1.8h	{ v0 }, [x0]
subs	w4, w4, #2
sshll.8h	v4, v4, #0
sshll.8h	v5, v5, #0
ld1.8h	{ v1 }, [x8]
shl.8h	v4, v4, #9
shl.8h	v5, v5, #9
sub.8h	v2, v0, v2
sub.8h	v3, v1, v3
sqrdmulh.8h	v2, v2, v4
sqrdmulh.8h	v3, v3, v5
add.8h	v0, v0, v2
add.8h	v1, v1, v3
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v1 }, [x8], x1
b.gt	blend_h_16bpc_neon
ret
ld2r.8b	{ v16, v17 }, [x5], #2
ld1.8h	{ v4, v5, v6, v7 }, [x2], #64
neg.8b	v16, v16
neg.8b	v17, v17
ld1.8h	{ v0, v1 }, [x0]
ld1.8h	{ v2, v3 }, [x8]
subs	w4, w4, #2
sshll.8h	v16, v16, #0
sshll.8h	v17, v17, #0
shl.8h	v16, v16, #9
shl.8h	v17, v17, #9
sub.8h	v4, v0, v4
sub.8h	v5, v1, v5
sub.8h	v6, v2, v6
sub.8h	v7, v3, v7
sqrdmulh.8h	v4, v4, v16
sqrdmulh.8h	v5, v5, v16
sqrdmulh.8h	v6, v6, v17
sqrdmulh.8h	v7, v7, v17
add.8h	v0, v0, v4
add.8h	v1, v1, v5
add.8h	v2, v2, v6
add.8h	v3, v3, v7
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v2, v3 }, [x8], x1
b.gt	blend_h_16bpc_neon
ret
sub	x1, x1, w3, uxtw #1
add	x7, x2, w3, uxtw #1
ld2r.8b	{ v24, v25 }, [x5], #2
mov	w6, w3
neg.8b	v24, v24
neg.8b	v25, v25
sshll.8h	v24, v24, #0
sshll.8h	v25, v25, #0
shl.8h	v24, v24, #9
shl.8h	v25, v25, #9
ld1.8h	{ v16, v17, v18, v19 }, [x2], #64
ld1.8h	{ v0, v1, v2, v3 }, [x0]
subs	w6, w6, #32
sub.8h	v16, v0, v16
sub.8h	v17, v1, v17
sub.8h	v18, v2, v18
sub.8h	v19, v3, v19
ld1.8h	{ v20, v21, v22, v23 }, [x7], #64
ld1.8h	{ v4, v5, v6, v7 }, [x8]
sqrdmulh.8h	v16, v16, v24
sqrdmulh.8h	v17, v17, v24
sqrdmulh.8h	v18, v18, v24
sqrdmulh.8h	v19, v19, v24
sub.8h	v20, v4, v20
sub.8h	v21, v5, v21
sub.8h	v22, v6, v22
sub.8h	v23, v7, v23
add.8h	v0, v0, v16
add.8h	v1, v1, v17
add.8h	v2, v2, v18
add.8h	v3, v3, v19
sqrdmulh.8h	v20, v20, v25
sqrdmulh.8h	v21, v21, v25
sqrdmulh.8h	v22, v22, v25
sqrdmulh.8h	v23, v23, v25
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v4, v4, v20
add.8h	v5, v5, v21
add.8h	v6, v6, v22
add.8h	v7, v7, v23
st1.8h	{ v4, v5, v6, v7 }, [x8], #64
b.gt	blend_h_16bpc_neon
subs	w4, w4, #2
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, w3, uxtw #1
add	x7, x7, w3, uxtw #1
b.gt	blend_h_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#516
_blend_v_16bpc_neon:
adr	x6, #528
adrp	x5, blend_v_16bpc_neon
add	x5, x5, #0
add	x5, x5, w3, uxtw
clz	w3, w3
add	x8, x0, x1
lsl	x1, x1, #1
sub	w3, w3, #26
ldrh	w3, [x6, x3, lsl #1]
sub	x6, x6, w3, uxtw
br	x6
ld1r.8b	{ v2 }, [x5]
neg.8b	v2, v2
sshll.8h	v2, v2, #0
shl.4h	v2, v2, #9
ld1.s	{ v1 }[0], [x2], #4
ld1.h	{ v0 }[0], [x0]
subs	w4, w4, #2
ld1.h	{ v1 }[1], [x2]
ld1.h	{ v0 }[1], [x8]
add	x2, x2, #4
sub.4h	v1, v0, v1
sqrdmulh.4h	v1, v1, v2
add.4h	v0, v0, v1
st1.h	{ v0 }[0], [x0], x1
st1.h	{ v0 }[1], [x8], x1
b.gt	blend_v_16bpc_neon
ret
ld1r.2s	{ v2 }, [x5]
sub	x1, x1, #4
neg.8b	v2, v2
sshll.8h	v2, v2, #0
shl.8h	v2, v2, #9
ld1.8h	{ v1 }, [x2], #16
ld1.d	{ v0 }[0], [x0]
ld1.d	{ v0 }[1], [x8]
subs	w4, w4, #2
sub.8h	v1, v0, v1
sqrdmulh.8h	v1, v1, v2
add.8h	v0, v0, v1
st1.s	{ v0 }[0], [x0], #4
st1.s	{ v0 }[2], [x8], #4
st1.h	{ v0 }[2], [x0], x1
st1.h	{ v0 }[6], [x8], x1
b.gt	blend_v_16bpc_neon
ret
ld1.8b	{ v4 }, [x5]
sub	x1, x1, #8
neg.8b	v4, v4
sshll.8h	v4, v4, #0
shl.8h	v4, v4, #9
ld1.8h	{ v2, v3 }, [x2], #32
ld1.8h	{ v0 }, [x0]
ld1.8h	{ v1 }, [x8]
subs	w4, w4, #2
sub.8h	v2, v0, v2
sub.8h	v3, v1, v3
sqrdmulh.8h	v2, v2, v4
sqrdmulh.8h	v3, v3, v4
add.8h	v0, v0, v2
add.8h	v1, v1, v3
st1.d	{ v0 }[0], [x0], #8
st1.d	{ v1 }[0], [x8], #8
st1.s	{ v0 }[2], [x0], x1
st1.s	{ v1 }[2], [x8], x1
b.gt	blend_v_16bpc_neon
ret
ld1.16b	{ v16 }, [x5]
sub	x1, x1, #16
neg.16b	v17, v16
sshll.8h	v16, v17, #0
sshll2.8h	v17, v17, #0
shl.8h	v16, v16, #9
shl.4h	v17, v17, #9
ld1.8h	{ v4, v5, v6, v7 }, [x2], #64
ld1.8h	{ v0, v1 }, [x0]
subs	w4, w4, #2
ld1.8h	{ v2, v3 }, [x8]
sub.8h	v4, v0, v4
sub.4h	v5, v1, v5
sub.8h	v6, v2, v6
sub.4h	v7, v3, v7
sqrdmulh.8h	v4, v4, v16
sqrdmulh.4h	v5, v5, v17
sqrdmulh.8h	v6, v6, v16
sqrdmulh.4h	v7, v7, v17
add.8h	v0, v0, v4
add.4h	v1, v1, v5
add.8h	v2, v2, v6
add.4h	v3, v3, v7
st1.8h	{ v0 }, [x0], #16
st1.8h	{ v2 }, [x8], #16
st1.4h	{ v1 }, [x0], x1
st1.4h	{ v3 }, [x8], x1
b.gt	blend_v_16bpc_neon
ret
ld1.16b	{ v24, v25 }, [x5]
neg.16b	v26, v24
neg.8b	v27, v25
sshll.8h	v24, v26, #0
sshll2.8h	v25, v26, #0
sshll.8h	v26, v27, #0
shl.8h	v24, v24, #9
shl.8h	v25, v25, #9
shl.8h	v26, v26, #9
ld1.8h	{ v16, v17, v18, v19 }, [x2], #64
ld1.8h	{ v0, v1, v2 }, [x0]
ld1.8h	{ v20, v21, v22, v23 }, [x2], #64
ld1.8h	{ v4, v5, v6 }, [x8]
subs	w4, w4, #2
sub.8h	v16, v0, v16
sub.8h	v17, v1, v17
sub.8h	v18, v2, v18
sub.8h	v20, v4, v20
sub.8h	v21, v5, v21
sub.8h	v22, v6, v22
sqrdmulh.8h	v16, v16, v24
sqrdmulh.8h	v17, v17, v25
sqrdmulh.8h	v18, v18, v26
sqrdmulh.8h	v20, v20, v24
sqrdmulh.8h	v21, v21, v25
sqrdmulh.8h	v22, v22, v26
add.8h	v0, v0, v16
add.8h	v1, v1, v17
add.8h	v2, v2, v18
add.8h	v4, v4, v20
add.8h	v5, v5, v21
add.8h	v6, v6, v22
st1.8h	{ v0, v1, v2 }, [x0], x1
st1.8h	{ v4, v5, v6 }, [x8], x1
b.gt	blend_v_16bpc_neon
ret
<unknown>
<unknown>
udf	#484
_put_neon:
adr	x10, #340
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
br	x10
ld1.s	{ v0 }[0], [x2], x3
ld1.s	{ v1 }[0], [x2], x3
subs	w5, w5, #2
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v1 }[0], [x0], x1
b.gt	put_neon
ret
ld1.4h	{ v0 }, [x2], x3
ld1.4h	{ v1 }, [x2], x3
subs	w5, w5, #2
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v1 }, [x0], x1
b.gt	put_neon
ret
add	x8, x0, x1
lsl	x1, x1, #1
add	x9, x2, x3
lsl	x3, x3, #1
ld1.8h	{ v0 }, [x2], x3
ld1.8h	{ v1 }, [x9], x3
subs	w5, w5, #2
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v1 }, [x8], x1
b.gt	put_neon
ret
ldp	x6, x7, [x2]
ldp	x8, x9, [x2, #16]
stp	x6, x7, [x0]
subs	w5, w5, #1
stp	x8, x9, [x0, #16]
add	x2, x2, x3
add	x0, x0, x1
b.gt	put_neon
ret
ldp	x6, x7, [x2]
ldp	x8, x9, [x2, #16]
stp	x6, x7, [x0]
ldp	x10, x11, [x2, #32]
stp	x8, x9, [x0, #16]
subs	w5, w5, #1
ldp	x12, x13, [x2, #48]
stp	x10, x11, [x0, #32]
stp	x12, x13, [x0, #48]
add	x2, x2, x3
add	x0, x0, x1
b.gt	put_neon
ret
ldp	q0, q1, [x2]
ldp	q2, q3, [x2, #32]
stp	q0, q1, [x0]
ldp	q4, q5, [x2, #64]
stp	q2, q3, [x0, #32]
ldp	q6, q7, [x2, #96]
subs	w5, w5, #1
stp	q4, q5, [x0, #64]
stp	q6, q7, [x0, #96]
add	x2, x2, x3
add	x0, x0, x1
b.gt	put_neon
ret
ldp	q0, q1, [x2]
ldp	q2, q3, [x2, #32]
stp	q0, q1, [x0]
ldp	q4, q5, [x2, #64]
stp	q2, q3, [x0, #32]
ldp	q6, q7, [x2, #96]
subs	w5, w5, #1
stp	q4, q5, [x0, #64]
ldp	q16, q17, [x2, #128]
stp	q6, q7, [x0, #96]
ldp	q18, q19, [x2, #160]
stp	q16, q17, [x0, #128]
ldp	q20, q21, [x2, #192]
stp	q18, q19, [x0, #160]
ldp	q22, q23, [x2, #224]
stp	q20, q21, [x0, #192]
stp	q22, q23, [x0, #224]
add	x2, x2, x3
add	x0, x0, x1
b.gt	put_neon
ret
<unknown>
<unknown>
<unknown>
udf	#324
_prep_neon:
adr	x10, #564
ldrh	w9, [x10, x9, lsl #1]
dup.8h	v31, w7
movi.8h	v30, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x9, x1, x2
lsl	x2, x2, #1
ld1.d	{ v0 }[0], [x1], x2
ld1.d	{ v0 }[1], [x9], x2
subs	w4, w4, #2
sshl.8h	v0, v0, v31
sub.8h	v0, v0, v30
st1.8h	{ v0 }, [x0], #16
b.gt	prep_neon
ret
add	x9, x1, x2
lsl	x2, x2, #1
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v1 }, [x9], x2
subs	w4, w4, #2
sshl.8h	v0, v0, v31
sshl.8h	v1, v1, v31
sub.8h	v0, v0, v30
sub.8h	v1, v1, v30
st1.8h	{ v0, v1 }, [x0], #32
b.gt	prep_neon
ret
ldp	q0, q1, [x1]
add	x1, x1, x2
sshl.8h	v0, v0, v31
ldp	q2, q3, [x1]
add	x1, x1, x2
subs	w4, w4, #2
sshl.8h	v1, v1, v31
sshl.8h	v2, v2, v31
sshl.8h	v3, v3, v31
sub.8h	v0, v0, v30
sub.8h	v1, v1, v30
sub.8h	v2, v2, v30
sub.8h	v3, v3, v30
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
b.gt	prep_neon
ret
ldp	q0, q1, [x1]
sshl.8h	v0, v0, v31
ldp	q2, q3, [x1, #32]
add	x1, x1, x2
sshl.8h	v1, v1, v31
sshl.8h	v2, v2, v31
sshl.8h	v3, v3, v31
subs	w4, w4, #1
sub.8h	v0, v0, v30
sub.8h	v1, v1, v30
sub.8h	v2, v2, v30
sub.8h	v3, v3, v30
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
b.gt	prep_neon
ret
ldp	q0, q1, [x1]
subs	w4, w4, #1
sshl.8h	v0, v0, v31
ldp	q2, q3, [x1, #32]
sshl.8h	v1, v1, v31
ldp	q4, q5, [x1, #64]
sshl.8h	v2, v2, v31
sshl.8h	v3, v3, v31
ldp	q6, q7, [x1, #96]
add	x1, x1, x2
sshl.8h	v4, v4, v31
sshl.8h	v5, v5, v31
sshl.8h	v6, v6, v31
sshl.8h	v7, v7, v31
sub.8h	v0, v0, v30
sub.8h	v1, v1, v30
sub.8h	v2, v2, v30
sub.8h	v3, v3, v30
stp	q0, q1, [x0]
sub.8h	v4, v4, v30
sub.8h	v5, v5, v30
stp	q2, q3, [x0, #32]
sub.8h	v6, v6, v30
sub.8h	v7, v7, v30
stp	q4, q5, [x0, #64]
stp	q6, q7, [x0, #96]
add	x0, x0, x8
b.gt	prep_neon
ret
ldp	q0, q1, [x1]
subs	w4, w4, #1
sshl.8h	v0, v0, v31
ldp	q2, q3, [x1, #32]
sshl.8h	v1, v1, v31
ldp	q4, q5, [x1, #64]
sshl.8h	v2, v2, v31
sshl.8h	v3, v3, v31
ldp	q6, q7, [x1, #96]
sshl.8h	v4, v4, v31
sshl.8h	v5, v5, v31
ldp	q16, q17, [x1, #128]
sshl.8h	v6, v6, v31
sshl.8h	v7, v7, v31
ldp	q18, q19, [x1, #160]
sshl.8h	v16, v16, v31
sshl.8h	v17, v17, v31
ldp	q20, q21, [x1, #192]
sshl.8h	v18, v18, v31
sshl.8h	v19, v19, v31
ldp	q22, q23, [x1, #224]
add	x1, x1, x2
sshl.8h	v20, v20, v31
sshl.8h	v21, v21, v31
sshl.8h	v22, v22, v31
sshl.8h	v23, v23, v31
sub.8h	v0, v0, v30
sub.8h	v1, v1, v30
sub.8h	v2, v2, v30
sub.8h	v3, v3, v30
stp	q0, q1, [x0]
sub.8h	v4, v4, v30
sub.8h	v5, v5, v30
stp	q2, q3, [x0, #32]
sub.8h	v6, v6, v30
sub.8h	v7, v7, v30
stp	q4, q5, [x0, #64]
sub.8h	v16, v16, v30
sub.8h	v17, v17, v30
stp	q6, q7, [x0, #96]
sub.8h	v18, v18, v30
sub.8h	v19, v19, v30
stp	q16, q17, [x0, #128]
sub.8h	v20, v20, v30
sub.8h	v21, v21, v30
stp	q18, q19, [x0, #160]
sub.8h	v22, v22, v30
sub.8h	v23, v23, v30
stp	q20, q21, [x0, #192]
stp	q22, q23, [x0, #224]
add	x0, x0, x8
b.gt	prep_neon
ret
<unknown>
<unknown>
<unknown>
_put_8tap_regular_sharp_16bpc_neon:
mov	w9, #45
mov	w10, #3885
b	put_8tap_neon
_put_8tap_smooth_sharp_16bpc_neon:
mov	w9, #1980
mov	w10, #3885
b	put_8tap_neon
_put_8tap_sharp_16bpc_neon:
mov	w9, #3885
mov	w10, #3885
b	put_8tap_neon
_put_8tap_sharp_regular_16bpc_neon:
mov	w9, #3885
mov	w10, #45
b	put_8tap_neon
_put_8tap_sharp_smooth_16bpc_neon:
mov	w9, #3885
mov	w10, #1980
b	put_8tap_neon
_put_8tap_neon:
ldr	w8, [sp]
mov	w11, #16513
mul	w6, w6, w11
mul	w7, w7, w11
add	w6, w6, w9
add	w7, w7, w10
dup.8h	v31, w8
clz	w8, w8
clz	w9, w4
sub	w8, w8, #18
mov	w12, #6
tst	w6, #0x1fc000
sub	w9, w9, #24
add	w13, w12, w8
sub	w12, w12, w8
adrp	x11, put_8tap_neon
add	x11, x11, #0
sub	x11, x11, #8
b.ne	put_8tap_neon
tst	w7, #0x1fc000
b.ne	put_8tap_neon
b	put_neon
cmp	w4, #4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	put_8tap_neon
mov	w6, w10
tst	w7, #0x1fc000
add	x6, x11, w6, uxtw #3
b.ne	put_8tap_neon
adr	x10, #636
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
dup.8h	v29, w8
sub	x10, x10, w9, uxtw
neg.8h	v29, v29
br	x10
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v4 }, [x2], x3
ld1.8h	{ v6 }, [x10], x3
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
subs	w5, w5, #2
trn1.2s	v3, v4, v6
trn2.2s	v6, v4, v6
trn1.2s	v4, v5, v7
trn2.2s	v7, v5, v7
smull.4s	v3, v3, v0[0]
smlal.4s	v3, v4, v0[1]
smlal.4s	v3, v6, v0[2]
smlal.4s	v3, v7, v0[3]
srshl.4s	v3, v3, v30
sqxtun.4h	v3, v3
srshl.4h	v3, v3, v29
umin.4h	v3, v3, v31
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v3 }[1], [x9], x1
b.gt	put_8tap_neon
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v16 }, [x2], x3
ld1.8h	{ v20 }, [x10], x3
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w5, w5, #2
smull.4s	v16, v16, v0[0]
smlal.4s	v16, v17, v0[1]
smlal.4s	v16, v18, v0[2]
smlal.4s	v16, v19, v0[3]
smull.4s	v20, v20, v0[0]
smlal.4s	v20, v21, v0[1]
smlal.4s	v20, v22, v0[2]
smlal.4s	v20, v23, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v20, v20, v30
sqxtun.4h	v16, v16
sqxtun2.8h	v16, v20
srshl.8h	v16, v16, v29
umin.8h	v16, v16, v31
st1.d	{ v16 }[0], [x0], x1
st1.d	{ v16 }[1], [x9], x1
b.gt	put_8tap_neon
ret
ld1.8b	{ v0 }, [x6]
sub	x2, x2, #6
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
sub	x3, x3, w4, uxtw #1
sub	x3, x3, #16
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
ld1.8h	{ v16, v17 }, [x2], #32
ld1.8h	{ v20, v21 }, [x10], #32
mov	w6, w4
smull.4s	v18, v16, v0[0]
smull2.4s	v19, v16, v0[0]
smull.4s	v22, v20, v0[0]
smull2.4s	v23, v20, v0[0]
ext.16b	v24, v16, v17, #2
ext.16b	v25, v20, v21, #2
smlal.4s	v18, v24, v0[1]
smlal2.4s	v19, v24, v0[1]
smlal.4s	v22, v25, v0[1]
smlal2.4s	v23, v25, v0[1]
ext.16b	v24, v16, v17, #4
ext.16b	v25, v20, v21, #4
smlal.4s	v18, v24, v0[2]
smlal2.4s	v19, v24, v0[2]
smlal.4s	v22, v25, v0[2]
smlal2.4s	v23, v25, v0[2]
ext.16b	v24, v16, v17, #6
ext.16b	v25, v20, v21, #6
smlal.4s	v18, v24, v0[3]
smlal2.4s	v19, v24, v0[3]
smlal.4s	v22, v25, v0[3]
smlal2.4s	v23, v25, v0[3]
ext.16b	v24, v16, v17, #8
ext.16b	v25, v20, v21, #8
smlal.4s	v18, v24, v0[4]
smlal2.4s	v19, v24, v0[4]
smlal.4s	v22, v25, v0[4]
smlal2.4s	v23, v25, v0[4]
ext.16b	v24, v16, v17, #10
ext.16b	v25, v20, v21, #10
smlal.4s	v18, v24, v0[5]
smlal2.4s	v19, v24, v0[5]
smlal.4s	v22, v25, v0[5]
smlal2.4s	v23, v25, v0[5]
ext.16b	v24, v16, v17, #12
ext.16b	v25, v20, v21, #12
smlal.4s	v18, v24, v0[6]
smlal2.4s	v19, v24, v0[6]
smlal.4s	v22, v25, v0[6]
smlal2.4s	v23, v25, v0[6]
ext.16b	v24, v16, v17, #14
ext.16b	v25, v20, v21, #14
smlal.4s	v18, v24, v0[7]
smlal2.4s	v19, v24, v0[7]
smlal.4s	v22, v25, v0[7]
smlal2.4s	v23, v25, v0[7]
subs	w6, w6, #8
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
srshl.4s	v22, v22, v30
srshl.4s	v23, v23, v30
sqxtun.4h	v18, v18
sqxtun2.8h	v18, v19
sqxtun.4h	v22, v22
sqxtun2.8h	v22, v23
srshl.8h	v18, v18, v29
srshl.8h	v22, v22, v29
umin.8h	v18, v18, v31
umin.8h	v22, v22, v31
st1.8h	{ v18 }, [x0], #16
st1.8h	{ v22 }, [x9], #16
b.le	put_8tap_neon
mov.16b	v16, v17
mov.16b	v20, v21
ld1.8h	{ v17 }, [x2], #16
ld1.8h	{ v21 }, [x10], #16
b	put_8tap_neon
add	x0, x0, x1
add	x9, x9, x1
add	x2, x2, x3
add	x10, x10, x3
subs	w5, w5, #2
b.gt	put_8tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#604
cmp	w5, #4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_8tap_neon
mov	w7, w10
add	x7, x11, w7, uxtw #3
adr	x10, #2028
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
br	x10
b.gt	put_8tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x3
ld1.s	{ v2 }[0], [x10], x3
ld1.s	{ v3 }[0], [x2], x3
ld1.s	{ v4 }[0], [x10], x3
ld1.s	{ v5 }[0], [x2], x3
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
b.gt	put_8tap_neon
smull.4s	v6, v1, v0[0]
smlal.4s	v6, v2, v0[1]
smlal.4s	v6, v3, v0[2]
smlal.4s	v6, v4, v0[3]
sqrshrun.4h	v6, v6, #6
umin.8h	v6, v6, v31
st1.s	{ v6 }[0], [x0], x1
st1.s	{ v6 }[1], [x9], x1
ret
ld1.s	{ v6 }[0], [x10], x3
ld1.s	{ v7 }[0], [x2], x3
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
smull.4s	v16, v1, v0[0]
smlal.4s	v16, v2, v0[1]
smlal.4s	v16, v3, v0[2]
smlal.4s	v16, v4, v0[3]
smull.4s	v17, v3, v0[0]
smlal.4s	v17, v4, v0[1]
smlal.4s	v17, v5, v0[2]
smlal.4s	v17, v6, v0[3]
sqrshrun.4h	v16, v16, #6
sqrshrun2.8h	v16, v17, #6
umin.8h	v16, v16, v31
st1.s	{ v16 }[0], [x0], x1
st1.s	{ v16 }[1], [x9], x1
st1.s	{ v16 }[2], [x0], x1
st1.s	{ v16 }[3], [x9], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x3
ld1.s	{ v2 }[0], [x10], x3
ld1.s	{ v3 }[0], [x2], x3
ld1.s	{ v4 }[0], [x10], x3
ld1.s	{ v5 }[0], [x2], x3
ld1.s	{ v6 }[0], [x10], x3
ld1.s	{ v7 }[0], [x2], x3
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
subs	w5, w5, #4
ld1.s	{ v16 }[0], [x10], x3
ld1.s	{ v17 }[0], [x2], x3
ld1.s	{ v18 }[0], [x10], x3
ld1.s	{ v19 }[0], [x2], x3
trn1.2s	v7, v7, v16
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
smull.4s	v24, v1, v0[0]
smlal.4s	v24, v2, v0[1]
smlal.4s	v24, v3, v0[2]
smlal.4s	v24, v4, v0[3]
smlal.4s	v24, v5, v0[4]
smlal.4s	v24, v6, v0[5]
smlal.4s	v24, v7, v0[6]
smlal.4s	v24, v16, v0[7]
smull.4s	v25, v3, v0[0]
smlal.4s	v25, v4, v0[1]
smlal.4s	v25, v5, v0[2]
smlal.4s	v25, v6, v0[3]
smlal.4s	v25, v7, v0[4]
smlal.4s	v25, v16, v0[5]
smlal.4s	v25, v17, v0[6]
smlal.4s	v25, v18, v0[7]
sqrshrun.4h	v24, v24, #6
sqrshrun2.8h	v24, v25, #6
umin.8h	v24, v24, v31
st1.s	{ v24 }[0], [x0], x1
st1.s	{ v24 }[1], [x9], x1
st1.s	{ v24 }[2], [x0], x1
st1.s	{ v24 }[3], [x9], x1
b.le	put_8tap_neon
cmp	w5, #2
mov.16b	v1, v5
mov.16b	v2, v6
mov.16b	v3, v7
mov.16b	v4, v16
mov.16b	v5, v17
mov.16b	v6, v18
mov.16b	v7, v19
b.eq	put_8tap_neon
b	put_8tap_neon
ld1.s	{ v16 }[0], [x10], x3
ld1.s	{ v17 }[0], [x2], x3
trn1.2s	v7, v7, v16
trn1.2s	v16, v16, v17
smull.4s	v24, v1, v0[0]
smlal.4s	v24, v2, v0[1]
smlal.4s	v24, v3, v0[2]
smlal.4s	v24, v4, v0[3]
smlal.4s	v24, v5, v0[4]
smlal.4s	v24, v6, v0[5]
smlal.4s	v24, v7, v0[6]
smlal.4s	v24, v16, v0[7]
sqrshrun.4h	v24, v24, #6
umin.4h	v24, v24, v31
st1.s	{ v24 }[0], [x0], x1
st1.s	{ v24 }[1], [x9], x1
ret
b.gt	put_8tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v1 }, [x2], x3
ld1.4h	{ v2 }, [x10], x3
ld1.4h	{ v3 }, [x2], x3
ld1.4h	{ v4 }, [x10], x3
ld1.4h	{ v5 }, [x2], x3
smull.4s	v6, v1, v0[0]
smlal.4s	v6, v2, v0[1]
smlal.4s	v6, v3, v0[2]
smlal.4s	v6, v4, v0[3]
smull.4s	v7, v2, v0[0]
smlal.4s	v7, v3, v0[1]
smlal.4s	v7, v4, v0[2]
smlal.4s	v7, v5, v0[3]
sqrshrun.4h	v6, v6, #6
sqrshrun2.8h	v6, v7, #6
umin.8h	v6, v6, v31
st1.d	{ v6 }[0], [x0], x1
st1.d	{ v6 }[1], [x9], x1
b.le	put_8tap_neon
ld1.4h	{ v6 }, [x10], x3
ld1.4h	{ v7 }, [x2], x3
smull.4s	v1, v3, v0[0]
smlal.4s	v1, v4, v0[1]
smlal.4s	v1, v5, v0[2]
smlal.4s	v1, v6, v0[3]
smull.4s	v2, v4, v0[0]
smlal.4s	v2, v5, v0[1]
smlal.4s	v2, v6, v0[2]
smlal.4s	v2, v7, v0[3]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
umin.8h	v1, v1, v31
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x9], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v16 }, [x2], x3
ld1.4h	{ v17 }, [x10], x3
ld1.4h	{ v18 }, [x2], x3
ld1.4h	{ v19 }, [x10], x3
ld1.4h	{ v20 }, [x2], x3
ld1.4h	{ v21 }, [x10], x3
ld1.4h	{ v22 }, [x2], x3
subs	w5, w5, #4
ld1.4h	{ v23 }, [x10], x3
ld1.4h	{ v24 }, [x2], x3
ld1.4h	{ v25 }, [x10], x3
ld1.4h	{ v26 }, [x2], x3
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smlal.4s	v1, v23, v0[7]
smull.4s	v2, v17, v0[0]
smlal.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
smlal.4s	v2, v24, v0[7]
smull.4s	v3, v18, v0[0]
smlal.4s	v3, v19, v0[1]
smlal.4s	v3, v20, v0[2]
smlal.4s	v3, v21, v0[3]
smlal.4s	v3, v22, v0[4]
smlal.4s	v3, v23, v0[5]
smlal.4s	v3, v24, v0[6]
smlal.4s	v3, v25, v0[7]
smull.4s	v4, v19, v0[0]
smlal.4s	v4, v20, v0[1]
smlal.4s	v4, v21, v0[2]
smlal.4s	v4, v22, v0[3]
smlal.4s	v4, v23, v0[4]
smlal.4s	v4, v24, v0[5]
smlal.4s	v4, v25, v0[6]
smlal.4s	v4, v26, v0[7]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v3, v3, v31
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x9], x1
st1.d	{ v3 }[0], [x0], x1
st1.d	{ v3 }[1], [x9], x1
b.le	put_8tap_neon
cmp	w5, #2
mov.8b	v16, v20
mov.8b	v17, v21
mov.8b	v18, v22
mov.8b	v19, v23
mov.8b	v20, v24
mov.8b	v21, v25
mov.8b	v22, v26
b.eq	put_8tap_neon
b	put_8tap_neon
ld1.4h	{ v23 }, [x10], x3
ld1.4h	{ v24 }, [x2], x3
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smlal.4s	v1, v23, v0[7]
smull.4s	v2, v17, v0[0]
smlal.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
smlal.4s	v2, v24, v0[7]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
umin.8h	v1, v1, v31
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x9], x1
ret
b.gt	put_8tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v1 }, [x2], x3
ld1.8h	{ v2 }, [x10], x3
ld1.8h	{ v3 }, [x2], x3
ld1.8h	{ v4 }, [x10], x3
ld1.8h	{ v5 }, [x2], x3
smull.4s	v16, v1, v0[0]
smlal.4s	v16, v2, v0[1]
smlal.4s	v16, v3, v0[2]
smlal.4s	v16, v4, v0[3]
smull2.4s	v17, v1, v0[0]
smlal2.4s	v17, v2, v0[1]
smlal2.4s	v17, v3, v0[2]
smlal2.4s	v17, v4, v0[3]
smull.4s	v18, v2, v0[0]
smlal.4s	v18, v3, v0[1]
smlal.4s	v18, v4, v0[2]
smlal.4s	v18, v5, v0[3]
smull2.4s	v19, v2, v0[0]
smlal2.4s	v19, v3, v0[1]
smlal2.4s	v19, v4, v0[2]
smlal2.4s	v19, v5, v0[3]
sqrshrun.4h	v16, v16, #6
sqrshrun2.8h	v16, v17, #6
sqrshrun.4h	v18, v18, #6
sqrshrun2.8h	v18, v19, #6
umin.8h	v16, v16, v31
umin.8h	v18, v18, v31
st1.8h	{ v16 }, [x0], x1
st1.8h	{ v18 }, [x9], x1
b.le	put_8tap_neon
ld1.8h	{ v6 }, [x10], x3
ld1.8h	{ v7 }, [x2], x3
smull.4s	v16, v3, v0[0]
smlal.4s	v16, v4, v0[1]
smlal.4s	v16, v5, v0[2]
smlal.4s	v16, v6, v0[3]
smull2.4s	v17, v3, v0[0]
smlal2.4s	v17, v4, v0[1]
smlal2.4s	v17, v5, v0[2]
smlal2.4s	v17, v6, v0[3]
smull.4s	v18, v4, v0[0]
smlal.4s	v18, v5, v0[1]
smlal.4s	v18, v6, v0[2]
smlal.4s	v18, v7, v0[3]
smull2.4s	v19, v4, v0[0]
smlal2.4s	v19, v5, v0[1]
smlal2.4s	v19, v6, v0[2]
smlal2.4s	v19, v7, v0[3]
sqrshrun.4h	v16, v16, #6
sqrshrun2.8h	v16, v17, #6
sqrshrun.4h	v18, v18, #6
sqrshrun2.8h	v18, v19, #6
umin.8h	v16, v16, v31
umin.8h	v18, v18, v31
st1.8h	{ v16 }, [x0], x1
st1.8h	{ v18 }, [x9], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8h	{ v16 }, [x2], x3
ld1.8h	{ v17 }, [x10], x3
ld1.8h	{ v18 }, [x2], x3
ld1.8h	{ v19 }, [x10], x3
ld1.8h	{ v20 }, [x2], x3
ld1.8h	{ v21 }, [x10], x3
ld1.8h	{ v22 }, [x2], x3
subs	w5, w5, #2
ld1.8h	{ v23 }, [x10], x3
ld1.8h	{ v24 }, [x2], x3
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smlal.4s	v1, v23, v0[7]
smull2.4s	v2, v16, v0[0]
smlal2.4s	v2, v17, v0[1]
smlal2.4s	v2, v18, v0[2]
smlal2.4s	v2, v19, v0[3]
smlal2.4s	v2, v20, v0[4]
smlal2.4s	v2, v21, v0[5]
smlal2.4s	v2, v22, v0[6]
smlal2.4s	v2, v23, v0[7]
smull.4s	v3, v17, v0[0]
smlal.4s	v3, v18, v0[1]
smlal.4s	v3, v19, v0[2]
smlal.4s	v3, v20, v0[3]
smlal.4s	v3, v21, v0[4]
smlal.4s	v3, v22, v0[5]
smlal.4s	v3, v23, v0[6]
smlal.4s	v3, v24, v0[7]
smull2.4s	v4, v17, v0[0]
smlal2.4s	v4, v18, v0[1]
smlal2.4s	v4, v19, v0[2]
smlal2.4s	v4, v20, v0[3]
smlal2.4s	v4, v21, v0[4]
smlal2.4s	v4, v22, v0[5]
smlal2.4s	v4, v23, v0[6]
smlal2.4s	v4, v24, v0[7]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v3, v3, v31
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_8tap_neon
subs	w5, w5, #2
ld1.8h	{ v25 }, [x10], x3
ld1.8h	{ v26 }, [x2], x3
smull.4s	v1, v18, v0[0]
smlal.4s	v1, v19, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v21, v0[3]
smlal.4s	v1, v22, v0[4]
smlal.4s	v1, v23, v0[5]
smlal.4s	v1, v24, v0[6]
smlal.4s	v1, v25, v0[7]
smull2.4s	v2, v18, v0[0]
smlal2.4s	v2, v19, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v21, v0[3]
smlal2.4s	v2, v22, v0[4]
smlal2.4s	v2, v23, v0[5]
smlal2.4s	v2, v24, v0[6]
smlal2.4s	v2, v25, v0[7]
smull.4s	v3, v19, v0[0]
smlal.4s	v3, v20, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v22, v0[3]
smlal.4s	v3, v23, v0[4]
smlal.4s	v3, v24, v0[5]
smlal.4s	v3, v25, v0[6]
smlal.4s	v3, v26, v0[7]
smull2.4s	v4, v19, v0[0]
smlal2.4s	v4, v20, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v22, v0[3]
smlal2.4s	v4, v23, v0[4]
smlal2.4s	v4, v24, v0[5]
smlal2.4s	v4, v25, v0[6]
smlal2.4s	v4, v26, v0[7]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v3, v3, v31
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_8tap_neon
mov.16b	v16, v20
mov.16b	v17, v21
mov.16b	v18, v22
mov.16b	v19, v23
mov.16b	v20, v24
mov.16b	v21, v25
mov.16b	v22, v26
b	put_8tap_neon
subs	w4, w4, #8
b.le	put_8tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_8tap_neon
ret
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
sshll.8h	v0, v0, #0
ld1.8h	{ v16, v17 }, [x2], x3
ld1.8h	{ v18, v19 }, [x2], x3
ld1.8h	{ v20, v21 }, [x2], x3
ld1.8h	{ v22, v23 }, [x2], x3
subs	w5, w5, #1
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v18, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v22, v0[3]
smull2.4s	v2, v16, v0[0]
smlal2.4s	v2, v18, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v22, v0[3]
smull.4s	v3, v17, v0[0]
smlal.4s	v3, v19, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v23, v0[3]
smull2.4s	v4, v17, v0[0]
smlal2.4s	v4, v19, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v23, v0[3]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v2, v3, v31
st1.8h	{ v1, v2 }, [x0], x1
b.le	put_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
b	put_8tap_neon
ret
<unknown>
<unknown>
mov	z4.d, p8/z, #29         ; =0x1d
udf	#2012
cmp	w5, #4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_8tap_neon
mov	w7, w10
add	x7, x11, w7, uxtw #3
adr	x10, #2036
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
dup.4s	v29, w13
sub	x10, x10, w9, uxtw
neg.4s	v29, v29
br	x10
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x10, x2, #2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v27 }, [x2], x3
ext.16b	v28, v27, v27, #2
smull.4s	v27, v27, v0
smull.4s	v28, v28, v0
addp.4s	v27, v27, v28
addp.4s	v16, v27, v27
srshl.2s	v16, v16, v30
bl	put_8tap_neon
xtn.4h	v16, v16
trn1.2s	v16, v16, v24
mov.8b	v17, v24
bl	put_8tap_neon
ext.8b	v18, v17, v24, #4
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v24, v1[3]
srshl.4s	v2, v2, v29
sqxtun.4h	v2, v2
umin.4h	v2, v2, v31
subs	w5, w5, #2
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x9], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v24
b	put_8tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #2
sub	x10, x2, x3, lsl #1
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v27 }, [x2], x3
ext.16b	v28, v27, v27, #2
smull.4s	v27, v27, v0
smull.4s	v28, v28, v0
addp.4s	v27, v27, v28
addp.4s	v16, v27, v27
srshl.2s	v16, v16, v30
bl	put_8tap_neon
xtn.4h	v16, v16
trn1.2s	v16, v16, v24
mov.8b	v17, v24
bl	put_8tap_neon
ext.8b	v18, v17, v24, #4
mov.8b	v19, v24
bl	put_8tap_neon
ext.8b	v20, v19, v24, #4
mov.8b	v21, v24
bl	put_8tap_neon
ext.8b	v22, v21, v24, #4
smull.4s	v3, v16, v1[0]
smlal.4s	v3, v17, v1[1]
smlal.4s	v3, v18, v1[2]
smlal.4s	v3, v19, v1[3]
smlal.4s	v3, v20, v1[4]
smlal.4s	v3, v21, v1[5]
smlal.4s	v3, v22, v1[6]
smlal.4s	v3, v24, v1[7]
srshl.4s	v3, v3, v29
sqxtun.4h	v3, v3
umin.4h	v3, v3, v31
subs	w5, w5, #2
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v3 }[1], [x9], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v24
b	put_8tap_neon
ret	x15
ld1.8h	{ v25 }, [x10], x3
ld1.8h	{ v27 }, [x2], x3
ext.16b	v26, v25, v25, #2
ext.16b	v28, v27, v27, #2
trn1.2s	v24, v25, v27
trn2.2s	v27, v25, v27
trn1.2s	v25, v26, v28
trn2.2s	v28, v26, v28
smull.4s	v24, v24, v0[0]
smlal.4s	v24, v25, v0[1]
smlal.4s	v24, v27, v0[2]
smlal.4s	v24, v28, v0[3]
srshl.4s	v24, v24, v30
xtn.4h	v24, v24
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x10, x2, #2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x2], x3
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v16, v16
bl	put_8tap_neon
mov.8b	v17, v24
mov.8b	v18, v25
bl	put_8tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v24, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v24, v1[2]
smlal.4s	v3, v25, v1[3]
srshl.4s	v2, v2, v29
srshl.4s	v3, v3, v29
sqxtun.4h	v2, v2
sqxtun2.8h	v2, v3
umin.8h	v2, v2, v31
subs	w5, w5, #2
st1.d	{ v2 }[0], [x0], x1
st1.d	{ v2 }[1], [x9], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v24
mov.8b	v18, v25
b	put_8tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #2
sub	x10, x2, x3, lsl #1
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x2], x3
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v16, v16
bl	put_8tap_neon
mov.8b	v17, v24
mov.8b	v18, v25
bl	put_8tap_neon
mov.8b	v19, v24
mov.8b	v20, v25
bl	put_8tap_neon
mov.8b	v21, v24
mov.8b	v22, v25
bl	put_8tap_neon
smull.4s	v3, v16, v1[0]
smlal.4s	v3, v17, v1[1]
smlal.4s	v3, v18, v1[2]
smlal.4s	v3, v19, v1[3]
smlal.4s	v3, v20, v1[4]
smlal.4s	v3, v21, v1[5]
smlal.4s	v3, v22, v1[6]
smlal.4s	v3, v24, v1[7]
smull.4s	v4, v17, v1[0]
smlal.4s	v4, v18, v1[1]
smlal.4s	v4, v19, v1[2]
smlal.4s	v4, v20, v1[3]
smlal.4s	v4, v21, v1[4]
smlal.4s	v4, v22, v1[5]
smlal.4s	v4, v24, v1[6]
smlal.4s	v4, v25, v1[7]
srshl.4s	v3, v3, v29
srshl.4s	v4, v4, v29
sqxtun.4h	v3, v3
sqxtun2.8h	v3, v4
umin.8h	v3, v3, v31
subs	w5, w5, #2
st1.d	{ v3 }[0], [x0], x1
st1.d	{ v3 }[1], [x9], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v24
mov.8b	v22, v25
b	put_8tap_neon
ret	x15
ld1.8h	{ v24 }, [x10], x3
ld1.8h	{ v25 }, [x2], x3
ext.16b	v26, v24, v24, #2
ext.16b	v27, v24, v24, #4
ext.16b	v28, v24, v24, #6
smull.4s	v24, v24, v0[0]
smlal.4s	v24, v26, v0[1]
smlal.4s	v24, v27, v0[2]
smlal.4s	v24, v28, v0[3]
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
xtn.4h	v24, v24
xtn.4h	v25, v25
ret
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.8b	{ v0 }, [x6]
ld1.s	{ v1 }[0], [x7]
sub	x2, x2, #6
sub	x2, x2, x3
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.8h	{ v27, v28 }, [x2], x3
smull.4s	v24, v27, v0[0]
smull2.4s	v25, v27, v0[0]
ext.16b	v26, v27, v28, #2
smlal.4s	v24, v26, v0[1]
smlal2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
ext.16b	v26, v27, v28, #14
smlal.4s	v24, v26, v0[7]
smlal2.4s	v25, v26, v0[7]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v16, v24, v25
bl	put_8tap_neon
mov.16b	v17, v23
mov.16b	v18, v24
smull.4s	v2, v16, v1[0]
smull2.4s	v3, v16, v1[0]
bl	put_8tap_neon
smull.4s	v4, v17, v1[0]
smull2.4s	v5, v17, v1[0]
smlal.4s	v2, v17, v1[1]
smlal2.4s	v3, v17, v1[1]
smlal.4s	v4, v18, v1[1]
smlal2.4s	v5, v18, v1[1]
smlal.4s	v2, v18, v1[2]
smlal2.4s	v3, v18, v1[2]
smlal.4s	v4, v23, v1[2]
smlal2.4s	v5, v23, v1[2]
smlal.4s	v2, v23, v1[3]
smlal2.4s	v3, v23, v1[3]
smlal.4s	v4, v24, v1[3]
smlal2.4s	v5, v24, v1[3]
srshl.4s	v2, v2, v29
srshl.4s	v3, v3, v29
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
sqxtun.4h	v2, v2
sqxtun2.8h	v2, v3
sqxtun.4h	v3, v4
sqxtun2.8h	v3, v5
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w5, w5, #2
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v23
mov.16b	v18, v24
b	put_8tap_neon
subs	w4, w4, #8
b.le	put_8tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_8tap_neon
ld1.8b	{ v0 }, [x6]
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #6
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.8h	{ v27, v28 }, [x2], x3
smull.4s	v24, v27, v0[0]
smull2.4s	v25, v27, v0[0]
ext.16b	v26, v27, v28, #2
smlal.4s	v24, v26, v0[1]
smlal2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
ext.16b	v26, v27, v28, #14
smlal.4s	v24, v26, v0[7]
smlal2.4s	v25, v26, v0[7]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v16, v24, v25
bl	put_8tap_neon
mov.16b	v17, v23
mov.16b	v18, v24
bl	put_8tap_neon
mov.16b	v19, v23
mov.16b	v20, v24
bl	put_8tap_neon
mov.16b	v21, v23
mov.16b	v22, v24
smull.4s	v2, v16, v1[0]
smull2.4s	v3, v16, v1[0]
bl	put_8tap_neon
smull.4s	v4, v17, v1[0]
smull2.4s	v5, v17, v1[0]
smlal.4s	v2, v17, v1[1]
smlal2.4s	v3, v17, v1[1]
smlal.4s	v4, v18, v1[1]
smlal2.4s	v5, v18, v1[1]
smlal.4s	v2, v18, v1[2]
smlal2.4s	v3, v18, v1[2]
smlal.4s	v4, v19, v1[2]
smlal2.4s	v5, v19, v1[2]
smlal.4s	v2, v19, v1[3]
smlal2.4s	v3, v19, v1[3]
smlal.4s	v4, v20, v1[3]
smlal2.4s	v5, v20, v1[3]
smlal.4s	v2, v20, v1[4]
smlal2.4s	v3, v20, v1[4]
smlal.4s	v4, v21, v1[4]
smlal2.4s	v5, v21, v1[4]
smlal.4s	v2, v21, v1[5]
smlal2.4s	v3, v21, v1[5]
smlal.4s	v4, v22, v1[5]
smlal2.4s	v5, v22, v1[5]
smlal.4s	v2, v22, v1[6]
smlal2.4s	v3, v22, v1[6]
smlal.4s	v4, v23, v1[6]
smlal2.4s	v5, v23, v1[6]
smlal.4s	v2, v23, v1[7]
smlal2.4s	v3, v23, v1[7]
smlal.4s	v4, v24, v1[7]
smlal2.4s	v5, v24, v1[7]
srshl.4s	v2, v2, v29
srshl.4s	v3, v3, v29
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
sqxtun.4h	v2, v2
sqxtun2.8h	v2, v3
sqxtun.4h	v3, v4
sqxtun2.8h	v3, v5
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w5, w5, #2
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
mov.16b	v22, v24
b	put_8tap_neon
subs	w4, w4, #8
b.le	put_8tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_8tap_neon
ret	x15
ld1.8h	{ v4, v5 }, [x10], x3
ld1.8h	{ v6, v7 }, [x2], x3
smull.4s	v25, v4, v0[0]
smull2.4s	v26, v4, v0[0]
smull.4s	v27, v6, v0[0]
smull2.4s	v28, v6, v0[0]
ext.16b	v23, v4, v5, #2
ext.16b	v24, v6, v7, #2
smlal.4s	v25, v23, v0[1]
smlal2.4s	v26, v23, v0[1]
smlal.4s	v27, v24, v0[1]
smlal2.4s	v28, v24, v0[1]
ext.16b	v23, v4, v5, #4
ext.16b	v24, v6, v7, #4
smlal.4s	v25, v23, v0[2]
smlal2.4s	v26, v23, v0[2]
smlal.4s	v27, v24, v0[2]
smlal2.4s	v28, v24, v0[2]
ext.16b	v23, v4, v5, #6
ext.16b	v24, v6, v7, #6
smlal.4s	v25, v23, v0[3]
smlal2.4s	v26, v23, v0[3]
smlal.4s	v27, v24, v0[3]
smlal2.4s	v28, v24, v0[3]
ext.16b	v23, v4, v5, #8
ext.16b	v24, v6, v7, #8
smlal.4s	v25, v23, v0[4]
smlal2.4s	v26, v23, v0[4]
smlal.4s	v27, v24, v0[4]
smlal2.4s	v28, v24, v0[4]
ext.16b	v23, v4, v5, #10
ext.16b	v24, v6, v7, #10
smlal.4s	v25, v23, v0[5]
smlal2.4s	v26, v23, v0[5]
smlal.4s	v27, v24, v0[5]
smlal2.4s	v28, v24, v0[5]
ext.16b	v23, v4, v5, #12
ext.16b	v24, v6, v7, #12
smlal.4s	v25, v23, v0[6]
smlal2.4s	v26, v23, v0[6]
smlal.4s	v27, v24, v0[6]
smlal2.4s	v28, v24, v0[6]
ext.16b	v23, v4, v5, #14
ext.16b	v24, v6, v7, #14
smlal.4s	v25, v23, v0[7]
smlal2.4s	v26, v23, v0[7]
smlal.4s	v27, v24, v0[7]
smlal2.4s	v28, v24, v0[7]
srshl.4s	v25, v25, v30
srshl.4s	v26, v26, v30
srshl.4s	v27, v27, v30
srshl.4s	v28, v28, v30
uzp1.8h	v23, v25, v26
uzp1.8h	v24, v27, v28
ret
<unknown>
<unknown>
<unknown>
udf	#2004
_put_8tap_regular_16bpc_neon:
mov	w9, #45
mov	w10, #45
b	put_6tap_neon
_put_8tap_regular_smooth_16bpc_neon:
mov	w9, #45
mov	w10, #1980
b	put_6tap_neon
_put_8tap_smooth_16bpc_neon:
mov	w9, #1980
mov	w10, #1980
b	put_6tap_neon
_put_8tap_smooth_regular_16bpc_neon:
mov	w9, #1980
mov	w10, #45
b	put_6tap_neon
_put_6tap_neon:
ldr	w8, [sp]
mov	w11, #16513
mul	w6, w6, w11
mul	w7, w7, w11
add	w6, w6, w9
add	w7, w7, w10
dup.8h	v31, w8
clz	w8, w8
clz	w9, w4
sub	w8, w8, #18
mov	w12, #6
tst	w6, #0x1fc000
sub	w9, w9, #24
add	w13, w12, w8
sub	w12, w12, w8
adrp	x11, put_6tap_neon
add	x11, x11, #0
sub	x11, x11, #8
b.ne	put_6tap_neon
tst	w7, #0x1fc000
b.ne	put_6tap_neon
b	put_neon
cmp	w4, #4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	put_6tap_neon
mov	w6, w10
tst	w7, #0x1fc000
add	x6, x11, w6, uxtw #3
b.ne	put_6tap_neon
adr	x10, #596
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
dup.8h	v29, w8
sub	x10, x10, w9, uxtw
neg.8h	v29, v29
br	x10
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v4 }, [x2], x3
ld1.8h	{ v6 }, [x10], x3
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
subs	w5, w5, #2
trn1.2s	v3, v4, v6
trn2.2s	v6, v4, v6
trn1.2s	v4, v5, v7
trn2.2s	v7, v5, v7
smull.4s	v3, v3, v0[0]
smlal.4s	v3, v4, v0[1]
smlal.4s	v3, v6, v0[2]
smlal.4s	v3, v7, v0[3]
srshl.4s	v3, v3, v30
sqxtun.4h	v3, v3
srshl.4h	v3, v3, v29
umin.4h	v3, v3, v31
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v3 }[1], [x9], x1
b.gt	put_6tap_neon
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v16 }, [x2], x3
ld1.8h	{ v20 }, [x10], x3
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w5, w5, #2
smull.4s	v16, v16, v0[0]
smlal.4s	v16, v17, v0[1]
smlal.4s	v16, v18, v0[2]
smlal.4s	v16, v19, v0[3]
smull.4s	v20, v20, v0[0]
smlal.4s	v20, v21, v0[1]
smlal.4s	v20, v22, v0[2]
smlal.4s	v20, v23, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v20, v20, v30
sqxtun.4h	v16, v16
sqxtun2.8h	v16, v20
srshl.8h	v16, v16, v29
umin.8h	v16, v16, v31
st1.d	{ v16 }[0], [x0], x1
st1.d	{ v16 }[1], [x9], x1
b.gt	put_6tap_neon
ret
ld1.8b	{ v0 }, [x6]
sub	x2, x2, #6
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
sub	x3, x3, w4, uxtw #1
sub	x3, x3, #16
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
ld1.8h	{ v16, v17 }, [x2], #32
ld1.8h	{ v20, v21 }, [x10], #32
mov	w6, w4
ext.16b	v24, v16, v17, #2
ext.16b	v25, v20, v21, #2
smull.4s	v18, v24, v0[1]
smull2.4s	v19, v24, v0[1]
smull.4s	v22, v25, v0[1]
smull2.4s	v23, v25, v0[1]
ext.16b	v24, v16, v17, #4
ext.16b	v25, v20, v21, #4
smlal.4s	v18, v24, v0[2]
smlal2.4s	v19, v24, v0[2]
smlal.4s	v22, v25, v0[2]
smlal2.4s	v23, v25, v0[2]
ext.16b	v24, v16, v17, #6
ext.16b	v25, v20, v21, #6
smlal.4s	v18, v24, v0[3]
smlal2.4s	v19, v24, v0[3]
smlal.4s	v22, v25, v0[3]
smlal2.4s	v23, v25, v0[3]
ext.16b	v24, v16, v17, #8
ext.16b	v25, v20, v21, #8
smlal.4s	v18, v24, v0[4]
smlal2.4s	v19, v24, v0[4]
smlal.4s	v22, v25, v0[4]
smlal2.4s	v23, v25, v0[4]
ext.16b	v24, v16, v17, #10
ext.16b	v25, v20, v21, #10
smlal.4s	v18, v24, v0[5]
smlal2.4s	v19, v24, v0[5]
smlal.4s	v22, v25, v0[5]
smlal2.4s	v23, v25, v0[5]
ext.16b	v24, v16, v17, #12
ext.16b	v25, v20, v21, #12
smlal.4s	v18, v24, v0[6]
smlal2.4s	v19, v24, v0[6]
smlal.4s	v22, v25, v0[6]
smlal2.4s	v23, v25, v0[6]
subs	w6, w6, #8
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
srshl.4s	v22, v22, v30
srshl.4s	v23, v23, v30
sqxtun.4h	v18, v18
sqxtun2.8h	v18, v19
sqxtun.4h	v22, v22
sqxtun2.8h	v22, v23
srshl.8h	v18, v18, v29
srshl.8h	v22, v22, v29
umin.8h	v18, v18, v31
umin.8h	v22, v22, v31
st1.8h	{ v18 }, [x0], #16
st1.8h	{ v22 }, [x9], #16
b.le	put_6tap_neon
mov.16b	v16, v17
mov.16b	v20, v21
ld1.8h	{ v17 }, [x2], #16
ld1.8h	{ v21 }, [x10], #16
b	put_6tap_neon
add	x0, x0, x1
add	x9, x9, x1
add	x2, x2, x3
add	x10, x10, x3
subs	w5, w5, #2
b.gt	put_6tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#564
cmp	w5, #4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_6tap_neon
mov	w7, w10
add	x7, x11, w7, uxtw #3
adr	x10, #1892
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
br	x10
b.gt	put_6tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x3
ld1.s	{ v2 }[0], [x10], x3
ld1.s	{ v3 }[0], [x2], x3
ld1.s	{ v4 }[0], [x10], x3
ld1.s	{ v5 }[0], [x2], x3
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
b.gt	put_6tap_neon
smull.4s	v6, v1, v0[0]
smlal.4s	v6, v2, v0[1]
smlal.4s	v6, v3, v0[2]
smlal.4s	v6, v4, v0[3]
sqrshrun.4h	v6, v6, #6
umin.8h	v6, v6, v31
st1.s	{ v6 }[0], [x0], x1
st1.s	{ v6 }[1], [x9], x1
ret
ld1.s	{ v6 }[0], [x10], x3
ld1.s	{ v7 }[0], [x2], x3
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
smull.4s	v16, v1, v0[0]
smlal.4s	v16, v2, v0[1]
smlal.4s	v16, v3, v0[2]
smlal.4s	v16, v4, v0[3]
smull.4s	v17, v3, v0[0]
smlal.4s	v17, v4, v0[1]
smlal.4s	v17, v5, v0[2]
smlal.4s	v17, v6, v0[3]
sqrshrun.4h	v16, v16, #6
sqrshrun2.8h	v16, v17, #6
umin.8h	v16, v16, v31
st1.s	{ v16 }[0], [x0], x1
st1.s	{ v16 }[1], [x9], x1
st1.s	{ v16 }[2], [x0], x1
st1.s	{ v16 }[3], [x9], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x3
ld1.s	{ v2 }[0], [x10], x3
ld1.s	{ v3 }[0], [x2], x3
ld1.s	{ v4 }[0], [x10], x3
ld1.s	{ v5 }[0], [x2], x3
ld1.s	{ v6 }[0], [x10], x3
ld1.s	{ v7 }[0], [x2], x3
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
subs	w5, w5, #4
ld1.s	{ v16 }[0], [x10], x3
ld1.s	{ v17 }[0], [x2], x3
ld1.s	{ v18 }[0], [x10], x3
ld1.s	{ v19 }[0], [x2], x3
trn1.2s	v7, v7, v16
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
smull.4s	v24, v2, v0[1]
smlal.4s	v24, v3, v0[2]
smlal.4s	v24, v4, v0[3]
smlal.4s	v24, v5, v0[4]
smlal.4s	v24, v6, v0[5]
smlal.4s	v24, v7, v0[6]
smull.4s	v25, v4, v0[1]
smlal.4s	v25, v5, v0[2]
smlal.4s	v25, v6, v0[3]
smlal.4s	v25, v7, v0[4]
smlal.4s	v25, v16, v0[5]
smlal.4s	v25, v17, v0[6]
sqrshrun.4h	v24, v24, #6
sqrshrun2.8h	v24, v25, #6
umin.8h	v24, v24, v31
st1.s	{ v24 }[0], [x0], x1
st1.s	{ v24 }[1], [x9], x1
st1.s	{ v24 }[2], [x0], x1
st1.s	{ v24 }[3], [x9], x1
b.le	put_6tap_neon
cmp	w5, #2
mov.16b	v1, v5
mov.16b	v2, v6
mov.16b	v3, v7
mov.16b	v4, v16
mov.16b	v5, v17
mov.16b	v6, v18
mov.16b	v7, v19
b.eq	put_6tap_neon
b	put_6tap_neon
ld1.s	{ v16 }[0], [x10], x3
ld1.s	{ v17 }[0], [x2], x3
trn1.2s	v7, v7, v16
trn1.2s	v16, v16, v17
smull.4s	v24, v2, v0[1]
smlal.4s	v24, v3, v0[2]
smlal.4s	v24, v4, v0[3]
smlal.4s	v24, v5, v0[4]
smlal.4s	v24, v6, v0[5]
smlal.4s	v24, v7, v0[6]
sqrshrun.4h	v24, v24, #6
umin.4h	v24, v24, v31
st1.s	{ v24 }[0], [x0], x1
st1.s	{ v24 }[1], [x9], x1
ret
b.gt	put_6tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v1 }, [x2], x3
ld1.4h	{ v2 }, [x10], x3
ld1.4h	{ v3 }, [x2], x3
ld1.4h	{ v4 }, [x10], x3
ld1.4h	{ v5 }, [x2], x3
smull.4s	v6, v1, v0[0]
smlal.4s	v6, v2, v0[1]
smlal.4s	v6, v3, v0[2]
smlal.4s	v6, v4, v0[3]
smull.4s	v7, v2, v0[0]
smlal.4s	v7, v3, v0[1]
smlal.4s	v7, v4, v0[2]
smlal.4s	v7, v5, v0[3]
sqrshrun.4h	v6, v6, #6
sqrshrun2.8h	v6, v7, #6
umin.8h	v6, v6, v31
st1.d	{ v6 }[0], [x0], x1
st1.d	{ v6 }[1], [x9], x1
b.le	put_6tap_neon
ld1.4h	{ v6 }, [x10], x3
ld1.4h	{ v7 }, [x2], x3
smull.4s	v1, v3, v0[0]
smlal.4s	v1, v4, v0[1]
smlal.4s	v1, v5, v0[2]
smlal.4s	v1, v6, v0[3]
smull.4s	v2, v4, v0[0]
smlal.4s	v2, v5, v0[1]
smlal.4s	v2, v6, v0[2]
smlal.4s	v2, v7, v0[3]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
umin.8h	v1, v1, v31
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x9], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v16 }, [x2], x3
ld1.4h	{ v17 }, [x10], x3
ld1.4h	{ v18 }, [x2], x3
ld1.4h	{ v19 }, [x10], x3
ld1.4h	{ v20 }, [x2], x3
ld1.4h	{ v21 }, [x10], x3
ld1.4h	{ v22 }, [x2], x3
subs	w5, w5, #4
ld1.4h	{ v23 }, [x10], x3
ld1.4h	{ v24 }, [x2], x3
ld1.4h	{ v25 }, [x10], x3
ld1.4h	{ v26 }, [x2], x3
smull.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smull.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
smull.4s	v3, v19, v0[1]
smlal.4s	v3, v20, v0[2]
smlal.4s	v3, v21, v0[3]
smlal.4s	v3, v22, v0[4]
smlal.4s	v3, v23, v0[5]
smlal.4s	v3, v24, v0[6]
smull.4s	v4, v20, v0[1]
smlal.4s	v4, v21, v0[2]
smlal.4s	v4, v22, v0[3]
smlal.4s	v4, v23, v0[4]
smlal.4s	v4, v24, v0[5]
smlal.4s	v4, v25, v0[6]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v3, v3, v31
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x9], x1
st1.d	{ v3 }[0], [x0], x1
st1.d	{ v3 }[1], [x9], x1
b.le	put_6tap_neon
cmp	w5, #2
mov.8b	v16, v20
mov.8b	v17, v21
mov.8b	v18, v22
mov.8b	v19, v23
mov.8b	v20, v24
mov.8b	v21, v25
mov.8b	v22, v26
b.eq	put_6tap_neon
b	put_6tap_neon
ld1.4h	{ v23 }, [x10], x3
ld1.4h	{ v24 }, [x2], x3
smull.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smull.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
umin.8h	v1, v1, v31
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x9], x1
ret
b.gt	put_6tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v1 }, [x2], x3
ld1.8h	{ v2 }, [x10], x3
ld1.8h	{ v3 }, [x2], x3
ld1.8h	{ v4 }, [x10], x3
ld1.8h	{ v5 }, [x2], x3
smull.4s	v16, v1, v0[0]
smlal.4s	v16, v2, v0[1]
smlal.4s	v16, v3, v0[2]
smlal.4s	v16, v4, v0[3]
smull2.4s	v17, v1, v0[0]
smlal2.4s	v17, v2, v0[1]
smlal2.4s	v17, v3, v0[2]
smlal2.4s	v17, v4, v0[3]
smull.4s	v18, v2, v0[0]
smlal.4s	v18, v3, v0[1]
smlal.4s	v18, v4, v0[2]
smlal.4s	v18, v5, v0[3]
smull2.4s	v19, v2, v0[0]
smlal2.4s	v19, v3, v0[1]
smlal2.4s	v19, v4, v0[2]
smlal2.4s	v19, v5, v0[3]
sqrshrun.4h	v16, v16, #6
sqrshrun2.8h	v16, v17, #6
sqrshrun.4h	v18, v18, #6
sqrshrun2.8h	v18, v19, #6
umin.8h	v16, v16, v31
umin.8h	v18, v18, v31
st1.8h	{ v16 }, [x0], x1
st1.8h	{ v18 }, [x9], x1
b.le	put_6tap_neon
ld1.8h	{ v6 }, [x10], x3
ld1.8h	{ v7 }, [x2], x3
smull.4s	v16, v3, v0[0]
smlal.4s	v16, v4, v0[1]
smlal.4s	v16, v5, v0[2]
smlal.4s	v16, v6, v0[3]
smull2.4s	v17, v3, v0[0]
smlal2.4s	v17, v4, v0[1]
smlal2.4s	v17, v5, v0[2]
smlal2.4s	v17, v6, v0[3]
smull.4s	v18, v4, v0[0]
smlal.4s	v18, v5, v0[1]
smlal.4s	v18, v6, v0[2]
smlal.4s	v18, v7, v0[3]
smull2.4s	v19, v4, v0[0]
smlal2.4s	v19, v5, v0[1]
smlal2.4s	v19, v6, v0[2]
smlal2.4s	v19, v7, v0[3]
sqrshrun.4h	v16, v16, #6
sqrshrun2.8h	v16, v17, #6
sqrshrun.4h	v18, v18, #6
sqrshrun2.8h	v18, v19, #6
umin.8h	v16, v16, v31
umin.8h	v18, v18, v31
st1.8h	{ v16 }, [x0], x1
st1.8h	{ v18 }, [x9], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8h	{ v16 }, [x2], x3
ld1.8h	{ v17 }, [x10], x3
ld1.8h	{ v18 }, [x2], x3
ld1.8h	{ v19 }, [x10], x3
ld1.8h	{ v20 }, [x2], x3
ld1.8h	{ v21 }, [x10], x3
ld1.8h	{ v22 }, [x2], x3
subs	w5, w5, #2
ld1.8h	{ v23 }, [x10], x3
ld1.8h	{ v24 }, [x2], x3
smull.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smull2.4s	v2, v17, v0[1]
smlal2.4s	v2, v18, v0[2]
smlal2.4s	v2, v19, v0[3]
smlal2.4s	v2, v20, v0[4]
smlal2.4s	v2, v21, v0[5]
smlal2.4s	v2, v22, v0[6]
smull.4s	v3, v18, v0[1]
smlal.4s	v3, v19, v0[2]
smlal.4s	v3, v20, v0[3]
smlal.4s	v3, v21, v0[4]
smlal.4s	v3, v22, v0[5]
smlal.4s	v3, v23, v0[6]
smull2.4s	v4, v18, v0[1]
smlal2.4s	v4, v19, v0[2]
smlal2.4s	v4, v20, v0[3]
smlal2.4s	v4, v21, v0[4]
smlal2.4s	v4, v22, v0[5]
smlal2.4s	v4, v23, v0[6]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v3, v3, v31
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_6tap_neon
subs	w5, w5, #2
ld1.8h	{ v25 }, [x10], x3
ld1.8h	{ v26 }, [x2], x3
smull.4s	v1, v19, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v21, v0[3]
smlal.4s	v1, v22, v0[4]
smlal.4s	v1, v23, v0[5]
smlal.4s	v1, v24, v0[6]
smull2.4s	v2, v19, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v21, v0[3]
smlal2.4s	v2, v22, v0[4]
smlal2.4s	v2, v23, v0[5]
smlal2.4s	v2, v24, v0[6]
smull.4s	v3, v20, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v22, v0[3]
smlal.4s	v3, v23, v0[4]
smlal.4s	v3, v24, v0[5]
smlal.4s	v3, v25, v0[6]
smull2.4s	v4, v20, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v22, v0[3]
smlal2.4s	v4, v23, v0[4]
smlal2.4s	v4, v24, v0[5]
smlal2.4s	v4, v25, v0[6]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v3, v3, v31
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_6tap_neon
mov.16b	v16, v20
mov.16b	v17, v21
mov.16b	v18, v22
mov.16b	v19, v23
mov.16b	v20, v24
mov.16b	v21, v25
mov.16b	v22, v26
b	put_6tap_neon
subs	w4, w4, #8
b.le	put_6tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_6tap_neon
ret
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
sshll.8h	v0, v0, #0
ld1.8h	{ v16, v17 }, [x2], x3
ld1.8h	{ v18, v19 }, [x2], x3
ld1.8h	{ v20, v21 }, [x2], x3
ld1.8h	{ v22, v23 }, [x2], x3
subs	w5, w5, #1
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v18, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v22, v0[3]
smull2.4s	v2, v16, v0[0]
smlal2.4s	v2, v18, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v22, v0[3]
smull.4s	v3, v17, v0[0]
smlal.4s	v3, v19, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v23, v0[3]
smull2.4s	v4, v17, v0[0]
smlal2.4s	v4, v19, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v23, v0[3]
sqrshrun.4h	v1, v1, #6
sqrshrun2.8h	v1, v2, #6
sqrshrun.4h	v3, v3, #6
sqrshrun2.8h	v3, v4, #6
umin.8h	v1, v1, v31
umin.8h	v2, v3, v31
st1.8h	{ v1, v2 }, [x0], x1
b.le	put_6tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
b	put_6tap_neon
ret
<unknown>
<unknown>
ext	z4.b, { z27.b, z28.b }, #64
udf	#1876
cmp	w5, #4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_6tap_neon
mov	w7, w10
add	x7, x11, w7, uxtw #3
adr	x10, #1880
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
dup.4s	v29, w13
sub	x10, x10, w9, uxtw
neg.4s	v29, v29
br	x10
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x10, x2, #2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v27 }, [x2], x3
ext.16b	v28, v27, v27, #2
smull.4s	v27, v27, v0
smull.4s	v28, v28, v0
addp.4s	v27, v27, v28
addp.4s	v16, v27, v27
srshl.2s	v16, v16, v30
bl	put_6tap_neon
xtn.4h	v16, v16
trn1.2s	v16, v16, v24
mov.8b	v17, v24
bl	put_6tap_neon
ext.8b	v18, v17, v24, #4
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v24, v1[3]
srshl.4s	v2, v2, v29
sqxtun.4h	v2, v2
umin.4h	v2, v2, v31
subs	w5, w5, #2
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x9], x1
b.le	put_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v24
b	put_6tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #2
sub	x10, x2, x3, lsl #1
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v27 }, [x2], x3
ext.16b	v28, v27, v27, #2
smull.4s	v27, v27, v0
smull.4s	v28, v28, v0
addp.4s	v27, v27, v28
addp.4s	v16, v27, v27
srshl.2s	v16, v16, v30
bl	put_6tap_neon
xtn.4h	v16, v16
trn1.2s	v16, v16, v24
mov.8b	v17, v24
bl	put_6tap_neon
ext.8b	v18, v17, v24, #4
mov.8b	v19, v24
bl	put_6tap_neon
ext.8b	v20, v19, v24, #4
mov.8b	v21, v24
bl	put_6tap_neon
ext.8b	v22, v21, v24, #4
smull.4s	v3, v17, v1[1]
smlal.4s	v3, v18, v1[2]
smlal.4s	v3, v19, v1[3]
smlal.4s	v3, v20, v1[4]
smlal.4s	v3, v21, v1[5]
smlal.4s	v3, v22, v1[6]
srshl.4s	v3, v3, v29
sqxtun.4h	v3, v3
umin.4h	v3, v3, v31
subs	w5, w5, #2
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v3 }[1], [x9], x1
b.le	put_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v24
b	put_6tap_neon
ret	x15
ld1.8h	{ v25 }, [x10], x3
ld1.8h	{ v27 }, [x2], x3
ext.16b	v26, v25, v25, #2
ext.16b	v28, v27, v27, #2
trn1.2s	v24, v25, v27
trn2.2s	v27, v25, v27
trn1.2s	v25, v26, v28
trn2.2s	v28, v26, v28
smull.4s	v24, v24, v0[0]
smlal.4s	v24, v25, v0[1]
smlal.4s	v24, v27, v0[2]
smlal.4s	v24, v28, v0[3]
srshl.4s	v24, v24, v30
xtn.4h	v24, v24
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x10, x2, #2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x2], x3
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v16, v16
bl	put_6tap_neon
mov.8b	v17, v24
mov.8b	v18, v25
bl	put_6tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v24, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v24, v1[2]
smlal.4s	v3, v25, v1[3]
srshl.4s	v2, v2, v29
srshl.4s	v3, v3, v29
sqxtun.4h	v2, v2
sqxtun2.8h	v2, v3
umin.8h	v2, v2, v31
subs	w5, w5, #2
st1.d	{ v2 }[0], [x0], x1
st1.d	{ v2 }[1], [x9], x1
b.le	put_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v24
mov.8b	v18, v25
b	put_6tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #2
sub	x10, x2, x3
sub	x2, x2, x3, lsl #1
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x2], x3
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v18, v16
bl	put_6tap_neon
mov.8b	v19, v24
mov.8b	v20, v25
bl	put_6tap_neon
mov.8b	v21, v24
mov.8b	v22, v25
bl	put_6tap_neon
smull.4s	v3, v18, v1[1]
smlal.4s	v3, v19, v1[2]
smlal.4s	v3, v20, v1[3]
smlal.4s	v3, v21, v1[4]
smlal.4s	v3, v22, v1[5]
smlal.4s	v3, v24, v1[6]
smull.4s	v4, v19, v1[1]
smlal.4s	v4, v20, v1[2]
smlal.4s	v4, v21, v1[3]
smlal.4s	v4, v22, v1[4]
smlal.4s	v4, v24, v1[5]
smlal.4s	v4, v25, v1[6]
srshl.4s	v3, v3, v29
srshl.4s	v4, v4, v29
sqxtun.4h	v3, v3
sqxtun2.8h	v3, v4
umin.8h	v3, v3, v31
subs	w5, w5, #2
st1.d	{ v3 }[0], [x0], x1
st1.d	{ v3 }[1], [x9], x1
b.le	put_6tap_neon
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v24
mov.8b	v22, v25
b	put_6tap_neon
ret	x15
ld1.8h	{ v24 }, [x10], x3
ld1.8h	{ v25 }, [x2], x3
ext.16b	v26, v24, v24, #2
ext.16b	v27, v24, v24, #4
ext.16b	v28, v24, v24, #6
smull.4s	v24, v24, v0[0]
smlal.4s	v24, v26, v0[1]
smlal.4s	v24, v27, v0[2]
smlal.4s	v24, v28, v0[3]
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
xtn.4h	v24, v24
xtn.4h	v25, v25
ret
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.8b	{ v0 }, [x6]
ld1.s	{ v1 }[0], [x7]
sub	x2, x2, #6
sub	x2, x2, x3
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.8h	{ v27, v28 }, [x2], x3
smull.4s	v24, v27, v0[0]
smull2.4s	v25, v27, v0[0]
ext.16b	v26, v27, v28, #2
smlal.4s	v24, v26, v0[1]
smlal2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
ext.16b	v26, v27, v28, #14
smlal.4s	v24, v26, v0[7]
smlal2.4s	v25, v26, v0[7]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v16, v24, v25
bl	put_6tap_neon
mov.16b	v17, v23
mov.16b	v18, v24
smull.4s	v2, v16, v1[0]
smull2.4s	v3, v16, v1[0]
bl	put_6tap_neon
smull.4s	v4, v17, v1[0]
smull2.4s	v5, v17, v1[0]
smlal.4s	v2, v17, v1[1]
smlal2.4s	v3, v17, v1[1]
smlal.4s	v4, v18, v1[1]
smlal2.4s	v5, v18, v1[1]
smlal.4s	v2, v18, v1[2]
smlal2.4s	v3, v18, v1[2]
smlal.4s	v4, v23, v1[2]
smlal2.4s	v5, v23, v1[2]
smlal.4s	v2, v23, v1[3]
smlal2.4s	v3, v23, v1[3]
smlal.4s	v4, v24, v1[3]
smlal2.4s	v5, v24, v1[3]
srshl.4s	v2, v2, v29
srshl.4s	v3, v3, v29
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
sqxtun.4h	v2, v2
sqxtun2.8h	v2, v3
sqxtun.4h	v3, v4
sqxtun2.8h	v3, v5
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w5, w5, #2
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_6tap_neon
mov.16b	v16, v18
mov.16b	v17, v23
mov.16b	v18, v24
b	put_6tap_neon
subs	w4, w4, #8
b.le	put_6tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_6tap_neon
ld1.8b	{ v0 }, [x6]
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #6
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.8h	{ v27, v28 }, [x2], x3
ext.16b	v26, v27, v28, #2
smull.4s	v24, v26, v0[1]
smull2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v18, v24, v25
bl	put_6tap_neon
mov.16b	v19, v23
mov.16b	v20, v24
bl	put_6tap_neon
mov.16b	v21, v23
mov.16b	v22, v24
smull.4s	v2, v18, v1[1]
smull2.4s	v3, v18, v1[1]
bl	put_6tap_neon
smull.4s	v4, v19, v1[1]
smull2.4s	v5, v19, v1[1]
smlal.4s	v2, v19, v1[2]
smlal2.4s	v3, v19, v1[2]
smlal.4s	v4, v20, v1[2]
smlal2.4s	v5, v20, v1[2]
smlal.4s	v2, v20, v1[3]
smlal2.4s	v3, v20, v1[3]
smlal.4s	v4, v21, v1[3]
smlal2.4s	v5, v21, v1[3]
smlal.4s	v2, v21, v1[4]
smlal2.4s	v3, v21, v1[4]
smlal.4s	v4, v22, v1[4]
smlal2.4s	v5, v22, v1[4]
smlal.4s	v2, v22, v1[5]
smlal2.4s	v3, v22, v1[5]
smlal.4s	v4, v23, v1[5]
smlal2.4s	v5, v23, v1[5]
smlal.4s	v2, v23, v1[6]
smlal2.4s	v3, v23, v1[6]
smlal.4s	v4, v24, v1[6]
smlal2.4s	v5, v24, v1[6]
srshl.4s	v2, v2, v29
srshl.4s	v3, v3, v29
srshl.4s	v4, v4, v29
srshl.4s	v5, v5, v29
sqxtun.4h	v2, v2
sqxtun2.8h	v2, v3
sqxtun.4h	v3, v4
sqxtun2.8h	v3, v5
umin.8h	v2, v2, v31
umin.8h	v3, v3, v31
subs	w5, w5, #2
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x9], x1
b.le	put_6tap_neon
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
mov.16b	v22, v24
b	put_6tap_neon
subs	w4, w4, #8
b.le	put_6tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
add	x2, x2, x3, lsl #1
b	put_6tap_neon
ret	x15
ld1.8h	{ v4, v5 }, [x10], x3
ld1.8h	{ v6, v7 }, [x2], x3
ext.16b	v23, v4, v5, #2
ext.16b	v24, v6, v7, #2
smull.4s	v25, v23, v0[1]
smull2.4s	v26, v23, v0[1]
smull.4s	v27, v24, v0[1]
smull2.4s	v28, v24, v0[1]
ext.16b	v23, v4, v5, #4
ext.16b	v24, v6, v7, #4
smlal.4s	v25, v23, v0[2]
smlal2.4s	v26, v23, v0[2]
smlal.4s	v27, v24, v0[2]
smlal2.4s	v28, v24, v0[2]
ext.16b	v23, v4, v5, #6
ext.16b	v24, v6, v7, #6
smlal.4s	v25, v23, v0[3]
smlal2.4s	v26, v23, v0[3]
smlal.4s	v27, v24, v0[3]
smlal2.4s	v28, v24, v0[3]
ext.16b	v23, v4, v5, #8
ext.16b	v24, v6, v7, #8
smlal.4s	v25, v23, v0[4]
smlal2.4s	v26, v23, v0[4]
smlal.4s	v27, v24, v0[4]
smlal2.4s	v28, v24, v0[4]
ext.16b	v23, v4, v5, #10
ext.16b	v24, v6, v7, #10
smlal.4s	v25, v23, v0[5]
smlal2.4s	v26, v23, v0[5]
smlal.4s	v27, v24, v0[5]
smlal2.4s	v28, v24, v0[5]
ext.16b	v23, v4, v5, #12
ext.16b	v24, v6, v7, #12
smlal.4s	v25, v23, v0[6]
smlal2.4s	v26, v23, v0[6]
smlal.4s	v27, v24, v0[6]
smlal2.4s	v28, v24, v0[6]
srshl.4s	v25, v25, v30
srshl.4s	v26, v26, v30
srshl.4s	v27, v27, v30
srshl.4s	v28, v28, v30
uzp1.8h	v23, v25, v26
uzp1.8h	v24, v27, v28
ret
<unknown>
<unknown>
mov	z4.s, p4/z, #29         ; =0x1d
udf	#1848
_put_bilin_16bpc_neon:
ldr	w8, [sp]
dup.8h	v1, w6
dup.8h	v3, w7
mov	w10, #16
sub	w9, w10, w6
sub	w10, w10, w7
dup.8h	v0, w9
dup.8h	v2, w10
clz	w8, w8
clz	w9, w4
sub	w8, w8, #18
mov	w11, #4
sub	w9, w9, #24
sub	w11, w11, w8
add	w12, w8, #4
cbnz	w6, put_bilin_16bpc_neon
cbnz	w7, put_bilin_16bpc_neon
b	put_neon
cbnz	w7, put_bilin_16bpc_neon
adr	x10, #460
dup.8h	v31, w11
ldrh	w9, [x10, x9, lsl #1]
neg.8h	v31, v31
dup.8h	v30, w8
sub	x10, x10, w9, uxtw
neg.8h	v30, v30
br	x10
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.4h	{ v4 }, [x2], x3
ld1.4h	{ v6 }, [x10], x3
ext.8b	v5, v4, v4, #2
ext.8b	v7, v6, v6, #2
trn1.2s	v4, v4, v6
trn1.2s	v5, v5, v7
subs	w5, w5, #2
mul.4h	v4, v4, v0
mla.4h	v4, v5, v1
urshl.4h	v4, v4, v31
urshl.4h	v4, v4, v30
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x9], x1
b.gt	put_bilin_16bpc_neon
ret
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.8h	{ v4 }, [x2], x3
ld1.8h	{ v6 }, [x10], x3
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
trn1.2d	v4, v4, v6
trn1.2d	v5, v5, v7
subs	w5, w5, #2
mul.8h	v4, v4, v0
mla.8h	v4, v5, v1
urshl.8h	v4, v4, v31
urshl.8h	v4, v4, v30
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x9], x1
b.gt	put_bilin_16bpc_neon
ret
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ldr	h5, [x2, #16]
ldr	h7, [x10, #16]
ld1.8h	{ v4 }, [x2], x3
ld1.8h	{ v6 }, [x10], x3
ext.16b	v5, v4, v5, #2
ext.16b	v7, v6, v7, #2
subs	w5, w5, #2
mul.8h	v4, v4, v0
mla.8h	v4, v5, v1
mul.8h	v6, v6, v0
mla.8h	v6, v7, v1
urshl.8h	v4, v4, v31
urshl.8h	v6, v6, v31
urshl.8h	v4, v4, v30
urshl.8h	v6, v6, v30
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v6 }, [x9], x1
b.gt	put_bilin_16bpc_neon
ret
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
sub	x3, x3, w4, uxtw #1
sub	x3, x3, #16
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
ld1.8h	{ v16 }, [x2], #16
ld1.8h	{ v21 }, [x10], #16
mov	w6, w4
ld1.8h	{ v17, v18 }, [x2], #32
ld1.8h	{ v22, v23 }, [x10], #32
ext.16b	v19, v16, v17, #2
ext.16b	v20, v17, v18, #2
ext.16b	v24, v21, v22, #2
ext.16b	v25, v22, v23, #2
mul.8h	v16, v16, v0
mla.8h	v16, v19, v1
mul.8h	v17, v17, v0
mla.8h	v17, v20, v1
mul.8h	v21, v21, v0
mla.8h	v21, v24, v1
mul.8h	v22, v22, v0
mla.8h	v22, v25, v1
urshl.8h	v16, v16, v31
urshl.8h	v17, v17, v31
urshl.8h	v21, v21, v31
urshl.8h	v22, v22, v31
subs	w6, w6, #16
urshl.8h	v16, v16, v30
urshl.8h	v17, v17, v30
urshl.8h	v21, v21, v30
urshl.8h	v22, v22, v30
st1.8h	{ v16, v17 }, [x0], #32
st1.8h	{ v21, v22 }, [x9], #32
b.le	put_bilin_16bpc_neon
mov.16b	v16, v18
mov.16b	v21, v23
b	put_bilin_16bpc_neon
add	x0, x0, x1
add	x9, x9, x1
add	x2, x2, x3
add	x10, x10, x3
subs	w5, w5, #2
b.gt	put_bilin_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#428
cmp	w5, #4
adr	x10, #492
ldrh	w9, [x10, x9, lsl #1]
sub	x10, x10, w9, uxtw
br	x10
cmp	w5, #2
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.s	{ v16 }[0], [x2], x3
b.gt	put_bilin_16bpc_neon
ld1.s	{ v17 }[0], [x10], x3
ld1.s	{ v18 }[0], [x2], x3
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
mul.4h	v4, v16, v2
mla.4h	v4, v17, v3
urshr.8h	v4, v4, #4
st1.s	{ v4 }[0], [x0]
st1.s	{ v4 }[1], [x9]
ret
ld1.s	{ v17 }[0], [x10], x3
ld1.s	{ v18 }[0], [x2], x3
ld1.s	{ v19 }[0], [x10], x3
ld1.s	{ v20 }[0], [x2], x3
sub	w5, w5, #4
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2d	v16, v16, v18
trn1.2d	v17, v17, v19
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
cmp	w5, #2
urshr.8h	v4, v4, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x9], x1
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x9], x1
b.lt	put_bilin_16bpc_neon
mov.8b	v16, v20
b.eq	put_bilin_16bpc_neon
b	put_bilin_16bpc_neon
ret
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.4h	{ v16 }, [x2], x3
ld1.4h	{ v17 }, [x10], x3
ld1.4h	{ v18 }, [x2], x3
trn1.2d	v16, v16, v17
trn1.2d	v17, v17, v18
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
subs	w5, w5, #2
urshr.8h	v4, v4, #4
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x9], x1
b.le	put_bilin_16bpc_neon
mov.8b	v16, v18
b	put_bilin_16bpc_neon
ret
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8h	{ v16 }, [x2], x3
ld1.8h	{ v17 }, [x10], x3
ld1.8h	{ v18 }, [x2], x3
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
mul.8h	v5, v17, v2
mla.8h	v5, v18, v3
subs	w5, w5, #2
urshr.8h	v4, v4, #4
urshr.8h	v5, v5, #4
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v5 }, [x9], x1
b.le	put_bilin_16bpc_neon
mov.16b	v16, v18
b	put_bilin_16bpc_neon
ret
mov	w7, w5
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8h	{ v16, v17 }, [x2], x3
ld1.8h	{ v18, v19 }, [x10], x3
ld1.8h	{ v20, v21 }, [x2], x3
mul.8h	v4, v16, v2
mla.8h	v4, v18, v3
mul.8h	v5, v17, v2
mla.8h	v5, v19, v3
mul.8h	v6, v18, v2
mla.8h	v6, v20, v3
mul.8h	v7, v19, v2
mla.8h	v7, v21, v3
subs	w5, w5, #2
urshr.8h	v4, v4, #4
urshr.8h	v5, v5, #4
urshr.8h	v6, v6, #4
urshr.8h	v7, v7, #4
st1.8h	{ v4, v5 }, [x0], x1
st1.8h	{ v6, v7 }, [x9], x1
b.le	put_bilin_16bpc_neon
mov.16b	v16, v20
mov.16b	v17, v21
b	put_bilin_16bpc_neon
subs	w4, w4, #16
b.le	put_bilin_16bpc_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #32
add	x0, x0, #32
b	put_bilin_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#476
adr	x10, #504
dup.8h	v31, w11
ldrh	w9, [x10, x9, lsl #1]
neg.8h	v31, v31
dup.4s	v30, w12
sub	x10, x10, w9, uxtw
neg.4s	v30, v30
br	x10
add	x10, x2, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.4h	{ v20 }, [x2], x3
ext.8b	v21, v20, v20, #2
mul.4h	v16, v20, v0
mla.4h	v16, v21, v1
urshl.4h	v16, v16, v31
ld1.4h	{ v22 }, [x10], x3
ld1.4h	{ v24 }, [x2], x3
ext.8b	v23, v22, v22, #2
ext.8b	v25, v24, v24, #2
trn1.2s	v22, v22, v24
trn1.2s	v23, v23, v25
mul.4h	v17, v22, v0
mla.4h	v17, v23, v1
urshl.4h	v17, v17, v31
trn1.2s	v16, v16, v17
umull.4s	v4, v16, v2
umlal.4s	v4, v17, v3
urshl.4s	v4, v4, v30
xtn.4h	v4, v4
subs	w5, w5, #2
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x9], x1
b.le	put_bilin_16bpc_neon
trn2.2s	v16, v17, v17
b	put_bilin_16bpc_neon
ret
add	x10, x2, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8h	{ v20 }, [x2], x3
ext.16b	v21, v20, v20, #2
mul.4h	v16, v20, v0
mla.4h	v16, v21, v1
urshl.4h	v16, v16, v31
ld1.8h	{ v22 }, [x10], x3
ld1.8h	{ v24 }, [x2], x3
ext.16b	v23, v22, v22, #2
ext.16b	v25, v24, v24, #2
trn1.2d	v22, v22, v24
trn1.2d	v23, v23, v25
mul.8h	v17, v22, v0
mla.8h	v17, v23, v1
urshl.8h	v17, v17, v31
trn1.2d	v16, v16, v17
umull.4s	v4, v16, v2
umlal.4s	v4, v17, v3
umull2.4s	v5, v16, v2
umlal2.4s	v5, v17, v3
urshl.4s	v4, v4, v30
urshl.4s	v5, v5, v30
uzp1.8h	v4, v4, v5
subs	w5, w5, #2
st1.d	{ v4 }[0], [x0], x1
st1.d	{ v4 }[1], [x9], x1
b.le	put_bilin_16bpc_neon
trn2.2d	v16, v17, v17
b	put_bilin_16bpc_neon
ret
mov	w7, w5
add	x10, x2, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ldr	h21, [x2, #16]
ld1.8h	{ v20 }, [x2], x3
ext.16b	v21, v20, v21, #2
mul.8h	v16, v20, v0
mla.8h	v16, v21, v1
urshl.8h	v16, v16, v31
ldr	h23, [x10, #16]
ld1.8h	{ v22 }, [x10], x3
ldr	h25, [x2, #16]
ld1.8h	{ v24 }, [x2], x3
ext.16b	v23, v22, v23, #2
ext.16b	v25, v24, v25, #2
mul.8h	v17, v22, v0
mla.8h	v17, v23, v1
mul.8h	v18, v24, v0
mla.8h	v18, v25, v1
urshl.8h	v17, v17, v31
urshl.8h	v18, v18, v31
umull.4s	v4, v16, v2
umlal.4s	v4, v17, v3
umull2.4s	v5, v16, v2
umlal2.4s	v5, v17, v3
umull.4s	v6, v17, v2
umlal.4s	v6, v18, v3
umull2.4s	v7, v17, v2
umlal2.4s	v7, v18, v3
urshl.4s	v4, v4, v30
urshl.4s	v5, v5, v30
urshl.4s	v6, v6, v30
urshl.4s	v7, v7, v30
uzp1.8h	v4, v4, v5
uzp1.8h	v5, v6, v7
subs	w5, w5, #2
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v5 }, [x9], x1
b.le	put_bilin_16bpc_neon
mov.16b	v16, v18
b	put_bilin_16bpc_neon
subs	w4, w4, #8
b.le	put_bilin_16bpc_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_bilin_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#472
_prep_8tap_regular_sharp_16bpc_neon:
mov	w9, #45
mov	w10, #3885
b	prep_8tap_neon
_prep_8tap_smooth_sharp_16bpc_neon:
mov	w9, #1980
mov	w10, #3885
b	prep_8tap_neon
_prep_8tap_sharp_16bpc_neon:
mov	w9, #3885
mov	w10, #3885
b	prep_8tap_neon
_prep_8tap_sharp_regular_16bpc_neon:
mov	w9, #3885
mov	w10, #45
b	prep_8tap_neon
_prep_8tap_sharp_smooth_16bpc_neon:
mov	w9, #3885
mov	w10, #1980
b	prep_8tap_neon
_prep_8tap_neon:
mov	w11, #16513
mul	w5, w5, w11
mul	w6, w6, w11
add	w5, w5, w9
add	w6, w6, w10
ubfx	x8, x3, #0, #32
lsl	x8, x8, #1
dup.8h	v31, w7
clz	w7, w7
clz	w9, w3
sub	w7, w7, #18
mov	w12, #6
tst	w5, #0x1fc000
sub	w9, w9, #24
add	w13, w12, w7
sub	w12, w12, w7
adrp	x11, prep_8tap_neon
add	x11, x11, #0
sub	x11, x11, #8
b.ne	prep_8tap_neon
tst	w6, #0x1fc000
b.ne	prep_8tap_neon
b	prep_neon
cmp	w3, #4
ubfx	w10, w5, #7, #7
and	w5, w5, #0x7f
b.le	prep_8tap_neon
mov	w5, w10
tst	w6, #0x1fc000
add	x5, x11, w5, uxtw #3
b.ne	prep_8tap_neon
adr	x10, #484
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
movi.8h	v28, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
sub	x1, x1, #2
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v16 }, [x1], x2
ld1.8h	{ v20 }, [x10], x2
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w4, w4, #2
smull.4s	v16, v16, v0[0]
smlal.4s	v16, v17, v0[1]
smlal.4s	v16, v18, v0[2]
smlal.4s	v16, v19, v0[3]
smull.4s	v20, v20, v0[0]
smlal.4s	v20, v21, v0[1]
smlal.4s	v20, v22, v0[2]
smlal.4s	v20, v23, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v20, v20, v30
uzp1.8h	v16, v16, v20
sub.8h	v16, v16, v28
st1.d	{ v16 }[0], [x0], x8
st1.d	{ v16 }[1], [x9], x8
b.gt	prep_8tap_neon
ret
ld1.8b	{ v0 }, [x5]
sub	x1, x1, #6
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
sub	x2, x2, w3, uxtw #1
sub	x2, x2, #16
ld1.8h	{ v16, v17 }, [x1], #32
ld1.8h	{ v20, v21 }, [x10], #32
mov	w5, w3
smull.4s	v18, v16, v0[0]
smull2.4s	v19, v16, v0[0]
smull.4s	v22, v20, v0[0]
smull2.4s	v23, v20, v0[0]
ext.16b	v24, v16, v17, #2
ext.16b	v25, v20, v21, #2
smlal.4s	v18, v24, v0[1]
smlal2.4s	v19, v24, v0[1]
smlal.4s	v22, v25, v0[1]
smlal2.4s	v23, v25, v0[1]
ext.16b	v24, v16, v17, #4
ext.16b	v25, v20, v21, #4
smlal.4s	v18, v24, v0[2]
smlal2.4s	v19, v24, v0[2]
smlal.4s	v22, v25, v0[2]
smlal2.4s	v23, v25, v0[2]
ext.16b	v24, v16, v17, #6
ext.16b	v25, v20, v21, #6
smlal.4s	v18, v24, v0[3]
smlal2.4s	v19, v24, v0[3]
smlal.4s	v22, v25, v0[3]
smlal2.4s	v23, v25, v0[3]
ext.16b	v24, v16, v17, #8
ext.16b	v25, v20, v21, #8
smlal.4s	v18, v24, v0[4]
smlal2.4s	v19, v24, v0[4]
smlal.4s	v22, v25, v0[4]
smlal2.4s	v23, v25, v0[4]
ext.16b	v24, v16, v17, #10
ext.16b	v25, v20, v21, #10
smlal.4s	v18, v24, v0[5]
smlal2.4s	v19, v24, v0[5]
smlal.4s	v22, v25, v0[5]
smlal2.4s	v23, v25, v0[5]
ext.16b	v24, v16, v17, #12
ext.16b	v25, v20, v21, #12
smlal.4s	v18, v24, v0[6]
smlal2.4s	v19, v24, v0[6]
smlal.4s	v22, v25, v0[6]
smlal2.4s	v23, v25, v0[6]
ext.16b	v24, v16, v17, #14
ext.16b	v25, v20, v21, #14
smlal.4s	v18, v24, v0[7]
smlal2.4s	v19, v24, v0[7]
smlal.4s	v22, v25, v0[7]
smlal2.4s	v23, v25, v0[7]
subs	w5, w5, #8
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
srshl.4s	v22, v22, v30
srshl.4s	v23, v23, v30
uzp1.8h	v18, v18, v19
uzp1.8h	v22, v22, v23
sub.8h	v18, v18, v28
sub.8h	v22, v22, v28
st1.8h	{ v18 }, [x0], #16
st1.8h	{ v22 }, [x9], #16
b.le	prep_8tap_neon
mov.16b	v16, v17
mov.16b	v20, v21
ld1.8h	{ v17 }, [x1], #16
ld1.8h	{ v21 }, [x10], #16
b	prep_8tap_neon
add	x0, x0, x8
add	x9, x9, x8
add	x1, x1, x2
add	x10, x10, x2
subs	w4, w4, #2
b.gt	prep_8tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#456
cmp	w4, #4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_8tap_neon
mov	w6, w10
add	x6, x11, w6, uxtw #3
dup.4s	v30, w12
movi.8h	v29, #32, lsl #8
adr	x10, #1576
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
sub	x10, x10, w9, uxtw
br	x10
b.gt	prep_8tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v1 }, [x1], x2
ld1.4h	{ v2 }, [x10], x2
ld1.4h	{ v3 }, [x1], x2
ld1.4h	{ v4 }, [x10], x2
ld1.4h	{ v5 }, [x1], x2
smull.4s	v6, v1, v0[0]
smlal.4s	v6, v2, v0[1]
smlal.4s	v6, v3, v0[2]
smlal.4s	v6, v4, v0[3]
smull.4s	v7, v2, v0[0]
smlal.4s	v7, v3, v0[1]
smlal.4s	v7, v4, v0[2]
smlal.4s	v7, v5, v0[3]
srshl.4s	v6, v6, v30
srshl.4s	v7, v7, v30
uzp1.8h	v6, v6, v7
sub.8h	v6, v6, v29
st1.d	{ v6 }[0], [x0], x8
st1.d	{ v6 }[1], [x9], x8
b.le	prep_8tap_neon
ld1.4h	{ v6 }, [x10], x2
ld1.4h	{ v7 }, [x1], x2
smull.4s	v1, v3, v0[0]
smlal.4s	v1, v4, v0[1]
smlal.4s	v1, v5, v0[2]
smlal.4s	v1, v6, v0[3]
smull.4s	v2, v4, v0[0]
smlal.4s	v2, v5, v0[1]
smlal.4s	v2, v6, v0[2]
smlal.4s	v2, v7, v0[3]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
uzp1.8h	v1, v1, v2
sub.8h	v1, v1, v29
st1.d	{ v1 }[0], [x0], x8
st1.d	{ v1 }[1], [x9], x8
ret
ld1.8b	{ v0 }, [x6]
sub	x10, x1, x2, lsl #1
add	x9, x0, x8
sub	x1, x10, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v16 }, [x1], x2
ld1.4h	{ v17 }, [x10], x2
ld1.4h	{ v18 }, [x1], x2
ld1.4h	{ v19 }, [x10], x2
ld1.4h	{ v20 }, [x1], x2
ld1.4h	{ v21 }, [x10], x2
ld1.4h	{ v22 }, [x1], x2
subs	w4, w4, #4
ld1.4h	{ v23 }, [x10], x2
ld1.4h	{ v24 }, [x1], x2
ld1.4h	{ v25 }, [x10], x2
ld1.4h	{ v26 }, [x1], x2
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smlal.4s	v1, v23, v0[7]
smull.4s	v2, v17, v0[0]
smlal.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
smlal.4s	v2, v24, v0[7]
smull.4s	v3, v18, v0[0]
smlal.4s	v3, v19, v0[1]
smlal.4s	v3, v20, v0[2]
smlal.4s	v3, v21, v0[3]
smlal.4s	v3, v22, v0[4]
smlal.4s	v3, v23, v0[5]
smlal.4s	v3, v24, v0[6]
smlal.4s	v3, v25, v0[7]
smull.4s	v4, v19, v0[0]
smlal.4s	v4, v20, v0[1]
smlal.4s	v4, v21, v0[2]
smlal.4s	v4, v22, v0[3]
smlal.4s	v4, v23, v0[4]
smlal.4s	v4, v24, v0[5]
smlal.4s	v4, v25, v0[6]
smlal.4s	v4, v26, v0[7]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v3, v3, v29
st1.d	{ v1 }[0], [x0], x8
st1.d	{ v1 }[1], [x9], x8
st1.d	{ v3 }[0], [x0], x8
st1.d	{ v3 }[1], [x9], x8
b.le	prep_8tap_neon
cmp	w4, #2
mov.8b	v16, v20
mov.8b	v17, v21
mov.8b	v18, v22
mov.8b	v19, v23
mov.8b	v20, v24
mov.8b	v21, v25
mov.8b	v22, v26
b.eq	prep_8tap_neon
b	prep_8tap_neon
ld1.4h	{ v23 }, [x10], x2
ld1.4h	{ v24 }, [x1], x2
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smlal.4s	v1, v23, v0[7]
smull.4s	v2, v17, v0[0]
smlal.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
smlal.4s	v2, v24, v0[7]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
uzp1.8h	v1, v1, v2
sub.8h	v1, v1, v29
st1.d	{ v1 }[0], [x0], x8
st1.d	{ v1 }[1], [x9], x8
ret
b.gt	prep_8tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v1 }, [x1], x2
ld1.8h	{ v2 }, [x10], x2
ld1.8h	{ v3 }, [x1], x2
ld1.8h	{ v4 }, [x10], x2
ld1.8h	{ v5 }, [x1], x2
smull.4s	v16, v1, v0[0]
smlal.4s	v16, v2, v0[1]
smlal.4s	v16, v3, v0[2]
smlal.4s	v16, v4, v0[3]
smull2.4s	v17, v1, v0[0]
smlal2.4s	v17, v2, v0[1]
smlal2.4s	v17, v3, v0[2]
smlal2.4s	v17, v4, v0[3]
smull.4s	v18, v2, v0[0]
smlal.4s	v18, v3, v0[1]
smlal.4s	v18, v4, v0[2]
smlal.4s	v18, v5, v0[3]
smull2.4s	v19, v2, v0[0]
smlal2.4s	v19, v3, v0[1]
smlal2.4s	v19, v4, v0[2]
smlal2.4s	v19, v5, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v17, v17, v30
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
uzp1.8h	v16, v16, v17
uzp1.8h	v18, v18, v19
sub.8h	v16, v16, v29
sub.8h	v18, v18, v29
st1.8h	{ v16 }, [x0], x8
st1.8h	{ v18 }, [x9], x8
b.le	prep_8tap_neon
ld1.8h	{ v6 }, [x10], x2
ld1.8h	{ v7 }, [x1], x2
smull.4s	v16, v3, v0[0]
smlal.4s	v16, v4, v0[1]
smlal.4s	v16, v5, v0[2]
smlal.4s	v16, v6, v0[3]
smull2.4s	v17, v3, v0[0]
smlal2.4s	v17, v4, v0[1]
smlal2.4s	v17, v5, v0[2]
smlal2.4s	v17, v6, v0[3]
smull.4s	v18, v4, v0[0]
smlal.4s	v18, v5, v0[1]
smlal.4s	v18, v6, v0[2]
smlal.4s	v18, v7, v0[3]
smull2.4s	v19, v4, v0[0]
smlal2.4s	v19, v5, v0[1]
smlal2.4s	v19, v6, v0[2]
smlal2.4s	v19, v7, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v17, v17, v30
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
uzp1.8h	v16, v16, v17
uzp1.8h	v18, v18, v19
sub.8h	v16, v16, v29
sub.8h	v18, v18, v29
st1.8h	{ v16 }, [x0], x8
st1.8h	{ v18 }, [x9], x8
ret
ld1.8b	{ v0 }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1.8h	{ v16 }, [x1], x2
ld1.8h	{ v17 }, [x10], x2
ld1.8h	{ v18 }, [x1], x2
ld1.8h	{ v19 }, [x10], x2
ld1.8h	{ v20 }, [x1], x2
ld1.8h	{ v21 }, [x10], x2
ld1.8h	{ v22 }, [x1], x2
subs	w4, w4, #2
ld1.8h	{ v23 }, [x10], x2
ld1.8h	{ v24 }, [x1], x2
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smlal.4s	v1, v23, v0[7]
smull2.4s	v2, v16, v0[0]
smlal2.4s	v2, v17, v0[1]
smlal2.4s	v2, v18, v0[2]
smlal2.4s	v2, v19, v0[3]
smlal2.4s	v2, v20, v0[4]
smlal2.4s	v2, v21, v0[5]
smlal2.4s	v2, v22, v0[6]
smlal2.4s	v2, v23, v0[7]
smull.4s	v3, v17, v0[0]
smlal.4s	v3, v18, v0[1]
smlal.4s	v3, v19, v0[2]
smlal.4s	v3, v20, v0[3]
smlal.4s	v3, v21, v0[4]
smlal.4s	v3, v22, v0[5]
smlal.4s	v3, v23, v0[6]
smlal.4s	v3, v24, v0[7]
smull2.4s	v4, v17, v0[0]
smlal2.4s	v4, v18, v0[1]
smlal2.4s	v4, v19, v0[2]
smlal2.4s	v4, v20, v0[3]
smlal2.4s	v4, v21, v0[4]
smlal2.4s	v4, v22, v0[5]
smlal2.4s	v4, v23, v0[6]
smlal2.4s	v4, v24, v0[7]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v3, v3, v29
st1.8h	{ v1 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_8tap_neon
subs	w4, w4, #2
ld1.8h	{ v25 }, [x10], x2
ld1.8h	{ v26 }, [x1], x2
smull.4s	v1, v18, v0[0]
smlal.4s	v1, v19, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v21, v0[3]
smlal.4s	v1, v22, v0[4]
smlal.4s	v1, v23, v0[5]
smlal.4s	v1, v24, v0[6]
smlal.4s	v1, v25, v0[7]
smull2.4s	v2, v18, v0[0]
smlal2.4s	v2, v19, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v21, v0[3]
smlal2.4s	v2, v22, v0[4]
smlal2.4s	v2, v23, v0[5]
smlal2.4s	v2, v24, v0[6]
smlal2.4s	v2, v25, v0[7]
smull.4s	v3, v19, v0[0]
smlal.4s	v3, v20, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v22, v0[3]
smlal.4s	v3, v23, v0[4]
smlal.4s	v3, v24, v0[5]
smlal.4s	v3, v25, v0[6]
smlal.4s	v3, v26, v0[7]
smull2.4s	v4, v19, v0[0]
smlal2.4s	v4, v20, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v22, v0[3]
smlal2.4s	v4, v23, v0[4]
smlal2.4s	v4, v24, v0[5]
smlal2.4s	v4, v25, v0[6]
smlal2.4s	v4, v26, v0[7]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v3, v3, v29
st1.8h	{ v1 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_8tap_neon
mov.16b	v16, v20
mov.16b	v17, v21
mov.16b	v18, v22
mov.16b	v19, v23
mov.16b	v20, v24
mov.16b	v21, v25
mov.16b	v22, v26
b	prep_8tap_neon
subs	w3, w3, #8
b.le	prep_8tap_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
b	prep_8tap_neon
ret
b.gt	prep_8tap_neon
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
sshll.8h	v0, v0, #0
ld1.8h	{ v16, v17 }, [x1], x2
ld1.8h	{ v18, v19 }, [x1], x2
ld1.8h	{ v20, v21 }, [x1], x2
ld1.8h	{ v22, v23 }, [x1], x2
subs	w4, w4, #1
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v18, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v22, v0[3]
smull2.4s	v2, v16, v0[0]
smlal2.4s	v2, v18, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v22, v0[3]
smull.4s	v3, v17, v0[0]
smlal.4s	v3, v19, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v23, v0[3]
smull2.4s	v4, v17, v0[0]
smlal2.4s	v4, v19, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v23, v0[3]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v2, v3, v29
st1.8h	{ v1, v2 }, [x0], x8
b.le	prep_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
b	prep_8tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#1556
cmp	w4, #4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_8tap_neon
mov	w6, w10
add	x6, x11, w6, uxtw #3
adr	x10, #1556
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
movi.8h	v29, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
b.gt	prep_8tap_neon
add	x6, x6, #2
ld1.s	{ v1 }[0], [x6]
sub	x10, x1, #2
sub	x1, x10, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x1], x2
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v16, v16
bl	prep_8tap_neon
mov.8b	v17, v24
mov.8b	v18, v25
bl	prep_8tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v24, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v24, v1[2]
smlal.4s	v3, v25, v1[3]
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
sub.8h	v2, v2, v29
subs	w4, w4, #2
st1.d	{ v2 }[0], [x0], x8
st1.d	{ v2 }[1], [x9], x8
b.le	prep_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v24
mov.8b	v18, v25
b	prep_8tap_neon
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #2
sub	x10, x1, x2, lsl #1
sub	x1, x10, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x1], x2
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v16, v16
bl	prep_8tap_neon
mov.8b	v17, v24
mov.8b	v18, v25
bl	prep_8tap_neon
mov.8b	v19, v24
mov.8b	v20, v25
bl	prep_8tap_neon
mov.8b	v21, v24
mov.8b	v22, v25
bl	prep_8tap_neon
smull.4s	v3, v16, v1[0]
smlal.4s	v3, v17, v1[1]
smlal.4s	v3, v18, v1[2]
smlal.4s	v3, v19, v1[3]
smlal.4s	v3, v20, v1[4]
smlal.4s	v3, v21, v1[5]
smlal.4s	v3, v22, v1[6]
smlal.4s	v3, v24, v1[7]
smull.4s	v4, v17, v1[0]
smlal.4s	v4, v18, v1[1]
smlal.4s	v4, v19, v1[2]
smlal.4s	v4, v20, v1[3]
smlal.4s	v4, v21, v1[4]
smlal.4s	v4, v22, v1[5]
smlal.4s	v4, v24, v1[6]
smlal.4s	v4, v25, v1[7]
rshrn.4h	v3, v3, #6
rshrn2.8h	v3, v4, #6
sub.8h	v3, v3, v29
subs	w4, w4, #2
st1.d	{ v3 }[0], [x0], x8
st1.d	{ v3 }[1], [x9], x8
b.le	prep_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v24
mov.8b	v22, v25
b	prep_8tap_neon
ret	x15
ld1.8h	{ v24 }, [x10], x2
ld1.8h	{ v25 }, [x1], x2
ext.16b	v26, v24, v24, #2
ext.16b	v27, v24, v24, #4
ext.16b	v28, v24, v24, #6
smull.4s	v24, v24, v0[0]
smlal.4s	v24, v26, v0[1]
smlal.4s	v24, v27, v0[2]
smlal.4s	v24, v28, v0[3]
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
xtn.4h	v24, v24
xtn.4h	v25, v25
ret
b.gt	prep_8tap_neon
add	x6, x6, #2
ld1.8b	{ v0 }, [x5]
ld1.s	{ v1 }[0], [x6]
sub	x1, x1, #6
sub	x1, x1, x2
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1.8h	{ v27, v28 }, [x1], x2
smull.4s	v24, v27, v0[0]
smull2.4s	v25, v27, v0[0]
ext.16b	v26, v27, v28, #2
smlal.4s	v24, v26, v0[1]
smlal2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
ext.16b	v26, v27, v28, #14
smlal.4s	v24, v26, v0[7]
smlal2.4s	v25, v26, v0[7]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v16, v24, v25
bl	prep_8tap_neon
mov.16b	v17, v23
mov.16b	v18, v24
smull.4s	v2, v16, v1[0]
smull2.4s	v3, v16, v1[0]
bl	prep_8tap_neon
smull.4s	v4, v17, v1[0]
smull2.4s	v5, v17, v1[0]
smlal.4s	v2, v17, v1[1]
smlal2.4s	v3, v17, v1[1]
smlal.4s	v4, v18, v1[1]
smlal2.4s	v5, v18, v1[1]
smlal.4s	v2, v18, v1[2]
smlal2.4s	v3, v18, v1[2]
smlal.4s	v4, v23, v1[2]
smlal2.4s	v5, v23, v1[2]
smlal.4s	v2, v23, v1[3]
smlal2.4s	v3, v23, v1[3]
smlal.4s	v4, v24, v1[3]
smlal2.4s	v5, v24, v1[3]
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
rshrn.4h	v3, v4, #6
rshrn2.8h	v3, v5, #6
sub.8h	v2, v2, v29
sub.8h	v3, v3, v29
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v23
mov.16b	v18, v24
b	prep_8tap_neon
subs	w3, w3, #8
b.le	prep_8tap_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
b	prep_8tap_neon
ld1.8b	{ v0 }, [x5]
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #6
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1.8h	{ v27, v28 }, [x1], x2
smull.4s	v24, v27, v0[0]
smull2.4s	v25, v27, v0[0]
ext.16b	v26, v27, v28, #2
smlal.4s	v24, v26, v0[1]
smlal2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
ext.16b	v26, v27, v28, #14
smlal.4s	v24, v26, v0[7]
smlal2.4s	v25, v26, v0[7]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v16, v24, v25
bl	prep_8tap_neon
mov.16b	v17, v23
mov.16b	v18, v24
bl	prep_8tap_neon
mov.16b	v19, v23
mov.16b	v20, v24
bl	prep_8tap_neon
mov.16b	v21, v23
mov.16b	v22, v24
smull.4s	v2, v16, v1[0]
smull2.4s	v3, v16, v1[0]
bl	prep_8tap_neon
smull.4s	v4, v17, v1[0]
smull2.4s	v5, v17, v1[0]
smlal.4s	v2, v17, v1[1]
smlal2.4s	v3, v17, v1[1]
smlal.4s	v4, v18, v1[1]
smlal2.4s	v5, v18, v1[1]
smlal.4s	v2, v18, v1[2]
smlal2.4s	v3, v18, v1[2]
smlal.4s	v4, v19, v1[2]
smlal2.4s	v5, v19, v1[2]
smlal.4s	v2, v19, v1[3]
smlal2.4s	v3, v19, v1[3]
smlal.4s	v4, v20, v1[3]
smlal2.4s	v5, v20, v1[3]
smlal.4s	v2, v20, v1[4]
smlal2.4s	v3, v20, v1[4]
smlal.4s	v4, v21, v1[4]
smlal2.4s	v5, v21, v1[4]
smlal.4s	v2, v21, v1[5]
smlal2.4s	v3, v21, v1[5]
smlal.4s	v4, v22, v1[5]
smlal2.4s	v5, v22, v1[5]
smlal.4s	v2, v22, v1[6]
smlal2.4s	v3, v22, v1[6]
smlal.4s	v4, v23, v1[6]
smlal2.4s	v5, v23, v1[6]
smlal.4s	v2, v23, v1[7]
smlal2.4s	v3, v23, v1[7]
smlal.4s	v4, v24, v1[7]
smlal2.4s	v5, v24, v1[7]
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
rshrn.4h	v3, v4, #6
rshrn2.8h	v3, v5, #6
sub.8h	v2, v2, v29
sub.8h	v3, v3, v29
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
mov.16b	v22, v24
b	prep_8tap_neon
subs	w3, w3, #8
b.le	prep_8tap_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
b	prep_8tap_neon
ret	x15
ld1.8h	{ v4, v5 }, [x10], x2
ld1.8h	{ v6, v7 }, [x1], x2
smull.4s	v25, v4, v0[0]
smull2.4s	v26, v4, v0[0]
smull.4s	v27, v6, v0[0]
smull2.4s	v28, v6, v0[0]
ext.16b	v23, v4, v5, #2
ext.16b	v24, v6, v7, #2
smlal.4s	v25, v23, v0[1]
smlal2.4s	v26, v23, v0[1]
smlal.4s	v27, v24, v0[1]
smlal2.4s	v28, v24, v0[1]
ext.16b	v23, v4, v5, #4
ext.16b	v24, v6, v7, #4
smlal.4s	v25, v23, v0[2]
smlal2.4s	v26, v23, v0[2]
smlal.4s	v27, v24, v0[2]
smlal2.4s	v28, v24, v0[2]
ext.16b	v23, v4, v5, #6
ext.16b	v24, v6, v7, #6
smlal.4s	v25, v23, v0[3]
smlal2.4s	v26, v23, v0[3]
smlal.4s	v27, v24, v0[3]
smlal2.4s	v28, v24, v0[3]
ext.16b	v23, v4, v5, #8
ext.16b	v24, v6, v7, #8
smlal.4s	v25, v23, v0[4]
smlal2.4s	v26, v23, v0[4]
smlal.4s	v27, v24, v0[4]
smlal2.4s	v28, v24, v0[4]
ext.16b	v23, v4, v5, #10
ext.16b	v24, v6, v7, #10
smlal.4s	v25, v23, v0[5]
smlal2.4s	v26, v23, v0[5]
smlal.4s	v27, v24, v0[5]
smlal2.4s	v28, v24, v0[5]
ext.16b	v23, v4, v5, #12
ext.16b	v24, v6, v7, #12
smlal.4s	v25, v23, v0[6]
smlal2.4s	v26, v23, v0[6]
smlal.4s	v27, v24, v0[6]
smlal2.4s	v28, v24, v0[6]
ext.16b	v23, v4, v5, #14
ext.16b	v24, v6, v7, #14
smlal.4s	v25, v23, v0[7]
smlal2.4s	v26, v23, v0[7]
smlal.4s	v27, v24, v0[7]
smlal2.4s	v28, v24, v0[7]
srshl.4s	v25, v25, v30
srshl.4s	v26, v26, v30
srshl.4s	v27, v27, v30
srshl.4s	v28, v28, v30
uzp1.8h	v23, v25, v26
uzp1.8h	v24, v27, v28
ret
<unknown>
<unknown>
<unknown>
udf	#1528
_prep_8tap_regular_16bpc_neon:
mov	w9, #45
mov	w10, #45
b	prep_6tap_neon
_prep_8tap_regular_smooth_16bpc_neon:
mov	w9, #45
mov	w10, #1980
b	prep_6tap_neon
_prep_8tap_smooth_16bpc_neon:
mov	w9, #1980
mov	w10, #1980
b	prep_6tap_neon
_prep_8tap_smooth_regular_16bpc_neon:
mov	w9, #1980
mov	w10, #45
b	prep_6tap_neon
_prep_6tap_neon:
mov	w11, #16513
mul	w5, w5, w11
mul	w6, w6, w11
add	w5, w5, w9
add	w6, w6, w10
ubfx	x8, x3, #0, #32
lsl	x8, x8, #1
dup.8h	v31, w7
clz	w7, w7
clz	w9, w3
sub	w7, w7, #18
mov	w12, #6
tst	w5, #0x1fc000
sub	w9, w9, #24
add	w13, w12, w7
sub	w12, w12, w7
adrp	x11, prep_6tap_neon
add	x11, x11, #0
sub	x11, x11, #8
b.ne	prep_6tap_neon
tst	w6, #0x1fc000
b.ne	prep_6tap_neon
b	prep_neon
cmp	w3, #4
ubfx	w10, w5, #7, #7
and	w5, w5, #0x7f
b.le	prep_6tap_neon
mov	w5, w10
tst	w6, #0x1fc000
add	x5, x11, w5, uxtw #3
b.ne	prep_6tap_neon
adr	x10, #444
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
movi.8h	v28, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
sub	x1, x1, #2
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v16 }, [x1], x2
ld1.8h	{ v20 }, [x10], x2
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w4, w4, #2
smull.4s	v16, v16, v0[0]
smlal.4s	v16, v17, v0[1]
smlal.4s	v16, v18, v0[2]
smlal.4s	v16, v19, v0[3]
smull.4s	v20, v20, v0[0]
smlal.4s	v20, v21, v0[1]
smlal.4s	v20, v22, v0[2]
smlal.4s	v20, v23, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v20, v20, v30
uzp1.8h	v16, v16, v20
sub.8h	v16, v16, v28
st1.d	{ v16 }[0], [x0], x8
st1.d	{ v16 }[1], [x9], x8
b.gt	prep_6tap_neon
ret
ld1.8b	{ v0 }, [x5]
sub	x1, x1, #6
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
sub	x2, x2, w3, uxtw #1
sub	x2, x2, #16
ld1.8h	{ v16, v17 }, [x1], #32
ld1.8h	{ v20, v21 }, [x10], #32
mov	w5, w3
ext.16b	v24, v16, v17, #2
ext.16b	v25, v20, v21, #2
smull.4s	v18, v24, v0[1]
smull2.4s	v19, v24, v0[1]
smull.4s	v22, v25, v0[1]
smull2.4s	v23, v25, v0[1]
ext.16b	v24, v16, v17, #4
ext.16b	v25, v20, v21, #4
smlal.4s	v18, v24, v0[2]
smlal2.4s	v19, v24, v0[2]
smlal.4s	v22, v25, v0[2]
smlal2.4s	v23, v25, v0[2]
ext.16b	v24, v16, v17, #6
ext.16b	v25, v20, v21, #6
smlal.4s	v18, v24, v0[3]
smlal2.4s	v19, v24, v0[3]
smlal.4s	v22, v25, v0[3]
smlal2.4s	v23, v25, v0[3]
ext.16b	v24, v16, v17, #8
ext.16b	v25, v20, v21, #8
smlal.4s	v18, v24, v0[4]
smlal2.4s	v19, v24, v0[4]
smlal.4s	v22, v25, v0[4]
smlal2.4s	v23, v25, v0[4]
ext.16b	v24, v16, v17, #10
ext.16b	v25, v20, v21, #10
smlal.4s	v18, v24, v0[5]
smlal2.4s	v19, v24, v0[5]
smlal.4s	v22, v25, v0[5]
smlal2.4s	v23, v25, v0[5]
ext.16b	v24, v16, v17, #12
ext.16b	v25, v20, v21, #12
smlal.4s	v18, v24, v0[6]
smlal2.4s	v19, v24, v0[6]
smlal.4s	v22, v25, v0[6]
smlal2.4s	v23, v25, v0[6]
subs	w5, w5, #8
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
srshl.4s	v22, v22, v30
srshl.4s	v23, v23, v30
uzp1.8h	v18, v18, v19
uzp1.8h	v22, v22, v23
sub.8h	v18, v18, v28
sub.8h	v22, v22, v28
st1.8h	{ v18 }, [x0], #16
st1.8h	{ v22 }, [x9], #16
b.le	prep_6tap_neon
mov.16b	v16, v17
mov.16b	v20, v21
ld1.8h	{ v17 }, [x1], #16
ld1.8h	{ v21 }, [x10], #16
b	prep_6tap_neon
add	x0, x0, x8
add	x9, x9, x8
add	x1, x1, x2
add	x10, x10, x2
subs	w4, w4, #2
b.gt	prep_6tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#416
cmp	w4, #4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_6tap_neon
mov	w6, w10
add	x6, x11, w6, uxtw #3
dup.4s	v30, w12
movi.8h	v29, #32, lsl #8
adr	x10, #1464
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
sub	x10, x10, w9, uxtw
br	x10
b.gt	prep_6tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v1 }, [x1], x2
ld1.4h	{ v2 }, [x10], x2
ld1.4h	{ v3 }, [x1], x2
ld1.4h	{ v4 }, [x10], x2
ld1.4h	{ v5 }, [x1], x2
smull.4s	v6, v1, v0[0]
smlal.4s	v6, v2, v0[1]
smlal.4s	v6, v3, v0[2]
smlal.4s	v6, v4, v0[3]
smull.4s	v7, v2, v0[0]
smlal.4s	v7, v3, v0[1]
smlal.4s	v7, v4, v0[2]
smlal.4s	v7, v5, v0[3]
srshl.4s	v6, v6, v30
srshl.4s	v7, v7, v30
uzp1.8h	v6, v6, v7
sub.8h	v6, v6, v29
st1.d	{ v6 }[0], [x0], x8
st1.d	{ v6 }[1], [x9], x8
b.le	prep_6tap_neon
ld1.4h	{ v6 }, [x10], x2
ld1.4h	{ v7 }, [x1], x2
smull.4s	v1, v3, v0[0]
smlal.4s	v1, v4, v0[1]
smlal.4s	v1, v5, v0[2]
smlal.4s	v1, v6, v0[3]
smull.4s	v2, v4, v0[0]
smlal.4s	v2, v5, v0[1]
smlal.4s	v2, v6, v0[2]
smlal.4s	v2, v7, v0[3]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
uzp1.8h	v1, v1, v2
sub.8h	v1, v1, v29
st1.d	{ v1 }[0], [x0], x8
st1.d	{ v1 }[1], [x9], x8
ret
ld1.8b	{ v0 }, [x6]
sub	x10, x1, x2, lsl #1
add	x9, x0, x8
sub	x1, x10, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
ld1.4h	{ v16 }, [x1], x2
ld1.4h	{ v17 }, [x10], x2
ld1.4h	{ v18 }, [x1], x2
ld1.4h	{ v19 }, [x10], x2
ld1.4h	{ v20 }, [x1], x2
ld1.4h	{ v21 }, [x10], x2
ld1.4h	{ v22 }, [x1], x2
subs	w4, w4, #4
ld1.4h	{ v23 }, [x10], x2
ld1.4h	{ v24 }, [x1], x2
ld1.4h	{ v25 }, [x10], x2
ld1.4h	{ v26 }, [x1], x2
smull.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smull.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
smull.4s	v3, v19, v0[1]
smlal.4s	v3, v20, v0[2]
smlal.4s	v3, v21, v0[3]
smlal.4s	v3, v22, v0[4]
smlal.4s	v3, v23, v0[5]
smlal.4s	v3, v24, v0[6]
smull.4s	v4, v20, v0[1]
smlal.4s	v4, v21, v0[2]
smlal.4s	v4, v22, v0[3]
smlal.4s	v4, v23, v0[4]
smlal.4s	v4, v24, v0[5]
smlal.4s	v4, v25, v0[6]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v3, v3, v29
st1.d	{ v1 }[0], [x0], x8
st1.d	{ v1 }[1], [x9], x8
st1.d	{ v3 }[0], [x0], x8
st1.d	{ v3 }[1], [x9], x8
b.le	prep_6tap_neon
cmp	w4, #2
mov.8b	v16, v20
mov.8b	v17, v21
mov.8b	v18, v22
mov.8b	v19, v23
mov.8b	v20, v24
mov.8b	v21, v25
mov.8b	v22, v26
b.eq	prep_6tap_neon
b	prep_6tap_neon
ld1.4h	{ v23 }, [x10], x2
ld1.4h	{ v24 }, [x1], x2
smull.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smull.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v21, v0[4]
smlal.4s	v2, v22, v0[5]
smlal.4s	v2, v23, v0[6]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
uzp1.8h	v1, v1, v2
sub.8h	v1, v1, v29
st1.d	{ v1 }[0], [x0], x8
st1.d	{ v1 }[1], [x9], x8
ret
b.gt	prep_6tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
ld1.8h	{ v1 }, [x1], x2
ld1.8h	{ v2 }, [x10], x2
ld1.8h	{ v3 }, [x1], x2
ld1.8h	{ v4 }, [x10], x2
ld1.8h	{ v5 }, [x1], x2
smull.4s	v16, v1, v0[0]
smlal.4s	v16, v2, v0[1]
smlal.4s	v16, v3, v0[2]
smlal.4s	v16, v4, v0[3]
smull2.4s	v17, v1, v0[0]
smlal2.4s	v17, v2, v0[1]
smlal2.4s	v17, v3, v0[2]
smlal2.4s	v17, v4, v0[3]
smull.4s	v18, v2, v0[0]
smlal.4s	v18, v3, v0[1]
smlal.4s	v18, v4, v0[2]
smlal.4s	v18, v5, v0[3]
smull2.4s	v19, v2, v0[0]
smlal2.4s	v19, v3, v0[1]
smlal2.4s	v19, v4, v0[2]
smlal2.4s	v19, v5, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v17, v17, v30
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
uzp1.8h	v16, v16, v17
uzp1.8h	v18, v18, v19
sub.8h	v16, v16, v29
sub.8h	v18, v18, v29
st1.8h	{ v16 }, [x0], x8
st1.8h	{ v18 }, [x9], x8
b.le	prep_6tap_neon
ld1.8h	{ v6 }, [x10], x2
ld1.8h	{ v7 }, [x1], x2
smull.4s	v16, v3, v0[0]
smlal.4s	v16, v4, v0[1]
smlal.4s	v16, v5, v0[2]
smlal.4s	v16, v6, v0[3]
smull2.4s	v17, v3, v0[0]
smlal2.4s	v17, v4, v0[1]
smlal2.4s	v17, v5, v0[2]
smlal2.4s	v17, v6, v0[3]
smull.4s	v18, v4, v0[0]
smlal.4s	v18, v5, v0[1]
smlal.4s	v18, v6, v0[2]
smlal.4s	v18, v7, v0[3]
smull2.4s	v19, v4, v0[0]
smlal2.4s	v19, v5, v0[1]
smlal2.4s	v19, v6, v0[2]
smlal2.4s	v19, v7, v0[3]
srshl.4s	v16, v16, v30
srshl.4s	v17, v17, v30
srshl.4s	v18, v18, v30
srshl.4s	v19, v19, v30
uzp1.8h	v16, v16, v17
uzp1.8h	v18, v18, v19
sub.8h	v16, v16, v29
sub.8h	v18, v18, v29
st1.8h	{ v16 }, [x0], x8
st1.8h	{ v18 }, [x9], x8
ret
ld1.8b	{ v0 }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1.8h	{ v16 }, [x1], x2
ld1.8h	{ v17 }, [x10], x2
ld1.8h	{ v18 }, [x1], x2
ld1.8h	{ v19 }, [x10], x2
ld1.8h	{ v20 }, [x1], x2
ld1.8h	{ v21 }, [x10], x2
ld1.8h	{ v22 }, [x1], x2
subs	w4, w4, #2
ld1.8h	{ v23 }, [x10], x2
ld1.8h	{ v24 }, [x1], x2
smull.4s	v1, v17, v0[1]
smlal.4s	v1, v18, v0[2]
smlal.4s	v1, v19, v0[3]
smlal.4s	v1, v20, v0[4]
smlal.4s	v1, v21, v0[5]
smlal.4s	v1, v22, v0[6]
smull2.4s	v2, v17, v0[1]
smlal2.4s	v2, v18, v0[2]
smlal2.4s	v2, v19, v0[3]
smlal2.4s	v2, v20, v0[4]
smlal2.4s	v2, v21, v0[5]
smlal2.4s	v2, v22, v0[6]
smull.4s	v3, v18, v0[1]
smlal.4s	v3, v19, v0[2]
smlal.4s	v3, v20, v0[3]
smlal.4s	v3, v21, v0[4]
smlal.4s	v3, v22, v0[5]
smlal.4s	v3, v23, v0[6]
smull2.4s	v4, v18, v0[1]
smlal2.4s	v4, v19, v0[2]
smlal2.4s	v4, v20, v0[3]
smlal2.4s	v4, v21, v0[4]
smlal2.4s	v4, v22, v0[5]
smlal2.4s	v4, v23, v0[6]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v3, v3, v29
st1.8h	{ v1 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_6tap_neon
subs	w4, w4, #2
ld1.8h	{ v25 }, [x10], x2
ld1.8h	{ v26 }, [x1], x2
smull.4s	v1, v19, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v21, v0[3]
smlal.4s	v1, v22, v0[4]
smlal.4s	v1, v23, v0[5]
smlal.4s	v1, v24, v0[6]
smull2.4s	v2, v19, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v21, v0[3]
smlal2.4s	v2, v22, v0[4]
smlal2.4s	v2, v23, v0[5]
smlal2.4s	v2, v24, v0[6]
smull.4s	v3, v20, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v22, v0[3]
smlal.4s	v3, v23, v0[4]
smlal.4s	v3, v24, v0[5]
smlal.4s	v3, v25, v0[6]
smull2.4s	v4, v20, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v22, v0[3]
smlal2.4s	v4, v23, v0[4]
smlal2.4s	v4, v24, v0[5]
smlal2.4s	v4, v25, v0[6]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v3, v3, v29
st1.8h	{ v1 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_6tap_neon
mov.16b	v16, v20
mov.16b	v17, v21
mov.16b	v18, v22
mov.16b	v19, v23
mov.16b	v20, v24
mov.16b	v21, v25
mov.16b	v22, v26
b	prep_6tap_neon
subs	w3, w3, #8
b.le	prep_6tap_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
b	prep_6tap_neon
ret
b.gt	prep_6tap_neon
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
sshll.8h	v0, v0, #0
ld1.8h	{ v16, v17 }, [x1], x2
ld1.8h	{ v18, v19 }, [x1], x2
ld1.8h	{ v20, v21 }, [x1], x2
ld1.8h	{ v22, v23 }, [x1], x2
subs	w4, w4, #1
smull.4s	v1, v16, v0[0]
smlal.4s	v1, v18, v0[1]
smlal.4s	v1, v20, v0[2]
smlal.4s	v1, v22, v0[3]
smull2.4s	v2, v16, v0[0]
smlal2.4s	v2, v18, v0[1]
smlal2.4s	v2, v20, v0[2]
smlal2.4s	v2, v22, v0[3]
smull.4s	v3, v17, v0[0]
smlal.4s	v3, v19, v0[1]
smlal.4s	v3, v21, v0[2]
smlal.4s	v3, v23, v0[3]
smull2.4s	v4, v17, v0[0]
smlal2.4s	v4, v19, v0[1]
smlal2.4s	v4, v21, v0[2]
smlal2.4s	v4, v23, v0[3]
srshl.4s	v1, v1, v30
srshl.4s	v2, v2, v30
srshl.4s	v3, v3, v30
srshl.4s	v4, v4, v30
uzp1.8h	v1, v1, v2
uzp1.8h	v3, v3, v4
sub.8h	v1, v1, v29
sub.8h	v2, v3, v29
st1.8h	{ v1, v2 }, [x0], x8
b.le	prep_6tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
b	prep_6tap_neon
ret
<unknown>
<unknown>
zip1	z12.q, z28.q, z4.q
udf	#1444
cmp	w4, #4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_6tap_neon
mov	w6, w10
add	x6, x11, w6, uxtw #3
adr	x10, #1408
dup.4s	v30, w12
ldrh	w9, [x10, x9, lsl #1]
neg.4s	v30, v30
movi.8h	v29, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
b.gt	prep_6tap_neon
add	x6, x6, #2
ld1.s	{ v1 }[0], [x6]
sub	x10, x1, #2
sub	x1, x10, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x1], x2
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v16, v16
bl	prep_6tap_neon
mov.8b	v17, v24
mov.8b	v18, v25
bl	prep_6tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v24, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v24, v1[2]
smlal.4s	v3, v25, v1[3]
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
sub.8h	v2, v2, v29
subs	w4, w4, #2
st1.d	{ v2 }[0], [x0], x8
st1.d	{ v2 }[1], [x9], x8
b.le	prep_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v24
mov.8b	v18, v25
b	prep_6tap_neon
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #2
sub	x10, x1, x2
sub	x1, x1, x2, lsl #1
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8h	{ v25 }, [x1], x2
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v16, v25, v30
xtn.4h	v18, v16
bl	prep_6tap_neon
mov.8b	v19, v24
mov.8b	v20, v25
bl	prep_6tap_neon
mov.8b	v21, v24
mov.8b	v22, v25
bl	prep_6tap_neon
smull.4s	v3, v18, v1[1]
smlal.4s	v3, v19, v1[2]
smlal.4s	v3, v20, v1[3]
smlal.4s	v3, v21, v1[4]
smlal.4s	v3, v22, v1[5]
smlal.4s	v3, v24, v1[6]
smull.4s	v4, v19, v1[1]
smlal.4s	v4, v20, v1[2]
smlal.4s	v4, v21, v1[3]
smlal.4s	v4, v22, v1[4]
smlal.4s	v4, v24, v1[5]
smlal.4s	v4, v25, v1[6]
rshrn.4h	v3, v3, #6
rshrn2.8h	v3, v4, #6
sub.8h	v3, v3, v29
subs	w4, w4, #2
st1.d	{ v3 }[0], [x0], x8
st1.d	{ v3 }[1], [x9], x8
b.le	prep_6tap_neon
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v24
mov.8b	v22, v25
b	prep_6tap_neon
ret	x15
ld1.8h	{ v24 }, [x10], x2
ld1.8h	{ v25 }, [x1], x2
ext.16b	v26, v24, v24, #2
ext.16b	v27, v24, v24, #4
ext.16b	v28, v24, v24, #6
smull.4s	v24, v24, v0[0]
smlal.4s	v24, v26, v0[1]
smlal.4s	v24, v27, v0[2]
smlal.4s	v24, v28, v0[3]
ext.16b	v26, v25, v25, #2
ext.16b	v27, v25, v25, #4
ext.16b	v28, v25, v25, #6
smull.4s	v25, v25, v0[0]
smlal.4s	v25, v26, v0[1]
smlal.4s	v25, v27, v0[2]
smlal.4s	v25, v28, v0[3]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
xtn.4h	v24, v24
xtn.4h	v25, v25
ret
b.gt	prep_6tap_neon
add	x6, x6, #2
ld1.8b	{ v0 }, [x5]
ld1.s	{ v1 }[0], [x6]
sub	x1, x1, #6
sub	x1, x1, x2
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1.8h	{ v27, v28 }, [x1], x2
smull.4s	v24, v27, v0[0]
smull2.4s	v25, v27, v0[0]
ext.16b	v26, v27, v28, #2
smlal.4s	v24, v26, v0[1]
smlal2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
ext.16b	v26, v27, v28, #14
smlal.4s	v24, v26, v0[7]
smlal2.4s	v25, v26, v0[7]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v16, v24, v25
bl	prep_6tap_neon
mov.16b	v17, v23
mov.16b	v18, v24
smull.4s	v2, v16, v1[0]
smull2.4s	v3, v16, v1[0]
bl	prep_6tap_neon
smull.4s	v4, v17, v1[0]
smull2.4s	v5, v17, v1[0]
smlal.4s	v2, v17, v1[1]
smlal2.4s	v3, v17, v1[1]
smlal.4s	v4, v18, v1[1]
smlal2.4s	v5, v18, v1[1]
smlal.4s	v2, v18, v1[2]
smlal2.4s	v3, v18, v1[2]
smlal.4s	v4, v23, v1[2]
smlal2.4s	v5, v23, v1[2]
smlal.4s	v2, v23, v1[3]
smlal2.4s	v3, v23, v1[3]
smlal.4s	v4, v24, v1[3]
smlal2.4s	v5, v24, v1[3]
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
rshrn.4h	v3, v4, #6
rshrn2.8h	v3, v5, #6
sub.8h	v2, v2, v29
sub.8h	v3, v3, v29
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_6tap_neon
mov.16b	v16, v18
mov.16b	v17, v23
mov.16b	v18, v24
b	prep_6tap_neon
subs	w3, w3, #8
b.le	prep_6tap_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
b	prep_6tap_neon
ld1.8b	{ v0 }, [x5]
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #6
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1.8h	{ v27, v28 }, [x1], x2
ext.16b	v26, v27, v28, #2
smull.4s	v24, v26, v0[1]
smull2.4s	v25, v26, v0[1]
ext.16b	v26, v27, v28, #4
smlal.4s	v24, v26, v0[2]
smlal2.4s	v25, v26, v0[2]
ext.16b	v26, v27, v28, #6
smlal.4s	v24, v26, v0[3]
smlal2.4s	v25, v26, v0[3]
ext.16b	v26, v27, v28, #8
smlal.4s	v24, v26, v0[4]
smlal2.4s	v25, v26, v0[4]
ext.16b	v26, v27, v28, #10
smlal.4s	v24, v26, v0[5]
smlal2.4s	v25, v26, v0[5]
ext.16b	v26, v27, v28, #12
smlal.4s	v24, v26, v0[6]
smlal2.4s	v25, v26, v0[6]
srshl.4s	v24, v24, v30
srshl.4s	v25, v25, v30
uzp1.8h	v18, v24, v25
bl	prep_6tap_neon
mov.16b	v19, v23
mov.16b	v20, v24
bl	prep_6tap_neon
mov.16b	v21, v23
mov.16b	v22, v24
smull.4s	v2, v18, v1[1]
smull2.4s	v3, v18, v1[1]
bl	prep_6tap_neon
smull.4s	v4, v19, v1[1]
smull2.4s	v5, v19, v1[1]
smlal.4s	v2, v19, v1[2]
smlal2.4s	v3, v19, v1[2]
smlal.4s	v4, v20, v1[2]
smlal2.4s	v5, v20, v1[2]
smlal.4s	v2, v20, v1[3]
smlal2.4s	v3, v20, v1[3]
smlal.4s	v4, v21, v1[3]
smlal2.4s	v5, v21, v1[3]
smlal.4s	v2, v21, v1[4]
smlal2.4s	v3, v21, v1[4]
smlal.4s	v4, v22, v1[4]
smlal2.4s	v5, v22, v1[4]
smlal.4s	v2, v22, v1[5]
smlal2.4s	v3, v22, v1[5]
smlal.4s	v4, v23, v1[5]
smlal2.4s	v5, v23, v1[5]
smlal.4s	v2, v23, v1[6]
smlal2.4s	v3, v23, v1[6]
smlal.4s	v4, v24, v1[6]
smlal2.4s	v5, v24, v1[6]
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
rshrn.4h	v3, v4, #6
rshrn2.8h	v3, v5, #6
sub.8h	v2, v2, v29
sub.8h	v3, v3, v29
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x8
st1.8h	{ v3 }, [x9], x8
b.le	prep_6tap_neon
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v23
mov.16b	v22, v24
b	prep_6tap_neon
subs	w3, w3, #8
b.le	prep_6tap_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
add	x1, x1, x2, lsl #1
b	prep_6tap_neon
ret	x15
ld1.8h	{ v4, v5 }, [x10], x2
ld1.8h	{ v6, v7 }, [x1], x2
ext.16b	v23, v4, v5, #2
ext.16b	v24, v6, v7, #2
smull.4s	v25, v23, v0[1]
smull2.4s	v26, v23, v0[1]
smull.4s	v27, v24, v0[1]
smull2.4s	v28, v24, v0[1]
ext.16b	v23, v4, v5, #4
ext.16b	v24, v6, v7, #4
smlal.4s	v25, v23, v0[2]
smlal2.4s	v26, v23, v0[2]
smlal.4s	v27, v24, v0[2]
smlal2.4s	v28, v24, v0[2]
ext.16b	v23, v4, v5, #6
ext.16b	v24, v6, v7, #6
smlal.4s	v25, v23, v0[3]
smlal2.4s	v26, v23, v0[3]
smlal.4s	v27, v24, v0[3]
smlal2.4s	v28, v24, v0[3]
ext.16b	v23, v4, v5, #8
ext.16b	v24, v6, v7, #8
smlal.4s	v25, v23, v0[4]
smlal2.4s	v26, v23, v0[4]
smlal.4s	v27, v24, v0[4]
smlal2.4s	v28, v24, v0[4]
ext.16b	v23, v4, v5, #10
ext.16b	v24, v6, v7, #10
smlal.4s	v25, v23, v0[5]
smlal2.4s	v26, v23, v0[5]
smlal.4s	v27, v24, v0[5]
smlal2.4s	v28, v24, v0[5]
ext.16b	v23, v4, v5, #12
ext.16b	v24, v6, v7, #12
smlal.4s	v25, v23, v0[6]
smlal2.4s	v26, v23, v0[6]
smlal.4s	v27, v24, v0[6]
smlal2.4s	v28, v24, v0[6]
srshl.4s	v25, v25, v30
srshl.4s	v26, v26, v30
srshl.4s	v27, v27, v30
srshl.4s	v28, v28, v30
uzp1.8h	v23, v25, v26
uzp1.8h	v24, v27, v28
ret
<unknown>
<unknown>
ext	z4.b, { z28.b, z29.b }, #32
udf	#1380
_prep_bilin_16bpc_neon:
dup.8h	v1, w5
dup.8h	v3, w6
mov	w10, #16
sub	w9, w10, w5
sub	w10, w10, w6
dup.8h	v0, w9
dup.8h	v2, w10
ubfx	x8, x3, #0, #32
lsl	x8, x8, #1
clz	w7, w7
clz	w9, w3
sub	w7, w7, #18
mov	w11, #4
sub	w9, w9, #24
sub	w11, w11, w7
add	w12, w7, #4
cbnz	w5, prep_bilin_16bpc_neon
cbnz	w6, prep_bilin_16bpc_neon
b	prep_neon
cbnz	w6, prep_bilin_16bpc_neon
adr	x10, #372
dup.8h	v31, w11
ldrh	w9, [x10, x9, lsl #1]
neg.8h	v31, v31
movi.8h	v29, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1.8h	{ v4 }, [x1], x2
ld1.8h	{ v6 }, [x10], x2
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
trn1.2d	v4, v4, v6
trn1.2d	v5, v5, v7
subs	w4, w4, #2
mul.8h	v4, v4, v0
mla.8h	v4, v5, v1
urshl.8h	v4, v4, v31
sub.8h	v4, v4, v29
st1.d	{ v4 }[0], [x0], x8
st1.d	{ v4 }[1], [x9], x8
b.gt	prep_bilin_16bpc_neon
ret
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ldr	h5, [x1, #16]
ldr	h7, [x10, #16]
ld1.8h	{ v4 }, [x1], x2
ld1.8h	{ v6 }, [x10], x2
ext.16b	v5, v4, v5, #2
ext.16b	v7, v6, v7, #2
subs	w4, w4, #2
mul.8h	v4, v4, v0
mla.8h	v4, v5, v1
mul.8h	v6, v6, v0
mla.8h	v6, v7, v1
urshl.8h	v4, v4, v31
urshl.8h	v6, v6, v31
sub.8h	v4, v4, v29
sub.8h	v6, v6, v29
st1.8h	{ v4 }, [x0], x8
st1.8h	{ v6 }, [x9], x8
b.gt	prep_bilin_16bpc_neon
ret
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
sub	x2, x2, w3, uxtw #1
sub	x2, x2, #16
ld1.8h	{ v16 }, [x1], #16
ld1.8h	{ v21 }, [x10], #16
mov	w5, w3
ld1.8h	{ v17, v18 }, [x1], #32
ld1.8h	{ v22, v23 }, [x10], #32
ext.16b	v19, v16, v17, #2
ext.16b	v20, v17, v18, #2
ext.16b	v24, v21, v22, #2
ext.16b	v25, v22, v23, #2
mul.8h	v16, v16, v0
mla.8h	v16, v19, v1
mul.8h	v17, v17, v0
mla.8h	v17, v20, v1
mul.8h	v21, v21, v0
mla.8h	v21, v24, v1
mul.8h	v22, v22, v0
mla.8h	v22, v25, v1
urshl.8h	v16, v16, v31
urshl.8h	v17, v17, v31
urshl.8h	v21, v21, v31
urshl.8h	v22, v22, v31
subs	w5, w5, #16
sub.8h	v16, v16, v29
sub.8h	v17, v17, v29
sub.8h	v21, v21, v29
sub.8h	v22, v22, v29
st1.8h	{ v16, v17 }, [x0], #32
st1.8h	{ v21, v22 }, [x9], #32
b.le	prep_bilin_16bpc_neon
mov.16b	v16, v18
mov.16b	v21, v23
b	prep_bilin_16bpc_neon
add	x0, x0, x8
add	x9, x9, x8
add	x1, x1, x2
add	x10, x10, x2
subs	w4, w4, #2
b.gt	prep_bilin_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#344
cmp	w4, #4
adr	x10, #368
dup.8h	v31, w11
ldrh	w9, [x10, x9, lsl #1]
movi.8h	v29, #32, lsl #8
neg.8h	v31, v31
sub	x10, x10, w9, uxtw
br	x10
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1.4h	{ v16 }, [x1], x2
ld1.4h	{ v17 }, [x10], x2
ld1.4h	{ v18 }, [x1], x2
trn1.2d	v16, v16, v17
trn1.2d	v17, v17, v18
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
subs	w4, w4, #2
urshl.8h	v4, v4, v31
sub.8h	v4, v4, v29
st1.d	{ v4 }[0], [x0], x8
st1.d	{ v4 }[1], [x9], x8
b.le	prep_bilin_16bpc_neon
mov.8b	v16, v18
b	prep_bilin_16bpc_neon
ret
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1.8h	{ v16 }, [x1], x2
ld1.8h	{ v17 }, [x10], x2
ld1.8h	{ v18 }, [x1], x2
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
mul.8h	v5, v17, v2
mla.8h	v5, v18, v3
subs	w4, w4, #2
urshl.8h	v4, v4, v31
urshl.8h	v5, v5, v31
sub.8h	v4, v4, v29
sub.8h	v5, v5, v29
st1.8h	{ v4 }, [x0], x8
st1.8h	{ v5 }, [x9], x8
b.le	prep_bilin_16bpc_neon
mov.16b	v16, v18
b	prep_bilin_16bpc_neon
ret
mov	w6, w4
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1.8h	{ v16, v17 }, [x1], x2
ld1.8h	{ v18, v19 }, [x10], x2
ld1.8h	{ v20, v21 }, [x1], x2
mul.8h	v4, v16, v2
mla.8h	v4, v18, v3
mul.8h	v5, v17, v2
mla.8h	v5, v19, v3
mul.8h	v6, v18, v2
mla.8h	v6, v20, v3
mul.8h	v7, v19, v2
mla.8h	v7, v21, v3
subs	w4, w4, #2
urshl.8h	v4, v4, v31
urshl.8h	v5, v5, v31
urshl.8h	v6, v6, v31
urshl.8h	v7, v7, v31
sub.8h	v4, v4, v29
sub.8h	v5, v5, v29
sub.8h	v6, v6, v29
sub.8h	v7, v7, v29
st1.8h	{ v4, v5 }, [x0], x8
st1.8h	{ v6, v7 }, [x9], x8
b.le	prep_bilin_16bpc_neon
mov.16b	v16, v20
mov.16b	v17, v21
b	prep_bilin_16bpc_neon
subs	w3, w3, #16
b.le	prep_bilin_16bpc_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #32
add	x0, x0, #32
b	prep_bilin_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#340
adr	x10, #380
dup.8h	v31, w11
ldrh	w9, [x10, x9, lsl #1]
neg.8h	v31, v31
movi.8h	v29, #32, lsl #8
sub	x10, x10, w9, uxtw
br	x10
add	x10, x1, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1.8h	{ v20 }, [x1], x2
ext.16b	v21, v20, v20, #2
mul.4h	v16, v20, v0
mla.4h	v16, v21, v1
urshl.4h	v16, v16, v31
ld1.8h	{ v22 }, [x10], x2
ld1.8h	{ v24 }, [x1], x2
ext.16b	v23, v22, v22, #2
ext.16b	v25, v24, v24, #2
trn1.2d	v22, v22, v24
trn1.2d	v23, v23, v25
mul.8h	v17, v22, v0
mla.8h	v17, v23, v1
urshl.8h	v17, v17, v31
trn1.2d	v16, v16, v17
umull.4s	v4, v16, v2
umlal.4s	v4, v17, v3
umull2.4s	v5, v16, v2
umlal2.4s	v5, v17, v3
rshrn.4h	v4, v4, #4
rshrn2.8h	v4, v5, #4
sub.8h	v4, v4, v29
subs	w4, w4, #2
st1.d	{ v4 }[0], [x0], x8
st1.d	{ v4 }[1], [x9], x8
b.le	prep_bilin_16bpc_neon
trn2.2d	v16, v17, v17
b	prep_bilin_16bpc_neon
ret
mov	w6, w4
add	x10, x1, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
ldr	h21, [x1, #16]
ld1.8h	{ v20 }, [x1], x2
ext.16b	v21, v20, v21, #2
mul.8h	v16, v20, v0
mla.8h	v16, v21, v1
urshl.8h	v16, v16, v31
ldr	h23, [x10, #16]
ld1.8h	{ v22 }, [x10], x2
ldr	h25, [x1, #16]
ld1.8h	{ v24 }, [x1], x2
ext.16b	v23, v22, v23, #2
ext.16b	v25, v24, v25, #2
mul.8h	v17, v22, v0
mla.8h	v17, v23, v1
mul.8h	v18, v24, v0
mla.8h	v18, v25, v1
urshl.8h	v17, v17, v31
urshl.8h	v18, v18, v31
umull.4s	v4, v16, v2
umlal.4s	v4, v17, v3
umull2.4s	v5, v16, v2
umlal2.4s	v5, v17, v3
umull.4s	v6, v17, v2
umlal.4s	v6, v18, v3
umull2.4s	v7, v17, v2
umlal2.4s	v7, v18, v3
rshrn.4h	v4, v4, #4
rshrn2.8h	v4, v5, #4
rshrn.4h	v5, v6, #4
rshrn2.8h	v5, v7, #4
sub.8h	v4, v4, v29
sub.8h	v5, v5, v29
subs	w4, w4, #2
st1.8h	{ v4 }, [x0], x8
st1.8h	{ v5 }, [x9], x8
b.le	prep_bilin_16bpc_neon
mov.16b	v16, v18
b	prep_bilin_16bpc_neon
subs	w3, w3, #8
b.le	prep_bilin_16bpc_neon
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #16
b	prep_bilin_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#352
_warp_filter_horz_neon:
add	w12, w5, #512
ld1.8h	{ v16, v17 }, [x2], x3
asr	w13, w12, #10
add	w12, w12, w7
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d2, [x11, w13, sxtw #3]
sshll.8h	v0, v0, #0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d3, [x11, w13, sxtw #3]
sshll.8h	v1, v1, #0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d4, [x11, w13, sxtw #3]
sshll.8h	v2, v2, #0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d5, [x11, w13, sxtw #3]
sshll.8h	v3, v3, #0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d6, [x11, w13, sxtw #3]
sshll.8h	v4, v4, #0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d7, [x11, w13, sxtw #3]
sshll.8h	v5, v5, #0
ext.16b	v18, v16, v17, #2
smull.4s	v8, v16, v0
smull2.4s	v9, v16, v0
sshll.8h	v6, v6, #0
ext.16b	v19, v16, v17, #4
smull.4s	v10, v18, v1
smull2.4s	v11, v18, v1
sshll.8h	v7, v7, #0
ext.16b	v20, v16, v17, #6
smull.4s	v0, v19, v2
smull2.4s	v1, v19, v2
ext.16b	v21, v16, v17, #8
addp.4s	v8, v8, v9
smull.4s	v2, v20, v3
smull2.4s	v3, v20, v3
ext.16b	v22, v16, v17, #10
addp.4s	v9, v10, v11
smull.4s	v10, v21, v4
smull2.4s	v11, v21, v4
ext.16b	v23, v16, v17, #12
addp.4s	v0, v0, v1
smull.4s	v18, v22, v5
smull2.4s	v19, v22, v5
ext.16b	v16, v16, v17, #14
addp.4s	v1, v2, v3
addp.4s	v2, v10, v11
smull.4s	v20, v23, v6
smull2.4s	v21, v23, v6
addp.4s	v3, v18, v19
smull.4s	v22, v16, v7
smull2.4s	v23, v16, v7
addp.4s	v4, v20, v21
addp.4s	v5, v22, v23
addp.4s	v8, v8, v9
addp.4s	v0, v0, v1
addp.4s	v2, v2, v3
addp.4s	v4, v4, v5
addp.4s	v16, v8, v0
addp.4s	v17, v2, v4
add	w5, w5, w8
srshl.4s	v16, v16, v14
srshl.4s	v17, v17, v14
ret
_warp_affine_8x8_16bpc_neon:
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
dup.8h	v15, w7
clz	w7, w7
sub	w8, w7, #11
sub	w7, w7, #25
neg	w8, w8
dup.4s	v14, w7
dup.4s	v13, w8
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #6
adrp	x11, warp_affine_8x8_16bpc_neon
add	x11, x11, #0
mov	x15, x30
bl	warp_filter_horz_neon
uzp1.8h	v24, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v25, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v26, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v27, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v28, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v29, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v30, v16, v17
add	w14, w6, #512
bl	warp_filter_horz_neon
uzp1.8h	v31, v16, v17
asr	w13, w14, #10
add	w14, w14, w9
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d2, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d3, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d4, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d5, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d6, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d7, [x11, w13, sxtw #3]
zip1.16b	v0, v0, v1
zip1.16b	v2, v2, v3
zip1.16b	v4, v4, v5
zip1.16b	v6, v6, v7
trn1.8h	v1, v0, v2
trn2.8h	v3, v0, v2
trn1.8h	v5, v4, v6
trn2.8h	v7, v4, v6
trn1.4s	v0, v1, v5
trn2.4s	v2, v1, v5
trn1.4s	v1, v3, v7
trn2.4s	v3, v3, v7
sshll2.8h	v4, v0, #0
sshll.8h	v0, v0, #0
sshll2.8h	v6, v2, #0
sshll.8h	v2, v2, #0
sshll2.8h	v5, v1, #0
sshll.8h	v1, v1, #0
sshll2.8h	v7, v3, #0
sshll.8h	v3, v3, #0
smull.4s	v16, v24, v0
smlal.4s	v16, v25, v1
smlal.4s	v16, v26, v2
smlal.4s	v16, v27, v3
smlal.4s	v16, v28, v4
smlal.4s	v16, v29, v5
smlal.4s	v16, v30, v6
smlal.4s	v16, v31, v7
smull2.4s	v17, v24, v0
smlal2.4s	v17, v25, v1
smlal2.4s	v17, v26, v2
smlal2.4s	v17, v27, v3
smlal2.4s	v17, v28, v4
smlal2.4s	v17, v29, v5
smlal2.4s	v17, v30, v6
smlal2.4s	v17, v31, v7
mov.16b	v24, v25
mov.16b	v25, v26
srshl.4s	v16, v16, v13
srshl.4s	v17, v17, v13
mov.16b	v26, v27
sqxtun.4h	v16, v16
sqxtun2.8h	v16, v17
mov.16b	v27, v28
mov.16b	v28, v29
umin.8h	v16, v16, v15
mov.16b	v29, v30
mov.16b	v30, v31
subs	w10, w10, #1
st1.8h	{ v16 }, [x0], x1
add	w6, w6, w4
b.gt	warp_affine_8x8_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x15
_warp_affine_8x8t_16bpc_neon:
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
movi.8h	v15, #32, lsl #8
clz	w7, w7
sub	w7, w7, #25
dup.4s	v14, w7
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #6
adrp	x11, warp_affine_8x8t_16bpc_neon
add	x11, x11, #0
mov	x15, x30
lsl	x1, x1, #1
bl	warp_filter_horz_neon
uzp1.8h	v24, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v25, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v26, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v27, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v28, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v29, v16, v17
bl	warp_filter_horz_neon
uzp1.8h	v30, v16, v17
add	w14, w6, #512
bl	warp_filter_horz_neon
uzp1.8h	v31, v16, v17
asr	w13, w14, #10
add	w14, w14, w9
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d2, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d3, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d4, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d5, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d6, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d7, [x11, w13, sxtw #3]
zip1.16b	v0, v0, v1
zip1.16b	v2, v2, v3
zip1.16b	v4, v4, v5
zip1.16b	v6, v6, v7
trn1.8h	v1, v0, v2
trn2.8h	v3, v0, v2
trn1.8h	v5, v4, v6
trn2.8h	v7, v4, v6
trn1.4s	v0, v1, v5
trn2.4s	v2, v1, v5
trn1.4s	v1, v3, v7
trn2.4s	v3, v3, v7
sshll2.8h	v4, v0, #0
sshll.8h	v0, v0, #0
sshll2.8h	v6, v2, #0
sshll.8h	v2, v2, #0
sshll2.8h	v5, v1, #0
sshll.8h	v1, v1, #0
sshll2.8h	v7, v3, #0
sshll.8h	v3, v3, #0
smull.4s	v16, v24, v0
smlal.4s	v16, v25, v1
smlal.4s	v16, v26, v2
smlal.4s	v16, v27, v3
smlal.4s	v16, v28, v4
smlal.4s	v16, v29, v5
smlal.4s	v16, v30, v6
smlal.4s	v16, v31, v7
smull2.4s	v17, v24, v0
smlal2.4s	v17, v25, v1
smlal2.4s	v17, v26, v2
smlal2.4s	v17, v27, v3
smlal2.4s	v17, v28, v4
smlal2.4s	v17, v29, v5
smlal2.4s	v17, v30, v6
smlal2.4s	v17, v31, v7
mov.16b	v24, v25
mov.16b	v25, v26
rshrn.4h	v16, v16, #7
rshrn2.8h	v16, v17, #7
mov.16b	v26, v27
sub.8h	v16, v16, v15
mov.16b	v27, v28
mov.16b	v28, v29
mov.16b	v29, v30
mov.16b	v30, v31
subs	w10, w10, #1
st1.8h	{ v16 }, [x0], x1
add	w6, w6, w4
b.gt	warp_affine_8x8t_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x15
_emu_edge_16bpc_neon:
ldp	x8, x9, [sp]
sub	x12, x3, #1
cmp	x5, x3
sub	x13, x2, #1
csel	x12, x12, x5, ge
cmp	x4, x2
bic	x12, x12, x12, asr #63
csel	x13, x13, x4, ge
bic	x13, x13, x13, asr #63
madd	x8, x12, x9, x8
add	x8, x8, x13, lsl #1
add	x10, x5, x1
neg	x5, x5
sub	x10, x10, x3
sub	x12, x1, #1
cmp	x10, x1
bic	x5, x5, x5, asr #63
csel	x10, x10, x12, lt
cmp	x5, x1
bic	x10, x10, x10, asr #63
csel	x5, x5, x12, lt
add	x11, x4, x0
neg	x4, x4
sub	x11, x11, x2
sub	x13, x0, #1
cmp	x11, x0
bic	x4, x4, x4, asr #63
csel	x11, x11, x13, lt
cmp	x4, x0
bic	x11, x11, x11, asr #63
csel	x4, x4, x13, lt
sub	x1, x1, x5
madd	x6, x5, x7, x6
sub	x2, x0, x4
sub	x1, x1, x10
sub	x2, x2, x11
mov	x14, x6
cbz	x4, emu_edge_16bpc_neon
cbz	x11, emu_edge_16bpc_neon
ld1r.8h	{ v0 }, [x8]
mov	x12, x6
mov	x3, x4
mov.16b	v1, v0
subs	x3, x3, #16
st1.8h	{ v0, v1 }, [x12], #32
b.gt	emu_edge_16bpc_neon
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
ld1.8h	{ v0, v1, v2, v3 }, [x13], #64
subs	x3, x3, #32
st1.8h	{ v0, v1, v2, v3 }, [x12], #64
b.gt	emu_edge_16bpc_neon
add	x3, x8, x2, lsl #1
sub	x3, x3, #2
add	x12, x6, x4, lsl #1
ld1r.8h	{ v0 }, [x3]
add	x12, x12, x2, lsl #1
mov	x3, x11
mov.16b	v1, v0
subs	x3, x3, #16
st1.8h	{ v0, v1 }, [x12], #32
b.gt	emu_edge_16bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_16bpc_neon
b	emu_edge_16bpc_neon
cbz	x11, emu_edge_16bpc_neon
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
ld1.8h	{ v0, v1, v2, v3 }, [x13], #64
subs	x3, x3, #32
st1.8h	{ v0, v1, v2, v3 }, [x12], #64
b.gt	emu_edge_16bpc_neon
add	x3, x8, x2, lsl #1
sub	x3, x3, #2
add	x12, x6, x4, lsl #1
ld1r.8h	{ v0 }, [x3]
add	x12, x12, x2, lsl #1
mov	x3, x11
mov.16b	v1, v0
subs	x3, x3, #16
st1.8h	{ v0, v1 }, [x12], #32
b.gt	emu_edge_16bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_16bpc_neon
b	emu_edge_16bpc_neon
ld1r.8h	{ v0 }, [x8]
mov	x12, x6
mov	x3, x4
mov.16b	v1, v0
subs	x3, x3, #16
st1.8h	{ v0, v1 }, [x12], #32
b.gt	emu_edge_16bpc_neon
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
ld1.8h	{ v0, v1, v2, v3 }, [x13], #64
subs	x3, x3, #32
st1.8h	{ v0, v1, v2, v3 }, [x12], #64
b.gt	emu_edge_16bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_16bpc_neon
b	emu_edge_16bpc_neon
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
ld1.8h	{ v0, v1, v2, v3 }, [x13], #64
subs	x3, x3, #32
st1.8h	{ v0, v1, v2, v3 }, [x12], #64
b.gt	emu_edge_16bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_16bpc_neon
cbz	x10, emu_edge_16bpc_neon
sub	x8, x6, x7
mov	x4, x0
ld1.8h	{ v0, v1, v2, v3 }, [x8], #64
mov	x3, x10
subs	x3, x3, #1
st1.8h	{ v0, v1, v2, v3 }, [x6], x7
b.gt	emu_edge_16bpc_neon
msub	x6, x7, x10, x6
subs	x4, x4, #32
add	x6, x6, #64
b.gt	emu_edge_16bpc_neon
cbz	x5, emu_edge_16bpc_neon
msub	x6, x7, x5, x14
ld1.8h	{ v0, v1, v2, v3 }, [x14], #64
mov	x3, x5
subs	x3, x3, #1
st1.8h	{ v0, v1, v2, v3 }, [x6], x7
b.gt	emu_edge_16bpc_neon
msub	x6, x7, x5, x6
subs	x0, x0, #32
add	x6, x6, #64
b.gt	emu_edge_16bpc_neon
ret