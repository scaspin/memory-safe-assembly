	.text
avg_8bpc_neon:
clz	w4, w4
adrp	x7, avg_tbl
add	x7, x7, :lo12:avg_tbl
sub	w4, w4, #0x18
ldrsw	x4, [x7, x4, lsl #2]
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
add	x7, x7, x4
br	x7
L_34:
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
b.eq	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
cmp	w5, #0x8
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
b.eq	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
ret
L_d8:
add	x7, x0, x1
lsl	x1, x1, #1
L_e0:
st1	{ v4.8b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v5.d }[1], [x7], x1
b.le	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	L_e0
L_12c:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
st1	{ v4.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
st1	{ v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
st1	{ v6.16b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v7.16b }, [x0], x1
b.le	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	L_12c
L_1a8:
add	x7, x0, x1
lsl	x1, x1, #1
L_1b0:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
st1	{ v4.16b, v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
subs	w5, w5, #0x2
st1	{ v6.16b, v7.16b }, [x7], x1
b.le	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	L_1b0
L_224:
add	x7, x0, x1
lsl	x1, x1, #1
L_22c:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v16.8b, v0.8h, #0x5
sqrshrun2	v16.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v17.8b, v0.8h, #0x5
sqrshrun2	v17.16b, v1.8h, #0x5
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v18.8b, v0.8h, #0x5
sqrshrun2	v18.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v19.8b, v0.8h, #0x5
sqrshrun2	v19.16b, v1.8h, #0x5
subs	w5, w5, #0x2
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	L_22c
L_300:
add	x7, x0, #0x40
L_304:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v16.8b, v0.8h, #0x5
sqrshrun2	v16.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v17.8b, v0.8h, #0x5
sqrshrun2	v17.16b, v1.8h, #0x5
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v18.8b, v0.8h, #0x5
sqrshrun2	v18.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v19.8b, v0.8h, #0x5
sqrshrun2	v19.16b, v1.8h, #0x5
subs	w5, w5, #0x1
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	L_3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	L_304
L_3d8:
ret
w_avg_8bpc_neon:
clz	w4, w4
dup	v30.8h, w6
neg	v30.8h, v30.8h
shl	v30.8h, v30.8h, #0xb
adrp	x7, w_avg_tbl
add	x7, x7, :lo12:w_avg_tbl
sub	w4, w4, #0x18
ldrsw	x4, [x7, x4, lsl #2]
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
add	x7, x7, x4
br	x7
L_42c:
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
b.eq	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
cmp	w5, #0x8
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
b.eq	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
ret
L_500:
add	x7, x0, x1
lsl	x1, x1, #1
L_508:
st1	{ v4.8b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v5.d }[1], [x7], x1
b.le	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_508
L_574:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
st1	{ v6.16b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v7.16b }, [x0], x1
b.le	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_574
L_630:
add	x7, x0, x1
lsl	x1, x1, #1
L_638:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v6.16b, v7.16b }, [x7], x1
b.le	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_638
L_6ec:
add	x7, x0, x1
lsl	x1, x1, #1
L_6f4:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_6f4
L_848:
add	x7, x0, #0x40
L_84c:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x1
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	L_9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_84c
L_9a0:
ret
mask_8bpc_neon:
clz	w4, w4
movi	v31.16b, #0xfe
adrp	x7, mask_tbl
add	x7, x7, :lo12:mask_tbl
sub	w4, w4, #0x18
ldrsw	x4, [x7, x4, lsl #2]
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
add	x7, x7, x4
br	x7
L_9fc:
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
b.eq	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
cmp	w5, #0x8
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
b.eq	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
ret
L_b00:
add	x7, x0, x1
lsl	x1, x1, #1
L_b08:
st1	{ v4.8b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v5.d }[1], [x7], x1
b.le	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_b08
L_b94:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v5.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
st1	{ v6.16b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v7.16b }, [x0], x1
b.le	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_b94
L_c90:
add	x7, x0, x1
lsl	x1, x1, #1
L_c98:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v6.16b, v7.16b }, [x7], x1
b.le	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_c98
L_d8c:
add	x7, x0, x1
lsl	x1, x1, #1
L_d94:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_d94
L_f68:
add	x7, x0, #0x40
L_f6c:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x1
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	L_1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	L_f6c
L_1140:
ret
w_mask_444_8bpc_neon:
clz	w8, w4
adrp	x9, w_mask_444_tbl
add	x9, x9, :lo12:w_mask_444_tbl
sub	w8, w8, #0x18
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
mov	w10, #0x1af7
dup	v0.8h, w10
movi	v1.16b, #0x40
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
L_1174:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
uzp1	v18.16b, v18.16b, v19.16b
sub	v18.16b, v1.16b, v18.16b
st1	{ v18.16b }, [x6], #16
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x12], x1
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x12], x1
b.gt	L_1174
ret
L_11e4:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
uzp1	v18.16b, v18.16b, v19.16b
sub	v18.16b, v1.16b, v18.16b
st1	{ v18.16b }, [x6], #16
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x12], x1
b.gt	L_11e4
ret
L_124c:
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x10, x6, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
L_1260:
mov	w8, w4
L_1264:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
ld1	{ v16.8h, v17.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
sub	v18.8h, v18.8h, v16.8h
sub	v19.8h, v19.8h, v17.8h
abs	v20.8h, v6.8h
abs	v21.8h, v7.8h
abs	v22.8h, v18.8h
abs	v23.8h, v19.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
ushr	v20.8h, v20.8h, #0x8
ushr	v21.8h, v21.8h, #0x8
ushr	v22.8h, v22.8h, #0x8
ushr	v23.8h, v23.8h, #0x8
shl	v24.8h, v20.8h, #0x9
shl	v25.8h, v21.8h, #0x9
shl	v26.8h, v22.8h, #0x9
shl	v27.8h, v23.8h, #0x9
sqdmulh	v24.8h, v24.8h, v6.8h
sqdmulh	v25.8h, v25.8h, v7.8h
sqdmulh	v26.8h, v26.8h, v18.8h
sqdmulh	v27.8h, v27.8h, v19.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v16.8h
add	v27.8h, v27.8h, v17.8h
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun	v25.8b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun	v27.8b, v27.8h, #0x4
uzp1	v20.16b, v20.16b, v21.16b
uzp1	v21.16b, v22.16b, v23.16b
sub	v20.16b, v1.16b, v20.16b
sub	v21.16b, v1.16b, v21.16b
st1	{ v20.16b }, [x6], #16
st1	{ v21.16b }, [x10], #16
st1	{ v24.8b, v25.8b }, [x0], #16
st1	{ v26.8b, v27.8b }, [x12], #16
b.gt	L_1264
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, w4, uxtw
add	x10, x10, w4, uxtw
add	x0, x0, x1
add	x12, x12, x1
b.gt	L_1260
ret
w_mask_422_8bpc_neon:
clz	w8, w4
adrp	x9, w_mask_422_tbl
add	x9, x9, :lo12:w_mask_422_tbl
sub	w8, w8, #0x18
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
mov	w10, #0x1af7
dup	v0.8h, w10
dup	v2.8b, w7
movi	v3.8b, #0x81
sub	v3.8b, v3.8b, v2.8b
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
L_1380:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
addp	v18.8h, v18.8h, v19.8h
xtn	v18.8b, v18.8h
uhsub	v18.8b, v3.8b, v18.8b
st1	{ v18.8b }, [x6], #8
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x12], x1
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x12], x1
b.gt	L_1380
ret
L_13f4:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
addp	v18.8h, v18.8h, v19.8h
xtn	v18.8b, v18.8h
uhsub	v18.8b, v3.8b, v18.8b
st1	{ v18.8b }, [x6], #8
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x12], x1
b.gt	L_13f4
ret
L_1460:
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x10, x6, x11, lsr #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
L_1474:
mov	w8, w4
L_1478:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
ld1	{ v16.8h, v17.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
sub	v18.8h, v18.8h, v16.8h
sub	v19.8h, v19.8h, v17.8h
abs	v20.8h, v6.8h
abs	v21.8h, v7.8h
abs	v22.8h, v18.8h
abs	v23.8h, v19.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
ushr	v20.8h, v20.8h, #0x8
ushr	v21.8h, v21.8h, #0x8
ushr	v22.8h, v22.8h, #0x8
ushr	v23.8h, v23.8h, #0x8
shl	v24.8h, v20.8h, #0x9
shl	v25.8h, v21.8h, #0x9
shl	v26.8h, v22.8h, #0x9
shl	v27.8h, v23.8h, #0x9
sqdmulh	v24.8h, v24.8h, v6.8h
sqdmulh	v25.8h, v25.8h, v7.8h
sqdmulh	v26.8h, v26.8h, v18.8h
sqdmulh	v27.8h, v27.8h, v19.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v16.8h
add	v27.8h, v27.8h, v17.8h
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun	v25.8b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun	v27.8b, v27.8h, #0x4
addp	v20.8h, v20.8h, v21.8h
addp	v21.8h, v22.8h, v23.8h
xtn	v20.8b, v20.8h
xtn	v21.8b, v21.8h
uhsub	v20.8b, v3.8b, v20.8b
uhsub	v21.8b, v3.8b, v21.8b
st1	{ v20.8b }, [x6], #8
st1	{ v21.8b }, [x10], #8
st1	{ v24.8b, v25.8b }, [x0], #16
st1	{ v26.8b, v27.8b }, [x12], #16
b.gt	L_1478
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, x11, lsr #1
add	x10, x10, x11, lsr #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	L_1474
ret
w_mask_420_8bpc_neon:
clz	w8, w4
adrp	x9, w_mask_420_tbl
add	x9, x9, :lo12:w_mask_420_tbl
sub	w8, w8, #0x18
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
mov	w10, #0x1af7
dup	v0.8h, w10
dup	v2.8h, w7
movi	v3.8h, #0x1, lsl #8
sub	v3.8h, v3.8h, v2.8h
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
L_159c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
trn1	v24.2d, v18.2d, v19.2d
trn2	v25.2d, v18.2d, v19.2d
add	v24.8h, v24.8h, v25.8h
addp	v18.8h, v24.8h, v24.8h
sub	v18.4h, v3.4h, v18.4h
rshrn	v18.8b, v18.8h, #0x2
str	s18, [x6], #0x4
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x12], x1
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x12], x1
b.gt	L_159c
ret
L_161c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
add	v18.8h, v18.8h, v19.8h
addp	v18.8h, v18.8h, v18.8h
sub	v18.4h, v3.4h, v18.4h
rshrn	v18.8b, v18.8h, #0x2
str	s18, [x6], #0x4
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x12], x1
b.gt	L_161c
ret
L_168c:
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
L_169c:
mov	w8, w4
L_16a0:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
ld1	{ v16.8h, v17.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
sub	v18.8h, v18.8h, v16.8h
sub	v19.8h, v19.8h, v17.8h
abs	v20.8h, v6.8h
abs	v21.8h, v7.8h
abs	v22.8h, v18.8h
abs	v23.8h, v19.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
ushr	v20.8h, v20.8h, #0x8
ushr	v21.8h, v21.8h, #0x8
ushr	v22.8h, v22.8h, #0x8
ushr	v23.8h, v23.8h, #0x8
shl	v24.8h, v20.8h, #0x9
shl	v25.8h, v21.8h, #0x9
shl	v26.8h, v22.8h, #0x9
shl	v27.8h, v23.8h, #0x9
sqdmulh	v24.8h, v24.8h, v6.8h
sqdmulh	v25.8h, v25.8h, v7.8h
sqdmulh	v26.8h, v26.8h, v18.8h
sqdmulh	v27.8h, v27.8h, v19.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v16.8h
add	v27.8h, v27.8h, v17.8h
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun	v25.8b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun	v27.8b, v27.8h, #0x4
add	v20.8h, v20.8h, v22.8h
add	v21.8h, v21.8h, v23.8h
addp	v20.8h, v20.8h, v21.8h
sub	v20.8h, v3.8h, v20.8h
rshrn	v20.8b, v20.8h, #0x2
st1	{ v20.8b }, [x6], #8
st1	{ v24.8b, v25.8b }, [x0], #16
st1	{ v26.8b, v27.8b }, [x12], #16
b.gt	L_16a0
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	L_169c
ret
blend_8bpc_neon:
adrp	x6, blend_tbl
add	x6, x6, :lo12:blend_tbl
clz	w3, w3
sub	w3, w3, #0x1a
ldrsw	x3, [x6, x3, lsl #2]
add	x6, x6, x3
movi	v4.16b, #0x40
add	x8, x0, x1
lsl	x1, x1, #1
br	x6
L_17a4:
ld1	{ v2.8b }, [x5], #8
ldr	d1, [x2], #0x8
ldr	s0, [x0]
subs	w4, w4, #0x2
ld1	{ v0.s }[1], [x8]
sub	v3.8b, v4.8b, v2.8b
umull	v5.8h, v1.8b, v2.8b
umlal	v5.8h, v0.8b, v3.8b
rshrn	v6.8b, v5.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.gt	L_17a4
ret
L_17d8:
ld1	{ v2.16b }, [x5], #16
ld1	{ v1.16b }, [x2], #16
ldr	d0, [x0]
ld1	{ v0.d }[1], [x8]
sub	v3.16b, v4.16b, v2.16b
subs	w4, w4, #0x2
umull	v5.8h, v1.8b, v2.8b
umlal	v5.8h, v0.8b, v3.8b
umull2	v6.8h, v1.16b, v2.16b
umlal2	v6.8h, v0.16b, v3.16b
rshrn	v7.8b, v5.8h, #0x6
rshrn	v16.8b, v6.8h, #0x6
st1	{ v7.8b }, [x0], x1
st1	{ v16.8b }, [x8], x1
b.gt	L_17d8
ret
L_1818:
ld1	{ v1.16b, v2.16b }, [x5], #32
ld1	{ v5.16b, v6.16b }, [x2], #32
ld1	{ v0.16b }, [x0]
subs	w4, w4, #0x2
sub	v7.16b, v4.16b, v1.16b
sub	v20.16b, v4.16b, v2.16b
ld1	{ v3.16b }, [x8]
umull	v16.8h, v5.8b, v1.8b
umlal	v16.8h, v0.8b, v7.8b
umull2	v17.8h, v5.16b, v1.16b
umlal2	v17.8h, v0.16b, v7.16b
umull	v21.8h, v6.8b, v2.8b
umlal	v21.8h, v3.8b, v20.8b
umull2	v22.8h, v6.16b, v2.16b
umlal2	v22.8h, v3.16b, v20.16b
rshrn	v18.8b, v16.8h, #0x6
rshrn2	v18.16b, v17.8h, #0x6
rshrn	v19.8b, v21.8h, #0x6
rshrn2	v19.16b, v22.8h, #0x6
st1	{ v18.16b }, [x0], x1
st1	{ v19.16b }, [x8], x1
b.gt	L_1818
ret
L_1874:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
ld1	{ v20.16b, v21.16b }, [x0]
subs	w4, w4, #0x2
ld1	{ v22.16b, v23.16b }, [x8]
sub	v5.16b, v4.16b, v0.16b
sub	v6.16b, v4.16b, v1.16b
sub	v30.16b, v4.16b, v2.16b
sub	v31.16b, v4.16b, v3.16b
umull	v24.8h, v16.8b, v0.8b
umlal	v24.8h, v20.8b, v5.8b
umull2	v26.8h, v16.16b, v0.16b
umlal2	v26.8h, v20.16b, v5.16b
umull	v28.8h, v17.8b, v1.8b
umlal	v28.8h, v21.8b, v6.8b
umull2	v7.8h, v17.16b, v1.16b
umlal2	v7.8h, v21.16b, v6.16b
umull	v27.8h, v18.8b, v2.8b
umlal	v27.8h, v22.8b, v30.8b
umull2	v1.8h, v18.16b, v2.16b
umlal2	v1.8h, v22.16b, v30.16b
umull	v29.8h, v19.8b, v3.8b
umlal	v29.8h, v23.8b, v31.8b
umull2	v21.8h, v19.16b, v3.16b
umlal2	v21.8h, v23.16b, v31.16b
rshrn	v24.8b, v24.8h, #0x6
rshrn2	v24.16b, v26.8h, #0x6
rshrn	v25.8b, v28.8h, #0x6
rshrn2	v25.16b, v7.8h, #0x6
rshrn	v27.8b, v27.8h, #0x6
rshrn2	v27.16b, v1.8h, #0x6
rshrn	v28.8b, v29.8h, #0x6
rshrn2	v28.16b, v21.8h, #0x6
st1	{ v24.16b, v25.16b }, [x0], x1
st1	{ v27.16b, v28.16b }, [x8], x1
b.gt	L_1874
ret
blend_h_8bpc_neon:
adrp	x6, blend_h_tbl
add	x6, x6, :lo12:blend_h_tbl
adrp	x5, obmc_masks
add	x5, x5, :lo12:obmc_masks
add	x5, x5, w4, uxtw
sub	w4, w4, w4, lsr #2
clz	w7, w3
movi	v4.16b, #0x40
add	x8, x0, x1
lsl	x1, x1, #1
sub	w7, w7, #0x18
ldrsw	x7, [x6, x7, lsl #2]
add	x6, x6, x7
br	x6
L_1940:
ldr	h0, [x5], #0x2
ldr	s1, [x2], #0x4
subs	w4, w4, #0x2
ldr	h2, [x0]
zip1	v0.8b, v0.8b, v0.8b
sub	v3.8b, v4.8b, v0.8b
ld1	{ v2.h }[1], [x8]
umull	v5.8h, v1.8b, v0.8b
umlal	v5.8h, v2.8b, v3.8b
rshrn	v5.8b, v5.8h, #0x6
st1	{ v5.h }[0], [x0], x1
st1	{ v5.h }[1], [x8], x1
b.gt	L_1940
ret
L_1978:
ld2r	{ v0.8b, v1.8b }, [x5], #2
ld1	{ v2.8b }, [x2], #8
subs	w4, w4, #0x2
ext	v0.8b, v0.8b, v1.8b, #0x4
ldr	s3, [x0]
sub	v5.8b, v4.8b, v0.8b
ld1	{ v3.s }[1], [x8]
umull	v6.8h, v2.8b, v0.8b
umlal	v6.8h, v3.8b, v5.8b
rshrn	v6.8b, v6.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.gt	L_1978
ret
L_19b0:
ld2r	{ v0.16b, v1.16b }, [x5], #2
ld1	{ v2.16b }, [x2], #16
ldr	d3, [x0]
ext	v0.16b, v0.16b, v1.16b, #0x8
sub	v5.16b, v4.16b, v0.16b
ld1	{ v3.d }[1], [x8]
subs	w4, w4, #0x2
umull	v6.8h, v0.8b, v2.8b
umlal	v6.8h, v3.8b, v5.8b
umull2	v7.8h, v0.16b, v2.16b
umlal2	v7.8h, v3.16b, v5.16b
rshrn	v16.8b, v6.8h, #0x6
rshrn	v17.8b, v7.8h, #0x6
st1	{ v16.8b }, [x0], x1
st1	{ v17.8b }, [x8], x1
b.gt	L_19b0
ret
L_19f4:
ld2r	{ v0.16b, v1.16b }, [x5], #2
ld1	{ v2.16b, v3.16b }, [x2], #32
ld1	{ v5.16b }, [x0]
sub	v7.16b, v4.16b, v0.16b
sub	v16.16b, v4.16b, v1.16b
ld1	{ v6.16b }, [x8]
subs	w4, w4, #0x2
umull	v17.8h, v0.8b, v2.8b
umlal	v17.8h, v5.8b, v7.8b
umull2	v18.8h, v0.16b, v2.16b
umlal2	v18.8h, v5.16b, v7.16b
umull	v19.8h, v1.8b, v3.8b
umlal	v19.8h, v6.8b, v16.8b
umull2	v20.8h, v1.16b, v3.16b
umlal2	v20.8h, v6.16b, v16.16b
rshrn	v21.8b, v17.8h, #0x6
rshrn2	v21.16b, v18.8h, #0x6
rshrn	v22.8b, v19.8h, #0x6
rshrn2	v22.16b, v20.8h, #0x6
st1	{ v21.16b }, [x0], x1
st1	{ v22.16b }, [x8], x1
b.gt	L_19f4
ret
L_1a50:
sub	x1, x1, w3, uxtw
add	x7, x2, w3, uxtw
L_1a58:
ld2r	{ v0.16b, v1.16b }, [x5], #2
mov	w6, w3
sub	v20.16b, v4.16b, v0.16b
sub	v21.16b, v4.16b, v1.16b
L_1a68:
ld1	{ v16.16b, v17.16b }, [x2], #32
ld1	{ v2.16b, v3.16b }, [x0]
subs	w6, w6, #0x20
umull	v23.8h, v0.8b, v16.8b
umlal	v23.8h, v2.8b, v20.8b
ld1	{ v18.16b, v19.16b }, [x7], #32
umull2	v27.8h, v0.16b, v16.16b
umlal2	v27.8h, v2.16b, v20.16b
ld1	{ v6.16b, v7.16b }, [x8]
umull	v24.8h, v0.8b, v17.8b
umlal	v24.8h, v3.8b, v20.8b
umull2	v28.8h, v0.16b, v17.16b
umlal2	v28.8h, v3.16b, v20.16b
umull	v25.8h, v1.8b, v18.8b
umlal	v25.8h, v6.8b, v21.8b
umull2	v5.8h, v1.16b, v18.16b
umlal2	v5.8h, v6.16b, v21.16b
rshrn	v29.8b, v23.8h, #0x6
rshrn2	v29.16b, v27.8h, #0x6
umull	v26.8h, v1.8b, v19.8b
umlal	v26.8h, v7.8b, v21.8b
umull2	v31.8h, v1.16b, v19.16b
umlal2	v31.8h, v7.16b, v21.16b
rshrn	v30.8b, v24.8h, #0x6
rshrn2	v30.16b, v28.8h, #0x6
rshrn	v23.8b, v25.8h, #0x6
rshrn2	v23.16b, v5.8h, #0x6
rshrn	v24.8b, v26.8h, #0x6
st1	{ v29.16b, v30.16b }, [x0], #32
rshrn2	v24.16b, v31.8h, #0x6
st1	{ v23.16b, v24.16b }, [x8], #32
b.gt	L_1a68
subs	w4, w4, #0x2
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, w3, uxtw
add	x7, x7, w3, uxtw
b.gt	L_1a58
ret
blend_v_8bpc_neon:
adrp	x6, blend_v_tbl
add	x6, x6, :lo12:blend_v_tbl
adrp	x5, obmc_masks
add	x5, x5, :lo12:obmc_masks
add	x5, x5, w3, uxtw
clz	w3, w3
movi	v4.16b, #0x40
add	x8, x0, x1
lsl	x1, x1, #1
sub	w3, w3, #0x1a
ldrsw	x3, [x6, x3, lsl #2]
add	x6, x6, x3
br	x6
L_1b38:
ld1r	{ v0.8b }, [x5]
sub	v1.8b, v4.8b, v0.8b
L_1b40:
ldr	h2, [x2], #0x2
ldr	b3, [x0]
subs	w4, w4, #0x2
ld1	{ v2.b }[1], [x2]
ld1	{ v3.b }[1], [x8]
umull	v5.8h, v2.8b, v0.8b
umlal	v5.8h, v3.8b, v1.8b
rshrn	v5.8b, v5.8h, #0x6
add	x2, x2, #0x2
st1	{ v5.b }[0], [x0], x1
st1	{ v5.b }[1], [x8], x1
b.gt	L_1b40
ret
L_1b74:
ld1r	{ v0.2s }, [x5]
sub	x1, x1, #0x2
sub	v1.8b, v4.8b, v0.8b
L_1b80:
ld1	{ v2.8b }, [x2], #8
ldr	s3, [x0]
ld1	{ v3.s }[1], [x8]
subs	w4, w4, #0x2
umull	v5.8h, v2.8b, v0.8b
umlal	v5.8h, v3.8b, v1.8b
rshrn	v5.8b, v5.8h, #0x6
str	h5, [x0], #0x2
st1	{ v5.h }[2], [x8], #2
st1	{ v5.b }[2], [x0], x1
st1	{ v5.b }[6], [x8], x1
b.gt	L_1b80
ret
L_1bb4:
ld1r	{ v0.2d }, [x5]
sub	x1, x1, #0x4
sub	v1.16b, v4.16b, v0.16b
zip2	v16.2d, v1.2d, v1.2d
L_1bc4:
ld1	{ v2.16b }, [x2], #16
ldr	d3, [x0]
ldr	d4, [x8]
subs	w4, w4, #0x2
umull	v5.8h, v0.8b, v2.8b
umlal	v5.8h, v3.8b, v1.8b
umull2	v6.8h, v0.16b, v2.16b
umlal	v6.8h, v4.8b, v16.8b
rshrn	v7.8b, v5.8h, #0x6
rshrn	v17.8b, v6.8h, #0x6
str	s7, [x0], #0x4
str	s17, [x8], #0x4
st1	{ v7.h }[2], [x0], x1
st1	{ v17.h }[2], [x8], x1
b.gt	L_1bc4
ret
L_1c04:
ld1	{ v0.16b }, [x5]
sub	x1, x1, #0x8
sub	v2.16b, v4.16b, v0.16b
L_1c10:
ld1	{ v5.16b, v6.16b }, [x2], #32
ld1	{ v7.16b }, [x0]
subs	w4, w4, #0x2
ld1	{ v16.16b }, [x8]
umull	v17.8h, v5.8b, v0.8b
umlal	v17.8h, v7.8b, v2.8b
umull2	v18.8h, v5.16b, v0.16b
umlal2	v18.8h, v7.16b, v2.16b
umull	v20.8h, v6.8b, v0.8b
umlal	v20.8h, v16.8b, v2.8b
umull2	v21.8h, v6.16b, v0.16b
umlal2	v21.8h, v16.16b, v2.16b
rshrn	v19.8b, v17.8h, #0x6
rshrn2	v19.16b, v18.8h, #0x6
rshrn	v22.8b, v20.8h, #0x6
rshrn2	v22.16b, v21.8h, #0x6
st1	{ v19.8b }, [x0], #8
st1	{ v22.8b }, [x8], #8
st1	{ v19.s }[2], [x0], x1
st1	{ v22.s }[2], [x8], x1
b.gt	L_1c10
ret
L_1c68:
ld1	{ v0.16b, v1.16b }, [x5]
sub	x1, x1, #0x10
sub	v2.16b, v4.16b, v0.16b
sub	v3.8b, v4.8b, v1.8b
L_1c78:
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
ld1	{ v5.16b, v6.16b }, [x0]
subs	w4, w4, #0x2
ld1	{ v20.16b, v21.16b }, [x8]
umull	v22.8h, v16.8b, v0.8b
umlal	v22.8h, v5.8b, v2.8b
umull2	v23.8h, v16.16b, v0.16b
umlal2	v23.8h, v5.16b, v2.16b
umull	v28.8h, v17.8b, v1.8b
umlal	v28.8h, v6.8b, v3.8b
umull	v30.8h, v18.8b, v0.8b
umlal	v30.8h, v20.8b, v2.8b
umull2	v31.8h, v18.16b, v0.16b
umlal2	v31.8h, v20.16b, v2.16b
umull	v25.8h, v19.8b, v1.8b
umlal	v25.8h, v21.8b, v3.8b
rshrn	v24.8b, v22.8h, #0x6
rshrn2	v24.16b, v23.8h, #0x6
rshrn	v28.8b, v28.8h, #0x6
rshrn	v30.8b, v30.8h, #0x6
rshrn2	v30.16b, v31.8h, #0x6
rshrn	v27.8b, v25.8h, #0x6
st1	{ v24.16b }, [x0], #16
st1	{ v30.16b }, [x8], #16
st1	{ v28.8b }, [x0], x1
st1	{ v27.8b }, [x8], x1
b.gt	L_1c78
ret
put_neon:
adrp	x9, put_tbl
add	x9, x9, :lo12:put_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_1cfc:
ldrh	w9, [x2]
ldrh	w10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
strh	w9, [x0]
strh	w10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_1cfc
ret
L_1d20:
ldr	w9, [x2]
ldr	w10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
str	w9, [x0]
str	w10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_1d20
ret
L_1d44:
ldr	x9, [x2]
ldr	x10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
str	x9, [x0]
str	x10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_1d44
ret
L_1d68:
ldr	q0, [x2]
ldr	q1, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
str	q0, [x0]
str	q1, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_1d68
ret
L_1d8c:
ldp	q0, q1, [x2]
add	x2, x2, x3
stp	q0, q1, [x0]
add	x0, x0, x1
ldp	q2, q3, [x2]
add	x2, x2, x3
stp	q2, q3, [x0]
subs	w5, w5, #0x2
add	x0, x0, x1
b.gt	L_1d8c
ret
L_1db8:
ldp	q0, q1, [x2]
stp	q0, q1, [x0]
ldp	q2, q3, [x2, #0x20]
add	x2, x2, x3
stp	q2, q3, [x0, #0x20]
subs	w5, w5, #0x1
add	x0, x0, x1
b.gt	L_1db8
ret
L_1ddc:
ldp	q0, q1, [x2]
stp	q0, q1, [x0]
ldp	q2, q3, [x2, #0x20]
stp	q2, q3, [x0, #0x20]
ldp	q4, q5, [x2, #0x40]
stp	q4, q5, [x0, #0x40]
ldp	q6, q7, [x2, #0x60]
add	x2, x2, x3
stp	q6, q7, [x0, #0x60]
subs	w5, w5, #0x1
add	x0, x0, x1
b.gt	L_1ddc
ret
prep_neon:
adrp	x9, prep_tbl
add	x9, x9, :lo12:prep_tbl
ldrsw	x8, [x9, x8, lsl #2]
movi	v24.16b, #0x10
add	x9, x9, x8
br	x9
L_1e28:
ldr	s0, [x1]
ldr	s2, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s1, [x1]
ldr	s3, [x1, x2]
add	x1, x1, x2, lsl #1
mov	v0.s[1], v2.s[0]
mov	v1.s[1], v3.s[0]
ushll	v0.8h, v0.8b, #0x4
ushll	v1.8h, v1.8b, #0x4
subs	w4, w4, #0x4
stp	q0, q1, [x0], #0x20
b.gt	L_1e28
ret
L_1e60:
ldr	d0, [x1]
ldr	d1, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d2, [x1]
ldr	d3, [x1, x2]
add	x1, x1, x2, lsl #1
ushll	v0.8h, v0.8b, #0x4
ushll	v1.8h, v1.8b, #0x4
umull	v2.8h, v2.8b, v24.8b
umull	v3.8h, v3.8b, v24.8b
subs	w4, w4, #0x4
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
add	x0, x0, #0x40
b.gt	L_1e60
ret
L_1ea0:
ldr	q1, [x1]
ldr	q3, [x1, x2]
add	x1, x1, x2, lsl #1
ushll	v0.8h, v1.8b, #0x4
ushll2	v1.8h, v1.16b, #0x4
ldr	q5, [x1]
ldr	q7, [x1, x2]
add	x1, x1, x2, lsl #1
umull	v2.8h, v3.8b, v24.8b
umull2	v3.8h, v3.16b, v24.16b
ushll	v4.8h, v5.8b, #0x4
ushll2	v5.8h, v5.16b, #0x4
umull	v6.8h, v7.8b, v24.8b
umull2	v7.8h, v7.16b, v24.16b
subs	w4, w4, #0x4
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, #0x80
b.gt	L_1ea0
ret
L_1ef8:
ldp	q4, q5, [x1]
add	x1, x1, x2
ldp	q6, q7, [x1]
add	x1, x1, x2
ushll	v0.8h, v4.8b, #0x4
ushll2	v1.8h, v4.16b, #0x4
umull	v2.8h, v5.8b, v24.8b
umull2	v3.8h, v5.16b, v24.16b
ushll	v4.8h, v6.8b, #0x4
ushll2	v5.8h, v6.16b, #0x4
umull	v6.8h, v7.8b, v24.8b
umull2	v7.8h, v7.16b, v24.16b
subs	w4, w4, #0x2
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, #0x80
b.gt	L_1ef8
ret
L_1f48:
ldp	q4, q5, [x1]
ldp	q6, q7, [x1, #0x20]
add	x1, x1, x2
ushll	v0.8h, v4.8b, #0x4
ushll2	v1.8h, v4.16b, #0x4
umull	v2.8h, v5.8b, v24.8b
umull2	v3.8h, v5.16b, v24.16b
ushll	v4.8h, v6.8b, #0x4
ushll2	v5.8h, v6.16b, #0x4
umull	v6.8h, v7.8b, v24.8b
umull2	v7.8h, v7.16b, v24.16b
subs	w4, w4, #0x1
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, #0x80
b.gt	L_1f48
ret
L_1f94:
ldp	q28, q29, [x1]
ldp	q30, q31, [x1, #0x20]
ushll	v16.8h, v28.8b, #0x4
ushll2	v17.8h, v28.16b, #0x4
umull	v18.8h, v29.8b, v24.8b
umull2	v19.8h, v29.16b, v24.16b
ushll	v20.8h, v30.8b, #0x4
ushll2	v21.8h, v30.16b, #0x4
umull	v22.8h, v31.8b, v24.8b
umull2	v23.8h, v31.16b, v24.16b
ldp	q28, q29, [x1, #0x40]
ldp	q30, q31, [x1, #0x60]
add	x1, x1, x2
stp	q16, q17, [x0]
stp	q18, q19, [x0, #0x20]
stp	q20, q21, [x0, #0x40]
stp	q22, q23, [x0, #0x60]
ushll	v16.8h, v28.8b, #0x4
ushll2	v17.8h, v28.16b, #0x4
umull	v18.8h, v29.8b, v24.8b
umull2	v19.8h, v29.16b, v24.16b
ushll	v20.8h, v30.8b, #0x4
ushll2	v21.8h, v30.16b, #0x4
umull	v22.8h, v31.8b, v24.8b
umull2	v23.8h, v31.16b, v24.16b
subs	w4, w4, #0x1
stp	q16, q17, [x0, #0x80]
stp	q18, q19, [x0, #0xa0]
stp	q20, q21, [x0, #0xc0]
stp	q22, q23, [x0, #0xe0]
add	x0, x0, #0x100
b.gt	L_1f94
ret
put_8tap_regular_sharp_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0xf2d
b	put_8tap_neon
put_8tap_smooth_sharp_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0xf2d
b	put_8tap_neon
put_8tap_sharp_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0xf2d
b	put_8tap_neon
put_8tap_sharp_regular_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x2d
b	put_8tap_neon
put_8tap_sharp_smooth_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x7bc
b	put_8tap_neon
put_8tap_neon:
mov	w10, #0x4081
mul	w6, w6, w10
mul	w7, w7, w10
add	w6, w6, w8
add	w7, w7, w9
clz	w8, w4
tst	w6, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	L_208c
tst	w7, #0x1fc000
b.ne	L_243c
b	put_neon
L_208c:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_20a0
mov	w6, w9
L_20a0:
tst	w7, #0x1fc000
add	x6, x10, w6, uxtw #3
b.ne	L_2e5c
adrp	x9, put_8tap_h_tbl
add	x9, x9, :lo12:put_8tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_20c0:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_20dc:
ld1	{ v4.8b }, [x2], x3
ld1	{ v6.8b }, [x9], x3
ushll	v4.8h, v4.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
subs	w5, w5, #0x2
trn1	v3.2s, v4.2s, v6.2s
trn2	v6.2s, v4.2s, v6.2s
trn1	v4.2s, v5.2s, v7.2s
trn2	v7.2s, v5.2s, v7.2s
mul	v3.4h, v3.4h, v0.h[0]
mla	v3.4h, v4.4h, v0.h[1]
mla	v3.4h, v6.4h, v0.h[2]
mla	v3.4h, v7.4h, v0.h[3]
srshr	v3.4h, v3.4h, #0x2
sqrshrun	v3.8b, v3.8h, #0x4
st1	{ v3.h }[0], [x0], x1
st1	{ v3.h }[1], [x8], x1
b.gt	L_20dc
ret
L_2130:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_214c:
ld1	{ v16.8b }, [x2], x3
ld1	{ v20.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w5, w5, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
sqrshrun	v16.8b, v16.8h, #0x4
sqrshrun	v20.8b, v20.8h, #0x4
str	s16, [x0]
str	s20, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.gt	L_214c
ret
L_21c0:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_21dc:
ld1	{ v16.8b, v17.8b }, [x2], x3
ld1	{ v20.8b, v21.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[0]
mul	v22.8h, v20.8h, v0.h[0]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[1]
mla	v22.8h, v23.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xc
ext	v23.16b, v20.16b, v21.16b, #0xc
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
ext	v19.16b, v16.16b, v17.16b, #0xe
ext	v23.16b, v20.16b, v21.16b, #0xe
mla	v18.8h, v19.8h, v0.h[7]
mla	v22.8h, v23.8h, v0.h[7]
subs	w5, w5, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
sqrshrun	v18.8b, v18.8h, #0x4
sqrshrun	v22.8b, v22.8h, #0x4
st1	{ v18.8b }, [x0], x1
st1	{ v22.8b }, [x8], x1
b.gt	L_21dc
ret
L_2290:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
sub	x3, x3, w4, uxtw
sub	x3, x3, #0x8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
L_22b8:
ld1	{ v16.8b, v17.8b, v18.8b }, [x2], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w6, w4
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_22dc:
mul	v24.8h, v16.8h, v0.h[0]
mul	v25.8h, v17.8h, v0.h[0]
mul	v26.8h, v20.8h, v0.h[0]
mul	v27.8h, v21.8h, v0.h[0]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[1]
mla	v25.8h, v29.8h, v0.h[1]
mla	v26.8h, v30.8h, v0.h[1]
mla	v27.8h, v31.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xc
ext	v29.16b, v17.16b, v18.16b, #0xc
ext	v30.16b, v20.16b, v21.16b, #0xc
ext	v31.16b, v21.16b, v22.16b, #0xc
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
ext	v28.16b, v16.16b, v17.16b, #0xe
ext	v29.16b, v17.16b, v18.16b, #0xe
ext	v30.16b, v20.16b, v21.16b, #0xe
ext	v31.16b, v21.16b, v22.16b, #0xe
mla	v24.8h, v28.8h, v0.h[7]
mla	v25.8h, v29.8h, v0.h[7]
mla	v26.8h, v30.8h, v0.h[7]
mla	v27.8h, v31.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w6, w6, #0x10
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun2	v24.16b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun2	v26.16b, v27.8h, #0x4
st1	{ v24.16b }, [x0], #16
st1	{ v26.16b }, [x8], #16
b.le	L_2420
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x2], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	L_22dc
L_2420:
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #0x2
b.gt	L_22b8
ret
L_243c:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_2450
mov	w7, w9
L_2450:
add	x7, x10, w7, uxtw #3
adrp	x9, put_8tap_v_tbl
add	x9, x9, :lo12:put_8tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_2468:
b.gt	L_253c
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
b.gt	L_24e4
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.4h, v1.4h, v0.h[0]
mla	v6.4h, v2.4h, v0.h[1]
mla	v6.4h, v3.4h, v0.h[2]
mla	v6.4h, v4.4h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
ret
L_24e4:
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
st1	{ v6.h }[2], [x0], x1
st1	{ v6.h }[3], [x8], x1
ret
L_253c:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
L_25ac:
subs	w5, w5, #0x4
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
ld1	{ v18.h }[0], [x9], x3
ld1	{ v19.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
trn1	v18.4h, v18.4h, v19.4h
trn1	v5.2s, v5.2s, v7.2s
trn1	v6.2s, v6.2s, v16.2s
trn1	v7.2s, v7.2s, v17.2s
trn1	v16.2s, v16.2s, v18.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.8h, v1.8h, v0.h[0]
mla	v30.8h, v2.8h, v0.h[1]
mla	v30.8h, v3.8h, v0.h[2]
mla	v30.8h, v4.8h, v0.h[3]
mla	v30.8h, v5.8h, v0.h[4]
mla	v30.8h, v6.8h, v0.h[5]
mla	v30.8h, v7.8h, v0.h[6]
mla	v30.8h, v16.8h, v0.h[7]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
st1	{ v30.h }[2], [x0], x1
st1	{ v30.h }[3], [x8], x1
b.le	L_269c
cmp	w5, #0x2
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
mov	v4.16b, v16.16b
mov	v5.16b, v17.16b
mov	v6.16b, v18.16b
mov	v7.16b, v19.16b
b.eq	L_2650
b	L_25ac
L_2650:
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.4h, v1.4h, v0.h[0]
mla	v30.4h, v2.4h, v0.h[1]
mla	v30.4h, v3.4h, v0.h[2]
mla	v30.4h, v4.4h, v0.h[3]
mla	v30.4h, v5.4h, v0.h[4]
mla	v30.4h, v6.4h, v0.h[5]
mla	v30.4h, v7.4h, v0.h[6]
mla	v30.4h, v16.4h, v0.h[7]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
L_269c:
ret
L_26a0:
b.gt	L_2750
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x9], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x9], x3
ld1	{ v5.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.le	L_274c
ld1	{ v6.s }[0], [x9], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v7.s }[0], [x0], x1
st1	{ v7.s }[1], [x8], x1
L_274c:
ret
L_2750:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x2], x3
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
L_27b8:
subs	w5, w5, #0x4
ld1	{ v23.s }[0], [x9], x3
ld1	{ v24.s }[0], [x2], x3
ld1	{ v25.s }[0], [x9], x3
ld1	{ v26.s }[0], [x2], x3
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v18.8h, v0.h[0]
mla	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
mla	v2.8h, v25.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	L_2970
ld1	{ v27.s }[0], [x9], x3
ld1	{ v16.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
b.le	L_2970
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v22.8h, v0.h[0]
mla	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
mla	v2.8h, v17.8h, v0.h[7]
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	L_2970
subs	w5, w5, #0x4
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v26.8h, v0.h[0]
mla	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
mla	v2.8h, v21.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.gt	L_27b8
L_2970:
ret
L_2974:
b.gt	L_2a38
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x2], x3
ld1	{ v2.8b }, [x9], x3
ld1	{ v3.8b }, [x2], x3
ld1	{ v4.8b }, [x9], x3
ld1	{ v5.8b }, [x2], x3
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v6.8b }, [x0], x1
st1	{ v7.8b }, [x8], x1
b.le	L_2a34
ld1	{ v6.8b }, [x9], x3
ld1	{ v7.8b }, [x2], x3
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
L_2a34:
ret
L_2a38:
ld1	{ v0.8b }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w7, w5
L_2a4c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8b }, [x2], x3
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_2a94:
subs	w5, w5, #0x2
ld1	{ v23.8b }, [x9], x3
ld1	{ v24.8b }, [x2], x3
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
mla	v2.8h, v24.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	L_2cfc
subs	w5, w5, #0x2
ld1	{ v25.8b }, [x9], x3
ld1	{ v26.8b }, [x2], x3
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v18.8h, v0.h[0]
mla	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mla	v3.8h, v25.8h, v0.h[7]
mul	v4.8h, v19.8h, v0.h[0]
mla	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
mla	v4.8h, v26.8h, v0.h[7]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_2cfc
subs	w5, w5, #0x2
ld1	{ v27.8b }, [x9], x3
ld1	{ v16.8b }, [x2], x3
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
mul	v2.8h, v21.8h, v0.h[0]
mla	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
mla	v2.8h, v16.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	L_2cfc
subs	w5, w5, #0x2
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v22.8h, v0.h[0]
mla	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mla	v3.8h, v17.8h, v0.h[7]
mul	v4.8h, v23.8h, v0.h[0]
mla	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
mla	v4.8h, v18.8h, v0.h[7]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_2cfc
subs	w5, w5, #0x4
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mla	v2.8h, v20.8h, v0.h[7]
mul	v3.8h, v26.8h, v0.h[0]
mla	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mla	v3.8h, v21.8h, v0.h[7]
mul	v4.8h, v27.8h, v0.h[0]
mla	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
mla	v4.8h, v22.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.gt	L_2a94
L_2cfc:
subs	w4, w4, #0x8
b.le	L_2d28
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	L_2a4c
L_2d28:
ret
L_2d2c:
b.gt	L_2a38
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w5, #0x2
ld1	{ v1.16b }, [x2], x3
ld1	{ v2.16b }, [x9], x3
ld1	{ v3.16b }, [x2], x3
ld1	{ v4.16b }, [x9], x3
ld1	{ v5.16b }, [x2], x3
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v16.8b, v16.8h, #0x6
sqrshrun2	v16.16b, v17.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v16.16b }, [x8], x1
b.le	L_2e58
ld1	{ v6.16b }, [x9], x3
ld1	{ v7.16b }, [x2], x3
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun2	v3.16b, v4.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v3.16b }, [x8], x1
L_2e58:
ret
L_2e5c:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_2e70
mov	w7, w9
L_2e70:
add	x7, x10, w7, uxtw #3
adrp	x9, put_8tap_hv_tbl
add	x9, x9, :lo12:put_8tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_2e88:
ldur	s0, [x6, #0x2]
b.gt	L_2f1c
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	L_2fe8
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
L_2ee0:
bl	L_2fe8
ext	v18.8b, v17.8b, v28.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	L_2fe4
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
b	L_2ee0
L_2f1c:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	L_2fe8
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
bl	L_2fe8
ext	v18.8b, v17.8b, v28.8b, #0x4
mov	v19.8b, v28.8b
bl	L_2fe8
ext	v20.8b, v19.8b, v28.8b, #0x4
mov	v21.8b, v28.8b
L_2f88:
bl	L_2fe8
ext	v22.8b, v21.8b, v28.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal	v2.4s, v28.4h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	L_2fe4
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
b	L_2f88
L_2fe4:
ret	x15
L_2fe8:
ld1	{ v28.8b }, [x9], x3
ld1	{ v30.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
ext	v31.16b, v30.16b, v30.16b, #0x2
trn1	v27.2s, v28.2s, v30.2s
trn2	v30.2s, v28.2s, v30.2s
trn1	v28.2s, v29.2s, v31.2s
trn2	v31.2s, v29.2s, v31.2s
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v30.4h, v0.h[2]
mla	v27.4h, v31.4h, v0.h[3]
srshr	v28.4h, v27.4h, #0x2
ret
L_3028:
ldur	s0, [x6, #0x2]
b.gt	L_30e4
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	L_31e8
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
L_3088:
bl	L_31e8
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	L_31e4
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	L_3088
L_30e4:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	L_31e8
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
bl	L_31e8
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	L_31e8
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
L_3158:
bl	L_31e8
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal	v2.4s, v28.4h, v1.h[7]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smlal	v3.4s, v21.4h, v1.h[4]
smlal	v3.4s, v22.4h, v1.h[5]
smlal	v3.4s, v28.4h, v1.h[6]
smlal	v3.4s, v29.4h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	L_31e4
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	L_3158
L_31e4:
ret	x15
L_31e8:
ld1	{ v26.8b }, [x9], x3
ld1	{ v27.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
L_323c:
b.gt	L_3328
ld1	{ v0.8b }, [x6]
ldur	s1, [x7, #0x2]
sub	x2, x2, #0x3
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_3260:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	L_3480
bl	L_34d0
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
L_3280:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_34d0
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_32fc
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	L_3280
L_32fc:
subs	w4, w4, #0x8
b.le	L_347c
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	L_3260
L_3328:
ld1	{ v0.8b }, [x6]
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x3
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_334c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	L_3480
bl	L_34d0
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
bl	L_34d0
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	L_34d0
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
L_3384:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_34d0
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v19.4h, v1.h[2]
smlal2	v5.4s, v19.8h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal2	v3.4s, v19.8h, v1.h[3]
smlal	v4.4s, v20.4h, v1.h[3]
smlal2	v5.4s, v20.8h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal2	v3.4s, v20.8h, v1.h[4]
smlal	v4.4s, v21.4h, v1.h[4]
smlal2	v5.4s, v21.8h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal2	v3.4s, v21.8h, v1.h[5]
smlal	v4.4s, v22.4h, v1.h[5]
smlal2	v5.4s, v22.8h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal2	v3.4s, v22.8h, v1.h[6]
smlal	v4.4s, v24.4h, v1.h[6]
smlal2	v5.4s, v24.8h, v1.h[6]
smlal	v2.4s, v24.4h, v1.h[7]
smlal2	v3.4s, v24.8h, v1.h[7]
smlal	v4.4s, v25.4h, v1.h[7]
smlal2	v5.4s, v25.8h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_3450
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	L_3384
L_3450:
subs	w4, w4, #0x8
b.le	L_347c
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	L_334c
L_347c:
ret	x15
L_3480:
ld1	{ v28.8b, v29.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[0]
ext	v24.16b, v28.16b, v29.16b, #0x2
ext	v25.16b, v28.16b, v29.16b, #0x4
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v28.16b, v29.16b, #0x8
mla	v16.8h, v24.8h, v0.h[1]
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0xa
ext	v25.16b, v28.16b, v29.16b, #0xc
ext	v26.16b, v28.16b, v29.16b, #0xe
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
mla	v16.8h, v26.8h, v0.h[7]
srshr	v16.8h, v16.8h, #0x2
ret
L_34d0:
ld1	{ v28.8b, v29.8b }, [x9], x3
ld1	{ v30.8b, v31.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[0]
mul	v25.8h, v30.8h, v0.h[0]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[1]
mla	v25.8h, v27.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xc
ext	v27.16b, v30.16b, v31.16b, #0xc
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
ext	v26.16b, v28.16b, v29.16b, #0xe
ext	v27.16b, v30.16b, v31.16b, #0xe
mla	v24.8h, v26.8h, v0.h[7]
mla	v25.8h, v27.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
put_8tap_regular_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x2d
b	put_6tap_neon
put_8tap_regular_smooth_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x7bc
b	put_6tap_neon
put_8tap_smooth_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x7bc
b	put_6tap_neon
put_8tap_smooth_regular_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x2d
b	put_6tap_neon
put_6tap_neon:
mov	w10, #0x4081
mul	w6, w6, w10
mul	w7, w7, w10
add	w6, w6, w8
add	w7, w7, w9
clz	w8, w4
tst	w6, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	L_35d4
tst	w7, #0x1fc000
b.ne	L_3924
b	put_neon
L_35d4:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_35e8
mov	w6, w9
L_35e8:
tst	w7, #0x1fc000
add	x6, x10, w6, uxtw #3
b.ne	L_42a4
adrp	x9, put_6tap_h_tbl
add	x9, x9, :lo12:put_6tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_3608:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_3624:
ld1	{ v4.8b }, [x2], x3
ld1	{ v6.8b }, [x9], x3
ushll	v4.8h, v4.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
subs	w5, w5, #0x2
trn1	v3.2s, v4.2s, v6.2s
trn2	v6.2s, v4.2s, v6.2s
trn1	v4.2s, v5.2s, v7.2s
trn2	v7.2s, v5.2s, v7.2s
mul	v3.4h, v3.4h, v0.h[0]
mla	v3.4h, v4.4h, v0.h[1]
mla	v3.4h, v6.4h, v0.h[2]
mla	v3.4h, v7.4h, v0.h[3]
srshr	v3.4h, v3.4h, #0x2
sqrshrun	v3.8b, v3.8h, #0x4
st1	{ v3.h }[0], [x0], x1
st1	{ v3.h }[1], [x8], x1
b.gt	L_3624
ret
L_3678:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_3694:
ld1	{ v16.8b }, [x2], x3
ld1	{ v20.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w5, w5, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
sqrshrun	v16.8b, v16.8h, #0x4
sqrshrun	v20.8b, v20.8h, #0x4
str	s16, [x0]
str	s20, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.gt	L_3694
ret
L_3708:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x2
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_3724:
ld1	{ v16.8b, v17.8b }, [x2], x3
ld1	{ v20.8b, v21.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[1]
mul	v22.8h, v20.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
subs	w5, w5, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
sqrshrun	v18.8b, v18.8h, #0x4
sqrshrun	v22.8b, v22.8h, #0x4
st1	{ v18.8b }, [x0], x1
st1	{ v22.8b }, [x8], x1
b.gt	L_3724
ret
L_37b8:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x2
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
sub	x3, x3, w4, uxtw
sub	x3, x3, #0x8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
L_37e0:
ld1	{ v16.8b, v17.8b, v18.8b }, [x2], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w6, w4
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_3804:
mul	v24.8h, v16.8h, v0.h[1]
mul	v25.8h, v17.8h, v0.h[1]
mul	v26.8h, v20.8h, v0.h[1]
mul	v27.8h, v21.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w6, w6, #0x10
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun2	v24.16b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun2	v26.16b, v27.8h, #0x4
st1	{ v24.16b }, [x0], #16
st1	{ v26.16b }, [x8], #16
b.le	L_3908
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x2], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	L_3804
L_3908:
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #0x2
b.gt	L_37e0
ret
L_3924:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_3938
mov	w7, w9
L_3938:
add	x7, x10, w7, uxtw #3
adrp	x9, put_6tap_v_tbl
add	x9, x9, :lo12:put_6tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_3950:
b.gt	L_3a24
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
b.gt	L_39cc
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.4h, v1.4h, v0.h[0]
mla	v6.4h, v2.4h, v0.h[1]
mla	v6.4h, v3.4h, v0.h[2]
mla	v6.4h, v4.4h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
ret
L_39cc:
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
st1	{ v6.h }[2], [x0], x1
st1	{ v6.h }[3], [x8], x1
ret
L_3a24:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
L_3a94:
subs	w5, w5, #0x4
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
ld1	{ v18.h }[0], [x9], x3
ld1	{ v19.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
trn1	v18.4h, v18.4h, v19.4h
trn1	v5.2s, v5.2s, v7.2s
trn1	v6.2s, v6.2s, v16.2s
trn1	v7.2s, v7.2s, v17.2s
trn1	v16.2s, v16.2s, v18.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.8h, v2.8h, v0.h[1]
mla	v30.8h, v3.8h, v0.h[2]
mla	v30.8h, v4.8h, v0.h[3]
mla	v30.8h, v5.8h, v0.h[4]
mla	v30.8h, v6.8h, v0.h[5]
mla	v30.8h, v7.8h, v0.h[6]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
st1	{ v30.h }[2], [x0], x1
st1	{ v30.h }[3], [x8], x1
b.le	L_3b74
cmp	w5, #0x2
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
mov	v4.16b, v16.16b
mov	v5.16b, v17.16b
mov	v6.16b, v18.16b
mov	v7.16b, v19.16b
b.eq	L_3b30
b	L_3a94
L_3b30:
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.4h, v2.4h, v0.h[1]
mla	v30.4h, v3.4h, v0.h[2]
mla	v30.4h, v4.4h, v0.h[3]
mla	v30.4h, v5.4h, v0.h[4]
mla	v30.4h, v6.4h, v0.h[5]
mla	v30.4h, v7.4h, v0.h[6]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
L_3b74:
ret
L_3b78:
b.gt	L_3c28
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x9], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x9], x3
ld1	{ v5.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.le	L_3c24
ld1	{ v6.s }[0], [x9], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v7.s }[0], [x0], x1
st1	{ v7.s }[1], [x8], x1
L_3c24:
ret
L_3c28:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x2], x3
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
L_3c90:
subs	w5, w5, #0x4
ld1	{ v23.s }[0], [x9], x3
ld1	{ v24.s }[0], [x2], x3
ld1	{ v25.s }[0], [x9], x3
ld1	{ v26.s }[0], [x2], x3
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	L_3e18
ld1	{ v27.s }[0], [x9], x3
ld1	{ v16.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
b.le	L_3e18
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	L_3e18
subs	w5, w5, #0x4
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.gt	L_3c90
L_3e18:
ret
L_3e1c:
b.gt	L_3ee0
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x2], x3
ld1	{ v2.8b }, [x9], x3
ld1	{ v3.8b }, [x2], x3
ld1	{ v4.8b }, [x9], x3
ld1	{ v5.8b }, [x2], x3
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v6.8b }, [x0], x1
st1	{ v7.8b }, [x8], x1
b.le	L_3edc
ld1	{ v6.8b }, [x9], x3
ld1	{ v7.8b }, [x2], x3
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
L_3edc:
ret
L_3ee0:
ld1	{ v0.8b }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w7, w5
L_3ef4:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8b }, [x2], x3
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_3f3c:
subs	w5, w5, #0x2
ld1	{ v23.8b }, [x9], x3
ld1	{ v24.8b }, [x2], x3
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	L_4144
subs	w5, w5, #0x2
ld1	{ v25.8b }, [x9], x3
ld1	{ v26.8b }, [x2], x3
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mul	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_4144
subs	w5, w5, #0x2
ld1	{ v27.8b }, [x9], x3
ld1	{ v16.8b }, [x2], x3
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mul	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	L_4144
subs	w5, w5, #0x2
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mul	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_4144
subs	w5, w5, #0x4
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mul	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mul	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.gt	L_3f3c
L_4144:
subs	w4, w4, #0x8
b.le	L_4170
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	L_3ef4
L_4170:
ret
L_4174:
b.gt	L_3ee0
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w5, #0x2
ld1	{ v1.16b }, [x2], x3
ld1	{ v2.16b }, [x9], x3
ld1	{ v3.16b }, [x2], x3
ld1	{ v4.16b }, [x9], x3
ld1	{ v5.16b }, [x2], x3
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v16.8b, v16.8h, #0x6
sqrshrun2	v16.16b, v17.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v16.16b }, [x8], x1
b.le	L_42a0
ld1	{ v6.16b }, [x9], x3
ld1	{ v7.16b }, [x2], x3
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun2	v3.16b, v4.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v3.16b }, [x8], x1
L_42a0:
ret
L_42a4:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_42b8
mov	w7, w9
L_42b8:
add	x7, x10, w7, uxtw #3
adrp	x9, put_6tap_hv_tbl
add	x9, x9, :lo12:put_6tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_42d0:
ldur	s0, [x6, #0x2]
b.gt	L_4364
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	L_4428
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
L_4328:
bl	L_4428
ext	v18.8b, v17.8b, v28.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	L_4424
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
b	L_4328
L_4364:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	L_4428
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
bl	L_4428
ext	v18.8b, v17.8b, v28.8b, #0x4
mov	v19.8b, v28.8b
bl	L_4428
ext	v20.8b, v19.8b, v28.8b, #0x4
mov	v21.8b, v28.8b
L_43d0:
bl	L_4428
ext	v22.8b, v21.8b, v28.8b, #0x4
smull	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	L_4424
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
b	L_43d0
L_4424:
ret	x15
L_4428:
ld1	{ v28.8b }, [x9], x3
ld1	{ v30.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
ext	v31.16b, v30.16b, v30.16b, #0x2
trn1	v27.2s, v28.2s, v30.2s
trn2	v30.2s, v28.2s, v30.2s
trn1	v28.2s, v29.2s, v31.2s
trn2	v31.2s, v29.2s, v31.2s
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v30.4h, v0.h[2]
mla	v27.4h, v31.4h, v0.h[3]
srshr	v28.4h, v27.4h, #0x2
ret
L_4468:
ldur	s0, [x6, #0x2]
b.gt	L_4524
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	L_4604
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
L_44c8:
bl	L_4604
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	L_4600
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	L_44c8
L_4524:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3
sub	x2, x2, x3, lsl #1
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v18.4h, v31.4h, #0x2
bl	L_4604
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	L_4604
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
L_458c:
bl	L_4604
smull	v2.4s, v18.4h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal	v2.4s, v28.4h, v1.h[6]
smull	v3.4s, v19.4h, v1.h[1]
smlal	v3.4s, v20.4h, v1.h[2]
smlal	v3.4s, v21.4h, v1.h[3]
smlal	v3.4s, v22.4h, v1.h[4]
smlal	v3.4s, v28.4h, v1.h[5]
smlal	v3.4s, v29.4h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	L_4600
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	L_458c
L_4600:
ret	x15
L_4604:
ld1	{ v26.8b }, [x9], x3
ld1	{ v27.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
L_4658:
b.gt	L_4744
ld1	{ v0.8b }, [x6]
ldur	s1, [x7, #0x2]
sub	x2, x2, #0x2
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_467c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	L_486c
bl	L_48ac
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
L_469c:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_48ac
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_4718
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	L_469c
L_4718:
subs	w4, w4, #0x8
b.le	L_4868
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	L_467c
L_4744:
ld1	{ v0.8b }, [x6]
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x2
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_4764:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	L_486c
mov	v18.16b, v16.16b
bl	L_48ac
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	L_48ac
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
L_4794:
smull	v2.4s, v18.4h, v1.h[1]
smull2	v3.4s, v18.8h, v1.h[1]
bl	L_48ac
smull	v4.4s, v19.4h, v1.h[1]
smull2	v5.4s, v19.8h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal2	v3.4s, v19.8h, v1.h[2]
smlal	v4.4s, v20.4h, v1.h[2]
smlal2	v5.4s, v20.8h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal2	v3.4s, v20.8h, v1.h[3]
smlal	v4.4s, v21.4h, v1.h[3]
smlal2	v5.4s, v21.8h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal2	v3.4s, v21.8h, v1.h[4]
smlal	v4.4s, v22.4h, v1.h[4]
smlal2	v5.4s, v22.8h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal2	v3.4s, v22.8h, v1.h[5]
smlal	v4.4s, v24.4h, v1.h[5]
smlal2	v5.4s, v24.8h, v1.h[5]
smlal	v2.4s, v24.4h, v1.h[6]
smlal2	v3.4s, v24.8h, v1.h[6]
smlal	v4.4s, v25.4h, v1.h[6]
smlal2	v5.4s, v25.8h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	L_4838
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	L_4794
L_4838:
subs	w4, w4, #0x8
b.le	L_4868
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
add	x2, x2, x3, lsl #1
b	L_4764
L_4868:
ret	x15
L_486c:
ld1	{ v28.8b, v29.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[1]
ext	v25.16b, v28.16b, v29.16b, #0x2
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v28.16b, v29.16b, #0x6
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0x8
ext	v25.16b, v28.16b, v29.16b, #0xa
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
srshr	v16.8h, v16.8h, #0x2
ret
L_48ac:
ld1	{ v28.8b, v29.8b }, [x9], x3
ld1	{ v30.8b, v31.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[1]
mul	v25.8h, v30.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
put_bilin_8bpc_neon:
dup	v1.16b, w6
dup	v3.16b, w7
mov	w9, #0x10
sub	w8, w9, w6
sub	w9, w9, w7
dup	v0.16b, w8
dup	v2.16b, w9
clz	w8, w4
sub	w8, w8, #0x18
cbnz	w6, L_4958
cbnz	w7, L_4af4
b	put_neon
L_4958:
cbnz	w7, L_4ce4
adrp	x9, put_bilin_h_tbl
add	x9, x9, :lo12:put_bilin_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_4970:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
L_4980:
ld1r	{ v4.4s }, [x2], x3
ld1r	{ v6.4s }, [x9], x3
ext	v5.8b, v4.8b, v4.8b, #0x1
ext	v7.8b, v6.8b, v6.8b, #0x1
trn1	v4.4h, v4.4h, v6.4h
trn1	v5.4h, v5.4h, v7.4h
subs	w5, w5, #0x2
umull	v4.8h, v4.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.h }[0], [x0], x1
st1	{ v4.h }[1], [x8], x1
b.gt	L_4980
ret
L_49b8:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
L_49c8:
ld1	{ v4.8b }, [x2], x3
ld1	{ v6.8b }, [x9], x3
ext	v5.8b, v4.8b, v4.8b, #0x1
ext	v7.8b, v6.8b, v6.8b, #0x1
trn1	v4.2s, v4.2s, v6.2s
trn1	v5.2s, v5.2s, v7.2s
subs	w5, w5, #0x2
umull	v4.8h, v4.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x8], x1
b.gt	L_49c8
ret
L_4a00:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
L_4a10:
ld1	{ v4.16b }, [x2], x3
ld1	{ v6.16b }, [x9], x3
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v7.16b, v6.16b, v6.16b, #0x1
subs	w5, w5, #0x2
umull	v4.8h, v4.8b, v0.8b
umull	v6.8h, v6.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
umlal	v6.8h, v7.8b, v1.8b
uqrshrn	v4.8b, v4.8h, #0x4
uqrshrn	v6.8b, v6.8h, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v6.8b }, [x8], x1
b.gt	L_4a10
ret
L_4a4c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sub	x3, x3, w4, uxtw
sub	x3, x3, #0x8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
L_4a68:
ld1	{ v16.d }[1], [x2], #8
ld1	{ v20.d }[1], [x9], #8
mov	w6, w4
L_4a74:
ld1	{ v18.16b }, [x2], #16
ld1	{ v22.16b }, [x9], #16
ext	v17.16b, v16.16b, v18.16b, #0x8
ext	v19.16b, v16.16b, v18.16b, #0x9
ext	v21.16b, v20.16b, v22.16b, #0x8
ext	v23.16b, v20.16b, v22.16b, #0x9
umull	v16.8h, v17.8b, v0.8b
umull2	v17.8h, v17.16b, v0.16b
umull	v20.8h, v21.8b, v0.8b
umull2	v21.8h, v21.16b, v0.16b
umlal	v16.8h, v19.8b, v1.8b
umlal2	v17.8h, v19.16b, v1.16b
umlal	v20.8h, v23.8b, v1.8b
umlal2	v21.8h, v23.16b, v1.16b
subs	w6, w6, #0x10
uqrshrn	v16.8b, v16.8h, #0x4
uqrshrn2	v16.16b, v17.8h, #0x4
uqrshrn	v20.8b, v20.8h, #0x4
uqrshrn2	v20.16b, v21.8h, #0x4
st1	{ v16.16b }, [x0], #16
st1	{ v20.16b }, [x8], #16
b.le	L_4ad8
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
b	L_4a74
L_4ad8:
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #0x2
b.gt	L_4a68
ret
L_4af4:
cmp	w5, #0x4
adrp	x9, put_bilin_v_tbl
add	x9, x9, :lo12:put_bilin_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_4b0c:
cmp	w5, #0x2
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v16.8h }, [x2], x3
b.gt	L_4b50
L_4b28:
ld1r	{ v17.8h }, [x9], x3
ld1r	{ v18.8h }, [x2], x3
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
uqrshrn	v4.8b, v4.8h, #0x4
str	h4, [x0]
st1	{ v4.h }[1], [x8]
ret
L_4b50:
ld1r	{ v17.8h }, [x9], x3
ld1r	{ v18.8h }, [x2], x3
ld1r	{ v19.8h }, [x9], x3
ld1r	{ v20.8h }, [x2], x3
sub	w5, w5, #0x4
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
trn1	v18.4h, v18.4h, v19.4h
trn1	v19.4h, v19.4h, v20.4h
trn1	v16.2s, v16.2s, v18.2s
trn1	v17.2s, v17.2s, v19.2s
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
cmp	w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.h }[0], [x0], x1
st1	{ v4.h }[1], [x8], x1
st1	{ v4.h }[2], [x0], x1
st1	{ v4.h }[3], [x8], x1
b.lt	L_4bac
mov	v16.8b, v20.8b
b.eq	L_4b28
b	L_4b50
L_4bac:
ret
L_4bb0:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v16.4s }, [x2], x3
L_4bc4:
ld1r	{ v17.4s }, [x9], x3
ld1r	{ v18.4s }, [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x8], x1
b.le	L_4bf8
mov	v16.8b, v18.8b
b	L_4bc4
L_4bf8:
ret
L_4bfc:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8b }, [x2], x3
L_4c10:
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
umull	v4.8h, v16.8b, v2.8b
umull	v5.8h, v17.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
umlal	v5.8h, v18.8b, v3.8b
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
uqrshrn	v5.8b, v5.8h, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x8], x1
b.le	L_4c48
mov	v16.8b, v18.8b
b	L_4c10
L_4c48:
ret
L_4c4c:
mov	w7, w5
L_4c50:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.16b }, [x2], x3
L_4c64:
ld1	{ v17.16b }, [x9], x3
ld1	{ v18.16b }, [x2], x3
umull	v4.8h, v16.8b, v2.8b
umull2	v5.8h, v16.16b, v2.16b
umull	v6.8h, v17.8b, v2.8b
umull2	v7.8h, v17.16b, v2.16b
umlal	v4.8h, v17.8b, v3.8b
umlal2	v5.8h, v17.16b, v3.16b
umlal	v6.8h, v18.8b, v3.8b
umlal2	v7.8h, v18.16b, v3.16b
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
uqrshrn2	v4.16b, v5.8h, #0x4
uqrshrn	v6.8b, v6.8h, #0x4
uqrshrn2	v6.16b, v7.8h, #0x4
st1	{ v4.16b }, [x0], x1
st1	{ v6.16b }, [x8], x1
b.le	L_4cb4
mov	v16.16b, v18.16b
b	L_4c64
L_4cb4:
subs	w4, w4, #0x10
b.le	L_4ce0
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_4c50
L_4ce0:
ret
L_4ce4:
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
adrp	x9, put_bilin_hv_tbl
add	x9, x9, :lo12:put_bilin_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_4d00:
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v28.4s }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
L_4d20:
ld1r	{ v28.4s }, [x9], x3
ld1r	{ v30.4s }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
ext	v31.8b, v30.8b, v30.8b, #0x1
trn1	v28.4h, v28.4h, v30.4h
trn1	v29.4h, v29.4h, v31.4h
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
trn1	v16.2s, v16.2s, v17.2s
mul	v4.4h, v16.4h, v2.4h
mla	v4.4h, v17.4h, v3.4h
uqrshrn	v4.8b, v4.8h, #0x8
subs	w5, w5, #0x2
st1	{ v4.h }[0], [x0], x1
st1	{ v4.h }[1], [x8], x1
b.le	L_4d68
trn2	v16.2s, v17.2s, v17.2s
b	L_4d20
L_4d68:
ret
L_4d6c:
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v28.8b }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
L_4d8c:
ld1	{ v28.8b }, [x9], x3
ld1	{ v30.8b }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
ext	v31.8b, v30.8b, v30.8b, #0x1
trn1	v28.2s, v28.2s, v30.2s
trn1	v29.2s, v29.2s, v31.2s
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
trn1	v16.2d, v16.2d, v17.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x8
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x8], x1
b.le	L_4dd4
trn2	v16.2d, v17.2d, v17.2d
b	L_4d8c
L_4dd4:
ret
L_4dd8:
mov	w7, w5
L_4ddc:
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v28.16b }, [x2], x3
ext	v29.16b, v28.16b, v28.16b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
L_4dfc:
ld1	{ v28.16b }, [x9], x3
ld1	{ v30.16b }, [x2], x3
ext	v29.16b, v28.16b, v28.16b, #0x1
ext	v31.16b, v30.16b, v30.16b, #0x1
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
umull	v18.8h, v30.8b, v0.8b
umlal	v18.8h, v31.8b, v1.8b
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v18.8h, v3.8h
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x8
uqrshrn	v5.8b, v5.8h, #0x8
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x8], x1
b.le	L_4e4c
mov	v16.16b, v18.16b
b	L_4dfc
L_4e4c:
subs	w4, w4, #0x8
b.le	L_4e78
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	L_4ddc
L_4e78:
ret
prep_8tap_regular_sharp_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0xf2d
b	prep_8tap_neon
prep_8tap_smooth_sharp_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0xf2d
b	prep_8tap_neon
prep_8tap_sharp_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0xf2d
b	prep_8tap_neon
prep_8tap_sharp_regular_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x2d
b	prep_8tap_neon
prep_8tap_sharp_smooth_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x7bc
b	prep_8tap_neon
prep_8tap_neon:
mov	w10, #0x4081
mul	w5, w5, w10
mul	w6, w6, w10
add	w5, w5, w8
add	w6, w6, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
tst	w5, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	L_4ef8
tst	w6, #0x1fc000
b.ne	L_5208
b	prep_neon
L_4ef8:
cmp	w3, #0x4
ubfx	w9, w5, #7, #7
and	w5, w5, #0x7f
b.le	L_4f0c
mov	w5, w9
L_4f0c:
tst	w6, #0x1fc000
add	x5, x10, w5, uxtw #3
b.ne	L_59f0
adrp	x9, prep_8tap_h_tbl
add	x9, x9, :lo12:prep_8tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_4f2c:
ldur	s0, [x5, #0x2]
sub	x1, x1, #0x1
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
L_4f48:
ld1	{ v16.8b }, [x1], x2
ld1	{ v20.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w4, w4, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
st1	{ v16.4h }, [x0], x7
st1	{ v20.4h }, [x8], x7
b.gt	L_4f48
ret
L_4fac:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x3
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
L_4fc8:
ld1	{ v16.8b, v17.8b }, [x1], x2
ld1	{ v20.8b, v21.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[0]
mul	v22.8h, v20.8h, v0.h[0]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[1]
mla	v22.8h, v23.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xc
ext	v23.16b, v20.16b, v21.16b, #0xc
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
ext	v19.16b, v16.16b, v17.16b, #0xe
ext	v23.16b, v20.16b, v21.16b, #0xe
mla	v18.8h, v19.8h, v0.h[7]
mla	v22.8h, v23.8h, v0.h[7]
subs	w4, w4, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
st1	{ v18.8h }, [x0], x7
st1	{ v22.8h }, [x8], x7
b.gt	L_4fc8
ret
L_5074:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x3
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
sub	x2, x2, w3, uxtw
sub	x2, x2, #0x8
L_5094:
ld1	{ v16.8b, v17.8b, v18.8b }, [x1], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w5, w3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_50b8:
mul	v24.8h, v16.8h, v0.h[0]
mul	v25.8h, v17.8h, v0.h[0]
mul	v26.8h, v20.8h, v0.h[0]
mul	v27.8h, v21.8h, v0.h[0]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[1]
mla	v25.8h, v29.8h, v0.h[1]
mla	v26.8h, v30.8h, v0.h[1]
mla	v27.8h, v31.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xc
ext	v29.16b, v17.16b, v18.16b, #0xc
ext	v30.16b, v20.16b, v21.16b, #0xc
ext	v31.16b, v21.16b, v22.16b, #0xc
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
ext	v28.16b, v16.16b, v17.16b, #0xe
ext	v29.16b, v17.16b, v18.16b, #0xe
ext	v30.16b, v20.16b, v21.16b, #0xe
ext	v31.16b, v21.16b, v22.16b, #0xe
mla	v24.8h, v28.8h, v0.h[7]
mla	v25.8h, v29.8h, v0.h[7]
mla	v26.8h, v30.8h, v0.h[7]
mla	v27.8h, v31.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w5, w5, #0x10
st1	{ v24.8h, v25.8h }, [x0], #32
st1	{ v26.8h, v27.8h }, [x8], #32
b.le	L_51ec
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x1], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	L_50b8
L_51ec:
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #0x2
b.gt	L_5094
ret
L_5208:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_521c
mov	w6, w9
L_521c:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_8tap_v_tbl
add	x9, x9, :lo12:prep_8tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_5234:
b.gt	L_52e4
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x1], x2
ld1	{ v2.s }[0], [x9], x2
ld1	{ v3.s }[0], [x1], x2
ld1	{ v4.s }[0], [x9], x2
ld1	{ v5.s }[0], [x1], x2
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
st1	{ v6.8b }, [x0], x7
st1	{ v6.d }[1], [x8], x7
b.le	L_52e0
ld1	{ v6.s }[0], [x9], x2
ld1	{ v7.s }[0], [x1], x2
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
srshr	v7.8h, v7.8h, #0x2
st1	{ v7.8b }, [x0], x7
st1	{ v7.d }[1], [x8], x7
L_52e0:
ret
L_52e4:
ld1	{ v0.8b }, [x6]
sub	x9, x1, x2, lsl #1
add	x8, x0, x7
sub	x1, x9, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x1], x2
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
L_534c:
subs	w4, w4, #0x4
ld1	{ v23.s }[0], [x9], x2
ld1	{ v24.s }[0], [x1], x2
ld1	{ v25.s }[0], [x9], x2
ld1	{ v26.s }[0], [x1], x2
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v18.8h, v0.h[0]
mla	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
mla	v2.8h, v25.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	L_5504
ld1	{ v27.s }[0], [x9], x2
ld1	{ v16.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
b.le	L_5504
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v22.8h, v0.h[0]
mla	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
mla	v2.8h, v17.8h, v0.h[7]
srshr	v2.8h, v2.8h, #0x2
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	L_5504
subs	w4, w4, #0x4
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v26.8h, v0.h[0]
mla	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
mla	v2.8h, v21.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.gt	L_534c
L_5504:
ret
L_5508:
b.gt	L_55cc
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x1], x2
ld1	{ v2.8b }, [x9], x2
ld1	{ v3.8b }, [x1], x2
ld1	{ v4.8b }, [x9], x2
ld1	{ v5.8b }, [x1], x2
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
st1	{ v6.16b }, [x0], x7
st1	{ v7.16b }, [x8], x7
b.le	L_55c8
ld1	{ v6.8b }, [x9], x2
ld1	{ v7.8b }, [x1], x2
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
L_55c8:
ret
L_55cc:
ld1	{ v0.8b }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w6, w4
L_55e0:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.8b }, [x1], x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_5628:
subs	w4, w4, #0x2
ld1	{ v23.8b }, [x9], x2
ld1	{ v24.8b }, [x1], x2
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
mla	v2.8h, v24.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	L_5890
subs	w4, w4, #0x2
ld1	{ v25.8b }, [x9], x2
ld1	{ v26.8b }, [x1], x2
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v18.8h, v0.h[0]
mla	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mla	v3.8h, v25.8h, v0.h[7]
mul	v4.8h, v19.8h, v0.h[0]
mla	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
mla	v4.8h, v26.8h, v0.h[7]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	L_5890
subs	w4, w4, #0x2
ld1	{ v27.8b }, [x9], x2
ld1	{ v16.8b }, [x1], x2
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
mul	v2.8h, v21.8h, v0.h[0]
mla	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
mla	v2.8h, v16.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	L_5890
subs	w4, w4, #0x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v22.8h, v0.h[0]
mla	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mla	v3.8h, v17.8h, v0.h[7]
mul	v4.8h, v23.8h, v0.h[0]
mla	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
mla	v4.8h, v18.8h, v0.h[7]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	L_5890
subs	w4, w4, #0x4
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mla	v2.8h, v20.8h, v0.h[7]
mul	v3.8h, v26.8h, v0.h[0]
mla	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mla	v3.8h, v21.8h, v0.h[7]
mul	v4.8h, v27.8h, v0.h[0]
mla	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
mla	v4.8h, v22.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.gt	L_5628
L_5890:
subs	w3, w3, #0x8
b.le	L_58bc
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	L_55e0
L_58bc:
ret
L_58c0:
b.gt	L_55cc
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w4, #0x2
ld1	{ v1.16b }, [x1], x2
ld1	{ v2.16b }, [x9], x2
ld1	{ v3.16b }, [x1], x2
ld1	{ v4.16b }, [x9], x2
ld1	{ v5.16b }, [x1], x2
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v16.8h, v16.8h, #0x2
srshr	v17.8h, v17.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v16.8h, v17.8h }, [x8], x7
b.le	L_59ec
ld1	{ v6.16b }, [x9], x2
ld1	{ v7.16b }, [x1], x2
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v3.8h, v4.8h }, [x8], x7
L_59ec:
ret
L_59f0:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_5a04
mov	w6, w9
L_5a04:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_8tap_hv_tbl
add	x9, x9, :lo12:prep_8tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_5a1c:
ldur	s0, [x5, #0x2]
b.gt	L_5ac8
ldur	s1, [x6, #0x2]
sub	x9, x1, #0x1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	L_5bbc
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
L_5a7c:
bl	L_5bbc
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	L_5bb8
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	L_5a7c
L_5ac8:
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x1
sub	x9, x1, x2, lsl #1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	L_5bbc
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
bl	L_5bbc
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	L_5bbc
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
L_5b3c:
bl	L_5bbc
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal	v2.4s, v28.4h, v1.h[7]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smlal	v3.4s, v21.4h, v1.h[4]
smlal	v3.4s, v22.4h, v1.h[5]
smlal	v3.4s, v28.4h, v1.h[6]
smlal	v3.4s, v29.4h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	L_5bb8
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	L_5b3c
L_5bb8:
ret	x15
L_5bbc:
ld1	{ v26.8b }, [x9], x2
ld1	{ v27.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
L_5c10:
b.gt	L_5cf4
ld1	{ v0.8b }, [x5]
ldur	s1, [x6, #0x2]
sub	x1, x1, #0x3
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_5c34:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	L_5e44
bl	L_5e94
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
L_5c54:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_5e94
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	L_5cc8
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	L_5c54
L_5cc8:
subs	w3, w3, #0x8
b.le	L_5e40
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	L_5c34
L_5cf4:
ld1	{ v0.8b }, [x5]
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x3
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_5d18:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	L_5e44
bl	L_5e94
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
bl	L_5e94
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	L_5e94
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
L_5d50:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_5e94
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v19.4h, v1.h[2]
smlal2	v5.4s, v19.8h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal2	v3.4s, v19.8h, v1.h[3]
smlal	v4.4s, v20.4h, v1.h[3]
smlal2	v5.4s, v20.8h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal2	v3.4s, v20.8h, v1.h[4]
smlal	v4.4s, v21.4h, v1.h[4]
smlal2	v5.4s, v21.8h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal2	v3.4s, v21.8h, v1.h[5]
smlal	v4.4s, v22.4h, v1.h[5]
smlal2	v5.4s, v22.8h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal2	v3.4s, v22.8h, v1.h[6]
smlal	v4.4s, v24.4h, v1.h[6]
smlal2	v5.4s, v24.8h, v1.h[6]
smlal	v2.4s, v24.4h, v1.h[7]
smlal2	v3.4s, v24.8h, v1.h[7]
smlal	v4.4s, v25.4h, v1.h[7]
smlal2	v5.4s, v25.8h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	L_5e14
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	L_5d50
L_5e14:
subs	w3, w3, #0x8
b.le	L_5e40
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	L_5d18
L_5e40:
ret	x15
L_5e44:
ld1	{ v28.8b, v29.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[0]
ext	v24.16b, v28.16b, v29.16b, #0x2
ext	v25.16b, v28.16b, v29.16b, #0x4
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v28.16b, v29.16b, #0x8
mla	v16.8h, v24.8h, v0.h[1]
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0xa
ext	v25.16b, v28.16b, v29.16b, #0xc
ext	v26.16b, v28.16b, v29.16b, #0xe
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
mla	v16.8h, v26.8h, v0.h[7]
srshr	v16.8h, v16.8h, #0x2
ret
L_5e94:
ld1	{ v28.8b, v29.8b }, [x9], x2
ld1	{ v30.8b, v31.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[0]
mul	v25.8h, v30.8h, v0.h[0]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[1]
mla	v25.8h, v27.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xc
ext	v27.16b, v30.16b, v31.16b, #0xc
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
ext	v26.16b, v28.16b, v29.16b, #0xe
ext	v27.16b, v30.16b, v31.16b, #0xe
mla	v24.8h, v26.8h, v0.h[7]
mla	v25.8h, v27.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
prep_8tap_regular_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x2d
b	prep_6tap_neon
prep_8tap_regular_smooth_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x7bc
b	prep_6tap_neon
prep_8tap_smooth_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x7bc
b	prep_6tap_neon
prep_8tap_smooth_regular_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x2d
b	prep_6tap_neon
prep_6tap_neon:
mov	w10, #0x4081
mul	w5, w5, w10
mul	w6, w6, w10
add	w5, w5, w8
add	w6, w6, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
tst	w5, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	L_5fa0
tst	w6, #0x1fc000
b.ne	L_6250
b	prep_neon
L_5fa0:
cmp	w3, #0x4
ubfx	w9, w5, #7, #7
and	w5, w5, #0x7f
b.le	L_5fb4
mov	w5, w9
L_5fb4:
tst	w6, #0x1fc000
add	x5, x10, w5, uxtw #3
b.ne	L_69a8
adrp	x9, prep_6tap_h_tbl
add	x9, x9, :lo12:prep_6tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_5fd4:
ldur	s0, [x5, #0x2]
sub	x1, x1, #0x1
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
L_5ff0:
ld1	{ v16.8b }, [x1], x2
ld1	{ v20.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w4, w4, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
st1	{ v16.4h }, [x0], x7
st1	{ v20.4h }, [x8], x7
b.gt	L_5ff0
ret
L_6054:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
L_6070:
ld1	{ v16.8b, v17.8b }, [x1], x2
ld1	{ v20.8b, v21.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[1]
mul	v22.8h, v20.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
subs	w4, w4, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
st1	{ v18.8h }, [x0], x7
st1	{ v22.8h }, [x8], x7
b.gt	L_6070
ret
L_60fc:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
sub	x2, x2, w3, uxtw
sub	x2, x2, #0x8
L_611c:
ld1	{ v16.8b, v17.8b, v18.8b }, [x1], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w5, w3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_6140:
mul	v24.8h, v16.8h, v0.h[1]
mul	v25.8h, v17.8h, v0.h[1]
mul	v26.8h, v20.8h, v0.h[1]
mul	v27.8h, v21.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w5, w5, #0x10
st1	{ v24.8h, v25.8h }, [x0], #32
st1	{ v26.8h, v27.8h }, [x8], #32
b.le	L_6234
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x1], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	L_6140
L_6234:
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #0x2
b.gt	L_611c
ret
L_6250:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_6264
mov	w6, w9
L_6264:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_6tap_v_tbl
add	x9, x9, :lo12:prep_6tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_627c:
b.gt	L_632c
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x1], x2
ld1	{ v2.s }[0], [x9], x2
ld1	{ v3.s }[0], [x1], x2
ld1	{ v4.s }[0], [x9], x2
ld1	{ v5.s }[0], [x1], x2
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
st1	{ v6.8b }, [x0], x7
st1	{ v6.d }[1], [x8], x7
b.le	L_6328
ld1	{ v6.s }[0], [x9], x2
ld1	{ v7.s }[0], [x1], x2
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
srshr	v7.8h, v7.8h, #0x2
st1	{ v7.8b }, [x0], x7
st1	{ v7.d }[1], [x8], x7
L_6328:
ret
L_632c:
ld1	{ v0.8b }, [x6]
sub	x9, x1, x2, lsl #1
add	x8, x0, x7
sub	x1, x9, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x1], x2
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
L_6394:
subs	w4, w4, #0x4
ld1	{ v23.s }[0], [x9], x2
ld1	{ v24.s }[0], [x1], x2
ld1	{ v25.s }[0], [x9], x2
ld1	{ v26.s }[0], [x1], x2
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	L_651c
ld1	{ v27.s }[0], [x9], x2
ld1	{ v16.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
b.le	L_651c
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
srshr	v2.8h, v2.8h, #0x2
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	L_651c
subs	w4, w4, #0x4
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.gt	L_6394
L_651c:
ret
L_6520:
b.gt	L_65e4
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x1], x2
ld1	{ v2.8b }, [x9], x2
ld1	{ v3.8b }, [x1], x2
ld1	{ v4.8b }, [x9], x2
ld1	{ v5.8b }, [x1], x2
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
st1	{ v6.16b }, [x0], x7
st1	{ v7.16b }, [x8], x7
b.le	L_65e0
ld1	{ v6.8b }, [x9], x2
ld1	{ v7.8b }, [x1], x2
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
L_65e0:
ret
L_65e4:
ld1	{ v0.8b }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w6, w4
L_65f8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.8b }, [x1], x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
L_6640:
subs	w4, w4, #0x2
ld1	{ v23.8b }, [x9], x2
ld1	{ v24.8b }, [x1], x2
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	L_6848
subs	w4, w4, #0x2
ld1	{ v25.8b }, [x9], x2
ld1	{ v26.8b }, [x1], x2
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mul	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	L_6848
subs	w4, w4, #0x2
ld1	{ v27.8b }, [x9], x2
ld1	{ v16.8b }, [x1], x2
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mul	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	L_6848
subs	w4, w4, #0x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mul	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	L_6848
subs	w4, w4, #0x4
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mul	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mul	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.gt	L_6640
L_6848:
subs	w3, w3, #0x8
b.le	L_6874
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	L_65f8
L_6874:
ret
L_6878:
b.gt	L_65e4
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w4, #0x2
ld1	{ v1.16b }, [x1], x2
ld1	{ v2.16b }, [x9], x2
ld1	{ v3.16b }, [x1], x2
ld1	{ v4.16b }, [x9], x2
ld1	{ v5.16b }, [x1], x2
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v16.8h, v16.8h, #0x2
srshr	v17.8h, v17.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v16.8h, v17.8h }, [x8], x7
b.le	L_69a4
ld1	{ v6.16b }, [x9], x2
ld1	{ v7.16b }, [x1], x2
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v3.8h, v4.8h }, [x8], x7
L_69a4:
ret
L_69a8:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_69bc
mov	w6, w9
L_69bc:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_6tap_hv_tbl
add	x9, x9, :lo12:prep_6tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_69d4:
ldur	s0, [x5, #0x2]
b.gt	L_6a80
ldur	s1, [x6, #0x2]
sub	x9, x1, #0x1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	L_6b50
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
L_6a34:
bl	L_6b50
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	L_6b4c
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	L_6a34
L_6a80:
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x1
sub	x9, x1, x2
sub	x1, x1, x2, lsl #1
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v18.4h, v31.4h, #0x2
bl	L_6b50
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	L_6b50
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
L_6ae8:
bl	L_6b50
smull	v2.4s, v18.4h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal	v2.4s, v28.4h, v1.h[6]
smull	v3.4s, v19.4h, v1.h[1]
smlal	v3.4s, v20.4h, v1.h[2]
smlal	v3.4s, v21.4h, v1.h[3]
smlal	v3.4s, v22.4h, v1.h[4]
smlal	v3.4s, v28.4h, v1.h[5]
smlal	v3.4s, v29.4h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	L_6b4c
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	L_6ae8
L_6b4c:
ret	x15
L_6b50:
ld1	{ v26.8b }, [x9], x2
ld1	{ v27.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
L_6ba4:
b.gt	L_6c88
ld1	{ v0.8b }, [x5]
ldur	s1, [x6, #0x2]
sub	x1, x1, #0x2
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_6bc8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	L_6da8
bl	L_6de8
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
L_6be8:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_6de8
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	L_6c5c
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	L_6be8
L_6c5c:
subs	w3, w3, #0x8
b.le	L_6da4
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	L_6bc8
L_6c88:
ld1	{ v0.8b }, [x5]
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_6ca8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	L_6da8
mov	v18.16b, v16.16b
bl	L_6de8
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	L_6de8
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
L_6cd8:
smull	v2.4s, v18.4h, v1.h[1]
smull2	v3.4s, v18.8h, v1.h[1]
bl	L_6de8
smull	v4.4s, v19.4h, v1.h[1]
smull2	v5.4s, v19.8h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal2	v3.4s, v19.8h, v1.h[2]
smlal	v4.4s, v20.4h, v1.h[2]
smlal2	v5.4s, v20.8h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal2	v3.4s, v20.8h, v1.h[3]
smlal	v4.4s, v21.4h, v1.h[3]
smlal2	v5.4s, v21.8h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal2	v3.4s, v21.8h, v1.h[4]
smlal	v4.4s, v22.4h, v1.h[4]
smlal2	v5.4s, v22.8h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal2	v3.4s, v22.8h, v1.h[5]
smlal	v4.4s, v24.4h, v1.h[5]
smlal2	v5.4s, v24.8h, v1.h[5]
smlal	v2.4s, v24.4h, v1.h[6]
smlal2	v3.4s, v24.8h, v1.h[6]
smlal	v4.4s, v25.4h, v1.h[6]
smlal2	v5.4s, v25.8h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	L_6d74
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	L_6cd8
L_6d74:
subs	w3, w3, #0x8
b.le	L_6da4
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
add	x1, x1, x2, lsl #1
b	L_6ca8
L_6da4:
ret	x15
L_6da8:
ld1	{ v28.8b, v29.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[1]
ext	v25.16b, v28.16b, v29.16b, #0x2
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v28.16b, v29.16b, #0x6
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0x8
ext	v25.16b, v28.16b, v29.16b, #0xa
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
srshr	v16.8h, v16.8h, #0x2
ret
L_6de8:
ld1	{ v28.8b, v29.8b }, [x9], x2
ld1	{ v30.8b, v31.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[1]
mul	v25.8h, v30.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
prep_bilin_8bpc_neon:
dup	v1.16b, w5
dup	v3.16b, w6
mov	w9, #0x10
sub	w8, w9, w5
sub	w9, w9, w6
dup	v0.16b, w8
dup	v2.16b, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
sub	w8, w8, #0x18
cbnz	w5, L_6e9c
cbnz	w6, L_6fcc
b	prep_neon
L_6e9c:
cbnz	w6, L_70fc
adrp	x9, prep_bilin_h_tbl
add	x9, x9, :lo12:prep_bilin_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_6eb4:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
L_6ec4:
ld1	{ v4.8b }, [x1], x2
ld1	{ v6.8b }, [x9], x2
ext	v5.8b, v4.8b, v4.8b, #0x1
ext	v7.8b, v6.8b, v6.8b, #0x1
trn1	v4.2s, v4.2s, v6.2s
trn1	v5.2s, v5.2s, v7.2s
subs	w4, w4, #0x2
umull	v4.8h, v4.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
st1	{ v4.8b }, [x0], x7
st1	{ v4.d }[1], [x8], x7
b.gt	L_6ec4
ret
L_6ef8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
L_6f08:
ld1	{ v4.16b }, [x1], x2
ld1	{ v6.16b }, [x9], x2
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v7.16b, v6.16b, v6.16b, #0x1
subs	w4, w4, #0x2
umull	v4.8h, v4.8b, v0.8b
umull	v6.8h, v6.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
umlal	v6.8h, v7.8b, v1.8b
st1	{ v4.8h }, [x0], x7
st1	{ v6.8h }, [x8], x7
b.gt	L_6f08
ret
L_6f3c:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sub	x2, x2, w3, uxtw
sub	x2, x2, #0x8
L_6f50:
ld1	{ v16.d }[1], [x1], #8
ld1	{ v20.d }[1], [x9], #8
mov	w5, w3
L_6f5c:
ld1	{ v18.16b }, [x1], #16
ld1	{ v22.16b }, [x9], #16
ext	v17.16b, v16.16b, v18.16b, #0x8
ext	v19.16b, v16.16b, v18.16b, #0x9
ext	v21.16b, v20.16b, v22.16b, #0x8
ext	v23.16b, v20.16b, v22.16b, #0x9
umull	v16.8h, v17.8b, v0.8b
umull2	v17.8h, v17.16b, v0.16b
umull	v20.8h, v21.8b, v0.8b
umull2	v21.8h, v21.16b, v0.16b
umlal	v16.8h, v19.8b, v1.8b
umlal2	v17.8h, v19.16b, v1.16b
umlal	v20.8h, v23.8b, v1.8b
umlal2	v21.8h, v23.16b, v1.16b
subs	w5, w5, #0x10
st1	{ v16.8h, v17.8h }, [x0], #32
st1	{ v20.8h, v21.8h }, [x8], #32
b.le	L_6fb0
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
b	L_6f5c
L_6fb0:
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #0x2
b.gt	L_6f50
ret
L_6fcc:
cmp	w4, #0x4
adrp	x9, prep_bilin_v_tbl
add	x9, x9, :lo12:prep_bilin_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_6fe4:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1r	{ v16.4s }, [x1], x2
L_6ff8:
ld1r	{ v17.4s }, [x9], x2
ld1r	{ v18.4s }, [x1], x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
subs	w4, w4, #0x2
st1	{ v4.8b }, [x0], x7
st1	{ v4.d }[1], [x8], x7
b.le	L_7028
mov	v16.8b, v18.8b
b	L_6ff8
L_7028:
ret
L_702c:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.8b }, [x1], x2
L_7040:
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
umull	v4.8h, v16.8b, v2.8b
umull	v5.8h, v17.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
umlal	v5.8h, v18.8b, v3.8b
subs	w4, w4, #0x2
st1	{ v4.8h }, [x0], x7
st1	{ v5.8h }, [x8], x7
b.le	L_7070
mov	v16.8b, v18.8b
b	L_7040
L_7070:
ret
L_7074:
mov	w6, w4
L_7078:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.16b }, [x1], x2
L_708c:
ld1	{ v17.16b }, [x9], x2
ld1	{ v18.16b }, [x1], x2
umull	v4.8h, v16.8b, v2.8b
umull2	v5.8h, v16.16b, v2.16b
umull	v6.8h, v17.8b, v2.8b
umull2	v7.8h, v17.16b, v2.16b
umlal	v4.8h, v17.8b, v3.8b
umlal2	v5.8h, v17.16b, v3.16b
umlal	v6.8h, v18.8b, v3.8b
umlal2	v7.8h, v18.16b, v3.16b
subs	w4, w4, #0x2
st1	{ v4.8h, v5.8h }, [x0], x7
st1	{ v6.8h, v7.8h }, [x8], x7
b.le	L_70cc
mov	v16.16b, v18.16b
b	L_708c
L_70cc:
subs	w3, w3, #0x10
b.le	L_70f8
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x20
b	L_7078
L_70f8:
ret
L_70fc:
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
adrp	x9, prep_bilin_hv_tbl
add	x9, x9, :lo12:prep_bilin_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
L_7118:
add	x9, x1, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v28.8b }, [x1], x2
ext	v29.8b, v28.8b, v28.8b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
L_7138:
ld1	{ v28.8b }, [x9], x2
ld1	{ v30.8b }, [x1], x2
ext	v29.8b, v28.8b, v28.8b, #0x1
ext	v31.8b, v30.8b, v30.8b, #0x1
trn1	v28.2s, v28.2s, v30.2s
trn1	v29.2s, v29.2s, v31.2s
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
trn1	v16.2d, v16.2d, v17.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
subs	w4, w4, #0x2
urshr	v4.8h, v4.8h, #0x4
st1	{ v4.8b }, [x0], x7
st1	{ v4.d }[1], [x8], x7
b.le	L_7180
trn2	v16.2d, v17.2d, v17.2d
b	L_7138
L_7180:
ret
L_7184:
mov	w6, w4
L_7188:
add	x9, x1, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v28.16b }, [x1], x2
ext	v29.16b, v28.16b, v28.16b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
L_71a8:
ld1	{ v28.16b }, [x9], x2
ld1	{ v30.16b }, [x1], x2
ext	v29.16b, v28.16b, v28.16b, #0x1
ext	v31.16b, v30.16b, v30.16b, #0x1
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
umull	v18.8h, v30.8b, v0.8b
umlal	v18.8h, v31.8b, v1.8b
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v18.8h, v3.8h
subs	w4, w4, #0x2
urshr	v4.8h, v4.8h, #0x4
urshr	v5.8h, v5.8h, #0x4
st1	{ v4.8h }, [x0], x7
st1	{ v5.8h }, [x8], x7
b.le	L_71f8
mov	v16.16b, v18.16b
b	L_71a8
L_71f8:
subs	w3, w3, #0x8
b.le	L_7224
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	L_7188
L_7224:
ret
warp_filter_horz_neon:
add	w12, w5, #0x200
ld1	{ v16.8b, v17.8b }, [x2], x3
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
eor	v16.8b, v16.8b, v22.8b
eor	v17.8b, v17.8b, v22.8b
asr	w13, w12, #10
add	w12, w12, w7
ldr	d7, [x11, w13, sxtw #3]
ext	v18.8b, v16.8b, v17.8b, #0x1
ext	v19.8b, v16.8b, v17.8b, #0x2
smull	v0.8h, v0.8b, v16.8b
smull	v1.8h, v1.8b, v18.8b
ext	v18.8b, v16.8b, v17.8b, #0x3
ext	v20.8b, v16.8b, v17.8b, #0x4
smull	v2.8h, v2.8b, v19.8b
smull	v3.8h, v3.8b, v18.8b
ext	v18.8b, v16.8b, v17.8b, #0x5
ext	v19.8b, v16.8b, v17.8b, #0x6
smull	v4.8h, v4.8b, v20.8b
smull	v5.8h, v5.8b, v18.8b
ext	v18.8b, v16.8b, v17.8b, #0x7
smull	v6.8h, v6.8b, v19.8b
smull	v7.8h, v7.8b, v18.8b
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
addp	v0.8h, v0.8h, v2.8h
addp	v4.8h, v4.8h, v6.8h
addp	v0.8h, v0.8h, v4.8h
add	w5, w5, w8
ret
warp_affine_8x8_8bpc_neon:
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #0x8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #0x3
adrp	x11, mc_warp_filter+512
add	x11, x11, :lo12:mc_warp_filter+512
mov	x15, x30
movi	v22.8b, #0x80
movi	v23.8h, #0x80
bl	warp_filter_horz_neon
srshr	v24.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v25.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v26.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v27.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v28.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v29.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v30.8h, v0.8h, #0x3
L_7368:
add	w14, w6, #0x200
bl	warp_filter_horz_neon
srshr	v31.8h, v0.8h, #0x3
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
zip1	v0.16b, v0.16b, v1.16b
zip1	v2.16b, v2.16b, v3.16b
zip1	v4.16b, v4.16b, v5.16b
zip1	v6.16b, v6.16b, v7.16b
trn1	v1.8h, v0.8h, v2.8h
trn2	v3.8h, v0.8h, v2.8h
trn1	v5.8h, v4.8h, v6.8h
trn2	v7.8h, v4.8h, v6.8h
trn1	v0.4s, v1.4s, v5.4s
trn2	v2.4s, v1.4s, v5.4s
trn1	v1.4s, v3.4s, v7.4s
trn2	v3.4s, v3.4s, v7.4s
sshll2	v4.8h, v0.16b, #0x0
sshll	v0.8h, v0.8b, #0x0
sshll2	v6.8h, v2.16b, #0x0
sshll	v2.8h, v2.8b, #0x0
sshll2	v5.8h, v1.16b, #0x0
sshll	v1.8h, v1.8b, #0x0
sshll2	v7.8h, v3.16b, #0x0
sshll	v3.8h, v3.8b, #0x0
smull	v16.4s, v24.4h, v0.4h
smlal	v16.4s, v25.4h, v1.4h
smlal	v16.4s, v26.4h, v2.4h
smlal	v16.4s, v27.4h, v3.4h
smlal	v16.4s, v28.4h, v4.4h
smlal	v16.4s, v29.4h, v5.4h
smlal	v16.4s, v30.4h, v6.4h
smlal	v16.4s, v31.4h, v7.4h
smull2	v17.4s, v24.8h, v0.8h
smlal2	v17.4s, v25.8h, v1.8h
smlal2	v17.4s, v26.8h, v2.8h
smlal2	v17.4s, v27.8h, v3.8h
smlal2	v17.4s, v28.8h, v4.8h
smlal2	v17.4s, v29.8h, v5.8h
smlal2	v17.4s, v30.8h, v6.8h
smlal2	v17.4s, v31.8h, v7.8h
mov	v24.16b, v25.16b
mov	v25.16b, v26.16b
sqrshrn	v16.4h, v16.4s, #0xb
mov	v26.16b, v27.16b
sqrshrn2	v16.8h, v17.4s, #0xb
mov	v27.16b, v28.16b
mov	v28.16b, v29.16b
add	v16.8h, v16.8h, v23.8h
sqxtun	v16.8b, v16.8h
mov	v29.16b, v30.16b
mov	v30.16b, v31.16b
subs	w10, w10, #0x1
st1	{ v16.8b }, [x0], x1
add	w6, w6, w4
b.gt	L_7368
ret	x15
warp_affine_8x8t_8bpc_neon:
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #0x8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #0x3
adrp	x11, mc_warp_filter+512
add	x11, x11, :lo12:mc_warp_filter+512
mov	x15, x30
lsl	x1, x1, #1
movi	v22.8b, #0x80
movi	v23.8h, #0x8, lsl #8
bl	warp_filter_horz_neon
srshr	v24.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v25.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v26.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v27.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v28.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v29.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v30.8h, v0.8h, #0x3
L_7518:
add	w14, w6, #0x200
bl	warp_filter_horz_neon
srshr	v31.8h, v0.8h, #0x3
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
zip1	v0.16b, v0.16b, v1.16b
zip1	v2.16b, v2.16b, v3.16b
zip1	v4.16b, v4.16b, v5.16b
zip1	v6.16b, v6.16b, v7.16b
trn1	v1.8h, v0.8h, v2.8h
trn2	v3.8h, v0.8h, v2.8h
trn1	v5.8h, v4.8h, v6.8h
trn2	v7.8h, v4.8h, v6.8h
trn1	v0.4s, v1.4s, v5.4s
trn2	v2.4s, v1.4s, v5.4s
trn1	v1.4s, v3.4s, v7.4s
trn2	v3.4s, v3.4s, v7.4s
sshll2	v4.8h, v0.16b, #0x0
sshll	v0.8h, v0.8b, #0x0
sshll2	v6.8h, v2.16b, #0x0
sshll	v2.8h, v2.8b, #0x0
sshll2	v5.8h, v1.16b, #0x0
sshll	v1.8h, v1.8b, #0x0
sshll2	v7.8h, v3.16b, #0x0
sshll	v3.8h, v3.8b, #0x0
smull	v16.4s, v24.4h, v0.4h
smlal	v16.4s, v25.4h, v1.4h
smlal	v16.4s, v26.4h, v2.4h
smlal	v16.4s, v27.4h, v3.4h
smlal	v16.4s, v28.4h, v4.4h
smlal	v16.4s, v29.4h, v5.4h
smlal	v16.4s, v30.4h, v6.4h
smlal	v16.4s, v31.4h, v7.4h
smull2	v17.4s, v24.8h, v0.8h
smlal2	v17.4s, v25.8h, v1.8h
smlal2	v17.4s, v26.8h, v2.8h
smlal2	v17.4s, v27.8h, v3.8h
smlal2	v17.4s, v28.8h, v4.8h
smlal2	v17.4s, v29.8h, v5.8h
smlal2	v17.4s, v30.8h, v6.8h
smlal2	v17.4s, v31.8h, v7.8h
mov	v24.16b, v25.16b
mov	v25.16b, v26.16b
sqrshrn	v16.4h, v16.4s, #0x7
mov	v26.16b, v27.16b
sqrshrn2	v16.8h, v17.4s, #0x7
mov	v27.16b, v28.16b
mov	v28.16b, v29.16b
add	v16.8h, v16.8h, v23.8h
mov	v29.16b, v30.16b
mov	v30.16b, v31.16b
subs	w10, w10, #0x1
st1	{ v16.8h }, [x0], x1
add	w6, w6, w4
b.gt	L_7518
ret	x15
emu_edge_8bpc_neon:
ldp	x8, x9, [sp]
sub	x12, x3, #0x1
cmp	x5, x3
sub	x13, x2, #0x1
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
sub	x12, x1, #0x1
cmp	x10, x1
bic	x5, x5, x5, asr #63
csel	x10, x10, x12, lt
cmp	x5, x1
bic	x10, x10, x10, asr #63
csel	x5, x5, x12, lt
add	x11, x4, x0
neg	x4, x4
sub	x11, x11, x2
sub	x13, x0, #0x1
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
cbz	x4, L_7758
cbz	x11, L_77b0
L_76ec:
ld1r	{ v0.16b }, [x8]
mov	x12, x6
mov	x3, x4
L_76f8:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	L_76f8
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
L_7710:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	L_7710
add	x3, x8, x2
sub	x3, x3, #0x1
add	x12, x6, x4
ld1r	{ v0.16b }, [x3]
add	x12, x12, x2
mov	x3, x11
L_7738:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	L_7738
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_76ec
b	L_7824
L_7758:
cbz	x11, L_77f8
L_775c:
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
L_7768:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	L_7768
add	x3, x8, x2
sub	x3, x3, #0x1
add	x12, x6, x4
ld1r	{ v0.16b }, [x3]
add	x12, x12, x2
mov	x3, x11
L_7790:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	L_7790
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_775c
b	L_7824
L_77b0:
ld1r	{ v0.16b }, [x8]
mov	x12, x6
mov	x3, x4
L_77bc:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	L_77bc
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
L_77d4:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	L_77d4
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_77b0
b	L_7824
L_77f8:
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
L_7804:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	L_7804
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_77f8
L_7824:
cbz	x10, L_7854
sub	x8, x6, x7
mov	x4, x0
L_7830:
ld1	{ v0.16b, v1.16b }, [x8], #32
mov	x3, x10
L_7838:
subs	x3, x3, #0x1
st1	{ v0.16b, v1.16b }, [x6], x7
b.gt	L_7838
msub	x6, x7, x10, x6
subs	x4, x4, #0x20
add	x6, x6, #0x20
b.gt	L_7830
L_7854:
cbz	x5, L_7880
msub	x6, x7, x5, x14
L_785c:
ld1	{ v0.16b, v1.16b }, [x14], #32
mov	x3, x5
L_7864:
subs	x3, x3, #0x1
st1	{ v0.16b, v1.16b }, [x6], x7
b.gt	L_7864
msub	x6, x7, x5, x6
subs	x0, x0, #0x20
add	x6, x6, #0x20
b.gt	L_785c
L_7880:
ret
	.section *UND*
	.section .rodata
avg_tbl:
	.size avg_tbl, 24
	.word L_300 - avg_tbl
	.word L_224 - avg_tbl
	.word L_1a8 - avg_tbl
	.word L_12c - avg_tbl
	.word L_d8 - avg_tbl
	.word L_34 - avg_tbl
w_avg_tbl:
	.size w_avg_tbl, 24
	.word L_848 - w_avg_tbl
	.word L_6ec - w_avg_tbl
	.word L_630 - w_avg_tbl
	.word L_574 - w_avg_tbl
	.word L_500 - w_avg_tbl
	.word L_42c - w_avg_tbl
mask_tbl:
	.size mask_tbl, 24
	.word L_f68 - mask_tbl
	.word L_d8c - mask_tbl
	.word L_c90 - mask_tbl
	.word L_b94 - mask_tbl
	.word L_b00 - mask_tbl
	.word L_9fc - mask_tbl
w_mask_444_tbl:
	.size w_mask_444_tbl, 24
	.word L_124c - w_mask_444_tbl
	.word L_124c - w_mask_444_tbl
	.word L_124c - w_mask_444_tbl
	.word L_124c - w_mask_444_tbl
	.word L_11e4 - w_mask_444_tbl
	.word L_1174 - w_mask_444_tbl
w_mask_422_tbl:
	.size w_mask_422_tbl, 24
	.word L_1460 - w_mask_422_tbl
	.word L_1460 - w_mask_422_tbl
	.word L_1460 - w_mask_422_tbl
	.word L_1460 - w_mask_422_tbl
	.word L_13f4 - w_mask_422_tbl
	.word L_1380 - w_mask_422_tbl
w_mask_420_tbl:
	.size w_mask_420_tbl, 24
	.word L_168c - w_mask_420_tbl
	.word L_168c - w_mask_420_tbl
	.word L_168c - w_mask_420_tbl
	.word L_168c - w_mask_420_tbl
	.word L_161c - w_mask_420_tbl
	.word L_159c - w_mask_420_tbl
blend_tbl:
	.size blend_tbl, 16
	.word L_1874 - blend_tbl
	.word L_1818 - blend_tbl
	.word L_17d8 - blend_tbl
	.word L_17a4 - blend_tbl
blend_h_tbl:
	.size blend_h_tbl, 28
	.word L_1a50 - blend_h_tbl
	.word L_1a50 - blend_h_tbl
	.word L_1a50 - blend_h_tbl
	.word L_19f4 - blend_h_tbl
	.word L_19b0 - blend_h_tbl
	.word L_1978 - blend_h_tbl
	.word L_1940 - blend_h_tbl
blend_v_tbl:
	.size blend_v_tbl, 20
	.word L_1c68 - blend_v_tbl
	.word L_1c04 - blend_v_tbl
	.word L_1bb4 - blend_v_tbl
	.word L_1b74 - blend_v_tbl
	.word L_1b38 - blend_v_tbl
put_tbl:
	.size put_tbl, 28
	.word L_1ddc - put_tbl
	.word L_1db8 - put_tbl
	.word L_1d8c - put_tbl
	.word L_1d68 - put_tbl
	.word L_1d44 - put_tbl
	.word L_1d20 - put_tbl
	.word L_1cfc - put_tbl
prep_tbl:
	.size prep_tbl, 24
	.word L_1f94 - prep_tbl
	.word L_1f48 - prep_tbl
	.word L_1ef8 - prep_tbl
	.word L_1ea0 - prep_tbl
	.word L_1e60 - prep_tbl
	.word L_1e28 - prep_tbl
put_8tap_h_tbl:
	.size put_8tap_h_tbl, 28
	.word L_2290 - put_8tap_h_tbl
	.word L_2290 - put_8tap_h_tbl
	.word L_2290 - put_8tap_h_tbl
	.word L_2290 - put_8tap_h_tbl
	.word L_21c0 - put_8tap_h_tbl
	.word L_2130 - put_8tap_h_tbl
	.word L_20c0 - put_8tap_h_tbl
put_8tap_v_tbl:
	.size put_8tap_v_tbl, 28
	.word L_2a38 - put_8tap_v_tbl
	.word L_2a38 - put_8tap_v_tbl
	.word L_2a38 - put_8tap_v_tbl
	.word L_2d2c - put_8tap_v_tbl
	.word L_2974 - put_8tap_v_tbl
	.word L_26a0 - put_8tap_v_tbl
	.word L_2468 - put_8tap_v_tbl
put_8tap_hv_tbl:
	.size put_8tap_hv_tbl, 28
	.word L_3328 - put_8tap_hv_tbl
	.word L_3328 - put_8tap_hv_tbl
	.word L_323c - put_8tap_hv_tbl
	.word L_323c - put_8tap_hv_tbl
	.word L_323c - put_8tap_hv_tbl
	.word L_3028 - put_8tap_hv_tbl
	.word L_2e88 - put_8tap_hv_tbl
put_6tap_h_tbl:
	.size put_6tap_h_tbl, 28
	.word L_37b8 - put_6tap_h_tbl
	.word L_37b8 - put_6tap_h_tbl
	.word L_37b8 - put_6tap_h_tbl
	.word L_37b8 - put_6tap_h_tbl
	.word L_3708 - put_6tap_h_tbl
	.word L_3678 - put_6tap_h_tbl
	.word L_3608 - put_6tap_h_tbl
put_6tap_v_tbl:
	.size put_6tap_v_tbl, 28
	.word L_3ee0 - put_6tap_v_tbl
	.word L_3ee0 - put_6tap_v_tbl
	.word L_3ee0 - put_6tap_v_tbl
	.word L_4174 - put_6tap_v_tbl
	.word L_3e1c - put_6tap_v_tbl
	.word L_3b78 - put_6tap_v_tbl
	.word L_3950 - put_6tap_v_tbl
put_6tap_hv_tbl:
	.size put_6tap_hv_tbl, 28
	.word L_4744 - put_6tap_hv_tbl
	.word L_4744 - put_6tap_hv_tbl
	.word L_4658 - put_6tap_hv_tbl
	.word L_4658 - put_6tap_hv_tbl
	.word L_4658 - put_6tap_hv_tbl
	.word L_4468 - put_6tap_hv_tbl
	.word L_42d0 - put_6tap_hv_tbl
put_bilin_h_tbl:
	.size put_bilin_h_tbl, 28
	.word L_4a4c - put_bilin_h_tbl
	.word L_4a4c - put_bilin_h_tbl
	.word L_4a4c - put_bilin_h_tbl
	.word L_4a4c - put_bilin_h_tbl
	.word L_4a00 - put_bilin_h_tbl
	.word L_49b8 - put_bilin_h_tbl
	.word L_4970 - put_bilin_h_tbl
put_bilin_v_tbl:
	.size put_bilin_v_tbl, 28
	.word L_4c4c - put_bilin_v_tbl
	.word L_4c4c - put_bilin_v_tbl
	.word L_4c4c - put_bilin_v_tbl
	.word L_4c4c - put_bilin_v_tbl
	.word L_4bfc - put_bilin_v_tbl
	.word L_4bb0 - put_bilin_v_tbl
	.word L_4b0c - put_bilin_v_tbl
put_bilin_hv_tbl:
	.size put_bilin_hv_tbl, 28
	.word L_4dd8 - put_bilin_hv_tbl
	.word L_4dd8 - put_bilin_hv_tbl
	.word L_4dd8 - put_bilin_hv_tbl
	.word L_4dd8 - put_bilin_hv_tbl
	.word L_4dd8 - put_bilin_hv_tbl
	.word L_4d6c - put_bilin_hv_tbl
	.word L_4d00 - put_bilin_hv_tbl
prep_8tap_h_tbl:
	.size prep_8tap_h_tbl, 28
	.word L_5074 - prep_8tap_h_tbl
	.word L_5074 - prep_8tap_h_tbl
	.word L_5074 - prep_8tap_h_tbl
	.word L_5074 - prep_8tap_h_tbl
	.word L_4fac - prep_8tap_h_tbl
	.word L_4f2c - prep_8tap_h_tbl
	.word L_4f2c - prep_8tap_h_tbl
prep_8tap_v_tbl:
	.size prep_8tap_v_tbl, 28
	.word L_55cc - prep_8tap_v_tbl
	.word L_55cc - prep_8tap_v_tbl
	.word L_55cc - prep_8tap_v_tbl
	.word L_58c0 - prep_8tap_v_tbl
	.word L_5508 - prep_8tap_v_tbl
	.word L_5234 - prep_8tap_v_tbl
	.word L_5234 - prep_8tap_v_tbl
prep_8tap_hv_tbl:
	.size prep_8tap_hv_tbl, 28
	.word L_5cf4 - prep_8tap_hv_tbl
	.word L_5cf4 - prep_8tap_hv_tbl
	.word L_5c10 - prep_8tap_hv_tbl
	.word L_5c10 - prep_8tap_hv_tbl
	.word L_5c10 - prep_8tap_hv_tbl
	.word L_5a1c - prep_8tap_hv_tbl
	.word L_5a1c - prep_8tap_hv_tbl
prep_6tap_h_tbl:
	.size prep_6tap_h_tbl, 28
	.word L_60fc - prep_6tap_h_tbl
	.word L_60fc - prep_6tap_h_tbl
	.word L_60fc - prep_6tap_h_tbl
	.word L_60fc - prep_6tap_h_tbl
	.word L_6054 - prep_6tap_h_tbl
	.word L_5fd4 - prep_6tap_h_tbl
	.word L_5fd4 - prep_6tap_h_tbl
prep_6tap_v_tbl:
	.size prep_6tap_v_tbl, 28
	.word L_65e4 - prep_6tap_v_tbl
	.word L_65e4 - prep_6tap_v_tbl
	.word L_65e4 - prep_6tap_v_tbl
	.word L_6878 - prep_6tap_v_tbl
	.word L_6520 - prep_6tap_v_tbl
	.word L_627c - prep_6tap_v_tbl
	.word L_627c - prep_6tap_v_tbl
prep_6tap_hv_tbl:
	.size prep_6tap_hv_tbl, 28
	.word L_6c88 - prep_6tap_hv_tbl
	.word L_6c88 - prep_6tap_hv_tbl
	.word L_6ba4 - prep_6tap_hv_tbl
	.word L_6ba4 - prep_6tap_hv_tbl
	.word L_6ba4 - prep_6tap_hv_tbl
	.word L_69d4 - prep_6tap_hv_tbl
	.word L_69d4 - prep_6tap_hv_tbl
prep_bilin_h_tbl:
	.size prep_bilin_h_tbl, 28
	.word L_6f3c - prep_bilin_h_tbl
	.word L_6f3c - prep_bilin_h_tbl
	.word L_6f3c - prep_bilin_h_tbl
	.word L_6f3c - prep_bilin_h_tbl
	.word L_6ef8 - prep_bilin_h_tbl
	.word L_6eb4 - prep_bilin_h_tbl
	.word L_6eb4 - prep_bilin_h_tbl
prep_bilin_v_tbl:
	.size prep_bilin_v_tbl, 28
	.word L_7074 - prep_bilin_v_tbl
	.word L_7074 - prep_bilin_v_tbl
	.word L_7074 - prep_bilin_v_tbl
	.word L_7074 - prep_bilin_v_tbl
	.word L_702c - prep_bilin_v_tbl
	.word L_6fe4 - prep_bilin_v_tbl
	.word L_6fe4 - prep_bilin_v_tbl
prep_bilin_hv_tbl:
	.size prep_bilin_hv_tbl, 28
	.word L_7184 - prep_bilin_hv_tbl
	.word L_7184 - prep_bilin_hv_tbl
	.word L_7184 - prep_bilin_hv_tbl
	.word L_7184 - prep_bilin_hv_tbl
	.word L_7184 - prep_bilin_hv_tbl
	.word L_7118 - prep_bilin_hv_tbl
	.word L_7118 - prep_bilin_hv_tbl
