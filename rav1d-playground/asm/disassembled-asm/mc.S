_ltmp0:
clz	w4, w4
adr	x7, #980
sub	w4, w4, #24
ldrh	w4, [x7, x4, lsl #1]
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
sub	x7, x7, w4, uxtw
br	x7
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x7], x1
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x7], x1
b.eq	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
cmp	w5, #8
st1.s	{ v5 }[0], [x0], x1
st1.s	{ v5 }[1], [x7], x1
st1.s	{ v5 }[2], [x0], x1
st1.s	{ v5 }[3], [x7], x1
b.eq	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x7], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x7], x1
st1.s	{ v5 }[0], [x0], x1
st1.s	{ v5 }[1], [x7], x1
st1.s	{ v5 }[2], [x0], x1
st1.s	{ v5 }[3], [x7], x1
ret
add	x7, x0, x1
lsl	x1, x1, #1
st1.d	{ v4 }[0], [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
st1.d	{ v4 }[1], [x7], x1
st1.d	{ v5 }[0], [x0], x1
subs	w5, w5, #4
st1.d	{ v5 }[1], [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
b	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
st1.16b	{ v4 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v6, v0, #5
sqrshrun2.16b	v6, v1, #5
st1.16b	{ v5 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v7, v0, #5
sqrshrun2.16b	v7, v1, #5
st1.16b	{ v6 }, [x0], x1
subs	w5, w5, #4
st1.16b	{ v7 }, [x0], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
b	ltmp0
add	x7, x0, x1
lsl	x1, x1, #1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v6, v0, #5
sqrshrun2.16b	v6, v1, #5
st1.16b	{ v4, v5 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v7, v0, #5
sqrshrun2.16b	v7, v1, #5
subs	w5, w5, #2
st1.16b	{ v6, v7 }, [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
b	ltmp0
add	x7, x0, x1
lsl	x1, x1, #1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v6, v0, #5
sqrshrun2.16b	v6, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v7, v0, #5
sqrshrun2.16b	v7, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v16, v0, #5
sqrshrun2.16b	v16, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v17, v0, #5
sqrshrun2.16b	v17, v1, #5
st1.16b	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v18, v0, #5
sqrshrun2.16b	v18, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v19, v0, #5
sqrshrun2.16b	v19, v1, #5
subs	w5, w5, #2
st1.16b	{ v16, v17, v18, v19 }, [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
b	ltmp0
add	x7, x0, #64
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v5, v0, #5
sqrshrun2.16b	v5, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v6, v0, #5
sqrshrun2.16b	v6, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v7, v0, #5
sqrshrun2.16b	v7, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v16, v0, #5
sqrshrun2.16b	v16, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v17, v0, #5
sqrshrun2.16b	v17, v1, #5
st1.16b	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v18, v0, #5
sqrshrun2.16b	v18, v1, #5
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v19, v0, #5
sqrshrun2.16b	v19, v1, #5
subs	w5, w5, #1
st1.16b	{ v16, v17, v18, v19 }, [x7], x1
b.le	ltmp0
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
add.8h	v0, v0, v2
add.8h	v1, v1, v3
sqrshrun.8b	v4, v0, #5
sqrshrun2.16b	v4, v1, #5
b	ltmp0
ret
<unknown>
<unknown>
<unknown>
_w_avg_8bpc_neon:
clz	w4, w4
dup.8h	v30, w6
neg.8h	v30, v30
shl.8h	v30, v30, #11
adr	x7, #1460
sub	w4, w4, #24
ldrh	w4, [x7, x4, lsl #1]
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
sub	x7, x7, w4, uxtw
br	x7
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x7], x1
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x7], x1
b.eq	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
cmp	w5, #8
st1.s	{ v5 }[0], [x0], x1
st1.s	{ v5 }[1], [x7], x1
st1.s	{ v5 }[2], [x0], x1
st1.s	{ v5 }[3], [x7], x1
b.eq	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x7], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x7], x1
st1.s	{ v5 }[0], [x0], x1
st1.s	{ v5 }[1], [x7], x1
st1.s	{ v5 }[2], [x0], x1
st1.s	{ v5 }[3], [x7], x1
ret
add	x7, x0, x1
lsl	x1, x1, #1
st1.d	{ v4 }[0], [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
st1.d	{ v4 }[1], [x7], x1
st1.d	{ v5 }[0], [x0], x1
subs	w5, w5, #4
st1.d	{ v5 }[1], [x7], x1
b.le	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
st1.16b	{ v4 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
st1.16b	{ v5 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
st1.16b	{ v6 }, [x0], x1
subs	w5, w5, #4
st1.16b	{ v7 }, [x0], x1
b.le	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	w_avg_8bpc_neon
add	x7, x0, x1
lsl	x1, x1, #1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
st1.16b	{ v4, v5 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
subs	w5, w5, #2
st1.16b	{ v6, v7 }, [x7], x1
b.le	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	w_avg_8bpc_neon
add	x7, x0, x1
lsl	x1, x1, #1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v16, v0, #4
sqrshrun2.16b	v16, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v17, v0, #4
sqrshrun2.16b	v17, v1, #4
st1.16b	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v18, v0, #4
sqrshrun2.16b	v18, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v19, v0, #4
sqrshrun2.16b	v19, v1, #4
subs	w5, w5, #2
st1.16b	{ v16, v17, v18, v19 }, [x7], x1
b.le	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	w_avg_8bpc_neon
add	x7, x0, #64
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v16, v0, #4
sqrshrun2.16b	v16, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v17, v0, #4
sqrshrun2.16b	v17, v1, #4
st1.16b	{ v4, v5, v6, v7 }, [x0], x1
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v18, v0, #4
sqrshrun2.16b	v18, v1, #4
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v19, v0, #4
sqrshrun2.16b	v19, v1, #4
subs	w5, w5, #1
st1.16b	{ v16, v17, v18, v19 }, [x7], x1
b.le	w_avg_8bpc_neon
ld1.8h	{ v0, v1 }, [x2], #32
ld1.8h	{ v2, v3 }, [x3], #32
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v30
sqdmulh.8h	v1, v1, v30
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	w_avg_8bpc_neon
ret
<unknown>
add	z20.b, z27.b, z16.b
ext	z4.b, { z5.b, z6.b }, #193
_mask_8bpc_neon:
clz	w4, w4
movi.16b	v31, #254
adr	x7, #1940
sub	w4, w4, #24
ldrh	w4, [x7, x4, lsl #1]
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
sub	x7, x7, w4, uxtw
br	x7
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x7], x1
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x7], x1
b.eq	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
cmp	w5, #8
st1.s	{ v5 }[0], [x0], x1
st1.s	{ v5 }[1], [x7], x1
st1.s	{ v5 }[2], [x0], x1
st1.s	{ v5 }[3], [x7], x1
b.eq	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x7], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
st1.s	{ v4 }[2], [x0], x1
st1.s	{ v4 }[3], [x7], x1
st1.s	{ v5 }[0], [x0], x1
st1.s	{ v5 }[1], [x7], x1
st1.s	{ v5 }[2], [x0], x1
st1.s	{ v5 }[3], [x7], x1
ret
add	x7, x0, x1
lsl	x1, x1, #1
st1.d	{ v4 }[0], [x0], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
st1.d	{ v4 }[1], [x7], x1
st1.d	{ v5 }[0], [x0], x1
subs	w5, w5, #4
st1.d	{ v5 }[1], [x7], x1
b.le	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
st1.16b	{ v4 }, [x0], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
st1.16b	{ v5 }, [x0], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
st1.16b	{ v6 }, [x0], x1
subs	w5, w5, #4
st1.16b	{ v7 }, [x0], x1
b.le	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	mask_8bpc_neon
add	x7, x0, x1
lsl	x1, x1, #1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
st1.16b	{ v4, v5 }, [x0], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
subs	w5, w5, #2
st1.16b	{ v6, v7 }, [x7], x1
b.le	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	mask_8bpc_neon
add	x7, x0, x1
lsl	x1, x1, #1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v16, v0, #4
sqrshrun2.16b	v16, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v17, v0, #4
sqrshrun2.16b	v17, v1, #4
st1.16b	{ v4, v5, v6, v7 }, [x0], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v18, v0, #4
sqrshrun2.16b	v18, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v19, v0, #4
sqrshrun2.16b	v19, v1, #4
subs	w5, w5, #2
st1.16b	{ v16, v17, v18, v19 }, [x7], x1
b.le	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	mask_8bpc_neon
add	x7, x0, #64
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v5, v0, #4
sqrshrun2.16b	v5, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v6, v0, #4
sqrshrun2.16b	v6, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v7, v0, #4
sqrshrun2.16b	v7, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v16, v0, #4
sqrshrun2.16b	v16, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v17, v0, #4
sqrshrun2.16b	v17, v1, #4
st1.16b	{ v4, v5, v6, v7 }, [x0], x1
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v18, v0, #4
sqrshrun2.16b	v18, v1, #4
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v19, v0, #4
sqrshrun2.16b	v19, v1, #4
subs	w5, w5, #1
st1.16b	{ v16, v17, v18, v19 }, [x7], x1
b.le	mask_8bpc_neon
ld1.16b	{ v30 }, [x6], #16
ld1.8h	{ v0, v1 }, [x2], #32
mul.16b	v30, v30, v31
ld1.8h	{ v2, v3 }, [x3], #32
shll.8h	v28, v30, #8
shll2.8h	v29, v30, #8
sub.8h	v0, v2, v0
sub.8h	v1, v3, v1
sqdmulh.8h	v0, v0, v28
sqdmulh.8h	v1, v1, v29
add.8h	v0, v2, v0
add.8h	v1, v3, v1
sqrshrun.8b	v4, v0, #4
sqrshrun2.16b	v4, v1, #4
b	mask_8bpc_neon
ret
<unknown>
zip2	z20.q, z5.q, z16.q
<unknown>
_w_mask_444_8bpc_neon:
clz	w8, w4
adr	x9, #508
sub	w8, w8, #24
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
mov	w10, #6903
dup.8h	v0, w10
movi.16b	v1, #64
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #4
sub.8h	v16, v6, v4
sub.8h	v17, v7, v5
sabd.8h	v18, v4, v6
sabd.8h	v19, v5, v7
uqsub.8h	v18, v0, v18
uqsub.8h	v19, v0, v19
ushr.8h	v18, v18, #8
ushr.8h	v19, v19, #8
shl.8h	v20, v18, #9
shl.8h	v21, v19, #9
sqdmulh.8h	v20, v20, v16
sqdmulh.8h	v21, v21, v17
add.8h	v20, v20, v4
add.8h	v21, v21, v5
sqrshrun.8b	v22, v20, #4
sqrshrun.8b	v23, v21, #4
uzp1.16b	v18, v18, v19
sub.16b	v18, v1, v18
st1.16b	{ v18 }, [x6], #16
st1.s	{ v22 }[0], [x0], x1
st1.s	{ v22 }[1], [x12], x1
st1.s	{ v23 }[0], [x0], x1
st1.s	{ v23 }[1], [x12], x1
b.gt	w_mask_444_8bpc_neon
ret
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #2
sub.8h	v16, v6, v4
sub.8h	v17, v7, v5
sabd.8h	v18, v4, v6
sabd.8h	v19, v5, v7
uqsub.8h	v18, v0, v18
uqsub.8h	v19, v0, v19
ushr.8h	v18, v18, #8
ushr.8h	v19, v19, #8
shl.8h	v20, v18, #9
shl.8h	v21, v19, #9
sqdmulh.8h	v20, v20, v16
sqdmulh.8h	v21, v21, v17
add.8h	v20, v20, v4
add.8h	v21, v21, v5
sqrshrun.8b	v22, v20, #4
sqrshrun.8b	v23, v21, #4
uzp1.16b	v18, v18, v19
sub.16b	v18, v1, v18
st1.16b	{ v18 }, [x6], #16
st1.8b	{ v22 }, [x0], x1
st1.8b	{ v23 }, [x12], x1
b.gt	w_mask_444_8bpc_neon
ret
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x10, x6, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
mov	w8, w4
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
ld1.8h	{ v16, v17 }, [x7], #32
ld1.8h	{ v18, v19 }, [x9], #32
subs	w8, w8, #16
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
sub.8h	v18, v18, v16
sub.8h	v19, v19, v17
abs.8h	v20, v6
abs.8h	v21, v7
abs.8h	v22, v18
abs.8h	v23, v19
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
uqsub.8h	v22, v0, v22
uqsub.8h	v23, v0, v23
ushr.8h	v20, v20, #8
ushr.8h	v21, v21, #8
ushr.8h	v22, v22, #8
ushr.8h	v23, v23, #8
shl.8h	v24, v20, #9
shl.8h	v25, v21, #9
shl.8h	v26, v22, #9
shl.8h	v27, v23, #9
sqdmulh.8h	v24, v24, v6
sqdmulh.8h	v25, v25, v7
sqdmulh.8h	v26, v26, v18
sqdmulh.8h	v27, v27, v19
add.8h	v24, v24, v4
add.8h	v25, v25, v5
add.8h	v26, v26, v16
add.8h	v27, v27, v17
sqrshrun.8b	v24, v24, #4
sqrshrun.8b	v25, v25, #4
sqrshrun.8b	v26, v26, #4
sqrshrun.8b	v27, v27, #4
uzp1.16b	v20, v20, v21
uzp1.16b	v21, v22, v23
sub.16b	v20, v1, v20
sub.16b	v21, v1, v21
st1.16b	{ v20 }, [x6], #16
st1.16b	{ v21 }, [x10], #16
st1.8b	{ v24, v25 }, [x0], #16
st1.8b	{ v26, v27 }, [x12], #16
b.gt	w_mask_444_8bpc_neon
subs	w5, w5, #2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, w4, uxtw
add	x10, x10, w4, uxtw
add	x0, x0, x1
add	x12, x12, x1
b.gt	w_mask_444_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
_w_mask_422_8bpc_neon:
clz	w8, w4
adr	x9, #532
sub	w8, w8, #24
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
mov	w10, #6903
dup.8h	v0, w10
dup.8b	v2, w7
movi.8b	v3, #129
sub.8b	v3, v3, v2
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #4
sub.8h	v16, v6, v4
sub.8h	v17, v7, v5
sabd.8h	v18, v4, v6
sabd.8h	v19, v5, v7
uqsub.8h	v18, v0, v18
uqsub.8h	v19, v0, v19
ushr.8h	v18, v18, #8
ushr.8h	v19, v19, #8
shl.8h	v20, v18, #9
shl.8h	v21, v19, #9
sqdmulh.8h	v20, v20, v16
sqdmulh.8h	v21, v21, v17
add.8h	v20, v20, v4
add.8h	v21, v21, v5
sqrshrun.8b	v22, v20, #4
sqrshrun.8b	v23, v21, #4
addp.8h	v18, v18, v19
xtn.8b	v18, v18
uhsub.8b	v18, v3, v18
st1.8b	{ v18 }, [x6], #8
st1.s	{ v22 }[0], [x0], x1
st1.s	{ v22 }[1], [x12], x1
st1.s	{ v23 }[0], [x0], x1
st1.s	{ v23 }[1], [x12], x1
b.gt	w_mask_422_8bpc_neon
ret
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #2
sub.8h	v16, v6, v4
sub.8h	v17, v7, v5
sabd.8h	v18, v4, v6
sabd.8h	v19, v5, v7
uqsub.8h	v18, v0, v18
uqsub.8h	v19, v0, v19
ushr.8h	v18, v18, #8
ushr.8h	v19, v19, #8
shl.8h	v20, v18, #9
shl.8h	v21, v19, #9
sqdmulh.8h	v20, v20, v16
sqdmulh.8h	v21, v21, v17
add.8h	v20, v20, v4
add.8h	v21, v21, v5
sqrshrun.8b	v22, v20, #4
sqrshrun.8b	v23, v21, #4
addp.8h	v18, v18, v19
xtn.8b	v18, v18
uhsub.8b	v18, v3, v18
st1.8b	{ v18 }, [x6], #8
st1.8b	{ v22 }, [x0], x1
st1.8b	{ v23 }, [x12], x1
b.gt	w_mask_422_8bpc_neon
ret
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x10, x6, x11, lsr #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
mov	w8, w4
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
ld1.8h	{ v16, v17 }, [x7], #32
ld1.8h	{ v18, v19 }, [x9], #32
subs	w8, w8, #16
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
sub.8h	v18, v18, v16
sub.8h	v19, v19, v17
abs.8h	v20, v6
abs.8h	v21, v7
abs.8h	v22, v18
abs.8h	v23, v19
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
uqsub.8h	v22, v0, v22
uqsub.8h	v23, v0, v23
ushr.8h	v20, v20, #8
ushr.8h	v21, v21, #8
ushr.8h	v22, v22, #8
ushr.8h	v23, v23, #8
shl.8h	v24, v20, #9
shl.8h	v25, v21, #9
shl.8h	v26, v22, #9
shl.8h	v27, v23, #9
sqdmulh.8h	v24, v24, v6
sqdmulh.8h	v25, v25, v7
sqdmulh.8h	v26, v26, v18
sqdmulh.8h	v27, v27, v19
add.8h	v24, v24, v4
add.8h	v25, v25, v5
add.8h	v26, v26, v16
add.8h	v27, v27, v17
sqrshrun.8b	v24, v24, #4
sqrshrun.8b	v25, v25, #4
sqrshrun.8b	v26, v26, #4
sqrshrun.8b	v27, v27, #4
addp.8h	v20, v20, v21
addp.8h	v21, v22, v23
xtn.8b	v20, v20
xtn.8b	v21, v21
uhsub.8b	v20, v3, v20
uhsub.8b	v21, v3, v21
st1.8b	{ v20 }, [x6], #8
st1.8b	{ v21 }, [x10], #8
st1.8b	{ v24, v25 }, [x0], #16
st1.8b	{ v26, v27 }, [x12], #16
b.gt	w_mask_422_8bpc_neon
subs	w5, w5, #2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, x11, lsr #1
add	x10, x10, x11, lsr #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	w_mask_422_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
_w_mask_420_8bpc_neon:
clz	w8, w4
adr	x9, #528
sub	w8, w8, #24
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
mov	w10, #6903
dup.8h	v0, w10
dup.8h	v2, w7
movi.8h	v3, #1, lsl #8
sub.8h	v3, v3, v2
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #4
sub.8h	v16, v6, v4
sub.8h	v17, v7, v5
sabd.8h	v18, v4, v6
sabd.8h	v19, v5, v7
uqsub.8h	v18, v0, v18
uqsub.8h	v19, v0, v19
ushr.8h	v18, v18, #8
ushr.8h	v19, v19, #8
shl.8h	v20, v18, #9
shl.8h	v21, v19, #9
sqdmulh.8h	v20, v20, v16
sqdmulh.8h	v21, v21, v17
add.8h	v20, v20, v4
add.8h	v21, v21, v5
sqrshrun.8b	v22, v20, #4
sqrshrun.8b	v23, v21, #4
trn1.2d	v24, v18, v19
trn2.2d	v25, v18, v19
add.8h	v24, v24, v25
addp.8h	v18, v24, v24
sub.4h	v18, v3, v18
rshrn.8b	v18, v18, #2
st1.s	{ v18 }[0], [x6], #4
st1.s	{ v22 }[0], [x0], x1
st1.s	{ v22 }[1], [x12], x1
st1.s	{ v23 }[0], [x0], x1
st1.s	{ v23 }[1], [x12], x1
b.gt	w_mask_420_8bpc_neon
ret
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
subs	w5, w5, #2
sub.8h	v16, v6, v4
sub.8h	v17, v7, v5
sabd.8h	v18, v4, v6
sabd.8h	v19, v5, v7
uqsub.8h	v18, v0, v18
uqsub.8h	v19, v0, v19
ushr.8h	v18, v18, #8
ushr.8h	v19, v19, #8
shl.8h	v20, v18, #9
shl.8h	v21, v19, #9
sqdmulh.8h	v20, v20, v16
sqdmulh.8h	v21, v21, v17
add.8h	v20, v20, v4
add.8h	v21, v21, v5
sqrshrun.8b	v22, v20, #4
sqrshrun.8b	v23, v21, #4
add.8h	v18, v18, v19
addp.8h	v18, v18, v18
sub.4h	v18, v3, v18
rshrn.8b	v18, v18, #2
st1.s	{ v18 }[0], [x6], #4
st1.8b	{ v22 }, [x0], x1
st1.8b	{ v23 }, [x12], x1
b.gt	w_mask_420_8bpc_neon
ret
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
mov	w8, w4
ld1.8h	{ v4, v5 }, [x2], #32
ld1.8h	{ v6, v7 }, [x3], #32
ld1.8h	{ v16, v17 }, [x7], #32
ld1.8h	{ v18, v19 }, [x9], #32
subs	w8, w8, #16
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
sub.8h	v18, v18, v16
sub.8h	v19, v19, v17
abs.8h	v20, v6
abs.8h	v21, v7
abs.8h	v22, v18
abs.8h	v23, v19
uqsub.8h	v20, v0, v20
uqsub.8h	v21, v0, v21
uqsub.8h	v22, v0, v22
uqsub.8h	v23, v0, v23
ushr.8h	v20, v20, #8
ushr.8h	v21, v21, #8
ushr.8h	v22, v22, #8
ushr.8h	v23, v23, #8
shl.8h	v24, v20, #9
shl.8h	v25, v21, #9
shl.8h	v26, v22, #9
shl.8h	v27, v23, #9
sqdmulh.8h	v24, v24, v6
sqdmulh.8h	v25, v25, v7
sqdmulh.8h	v26, v26, v18
sqdmulh.8h	v27, v27, v19
add.8h	v24, v24, v4
add.8h	v25, v25, v5
add.8h	v26, v26, v16
add.8h	v27, v27, v17
sqrshrun.8b	v24, v24, #4
sqrshrun.8b	v25, v25, #4
sqrshrun.8b	v26, v26, #4
sqrshrun.8b	v27, v27, #4
add.8h	v20, v20, v22
add.8h	v21, v21, v23
addp.8h	v20, v20, v21
sub.8h	v20, v3, v20
rshrn.8b	v20, v20, #2
st1.8b	{ v20 }, [x6], #8
st1.8b	{ v24, v25 }, [x0], #16
st1.8b	{ v26, v27 }, [x12], #16
b.gt	w_mask_420_8bpc_neon
subs	w5, w5, #2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	w_mask_420_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
_blend_8bpc_neon:
adr	x6, #392
clz	w3, w3
sub	w3, w3, #26
ldrh	w3, [x6, x3, lsl #1]
sub	x6, x6, w3, uxtw
movi.16b	v4, #64
add	x8, x0, x1
lsl	x1, x1, #1
br	x6
ld1.8b	{ v2 }, [x5], #8
ld1.d	{ v1 }[0], [x2], #8
ld1.s	{ v0 }[0], [x0]
subs	w4, w4, #2
ld1.s	{ v0 }[1], [x8]
sub.8b	v3, v4, v2
umull.8h	v5, v1, v2
umlal.8h	v5, v0, v3
rshrn.8b	v6, v5, #6
st1.s	{ v6 }[0], [x0], x1
st1.s	{ v6 }[1], [x8], x1
b.gt	blend_8bpc_neon
ret
ld1.16b	{ v2 }, [x5], #16
ld1.16b	{ v1 }, [x2], #16
ld1.d	{ v0 }[0], [x0]
ld1.d	{ v0 }[1], [x8]
sub.16b	v3, v4, v2
subs	w4, w4, #2
umull.8h	v5, v1, v2
umlal.8h	v5, v0, v3
umull2.8h	v6, v1, v2
umlal2.8h	v6, v0, v3
rshrn.8b	v7, v5, #6
rshrn2.16b	v7, v6, #6
st1.d	{ v7 }[0], [x0], x1
st1.d	{ v7 }[1], [x8], x1
b.gt	blend_8bpc_neon
ret
ld1.16b	{ v1, v2 }, [x5], #32
ld1.16b	{ v5, v6 }, [x2], #32
ld1.16b	{ v0 }, [x0]
subs	w4, w4, #2
sub.16b	v7, v4, v1
sub.16b	v20, v4, v2
ld1.16b	{ v3 }, [x8]
umull.8h	v16, v5, v1
umlal.8h	v16, v0, v7
umull2.8h	v17, v5, v1
umlal2.8h	v17, v0, v7
umull.8h	v21, v6, v2
umlal.8h	v21, v3, v20
umull2.8h	v22, v6, v2
umlal2.8h	v22, v3, v20
rshrn.8b	v18, v16, #6
rshrn2.16b	v18, v17, #6
rshrn.8b	v19, v21, #6
rshrn2.16b	v19, v22, #6
st1.16b	{ v18 }, [x0], x1
st1.16b	{ v19 }, [x8], x1
b.gt	blend_8bpc_neon
ret
ld1.16b	{ v0, v1, v2, v3 }, [x5], #64
ld1.16b	{ v16, v17, v18, v19 }, [x2], #64
ld1.16b	{ v20, v21 }, [x0]
subs	w4, w4, #2
ld1.16b	{ v22, v23 }, [x8]
sub.16b	v5, v4, v0
sub.16b	v6, v4, v1
sub.16b	v30, v4, v2
sub.16b	v31, v4, v3
umull.8h	v24, v16, v0
umlal.8h	v24, v20, v5
umull2.8h	v26, v16, v0
umlal2.8h	v26, v20, v5
umull.8h	v28, v17, v1
umlal.8h	v28, v21, v6
umull2.8h	v7, v17, v1
umlal2.8h	v7, v21, v6
umull.8h	v27, v18, v2
umlal.8h	v27, v22, v30
umull2.8h	v1, v18, v2
umlal2.8h	v1, v22, v30
umull.8h	v29, v19, v3
umlal.8h	v29, v23, v31
umull2.8h	v21, v19, v3
umlal2.8h	v21, v23, v31
rshrn.8b	v24, v24, #6
rshrn2.16b	v24, v26, #6
rshrn.8b	v25, v28, #6
rshrn2.16b	v25, v7, #6
rshrn.8b	v27, v27, #6
rshrn2.16b	v27, v1, #6
rshrn.8b	v28, v29, #6
rshrn2.16b	v28, v21, #6
st1.16b	{ v24, v25 }, [x0], x1
st1.16b	{ v27, v28 }, [x8], x1
b.gt	blend_8bpc_neon
ret
<unknown>
<unknown>
_blend_h_8bpc_neon:
adr	x6, #504
adrp	x5, blend_h_8bpc_neon
add	x5, x5, #0
add	x5, x5, w4, uxtw
sub	w4, w4, w4, lsr #2
clz	w7, w3
movi.16b	v4, #64
add	x8, x0, x1
lsl	x1, x1, #1
sub	w7, w7, #24
ldrh	w7, [x6, x7, lsl #1]
sub	x6, x6, w7, uxtw
br	x6
ld1.h	{ v0 }[0], [x5], #2
ld1.s	{ v1 }[0], [x2], #4
subs	w4, w4, #2
ld1.h	{ v2 }[0], [x0]
zip1.8b	v0, v0, v0
sub.8b	v3, v4, v0
ld1.h	{ v2 }[1], [x8]
umull.8h	v5, v1, v0
umlal.8h	v5, v2, v3
rshrn.8b	v5, v5, #6
st1.h	{ v5 }[0], [x0], x1
st1.h	{ v5 }[1], [x8], x1
b.gt	blend_h_8bpc_neon
ret
ld2r.8b	{ v0, v1 }, [x5], #2
ld1.8b	{ v2 }, [x2], #8
subs	w4, w4, #2
ext.8b	v0, v0, v1, #4
ld1.s	{ v3 }[0], [x0]
sub.8b	v5, v4, v0
ld1.s	{ v3 }[1], [x8]
umull.8h	v6, v2, v0
umlal.8h	v6, v3, v5
rshrn.8b	v6, v6, #6
st1.s	{ v6 }[0], [x0], x1
st1.s	{ v6 }[1], [x8], x1
b.gt	blend_h_8bpc_neon
ret
ld2r.16b	{ v0, v1 }, [x5], #2
ld1.16b	{ v2 }, [x2], #16
ld1.d	{ v3 }[0], [x0]
ext.16b	v0, v0, v1, #8
sub.16b	v5, v4, v0
ld1.d	{ v3 }[1], [x8]
subs	w4, w4, #2
umull.8h	v6, v0, v2
umlal.8h	v6, v3, v5
umull2.8h	v7, v0, v2
umlal2.8h	v7, v3, v5
rshrn.8b	v16, v6, #6
rshrn2.16b	v16, v7, #6
st1.d	{ v16 }[0], [x0], x1
st1.d	{ v16 }[1], [x8], x1
b.gt	blend_h_8bpc_neon
ret
ld2r.16b	{ v0, v1 }, [x5], #2
ld1.16b	{ v2, v3 }, [x2], #32
ld1.16b	{ v5 }, [x0]
sub.16b	v7, v4, v0
sub.16b	v16, v4, v1
ld1.16b	{ v6 }, [x8]
subs	w4, w4, #2
umull.8h	v17, v0, v2
umlal.8h	v17, v5, v7
umull2.8h	v18, v0, v2
umlal2.8h	v18, v5, v7
umull.8h	v19, v1, v3
umlal.8h	v19, v6, v16
umull2.8h	v20, v1, v3
umlal2.8h	v20, v6, v16
rshrn.8b	v21, v17, #6
rshrn2.16b	v21, v18, #6
rshrn.8b	v22, v19, #6
rshrn2.16b	v22, v20, #6
st1.16b	{ v21 }, [x0], x1
st1.16b	{ v22 }, [x8], x1
b.gt	blend_h_8bpc_neon
ret
sub	x1, x1, w3, uxtw
add	x7, x2, w3, uxtw
ld2r.16b	{ v0, v1 }, [x5], #2
mov	w6, w3
sub.16b	v20, v4, v0
sub.16b	v21, v4, v1
ld1.16b	{ v16, v17 }, [x2], #32
ld1.16b	{ v2, v3 }, [x0]
subs	w6, w6, #32
umull.8h	v23, v0, v16
umlal.8h	v23, v2, v20
ld1.16b	{ v18, v19 }, [x7], #32
umull2.8h	v27, v0, v16
umlal2.8h	v27, v2, v20
ld1.16b	{ v6, v7 }, [x8]
umull.8h	v24, v0, v17
umlal.8h	v24, v3, v20
umull2.8h	v28, v0, v17
umlal2.8h	v28, v3, v20
umull.8h	v25, v1, v18
umlal.8h	v25, v6, v21
umull2.8h	v5, v1, v18
umlal2.8h	v5, v6, v21
rshrn.8b	v29, v23, #6
rshrn2.16b	v29, v27, #6
umull.8h	v26, v1, v19
umlal.8h	v26, v7, v21
umull2.8h	v31, v1, v19
umlal2.8h	v31, v7, v21
rshrn.8b	v30, v24, #6
rshrn2.16b	v30, v28, #6
rshrn.8b	v23, v25, #6
rshrn2.16b	v23, v5, #6
rshrn.8b	v24, v26, #6
st1.16b	{ v29, v30 }, [x0], #32
rshrn2.16b	v24, v31, #6
st1.16b	{ v23, v24 }, [x8], #32
b.gt	blend_h_8bpc_neon
subs	w4, w4, #2
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, w3, uxtw
add	x7, x7, w3, uxtw
b.gt	blend_h_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#452
_blend_v_8bpc_neon:
adr	x6, #476
adrp	x5, blend_v_8bpc_neon
add	x5, x5, #0
add	x5, x5, w3, uxtw
clz	w3, w3
movi.16b	v4, #64
add	x8, x0, x1
lsl	x1, x1, #1
sub	w3, w3, #26
ldrh	w3, [x6, x3, lsl #1]
sub	x6, x6, w3, uxtw
br	x6
ld1r.8b	{ v0 }, [x5]
sub.8b	v1, v4, v0
ld1.h	{ v2 }[0], [x2], #2
ld1.b	{ v3 }[0], [x0]
subs	w4, w4, #2
ld1.b	{ v2 }[1], [x2]
ld1.b	{ v3 }[1], [x8]
umull.8h	v5, v2, v0
umlal.8h	v5, v3, v1
rshrn.8b	v5, v5, #6
add	x2, x2, #2
st1.b	{ v5 }[0], [x0], x1
st1.b	{ v5 }[1], [x8], x1
b.gt	blend_v_8bpc_neon
ret
ld1r.2s	{ v0 }, [x5]
sub	x1, x1, #2
sub.8b	v1, v4, v0
ld1.8b	{ v2 }, [x2], #8
ld1.s	{ v3 }[0], [x0]
ld1.s	{ v3 }[1], [x8]
subs	w4, w4, #2
umull.8h	v5, v2, v0
umlal.8h	v5, v3, v1
rshrn.8b	v5, v5, #6
st1.h	{ v5 }[0], [x0], #2
st1.h	{ v5 }[2], [x8], #2
st1.b	{ v5 }[2], [x0], x1
st1.b	{ v5 }[6], [x8], x1
b.gt	blend_v_8bpc_neon
ret
ld1r.2d	{ v0 }, [x5]
sub	x1, x1, #4
sub.16b	v1, v4, v0
ld1.16b	{ v2 }, [x2], #16
ld1.d	{ v3 }[0], [x0]
ld1.d	{ v3 }[1], [x8]
subs	w4, w4, #2
umull.8h	v5, v0, v2
umlal.8h	v5, v3, v1
umull2.8h	v6, v0, v2
umlal2.8h	v6, v3, v1
rshrn.8b	v7, v5, #6
rshrn2.16b	v7, v6, #6
st1.s	{ v7 }[0], [x0], #4
st1.s	{ v7 }[2], [x8], #4
st1.h	{ v7 }[2], [x0], x1
st1.h	{ v7 }[6], [x8], x1
b.gt	blend_v_8bpc_neon
ret
ld1.16b	{ v0 }, [x5]
sub	x1, x1, #8
sub.16b	v2, v4, v0
ld1.16b	{ v5, v6 }, [x2], #32
ld1.16b	{ v7 }, [x0]
subs	w4, w4, #2
ld1.16b	{ v16 }, [x8]
umull.8h	v17, v5, v0
umlal.8h	v17, v7, v2
umull2.8h	v18, v5, v0
umlal2.8h	v18, v7, v2
umull.8h	v20, v6, v0
umlal.8h	v20, v16, v2
umull2.8h	v21, v6, v0
umlal2.8h	v21, v16, v2
rshrn.8b	v19, v17, #6
rshrn2.16b	v19, v18, #6
rshrn.8b	v22, v20, #6
rshrn2.16b	v22, v21, #6
st1.8b	{ v19 }, [x0], #8
st1.8b	{ v22 }, [x8], #8
st1.s	{ v19 }[2], [x0], x1
st1.s	{ v22 }[2], [x8], x1
b.gt	blend_v_8bpc_neon
ret
ld1.16b	{ v0, v1 }, [x5]
sub	x1, x1, #16
sub.16b	v2, v4, v0
sub.8b	v3, v4, v1
ld1.16b	{ v16, v17, v18, v19 }, [x2], #64
ld1.16b	{ v5, v6 }, [x0]
subs	w4, w4, #2
ld1.16b	{ v20, v21 }, [x8]
umull.8h	v22, v16, v0
umlal.8h	v22, v5, v2
umull2.8h	v23, v16, v0
umlal2.8h	v23, v5, v2
umull.8h	v28, v17, v1
umlal.8h	v28, v6, v3
umull.8h	v30, v18, v0
umlal.8h	v30, v20, v2
umull2.8h	v31, v18, v0
umlal2.8h	v31, v20, v2
umull.8h	v25, v19, v1
umlal.8h	v25, v21, v3
rshrn.8b	v24, v22, #6
rshrn2.16b	v24, v23, #6
rshrn.8b	v28, v28, #6
rshrn.8b	v30, v30, #6
rshrn2.16b	v30, v31, #6
rshrn.8b	v27, v25, #6
st1.16b	{ v24 }, [x0], #16
st1.16b	{ v30 }, [x8], #16
st1.8b	{ v28 }, [x0], x1
st1.8b	{ v27 }, [x8], x1
b.gt	blend_v_8bpc_neon
ret
<unknown>
<unknown>
udf	#428
_put_neon:
adr	x9, #292
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, x8
br	x9
ldrh	w9, [x2]
ldrh	w10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #2
strh	w9, [x0]
strh	w10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	put_neon
ret
ldr	w9, [x2]
ldr	w10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #2
str	w9, [x0]
str	w10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	put_neon
ret
ldr	x9, [x2]
ldr	x10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #2
str	x9, [x0]
str	x10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	put_neon
ret
ldr	q0, [x2]
ldr	q1, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #2
str	q0, [x0]
str	q1, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	put_neon
ret
ldp	q0, q1, [x2]
add	x2, x2, x3
stp	q0, q1, [x0]
add	x0, x0, x1
ldp	q2, q3, [x2]
add	x2, x2, x3
stp	q2, q3, [x0]
subs	w5, w5, #2
add	x0, x0, x1
b.gt	put_neon
ret
ldp	q0, q1, [x2]
stp	q0, q1, [x0]
ldp	q2, q3, [x2, #32]
add	x2, x2, x3
stp	q2, q3, [x0, #32]
subs	w5, w5, #1
add	x0, x0, x1
b.gt	put_neon
ret
ldp	q0, q1, [x2]
stp	q0, q1, [x0]
ldp	q2, q3, [x2, #32]
stp	q2, q3, [x0, #32]
ldp	q4, q5, [x2, #64]
stp	q4, q5, [x0, #64]
ldp	q6, q7, [x2, #96]
add	x2, x2, x3
stp	q6, q7, [x0, #96]
subs	w5, w5, #1
add	x0, x0, x1
b.gt	put_neon
ret
<unknown>
<unknown>
<unknown>
udf	#276
_prep_neon:
adr	x9, #500
ldrh	w8, [x9, x8, lsl #1]
movi.16b	v24, #16
sub	x9, x9, x8
br	x9
ld1.s	{ v0 }[0], [x1], x2
ld1.s	{ v0 }[1], [x1], x2
ld1.s	{ v1 }[0], [x1], x2
ld1.s	{ v1 }[1], [x1], x2
ushll.8h	v0, v0, #4
ushll.8h	v1, v1, #4
subs	w4, w4, #4
stp	q0, q1, [x0], #32
b.gt	prep_neon
ret
ldr	d0, [x1]
ldr	d1, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d2, [x1]
ldr	d3, [x1, x2]
add	x1, x1, x2, lsl #1
ushll.8h	v0, v0, #4
ushll.8h	v1, v1, #4
umull.8h	v2, v2, v24
umull.8h	v3, v3, v24
subs	w4, w4, #4
stp	q0, q1, [x0]
stp	q2, q3, [x0, #32]
add	x0, x0, #64
b.gt	prep_neon
ret
ldr	q1, [x1]
ldr	q3, [x1, x2]
add	x1, x1, x2, lsl #1
ushll.8h	v0, v1, #4
ushll2.8h	v1, v1, #4
ldr	q5, [x1]
ldr	q7, [x1, x2]
add	x1, x1, x2, lsl #1
umull.8h	v2, v3, v24
umull2.8h	v3, v3, v24
ushll.8h	v4, v5, #4
ushll2.8h	v5, v5, #4
umull.8h	v6, v7, v24
umull2.8h	v7, v7, v24
subs	w4, w4, #4
stp	q0, q1, [x0]
stp	q2, q3, [x0, #32]
stp	q4, q5, [x0, #64]
stp	q6, q7, [x0, #96]
add	x0, x0, #128
b.gt	prep_neon
ret
ldp	q4, q5, [x1]
add	x1, x1, x2
ldp	q6, q7, [x1]
add	x1, x1, x2
ushll.8h	v0, v4, #4
ushll2.8h	v1, v4, #4
umull.8h	v2, v5, v24
umull2.8h	v3, v5, v24
ushll.8h	v4, v6, #4
ushll2.8h	v5, v6, #4
umull.8h	v6, v7, v24
umull2.8h	v7, v7, v24
subs	w4, w4, #2
stp	q0, q1, [x0]
stp	q2, q3, [x0, #32]
stp	q4, q5, [x0, #64]
stp	q6, q7, [x0, #96]
add	x0, x0, #128
b.gt	prep_neon
ret
ldp	q4, q5, [x1]
ldp	q6, q7, [x1, #32]
add	x1, x1, x2
ushll.8h	v0, v4, #4
ushll2.8h	v1, v4, #4
umull.8h	v2, v5, v24
umull2.8h	v3, v5, v24
ushll.8h	v4, v6, #4
ushll2.8h	v5, v6, #4
umull.8h	v6, v7, v24
umull2.8h	v7, v7, v24
subs	w4, w4, #1
stp	q0, q1, [x0]
stp	q2, q3, [x0, #32]
stp	q4, q5, [x0, #64]
stp	q6, q7, [x0, #96]
add	x0, x0, #128
b.gt	prep_neon
ret
ldp	q28, q29, [x1]
ldp	q30, q31, [x1, #32]
ushll.8h	v16, v28, #4
ushll2.8h	v17, v28, #4
umull.8h	v18, v29, v24
umull2.8h	v19, v29, v24
ushll.8h	v20, v30, #4
ushll2.8h	v21, v30, #4
umull.8h	v22, v31, v24
umull2.8h	v23, v31, v24
ldp	q28, q29, [x1, #64]
ldp	q30, q31, [x1, #96]
add	x1, x1, x2
stp	q16, q17, [x0]
stp	q18, q19, [x0, #32]
stp	q20, q21, [x0, #64]
stp	q22, q23, [x0, #96]
ushll.8h	v16, v28, #4
ushll2.8h	v17, v28, #4
umull.8h	v18, v29, v24
umull2.8h	v19, v29, v24
ushll.8h	v20, v30, #4
ushll2.8h	v21, v30, #4
umull.8h	v22, v31, v24
umull2.8h	v23, v31, v24
subs	w4, w4, #1
stp	q16, q17, [x0, #128]
stp	q18, q19, [x0, #160]
stp	q20, q21, [x0, #192]
stp	q22, q23, [x0, #224]
add	x0, x0, #256
b.gt	prep_neon
ret
<unknown>
<unknown>
<unknown>
_put_8tap_regular_sharp_8bpc_neon:
mov	x8, #45
mov	x9, #3885
b	put_8tap_neon
_put_8tap_smooth_sharp_8bpc_neon:
mov	x8, #1980
mov	x9, #3885
b	put_8tap_neon
_put_8tap_sharp_8bpc_neon:
mov	x8, #3885
mov	x9, #3885
b	put_8tap_neon
_put_8tap_sharp_regular_8bpc_neon:
mov	x8, #3885
mov	x9, #45
b	put_8tap_neon
_put_8tap_sharp_smooth_8bpc_neon:
mov	x8, #3885
mov	x9, #1980
b	put_8tap_neon
_put_8tap_neon:
mov	w10, #16513
mul	w6, w6, w10
mul	w7, w7, w10
add	w6, w6, w8
add	w7, w7, w9
clz	w8, w4
tst	w6, #0x1fc000
sub	w8, w8, #24
adrp	x10, put_8tap_neon
add	x10, x10, #0
sub	x10, x10, #8
b.ne	put_8tap_neon
tst	w7, #0x1fc000
b.ne	put_8tap_neon
b	put_neon
cmp	w4, #4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	put_8tap_neon
mov	w6, w9
tst	w7, #0x1fc000
add	x6, x10, w6, uxtw #3
b.ne	put_8tap_neon
adr	x9, #908
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v4 }, [x2], x3
ld1.8b	{ v6 }, [x9], x3
ushll.8h	v4, v4, #0
ushll.8h	v6, v6, #0
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
subs	w5, w5, #2
trn1.2s	v3, v4, v6
trn2.2s	v6, v4, v6
trn1.2s	v4, v5, v7
trn2.2s	v7, v5, v7
mul.4h	v3, v3, v0[0]
mla.4h	v3, v4, v0[1]
mla.4h	v3, v6, v0[2]
mla.4h	v3, v7, v0[3]
srshr.4h	v3, v3, #2
sqrshrun.8b	v3, v3, #4
st1.h	{ v3 }[0], [x0], x1
st1.h	{ v3 }[1], [x8], x1
b.gt	put_8tap_neon
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16 }, [x2], x3
ld1.8b	{ v20 }, [x9], x3
ushll.8h	v16, v16, #0
ushll.8h	v20, v20, #0
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w5, w5, #2
mul.4h	v16, v16, v0[0]
mla.4h	v16, v17, v0[1]
mla.4h	v16, v18, v0[2]
mla.4h	v16, v19, v0[3]
mul.4h	v20, v20, v0[0]
mla.4h	v20, v21, v0[1]
mla.4h	v20, v22, v0[2]
mla.4h	v20, v23, v0[3]
srshr.4h	v16, v16, #2
srshr.4h	v20, v20, #2
sqrshrun.8b	v16, v16, #4
sqrshrun.8b	v20, v20, #4
st1.s	{ v16 }[0], [x0], x1
st1.s	{ v20 }[0], [x8], x1
b.gt	put_8tap_neon
ret
ld1.8b	{ v0 }, [x6]
sub	x2, x2, #3
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16, v17 }, [x2], x3
ld1.8b	{ v20, v21 }, [x9], x3
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
mul.8h	v18, v16, v0[0]
mul.8h	v22, v20, v0[0]
ext.16b	v19, v16, v17, #2
ext.16b	v23, v20, v21, #2
mla.8h	v18, v19, v0[1]
mla.8h	v22, v23, v0[1]
ext.16b	v19, v16, v17, #4
ext.16b	v23, v20, v21, #4
mla.8h	v18, v19, v0[2]
mla.8h	v22, v23, v0[2]
ext.16b	v19, v16, v17, #6
ext.16b	v23, v20, v21, #6
mla.8h	v18, v19, v0[3]
mla.8h	v22, v23, v0[3]
ext.16b	v19, v16, v17, #8
ext.16b	v23, v20, v21, #8
mla.8h	v18, v19, v0[4]
mla.8h	v22, v23, v0[4]
ext.16b	v19, v16, v17, #10
ext.16b	v23, v20, v21, #10
mla.8h	v18, v19, v0[5]
mla.8h	v22, v23, v0[5]
ext.16b	v19, v16, v17, #12
ext.16b	v23, v20, v21, #12
mla.8h	v18, v19, v0[6]
mla.8h	v22, v23, v0[6]
ext.16b	v19, v16, v17, #14
ext.16b	v23, v20, v21, #14
mla.8h	v18, v19, v0[7]
mla.8h	v22, v23, v0[7]
subs	w5, w5, #2
srshr.8h	v18, v18, #2
srshr.8h	v22, v22, #2
sqrshrun.8b	v18, v18, #4
sqrshrun.8b	v22, v22, #4
st1.8b	{ v18 }, [x0], x1
st1.8b	{ v22 }, [x8], x1
b.gt	put_8tap_neon
ret
ld1.8b	{ v0 }, [x6]
sub	x2, x2, #3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
sub	x3, x3, w4, uxtw
sub	x3, x3, #8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
ld1.8b	{ v16, v17, v18 }, [x2], #24
ld1.8b	{ v20, v21, v22 }, [x9], #24
mov	w6, w4
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
mul.8h	v24, v16, v0[0]
mul.8h	v25, v17, v0[0]
mul.8h	v26, v20, v0[0]
mul.8h	v27, v21, v0[0]
ext.16b	v28, v16, v17, #2
ext.16b	v29, v17, v18, #2
ext.16b	v30, v20, v21, #2
ext.16b	v31, v21, v22, #2
mla.8h	v24, v28, v0[1]
mla.8h	v25, v29, v0[1]
mla.8h	v26, v30, v0[1]
mla.8h	v27, v31, v0[1]
ext.16b	v28, v16, v17, #4
ext.16b	v29, v17, v18, #4
ext.16b	v30, v20, v21, #4
ext.16b	v31, v21, v22, #4
mla.8h	v24, v28, v0[2]
mla.8h	v25, v29, v0[2]
mla.8h	v26, v30, v0[2]
mla.8h	v27, v31, v0[2]
ext.16b	v28, v16, v17, #6
ext.16b	v29, v17, v18, #6
ext.16b	v30, v20, v21, #6
ext.16b	v31, v21, v22, #6
mla.8h	v24, v28, v0[3]
mla.8h	v25, v29, v0[3]
mla.8h	v26, v30, v0[3]
mla.8h	v27, v31, v0[3]
ext.16b	v28, v16, v17, #8
ext.16b	v29, v17, v18, #8
ext.16b	v30, v20, v21, #8
ext.16b	v31, v21, v22, #8
mla.8h	v24, v28, v0[4]
mla.8h	v25, v29, v0[4]
mla.8h	v26, v30, v0[4]
mla.8h	v27, v31, v0[4]
ext.16b	v28, v16, v17, #10
ext.16b	v29, v17, v18, #10
ext.16b	v30, v20, v21, #10
ext.16b	v31, v21, v22, #10
mla.8h	v24, v28, v0[5]
mla.8h	v25, v29, v0[5]
mla.8h	v26, v30, v0[5]
mla.8h	v27, v31, v0[5]
ext.16b	v28, v16, v17, #12
ext.16b	v29, v17, v18, #12
ext.16b	v30, v20, v21, #12
ext.16b	v31, v21, v22, #12
mla.8h	v24, v28, v0[6]
mla.8h	v25, v29, v0[6]
mla.8h	v26, v30, v0[6]
mla.8h	v27, v31, v0[6]
ext.16b	v28, v16, v17, #14
ext.16b	v29, v17, v18, #14
ext.16b	v30, v20, v21, #14
ext.16b	v31, v21, v22, #14
mla.8h	v24, v28, v0[7]
mla.8h	v25, v29, v0[7]
mla.8h	v26, v30, v0[7]
mla.8h	v27, v31, v0[7]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
srshr.8h	v26, v26, #2
srshr.8h	v27, v27, #2
subs	w6, w6, #16
sqrshrun.8b	v24, v24, #4
sqrshrun2.16b	v24, v25, #4
sqrshrun.8b	v26, v26, #4
sqrshrun2.16b	v26, v27, #4
st1.16b	{ v24 }, [x0], #16
st1.16b	{ v26 }, [x8], #16
b.le	put_8tap_neon
mov.16b	v16, v18
mov.16b	v20, v22
ld1.8b	{ v17, v18 }, [x2], #16
ld1.8b	{ v21, v22 }, [x9], #16
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
b	put_8tap_neon
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #2
b.gt	put_8tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#892
cmp	w5, #4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_8tap_neon
mov	w7, w9
add	x7, x10, w7, uxtw #3
adr	x9, #2580
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
b.gt	put_8tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.h	{ v1 }[0], [x2], x3
ld1.h	{ v2 }[0], [x9], x3
ld1.h	{ v3 }[0], [x2], x3
ld1.h	{ v4 }[0], [x9], x3
ld1.h	{ v5 }[0], [x2], x3
trn1.4h	v1, v1, v2
trn1.4h	v2, v2, v3
trn1.4h	v3, v3, v4
trn1.4h	v4, v4, v5
b.gt	put_8tap_neon
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.4h	v6, v1, v0[0]
mla.4h	v6, v2, v0[1]
mla.4h	v6, v3, v0[2]
mla.4h	v6, v4, v0[3]
sqrshrun.8b	v6, v6, #6
st1.h	{ v6 }[0], [x0], x1
st1.h	{ v6 }[1], [x8], x1
ret
ld1.h	{ v6 }[0], [x9], x3
ld1.h	{ v7 }[0], [x2], x3
trn1.4h	v5, v5, v6
trn1.4h	v6, v6, v7
trn1.2s	v1, v1, v3
trn1.2s	v2, v2, v4
trn1.2s	v3, v3, v5
trn1.2s	v4, v4, v6
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
sqrshrun.8b	v6, v6, #6
st1.h	{ v6 }[0], [x0], x1
st1.h	{ v6 }[1], [x8], x1
st1.h	{ v6 }[2], [x0], x1
st1.h	{ v6 }[3], [x8], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.h	{ v1 }[0], [x2], x3
ld1.h	{ v2 }[0], [x9], x3
ld1.h	{ v3 }[0], [x2], x3
ld1.h	{ v4 }[0], [x9], x3
ld1.h	{ v5 }[0], [x2], x3
ld1.h	{ v6 }[0], [x9], x3
ld1.h	{ v7 }[0], [x2], x3
trn1.4h	v1, v1, v2
trn1.4h	v2, v2, v3
trn1.4h	v3, v3, v4
trn1.4h	v4, v4, v5
trn1.4h	v5, v5, v6
trn1.4h	v6, v6, v7
trn1.2s	v1, v1, v3
trn1.2s	v2, v2, v4
trn1.2s	v3, v3, v5
trn1.2s	v4, v4, v6
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
subs	w5, w5, #4
ld1.h	{ v16 }[0], [x9], x3
ld1.h	{ v17 }[0], [x2], x3
ld1.h	{ v18 }[0], [x9], x3
ld1.h	{ v19 }[0], [x2], x3
trn1.4h	v7, v7, v16
trn1.4h	v16, v16, v17
trn1.4h	v17, v17, v18
trn1.4h	v18, v18, v19
trn1.2s	v5, v5, v7
trn1.2s	v6, v6, v16
trn1.2s	v7, v7, v17
trn1.2s	v16, v16, v18
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
ushll.8h	v16, v16, #0
mul.8h	v30, v1, v0[0]
mla.8h	v30, v2, v0[1]
mla.8h	v30, v3, v0[2]
mla.8h	v30, v4, v0[3]
mla.8h	v30, v5, v0[4]
mla.8h	v30, v6, v0[5]
mla.8h	v30, v7, v0[6]
mla.8h	v30, v16, v0[7]
sqrshrun.8b	v30, v30, #6
st1.h	{ v30 }[0], [x0], x1
st1.h	{ v30 }[1], [x8], x1
st1.h	{ v30 }[2], [x0], x1
st1.h	{ v30 }[3], [x8], x1
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
ld1.h	{ v16 }[0], [x9], x3
ld1.h	{ v17 }[0], [x2], x3
trn1.4h	v7, v7, v16
trn1.4h	v16, v16, v17
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
ushll.8h	v16, v16, #0
mul.4h	v30, v1, v0[0]
mla.4h	v30, v2, v0[1]
mla.4h	v30, v3, v0[2]
mla.4h	v30, v4, v0[3]
mla.4h	v30, v5, v0[4]
mla.4h	v30, v6, v0[5]
mla.4h	v30, v7, v0[6]
mla.4h	v30, v16, v0[7]
sqrshrun.8b	v30, v30, #6
st1.h	{ v30 }[0], [x0], x1
st1.h	{ v30 }[1], [x8], x1
ret
b.gt	put_8tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x3
ld1.s	{ v2 }[0], [x9], x3
ld1.s	{ v3 }[0], [x2], x3
ld1.s	{ v4 }[0], [x9], x3
ld1.s	{ v5 }[0], [x2], x3
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
sqrshrun.8b	v6, v6, #6
st1.s	{ v6 }[0], [x0], x1
st1.s	{ v6 }[1], [x8], x1
b.le	put_8tap_neon
ld1.s	{ v6 }[0], [x9], x3
ld1.s	{ v7 }[0], [x2], x3
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
mul.8h	v7, v3, v0[0]
mla.8h	v7, v4, v0[1]
mla.8h	v7, v5, v0[2]
mla.8h	v7, v6, v0[3]
sqrshrun.8b	v7, v7, #6
st1.s	{ v7 }[0], [x0], x1
st1.s	{ v7 }[1], [x8], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.s	{ v16 }[0], [x2], x3
ld1.s	{ v17 }[0], [x9], x3
ld1.s	{ v18 }[0], [x2], x3
ld1.s	{ v19 }[0], [x9], x3
ld1.s	{ v20 }[0], [x2], x3
ld1.s	{ v21 }[0], [x9], x3
ld1.s	{ v22 }[0], [x2], x3
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
subs	w5, w5, #4
ld1.s	{ v23 }[0], [x9], x3
ld1.s	{ v24 }[0], [x2], x3
ld1.s	{ v25 }[0], [x9], x3
ld1.s	{ v26 }[0], [x2], x3
trn1.2s	v22, v22, v23
trn1.2s	v23, v23, v24
trn1.2s	v24, v24, v25
trn1.2s	v25, v25, v26
ushll.8h	v22, v22, #0
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
ushll.8h	v25, v25, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mla.8h	v1, v23, v0[7]
mul.8h	v2, v18, v0[0]
mla.8h	v2, v19, v0[1]
mla.8h	v2, v20, v0[2]
mla.8h	v2, v21, v0[3]
mla.8h	v2, v22, v0[4]
mla.8h	v2, v23, v0[5]
mla.8h	v2, v24, v0[6]
mla.8h	v2, v25, v0[7]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x8], x1
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x8], x1
b.le	put_8tap_neon
ld1.s	{ v27 }[0], [x9], x3
ld1.s	{ v16 }[0], [x2], x3
subs	w5, w5, #2
trn1.2s	v26, v26, v27
trn1.2s	v27, v27, v16
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
mul.8h	v1, v20, v0[0]
mla.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
mla.8h	v1, v27, v0[7]
sqrshrun.8b	v1, v1, #6
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x8], x1
b.le	put_8tap_neon
ld1.s	{ v17 }[0], [x9], x3
ld1.s	{ v18 }[0], [x2], x3
subs	w5, w5, #2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
mul.8h	v2, v22, v0[0]
mla.8h	v2, v23, v0[1]
mla.8h	v2, v24, v0[2]
mla.8h	v2, v25, v0[3]
mla.8h	v2, v26, v0[4]
mla.8h	v2, v27, v0[5]
mla.8h	v2, v16, v0[6]
mla.8h	v2, v17, v0[7]
sqrshrun.8b	v2, v2, #6
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x8], x1
b.le	put_8tap_neon
subs	w5, w5, #4
ld1.s	{ v19 }[0], [x9], x3
ld1.s	{ v20 }[0], [x2], x3
ld1.s	{ v21 }[0], [x9], x3
ld1.s	{ v22 }[0], [x2], x3
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
mul.8h	v1, v24, v0[0]
mla.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mla.8h	v1, v19, v0[7]
mul.8h	v2, v26, v0[0]
mla.8h	v2, v27, v0[1]
mla.8h	v2, v16, v0[2]
mla.8h	v2, v17, v0[3]
mla.8h	v2, v18, v0[4]
mla.8h	v2, v19, v0[5]
mla.8h	v2, v20, v0[6]
mla.8h	v2, v21, v0[7]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x8], x1
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x8], x1
b.gt	put_8tap_neon
ret
b.gt	put_8tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v1 }, [x2], x3
ld1.8b	{ v2 }, [x9], x3
ld1.8b	{ v3 }, [x2], x3
ld1.8b	{ v4 }, [x9], x3
ld1.8b	{ v5 }, [x2], x3
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
ushll.8h	v5, v5, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
mul.8h	v7, v2, v0[0]
mla.8h	v7, v3, v0[1]
mla.8h	v7, v4, v0[2]
mla.8h	v7, v5, v0[3]
sqrshrun.8b	v6, v6, #6
sqrshrun.8b	v7, v7, #6
st1.8b	{ v6 }, [x0], x1
st1.8b	{ v7 }, [x8], x1
b.le	put_8tap_neon
ld1.8b	{ v6 }, [x9], x3
ld1.8b	{ v7 }, [x2], x3
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
mul.8h	v1, v3, v0[0]
mla.8h	v1, v4, v0[1]
mla.8h	v1, v5, v0[2]
mla.8h	v1, v6, v0[3]
mul.8h	v2, v4, v0[0]
mla.8h	v2, v5, v0[1]
mla.8h	v2, v6, v0[2]
mla.8h	v2, v7, v0[3]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8b	{ v16 }, [x2], x3
ld1.8b	{ v17 }, [x9], x3
ld1.8b	{ v18 }, [x2], x3
ld1.8b	{ v19 }, [x9], x3
ld1.8b	{ v20 }, [x2], x3
ld1.8b	{ v21 }, [x9], x3
ld1.8b	{ v22 }, [x2], x3
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
subs	w5, w5, #2
ld1.8b	{ v23 }, [x9], x3
ld1.8b	{ v24 }, [x2], x3
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mla.8h	v1, v23, v0[7]
mul.8h	v2, v17, v0[0]
mla.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
mla.8h	v2, v20, v0[3]
mla.8h	v2, v21, v0[4]
mla.8h	v2, v22, v0[5]
mla.8h	v2, v23, v0[6]
mla.8h	v2, v24, v0[7]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
b.le	put_8tap_neon
subs	w5, w5, #2
ld1.8b	{ v25 }, [x9], x3
ld1.8b	{ v26 }, [x2], x3
ushll.8h	v25, v25, #0
ushll.8h	v26, v26, #0
mul.8h	v3, v18, v0[0]
mla.8h	v3, v19, v0[1]
mla.8h	v3, v20, v0[2]
mla.8h	v3, v21, v0[3]
mla.8h	v3, v22, v0[4]
mla.8h	v3, v23, v0[5]
mla.8h	v3, v24, v0[6]
mla.8h	v3, v25, v0[7]
mul.8h	v4, v19, v0[0]
mla.8h	v4, v20, v0[1]
mla.8h	v4, v21, v0[2]
mla.8h	v4, v22, v0[3]
mla.8h	v4, v23, v0[4]
mla.8h	v4, v24, v0[5]
mla.8h	v4, v25, v0[6]
mla.8h	v4, v26, v0[7]
sqrshrun.8b	v3, v3, #6
sqrshrun.8b	v4, v4, #6
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_8tap_neon
subs	w5, w5, #2
ld1.8b	{ v27 }, [x9], x3
ld1.8b	{ v16 }, [x2], x3
ushll.8h	v27, v27, #0
ushll.8h	v16, v16, #0
mul.8h	v1, v20, v0[0]
mla.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
mla.8h	v1, v27, v0[7]
mul.8h	v2, v21, v0[0]
mla.8h	v2, v22, v0[1]
mla.8h	v2, v23, v0[2]
mla.8h	v2, v24, v0[3]
mla.8h	v2, v25, v0[4]
mla.8h	v2, v26, v0[5]
mla.8h	v2, v27, v0[6]
mla.8h	v2, v16, v0[7]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
b.le	put_8tap_neon
subs	w5, w5, #2
ld1.8b	{ v17 }, [x9], x3
ld1.8b	{ v18 }, [x2], x3
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
mul.8h	v3, v22, v0[0]
mla.8h	v3, v23, v0[1]
mla.8h	v3, v24, v0[2]
mla.8h	v3, v25, v0[3]
mla.8h	v3, v26, v0[4]
mla.8h	v3, v27, v0[5]
mla.8h	v3, v16, v0[6]
mla.8h	v3, v17, v0[7]
mul.8h	v4, v23, v0[0]
mla.8h	v4, v24, v0[1]
mla.8h	v4, v25, v0[2]
mla.8h	v4, v26, v0[3]
mla.8h	v4, v27, v0[4]
mla.8h	v4, v16, v0[5]
mla.8h	v4, v17, v0[6]
mla.8h	v4, v18, v0[7]
sqrshrun.8b	v3, v3, #6
sqrshrun.8b	v4, v4, #6
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_8tap_neon
subs	w5, w5, #4
ld1.8b	{ v19 }, [x9], x3
ld1.8b	{ v20 }, [x2], x3
ld1.8b	{ v21 }, [x9], x3
ld1.8b	{ v22 }, [x2], x3
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
mul.8h	v1, v24, v0[0]
mla.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mla.8h	v1, v19, v0[7]
mul.8h	v2, v25, v0[0]
mla.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v16, v0[3]
mla.8h	v2, v17, v0[4]
mla.8h	v2, v18, v0[5]
mla.8h	v2, v19, v0[6]
mla.8h	v2, v20, v0[7]
mul.8h	v3, v26, v0[0]
mla.8h	v3, v27, v0[1]
mla.8h	v3, v16, v0[2]
mla.8h	v3, v17, v0[3]
mla.8h	v3, v18, v0[4]
mla.8h	v3, v19, v0[5]
mla.8h	v3, v20, v0[6]
mla.8h	v3, v21, v0[7]
mul.8h	v4, v27, v0[0]
mla.8h	v4, v16, v0[1]
mla.8h	v4, v17, v0[2]
mla.8h	v4, v18, v0[3]
mla.8h	v4, v19, v0[4]
mla.8h	v4, v20, v0[5]
mla.8h	v4, v21, v0[6]
mla.8h	v4, v22, v0[7]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
sqrshrun.8b	v3, v3, #6
sqrshrun.8b	v4, v4, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.gt	put_8tap_neon
subs	w4, w4, #8
b.le	put_8tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
b	put_8tap_neon
ret
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
cmp	w5, #2
ld1.16b	{ v1 }, [x2], x3
ld1.16b	{ v2 }, [x9], x3
ld1.16b	{ v3 }, [x2], x3
ld1.16b	{ v4 }, [x9], x3
ld1.16b	{ v5 }, [x2], x3
ushll.8h	v16, v1, #0
ushll.8h	v17, v2, #0
ushll.8h	v18, v3, #0
ushll.8h	v19, v4, #0
ushll.8h	v20, v5, #0
ushll2.8h	v23, v1, #0
ushll2.8h	v24, v2, #0
ushll2.8h	v25, v3, #0
ushll2.8h	v26, v4, #0
ushll2.8h	v27, v5, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mul.8h	v16, v17, v0[0]
mla.8h	v16, v18, v0[1]
mla.8h	v16, v19, v0[2]
mla.8h	v16, v20, v0[3]
mul.8h	v2, v23, v0[0]
mla.8h	v2, v24, v0[1]
mla.8h	v2, v25, v0[2]
mla.8h	v2, v26, v0[3]
mul.8h	v17, v24, v0[0]
mla.8h	v17, v25, v0[1]
mla.8h	v17, v26, v0[2]
mla.8h	v17, v27, v0[3]
sqrshrun.8b	v1, v1, #6
sqrshrun2.16b	v1, v2, #6
sqrshrun.8b	v16, v16, #6
sqrshrun2.16b	v16, v17, #6
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v16 }, [x8], x1
b.le	put_8tap_neon
ld1.16b	{ v6 }, [x9], x3
ld1.16b	{ v7 }, [x2], x3
ushll.8h	v21, v6, #0
ushll.8h	v22, v7, #0
ushll2.8h	v28, v6, #0
ushll2.8h	v29, v7, #0
mul.8h	v1, v18, v0[0]
mla.8h	v1, v19, v0[1]
mla.8h	v1, v20, v0[2]
mla.8h	v1, v21, v0[3]
mul.8h	v3, v19, v0[0]
mla.8h	v3, v20, v0[1]
mla.8h	v3, v21, v0[2]
mla.8h	v3, v22, v0[3]
mul.8h	v2, v25, v0[0]
mla.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v28, v0[3]
mul.8h	v4, v26, v0[0]
mla.8h	v4, v27, v0[1]
mla.8h	v4, v28, v0[2]
mla.8h	v4, v29, v0[3]
sqrshrun.8b	v1, v1, #6
sqrshrun2.16b	v1, v2, #6
sqrshrun.8b	v3, v3, #6
sqrshrun2.16b	v3, v4, #6
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v3 }, [x8], x1
ret
sub	z8.b, z1.b, z8.b
<unknown>
<unknown>
udf	#2564
cmp	w5, #4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_8tap_neon
mov	w7, w9
add	x7, x10, w7, uxtw #3
adr	x9, #1784
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x9, x2, #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v28 }, [x2], x3
ushll.8h	v28, v28, #0
ext.16b	v29, v28, v28, #2
mul.4h	v28, v28, v0
mul.4h	v29, v29, v0
addp.4h	v28, v28, v29
addp.4h	v16, v28, v28
srshr.4h	v16, v16, #2
bl	put_8tap_neon
trn1.2s	v16, v16, v28
mov.8b	v17, v28
bl	put_8tap_neon
ext.8b	v18, v17, v28, #4
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v28, v1[3]
sqrshrn.4h	v2, v2, #10
sqxtun.8b	v2, v2
subs	w5, w5, #2
st1.h	{ v2 }[0], [x0], x1
st1.h	{ v2 }[1], [x8], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v28
b	put_8tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v28 }, [x2], x3
ushll.8h	v28, v28, #0
ext.16b	v29, v28, v28, #2
mul.4h	v28, v28, v0
mul.4h	v29, v29, v0
addp.4h	v28, v28, v29
addp.4h	v16, v28, v28
srshr.4h	v16, v16, #2
bl	put_8tap_neon
trn1.2s	v16, v16, v28
mov.8b	v17, v28
bl	put_8tap_neon
ext.8b	v18, v17, v28, #4
mov.8b	v19, v28
bl	put_8tap_neon
ext.8b	v20, v19, v28, #4
mov.8b	v21, v28
bl	put_8tap_neon
ext.8b	v22, v21, v28, #4
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v19, v1[3]
smlal.4s	v2, v20, v1[4]
smlal.4s	v2, v21, v1[5]
smlal.4s	v2, v22, v1[6]
smlal.4s	v2, v28, v1[7]
sqrshrn.4h	v2, v2, #10
sqxtun.8b	v2, v2
subs	w5, w5, #2
st1.h	{ v2 }[0], [x0], x1
st1.h	{ v2 }[1], [x8], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v28
b	put_8tap_neon
ret	x15
ld1.8b	{ v28 }, [x9], x3
ld1.8b	{ v30 }, [x2], x3
ushll.8h	v28, v28, #0
ushll.8h	v30, v30, #0
ext.16b	v29, v28, v28, #2
ext.16b	v31, v30, v30, #2
trn1.2s	v27, v28, v30
trn2.2s	v30, v28, v30
trn1.2s	v28, v29, v31
trn2.2s	v31, v29, v31
mul.4h	v27, v27, v0[0]
mla.4h	v27, v28, v0[1]
mla.4h	v27, v30, v0[2]
mla.4h	v27, v31, v0[3]
srshr.4h	v28, v27, #2
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x9, x2, #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x2], x3
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v16, v31, #2
bl	put_8tap_neon
mov.8b	v17, v28
mov.8b	v18, v29
bl	put_8tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v28, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v28, v1[2]
smlal.4s	v3, v29, v1[3]
sqrshrn.4h	v2, v2, #10
sqrshrn.4h	v3, v3, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v3 }[0], [x8], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v28
mov.8b	v18, v29
b	put_8tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x2], x3
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v16, v31, #2
bl	put_8tap_neon
mov.8b	v17, v28
mov.8b	v18, v29
bl	put_8tap_neon
mov.8b	v19, v28
mov.8b	v20, v29
bl	put_8tap_neon
mov.8b	v21, v28
mov.8b	v22, v29
bl	put_8tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v19, v1[3]
smlal.4s	v2, v20, v1[4]
smlal.4s	v2, v21, v1[5]
smlal.4s	v2, v22, v1[6]
smlal.4s	v2, v28, v1[7]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v19, v1[2]
smlal.4s	v3, v20, v1[3]
smlal.4s	v3, v21, v1[4]
smlal.4s	v3, v22, v1[5]
smlal.4s	v3, v28, v1[6]
smlal.4s	v3, v29, v1[7]
sqrshrn.4h	v2, v2, #10
sqrshrn.4h	v3, v3, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v3 }[0], [x8], x1
b.le	put_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v28
mov.8b	v22, v29
b	put_8tap_neon
ret	x15
ld1.8b	{ v26 }, [x9], x3
ld1.8b	{ v27 }, [x2], x3
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
ext.16b	v28, v27, v27, #2
ext.16b	v29, v27, v27, #4
ext.16b	v30, v27, v27, #6
mul.4h	v27, v27, v0[0]
mla.4h	v27, v28, v0[1]
mla.4h	v27, v29, v0[2]
mla.4h	v27, v30, v0[3]
srshr.4h	v28, v31, #2
srshr.4h	v29, v27, #2
ret
b.gt	put_8tap_neon
add	x7, x7, #2
ld1.8b	{ v0 }, [x6]
ld1.s	{ v1 }[0], [x7]
sub	x2, x2, #3
sub	x2, x2, x3
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	put_8tap_neon
bl	put_8tap_neon
mov.16b	v17, v24
mov.16b	v18, v25
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
smlal.4s	v4, v24, v1[2]
smlal2.4s	v5, v24, v1[2]
smlal.4s	v2, v24, v1[3]
smlal2.4s	v3, v24, v1[3]
smlal.4s	v4, v25, v1[3]
smlal2.4s	v5, v25, v1[3]
sqrshrn.4h	v2, v2, #10
sqrshrn2.8h	v2, v3, #10
sqrshrn.4h	v4, v4, #10
sqrshrn2.8h	v4, v5, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v4, v4
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v24
mov.16b	v18, v25
b	put_8tap_neon
subs	w4, w4, #8
b.le	put_8tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
b	put_8tap_neon
ld1.8b	{ v0 }, [x6]
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #3
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	put_8tap_neon
bl	put_8tap_neon
mov.16b	v17, v24
mov.16b	v18, v25
bl	put_8tap_neon
mov.16b	v19, v24
mov.16b	v20, v25
bl	put_8tap_neon
mov.16b	v21, v24
mov.16b	v22, v25
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
smlal.4s	v4, v24, v1[6]
smlal2.4s	v5, v24, v1[6]
smlal.4s	v2, v24, v1[7]
smlal2.4s	v3, v24, v1[7]
smlal.4s	v4, v25, v1[7]
smlal2.4s	v5, v25, v1[7]
sqrshrn.4h	v2, v2, #10
sqrshrn2.8h	v2, v3, #10
sqrshrn.4h	v4, v4, #10
sqrshrn2.8h	v4, v5, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v4, v4
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v24
mov.16b	v22, v25
b	put_8tap_neon
subs	w4, w4, #8
b.le	put_8tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
b	put_8tap_neon
ret	x15
ld1.8b	{ v28, v29 }, [x2], x3
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
mul.8h	v16, v28, v0[0]
ext.16b	v24, v28, v29, #2
ext.16b	v25, v28, v29, #4
ext.16b	v26, v28, v29, #6
ext.16b	v27, v28, v29, #8
mla.8h	v16, v24, v0[1]
mla.8h	v16, v25, v0[2]
mla.8h	v16, v26, v0[3]
mla.8h	v16, v27, v0[4]
ext.16b	v24, v28, v29, #10
ext.16b	v25, v28, v29, #12
ext.16b	v26, v28, v29, #14
mla.8h	v16, v24, v0[5]
mla.8h	v16, v25, v0[6]
mla.8h	v16, v26, v0[7]
srshr.8h	v16, v16, #2
ret
ld1.8b	{ v28, v29 }, [x9], x3
ld1.8b	{ v30, v31 }, [x2], x3
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
ushll.8h	v30, v30, #0
ushll.8h	v31, v31, #0
mul.8h	v24, v28, v0[0]
mul.8h	v25, v30, v0[0]
ext.16b	v26, v28, v29, #2
ext.16b	v27, v30, v31, #2
mla.8h	v24, v26, v0[1]
mla.8h	v25, v27, v0[1]
ext.16b	v26, v28, v29, #4
ext.16b	v27, v30, v31, #4
mla.8h	v24, v26, v0[2]
mla.8h	v25, v27, v0[2]
ext.16b	v26, v28, v29, #6
ext.16b	v27, v30, v31, #6
mla.8h	v24, v26, v0[3]
mla.8h	v25, v27, v0[3]
ext.16b	v26, v28, v29, #8
ext.16b	v27, v30, v31, #8
mla.8h	v24, v26, v0[4]
mla.8h	v25, v27, v0[4]
ext.16b	v26, v28, v29, #10
ext.16b	v27, v30, v31, #10
mla.8h	v24, v26, v0[5]
mla.8h	v25, v27, v0[5]
ext.16b	v26, v28, v29, #12
ext.16b	v27, v30, v31, #12
mla.8h	v24, v26, v0[6]
mla.8h	v25, v27, v0[6]
ext.16b	v26, v28, v29, #14
ext.16b	v27, v30, v31, #14
mla.8h	v24, v26, v0[7]
mla.8h	v25, v27, v0[7]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
ret
<unknown>
<unknown>
eor	z20.s, z20.s, #0x3ffffff
udf	#1768
_put_8tap_regular_8bpc_neon:
mov	x8, #45
mov	x9, #45
b	put_6tap_neon
_put_8tap_regular_smooth_8bpc_neon:
mov	x8, #45
mov	x9, #1980
b	put_6tap_neon
_put_8tap_smooth_8bpc_neon:
mov	x8, #1980
mov	x9, #1980
b	put_6tap_neon
_put_8tap_smooth_regular_8bpc_neon:
mov	x8, #1980
mov	x9, #45
b	put_6tap_neon
_put_6tap_neon:
mov	w10, #16513
mul	w6, w6, w10
mul	w7, w7, w10
add	w6, w6, w8
add	w7, w7, w9
clz	w8, w4
tst	w6, #0x1fc000
sub	w8, w8, #24
adrp	x10, put_6tap_neon
add	x10, x10, #0
sub	x10, x10, #8
b.ne	put_6tap_neon
tst	w7, #0x1fc000
b.ne	put_6tap_neon
b	put_neon
cmp	w4, #4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	put_6tap_neon
mov	w6, w9
tst	w7, #0x1fc000
add	x6, x10, w6, uxtw #3
b.ne	put_6tap_neon
adr	x9, #836
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v4 }, [x2], x3
ld1.8b	{ v6 }, [x9], x3
ushll.8h	v4, v4, #0
ushll.8h	v6, v6, #0
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
subs	w5, w5, #2
trn1.2s	v3, v4, v6
trn2.2s	v6, v4, v6
trn1.2s	v4, v5, v7
trn2.2s	v7, v5, v7
mul.4h	v3, v3, v0[0]
mla.4h	v3, v4, v0[1]
mla.4h	v3, v6, v0[2]
mla.4h	v3, v7, v0[3]
srshr.4h	v3, v3, #2
sqrshrun.8b	v3, v3, #4
st1.h	{ v3 }[0], [x0], x1
st1.h	{ v3 }[1], [x8], x1
b.gt	put_6tap_neon
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x2, x2, #1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16 }, [x2], x3
ld1.8b	{ v20 }, [x9], x3
ushll.8h	v16, v16, #0
ushll.8h	v20, v20, #0
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w5, w5, #2
mul.4h	v16, v16, v0[0]
mla.4h	v16, v17, v0[1]
mla.4h	v16, v18, v0[2]
mla.4h	v16, v19, v0[3]
mul.4h	v20, v20, v0[0]
mla.4h	v20, v21, v0[1]
mla.4h	v20, v22, v0[2]
mla.4h	v20, v23, v0[3]
srshr.4h	v16, v16, #2
srshr.4h	v20, v20, #2
sqrshrun.8b	v16, v16, #4
sqrshrun.8b	v20, v20, #4
st1.s	{ v16 }[0], [x0], x1
st1.s	{ v20 }[0], [x8], x1
b.gt	put_6tap_neon
ret
ld1.8b	{ v0 }, [x6]
sub	x2, x2, #3
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16, v17 }, [x2], x3
ld1.8b	{ v20, v21 }, [x9], x3
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ext.16b	v19, v16, v17, #2
ext.16b	v23, v20, v21, #2
mul.8h	v18, v19, v0[1]
mul.8h	v22, v23, v0[1]
ext.16b	v19, v16, v17, #4
ext.16b	v23, v20, v21, #4
mla.8h	v18, v19, v0[2]
mla.8h	v22, v23, v0[2]
ext.16b	v19, v16, v17, #6
ext.16b	v23, v20, v21, #6
mla.8h	v18, v19, v0[3]
mla.8h	v22, v23, v0[3]
ext.16b	v19, v16, v17, #8
ext.16b	v23, v20, v21, #8
mla.8h	v18, v19, v0[4]
mla.8h	v22, v23, v0[4]
ext.16b	v19, v16, v17, #10
ext.16b	v23, v20, v21, #10
mla.8h	v18, v19, v0[5]
mla.8h	v22, v23, v0[5]
ext.16b	v19, v16, v17, #12
ext.16b	v23, v20, v21, #12
mla.8h	v18, v19, v0[6]
mla.8h	v22, v23, v0[6]
subs	w5, w5, #2
srshr.8h	v18, v18, #2
srshr.8h	v22, v22, #2
sqrshrun.8b	v18, v18, #4
sqrshrun.8b	v22, v22, #4
st1.8b	{ v18 }, [x0], x1
st1.8b	{ v22 }, [x8], x1
b.gt	put_6tap_neon
ret
ld1.8b	{ v0 }, [x6]
sub	x2, x2, #3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
sub	x3, x3, w4, uxtw
sub	x3, x3, #8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
ld1.8b	{ v16, v17, v18 }, [x2], #24
ld1.8b	{ v20, v21, v22 }, [x9], #24
mov	w6, w4
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
ext.16b	v28, v16, v17, #2
ext.16b	v29, v17, v18, #2
ext.16b	v30, v20, v21, #2
ext.16b	v31, v21, v22, #2
mul.8h	v24, v28, v0[1]
mul.8h	v25, v29, v0[1]
mul.8h	v26, v30, v0[1]
mul.8h	v27, v31, v0[1]
ext.16b	v28, v16, v17, #4
ext.16b	v29, v17, v18, #4
ext.16b	v30, v20, v21, #4
ext.16b	v31, v21, v22, #4
mla.8h	v24, v28, v0[2]
mla.8h	v25, v29, v0[2]
mla.8h	v26, v30, v0[2]
mla.8h	v27, v31, v0[2]
ext.16b	v28, v16, v17, #6
ext.16b	v29, v17, v18, #6
ext.16b	v30, v20, v21, #6
ext.16b	v31, v21, v22, #6
mla.8h	v24, v28, v0[3]
mla.8h	v25, v29, v0[3]
mla.8h	v26, v30, v0[3]
mla.8h	v27, v31, v0[3]
ext.16b	v28, v16, v17, #8
ext.16b	v29, v17, v18, #8
ext.16b	v30, v20, v21, #8
ext.16b	v31, v21, v22, #8
mla.8h	v24, v28, v0[4]
mla.8h	v25, v29, v0[4]
mla.8h	v26, v30, v0[4]
mla.8h	v27, v31, v0[4]
ext.16b	v28, v16, v17, #10
ext.16b	v29, v17, v18, #10
ext.16b	v30, v20, v21, #10
ext.16b	v31, v21, v22, #10
mla.8h	v24, v28, v0[5]
mla.8h	v25, v29, v0[5]
mla.8h	v26, v30, v0[5]
mla.8h	v27, v31, v0[5]
ext.16b	v28, v16, v17, #12
ext.16b	v29, v17, v18, #12
ext.16b	v30, v20, v21, #12
ext.16b	v31, v21, v22, #12
mla.8h	v24, v28, v0[6]
mla.8h	v25, v29, v0[6]
mla.8h	v26, v30, v0[6]
mla.8h	v27, v31, v0[6]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
srshr.8h	v26, v26, #2
srshr.8h	v27, v27, #2
subs	w6, w6, #16
sqrshrun.8b	v24, v24, #4
sqrshrun2.16b	v24, v25, #4
sqrshrun.8b	v26, v26, #4
sqrshrun2.16b	v26, v27, #4
st1.16b	{ v24 }, [x0], #16
st1.16b	{ v26 }, [x8], #16
b.le	put_6tap_neon
mov.16b	v16, v18
mov.16b	v20, v22
ld1.8b	{ v17, v18 }, [x2], #16
ld1.8b	{ v21, v22 }, [x9], #16
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
b	put_6tap_neon
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #2
b.gt	put_6tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#820
cmp	w5, #4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_6tap_neon
mov	w7, w9
add	x7, x10, w7, uxtw #3
adr	x9, #2420
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
b.gt	put_6tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.h	{ v1 }[0], [x2], x3
ld1.h	{ v2 }[0], [x9], x3
ld1.h	{ v3 }[0], [x2], x3
ld1.h	{ v4 }[0], [x9], x3
ld1.h	{ v5 }[0], [x2], x3
trn1.4h	v1, v1, v2
trn1.4h	v2, v2, v3
trn1.4h	v3, v3, v4
trn1.4h	v4, v4, v5
b.gt	put_6tap_neon
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.4h	v6, v1, v0[0]
mla.4h	v6, v2, v0[1]
mla.4h	v6, v3, v0[2]
mla.4h	v6, v4, v0[3]
sqrshrun.8b	v6, v6, #6
st1.h	{ v6 }[0], [x0], x1
st1.h	{ v6 }[1], [x8], x1
ret
ld1.h	{ v6 }[0], [x9], x3
ld1.h	{ v7 }[0], [x2], x3
trn1.4h	v5, v5, v6
trn1.4h	v6, v6, v7
trn1.2s	v1, v1, v3
trn1.2s	v2, v2, v4
trn1.2s	v3, v3, v5
trn1.2s	v4, v4, v6
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
sqrshrun.8b	v6, v6, #6
st1.h	{ v6 }[0], [x0], x1
st1.h	{ v6 }[1], [x8], x1
st1.h	{ v6 }[2], [x0], x1
st1.h	{ v6 }[3], [x8], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll.8h	v0, v0, #0
ld1.h	{ v1 }[0], [x2], x3
ld1.h	{ v2 }[0], [x9], x3
ld1.h	{ v3 }[0], [x2], x3
ld1.h	{ v4 }[0], [x9], x3
ld1.h	{ v5 }[0], [x2], x3
ld1.h	{ v6 }[0], [x9], x3
ld1.h	{ v7 }[0], [x2], x3
trn1.4h	v1, v1, v2
trn1.4h	v2, v2, v3
trn1.4h	v3, v3, v4
trn1.4h	v4, v4, v5
trn1.4h	v5, v5, v6
trn1.4h	v6, v6, v7
trn1.2s	v1, v1, v3
trn1.2s	v2, v2, v4
trn1.2s	v3, v3, v5
trn1.2s	v4, v4, v6
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
subs	w5, w5, #4
ld1.h	{ v16 }[0], [x9], x3
ld1.h	{ v17 }[0], [x2], x3
ld1.h	{ v18 }[0], [x9], x3
ld1.h	{ v19 }[0], [x2], x3
trn1.4h	v7, v7, v16
trn1.4h	v16, v16, v17
trn1.4h	v17, v17, v18
trn1.4h	v18, v18, v19
trn1.2s	v5, v5, v7
trn1.2s	v6, v6, v16
trn1.2s	v7, v7, v17
trn1.2s	v16, v16, v18
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
ushll.8h	v16, v16, #0
mul.8h	v30, v2, v0[1]
mla.8h	v30, v3, v0[2]
mla.8h	v30, v4, v0[3]
mla.8h	v30, v5, v0[4]
mla.8h	v30, v6, v0[5]
mla.8h	v30, v7, v0[6]
sqrshrun.8b	v30, v30, #6
st1.h	{ v30 }[0], [x0], x1
st1.h	{ v30 }[1], [x8], x1
st1.h	{ v30 }[2], [x0], x1
st1.h	{ v30 }[3], [x8], x1
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
ld1.h	{ v16 }[0], [x9], x3
ld1.h	{ v17 }[0], [x2], x3
trn1.4h	v7, v7, v16
trn1.4h	v16, v16, v17
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
ushll.8h	v16, v16, #0
mul.4h	v30, v2, v0[1]
mla.4h	v30, v3, v0[2]
mla.4h	v30, v4, v0[3]
mla.4h	v30, v5, v0[4]
mla.4h	v30, v6, v0[5]
mla.4h	v30, v7, v0[6]
sqrshrun.8b	v30, v30, #6
st1.h	{ v30 }[0], [x0], x1
st1.h	{ v30 }[1], [x8], x1
ret
b.gt	put_6tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x3
ld1.s	{ v2 }[0], [x9], x3
ld1.s	{ v3 }[0], [x2], x3
ld1.s	{ v4 }[0], [x9], x3
ld1.s	{ v5 }[0], [x2], x3
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
sqrshrun.8b	v6, v6, #6
st1.s	{ v6 }[0], [x0], x1
st1.s	{ v6 }[1], [x8], x1
b.le	put_6tap_neon
ld1.s	{ v6 }[0], [x9], x3
ld1.s	{ v7 }[0], [x2], x3
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
mul.8h	v7, v3, v0[0]
mla.8h	v7, v4, v0[1]
mla.8h	v7, v5, v0[2]
mla.8h	v7, v6, v0[3]
sqrshrun.8b	v7, v7, #6
st1.s	{ v7 }[0], [x0], x1
st1.s	{ v7 }[1], [x8], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.s	{ v16 }[0], [x2], x3
ld1.s	{ v17 }[0], [x9], x3
ld1.s	{ v18 }[0], [x2], x3
ld1.s	{ v19 }[0], [x9], x3
ld1.s	{ v20 }[0], [x2], x3
ld1.s	{ v21 }[0], [x9], x3
ld1.s	{ v22 }[0], [x2], x3
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
subs	w5, w5, #4
ld1.s	{ v23 }[0], [x9], x3
ld1.s	{ v24 }[0], [x2], x3
ld1.s	{ v25 }[0], [x9], x3
ld1.s	{ v26 }[0], [x2], x3
trn1.2s	v22, v22, v23
trn1.2s	v23, v23, v24
trn1.2s	v24, v24, v25
trn1.2s	v25, v25, v26
ushll.8h	v22, v22, #0
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
ushll.8h	v25, v25, #0
mul.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mul.8h	v2, v19, v0[1]
mla.8h	v2, v20, v0[2]
mla.8h	v2, v21, v0[3]
mla.8h	v2, v22, v0[4]
mla.8h	v2, v23, v0[5]
mla.8h	v2, v24, v0[6]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x8], x1
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x8], x1
b.le	put_6tap_neon
ld1.s	{ v27 }[0], [x9], x3
ld1.s	{ v16 }[0], [x2], x3
subs	w5, w5, #2
trn1.2s	v26, v26, v27
trn1.2s	v27, v27, v16
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
mul.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
sqrshrun.8b	v1, v1, #6
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x8], x1
b.le	put_6tap_neon
ld1.s	{ v17 }[0], [x9], x3
ld1.s	{ v18 }[0], [x2], x3
subs	w5, w5, #2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
mul.8h	v2, v23, v0[1]
mla.8h	v2, v24, v0[2]
mla.8h	v2, v25, v0[3]
mla.8h	v2, v26, v0[4]
mla.8h	v2, v27, v0[5]
mla.8h	v2, v16, v0[6]
sqrshrun.8b	v2, v2, #6
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x8], x1
b.le	put_6tap_neon
subs	w5, w5, #4
ld1.s	{ v19 }[0], [x9], x3
ld1.s	{ v20 }[0], [x2], x3
ld1.s	{ v21 }[0], [x9], x3
ld1.s	{ v22 }[0], [x2], x3
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
mul.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mul.8h	v2, v27, v0[1]
mla.8h	v2, v16, v0[2]
mla.8h	v2, v17, v0[3]
mla.8h	v2, v18, v0[4]
mla.8h	v2, v19, v0[5]
mla.8h	v2, v20, v0[6]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x8], x1
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x8], x1
b.gt	put_6tap_neon
ret
b.gt	put_6tap_neon
cmp	w5, #2
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v1 }, [x2], x3
ld1.8b	{ v2 }, [x9], x3
ld1.8b	{ v3 }, [x2], x3
ld1.8b	{ v4 }, [x9], x3
ld1.8b	{ v5 }, [x2], x3
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
ushll.8h	v5, v5, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
mul.8h	v7, v2, v0[0]
mla.8h	v7, v3, v0[1]
mla.8h	v7, v4, v0[2]
mla.8h	v7, v5, v0[3]
sqrshrun.8b	v6, v6, #6
sqrshrun.8b	v7, v7, #6
st1.8b	{ v6 }, [x0], x1
st1.8b	{ v7 }, [x8], x1
b.le	put_6tap_neon
ld1.8b	{ v6 }, [x9], x3
ld1.8b	{ v7 }, [x2], x3
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
mul.8h	v1, v3, v0[0]
mla.8h	v1, v4, v0[1]
mla.8h	v1, v5, v0[2]
mla.8h	v1, v6, v0[3]
mul.8h	v2, v4, v0[0]
mla.8h	v2, v5, v0[1]
mla.8h	v2, v6, v0[2]
mla.8h	v2, v7, v0[3]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
ret
ld1.8b	{ v0 }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8b	{ v16 }, [x2], x3
ld1.8b	{ v17 }, [x9], x3
ld1.8b	{ v18 }, [x2], x3
ld1.8b	{ v19 }, [x9], x3
ld1.8b	{ v20 }, [x2], x3
ld1.8b	{ v21 }, [x9], x3
ld1.8b	{ v22 }, [x2], x3
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
subs	w5, w5, #2
ld1.8b	{ v23 }, [x9], x3
ld1.8b	{ v24 }, [x2], x3
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
mul.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mul.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
mla.8h	v2, v20, v0[3]
mla.8h	v2, v21, v0[4]
mla.8h	v2, v22, v0[5]
mla.8h	v2, v23, v0[6]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
b.le	put_6tap_neon
subs	w5, w5, #2
ld1.8b	{ v25 }, [x9], x3
ld1.8b	{ v26 }, [x2], x3
ushll.8h	v25, v25, #0
ushll.8h	v26, v26, #0
mul.8h	v3, v19, v0[1]
mla.8h	v3, v20, v0[2]
mla.8h	v3, v21, v0[3]
mla.8h	v3, v22, v0[4]
mla.8h	v3, v23, v0[5]
mla.8h	v3, v24, v0[6]
mul.8h	v4, v20, v0[1]
mla.8h	v4, v21, v0[2]
mla.8h	v4, v22, v0[3]
mla.8h	v4, v23, v0[4]
mla.8h	v4, v24, v0[5]
mla.8h	v4, v25, v0[6]
sqrshrun.8b	v3, v3, #6
sqrshrun.8b	v4, v4, #6
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_6tap_neon
subs	w5, w5, #2
ld1.8b	{ v27 }, [x9], x3
ld1.8b	{ v16 }, [x2], x3
ushll.8h	v27, v27, #0
ushll.8h	v16, v16, #0
mul.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
mul.8h	v2, v22, v0[1]
mla.8h	v2, v23, v0[2]
mla.8h	v2, v24, v0[3]
mla.8h	v2, v25, v0[4]
mla.8h	v2, v26, v0[5]
mla.8h	v2, v27, v0[6]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
b.le	put_6tap_neon
subs	w5, w5, #2
ld1.8b	{ v17 }, [x9], x3
ld1.8b	{ v18 }, [x2], x3
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
mul.8h	v3, v23, v0[1]
mla.8h	v3, v24, v0[2]
mla.8h	v3, v25, v0[3]
mla.8h	v3, v26, v0[4]
mla.8h	v3, v27, v0[5]
mla.8h	v3, v16, v0[6]
mul.8h	v4, v24, v0[1]
mla.8h	v4, v25, v0[2]
mla.8h	v4, v26, v0[3]
mla.8h	v4, v27, v0[4]
mla.8h	v4, v16, v0[5]
mla.8h	v4, v17, v0[6]
sqrshrun.8b	v3, v3, #6
sqrshrun.8b	v4, v4, #6
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_6tap_neon
subs	w5, w5, #4
ld1.8b	{ v19 }, [x9], x3
ld1.8b	{ v20 }, [x2], x3
ld1.8b	{ v21 }, [x9], x3
ld1.8b	{ v22 }, [x2], x3
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
mul.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mul.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v16, v0[3]
mla.8h	v2, v17, v0[4]
mla.8h	v2, v18, v0[5]
mla.8h	v2, v19, v0[6]
mul.8h	v3, v27, v0[1]
mla.8h	v3, v16, v0[2]
mla.8h	v3, v17, v0[3]
mla.8h	v3, v18, v0[4]
mla.8h	v3, v19, v0[5]
mla.8h	v3, v20, v0[6]
mul.8h	v4, v16, v0[1]
mla.8h	v4, v17, v0[2]
mla.8h	v4, v18, v0[3]
mla.8h	v4, v19, v0[4]
mla.8h	v4, v20, v0[5]
mla.8h	v4, v21, v0[6]
sqrshrun.8b	v1, v1, #6
sqrshrun.8b	v2, v2, #6
sqrshrun.8b	v3, v3, #6
sqrshrun.8b	v4, v4, #6
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v2 }, [x8], x1
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.gt	put_6tap_neon
subs	w4, w4, #8
b.le	put_6tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
b	put_6tap_neon
ret
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.s	{ v0 }[0], [x7]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
cmp	w5, #2
ld1.16b	{ v1 }, [x2], x3
ld1.16b	{ v2 }, [x9], x3
ld1.16b	{ v3 }, [x2], x3
ld1.16b	{ v4 }, [x9], x3
ld1.16b	{ v5 }, [x2], x3
ushll.8h	v16, v1, #0
ushll.8h	v17, v2, #0
ushll.8h	v18, v3, #0
ushll.8h	v19, v4, #0
ushll.8h	v20, v5, #0
ushll2.8h	v23, v1, #0
ushll2.8h	v24, v2, #0
ushll2.8h	v25, v3, #0
ushll2.8h	v26, v4, #0
ushll2.8h	v27, v5, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mul.8h	v16, v17, v0[0]
mla.8h	v16, v18, v0[1]
mla.8h	v16, v19, v0[2]
mla.8h	v16, v20, v0[3]
mul.8h	v2, v23, v0[0]
mla.8h	v2, v24, v0[1]
mla.8h	v2, v25, v0[2]
mla.8h	v2, v26, v0[3]
mul.8h	v17, v24, v0[0]
mla.8h	v17, v25, v0[1]
mla.8h	v17, v26, v0[2]
mla.8h	v17, v27, v0[3]
sqrshrun.8b	v1, v1, #6
sqrshrun2.16b	v1, v2, #6
sqrshrun.8b	v16, v16, #6
sqrshrun2.16b	v16, v17, #6
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v16 }, [x8], x1
b.le	put_6tap_neon
ld1.16b	{ v6 }, [x9], x3
ld1.16b	{ v7 }, [x2], x3
ushll.8h	v21, v6, #0
ushll.8h	v22, v7, #0
ushll2.8h	v28, v6, #0
ushll2.8h	v29, v7, #0
mul.8h	v1, v18, v0[0]
mla.8h	v1, v19, v0[1]
mla.8h	v1, v20, v0[2]
mla.8h	v1, v21, v0[3]
mul.8h	v3, v19, v0[0]
mla.8h	v3, v20, v0[1]
mla.8h	v3, v21, v0[2]
mla.8h	v3, v22, v0[3]
mul.8h	v2, v25, v0[0]
mla.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v28, v0[3]
mul.8h	v4, v26, v0[0]
mla.8h	v4, v27, v0[1]
mla.8h	v4, v28, v0[2]
mla.8h	v4, v29, v0[3]
sqrshrun.8b	v1, v1, #6
sqrshrun2.16b	v1, v2, #6
sqrshrun.8b	v3, v3, #6
sqrshrun2.16b	v3, v4, #6
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v3 }, [x8], x1
ret
<unknown>
<unknown>
<unknown>
udf	#2404
cmp	w5, #4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	put_6tap_neon
mov	w7, w9
add	x7, x10, w7, uxtw #3
adr	x9, #1660
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x9, x2, #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v28 }, [x2], x3
ushll.8h	v28, v28, #0
ext.16b	v29, v28, v28, #2
mul.4h	v28, v28, v0
mul.4h	v29, v29, v0
addp.4h	v28, v28, v29
addp.4h	v16, v28, v28
srshr.4h	v16, v16, #2
bl	put_6tap_neon
trn1.2s	v16, v16, v28
mov.8b	v17, v28
bl	put_6tap_neon
ext.8b	v18, v17, v28, #4
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v28, v1[3]
sqrshrn.4h	v2, v2, #10
sqxtun.8b	v2, v2
subs	w5, w5, #2
st1.h	{ v2 }[0], [x0], x1
st1.h	{ v2 }[1], [x8], x1
b.le	put_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v28
b	put_6tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v28 }, [x2], x3
ushll.8h	v28, v28, #0
ext.16b	v29, v28, v28, #2
mul.4h	v28, v28, v0
mul.4h	v29, v29, v0
addp.4h	v28, v28, v29
addp.4h	v16, v28, v28
srshr.4h	v16, v16, #2
bl	put_6tap_neon
trn1.2s	v16, v16, v28
mov.8b	v17, v28
bl	put_6tap_neon
ext.8b	v18, v17, v28, #4
mov.8b	v19, v28
bl	put_6tap_neon
ext.8b	v20, v19, v28, #4
mov.8b	v21, v28
bl	put_6tap_neon
ext.8b	v22, v21, v28, #4
smull.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v19, v1[3]
smlal.4s	v2, v20, v1[4]
smlal.4s	v2, v21, v1[5]
smlal.4s	v2, v22, v1[6]
sqrshrn.4h	v2, v2, #10
sqxtun.8b	v2, v2
subs	w5, w5, #2
st1.h	{ v2 }[0], [x0], x1
st1.h	{ v2 }[1], [x8], x1
b.le	put_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v28
b	put_6tap_neon
ret	x15
ld1.8b	{ v28 }, [x9], x3
ld1.8b	{ v30 }, [x2], x3
ushll.8h	v28, v28, #0
ushll.8h	v30, v30, #0
ext.16b	v29, v28, v28, #2
ext.16b	v31, v30, v30, #2
trn1.2s	v27, v28, v30
trn2.2s	v30, v28, v30
trn1.2s	v28, v29, v31
trn2.2s	v31, v29, v31
mul.4h	v27, v27, v0[0]
mla.4h	v27, v28, v0[1]
mla.4h	v27, v30, v0[2]
mla.4h	v27, v31, v0[3]
srshr.4h	v28, v27, #2
ret
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.s	{ v1 }[0], [x7]
sub	x9, x2, #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x2], x3
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v16, v31, #2
bl	put_6tap_neon
mov.8b	v17, v28
mov.8b	v18, v29
bl	put_6tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v28, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v28, v1[2]
smlal.4s	v3, v29, v1[3]
sqrshrn.4h	v2, v2, #10
sqrshrn.4h	v3, v3, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v3 }[0], [x8], x1
b.le	put_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v28
mov.8b	v18, v29
b	put_6tap_neon
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #1
sub	x9, x2, x3
sub	x2, x2, x3, lsl #1
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x2], x3
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v18, v31, #2
bl	put_6tap_neon
mov.8b	v19, v28
mov.8b	v20, v29
bl	put_6tap_neon
mov.8b	v21, v28
mov.8b	v22, v29
bl	put_6tap_neon
smull.4s	v2, v18, v1[1]
smlal.4s	v2, v19, v1[2]
smlal.4s	v2, v20, v1[3]
smlal.4s	v2, v21, v1[4]
smlal.4s	v2, v22, v1[5]
smlal.4s	v2, v28, v1[6]
smull.4s	v3, v19, v1[1]
smlal.4s	v3, v20, v1[2]
smlal.4s	v3, v21, v1[3]
smlal.4s	v3, v22, v1[4]
smlal.4s	v3, v28, v1[5]
smlal.4s	v3, v29, v1[6]
sqrshrn.4h	v2, v2, #10
sqrshrn.4h	v3, v3, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v3 }[0], [x8], x1
b.le	put_6tap_neon
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v28
mov.8b	v22, v29
b	put_6tap_neon
ret	x15
ld1.8b	{ v26 }, [x9], x3
ld1.8b	{ v27 }, [x2], x3
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
ext.16b	v28, v27, v27, #2
ext.16b	v29, v27, v27, #4
ext.16b	v30, v27, v27, #6
mul.4h	v27, v27, v0[0]
mla.4h	v27, v28, v0[1]
mla.4h	v27, v29, v0[2]
mla.4h	v27, v30, v0[3]
srshr.4h	v28, v31, #2
srshr.4h	v29, v27, #2
ret
b.gt	put_6tap_neon
add	x7, x7, #2
ld1.8b	{ v0 }, [x6]
ld1.s	{ v1 }[0], [x7]
sub	x2, x2, #3
sub	x2, x2, x3
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	put_6tap_neon
bl	put_6tap_neon
mov.16b	v17, v24
mov.16b	v18, v25
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
smlal.4s	v4, v24, v1[2]
smlal2.4s	v5, v24, v1[2]
smlal.4s	v2, v24, v1[3]
smlal2.4s	v3, v24, v1[3]
smlal.4s	v4, v25, v1[3]
smlal2.4s	v5, v25, v1[3]
sqrshrn.4h	v2, v2, #10
sqrshrn2.8h	v2, v3, #10
sqrshrn.4h	v4, v4, #10
sqrshrn2.8h	v4, v5, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v4, v4
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_6tap_neon
mov.16b	v16, v18
mov.16b	v17, v24
mov.16b	v18, v25
b	put_6tap_neon
subs	w4, w4, #8
b.le	put_6tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
b	put_6tap_neon
ld1.8b	{ v0 }, [x6]
ld1.8b	{ v1 }, [x7]
sub	x2, x2, #3
sub	x2, x2, x3, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	put_6tap_neon
mov.16b	v18, v16
bl	put_6tap_neon
mov.16b	v19, v24
mov.16b	v20, v25
bl	put_6tap_neon
mov.16b	v21, v24
mov.16b	v22, v25
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
smlal.4s	v4, v24, v1[5]
smlal2.4s	v5, v24, v1[5]
smlal.4s	v2, v24, v1[6]
smlal2.4s	v3, v24, v1[6]
smlal.4s	v4, v25, v1[6]
smlal2.4s	v5, v25, v1[6]
sqrshrn.4h	v2, v2, #10
sqrshrn2.8h	v2, v3, #10
sqrshrn.4h	v4, v4, #10
sqrshrn2.8h	v4, v5, #10
subs	w5, w5, #2
sqxtun.8b	v2, v2
sqxtun.8b	v4, v4
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v4 }, [x8], x1
b.le	put_6tap_neon
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v24
mov.16b	v22, v25
b	put_6tap_neon
subs	w4, w4, #8
b.le	put_6tap_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
add	x2, x2, x3, lsl #1
b	put_6tap_neon
ret	x15
ld1.8b	{ v28, v29 }, [x2], x3
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
ext.16b	v24, v28, v29, #2
ext.16b	v25, v28, v29, #4
ext.16b	v26, v28, v29, #6
ext.16b	v27, v28, v29, #8
mul.8h	v16, v24, v0[1]
mla.8h	v16, v25, v0[2]
mla.8h	v16, v26, v0[3]
mla.8h	v16, v27, v0[4]
ext.16b	v24, v28, v29, #10
ext.16b	v25, v28, v29, #12
ext.16b	v26, v28, v29, #14
mla.8h	v16, v24, v0[5]
mla.8h	v16, v25, v0[6]
srshr.8h	v16, v16, #2
ret
ld1.8b	{ v28, v29 }, [x9], x3
ld1.8b	{ v30, v31 }, [x2], x3
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
ushll.8h	v30, v30, #0
ushll.8h	v31, v31, #0
ext.16b	v26, v28, v29, #2
ext.16b	v27, v30, v31, #2
mul.8h	v24, v26, v0[1]
mul.8h	v25, v27, v0[1]
ext.16b	v26, v28, v29, #4
ext.16b	v27, v30, v31, #4
mla.8h	v24, v26, v0[2]
mla.8h	v25, v27, v0[2]
ext.16b	v26, v28, v29, #6
ext.16b	v27, v30, v31, #6
mla.8h	v24, v26, v0[3]
mla.8h	v25, v27, v0[3]
ext.16b	v26, v28, v29, #8
ext.16b	v27, v30, v31, #8
mla.8h	v24, v26, v0[4]
mla.8h	v25, v27, v0[4]
ext.16b	v26, v28, v29, #10
ext.16b	v27, v30, v31, #10
mla.8h	v24, v26, v0[5]
mla.8h	v25, v27, v0[5]
ext.16b	v26, v28, v29, #12
ext.16b	v27, v30, v31, #12
mla.8h	v24, v26, v0[6]
mla.8h	v25, v27, v0[6]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
ret
<unknown>
<unknown>
sabd	z4.d, p0/m, z4.d, z23.d
udf	#1644
_put_bilin_8bpc_neon:
dup.16b	v1, w6
dup.16b	v3, w7
mov	w9, #16
sub	w8, w9, w6
sub	w9, w9, w7
dup.16b	v0, w8
dup.16b	v2, w9
clz	w8, w4
sub	w8, w8, #24
cbnz	w6, put_bilin_8bpc_neon
cbnz	w7, put_bilin_8bpc_neon
b	put_neon
cbnz	w7, put_bilin_8bpc_neon
adr	x9, #404
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.s	{ v4 }[0], [x2], x3
ld1.s	{ v6 }[0], [x9], x3
ext.8b	v5, v4, v4, #1
ext.8b	v7, v6, v6, #1
trn1.4h	v4, v4, v6
trn1.4h	v5, v5, v7
subs	w5, w5, #2
umull.8h	v4, v4, v0
umlal.8h	v4, v5, v1
uqrshrn.8b	v4, v4, #4
st1.h	{ v4 }[0], [x0], x1
st1.h	{ v4 }[1], [x8], x1
b.gt	put_bilin_8bpc_neon
ret
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.8b	{ v4 }, [x2], x3
ld1.8b	{ v6 }, [x9], x3
ext.8b	v5, v4, v4, #1
ext.8b	v7, v6, v6, #1
trn1.2s	v4, v4, v6
trn1.2s	v5, v5, v7
subs	w5, w5, #2
umull.8h	v4, v4, v0
umlal.8h	v4, v5, v1
uqrshrn.8b	v4, v4, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x8], x1
b.gt	put_bilin_8bpc_neon
ret
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1.16b	{ v4 }, [x2], x3
ld1.16b	{ v6 }, [x9], x3
ext.16b	v5, v4, v4, #1
ext.16b	v7, v6, v6, #1
subs	w5, w5, #2
umull.8h	v4, v4, v0
umull.8h	v6, v6, v0
umlal.8h	v4, v5, v1
umlal.8h	v6, v7, v1
uqrshrn.8b	v4, v4, #4
uqrshrn.8b	v6, v6, #4
st1.8b	{ v4 }, [x0], x1
st1.8b	{ v6 }, [x8], x1
b.gt	put_bilin_8bpc_neon
ret
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sub	x3, x3, w4, uxtw
sub	x3, x3, #8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
ld1.d	{ v16 }[1], [x2], #8
ld1.d	{ v20 }[1], [x9], #8
mov	w6, w4
ld1.16b	{ v18 }, [x2], #16
ld1.16b	{ v22 }, [x9], #16
ext.16b	v17, v16, v18, #8
ext.16b	v19, v16, v18, #9
ext.16b	v21, v20, v22, #8
ext.16b	v23, v20, v22, #9
umull.8h	v16, v17, v0
umull2.8h	v17, v17, v0
umull.8h	v20, v21, v0
umull2.8h	v21, v21, v0
umlal.8h	v16, v19, v1
umlal2.8h	v17, v19, v1
umlal.8h	v20, v23, v1
umlal2.8h	v21, v23, v1
subs	w6, w6, #16
uqrshrn.8b	v16, v16, #4
uqrshrn2.16b	v16, v17, #4
uqrshrn.8b	v20, v20, #4
uqrshrn2.16b	v20, v21, #4
st1.16b	{ v16 }, [x0], #16
st1.16b	{ v20 }, [x8], #16
b.le	put_bilin_8bpc_neon
mov.16b	v16, v18
mov.16b	v20, v22
b	put_bilin_8bpc_neon
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #2
b.gt	put_bilin_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#388
cmp	w5, #4
adr	x9, #488
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
cmp	w5, #2
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.h	{ v16 }[0], [x2], x3
b.gt	put_bilin_8bpc_neon
ld1.h	{ v17 }[0], [x9], x3
ld1.h	{ v18 }[0], [x2], x3
trn1.4h	v16, v16, v17
trn1.4h	v17, v17, v18
umull.8h	v4, v16, v2
umlal.8h	v4, v17, v3
uqrshrn.8b	v4, v4, #4
st1.h	{ v4 }[0], [x0]
st1.h	{ v4 }[1], [x8]
ret
ld1.h	{ v17 }[0], [x9], x3
ld1.h	{ v18 }[0], [x2], x3
ld1.h	{ v19 }[0], [x9], x3
ld1.h	{ v20 }[0], [x2], x3
sub	w5, w5, #4
trn1.4h	v16, v16, v17
trn1.4h	v17, v17, v18
trn1.4h	v18, v18, v19
trn1.4h	v19, v19, v20
trn1.2s	v16, v16, v18
trn1.2s	v17, v17, v19
umull.8h	v4, v16, v2
umlal.8h	v4, v17, v3
cmp	w5, #2
uqrshrn.8b	v4, v4, #4
st1.h	{ v4 }[0], [x0], x1
st1.h	{ v4 }[1], [x8], x1
st1.h	{ v4 }[2], [x0], x1
st1.h	{ v4 }[3], [x8], x1
b.lt	put_bilin_8bpc_neon
mov.8b	v16, v20
b.eq	put_bilin_8bpc_neon
b	put_bilin_8bpc_neon
ret
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.s	{ v16 }[0], [x2], x3
ld1.s	{ v17 }[0], [x9], x3
ld1.s	{ v18 }[0], [x2], x3
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
umull.8h	v4, v16, v2
umlal.8h	v4, v17, v3
subs	w5, w5, #2
uqrshrn.8b	v4, v4, #4
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x8], x1
b.le	put_bilin_8bpc_neon
mov.8b	v16, v18
b	put_bilin_8bpc_neon
ret
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8b	{ v16 }, [x2], x3
ld1.8b	{ v17 }, [x9], x3
ld1.8b	{ v18 }, [x2], x3
umull.8h	v4, v16, v2
umull.8h	v5, v17, v2
umlal.8h	v4, v17, v3
umlal.8h	v5, v18, v3
subs	w5, w5, #2
uqrshrn.8b	v4, v4, #4
uqrshrn.8b	v5, v5, #4
st1.8b	{ v4 }, [x0], x1
st1.8b	{ v5 }, [x8], x1
b.le	put_bilin_8bpc_neon
mov.8b	v16, v18
b	put_bilin_8bpc_neon
ret
mov	w7, w5
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.16b	{ v16 }, [x2], x3
ld1.16b	{ v17 }, [x9], x3
ld1.16b	{ v18 }, [x2], x3
umull.8h	v4, v16, v2
umull2.8h	v5, v16, v2
umull.8h	v6, v17, v2
umull2.8h	v7, v17, v2
umlal.8h	v4, v17, v3
umlal2.8h	v5, v17, v3
umlal.8h	v6, v18, v3
umlal2.8h	v7, v18, v3
subs	w5, w5, #2
uqrshrn.8b	v4, v4, #4
uqrshrn2.16b	v4, v5, #4
uqrshrn.8b	v6, v6, #4
uqrshrn2.16b	v6, v7, #4
st1.16b	{ v4 }, [x0], x1
st1.16b	{ v6 }, [x8], x1
b.le	put_bilin_8bpc_neon
mov.16b	v16, v18
b	put_bilin_8bpc_neon
subs	w4, w4, #16
b.le	put_bilin_8bpc_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #16
add	x0, x0, #16
b	put_bilin_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#472
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
adr	x9, #396
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.s	{ v28 }[0], [x2], x3
ext.8b	v29, v28, v28, #1
umull.8h	v16, v28, v0
umlal.8h	v16, v29, v1
ld1.s	{ v28 }[0], [x9], x3
ld1.s	{ v30 }[0], [x2], x3
ext.8b	v29, v28, v28, #1
ext.8b	v31, v30, v30, #1
trn1.4h	v28, v28, v30
trn1.4h	v29, v29, v31
umull.8h	v17, v28, v0
umlal.8h	v17, v29, v1
trn1.2s	v16, v16, v17
mul.4h	v4, v16, v2
mla.4h	v4, v17, v3
uqrshrn.8b	v4, v4, #8
subs	w5, w5, #2
st1.h	{ v4 }[0], [x0], x1
st1.h	{ v4 }[1], [x8], x1
b.le	put_bilin_8bpc_neon
trn2.2s	v16, v17, v17
b	put_bilin_8bpc_neon
ret
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.8b	{ v28 }, [x2], x3
ext.8b	v29, v28, v28, #1
umull.8h	v16, v28, v0
umlal.8h	v16, v29, v1
ld1.8b	{ v28 }, [x9], x3
ld1.8b	{ v30 }, [x2], x3
ext.8b	v29, v28, v28, #1
ext.8b	v31, v30, v30, #1
trn1.2s	v28, v28, v30
trn1.2s	v29, v29, v31
umull.8h	v17, v28, v0
umlal.8h	v17, v29, v1
trn1.2d	v16, v16, v17
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
subs	w5, w5, #2
uqrshrn.8b	v4, v4, #8
st1.s	{ v4 }[0], [x0], x1
st1.s	{ v4 }[1], [x8], x1
b.le	put_bilin_8bpc_neon
trn2.2d	v16, v17, v17
b	put_bilin_8bpc_neon
ret
mov	w7, w5
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1.16b	{ v28 }, [x2], x3
ext.16b	v29, v28, v28, #1
umull.8h	v16, v28, v0
umlal.8h	v16, v29, v1
ld1.16b	{ v28 }, [x9], x3
ld1.16b	{ v30 }, [x2], x3
ext.16b	v29, v28, v28, #1
ext.16b	v31, v30, v30, #1
umull.8h	v17, v28, v0
umlal.8h	v17, v29, v1
umull.8h	v18, v30, v0
umlal.8h	v18, v31, v1
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
mul.8h	v5, v17, v2
mla.8h	v5, v18, v3
subs	w5, w5, #2
uqrshrn.8b	v4, v4, #8
uqrshrn.8b	v5, v5, #8
st1.8b	{ v4 }, [x0], x1
st1.8b	{ v5 }, [x8], x1
b.le	put_bilin_8bpc_neon
mov.16b	v16, v18
b	put_bilin_8bpc_neon
subs	w4, w4, #8
b.le	put_bilin_8bpc_neon
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #8
add	x0, x0, #8
b	put_bilin_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#380
_prep_8tap_regular_sharp_8bpc_neon:
mov	x8, #45
mov	x9, #3885
b	prep_8tap_neon
_prep_8tap_smooth_sharp_8bpc_neon:
mov	x8, #1980
mov	x9, #3885
b	prep_8tap_neon
_prep_8tap_sharp_8bpc_neon:
mov	x8, #3885
mov	x9, #3885
b	prep_8tap_neon
_prep_8tap_sharp_regular_8bpc_neon:
mov	x8, #3885
mov	x9, #45
b	prep_8tap_neon
_prep_8tap_sharp_smooth_8bpc_neon:
mov	x8, #3885
mov	x9, #1980
b	prep_8tap_neon
_prep_8tap_neon:
mov	w10, #16513
mul	w5, w5, w10
mul	w6, w6, w10
add	w5, w5, w8
add	w6, w6, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
tst	w5, #0x1fc000
sub	w8, w8, #24
adrp	x10, prep_8tap_neon
add	x10, x10, #0
sub	x10, x10, #8
b.ne	prep_8tap_neon
tst	w6, #0x1fc000
b.ne	prep_8tap_neon
b	prep_neon
cmp	w3, #4
ubfx	w9, w5, #7, #7
and	w5, w5, #0x7f
b.le	prep_8tap_neon
mov	w5, w9
tst	w6, #0x1fc000
add	x5, x10, w5, uxtw #3
b.ne	prep_8tap_neon
adr	x9, #752
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
sub	x1, x1, #1
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16 }, [x1], x2
ld1.8b	{ v20 }, [x9], x2
ushll.8h	v16, v16, #0
ushll.8h	v20, v20, #0
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w4, w4, #2
mul.4h	v16, v16, v0[0]
mla.4h	v16, v17, v0[1]
mla.4h	v16, v18, v0[2]
mla.4h	v16, v19, v0[3]
mul.4h	v20, v20, v0[0]
mla.4h	v20, v21, v0[1]
mla.4h	v20, v22, v0[2]
mla.4h	v20, v23, v0[3]
srshr.4h	v16, v16, #2
srshr.4h	v20, v20, #2
st1.4h	{ v16 }, [x0], x7
st1.4h	{ v20 }, [x8], x7
b.gt	prep_8tap_neon
ret
ld1.8b	{ v0 }, [x5]
sub	x1, x1, #3
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16, v17 }, [x1], x2
ld1.8b	{ v20, v21 }, [x9], x2
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
mul.8h	v18, v16, v0[0]
mul.8h	v22, v20, v0[0]
ext.16b	v19, v16, v17, #2
ext.16b	v23, v20, v21, #2
mla.8h	v18, v19, v0[1]
mla.8h	v22, v23, v0[1]
ext.16b	v19, v16, v17, #4
ext.16b	v23, v20, v21, #4
mla.8h	v18, v19, v0[2]
mla.8h	v22, v23, v0[2]
ext.16b	v19, v16, v17, #6
ext.16b	v23, v20, v21, #6
mla.8h	v18, v19, v0[3]
mla.8h	v22, v23, v0[3]
ext.16b	v19, v16, v17, #8
ext.16b	v23, v20, v21, #8
mla.8h	v18, v19, v0[4]
mla.8h	v22, v23, v0[4]
ext.16b	v19, v16, v17, #10
ext.16b	v23, v20, v21, #10
mla.8h	v18, v19, v0[5]
mla.8h	v22, v23, v0[5]
ext.16b	v19, v16, v17, #12
ext.16b	v23, v20, v21, #12
mla.8h	v18, v19, v0[6]
mla.8h	v22, v23, v0[6]
ext.16b	v19, v16, v17, #14
ext.16b	v23, v20, v21, #14
mla.8h	v18, v19, v0[7]
mla.8h	v22, v23, v0[7]
subs	w4, w4, #2
srshr.8h	v18, v18, #2
srshr.8h	v22, v22, #2
st1.8h	{ v18 }, [x0], x7
st1.8h	{ v22 }, [x8], x7
b.gt	prep_8tap_neon
ret
ld1.8b	{ v0 }, [x5]
sub	x1, x1, #3
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
sub	x2, x2, w3, uxtw
sub	x2, x2, #8
ld1.8b	{ v16, v17, v18 }, [x1], #24
ld1.8b	{ v20, v21, v22 }, [x9], #24
mov	w5, w3
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
mul.8h	v24, v16, v0[0]
mul.8h	v25, v17, v0[0]
mul.8h	v26, v20, v0[0]
mul.8h	v27, v21, v0[0]
ext.16b	v28, v16, v17, #2
ext.16b	v29, v17, v18, #2
ext.16b	v30, v20, v21, #2
ext.16b	v31, v21, v22, #2
mla.8h	v24, v28, v0[1]
mla.8h	v25, v29, v0[1]
mla.8h	v26, v30, v0[1]
mla.8h	v27, v31, v0[1]
ext.16b	v28, v16, v17, #4
ext.16b	v29, v17, v18, #4
ext.16b	v30, v20, v21, #4
ext.16b	v31, v21, v22, #4
mla.8h	v24, v28, v0[2]
mla.8h	v25, v29, v0[2]
mla.8h	v26, v30, v0[2]
mla.8h	v27, v31, v0[2]
ext.16b	v28, v16, v17, #6
ext.16b	v29, v17, v18, #6
ext.16b	v30, v20, v21, #6
ext.16b	v31, v21, v22, #6
mla.8h	v24, v28, v0[3]
mla.8h	v25, v29, v0[3]
mla.8h	v26, v30, v0[3]
mla.8h	v27, v31, v0[3]
ext.16b	v28, v16, v17, #8
ext.16b	v29, v17, v18, #8
ext.16b	v30, v20, v21, #8
ext.16b	v31, v21, v22, #8
mla.8h	v24, v28, v0[4]
mla.8h	v25, v29, v0[4]
mla.8h	v26, v30, v0[4]
mla.8h	v27, v31, v0[4]
ext.16b	v28, v16, v17, #10
ext.16b	v29, v17, v18, #10
ext.16b	v30, v20, v21, #10
ext.16b	v31, v21, v22, #10
mla.8h	v24, v28, v0[5]
mla.8h	v25, v29, v0[5]
mla.8h	v26, v30, v0[5]
mla.8h	v27, v31, v0[5]
ext.16b	v28, v16, v17, #12
ext.16b	v29, v17, v18, #12
ext.16b	v30, v20, v21, #12
ext.16b	v31, v21, v22, #12
mla.8h	v24, v28, v0[6]
mla.8h	v25, v29, v0[6]
mla.8h	v26, v30, v0[6]
mla.8h	v27, v31, v0[6]
ext.16b	v28, v16, v17, #14
ext.16b	v29, v17, v18, #14
ext.16b	v30, v20, v21, #14
ext.16b	v31, v21, v22, #14
mla.8h	v24, v28, v0[7]
mla.8h	v25, v29, v0[7]
mla.8h	v26, v30, v0[7]
mla.8h	v27, v31, v0[7]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
srshr.8h	v26, v26, #2
srshr.8h	v27, v27, #2
subs	w5, w5, #16
st1.8h	{ v24, v25 }, [x0], #32
st1.8h	{ v26, v27 }, [x8], #32
b.le	prep_8tap_neon
mov.16b	v16, v18
mov.16b	v20, v22
ld1.8b	{ v17, v18 }, [x1], #16
ld1.8b	{ v21, v22 }, [x9], #16
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
b	prep_8tap_neon
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #2
b.gt	prep_8tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#736
cmp	w4, #4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_8tap_neon
mov	w6, w9
add	x6, x10, w6, uxtw #3
adr	x9, #2008
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
b.gt	prep_8tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x1], x2
ld1.s	{ v2 }[0], [x9], x2
ld1.s	{ v3 }[0], [x1], x2
ld1.s	{ v4 }[0], [x9], x2
ld1.s	{ v5 }[0], [x1], x2
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
srshr.8h	v6, v6, #2
st1.d	{ v6 }[0], [x0], x7
st1.d	{ v6 }[1], [x8], x7
b.le	prep_8tap_neon
ld1.s	{ v6 }[0], [x9], x2
ld1.s	{ v7 }[0], [x1], x2
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
mul.8h	v7, v3, v0[0]
mla.8h	v7, v4, v0[1]
mla.8h	v7, v5, v0[2]
mla.8h	v7, v6, v0[3]
srshr.8h	v7, v7, #2
st1.d	{ v7 }[0], [x0], x7
st1.d	{ v7 }[1], [x8], x7
ret
ld1.8b	{ v0 }, [x6]
sub	x9, x1, x2, lsl #1
add	x8, x0, x7
sub	x1, x9, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
ld1.s	{ v16 }[0], [x1], x2
ld1.s	{ v17 }[0], [x9], x2
ld1.s	{ v18 }[0], [x1], x2
ld1.s	{ v19 }[0], [x9], x2
ld1.s	{ v20 }[0], [x1], x2
ld1.s	{ v21 }[0], [x9], x2
ld1.s	{ v22 }[0], [x1], x2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
subs	w4, w4, #4
ld1.s	{ v23 }[0], [x9], x2
ld1.s	{ v24 }[0], [x1], x2
ld1.s	{ v25 }[0], [x9], x2
ld1.s	{ v26 }[0], [x1], x2
trn1.2s	v22, v22, v23
trn1.2s	v23, v23, v24
trn1.2s	v24, v24, v25
trn1.2s	v25, v25, v26
ushll.8h	v22, v22, #0
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
ushll.8h	v25, v25, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mla.8h	v1, v23, v0[7]
mul.8h	v2, v18, v0[0]
mla.8h	v2, v19, v0[1]
mla.8h	v2, v20, v0[2]
mla.8h	v2, v21, v0[3]
mla.8h	v2, v22, v0[4]
mla.8h	v2, v23, v0[5]
mla.8h	v2, v24, v0[6]
mla.8h	v2, v25, v0[7]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.d	{ v1 }[0], [x0], x7
st1.d	{ v1 }[1], [x8], x7
st1.d	{ v2 }[0], [x0], x7
st1.d	{ v2 }[1], [x8], x7
b.le	prep_8tap_neon
ld1.s	{ v27 }[0], [x9], x2
ld1.s	{ v16 }[0], [x1], x2
subs	w4, w4, #2
trn1.2s	v26, v26, v27
trn1.2s	v27, v27, v16
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
mul.8h	v1, v20, v0[0]
mla.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
mla.8h	v1, v27, v0[7]
srshr.8h	v1, v1, #2
st1.d	{ v1 }[0], [x0], x7
st1.d	{ v1 }[1], [x8], x7
b.le	prep_8tap_neon
ld1.s	{ v17 }[0], [x9], x2
ld1.s	{ v18 }[0], [x1], x2
subs	w4, w4, #2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
mul.8h	v2, v22, v0[0]
mla.8h	v2, v23, v0[1]
mla.8h	v2, v24, v0[2]
mla.8h	v2, v25, v0[3]
mla.8h	v2, v26, v0[4]
mla.8h	v2, v27, v0[5]
mla.8h	v2, v16, v0[6]
mla.8h	v2, v17, v0[7]
srshr.8h	v2, v2, #2
st1.d	{ v2 }[0], [x0], x7
st1.d	{ v2 }[1], [x8], x7
b.le	prep_8tap_neon
subs	w4, w4, #4
ld1.s	{ v19 }[0], [x9], x2
ld1.s	{ v20 }[0], [x1], x2
ld1.s	{ v21 }[0], [x9], x2
ld1.s	{ v22 }[0], [x1], x2
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
mul.8h	v1, v24, v0[0]
mla.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mla.8h	v1, v19, v0[7]
mul.8h	v2, v26, v0[0]
mla.8h	v2, v27, v0[1]
mla.8h	v2, v16, v0[2]
mla.8h	v2, v17, v0[3]
mla.8h	v2, v18, v0[4]
mla.8h	v2, v19, v0[5]
mla.8h	v2, v20, v0[6]
mla.8h	v2, v21, v0[7]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.d	{ v1 }[0], [x0], x7
st1.d	{ v1 }[1], [x8], x7
st1.d	{ v2 }[0], [x0], x7
st1.d	{ v2 }[1], [x8], x7
b.gt	prep_8tap_neon
ret
b.gt	prep_8tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v1 }, [x1], x2
ld1.8b	{ v2 }, [x9], x2
ld1.8b	{ v3 }, [x1], x2
ld1.8b	{ v4 }, [x9], x2
ld1.8b	{ v5 }, [x1], x2
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
ushll.8h	v5, v5, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
mul.8h	v7, v2, v0[0]
mla.8h	v7, v3, v0[1]
mla.8h	v7, v4, v0[2]
mla.8h	v7, v5, v0[3]
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
st1.16b	{ v6 }, [x0], x7
st1.16b	{ v7 }, [x8], x7
b.le	prep_8tap_neon
ld1.8b	{ v6 }, [x9], x2
ld1.8b	{ v7 }, [x1], x2
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
mul.8h	v1, v3, v0[0]
mla.8h	v1, v4, v0[1]
mla.8h	v1, v5, v0[2]
mla.8h	v1, v6, v0[3]
mul.8h	v2, v4, v0[0]
mla.8h	v2, v5, v0[1]
mla.8h	v2, v6, v0[2]
mla.8h	v2, v7, v0[3]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
ret
ld1.8b	{ v0 }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.8b	{ v16 }, [x1], x2
ld1.8b	{ v17 }, [x9], x2
ld1.8b	{ v18 }, [x1], x2
ld1.8b	{ v19 }, [x9], x2
ld1.8b	{ v20 }, [x1], x2
ld1.8b	{ v21 }, [x9], x2
ld1.8b	{ v22 }, [x1], x2
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
subs	w4, w4, #2
ld1.8b	{ v23 }, [x9], x2
ld1.8b	{ v24 }, [x1], x2
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mla.8h	v1, v23, v0[7]
mul.8h	v2, v17, v0[0]
mla.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
mla.8h	v2, v20, v0[3]
mla.8h	v2, v21, v0[4]
mla.8h	v2, v22, v0[5]
mla.8h	v2, v23, v0[6]
mla.8h	v2, v24, v0[7]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
b.le	prep_8tap_neon
subs	w4, w4, #2
ld1.8b	{ v25 }, [x9], x2
ld1.8b	{ v26 }, [x1], x2
ushll.8h	v25, v25, #0
ushll.8h	v26, v26, #0
mul.8h	v3, v18, v0[0]
mla.8h	v3, v19, v0[1]
mla.8h	v3, v20, v0[2]
mla.8h	v3, v21, v0[3]
mla.8h	v3, v22, v0[4]
mla.8h	v3, v23, v0[5]
mla.8h	v3, v24, v0[6]
mla.8h	v3, v25, v0[7]
mul.8h	v4, v19, v0[0]
mla.8h	v4, v20, v0[1]
mla.8h	v4, v21, v0[2]
mla.8h	v4, v22, v0[3]
mla.8h	v4, v23, v0[4]
mla.8h	v4, v24, v0[5]
mla.8h	v4, v25, v0[6]
mla.8h	v4, v26, v0[7]
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.16b	{ v3 }, [x0], x7
st1.16b	{ v4 }, [x8], x7
b.le	prep_8tap_neon
subs	w4, w4, #2
ld1.8b	{ v27 }, [x9], x2
ld1.8b	{ v16 }, [x1], x2
ushll.8h	v27, v27, #0
ushll.8h	v16, v16, #0
mul.8h	v1, v20, v0[0]
mla.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
mla.8h	v1, v27, v0[7]
mul.8h	v2, v21, v0[0]
mla.8h	v2, v22, v0[1]
mla.8h	v2, v23, v0[2]
mla.8h	v2, v24, v0[3]
mla.8h	v2, v25, v0[4]
mla.8h	v2, v26, v0[5]
mla.8h	v2, v27, v0[6]
mla.8h	v2, v16, v0[7]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
b.le	prep_8tap_neon
subs	w4, w4, #2
ld1.8b	{ v17 }, [x9], x2
ld1.8b	{ v18 }, [x1], x2
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
mul.8h	v3, v22, v0[0]
mla.8h	v3, v23, v0[1]
mla.8h	v3, v24, v0[2]
mla.8h	v3, v25, v0[3]
mla.8h	v3, v26, v0[4]
mla.8h	v3, v27, v0[5]
mla.8h	v3, v16, v0[6]
mla.8h	v3, v17, v0[7]
mul.8h	v4, v23, v0[0]
mla.8h	v4, v24, v0[1]
mla.8h	v4, v25, v0[2]
mla.8h	v4, v26, v0[3]
mla.8h	v4, v27, v0[4]
mla.8h	v4, v16, v0[5]
mla.8h	v4, v17, v0[6]
mla.8h	v4, v18, v0[7]
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.16b	{ v3 }, [x0], x7
st1.16b	{ v4 }, [x8], x7
b.le	prep_8tap_neon
subs	w4, w4, #4
ld1.8b	{ v19 }, [x9], x2
ld1.8b	{ v20 }, [x1], x2
ld1.8b	{ v21 }, [x9], x2
ld1.8b	{ v22 }, [x1], x2
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
mul.8h	v1, v24, v0[0]
mla.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mla.8h	v1, v19, v0[7]
mul.8h	v2, v25, v0[0]
mla.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v16, v0[3]
mla.8h	v2, v17, v0[4]
mla.8h	v2, v18, v0[5]
mla.8h	v2, v19, v0[6]
mla.8h	v2, v20, v0[7]
mul.8h	v3, v26, v0[0]
mla.8h	v3, v27, v0[1]
mla.8h	v3, v16, v0[2]
mla.8h	v3, v17, v0[3]
mla.8h	v3, v18, v0[4]
mla.8h	v3, v19, v0[5]
mla.8h	v3, v20, v0[6]
mla.8h	v3, v21, v0[7]
mul.8h	v4, v27, v0[0]
mla.8h	v4, v16, v0[1]
mla.8h	v4, v17, v0[2]
mla.8h	v4, v18, v0[3]
mla.8h	v4, v19, v0[4]
mla.8h	v4, v20, v0[5]
mla.8h	v4, v21, v0[6]
mla.8h	v4, v22, v0[7]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
st1.16b	{ v3 }, [x0], x7
st1.16b	{ v4 }, [x8], x7
b.gt	prep_8tap_neon
subs	w3, w3, #8
b.le	prep_8tap_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
b	prep_8tap_neon
ret
b.gt	prep_8tap_neon
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
cmp	w4, #2
ld1.16b	{ v1 }, [x1], x2
ld1.16b	{ v2 }, [x9], x2
ld1.16b	{ v3 }, [x1], x2
ld1.16b	{ v4 }, [x9], x2
ld1.16b	{ v5 }, [x1], x2
ushll.8h	v16, v1, #0
ushll.8h	v17, v2, #0
ushll.8h	v18, v3, #0
ushll.8h	v19, v4, #0
ushll.8h	v20, v5, #0
ushll2.8h	v23, v1, #0
ushll2.8h	v24, v2, #0
ushll2.8h	v25, v3, #0
ushll2.8h	v26, v4, #0
ushll2.8h	v27, v5, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mul.8h	v16, v17, v0[0]
mla.8h	v16, v18, v0[1]
mla.8h	v16, v19, v0[2]
mla.8h	v16, v20, v0[3]
mul.8h	v2, v23, v0[0]
mla.8h	v2, v24, v0[1]
mla.8h	v2, v25, v0[2]
mla.8h	v2, v26, v0[3]
mul.8h	v17, v24, v0[0]
mla.8h	v17, v25, v0[1]
mla.8h	v17, v26, v0[2]
mla.8h	v17, v27, v0[3]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
srshr.8h	v16, v16, #2
srshr.8h	v17, v17, #2
st1.8h	{ v1, v2 }, [x0], x7
st1.8h	{ v16, v17 }, [x8], x7
b.le	prep_8tap_neon
ld1.16b	{ v6 }, [x9], x2
ld1.16b	{ v7 }, [x1], x2
ushll.8h	v21, v6, #0
ushll.8h	v22, v7, #0
ushll2.8h	v28, v6, #0
ushll2.8h	v29, v7, #0
mul.8h	v1, v18, v0[0]
mla.8h	v1, v19, v0[1]
mla.8h	v1, v20, v0[2]
mla.8h	v1, v21, v0[3]
mul.8h	v3, v19, v0[0]
mla.8h	v3, v20, v0[1]
mla.8h	v3, v21, v0[2]
mla.8h	v3, v22, v0[3]
mul.8h	v2, v25, v0[0]
mla.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v28, v0[3]
mul.8h	v4, v26, v0[0]
mla.8h	v4, v27, v0[1]
mla.8h	v4, v28, v0[2]
mla.8h	v4, v29, v0[3]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.8h	{ v1, v2 }, [x0], x7
st1.8h	{ v3, v4 }, [x8], x7
ret
sub	z8.b, z1.b, z8.b
<unknown>
<unknown>
udf	#1992
cmp	w4, #4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_8tap_neon
mov	w6, w9
add	x6, x10, w6, uxtw #3
adr	x9, #1328
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
b.gt	prep_8tap_neon
add	x6, x6, #2
ld1.s	{ v1 }[0], [x6]
sub	x9, x1, #1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x1], x2
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v16, v31, #2
bl	prep_8tap_neon
mov.8b	v17, v28
mov.8b	v18, v29
bl	prep_8tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v28, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v28, v1[2]
smlal.4s	v3, v29, v1[3]
sqrshrn.4h	v2, v2, #6
sqrshrn.4h	v3, v3, #6
subs	w4, w4, #2
st1.4h	{ v2 }, [x0], x7
st1.4h	{ v3 }, [x8], x7
b.le	prep_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v28
mov.8b	v18, v29
b	prep_8tap_neon
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #1
sub	x9, x1, x2, lsl #1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x1], x2
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v16, v31, #2
bl	prep_8tap_neon
mov.8b	v17, v28
mov.8b	v18, v29
bl	prep_8tap_neon
mov.8b	v19, v28
mov.8b	v20, v29
bl	prep_8tap_neon
mov.8b	v21, v28
mov.8b	v22, v29
bl	prep_8tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v19, v1[3]
smlal.4s	v2, v20, v1[4]
smlal.4s	v2, v21, v1[5]
smlal.4s	v2, v22, v1[6]
smlal.4s	v2, v28, v1[7]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v19, v1[2]
smlal.4s	v3, v20, v1[3]
smlal.4s	v3, v21, v1[4]
smlal.4s	v3, v22, v1[5]
smlal.4s	v3, v28, v1[6]
smlal.4s	v3, v29, v1[7]
sqrshrn.4h	v2, v2, #6
sqrshrn.4h	v3, v3, #6
subs	w4, w4, #2
st1.4h	{ v2 }, [x0], x7
st1.4h	{ v3 }, [x8], x7
b.le	prep_8tap_neon
mov.8b	v16, v18
mov.8b	v17, v19
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v28
mov.8b	v22, v29
b	prep_8tap_neon
ret	x15
ld1.8b	{ v26 }, [x9], x2
ld1.8b	{ v27 }, [x1], x2
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
ext.16b	v28, v27, v27, #2
ext.16b	v29, v27, v27, #4
ext.16b	v30, v27, v27, #6
mul.4h	v27, v27, v0[0]
mla.4h	v27, v28, v0[1]
mla.4h	v27, v29, v0[2]
mla.4h	v27, v30, v0[3]
srshr.4h	v28, v31, #2
srshr.4h	v29, v27, #2
ret
b.gt	prep_8tap_neon
add	x6, x6, #2
ld1.8b	{ v0 }, [x5]
ld1.s	{ v1 }[0], [x6]
sub	x1, x1, #3
sub	x1, x1, x2
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	prep_8tap_neon
bl	prep_8tap_neon
mov.16b	v17, v24
mov.16b	v18, v25
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
smlal.4s	v4, v24, v1[2]
smlal2.4s	v5, v24, v1[2]
smlal.4s	v2, v24, v1[3]
smlal2.4s	v3, v24, v1[3]
smlal.4s	v4, v25, v1[3]
smlal2.4s	v5, v25, v1[3]
sqrshrn.4h	v2, v2, #6
sqrshrn2.8h	v2, v3, #6
sqrshrn.4h	v4, v4, #6
sqrshrn2.8h	v4, v5, #6
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x7
st1.8h	{ v4 }, [x8], x7
b.le	prep_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v24
mov.16b	v18, v25
b	prep_8tap_neon
subs	w3, w3, #8
b.le	prep_8tap_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
b	prep_8tap_neon
ld1.8b	{ v0 }, [x5]
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #3
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	prep_8tap_neon
bl	prep_8tap_neon
mov.16b	v17, v24
mov.16b	v18, v25
bl	prep_8tap_neon
mov.16b	v19, v24
mov.16b	v20, v25
bl	prep_8tap_neon
mov.16b	v21, v24
mov.16b	v22, v25
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
smlal.4s	v4, v24, v1[6]
smlal2.4s	v5, v24, v1[6]
smlal.4s	v2, v24, v1[7]
smlal2.4s	v3, v24, v1[7]
smlal.4s	v4, v25, v1[7]
smlal2.4s	v5, v25, v1[7]
sqrshrn.4h	v2, v2, #6
sqrshrn2.8h	v2, v3, #6
sqrshrn.4h	v4, v4, #6
sqrshrn2.8h	v4, v5, #6
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x7
st1.8h	{ v4 }, [x8], x7
b.le	prep_8tap_neon
mov.16b	v16, v18
mov.16b	v17, v19
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v24
mov.16b	v22, v25
b	prep_8tap_neon
subs	w3, w3, #8
b.le	prep_8tap_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
b	prep_8tap_neon
ret	x15
ld1.8b	{ v28, v29 }, [x1], x2
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
mul.8h	v16, v28, v0[0]
ext.16b	v24, v28, v29, #2
ext.16b	v25, v28, v29, #4
ext.16b	v26, v28, v29, #6
ext.16b	v27, v28, v29, #8
mla.8h	v16, v24, v0[1]
mla.8h	v16, v25, v0[2]
mla.8h	v16, v26, v0[3]
mla.8h	v16, v27, v0[4]
ext.16b	v24, v28, v29, #10
ext.16b	v25, v28, v29, #12
ext.16b	v26, v28, v29, #14
mla.8h	v16, v24, v0[5]
mla.8h	v16, v25, v0[6]
mla.8h	v16, v26, v0[7]
srshr.8h	v16, v16, #2
ret
ld1.8b	{ v28, v29 }, [x9], x2
ld1.8b	{ v30, v31 }, [x1], x2
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
ushll.8h	v30, v30, #0
ushll.8h	v31, v31, #0
mul.8h	v24, v28, v0[0]
mul.8h	v25, v30, v0[0]
ext.16b	v26, v28, v29, #2
ext.16b	v27, v30, v31, #2
mla.8h	v24, v26, v0[1]
mla.8h	v25, v27, v0[1]
ext.16b	v26, v28, v29, #4
ext.16b	v27, v30, v31, #4
mla.8h	v24, v26, v0[2]
mla.8h	v25, v27, v0[2]
ext.16b	v26, v28, v29, #6
ext.16b	v27, v30, v31, #6
mla.8h	v24, v26, v0[3]
mla.8h	v25, v27, v0[3]
ext.16b	v26, v28, v29, #8
ext.16b	v27, v30, v31, #8
mla.8h	v24, v26, v0[4]
mla.8h	v25, v27, v0[4]
ext.16b	v26, v28, v29, #10
ext.16b	v27, v30, v31, #10
mla.8h	v24, v26, v0[5]
mla.8h	v25, v27, v0[5]
ext.16b	v26, v28, v29, #12
ext.16b	v27, v30, v31, #12
mla.8h	v24, v26, v0[6]
mla.8h	v25, v27, v0[6]
ext.16b	v26, v28, v29, #14
ext.16b	v27, v30, v31, #14
mla.8h	v24, v26, v0[7]
mla.8h	v25, v27, v0[7]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
ret
<unknown>
<unknown>
ext	z4.b, z4.b, z25.b, #0
udf	#1312
_prep_8tap_regular_8bpc_neon:
mov	x8, #45
mov	x9, #45
b	prep_6tap_neon
_prep_8tap_regular_smooth_8bpc_neon:
mov	x8, #45
mov	x9, #1980
b	prep_6tap_neon
_prep_8tap_smooth_8bpc_neon:
mov	x8, #1980
mov	x9, #1980
b	prep_6tap_neon
_prep_8tap_smooth_regular_8bpc_neon:
mov	x8, #1980
mov	x9, #45
b	prep_6tap_neon
_prep_6tap_neon:
mov	w10, #16513
mul	w5, w5, w10
mul	w6, w6, w10
add	w5, w5, w8
add	w6, w6, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
tst	w5, #0x1fc000
sub	w8, w8, #24
adrp	x10, prep_6tap_neon
add	x10, x10, #0
sub	x10, x10, #8
b.ne	prep_6tap_neon
tst	w6, #0x1fc000
b.ne	prep_6tap_neon
b	prep_neon
cmp	w3, #4
ubfx	w9, w5, #7, #7
and	w5, w5, #0x7f
b.le	prep_6tap_neon
mov	w5, w9
tst	w6, #0x1fc000
add	x5, x10, w5, uxtw #3
b.ne	prep_6tap_neon
adr	x9, #680
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
sub	x1, x1, #1
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16 }, [x1], x2
ld1.8b	{ v20 }, [x9], x2
ushll.8h	v16, v16, #0
ushll.8h	v20, v20, #0
ext.16b	v17, v16, v16, #2
ext.16b	v18, v16, v16, #4
ext.16b	v19, v16, v16, #6
ext.16b	v21, v20, v20, #2
ext.16b	v22, v20, v20, #4
ext.16b	v23, v20, v20, #6
subs	w4, w4, #2
mul.4h	v16, v16, v0[0]
mla.4h	v16, v17, v0[1]
mla.4h	v16, v18, v0[2]
mla.4h	v16, v19, v0[3]
mul.4h	v20, v20, v0[0]
mla.4h	v20, v21, v0[1]
mla.4h	v20, v22, v0[2]
mla.4h	v20, v23, v0[3]
srshr.4h	v16, v16, #2
srshr.4h	v20, v20, #2
st1.4h	{ v16 }, [x0], x7
st1.4h	{ v20 }, [x8], x7
b.gt	prep_6tap_neon
ret
ld1.8b	{ v0 }, [x5]
sub	x1, x1, #3
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v16, v17 }, [x1], x2
ld1.8b	{ v20, v21 }, [x9], x2
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ext.16b	v19, v16, v17, #2
ext.16b	v23, v20, v21, #2
mul.8h	v18, v19, v0[1]
mul.8h	v22, v23, v0[1]
ext.16b	v19, v16, v17, #4
ext.16b	v23, v20, v21, #4
mla.8h	v18, v19, v0[2]
mla.8h	v22, v23, v0[2]
ext.16b	v19, v16, v17, #6
ext.16b	v23, v20, v21, #6
mla.8h	v18, v19, v0[3]
mla.8h	v22, v23, v0[3]
ext.16b	v19, v16, v17, #8
ext.16b	v23, v20, v21, #8
mla.8h	v18, v19, v0[4]
mla.8h	v22, v23, v0[4]
ext.16b	v19, v16, v17, #10
ext.16b	v23, v20, v21, #10
mla.8h	v18, v19, v0[5]
mla.8h	v22, v23, v0[5]
ext.16b	v19, v16, v17, #12
ext.16b	v23, v20, v21, #12
mla.8h	v18, v19, v0[6]
mla.8h	v22, v23, v0[6]
subs	w4, w4, #2
srshr.8h	v18, v18, #2
srshr.8h	v22, v22, #2
st1.8h	{ v18 }, [x0], x7
st1.8h	{ v22 }, [x8], x7
b.gt	prep_6tap_neon
ret
ld1.8b	{ v0 }, [x5]
sub	x1, x1, #3
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sshll.8h	v0, v0, #0
sub	x2, x2, w3, uxtw
sub	x2, x2, #8
ld1.8b	{ v16, v17, v18 }, [x1], #24
ld1.8b	{ v20, v21, v22 }, [x9], #24
mov	w5, w3
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
ext.16b	v28, v16, v17, #2
ext.16b	v29, v17, v18, #2
ext.16b	v30, v20, v21, #2
ext.16b	v31, v21, v22, #2
mul.8h	v24, v28, v0[1]
mul.8h	v25, v29, v0[1]
mul.8h	v26, v30, v0[1]
mul.8h	v27, v31, v0[1]
ext.16b	v28, v16, v17, #4
ext.16b	v29, v17, v18, #4
ext.16b	v30, v20, v21, #4
ext.16b	v31, v21, v22, #4
mla.8h	v24, v28, v0[2]
mla.8h	v25, v29, v0[2]
mla.8h	v26, v30, v0[2]
mla.8h	v27, v31, v0[2]
ext.16b	v28, v16, v17, #6
ext.16b	v29, v17, v18, #6
ext.16b	v30, v20, v21, #6
ext.16b	v31, v21, v22, #6
mla.8h	v24, v28, v0[3]
mla.8h	v25, v29, v0[3]
mla.8h	v26, v30, v0[3]
mla.8h	v27, v31, v0[3]
ext.16b	v28, v16, v17, #8
ext.16b	v29, v17, v18, #8
ext.16b	v30, v20, v21, #8
ext.16b	v31, v21, v22, #8
mla.8h	v24, v28, v0[4]
mla.8h	v25, v29, v0[4]
mla.8h	v26, v30, v0[4]
mla.8h	v27, v31, v0[4]
ext.16b	v28, v16, v17, #10
ext.16b	v29, v17, v18, #10
ext.16b	v30, v20, v21, #10
ext.16b	v31, v21, v22, #10
mla.8h	v24, v28, v0[5]
mla.8h	v25, v29, v0[5]
mla.8h	v26, v30, v0[5]
mla.8h	v27, v31, v0[5]
ext.16b	v28, v16, v17, #12
ext.16b	v29, v17, v18, #12
ext.16b	v30, v20, v21, #12
ext.16b	v31, v21, v22, #12
mla.8h	v24, v28, v0[6]
mla.8h	v25, v29, v0[6]
mla.8h	v26, v30, v0[6]
mla.8h	v27, v31, v0[6]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
srshr.8h	v26, v26, #2
srshr.8h	v27, v27, #2
subs	w5, w5, #16
st1.8h	{ v24, v25 }, [x0], #32
st1.8h	{ v26, v27 }, [x8], #32
b.le	prep_6tap_neon
mov.16b	v16, v18
mov.16b	v20, v22
ld1.8b	{ v17, v18 }, [x1], #16
ld1.8b	{ v21, v22 }, [x9], #16
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
b	prep_6tap_neon
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #2
b.gt	prep_6tap_neon
ret
<unknown>
<unknown>
<unknown>
udf	#664
cmp	w4, #4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_6tap_neon
mov	w6, w9
add	x6, x10, w6, uxtw #3
adr	x9, #1864
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
b.gt	prep_6tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x1], x2
ld1.s	{ v2 }[0], [x9], x2
ld1.s	{ v3 }[0], [x1], x2
ld1.s	{ v4 }[0], [x9], x2
ld1.s	{ v5 }[0], [x1], x2
trn1.2s	v1, v1, v2
trn1.2s	v2, v2, v3
trn1.2s	v3, v3, v4
trn1.2s	v4, v4, v5
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
srshr.8h	v6, v6, #2
st1.d	{ v6 }[0], [x0], x7
st1.d	{ v6 }[1], [x8], x7
b.le	prep_6tap_neon
ld1.s	{ v6 }[0], [x9], x2
ld1.s	{ v7 }[0], [x1], x2
trn1.2s	v5, v5, v6
trn1.2s	v6, v6, v7
ushll.8h	v5, v5, #0
ushll.8h	v6, v6, #0
mul.8h	v7, v3, v0[0]
mla.8h	v7, v4, v0[1]
mla.8h	v7, v5, v0[2]
mla.8h	v7, v6, v0[3]
srshr.8h	v7, v7, #2
st1.d	{ v7 }[0], [x0], x7
st1.d	{ v7 }[1], [x8], x7
ret
ld1.8b	{ v0 }, [x6]
sub	x9, x1, x2, lsl #1
add	x8, x0, x7
sub	x1, x9, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
ld1.s	{ v16 }[0], [x1], x2
ld1.s	{ v17 }[0], [x9], x2
ld1.s	{ v18 }[0], [x1], x2
ld1.s	{ v19 }[0], [x9], x2
ld1.s	{ v20 }[0], [x1], x2
ld1.s	{ v21 }[0], [x9], x2
ld1.s	{ v22 }[0], [x1], x2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
subs	w4, w4, #4
ld1.s	{ v23 }[0], [x9], x2
ld1.s	{ v24 }[0], [x1], x2
ld1.s	{ v25 }[0], [x9], x2
ld1.s	{ v26 }[0], [x1], x2
trn1.2s	v22, v22, v23
trn1.2s	v23, v23, v24
trn1.2s	v24, v24, v25
trn1.2s	v25, v25, v26
ushll.8h	v22, v22, #0
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
ushll.8h	v25, v25, #0
mul.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mul.8h	v2, v19, v0[1]
mla.8h	v2, v20, v0[2]
mla.8h	v2, v21, v0[3]
mla.8h	v2, v22, v0[4]
mla.8h	v2, v23, v0[5]
mla.8h	v2, v24, v0[6]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.d	{ v1 }[0], [x0], x7
st1.d	{ v1 }[1], [x8], x7
st1.d	{ v2 }[0], [x0], x7
st1.d	{ v2 }[1], [x8], x7
b.le	prep_6tap_neon
ld1.s	{ v27 }[0], [x9], x2
ld1.s	{ v16 }[0], [x1], x2
subs	w4, w4, #2
trn1.2s	v26, v26, v27
trn1.2s	v27, v27, v16
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
mul.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
srshr.8h	v1, v1, #2
st1.d	{ v1 }[0], [x0], x7
st1.d	{ v1 }[1], [x8], x7
b.le	prep_6tap_neon
ld1.s	{ v17 }[0], [x9], x2
ld1.s	{ v18 }[0], [x1], x2
subs	w4, w4, #2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
mul.8h	v2, v23, v0[1]
mla.8h	v2, v24, v0[2]
mla.8h	v2, v25, v0[3]
mla.8h	v2, v26, v0[4]
mla.8h	v2, v27, v0[5]
mla.8h	v2, v16, v0[6]
srshr.8h	v2, v2, #2
st1.d	{ v2 }[0], [x0], x7
st1.d	{ v2 }[1], [x8], x7
b.le	prep_6tap_neon
subs	w4, w4, #4
ld1.s	{ v19 }[0], [x9], x2
ld1.s	{ v20 }[0], [x1], x2
ld1.s	{ v21 }[0], [x9], x2
ld1.s	{ v22 }[0], [x1], x2
trn1.2s	v18, v18, v19
trn1.2s	v19, v19, v20
trn1.2s	v20, v20, v21
trn1.2s	v21, v21, v22
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
mul.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mul.8h	v2, v27, v0[1]
mla.8h	v2, v16, v0[2]
mla.8h	v2, v17, v0[3]
mla.8h	v2, v18, v0[4]
mla.8h	v2, v19, v0[5]
mla.8h	v2, v20, v0[6]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.d	{ v1 }[0], [x0], x7
st1.d	{ v1 }[1], [x8], x7
st1.d	{ v2 }[0], [x0], x7
st1.d	{ v2 }[1], [x8], x7
b.gt	prep_6tap_neon
ret
b.gt	prep_6tap_neon
cmp	w4, #2
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
ld1.8b	{ v1 }, [x1], x2
ld1.8b	{ v2 }, [x9], x2
ld1.8b	{ v3 }, [x1], x2
ld1.8b	{ v4 }, [x9], x2
ld1.8b	{ v5 }, [x1], x2
ushll.8h	v1, v1, #0
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
ushll.8h	v4, v4, #0
ushll.8h	v5, v5, #0
mul.8h	v6, v1, v0[0]
mla.8h	v6, v2, v0[1]
mla.8h	v6, v3, v0[2]
mla.8h	v6, v4, v0[3]
mul.8h	v7, v2, v0[0]
mla.8h	v7, v3, v0[1]
mla.8h	v7, v4, v0[2]
mla.8h	v7, v5, v0[3]
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
st1.16b	{ v6 }, [x0], x7
st1.16b	{ v7 }, [x8], x7
b.le	prep_6tap_neon
ld1.8b	{ v6 }, [x9], x2
ld1.8b	{ v7 }, [x1], x2
ushll.8h	v6, v6, #0
ushll.8h	v7, v7, #0
mul.8h	v1, v3, v0[0]
mla.8h	v1, v4, v0[1]
mla.8h	v1, v5, v0[2]
mla.8h	v1, v6, v0[3]
mul.8h	v2, v4, v0[0]
mla.8h	v2, v5, v0[1]
mla.8h	v2, v6, v0[2]
mla.8h	v2, v7, v0[3]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
ret
ld1.8b	{ v0 }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.8b	{ v16 }, [x1], x2
ld1.8b	{ v17 }, [x9], x2
ld1.8b	{ v18 }, [x1], x2
ld1.8b	{ v19 }, [x9], x2
ld1.8b	{ v20 }, [x1], x2
ld1.8b	{ v21 }, [x9], x2
ld1.8b	{ v22 }, [x1], x2
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
subs	w4, w4, #2
ld1.8b	{ v23 }, [x9], x2
ld1.8b	{ v24 }, [x1], x2
ushll.8h	v23, v23, #0
ushll.8h	v24, v24, #0
mul.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mla.8h	v1, v20, v0[4]
mla.8h	v1, v21, v0[5]
mla.8h	v1, v22, v0[6]
mul.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
mla.8h	v2, v20, v0[3]
mla.8h	v2, v21, v0[4]
mla.8h	v2, v22, v0[5]
mla.8h	v2, v23, v0[6]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
b.le	prep_6tap_neon
subs	w4, w4, #2
ld1.8b	{ v25 }, [x9], x2
ld1.8b	{ v26 }, [x1], x2
ushll.8h	v25, v25, #0
ushll.8h	v26, v26, #0
mul.8h	v3, v19, v0[1]
mla.8h	v3, v20, v0[2]
mla.8h	v3, v21, v0[3]
mla.8h	v3, v22, v0[4]
mla.8h	v3, v23, v0[5]
mla.8h	v3, v24, v0[6]
mul.8h	v4, v20, v0[1]
mla.8h	v4, v21, v0[2]
mla.8h	v4, v22, v0[3]
mla.8h	v4, v23, v0[4]
mla.8h	v4, v24, v0[5]
mla.8h	v4, v25, v0[6]
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.16b	{ v3 }, [x0], x7
st1.16b	{ v4 }, [x8], x7
b.le	prep_6tap_neon
subs	w4, w4, #2
ld1.8b	{ v27 }, [x9], x2
ld1.8b	{ v16 }, [x1], x2
ushll.8h	v27, v27, #0
ushll.8h	v16, v16, #0
mul.8h	v1, v21, v0[1]
mla.8h	v1, v22, v0[2]
mla.8h	v1, v23, v0[3]
mla.8h	v1, v24, v0[4]
mla.8h	v1, v25, v0[5]
mla.8h	v1, v26, v0[6]
mul.8h	v2, v22, v0[1]
mla.8h	v2, v23, v0[2]
mla.8h	v2, v24, v0[3]
mla.8h	v2, v25, v0[4]
mla.8h	v2, v26, v0[5]
mla.8h	v2, v27, v0[6]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
b.le	prep_6tap_neon
subs	w4, w4, #2
ld1.8b	{ v17 }, [x9], x2
ld1.8b	{ v18 }, [x1], x2
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
mul.8h	v3, v23, v0[1]
mla.8h	v3, v24, v0[2]
mla.8h	v3, v25, v0[3]
mla.8h	v3, v26, v0[4]
mla.8h	v3, v27, v0[5]
mla.8h	v3, v16, v0[6]
mul.8h	v4, v24, v0[1]
mla.8h	v4, v25, v0[2]
mla.8h	v4, v26, v0[3]
mla.8h	v4, v27, v0[4]
mla.8h	v4, v16, v0[5]
mla.8h	v4, v17, v0[6]
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.16b	{ v3 }, [x0], x7
st1.16b	{ v4 }, [x8], x7
b.le	prep_6tap_neon
subs	w4, w4, #4
ld1.8b	{ v19 }, [x9], x2
ld1.8b	{ v20 }, [x1], x2
ld1.8b	{ v21 }, [x9], x2
ld1.8b	{ v22 }, [x1], x2
ushll.8h	v19, v19, #0
ushll.8h	v20, v20, #0
ushll.8h	v21, v21, #0
ushll.8h	v22, v22, #0
mul.8h	v1, v25, v0[1]
mla.8h	v1, v26, v0[2]
mla.8h	v1, v27, v0[3]
mla.8h	v1, v16, v0[4]
mla.8h	v1, v17, v0[5]
mla.8h	v1, v18, v0[6]
mul.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v16, v0[3]
mla.8h	v2, v17, v0[4]
mla.8h	v2, v18, v0[5]
mla.8h	v2, v19, v0[6]
mul.8h	v3, v27, v0[1]
mla.8h	v3, v16, v0[2]
mla.8h	v3, v17, v0[3]
mla.8h	v3, v18, v0[4]
mla.8h	v3, v19, v0[5]
mla.8h	v3, v20, v0[6]
mul.8h	v4, v16, v0[1]
mla.8h	v4, v17, v0[2]
mla.8h	v4, v18, v0[3]
mla.8h	v4, v19, v0[4]
mla.8h	v4, v20, v0[5]
mla.8h	v4, v21, v0[6]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.16b	{ v1 }, [x0], x7
st1.16b	{ v2 }, [x8], x7
st1.16b	{ v3 }, [x0], x7
st1.16b	{ v4 }, [x8], x7
b.gt	prep_6tap_neon
subs	w3, w3, #8
b.le	prep_6tap_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
b	prep_6tap_neon
ret
b.gt	prep_6tap_neon
add	x6, x6, #2
ld1.s	{ v0 }[0], [x6]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
cmp	w4, #2
ld1.16b	{ v1 }, [x1], x2
ld1.16b	{ v2 }, [x9], x2
ld1.16b	{ v3 }, [x1], x2
ld1.16b	{ v4 }, [x9], x2
ld1.16b	{ v5 }, [x1], x2
ushll.8h	v16, v1, #0
ushll.8h	v17, v2, #0
ushll.8h	v18, v3, #0
ushll.8h	v19, v4, #0
ushll.8h	v20, v5, #0
ushll2.8h	v23, v1, #0
ushll2.8h	v24, v2, #0
ushll2.8h	v25, v3, #0
ushll2.8h	v26, v4, #0
ushll2.8h	v27, v5, #0
mul.8h	v1, v16, v0[0]
mla.8h	v1, v17, v0[1]
mla.8h	v1, v18, v0[2]
mla.8h	v1, v19, v0[3]
mul.8h	v16, v17, v0[0]
mla.8h	v16, v18, v0[1]
mla.8h	v16, v19, v0[2]
mla.8h	v16, v20, v0[3]
mul.8h	v2, v23, v0[0]
mla.8h	v2, v24, v0[1]
mla.8h	v2, v25, v0[2]
mla.8h	v2, v26, v0[3]
mul.8h	v17, v24, v0[0]
mla.8h	v17, v25, v0[1]
mla.8h	v17, v26, v0[2]
mla.8h	v17, v27, v0[3]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
srshr.8h	v16, v16, #2
srshr.8h	v17, v17, #2
st1.8h	{ v1, v2 }, [x0], x7
st1.8h	{ v16, v17 }, [x8], x7
b.le	prep_6tap_neon
ld1.16b	{ v6 }, [x9], x2
ld1.16b	{ v7 }, [x1], x2
ushll.8h	v21, v6, #0
ushll.8h	v22, v7, #0
ushll2.8h	v28, v6, #0
ushll2.8h	v29, v7, #0
mul.8h	v1, v18, v0[0]
mla.8h	v1, v19, v0[1]
mla.8h	v1, v20, v0[2]
mla.8h	v1, v21, v0[3]
mul.8h	v3, v19, v0[0]
mla.8h	v3, v20, v0[1]
mla.8h	v3, v21, v0[2]
mla.8h	v3, v22, v0[3]
mul.8h	v2, v25, v0[0]
mla.8h	v2, v26, v0[1]
mla.8h	v2, v27, v0[2]
mla.8h	v2, v28, v0[3]
mul.8h	v4, v26, v0[0]
mla.8h	v4, v27, v0[1]
mla.8h	v4, v28, v0[2]
mla.8h	v4, v29, v0[3]
srshr.8h	v1, v1, #2
srshr.8h	v2, v2, #2
srshr.8h	v3, v3, #2
srshr.8h	v4, v4, #2
st1.8h	{ v1, v2 }, [x0], x7
st1.8h	{ v3, v4 }, [x8], x7
ret
<unknown>
<unknown>
<unknown>
udf	#1848
cmp	w4, #4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	prep_6tap_neon
mov	w6, w9
add	x6, x10, w6, uxtw #3
adr	x9, #1212
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x5, x5, #2
ld1.s	{ v0 }[0], [x5]
b.gt	prep_6tap_neon
add	x6, x6, #2
ld1.s	{ v1 }[0], [x6]
sub	x9, x1, #1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x1], x2
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v16, v31, #2
bl	prep_6tap_neon
mov.8b	v17, v28
mov.8b	v18, v29
bl	prep_6tap_neon
smull.4s	v2, v16, v1[0]
smlal.4s	v2, v17, v1[1]
smlal.4s	v2, v18, v1[2]
smlal.4s	v2, v28, v1[3]
smull.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v28, v1[2]
smlal.4s	v3, v29, v1[3]
sqrshrn.4h	v2, v2, #6
sqrshrn.4h	v3, v3, #6
subs	w4, w4, #2
st1.4h	{ v2 }, [x0], x7
st1.4h	{ v3 }, [x8], x7
b.le	prep_6tap_neon
mov.8b	v16, v18
mov.8b	v17, v28
mov.8b	v18, v29
b	prep_6tap_neon
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #1
sub	x9, x1, x2
sub	x1, x1, x2, lsl #1
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
ld1.8b	{ v26 }, [x1], x2
ushll.8h	v26, v26, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
srshr.4h	v18, v31, #2
bl	prep_6tap_neon
mov.8b	v19, v28
mov.8b	v20, v29
bl	prep_6tap_neon
mov.8b	v21, v28
mov.8b	v22, v29
bl	prep_6tap_neon
smull.4s	v2, v18, v1[1]
smlal.4s	v2, v19, v1[2]
smlal.4s	v2, v20, v1[3]
smlal.4s	v2, v21, v1[4]
smlal.4s	v2, v22, v1[5]
smlal.4s	v2, v28, v1[6]
smull.4s	v3, v19, v1[1]
smlal.4s	v3, v20, v1[2]
smlal.4s	v3, v21, v1[3]
smlal.4s	v3, v22, v1[4]
smlal.4s	v3, v28, v1[5]
smlal.4s	v3, v29, v1[6]
sqrshrn.4h	v2, v2, #6
sqrshrn.4h	v3, v3, #6
subs	w4, w4, #2
st1.4h	{ v2 }, [x0], x7
st1.4h	{ v3 }, [x8], x7
b.le	prep_6tap_neon
mov.8b	v18, v20
mov.8b	v19, v21
mov.8b	v20, v22
mov.8b	v21, v28
mov.8b	v22, v29
b	prep_6tap_neon
ret	x15
ld1.8b	{ v26 }, [x9], x2
ld1.8b	{ v27 }, [x1], x2
ushll.8h	v26, v26, #0
ushll.8h	v27, v27, #0
ext.16b	v28, v26, v26, #2
ext.16b	v29, v26, v26, #4
ext.16b	v30, v26, v26, #6
mul.4h	v31, v26, v0[0]
mla.4h	v31, v28, v0[1]
mla.4h	v31, v29, v0[2]
mla.4h	v31, v30, v0[3]
ext.16b	v28, v27, v27, #2
ext.16b	v29, v27, v27, #4
ext.16b	v30, v27, v27, #6
mul.4h	v27, v27, v0[0]
mla.4h	v27, v28, v0[1]
mla.4h	v27, v29, v0[2]
mla.4h	v27, v30, v0[3]
srshr.4h	v28, v31, #2
srshr.4h	v29, v27, #2
ret
b.gt	prep_6tap_neon
add	x6, x6, #2
ld1.8b	{ v0 }, [x5]
ld1.s	{ v1 }[0], [x6]
sub	x1, x1, #3
sub	x1, x1, x2
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	prep_6tap_neon
bl	prep_6tap_neon
mov.16b	v17, v24
mov.16b	v18, v25
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
smlal.4s	v4, v24, v1[2]
smlal2.4s	v5, v24, v1[2]
smlal.4s	v2, v24, v1[3]
smlal2.4s	v3, v24, v1[3]
smlal.4s	v4, v25, v1[3]
smlal2.4s	v5, v25, v1[3]
sqrshrn.4h	v2, v2, #6
sqrshrn2.8h	v2, v3, #6
sqrshrn.4h	v4, v4, #6
sqrshrn2.8h	v4, v5, #6
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x7
st1.8h	{ v4 }, [x8], x7
b.le	prep_6tap_neon
mov.16b	v16, v18
mov.16b	v17, v24
mov.16b	v18, v25
b	prep_6tap_neon
subs	w3, w3, #8
b.le	prep_6tap_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
b	prep_6tap_neon
ld1.8b	{ v0 }, [x5]
ld1.8b	{ v1 }, [x6]
sub	x1, x1, #3
sub	x1, x1, x2, lsl #1
sshll.8h	v0, v0, #0
sshll.8h	v1, v1, #0
mov	x15, x30
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	prep_6tap_neon
mov.16b	v18, v16
bl	prep_6tap_neon
mov.16b	v19, v24
mov.16b	v20, v25
bl	prep_6tap_neon
mov.16b	v21, v24
mov.16b	v22, v25
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
smlal.4s	v4, v24, v1[5]
smlal2.4s	v5, v24, v1[5]
smlal.4s	v2, v24, v1[6]
smlal2.4s	v3, v24, v1[6]
smlal.4s	v4, v25, v1[6]
smlal2.4s	v5, v25, v1[6]
sqrshrn.4h	v2, v2, #6
sqrshrn2.8h	v2, v3, #6
sqrshrn.4h	v4, v4, #6
sqrshrn2.8h	v4, v5, #6
subs	w4, w4, #2
st1.8h	{ v2 }, [x0], x7
st1.8h	{ v4 }, [x8], x7
b.le	prep_6tap_neon
mov.16b	v18, v20
mov.16b	v19, v21
mov.16b	v20, v22
mov.16b	v21, v24
mov.16b	v22, v25
b	prep_6tap_neon
subs	w3, w3, #8
b.le	prep_6tap_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
add	x1, x1, x2, lsl #1
b	prep_6tap_neon
ret	x15
ld1.8b	{ v28, v29 }, [x1], x2
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
ext.16b	v24, v28, v29, #2
ext.16b	v25, v28, v29, #4
ext.16b	v26, v28, v29, #6
ext.16b	v27, v28, v29, #8
mul.8h	v16, v24, v0[1]
mla.8h	v16, v25, v0[2]
mla.8h	v16, v26, v0[3]
mla.8h	v16, v27, v0[4]
ext.16b	v24, v28, v29, #10
ext.16b	v25, v28, v29, #12
ext.16b	v26, v28, v29, #14
mla.8h	v16, v24, v0[5]
mla.8h	v16, v25, v0[6]
srshr.8h	v16, v16, #2
ret
ld1.8b	{ v28, v29 }, [x9], x2
ld1.8b	{ v30, v31 }, [x1], x2
ushll.8h	v28, v28, #0
ushll.8h	v29, v29, #0
ushll.8h	v30, v30, #0
ushll.8h	v31, v31, #0
ext.16b	v26, v28, v29, #2
ext.16b	v27, v30, v31, #2
mul.8h	v24, v26, v0[1]
mul.8h	v25, v27, v0[1]
ext.16b	v26, v28, v29, #4
ext.16b	v27, v30, v31, #4
mla.8h	v24, v26, v0[2]
mla.8h	v25, v27, v0[2]
ext.16b	v26, v28, v29, #6
ext.16b	v27, v30, v31, #6
mla.8h	v24, v26, v0[3]
mla.8h	v25, v27, v0[3]
ext.16b	v26, v28, v29, #8
ext.16b	v27, v30, v31, #8
mla.8h	v24, v26, v0[4]
mla.8h	v25, v27, v0[4]
ext.16b	v26, v28, v29, #10
ext.16b	v27, v30, v31, #10
mla.8h	v24, v26, v0[5]
mla.8h	v25, v27, v0[5]
ext.16b	v26, v28, v29, #12
ext.16b	v27, v30, v31, #12
mla.8h	v24, v26, v0[6]
mla.8h	v25, v27, v0[6]
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
ret
<unknown>
<unknown>
add	z20.s, z22.s, z12.s
udf	#1196
_prep_bilin_8bpc_neon:
dup.16b	v1, w5
dup.16b	v3, w6
mov	w9, #16
sub	w8, w9, w5
sub	w9, w9, w6
dup.16b	v0, w8
dup.16b	v2, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
sub	w8, w8, #24
cbnz	w5, prep_bilin_8bpc_neon
cbnz	w6, prep_bilin_8bpc_neon
b	prep_neon
cbnz	w6, prep_bilin_8bpc_neon
adr	x9, #296
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
ld1.8b	{ v4 }, [x1], x2
ld1.8b	{ v6 }, [x9], x2
ext.8b	v5, v4, v4, #1
ext.8b	v7, v6, v6, #1
trn1.2s	v4, v4, v6
trn1.2s	v5, v5, v7
subs	w4, w4, #2
umull.8h	v4, v4, v0
umlal.8h	v4, v5, v1
st1.d	{ v4 }[0], [x0], x7
st1.d	{ v4 }[1], [x8], x7
b.gt	prep_bilin_8bpc_neon
ret
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
ld1.16b	{ v4 }, [x1], x2
ld1.16b	{ v6 }, [x9], x2
ext.16b	v5, v4, v4, #1
ext.16b	v7, v6, v6, #1
subs	w4, w4, #2
umull.8h	v4, v4, v0
umull.8h	v6, v6, v0
umlal.8h	v4, v5, v1
umlal.8h	v6, v7, v1
st1.8h	{ v4 }, [x0], x7
st1.8h	{ v6 }, [x8], x7
b.gt	prep_bilin_8bpc_neon
ret
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sub	x2, x2, w3, uxtw
sub	x2, x2, #8
ld1.d	{ v16 }[1], [x1], #8
ld1.d	{ v20 }[1], [x9], #8
mov	w5, w3
ld1.16b	{ v18 }, [x1], #16
ld1.16b	{ v22 }, [x9], #16
ext.16b	v17, v16, v18, #8
ext.16b	v19, v16, v18, #9
ext.16b	v21, v20, v22, #8
ext.16b	v23, v20, v22, #9
umull.8h	v16, v17, v0
umull2.8h	v17, v17, v0
umull.8h	v20, v21, v0
umull2.8h	v21, v21, v0
umlal.8h	v16, v19, v1
umlal2.8h	v17, v19, v1
umlal.8h	v20, v23, v1
umlal2.8h	v21, v23, v1
subs	w5, w5, #16
st1.8h	{ v16, v17 }, [x0], #32
st1.8h	{ v20, v21 }, [x8], #32
b.le	prep_bilin_8bpc_neon
mov.16b	v16, v18
mov.16b	v20, v22
b	prep_bilin_8bpc_neon
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #2
b.gt	prep_bilin_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#280
cmp	w4, #4
adr	x9, #296
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.s	{ v16 }[0], [x1], x2
ld1.s	{ v17 }[0], [x9], x2
ld1.s	{ v18 }[0], [x1], x2
trn1.2s	v16, v16, v17
trn1.2s	v17, v17, v18
umull.8h	v4, v16, v2
umlal.8h	v4, v17, v3
subs	w4, w4, #2
st1.d	{ v4 }[0], [x0], x7
st1.d	{ v4 }[1], [x8], x7
b.le	prep_bilin_8bpc_neon
mov.8b	v16, v18
b	prep_bilin_8bpc_neon
ret
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.8b	{ v16 }, [x1], x2
ld1.8b	{ v17 }, [x9], x2
ld1.8b	{ v18 }, [x1], x2
umull.8h	v4, v16, v2
umull.8h	v5, v17, v2
umlal.8h	v4, v17, v3
umlal.8h	v5, v18, v3
subs	w4, w4, #2
st1.8h	{ v4 }, [x0], x7
st1.8h	{ v5 }, [x8], x7
b.le	prep_bilin_8bpc_neon
mov.8b	v16, v18
b	prep_bilin_8bpc_neon
ret
mov	w6, w4
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.16b	{ v16 }, [x1], x2
ld1.16b	{ v17 }, [x9], x2
ld1.16b	{ v18 }, [x1], x2
umull.8h	v4, v16, v2
umull2.8h	v5, v16, v2
umull.8h	v6, v17, v2
umull2.8h	v7, v17, v2
umlal.8h	v4, v17, v3
umlal2.8h	v5, v17, v3
umlal.8h	v6, v18, v3
umlal2.8h	v7, v18, v3
subs	w4, w4, #2
st1.8h	{ v4, v5 }, [x0], x7
st1.8h	{ v6, v7 }, [x8], x7
b.le	prep_bilin_8bpc_neon
mov.16b	v16, v18
b	prep_bilin_8bpc_neon
subs	w3, w3, #16
b.le	prep_bilin_8bpc_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #16
add	x0, x0, #32
b	prep_bilin_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#280
ushll.8h	v2, v2, #0
ushll.8h	v3, v3, #0
adr	x9, #288
ldrh	w8, [x9, x8, lsl #1]
sub	x9, x9, w8, uxtw
br	x9
add	x9, x1, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.8b	{ v28 }, [x1], x2
ext.8b	v29, v28, v28, #1
umull.8h	v16, v28, v0
umlal.8h	v16, v29, v1
ld1.8b	{ v28 }, [x9], x2
ld1.8b	{ v30 }, [x1], x2
ext.8b	v29, v28, v28, #1
ext.8b	v31, v30, v30, #1
trn1.2s	v28, v28, v30
trn1.2s	v29, v29, v31
umull.8h	v17, v28, v0
umlal.8h	v17, v29, v1
trn1.2d	v16, v16, v17
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
subs	w4, w4, #2
urshr.8h	v4, v4, #4
st1.d	{ v4 }[0], [x0], x7
st1.d	{ v4 }[1], [x8], x7
b.le	prep_bilin_8bpc_neon
trn2.2d	v16, v17, v17
b	prep_bilin_8bpc_neon
ret
mov	w6, w4
add	x9, x1, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1.16b	{ v28 }, [x1], x2
ext.16b	v29, v28, v28, #1
umull.8h	v16, v28, v0
umlal.8h	v16, v29, v1
ld1.16b	{ v28 }, [x9], x2
ld1.16b	{ v30 }, [x1], x2
ext.16b	v29, v28, v28, #1
ext.16b	v31, v30, v30, #1
umull.8h	v17, v28, v0
umlal.8h	v17, v29, v1
umull.8h	v18, v30, v0
umlal.8h	v18, v31, v1
mul.8h	v4, v16, v2
mla.8h	v4, v17, v3
mul.8h	v5, v17, v2
mla.8h	v5, v18, v3
subs	w4, w4, #2
urshr.8h	v4, v4, #4
urshr.8h	v5, v5, #4
st1.8h	{ v4 }, [x0], x7
st1.8h	{ v5 }, [x8], x7
b.le	prep_bilin_8bpc_neon
mov.16b	v16, v18
b	prep_bilin_8bpc_neon
subs	w3, w3, #8
b.le	prep_bilin_8bpc_neon
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #8
add	x0, x0, #16
b	prep_bilin_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
udf	#272
_warp_filter_horz_neon:
add	w12, w5, #512
ld1.8b	{ v16, v17 }, [x2], x3
asr	w13, w12, #10
add	w12, w12, w7
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d2, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d3, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d4, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d5, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d6, [x11, w13, sxtw #3]
eor.8b	v16, v16, v22
eor.8b	v17, v17, v22
asr	w13, w12, #10
add	w12, w12, w7
ldr	d7, [x11, w13, sxtw #3]
ext.8b	v18, v16, v17, #1
ext.8b	v19, v16, v17, #2
smull.8h	v0, v0, v16
smull.8h	v1, v1, v18
ext.8b	v18, v16, v17, #3
ext.8b	v20, v16, v17, #4
smull.8h	v2, v2, v19
smull.8h	v3, v3, v18
ext.8b	v18, v16, v17, #5
ext.8b	v19, v16, v17, #6
smull.8h	v4, v4, v20
smull.8h	v5, v5, v18
ext.8b	v18, v16, v17, #7
smull.8h	v6, v6, v19
smull.8h	v7, v7, v18
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
addp.8h	v0, v0, v2
addp.8h	v4, v4, v6
addp.8h	v0, v0, v4
add	w5, w5, w8
ret
_warp_affine_8x8_8bpc_neon:
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #3
adrp	x11, warp_affine_8x8_8bpc_neon
add	x11, x11, #0
mov	x15, x30
movi.8b	v22, #128
movi.8h	v23, #128
bl	warp_filter_horz_neon
srshr.8h	v24, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v25, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v26, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v27, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v28, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v29, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v30, v0, #3
add	w14, w6, #512
bl	warp_filter_horz_neon
srshr.8h	v31, v0, #3
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
sqrshrn.4h	v16, v16, #11
mov.16b	v26, v27
sqrshrn2.8h	v16, v17, #11
mov.16b	v27, v28
mov.16b	v28, v29
add.8h	v16, v16, v23
sqxtun.8b	v16, v16
mov.16b	v29, v30
mov.16b	v30, v31
subs	w10, w10, #1
st1.8b	{ v16 }, [x0], x1
add	w6, w6, w4
b.gt	warp_affine_8x8_8bpc_neon
ret	x15
_warp_affine_8x8t_8bpc_neon:
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #3
adrp	x11, warp_affine_8x8t_8bpc_neon
add	x11, x11, #0
mov	x15, x30
lsl	x1, x1, #1
movi.8b	v22, #128
movi.8h	v23, #8, lsl #8
bl	warp_filter_horz_neon
srshr.8h	v24, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v25, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v26, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v27, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v28, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v29, v0, #3
bl	warp_filter_horz_neon
srshr.8h	v30, v0, #3
add	w14, w6, #512
bl	warp_filter_horz_neon
srshr.8h	v31, v0, #3
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
sqrshrn.4h	v16, v16, #7
mov.16b	v26, v27
sqrshrn2.8h	v16, v17, #7
mov.16b	v27, v28
mov.16b	v28, v29
add.8h	v16, v16, v23
mov.16b	v29, v30
mov.16b	v30, v31
subs	w10, w10, #1
st1.8h	{ v16 }, [x0], x1
add	w6, w6, w4
b.gt	warp_affine_8x8t_8bpc_neon
ret	x15
_emu_edge_8bpc_neon:
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
add	x8, x8, x13
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
cbz	x4, emu_edge_8bpc_neon
cbz	x11, emu_edge_8bpc_neon
ld1r.16b	{ v0 }, [x8]
mov	x12, x6
mov	x3, x4
subs	x3, x3, #16
st1.16b	{ v0 }, [x12], #16
b.gt	emu_edge_8bpc_neon
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
ld1.16b	{ v0, v1 }, [x13], #32
subs	x3, x3, #32
st1.16b	{ v0, v1 }, [x12], #32
b.gt	emu_edge_8bpc_neon
add	x3, x8, x2
sub	x3, x3, #1
add	x12, x6, x4
ld1r.16b	{ v0 }, [x3]
add	x12, x12, x2
mov	x3, x11
subs	x3, x3, #16
st1.16b	{ v0 }, [x12], #16
b.gt	emu_edge_8bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_8bpc_neon
b	emu_edge_8bpc_neon
cbz	x11, emu_edge_8bpc_neon
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
ld1.16b	{ v0, v1 }, [x13], #32
subs	x3, x3, #32
st1.16b	{ v0, v1 }, [x12], #32
b.gt	emu_edge_8bpc_neon
add	x3, x8, x2
sub	x3, x3, #1
add	x12, x6, x4
ld1r.16b	{ v0 }, [x3]
add	x12, x12, x2
mov	x3, x11
subs	x3, x3, #16
st1.16b	{ v0 }, [x12], #16
b.gt	emu_edge_8bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_8bpc_neon
b	emu_edge_8bpc_neon
ld1r.16b	{ v0 }, [x8]
mov	x12, x6
mov	x3, x4
subs	x3, x3, #16
st1.16b	{ v0 }, [x12], #16
b.gt	emu_edge_8bpc_neon
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
ld1.16b	{ v0, v1 }, [x13], #32
subs	x3, x3, #32
st1.16b	{ v0, v1 }, [x12], #32
b.gt	emu_edge_8bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_8bpc_neon
b	emu_edge_8bpc_neon
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
ld1.16b	{ v0, v1 }, [x13], #32
subs	x3, x3, #32
st1.16b	{ v0, v1 }, [x12], #32
b.gt	emu_edge_8bpc_neon
subs	x1, x1, #1
add	x6, x6, x7
add	x8, x8, x9
b.gt	emu_edge_8bpc_neon
cbz	x10, emu_edge_8bpc_neon
sub	x8, x6, x7
mov	x4, x0
ld1.16b	{ v0, v1 }, [x8], #32
mov	x3, x10
subs	x3, x3, #1
st1.16b	{ v0, v1 }, [x6], x7
b.gt	emu_edge_8bpc_neon
msub	x6, x7, x10, x6
subs	x4, x4, #32
add	x6, x6, #32
b.gt	emu_edge_8bpc_neon
cbz	x5, emu_edge_8bpc_neon
msub	x6, x7, x5, x14
ld1.16b	{ v0, v1 }, [x14], #32
mov	x3, x5
subs	x3, x3, #1
st1.16b	{ v0, v1 }, [x6], x7
b.gt	emu_edge_8bpc_neon
msub	x6, x7, x5, x6
subs	x0, x0, #32
add	x6, x6, #32
b.gt	emu_edge_8bpc_neon
ret