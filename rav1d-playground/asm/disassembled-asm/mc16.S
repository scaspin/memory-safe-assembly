	.text
avg_16bpc_neon:
clz	w4, w4
clz	w7, w6
sub	w7, w7, #0x12
mov	w9, #0x1
mov	w8, #-0x4000
lsl	w9, w9, w7
add	w7, w7, #0x1
sub	w8, w8, w9
neg	w7, w7
dup	v28.8h, w8
dup	v29.8h, w7
adrp	x7, avg_tbl
add	x7, x7, :lo12:avg_tbl
sub	w4, w4, #0x18
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
ldrsw	x4, [x7, x4, lsl #2]
add	x7, x7, x4
br	x7
L_6c:
add	x7, x0, x1
lsl	x1, x1, #1
L_74:
subs	w5, w5, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
st1	{ v5.d }[1], [x7], x1
b.le	L_3e0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
b	L_74
L_b8:
add	x7, x0, x1
lsl	x1, x1, #1
L_c0:
st1	{ v4.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.8h }, [x7], x1
b.le	L_3e0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
b	L_c0
L_fc:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v6.8h, v0.8h, v29.8h
sshl	v7.8h, v1.8h, v29.8h
st1	{ v4.8h, v5.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v6.8h, v7.8h }, [x0], x1
b.le	L_3e0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
b	L_fc
L_160:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v6.8h, v0.8h, v29.8h
sshl	v7.8h, v1.8h, v29.8h
subs	w5, w5, #0x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
b.le	L_3e0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
b	L_160
L_1c0:
add	x7, x0, #0x40
L_1c4:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v6.8h, v0.8h, v29.8h
sshl	v7.8h, v1.8h, v29.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v16.8h, v0.8h, v29.8h
sshl	v17.8h, v1.8h, v29.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v18.8h, v0.8h, v29.8h
sshl	v19.8h, v1.8h, v29.8h
subs	w5, w5, #0x1
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x1
b.le	L_3e0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
b	L_1c4
L_278:
add	x7, x0, #0x40
mov	x8, #0x80
sub	x1, x1, #0x80
L_284:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v6.8h, v0.8h, v29.8h
sshl	v7.8h, v1.8h, v29.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v16.8h, v0.8h, v29.8h
sshl	v17.8h, v1.8h, v29.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v18.8h, v0.8h, v29.8h
sshl	v19.8h, v1.8h, v29.8h
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v6.8h, v0.8h, v29.8h
sshl	v7.8h, v1.8h, v29.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v16.8h, v0.8h, v29.8h
sshl	v17.8h, v1.8h, v29.8h
subs	w5, w5, #0x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v18.8h, v0.8h, v29.8h
sshl	v19.8h, v1.8h, v29.8h
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x1
b.le	L_3e0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sqadd	v0.8h, v0.8h, v2.8h
sqadd	v1.8h, v1.8h, v3.8h
smax	v0.8h, v0.8h, v28.8h
smax	v1.8h, v1.8h, v28.8h
sqsub	v0.8h, v0.8h, v28.8h
sqsub	v1.8h, v1.8h, v28.8h
sshl	v4.8h, v0.8h, v29.8h
sshl	v5.8h, v1.8h, v29.8h
b	L_284
L_3e0:
ret
w_avg_16bpc_neon:
clz	w4, w4
dup	v31.8h, w7
movi	v30.8h, #0x0
clz	w7, w7
sub	w7, w7, #0x12
mov	w8, #0x2000
lsr	w8, w8, w7
neg	w7, w7
dup	v28.8h, w8
dup	v29.8h, w7
dup	v27.4s, w6
neg	v27.4s, v27.4s
adrp	x7, w_avg_tbl
add	x7, x7, :lo12:w_avg_tbl
sub	w4, w4, #0x18
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
ldrsw	x4, [x7, x4, lsl #2]
add	x7, x7, x4
br	x7
L_49c:
add	x7, x0, x1
lsl	x1, x1, #1
L_4a4:
subs	w5, w5, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
st1	{ v5.d }[1], [x7], x1
b.le	L_d20
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_4a4
L_530:
add	x7, x0, x1
lsl	x1, x1, #1
L_538:
st1	{ v4.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.8h }, [x7], x1
b.le	L_d20
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_538
L_5bc:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v7.4s, v7.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v7.4s, v7.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
st1	{ v4.8h, v5.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v6.8h, v7.8h }, [x0], x1
b.le	L_d20
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_5bc
L_6b0:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v7.4s, v7.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v7.4s, v7.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
subs	w5, w5, #0x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
b.le	L_d20
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_6b0
L_7a0:
add	x7, x0, #0x40
L_7a4:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v7.4s, v7.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v7.4s, v7.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v16.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v17.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v16.4s, v16.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v17.4s, v17.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v16.4s, v16.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v17.4s, v17.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v16.4s, v16.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v17.4s, v17.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v16.8h, v16.8h, v0.8h
uzp1	v17.8h, v17.8h, v1.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
add	v16.8h, v16.8h, v28.8h
add	v17.8h, v17.8h, v28.8h
smin	v16.8h, v16.8h, v31.8h
smin	v17.8h, v17.8h, v31.8h
smax	v16.8h, v16.8h, v30.8h
smax	v17.8h, v17.8h, v30.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v18.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v19.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v18.4s, v18.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v19.4s, v19.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v18.4s, v18.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v19.4s, v19.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v18.4s, v18.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v19.4s, v19.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v18.8h, v18.8h, v0.8h
uzp1	v19.8h, v19.8h, v1.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
add	v18.8h, v18.8h, v28.8h
add	v19.8h, v19.8h, v28.8h
smin	v18.8h, v18.8h, v31.8h
smin	v19.8h, v19.8h, v31.8h
smax	v18.8h, v18.8h, v30.8h
smax	v19.8h, v19.8h, v30.8h
subs	w5, w5, #0x1
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x1
b.le	L_d20
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_7a4
L_978:
add	x7, x0, #0x40
mov	x8, #0x80
sub	x1, x1, #0x80
L_984:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v7.4s, v7.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v7.4s, v7.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v16.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v17.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v16.4s, v16.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v17.4s, v17.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v16.4s, v16.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v17.4s, v17.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v16.4s, v16.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v17.4s, v17.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v16.8h, v16.8h, v0.8h
uzp1	v17.8h, v17.8h, v1.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
add	v16.8h, v16.8h, v28.8h
add	v17.8h, v17.8h, v28.8h
smin	v16.8h, v16.8h, v31.8h
smin	v17.8h, v17.8h, v31.8h
smax	v16.8h, v16.8h, v30.8h
smax	v17.8h, v17.8h, v30.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v18.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v19.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v18.4s, v18.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v19.4s, v19.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v18.4s, v18.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v19.4s, v19.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v18.4s, v18.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v19.4s, v19.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v18.8h, v18.8h, v0.8h
uzp1	v19.8h, v19.8h, v1.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
add	v18.8h, v18.8h, v28.8h
add	v19.8h, v19.8h, v28.8h
smin	v18.8h, v18.8h, v31.8h
smin	v19.8h, v19.8h, v31.8h
smax	v18.8h, v18.8h, v30.8h
smax	v19.8h, v19.8h, v30.8h
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v7.4s, v7.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v7.4s, v7.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v16.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v17.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v16.4s, v16.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v17.4s, v17.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v16.4s, v16.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v17.4s, v17.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v16.4s, v16.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v17.4s, v17.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v16.8h, v16.8h, v0.8h
uzp1	v17.8h, v17.8h, v1.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
add	v16.8h, v16.8h, v28.8h
add	v17.8h, v17.8h, v28.8h
smin	v16.8h, v16.8h, v31.8h
smin	v17.8h, v17.8h, v31.8h
smax	v16.8h, v16.8h, v30.8h
smax	v17.8h, v17.8h, v30.8h
subs	w5, w5, #0x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v18.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v19.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v18.4s, v18.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v19.4s, v19.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v18.4s, v18.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v19.4s, v19.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v18.4s, v18.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v19.4s, v19.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v18.8h, v18.8h, v0.8h
uzp1	v19.8h, v19.8h, v1.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
add	v18.8h, v18.8h, v28.8h
add	v19.8h, v19.8h, v28.8h
smin	v18.8h, v18.8h, v31.8h
smin	v19.8h, v19.8h, v31.8h
smax	v18.8h, v18.8h, v30.8h
smax	v19.8h, v19.8h, v30.8h
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x1
b.le	L_d20
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v27.4s
mul	v0.4s, v0.4s, v27.4s
mul	v5.4s, v5.4s, v27.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x4
sshr	v0.4s, v0.4s, #0x4
sshr	v5.4s, v5.4s, #0x4
sshr	v1.4s, v1.4s, #0x4
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_984
L_d20:
ret
mask_16bpc_neon:
clz	w4, w4
dup	v31.8h, w7
movi	v30.8h, #0x0
clz	w7, w7
sub	w7, w7, #0x12
mov	w8, #0x2000
lsr	w8, w8, w7
neg	w7, w7
dup	v28.8h, w8
dup	v29.8h, w7
adrp	x7, mask_tbl
add	x7, x7, :lo12:mask_tbl
sub	w4, w4, #0x18
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
ldrsw	x4, [x7, x4, lsl #2]
add	x7, x7, x4
br	x7
L_df4:
add	x7, x0, x1
lsl	x1, x1, #1
L_dfc:
subs	w5, w5, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
st1	{ v5.d }[1], [x7], x1
b.le	L_18b8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_dfc
L_ea8:
add	x7, x0, x1
lsl	x1, x1, #1
L_eb0:
st1	{ v4.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.8h }, [x7], x1
b.le	L_18b8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_eb0
L_f54:
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v7.4s, v7.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v7.4s, v7.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
st1	{ v4.8h, v5.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v6.8h, v7.8h }, [x0], x1
b.le	L_18b8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_f54
L_1088:
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v7.4s, v7.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v7.4s, v7.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
subs	w5, w5, #0x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
b.le	L_18b8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_1088
L_11b8:
add	x7, x0, #0x40
L_11bc:
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v7.4s, v7.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v7.4s, v7.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v16.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v17.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v16.4s, v16.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v17.4s, v17.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v16.4s, v16.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v17.4s, v17.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v16.4s, v16.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v17.4s, v17.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v16.8h, v16.8h, v0.8h
uzp1	v17.8h, v17.8h, v1.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
add	v16.8h, v16.8h, v28.8h
add	v17.8h, v17.8h, v28.8h
smin	v16.8h, v16.8h, v31.8h
smin	v17.8h, v17.8h, v31.8h
smax	v16.8h, v16.8h, v30.8h
smax	v17.8h, v17.8h, v30.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v18.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v19.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v18.4s, v18.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v19.4s, v19.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v18.4s, v18.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v19.4s, v19.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v18.4s, v18.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v19.4s, v19.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v18.8h, v18.8h, v0.8h
uzp1	v19.8h, v19.8h, v1.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
add	v18.8h, v18.8h, v28.8h
add	v19.8h, v19.8h, v28.8h
smin	v18.8h, v18.8h, v31.8h
smin	v19.8h, v19.8h, v31.8h
smax	v18.8h, v18.8h, v30.8h
smax	v19.8h, v19.8h, v30.8h
subs	w5, w5, #0x1
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x1
b.le	L_18b8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_11bc
L_1410:
add	x7, x0, #0x40
mov	x8, #0x80
sub	x1, x1, #0x80
L_141c:
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v7.4s, v7.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v7.4s, v7.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v16.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v17.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v16.4s, v16.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v17.4s, v17.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v16.4s, v16.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v17.4s, v17.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v16.4s, v16.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v17.4s, v17.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v16.8h, v16.8h, v0.8h
uzp1	v17.8h, v17.8h, v1.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
add	v16.8h, v16.8h, v28.8h
add	v17.8h, v17.8h, v28.8h
smin	v16.8h, v16.8h, v31.8h
smin	v17.8h, v17.8h, v31.8h
smax	v16.8h, v16.8h, v30.8h
smax	v17.8h, v17.8h, v30.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v18.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v19.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v18.4s, v18.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v19.4s, v19.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v18.4s, v18.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v19.4s, v19.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v18.4s, v18.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v19.4s, v19.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v18.8h, v18.8h, v0.8h
uzp1	v19.8h, v19.8h, v1.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
add	v18.8h, v18.8h, v28.8h
add	v19.8h, v19.8h, v28.8h
smin	v18.8h, v18.8h, v31.8h
smin	v19.8h, v19.8h, v31.8h
smax	v18.8h, v18.8h, v30.8h
smax	v19.8h, v19.8h, v30.8h
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v6.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v7.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v6.4s, v6.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v7.4s, v7.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v6.4s, v6.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v7.4s, v7.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v6.4s, v6.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v7.4s, v7.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v6.8h, v6.8h, v0.8h
uzp1	v7.8h, v7.8h, v1.8h
srshl	v6.8h, v6.8h, v29.8h
srshl	v7.8h, v7.8h, v29.8h
add	v6.8h, v6.8h, v28.8h
add	v7.8h, v7.8h, v28.8h
smin	v6.8h, v6.8h, v31.8h
smin	v7.8h, v7.8h, v31.8h
smax	v6.8h, v6.8h, v30.8h
smax	v7.8h, v7.8h, v30.8h
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v16.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v17.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v16.4s, v16.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v17.4s, v17.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v16.4s, v16.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v17.4s, v17.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v16.4s, v16.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v17.4s, v17.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v16.8h, v16.8h, v0.8h
uzp1	v17.8h, v17.8h, v1.8h
srshl	v16.8h, v16.8h, v29.8h
srshl	v17.8h, v17.8h, v29.8h
add	v16.8h, v16.8h, v28.8h
add	v17.8h, v17.8h, v28.8h
smin	v16.8h, v16.8h, v31.8h
smin	v17.8h, v17.8h, v31.8h
smax	v16.8h, v16.8h, v30.8h
smax	v17.8h, v17.8h, v30.8h
subs	w5, w5, #0x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v18.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v19.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v18.4s, v18.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v19.4s, v19.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v18.4s, v18.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v19.4s, v19.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v18.4s, v18.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v19.4s, v19.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v18.8h, v18.8h, v0.8h
uzp1	v19.8h, v19.8h, v1.8h
srshl	v18.8h, v18.8h, v29.8h
srshl	v19.8h, v19.8h, v29.8h
add	v18.8h, v18.8h, v28.8h
add	v19.8h, v19.8h, v28.8h
smin	v18.8h, v18.8h, v31.8h
smin	v19.8h, v19.8h, v31.8h
smax	v18.8h, v18.8h, v30.8h
smax	v19.8h, v19.8h, v30.8h
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], x1
b.le	L_18b8
ld1	{ v27.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
neg	v27.16b, v27.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
sshll	v26.8h, v27.8b, #0x0
sshll2	v27.8h, v27.16b, #0x0
sshll	v24.4s, v26.4h, #0x0
sshll2	v25.4s, v26.8h, #0x0
sshll	v26.4s, v27.4h, #0x0
sshll2	v27.4s, v27.8h, #0x0
ssubl	v4.4s, v2.4h, v0.4h
ssubl2	v0.4s, v2.8h, v0.8h
ssubl	v5.4s, v3.4h, v1.4h
ssubl2	v1.4s, v3.8h, v1.8h
mul	v4.4s, v4.4s, v24.4s
mul	v0.4s, v0.4s, v25.4s
mul	v5.4s, v5.4s, v26.4s
mul	v1.4s, v1.4s, v27.4s
sshr	v4.4s, v4.4s, #0x6
sshr	v0.4s, v0.4s, #0x6
sshr	v5.4s, v5.4s, #0x6
sshr	v1.4s, v1.4s, #0x6
saddw	v4.4s, v4.4s, v2.4h
saddw2	v0.4s, v0.4s, v2.8h
saddw	v5.4s, v5.4s, v3.4h
saddw2	v1.4s, v1.4s, v3.8h
uzp1	v4.8h, v4.8h, v0.8h
uzp1	v5.8h, v5.8h, v1.8h
srshl	v4.8h, v4.8h, v29.8h
srshl	v5.8h, v5.8h, v29.8h
add	v4.8h, v4.8h, v28.8h
add	v5.8h, v5.8h, v28.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
b	L_141c
L_18b8:
ret
w_mask_444_16bpc_neon:
ldr	w8, [sp]
clz	w9, w4
adrp	x10, w_mask_444_tbl
add	x10, x10, :lo12:w_mask_444_tbl
dup	v31.8h, w8
sub	w9, w9, #0x18
clz	w8, w8
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
sub	w8, w8, #0xc
mov	w9, #0x80000
neg	w8, w8
mov	w11, #0x6bdf
dup	v30.4s, w9
dup	v29.4s, w8
dup	v0.8h, w11
movi	v1.16b, #0x40
add	x12, x0, x1
lsl	x1, x1, #1
br	x10
L_190c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sabd	v20.8h, v4.8h, v6.8h
sabd	v21.8h, v5.8h, v7.8h
ssubl	v16.4s, v6.4h, v4.4h
ssubl2	v17.4s, v6.8h, v4.8h
ssubl	v18.4s, v7.4h, v5.4h
ssubl2	v19.4s, v7.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v7.4s, v5.8h, #0x6
sshll	v6.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
ushll	v22.4s, v20.4h, #0x0
ushll2	v23.4s, v20.8h, #0x0
ushll	v24.4s, v21.4h, #0x0
ushll2	v25.4s, v21.8h, #0x0
mla	v4.4s, v16.4s, v22.4s
mla	v5.4s, v17.4s, v23.4s
mla	v6.4s, v18.4s, v24.4s
mla	v7.4s, v19.4s, v25.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v6.4s
sqxtun2	v5.8h, v7.4s
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
uzp1	v20.16b, v20.16b, v21.16b
sub	v20.16b, v1.16b, v20.16b
st1	{ v20.16b }, [x6], #16
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x12], x1
st1	{ v5.8b }, [x0], x1
st1	{ v5.d }[1], [x12], x1
b.gt	L_190c
ret
L_19cc:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sabd	v20.8h, v4.8h, v6.8h
sabd	v21.8h, v5.8h, v7.8h
ssubl	v16.4s, v6.4h, v4.4h
ssubl2	v17.4s, v6.8h, v4.8h
ssubl	v18.4s, v7.4h, v5.4h
ssubl2	v19.4s, v7.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v7.4s, v5.8h, #0x6
sshll	v6.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
ushll	v22.4s, v20.4h, #0x0
ushll2	v23.4s, v20.8h, #0x0
ushll	v24.4s, v21.4h, #0x0
ushll2	v25.4s, v21.8h, #0x0
mla	v4.4s, v16.4s, v22.4s
mla	v5.4s, v17.4s, v23.4s
mla	v6.4s, v18.4s, v24.4s
mla	v7.4s, v19.4s, v25.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v6.4s
sqxtun2	v5.8h, v7.4s
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
uzp1	v20.16b, v20.16b, v21.16b
sub	v20.16b, v1.16b, v20.16b
st1	{ v20.16b }, [x6], #16
st1	{ v4.8h }, [x0], x1
st1	{ v5.8h }, [x12], x1
b.gt	L_19cc
ret
L_1a84:
mov	w11, w4
sub	x1, x1, w4, uxtw #1
add	x10, x6, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
L_1a98:
mov	w8, w4
L_1a9c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v16.8h, v17.8h }, [x3], #32
ld1	{ v6.8h, v7.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sabd	v20.8h, v4.8h, v16.8h
sabd	v21.8h, v5.8h, v17.8h
ssubl	v22.4s, v16.4h, v4.4h
ssubl2	v23.4s, v16.8h, v4.8h
ssubl	v24.4s, v17.4h, v5.4h
ssubl2	v25.4s, v17.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v27.4s, v5.8h, #0x6
sshll	v26.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v26.4s, v26.4s, v30.4s
add	v27.4s, v27.4s, v30.4s
ushll	v16.4s, v20.4h, #0x0
ushll2	v17.4s, v20.8h, #0x0
ushll	v28.4s, v21.4h, #0x0
mla	v4.4s, v22.4s, v16.4s
ushll2	v16.4s, v21.8h, #0x0
mla	v5.4s, v23.4s, v17.4s
mla	v26.4s, v24.4s, v28.4s
mla	v27.4s, v25.4s, v16.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v26.4s, v26.4s, v29.4s
srshl	v27.4s, v27.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v26.4s
sqxtun2	v5.8h, v27.4s
sabd	v22.8h, v6.8h, v18.8h
sabd	v23.8h, v7.8h, v19.8h
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
ssubl	v16.4s, v18.4h, v6.4h
ssubl2	v17.4s, v18.8h, v6.8h
ssubl	v18.4s, v19.4h, v7.4h
ssubl2	v19.4s, v19.8h, v7.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
sshll	v24.4s, v6.4h, #0x6
sshll2	v25.4s, v6.8h, #0x6
sshll	v26.4s, v7.4h, #0x6
sshll2	v27.4s, v7.8h, #0x6
ushr	v22.8h, v22.8h, #0xa
ushr	v23.8h, v23.8h, #0xa
add	v24.4s, v24.4s, v30.4s
add	v25.4s, v25.4s, v30.4s
add	v26.4s, v26.4s, v30.4s
add	v27.4s, v27.4s, v30.4s
ushll	v6.4s, v22.4h, #0x0
ushll2	v7.4s, v22.8h, #0x0
ushll	v28.4s, v23.4h, #0x0
mla	v24.4s, v16.4s, v6.4s
ushll2	v6.4s, v23.8h, #0x0
mla	v25.4s, v17.4s, v7.4s
mla	v26.4s, v18.4s, v28.4s
mla	v27.4s, v19.4s, v6.4s
srshl	v24.4s, v24.4s, v29.4s
srshl	v25.4s, v25.4s, v29.4s
srshl	v26.4s, v26.4s, v29.4s
srshl	v27.4s, v27.4s, v29.4s
sqxtun	v6.4h, v24.4s
sqxtun2	v6.8h, v25.4s
sqxtun	v7.4h, v26.4s
sqxtun2	v7.8h, v27.4s
umin	v6.8h, v6.8h, v31.8h
umin	v7.8h, v7.8h, v31.8h
uzp1	v20.16b, v20.16b, v21.16b
uzp1	v21.16b, v22.16b, v23.16b
sub	v20.16b, v1.16b, v20.16b
sub	v21.16b, v1.16b, v21.16b
st1	{ v20.16b }, [x6], #16
st1	{ v21.16b }, [x10], #16
st1	{ v4.8h, v5.8h }, [x0], #32
st1	{ v6.8h, v7.8h }, [x12], #32
b.gt	L_1a9c
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, w4, uxtw
add	x10, x10, w4, uxtw
add	x0, x0, x1
add	x12, x12, x1
b.gt	L_1a98
ret
w_mask_422_16bpc_neon:
ldr	w8, [sp]
clz	w9, w4
adrp	x10, w_mask_422_tbl
add	x10, x10, :lo12:w_mask_422_tbl
dup	v31.8h, w8
sub	w9, w9, #0x18
clz	w8, w8
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
sub	w8, w8, #0xc
mov	w9, #0x80000
neg	w8, w8
mov	w11, #0x6bdf
dup	v30.4s, w9
dup	v29.4s, w8
dup	v0.8h, w11
dup	v2.8b, w7
movi	v3.8b, #0x81
sub	v3.8b, v3.8b, v2.8b
add	x12, x0, x1
lsl	x1, x1, #1
br	x10
L_1c78:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sabd	v20.8h, v4.8h, v6.8h
sabd	v21.8h, v5.8h, v7.8h
ssubl	v16.4s, v6.4h, v4.4h
ssubl2	v17.4s, v6.8h, v4.8h
ssubl	v18.4s, v7.4h, v5.4h
ssubl2	v19.4s, v7.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v7.4s, v5.8h, #0x6
sshll	v6.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
ushll	v22.4s, v20.4h, #0x0
ushll2	v23.4s, v20.8h, #0x0
ushll	v24.4s, v21.4h, #0x0
ushll2	v25.4s, v21.8h, #0x0
mla	v4.4s, v16.4s, v22.4s
mla	v5.4s, v17.4s, v23.4s
mla	v6.4s, v18.4s, v24.4s
mla	v7.4s, v19.4s, v25.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v6.4s
sqxtun2	v5.8h, v7.4s
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
addp	v20.8h, v20.8h, v21.8h
xtn	v20.8b, v20.8h
uhsub	v20.8b, v3.8b, v20.8b
st1	{ v20.8b }, [x6], #8
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x12], x1
st1	{ v5.8b }, [x0], x1
st1	{ v5.d }[1], [x12], x1
b.gt	L_1c78
ret
L_1d3c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sabd	v20.8h, v4.8h, v6.8h
sabd	v21.8h, v5.8h, v7.8h
ssubl	v16.4s, v6.4h, v4.4h
ssubl2	v17.4s, v6.8h, v4.8h
ssubl	v18.4s, v7.4h, v5.4h
ssubl2	v19.4s, v7.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v7.4s, v5.8h, #0x6
sshll	v6.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
ushll	v22.4s, v20.4h, #0x0
ushll2	v23.4s, v20.8h, #0x0
ushll	v24.4s, v21.4h, #0x0
ushll2	v25.4s, v21.8h, #0x0
mla	v4.4s, v16.4s, v22.4s
mla	v5.4s, v17.4s, v23.4s
mla	v6.4s, v18.4s, v24.4s
mla	v7.4s, v19.4s, v25.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v6.4s
sqxtun2	v5.8h, v7.4s
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
addp	v20.8h, v20.8h, v21.8h
xtn	v20.8b, v20.8h
uhsub	v20.8b, v3.8b, v20.8b
st1	{ v20.8b }, [x6], #8
st1	{ v4.8h }, [x0], x1
st1	{ v5.8h }, [x12], x1
b.gt	L_1d3c
ret
L_1df8:
mov	w11, w4
sub	x1, x1, w4, uxtw #1
add	x10, x6, x11, lsr #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
L_1e0c:
mov	w8, w4
L_1e10:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v16.8h, v17.8h }, [x3], #32
ld1	{ v6.8h, v7.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sabd	v20.8h, v4.8h, v16.8h
sabd	v21.8h, v5.8h, v17.8h
ssubl	v22.4s, v16.4h, v4.4h
ssubl2	v23.4s, v16.8h, v4.8h
ssubl	v24.4s, v17.4h, v5.4h
ssubl2	v25.4s, v17.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v27.4s, v5.8h, #0x6
sshll	v26.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v26.4s, v26.4s, v30.4s
add	v27.4s, v27.4s, v30.4s
ushll	v16.4s, v20.4h, #0x0
ushll2	v17.4s, v20.8h, #0x0
ushll	v28.4s, v21.4h, #0x0
mla	v4.4s, v22.4s, v16.4s
ushll2	v16.4s, v21.8h, #0x0
mla	v5.4s, v23.4s, v17.4s
mla	v26.4s, v24.4s, v28.4s
mla	v27.4s, v25.4s, v16.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v26.4s, v26.4s, v29.4s
srshl	v27.4s, v27.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v26.4s
sqxtun2	v5.8h, v27.4s
sabd	v22.8h, v6.8h, v18.8h
sabd	v23.8h, v7.8h, v19.8h
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
ssubl	v16.4s, v18.4h, v6.4h
ssubl2	v17.4s, v18.8h, v6.8h
ssubl	v18.4s, v19.4h, v7.4h
ssubl2	v19.4s, v19.8h, v7.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
sshll	v24.4s, v6.4h, #0x6
sshll2	v25.4s, v6.8h, #0x6
sshll	v26.4s, v7.4h, #0x6
sshll2	v27.4s, v7.8h, #0x6
ushr	v22.8h, v22.8h, #0xa
ushr	v23.8h, v23.8h, #0xa
add	v24.4s, v24.4s, v30.4s
add	v25.4s, v25.4s, v30.4s
add	v26.4s, v26.4s, v30.4s
add	v27.4s, v27.4s, v30.4s
ushll	v6.4s, v22.4h, #0x0
ushll2	v7.4s, v22.8h, #0x0
ushll	v28.4s, v23.4h, #0x0
mla	v24.4s, v16.4s, v6.4s
ushll2	v6.4s, v23.8h, #0x0
mla	v25.4s, v17.4s, v7.4s
mla	v26.4s, v18.4s, v28.4s
mla	v27.4s, v19.4s, v6.4s
srshl	v24.4s, v24.4s, v29.4s
srshl	v25.4s, v25.4s, v29.4s
srshl	v26.4s, v26.4s, v29.4s
srshl	v27.4s, v27.4s, v29.4s
sqxtun	v6.4h, v24.4s
sqxtun2	v6.8h, v25.4s
sqxtun	v7.4h, v26.4s
sqxtun2	v7.8h, v27.4s
umin	v6.8h, v6.8h, v31.8h
umin	v7.8h, v7.8h, v31.8h
addp	v20.8h, v20.8h, v21.8h
addp	v21.8h, v22.8h, v23.8h
xtn	v20.8b, v20.8h
xtn	v21.8b, v21.8h
uhsub	v20.8b, v3.8b, v20.8b
uhsub	v21.8b, v3.8b, v21.8b
st1	{ v20.8b }, [x6], #8
st1	{ v21.8b }, [x10], #8
st1	{ v4.8h, v5.8h }, [x0], #32
st1	{ v6.8h, v7.8h }, [x12], #32
b.gt	L_1e10
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, x11, lsr #1
add	x10, x10, x11, lsr #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	L_1e0c
ret
w_mask_420_16bpc_neon:
ldr	w8, [sp]
clz	w9, w4
adrp	x10, w_mask_420_tbl
add	x10, x10, :lo12:w_mask_420_tbl
dup	v31.8h, w8
sub	w9, w9, #0x18
clz	w8, w8
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
sub	w8, w8, #0xc
mov	w9, #0x80000
neg	w8, w8
mov	w11, #0x6bdf
dup	v30.4s, w9
dup	v29.4s, w8
dup	v0.8h, w11
dup	v2.8h, w7
movi	v3.8h, #0x1, lsl #8
sub	v3.8h, v3.8h, v2.8h
add	x12, x0, x1
lsl	x1, x1, #1
br	x10
L_1ff4:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sabd	v20.8h, v4.8h, v6.8h
sabd	v21.8h, v5.8h, v7.8h
ssubl	v16.4s, v6.4h, v4.4h
ssubl2	v17.4s, v6.8h, v4.8h
ssubl	v18.4s, v7.4h, v5.4h
ssubl2	v19.4s, v7.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v7.4s, v5.8h, #0x6
sshll	v6.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
ushll	v22.4s, v20.4h, #0x0
ushll2	v23.4s, v20.8h, #0x0
ushll	v24.4s, v21.4h, #0x0
ushll2	v25.4s, v21.8h, #0x0
mla	v4.4s, v16.4s, v22.4s
mla	v5.4s, v17.4s, v23.4s
mla	v6.4s, v18.4s, v24.4s
mla	v7.4s, v19.4s, v25.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v6.4s
sqxtun2	v5.8h, v7.4s
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
trn1	v24.2d, v20.2d, v21.2d
trn2	v25.2d, v20.2d, v21.2d
add	v24.8h, v24.8h, v25.8h
addp	v20.8h, v24.8h, v24.8h
sub	v20.4h, v3.4h, v20.4h
rshrn	v20.8b, v20.8h, #0x2
str	s20, [x6], #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x12], x1
st1	{ v5.8b }, [x0], x1
st1	{ v5.d }[1], [x12], x1
b.gt	L_1ff4
ret
L_20c4:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sabd	v20.8h, v4.8h, v6.8h
sabd	v21.8h, v5.8h, v7.8h
ssubl	v16.4s, v6.4h, v4.4h
ssubl2	v17.4s, v6.8h, v4.8h
ssubl	v18.4s, v7.4h, v5.4h
ssubl2	v19.4s, v7.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v7.4s, v5.8h, #0x6
sshll	v6.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
ushll	v22.4s, v20.4h, #0x0
ushll2	v23.4s, v20.8h, #0x0
ushll	v24.4s, v21.4h, #0x0
ushll2	v25.4s, v21.8h, #0x0
mla	v4.4s, v16.4s, v22.4s
mla	v5.4s, v17.4s, v23.4s
mla	v6.4s, v18.4s, v24.4s
mla	v7.4s, v19.4s, v25.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v6.4s
sqxtun2	v5.8h, v7.4s
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
add	v20.8h, v20.8h, v21.8h
addp	v20.8h, v20.8h, v20.8h
sub	v20.4h, v3.4h, v20.4h
rshrn	v20.8b, v20.8h, #0x2
str	s20, [x6], #0x4
st1	{ v4.8h }, [x0], x1
st1	{ v5.8h }, [x12], x1
b.gt	L_20c4
ret
L_2184:
mov	w11, w4
sub	x1, x1, w4, uxtw #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
L_2194:
mov	w8, w4
L_2198:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v16.8h, v17.8h }, [x3], #32
ld1	{ v6.8h, v7.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sabd	v20.8h, v4.8h, v16.8h
sabd	v21.8h, v5.8h, v17.8h
ssubl	v22.4s, v16.4h, v4.4h
ssubl2	v23.4s, v16.8h, v4.8h
ssubl	v24.4s, v17.4h, v5.4h
ssubl2	v25.4s, v17.8h, v5.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
sshll2	v27.4s, v5.8h, #0x6
sshll	v26.4s, v5.4h, #0x6
sshll2	v5.4s, v4.8h, #0x6
sshll	v4.4s, v4.4h, #0x6
ushr	v20.8h, v20.8h, #0xa
ushr	v21.8h, v21.8h, #0xa
add	v4.4s, v4.4s, v30.4s
add	v5.4s, v5.4s, v30.4s
add	v26.4s, v26.4s, v30.4s
add	v27.4s, v27.4s, v30.4s
ushll	v16.4s, v20.4h, #0x0
ushll2	v17.4s, v20.8h, #0x0
ushll	v28.4s, v21.4h, #0x0
mla	v4.4s, v22.4s, v16.4s
ushll2	v16.4s, v21.8h, #0x0
mla	v5.4s, v23.4s, v17.4s
mla	v26.4s, v24.4s, v28.4s
mla	v27.4s, v25.4s, v16.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
srshl	v26.4s, v26.4s, v29.4s
srshl	v27.4s, v27.4s, v29.4s
sqxtun	v4.4h, v4.4s
sqxtun2	v4.8h, v5.4s
sqxtun	v5.4h, v26.4s
sqxtun2	v5.8h, v27.4s
sabd	v22.8h, v6.8h, v18.8h
sabd	v23.8h, v7.8h, v19.8h
umin	v4.8h, v4.8h, v31.8h
umin	v5.8h, v5.8h, v31.8h
ssubl	v16.4s, v18.4h, v6.4h
ssubl2	v17.4s, v18.8h, v6.8h
ssubl	v18.4s, v19.4h, v7.4h
ssubl2	v19.4s, v19.8h, v7.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
sshll	v24.4s, v6.4h, #0x6
sshll2	v25.4s, v6.8h, #0x6
sshll	v26.4s, v7.4h, #0x6
sshll2	v27.4s, v7.8h, #0x6
ushr	v22.8h, v22.8h, #0xa
ushr	v23.8h, v23.8h, #0xa
add	v24.4s, v24.4s, v30.4s
add	v25.4s, v25.4s, v30.4s
add	v26.4s, v26.4s, v30.4s
add	v27.4s, v27.4s, v30.4s
ushll	v6.4s, v22.4h, #0x0
ushll2	v7.4s, v22.8h, #0x0
ushll	v28.4s, v23.4h, #0x0
mla	v24.4s, v16.4s, v6.4s
ushll2	v6.4s, v23.8h, #0x0
mla	v25.4s, v17.4s, v7.4s
mla	v26.4s, v18.4s, v28.4s
mla	v27.4s, v19.4s, v6.4s
srshl	v24.4s, v24.4s, v29.4s
srshl	v25.4s, v25.4s, v29.4s
srshl	v26.4s, v26.4s, v29.4s
srshl	v27.4s, v27.4s, v29.4s
sqxtun	v6.4h, v24.4s
sqxtun2	v6.8h, v25.4s
sqxtun	v7.4h, v26.4s
sqxtun2	v7.8h, v27.4s
umin	v6.8h, v6.8h, v31.8h
umin	v7.8h, v7.8h, v31.8h
add	v20.8h, v20.8h, v22.8h
add	v21.8h, v21.8h, v23.8h
addp	v20.8h, v20.8h, v21.8h
sub	v20.8h, v3.8h, v20.8h
rshrn	v20.8b, v20.8h, #0x2
st1	{ v20.8b }, [x6], #8
st1	{ v4.8h, v5.8h }, [x0], #32
st1	{ v6.8h, v7.8h }, [x12], #32
b.gt	L_2198
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	L_2194
ret
blend_16bpc_neon:
adrp	x6, blend_tbl
add	x6, x6, :lo12:blend_tbl
clz	w3, w3
sub	w3, w3, #0x1a
ldrsw	x3, [x6, x3, lsl #2]
add	x6, x6, x3
add	x8, x0, x1
br	x6
L_2334:
lsl	x1, x1, #1
L_2338:
ld1	{ v2.8b }, [x5], #8
ld1	{ v1.8h }, [x2], #16
ldr	d0, [x0]
neg	v2.8b, v2.8b
subs	w4, w4, #0x2
ld1	{ v0.d }[1], [x8]
sshll	v2.8h, v2.8b, #0x0
shl	v2.8h, v2.8h, #0x9
sub	v1.8h, v0.8h, v1.8h
sqrdmulh	v1.8h, v1.8h, v2.8h
add	v0.8h, v0.8h, v1.8h
st1	{ v0.8b }, [x0], x1
st1	{ v0.d }[1], [x8], x1
b.gt	L_2338
ret
L_2374:
lsl	x1, x1, #1
L_2378:
ld1	{ v4.16b }, [x5], #16
ld1	{ v2.8h, v3.8h }, [x2], #32
neg	v5.16b, v4.16b
ld1	{ v0.8h }, [x0]
ld1	{ v1.8h }, [x8]
sshll	v4.8h, v5.8b, #0x0
sshll2	v5.8h, v5.16b, #0x0
shl	v4.8h, v4.8h, #0x9
shl	v5.8h, v5.8h, #0x9
sub	v2.8h, v0.8h, v2.8h
sub	v3.8h, v1.8h, v3.8h
subs	w4, w4, #0x2
sqrdmulh	v2.8h, v2.8h, v4.8h
sqrdmulh	v3.8h, v3.8h, v5.8h
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
st1	{ v0.8h }, [x0], x1
st1	{ v1.8h }, [x8], x1
b.gt	L_2378
ret
L_23c8:
lsl	x1, x1, #1
L_23cc:
ld1	{ v16.16b, v17.16b }, [x5], #32
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], #64
subs	w4, w4, #0x2
neg	v18.16b, v16.16b
neg	v19.16b, v17.16b
ld1	{ v0.8h, v1.8h }, [x0]
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
ld1	{ v2.8h, v3.8h }, [x8]
shl	v16.8h, v16.8h, #0x9
shl	v17.8h, v17.8h, #0x9
shl	v18.8h, v18.8h, #0x9
shl	v19.8h, v19.8h, #0x9
sub	v4.8h, v0.8h, v4.8h
sub	v5.8h, v1.8h, v5.8h
sub	v6.8h, v2.8h, v6.8h
sub	v7.8h, v3.8h, v7.8h
sqrdmulh	v4.8h, v4.8h, v16.8h
sqrdmulh	v5.8h, v5.8h, v17.8h
sqrdmulh	v6.8h, v6.8h, v18.8h
sqrdmulh	v7.8h, v7.8h, v19.8h
add	v0.8h, v0.8h, v4.8h
add	v1.8h, v1.8h, v5.8h
add	v2.8h, v2.8h, v6.8h
add	v3.8h, v3.8h, v7.8h
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v2.8h, v3.8h }, [x8], x1
b.gt	L_23cc
ret
L_2448:
ld1	{ v16.16b, v17.16b }, [x5], #32
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], #64
subs	w4, w4, #0x1
neg	v18.16b, v16.16b
neg	v19.16b, v17.16b
sshll	v16.8h, v18.8b, #0x0
sshll2	v17.8h, v18.16b, #0x0
sshll	v18.8h, v19.8b, #0x0
sshll2	v19.8h, v19.16b, #0x0
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0]
shl	v16.8h, v16.8h, #0x9
shl	v17.8h, v17.8h, #0x9
shl	v18.8h, v18.8h, #0x9
shl	v19.8h, v19.8h, #0x9
sub	v4.8h, v0.8h, v4.8h
sub	v5.8h, v1.8h, v5.8h
sub	v6.8h, v2.8h, v6.8h
sub	v7.8h, v3.8h, v7.8h
sqrdmulh	v4.8h, v4.8h, v16.8h
sqrdmulh	v5.8h, v5.8h, v17.8h
sqrdmulh	v6.8h, v6.8h, v18.8h
sqrdmulh	v7.8h, v7.8h, v19.8h
add	v0.8h, v0.8h, v4.8h
add	v1.8h, v1.8h, v5.8h
add	v2.8h, v2.8h, v6.8h
add	v3.8h, v3.8h, v7.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
b.gt	L_2448
ret
blend_h_16bpc_neon:
adrp	x6, blend_h_tbl
add	x6, x6, :lo12:blend_h_tbl
adrp	x5, obmc_masks
add	x5, x5, :lo12:obmc_masks
add	x5, x5, w4, uxtw
sub	w4, w4, w4, lsr #2
clz	w7, w3
add	x8, x0, x1
lsl	x1, x1, #1
sub	w7, w7, #0x18
ldrsw	x7, [x6, x7, lsl #2]
add	x6, x6, x7
br	x6
L_24f0:
ld2r	{ v2.8b, v3.8b }, [x5], #2
ld1	{ v1.4h }, [x2], #8
ext	v2.8b, v2.8b, v3.8b, #0x6
subs	w4, w4, #0x2
neg	v2.8b, v2.8b
ldr	s0, [x0]
ld1	{ v0.s }[1], [x8]
sshll	v2.8h, v2.8b, #0x0
shl	v2.4h, v2.4h, #0x9
sub	v1.4h, v0.4h, v1.4h
sqrdmulh	v1.4h, v1.4h, v2.4h
add	v0.4h, v0.4h, v1.4h
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[1], [x8], x1
b.gt	L_24f0
ret
L_2530:
ld2r	{ v2.8b, v3.8b }, [x5], #2
ld1	{ v1.8h }, [x2], #16
ext	v2.8b, v2.8b, v3.8b, #0x4
subs	w4, w4, #0x2
neg	v2.8b, v2.8b
ldr	d0, [x0]
ld1	{ v0.d }[1], [x8]
sshll	v2.8h, v2.8b, #0x0
shl	v2.8h, v2.8h, #0x9
sub	v1.8h, v0.8h, v1.8h
sqrdmulh	v1.8h, v1.8h, v2.8h
add	v0.8h, v0.8h, v1.8h
st1	{ v0.8b }, [x0], x1
st1	{ v0.d }[1], [x8], x1
b.gt	L_2530
ret
L_2570:
ld2r	{ v4.8b, v5.8b }, [x5], #2
ld1	{ v2.8h, v3.8h }, [x2], #32
neg	v4.8b, v4.8b
neg	v5.8b, v5.8b
ld1	{ v0.8h }, [x0]
subs	w4, w4, #0x2
sshll	v4.8h, v4.8b, #0x0
sshll	v5.8h, v5.8b, #0x0
ld1	{ v1.8h }, [x8]
shl	v4.8h, v4.8h, #0x9
shl	v5.8h, v5.8h, #0x9
sub	v2.8h, v0.8h, v2.8h
sub	v3.8h, v1.8h, v3.8h
sqrdmulh	v2.8h, v2.8h, v4.8h
sqrdmulh	v3.8h, v3.8h, v5.8h
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
st1	{ v0.8h }, [x0], x1
st1	{ v1.8h }, [x8], x1
b.gt	L_2570
ret
L_25c4:
ld2r	{ v16.8b, v17.8b }, [x5], #2
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], #64
neg	v16.8b, v16.8b
neg	v17.8b, v17.8b
ld1	{ v0.8h, v1.8h }, [x0]
ld1	{ v2.8h, v3.8h }, [x8]
subs	w4, w4, #0x2
sshll	v16.8h, v16.8b, #0x0
sshll	v17.8h, v17.8b, #0x0
shl	v16.8h, v16.8h, #0x9
shl	v17.8h, v17.8h, #0x9
sub	v4.8h, v0.8h, v4.8h
sub	v5.8h, v1.8h, v5.8h
sub	v6.8h, v2.8h, v6.8h
sub	v7.8h, v3.8h, v7.8h
sqrdmulh	v4.8h, v4.8h, v16.8h
sqrdmulh	v5.8h, v5.8h, v16.8h
sqrdmulh	v6.8h, v6.8h, v17.8h
sqrdmulh	v7.8h, v7.8h, v17.8h
add	v0.8h, v0.8h, v4.8h
add	v1.8h, v1.8h, v5.8h
add	v2.8h, v2.8h, v6.8h
add	v3.8h, v3.8h, v7.8h
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v2.8h, v3.8h }, [x8], x1
b.gt	L_25c4
ret
L_2630:
sub	x1, x1, w3, uxtw #1
add	x7, x2, w3, uxtw #1
L_2638:
ld2r	{ v24.8b, v25.8b }, [x5], #2
mov	w6, w3
neg	v24.8b, v24.8b
neg	v25.8b, v25.8b
sshll	v24.8h, v24.8b, #0x0
sshll	v25.8h, v25.8b, #0x0
shl	v24.8h, v24.8h, #0x9
shl	v25.8h, v25.8h, #0x9
L_2658:
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x2], #64
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0]
subs	w6, w6, #0x20
sub	v16.8h, v0.8h, v16.8h
sub	v17.8h, v1.8h, v17.8h
sub	v18.8h, v2.8h, v18.8h
sub	v19.8h, v3.8h, v19.8h
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x7], #64
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x8]
sqrdmulh	v16.8h, v16.8h, v24.8h
sqrdmulh	v17.8h, v17.8h, v24.8h
sqrdmulh	v18.8h, v18.8h, v24.8h
sqrdmulh	v19.8h, v19.8h, v24.8h
sub	v20.8h, v4.8h, v20.8h
sub	v21.8h, v5.8h, v21.8h
sub	v22.8h, v6.8h, v22.8h
sub	v23.8h, v7.8h, v23.8h
add	v0.8h, v0.8h, v16.8h
add	v1.8h, v1.8h, v17.8h
add	v2.8h, v2.8h, v18.8h
add	v3.8h, v3.8h, v19.8h
sqrdmulh	v20.8h, v20.8h, v25.8h
sqrdmulh	v21.8h, v21.8h, v25.8h
sqrdmulh	v22.8h, v22.8h, v25.8h
sqrdmulh	v23.8h, v23.8h, v25.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v4.8h, v4.8h, v20.8h
add	v5.8h, v5.8h, v21.8h
add	v6.8h, v6.8h, v22.8h
add	v7.8h, v7.8h, v23.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x8], #64
b.gt	L_2658
subs	w4, w4, #0x2
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, w3, uxtw #1
add	x7, x7, w3, uxtw #1
b.gt	L_2638
ret
blend_v_16bpc_neon:
adrp	x6, blend_v_tbl
add	x6, x6, :lo12:blend_v_tbl
adrp	x5, obmc_masks
add	x5, x5, :lo12:obmc_masks
add	x5, x5, w3, uxtw
clz	w3, w3
add	x8, x0, x1
lsl	x1, x1, #1
sub	w3, w3, #0x1a
ldrsw	x3, [x6, x3, lsl #2]
add	x6, x6, x3
br	x6
L_2724:
ld1r	{ v2.8b }, [x5]
neg	v2.8b, v2.8b
sshll	v2.8h, v2.8b, #0x0
shl	v2.4h, v2.4h, #0x9
L_2734:
ldr	s1, [x2], #0x4
ldr	h0, [x0]
subs	w4, w4, #0x2
ld1	{ v1.h }[1], [x2]
ld1	{ v0.h }[1], [x8]
add	x2, x2, #0x4
sub	v1.4h, v0.4h, v1.4h
sqrdmulh	v1.4h, v1.4h, v2.4h
add	v0.4h, v0.4h, v1.4h
st1	{ v0.h }[0], [x0], x1
st1	{ v0.h }[1], [x8], x1
b.gt	L_2734
ret
L_2768:
ld1r	{ v2.2s }, [x5]
sub	x1, x1, #0x4
neg	v2.8b, v2.8b
sshll	v2.8h, v2.8b, #0x0
shl	v2.8h, v2.8h, #0x9
L_277c:
ld1	{ v1.8h }, [x2], #16
ldr	d0, [x0]
ld1	{ v0.d }[1], [x8]
subs	w4, w4, #0x2
sub	v1.8h, v0.8h, v1.8h
sqrdmulh	v1.8h, v1.8h, v2.8h
add	v0.8h, v0.8h, v1.8h
str	s0, [x0], #0x4
st1	{ v0.s }[2], [x8], #4
st1	{ v0.h }[2], [x0], x1
st1	{ v0.h }[6], [x8], x1
b.gt	L_277c
ret
L_27b0:
ld1	{ v4.8b }, [x5]
sub	x1, x1, #0x8
neg	v4.8b, v4.8b
sshll	v4.8h, v4.8b, #0x0
shl	v4.8h, v4.8h, #0x9
L_27c4:
ld1	{ v2.8h, v3.8h }, [x2], #32
ld1	{ v0.8h }, [x0]
ld1	{ v1.8h }, [x8]
subs	w4, w4, #0x2
sub	v2.8h, v0.8h, v2.8h
sub	v3.8h, v1.8h, v3.8h
sqrdmulh	v2.8h, v2.8h, v4.8h
sqrdmulh	v3.8h, v3.8h, v4.8h
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
str	d0, [x0], #0x8
str	d1, [x8], #0x8
st1	{ v0.s }[2], [x0], x1
st1	{ v1.s }[2], [x8], x1
b.gt	L_27c4
ret
L_2804:
ld1	{ v16.16b }, [x5]
sub	x1, x1, #0x10
neg	v17.16b, v16.16b
sshll	v16.8h, v17.8b, #0x0
sshll2	v17.8h, v17.16b, #0x0
shl	v16.8h, v16.8h, #0x9
shl	v17.4h, v17.4h, #0x9
L_2820:
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], #64
ld1	{ v0.8h, v1.8h }, [x0]
subs	w4, w4, #0x2
ld1	{ v2.8h, v3.8h }, [x8]
sub	v4.8h, v0.8h, v4.8h
sub	v5.4h, v1.4h, v5.4h
sub	v6.8h, v2.8h, v6.8h
sub	v7.4h, v3.4h, v7.4h
sqrdmulh	v4.8h, v4.8h, v16.8h
sqrdmulh	v5.4h, v5.4h, v17.4h
sqrdmulh	v6.8h, v6.8h, v16.8h
sqrdmulh	v7.4h, v7.4h, v17.4h
add	v0.8h, v0.8h, v4.8h
add	v1.4h, v1.4h, v5.4h
add	v2.8h, v2.8h, v6.8h
add	v3.4h, v3.4h, v7.4h
st1	{ v0.8h }, [x0], #16
st1	{ v2.8h }, [x8], #16
st1	{ v1.4h }, [x0], x1
st1	{ v3.4h }, [x8], x1
b.gt	L_2820
ret
L_2878:
ld1	{ v24.16b, v25.16b }, [x5]
neg	v26.16b, v24.16b
neg	v27.8b, v25.8b
sshll	v24.8h, v26.8b, #0x0
sshll2	v25.8h, v26.16b, #0x0
sshll	v26.8h, v27.8b, #0x0
shl	v24.8h, v24.8h, #0x9
shl	v25.8h, v25.8h, #0x9
shl	v26.8h, v26.8h, #0x9
L_289c:
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x2], #64
ld1	{ v0.8h, v1.8h, v2.8h }, [x0]
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x2], #64
ld1	{ v4.8h, v5.8h, v6.8h }, [x8]
subs	w4, w4, #0x2
sub	v16.8h, v0.8h, v16.8h
sub	v17.8h, v1.8h, v17.8h
sub	v18.8h, v2.8h, v18.8h
sub	v20.8h, v4.8h, v20.8h
sub	v21.8h, v5.8h, v21.8h
sub	v22.8h, v6.8h, v22.8h
sqrdmulh	v16.8h, v16.8h, v24.8h
sqrdmulh	v17.8h, v17.8h, v25.8h
sqrdmulh	v18.8h, v18.8h, v26.8h
sqrdmulh	v20.8h, v20.8h, v24.8h
sqrdmulh	v21.8h, v21.8h, v25.8h
sqrdmulh	v22.8h, v22.8h, v26.8h
add	v0.8h, v0.8h, v16.8h
add	v1.8h, v1.8h, v17.8h
add	v2.8h, v2.8h, v18.8h
add	v4.8h, v4.8h, v20.8h
add	v5.8h, v5.8h, v21.8h
add	v6.8h, v6.8h, v22.8h
st1	{ v0.8h, v1.8h, v2.8h }, [x0], x1
st1	{ v4.8h, v5.8h, v6.8h }, [x8], x1
b.gt	L_289c
ret
put_16bpc_neon:
adrp	x10, put_16bpc_tbl
add	x10, x10, :lo12:put_16bpc_tbl
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
br	x10
L_291c:
ld1r	{ v0.4s }, [x2], x3
ld1r	{ v1.4s }, [x2], x3
subs	w5, w5, #0x2
st1	{ v0.s }[0], [x0], x1
st1	{ v1.s }[0], [x0], x1
b.gt	L_291c
ret
L_2938:
ld1	{ v0.4h }, [x2], x3
ld1	{ v1.4h }, [x2], x3
subs	w5, w5, #0x2
st1	{ v0.4h }, [x0], x1
st1	{ v1.4h }, [x0], x1
b.gt	L_2938
ret
L_2954:
add	x8, x0, x1
lsl	x1, x1, #1
add	x9, x2, x3
lsl	x3, x3, #1
L_2964:
ld1	{ v0.8h }, [x2], x3
ld1	{ v1.8h }, [x9], x3
subs	w5, w5, #0x2
st1	{ v0.8h }, [x0], x1
st1	{ v1.8h }, [x8], x1
b.gt	L_2964
ret
L_2980:
ldp	x6, x7, [x2]
ldp	x8, x9, [x2, #0x10]
stp	x6, x7, [x0]
subs	w5, w5, #0x1
stp	x8, x9, [x0, #0x10]
add	x2, x2, x3
add	x0, x0, x1
b.gt	L_2980
ret
L_29a4:
ldp	x6, x7, [x2]
ldp	x8, x9, [x2, #0x10]
stp	x6, x7, [x0]
ldp	x10, x11, [x2, #0x20]
stp	x8, x9, [x0, #0x10]
subs	w5, w5, #0x1
ldp	x12, x13, [x2, #0x30]
stp	x10, x11, [x0, #0x20]
stp	x12, x13, [x0, #0x30]
add	x2, x2, x3
add	x0, x0, x1
b.gt	L_29a4
ret
L_29d8:
ldp	q0, q1, [x2]
ldp	q2, q3, [x2, #0x20]
stp	q0, q1, [x0]
ldp	q4, q5, [x2, #0x40]
stp	q2, q3, [x0, #0x20]
ldp	q6, q7, [x2, #0x60]
subs	w5, w5, #0x1
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x2, x2, x3
add	x0, x0, x1
b.gt	L_29d8
ret
L_2a0c:
ldp	q0, q1, [x2]
ldp	q2, q3, [x2, #0x20]
stp	q0, q1, [x0]
ldp	q4, q5, [x2, #0x40]
stp	q2, q3, [x0, #0x20]
ldp	q6, q7, [x2, #0x60]
subs	w5, w5, #0x1
stp	q4, q5, [x0, #0x40]
ldp	q16, q17, [x2, #0x80]
stp	q6, q7, [x0, #0x60]
ldp	q18, q19, [x2, #0xa0]
stp	q16, q17, [x0, #0x80]
ldp	q20, q21, [x2, #0xc0]
stp	q18, q19, [x0, #0xa0]
ldp	q22, q23, [x2, #0xe0]
stp	q20, q21, [x0, #0xc0]
stp	q22, q23, [x0, #0xe0]
add	x2, x2, x3
add	x0, x0, x1
b.gt	L_2a0c
ret
prep_16bpc_neon:
adrp	x10, prep_16bpc_tbl
add	x10, x10, :lo12:prep_16bpc_tbl
ldrsw	x9, [x10, x9, lsl #2]
dup	v31.8h, w7
movi	v30.8h, #0x20, lsl #8
add	x10, x10, x9
br	x10
L_2a7c:
add	x9, x1, x2
lsl	x2, x2, #1
L_2a84:
ld1	{ v0.8b }, [x1], x2
ld1	{ v0.d }[1], [x9], x2
subs	w4, w4, #0x2
sshl	v0.8h, v0.8h, v31.8h
sub	v0.8h, v0.8h, v30.8h
st1	{ v0.8h }, [x0], #16
b.gt	L_2a84
ret
L_2aa4:
add	x9, x1, x2
lsl	x2, x2, #1
L_2aac:
ld1	{ v0.8h }, [x1], x2
ld1	{ v1.8h }, [x9], x2
subs	w4, w4, #0x2
sshl	v0.8h, v0.8h, v31.8h
sshl	v1.8h, v1.8h, v31.8h
sub	v0.8h, v0.8h, v30.8h
sub	v1.8h, v1.8h, v30.8h
st1	{ v0.8h, v1.8h }, [x0], #32
b.gt	L_2aac
ret
L_2ad4:
ldp	q0, q1, [x1]
add	x1, x1, x2
sshl	v0.8h, v0.8h, v31.8h
ldp	q2, q3, [x1]
add	x1, x1, x2
subs	w4, w4, #0x2
sshl	v1.8h, v1.8h, v31.8h
sshl	v2.8h, v2.8h, v31.8h
sshl	v3.8h, v3.8h, v31.8h
sub	v0.8h, v0.8h, v30.8h
sub	v1.8h, v1.8h, v30.8h
sub	v2.8h, v2.8h, v30.8h
sub	v3.8h, v3.8h, v30.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
b.gt	L_2ad4
ret
L_2b14:
ldp	q0, q1, [x1]
sshl	v0.8h, v0.8h, v31.8h
ldp	q2, q3, [x1, #0x20]
add	x1, x1, x2
sshl	v1.8h, v1.8h, v31.8h
sshl	v2.8h, v2.8h, v31.8h
sshl	v3.8h, v3.8h, v31.8h
subs	w4, w4, #0x1
sub	v0.8h, v0.8h, v30.8h
sub	v1.8h, v1.8h, v30.8h
sub	v2.8h, v2.8h, v30.8h
sub	v3.8h, v3.8h, v30.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
b.gt	L_2b14
ret
L_2b50:
ldp	q0, q1, [x1]
subs	w4, w4, #0x1
sshl	v0.8h, v0.8h, v31.8h
ldp	q2, q3, [x1, #0x20]
sshl	v1.8h, v1.8h, v31.8h
ldp	q4, q5, [x1, #0x40]
sshl	v2.8h, v2.8h, v31.8h
sshl	v3.8h, v3.8h, v31.8h
ldp	q6, q7, [x1, #0x60]
add	x1, x1, x2
sshl	v4.8h, v4.8h, v31.8h
sshl	v5.8h, v5.8h, v31.8h
sshl	v6.8h, v6.8h, v31.8h
sshl	v7.8h, v7.8h, v31.8h
sub	v0.8h, v0.8h, v30.8h
sub	v1.8h, v1.8h, v30.8h
sub	v2.8h, v2.8h, v30.8h
sub	v3.8h, v3.8h, v30.8h
stp	q0, q1, [x0]
sub	v4.8h, v4.8h, v30.8h
sub	v5.8h, v5.8h, v30.8h
stp	q2, q3, [x0, #0x20]
sub	v6.8h, v6.8h, v30.8h
sub	v7.8h, v7.8h, v30.8h
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, x8
b.gt	L_2b50
ret
L_2bc4:
ldp	q0, q1, [x1]
subs	w4, w4, #0x1
sshl	v0.8h, v0.8h, v31.8h
ldp	q2, q3, [x1, #0x20]
sshl	v1.8h, v1.8h, v31.8h
ldp	q4, q5, [x1, #0x40]
sshl	v2.8h, v2.8h, v31.8h
sshl	v3.8h, v3.8h, v31.8h
ldp	q6, q7, [x1, #0x60]
sshl	v4.8h, v4.8h, v31.8h
sshl	v5.8h, v5.8h, v31.8h
ldp	q16, q17, [x1, #0x80]
sshl	v6.8h, v6.8h, v31.8h
sshl	v7.8h, v7.8h, v31.8h
ldp	q18, q19, [x1, #0xa0]
sshl	v16.8h, v16.8h, v31.8h
sshl	v17.8h, v17.8h, v31.8h
ldp	q20, q21, [x1, #0xc0]
sshl	v18.8h, v18.8h, v31.8h
sshl	v19.8h, v19.8h, v31.8h
ldp	q22, q23, [x1, #0xe0]
add	x1, x1, x2
sshl	v20.8h, v20.8h, v31.8h
sshl	v21.8h, v21.8h, v31.8h
sshl	v22.8h, v22.8h, v31.8h
sshl	v23.8h, v23.8h, v31.8h
sub	v0.8h, v0.8h, v30.8h
sub	v1.8h, v1.8h, v30.8h
sub	v2.8h, v2.8h, v30.8h
sub	v3.8h, v3.8h, v30.8h
stp	q0, q1, [x0]
sub	v4.8h, v4.8h, v30.8h
sub	v5.8h, v5.8h, v30.8h
stp	q2, q3, [x0, #0x20]
sub	v6.8h, v6.8h, v30.8h
sub	v7.8h, v7.8h, v30.8h
stp	q4, q5, [x0, #0x40]
sub	v16.8h, v16.8h, v30.8h
sub	v17.8h, v17.8h, v30.8h
stp	q6, q7, [x0, #0x60]
sub	v18.8h, v18.8h, v30.8h
sub	v19.8h, v19.8h, v30.8h
stp	q16, q17, [x0, #0x80]
sub	v20.8h, v20.8h, v30.8h
sub	v21.8h, v21.8h, v30.8h
stp	q18, q19, [x0, #0xa0]
sub	v22.8h, v22.8h, v30.8h
sub	v23.8h, v23.8h, v30.8h
stp	q20, q21, [x0, #0xc0]
stp	q22, q23, [x0, #0xe0]
add	x0, x0, x8
b.gt	L_2bc4
ret
put_8tap_regular_sharp_16bpc_neon:
mov	w9, #0x2d
mov	w10, #0xf2d
b	put_8tap_neon
put_8tap_smooth_sharp_16bpc_neon:
mov	w9, #0x7bc
mov	w10, #0xf2d
b	put_8tap_neon
put_8tap_sharp_16bpc_neon:
mov	w9, #0xf2d
mov	w10, #0xf2d
b	put_8tap_neon
put_8tap_sharp_regular_16bpc_neon:
mov	w9, #0xf2d
mov	w10, #0x2d
b	put_8tap_neon
put_8tap_sharp_smooth_16bpc_neon:
mov	w9, #0xf2d
mov	w10, #0x7bc
b	put_8tap_neon
put_8tap_neon:
ldr	w8, [sp]
mov	w11, #0x4081
mul	w6, w6, w11
mul	w7, w7, w11
add	w6, w6, w9
add	w7, w7, w10
dup	v31.8h, w8
clz	w8, w8
clz	w9, w4
sub	w8, w8, #0x12
mov	w12, #0x6
tst	w6, #0x1fc000
sub	w9, w9, #0x18
add	w13, w12, w8
sub	w12, w12, w8
adrp	x11, mc_subpel_filters-8
add	x11, x11, :lo12:mc_subpel_filters-8
b.ne	L_2d28
tst	w7, #0x1fc000
b.ne	L_2fb4
b	put_16bpc_neon
L_2d28:
cmp	w4, #0x4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_2d3c
mov	w6, w10
L_2d3c:
tst	w7, #0x1fc000
add	x6, x11, w6, uxtw #3
b.ne	L_37ac
adrp	x10, put_8tap_h_tbl
add	x10, x10, :lo12:put_8tap_h_tbl
ldrsw	x9, [x10, x9, lsl #2]
mov	w12, #0x22
mov	w13, #0x28
cmp	w8, #0x2
csel	w12, w12, w13, ne
add	x10, x10, x9
dup	v30.4s, w12
br	x10
L_2d70:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_2d8c:
ld1	{ v4.8h }, [x2], x3
ld1	{ v6.8h }, [x10], x3
mov	v2.16b, v30.16b
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
subs	w5, w5, #0x2
trn1	v3.2s, v4.2s, v6.2s
trn2	v6.2s, v4.2s, v6.2s
trn1	v4.2s, v5.2s, v7.2s
trn2	v7.2s, v5.2s, v7.2s
smlal	v2.4s, v3.4h, v0.h[0]
smlal	v2.4s, v4.4h, v0.h[1]
smlal	v2.4s, v6.4h, v0.h[2]
smlal	v2.4s, v7.4h, v0.h[3]
sqshrun	v2.4h, v2.4s, #0x6
umin	v2.4h, v2.4h, v31.4h
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x9], x1
b.gt	L_2d8c
ret
L_2ddc:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_2df8:
ld1	{ v16.8h }, [x2], x3
ld1	{ v20.8h }, [x10], x3
mov	v2.16b, v30.16b
mov	v3.16b, v30.16b
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w5, w5, #0x2
smlal	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v17.4h, v0.h[1]
smlal	v2.4s, v18.4h, v0.h[2]
smlal	v2.4s, v19.4h, v0.h[3]
smlal	v3.4s, v20.4h, v0.h[0]
smlal	v3.4s, v21.4h, v0.h[1]
smlal	v3.4s, v22.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
sqshrun	v16.4h, v2.4s, #0x6
sqshrun2	v16.8h, v3.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
st1	{ v16.8b }, [x0], x1
st1	{ v16.d }[1], [x9], x1
b.gt	L_2df8
ret
L_2e60:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x6
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
sub	x3, x3, w4, uxtw #1
sub	x3, x3, #0x10
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
L_2e88:
ld1	{ v16.8h, v17.8h }, [x2], #32
ld1	{ v20.8h, v21.8h }, [x10], #32
mov	w6, w4
L_2e94:
mov	v18.16b, v30.16b
mov	v19.16b, v30.16b
smlal	v18.4s, v16.4h, v0.h[0]
smlal2	v19.4s, v16.8h, v0.h[0]
mov	v22.16b, v30.16b
mov	v23.16b, v30.16b
smlal	v22.4s, v20.4h, v0.h[0]
smlal2	v23.4s, v20.8h, v0.h[0]
ext	v24.16b, v16.16b, v17.16b, #0x2
ext	v25.16b, v20.16b, v21.16b, #0x2
smlal	v18.4s, v24.4h, v0.h[1]
smlal2	v19.4s, v24.8h, v0.h[1]
smlal	v22.4s, v25.4h, v0.h[1]
smlal2	v23.4s, v25.8h, v0.h[1]
ext	v24.16b, v16.16b, v17.16b, #0x4
ext	v25.16b, v20.16b, v21.16b, #0x4
smlal	v18.4s, v24.4h, v0.h[2]
smlal2	v19.4s, v24.8h, v0.h[2]
smlal	v22.4s, v25.4h, v0.h[2]
smlal2	v23.4s, v25.8h, v0.h[2]
ext	v24.16b, v16.16b, v17.16b, #0x6
ext	v25.16b, v20.16b, v21.16b, #0x6
smlal	v18.4s, v24.4h, v0.h[3]
smlal2	v19.4s, v24.8h, v0.h[3]
smlal	v22.4s, v25.4h, v0.h[3]
smlal2	v23.4s, v25.8h, v0.h[3]
ext	v24.16b, v16.16b, v17.16b, #0x8
ext	v25.16b, v20.16b, v21.16b, #0x8
smlal	v18.4s, v24.4h, v0.h[4]
smlal2	v19.4s, v24.8h, v0.h[4]
smlal	v22.4s, v25.4h, v0.h[4]
smlal2	v23.4s, v25.8h, v0.h[4]
ext	v24.16b, v16.16b, v17.16b, #0xa
ext	v25.16b, v20.16b, v21.16b, #0xa
smlal	v18.4s, v24.4h, v0.h[5]
smlal2	v19.4s, v24.8h, v0.h[5]
smlal	v22.4s, v25.4h, v0.h[5]
smlal2	v23.4s, v25.8h, v0.h[5]
ext	v24.16b, v16.16b, v17.16b, #0xc
ext	v25.16b, v20.16b, v21.16b, #0xc
smlal	v18.4s, v24.4h, v0.h[6]
smlal2	v19.4s, v24.8h, v0.h[6]
smlal	v22.4s, v25.4h, v0.h[6]
smlal2	v23.4s, v25.8h, v0.h[6]
ext	v24.16b, v16.16b, v17.16b, #0xe
ext	v25.16b, v20.16b, v21.16b, #0xe
smlal	v18.4s, v24.4h, v0.h[7]
smlal2	v19.4s, v24.8h, v0.h[7]
smlal	v22.4s, v25.4h, v0.h[7]
smlal2	v23.4s, v25.8h, v0.h[7]
subs	w6, w6, #0x8
sqshrun	v18.4h, v18.4s, #0x6
sqshrun2	v18.8h, v19.4s, #0x6
sqshrun	v22.4h, v22.4s, #0x6
sqshrun2	v22.8h, v23.4s, #0x6
umin	v18.8h, v18.8h, v31.8h
umin	v22.8h, v22.8h, v31.8h
st1	{ v18.8h }, [x0], #16
st1	{ v22.8h }, [x9], #16
b.le	L_2f98
mov	v16.16b, v17.16b
mov	v20.16b, v21.16b
ld1	{ v17.8h }, [x2], #16
ld1	{ v21.8h }, [x10], #16
b	L_2e94
L_2f98:
add	x0, x0, x1
add	x9, x9, x1
add	x2, x2, x3
add	x10, x10, x3
subs	w5, w5, #0x2
b.gt	L_2e88
ret
L_2fb4:
cmp	w5, #0x4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_2fc8
mov	w7, w10
L_2fc8:
add	x7, x11, w7, uxtw #3
adrp	x10, put_8tap_v_tbl
add	x10, x10, :lo12:put_8tap_v_tbl
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
br	x10
L_2fe0:
b.gt	L_30a0
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x10], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x10], x3
ld1	{ v5.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
b.gt	L_3050
smull	v6.4s, v1.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[1]
smlal	v6.4s, v3.4h, v0.h[2]
smlal	v6.4s, v4.4h, v0.h[3]
sqrshrun	v6.4h, v6.4s, #0x6
umin	v6.8h, v6.8h, v31.8h
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x9], x1
ret
L_3050:
ld1	{ v6.s }[0], [x10], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
smull	v16.4s, v1.4h, v0.h[0]
smlal	v16.4s, v2.4h, v0.h[1]
smlal	v16.4s, v3.4h, v0.h[2]
smlal	v16.4s, v4.4h, v0.h[3]
smull	v17.4s, v3.4h, v0.h[0]
smlal	v17.4s, v4.4h, v0.h[1]
smlal	v17.4s, v5.4h, v0.h[2]
smlal	v17.4s, v6.4h, v0.h[3]
sqrshrun	v16.4h, v16.4s, #0x6
sqrshrun2	v16.8h, v17.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
st1	{ v16.s }[0], [x0], x1
st1	{ v16.s }[1], [x9], x1
st1	{ v16.s }[2], [x0], x1
st1	{ v16.s }[3], [x9], x1
ret
L_30a0:
ld1	{ v0.8b }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x10], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x10], x3
ld1	{ v5.s }[0], [x2], x3
ld1	{ v6.s }[0], [x10], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
L_30f0:
subs	w5, w5, #0x4
ld1	{ v16.s }[0], [x10], x3
ld1	{ v17.s }[0], [x2], x3
ld1	{ v18.s }[0], [x10], x3
ld1	{ v19.s }[0], [x2], x3
trn1	v7.2s, v7.2s, v16.2s
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
smull	v24.4s, v1.4h, v0.h[0]
smlal	v24.4s, v2.4h, v0.h[1]
smlal	v24.4s, v3.4h, v0.h[2]
smlal	v24.4s, v4.4h, v0.h[3]
smlal	v24.4s, v5.4h, v0.h[4]
smlal	v24.4s, v6.4h, v0.h[5]
smlal	v24.4s, v7.4h, v0.h[6]
smlal	v24.4s, v16.4h, v0.h[7]
smull	v25.4s, v3.4h, v0.h[0]
smlal	v25.4s, v4.4h, v0.h[1]
smlal	v25.4s, v5.4h, v0.h[2]
smlal	v25.4s, v6.4h, v0.h[3]
smlal	v25.4s, v7.4h, v0.h[4]
smlal	v25.4s, v16.4h, v0.h[5]
smlal	v25.4s, v17.4h, v0.h[6]
smlal	v25.4s, v18.4h, v0.h[7]
sqrshrun	v24.4h, v24.4s, #0x6
sqrshrun2	v24.8h, v25.4s, #0x6
umin	v24.8h, v24.8h, v31.8h
st1	{ v24.s }[0], [x0], x1
st1	{ v24.s }[1], [x9], x1
st1	{ v24.s }[2], [x0], x1
st1	{ v24.s }[3], [x9], x1
b.le	L_31dc
cmp	w5, #0x2
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
mov	v4.16b, v16.16b
mov	v5.16b, v17.16b
mov	v6.16b, v18.16b
mov	v7.16b, v19.16b
b.eq	L_319c
b	L_30f0
L_319c:
ld1	{ v16.s }[0], [x10], x3
ld1	{ v17.s }[0], [x2], x3
trn1	v7.2s, v7.2s, v16.2s
trn1	v16.2s, v16.2s, v17.2s
smull	v24.4s, v1.4h, v0.h[0]
smlal	v24.4s, v2.4h, v0.h[1]
smlal	v24.4s, v3.4h, v0.h[2]
smlal	v24.4s, v4.4h, v0.h[3]
smlal	v24.4s, v5.4h, v0.h[4]
smlal	v24.4s, v6.4h, v0.h[5]
smlal	v24.4s, v7.4h, v0.h[6]
smlal	v24.4s, v16.4h, v0.h[7]
sqrshrun	v24.4h, v24.4s, #0x6
umin	v24.4h, v24.4h, v31.4h
st1	{ v24.s }[0], [x0], x1
st1	{ v24.s }[1], [x9], x1
L_31dc:
ret
L_31e0:
b.gt	L_3290
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.4h }, [x2], x3
ld1	{ v2.4h }, [x10], x3
ld1	{ v3.4h }, [x2], x3
ld1	{ v4.4h }, [x10], x3
ld1	{ v5.4h }, [x2], x3
smull	v6.4s, v1.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[1]
smlal	v6.4s, v3.4h, v0.h[2]
smlal	v6.4s, v4.4h, v0.h[3]
smull	v7.4s, v2.4h, v0.h[0]
smlal	v7.4s, v3.4h, v0.h[1]
smlal	v7.4s, v4.4h, v0.h[2]
smlal	v7.4s, v5.4h, v0.h[3]
sqrshrun	v6.4h, v6.4s, #0x6
sqrshrun2	v6.8h, v7.4s, #0x6
umin	v6.8h, v6.8h, v31.8h
st1	{ v6.8b }, [x0], x1
st1	{ v6.d }[1], [x9], x1
b.le	L_328c
ld1	{ v6.4h }, [x10], x3
ld1	{ v7.4h }, [x2], x3
smull	v1.4s, v3.4h, v0.h[0]
smlal	v1.4s, v4.4h, v0.h[1]
smlal	v1.4s, v5.4h, v0.h[2]
smlal	v1.4s, v6.4h, v0.h[3]
smull	v2.4s, v4.4h, v0.h[0]
smlal	v2.4s, v5.4h, v0.h[1]
smlal	v2.4s, v6.4h, v0.h[2]
smlal	v2.4s, v7.4h, v0.h[3]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
st1	{ v1.8b }, [x0], x1
st1	{ v1.d }[1], [x9], x1
L_328c:
ret
L_3290:
ld1	{ v0.8b }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.4h }, [x2], x3
ld1	{ v17.4h }, [x10], x3
ld1	{ v18.4h }, [x2], x3
ld1	{ v19.4h }, [x10], x3
ld1	{ v20.4h }, [x2], x3
ld1	{ v21.4h }, [x10], x3
ld1	{ v22.4h }, [x2], x3
L_32c8:
subs	w5, w5, #0x4
ld1	{ v23.4h }, [x10], x3
ld1	{ v24.4h }, [x2], x3
ld1	{ v25.4h }, [x10], x3
ld1	{ v26.4h }, [x2], x3
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smlal	v1.4s, v23.4h, v0.h[7]
smull	v2.4s, v17.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
smlal	v2.4s, v24.4h, v0.h[7]
smull	v3.4s, v18.4h, v0.h[0]
smlal	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v20.4h, v0.h[2]
smlal	v3.4s, v21.4h, v0.h[3]
smlal	v3.4s, v22.4h, v0.h[4]
smlal	v3.4s, v23.4h, v0.h[5]
smlal	v3.4s, v24.4h, v0.h[6]
smlal	v3.4s, v25.4h, v0.h[7]
smull	v4.4s, v19.4h, v0.h[0]
smlal	v4.4s, v20.4h, v0.h[1]
smlal	v4.4s, v21.4h, v0.h[2]
smlal	v4.4s, v22.4h, v0.h[3]
smlal	v4.4s, v23.4h, v0.h[4]
smlal	v4.4s, v24.4h, v0.h[5]
smlal	v4.4s, v25.4h, v0.h[6]
smlal	v4.4s, v26.4h, v0.h[7]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
st1	{ v1.8b }, [x0], x1
st1	{ v1.d }[1], [x9], x1
st1	{ v3.8b }, [x0], x1
st1	{ v3.d }[1], [x9], x1
b.le	L_340c
cmp	w5, #0x2
mov	v16.8b, v20.8b
mov	v17.8b, v21.8b
mov	v18.8b, v22.8b
mov	v19.8b, v23.8b
mov	v20.8b, v24.8b
mov	v21.8b, v25.8b
mov	v22.8b, v26.8b
b.eq	L_33b0
b	L_32c8
L_33b0:
ld1	{ v23.4h }, [x10], x3
ld1	{ v24.4h }, [x2], x3
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smlal	v1.4s, v23.4h, v0.h[7]
smull	v2.4s, v17.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
smlal	v2.4s, v24.4h, v0.h[7]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
st1	{ v1.8b }, [x0], x1
st1	{ v1.d }[1], [x9], x1
L_340c:
ret
L_3410:
b.gt	L_3518
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8h }, [x2], x3
ld1	{ v2.8h }, [x10], x3
ld1	{ v3.8h }, [x2], x3
ld1	{ v4.8h }, [x10], x3
ld1	{ v5.8h }, [x2], x3
smull	v16.4s, v1.4h, v0.h[0]
smlal	v16.4s, v2.4h, v0.h[1]
smlal	v16.4s, v3.4h, v0.h[2]
smlal	v16.4s, v4.4h, v0.h[3]
smull2	v17.4s, v1.8h, v0.h[0]
smlal2	v17.4s, v2.8h, v0.h[1]
smlal2	v17.4s, v3.8h, v0.h[2]
smlal2	v17.4s, v4.8h, v0.h[3]
smull	v18.4s, v2.4h, v0.h[0]
smlal	v18.4s, v3.4h, v0.h[1]
smlal	v18.4s, v4.4h, v0.h[2]
smlal	v18.4s, v5.4h, v0.h[3]
smull2	v19.4s, v2.8h, v0.h[0]
smlal2	v19.4s, v3.8h, v0.h[1]
smlal2	v19.4s, v4.8h, v0.h[2]
smlal2	v19.4s, v5.8h, v0.h[3]
sqrshrun	v16.4h, v16.4s, #0x6
sqrshrun2	v16.8h, v17.4s, #0x6
sqrshrun	v18.4h, v18.4s, #0x6
sqrshrun2	v18.8h, v19.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
umin	v18.8h, v18.8h, v31.8h
st1	{ v16.8h }, [x0], x1
st1	{ v18.8h }, [x9], x1
b.le	L_3514
ld1	{ v6.8h }, [x10], x3
ld1	{ v7.8h }, [x2], x3
smull	v16.4s, v3.4h, v0.h[0]
smlal	v16.4s, v4.4h, v0.h[1]
smlal	v16.4s, v5.4h, v0.h[2]
smlal	v16.4s, v6.4h, v0.h[3]
smull2	v17.4s, v3.8h, v0.h[0]
smlal2	v17.4s, v4.8h, v0.h[1]
smlal2	v17.4s, v5.8h, v0.h[2]
smlal2	v17.4s, v6.8h, v0.h[3]
smull	v18.4s, v4.4h, v0.h[0]
smlal	v18.4s, v5.4h, v0.h[1]
smlal	v18.4s, v6.4h, v0.h[2]
smlal	v18.4s, v7.4h, v0.h[3]
smull2	v19.4s, v4.8h, v0.h[0]
smlal2	v19.4s, v5.8h, v0.h[1]
smlal2	v19.4s, v6.8h, v0.h[2]
smlal2	v19.4s, v7.8h, v0.h[3]
sqrshrun	v16.4h, v16.4s, #0x6
sqrshrun2	v16.8h, v17.4s, #0x6
sqrshrun	v18.4h, v18.4s, #0x6
sqrshrun2	v18.8h, v19.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
umin	v18.8h, v18.8h, v31.8h
st1	{ v16.8h }, [x0], x1
st1	{ v18.8h }, [x9], x1
L_3514:
ret
L_3518:
ld1	{ v0.8b }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w7, w5
L_352c:
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8h }, [x2], x3
ld1	{ v17.8h }, [x10], x3
ld1	{ v18.8h }, [x2], x3
ld1	{ v19.8h }, [x10], x3
ld1	{ v20.8h }, [x2], x3
ld1	{ v21.8h }, [x10], x3
ld1	{ v22.8h }, [x2], x3
L_3558:
subs	w5, w5, #0x2
ld1	{ v23.8h }, [x10], x3
ld1	{ v24.8h }, [x2], x3
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smlal	v1.4s, v23.4h, v0.h[7]
smull2	v2.4s, v16.8h, v0.h[0]
smlal2	v2.4s, v17.8h, v0.h[1]
smlal2	v2.4s, v18.8h, v0.h[2]
smlal2	v2.4s, v19.8h, v0.h[3]
smlal2	v2.4s, v20.8h, v0.h[4]
smlal2	v2.4s, v21.8h, v0.h[5]
smlal2	v2.4s, v22.8h, v0.h[6]
smlal2	v2.4s, v23.8h, v0.h[7]
smull	v3.4s, v17.4h, v0.h[0]
smlal	v3.4s, v18.4h, v0.h[1]
smlal	v3.4s, v19.4h, v0.h[2]
smlal	v3.4s, v20.4h, v0.h[3]
smlal	v3.4s, v21.4h, v0.h[4]
smlal	v3.4s, v22.4h, v0.h[5]
smlal	v3.4s, v23.4h, v0.h[6]
smlal	v3.4s, v24.4h, v0.h[7]
smull2	v4.4s, v17.8h, v0.h[0]
smlal2	v4.4s, v18.8h, v0.h[1]
smlal2	v4.4s, v19.8h, v0.h[2]
smlal2	v4.4s, v20.8h, v0.h[3]
smlal2	v4.4s, v21.8h, v0.h[4]
smlal2	v4.4s, v22.8h, v0.h[5]
smlal2	v4.4s, v23.8h, v0.h[6]
smlal2	v4.4s, v24.8h, v0.h[7]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
st1	{ v1.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_36d8
subs	w5, w5, #0x2
ld1	{ v25.8h }, [x10], x3
ld1	{ v26.8h }, [x2], x3
smull	v1.4s, v18.4h, v0.h[0]
smlal	v1.4s, v19.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v21.4h, v0.h[3]
smlal	v1.4s, v22.4h, v0.h[4]
smlal	v1.4s, v23.4h, v0.h[5]
smlal	v1.4s, v24.4h, v0.h[6]
smlal	v1.4s, v25.4h, v0.h[7]
smull2	v2.4s, v18.8h, v0.h[0]
smlal2	v2.4s, v19.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v21.8h, v0.h[3]
smlal2	v2.4s, v22.8h, v0.h[4]
smlal2	v2.4s, v23.8h, v0.h[5]
smlal2	v2.4s, v24.8h, v0.h[6]
smlal2	v2.4s, v25.8h, v0.h[7]
smull	v3.4s, v19.4h, v0.h[0]
smlal	v3.4s, v20.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v22.4h, v0.h[3]
smlal	v3.4s, v23.4h, v0.h[4]
smlal	v3.4s, v24.4h, v0.h[5]
smlal	v3.4s, v25.4h, v0.h[6]
smlal	v3.4s, v26.4h, v0.h[7]
smull2	v4.4s, v19.8h, v0.h[0]
smlal2	v4.4s, v20.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v22.8h, v0.h[3]
smlal2	v4.4s, v23.8h, v0.h[4]
smlal2	v4.4s, v24.8h, v0.h[5]
smlal2	v4.4s, v25.8h, v0.h[6]
smlal2	v4.4s, v26.8h, v0.h[7]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
st1	{ v1.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_36d8
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
mov	v18.16b, v22.16b
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
mov	v21.16b, v25.16b
mov	v22.16b, v26.16b
b	L_3558
L_36d8:
subs	w4, w4, #0x8
b.le	L_3704
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_352c
L_3704:
ret
L_3708:
b.gt	L_3518
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.8h, v17.8h }, [x2], x3
ld1	{ v18.8h, v19.8h }, [x2], x3
ld1	{ v20.8h, v21.8h }, [x2], x3
L_3724:
ld1	{ v22.8h, v23.8h }, [x2], x3
subs	w5, w5, #0x1
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v18.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v22.4h, v0.h[3]
smull2	v2.4s, v16.8h, v0.h[0]
smlal2	v2.4s, v18.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v22.8h, v0.h[3]
smull	v3.4s, v17.4h, v0.h[0]
smlal	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
smull2	v4.4s, v17.8h, v0.h[0]
smlal2	v4.4s, v19.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v23.8h, v0.h[3]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v3.8h, v31.8h
st1	{ v1.8h, v2.8h }, [x0], x1
b.le	L_37a8
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
b	L_3724
L_37a8:
ret
L_37ac:
cmp	w5, #0x4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_37c0
mov	w7, w10
L_37c0:
add	x7, x11, w7, uxtw #3
adrp	x10, put_8tap_hv_tbl
add	x10, x10, :lo12:put_8tap_hv_tbl
dup	v30.4s, w12
ldrsw	x9, [x10, x9, lsl #2]
neg	v30.4s, v30.4s
dup	v29.4s, w13
add	x10, x10, x9
neg	v29.4s, v29.4s
br	x10
L_37e8:
ldur	s0, [x6, #0x2]
b.gt	L_3880
ldur	s1, [x7, #0x2]
sub	x10, x2, #0x2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v27.8h }, [x2], x3
ext	v28.16b, v27.16b, v27.16b, #0x2
smull	v27.4s, v27.4h, v0.4h
smull	v28.4s, v28.4h, v0.4h
addp	v27.4s, v27.4s, v28.4s
addp	v16.4s, v27.4s, v27.4s
srshl	v16.2s, v16.2s, v30.2s
bl	L_3950
xtn	v16.4h, v16.4s
trn1	v16.2s, v16.2s, v24.2s
mov	v17.8b, v24.8b
L_3840:
bl	L_3950
ext	v18.8b, v17.8b, v24.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
srshl	v2.4s, v2.4s, v29.4s
sqxtun	v2.4h, v2.4s
umin	v2.4h, v2.4h, v31.4h
subs	w5, w5, #0x2
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x9], x1
b.le	L_394c
mov	v16.8b, v18.8b
mov	v17.8b, v24.8b
b	L_3840
L_3880:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x2
sub	x10, x2, x3, lsl #1
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v27.8h }, [x2], x3
ext	v28.16b, v27.16b, v27.16b, #0x2
smull	v27.4s, v27.4h, v0.4h
smull	v28.4s, v28.4h, v0.4h
addp	v27.4s, v27.4s, v28.4s
addp	v16.4s, v27.4s, v27.4s
srshl	v16.2s, v16.2s, v30.2s
bl	L_3950
xtn	v16.4h, v16.4s
trn1	v16.2s, v16.2s, v24.2s
mov	v17.8b, v24.8b
bl	L_3950
ext	v18.8b, v17.8b, v24.8b, #0x4
mov	v19.8b, v24.8b
bl	L_3950
ext	v20.8b, v19.8b, v24.8b, #0x4
mov	v21.8b, v24.8b
L_38ec:
bl	L_3950
ext	v22.8b, v21.8b, v24.8b, #0x4
smull	v3.4s, v16.4h, v1.h[0]
smlal	v3.4s, v17.4h, v1.h[1]
smlal	v3.4s, v18.4h, v1.h[2]
smlal	v3.4s, v19.4h, v1.h[3]
smlal	v3.4s, v20.4h, v1.h[4]
smlal	v3.4s, v21.4h, v1.h[5]
smlal	v3.4s, v22.4h, v1.h[6]
smlal	v3.4s, v24.4h, v1.h[7]
srshl	v3.4s, v3.4s, v29.4s
sqxtun	v3.4h, v3.4s
umin	v3.4h, v3.4h, v31.4h
subs	w5, w5, #0x2
st1	{ v3.s }[0], [x0], x1
st1	{ v3.s }[1], [x9], x1
b.le	L_394c
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v24.8b
b	L_38ec
L_394c:
ret	x15
L_3950:
ld1	{ v25.8h }, [x10], x3
ld1	{ v27.8h }, [x2], x3
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v28.16b, v27.16b, v27.16b, #0x2
trn1	v24.2s, v25.2s, v27.2s
trn2	v27.2s, v25.2s, v27.2s
trn1	v25.2s, v26.2s, v28.2s
trn2	v28.2s, v26.2s, v28.2s
smull	v24.4s, v24.4h, v0.h[0]
smlal	v24.4s, v25.4h, v0.h[1]
smlal	v24.4s, v27.4h, v0.h[2]
smlal	v24.4s, v28.4h, v0.h[3]
srshl	v24.4s, v24.4s, v30.4s
xtn	v24.4h, v24.4s
ret
L_398c:
ldur	s0, [x6, #0x2]
b.gt	L_3a44
ldur	s1, [x7, #0x2]
sub	x10, x2, #0x2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x2], x3
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v16.4h, v16.4s
bl	L_3b44
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
L_39ec:
bl	L_3b44
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v24.4h, v1.h[2]
smlal	v3.4s, v25.4h, v1.h[3]
srshl	v2.4s, v2.4s, v29.4s
srshl	v3.4s, v3.4s, v29.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
umin	v2.8h, v2.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v2.8b }, [x0], x1
st1	{ v2.d }[1], [x9], x1
b.le	L_3b40
mov	v16.8b, v18.8b
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
b	L_39ec
L_3a44:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x2
sub	x10, x2, x3, lsl #1
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x2], x3
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v16.4h, v16.4s
bl	L_3b44
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
bl	L_3b44
mov	v19.8b, v24.8b
mov	v20.8b, v25.8b
bl	L_3b44
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
L_3ab8:
bl	L_3b44
smull	v3.4s, v16.4h, v1.h[0]
smlal	v3.4s, v17.4h, v1.h[1]
smlal	v3.4s, v18.4h, v1.h[2]
smlal	v3.4s, v19.4h, v1.h[3]
smlal	v3.4s, v20.4h, v1.h[4]
smlal	v3.4s, v21.4h, v1.h[5]
smlal	v3.4s, v22.4h, v1.h[6]
smlal	v3.4s, v24.4h, v1.h[7]
smull	v4.4s, v17.4h, v1.h[0]
smlal	v4.4s, v18.4h, v1.h[1]
smlal	v4.4s, v19.4h, v1.h[2]
smlal	v4.4s, v20.4h, v1.h[3]
smlal	v4.4s, v21.4h, v1.h[4]
smlal	v4.4s, v22.4h, v1.h[5]
smlal	v4.4s, v24.4h, v1.h[6]
smlal	v4.4s, v25.4h, v1.h[7]
srshl	v3.4s, v3.4s, v29.4s
srshl	v4.4s, v4.4s, v29.4s
sqxtun	v3.4h, v3.4s
sqxtun2	v3.8h, v4.4s
umin	v3.8h, v3.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v3.8b }, [x0], x1
st1	{ v3.d }[1], [x9], x1
b.le	L_3b40
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
b	L_3ab8
L_3b40:
ret	x15
L_3b44:
ld1	{ v24.8h }, [x10], x3
ld1	{ v25.8h }, [x2], x3
ext	v26.16b, v24.16b, v24.16b, #0x2
ext	v27.16b, v24.16b, v24.16b, #0x4
ext	v28.16b, v24.16b, v24.16b, #0x6
smull	v24.4s, v24.4h, v0.h[0]
smlal	v24.4s, v26.4h, v0.h[1]
smlal	v24.4s, v27.4h, v0.h[2]
smlal	v24.4s, v28.4h, v0.h[3]
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
xtn	v24.4h, v24.4s
xtn	v25.4h, v25.4s
ret
L_3b98:
b.gt	L_3cfc
ld1	{ v0.8b }, [x6]
ldur	s1, [x7, #0x2]
sub	x2, x2, #0x6
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_3bbc:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1	{ v27.8h, v28.8h }, [x2], x3
smull	v24.4s, v27.4h, v0.h[0]
smull2	v25.4s, v27.8h, v0.h[0]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[1]
smlal2	v25.4s, v26.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xc
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
ext	v26.16b, v27.16b, v28.16b, #0xe
smlal	v24.4s, v26.4h, v0.h[7]
smlal2	v25.4s, v26.8h, v0.h[7]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v16.8h, v24.8h, v25.8h
bl	L_3ecc
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
L_3c44:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_3ecc
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v23.4h, v1.h[2]
smlal2	v5.4s, v23.8h, v1.h[2]
smlal	v2.4s, v23.4h, v1.h[3]
smlal2	v3.4s, v23.8h, v1.h[3]
smlal	v4.4s, v24.4h, v1.h[3]
smlal2	v5.4s, v24.8h, v1.h[3]
srshl	v2.4s, v2.4s, v29.4s
srshl	v3.4s, v3.4s, v29.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
sqxtun	v3.4h, v4.4s
sqxtun2	v3.8h, v5.4s
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v2.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_3cd0
mov	v16.16b, v18.16b
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
b	L_3c44
L_3cd0:
subs	w4, w4, #0x8
b.le	L_3ec8
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_3bbc
L_3cfc:
ld1	{ v0.8b }, [x6]
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x6
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_3d20:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1	{ v27.8h, v28.8h }, [x2], x3
smull	v24.4s, v27.4h, v0.h[0]
smull2	v25.4s, v27.8h, v0.h[0]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[1]
smlal2	v25.4s, v26.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xc
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
ext	v26.16b, v27.16b, v28.16b, #0xe
smlal	v24.4s, v26.4h, v0.h[7]
smlal2	v25.4s, v26.8h, v0.h[7]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v16.8h, v24.8h, v25.8h
bl	L_3ecc
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
bl	L_3ecc
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
bl	L_3ecc
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
L_3dc0:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_3ecc
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
smlal	v4.4s, v23.4h, v1.h[6]
smlal2	v5.4s, v23.8h, v1.h[6]
smlal	v2.4s, v23.4h, v1.h[7]
smlal2	v3.4s, v23.8h, v1.h[7]
smlal	v4.4s, v24.4h, v1.h[7]
smlal2	v5.4s, v24.8h, v1.h[7]
srshl	v2.4s, v2.4s, v29.4s
srshl	v3.4s, v3.4s, v29.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
sqxtun	v3.4h, v4.4s
sqxtun2	v3.8h, v5.4s
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v2.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_3e9c
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
b	L_3dc0
L_3e9c:
subs	w4, w4, #0x8
b.le	L_3ec8
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_3d20
L_3ec8:
ret	x15
L_3ecc:
ld1	{ v4.8h, v5.8h }, [x10], x3
ld1	{ v6.8h, v7.8h }, [x2], x3
smull	v25.4s, v4.4h, v0.h[0]
smull2	v26.4s, v4.8h, v0.h[0]
smull	v27.4s, v6.4h, v0.h[0]
smull2	v28.4s, v6.8h, v0.h[0]
ext	v23.16b, v4.16b, v5.16b, #0x2
ext	v24.16b, v6.16b, v7.16b, #0x2
smlal	v25.4s, v23.4h, v0.h[1]
smlal2	v26.4s, v23.8h, v0.h[1]
smlal	v27.4s, v24.4h, v0.h[1]
smlal2	v28.4s, v24.8h, v0.h[1]
ext	v23.16b, v4.16b, v5.16b, #0x4
ext	v24.16b, v6.16b, v7.16b, #0x4
smlal	v25.4s, v23.4h, v0.h[2]
smlal2	v26.4s, v23.8h, v0.h[2]
smlal	v27.4s, v24.4h, v0.h[2]
smlal2	v28.4s, v24.8h, v0.h[2]
ext	v23.16b, v4.16b, v5.16b, #0x6
ext	v24.16b, v6.16b, v7.16b, #0x6
smlal	v25.4s, v23.4h, v0.h[3]
smlal2	v26.4s, v23.8h, v0.h[3]
smlal	v27.4s, v24.4h, v0.h[3]
smlal2	v28.4s, v24.8h, v0.h[3]
ext	v23.16b, v4.16b, v5.16b, #0x8
ext	v24.16b, v6.16b, v7.16b, #0x8
smlal	v25.4s, v23.4h, v0.h[4]
smlal2	v26.4s, v23.8h, v0.h[4]
smlal	v27.4s, v24.4h, v0.h[4]
smlal2	v28.4s, v24.8h, v0.h[4]
ext	v23.16b, v4.16b, v5.16b, #0xa
ext	v24.16b, v6.16b, v7.16b, #0xa
smlal	v25.4s, v23.4h, v0.h[5]
smlal2	v26.4s, v23.8h, v0.h[5]
smlal	v27.4s, v24.4h, v0.h[5]
smlal2	v28.4s, v24.8h, v0.h[5]
ext	v23.16b, v4.16b, v5.16b, #0xc
ext	v24.16b, v6.16b, v7.16b, #0xc
smlal	v25.4s, v23.4h, v0.h[6]
smlal2	v26.4s, v23.8h, v0.h[6]
smlal	v27.4s, v24.4h, v0.h[6]
smlal2	v28.4s, v24.8h, v0.h[6]
ext	v23.16b, v4.16b, v5.16b, #0xe
ext	v24.16b, v6.16b, v7.16b, #0xe
smlal	v25.4s, v23.4h, v0.h[7]
smlal2	v26.4s, v23.8h, v0.h[7]
smlal	v27.4s, v24.4h, v0.h[7]
smlal2	v28.4s, v24.8h, v0.h[7]
srshl	v25.4s, v25.4s, v30.4s
srshl	v26.4s, v26.4s, v30.4s
srshl	v27.4s, v27.4s, v30.4s
srshl	v28.4s, v28.4s, v30.4s
uzp1	v23.8h, v25.8h, v26.8h
uzp1	v24.8h, v27.8h, v28.8h
ret
put_8tap_regular_16bpc_neon:
mov	w9, #0x2d
mov	w10, #0x2d
b	put_6tap_neon
put_8tap_regular_smooth_16bpc_neon:
mov	w9, #0x2d
mov	w10, #0x7bc
b	put_6tap_neon
put_8tap_smooth_16bpc_neon:
mov	w9, #0x7bc
mov	w10, #0x7bc
b	put_6tap_neon
put_8tap_smooth_regular_16bpc_neon:
mov	w9, #0x7bc
mov	w10, #0x2d
b	put_6tap_neon
put_6tap_neon:
ldr	w8, [sp]
mov	w11, #0x4081
mul	w6, w6, w11
mul	w7, w7, w11
add	w6, w6, w9
add	w7, w7, w10
dup	v31.8h, w8
clz	w8, w8
clz	w9, w4
sub	w8, w8, #0x12
mov	w12, #0x6
tst	w6, #0x1fc000
sub	w9, w9, #0x18
add	w13, w12, w8
sub	w12, w12, w8
adrp	x11, mc_subpel_filters-8
add	x11, x11, :lo12:mc_subpel_filters-8
b.ne	L_402c
tst	w7, #0x1fc000
b.ne	L_4288
b	put_16bpc_neon
L_402c:
cmp	w4, #0x4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_4040
mov	w6, w10
L_4040:
tst	w7, #0x1fc000
add	x6, x11, w6, uxtw #3
b.ne	L_49f8
adrp	x10, put_6tap_h_tbl
add	x10, x10, :lo12:put_6tap_h_tbl
ldrsw	x9, [x10, x9, lsl #2]
mov	w12, #0x22
mov	w13, #0x28
cmp	w8, #0x2
csel	w12, w12, w13, ne
add	x10, x10, x9
dup	v30.4s, w12
br	x10
L_4074:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_4090:
ld1	{ v4.8h }, [x2], x3
ld1	{ v6.8h }, [x10], x3
mov	v2.16b, v30.16b
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
subs	w5, w5, #0x2
trn1	v3.2s, v4.2s, v6.2s
trn2	v6.2s, v4.2s, v6.2s
trn1	v4.2s, v5.2s, v7.2s
trn2	v7.2s, v5.2s, v7.2s
smlal	v2.4s, v3.4h, v0.h[0]
smlal	v2.4s, v4.4h, v0.h[1]
smlal	v2.4s, v6.4h, v0.h[2]
smlal	v2.4s, v7.4h, v0.h[3]
sqshrun	v2.4h, v2.4s, #0x6
umin	v2.4h, v2.4h, v31.4h
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x9], x1
b.gt	L_4090
ret
L_40e0:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x2
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
L_40fc:
ld1	{ v16.8h }, [x2], x3
ld1	{ v20.8h }, [x10], x3
mov	v2.16b, v30.16b
mov	v3.16b, v30.16b
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w5, w5, #0x2
smlal	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v17.4h, v0.h[1]
smlal	v2.4s, v18.4h, v0.h[2]
smlal	v2.4s, v19.4h, v0.h[3]
smlal	v3.4s, v20.4h, v0.h[0]
smlal	v3.4s, v21.4h, v0.h[1]
smlal	v3.4s, v22.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
sqshrun	v16.4h, v2.4s, #0x6
sqshrun2	v16.8h, v3.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
st1	{ v16.8b }, [x0], x1
st1	{ v16.d }[1], [x9], x1
b.gt	L_40fc
ret
L_4164:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x4
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
sub	x3, x3, w4, uxtw #1
sub	x3, x3, #0x10
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
L_418c:
ld1	{ v16.8h, v17.8h }, [x2], #32
ld1	{ v20.8h, v21.8h }, [x10], #32
mov	w6, w4
L_4198:
mov	v18.16b, v30.16b
mov	v19.16b, v30.16b
smlal	v18.4s, v16.4h, v0.h[1]
smlal2	v19.4s, v16.8h, v0.h[1]
mov	v22.16b, v30.16b
mov	v23.16b, v30.16b
smlal	v22.4s, v20.4h, v0.h[1]
smlal2	v23.4s, v20.8h, v0.h[1]
ext	v24.16b, v16.16b, v17.16b, #0x2
ext	v25.16b, v20.16b, v21.16b, #0x2
smlal	v18.4s, v24.4h, v0.h[2]
smlal2	v19.4s, v24.8h, v0.h[2]
smlal	v22.4s, v25.4h, v0.h[2]
smlal2	v23.4s, v25.8h, v0.h[2]
ext	v24.16b, v16.16b, v17.16b, #0x4
ext	v25.16b, v20.16b, v21.16b, #0x4
smlal	v18.4s, v24.4h, v0.h[3]
smlal2	v19.4s, v24.8h, v0.h[3]
smlal	v22.4s, v25.4h, v0.h[3]
smlal2	v23.4s, v25.8h, v0.h[3]
ext	v24.16b, v16.16b, v17.16b, #0x6
ext	v25.16b, v20.16b, v21.16b, #0x6
smlal	v18.4s, v24.4h, v0.h[4]
smlal2	v19.4s, v24.8h, v0.h[4]
smlal	v22.4s, v25.4h, v0.h[4]
smlal2	v23.4s, v25.8h, v0.h[4]
ext	v24.16b, v16.16b, v17.16b, #0x8
ext	v25.16b, v20.16b, v21.16b, #0x8
smlal	v18.4s, v24.4h, v0.h[5]
smlal2	v19.4s, v24.8h, v0.h[5]
smlal	v22.4s, v25.4h, v0.h[5]
smlal2	v23.4s, v25.8h, v0.h[5]
ext	v24.16b, v16.16b, v17.16b, #0xa
ext	v25.16b, v20.16b, v21.16b, #0xa
smlal	v18.4s, v24.4h, v0.h[6]
smlal2	v19.4s, v24.8h, v0.h[6]
smlal	v22.4s, v25.4h, v0.h[6]
smlal2	v23.4s, v25.8h, v0.h[6]
subs	w6, w6, #0x8
sqshrun	v18.4h, v18.4s, #0x6
sqshrun2	v18.8h, v19.4s, #0x6
sqshrun	v22.4h, v22.4s, #0x6
sqshrun2	v22.8h, v23.4s, #0x6
umin	v18.8h, v18.8h, v31.8h
umin	v22.8h, v22.8h, v31.8h
st1	{ v18.8h }, [x0], #16
st1	{ v22.8h }, [x9], #16
b.le	L_426c
mov	v16.16b, v17.16b
mov	v20.16b, v21.16b
ld1	{ v17.8h }, [x2], #16
ld1	{ v21.8h }, [x10], #16
b	L_4198
L_426c:
add	x0, x0, x1
add	x9, x9, x1
add	x2, x2, x3
add	x10, x10, x3
subs	w5, w5, #0x2
b.gt	L_418c
ret
L_4288:
cmp	w5, #0x4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_429c
mov	w7, w10
L_429c:
add	x7, x11, w7, uxtw #3
adrp	x10, put_6tap_v_tbl
add	x10, x10, :lo12:put_6tap_v_tbl
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
br	x10
L_42b4:
b.gt	L_4374
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x10], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x10], x3
ld1	{ v5.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
b.gt	L_4324
smull	v6.4s, v1.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[1]
smlal	v6.4s, v3.4h, v0.h[2]
smlal	v6.4s, v4.4h, v0.h[3]
sqrshrun	v6.4h, v6.4s, #0x6
umin	v6.8h, v6.8h, v31.8h
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x9], x1
ret
L_4324:
ld1	{ v6.s }[0], [x10], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
smull	v16.4s, v1.4h, v0.h[0]
smlal	v16.4s, v2.4h, v0.h[1]
smlal	v16.4s, v3.4h, v0.h[2]
smlal	v16.4s, v4.4h, v0.h[3]
smull	v17.4s, v3.4h, v0.h[0]
smlal	v17.4s, v4.4h, v0.h[1]
smlal	v17.4s, v5.4h, v0.h[2]
smlal	v17.4s, v6.4h, v0.h[3]
sqrshrun	v16.4h, v16.4s, #0x6
sqrshrun2	v16.8h, v17.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
st1	{ v16.s }[0], [x0], x1
st1	{ v16.s }[1], [x9], x1
st1	{ v16.s }[2], [x0], x1
st1	{ v16.s }[3], [x9], x1
ret
L_4374:
ld1	{ v0.8b }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x10], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x10], x3
ld1	{ v5.s }[0], [x2], x3
ld1	{ v6.s }[0], [x10], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
L_43c4:
subs	w5, w5, #0x4
ld1	{ v16.s }[0], [x10], x3
ld1	{ v17.s }[0], [x2], x3
ld1	{ v18.s }[0], [x10], x3
ld1	{ v19.s }[0], [x2], x3
trn1	v7.2s, v7.2s, v16.2s
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
smull	v24.4s, v2.4h, v0.h[1]
smlal	v24.4s, v3.4h, v0.h[2]
smlal	v24.4s, v4.4h, v0.h[3]
smlal	v24.4s, v5.4h, v0.h[4]
smlal	v24.4s, v6.4h, v0.h[5]
smlal	v24.4s, v7.4h, v0.h[6]
smull	v25.4s, v4.4h, v0.h[1]
smlal	v25.4s, v5.4h, v0.h[2]
smlal	v25.4s, v6.4h, v0.h[3]
smlal	v25.4s, v7.4h, v0.h[4]
smlal	v25.4s, v16.4h, v0.h[5]
smlal	v25.4s, v17.4h, v0.h[6]
sqrshrun	v24.4h, v24.4s, #0x6
sqrshrun2	v24.8h, v25.4s, #0x6
umin	v24.8h, v24.8h, v31.8h
st1	{ v24.s }[0], [x0], x1
st1	{ v24.s }[1], [x9], x1
st1	{ v24.s }[2], [x0], x1
st1	{ v24.s }[3], [x9], x1
b.le	L_4498
cmp	w5, #0x2
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
mov	v4.16b, v16.16b
mov	v5.16b, v17.16b
mov	v6.16b, v18.16b
mov	v7.16b, v19.16b
b.eq	L_4460
b	L_43c4
L_4460:
ld1	{ v16.s }[0], [x10], x3
ld1	{ v17.s }[0], [x2], x3
trn1	v7.2s, v7.2s, v16.2s
trn1	v16.2s, v16.2s, v17.2s
smull	v24.4s, v2.4h, v0.h[1]
smlal	v24.4s, v3.4h, v0.h[2]
smlal	v24.4s, v4.4h, v0.h[3]
smlal	v24.4s, v5.4h, v0.h[4]
smlal	v24.4s, v6.4h, v0.h[5]
smlal	v24.4s, v7.4h, v0.h[6]
sqrshrun	v24.4h, v24.4s, #0x6
umin	v24.4h, v24.4h, v31.4h
st1	{ v24.s }[0], [x0], x1
st1	{ v24.s }[1], [x9], x1
L_4498:
ret
L_449c:
b.gt	L_454c
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.4h }, [x2], x3
ld1	{ v2.4h }, [x10], x3
ld1	{ v3.4h }, [x2], x3
ld1	{ v4.4h }, [x10], x3
ld1	{ v5.4h }, [x2], x3
smull	v6.4s, v1.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[1]
smlal	v6.4s, v3.4h, v0.h[2]
smlal	v6.4s, v4.4h, v0.h[3]
smull	v7.4s, v2.4h, v0.h[0]
smlal	v7.4s, v3.4h, v0.h[1]
smlal	v7.4s, v4.4h, v0.h[2]
smlal	v7.4s, v5.4h, v0.h[3]
sqrshrun	v6.4h, v6.4s, #0x6
sqrshrun2	v6.8h, v7.4s, #0x6
umin	v6.8h, v6.8h, v31.8h
st1	{ v6.8b }, [x0], x1
st1	{ v6.d }[1], [x9], x1
b.le	L_4548
ld1	{ v6.4h }, [x10], x3
ld1	{ v7.4h }, [x2], x3
smull	v1.4s, v3.4h, v0.h[0]
smlal	v1.4s, v4.4h, v0.h[1]
smlal	v1.4s, v5.4h, v0.h[2]
smlal	v1.4s, v6.4h, v0.h[3]
smull	v2.4s, v4.4h, v0.h[0]
smlal	v2.4s, v5.4h, v0.h[1]
smlal	v2.4s, v6.4h, v0.h[2]
smlal	v2.4s, v7.4h, v0.h[3]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
st1	{ v1.8b }, [x0], x1
st1	{ v1.d }[1], [x9], x1
L_4548:
ret
L_454c:
ld1	{ v0.8b }, [x7]
sub	x10, x2, x3, lsl #1
add	x9, x0, x1
sub	x2, x10, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.4h }, [x2], x3
ld1	{ v17.4h }, [x10], x3
ld1	{ v18.4h }, [x2], x3
ld1	{ v19.4h }, [x10], x3
ld1	{ v20.4h }, [x2], x3
ld1	{ v21.4h }, [x10], x3
ld1	{ v22.4h }, [x2], x3
L_4584:
subs	w5, w5, #0x4
ld1	{ v23.4h }, [x10], x3
ld1	{ v24.4h }, [x2], x3
ld1	{ v25.4h }, [x10], x3
ld1	{ v26.4h }, [x2], x3
smull	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smull	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
smull	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v20.4h, v0.h[2]
smlal	v3.4s, v21.4h, v0.h[3]
smlal	v3.4s, v22.4h, v0.h[4]
smlal	v3.4s, v23.4h, v0.h[5]
smlal	v3.4s, v24.4h, v0.h[6]
smull	v4.4s, v20.4h, v0.h[1]
smlal	v4.4s, v21.4h, v0.h[2]
smlal	v4.4s, v22.4h, v0.h[3]
smlal	v4.4s, v23.4h, v0.h[4]
smlal	v4.4s, v24.4h, v0.h[5]
smlal	v4.4s, v25.4h, v0.h[6]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
st1	{ v1.8b }, [x0], x1
st1	{ v1.d }[1], [x9], x1
st1	{ v3.8b }, [x0], x1
st1	{ v3.d }[1], [x9], x1
b.le	L_4698
cmp	w5, #0x2
mov	v16.8b, v20.8b
mov	v17.8b, v21.8b
mov	v18.8b, v22.8b
mov	v19.8b, v23.8b
mov	v20.8b, v24.8b
mov	v21.8b, v25.8b
mov	v22.8b, v26.8b
b.eq	L_464c
b	L_4584
L_464c:
ld1	{ v23.4h }, [x10], x3
ld1	{ v24.4h }, [x2], x3
smull	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smull	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
st1	{ v1.8b }, [x0], x1
st1	{ v1.d }[1], [x9], x1
L_4698:
ret
L_469c:
b.gt	L_47a4
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8h }, [x2], x3
ld1	{ v2.8h }, [x10], x3
ld1	{ v3.8h }, [x2], x3
ld1	{ v4.8h }, [x10], x3
ld1	{ v5.8h }, [x2], x3
smull	v16.4s, v1.4h, v0.h[0]
smlal	v16.4s, v2.4h, v0.h[1]
smlal	v16.4s, v3.4h, v0.h[2]
smlal	v16.4s, v4.4h, v0.h[3]
smull2	v17.4s, v1.8h, v0.h[0]
smlal2	v17.4s, v2.8h, v0.h[1]
smlal2	v17.4s, v3.8h, v0.h[2]
smlal2	v17.4s, v4.8h, v0.h[3]
smull	v18.4s, v2.4h, v0.h[0]
smlal	v18.4s, v3.4h, v0.h[1]
smlal	v18.4s, v4.4h, v0.h[2]
smlal	v18.4s, v5.4h, v0.h[3]
smull2	v19.4s, v2.8h, v0.h[0]
smlal2	v19.4s, v3.8h, v0.h[1]
smlal2	v19.4s, v4.8h, v0.h[2]
smlal2	v19.4s, v5.8h, v0.h[3]
sqrshrun	v16.4h, v16.4s, #0x6
sqrshrun2	v16.8h, v17.4s, #0x6
sqrshrun	v18.4h, v18.4s, #0x6
sqrshrun2	v18.8h, v19.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
umin	v18.8h, v18.8h, v31.8h
st1	{ v16.8h }, [x0], x1
st1	{ v18.8h }, [x9], x1
b.le	L_47a0
ld1	{ v6.8h }, [x10], x3
ld1	{ v7.8h }, [x2], x3
smull	v16.4s, v3.4h, v0.h[0]
smlal	v16.4s, v4.4h, v0.h[1]
smlal	v16.4s, v5.4h, v0.h[2]
smlal	v16.4s, v6.4h, v0.h[3]
smull2	v17.4s, v3.8h, v0.h[0]
smlal2	v17.4s, v4.8h, v0.h[1]
smlal2	v17.4s, v5.8h, v0.h[2]
smlal2	v17.4s, v6.8h, v0.h[3]
smull	v18.4s, v4.4h, v0.h[0]
smlal	v18.4s, v5.4h, v0.h[1]
smlal	v18.4s, v6.4h, v0.h[2]
smlal	v18.4s, v7.4h, v0.h[3]
smull2	v19.4s, v4.8h, v0.h[0]
smlal2	v19.4s, v5.8h, v0.h[1]
smlal2	v19.4s, v6.8h, v0.h[2]
smlal2	v19.4s, v7.8h, v0.h[3]
sqrshrun	v16.4h, v16.4s, #0x6
sqrshrun2	v16.8h, v17.4s, #0x6
sqrshrun	v18.4h, v18.4s, #0x6
sqrshrun2	v18.8h, v19.4s, #0x6
umin	v16.8h, v16.8h, v31.8h
umin	v18.8h, v18.8h, v31.8h
st1	{ v16.8h }, [x0], x1
st1	{ v18.8h }, [x9], x1
L_47a0:
ret
L_47a4:
ld1	{ v0.8b }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w7, w5
L_47b8:
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8h }, [x2], x3
ld1	{ v17.8h }, [x10], x3
ld1	{ v18.8h }, [x2], x3
ld1	{ v19.8h }, [x10], x3
ld1	{ v20.8h }, [x2], x3
ld1	{ v21.8h }, [x10], x3
ld1	{ v22.8h }, [x2], x3
L_47e4:
subs	w5, w5, #0x2
ld1	{ v23.8h }, [x10], x3
ld1	{ v24.8h }, [x2], x3
smull	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smull2	v2.4s, v17.8h, v0.h[1]
smlal2	v2.4s, v18.8h, v0.h[2]
smlal2	v2.4s, v19.8h, v0.h[3]
smlal2	v2.4s, v20.8h, v0.h[4]
smlal2	v2.4s, v21.8h, v0.h[5]
smlal2	v2.4s, v22.8h, v0.h[6]
smull	v3.4s, v18.4h, v0.h[1]
smlal	v3.4s, v19.4h, v0.h[2]
smlal	v3.4s, v20.4h, v0.h[3]
smlal	v3.4s, v21.4h, v0.h[4]
smlal	v3.4s, v22.4h, v0.h[5]
smlal	v3.4s, v23.4h, v0.h[6]
smull2	v4.4s, v18.8h, v0.h[1]
smlal2	v4.4s, v19.8h, v0.h[2]
smlal2	v4.4s, v20.8h, v0.h[3]
smlal2	v4.4s, v21.8h, v0.h[4]
smlal2	v4.4s, v22.8h, v0.h[5]
smlal2	v4.4s, v23.8h, v0.h[6]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
st1	{ v1.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_4924
subs	w5, w5, #0x2
ld1	{ v25.8h }, [x10], x3
ld1	{ v26.8h }, [x2], x3
smull	v1.4s, v19.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v21.4h, v0.h[3]
smlal	v1.4s, v22.4h, v0.h[4]
smlal	v1.4s, v23.4h, v0.h[5]
smlal	v1.4s, v24.4h, v0.h[6]
smull2	v2.4s, v19.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v21.8h, v0.h[3]
smlal2	v2.4s, v22.8h, v0.h[4]
smlal2	v2.4s, v23.8h, v0.h[5]
smlal2	v2.4s, v24.8h, v0.h[6]
smull	v3.4s, v20.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v22.4h, v0.h[3]
smlal	v3.4s, v23.4h, v0.h[4]
smlal	v3.4s, v24.4h, v0.h[5]
smlal	v3.4s, v25.4h, v0.h[6]
smull2	v4.4s, v20.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v22.8h, v0.h[3]
smlal2	v4.4s, v23.8h, v0.h[4]
smlal2	v4.4s, v24.8h, v0.h[5]
smlal2	v4.4s, v25.8h, v0.h[6]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
st1	{ v1.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_4924
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
mov	v18.16b, v22.16b
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
mov	v21.16b, v25.16b
mov	v22.16b, v26.16b
b	L_47e4
L_4924:
subs	w4, w4, #0x8
b.le	L_4950
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_47b8
L_4950:
ret
L_4954:
b.gt	L_47a4
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.8h, v17.8h }, [x2], x3
ld1	{ v18.8h, v19.8h }, [x2], x3
ld1	{ v20.8h, v21.8h }, [x2], x3
L_4970:
ld1	{ v22.8h, v23.8h }, [x2], x3
subs	w5, w5, #0x1
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v18.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v22.4h, v0.h[3]
smull2	v2.4s, v16.8h, v0.h[0]
smlal2	v2.4s, v18.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v22.8h, v0.h[3]
smull	v3.4s, v17.4h, v0.h[0]
smlal	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
smull2	v4.4s, v17.8h, v0.h[0]
smlal2	v4.4s, v19.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v23.8h, v0.h[3]
sqrshrun	v1.4h, v1.4s, #0x6
sqrshrun2	v1.8h, v2.4s, #0x6
sqrshrun	v3.4h, v3.4s, #0x6
sqrshrun2	v3.8h, v4.4s, #0x6
umin	v1.8h, v1.8h, v31.8h
umin	v2.8h, v3.8h, v31.8h
st1	{ v1.8h, v2.8h }, [x0], x1
b.le	L_49f4
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
b	L_4970
L_49f4:
ret
L_49f8:
cmp	w5, #0x4
ubfx	w10, w7, #7, #7
and	w7, w7, #0x7f
b.le	L_4a0c
mov	w7, w10
L_4a0c:
add	x7, x11, w7, uxtw #3
adrp	x10, put_6tap_hv_tbl
add	x10, x10, :lo12:put_6tap_hv_tbl
dup	v30.4s, w12
ldrsw	x9, [x10, x9, lsl #2]
neg	v30.4s, v30.4s
dup	v29.4s, w13
add	x10, x10, x9
neg	v29.4s, v29.4s
br	x10
L_4a34:
ldur	s0, [x6, #0x2]
b.gt	L_4acc
ldur	s1, [x7, #0x2]
sub	x10, x2, #0x2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v27.8h }, [x2], x3
ext	v28.16b, v27.16b, v27.16b, #0x2
smull	v27.4s, v27.4h, v0.4h
smull	v28.4s, v28.4h, v0.4h
addp	v27.4s, v27.4s, v28.4s
addp	v16.4s, v27.4s, v27.4s
srshl	v16.2s, v16.2s, v30.2s
bl	L_4b94
xtn	v16.4h, v16.4s
trn1	v16.2s, v16.2s, v24.2s
mov	v17.8b, v24.8b
L_4a8c:
bl	L_4b94
ext	v18.8b, v17.8b, v24.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
srshl	v2.4s, v2.4s, v29.4s
sqxtun	v2.4h, v2.4s
umin	v2.4h, v2.4h, v31.4h
subs	w5, w5, #0x2
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x9], x1
b.le	L_4b90
mov	v16.8b, v18.8b
mov	v17.8b, v24.8b
b	L_4a8c
L_4acc:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x2
sub	x10, x2, x3, lsl #1
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v27.8h }, [x2], x3
ext	v28.16b, v27.16b, v27.16b, #0x2
smull	v27.4s, v27.4h, v0.4h
smull	v28.4s, v28.4h, v0.4h
addp	v27.4s, v27.4s, v28.4s
addp	v16.4s, v27.4s, v27.4s
srshl	v16.2s, v16.2s, v30.2s
bl	L_4b94
xtn	v16.4h, v16.4s
trn1	v16.2s, v16.2s, v24.2s
mov	v17.8b, v24.8b
bl	L_4b94
ext	v18.8b, v17.8b, v24.8b, #0x4
mov	v19.8b, v24.8b
bl	L_4b94
ext	v20.8b, v19.8b, v24.8b, #0x4
mov	v21.8b, v24.8b
L_4b38:
bl	L_4b94
ext	v22.8b, v21.8b, v24.8b, #0x4
smull	v3.4s, v17.4h, v1.h[1]
smlal	v3.4s, v18.4h, v1.h[2]
smlal	v3.4s, v19.4h, v1.h[3]
smlal	v3.4s, v20.4h, v1.h[4]
smlal	v3.4s, v21.4h, v1.h[5]
smlal	v3.4s, v22.4h, v1.h[6]
srshl	v3.4s, v3.4s, v29.4s
sqxtun	v3.4h, v3.4s
umin	v3.4h, v3.4h, v31.4h
subs	w5, w5, #0x2
st1	{ v3.s }[0], [x0], x1
st1	{ v3.s }[1], [x9], x1
b.le	L_4b90
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v24.8b
b	L_4b38
L_4b90:
ret	x15
L_4b94:
ld1	{ v25.8h }, [x10], x3
ld1	{ v27.8h }, [x2], x3
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v28.16b, v27.16b, v27.16b, #0x2
trn1	v24.2s, v25.2s, v27.2s
trn2	v27.2s, v25.2s, v27.2s
trn1	v25.2s, v26.2s, v28.2s
trn2	v28.2s, v26.2s, v28.2s
smull	v24.4s, v24.4h, v0.h[0]
smlal	v24.4s, v25.4h, v0.h[1]
smlal	v24.4s, v27.4h, v0.h[2]
smlal	v24.4s, v28.4h, v0.h[3]
srshl	v24.4s, v24.4s, v30.4s
xtn	v24.4h, v24.4s
ret
L_4bd0:
ldur	s0, [x6, #0x2]
b.gt	L_4c88
ldur	s1, [x7, #0x2]
sub	x10, x2, #0x2
sub	x2, x10, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x2], x3
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v16.4h, v16.4s
bl	L_4d64
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
L_4c30:
bl	L_4d64
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v24.4h, v1.h[2]
smlal	v3.4s, v25.4h, v1.h[3]
srshl	v2.4s, v2.4s, v29.4s
srshl	v3.4s, v3.4s, v29.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
umin	v2.8h, v2.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v2.8b }, [x0], x1
st1	{ v2.d }[1], [x9], x1
b.le	L_4d60
mov	v16.8b, v18.8b
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
b	L_4c30
L_4c88:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x2
sub	x10, x2, x3
sub	x2, x2, x3, lsl #1
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x2], x3
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v18.4h, v16.4s
bl	L_4d64
mov	v19.8b, v24.8b
mov	v20.8b, v25.8b
bl	L_4d64
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
L_4cf0:
bl	L_4d64
smull	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smlal	v3.4s, v21.4h, v1.h[4]
smlal	v3.4s, v22.4h, v1.h[5]
smlal	v3.4s, v24.4h, v1.h[6]
smull	v4.4s, v19.4h, v1.h[1]
smlal	v4.4s, v20.4h, v1.h[2]
smlal	v4.4s, v21.4h, v1.h[3]
smlal	v4.4s, v22.4h, v1.h[4]
smlal	v4.4s, v24.4h, v1.h[5]
smlal	v4.4s, v25.4h, v1.h[6]
srshl	v3.4s, v3.4s, v29.4s
srshl	v4.4s, v4.4s, v29.4s
sqxtun	v3.4h, v3.4s
sqxtun2	v3.8h, v4.4s
umin	v3.8h, v3.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v3.8b }, [x0], x1
st1	{ v3.d }[1], [x9], x1
b.le	L_4d60
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
b	L_4cf0
L_4d60:
ret	x15
L_4d64:
ld1	{ v24.8h }, [x10], x3
ld1	{ v25.8h }, [x2], x3
ext	v26.16b, v24.16b, v24.16b, #0x2
ext	v27.16b, v24.16b, v24.16b, #0x4
ext	v28.16b, v24.16b, v24.16b, #0x6
smull	v24.4s, v24.4h, v0.h[0]
smlal	v24.4s, v26.4h, v0.h[1]
smlal	v24.4s, v27.4h, v0.h[2]
smlal	v24.4s, v28.4h, v0.h[3]
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
xtn	v24.4h, v24.4s
xtn	v25.4h, v25.4s
ret
L_4db8:
b.gt	L_4f04
ld1	{ v0.8b }, [x6]
ldur	s1, [x7, #0x2]
sub	x2, x2, #0x4
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_4ddc:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1	{ v27.8h, v28.8h }, [x2], x3
smull	v24.4s, v27.4h, v0.h[1]
smull2	v25.4s, v27.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v16.8h, v24.8h, v25.8h
bl	L_5088
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
L_4e4c:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_5088
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v23.4h, v1.h[2]
smlal2	v5.4s, v23.8h, v1.h[2]
smlal	v2.4s, v23.4h, v1.h[3]
smlal2	v3.4s, v23.8h, v1.h[3]
smlal	v4.4s, v24.4h, v1.h[3]
smlal2	v5.4s, v24.8h, v1.h[3]
srshl	v2.4s, v2.4s, v29.4s
srshl	v3.4s, v3.4s, v29.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
sqxtun	v3.4h, v4.4s
sqxtun2	v3.8h, v5.4s
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v2.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_4ed8
mov	v16.16b, v18.16b
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
b	L_4e4c
L_4ed8:
subs	w4, w4, #0x8
b.le	L_5084
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_4ddc
L_4f04:
ld1	{ v0.8b }, [x6]
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x4
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
L_4f24:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
ld1	{ v27.8h, v28.8h }, [x2], x3
smull	v24.4s, v27.4h, v0.h[1]
smull2	v25.4s, v27.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v18.8h, v24.8h, v25.8h
bl	L_5088
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
bl	L_5088
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
L_4fa0:
smull	v2.4s, v18.4h, v1.h[1]
smull2	v3.4s, v18.8h, v1.h[1]
bl	L_5088
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
smlal	v4.4s, v23.4h, v1.h[5]
smlal2	v5.4s, v23.8h, v1.h[5]
smlal	v2.4s, v23.4h, v1.h[6]
smlal2	v3.4s, v23.8h, v1.h[6]
smlal	v4.4s, v24.4h, v1.h[6]
smlal2	v5.4s, v24.8h, v1.h[6]
srshl	v2.4s, v2.4s, v29.4s
srshl	v3.4s, v3.4s, v29.4s
srshl	v4.4s, v4.4s, v29.4s
srshl	v5.4s, v5.4s, v29.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
sqxtun	v3.4h, v4.4s
sqxtun2	v3.8h, v5.4s
umin	v2.8h, v2.8h, v31.8h
umin	v3.8h, v3.8h, v31.8h
subs	w5, w5, #0x2
st1	{ v2.8h }, [x0], x1
st1	{ v3.8h }, [x9], x1
b.le	L_5054
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
b	L_4fa0
L_5054:
subs	w4, w4, #0x8
b.le	L_5084
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
add	x2, x2, x3, lsl #1
b	L_4f24
L_5084:
ret	x15
L_5088:
ld1	{ v4.8h, v5.8h }, [x10], x3
ld1	{ v6.8h, v7.8h }, [x2], x3
smull	v25.4s, v4.4h, v0.h[1]
smull2	v26.4s, v4.8h, v0.h[1]
smull	v27.4s, v6.4h, v0.h[1]
smull2	v28.4s, v6.8h, v0.h[1]
ext	v23.16b, v4.16b, v5.16b, #0x2
ext	v24.16b, v6.16b, v7.16b, #0x2
smlal	v25.4s, v23.4h, v0.h[2]
smlal2	v26.4s, v23.8h, v0.h[2]
smlal	v27.4s, v24.4h, v0.h[2]
smlal2	v28.4s, v24.8h, v0.h[2]
ext	v23.16b, v4.16b, v5.16b, #0x4
ext	v24.16b, v6.16b, v7.16b, #0x4
smlal	v25.4s, v23.4h, v0.h[3]
smlal2	v26.4s, v23.8h, v0.h[3]
smlal	v27.4s, v24.4h, v0.h[3]
smlal2	v28.4s, v24.8h, v0.h[3]
ext	v23.16b, v4.16b, v5.16b, #0x6
ext	v24.16b, v6.16b, v7.16b, #0x6
smlal	v25.4s, v23.4h, v0.h[4]
smlal2	v26.4s, v23.8h, v0.h[4]
smlal	v27.4s, v24.4h, v0.h[4]
smlal2	v28.4s, v24.8h, v0.h[4]
ext	v23.16b, v4.16b, v5.16b, #0x8
ext	v24.16b, v6.16b, v7.16b, #0x8
smlal	v25.4s, v23.4h, v0.h[5]
smlal2	v26.4s, v23.8h, v0.h[5]
smlal	v27.4s, v24.4h, v0.h[5]
smlal2	v28.4s, v24.8h, v0.h[5]
ext	v23.16b, v4.16b, v5.16b, #0xa
ext	v24.16b, v6.16b, v7.16b, #0xa
smlal	v25.4s, v23.4h, v0.h[6]
smlal2	v26.4s, v23.8h, v0.h[6]
smlal	v27.4s, v24.4h, v0.h[6]
smlal2	v28.4s, v24.8h, v0.h[6]
srshl	v25.4s, v25.4s, v30.4s
srshl	v26.4s, v26.4s, v30.4s
srshl	v27.4s, v27.4s, v30.4s
srshl	v28.4s, v28.4s, v30.4s
uzp1	v23.8h, v25.8h, v26.8h
uzp1	v24.8h, v27.8h, v28.8h
ret
put_bilin_16bpc_neon:
ldr	w8, [sp]
dup	v1.8h, w6
dup	v3.8h, w7
mov	w10, #0x10
sub	w9, w10, w6
sub	w10, w10, w7
dup	v0.8h, w9
dup	v2.8h, w10
clz	w8, w8
clz	w9, w4
sub	w8, w8, #0x12
mov	w11, #0x4
sub	w9, w9, #0x18
sub	w11, w11, w8
add	w12, w8, #0x4
cbnz	w6, L_517c
cbnz	w7, L_5350
b	put_16bpc_neon
L_517c:
cbnz	w7, L_5544
adrp	x10, put_bilin_h_tbl
add	x10, x10, :lo12:put_bilin_h_tbl
dup	v31.8h, w11
ldrsw	x9, [x10, x9, lsl #2]
neg	v31.8h, v31.8h
dup	v30.8h, w8
add	x10, x10, x9
neg	v30.8h, v30.8h
br	x10
L_51a4:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
L_51b4:
ld1	{ v4.4h }, [x2], x3
ld1	{ v6.4h }, [x10], x3
ext	v5.8b, v4.8b, v4.8b, #0x2
ext	v7.8b, v6.8b, v6.8b, #0x2
trn1	v4.2s, v4.2s, v6.2s
trn1	v5.2s, v5.2s, v7.2s
subs	w5, w5, #0x2
mul	v4.4h, v4.4h, v0.4h
mla	v4.4h, v5.4h, v1.4h
urshl	v4.4h, v4.4h, v31.4h
urshl	v4.4h, v4.4h, v30.4h
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x9], x1
b.gt	L_51b4
ret
L_51f0:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
L_5200:
ld1	{ v4.8h }, [x2], x3
ld1	{ v6.8h }, [x10], x3
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
trn1	v4.2d, v4.2d, v6.2d
trn1	v5.2d, v5.2d, v7.2d
subs	w5, w5, #0x2
mul	v4.8h, v4.8h, v0.8h
mla	v4.8h, v5.8h, v1.8h
urshl	v4.8h, v4.8h, v31.8h
urshl	v4.8h, v4.8h, v30.8h
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x9], x1
b.gt	L_5200
ret
L_523c:
add	x9, x0, x1
add	x10, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
L_524c:
ldr	h5, [x2, #0x10]
ldr	h7, [x10, #0x10]
ld1	{ v4.8h }, [x2], x3
ld1	{ v6.8h }, [x10], x3
ext	v5.16b, v4.16b, v5.16b, #0x2
ext	v7.16b, v6.16b, v7.16b, #0x2
subs	w5, w5, #0x2
mul	v4.8h, v4.8h, v0.8h
mla	v4.8h, v5.8h, v1.8h
mul	v6.8h, v6.8h, v0.8h
mla	v6.8h, v7.8h, v1.8h
urshl	v4.8h, v4.8h, v31.8h
urshl	v6.8h, v6.8h, v31.8h
urshl	v4.8h, v4.8h, v30.8h
urshl	v6.8h, v6.8h, v30.8h
st1	{ v4.8h }, [x0], x1
st1	{ v6.8h }, [x9], x1
b.gt	L_524c
ret
L_5298:
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
sub	x3, x3, w4, uxtw #1
sub	x3, x3, #0x10
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
L_52b4:
ld1	{ v16.8h }, [x2], #16
ld1	{ v21.8h }, [x10], #16
mov	w6, w4
L_52c0:
ld1	{ v17.8h, v18.8h }, [x2], #32
ld1	{ v22.8h, v23.8h }, [x10], #32
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v20.16b, v17.16b, v18.16b, #0x2
ext	v24.16b, v21.16b, v22.16b, #0x2
ext	v25.16b, v22.16b, v23.16b, #0x2
mul	v16.8h, v16.8h, v0.8h
mla	v16.8h, v19.8h, v1.8h
mul	v17.8h, v17.8h, v0.8h
mla	v17.8h, v20.8h, v1.8h
mul	v21.8h, v21.8h, v0.8h
mla	v21.8h, v24.8h, v1.8h
mul	v22.8h, v22.8h, v0.8h
mla	v22.8h, v25.8h, v1.8h
urshl	v16.8h, v16.8h, v31.8h
urshl	v17.8h, v17.8h, v31.8h
urshl	v21.8h, v21.8h, v31.8h
urshl	v22.8h, v22.8h, v31.8h
subs	w6, w6, #0x10
urshl	v16.8h, v16.8h, v30.8h
urshl	v17.8h, v17.8h, v30.8h
urshl	v21.8h, v21.8h, v30.8h
urshl	v22.8h, v22.8h, v30.8h
st1	{ v16.8h, v17.8h }, [x0], #32
st1	{ v21.8h, v22.8h }, [x9], #32
b.le	L_5334
mov	v16.16b, v18.16b
mov	v21.16b, v23.16b
b	L_52c0
L_5334:
add	x0, x0, x1
add	x9, x9, x1
add	x2, x2, x3
add	x10, x10, x3
subs	w5, w5, #0x2
b.gt	L_52b4
ret
L_5350:
cmp	w5, #0x4
adrp	x10, put_bilin_v_tbl
add	x10, x10, :lo12:put_bilin_v_tbl
ldrsw	x9, [x10, x9, lsl #2]
add	x10, x10, x9
br	x10
L_5368:
cmp	w5, #0x2
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v16.4s }, [x2], x3
b.gt	L_53ac
L_5384:
ld1r	{ v17.4s }, [x10], x3
ld1r	{ v18.4s }, [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
mul	v4.4h, v16.4h, v2.4h
mla	v4.4h, v17.4h, v3.4h
urshr	v4.8h, v4.8h, #0x4
str	s4, [x0]
st1	{ v4.s }[1], [x9]
ret
L_53ac:
ld1r	{ v17.4s }, [x10], x3
ld1r	{ v18.4s }, [x2], x3
ld1r	{ v19.4s }, [x10], x3
ld1r	{ v20.4s }, [x2], x3
sub	w5, w5, #0x4
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v16.2d, v16.2d, v18.2d
trn1	v17.2d, v17.2d, v19.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
cmp	w5, #0x2
urshr	v4.8h, v4.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x9], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x9], x1
b.lt	L_5408
mov	v16.8b, v20.8b
b.eq	L_5384
b	L_53ac
L_5408:
ret
L_540c:
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.4h }, [x2], x3
L_5420:
ld1	{ v17.4h }, [x10], x3
ld1	{ v18.4h }, [x2], x3
trn1	v16.2d, v16.2d, v17.2d
trn1	v17.2d, v17.2d, v18.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
subs	w5, w5, #0x2
urshr	v4.8h, v4.8h, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x9], x1
b.le	L_5454
mov	v16.8b, v18.8b
b	L_5420
L_5454:
ret
L_5458:
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8h }, [x2], x3
L_546c:
ld1	{ v17.8h }, [x10], x3
ld1	{ v18.8h }, [x2], x3
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v18.8h, v3.8h
subs	w5, w5, #0x2
urshr	v4.8h, v4.8h, #0x4
urshr	v5.8h, v5.8h, #0x4
st1	{ v4.8h }, [x0], x1
st1	{ v5.8h }, [x9], x1
b.le	L_54a4
mov	v16.16b, v18.16b
b	L_546c
L_54a4:
ret
L_54a8:
mov	w7, w5
L_54ac:
add	x9, x0, x1
add	x10, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8h, v17.8h }, [x2], x3
L_54c0:
ld1	{ v18.8h, v19.8h }, [x10], x3
ld1	{ v20.8h, v21.8h }, [x2], x3
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v18.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v19.8h, v3.8h
mul	v6.8h, v18.8h, v2.8h
mla	v6.8h, v20.8h, v3.8h
mul	v7.8h, v19.8h, v2.8h
mla	v7.8h, v21.8h, v3.8h
subs	w5, w5, #0x2
urshr	v4.8h, v4.8h, #0x4
urshr	v5.8h, v5.8h, #0x4
urshr	v6.8h, v6.8h, #0x4
urshr	v7.8h, v7.8h, #0x4
st1	{ v4.8h, v5.8h }, [x0], x1
st1	{ v6.8h, v7.8h }, [x9], x1
b.le	L_5514
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
b	L_54c0
L_5514:
subs	w4, w4, #0x10
b.le	L_5540
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #0x20
add	x0, x0, #0x20
b	L_54ac
L_5540:
ret
L_5544:
adrp	x10, put_bilin_hv_tbl
add	x10, x10, :lo12:put_bilin_hv_tbl
dup	v31.8h, w11
ldrsw	x9, [x10, x9, lsl #2]
neg	v31.8h, v31.8h
dup	v30.4s, w12
add	x10, x10, x9
neg	v30.4s, v30.4s
br	x10
L_5568:
add	x10, x2, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v20.4h }, [x2], x3
ext	v21.8b, v20.8b, v20.8b, #0x2
mul	v16.4h, v20.4h, v0.4h
mla	v16.4h, v21.4h, v1.4h
urshl	v16.4h, v16.4h, v31.4h
L_558c:
ld1	{ v22.4h }, [x10], x3
ld1	{ v24.4h }, [x2], x3
ext	v23.8b, v22.8b, v22.8b, #0x2
ext	v25.8b, v24.8b, v24.8b, #0x2
trn1	v22.2s, v22.2s, v24.2s
trn1	v23.2s, v23.2s, v25.2s
mul	v17.4h, v22.4h, v0.4h
mla	v17.4h, v23.4h, v1.4h
urshl	v17.4h, v17.4h, v31.4h
trn1	v16.2s, v16.2s, v17.2s
umull	v4.4s, v16.4h, v2.4h
umlal	v4.4s, v17.4h, v3.4h
urshl	v4.4s, v4.4s, v30.4s
xtn	v4.4h, v4.4s
subs	w5, w5, #0x2
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x9], x1
b.le	L_55dc
trn2	v16.2s, v17.2s, v17.2s
b	L_558c
L_55dc:
ret
L_55e0:
add	x10, x2, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v20.8h }, [x2], x3
ext	v21.16b, v20.16b, v20.16b, #0x2
mul	v16.4h, v20.4h, v0.4h
mla	v16.4h, v21.4h, v1.4h
urshl	v16.4h, v16.4h, v31.4h
L_5604:
ld1	{ v22.8h }, [x10], x3
ld1	{ v24.8h }, [x2], x3
ext	v23.16b, v22.16b, v22.16b, #0x2
ext	v25.16b, v24.16b, v24.16b, #0x2
trn1	v22.2d, v22.2d, v24.2d
trn1	v23.2d, v23.2d, v25.2d
mul	v17.8h, v22.8h, v0.8h
mla	v17.8h, v23.8h, v1.8h
urshl	v17.8h, v17.8h, v31.8h
trn1	v16.2d, v16.2d, v17.2d
umull	v4.4s, v16.4h, v2.4h
umlal	v4.4s, v17.4h, v3.4h
umull2	v5.4s, v16.8h, v2.8h
umlal2	v5.4s, v17.8h, v3.8h
urshl	v4.4s, v4.4s, v30.4s
urshl	v5.4s, v5.4s, v30.4s
uzp1	v4.8h, v4.8h, v5.8h
subs	w5, w5, #0x2
st1	{ v4.8b }, [x0], x1
st1	{ v4.d }[1], [x9], x1
b.le	L_5660
trn2	v16.2d, v17.2d, v17.2d
b	L_5604
L_5660:
ret
L_5664:
mov	w7, w5
L_5668:
add	x10, x2, x3
add	x9, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ldr	h21, [x2, #0x10]
ld1	{ v20.8h }, [x2], x3
ext	v21.16b, v20.16b, v21.16b, #0x2
mul	v16.8h, v20.8h, v0.8h
mla	v16.8h, v21.8h, v1.8h
urshl	v16.8h, v16.8h, v31.8h
L_5690:
ldr	h23, [x10, #0x10]
ld1	{ v22.8h }, [x10], x3
ldr	h25, [x2, #0x10]
ld1	{ v24.8h }, [x2], x3
ext	v23.16b, v22.16b, v23.16b, #0x2
ext	v25.16b, v24.16b, v25.16b, #0x2
mul	v17.8h, v22.8h, v0.8h
mla	v17.8h, v23.8h, v1.8h
mul	v18.8h, v24.8h, v0.8h
mla	v18.8h, v25.8h, v1.8h
urshl	v17.8h, v17.8h, v31.8h
urshl	v18.8h, v18.8h, v31.8h
umull	v4.4s, v16.4h, v2.4h
umlal	v4.4s, v17.4h, v3.4h
umull2	v5.4s, v16.8h, v2.8h
umlal2	v5.4s, v17.8h, v3.8h
umull	v6.4s, v17.4h, v2.4h
umlal	v6.4s, v18.4h, v3.4h
umull2	v7.4s, v17.8h, v2.8h
umlal2	v7.4s, v18.8h, v3.8h
urshl	v4.4s, v4.4s, v30.4s
urshl	v5.4s, v5.4s, v30.4s
urshl	v6.4s, v6.4s, v30.4s
urshl	v7.4s, v7.4s, v30.4s
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v5.8h, v6.8h, v7.8h
subs	w5, w5, #0x2
st1	{ v4.8h }, [x0], x1
st1	{ v5.8h }, [x9], x1
b.le	L_5710
mov	v16.16b, v18.16b
b	L_5690
L_5710:
subs	w4, w4, #0x8
b.le	L_573c
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	L_5668
L_573c:
ret
prep_8tap_regular_sharp_16bpc_neon:
mov	w9, #0x2d
mov	w10, #0xf2d
b	prep_8tap_neon
prep_8tap_smooth_sharp_16bpc_neon:
mov	w9, #0x7bc
mov	w10, #0xf2d
b	prep_8tap_neon
prep_8tap_sharp_16bpc_neon:
mov	w9, #0xf2d
mov	w10, #0xf2d
b	prep_8tap_neon
prep_8tap_sharp_regular_16bpc_neon:
mov	w9, #0xf2d
mov	w10, #0x2d
b	prep_8tap_neon
prep_8tap_sharp_smooth_16bpc_neon:
mov	w9, #0xf2d
mov	w10, #0x7bc
b	prep_8tap_neon
prep_8tap_neon:
mov	w11, #0x4081
mul	w5, w5, w11
mul	w6, w6, w11
add	w5, w5, w9
add	w6, w6, w10
ubfx	x8, x3, #0, #32
lsl	x8, x8, #1
dup	v31.8h, w7
clz	w7, w7
clz	w9, w3
sub	w7, w7, #0x12
mov	w12, #0x6
tst	w5, #0x1fc000
sub	w9, w9, #0x18
add	w13, w12, w7
sub	w12, w12, w7
adrp	x11, mc_subpel_filters-8
add	x11, x11, :lo12:mc_subpel_filters-8
b.ne	L_57d4
tst	w6, #0x1fc000
b.ne	L_59d8
b	prep_16bpc_neon
L_57d4:
cmp	w3, #0x4
ubfx	w10, w5, #7, #7
and	w5, w5, #0x7f
b.le	L_57e8
mov	w5, w10
L_57e8:
tst	w6, #0x1fc000
add	x5, x11, w5, uxtw #3
b.ne	L_6018
adrp	x10, prep_8tap_h_tbl
add	x10, x10, :lo12:prep_8tap_h_tbl
ldrsw	x9, [x10, x9, lsl #2]
neg	w12, w12
movi	v28.8h, #0x20, lsl #8
add	x10, x10, x9
dup	v30.4s, w12
br	x10
L_5814:
ldur	s0, [x5, #0x2]
sub	x1, x1, #0x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
L_5830:
ld1	{ v16.8h }, [x1], x2
ld1	{ v20.8h }, [x10], x2
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w4, w4, #0x2
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v17.4h, v0.h[1]
smlal	v2.4s, v18.4h, v0.h[2]
smlal	v2.4s, v19.4h, v0.h[3]
smull	v3.4s, v20.4h, v0.h[0]
smlal	v3.4s, v21.4h, v0.h[1]
smlal	v3.4s, v22.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
srshl	v16.4s, v2.4s, v30.4s
srshl	v20.4s, v3.4s, v30.4s
uzp1	v16.8h, v16.8h, v20.8h
sub	v16.8h, v16.8h, v28.8h
st1	{ v16.8b }, [x0], x8
st1	{ v16.d }[1], [x9], x8
b.gt	L_5830
ret
L_5894:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x6
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
sub	x2, x2, w3, uxtw #1
sub	x2, x2, #0x10
L_58b4:
ld1	{ v16.8h, v17.8h }, [x1], #32
ld1	{ v20.8h, v21.8h }, [x10], #32
mov	w5, w3
L_58c0:
smull	v18.4s, v16.4h, v0.h[0]
smull2	v19.4s, v16.8h, v0.h[0]
smull	v22.4s, v20.4h, v0.h[0]
smull2	v23.4s, v20.8h, v0.h[0]
ext	v24.16b, v16.16b, v17.16b, #0x2
ext	v25.16b, v20.16b, v21.16b, #0x2
smlal	v18.4s, v24.4h, v0.h[1]
smlal2	v19.4s, v24.8h, v0.h[1]
smlal	v22.4s, v25.4h, v0.h[1]
smlal2	v23.4s, v25.8h, v0.h[1]
ext	v24.16b, v16.16b, v17.16b, #0x4
ext	v25.16b, v20.16b, v21.16b, #0x4
smlal	v18.4s, v24.4h, v0.h[2]
smlal2	v19.4s, v24.8h, v0.h[2]
smlal	v22.4s, v25.4h, v0.h[2]
smlal2	v23.4s, v25.8h, v0.h[2]
ext	v24.16b, v16.16b, v17.16b, #0x6
ext	v25.16b, v20.16b, v21.16b, #0x6
smlal	v18.4s, v24.4h, v0.h[3]
smlal2	v19.4s, v24.8h, v0.h[3]
smlal	v22.4s, v25.4h, v0.h[3]
smlal2	v23.4s, v25.8h, v0.h[3]
ext	v24.16b, v16.16b, v17.16b, #0x8
ext	v25.16b, v20.16b, v21.16b, #0x8
smlal	v18.4s, v24.4h, v0.h[4]
smlal2	v19.4s, v24.8h, v0.h[4]
smlal	v22.4s, v25.4h, v0.h[4]
smlal2	v23.4s, v25.8h, v0.h[4]
ext	v24.16b, v16.16b, v17.16b, #0xa
ext	v25.16b, v20.16b, v21.16b, #0xa
smlal	v18.4s, v24.4h, v0.h[5]
smlal2	v19.4s, v24.8h, v0.h[5]
smlal	v22.4s, v25.4h, v0.h[5]
smlal2	v23.4s, v25.8h, v0.h[5]
ext	v24.16b, v16.16b, v17.16b, #0xc
ext	v25.16b, v20.16b, v21.16b, #0xc
smlal	v18.4s, v24.4h, v0.h[6]
smlal2	v19.4s, v24.8h, v0.h[6]
smlal	v22.4s, v25.4h, v0.h[6]
smlal2	v23.4s, v25.8h, v0.h[6]
ext	v24.16b, v16.16b, v17.16b, #0xe
ext	v25.16b, v20.16b, v21.16b, #0xe
smlal	v18.4s, v24.4h, v0.h[7]
smlal2	v19.4s, v24.8h, v0.h[7]
smlal	v22.4s, v25.4h, v0.h[7]
smlal2	v23.4s, v25.8h, v0.h[7]
subs	w5, w5, #0x8
srshl	v18.4s, v18.4s, v30.4s
srshl	v19.4s, v19.4s, v30.4s
srshl	v22.4s, v22.4s, v30.4s
srshl	v23.4s, v23.4s, v30.4s
uzp1	v18.8h, v18.8h, v19.8h
uzp1	v22.8h, v22.8h, v23.8h
sub	v18.8h, v18.8h, v28.8h
sub	v22.8h, v22.8h, v28.8h
st1	{ v18.8h }, [x0], #16
st1	{ v22.8h }, [x9], #16
b.le	L_59bc
mov	v16.16b, v17.16b
mov	v20.16b, v21.16b
ld1	{ v17.8h }, [x1], #16
ld1	{ v21.8h }, [x10], #16
b	L_58c0
L_59bc:
add	x0, x0, x8
add	x9, x9, x8
add	x1, x1, x2
add	x10, x10, x2
subs	w4, w4, #0x2
b.gt	L_58b4
ret
L_59d8:
cmp	w4, #0x4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_59ec
mov	w6, w10
L_59ec:
add	x6, x11, w6, uxtw #3
dup	v30.4s, w12
movi	v29.8h, #0x20, lsl #8
adrp	x10, prep_8tap_v_tbl
add	x10, x10, :lo12:prep_8tap_v_tbl
ldrsw	x9, [x10, x9, lsl #2]
neg	v30.4s, v30.4s
add	x10, x10, x9
br	x10
L_5a10:
b.gt	L_5ac8
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.4h }, [x1], x2
ld1	{ v2.4h }, [x10], x2
ld1	{ v3.4h }, [x1], x2
ld1	{ v4.4h }, [x10], x2
ld1	{ v5.4h }, [x1], x2
smull	v6.4s, v1.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[1]
smlal	v6.4s, v3.4h, v0.h[2]
smlal	v6.4s, v4.4h, v0.h[3]
smull	v7.4s, v2.4h, v0.h[0]
smlal	v7.4s, v3.4h, v0.h[1]
smlal	v7.4s, v4.4h, v0.h[2]
smlal	v7.4s, v5.4h, v0.h[3]
srshl	v6.4s, v6.4s, v30.4s
srshl	v7.4s, v7.4s, v30.4s
uzp1	v6.8h, v6.8h, v7.8h
sub	v6.8h, v6.8h, v29.8h
st1	{ v6.8b }, [x0], x8
st1	{ v6.d }[1], [x9], x8
b.le	L_5ac4
ld1	{ v6.4h }, [x10], x2
ld1	{ v7.4h }, [x1], x2
smull	v1.4s, v3.4h, v0.h[0]
smlal	v1.4s, v4.4h, v0.h[1]
smlal	v1.4s, v5.4h, v0.h[2]
smlal	v1.4s, v6.4h, v0.h[3]
smull	v2.4s, v4.4h, v0.h[0]
smlal	v2.4s, v5.4h, v0.h[1]
smlal	v2.4s, v6.4h, v0.h[2]
smlal	v2.4s, v7.4h, v0.h[3]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
sub	v1.8h, v1.8h, v29.8h
st1	{ v1.8b }, [x0], x8
st1	{ v1.d }[1], [x9], x8
L_5ac4:
ret
L_5ac8:
ld1	{ v0.8b }, [x6]
sub	x10, x1, x2, lsl #1
add	x9, x0, x8
sub	x1, x10, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.4h }, [x1], x2
ld1	{ v17.4h }, [x10], x2
ld1	{ v18.4h }, [x1], x2
ld1	{ v19.4h }, [x10], x2
ld1	{ v20.4h }, [x1], x2
ld1	{ v21.4h }, [x10], x2
ld1	{ v22.4h }, [x1], x2
L_5b00:
subs	w4, w4, #0x4
ld1	{ v23.4h }, [x10], x2
ld1	{ v24.4h }, [x1], x2
ld1	{ v25.4h }, [x10], x2
ld1	{ v26.4h }, [x1], x2
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smlal	v1.4s, v23.4h, v0.h[7]
smull	v2.4s, v17.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
smlal	v2.4s, v24.4h, v0.h[7]
smull	v3.4s, v18.4h, v0.h[0]
smlal	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v20.4h, v0.h[2]
smlal	v3.4s, v21.4h, v0.h[3]
smlal	v3.4s, v22.4h, v0.h[4]
smlal	v3.4s, v23.4h, v0.h[5]
smlal	v3.4s, v24.4h, v0.h[6]
smlal	v3.4s, v25.4h, v0.h[7]
smull	v4.4s, v19.4h, v0.h[0]
smlal	v4.4s, v20.4h, v0.h[1]
smlal	v4.4s, v21.4h, v0.h[2]
smlal	v4.4s, v22.4h, v0.h[3]
smlal	v4.4s, v23.4h, v0.h[4]
smlal	v4.4s, v24.4h, v0.h[5]
smlal	v4.4s, v25.4h, v0.h[6]
smlal	v4.4s, v26.4h, v0.h[7]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
st1	{ v1.8b }, [x0], x8
st1	{ v1.d }[1], [x9], x8
st1	{ v3.8b }, [x0], x8
st1	{ v3.d }[1], [x9], x8
b.le	L_5c50
cmp	w4, #0x2
mov	v16.8b, v20.8b
mov	v17.8b, v21.8b
mov	v18.8b, v22.8b
mov	v19.8b, v23.8b
mov	v20.8b, v24.8b
mov	v21.8b, v25.8b
mov	v22.8b, v26.8b
b.eq	L_5bf0
b	L_5b00
L_5bf0:
ld1	{ v23.4h }, [x10], x2
ld1	{ v24.4h }, [x1], x2
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smlal	v1.4s, v23.4h, v0.h[7]
smull	v2.4s, v17.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
smlal	v2.4s, v24.4h, v0.h[7]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
sub	v1.8h, v1.8h, v29.8h
st1	{ v1.8b }, [x0], x8
st1	{ v1.d }[1], [x9], x8
L_5c50:
ret
L_5c54:
b.gt	L_5d6c
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8h }, [x1], x2
ld1	{ v2.8h }, [x10], x2
ld1	{ v3.8h }, [x1], x2
ld1	{ v4.8h }, [x10], x2
ld1	{ v5.8h }, [x1], x2
smull	v16.4s, v1.4h, v0.h[0]
smlal	v16.4s, v2.4h, v0.h[1]
smlal	v16.4s, v3.4h, v0.h[2]
smlal	v16.4s, v4.4h, v0.h[3]
smull2	v17.4s, v1.8h, v0.h[0]
smlal2	v17.4s, v2.8h, v0.h[1]
smlal2	v17.4s, v3.8h, v0.h[2]
smlal2	v17.4s, v4.8h, v0.h[3]
smull	v18.4s, v2.4h, v0.h[0]
smlal	v18.4s, v3.4h, v0.h[1]
smlal	v18.4s, v4.4h, v0.h[2]
smlal	v18.4s, v5.4h, v0.h[3]
smull2	v19.4s, v2.8h, v0.h[0]
smlal2	v19.4s, v3.8h, v0.h[1]
smlal2	v19.4s, v4.8h, v0.h[2]
smlal2	v19.4s, v5.8h, v0.h[3]
srshl	v16.4s, v16.4s, v30.4s
srshl	v17.4s, v17.4s, v30.4s
srshl	v18.4s, v18.4s, v30.4s
srshl	v19.4s, v19.4s, v30.4s
uzp1	v16.8h, v16.8h, v17.8h
uzp1	v18.8h, v18.8h, v19.8h
sub	v16.8h, v16.8h, v29.8h
sub	v18.8h, v18.8h, v29.8h
st1	{ v16.8h }, [x0], x8
st1	{ v18.8h }, [x9], x8
b.le	L_5d68
ld1	{ v6.8h }, [x10], x2
ld1	{ v7.8h }, [x1], x2
smull	v16.4s, v3.4h, v0.h[0]
smlal	v16.4s, v4.4h, v0.h[1]
smlal	v16.4s, v5.4h, v0.h[2]
smlal	v16.4s, v6.4h, v0.h[3]
smull2	v17.4s, v3.8h, v0.h[0]
smlal2	v17.4s, v4.8h, v0.h[1]
smlal2	v17.4s, v5.8h, v0.h[2]
smlal2	v17.4s, v6.8h, v0.h[3]
smull	v18.4s, v4.4h, v0.h[0]
smlal	v18.4s, v5.4h, v0.h[1]
smlal	v18.4s, v6.4h, v0.h[2]
smlal	v18.4s, v7.4h, v0.h[3]
smull2	v19.4s, v4.8h, v0.h[0]
smlal2	v19.4s, v5.8h, v0.h[1]
smlal2	v19.4s, v6.8h, v0.h[2]
smlal2	v19.4s, v7.8h, v0.h[3]
srshl	v16.4s, v16.4s, v30.4s
srshl	v17.4s, v17.4s, v30.4s
srshl	v18.4s, v18.4s, v30.4s
srshl	v19.4s, v19.4s, v30.4s
uzp1	v16.8h, v16.8h, v17.8h
uzp1	v18.8h, v18.8h, v19.8h
sub	v16.8h, v16.8h, v29.8h
sub	v18.8h, v18.8h, v29.8h
st1	{ v16.8h }, [x0], x8
st1	{ v18.8h }, [x9], x8
L_5d68:
ret
L_5d6c:
ld1	{ v0.8b }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w6, w4
L_5d80:
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1	{ v16.8h }, [x1], x2
ld1	{ v17.8h }, [x10], x2
ld1	{ v18.8h }, [x1], x2
ld1	{ v19.8h }, [x10], x2
ld1	{ v20.8h }, [x1], x2
ld1	{ v21.8h }, [x10], x2
ld1	{ v22.8h }, [x1], x2
L_5dac:
subs	w4, w4, #0x2
ld1	{ v23.8h }, [x10], x2
ld1	{ v24.8h }, [x1], x2
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smlal	v1.4s, v23.4h, v0.h[7]
smull2	v2.4s, v16.8h, v0.h[0]
smlal2	v2.4s, v17.8h, v0.h[1]
smlal2	v2.4s, v18.8h, v0.h[2]
smlal2	v2.4s, v19.8h, v0.h[3]
smlal2	v2.4s, v20.8h, v0.h[4]
smlal2	v2.4s, v21.8h, v0.h[5]
smlal2	v2.4s, v22.8h, v0.h[6]
smlal2	v2.4s, v23.8h, v0.h[7]
smull	v3.4s, v17.4h, v0.h[0]
smlal	v3.4s, v18.4h, v0.h[1]
smlal	v3.4s, v19.4h, v0.h[2]
smlal	v3.4s, v20.4h, v0.h[3]
smlal	v3.4s, v21.4h, v0.h[4]
smlal	v3.4s, v22.4h, v0.h[5]
smlal	v3.4s, v23.4h, v0.h[6]
smlal	v3.4s, v24.4h, v0.h[7]
smull2	v4.4s, v17.8h, v0.h[0]
smlal2	v4.4s, v18.8h, v0.h[1]
smlal2	v4.4s, v19.8h, v0.h[2]
smlal2	v4.4s, v20.8h, v0.h[3]
smlal2	v4.4s, v21.8h, v0.h[4]
smlal2	v4.4s, v22.8h, v0.h[5]
smlal2	v4.4s, v23.8h, v0.h[6]
smlal2	v4.4s, v24.8h, v0.h[7]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
st1	{ v1.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_5f3c
subs	w4, w4, #0x2
ld1	{ v25.8h }, [x10], x2
ld1	{ v26.8h }, [x1], x2
smull	v1.4s, v18.4h, v0.h[0]
smlal	v1.4s, v19.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v21.4h, v0.h[3]
smlal	v1.4s, v22.4h, v0.h[4]
smlal	v1.4s, v23.4h, v0.h[5]
smlal	v1.4s, v24.4h, v0.h[6]
smlal	v1.4s, v25.4h, v0.h[7]
smull2	v2.4s, v18.8h, v0.h[0]
smlal2	v2.4s, v19.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v21.8h, v0.h[3]
smlal2	v2.4s, v22.8h, v0.h[4]
smlal2	v2.4s, v23.8h, v0.h[5]
smlal2	v2.4s, v24.8h, v0.h[6]
smlal2	v2.4s, v25.8h, v0.h[7]
smull	v3.4s, v19.4h, v0.h[0]
smlal	v3.4s, v20.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v22.4h, v0.h[3]
smlal	v3.4s, v23.4h, v0.h[4]
smlal	v3.4s, v24.4h, v0.h[5]
smlal	v3.4s, v25.4h, v0.h[6]
smlal	v3.4s, v26.4h, v0.h[7]
smull2	v4.4s, v19.8h, v0.h[0]
smlal2	v4.4s, v20.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v22.8h, v0.h[3]
smlal2	v4.4s, v23.8h, v0.h[4]
smlal2	v4.4s, v24.8h, v0.h[5]
smlal2	v4.4s, v25.8h, v0.h[6]
smlal2	v4.4s, v26.8h, v0.h[7]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
st1	{ v1.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_5f3c
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
mov	v18.16b, v22.16b
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
mov	v21.16b, v25.16b
mov	v22.16b, v26.16b
b	L_5dac
L_5f3c:
subs	w3, w3, #0x8
b.le	L_5f68
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
b	L_5d80
L_5f68:
ret
L_5f6c:
b.gt	L_5d6c
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.8h, v17.8h }, [x1], x2
ld1	{ v18.8h, v19.8h }, [x1], x2
ld1	{ v20.8h, v21.8h }, [x1], x2
L_5f88:
ld1	{ v22.8h, v23.8h }, [x1], x2
subs	w4, w4, #0x1
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v18.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v22.4h, v0.h[3]
smull2	v2.4s, v16.8h, v0.h[0]
smlal2	v2.4s, v18.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v22.8h, v0.h[3]
smull	v3.4s, v17.4h, v0.h[0]
smlal	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
smull2	v4.4s, v17.8h, v0.h[0]
smlal2	v4.4s, v19.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v23.8h, v0.h[3]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v2.8h, v3.8h, v29.8h
st1	{ v1.8h, v2.8h }, [x0], x8
b.le	L_6014
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
b	L_5f88
L_6014:
ret
L_6018:
cmp	w4, #0x4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_602c
mov	w6, w10
L_602c:
add	x6, x11, w6, uxtw #3
adrp	x10, prep_8tap_hv_tbl
add	x10, x10, :lo12:prep_8tap_hv_tbl
dup	v30.4s, w12
ldrsw	x9, [x10, x9, lsl #2]
neg	v30.4s, v30.4s
movi	v29.8h, #0x20, lsl #8
add	x10, x10, x9
br	x10
L_6050:
ldur	s0, [x5, #0x2]
b.gt	L_6100
ldur	s1, [x6, #0x2]
sub	x10, x1, #0x2
sub	x1, x10, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x1], x2
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v16.4h, v16.4s
bl	L_61f8
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
L_60b0:
bl	L_61f8
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v24.4h, v1.h[2]
smlal	v3.4s, v25.4h, v1.h[3]
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
sub	v2.8h, v2.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v2.8b }, [x0], x8
st1	{ v2.d }[1], [x9], x8
b.le	L_61f4
mov	v16.8b, v18.8b
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
b	L_60b0
L_6100:
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x2
sub	x10, x1, x2, lsl #1
sub	x1, x10, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x1], x2
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v16.4h, v16.4s
bl	L_61f8
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
bl	L_61f8
mov	v19.8b, v24.8b
mov	v20.8b, v25.8b
bl	L_61f8
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
L_6174:
bl	L_61f8
smull	v3.4s, v16.4h, v1.h[0]
smlal	v3.4s, v17.4h, v1.h[1]
smlal	v3.4s, v18.4h, v1.h[2]
smlal	v3.4s, v19.4h, v1.h[3]
smlal	v3.4s, v20.4h, v1.h[4]
smlal	v3.4s, v21.4h, v1.h[5]
smlal	v3.4s, v22.4h, v1.h[6]
smlal	v3.4s, v24.4h, v1.h[7]
smull	v4.4s, v17.4h, v1.h[0]
smlal	v4.4s, v18.4h, v1.h[1]
smlal	v4.4s, v19.4h, v1.h[2]
smlal	v4.4s, v20.4h, v1.h[3]
smlal	v4.4s, v21.4h, v1.h[4]
smlal	v4.4s, v22.4h, v1.h[5]
smlal	v4.4s, v24.4h, v1.h[6]
smlal	v4.4s, v25.4h, v1.h[7]
rshrn	v3.4h, v3.4s, #0x6
rshrn2	v3.8h, v4.4s, #0x6
sub	v3.8h, v3.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v3.8b }, [x0], x8
st1	{ v3.d }[1], [x9], x8
b.le	L_61f4
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
b	L_6174
L_61f4:
ret	x15
L_61f8:
ld1	{ v24.8h }, [x10], x2
ld1	{ v25.8h }, [x1], x2
ext	v26.16b, v24.16b, v24.16b, #0x2
ext	v27.16b, v24.16b, v24.16b, #0x4
ext	v28.16b, v24.16b, v24.16b, #0x6
smull	v24.4s, v24.4h, v0.h[0]
smlal	v24.4s, v26.4h, v0.h[1]
smlal	v24.4s, v27.4h, v0.h[2]
smlal	v24.4s, v28.4h, v0.h[3]
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
xtn	v24.4h, v24.4s
xtn	v25.4h, v25.4s
ret
L_624c:
b.gt	L_63a0
ld1	{ v0.8b }, [x5]
ldur	s1, [x6, #0x2]
sub	x1, x1, #0x6
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_6270:
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1	{ v27.8h, v28.8h }, [x1], x2
smull	v24.4s, v27.4h, v0.h[0]
smull2	v25.4s, v27.8h, v0.h[0]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[1]
smlal2	v25.4s, v26.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xc
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
ext	v26.16b, v27.16b, v28.16b, #0xe
smlal	v24.4s, v26.4h, v0.h[7]
smlal2	v25.4s, v26.8h, v0.h[7]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v16.8h, v24.8h, v25.8h
bl	L_6560
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
L_62f8:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_6560
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v23.4h, v1.h[2]
smlal2	v5.4s, v23.8h, v1.h[2]
smlal	v2.4s, v23.4h, v1.h[3]
smlal2	v3.4s, v23.8h, v1.h[3]
smlal	v4.4s, v24.4h, v1.h[3]
smlal2	v5.4s, v24.8h, v1.h[3]
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
rshrn	v3.4h, v4.4s, #0x6
rshrn2	v3.8h, v5.4s, #0x6
sub	v2.8h, v2.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_6374
mov	v16.16b, v18.16b
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
b	L_62f8
L_6374:
subs	w3, w3, #0x8
b.le	L_655c
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
b	L_6270
L_63a0:
ld1	{ v0.8b }, [x5]
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x6
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_63c4:
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1	{ v27.8h, v28.8h }, [x1], x2
smull	v24.4s, v27.4h, v0.h[0]
smull2	v25.4s, v27.8h, v0.h[0]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[1]
smlal2	v25.4s, v26.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xc
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
ext	v26.16b, v27.16b, v28.16b, #0xe
smlal	v24.4s, v26.4h, v0.h[7]
smlal2	v25.4s, v26.8h, v0.h[7]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v16.8h, v24.8h, v25.8h
bl	L_6560
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
bl	L_6560
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
bl	L_6560
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
L_6464:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_6560
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
smlal	v4.4s, v23.4h, v1.h[6]
smlal2	v5.4s, v23.8h, v1.h[6]
smlal	v2.4s, v23.4h, v1.h[7]
smlal2	v3.4s, v23.8h, v1.h[7]
smlal	v4.4s, v24.4h, v1.h[7]
smlal2	v5.4s, v24.8h, v1.h[7]
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
rshrn	v3.4h, v4.4s, #0x6
rshrn2	v3.8h, v5.4s, #0x6
sub	v2.8h, v2.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_6530
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
b	L_6464
L_6530:
subs	w3, w3, #0x8
b.le	L_655c
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
b	L_63c4
L_655c:
ret	x15
L_6560:
ld1	{ v4.8h, v5.8h }, [x10], x2
ld1	{ v6.8h, v7.8h }, [x1], x2
smull	v25.4s, v4.4h, v0.h[0]
smull2	v26.4s, v4.8h, v0.h[0]
smull	v27.4s, v6.4h, v0.h[0]
smull2	v28.4s, v6.8h, v0.h[0]
ext	v23.16b, v4.16b, v5.16b, #0x2
ext	v24.16b, v6.16b, v7.16b, #0x2
smlal	v25.4s, v23.4h, v0.h[1]
smlal2	v26.4s, v23.8h, v0.h[1]
smlal	v27.4s, v24.4h, v0.h[1]
smlal2	v28.4s, v24.8h, v0.h[1]
ext	v23.16b, v4.16b, v5.16b, #0x4
ext	v24.16b, v6.16b, v7.16b, #0x4
smlal	v25.4s, v23.4h, v0.h[2]
smlal2	v26.4s, v23.8h, v0.h[2]
smlal	v27.4s, v24.4h, v0.h[2]
smlal2	v28.4s, v24.8h, v0.h[2]
ext	v23.16b, v4.16b, v5.16b, #0x6
ext	v24.16b, v6.16b, v7.16b, #0x6
smlal	v25.4s, v23.4h, v0.h[3]
smlal2	v26.4s, v23.8h, v0.h[3]
smlal	v27.4s, v24.4h, v0.h[3]
smlal2	v28.4s, v24.8h, v0.h[3]
ext	v23.16b, v4.16b, v5.16b, #0x8
ext	v24.16b, v6.16b, v7.16b, #0x8
smlal	v25.4s, v23.4h, v0.h[4]
smlal2	v26.4s, v23.8h, v0.h[4]
smlal	v27.4s, v24.4h, v0.h[4]
smlal2	v28.4s, v24.8h, v0.h[4]
ext	v23.16b, v4.16b, v5.16b, #0xa
ext	v24.16b, v6.16b, v7.16b, #0xa
smlal	v25.4s, v23.4h, v0.h[5]
smlal2	v26.4s, v23.8h, v0.h[5]
smlal	v27.4s, v24.4h, v0.h[5]
smlal2	v28.4s, v24.8h, v0.h[5]
ext	v23.16b, v4.16b, v5.16b, #0xc
ext	v24.16b, v6.16b, v7.16b, #0xc
smlal	v25.4s, v23.4h, v0.h[6]
smlal2	v26.4s, v23.8h, v0.h[6]
smlal	v27.4s, v24.4h, v0.h[6]
smlal2	v28.4s, v24.8h, v0.h[6]
ext	v23.16b, v4.16b, v5.16b, #0xe
ext	v24.16b, v6.16b, v7.16b, #0xe
smlal	v25.4s, v23.4h, v0.h[7]
smlal2	v26.4s, v23.8h, v0.h[7]
smlal	v27.4s, v24.4h, v0.h[7]
smlal2	v28.4s, v24.8h, v0.h[7]
srshl	v25.4s, v25.4s, v30.4s
srshl	v26.4s, v26.4s, v30.4s
srshl	v27.4s, v27.4s, v30.4s
srshl	v28.4s, v28.4s, v30.4s
uzp1	v23.8h, v25.8h, v26.8h
uzp1	v24.8h, v27.8h, v28.8h
ret
prep_8tap_regular_16bpc_neon:
mov	w9, #0x2d
mov	w10, #0x2d
b	prep_6tap_neon
prep_8tap_regular_smooth_16bpc_neon:
mov	w9, #0x2d
mov	w10, #0x7bc
b	prep_6tap_neon
prep_8tap_smooth_16bpc_neon:
mov	w9, #0x7bc
mov	w10, #0x7bc
b	prep_6tap_neon
prep_8tap_smooth_regular_16bpc_neon:
mov	w9, #0x7bc
mov	w10, #0x2d
b	prep_6tap_neon
prep_6tap_neon:
mov	w11, #0x4081
mul	w5, w5, w11
mul	w6, w6, w11
add	w5, w5, w9
add	w6, w6, w10
ubfx	x8, x3, #0, #32
lsl	x8, x8, #1
dup	v31.8h, w7
clz	w7, w7
clz	w9, w3
sub	w7, w7, #0x12
mov	w12, #0x6
tst	w5, #0x1fc000
sub	w9, w9, #0x18
add	w13, w12, w7
sub	w12, w12, w7
adrp	x11, mc_subpel_filters-8
add	x11, x11, :lo12:mc_subpel_filters-8
b.ne	L_66c4
tst	w6, #0x1fc000
b.ne	L_6898
b	prep_16bpc_neon
L_66c4:
cmp	w3, #0x4
ubfx	w10, w5, #7, #7
and	w5, w5, #0x7f
b.le	L_66d8
mov	w5, w10
L_66d8:
tst	w6, #0x1fc000
add	x5, x11, w5, uxtw #3
b.ne	L_6e68
adrp	x10, prep_6tap_h_tbl
add	x10, x10, :lo12:prep_6tap_h_tbl
ldrsw	x9, [x10, x9, lsl #2]
neg	w12, w12
movi	v28.8h, #0x20, lsl #8
add	x10, x10, x9
dup	v30.4s, w12
br	x10
L_6704:
ldur	s0, [x5, #0x2]
sub	x1, x1, #0x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
L_6720:
ld1	{ v16.8h }, [x1], x2
ld1	{ v20.8h }, [x10], x2
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w4, w4, #0x2
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v17.4h, v0.h[1]
smlal	v2.4s, v18.4h, v0.h[2]
smlal	v2.4s, v19.4h, v0.h[3]
smull	v3.4s, v20.4h, v0.h[0]
smlal	v3.4s, v21.4h, v0.h[1]
smlal	v3.4s, v22.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
srshl	v16.4s, v2.4s, v30.4s
srshl	v20.4s, v3.4s, v30.4s
uzp1	v16.8h, v16.8h, v20.8h
sub	v16.8h, v16.8h, v28.8h
st1	{ v16.8b }, [x0], x8
st1	{ v16.d }[1], [x9], x8
b.gt	L_6720
ret
L_6784:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x4
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
sub	x2, x2, w3, uxtw #1
sub	x2, x2, #0x10
L_67a4:
ld1	{ v16.8h, v17.8h }, [x1], #32
ld1	{ v20.8h, v21.8h }, [x10], #32
mov	w5, w3
L_67b0:
smull	v18.4s, v16.4h, v0.h[1]
smull2	v19.4s, v16.8h, v0.h[1]
smull	v22.4s, v20.4h, v0.h[1]
smull2	v23.4s, v20.8h, v0.h[1]
ext	v24.16b, v16.16b, v17.16b, #0x2
ext	v25.16b, v20.16b, v21.16b, #0x2
smlal	v18.4s, v24.4h, v0.h[2]
smlal2	v19.4s, v24.8h, v0.h[2]
smlal	v22.4s, v25.4h, v0.h[2]
smlal2	v23.4s, v25.8h, v0.h[2]
ext	v24.16b, v16.16b, v17.16b, #0x4
ext	v25.16b, v20.16b, v21.16b, #0x4
smlal	v18.4s, v24.4h, v0.h[3]
smlal2	v19.4s, v24.8h, v0.h[3]
smlal	v22.4s, v25.4h, v0.h[3]
smlal2	v23.4s, v25.8h, v0.h[3]
ext	v24.16b, v16.16b, v17.16b, #0x6
ext	v25.16b, v20.16b, v21.16b, #0x6
smlal	v18.4s, v24.4h, v0.h[4]
smlal2	v19.4s, v24.8h, v0.h[4]
smlal	v22.4s, v25.4h, v0.h[4]
smlal2	v23.4s, v25.8h, v0.h[4]
ext	v24.16b, v16.16b, v17.16b, #0x8
ext	v25.16b, v20.16b, v21.16b, #0x8
smlal	v18.4s, v24.4h, v0.h[5]
smlal2	v19.4s, v24.8h, v0.h[5]
smlal	v22.4s, v25.4h, v0.h[5]
smlal2	v23.4s, v25.8h, v0.h[5]
ext	v24.16b, v16.16b, v17.16b, #0xa
ext	v25.16b, v20.16b, v21.16b, #0xa
smlal	v18.4s, v24.4h, v0.h[6]
smlal2	v19.4s, v24.8h, v0.h[6]
smlal	v22.4s, v25.4h, v0.h[6]
smlal2	v23.4s, v25.8h, v0.h[6]
subs	w5, w5, #0x8
srshl	v18.4s, v18.4s, v30.4s
srshl	v19.4s, v19.4s, v30.4s
srshl	v22.4s, v22.4s, v30.4s
srshl	v23.4s, v23.4s, v30.4s
uzp1	v18.8h, v18.8h, v19.8h
uzp1	v22.8h, v22.8h, v23.8h
sub	v18.8h, v18.8h, v28.8h
sub	v22.8h, v22.8h, v28.8h
st1	{ v18.8h }, [x0], #16
st1	{ v22.8h }, [x9], #16
b.le	L_687c
mov	v16.16b, v17.16b
mov	v20.16b, v21.16b
ld1	{ v17.8h }, [x1], #16
ld1	{ v21.8h }, [x10], #16
b	L_67b0
L_687c:
add	x0, x0, x8
add	x9, x9, x8
add	x1, x1, x2
add	x10, x10, x2
subs	w4, w4, #0x2
b.gt	L_67a4
ret
L_6898:
cmp	w4, #0x4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_68ac
mov	w6, w10
L_68ac:
add	x6, x11, w6, uxtw #3
dup	v30.4s, w12
movi	v29.8h, #0x20, lsl #8
adrp	x10, prep_6tap_v_tbl
add	x10, x10, :lo12:prep_6tap_v_tbl
ldrsw	x9, [x10, x9, lsl #2]
neg	v30.4s, v30.4s
add	x10, x10, x9
br	x10
L_68d0:
b.gt	L_6988
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.4h }, [x1], x2
ld1	{ v2.4h }, [x10], x2
ld1	{ v3.4h }, [x1], x2
ld1	{ v4.4h }, [x10], x2
ld1	{ v5.4h }, [x1], x2
smull	v6.4s, v1.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[1]
smlal	v6.4s, v3.4h, v0.h[2]
smlal	v6.4s, v4.4h, v0.h[3]
smull	v7.4s, v2.4h, v0.h[0]
smlal	v7.4s, v3.4h, v0.h[1]
smlal	v7.4s, v4.4h, v0.h[2]
smlal	v7.4s, v5.4h, v0.h[3]
srshl	v6.4s, v6.4s, v30.4s
srshl	v7.4s, v7.4s, v30.4s
uzp1	v6.8h, v6.8h, v7.8h
sub	v6.8h, v6.8h, v29.8h
st1	{ v6.8b }, [x0], x8
st1	{ v6.d }[1], [x9], x8
b.le	L_6984
ld1	{ v6.4h }, [x10], x2
ld1	{ v7.4h }, [x1], x2
smull	v1.4s, v3.4h, v0.h[0]
smlal	v1.4s, v4.4h, v0.h[1]
smlal	v1.4s, v5.4h, v0.h[2]
smlal	v1.4s, v6.4h, v0.h[3]
smull	v2.4s, v4.4h, v0.h[0]
smlal	v2.4s, v5.4h, v0.h[1]
smlal	v2.4s, v6.4h, v0.h[2]
smlal	v2.4s, v7.4h, v0.h[3]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
sub	v1.8h, v1.8h, v29.8h
st1	{ v1.8b }, [x0], x8
st1	{ v1.d }[1], [x9], x8
L_6984:
ret
L_6988:
ld1	{ v0.8b }, [x6]
sub	x10, x1, x2, lsl #1
add	x9, x0, x8
sub	x1, x10, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.4h }, [x1], x2
ld1	{ v17.4h }, [x10], x2
ld1	{ v18.4h }, [x1], x2
ld1	{ v19.4h }, [x10], x2
ld1	{ v20.4h }, [x1], x2
ld1	{ v21.4h }, [x10], x2
ld1	{ v22.4h }, [x1], x2
L_69c0:
subs	w4, w4, #0x4
ld1	{ v23.4h }, [x10], x2
ld1	{ v24.4h }, [x1], x2
ld1	{ v25.4h }, [x10], x2
ld1	{ v26.4h }, [x1], x2
smull	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smull	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
smull	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v20.4h, v0.h[2]
smlal	v3.4s, v21.4h, v0.h[3]
smlal	v3.4s, v22.4h, v0.h[4]
smlal	v3.4s, v23.4h, v0.h[5]
smlal	v3.4s, v24.4h, v0.h[6]
smull	v4.4s, v20.4h, v0.h[1]
smlal	v4.4s, v21.4h, v0.h[2]
smlal	v4.4s, v22.4h, v0.h[3]
smlal	v4.4s, v23.4h, v0.h[4]
smlal	v4.4s, v24.4h, v0.h[5]
smlal	v4.4s, v25.4h, v0.h[6]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
st1	{ v1.8b }, [x0], x8
st1	{ v1.d }[1], [x9], x8
st1	{ v3.8b }, [x0], x8
st1	{ v3.d }[1], [x9], x8
b.le	L_6ae0
cmp	w4, #0x2
mov	v16.8b, v20.8b
mov	v17.8b, v21.8b
mov	v18.8b, v22.8b
mov	v19.8b, v23.8b
mov	v20.8b, v24.8b
mov	v21.8b, v25.8b
mov	v22.8b, v26.8b
b.eq	L_6a90
b	L_69c0
L_6a90:
ld1	{ v23.4h }, [x10], x2
ld1	{ v24.4h }, [x1], x2
smull	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smull	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v21.4h, v0.h[4]
smlal	v2.4s, v22.4h, v0.h[5]
smlal	v2.4s, v23.4h, v0.h[6]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
sub	v1.8h, v1.8h, v29.8h
st1	{ v1.8b }, [x0], x8
st1	{ v1.d }[1], [x9], x8
L_6ae0:
ret
L_6ae4:
b.gt	L_6bfc
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8h }, [x1], x2
ld1	{ v2.8h }, [x10], x2
ld1	{ v3.8h }, [x1], x2
ld1	{ v4.8h }, [x10], x2
ld1	{ v5.8h }, [x1], x2
smull	v16.4s, v1.4h, v0.h[0]
smlal	v16.4s, v2.4h, v0.h[1]
smlal	v16.4s, v3.4h, v0.h[2]
smlal	v16.4s, v4.4h, v0.h[3]
smull2	v17.4s, v1.8h, v0.h[0]
smlal2	v17.4s, v2.8h, v0.h[1]
smlal2	v17.4s, v3.8h, v0.h[2]
smlal2	v17.4s, v4.8h, v0.h[3]
smull	v18.4s, v2.4h, v0.h[0]
smlal	v18.4s, v3.4h, v0.h[1]
smlal	v18.4s, v4.4h, v0.h[2]
smlal	v18.4s, v5.4h, v0.h[3]
smull2	v19.4s, v2.8h, v0.h[0]
smlal2	v19.4s, v3.8h, v0.h[1]
smlal2	v19.4s, v4.8h, v0.h[2]
smlal2	v19.4s, v5.8h, v0.h[3]
srshl	v16.4s, v16.4s, v30.4s
srshl	v17.4s, v17.4s, v30.4s
srshl	v18.4s, v18.4s, v30.4s
srshl	v19.4s, v19.4s, v30.4s
uzp1	v16.8h, v16.8h, v17.8h
uzp1	v18.8h, v18.8h, v19.8h
sub	v16.8h, v16.8h, v29.8h
sub	v18.8h, v18.8h, v29.8h
st1	{ v16.8h }, [x0], x8
st1	{ v18.8h }, [x9], x8
b.le	L_6bf8
ld1	{ v6.8h }, [x10], x2
ld1	{ v7.8h }, [x1], x2
smull	v16.4s, v3.4h, v0.h[0]
smlal	v16.4s, v4.4h, v0.h[1]
smlal	v16.4s, v5.4h, v0.h[2]
smlal	v16.4s, v6.4h, v0.h[3]
smull2	v17.4s, v3.8h, v0.h[0]
smlal2	v17.4s, v4.8h, v0.h[1]
smlal2	v17.4s, v5.8h, v0.h[2]
smlal2	v17.4s, v6.8h, v0.h[3]
smull	v18.4s, v4.4h, v0.h[0]
smlal	v18.4s, v5.4h, v0.h[1]
smlal	v18.4s, v6.4h, v0.h[2]
smlal	v18.4s, v7.4h, v0.h[3]
smull2	v19.4s, v4.8h, v0.h[0]
smlal2	v19.4s, v5.8h, v0.h[1]
smlal2	v19.4s, v6.8h, v0.h[2]
smlal2	v19.4s, v7.8h, v0.h[3]
srshl	v16.4s, v16.4s, v30.4s
srshl	v17.4s, v17.4s, v30.4s
srshl	v18.4s, v18.4s, v30.4s
srshl	v19.4s, v19.4s, v30.4s
uzp1	v16.8h, v16.8h, v17.8h
uzp1	v18.8h, v18.8h, v19.8h
sub	v16.8h, v16.8h, v29.8h
sub	v18.8h, v18.8h, v29.8h
st1	{ v16.8h }, [x0], x8
st1	{ v18.8h }, [x9], x8
L_6bf8:
ret
L_6bfc:
ld1	{ v0.8b }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w6, w4
L_6c10:
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1	{ v16.8h }, [x1], x2
ld1	{ v17.8h }, [x10], x2
ld1	{ v18.8h }, [x1], x2
ld1	{ v19.8h }, [x10], x2
ld1	{ v20.8h }, [x1], x2
ld1	{ v21.8h }, [x10], x2
ld1	{ v22.8h }, [x1], x2
L_6c3c:
subs	w4, w4, #0x2
ld1	{ v23.8h }, [x10], x2
ld1	{ v24.8h }, [x1], x2
smull	v1.4s, v17.4h, v0.h[1]
smlal	v1.4s, v18.4h, v0.h[2]
smlal	v1.4s, v19.4h, v0.h[3]
smlal	v1.4s, v20.4h, v0.h[4]
smlal	v1.4s, v21.4h, v0.h[5]
smlal	v1.4s, v22.4h, v0.h[6]
smull2	v2.4s, v17.8h, v0.h[1]
smlal2	v2.4s, v18.8h, v0.h[2]
smlal2	v2.4s, v19.8h, v0.h[3]
smlal2	v2.4s, v20.8h, v0.h[4]
smlal2	v2.4s, v21.8h, v0.h[5]
smlal2	v2.4s, v22.8h, v0.h[6]
smull	v3.4s, v18.4h, v0.h[1]
smlal	v3.4s, v19.4h, v0.h[2]
smlal	v3.4s, v20.4h, v0.h[3]
smlal	v3.4s, v21.4h, v0.h[4]
smlal	v3.4s, v22.4h, v0.h[5]
smlal	v3.4s, v23.4h, v0.h[6]
smull2	v4.4s, v18.8h, v0.h[1]
smlal2	v4.4s, v19.8h, v0.h[2]
smlal2	v4.4s, v20.8h, v0.h[3]
smlal2	v4.4s, v21.8h, v0.h[4]
smlal2	v4.4s, v22.8h, v0.h[5]
smlal2	v4.4s, v23.8h, v0.h[6]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
st1	{ v1.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_6d8c
subs	w4, w4, #0x2
ld1	{ v25.8h }, [x10], x2
ld1	{ v26.8h }, [x1], x2
smull	v1.4s, v19.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v21.4h, v0.h[3]
smlal	v1.4s, v22.4h, v0.h[4]
smlal	v1.4s, v23.4h, v0.h[5]
smlal	v1.4s, v24.4h, v0.h[6]
smull2	v2.4s, v19.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v21.8h, v0.h[3]
smlal2	v2.4s, v22.8h, v0.h[4]
smlal2	v2.4s, v23.8h, v0.h[5]
smlal2	v2.4s, v24.8h, v0.h[6]
smull	v3.4s, v20.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v22.4h, v0.h[3]
smlal	v3.4s, v23.4h, v0.h[4]
smlal	v3.4s, v24.4h, v0.h[5]
smlal	v3.4s, v25.4h, v0.h[6]
smull2	v4.4s, v20.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v22.8h, v0.h[3]
smlal2	v4.4s, v23.8h, v0.h[4]
smlal2	v4.4s, v24.8h, v0.h[5]
smlal2	v4.4s, v25.8h, v0.h[6]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
st1	{ v1.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_6d8c
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
mov	v18.16b, v22.16b
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
mov	v21.16b, v25.16b
mov	v22.16b, v26.16b
b	L_6c3c
L_6d8c:
subs	w3, w3, #0x8
b.le	L_6db8
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
b	L_6c10
L_6db8:
ret
L_6dbc:
b.gt	L_6bfc
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.8h, v17.8h }, [x1], x2
ld1	{ v18.8h, v19.8h }, [x1], x2
ld1	{ v20.8h, v21.8h }, [x1], x2
L_6dd8:
ld1	{ v22.8h, v23.8h }, [x1], x2
subs	w4, w4, #0x1
smull	v1.4s, v16.4h, v0.h[0]
smlal	v1.4s, v18.4h, v0.h[1]
smlal	v1.4s, v20.4h, v0.h[2]
smlal	v1.4s, v22.4h, v0.h[3]
smull2	v2.4s, v16.8h, v0.h[0]
smlal2	v2.4s, v18.8h, v0.h[1]
smlal2	v2.4s, v20.8h, v0.h[2]
smlal2	v2.4s, v22.8h, v0.h[3]
smull	v3.4s, v17.4h, v0.h[0]
smlal	v3.4s, v19.4h, v0.h[1]
smlal	v3.4s, v21.4h, v0.h[2]
smlal	v3.4s, v23.4h, v0.h[3]
smull2	v4.4s, v17.8h, v0.h[0]
smlal2	v4.4s, v19.8h, v0.h[1]
smlal2	v4.4s, v21.8h, v0.h[2]
smlal2	v4.4s, v23.8h, v0.h[3]
srshl	v1.4s, v1.4s, v30.4s
srshl	v2.4s, v2.4s, v30.4s
srshl	v3.4s, v3.4s, v30.4s
srshl	v4.4s, v4.4s, v30.4s
uzp1	v1.8h, v1.8h, v2.8h
uzp1	v3.8h, v3.8h, v4.8h
sub	v1.8h, v1.8h, v29.8h
sub	v2.8h, v3.8h, v29.8h
st1	{ v1.8h, v2.8h }, [x0], x8
b.le	L_6e64
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
b	L_6dd8
L_6e64:
ret
L_6e68:
cmp	w4, #0x4
ubfx	w10, w6, #7, #7
and	w6, w6, #0x7f
b.le	L_6e7c
mov	w6, w10
L_6e7c:
add	x6, x11, w6, uxtw #3
adrp	x10, prep_6tap_hv_tbl
add	x10, x10, :lo12:prep_6tap_hv_tbl
dup	v30.4s, w12
ldrsw	x9, [x10, x9, lsl #2]
neg	v30.4s, v30.4s
movi	v29.8h, #0x20, lsl #8
add	x10, x10, x9
br	x10
L_6ea0:
ldur	s0, [x5, #0x2]
b.gt	L_6f50
ldur	s1, [x6, #0x2]
sub	x10, x1, #0x2
sub	x1, x10, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x1], x2
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v16.4h, v16.4s
bl	L_7024
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
L_6f00:
bl	L_7024
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v24.4h, v1.h[2]
smlal	v3.4s, v25.4h, v1.h[3]
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
sub	v2.8h, v2.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v2.8b }, [x0], x8
st1	{ v2.d }[1], [x9], x8
b.le	L_7020
mov	v16.8b, v18.8b
mov	v17.8b, v24.8b
mov	v18.8b, v25.8b
b	L_6f00
L_6f50:
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x2
sub	x10, x1, x2
sub	x1, x1, x2, lsl #1
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v25.8h }, [x1], x2
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v16.4s, v25.4s, v30.4s
xtn	v18.4h, v16.4s
bl	L_7024
mov	v19.8b, v24.8b
mov	v20.8b, v25.8b
bl	L_7024
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
L_6fb8:
bl	L_7024
smull	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smlal	v3.4s, v21.4h, v1.h[4]
smlal	v3.4s, v22.4h, v1.h[5]
smlal	v3.4s, v24.4h, v1.h[6]
smull	v4.4s, v19.4h, v1.h[1]
smlal	v4.4s, v20.4h, v1.h[2]
smlal	v4.4s, v21.4h, v1.h[3]
smlal	v4.4s, v22.4h, v1.h[4]
smlal	v4.4s, v24.4h, v1.h[5]
smlal	v4.4s, v25.4h, v1.h[6]
rshrn	v3.4h, v3.4s, #0x6
rshrn2	v3.8h, v4.4s, #0x6
sub	v3.8h, v3.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v3.8b }, [x0], x8
st1	{ v3.d }[1], [x9], x8
b.le	L_7020
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v24.8b
mov	v22.8b, v25.8b
b	L_6fb8
L_7020:
ret	x15
L_7024:
ld1	{ v24.8h }, [x10], x2
ld1	{ v25.8h }, [x1], x2
ext	v26.16b, v24.16b, v24.16b, #0x2
ext	v27.16b, v24.16b, v24.16b, #0x4
ext	v28.16b, v24.16b, v24.16b, #0x6
smull	v24.4s, v24.4h, v0.h[0]
smlal	v24.4s, v26.4h, v0.h[1]
smlal	v24.4s, v27.4h, v0.h[2]
smlal	v24.4s, v28.4h, v0.h[3]
ext	v26.16b, v25.16b, v25.16b, #0x2
ext	v27.16b, v25.16b, v25.16b, #0x4
ext	v28.16b, v25.16b, v25.16b, #0x6
smull	v25.4s, v25.4h, v0.h[0]
smlal	v25.4s, v26.4h, v0.h[1]
smlal	v25.4s, v27.4h, v0.h[2]
smlal	v25.4s, v28.4h, v0.h[3]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
xtn	v24.4h, v24.4s
xtn	v25.4h, v25.4s
ret
L_7078:
b.gt	L_71b4
ld1	{ v0.8b }, [x5]
ldur	s1, [x6, #0x2]
sub	x1, x1, #0x4
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_709c:
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1	{ v27.8h, v28.8h }, [x1], x2
smull	v24.4s, v27.4h, v0.h[1]
smull2	v25.4s, v27.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v16.8h, v24.8h, v25.8h
bl	L_7328
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
L_710c:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	L_7328
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v23.4h, v1.h[2]
smlal2	v5.4s, v23.8h, v1.h[2]
smlal	v2.4s, v23.4h, v1.h[3]
smlal2	v3.4s, v23.8h, v1.h[3]
smlal	v4.4s, v24.4h, v1.h[3]
smlal2	v5.4s, v24.8h, v1.h[3]
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
rshrn	v3.4h, v4.4s, #0x6
rshrn2	v3.8h, v5.4s, #0x6
sub	v2.8h, v2.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_7188
mov	v16.16b, v18.16b
mov	v17.16b, v23.16b
mov	v18.16b, v24.16b
b	L_710c
L_7188:
subs	w3, w3, #0x8
b.le	L_7324
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
b	L_709c
L_71b4:
ld1	{ v0.8b }, [x5]
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x4
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
L_71d4:
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
ld1	{ v27.8h, v28.8h }, [x1], x2
smull	v24.4s, v27.4h, v0.h[1]
smull2	v25.4s, v27.8h, v0.h[1]
ext	v26.16b, v27.16b, v28.16b, #0x2
smlal	v24.4s, v26.4h, v0.h[2]
smlal2	v25.4s, v26.8h, v0.h[2]
ext	v26.16b, v27.16b, v28.16b, #0x4
smlal	v24.4s, v26.4h, v0.h[3]
smlal2	v25.4s, v26.8h, v0.h[3]
ext	v26.16b, v27.16b, v28.16b, #0x6
smlal	v24.4s, v26.4h, v0.h[4]
smlal2	v25.4s, v26.8h, v0.h[4]
ext	v26.16b, v27.16b, v28.16b, #0x8
smlal	v24.4s, v26.4h, v0.h[5]
smlal2	v25.4s, v26.8h, v0.h[5]
ext	v26.16b, v27.16b, v28.16b, #0xa
smlal	v24.4s, v26.4h, v0.h[6]
smlal2	v25.4s, v26.8h, v0.h[6]
srshl	v24.4s, v24.4s, v30.4s
srshl	v25.4s, v25.4s, v30.4s
uzp1	v18.8h, v24.8h, v25.8h
bl	L_7328
mov	v19.16b, v23.16b
mov	v20.16b, v24.16b
bl	L_7328
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
L_7250:
smull	v2.4s, v18.4h, v1.h[1]
smull2	v3.4s, v18.8h, v1.h[1]
bl	L_7328
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
smlal	v4.4s, v23.4h, v1.h[5]
smlal2	v5.4s, v23.8h, v1.h[5]
smlal	v2.4s, v23.4h, v1.h[6]
smlal2	v3.4s, v23.8h, v1.h[6]
smlal	v4.4s, v24.4h, v1.h[6]
smlal2	v5.4s, v24.8h, v1.h[6]
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
rshrn	v3.4h, v4.4s, #0x6
rshrn2	v3.8h, v5.4s, #0x6
sub	v2.8h, v2.8h, v29.8h
sub	v3.8h, v3.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x8
st1	{ v3.8h }, [x9], x8
b.le	L_72f4
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v23.16b
mov	v22.16b, v24.16b
b	L_7250
L_72f4:
subs	w3, w3, #0x8
b.le	L_7324
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
add	x1, x1, x2, lsl #1
b	L_71d4
L_7324:
ret	x15
L_7328:
ld1	{ v4.8h, v5.8h }, [x10], x2
ld1	{ v6.8h, v7.8h }, [x1], x2
smull	v25.4s, v4.4h, v0.h[1]
smull2	v26.4s, v4.8h, v0.h[1]
smull	v27.4s, v6.4h, v0.h[1]
smull2	v28.4s, v6.8h, v0.h[1]
ext	v23.16b, v4.16b, v5.16b, #0x2
ext	v24.16b, v6.16b, v7.16b, #0x2
smlal	v25.4s, v23.4h, v0.h[2]
smlal2	v26.4s, v23.8h, v0.h[2]
smlal	v27.4s, v24.4h, v0.h[2]
smlal2	v28.4s, v24.8h, v0.h[2]
ext	v23.16b, v4.16b, v5.16b, #0x4
ext	v24.16b, v6.16b, v7.16b, #0x4
smlal	v25.4s, v23.4h, v0.h[3]
smlal2	v26.4s, v23.8h, v0.h[3]
smlal	v27.4s, v24.4h, v0.h[3]
smlal2	v28.4s, v24.8h, v0.h[3]
ext	v23.16b, v4.16b, v5.16b, #0x6
ext	v24.16b, v6.16b, v7.16b, #0x6
smlal	v25.4s, v23.4h, v0.h[4]
smlal2	v26.4s, v23.8h, v0.h[4]
smlal	v27.4s, v24.4h, v0.h[4]
smlal2	v28.4s, v24.8h, v0.h[4]
ext	v23.16b, v4.16b, v5.16b, #0x8
ext	v24.16b, v6.16b, v7.16b, #0x8
smlal	v25.4s, v23.4h, v0.h[5]
smlal2	v26.4s, v23.8h, v0.h[5]
smlal	v27.4s, v24.4h, v0.h[5]
smlal2	v28.4s, v24.8h, v0.h[5]
ext	v23.16b, v4.16b, v5.16b, #0xa
ext	v24.16b, v6.16b, v7.16b, #0xa
smlal	v25.4s, v23.4h, v0.h[6]
smlal2	v26.4s, v23.8h, v0.h[6]
smlal	v27.4s, v24.4h, v0.h[6]
smlal2	v28.4s, v24.8h, v0.h[6]
srshl	v25.4s, v25.4s, v30.4s
srshl	v26.4s, v26.4s, v30.4s
srshl	v27.4s, v27.4s, v30.4s
srshl	v28.4s, v28.4s, v30.4s
uzp1	v23.8h, v25.8h, v26.8h
uzp1	v24.8h, v27.8h, v28.8h
ret
prep_bilin_16bpc_neon:
dup	v1.8h, w5
dup	v3.8h, w6
mov	w10, #0x10
sub	w9, w10, w5
sub	w10, w10, w6
dup	v0.8h, w9
dup	v2.8h, w10
ubfx	x8, x3, #0, #32
lsl	x8, x8, #1
clz	w7, w7
clz	w9, w3
sub	w7, w7, #0x12
mov	w11, #0x4
sub	w9, w9, #0x18
sub	w11, w11, w7
add	w12, w7, #0x4
cbnz	w5, L_7420
cbnz	w6, L_759c
b	prep_16bpc_neon
L_7420:
cbnz	w6, L_7714
adrp	x10, prep_bilin_h_tbl
add	x10, x10, :lo12:prep_bilin_h_tbl
dup	v31.8h, w11
ldrsw	x9, [x10, x9, lsl #2]
neg	v31.8h, v31.8h
movi	v29.8h, #0x20, lsl #8
add	x10, x10, x9
br	x10
L_7444:
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
L_7454:
ld1	{ v4.8h }, [x1], x2
ld1	{ v6.8h }, [x10], x2
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
trn1	v4.2d, v4.2d, v6.2d
trn1	v5.2d, v5.2d, v7.2d
subs	w4, w4, #0x2
mul	v4.8h, v4.8h, v0.8h
mla	v4.8h, v5.8h, v1.8h
urshl	v4.8h, v4.8h, v31.8h
sub	v4.8h, v4.8h, v29.8h
st1	{ v4.8b }, [x0], x8
st1	{ v4.d }[1], [x9], x8
b.gt	L_7454
ret
L_7490:
add	x9, x0, x8
add	x10, x1, x2
lsl	x8, x8, #1
lsl	x2, x2, #1
L_74a0:
ldr	h5, [x1, #0x10]
ldr	h7, [x10, #0x10]
ld1	{ v4.8h }, [x1], x2
ld1	{ v6.8h }, [x10], x2
ext	v5.16b, v4.16b, v5.16b, #0x2
ext	v7.16b, v6.16b, v7.16b, #0x2
subs	w4, w4, #0x2
mul	v4.8h, v4.8h, v0.8h
mla	v4.8h, v5.8h, v1.8h
mul	v6.8h, v6.8h, v0.8h
mla	v6.8h, v7.8h, v1.8h
urshl	v4.8h, v4.8h, v31.8h
urshl	v6.8h, v6.8h, v31.8h
sub	v4.8h, v4.8h, v29.8h
sub	v6.8h, v6.8h, v29.8h
st1	{ v4.8h }, [x0], x8
st1	{ v6.8h }, [x9], x8
b.gt	L_74a0
ret
L_74ec:
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
sub	x2, x2, w3, uxtw #1
sub	x2, x2, #0x10
L_7500:
ld1	{ v16.8h }, [x1], #16
ld1	{ v21.8h }, [x10], #16
mov	w5, w3
L_750c:
ld1	{ v17.8h, v18.8h }, [x1], #32
ld1	{ v22.8h, v23.8h }, [x10], #32
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v20.16b, v17.16b, v18.16b, #0x2
ext	v24.16b, v21.16b, v22.16b, #0x2
ext	v25.16b, v22.16b, v23.16b, #0x2
mul	v16.8h, v16.8h, v0.8h
mla	v16.8h, v19.8h, v1.8h
mul	v17.8h, v17.8h, v0.8h
mla	v17.8h, v20.8h, v1.8h
mul	v21.8h, v21.8h, v0.8h
mla	v21.8h, v24.8h, v1.8h
mul	v22.8h, v22.8h, v0.8h
mla	v22.8h, v25.8h, v1.8h
urshl	v16.8h, v16.8h, v31.8h
urshl	v17.8h, v17.8h, v31.8h
urshl	v21.8h, v21.8h, v31.8h
urshl	v22.8h, v22.8h, v31.8h
subs	w5, w5, #0x10
sub	v16.8h, v16.8h, v29.8h
sub	v17.8h, v17.8h, v29.8h
sub	v21.8h, v21.8h, v29.8h
sub	v22.8h, v22.8h, v29.8h
st1	{ v16.8h, v17.8h }, [x0], #32
st1	{ v21.8h, v22.8h }, [x9], #32
b.le	L_7580
mov	v16.16b, v18.16b
mov	v21.16b, v23.16b
b	L_750c
L_7580:
add	x0, x0, x8
add	x9, x9, x8
add	x1, x1, x2
add	x10, x10, x2
subs	w4, w4, #0x2
b.gt	L_7500
ret
L_759c:
cmp	w4, #0x4
adrp	x10, prep_bilin_v_tbl
add	x10, x10, :lo12:prep_bilin_v_tbl
dup	v31.8h, w11
ldrsw	x9, [x10, x9, lsl #2]
movi	v29.8h, #0x20, lsl #8
neg	v31.8h, v31.8h
add	x10, x10, x9
br	x10
L_75c0:
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1	{ v16.4h }, [x1], x2
L_75d4:
ld1	{ v17.4h }, [x10], x2
ld1	{ v18.4h }, [x1], x2
trn1	v16.2d, v16.2d, v17.2d
trn1	v17.2d, v17.2d, v18.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
subs	w4, w4, #0x2
urshl	v4.8h, v4.8h, v31.8h
sub	v4.8h, v4.8h, v29.8h
st1	{ v4.8b }, [x0], x8
st1	{ v4.d }[1], [x9], x8
b.le	L_760c
mov	v16.8b, v18.8b
b	L_75d4
L_760c:
ret
L_7610:
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1	{ v16.8h }, [x1], x2
L_7624:
ld1	{ v17.8h }, [x10], x2
ld1	{ v18.8h }, [x1], x2
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v18.8h, v3.8h
subs	w4, w4, #0x2
urshl	v4.8h, v4.8h, v31.8h
urshl	v5.8h, v5.8h, v31.8h
sub	v4.8h, v4.8h, v29.8h
sub	v5.8h, v5.8h, v29.8h
st1	{ v4.8h }, [x0], x8
st1	{ v5.8h }, [x9], x8
b.le	L_7664
mov	v16.16b, v18.16b
b	L_7624
L_7664:
ret
L_7668:
mov	w6, w4
L_766c:
add	x9, x0, x8
add	x10, x1, x2
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1	{ v16.8h, v17.8h }, [x1], x2
L_7680:
ld1	{ v18.8h, v19.8h }, [x10], x2
ld1	{ v20.8h, v21.8h }, [x1], x2
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v18.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v19.8h, v3.8h
mul	v6.8h, v18.8h, v2.8h
mla	v6.8h, v20.8h, v3.8h
mul	v7.8h, v19.8h, v2.8h
mla	v7.8h, v21.8h, v3.8h
subs	w4, w4, #0x2
urshl	v4.8h, v4.8h, v31.8h
urshl	v5.8h, v5.8h, v31.8h
urshl	v6.8h, v6.8h, v31.8h
urshl	v7.8h, v7.8h, v31.8h
sub	v4.8h, v4.8h, v29.8h
sub	v5.8h, v5.8h, v29.8h
sub	v6.8h, v6.8h, v29.8h
sub	v7.8h, v7.8h, v29.8h
st1	{ v4.8h, v5.8h }, [x0], x8
st1	{ v6.8h, v7.8h }, [x9], x8
b.le	L_76e4
mov	v16.16b, v20.16b
mov	v17.16b, v21.16b
b	L_7680
L_76e4:
subs	w3, w3, #0x10
b.le	L_7710
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #0x20
add	x0, x0, #0x20
b	L_766c
L_7710:
ret
L_7714:
adrp	x10, prep_bilin_hv_tbl
add	x10, x10, :lo12:prep_bilin_hv_tbl
dup	v31.8h, w11
ldrsw	x9, [x10, x9, lsl #2]
neg	v31.8h, v31.8h
movi	v29.8h, #0x20, lsl #8
add	x10, x10, x9
br	x10
L_7734:
add	x10, x1, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
ld1	{ v20.8h }, [x1], x2
ext	v21.16b, v20.16b, v20.16b, #0x2
mul	v16.4h, v20.4h, v0.4h
mla	v16.4h, v21.4h, v1.4h
urshl	v16.4h, v16.4h, v31.4h
L_7758:
ld1	{ v22.8h }, [x10], x2
ld1	{ v24.8h }, [x1], x2
ext	v23.16b, v22.16b, v22.16b, #0x2
ext	v25.16b, v24.16b, v24.16b, #0x2
trn1	v22.2d, v22.2d, v24.2d
trn1	v23.2d, v23.2d, v25.2d
mul	v17.8h, v22.8h, v0.8h
mla	v17.8h, v23.8h, v1.8h
urshl	v17.8h, v17.8h, v31.8h
trn1	v16.2d, v16.2d, v17.2d
umull	v4.4s, v16.4h, v2.4h
umlal	v4.4s, v17.4h, v3.4h
umull2	v5.4s, v16.8h, v2.8h
umlal2	v5.4s, v17.8h, v3.8h
rshrn	v4.4h, v4.4s, #0x4
rshrn2	v4.8h, v5.4s, #0x4
sub	v4.8h, v4.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v4.8b }, [x0], x8
st1	{ v4.d }[1], [x9], x8
b.le	L_77b4
trn2	v16.2d, v17.2d, v17.2d
b	L_7758
L_77b4:
ret
L_77b8:
mov	w6, w4
L_77bc:
add	x10, x1, x2
add	x9, x0, x8
lsl	x2, x2, #1
lsl	x8, x8, #1
ldr	h21, [x1, #0x10]
ld1	{ v20.8h }, [x1], x2
ext	v21.16b, v20.16b, v21.16b, #0x2
mul	v16.8h, v20.8h, v0.8h
mla	v16.8h, v21.8h, v1.8h
urshl	v16.8h, v16.8h, v31.8h
L_77e4:
ldr	h23, [x10, #0x10]
ld1	{ v22.8h }, [x10], x2
ldr	h25, [x1, #0x10]
ld1	{ v24.8h }, [x1], x2
ext	v23.16b, v22.16b, v23.16b, #0x2
ext	v25.16b, v24.16b, v25.16b, #0x2
mul	v17.8h, v22.8h, v0.8h
mla	v17.8h, v23.8h, v1.8h
mul	v18.8h, v24.8h, v0.8h
mla	v18.8h, v25.8h, v1.8h
urshl	v17.8h, v17.8h, v31.8h
urshl	v18.8h, v18.8h, v31.8h
umull	v4.4s, v16.4h, v2.4h
umlal	v4.4s, v17.4h, v3.4h
umull2	v5.4s, v16.8h, v2.8h
umlal2	v5.4s, v17.8h, v3.8h
umull	v6.4s, v17.4h, v2.4h
umlal	v6.4s, v18.4h, v3.4h
umull2	v7.4s, v17.8h, v2.8h
umlal2	v7.4s, v18.8h, v3.8h
rshrn	v4.4h, v4.4s, #0x4
rshrn2	v4.8h, v5.4s, #0x4
rshrn	v5.4h, v6.4s, #0x4
rshrn2	v5.8h, v7.4s, #0x4
sub	v4.8h, v4.8h, v29.8h
sub	v5.8h, v5.8h, v29.8h
subs	w4, w4, #0x2
st1	{ v4.8h }, [x0], x8
st1	{ v5.8h }, [x9], x8
b.le	L_7864
mov	v16.16b, v18.16b
b	L_77e4
L_7864:
subs	w3, w3, #0x8
b.le	L_7890
asr	x2, x2, #1
asr	x8, x8, #1
msub	x1, x2, x6, x1
msub	x0, x8, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x10
b	L_77bc
L_7890:
ret
warp_filter_horz_neon:
add	w12, w5, #0x200
ld1	{ v16.8h, v17.8h }, [x2], x3
asr	w13, w12, #10
add	w12, w12, w7
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d2, [x11, w13, sxtw #3]
sshll	v0.8h, v0.8b, #0x0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d3, [x11, w13, sxtw #3]
sshll	v1.8h, v1.8b, #0x0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d4, [x11, w13, sxtw #3]
sshll	v2.8h, v2.8b, #0x0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d5, [x11, w13, sxtw #3]
sshll	v3.8h, v3.8b, #0x0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d6, [x11, w13, sxtw #3]
sshll	v4.8h, v4.8b, #0x0
asr	w13, w12, #10
add	w12, w12, w7
ldr	d7, [x11, w13, sxtw #3]
sshll	v5.8h, v5.8b, #0x0
ext	v18.16b, v16.16b, v17.16b, #0x2
smull	v8.4s, v16.4h, v0.4h
smull2	v9.4s, v16.8h, v0.8h
sshll	v6.8h, v6.8b, #0x0
ext	v19.16b, v16.16b, v17.16b, #0x4
smull	v10.4s, v18.4h, v1.4h
smull2	v11.4s, v18.8h, v1.8h
sshll	v7.8h, v7.8b, #0x0
ext	v20.16b, v16.16b, v17.16b, #0x6
smull	v0.4s, v19.4h, v2.4h
smull2	v1.4s, v19.8h, v2.8h
ext	v21.16b, v16.16b, v17.16b, #0x8
addp	v8.4s, v8.4s, v9.4s
smull	v2.4s, v20.4h, v3.4h
smull2	v3.4s, v20.8h, v3.8h
ext	v22.16b, v16.16b, v17.16b, #0xa
addp	v9.4s, v10.4s, v11.4s
smull	v10.4s, v21.4h, v4.4h
smull2	v11.4s, v21.8h, v4.8h
ext	v23.16b, v16.16b, v17.16b, #0xc
addp	v0.4s, v0.4s, v1.4s
smull	v18.4s, v22.4h, v5.4h
smull2	v19.4s, v22.8h, v5.8h
ext	v16.16b, v16.16b, v17.16b, #0xe
addp	v1.4s, v2.4s, v3.4s
addp	v2.4s, v10.4s, v11.4s
smull	v20.4s, v23.4h, v6.4h
smull2	v21.4s, v23.8h, v6.8h
addp	v3.4s, v18.4s, v19.4s
smull	v22.4s, v16.4h, v7.4h
smull2	v23.4s, v16.8h, v7.8h
addp	v4.4s, v20.4s, v21.4s
addp	v5.4s, v22.4s, v23.4s
addp	v8.4s, v8.4s, v9.4s
addp	v0.4s, v0.4s, v1.4s
addp	v2.4s, v2.4s, v3.4s
addp	v4.4s, v4.4s, v5.4s
addp	v16.4s, v8.4s, v0.4s
addp	v17.4s, v2.4s, v4.4s
add	w5, w5, w8
srshl	v16.4s, v16.4s, v14.4s
srshl	v17.4s, v17.4s, v14.4s
ret
warp_affine_8x8_16bpc_neon:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
dup	v15.8h, w7
clz	w7, w7
sub	w8, w7, #0xb
sub	w7, w7, #0x19
neg	w8, w8
dup	v14.4s, w7
dup	v13.4s, w8
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #0x8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #0x6
adrp	x11, mc_warp_filter+512
add	x11, x11, :lo12:mc_warp_filter+512
mov	x15, x30
bl	warp_filter_horz_neon
uzp1	v24.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v25.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v26.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v27.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v28.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v29.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v30.8h, v16.8h, v17.8h
L_7a54:
add	w14, w6, #0x200
bl	warp_filter_horz_neon
uzp1	v31.8h, v16.8h, v17.8h
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
srshl	v16.4s, v16.4s, v13.4s
srshl	v17.4s, v17.4s, v13.4s
mov	v26.16b, v27.16b
sqxtun	v16.4h, v16.4s
sqxtun2	v16.8h, v17.4s
mov	v27.16b, v28.16b
mov	v28.16b, v29.16b
umin	v16.8h, v16.8h, v15.8h
mov	v29.16b, v30.16b
mov	v30.16b, v31.16b
subs	w10, w10, #0x1
st1	{ v16.8h }, [x0], x1
add	w6, w6, w4
b.gt	L_7a54
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x15
warp_affine_8x8t_16bpc_neon:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
movi	v15.8h, #0x20, lsl #8
clz	w7, w7
sub	w7, w7, #0x19
dup	v14.4s, w7
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #0x8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #0x6
adrp	x11, mc_warp_filter+512
add	x11, x11, :lo12:mc_warp_filter+512
mov	x15, x30
lsl	x1, x1, #1
bl	warp_filter_horz_neon
uzp1	v24.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v25.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v26.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v27.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v28.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v29.8h, v16.8h, v17.8h
bl	warp_filter_horz_neon
uzp1	v30.8h, v16.8h, v17.8h
L_7c30:
add	w14, w6, #0x200
bl	warp_filter_horz_neon
uzp1	v31.8h, v16.8h, v17.8h
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
rshrn	v16.4h, v16.4s, #0x7
rshrn2	v16.8h, v17.4s, #0x7
mov	v26.16b, v27.16b
sub	v16.8h, v16.8h, v15.8h
mov	v27.16b, v28.16b
mov	v28.16b, v29.16b
mov	v29.16b, v30.16b
mov	v30.16b, v31.16b
subs	w10, w10, #0x1
st1	{ v16.8h }, [x0], x1
add	w6, w6, w4
b.gt	L_7c30
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x15
emu_edge_16bpc_neon:
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
add	x8, x8, x13, lsl #1
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
cbz	x4, L_7e88
cbz	x11, L_7ee4
L_7e14:
ld1r	{ v0.8h }, [x8]
mov	x12, x6
mov	x3, x4
mov	v1.16b, v0.16b
L_7e24:
subs	x3, x3, #0x10
st1	{ v0.8h, v1.8h }, [x12], #32
b.gt	L_7e24
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
L_7e3c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x13], #64
subs	x3, x3, #0x20
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x12], #64
b.gt	L_7e3c
add	x3, x8, x2, lsl #1
sub	x3, x3, #0x2
add	x12, x6, x4, lsl #1
ld1r	{ v0.8h }, [x3]
add	x12, x12, x2, lsl #1
mov	x3, x11
mov	v1.16b, v0.16b
L_7e68:
subs	x3, x3, #0x10
st1	{ v0.8h, v1.8h }, [x12], #32
b.gt	L_7e68
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_7e14
b	L_7f5c
L_7e88:
cbz	x11, L_7f30
L_7e8c:
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
L_7e98:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x13], #64
subs	x3, x3, #0x20
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x12], #64
b.gt	L_7e98
add	x3, x8, x2, lsl #1
sub	x3, x3, #0x2
add	x12, x6, x4, lsl #1
ld1r	{ v0.8h }, [x3]
add	x12, x12, x2, lsl #1
mov	x3, x11
mov	v1.16b, v0.16b
L_7ec4:
subs	x3, x3, #0x10
st1	{ v0.8h, v1.8h }, [x12], #32
b.gt	L_7ec4
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_7e8c
b	L_7f5c
L_7ee4:
ld1r	{ v0.8h }, [x8]
mov	x12, x6
mov	x3, x4
mov	v1.16b, v0.16b
L_7ef4:
subs	x3, x3, #0x10
st1	{ v0.8h, v1.8h }, [x12], #32
b.gt	L_7ef4
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
L_7f0c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x13], #64
subs	x3, x3, #0x20
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x12], #64
b.gt	L_7f0c
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_7ee4
b	L_7f5c
L_7f30:
mov	x13, x8
add	x12, x6, x4, lsl #1
mov	x3, x2
L_7f3c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x13], #64
subs	x3, x3, #0x20
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x12], #64
b.gt	L_7f3c
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	L_7f30
L_7f5c:
cbz	x10, L_7f8c
sub	x8, x6, x7
mov	x4, x0
L_7f68:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x8], #64
mov	x3, x10
L_7f70:
subs	x3, x3, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
b.gt	L_7f70
msub	x6, x7, x10, x6
subs	x4, x4, #0x20
add	x6, x6, #0x40
b.gt	L_7f68
L_7f8c:
cbz	x5, L_7fb8
msub	x6, x7, x5, x14
L_7f94:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x14], #64
mov	x3, x5
L_7f9c:
subs	x3, x3, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x7
b.gt	L_7f9c
msub	x6, x7, x5, x6
subs	x0, x0, #0x20
add	x6, x6, #0x40
b.gt	L_7f94
L_7fb8:
ret
	.section *UND*
	.section .rodata
avg_tbl:
	.size avg_tbl, 24
	.word L_278 - avg_tbl
	.word L_1c0 - avg_tbl
	.word L_160 - avg_tbl
	.word L_fc - avg_tbl
	.word L_b8 - avg_tbl
	.word L_6c - avg_tbl
w_avg_tbl:
	.size w_avg_tbl, 24
	.word L_978 - w_avg_tbl
	.word L_7a0 - w_avg_tbl
	.word L_6b0 - w_avg_tbl
	.word L_5bc - w_avg_tbl
	.word L_530 - w_avg_tbl
	.word L_49c - w_avg_tbl
mask_tbl:
	.size mask_tbl, 24
	.word L_1410 - mask_tbl
	.word L_11b8 - mask_tbl
	.word L_1088 - mask_tbl
	.word L_f54 - mask_tbl
	.word L_ea8 - mask_tbl
	.word L_df4 - mask_tbl
w_mask_444_tbl:
	.size w_mask_444_tbl, 24
	.word L_1a84 - w_mask_444_tbl
	.word L_1a84 - w_mask_444_tbl
	.word L_1a84 - w_mask_444_tbl
	.word L_1a84 - w_mask_444_tbl
	.word L_19cc - w_mask_444_tbl
	.word L_190c - w_mask_444_tbl
w_mask_422_tbl:
	.size w_mask_422_tbl, 24
	.word L_1df8 - w_mask_422_tbl
	.word L_1df8 - w_mask_422_tbl
	.word L_1df8 - w_mask_422_tbl
	.word L_1df8 - w_mask_422_tbl
	.word L_1d3c - w_mask_422_tbl
	.word L_1c78 - w_mask_422_tbl
w_mask_420_tbl:
	.size w_mask_420_tbl, 24
	.word L_2184 - w_mask_420_tbl
	.word L_2184 - w_mask_420_tbl
	.word L_2184 - w_mask_420_tbl
	.word L_2184 - w_mask_420_tbl
	.word L_20c4 - w_mask_420_tbl
	.word L_1ff4 - w_mask_420_tbl
blend_tbl:
	.size blend_tbl, 16
	.word L_2448 - blend_tbl
	.word L_23c8 - blend_tbl
	.word L_2374 - blend_tbl
	.word L_2334 - blend_tbl
blend_h_tbl:
	.size blend_h_tbl, 28
	.word L_2630 - blend_h_tbl
	.word L_2630 - blend_h_tbl
	.word L_2630 - blend_h_tbl
	.word L_25c4 - blend_h_tbl
	.word L_2570 - blend_h_tbl
	.word L_2530 - blend_h_tbl
	.word L_24f0 - blend_h_tbl
blend_v_tbl:
	.size blend_v_tbl, 20
	.word L_2878 - blend_v_tbl
	.word L_2804 - blend_v_tbl
	.word L_27b0 - blend_v_tbl
	.word L_2768 - blend_v_tbl
	.word L_2724 - blend_v_tbl
put_16bpc_tbl:
	.size put_16bpc_tbl, 28
	.word L_2a0c - put_16bpc_tbl
	.word L_29d8 - put_16bpc_tbl
	.word L_29a4 - put_16bpc_tbl
	.word L_2980 - put_16bpc_tbl
	.word L_2954 - put_16bpc_tbl
	.word L_2938 - put_16bpc_tbl
	.word L_291c - put_16bpc_tbl
prep_16bpc_tbl:
	.size prep_16bpc_tbl, 24
	.word L_2bc4 - prep_16bpc_tbl
	.word L_2b50 - prep_16bpc_tbl
	.word L_2b14 - prep_16bpc_tbl
	.word L_2ad4 - prep_16bpc_tbl
	.word L_2aa4 - prep_16bpc_tbl
	.word L_2a7c - prep_16bpc_tbl
put_8tap_h_tbl:
	.size put_8tap_h_tbl, 28
	.word L_2e60 - put_8tap_h_tbl
	.word L_2e60 - put_8tap_h_tbl
	.word L_2e60 - put_8tap_h_tbl
	.word L_2e60 - put_8tap_h_tbl
	.word L_2e60 - put_8tap_h_tbl
	.word L_2ddc - put_8tap_h_tbl
	.word L_2d70 - put_8tap_h_tbl
put_8tap_v_tbl:
	.size put_8tap_v_tbl, 28
	.word L_3518 - put_8tap_v_tbl
	.word L_3518 - put_8tap_v_tbl
	.word L_3518 - put_8tap_v_tbl
	.word L_3708 - put_8tap_v_tbl
	.word L_3410 - put_8tap_v_tbl
	.word L_31e0 - put_8tap_v_tbl
	.word L_2fe0 - put_8tap_v_tbl
put_8tap_hv_tbl:
	.size put_8tap_hv_tbl, 28
	.word L_3cfc - put_8tap_hv_tbl
	.word L_3cfc - put_8tap_hv_tbl
	.word L_3b98 - put_8tap_hv_tbl
	.word L_3b98 - put_8tap_hv_tbl
	.word L_3b98 - put_8tap_hv_tbl
	.word L_398c - put_8tap_hv_tbl
	.word L_37e8 - put_8tap_hv_tbl
put_6tap_h_tbl:
	.size put_6tap_h_tbl, 28
	.word L_4164 - put_6tap_h_tbl
	.word L_4164 - put_6tap_h_tbl
	.word L_4164 - put_6tap_h_tbl
	.word L_4164 - put_6tap_h_tbl
	.word L_4164 - put_6tap_h_tbl
	.word L_40e0 - put_6tap_h_tbl
	.word L_4074 - put_6tap_h_tbl
put_6tap_v_tbl:
	.size put_6tap_v_tbl, 28
	.word L_47a4 - put_6tap_v_tbl
	.word L_47a4 - put_6tap_v_tbl
	.word L_47a4 - put_6tap_v_tbl
	.word L_4954 - put_6tap_v_tbl
	.word L_469c - put_6tap_v_tbl
	.word L_449c - put_6tap_v_tbl
	.word L_42b4 - put_6tap_v_tbl
put_6tap_hv_tbl:
	.size put_6tap_hv_tbl, 28
	.word L_4f04 - put_6tap_hv_tbl
	.word L_4f04 - put_6tap_hv_tbl
	.word L_4db8 - put_6tap_hv_tbl
	.word L_4db8 - put_6tap_hv_tbl
	.word L_4db8 - put_6tap_hv_tbl
	.word L_4bd0 - put_6tap_hv_tbl
	.word L_4a34 - put_6tap_hv_tbl
put_bilin_h_tbl:
	.size put_bilin_h_tbl, 28
	.word L_5298 - put_bilin_h_tbl
	.word L_5298 - put_bilin_h_tbl
	.word L_5298 - put_bilin_h_tbl
	.word L_5298 - put_bilin_h_tbl
	.word L_523c - put_bilin_h_tbl
	.word L_51f0 - put_bilin_h_tbl
	.word L_51a4 - put_bilin_h_tbl
put_bilin_v_tbl:
	.size put_bilin_v_tbl, 28
	.word L_54a8 - put_bilin_v_tbl
	.word L_54a8 - put_bilin_v_tbl
	.word L_54a8 - put_bilin_v_tbl
	.word L_54a8 - put_bilin_v_tbl
	.word L_5458 - put_bilin_v_tbl
	.word L_540c - put_bilin_v_tbl
	.word L_5368 - put_bilin_v_tbl
put_bilin_hv_tbl:
	.size put_bilin_hv_tbl, 28
	.word L_5664 - put_bilin_hv_tbl
	.word L_5664 - put_bilin_hv_tbl
	.word L_5664 - put_bilin_hv_tbl
	.word L_5664 - put_bilin_hv_tbl
	.word L_5664 - put_bilin_hv_tbl
	.word L_55e0 - put_bilin_hv_tbl
	.word L_5568 - put_bilin_hv_tbl
prep_8tap_h_tbl:
	.size prep_8tap_h_tbl, 28
	.word L_5894 - prep_8tap_h_tbl
	.word L_5894 - prep_8tap_h_tbl
	.word L_5894 - prep_8tap_h_tbl
	.word L_5894 - prep_8tap_h_tbl
	.word L_5894 - prep_8tap_h_tbl
	.word L_5814 - prep_8tap_h_tbl
	.word L_5814 - prep_8tap_h_tbl
prep_8tap_v_tbl:
	.size prep_8tap_v_tbl, 28
	.word L_5d6c - prep_8tap_v_tbl
	.word L_5d6c - prep_8tap_v_tbl
	.word L_5d6c - prep_8tap_v_tbl
	.word L_5f6c - prep_8tap_v_tbl
	.word L_5c54 - prep_8tap_v_tbl
	.word L_5a10 - prep_8tap_v_tbl
	.word L_5a10 - prep_8tap_v_tbl
prep_8tap_hv_tbl:
	.size prep_8tap_hv_tbl, 28
	.word L_63a0 - prep_8tap_hv_tbl
	.word L_63a0 - prep_8tap_hv_tbl
	.word L_624c - prep_8tap_hv_tbl
	.word L_624c - prep_8tap_hv_tbl
	.word L_624c - prep_8tap_hv_tbl
	.word L_6050 - prep_8tap_hv_tbl
	.word L_6050 - prep_8tap_hv_tbl
prep_6tap_h_tbl:
	.size prep_6tap_h_tbl, 28
	.word L_6784 - prep_6tap_h_tbl
	.word L_6784 - prep_6tap_h_tbl
	.word L_6784 - prep_6tap_h_tbl
	.word L_6784 - prep_6tap_h_tbl
	.word L_6784 - prep_6tap_h_tbl
	.word L_6704 - prep_6tap_h_tbl
	.word L_6704 - prep_6tap_h_tbl
prep_6tap_v_tbl:
	.size prep_6tap_v_tbl, 28
	.word L_6bfc - prep_6tap_v_tbl
	.word L_6bfc - prep_6tap_v_tbl
	.word L_6bfc - prep_6tap_v_tbl
	.word L_6dbc - prep_6tap_v_tbl
	.word L_6ae4 - prep_6tap_v_tbl
	.word L_68d0 - prep_6tap_v_tbl
	.word L_68d0 - prep_6tap_v_tbl
prep_6tap_hv_tbl:
	.size prep_6tap_hv_tbl, 28
	.word L_71b4 - prep_6tap_hv_tbl
	.word L_71b4 - prep_6tap_hv_tbl
	.word L_7078 - prep_6tap_hv_tbl
	.word L_7078 - prep_6tap_hv_tbl
	.word L_7078 - prep_6tap_hv_tbl
	.word L_6ea0 - prep_6tap_hv_tbl
	.word L_6ea0 - prep_6tap_hv_tbl
prep_bilin_h_tbl:
	.size prep_bilin_h_tbl, 28
	.word L_74ec - prep_bilin_h_tbl
	.word L_74ec - prep_bilin_h_tbl
	.word L_74ec - prep_bilin_h_tbl
	.word L_74ec - prep_bilin_h_tbl
	.word L_7490 - prep_bilin_h_tbl
	.word L_7444 - prep_bilin_h_tbl
	.word L_7444 - prep_bilin_h_tbl
prep_bilin_v_tbl:
	.size prep_bilin_v_tbl, 28
	.word L_7668 - prep_bilin_v_tbl
	.word L_7668 - prep_bilin_v_tbl
	.word L_7668 - prep_bilin_v_tbl
	.word L_7668 - prep_bilin_v_tbl
	.word L_7610 - prep_bilin_v_tbl
	.word L_75c0 - prep_bilin_v_tbl
	.word L_75c0 - prep_bilin_v_tbl
prep_bilin_hv_tbl:
	.size prep_bilin_hv_tbl, 28
	.word L_77b8 - prep_bilin_hv_tbl
	.word L_77b8 - prep_bilin_hv_tbl
	.word L_77b8 - prep_bilin_hv_tbl
	.word L_77b8 - prep_bilin_hv_tbl
	.word L_77b8 - prep_bilin_hv_tbl
	.word L_7734 - prep_bilin_hv_tbl
	.word L_7734 - prep_bilin_hv_tbl
