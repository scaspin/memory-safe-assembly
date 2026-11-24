	.text
ipred_dc_128_8bpc_neon:
clz	w3, w3
adrp	x5, ipred_dc_128_tbl
add	x5, x5, :lo12:ipred_dc_128_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
movi	v0.16b, #0x80
add	x5, x5, x3
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_28:
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
b.gt	L_28
ret
L_44:
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
b.gt	L_44
ret
L_60:
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_60
ret
L_7c:
movi	v1.16b, #0x80
L_80:
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
b.gt	L_80
ret
L_9c:
movi	v1.16b, #0x80
movi	v2.16b, #0x80
movi	v3.16b, #0x80
L_a8:
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
b.gt	L_a8
ret
ipred_v_8bpc_neon:
clz	w3, w3
adrp	x5, ipred_v_tbl
add	x5, x5, :lo12:ipred_v_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
add	x2, x2, #0x1
add	x5, x5, x3
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_ec:
ld1	{ v0.s }[0], [x2]
L_f0:
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
b.gt	L_f0
ret
L_10c:
ld1	{ v0.8b }, [x2]
L_110:
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
b.gt	L_110
ret
L_12c:
ld1	{ v0.16b }, [x2]
L_130:
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_130
ret
L_14c:
ld1	{ v0.16b, v1.16b }, [x2]
L_150:
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
b.gt	L_150
ret
L_16c:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
L_170:
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
b.gt	L_170
ret
ipred_h_8bpc_neon:
clz	w3, w3
adrp	x5, ipred_h_tbl
add	x5, x5, :lo12:ipred_h_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
sub	x2, x2, #0x4
add	x5, x5, x3
mov	x7, #-0x4
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_1b8:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
st1	{ v3.s }[0], [x0], x1
st1	{ v2.s }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v1.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
b.gt	L_1b8
ret
L_1d8:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
st1	{ v3.8b }, [x0], x1
st1	{ v2.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v1.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
b.gt	L_1d8
ret
L_1f8:
ld4r	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2], x7
st1	{ v3.16b }, [x0], x1
st1	{ v2.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v1.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_1f8
ret
L_218:
ld4r	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2], x7
str	q3, [x0, #0x10]
str	q2, [x6, #0x10]
st1	{ v3.16b }, [x0], x1
st1	{ v2.16b }, [x6], x1
subs	w4, w4, #0x4
str	q1, [x0, #0x10]
str	q0, [x6, #0x10]
st1	{ v1.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_218
ret
L_248:
ld4r	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2], x7
str	q3, [x0, #0x10]
str	q2, [x6, #0x10]
stp	q3, q3, [x0, #0x20]
stp	q2, q2, [x6, #0x20]
st1	{ v3.16b }, [x0], x1
st1	{ v2.16b }, [x6], x1
subs	w4, w4, #0x4
str	q1, [x0, #0x10]
str	q0, [x6, #0x10]
stp	q1, q1, [x0, #0x20]
stp	q0, q0, [x6, #0x20]
st1	{ v1.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_248
ret
ipred_dc_top_8bpc_neon:
clz	w3, w3
adrp	x5, ipred_dc_top_tbl
add	x5, x5, :lo12:ipred_dc_top_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
add	x2, x2, #0x1
add	x5, x5, x3
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_2b0:
ld1r	{ v0.2s }, [x2]
uaddlv	h0, v0.8b
rshrn	v0.8b, v0.8h, #0x3
dup	v0.8b, v0.b[0]
L_2c0:
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
b.gt	L_2c0
ret
L_2dc:
ld1	{ v0.8b }, [x2]
uaddlv	h0, v0.8b
rshrn	v0.8b, v0.8h, #0x3
dup	v0.8b, v0.b[0]
L_2ec:
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
b.gt	L_2ec
ret
L_308:
ld1	{ v0.16b }, [x2]
uaddlv	h0, v0.16b
rshrn	v0.8b, v0.8h, #0x4
dup	v0.16b, v0.b[0]
L_318:
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_318
ret
L_334:
ld1	{ v0.16b, v1.16b }, [x2]
uaddlv	h0, v0.16b
uaddlv	h1, v1.16b
add	v2.4h, v0.4h, v1.4h
rshrn	v2.8b, v2.8h, #0x5
dup	v0.16b, v2.b[0]
dup	v1.16b, v2.b[0]
L_350:
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
b.gt	L_350
ret
L_36c:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
uaddlv	h0, v0.16b
uaddlv	h1, v1.16b
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
add	v4.4h, v0.4h, v1.4h
add	v5.4h, v2.4h, v3.4h
add	v4.4h, v4.4h, v5.4h
rshrn	v4.8b, v4.8h, #0x6
dup	v0.16b, v4.b[0]
dup	v1.16b, v4.b[0]
dup	v2.16b, v4.b[0]
dup	v3.16b, v4.b[0]
L_3a0:
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
b.gt	L_3a0
ret
ipred_dc_left_8bpc_neon:
sub	x2, x2, w4, uxtw
clz	w3, w3
clz	w7, w4
adrp	x5, ipred_dc_left_tbl
add	x5, x5, :lo12:ipred_dc_left_tbl
sub	w3, w3, #0x14
sub	w7, w7, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
ldrsw	x7, [x5, w7, uxtw #2]
add	x3, x5, x3
add	x5, x5, x7
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_3f4:
ld1r	{ v0.2s }, [x2]
uaddlv	h0, v0.8b
rshrn	v0.8b, v0.8h, #0x3
dup	v0.16b, v0.b[0]
br	x3
L_408:
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
b.gt	L_408
ret
L_424:
ld1	{ v0.8b }, [x2]
uaddlv	h0, v0.8b
rshrn	v0.8b, v0.8h, #0x3
dup	v0.16b, v0.b[0]
br	x3
L_438:
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
b.gt	L_438
ret
L_454:
ld1	{ v0.16b }, [x2]
uaddlv	h0, v0.16b
rshrn	v0.8b, v0.8h, #0x4
dup	v0.16b, v0.b[0]
br	x3
L_468:
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_468
ret
L_484:
ld1	{ v0.16b, v1.16b }, [x2]
uaddlv	h0, v0.16b
uaddlv	h1, v1.16b
add	v0.4h, v0.4h, v1.4h
rshrn	v0.8b, v0.8h, #0x5
dup	v0.16b, v0.b[0]
br	x3
L_4a0:
mov	v1.16b, v0.16b
L_4a4:
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
b.gt	L_4a4
ret
L_4c0:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
uaddlv	h0, v0.16b
uaddlv	h1, v1.16b
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
add	v0.4h, v0.4h, v1.4h
add	v2.4h, v2.4h, v3.4h
add	v0.4h, v0.4h, v2.4h
rshrn	v0.8b, v0.8h, #0x6
dup	v0.16b, v0.b[0]
br	x3
L_4ec:
mov	v1.16b, v0.16b
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
L_4f8:
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
b.gt	L_4f8
ret
ipred_dc_8bpc_neon:
sub	x2, x2, w4, uxtw
add	w7, w3, w4
clz	w3, w3
clz	w6, w4
dup	v16.8h, w7
adrp	x5, ipred_dc_tbl
add	x5, x5, :lo12:ipred_dc_tbl
rbit	w7, w7
sub	w3, w3, #0x14
sub	w6, w6, #0x19
clz	w7, w7
ldrsw	x3, [x5, w3, uxtw #2]
ldrsw	x6, [x5, w6, uxtw #2]
neg	w7, w7
add	x3, x5, x3
add	x5, x5, x6
ushr	v16.8h, v16.8h, #0x1
dup	v17.8h, w7
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_568:
ld1	{ v0.s }[0], [x2], #4
mov	v0.s[1], wzr
uaddlv	h0, v0.8b
add	x2, x2, #0x1
br	x3
L_57c:
ld1	{ v1.s }[0], [x2]
mov	v1.s[1], wzr
add	v0.4h, v0.4h, v16.4h
uaddlv	h1, v1.8b
cmp	w4, #0x4
add	v0.4h, v0.4h, v1.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_5b4
mov	w16, #0x199a
movk	w16, #0x2aab, lsl #16
add	w17, w4, w4
lsr	w16, w16, w17
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_5b4:
dup	v0.8b, v0.b[0]
L_5b8:
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v0.s }[0], [x0], x1
st1	{ v0.s }[0], [x6], x1
b.gt	L_5b8
ret
L_5d4:
ld1	{ v0.8b }, [x2], #8
uaddlv	h0, v0.8b
add	x2, x2, #0x1
br	x3
L_5e4:
ld1	{ v1.8b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h1, v1.8b
cmp	w4, #0x8
add	v0.4h, v0.4h, v1.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_618
cmp	w4, #0x20
mov	w16, #0x199a
mov	w17, #0x2aab
csel	w16, w16, w17, eq
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_618:
dup	v0.8b, v0.b[0]
L_61c:
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8b }, [x0], x1
st1	{ v0.8b }, [x6], x1
b.gt	L_61c
ret
L_638:
ld1	{ v0.16b }, [x2], #16
uaddlv	h0, v0.16b
add	x2, x2, #0x1
br	x3
L_648:
ld1	{ v1.16b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h1, v1.16b
cmp	w4, #0x10
add	v0.4h, v0.4h, v1.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_67c
tst	w4, #0x38
mov	w16, #0x199a
mov	w17, #0x2aab
csel	w16, w16, w17, eq
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_67c:
dup	v0.16b, v0.b[0]
L_680:
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b }, [x0], x1
st1	{ v0.16b }, [x6], x1
b.gt	L_680
ret
L_69c:
ld1	{ v0.16b, v1.16b }, [x2], #32
uaddlv	h0, v0.16b
uaddlv	h1, v1.16b
add	x2, x2, #0x1
add	v0.4h, v0.4h, v1.4h
br	x3
L_6b4:
ld1	{ v1.16b, v2.16b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h1, v1.16b
uaddlv	h2, v2.16b
cmp	w4, #0x20
add	v0.4h, v0.4h, v1.4h
add	v0.4h, v0.4h, v2.4h
ushl	v4.4h, v0.4h, v17.4h
b.eq	L_6f0
cmp	w4, #0x8
mov	w16, #0x199a
mov	w17, #0x2aab
csel	w16, w16, w17, eq
dup	v16.4h, w16
sqdmulh	v4.4h, v4.4h, v16.4h
L_6f0:
dup	v0.16b, v4.b[0]
dup	v1.16b, v4.b[0]
L_6f8:
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b }, [x0], x1
st1	{ v0.16b, v1.16b }, [x6], x1
b.gt	L_6f8
ret
L_714:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2], #64
uaddlv	h0, v0.16b
uaddlv	h1, v1.16b
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
add	v0.4h, v0.4h, v1.4h
add	v2.4h, v2.4h, v3.4h
add	x2, x2, #0x1
add	v0.4h, v0.4h, v2.4h
br	x3
L_73c:
ld1	{ v1.16b, v2.16b, v3.16b, v4.16b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h1, v1.16b
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
uaddlv	h4, v4.16b
add	v1.4h, v1.4h, v2.4h
add	v3.4h, v3.4h, v4.4h
cmp	w4, #0x40
add	v0.4h, v0.4h, v1.4h
add	v0.4h, v0.4h, v3.4h
ushl	v4.4h, v0.4h, v17.4h
b.eq	L_784
mov	w16, #0x2aab
movk	w16, #0x199a, lsl #16
lsr	w16, w16, w4
dup	v16.4h, w16
sqdmulh	v4.4h, v4.4h, v16.4h
L_784:
dup	v0.16b, v4.b[0]
dup	v1.16b, v4.b[0]
dup	v2.16b, v4.b[0]
dup	v3.16b, v4.b[0]
L_794:
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x6], x1
b.gt	L_794
ret
ipred_paeth_8bpc_neon:
clz	w9, w3
adrp	x5, ipred_paeth_tbl
add	x5, x5, :lo12:ipred_paeth_tbl
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v4.16b }, [x2]
add	x8, x2, #0x1
sub	x2, x2, #0x4
add	x5, x5, x9
mov	x7, #-0x4
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_7e4:
ld1r	{ v5.4s }, [x8]
usubl	v6.8h, v5.8b, v4.8b
L_7ec:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
zip1	v0.2s, v0.2s, v1.2s
zip1	v2.2s, v2.2s, v3.2s
uaddw	v16.8h, v6.8h, v0.8b
uaddw	v17.8h, v6.8h, v2.8b
sqxtun	v16.8b, v16.8h
sqxtun2	v16.16b, v17.8h
zip1	v0.2d, v0.2d, v2.2d
uabd	v20.16b, v5.16b, v16.16b
uabd	v22.16b, v4.16b, v16.16b
uabd	v16.16b, v0.16b, v16.16b
umin	v18.16b, v20.16b, v22.16b
cmhs	v20.16b, v22.16b, v20.16b
cmhs	v16.16b, v18.16b, v16.16b
bsl	v20.16b, v5.16b, v4.16b
bit	v20.16b, v0.16b, v16.16b
st1	{ v20.s }[3], [x0], x1
st1	{ v20.s }[2], [x6], x1
subs	w4, w4, #0x4
st1	{ v20.s }[1], [x0], x1
st1	{ v20.s }[0], [x6], x1
b.gt	L_7ec
ret
L_848:
ld1r	{ v5.2d }, [x8]
usubl	v6.8h, v5.8b, v4.8b
L_850:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
uaddw	v16.8h, v6.8h, v0.8b
uaddw	v17.8h, v6.8h, v1.8b
uaddw	v18.8h, v6.8h, v2.8b
uaddw	v19.8h, v6.8h, v3.8b
sqxtun	v16.8b, v16.8h
sqxtun2	v16.16b, v17.8h
sqxtun	v18.8b, v18.8h
sqxtun2	v18.16b, v19.8h
zip1	v2.2d, v2.2d, v3.2d
zip1	v0.2d, v0.2d, v1.2d
uabd	v21.16b, v5.16b, v18.16b
uabd	v20.16b, v5.16b, v16.16b
uabd	v23.16b, v4.16b, v18.16b
uabd	v22.16b, v4.16b, v16.16b
uabd	v17.16b, v2.16b, v18.16b
uabd	v16.16b, v0.16b, v16.16b
umin	v19.16b, v21.16b, v23.16b
umin	v18.16b, v20.16b, v22.16b
cmhs	v21.16b, v23.16b, v21.16b
cmhs	v20.16b, v22.16b, v20.16b
cmhs	v17.16b, v19.16b, v17.16b
cmhs	v16.16b, v18.16b, v16.16b
bsl	v21.16b, v5.16b, v4.16b
bsl	v20.16b, v5.16b, v4.16b
bit	v21.16b, v2.16b, v17.16b
bit	v20.16b, v0.16b, v16.16b
st1	{ v21.d }[1], [x0], x1
st1	{ v21.d }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v20.d }[1], [x0], x1
st1	{ v20.d }[0], [x6], x1
b.gt	L_850
ret
L_8d8:
ld1	{ v5.16b }, [x8], #16
mov	w9, w3
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
L_8f0:
ld4r	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2], x7
L_8f4:
usubl	v6.8h, v5.8b, v4.8b
usubl2	v7.8h, v5.16b, v4.16b
uaddw	v24.8h, v6.8h, v0.8b
uaddw	v25.8h, v7.8h, v0.8b
uaddw	v26.8h, v6.8h, v1.8b
uaddw	v27.8h, v7.8h, v1.8b
uaddw	v28.8h, v6.8h, v2.8b
uaddw	v29.8h, v7.8h, v2.8b
uaddw	v30.8h, v6.8h, v3.8b
uaddw	v31.8h, v7.8h, v3.8b
sqxtun	v17.8b, v26.8h
sqxtun2	v17.16b, v27.8h
sqxtun	v16.8b, v24.8h
sqxtun2	v16.16b, v25.8h
sqxtun	v19.8b, v30.8h
sqxtun2	v19.16b, v31.8h
sqxtun	v18.8b, v28.8h
sqxtun2	v18.16b, v29.8h
uabd	v23.16b, v5.16b, v19.16b
uabd	v22.16b, v5.16b, v18.16b
uabd	v21.16b, v5.16b, v17.16b
uabd	v20.16b, v5.16b, v16.16b
uabd	v27.16b, v4.16b, v19.16b
uabd	v26.16b, v4.16b, v18.16b
uabd	v25.16b, v4.16b, v17.16b
uabd	v24.16b, v4.16b, v16.16b
uabd	v19.16b, v3.16b, v19.16b
uabd	v18.16b, v2.16b, v18.16b
uabd	v17.16b, v1.16b, v17.16b
uabd	v16.16b, v0.16b, v16.16b
umin	v31.16b, v23.16b, v27.16b
umin	v30.16b, v22.16b, v26.16b
umin	v29.16b, v21.16b, v25.16b
umin	v28.16b, v20.16b, v24.16b
cmhs	v23.16b, v27.16b, v23.16b
cmhs	v22.16b, v26.16b, v22.16b
cmhs	v21.16b, v25.16b, v21.16b
cmhs	v20.16b, v24.16b, v20.16b
cmhs	v19.16b, v31.16b, v19.16b
cmhs	v18.16b, v30.16b, v18.16b
cmhs	v17.16b, v29.16b, v17.16b
cmhs	v16.16b, v28.16b, v16.16b
bsl	v23.16b, v5.16b, v4.16b
bsl	v22.16b, v5.16b, v4.16b
bsl	v21.16b, v5.16b, v4.16b
bsl	v20.16b, v5.16b, v4.16b
bit	v23.16b, v3.16b, v19.16b
bit	v22.16b, v2.16b, v18.16b
bit	v21.16b, v1.16b, v17.16b
bit	v20.16b, v0.16b, v16.16b
subs	w3, w3, #0x10
st1	{ v23.16b }, [x0], #16
st1	{ v22.16b }, [x6], #16
st1	{ v21.16b }, [x5], #16
st1	{ v20.16b }, [x10], #16
b.le	L_9dc
ld1	{ v5.16b }, [x8], #16
b	L_8f4
L_9dc:
subs	w4, w4, #0x4
b.le	L_a04
sub	x8, x8, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
ld1	{ v5.16b }, [x8], #16
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	L_8f0
L_a04:
ret
ipred_smooth_8bpc_neon:
adrp	x10, sm_weights
add	x10, x10, :lo12:sm_weights
add	x11, x10, w4, uxtw
add	x10, x10, w3, uxtw
clz	w9, w3
adrp	x5, ipred_smooth_tbl
add	x5, x5, :lo12:ipred_smooth_tbl
sub	x12, x2, w4, uxtw
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v4.16b }, [x12]
add	x8, x2, #0x1
add	x5, x5, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_a48:
ld1r	{ v6.2s }, [x8]
ld1r	{ v7.2s }, [x10]
sub	x2, x2, #0x4
mov	x7, #-0x4
dup	v5.16b, v6.b[3]
usubl	v6.8h, v6.8b, v4.8b
ushll	v7.8h, v7.8b, #0x0
L_a64:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x11], #4
shll	v20.8h, v5.8b, #8
shll	v21.8h, v5.8b, #8
zip1	v1.2s, v1.2s, v0.2s
zip1	v0.2s, v3.2s, v2.2s
zip1	v16.2s, v16.2s, v17.2s
zip1	v18.2s, v18.2s, v19.2s
shll	v22.8h, v4.8b, #8
shll	v23.8h, v4.8b, #8
usubl	v0.8h, v0.8b, v5.8b
usubl	v1.8h, v1.8b, v5.8b
ushll	v16.8h, v16.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mla	v20.8h, v0.8h, v7.8h
mla	v21.8h, v1.8h, v7.8h
mla	v22.8h, v6.8h, v16.8h
mla	v23.8h, v6.8h, v18.8h
uhadd	v20.8h, v20.8h, v22.8h
uhadd	v21.8h, v21.8h, v23.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn	v21.8b, v21.8h, #0x8
st1	{ v20.s }[0], [x0], x1
st1	{ v20.s }[1], [x6], x1
subs	w4, w4, #0x4
st1	{ v21.s }[0], [x0], x1
st1	{ v21.s }[1], [x6], x1
b.gt	L_a64
ret
L_ad8:
ld1	{ v6.8b }, [x8]
ld1	{ v7.8b }, [x10]
sub	x2, x2, #0x4
mov	x7, #-0x4
dup	v5.16b, v6.b[7]
usubl	v6.8h, v6.8b, v4.8b
ushll	v7.8h, v7.8b, #0x0
L_af4:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x11], #4
shll	v20.8h, v5.8b, #8
shll	v21.8h, v5.8b, #8
shll	v22.8h, v5.8b, #8
shll	v23.8h, v5.8b, #8
usubl	v0.8h, v0.8b, v5.8b
usubl	v1.8h, v1.8b, v5.8b
usubl	v2.8h, v2.8b, v5.8b
usubl	v3.8h, v3.8b, v5.8b
shll	v24.8h, v4.8b, #8
shll	v25.8h, v4.8b, #8
shll	v26.8h, v4.8b, #8
shll	v27.8h, v4.8b, #8
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
mla	v20.8h, v3.8h, v7.8h
mla	v21.8h, v2.8h, v7.8h
mla	v22.8h, v1.8h, v7.8h
mla	v23.8h, v0.8h, v7.8h
mla	v24.8h, v6.8h, v16.8h
mla	v25.8h, v6.8h, v17.8h
mla	v26.8h, v6.8h, v18.8h
mla	v27.8h, v6.8h, v19.8h
uhadd	v20.8h, v20.8h, v24.8h
uhadd	v21.8h, v21.8h, v25.8h
uhadd	v22.8h, v22.8h, v26.8h
uhadd	v23.8h, v23.8h, v27.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn	v21.8b, v21.8h, #0x8
rshrn	v22.8b, v22.8h, #0x8
rshrn	v23.8b, v23.8h, #0x8
st1	{ v20.8b }, [x0], x1
st1	{ v21.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x6], x1
b.gt	L_af4
ret
L_b98:
add	x12, x2, w3, uxtw
sub	x2, x2, #0x2
mov	x7, #-0x2
ld1r	{ v5.16b }, [x12]
sub	x1, x1, w3, uxtw
mov	w9, w3
L_bb0:
ld2r	{ v0.8b, v1.8b }, [x2], x7
ld2r	{ v16.8b, v17.8b }, [x11], #2
usubl	v0.8h, v0.8b, v5.8b
usubl	v1.8h, v1.8b, v5.8b
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
L_bc8:
ld1	{ v7.16b }, [x10], #16
ld1	{ v3.16b }, [x8], #16
shll	v20.8h, v5.8b, #8
shll	v21.8h, v5.8b, #8
shll	v22.8h, v5.8b, #8
shll	v23.8h, v5.8b, #8
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
usubl	v2.8h, v3.8b, v4.8b
usubl2	v3.8h, v3.16b, v4.16b
mla	v20.8h, v1.8h, v6.8h
mla	v21.8h, v1.8h, v7.8h
mla	v22.8h, v0.8h, v6.8h
mla	v23.8h, v0.8h, v7.8h
shll	v24.8h, v4.8b, #8
shll	v25.8h, v4.8b, #8
shll	v26.8h, v4.8b, #8
shll	v27.8h, v4.8b, #8
mla	v24.8h, v2.8h, v16.8h
mla	v25.8h, v3.8h, v16.8h
mla	v26.8h, v2.8h, v17.8h
mla	v27.8h, v3.8h, v17.8h
uhadd	v20.8h, v20.8h, v24.8h
uhadd	v21.8h, v21.8h, v25.8h
uhadd	v22.8h, v22.8h, v26.8h
uhadd	v23.8h, v23.8h, v27.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn2	v20.16b, v21.8h, #0x8
rshrn	v22.8b, v22.8h, #0x8
rshrn2	v22.16b, v23.8h, #0x8
subs	w3, w3, #0x10
st1	{ v20.16b }, [x0], #16
st1	{ v22.16b }, [x6], #16
b.gt	L_bc8
subs	w4, w4, #0x2
b.le	L_c70
sub	x8, x8, w9, uxtw
sub	x10, x10, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	L_bb0
L_c70:
ret
ipred_smooth_v_8bpc_neon:
adrp	x7, sm_weights
add	x7, x7, :lo12:sm_weights
add	x7, x7, w4, uxtw
clz	w9, w3
adrp	x5, ipred_smooth_v_tbl
add	x5, x5, :lo12:ipred_smooth_v_tbl
sub	x8, x2, w4, uxtw
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v4.16b }, [x8]
add	x2, x2, #0x1
add	x5, x5, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_cb0:
ld1r	{ v6.2s }, [x2]
usubl	v6.8h, v6.8b, v4.8b
L_cb8:
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x7], #4
shll	v22.8h, v4.8b, #8
shll	v23.8h, v4.8b, #8
zip1	v16.2s, v16.2s, v17.2s
zip1	v18.2s, v18.2s, v19.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mla	v22.8h, v6.8h, v16.8h
mla	v23.8h, v6.8h, v18.8h
rshrn	v22.8b, v22.8h, #0x8
rshrn	v23.8b, v23.8h, #0x8
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x6], x1
subs	w4, w4, #0x4
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x6], x1
b.gt	L_cb8
ret
L_d00:
ld1	{ v6.8b }, [x2]
usubl	v6.8h, v6.8b, v4.8b
L_d08:
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x7], #4
shll	v24.8h, v4.8b, #8
shll	v25.8h, v4.8b, #8
shll	v26.8h, v4.8b, #8
shll	v27.8h, v4.8b, #8
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
mla	v24.8h, v6.8h, v16.8h
mla	v25.8h, v6.8h, v17.8h
mla	v26.8h, v6.8h, v18.8h
mla	v27.8h, v6.8h, v19.8h
rshrn	v24.8b, v24.8h, #0x8
rshrn	v25.8b, v25.8h, #0x8
rshrn	v26.8b, v26.8h, #0x8
rshrn	v27.8b, v27.8h, #0x8
st1	{ v24.8b }, [x0], x1
st1	{ v25.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v26.8b }, [x0], x1
st1	{ v27.8b }, [x6], x1
b.gt	L_d08
ret
L_d68:
add	x5, x0, x1
add	x8, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
mov	w9, w3
L_d7c:
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x7], #4
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
L_d90:
ld1	{ v3.16b }, [x2], #16
shll	v20.8h, v4.8b, #8
shll	v21.8h, v4.8b, #8
shll	v22.8h, v4.8b, #8
shll	v23.8h, v4.8b, #8
shll	v24.8h, v4.8b, #8
shll	v25.8h, v4.8b, #8
shll	v26.8h, v4.8b, #8
shll	v27.8h, v4.8b, #8
usubl	v2.8h, v3.8b, v4.8b
usubl2	v3.8h, v3.16b, v4.16b
mla	v20.8h, v2.8h, v16.8h
mla	v21.8h, v3.8h, v16.8h
mla	v22.8h, v2.8h, v17.8h
mla	v23.8h, v3.8h, v17.8h
mla	v24.8h, v2.8h, v18.8h
mla	v25.8h, v3.8h, v18.8h
mla	v26.8h, v2.8h, v19.8h
mla	v27.8h, v3.8h, v19.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn2	v20.16b, v21.8h, #0x8
rshrn	v22.8b, v22.8h, #0x8
rshrn2	v22.16b, v23.8h, #0x8
rshrn	v24.8b, v24.8h, #0x8
rshrn2	v24.16b, v25.8h, #0x8
rshrn	v26.8b, v26.8h, #0x8
rshrn2	v26.16b, v27.8h, #0x8
subs	w3, w3, #0x10
st1	{ v20.16b }, [x0], #16
st1	{ v22.16b }, [x6], #16
st1	{ v24.16b }, [x5], #16
st1	{ v26.16b }, [x8], #16
b.gt	L_d90
subs	w4, w4, #0x4
b.le	L_e38
sub	x2, x2, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x8, x8, x1
mov	w3, w9
b	L_d7c
L_e38:
ret
ipred_smooth_h_8bpc_neon:
adrp	x8, sm_weights
add	x8, x8, :lo12:sm_weights
add	x8, x8, w3, uxtw
clz	w9, w3
adrp	x5, ipred_smooth_h_tbl
add	x5, x5, :lo12:ipred_smooth_h_tbl
add	x12, x2, w3, uxtw
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v5.16b }, [x12]
add	x5, x5, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_e74:
ld1r	{ v7.2s }, [x8]
sub	x2, x2, #0x4
mov	x7, #-0x4
ushll	v7.8h, v7.8b, #0x0
L_e84:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
shll	v20.8h, v5.8b, #8
shll	v21.8h, v5.8b, #8
zip1	v1.2s, v1.2s, v0.2s
zip1	v0.2s, v3.2s, v2.2s
usubl	v0.8h, v0.8b, v5.8b
usubl	v1.8h, v1.8b, v5.8b
mla	v20.8h, v0.8h, v7.8h
mla	v21.8h, v1.8h, v7.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn	v21.8b, v21.8h, #0x8
st1	{ v20.s }[0], [x0], x1
st1	{ v20.s }[1], [x6], x1
subs	w4, w4, #0x4
st1	{ v21.s }[0], [x0], x1
st1	{ v21.s }[1], [x6], x1
b.gt	L_e84
ret
L_ecc:
ld1	{ v7.8b }, [x8]
sub	x2, x2, #0x4
mov	x7, #-0x4
ushll	v7.8h, v7.8b, #0x0
L_edc:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
shll	v20.8h, v5.8b, #8
shll	v21.8h, v5.8b, #8
shll	v22.8h, v5.8b, #8
shll	v23.8h, v5.8b, #8
usubl	v3.8h, v3.8b, v5.8b
usubl	v2.8h, v2.8b, v5.8b
usubl	v1.8h, v1.8b, v5.8b
usubl	v0.8h, v0.8b, v5.8b
mla	v20.8h, v3.8h, v7.8h
mla	v21.8h, v2.8h, v7.8h
mla	v22.8h, v1.8h, v7.8h
mla	v23.8h, v0.8h, v7.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn	v21.8b, v21.8h, #0x8
rshrn	v22.8b, v22.8h, #0x8
rshrn	v23.8b, v23.8h, #0x8
st1	{ v20.8b }, [x0], x1
st1	{ v21.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x6], x1
b.gt	L_edc
ret
L_f3c:
sub	x2, x2, #0x4
mov	x7, #-0x4
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
mov	w9, w3
L_f58:
ld4r	{ v0.8b, v1.8b, v2.8b, v3.8b }, [x2], x7
usubl	v0.8h, v0.8b, v5.8b
usubl	v1.8h, v1.8b, v5.8b
usubl	v2.8h, v2.8b, v5.8b
usubl	v3.8h, v3.8b, v5.8b
L_f6c:
ld1	{ v7.16b }, [x8], #16
shll	v20.8h, v5.8b, #8
shll	v21.8h, v5.8b, #8
shll	v22.8h, v5.8b, #8
shll	v23.8h, v5.8b, #8
shll	v24.8h, v5.8b, #8
shll	v25.8h, v5.8b, #8
shll	v26.8h, v5.8b, #8
shll	v27.8h, v5.8b, #8
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
mla	v20.8h, v3.8h, v6.8h
mla	v21.8h, v3.8h, v7.8h
mla	v22.8h, v2.8h, v6.8h
mla	v23.8h, v2.8h, v7.8h
mla	v24.8h, v1.8h, v6.8h
mla	v25.8h, v1.8h, v7.8h
mla	v26.8h, v0.8h, v6.8h
mla	v27.8h, v0.8h, v7.8h
rshrn	v20.8b, v20.8h, #0x8
rshrn2	v20.16b, v21.8h, #0x8
rshrn	v22.8b, v22.8h, #0x8
rshrn2	v22.16b, v23.8h, #0x8
rshrn	v24.8b, v24.8h, #0x8
rshrn2	v24.16b, v25.8h, #0x8
rshrn	v26.8b, v26.8h, #0x8
rshrn2	v26.16b, v27.8h, #0x8
subs	w3, w3, #0x10
st1	{ v20.16b }, [x0], #16
st1	{ v22.16b }, [x6], #16
st1	{ v24.16b }, [x5], #16
st1	{ v26.16b }, [x10], #16
b.gt	L_f6c
subs	w4, w4, #0x4
b.le	L_1014
sub	x8, x8, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	L_f58
L_1014:
ret
ipred_z1_upsample_edge_8bpc_neon:
adrp	x4, padding_mask
add	x4, x4, :lo12:padding_mask
ld1	{ v0.16b }, [x2]
add	x5, x2, w3, uxtw
sub	x4, x4, w3, uxtw
ld1r	{ v1.16b }, [x5]
ld1	{ v3.16b }, [x4]
movi	v31.8h, #0x9
bit	v0.16b, v1.16b, v3.16b
ext	v4.16b, v0.16b, v1.16b, #0x1
ext	v5.16b, v0.16b, v1.16b, #0x2
ext	v6.16b, v0.16b, v1.16b, #0x3
uaddl	v16.8h, v4.8b, v5.8b
uaddl2	v17.8h, v4.16b, v5.16b
uaddl	v18.8h, v0.8b, v6.8b
uaddl2	v19.8h, v0.16b, v6.16b
mul	v16.8h, v16.8h, v31.8h
mul	v17.8h, v17.8h, v31.8h
sub	v16.8h, v16.8h, v18.8h
sub	v17.8h, v17.8h, v19.8h
sqrshrun	v16.8b, v16.8h, #0x4
sqrshrun2	v16.16b, v17.8h, #0x4
zip1	v0.16b, v4.16b, v16.16b
zip2	v1.16b, v4.16b, v16.16b
st1	{ v0.16b, v1.16b }, [x0]
ret
ipred_z2_upsample_edge_8bpc_neon:
adrp	x4, padding_mask
add	x4, x4, :lo12:padding_mask
ld1	{ v0.16b }, [x2]
add	x5, x2, w1, uxtw
sub	x4, x4, w1, uxtw
ld1r	{ v2.16b }, [x2]
ld1r	{ v1.16b }, [x5]
ld1	{ v3.16b }, [x4]
movi	v31.8h, #0x9
bit	v0.16b, v1.16b, v3.16b
ext	v4.16b, v2.16b, v0.16b, #0xf
ext	v5.16b, v0.16b, v1.16b, #0x1
ext	v6.16b, v0.16b, v1.16b, #0x2
uaddl	v16.8h, v0.8b, v5.8b
uaddl	v18.8h, v4.8b, v6.8b
mul	v16.8h, v16.8h, v31.8h
sub	v16.8h, v16.8h, v18.8h
sqrshrun	v16.8b, v16.8h, #0x4
add	x5, x0, #0x10
zip1	v2.16b, v0.16b, v16.16b
st1	{ v1.b }[0], [x5]
st1	{ v2.16b }, [x0]
ret
ipred_z1_filter_edge_8bpc_neon:
cmp	w4, #0x3
b.eq	L_11b0
adrp	x5, padding_mask_buf+61
add	x5, x5, :lo12:padding_mask_buf+61
add	x5, x5, w4, uxtw #2
ld1	{ v31.h }[0], [x5]
ld1	{ v0.16b }, [x2], #16
dup	v30.16b, v31.b[0]
dup	v31.16b, v31.b[1]
L_1100:
cmp	w3, #0x11
ld1	{ v1.16b }, [x2], #16
b.lt	L_114c
ext	v2.16b, v0.16b, v1.16b, #0x1
ext	v3.16b, v0.16b, v1.16b, #0x2
umull	v4.8h, v0.8b, v30.8b
umlal	v4.8h, v2.8b, v31.8b
umlal	v4.8h, v3.8b, v30.8b
umull2	v5.8h, v0.16b, v30.16b
umlal2	v5.8h, v2.16b, v31.16b
umlal2	v5.8h, v3.16b, v30.16b
subs	w1, w1, #0x10
mov	v0.16b, v1.16b
rshrn	v4.8b, v4.8h, #0x4
rshrn2	v4.16b, v5.8h, #0x4
sub	w3, w3, #0x10
st1	{ v4.16b }, [x0], #16
b.gt	L_1100
ret
L_114c:
adrp	x5, padding_mask
add	x5, x5, :lo12:padding_mask
sub	w6, w3, #0x20
sub	x5, x5, w3, uxtw
add	x6, x2, w6, sxtw
ld1	{ v2.16b }, [x5]
ld1r	{ v1.16b }, [x6]
bit	v0.16b, v1.16b, v2.16b
ext	v2.16b, v0.16b, v1.16b, #0x1
ext	v3.16b, v0.16b, v1.16b, #0x2
umull	v4.8h, v0.8b, v30.8b
umlal	v4.8h, v2.8b, v31.8b
umlal	v4.8h, v3.8b, v30.8b
umull2	v5.8h, v0.16b, v30.16b
umlal2	v5.8h, v2.16b, v31.16b
umlal2	v5.8h, v3.16b, v30.16b
subs	w1, w1, #0x10
rshrn	v4.8b, v4.8h, #0x4
rshrn2	v4.16b, v5.8h, #0x4
st1	{ v4.16b }, [x0], #16
b.le	L_11ac
L_11a0:
subs	w1, w1, #0x10
st1	{ v1.16b }, [x0], #16
b.gt	L_11a0
L_11ac:
ret
L_11b0:
sub	x2, x2, #0x1
movi	v29.16b, #0x2
ld1	{ v0.16b }, [x2], #16
movi	v30.16b, #0x4
movi	v31.16b, #0x4
mov	v0.b[0], v0.b[1]
L_11c8:
cmp	w3, #0x12
ld1	{ v1.16b }, [x2], #16
b.lt	L_122c
ext	v2.16b, v0.16b, v1.16b, #0x1
ext	v3.16b, v0.16b, v1.16b, #0x2
ext	v4.16b, v0.16b, v1.16b, #0x3
ext	v5.16b, v0.16b, v1.16b, #0x4
umull	v6.8h, v0.8b, v29.8b
umlal	v6.8h, v2.8b, v30.8b
umlal	v6.8h, v3.8b, v31.8b
umlal	v6.8h, v4.8b, v30.8b
umlal	v6.8h, v5.8b, v29.8b
umull2	v7.8h, v0.16b, v29.16b
umlal2	v7.8h, v2.16b, v30.16b
umlal2	v7.8h, v3.16b, v31.16b
umlal2	v7.8h, v4.16b, v30.16b
umlal2	v7.8h, v5.16b, v29.16b
subs	w1, w1, #0x10
mov	v0.16b, v1.16b
rshrn	v6.8b, v6.8h, #0x4
rshrn2	v6.16b, v7.8h, #0x4
sub	w3, w3, #0x10
st1	{ v6.16b }, [x0], #16
b.gt	L_11c8
ret
L_122c:
adrp	x5, padding_mask_buf+31
add	x5, x5, :lo12:padding_mask_buf+31
sub	w6, w3, #0x1f
sub	x5, x5, w3, uxtw
add	x6, x2, w6, sxtw
ld1	{ v2.16b, v3.16b }, [x5]
ld1r	{ v28.16b }, [x6]
bit	v0.16b, v28.16b, v2.16b
bit	v1.16b, v28.16b, v3.16b
L_1250:
ext	v2.16b, v0.16b, v1.16b, #0x1
ext	v3.16b, v0.16b, v1.16b, #0x2
ext	v4.16b, v0.16b, v1.16b, #0x3
ext	v5.16b, v0.16b, v1.16b, #0x4
umull	v6.8h, v0.8b, v29.8b
umlal	v6.8h, v2.8b, v30.8b
umlal	v6.8h, v3.8b, v31.8b
umlal	v6.8h, v4.8b, v30.8b
umlal	v6.8h, v5.8b, v29.8b
umull2	v7.8h, v0.16b, v29.16b
umlal2	v7.8h, v2.16b, v30.16b
umlal2	v7.8h, v3.16b, v31.16b
umlal2	v7.8h, v4.16b, v30.16b
umlal2	v7.8h, v5.16b, v29.16b
subs	w1, w1, #0x10
mov	v0.16b, v1.16b
mov	v1.16b, v28.16b
rshrn	v6.8b, v6.8h, #0x4
rshrn2	v6.16b, v7.8h, #0x4
sub	w3, w3, #0x10
st1	{ v6.16b }, [x0], #16
b.le	L_12bc
cmp	w3, #0x0
b.ge	L_1250
L_12b0:
subs	w1, w1, #0x10
st1	{ v1.16b }, [x0], #16
b.gt	L_12b0
L_12bc:
ret
ipred_pixel_set_8bpc_neon:
dup	v0.16b, w1
L_12c4:
subs	w2, w2, #0x10
st1	{ v0.16b }, [x0], #16
b.gt	L_12c4
ret
ipred_z1_fill1_8bpc_neon:
clz	w9, w3
adrp	x8, ipred_z1_fill1_tbl
add	x8, x8, :lo12:ipred_z1_fill1_tbl
sub	w9, w9, #0x19
ldrsw	x9, [x8, w9, uxtw #2]
add	x10, x2, w6, uxtw
add	x8, x8, x9
ld1r	{ v31.16b }, [x10]
mov	w7, w5
mov	w15, #0x40
br	x8
L_1300:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_136c
ldr	d0, [x2, w8, uxtw]
ldr	d2, [x2, w10, uxtw]
dup	v4.4h, w9
dup	v5.4h, w11
ext	v1.8b, v0.8b, v0.8b, #0x1
ext	v3.8b, v2.8b, v2.8b, #0x1
usubl	v6.8h, v1.8b, v0.8b
usubl	v7.8h, v3.8b, v2.8b
ushll	v16.8h, v0.8b, #0x6
ushll	v17.8h, v2.8b, #0x6
mla	v16.4h, v6.4h, v4.4h
mla	v17.4h, v7.4h, v5.4h
rshrn	v16.8b, v16.8h, #0x6
rshrn	v17.8b, v17.8h, #0x6
st1	{ v16.s }[0], [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.s }[0], [x0], x1
b.gt	L_1300
ret
L_136c:
st1	{ v31.s }[0], [x0], x1
subs	w4, w4, #0x2
st1	{ v31.s }[0], [x0], x1
b.gt	L_136c
ret
L_1380:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_13f4
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup	v4.8b, w9
dup	v5.8b, w11
sub	w9, w15, w9
sub	w11, w15, w11
dup	v6.8b, w9
dup	v7.8b, w11
ext	v1.16b, v0.16b, v0.16b, #0x1
ext	v3.16b, v2.16b, v2.16b, #0x1
umull	v16.8h, v0.8b, v6.8b
umlal	v16.8h, v1.8b, v4.8b
umull	v17.8h, v2.8b, v7.8b
umlal	v17.8h, v3.8b, v5.8b
rshrn	v16.8b, v16.8h, #0x6
rshrn	v17.8b, v17.8h, #0x6
st1	{ v16.8b }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.8b }, [x0], x1
b.gt	L_1380
ret
L_13f4:
st1	{ v31.8b }, [x0], x1
subs	w4, w4, #0x2
st1	{ v31.8b }, [x0], x1
b.gt	L_13f4
ret
L_1408:
mov	w12, w3
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
L_1418:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_14d8
add	x8, x2, w8, uxtw
add	x10, x2, w10, uxtw
dup	v4.16b, w9
dup	v5.16b, w11
ld1	{ v0.16b, v1.16b }, [x8], #32
ld1	{ v2.16b, v3.16b }, [x10], #32
sub	w9, w15, w9
sub	w11, w15, w11
dup	v6.16b, w9
dup	v7.16b, w11
add	w7, w7, w5
L_1460:
ext	v16.16b, v0.16b, v1.16b, #0x1
ext	v17.16b, v2.16b, v3.16b, #0x1
subs	w3, w3, #0x10
umull	v18.8h, v0.8b, v6.8b
umlal	v18.8h, v16.8b, v4.8b
umull2	v19.8h, v0.16b, v6.16b
umlal2	v19.8h, v16.16b, v4.16b
umull	v20.8h, v2.8b, v7.8b
umlal	v20.8h, v17.8b, v5.8b
umull2	v21.8h, v2.16b, v7.16b
umlal2	v21.8h, v17.16b, v5.16b
rshrn	v16.8b, v18.8h, #0x6
rshrn2	v16.16b, v19.8h, #0x6
rshrn	v17.8b, v20.8h, #0x6
rshrn2	v17.16b, v21.8h, #0x6
st1	{ v16.16b }, [x0], #16
st1	{ v17.16b }, [x13], #16
b.le	L_14bc
mov	v0.16b, v1.16b
ld1	{ v1.16b }, [x8], #16
mov	v2.16b, v3.16b
ld1	{ v3.16b }, [x10], #16
b	L_1460
L_14bc:
subs	w4, w4, #0x2
b.le	L_14d4
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	L_1418
L_14d4:
ret
L_14d8:
st1	{ v31.16b }, [x0], #16
subs	w3, w3, #0x10
st1	{ v31.16b }, [x13], #16
b.gt	L_14d8
subs	w4, w4, #0x2
b.le	L_14d4
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	L_14d8
ipred_z1_fill2_8bpc_neon:
cmp	w3, #0x8
add	x10, x2, w6, uxtw
ld1r	{ v31.16b }, [x10]
mov	w7, w5
mov	w15, #0x40
b.eq	L_15a0
L_1518:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_158c
ldr	d0, [x2, w8, uxtw]
ldr	d2, [x2, w10, uxtw]
dup	v4.4h, w9
dup	v5.4h, w11
uzp2	v1.8b, v0.8b, v0.8b
uzp1	v0.8b, v0.8b, v0.8b
uzp2	v3.8b, v2.8b, v2.8b
uzp1	v2.8b, v2.8b, v2.8b
usubl	v6.8h, v1.8b, v0.8b
usubl	v7.8h, v3.8b, v2.8b
ushll	v16.8h, v0.8b, #0x6
ushll	v17.8h, v2.8b, #0x6
mla	v16.4h, v6.4h, v4.4h
mla	v17.4h, v7.4h, v5.4h
rshrn	v16.8b, v16.8h, #0x6
rshrn	v17.8b, v17.8h, #0x6
st1	{ v16.s }[0], [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.s }[0], [x0], x1
b.gt	L_1518
ret
L_158c:
st1	{ v31.s }[0], [x0], x1
subs	w4, w4, #0x2
st1	{ v31.s }[0], [x0], x1
b.gt	L_158c
ret
L_15a0:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_161c
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup	v4.8b, w9
dup	v5.8b, w11
sub	w9, w15, w9
sub	w11, w15, w11
dup	v6.8b, w9
dup	v7.8b, w11
uzp2	v1.16b, v0.16b, v0.16b
uzp1	v0.16b, v0.16b, v0.16b
uzp2	v3.16b, v2.16b, v2.16b
uzp1	v2.16b, v2.16b, v2.16b
umull	v16.8h, v1.8b, v4.8b
umlal	v16.8h, v0.8b, v6.8b
umull	v17.8h, v3.8b, v5.8b
umlal	v17.8h, v2.8b, v7.8b
rshrn	v16.8b, v16.8h, #0x6
rshrn	v17.8b, v17.8h, #0x6
st1	{ v16.8b }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.8b }, [x0], x1
b.gt	L_15a0
ret
L_161c:
st1	{ v31.8b }, [x0], x1
subs	w4, w4, #0x2
st1	{ v31.8b }, [x0], x1
b.gt	L_161c
ret
ipred_reverse_8bpc_neon:
sub	x1, x1, #0x10
add	x3, x0, #0x8
mov	x4, #0x10
L_163c:
ld1	{ v0.16b }, [x1]
subs	w2, w2, #0x10
rev64	v0.16b, v0.16b
sub	x1, x1, #0x10
st1	{ v0.d }[1], [x0], x4
st1	{ v0.d }[0], [x3], x4
b.gt	L_163c
ret
ipred_z2_fill1_8bpc_neon:
clz	w10, w4
adrp	x9, ipred_z2_fill1_tbl
add	x9, x9, :lo12:ipred_z2_fill1_tbl
sub	w10, w10, #0x19
ldrsw	x10, [x9, w10, uxtw #2]
mov	w8, #0x40
add	x9, x9, x10
sub	w8, w8, w6
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1	{ v31.8h }, [x11]
neg	w7, w7
br	x9
L_1690:
dup	v30.4h, w7
movi	v17.8b, #0x1
mul	v16.4h, v31.4h, v30.4h
movi	v25.16b, #0x3e
add	v30.4h, v16.4h, v30.4h
xtn	v31.8b, v31.8h
ld1	{ v0.16b, v1.16b }, [x3]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v30.8h
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v27.8b, v25.8b
add	v29.8b, v29.8b, v17.8b
add	v30.8b, v29.8b, v17.8b
add	v28.8b, v29.8b, v19.8b
tbl	v16.8b, { v0.16b }, v29.8b
trn1	v30.2s, v30.2s, v28.2s
sub	v28.8b, v26.8b, v27.8b
trn1	v31.2s, v31.2s, v31.2s
trn1	v27.2s, v27.2s, v27.2s
trn1	v28.2s, v28.2s, v28.2s
movi	v29.8b, #0x2
L_16e8:
asr	w9, w8, #6
dup	v6.4h, w8
sub	w8, w8, w6
cmn	w9, #0x4
asr	w11, w8, #6
b.le	L_177c
dup	v7.4h, w8
ldr	d2, [x2, w9, sxtw]
ldr	d4, [x2, w11, sxtw]
trn1	v6.2d, v6.2d, v7.2d
tbl	v17.8b, { v0.16b }, v30.8b
shrn	v20.8b, v6.8h, #0x6
xtn	v6.8b, v6.8h
ext	v3.8b, v2.8b, v2.8b, #0x1
ext	v5.8b, v4.8b, v4.8b, #0x1
and	v6.8b, v6.8b, v25.8b
trn1	v16.2s, v16.2s, v17.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
sub	v7.8b, v26.8b, v6.8b
add	v20.8b, v20.8b, v31.8b
umull	v16.8h, v16.8b, v28.8b
umlal	v16.8h, v17.8b, v27.8b
umull	v22.8h, v2.8b, v7.8b
umlal	v22.8h, v3.8b, v6.8b
cmge	v20.8b, v20.8b, #0
rshrn	v16.8b, v16.8h, #0x6
rshrn	v22.8b, v22.8h, #0x6
bit	v16.8b, v22.8b, v20.8b
st1	{ v16.s }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v16.s }[1], [x0], x1
b.le	L_17ac
ext	v16.8b, v17.8b, v17.8b, #0x4
add	v30.8b, v30.8b, v29.8b
b	L_16e8
L_177c:
tbl	v17.8b, { v0.16b, v1.16b }, v30.8b
trn1	v16.2s, v16.2s, v17.2s
umull	v18.8h, v16.8b, v28.8b
umlal	v18.8h, v17.8b, v27.8b
rshrn	v18.8b, v18.8h, #0x6
st1	{ v18.s }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v18.s }[1], [x0], x1
b.le	L_17ac
ext	v16.8b, v17.8b, v17.8b, #0x4
add	v30.8b, v30.8b, v29.8b
b	L_177c
L_17ac:
ret
L_17b0:
dup	v30.8h, w7
movi	v17.8b, #0x1
mul	v16.8h, v31.8h, v30.8h
movi	v25.16b, #0x3e
add	v30.8h, v16.8h, v30.8h
xtn	v31.8b, v31.8h
ld1	{ v0.16b, v1.16b, v2.16b }, [x3]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v30.8h
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v27.8b, v25.8b
add	v29.8b, v29.8b, v17.8b
tbl	v18.8b, { v0.16b }, v29.8b
add	v30.8b, v29.8b, v19.8b
add	v29.8b, v29.8b, v17.8b
sub	v28.8b, v26.8b, v27.8b
trn1	v31.2d, v31.2d, v31.2d
movi	v24.8b, #0x2
L_17fc:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x8
asr	w11, w8, #6
b.le	L_18b0
dup	v17.8h, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
tbl	v19.8b, { v0.16b, v1.16b }, v29.8b
shrn	v21.8b, v16.8h, #0x6
shrn2	v21.16b, v17.8h, #0x6
xtn	v16.8b, v16.8h
xtn2	v16.16b, v17.8h
tbl	v20.8b, { v0.16b, v1.16b }, v30.8b
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v7.16b, v6.16b, v6.16b, #0x1
and	v16.16b, v16.16b, v25.16b
trn1	v4.2d, v4.2d, v6.2d
trn1	v5.2d, v5.2d, v7.2d
sub	v7.16b, v26.16b, v16.16b
add	v21.16b, v21.16b, v31.16b
umull	v6.8h, v18.8b, v28.8b
umlal	v6.8h, v19.8b, v27.8b
umull	v17.8h, v19.8b, v28.8b
umlal	v17.8h, v20.8b, v27.8b
umull	v22.8h, v4.8b, v7.8b
umlal	v22.8h, v5.8b, v16.8b
umull2	v23.8h, v4.16b, v7.16b
umlal2	v23.8h, v5.16b, v16.16b
cmge	v21.16b, v21.16b, #0
rshrn	v6.8b, v6.8h, #0x6
rshrn2	v6.16b, v17.8h, #0x6
rshrn	v22.8b, v22.8h, #0x6
rshrn2	v22.16b, v23.8h, #0x6
bit	v6.16b, v22.16b, v21.16b
st1	{ v6.d }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v6.d }[1], [x0], x1
b.le	L_18f0
mov	v18.8b, v20.8b
add	v29.8b, v29.8b, v24.8b
add	v30.8b, v30.8b, v24.8b
b	L_17fc
L_18b0:
tbl	v19.8b, { v0.16b, v1.16b, v2.16b }, v29.8b
tbl	v20.8b, { v0.16b, v1.16b, v2.16b }, v30.8b
umull	v6.8h, v18.8b, v28.8b
umlal	v6.8h, v19.8b, v27.8b
umull	v17.8h, v19.8b, v28.8b
umlal	v17.8h, v20.8b, v27.8b
rshrn	v6.8b, v6.8h, #0x6
rshrn2	v6.16b, v17.8h, #0x6
st1	{ v6.d }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v6.d }[1], [x0], x1
b.le	L_18f0
mov	v18.8b, v20.8b
add	v29.8b, v29.8b, v24.8b
add	v30.8b, v30.8b, v24.8b
b	L_18b0
L_18f0:
ret
L_18f4:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
add	x11, x11, #0x10
dup	v18.8h, w7
movi	v17.16b, #0x1
add	x3, x3, #0x1
ld1	{ v14.8h }, [x11]
mul	v16.8h, v31.8h, v18.8h
mul	v19.8h, v14.8h, v18.8h
movi	v25.16b, #0x3e
add	v16.8h, v16.8h, v18.8h
add	v18.8h, v19.8h, v18.8h
xtn	v31.8b, v31.8h
xtn2	v31.16b, v14.8h
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
ld1r	{ v15.16b }, [x2]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v16.8h
xtn2	v27.16b, v18.8h
shrn	v29.8b, v16.8h, #0x6
shrn2	v29.16b, v18.8h, #0x6
mov	v18.16b, v15.16b
and	v27.16b, v27.16b, v25.16b
tbx	v18.16b, { v0.16b }, v29.16b
add	v30.16b, v29.16b, v19.16b
add	v29.16b, v29.16b, v17.16b
sub	v28.16b, v26.16b, v27.16b
movi	v24.16b, #0x2
L_1970:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x10
asr	w11, w8, #6
b.le	L_1a80
dup	v17.8h, w8
add	x9, x2, w9, sxtw
add	x11, x2, w11, sxtw
ld1	{ v4.16b, v5.16b }, [x9]
mov	v19.16b, v15.16b
ld1	{ v6.16b, v7.16b }, [x11]
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
mov	v20.16b, v15.16b
shrn	v21.8b, v16.8h, #0x6
shrn	v22.8b, v17.8h, #0x6
xtn	v16.8b, v16.8h
xtn	v17.8b, v17.8h
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v30.16b
trn1	v21.2d, v21.2d, v21.2d
trn1	v22.2d, v22.2d, v22.2d
trn1	v16.2d, v16.2d, v16.2d
trn1	v17.2d, v17.2d, v17.2d
ext	v5.16b, v4.16b, v5.16b, #0x1
ext	v7.16b, v6.16b, v7.16b, #0x1
and	v16.16b, v16.16b, v25.16b
and	v17.16b, v17.16b, v25.16b
umull	v10.8h, v18.8b, v28.8b
umlal	v10.8h, v19.8b, v27.8b
sub	v8.16b, v26.16b, v16.16b
sub	v9.16b, v26.16b, v17.16b
umull2	v11.8h, v18.16b, v28.16b
umlal2	v11.8h, v19.16b, v27.16b
add	v21.16b, v21.16b, v31.16b
add	v22.16b, v22.16b, v31.16b
umull	v12.8h, v19.8b, v28.8b
umlal	v12.8h, v20.8b, v27.8b
umull2	v13.8h, v19.16b, v28.16b
umlal2	v13.8h, v20.16b, v27.16b
rshrn	v10.8b, v10.8h, #0x6
rshrn2	v10.16b, v11.8h, #0x6
rshrn	v11.8b, v12.8h, #0x6
rshrn2	v11.16b, v13.8h, #0x6
umull	v12.8h, v4.8b, v8.8b
umlal	v12.8h, v5.8b, v16.8b
umull2	v13.8h, v4.16b, v8.16b
umlal2	v13.8h, v5.16b, v16.16b
umull	v14.8h, v6.8b, v9.8b
umlal	v14.8h, v7.8b, v17.8b
umull2	v18.8h, v6.16b, v9.16b
umlal2	v18.8h, v7.16b, v17.16b
cmge	v21.16b, v21.16b, #0
cmge	v22.16b, v22.16b, #0
rshrn	v12.8b, v12.8h, #0x6
rshrn2	v12.16b, v13.8h, #0x6
rshrn	v13.8b, v14.8h, #0x6
rshrn2	v13.16b, v18.8h, #0x6
bit	v10.16b, v12.16b, v21.16b
bit	v11.16b, v13.16b, v22.16b
st1	{ v10.16b }, [x0], x1
subs	w5, w5, #0x2
sub	w8, w8, w6
st1	{ v11.16b }, [x0], x1
b.le	L_1ae0
mov	v18.16b, v20.16b
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_1970
L_1a80:
mov	v19.16b, v15.16b
mov	v20.16b, v15.16b
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v30.16b
umull	v4.8h, v18.8b, v28.8b
umlal	v4.8h, v19.8b, v27.8b
umull2	v5.8h, v18.16b, v28.16b
umlal2	v5.8h, v19.16b, v27.16b
umull	v6.8h, v19.8b, v28.8b
umlal	v6.8h, v20.8b, v27.8b
umull2	v7.8h, v19.16b, v28.16b
umlal2	v7.8h, v20.16b, v27.16b
rshrn	v4.8b, v4.8h, #0x6
rshrn2	v4.16b, v5.8h, #0x6
rshrn	v5.8b, v6.8h, #0x6
rshrn2	v5.16b, v7.8h, #0x6
st1	{ v4.16b }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.16b }, [x0], x1
b.le	L_1ae0
mov	v18.16b, v20.16b
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_1a80
L_1ae0:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
L_1af4:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
add	x11, x11, #0x10
dup	v25.8h, w7
add	x3, x3, #0x1
ld1	{ v14.8h }, [x11]
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
movi	v11.8h, #0x8
mul	v26.8h, v31.8h, v25.8h
add	v26.8h, v26.8h, v25.8h
mul	v25.8h, v25.8h, v11.8h
xtn	v31.8b, v31.8h
xtn2	v31.16b, v14.8h
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
ld1r	{ v15.16b }, [x2]
mov	w12, w4
neg	w14, w4
L_1b48:
mov	v23.16b, v26.16b
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmp	w9, w14
asr	w11, w8, #6
b.le	L_1d3c
dup	v17.8h, w8
sub	w8, w8, w6
add	x9, x2, w9, sxtw
add	x11, x2, w11, sxtw
sqshrn	v21.8b, v16.8h, #0x6
sqshrn	v22.8b, v17.8h, #0x6
xtn	v16.8b, v16.8h
xtn	v17.8b, v17.8h
ld1	{ v4.16b }, [x9], #16
ld1	{ v6.16b }, [x11], #16
trn1	v21.2d, v21.2d, v21.2d
trn1	v22.2d, v22.2d, v22.2d
trn1	v16.2d, v16.2d, v16.2d
trn1	v17.2d, v17.2d, v17.2d
movi	v10.16b, #0x3e
movi	v11.16b, #0x40
and	v16.16b, v16.16b, v10.16b
and	v17.16b, v17.16b, v10.16b
sub	v8.16b, v11.16b, v16.16b
sub	v9.16b, v11.16b, v17.16b
add	v21.16b, v21.16b, v31.16b
add	v22.16b, v22.16b, v31.16b
L_1bbc:
add	v13.8h, v23.8h, v25.8h
movi	v12.16b, #0x40
movi	v20.16b, #0x2
movi	v10.16b, #0x3e
smov	w10, v22.b[0]
xtn	v27.8b, v23.8h
xtn2	v27.16b, v13.8h
shrn	v29.8b, v23.8h, #0x6
shrn2	v29.16b, v13.8h, #0x6
cmp	w10, #0x0
and	v27.16b, v27.16b, v10.16b
mov	v18.16b, v15.16b
b.ge	L_1ce0
add	v23.8h, v13.8h, v25.8h
movi	v13.16b, #0x1
tbx	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v13.16b
mov	v19.16b, v15.16b
sub	v28.16b, v12.16b, v27.16b
ld1	{ v5.16b }, [x9], #16
ld1	{ v7.16b }, [x11], #16
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v13.16b
mov	v20.16b, v15.16b
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
umull	v10.8h, v18.8b, v28.8b
umlal	v10.8h, v19.8b, v27.8b
umull2	v11.8h, v18.16b, v28.16b
umlal2	v11.8h, v19.16b, v27.16b
umull	v12.8h, v19.8b, v28.8b
umlal	v12.8h, v20.8b, v27.8b
umull2	v13.8h, v19.16b, v28.16b
umlal2	v13.8h, v20.16b, v27.16b
ext	v18.16b, v4.16b, v5.16b, #0x1
ext	v19.16b, v6.16b, v7.16b, #0x1
rshrn	v10.8b, v10.8h, #0x6
rshrn2	v10.16b, v11.8h, #0x6
rshrn	v11.8b, v12.8h, #0x6
rshrn2	v11.16b, v13.8h, #0x6
umull	v12.8h, v4.8b, v8.8b
umlal	v12.8h, v18.8b, v16.8b
umull2	v13.8h, v4.16b, v8.16b
umlal2	v13.8h, v18.16b, v16.16b
umull	v14.8h, v6.8b, v9.8b
umlal	v14.8h, v19.8b, v17.8b
umull2	v20.8h, v6.16b, v9.16b
umlal2	v20.8h, v19.16b, v17.16b
cmge	v18.16b, v21.16b, #0
cmge	v19.16b, v22.16b, #0
rshrn	v12.8b, v12.8h, #0x6
rshrn2	v12.16b, v13.8h, #0x6
rshrn	v13.8b, v14.8h, #0x6
rshrn2	v13.16b, v20.8h, #0x6
bit	v10.16b, v12.16b, v18.16b
bit	v11.16b, v13.16b, v19.16b
st1	{ v10.16b }, [x0], #16
subs	w4, w4, #0x10
st1	{ v11.16b }, [x13], #16
b.le	L_1cc0
movi	v10.16b, #0x10
mov	v4.16b, v5.16b
mov	v6.16b, v7.16b
add	v21.16b, v21.16b, v10.16b
add	v22.16b, v22.16b, v10.16b
b	L_1bbc
L_1cc0:
subs	w5, w5, #0x2
b.le	L_1e04
movi	v10.8h, #0x80
add	x0, x0, x1
add	x13, x13, x1
mov	w4, w12
add	v26.8h, v26.8h, v10.8h
b	L_1b48
L_1ce0:
ld1	{ v5.16b }, [x9], #16
ld1	{ v7.16b }, [x11], #16
ext	v18.16b, v4.16b, v5.16b, #0x1
ext	v19.16b, v6.16b, v7.16b, #0x1
umull	v12.8h, v4.8b, v8.8b
umlal	v12.8h, v18.8b, v16.8b
umull2	v13.8h, v4.16b, v8.16b
umlal2	v13.8h, v18.16b, v16.16b
umull	v14.8h, v6.8b, v9.8b
umlal	v14.8h, v19.8b, v17.8b
umull2	v20.8h, v6.16b, v9.16b
umlal2	v20.8h, v19.16b, v17.16b
rshrn	v12.8b, v12.8h, #0x6
rshrn2	v12.16b, v13.8h, #0x6
rshrn	v13.8b, v14.8h, #0x6
rshrn2	v13.16b, v20.8h, #0x6
st1	{ v12.16b }, [x0], #16
subs	w4, w4, #0x10
st1	{ v13.16b }, [x13], #16
b.le	L_1cc0
mov	v4.16b, v5.16b
mov	v6.16b, v7.16b
b	L_1ce0
L_1d3c:
add	x1, x1, w4, uxtw
mov	w12, w5
L_1d44:
add	v13.8h, v23.8h, v25.8h
movi	v12.16b, #0x40
movi	v10.16b, #0x3e
xtn	v27.8b, v23.8h
xtn2	v27.16b, v13.8h
shrn	v29.8b, v23.8h, #0x6
shrn2	v29.16b, v13.8h, #0x6
and	v27.16b, v27.16b, v10.16b
mov	v18.16b, v15.16b
add	v23.8h, v13.8h, v25.8h
movi	v21.16b, #0x1
tbx	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v21.16b
sub	v28.16b, v12.16b, v27.16b
L_1d7c:
mov	v19.16b, v15.16b
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v21.16b
mov	v20.16b, v15.16b
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v21.16b
umull	v10.8h, v18.8b, v28.8b
umlal	v10.8h, v19.8b, v27.8b
umull2	v11.8h, v18.16b, v28.16b
umlal2	v11.8h, v19.16b, v27.16b
umull	v12.8h, v19.8b, v28.8b
umlal	v12.8h, v20.8b, v27.8b
umull2	v13.8h, v19.16b, v28.16b
umlal2	v13.8h, v20.16b, v27.16b
rshrn	v10.8b, v10.8h, #0x6
rshrn2	v10.16b, v11.8h, #0x6
rshrn	v11.8b, v12.8h, #0x6
rshrn2	v11.16b, v13.8h, #0x6
st1	{ v10.16b }, [x0], x1
subs	w5, w5, #0x2
st1	{ v11.16b }, [x13], x1
b.le	L_1ddc
mov	v18.16b, v20.16b
b	L_1d7c
L_1ddc:
subs	w4, w4, #0x10
b.le	L_1e04
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #0x10
add	x13, x13, #0x10
mov	w5, w12
b	L_1d44
L_1e04:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
ipred_z2_fill2_8bpc_neon:
cmp	w4, #0x8
mov	w8, #0x80
sub	w8, w8, w6
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1	{ v31.8h }, [x11]
neg	w7, w7
b.eq	L_1f54
dup	v30.4h, w7
movi	v17.8b, #0x1
mul	v16.4h, v31.4h, v30.4h
movi	v25.16b, #0x3e
add	v30.4h, v16.4h, v30.4h
xtn	v31.8b, v31.8h
ld1	{ v0.16b }, [x3]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v30.8h
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v27.8b, v25.8b
add	v29.8b, v29.8b, v17.8b
add	v30.8b, v29.8b, v17.8b
add	v28.8b, v29.8b, v19.8b
tbl	v16.8b, { v0.16b }, v29.8b
trn1	v30.2s, v30.2s, v28.2s
sub	v28.8b, v26.8b, v27.8b
trn1	v31.2s, v31.2s, v31.2s
trn1	v27.2s, v27.2s, v27.2s
trn1	v28.2s, v28.2s, v28.2s
movi	v29.8b, #0x2
add	v31.8b, v31.8b, v31.8b
L_1e94:
asr	w9, w8, #6
dup	v6.4h, w8
sub	w8, w8, w6
cmn	w9, #0x8
asr	w11, w8, #6
b.le	L_1f20
dup	v7.4h, w8
ldr	d2, [x2, w9, sxtw]
ldr	d4, [x2, w11, sxtw]
trn1	v6.2d, v6.2d, v7.2d
tbl	v17.8b, { v0.16b }, v30.8b
shrn	v20.8b, v6.8h, #0x6
xtn	v6.8b, v6.8h
uzp2	v3.8b, v2.8b, v4.8b
uzp1	v2.8b, v2.8b, v4.8b
and	v6.8b, v6.8b, v25.8b
trn1	v16.2s, v16.2s, v17.2s
sub	v7.8b, v26.8b, v6.8b
add	v20.8b, v20.8b, v31.8b
umull	v16.8h, v16.8b, v28.8b
umlal	v16.8h, v17.8b, v27.8b
umull	v22.8h, v2.8b, v7.8b
umlal	v22.8h, v3.8b, v6.8b
cmge	v20.8b, v20.8b, #0
rshrn	v16.8b, v16.8h, #0x6
rshrn	v22.8b, v22.8h, #0x6
bit	v16.8b, v22.8b, v20.8b
st1	{ v16.s }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v16.s }[1], [x0], x1
b.le	L_1f50
ext	v16.8b, v17.8b, v17.8b, #0x4
add	v30.8b, v30.8b, v29.8b
b	L_1e94
L_1f20:
tbl	v17.8b, { v0.16b }, v30.8b
trn1	v16.2s, v16.2s, v17.2s
umull	v18.8h, v16.8b, v28.8b
umlal	v18.8h, v17.8b, v27.8b
rshrn	v18.8b, v18.8h, #0x6
st1	{ v18.s }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v18.s }[1], [x0], x1
b.le	L_1f50
ext	v16.8b, v17.8b, v17.8b, #0x4
add	v30.8b, v30.8b, v29.8b
b	L_1f20
L_1f50:
ret
L_1f54:
dup	v30.8h, w7
movi	v17.8b, #0x1
mul	v16.8h, v31.8h, v30.8h
movi	v25.16b, #0x3e
add	v30.8h, v16.8h, v30.8h
xtn	v31.8b, v31.8h
ld1	{ v0.16b }, [x3]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v30.8h
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v27.8b, v25.8b
add	v29.8b, v29.8b, v17.8b
tbl	v18.8b, { v0.16b }, v29.8b
add	v30.8b, v29.8b, v19.8b
add	v29.8b, v29.8b, v17.8b
sub	v28.8b, v26.8b, v27.8b
trn1	v31.2d, v31.2d, v31.2d
movi	v24.8b, #0x2
add	v31.16b, v31.16b, v31.16b
L_1fa4:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x10
asr	w11, w8, #6
b.le	L_2050
dup	v17.8h, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
tbl	v19.8b, { v0.16b }, v29.8b
shrn	v21.8b, v16.8h, #0x6
shrn2	v21.16b, v17.8h, #0x6
xtn	v16.8b, v16.8h
xtn2	v16.16b, v17.8h
tbl	v20.8b, { v0.16b }, v30.8b
uzp2	v5.16b, v4.16b, v6.16b
uzp1	v4.16b, v4.16b, v6.16b
and	v16.16b, v16.16b, v25.16b
sub	v7.16b, v26.16b, v16.16b
add	v21.16b, v21.16b, v31.16b
umull	v6.8h, v18.8b, v28.8b
umlal	v6.8h, v19.8b, v27.8b
umull	v17.8h, v19.8b, v28.8b
umlal	v17.8h, v20.8b, v27.8b
umull	v22.8h, v4.8b, v7.8b
umlal	v22.8h, v5.8b, v16.8b
umull2	v23.8h, v4.16b, v7.16b
umlal2	v23.8h, v5.16b, v16.16b
cmge	v21.16b, v21.16b, #0
rshrn	v6.8b, v6.8h, #0x6
rshrn2	v6.16b, v17.8h, #0x6
rshrn	v22.8b, v22.8h, #0x6
rshrn2	v22.16b, v23.8h, #0x6
bit	v6.16b, v22.16b, v21.16b
st1	{ v6.d }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v6.d }[1], [x0], x1
b.le	L_2090
mov	v18.8b, v20.8b
add	v29.8b, v29.8b, v24.8b
add	v30.8b, v30.8b, v24.8b
b	L_1fa4
L_2050:
tbl	v19.8b, { v0.16b }, v29.8b
tbl	v20.8b, { v0.16b }, v30.8b
umull	v6.8h, v18.8b, v28.8b
umlal	v6.8h, v19.8b, v27.8b
umull	v17.8h, v19.8b, v28.8b
umlal	v17.8h, v20.8b, v27.8b
rshrn	v6.8b, v6.8h, #0x6
rshrn2	v6.16b, v17.8h, #0x6
st1	{ v6.d }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v6.d }[1], [x0], x1
b.le	L_2090
mov	v18.8b, v20.8b
add	v29.8b, v29.8b, v24.8b
add	v30.8b, v30.8b, v24.8b
b	L_2050
L_2090:
ret
ipred_z2_fill3_8bpc_neon:
cmp	w4, #0x8
mov	w8, #0x40
sub	w8, w8, w6
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1	{ v31.8h }, [x11]
neg	w7, w7
b.eq	L_21d8
dup	v30.4h, w7
movi	v17.8b, #0x1
mul	v16.4h, v31.4h, v30.4h
movi	v25.16b, #0x3e
add	v30.4h, v16.4h, v30.4h
xtn	v31.8b, v31.8h
ld1	{ v0.16b, v1.16b }, [x3]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v30.8h
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v27.8b, v25.8b
add	v29.8b, v29.8b, v19.8b
add	v30.8b, v29.8b, v17.8b
add	v28.8b, v29.8b, v19.8b
trn1	v31.2s, v31.2s, v31.2s
add	v24.8b, v30.8b, v19.8b
trn1	v29.2s, v29.2s, v28.2s
trn1	v30.2s, v30.2s, v24.2s
sub	v28.8b, v26.8b, v27.8b
trn1	v27.2s, v27.2s, v27.2s
trn1	v28.2s, v28.2s, v28.2s
movi	v24.8b, #0x4
L_2110:
asr	w9, w8, #6
dup	v6.4h, w8
sub	w8, w8, w6
cmn	w9, #0x4
asr	w11, w8, #6
b.le	L_21a4
dup	v7.4h, w8
ldr	d2, [x2, w9, sxtw]
ldr	d4, [x2, w11, sxtw]
trn1	v6.2d, v6.2d, v7.2d
tbl	v16.8b, { v0.16b, v1.16b }, v29.8b
tbl	v17.8b, { v0.16b, v1.16b }, v30.8b
shrn	v20.8b, v6.8h, #0x6
xtn	v6.8b, v6.8h
ext	v3.8b, v2.8b, v2.8b, #0x1
ext	v5.8b, v4.8b, v4.8b, #0x1
and	v6.8b, v6.8b, v25.8b
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
sub	v7.8b, v26.8b, v6.8b
add	v20.8b, v20.8b, v31.8b
umull	v16.8h, v16.8b, v28.8b
umlal	v16.8h, v17.8b, v27.8b
umull	v22.8h, v2.8b, v7.8b
umlal	v22.8h, v3.8b, v6.8b
cmge	v20.8b, v20.8b, #0
rshrn	v16.8b, v16.8h, #0x6
rshrn	v22.8b, v22.8h, #0x6
bit	v16.8b, v22.8b, v20.8b
st1	{ v16.s }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v16.s }[1], [x0], x1
b.le	L_21d4
add	v29.8b, v29.8b, v24.8b
add	v30.8b, v30.8b, v24.8b
b	L_2110
L_21a4:
tbl	v16.8b, { v0.16b, v1.16b }, v29.8b
tbl	v17.8b, { v0.16b, v1.16b }, v30.8b
umull	v18.8h, v16.8b, v28.8b
umlal	v18.8h, v17.8b, v27.8b
rshrn	v18.8b, v18.8h, #0x6
st1	{ v18.s }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v18.s }[1], [x0], x1
b.le	L_21d4
add	v29.8b, v29.8b, v24.8b
add	v30.8b, v30.8b, v24.8b
b	L_21a4
L_21d4:
ret
L_21d8:
dup	v30.8h, w7
movi	v17.8b, #0x1
mul	v16.8h, v31.8h, v30.8h
movi	v25.16b, #0x3e
add	v30.8h, v16.8h, v30.8h
xtn	v31.8b, v31.8h
ld1	{ v0.16b, v1.16b, v2.16b }, [x3]
movi	v26.16b, #0x40
movi	v19.16b, #0x2
xtn	v27.8b, v30.8h
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v27.8b, v25.8b
add	v29.8b, v29.8b, v19.8b
add	v28.8b, v29.8b, v17.8b
add	v30.8b, v29.8b, v19.8b
trn1	v31.2d, v31.2d, v31.2d
add	v24.8b, v28.8b, v19.8b
trn1	v29.2d, v29.2d, v30.2d
trn1	v30.2d, v28.2d, v24.2d
sub	v28.8b, v26.8b, v27.8b
movi	v24.16b, #0x4
trn1	v27.2d, v27.2d, v27.2d
trn1	v28.2d, v28.2d, v28.2d
L_2234:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x8
asr	w11, w8, #6
b.le	L_22e4
dup	v17.8h, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
tbl	v18.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
shrn	v21.8b, v16.8h, #0x6
shrn2	v21.16b, v17.8h, #0x6
xtn	v16.8b, v16.8h
xtn2	v16.16b, v17.8h
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v7.16b, v6.16b, v6.16b, #0x1
and	v16.16b, v16.16b, v25.16b
trn1	v4.2d, v4.2d, v6.2d
trn1	v5.2d, v5.2d, v7.2d
sub	v7.16b, v26.16b, v16.16b
add	v21.16b, v21.16b, v31.16b
umull	v6.8h, v18.8b, v28.8b
umlal	v6.8h, v19.8b, v27.8b
umull2	v17.8h, v18.16b, v28.16b
umlal2	v17.8h, v19.16b, v27.16b
umull	v22.8h, v4.8b, v7.8b
umlal	v22.8h, v5.8b, v16.8b
umull2	v23.8h, v4.16b, v7.16b
umlal2	v23.8h, v5.16b, v16.16b
cmge	v21.16b, v21.16b, #0
rshrn	v6.8b, v6.8h, #0x6
rshrn2	v6.16b, v17.8h, #0x6
rshrn	v22.8b, v22.8h, #0x6
rshrn2	v22.16b, v23.8h, #0x6
bit	v6.16b, v22.16b, v21.16b
st1	{ v6.d }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v6.d }[1], [x0], x1
b.le	L_2320
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_2234
L_22e4:
tbl	v18.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
umull	v6.8h, v18.8b, v28.8b
umlal	v6.8h, v19.8b, v27.8b
umull2	v17.8h, v18.16b, v28.16b
umlal2	v17.8h, v19.16b, v27.16b
rshrn	v6.8b, v6.8h, #0x6
rshrn2	v6.16b, v17.8h, #0x6
st1	{ v6.d }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v6.d }[1], [x0], x1
b.le	L_2320
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_22e4
L_2320:
ret
ipred_z3_fill1_8bpc_neon:
cmp	w6, #0x40
clz	w9, w3
adrp	x8, ipred_z3_fill1_tbl
add	x8, x8, :lo12:ipred_z3_fill1_tbl
sub	w9, w9, #0x19
ldrsw	x9, [x8, w9, uxtw #2]
add	x10, x2, w6, uxtw
add	x8, x8, x9
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1r	{ v31.16b }, [x10]
ld1	{ v30.8h }, [x11]
mov	w7, w5
b.gt	L_2624
br	x8
L_2360:
dup	v29.4h, w5
mul	v30.4h, v30.4h, v29.4h
movi	v23.16b, #0x3e
ld1	{ v0.16b, v1.16b }, [x2]
add	v30.4h, v29.4h, v30.4h
movi	v22.16b, #0x40
movi	v20.16b, #0x1
movi	v21.16b, #0x2
xtn	v24.8b, v30.8h
uqshrn	v26.8b, v30.8h, #0x6
and	v24.8b, v24.8b, v23.8b
mov	v4.8b, v31.8b
uqadd	v27.8b, v26.8b, v20.8b
uqadd	v28.8b, v26.8b, v21.8b
sub	v25.8b, v22.8b, v24.8b
tbx	v4.8b, { v0.16b, v1.16b }, v26.8b
trn1	v27.2s, v27.2s, v28.2s
trn1	v24.2s, v24.2s, v24.2s
trn1	v25.2s, v25.2s, v25.2s
L_23ac:
mov	v5.8b, v31.8b
tbx	v5.8b, { v0.16b, v1.16b }, v27.8b
trn1	v4.2s, v4.2s, v5.2s
umull	v16.8h, v4.8b, v25.8b
umlal	v16.8h, v5.8b, v24.8b
rshrn	v16.8b, v16.8h, #0x6
st1	{ v16.s }[0], [x0], x1
subs	w4, w4, #0x2
st1	{ v16.s }[1], [x0], x1
b.le	L_23e0
ext	v4.8b, v5.8b, v5.8b, #0x4
uqadd	v27.8b, v27.8b, v21.8b
b	L_23ac
L_23e0:
ret
L_23e4:
dup	v29.8h, w5
mul	v30.8h, v30.8h, v29.8h
movi	v23.16b, #0x3e
ld1	{ v0.16b, v1.16b, v2.16b }, [x2]
add	v30.8h, v29.8h, v30.8h
movi	v22.16b, #0x40
movi	v20.16b, #0x1
movi	v21.16b, #0x2
xtn	v24.8b, v30.8h
uqshrn	v26.8b, v30.8h, #0x6
and	v24.8b, v24.8b, v23.8b
mov	v4.8b, v31.8b
uqadd	v27.8b, v26.8b, v20.8b
uqadd	v28.8b, v26.8b, v21.8b
sub	v25.8b, v22.8b, v24.8b
tbx	v4.8b, { v0.16b, v1.16b, v2.16b }, v26.8b
L_2424:
mov	v5.8b, v31.8b
mov	v6.8b, v31.8b
tbx	v5.8b, { v0.16b, v1.16b, v2.16b }, v27.8b
tbx	v6.8b, { v0.16b, v1.16b, v2.16b }, v28.8b
umull	v16.8h, v4.8b, v25.8b
umlal	v16.8h, v5.8b, v24.8b
umull	v17.8h, v5.8b, v25.8b
umlal	v17.8h, v6.8b, v24.8b
rshrn	v16.8b, v16.8h, #0x6
rshrn	v17.8b, v17.8h, #0x6
st1	{ v16.8b }, [x0], x1
subs	w4, w4, #0x2
st1	{ v17.8b }, [x0], x1
b.le	L_246c
mov	v4.8b, v6.8b
uqadd	v27.8b, v27.8b, v21.8b
uqadd	v28.8b, v28.8b, v21.8b
b	L_2424
L_246c:
ret
L_2470:
dup	v28.8h, w5
shl	v29.8h, v28.8h, #0x3
mul	v30.8h, v30.8h, v28.8h
movi	v23.16b, #0x3e
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
add	v28.8h, v28.8h, v30.8h
movi	v22.16b, #0x40
movi	v20.16b, #0x1
movi	v21.16b, #0x2
add	v29.8h, v28.8h, v29.8h
xtn	v24.8b, v28.8h
xtn2	v24.16b, v29.8h
uqshrn	v26.8b, v28.8h, #0x6
uqshrn2	v26.16b, v29.8h, #0x6
and	v24.16b, v24.16b, v23.16b
mov	v4.16b, v31.16b
uqadd	v27.16b, v26.16b, v20.16b
uqadd	v28.16b, v26.16b, v21.16b
sub	v25.16b, v22.16b, v24.16b
tbx	v4.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v26.16b
L_24c0:
mov	v5.16b, v31.16b
mov	v6.16b, v31.16b
tbx	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
tbx	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v28.16b
umull	v16.8h, v4.8b, v25.8b
umlal	v16.8h, v5.8b, v24.8b
umull2	v17.8h, v4.16b, v25.16b
umlal2	v17.8h, v5.16b, v24.16b
umull	v18.8h, v5.8b, v25.8b
umlal	v18.8h, v6.8b, v24.8b
umull2	v19.8h, v5.16b, v25.16b
umlal2	v19.8h, v6.16b, v24.16b
rshrn	v16.8b, v16.8h, #0x6
rshrn2	v16.16b, v17.8h, #0x6
rshrn	v17.8b, v18.8h, #0x6
rshrn2	v17.16b, v19.8h, #0x6
st1	{ v16.16b }, [x0], x1
subs	w4, w4, #0x2
st1	{ v17.16b }, [x0], x1
b.le	L_2520
mov	v4.16b, v6.16b
uqadd	v27.16b, v27.16b, v21.16b
uqadd	v28.16b, v28.16b, v21.16b
b	L_24c0
L_2520:
ret
L_2524:
dup	v28.8h, w5
mov	w12, w3
add	x13, x0, x1
shl	v29.8h, v28.8h, #0x3
mul	v30.8h, v30.8h, v28.8h
movi	v23.16b, #0x3e
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
add	v30.8h, v28.8h, v30.8h
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
movi	v22.16b, #0x40
movi	v20.16b, #0x1
movi	v21.16b, #0x2
L_2558:
mov	v26.16b, v30.16b
L_255c:
add	v27.8h, v26.8h, v29.8h
uqshrn	v16.8b, v26.8h, #0x6
uqshrn2	v16.16b, v27.8h, #0x6
xtn	v24.8b, v26.8h
xtn2	v24.16b, v27.8h
umov	w14, v16.b[0]
and	v24.16b, v24.16b, v23.16b
uqadd	v17.16b, v16.16b, v20.16b
cmp	w14, w6
uqadd	v18.16b, v16.16b, v21.16b
sub	v25.16b, v22.16b, v24.16b
b.ge	L_260c
mov	v4.16b, v31.16b
mov	v5.16b, v31.16b
mov	v6.16b, v31.16b
tbx	v4.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v16.16b
tbx	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v17.16b
tbx	v6.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v18.16b
subs	w3, w3, #0x10
umull	v16.8h, v4.8b, v25.8b
umlal	v16.8h, v5.8b, v24.8b
umull2	v17.8h, v4.16b, v25.16b
umlal2	v17.8h, v5.16b, v24.16b
umull	v18.8h, v5.8b, v25.8b
umlal	v18.8h, v6.8b, v24.8b
umull2	v19.8h, v5.16b, v25.16b
umlal2	v19.8h, v6.16b, v24.16b
rshrn	v16.8b, v16.8h, #0x6
rshrn2	v16.16b, v17.8h, #0x6
rshrn	v17.8b, v18.8h, #0x6
rshrn2	v17.16b, v19.8h, #0x6
st1	{ v16.16b }, [x0], #16
st1	{ v17.16b }, [x13], #16
b.le	L_25ec
add	v26.8h, v27.8h, v29.8h
b	L_255c
L_25ec:
subs	w4, w4, #0x2
b.le	L_2620
movi	v16.8h, #0x80
add	x0, x0, x1
add	x13, x13, x1
add	v30.8h, v30.8h, v16.8h
mov	w3, w12
b	L_2558
L_260c:
subs	w3, w3, #0x10
st1	{ v31.16b }, [x0], #16
st1	{ v31.16b }, [x13], #16
b.gt	L_260c
b	L_25ec
L_2620:
ret
L_2624:
mov	w15, #0x40
add	x13, x0, x1
lsl	x1, x1, #1
mov	w12, w4
L_2634:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw
add	x10, x2, w10, uxtw
dup	v4.16b, w9
dup	v5.16b, w11
ld1	{ v0.16b, v1.16b }, [x8], #32
ld1	{ v2.16b, v3.16b }, [x10], #32
sub	w9, w15, w9
sub	w11, w15, w11
dup	v6.16b, w9
dup	v7.16b, w11
add	w7, w7, w5
L_267c:
ext	v16.16b, v0.16b, v1.16b, #0x1
ext	v17.16b, v2.16b, v3.16b, #0x1
subs	w4, w4, #0x10
umull	v18.8h, v16.8b, v4.8b
umlal	v18.8h, v0.8b, v6.8b
umull2	v19.8h, v16.16b, v4.16b
umlal2	v19.8h, v0.16b, v6.16b
umull	v20.8h, v17.8b, v5.8b
umlal	v20.8h, v2.8b, v7.8b
umull2	v21.8h, v17.16b, v5.16b
umlal2	v21.8h, v2.16b, v7.16b
rshrn	v16.8b, v18.8h, #0x6
rshrn2	v16.16b, v19.8h, #0x6
rshrn	v17.8b, v20.8h, #0x6
rshrn2	v17.16b, v21.8h, #0x6
zip1	v18.16b, v16.16b, v17.16b
zip2	v19.16b, v16.16b, v17.16b
st1	{ v18.h }[0], [x0], x1
st1	{ v18.h }[1], [x13], x1
st1	{ v18.h }[2], [x0], x1
st1	{ v18.h }[3], [x13], x1
st1	{ v18.h }[4], [x0], x1
st1	{ v18.h }[5], [x13], x1
st1	{ v18.h }[6], [x0], x1
st1	{ v18.h }[7], [x13], x1
st1	{ v19.h }[0], [x0], x1
st1	{ v19.h }[1], [x13], x1
st1	{ v19.h }[2], [x0], x1
st1	{ v19.h }[3], [x13], x1
st1	{ v19.h }[4], [x0], x1
st1	{ v19.h }[5], [x13], x1
st1	{ v19.h }[6], [x0], x1
st1	{ v19.h }[7], [x13], x1
b.le	L_2718
mov	v0.16b, v1.16b
ld1	{ v1.16b }, [x8], #16
mov	v2.16b, v3.16b
ld1	{ v3.16b }, [x10], #16
b	L_267c
L_2718:
subs	w3, w3, #0x2
b.le	L_2740
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #0x2
add	x13, x13, #0x2
mov	w4, w12
b	L_2634
L_2740:
ret
ipred_z3_fill_padding_neon:
cmp	w3, #0x10
adrp	x8, ipred_z3_fill_padding_tbl
add	x8, x8, :lo12:ipred_z3_fill_padding_tbl
b.gt	ipred_z3_fill_padding_wide
mov	w12, w4
L_2758:
clz	w9, w3
sub	w9, w9, #0x19
ldrsw	x9, [x8, w9, uxtw #2]
add	x9, x8, x9
br	x9
L_276c:
st1	{ v31.h }[0], [x0], x1
subs	w4, w4, #0x4
st1	{ v31.h }[0], [x13], x1
st1	{ v31.h }[0], [x0], x1
st1	{ v31.h }[0], [x13], x1
b.gt	L_276c
subs	w3, w3, #0x2
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_286c
lsl	x1, x1, #1
add	x0, x0, #0x2
add	x13, x13, #0x2
mov	w4, w12
b	L_2758
L_27ac:
st1	{ v31.s }[0], [x0], x1
subs	w4, w4, #0x4
st1	{ v31.s }[0], [x13], x1
st1	{ v31.s }[0], [x0], x1
st1	{ v31.s }[0], [x13], x1
b.gt	L_27ac
subs	w3, w3, #0x4
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_286c
lsl	x1, x1, #1
add	x0, x0, #0x4
add	x13, x13, #0x4
mov	w4, w12
b	L_2758
L_27ec:
st1	{ v31.8b }, [x0], x1
subs	w4, w4, #0x4
st1	{ v31.8b }, [x13], x1
st1	{ v31.8b }, [x0], x1
st1	{ v31.8b }, [x13], x1
b.gt	L_27ec
subs	w3, w3, #0x8
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_286c
lsl	x1, x1, #1
add	x0, x0, #0x8
add	x13, x13, #0x8
mov	w4, w12
b	L_2758
L_282c:
st1	{ v31.16b }, [x0], x1
subs	w4, w4, #0x4
st1	{ v31.16b }, [x13], x1
st1	{ v31.16b }, [x0], x1
st1	{ v31.16b }, [x13], x1
b.gt	L_282c
subs	w3, w3, #0x10
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_286c
lsl	x1, x1, #1
add	x0, x0, #0x10
add	x13, x13, #0x10
mov	w4, w12
b	L_2758
L_286c:
ret
ipred_z3_fill_padding_wide:
lsr	x1, x1, #1
mov	w12, w3
sub	x1, x1, w3, uxtw
L_287c:
ands	w5, w3, #0xf
b.eq	L_2890
sub	w3, w3, w5
st1	{ v31.16b }, [x0]
add	x0, x0, w5, uxtw
L_2890:
subs	w3, w3, #0x10
st1	{ v31.16b }, [x0], #16
b.gt	L_2890
subs	w4, w4, #0x1
add	x0, x0, x1
b.le	L_28b0
mov	w3, w12
b	L_287c
L_28b0:
ret
ipred_z3_fill2_8bpc_neon:
cmp	w3, #0x8
add	x10, x2, w6, uxtw
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1r	{ v31.16b }, [x10]
ld1	{ v30.8h }, [x11]
b.eq	L_295c
dup	v29.4h, w5
mul	v30.4h, v30.4h, v29.4h
movi	v23.16b, #0x3e
ld1	{ v0.16b, v1.16b }, [x2]
add	v30.4h, v29.4h, v30.4h
movi	v22.16b, #0x40
movi	v20.16b, #0x1
movi	v21.16b, #0x2
xtn	v24.8b, v30.8h
uqshrn	v26.8b, v30.8h, #0x6
and	v24.8b, v24.8b, v23.8b
uqadd	v27.8b, v26.8b, v20.8b
uqadd	v28.8b, v26.8b, v21.8b
sub	v25.8b, v22.8b, v24.8b
uqadd	v29.8b, v27.8b, v21.8b
trn1	v24.2s, v24.2s, v24.2s
trn1	v26.2s, v26.2s, v28.2s
trn1	v27.2s, v27.2s, v29.2s
trn1	v25.2s, v25.2s, v25.2s
movi	v21.16b, #0x4
L_2920:
mov	v4.8b, v31.8b
mov	v5.8b, v31.8b
tbx	v4.8b, { v0.16b, v1.16b }, v26.8b
tbx	v5.8b, { v0.16b, v1.16b }, v27.8b
umull	v16.8h, v4.8b, v25.8b
umlal	v16.8h, v5.8b, v24.8b
rshrn	v16.8b, v16.8h, #0x6
st1	{ v16.s }[0], [x0], x1
subs	w4, w4, #0x2
st1	{ v16.s }[1], [x0], x1
b.le	L_2958
uqadd	v26.8b, v26.8b, v21.8b
uqadd	v27.8b, v27.8b, v21.8b
b	L_2920
L_2958:
ret
L_295c:
dup	v29.8h, w5
mul	v30.8h, v30.8h, v29.8h
movi	v23.16b, #0x3e
ld1	{ v0.16b, v1.16b }, [x2]
add	v30.8h, v29.8h, v30.8h
movi	v22.16b, #0x40
movi	v20.16b, #0x1
movi	v21.16b, #0x2
xtn	v24.8b, v30.8h
uqshrn	v26.8b, v30.8h, #0x6
and	v24.8b, v24.8b, v23.8b
uqadd	v27.8b, v26.8b, v20.8b
uqadd	v28.8b, v26.8b, v21.8b
sub	v25.8b, v22.8b, v24.8b
uqadd	v29.8b, v27.8b, v21.8b
trn1	v24.2d, v24.2d, v24.2d
trn1	v26.2d, v26.2d, v28.2d
trn1	v27.2d, v27.2d, v29.2d
trn1	v25.2d, v25.2d, v25.2d
movi	v21.16b, #0x4
L_29ac:
mov	v4.16b, v31.16b
mov	v5.16b, v31.16b
tbx	v4.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v26.16b
tbx	v5.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v27.16b
umull	v16.8h, v4.8b, v25.8b
umlal	v16.8h, v5.8b, v24.8b
umull2	v17.8h, v4.16b, v25.16b
umlal2	v17.8h, v5.16b, v24.16b
rshrn	v16.8b, v16.8h, #0x6
rshrn	v17.8b, v17.8h, #0x6
st1	{ v16.8b }, [x0], x1
subs	w4, w4, #0x2
st1	{ v17.8b }, [x0], x1
b.le	L_29f0
uqadd	v26.16b, v26.16b, v21.16b
uqadd	v27.16b, v27.16b, v21.16b
b	L_29ac
L_29f0:
ret
ipred_filter_8bpc_neon:
and	w5, w5, #0x1ff
adrp	x6, filter_intra_taps
add	x6, x6, :lo12:filter_intra_taps
lsl	w5, w5, #6
add	x6, x6, w5, uxtw
ld1	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x6], #32
clz	w9, w3
adrp	x5, ipred_filter_tbl
add	x5, x5, :lo12:ipred_filter_tbl
ld1	{ v20.8b, v21.8b, v22.8b }, [x6]
sub	w9, w9, #0x1a
ldrsw	x9, [x5, w9, uxtw #2]
sshll	v16.8h, v16.8b, #0x0
sshll	v17.8h, v17.8b, #0x0
add	x5, x5, x9
sshll	v18.8h, v18.8b, #0x0
sshll	v19.8h, v19.8b, #0x0
add	x6, x0, x1
lsl	x1, x1, #1
sshll	v20.8h, v20.8b, #0x0
sshll	v21.8h, v21.8b, #0x0
sshll	v22.8h, v22.8b, #0x0
br	x5
L_2a50:
ldur	s0, [x2, #0x1]
sub	x2, x2, #0x2
mov	x7, #-0x2
ushll	v0.8h, v0.8b, #0x0
L_2a60:
ld1	{ v1.s }[0], [x2], x7
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
ushll	v1.8h, v1.8b, #0x0
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v16.8h, v1.h[2]
mla	v2.8h, v21.8h, v1.h[1]
mla	v2.8h, v22.8h, v1.h[0]
sqrshrun	v2.8b, v2.8h, #0x4
subs	w4, w4, #0x2
st1	{ v2.s }[0], [x0], x1
ushll	v0.8h, v2.8b, #0x0
st1	{ v2.s }[1], [x6], x1
ext	v0.16b, v0.16b, v0.16b, #0x8
b.gt	L_2a60
ret
L_2aa4:
ldur	d0, [x2, #0x1]
sub	x2, x2, #0x2
mov	x7, #-0x2
ushll	v0.8h, v0.8b, #0x0
L_2ab4:
ld1	{ v1.s }[0], [x2], x7
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
ushll	v1.8h, v1.8b, #0x0
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v16.8h, v1.h[2]
mla	v2.8h, v21.8h, v1.h[1]
mla	v2.8h, v22.8h, v1.h[0]
mul	v3.8h, v17.8h, v0.h[4]
mla	v3.8h, v18.8h, v0.h[5]
mla	v3.8h, v19.8h, v0.h[6]
sqrshrun	v2.8b, v2.8h, #0x4
ushll	v1.8h, v2.8b, #0x0
mla	v3.8h, v20.8h, v0.h[7]
mla	v3.8h, v16.8h, v0.h[3]
mla	v3.8h, v21.8h, v1.h[3]
mla	v3.8h, v22.8h, v1.h[7]
sqrshrun	v3.8b, v3.8h, #0x4
subs	w4, w4, #0x2
st2	{ v2.s, v3.s }[0], [x0], x1
zip2	v0.2s, v2.2s, v3.2s
st2	{ v2.s, v3.s }[1], [x6], x1
ushll	v0.8h, v0.8b, #0x0
b.gt	L_2ab4
ret
L_2b1c:
add	x8, x2, #0x1
sub	x2, x2, #0x2
mov	x7, #-0x2
sub	x1, x1, w3, uxtw
mov	w9, w3
L_2b30:
ld1	{ v0.s }[0], [x2], x7
ushll	v0.8h, v0.8b, #0x0
L_2b38:
ld1	{ v2.16b }, [x8], #16
mul	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[1]
ushll	v1.8h, v2.8b, #0x0
ushll2	v2.8h, v2.16b, #0x0
mla	v3.8h, v22.8h, v0.h[0]
mla	v3.8h, v17.8h, v1.h[0]
mla	v3.8h, v18.8h, v1.h[1]
mla	v3.8h, v19.8h, v1.h[2]
mla	v3.8h, v20.8h, v1.h[3]
mul	v4.8h, v17.8h, v1.h[4]
mla	v4.8h, v18.8h, v1.h[5]
mla	v4.8h, v19.8h, v1.h[6]
sqrshrun	v3.8b, v3.8h, #0x4
ushll	v0.8h, v3.8b, #0x0
mla	v4.8h, v20.8h, v1.h[7]
mla	v4.8h, v16.8h, v1.h[3]
mla	v4.8h, v21.8h, v0.h[3]
mla	v4.8h, v22.8h, v0.h[7]
mul	v5.8h, v17.8h, v2.h[0]
mla	v5.8h, v18.8h, v2.h[1]
mla	v5.8h, v19.8h, v2.h[2]
sqrshrun	v4.8b, v4.8h, #0x4
ushll	v0.8h, v4.8b, #0x0
mla	v5.8h, v20.8h, v2.h[3]
mla	v5.8h, v16.8h, v1.h[7]
mla	v5.8h, v21.8h, v0.h[3]
mla	v5.8h, v22.8h, v0.h[7]
mul	v6.8h, v17.8h, v2.h[4]
mla	v6.8h, v18.8h, v2.h[5]
mla	v6.8h, v19.8h, v2.h[6]
sqrshrun	v5.8b, v5.8h, #0x4
ushll	v0.8h, v5.8b, #0x0
mla	v6.8h, v20.8h, v2.h[7]
mla	v6.8h, v16.8h, v2.h[3]
mla	v6.8h, v21.8h, v0.h[3]
mla	v6.8h, v22.8h, v0.h[7]
subs	w3, w3, #0x10
sqrshrun	v6.8b, v6.8h, #0x4
st4	{ v3.s, v4.s, v5.s, v6.s }[0], [x0], #16
st4	{ v3.s, v4.s, v5.s, v6.s }[1], [x6], #16
b.le	L_2bf0
mov	v0.h[2], v2.h[7]
mov	v0.b[0], v6.b[7]
mov	v0.b[2], v6.b[3]
b	L_2b38
L_2bf0:
subs	w4, w4, #0x2
b.le	L_2c0c
sub	x8, x6, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	L_2b30
L_2c0c:
ret
pal_pred_8bpc_neon:
ld1	{ v0.8b }, [x2]
clz	w9, w4
adrp	x6, pal_pred_tbl
add	x6, x6, :lo12:pal_pred_tbl
sub	w9, w9, #0x19
movi	v31.16b, #0x7
ldrsw	x9, [x6, w9, uxtw #2]
add	x6, x6, x9
add	x2, x0, x1
lsl	x1, x1, #1
br	x6
L_2c3c:
ld1	{ v1.8b }, [x3], #8
subs	w5, w5, #0x4
ushr	v3.8b, v1.8b, #0x4
and	v2.8b, v1.8b, v31.8b
zip1	v1.16b, v2.16b, v3.16b
tbl	v1.16b, { v0.16b }, v1.16b
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x2], x1
st1	{ v1.s }[2], [x0], x1
st1	{ v1.s }[3], [x2], x1
b.gt	L_2c3c
ret
L_2c6c:
ld1	{ v1.16b }, [x3], #16
subs	w5, w5, #0x4
ushr	v4.16b, v1.16b, #0x4
and	v3.16b, v1.16b, v31.16b
zip1	v1.16b, v3.16b, v4.16b
zip2	v2.16b, v3.16b, v4.16b
tbl	v1.16b, { v0.16b }, v1.16b
st1	{ v1.d }[0], [x0], x1
tbl	v2.16b, { v0.16b }, v2.16b
st1	{ v1.d }[1], [x2], x1
st1	{ v2.d }[0], [x0], x1
st1	{ v2.d }[1], [x2], x1
b.gt	L_2c6c
ret
L_2ca4:
ld1	{ v1.16b, v2.16b }, [x3], #32
subs	w5, w5, #0x4
ushr	v5.16b, v1.16b, #0x4
and	v4.16b, v1.16b, v31.16b
ushr	v7.16b, v2.16b, #0x4
and	v6.16b, v2.16b, v31.16b
zip1	v1.16b, v4.16b, v5.16b
zip2	v2.16b, v4.16b, v5.16b
zip1	v3.16b, v6.16b, v7.16b
tbl	v1.16b, { v0.16b }, v1.16b
zip2	v4.16b, v6.16b, v7.16b
tbl	v2.16b, { v0.16b }, v2.16b
st1	{ v1.16b }, [x0], x1
tbl	v3.16b, { v0.16b }, v3.16b
st1	{ v2.16b }, [x2], x1
tbl	v4.16b, { v0.16b }, v4.16b
st1	{ v3.16b }, [x0], x1
st1	{ v4.16b }, [x2], x1
b.gt	L_2ca4
ret
L_2cf4:
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x3], #64
subs	w5, w5, #0x4
ushr	v21.16b, v16.16b, #0x4
and	v20.16b, v16.16b, v31.16b
ushr	v23.16b, v17.16b, #0x4
and	v22.16b, v17.16b, v31.16b
ushr	v25.16b, v18.16b, #0x4
and	v24.16b, v18.16b, v31.16b
ushr	v27.16b, v19.16b, #0x4
and	v26.16b, v19.16b, v31.16b
zip1	v16.16b, v20.16b, v21.16b
zip2	v17.16b, v20.16b, v21.16b
zip1	v18.16b, v22.16b, v23.16b
zip2	v19.16b, v22.16b, v23.16b
zip1	v20.16b, v24.16b, v25.16b
zip2	v21.16b, v24.16b, v25.16b
tbl	v16.16b, { v0.16b }, v16.16b
zip1	v22.16b, v26.16b, v27.16b
tbl	v17.16b, { v0.16b }, v17.16b
zip2	v23.16b, v26.16b, v27.16b
tbl	v18.16b, { v0.16b }, v18.16b
tbl	v19.16b, { v0.16b }, v19.16b
tbl	v20.16b, { v0.16b }, v20.16b
st1	{ v16.16b, v17.16b }, [x0], x1
tbl	v21.16b, { v0.16b }, v21.16b
st1	{ v18.16b, v19.16b }, [x2], x1
tbl	v22.16b, { v0.16b }, v22.16b
st1	{ v20.16b, v21.16b }, [x0], x1
tbl	v23.16b, { v0.16b }, v23.16b
st1	{ v22.16b, v23.16b }, [x2], x1
b.gt	L_2cf4
ret
L_2d74:
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x3], #64
subs	w5, w5, #0x2
ushr	v21.16b, v16.16b, #0x4
and	v20.16b, v16.16b, v31.16b
ushr	v23.16b, v17.16b, #0x4
and	v22.16b, v17.16b, v31.16b
ushr	v25.16b, v18.16b, #0x4
and	v24.16b, v18.16b, v31.16b
ushr	v27.16b, v19.16b, #0x4
and	v26.16b, v19.16b, v31.16b
zip1	v16.16b, v20.16b, v21.16b
zip2	v17.16b, v20.16b, v21.16b
zip1	v18.16b, v22.16b, v23.16b
zip2	v19.16b, v22.16b, v23.16b
zip1	v20.16b, v24.16b, v25.16b
zip2	v21.16b, v24.16b, v25.16b
tbl	v16.16b, { v0.16b }, v16.16b
zip1	v22.16b, v26.16b, v27.16b
tbl	v17.16b, { v0.16b }, v17.16b
zip2	v23.16b, v26.16b, v27.16b
tbl	v18.16b, { v0.16b }, v18.16b
tbl	v19.16b, { v0.16b }, v19.16b
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x0], x1
tbl	v20.16b, { v0.16b }, v20.16b
tbl	v21.16b, { v0.16b }, v21.16b
tbl	v22.16b, { v0.16b }, v22.16b
tbl	v23.16b, { v0.16b }, v23.16b
st1	{ v20.16b, v21.16b, v22.16b, v23.16b }, [x2], x1
b.gt	L_2d74
ret
ipred_cfl_128_8bpc_neon:
clz	w9, w3
adrp	x7, ipred_cfl_128_tbl
add	x7, x7, :lo12:ipred_cfl_128_tbl
sub	w9, w9, #0x1a
ldrsw	x9, [x7, w9, uxtw #2]
movi	v0.8h, #0x80
dup	v1.8h, w6
add	x7, x7, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
L_2e18:
ld1	{ v2.8h, v3.8h }, [x5], #32
mul	v2.8h, v2.8h, v1.8h
mul	v3.8h, v3.8h, v1.8h
cmlt	v4.8h, v2.8h, #0
cmlt	v5.8h, v3.8h, #0
add	v2.8h, v2.8h, v4.8h
add	v3.8h, v3.8h, v5.8h
srshr	v2.8h, v2.8h, #0x6
srshr	v3.8h, v3.8h, #0x6
add	v2.8h, v2.8h, v0.8h
add	v3.8h, v3.8h, v0.8h
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x6], x1
subs	w4, w4, #0x4
st1	{ v3.s }[0], [x0], x1
st1	{ v3.s }[1], [x6], x1
b.gt	L_2e18
ret
L_2e68:
ld1	{ v2.8h, v3.8h, v4.8h, v5.8h }, [x5], #64
mul	v2.8h, v2.8h, v1.8h
mul	v3.8h, v3.8h, v1.8h
mul	v4.8h, v4.8h, v1.8h
mul	v5.8h, v5.8h, v1.8h
cmlt	v16.8h, v2.8h, #0
cmlt	v17.8h, v3.8h, #0
cmlt	v18.8h, v4.8h, #0
cmlt	v19.8h, v5.8h, #0
add	v2.8h, v2.8h, v16.8h
add	v3.8h, v3.8h, v17.8h
add	v4.8h, v4.8h, v18.8h
add	v5.8h, v5.8h, v19.8h
srshr	v2.8h, v2.8h, #0x6
srshr	v3.8h, v3.8h, #0x6
srshr	v4.8h, v4.8h, #0x6
srshr	v5.8h, v5.8h, #0x6
add	v2.8h, v2.8h, v0.8h
add	v3.8h, v3.8h, v0.8h
add	v4.8h, v4.8h, v0.8h
add	v5.8h, v5.8h, v0.8h
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
sqxtun	v4.8b, v4.8h
sqxtun	v5.8b, v5.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x6], x1
subs	w4, w4, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x6], x1
b.gt	L_2e68
ret
L_2ee8:
add	x7, x5, w3, uxtw #1
sub	x1, x1, w3, uxtw
mov	w9, w3
L_2ef4:
ld1	{ v2.8h, v3.8h }, [x5], #32
ld1	{ v4.8h, v5.8h }, [x7], #32
mul	v2.8h, v2.8h, v1.8h
mul	v3.8h, v3.8h, v1.8h
mul	v4.8h, v4.8h, v1.8h
mul	v5.8h, v5.8h, v1.8h
cmlt	v16.8h, v2.8h, #0
cmlt	v17.8h, v3.8h, #0
cmlt	v18.8h, v4.8h, #0
cmlt	v19.8h, v5.8h, #0
add	v2.8h, v2.8h, v16.8h
add	v3.8h, v3.8h, v17.8h
add	v4.8h, v4.8h, v18.8h
add	v5.8h, v5.8h, v19.8h
srshr	v2.8h, v2.8h, #0x6
srshr	v3.8h, v3.8h, #0x6
srshr	v4.8h, v4.8h, #0x6
srshr	v5.8h, v5.8h, #0x6
add	v2.8h, v2.8h, v0.8h
add	v3.8h, v3.8h, v0.8h
add	v4.8h, v4.8h, v0.8h
add	v5.8h, v5.8h, v0.8h
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
sqxtun	v4.8b, v4.8h
sqxtun	v5.8b, v5.8h
subs	w3, w3, #0x10
st1	{ v2.8b, v3.8b }, [x0], #16
st1	{ v4.8b, v5.8b }, [x6], #16
b.gt	L_2ef4
subs	w4, w4, #0x2
add	x5, x5, w9, uxtw #1
add	x7, x7, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b.gt	L_2ef4
ret
ipred_cfl_top_8bpc_neon:
clz	w9, w3
adrp	x7, ipred_cfl_top_tbl
add	x7, x7, :lo12:ipred_cfl_top_tbl
sub	w9, w9, #0x1a
ldrsw	x9, [x7, w9, uxtw #2]
dup	v1.8h, w6
add	x2, x2, #0x1
add	x7, x7, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
L_2fb8:
ld1r	{ v0.2s }, [x2]
uaddlv	h0, v0.8b
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
b	L_2e18
L_2fcc:
ld1	{ v0.8b }, [x2]
uaddlv	h0, v0.8b
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
b	L_2e68
L_2fe0:
ld1	{ v0.16b }, [x2]
uaddlv	h0, v0.16b
urshr	v0.4h, v0.4h, #0x4
dup	v0.8h, v0.h[0]
b	L_2ee8
L_2ff4:
ld1	{ v2.16b, v3.16b }, [x2]
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
add	v2.4h, v2.4h, v3.4h
urshr	v2.4h, v2.4h, #0x5
dup	v0.8h, v2.h[0]
b	L_2ee8
ipred_cfl_left_8bpc_neon:
sub	x2, x2, w4, uxtw
clz	w9, w3
clz	w8, w4
adrp	x10, ipred_cfl_128_tbl
add	x10, x10, :lo12:ipred_cfl_128_tbl
adrp	x7, ipred_cfl_left_tbl
add	x7, x7, :lo12:ipred_cfl_left_tbl
sub	w9, w9, #0x1a
sub	w8, w8, #0x1a
ldrsw	x9, [x10, w9, uxtw #2]
ldrsw	x8, [x7, w8, uxtw #2]
dup	v1.8h, w6
add	x9, x10, x9
add	x7, x7, x8
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
L_3054:
ld1r	{ v0.2s }, [x2]
uaddlv	h0, v0.8b
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
br	x9
L_3068:
ld1	{ v0.8b }, [x2]
uaddlv	h0, v0.8b
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
br	x9
L_307c:
ld1	{ v0.16b }, [x2]
uaddlv	h0, v0.16b
urshr	v0.4h, v0.4h, #0x4
dup	v0.8h, v0.h[0]
br	x9
L_3090:
ld1	{ v2.16b, v3.16b }, [x2]
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
add	v2.4h, v2.4h, v3.4h
urshr	v2.4h, v2.4h, #0x5
dup	v0.8h, v2.h[0]
br	x9
ipred_cfl_8bpc_neon:
sub	x2, x2, w4, uxtw
add	w8, w3, w4
dup	v1.8h, w6
clz	w9, w3
clz	w6, w4
dup	v16.8h, w8
adrp	x7, ipred_cfl_tbl
add	x7, x7, :lo12:ipred_cfl_tbl
rbit	w8, w8
sub	w9, w9, #0x16
sub	w6, w6, #0x1a
clz	w8, w8
ldrsw	x9, [x7, w9, uxtw #2]
ldrsw	x6, [x7, w6, uxtw #2]
neg	w8, w8
add	x9, x7, x9
add	x7, x7, x6
ushr	v16.8h, v16.8h, #0x1
dup	v17.8h, w8
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
L_3104:
ld1	{ v0.s }[0], [x2], #4
mov	v0.s[1], wzr
add	x2, x2, #0x1
uaddlv	h0, v0.8b
br	x9
L_3118:
ld1	{ v2.s }[0], [x2]
mov	v2.s[1], wzr
add	v0.4h, v0.4h, v16.4h
uaddlv	h2, v2.8b
cmp	w4, #0x4
add	v0.4h, v0.4h, v2.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_3150
mov	w16, #0x199a
movk	w16, #0x2aab, lsl #16
add	w17, w4, w4
lsr	w16, w16, w17
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_3150:
dup	v0.8h, v0.h[0]
b	L_2e18
L_3158:
ld1	{ v0.8b }, [x2], #8
uaddlv	h0, v0.8b
add	x2, x2, #0x1
br	x9
L_3168:
ld1	{ v2.8b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h2, v2.8b
cmp	w4, #0x8
add	v0.4h, v0.4h, v2.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_319c
cmp	w4, #0x20
mov	w16, #0x199a
mov	w17, #0x2aab
csel	w16, w16, w17, eq
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_319c:
dup	v0.8h, v0.h[0]
b	L_2e68
L_31a4:
ld1	{ v0.16b }, [x2], #16
uaddlv	h0, v0.16b
add	x2, x2, #0x1
br	x9
L_31b4:
ld1	{ v2.16b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h2, v2.16b
cmp	w4, #0x10
add	v0.4h, v0.4h, v2.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_31e8
cmp	w4, #0x4
mov	w16, #0x199a
mov	w17, #0x2aab
csel	w16, w16, w17, eq
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_31e8:
dup	v0.8h, v0.h[0]
b	L_2ee8
L_31f0:
ld1	{ v2.16b, v3.16b }, [x2], #32
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
add	x2, x2, #0x1
add	v0.4h, v2.4h, v3.4h
br	x9
L_3208:
ld1	{ v2.16b, v3.16b }, [x2]
add	v0.4h, v0.4h, v16.4h
uaddlv	h2, v2.16b
uaddlv	h3, v3.16b
cmp	w4, #0x20
add	v0.4h, v0.4h, v2.4h
add	v0.4h, v0.4h, v3.4h
ushl	v0.4h, v0.4h, v17.4h
b.eq	L_3244
mov	w16, #0x2aab
movk	w16, #0x199a, lsl #16
add	w17, w4, w4
lsr	w16, w16, w17
dup	v16.4h, w16
sqdmulh	v0.4h, v0.4h, v16.4h
L_3244:
dup	v0.8h, v0.h[0]
b	L_2ee8
ipred_cfl_ac_420_8bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adrp	x7, ipred_cfl_ac_420_tbl
add	x7, x7, :lo12:ipred_cfl_ac_420_tbl
sub	w8, w8, #0x1b
ldrsw	x8, [x7, w8, uxtw #2]
movi	v16.8h, #0x0
movi	v17.8h, #0x0
movi	v18.8h, #0x0
movi	v19.8h, #0x0
add	x7, x7, x8
sub	w8, w6, w4
rbit	w9, w5
rbit	w10, w6
clz	w9, w9
clz	w10, w10
add	w9, w9, w10
add	x10, x1, x2
dup	v31.4s, w9
lsl	x2, x2, #1
neg	v31.4s, v31.4s
br	x7
L_32a4:
ld1	{ v0.8b }, [x1], x2
ld1	{ v1.8b }, [x10], x2
ld1	{ v0.d }[1], [x1], x2
ld1	{ v1.d }[1], [x10], x2
uaddlp	v0.8h, v0.16b
uaddlp	v1.8h, v1.16b
add	v0.8h, v0.8h, v1.8h
shl	v0.8h, v0.8h, #0x1
subs	w8, w8, #0x2
st1	{ v0.8h }, [x0], #16
add	v16.8h, v16.8h, v0.8h
b.gt	L_32a4
trn2	v1.2d, v0.2d, v0.2d
trn2	v0.2d, v0.2d, v0.2d
L_32dc:
cbz	w4, L_32f4
L_32e0:
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], #32
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
b.gt	L_32e0
L_32f4:
add	v0.8h, v16.8h, v17.8h
uaddlv	s0, v0.8h
sub	x0, x0, w6, uxtw #3
urshl	v4.2s, v0.2s, v31.2s
dup	v4.8h, v4.h[0]
L_3308:
ld1	{ v0.8h, v1.8h }, [x0]
subs	w6, w6, #0x4
sub	v0.8h, v0.8h, v4.8h
sub	v1.8h, v1.8h, v4.8h
st1	{ v0.8h, v1.8h }, [x0], #32
b.gt	L_3308
ret
L_3324:
cbnz	w3, L_3374
L_3328:
ld1	{ v0.16b }, [x1], x2
ld1	{ v1.16b }, [x10], x2
ld1	{ v2.16b }, [x1], x2
uaddlp	v0.8h, v0.16b
ld1	{ v3.16b }, [x10], x2
uaddlp	v1.8h, v1.16b
uaddlp	v2.8h, v2.16b
uaddlp	v3.8h, v3.16b
add	v0.8h, v0.8h, v1.8h
add	v2.8h, v2.8h, v3.8h
shl	v0.8h, v0.8h, #0x1
shl	v1.8h, v2.8h, #0x1
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h }, [x0], #32
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
b.gt	L_3328
mov	v0.16b, v1.16b
b	L_33c4
L_3374:
ld1	{ v0.8b }, [x1], x2
ld1	{ v1.8b }, [x10], x2
ld1	{ v0.d }[1], [x1], x2
ld1	{ v1.d }[1], [x10], x2
uaddlp	v0.8h, v0.16b
uaddlp	v1.8h, v1.16b
add	v0.8h, v0.8h, v1.8h
shl	v0.8h, v0.8h, #0x1
dup	v1.4h, v0.h[3]
dup	v3.4h, v0.h[7]
trn2	v2.2d, v0.2d, v0.2d
subs	w8, w8, #0x2
st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x0], #32
add	v16.4h, v16.4h, v0.4h
add	v17.4h, v17.4h, v1.4h
add	v18.4h, v18.4h, v2.4h
add	v19.4h, v19.4h, v3.4h
b.gt	L_3374
trn1	v0.2d, v2.2d, v3.2d
trn1	v1.2d, v2.2d, v3.2d
L_33c4:
cbz	w4, L_33e8
L_33c8:
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], #32
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
st1	{ v0.8h, v1.8h }, [x0], #32
add	v18.8h, v18.8h, v0.8h
add	v19.8h, v19.8h, v1.8h
b.gt	L_33c8
L_33e8:
add	v0.8h, v16.8h, v17.8h
add	v2.8h, v18.8h, v19.8h
uaddlp	v0.4s, v0.8h
uaddlp	v2.4s, v2.8h
add	v0.4s, v0.4s, v2.4s
addv	s0, v0.4s
sub	x0, x0, w6, uxtw #4
urshl	v4.2s, v0.2s, v31.2s
dup	v4.8h, v4.h[0]
L_340c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0]
subs	w6, w6, #0x4
sub	v0.8h, v0.8h, v4.8h
sub	v1.8h, v1.8h, v4.8h
sub	v2.8h, v2.8h, v4.8h
sub	v3.8h, v3.8h, v4.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
b.gt	L_340c
ret
L_3430:
adrp	x7, ipred_cfl_ac_420_w16_tbl
add	x7, x7, :lo12:ipred_cfl_ac_420_w16_tbl
ldrsw	x3, [x7, w3, uxtw #2]
add	x7, x7, x3
br	x7
L_3444:
ld1	{ v0.16b, v1.16b }, [x1], x2
ld1	{ v2.16b, v3.16b }, [x10], x2
uaddlp	v0.8h, v0.16b
ld1	{ v4.16b, v5.16b }, [x1], x2
uaddlp	v1.8h, v1.16b
ld1	{ v6.16b, v7.16b }, [x10], x2
uaddlp	v2.8h, v2.16b
uaddlp	v3.8h, v3.16b
uaddlp	v4.8h, v4.16b
uaddlp	v5.8h, v5.16b
uaddlp	v6.8h, v6.16b
uaddlp	v7.8h, v7.16b
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
add	v4.8h, v4.8h, v6.8h
add	v5.8h, v5.8h, v7.8h
shl	v0.8h, v0.8h, #0x1
shl	v1.8h, v1.8h, #0x1
shl	v2.8h, v4.8h, #0x1
shl	v3.8h, v5.8h, #0x1
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_3444
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
L_34bc:
ldr	d1, [x1, #0x10]
ld1	{ v0.16b }, [x1], x2
ldr	d3, [x10, #0x10]
ld1	{ v2.16b }, [x10], x2
uaddlp	v1.4h, v1.8b
ldr	d5, [x1, #0x10]
uaddlp	v0.8h, v0.16b
ld1	{ v4.16b }, [x1], x2
uaddlp	v3.4h, v3.8b
ldr	d7, [x10, #0x10]
uaddlp	v2.8h, v2.16b
ld1	{ v6.16b }, [x10], x2
uaddlp	v5.4h, v5.8b
uaddlp	v4.8h, v4.16b
uaddlp	v7.4h, v7.8b
uaddlp	v6.8h, v6.16b
add	v1.4h, v1.4h, v3.4h
add	v0.8h, v0.8h, v2.8h
add	v5.4h, v5.4h, v7.4h
add	v4.8h, v4.8h, v6.8h
shl	v1.4h, v1.4h, #0x1
shl	v0.8h, v0.8h, #0x1
shl	v3.4h, v5.4h, #0x1
shl	v2.8h, v4.8h, #0x1
dup	v4.4h, v1.h[3]
dup	v5.4h, v3.h[3]
trn1	v1.2d, v1.2d, v4.2d
trn1	v3.2d, v3.2d, v5.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_34bc
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
L_3554:
ld1	{ v0.16b }, [x1], x2
ld1	{ v2.16b }, [x10], x2
ld1	{ v4.16b }, [x1], x2
uaddlp	v0.8h, v0.16b
ld1	{ v6.16b }, [x10], x2
uaddlp	v2.8h, v2.16b
uaddlp	v4.8h, v4.16b
uaddlp	v6.8h, v6.16b
add	v0.8h, v0.8h, v2.8h
add	v4.8h, v4.8h, v6.8h
shl	v0.8h, v0.8h, #0x1
shl	v2.8h, v4.8h, #0x1
dup	v1.8h, v0.h[7]
dup	v3.8h, v2.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_3554
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
L_35b4:
ld1	{ v0.8b }, [x1], x2
ld1	{ v2.8b }, [x10], x2
ld1	{ v4.8b }, [x1], x2
uaddlp	v0.4h, v0.8b
ld1	{ v6.8b }, [x10], x2
uaddlp	v2.4h, v2.8b
uaddlp	v4.4h, v4.8b
uaddlp	v6.4h, v6.8b
add	v0.4h, v0.4h, v2.4h
add	v4.4h, v4.4h, v6.4h
shl	v0.4h, v0.4h, #0x1
shl	v2.4h, v4.4h, #0x1
dup	v1.8h, v0.h[3]
dup	v3.8h, v2.h[3]
trn1	v0.2d, v0.2d, v1.2d
trn1	v2.2d, v2.2d, v3.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_35b4
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
L_3618:
cbz	w4, L_364c
L_361c:
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_361c
L_364c:
lsl	w6, w6, #1
b	L_33e8
ipred_cfl_ac_422_8bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adrp	x7, ipred_cfl_ac_422_tbl
add	x7, x7, :lo12:ipred_cfl_ac_422_tbl
sub	w8, w8, #0x1b
ldrsw	x8, [x7, w8, uxtw #2]
movi	v16.8h, #0x0
movi	v17.8h, #0x0
movi	v18.8h, #0x0
movi	v19.8h, #0x0
add	x7, x7, x8
sub	w8, w6, w4
rbit	w9, w5
rbit	w10, w6
clz	w9, w9
clz	w10, w10
add	w9, w9, w10
add	x10, x1, x2
dup	v31.4s, w9
lsl	x2, x2, #1
neg	v31.4s, v31.4s
br	x7
L_36ac:
ld1	{ v0.8b }, [x1], x2
ld1	{ v0.d }[1], [x10], x2
ld1	{ v1.8b }, [x1], x2
ld1	{ v1.d }[1], [x10], x2
uaddlp	v0.8h, v0.16b
uaddlp	v1.8h, v1.16b
shl	v0.8h, v0.8h, #0x2
shl	v1.8h, v1.8h, #0x2
subs	w8, w8, #0x4
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
st1	{ v0.8h, v1.8h }, [x0], #32
b.gt	L_36ac
trn2	v0.2d, v1.2d, v1.2d
trn2	v1.2d, v1.2d, v1.2d
b	L_32dc
L_36ec:
cbnz	w3, L_3748
L_36f0:
ld1	{ v0.16b }, [x1], x2
ld1	{ v1.16b }, [x10], x2
ld1	{ v2.16b }, [x1], x2
uaddlp	v0.8h, v0.16b
ld1	{ v3.16b }, [x10], x2
uaddlp	v1.8h, v1.16b
uaddlp	v2.8h, v2.16b
uaddlp	v3.8h, v3.16b
shl	v0.8h, v0.8h, #0x2
shl	v1.8h, v1.8h, #0x2
shl	v2.8h, v2.8h, #0x2
shl	v3.8h, v3.8h, #0x2
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_36f0
mov	v0.16b, v3.16b
mov	v1.16b, v3.16b
b	L_33c4
L_3748:
ld1	{ v0.8b }, [x1], x2
ld1	{ v0.d }[1], [x10], x2
ld1	{ v2.8b }, [x1], x2
ld1	{ v2.d }[1], [x10], x2
uaddlp	v0.8h, v0.16b
uaddlp	v2.8h, v2.16b
shl	v0.8h, v0.8h, #0x2
shl	v2.8h, v2.8h, #0x2
dup	v4.4h, v0.h[3]
dup	v5.8h, v0.h[7]
dup	v6.4h, v2.h[3]
dup	v7.8h, v2.h[7]
trn2	v1.2d, v0.2d, v5.2d
trn1	v0.2d, v0.2d, v4.2d
trn2	v3.2d, v2.2d, v7.2d
trn1	v2.2d, v2.2d, v6.2d
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_3748
mov	v0.16b, v3.16b
mov	v1.16b, v3.16b
b	L_33c4
L_37b0:
adrp	x7, ipred_cfl_ac_422_w16_tbl
add	x7, x7, :lo12:ipred_cfl_ac_422_w16_tbl
ldrsw	x3, [x7, w3, uxtw #2]
add	x7, x7, x3
br	x7
L_37c4:
ld1	{ v0.16b, v1.16b }, [x1], x2
ld1	{ v2.16b, v3.16b }, [x10], x2
uaddlp	v0.8h, v0.16b
uaddlp	v1.8h, v1.16b
uaddlp	v2.8h, v2.16b
uaddlp	v3.8h, v3.16b
shl	v0.8h, v0.8h, #0x2
shl	v1.8h, v1.8h, #0x2
shl	v2.8h, v2.8h, #0x2
shl	v3.8h, v3.8h, #0x2
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_37c4
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
L_3814:
ldr	d1, [x1, #0x10]
ld1	{ v0.16b }, [x1], x2
ldr	d3, [x10, #0x10]
ld1	{ v2.16b }, [x10], x2
uaddlp	v1.4h, v1.8b
uaddlp	v0.8h, v0.16b
uaddlp	v3.4h, v3.8b
uaddlp	v2.8h, v2.16b
shl	v1.4h, v1.4h, #0x2
shl	v0.8h, v0.8h, #0x2
shl	v3.4h, v3.4h, #0x2
shl	v2.8h, v2.8h, #0x2
dup	v4.4h, v1.h[3]
dup	v5.4h, v3.h[3]
trn1	v1.2d, v1.2d, v4.2d
trn1	v3.2d, v3.2d, v5.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_3814
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
L_387c:
ld1	{ v0.16b }, [x1], x2
ld1	{ v2.16b }, [x10], x2
uaddlp	v0.8h, v0.16b
uaddlp	v2.8h, v2.16b
shl	v0.8h, v0.8h, #0x2
shl	v2.8h, v2.8h, #0x2
dup	v1.8h, v0.h[7]
dup	v3.8h, v2.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_387c
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
L_38c4:
ld1	{ v0.8b }, [x1], x2
ld1	{ v2.8b }, [x10], x2
uaddlp	v0.4h, v0.8b
uaddlp	v2.4h, v2.8b
shl	v0.4h, v0.4h, #0x2
shl	v2.4h, v2.4h, #0x2
dup	v1.8h, v0.h[3]
dup	v3.8h, v2.h[3]
trn1	v0.2d, v0.2d, v1.2d
trn1	v2.2d, v2.2d, v3.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_38c4
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3618
ipred_cfl_ac_444_8bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adrp	x7, ipred_cfl_ac_444_tbl
add	x7, x7, :lo12:ipred_cfl_ac_444_tbl
sub	w8, w8, #0x1a
ldrsw	x8, [x7, w8, uxtw #2]
movi	v16.8h, #0x0
movi	v17.8h, #0x0
movi	v18.8h, #0x0
movi	v19.8h, #0x0
add	x7, x7, x8
sub	w8, w6, w4
rbit	w9, w5
rbit	w10, w6
clz	w9, w9
clz	w10, w10
add	w9, w9, w10
add	x10, x1, x2
dup	v31.4s, w9
lsl	x2, x2, #1
neg	v31.4s, v31.4s
br	x7
L_396c:
ld1	{ v0.s }[0], [x1], x2
ld1	{ v0.s }[1], [x10], x2
ld1	{ v1.s }[0], [x1], x2
ld1	{ v1.s }[1], [x10], x2
ushll	v0.8h, v0.8b, #0x3
ushll	v1.8h, v1.8b, #0x3
subs	w8, w8, #0x4
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
st1	{ v0.8h, v1.8h }, [x0], #32
b.gt	L_396c
trn2	v0.2d, v1.2d, v1.2d
trn2	v1.2d, v1.2d, v1.2d
b	L_32dc
L_39a4:
ld1	{ v0.8b }, [x1], x2
ld1	{ v1.8b }, [x10], x2
ld1	{ v2.8b }, [x1], x2
ushll	v0.8h, v0.8b, #0x3
ld1	{ v3.8b }, [x10], x2
ushll	v1.8h, v1.8b, #0x3
ushll	v2.8h, v2.8b, #0x3
ushll	v3.8h, v3.8b, #0x3
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
b.gt	L_39a4
mov	v0.16b, v3.16b
mov	v1.16b, v3.16b
b	L_33c4
L_39ec:
cbnz	w3, L_3a64
L_39f0:
ld1	{ v0.16b }, [x1], x2
ld1	{ v2.16b }, [x10], x2
ld1	{ v4.16b }, [x1], x2
ushll2	v1.8h, v0.16b, #0x3
ushll	v0.8h, v0.8b, #0x3
ld1	{ v6.16b }, [x10], x2
ushll2	v3.8h, v2.16b, #0x3
ushll	v2.8h, v2.8b, #0x3
ushll2	v5.8h, v4.16b, #0x3
ushll	v4.8h, v4.8b, #0x3
ushll2	v7.8h, v6.16b, #0x3
ushll	v6.8h, v6.8b, #0x3
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_39f0
mov	v0.16b, v6.16b
mov	v1.16b, v7.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
b	L_3618
L_3a64:
ld1	{ v0.8b }, [x1], x2
ld1	{ v2.8b }, [x10], x2
ld1	{ v4.8b }, [x1], x2
ld1	{ v6.8b }, [x10], x2
ushll	v0.8h, v0.8b, #0x3
ushll	v2.8h, v2.8b, #0x3
ushll	v4.8h, v4.8b, #0x3
ushll	v6.8h, v6.8b, #0x3
dup	v1.8h, v0.h[7]
dup	v3.8h, v2.h[7]
dup	v5.8h, v4.h[7]
dup	v7.8h, v6.h[7]
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_3a64
mov	v0.16b, v6.16b
mov	v1.16b, v7.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
b	L_3618
L_3ad8:
adrp	x7, ipred_cfl_ac_444_w32_tbl
add	x7, x7, :lo12:ipred_cfl_ac_444_w32_tbl
lsr	w3, w3, #1
ldrsw	x3, [x7, w3, uxtw #2]
add	x7, x7, x3
br	x7
L_3af0:
ld1	{ v2.16b, v3.16b }, [x1], x2
ld1	{ v6.16b, v7.16b }, [x10], x2
ushll	v0.8h, v2.8b, #0x3
ushll2	v1.8h, v2.16b, #0x3
ushll	v2.8h, v3.8b, #0x3
ushll2	v3.8h, v3.16b, #0x3
ushll	v4.8h, v6.8b, #0x3
ushll2	v5.8h, v6.16b, #0x3
ushll	v6.8h, v7.8b, #0x3
ushll2	v7.8h, v7.16b, #0x3
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_3af0
b	L_3c64
L_3b4c:
ldr	d2, [x1, #0x10]
ld1	{ v1.16b }, [x1], x2
ldr	d6, [x10, #0x10]
ld1	{ v5.16b }, [x10], x2
ushll	v2.8h, v2.8b, #0x3
ushll	v0.8h, v1.8b, #0x3
ushll2	v1.8h, v1.16b, #0x3
ushll	v6.8h, v6.8b, #0x3
ushll	v4.8h, v5.8b, #0x3
ushll2	v5.8h, v5.16b, #0x3
dup	v3.8h, v2.h[7]
dup	v7.8h, v6.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_3b4c
b	L_3c64
L_3bb0:
ld1	{ v1.16b }, [x1], x2
ld1	{ v5.16b }, [x10], x2
ushll	v0.8h, v1.8b, #0x3
ushll2	v1.8h, v1.16b, #0x3
ushll	v4.8h, v5.8b, #0x3
ushll2	v5.8h, v5.16b, #0x3
dup	v2.8h, v1.h[7]
dup	v3.8h, v1.h[7]
dup	v6.8h, v5.h[7]
dup	v7.8h, v5.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_3bb0
b	L_3c64
L_3c0c:
ld1	{ v0.8b }, [x1], x2
ld1	{ v4.8b }, [x10], x2
ushll	v0.8h, v0.8b, #0x3
ushll	v4.8h, v4.8b, #0x3
dup	v1.8h, v0.h[7]
dup	v2.8h, v0.h[7]
dup	v3.8h, v0.h[7]
dup	v5.8h, v4.h[7]
dup	v6.8h, v4.h[7]
dup	v7.8h, v4.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
add	v16.8h, v16.8h, v0.8h
add	v17.8h, v17.8h, v1.8h
add	v18.8h, v18.8h, v2.8h
add	v19.8h, v19.8h, v3.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_3c0c
L_3c64:
cbz	w4, L_3c98
L_3c68:
subs	w4, w4, #0x2
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], #64
add	v16.8h, v16.8h, v4.8h
add	v17.8h, v17.8h, v5.8h
add	v18.8h, v18.8h, v6.8h
add	v19.8h, v19.8h, v7.8h
b.gt	L_3c68
L_3c98:
lsl	w6, w6, #2
uaddlp	v0.4s, v16.8h
uaddlp	v1.4s, v17.8h
uaddlp	v2.4s, v18.8h
uaddlp	v3.4s, v19.8h
add	v0.4s, v0.4s, v1.4s
add	v2.4s, v2.4s, v3.4s
add	v0.4s, v0.4s, v2.4s
addv	s0, v0.4s
sub	x0, x0, w6, uxtw #4
urshl	v4.2s, v0.2s, v31.2s
dup	v4.8h, v4.h[0]
b	L_340c
	.section *UND*
	.section .rodata
ipred_dc_128_tbl:
	.size ipred_dc_128_tbl, 20
	.word L_9c - ipred_dc_128_tbl
	.word L_7c - ipred_dc_128_tbl
	.word L_60 - ipred_dc_128_tbl
	.word L_44 - ipred_dc_128_tbl
	.word L_28 - ipred_dc_128_tbl
ipred_v_tbl:
	.size ipred_v_tbl, 20
	.word L_16c - ipred_v_tbl
	.word L_14c - ipred_v_tbl
	.word L_12c - ipred_v_tbl
	.word L_10c - ipred_v_tbl
	.word L_ec - ipred_v_tbl
ipred_h_tbl:
	.size ipred_h_tbl, 20
	.word L_248 - ipred_h_tbl
	.word L_218 - ipred_h_tbl
	.word L_1f8 - ipred_h_tbl
	.word L_1d8 - ipred_h_tbl
	.word L_1b8 - ipred_h_tbl
ipred_dc_top_tbl:
	.size ipred_dc_top_tbl, 20
	.word L_36c - ipred_dc_top_tbl
	.word L_334 - ipred_dc_top_tbl
	.word L_308 - ipred_dc_top_tbl
	.word L_2dc - ipred_dc_top_tbl
	.word L_2b0 - ipred_dc_top_tbl
ipred_dc_left_tbl:
	.size ipred_dc_left_tbl, 40
	.word L_4c0 - ipred_dc_left_tbl
	.word L_484 - ipred_dc_left_tbl
	.word L_454 - ipred_dc_left_tbl
	.word L_424 - ipred_dc_left_tbl
	.word L_3f4 - ipred_dc_left_tbl
	.word L_4ec - ipred_dc_left_tbl
	.word L_4a0 - ipred_dc_left_tbl
	.word L_468 - ipred_dc_left_tbl
	.word L_438 - ipred_dc_left_tbl
	.word L_408 - ipred_dc_left_tbl
ipred_dc_tbl:
	.size ipred_dc_tbl, 40
	.word L_714 - ipred_dc_tbl
	.word L_69c - ipred_dc_tbl
	.word L_638 - ipred_dc_tbl
	.word L_5d4 - ipred_dc_tbl
	.word L_568 - ipred_dc_tbl
	.word L_73c - ipred_dc_tbl
	.word L_6b4 - ipred_dc_tbl
	.word L_648 - ipred_dc_tbl
	.word L_5e4 - ipred_dc_tbl
	.word L_57c - ipred_dc_tbl
ipred_paeth_tbl:
	.size ipred_paeth_tbl, 20
	.word L_8d8 - ipred_paeth_tbl
	.word L_8d8 - ipred_paeth_tbl
	.word L_8d8 - ipred_paeth_tbl
	.word L_848 - ipred_paeth_tbl
	.word L_7e4 - ipred_paeth_tbl
ipred_smooth_tbl:
	.size ipred_smooth_tbl, 20
	.word L_b98 - ipred_smooth_tbl
	.word L_b98 - ipred_smooth_tbl
	.word L_b98 - ipred_smooth_tbl
	.word L_ad8 - ipred_smooth_tbl
	.word L_a48 - ipred_smooth_tbl
ipred_smooth_v_tbl:
	.size ipred_smooth_v_tbl, 20
	.word L_d68 - ipred_smooth_v_tbl
	.word L_d68 - ipred_smooth_v_tbl
	.word L_d68 - ipred_smooth_v_tbl
	.word L_d00 - ipred_smooth_v_tbl
	.word L_cb0 - ipred_smooth_v_tbl
ipred_smooth_h_tbl:
	.size ipred_smooth_h_tbl, 20
	.word L_f3c - ipred_smooth_h_tbl
	.word L_f3c - ipred_smooth_h_tbl
	.word L_f3c - ipred_smooth_h_tbl
	.word L_ecc - ipred_smooth_h_tbl
	.word L_e74 - ipred_smooth_h_tbl
padding_mask_buf:
	.size padding_mask_buf, 64
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
padding_mask:
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
edge_filter:
	.size edge_filter, 8
	.byte 0,4,8,0,0,5,6,0
ipred_z1_fill1_tbl:
	.size ipred_z1_fill1_tbl, 20
	.word L_1408 - ipred_z1_fill1_tbl
	.word L_1408 - ipred_z1_fill1_tbl
	.word L_1408 - ipred_z1_fill1_tbl
	.word L_1380 - ipred_z1_fill1_tbl
	.word L_1300 - ipred_z1_fill1_tbl
increments:
	.size increments, 32
	.byte 0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0
	.byte 8,0,9,0,10,0,11,0,12,0,13,0,14,0,15,0
ipred_z2_fill1_tbl:
	.size ipred_z2_fill1_tbl, 20
	.word L_1af4 - ipred_z2_fill1_tbl
	.word L_1af4 - ipred_z2_fill1_tbl
	.word L_18f4 - ipred_z2_fill1_tbl
	.word L_17b0 - ipred_z2_fill1_tbl
	.word L_1690 - ipred_z2_fill1_tbl
ipred_z3_fill1_tbl:
	.size ipred_z3_fill1_tbl, 20
	.word L_2524 - ipred_z3_fill1_tbl
	.word L_2524 - ipred_z3_fill1_tbl
	.word L_2470 - ipred_z3_fill1_tbl
	.word L_23e4 - ipred_z3_fill1_tbl
	.word L_2360 - ipred_z3_fill1_tbl
ipred_z3_fill_padding_tbl:
	.size ipred_z3_fill_padding_tbl, 24
	.word L_282c - ipred_z3_fill_padding_tbl
	.word L_282c - ipred_z3_fill_padding_tbl
	.word L_282c - ipred_z3_fill_padding_tbl
	.word L_27ec - ipred_z3_fill_padding_tbl
	.word L_27ac - ipred_z3_fill_padding_tbl
	.word L_276c - ipred_z3_fill_padding_tbl
ipred_filter_tbl:
	.size ipred_filter_tbl, 16
	.word L_2b1c - ipred_filter_tbl
	.word L_2b1c - ipred_filter_tbl
	.word L_2aa4 - ipred_filter_tbl
	.word L_2a50 - ipred_filter_tbl
pal_pred_tbl:
	.size pal_pred_tbl, 20
	.word L_2d74 - pal_pred_tbl
	.word L_2cf4 - pal_pred_tbl
	.word L_2ca4 - pal_pred_tbl
	.word L_2c6c - pal_pred_tbl
	.word L_2c3c - pal_pred_tbl
ipred_cfl_128_tbl:
	.size ipred_cfl_128_tbl, 16
ipred_cfl_splat_tbl:
	.word L_2ee8 - ipred_cfl_128_tbl
	.word L_2ee8 - ipred_cfl_128_tbl
	.word L_2e68 - ipred_cfl_128_tbl
	.word L_2e18 - ipred_cfl_128_tbl
ipred_cfl_top_tbl:
	.size ipred_cfl_top_tbl, 16
	.word L_2ff4 - ipred_cfl_top_tbl
	.word L_2fe0 - ipred_cfl_top_tbl
	.word L_2fcc - ipred_cfl_top_tbl
	.word L_2fb8 - ipred_cfl_top_tbl
ipred_cfl_left_tbl:
	.size ipred_cfl_left_tbl, 16
	.word L_3090 - ipred_cfl_left_tbl
	.word L_307c - ipred_cfl_left_tbl
	.word L_3068 - ipred_cfl_left_tbl
	.word L_3054 - ipred_cfl_left_tbl
ipred_cfl_tbl:
	.size ipred_cfl_tbl, 32
	.word L_31f0 - ipred_cfl_tbl
	.word L_31a4 - ipred_cfl_tbl
	.word L_3158 - ipred_cfl_tbl
	.word L_3104 - ipred_cfl_tbl
	.word L_3208 - ipred_cfl_tbl
	.word L_31b4 - ipred_cfl_tbl
	.word L_3168 - ipred_cfl_tbl
	.word L_3118 - ipred_cfl_tbl
ipred_cfl_ac_420_tbl:
	.size ipred_cfl_ac_420_tbl, 12
	.word L_3430 - ipred_cfl_ac_420_tbl
	.word L_3324 - ipred_cfl_ac_420_tbl
	.word L_32a4 - ipred_cfl_ac_420_tbl
ipred_cfl_ac_420_w16_tbl:
	.size ipred_cfl_ac_420_w16_tbl, 16
	.word L_3444 - ipred_cfl_ac_420_w16_tbl
	.word L_34bc - ipred_cfl_ac_420_w16_tbl
	.word L_3554 - ipred_cfl_ac_420_w16_tbl
	.word L_35b4 - ipred_cfl_ac_420_w16_tbl
ipred_cfl_ac_422_tbl:
	.size ipred_cfl_ac_422_tbl, 12
	.word L_37b0 - ipred_cfl_ac_422_tbl
	.word L_36ec - ipred_cfl_ac_422_tbl
	.word L_36ac - ipred_cfl_ac_422_tbl
ipred_cfl_ac_422_w16_tbl:
	.size ipred_cfl_ac_422_w16_tbl, 16
	.word L_37c4 - ipred_cfl_ac_422_w16_tbl
	.word L_3814 - ipred_cfl_ac_422_w16_tbl
	.word L_387c - ipred_cfl_ac_422_w16_tbl
	.word L_38c4 - ipred_cfl_ac_422_w16_tbl
ipred_cfl_ac_444_tbl:
	.size ipred_cfl_ac_444_tbl, 16
	.word L_3ad8 - ipred_cfl_ac_444_tbl
	.word L_39ec - ipred_cfl_ac_444_tbl
	.word L_39a4 - ipred_cfl_ac_444_tbl
	.word L_396c - ipred_cfl_ac_444_tbl
ipred_cfl_ac_444_w32_tbl:
	.size ipred_cfl_ac_444_w32_tbl, 16
	.word L_3af0 - ipred_cfl_ac_444_w32_tbl
	.word L_3b4c - ipred_cfl_ac_444_w32_tbl
	.word L_3bb0 - ipred_cfl_ac_444_w32_tbl
	.word L_3c0c - ipred_cfl_ac_444_w32_tbl
