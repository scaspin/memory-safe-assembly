	.text
cdef_padding8_8bpc_neon:
cmp	w7, #0xf
b.eq	cdef_padding8_edged_8bpc_neon
movi	v30.8h, #0x80, lsl #8
mov	v31.16b, v30.16b
sub	x0, x0, #0x44
tst	w7, #0x4
b.ne	L_28
st1	{ v30.8h, v31.8h }, [x0], #32
st1	{ v30.8h, v31.8h }, [x0], #32
b	L_140
L_28:
add	x9, x4, x2
tst	w7, #0x1
b.eq	L_c4
sub	x4, x4, #0x2
sub	x9, x9, #0x2
tst	w7, #0x2
b.eq	L_80
ldr	d0, [x4]
ldr	s1, [x4, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	q0, [x0]
str	d1, [x0, #0x10]
add	x0, x0, #0x20
str	q2, [x0]
str	d3, [x0, #0x10]
add	x0, x0, #0x20
b	L_140
L_80:
ldr	d0, [x4]
ldr	h1, [x4, #0x8]
ldr	d2, [x9]
ldr	h3, [x9, #0x8]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	q0, [x0]
str	s1, [x0, #0x10]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	q2, [x0]
str	s3, [x0, #0x10]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
b	L_140
L_c4:
tst	w7, #0x2
b.eq	L_110
ldr	d0, [x4]
ldr	h1, [x4, #0x8]
ldr	d2, [x9]
ldr	h3, [x9, #0x8]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s1, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q2, [x0, #0x4]
str	s3, [x0, #0x14]
add	x0, x0, #0x20
b	L_140
L_110:
ldr	d0, [x4]
ldr	d1, [x9]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q1, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
L_140:
tst	w7, #0x1
b.eq	L_1b0
tst	w7, #0x2
b.eq	L_184
L_150:
ld1	{ v0.h }[0], [x3], #2
ldr	h2, [x1, #0x8]
ld1	{ v1.8b }, [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
str	s0, [x0]
stur	q1, [x0, #0x4]
str	s2, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_150
b	L_204
L_184:
ld1	{ v0.h }[0], [x3], #2
ld1	{ v1.8b }, [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s0, [x0]
stur	q1, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_184
b	L_204
L_1b0:
tst	w7, #0x2
b.eq	L_1e4
L_1b8:
ldr	h1, [x1, #0x8]
ld1	{ v0.8b }, [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s1, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_1b8
b	L_204
L_1e4:
ld1	{ v0.8b }, [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_1e4
L_204:
tst	w7, #0x8
b.ne	L_218
st1	{ v30.8h, v31.8h }, [x0], #32
st1	{ v30.8h, v31.8h }, [x0], #32
ret
L_218:
add	x9, x5, x2
tst	w7, #0x1
b.eq	L_2ac
sub	x5, x5, #0x2
sub	x9, x9, #0x2
tst	w7, #0x2
b.eq	L_26c
ldr	d0, [x5]
ldr	s1, [x5, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	q0, [x0]
str	d1, [x0, #0x10]
add	x0, x0, #0x20
str	q2, [x0]
str	d3, [x0, #0x10]
ret
L_26c:
ldr	d0, [x5]
ldr	h1, [x5, #0x8]
ldr	d2, [x9]
ldr	h3, [x9, #0x8]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	q0, [x0]
str	s1, [x0, #0x10]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	q2, [x0]
str	s3, [x0, #0x10]
str	s31, [x0, #0x14]
ret
L_2ac:
tst	w7, #0x2
b.eq	L_2f4
ldr	d0, [x5]
ldr	h1, [x5, #0x8]
ldr	d2, [x9]
ldr	h3, [x9, #0x8]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s1, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q2, [x0, #0x4]
str	s3, [x0, #0x14]
ret
L_2f4:
ldr	d0, [x5]
ldr	d1, [x9]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q1, [x0, #0x4]
str	s31, [x0, #0x14]
ret
cdef_padding4_8bpc_neon:
cmp	w7, #0xf
b.eq	cdef_padding4_edged_8bpc_neon
movi	v30.8h, #0x80, lsl #8
mov	v31.16b, v30.16b
sub	x0, x0, #0x24
tst	w7, #0x4
b.ne	L_348
st1	{ v30.8h, v31.8h }, [x0], #32
b	L_460
L_348:
add	x9, x4, x2
tst	w7, #0x1
b.eq	L_3e4
sub	x4, x4, #0x2
sub	x9, x9, #0x2
tst	w7, #0x2
b.eq	L_3a0
ldr	s0, [x4]
ldr	s1, [x4, #0x4]
ldr	s2, [x9]
ldr	s3, [x9, #0x4]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	d0, [x0]
str	d1, [x0, #0x8]
add	x0, x0, #0x10
str	d2, [x0]
str	d3, [x0, #0x8]
add	x0, x0, #0x10
b	L_460
L_3a0:
ldr	s0, [x4]
ldr	h1, [x4, #0x4]
ldr	s2, [x9]
ldr	h3, [x9, #0x4]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	d0, [x0]
str	s1, [x0, #0x8]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	d2, [x0]
str	s3, [x0, #0x8]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
b	L_460
L_3e4:
tst	w7, #0x2
b.eq	L_430
ldr	s0, [x4]
ldr	h1, [x4, #0x4]
ldr	s2, [x9]
ldr	h3, [x9, #0x4]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s1, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d2, [x0, #0x4]
str	s3, [x0, #0xc]
add	x0, x0, #0x10
b	L_460
L_430:
ldr	s0, [x4]
ldr	s1, [x9]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d1, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
L_460:
tst	w7, #0x1
b.eq	L_4d0
tst	w7, #0x2
b.eq	L_4a4
L_470:
ld1	{ v0.h }[0], [x3], #2
ldr	h2, [x1, #0x4]
ld1	{ v1.s }[0], [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
str	s0, [x0]
stur	d1, [x0, #0x4]
str	s2, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_470
b	L_524
L_4a4:
ld1	{ v0.h }[0], [x3], #2
ld1	{ v1.s }[0], [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s0, [x0]
stur	d1, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_4a4
b	L_524
L_4d0:
tst	w7, #0x2
b.eq	L_504
L_4d8:
ldr	h1, [x1, #0x4]
ld1	{ v0.s }[0], [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s1, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_4d8
b	L_524
L_504:
ld1	{ v0.s }[0], [x1], x2
subs	w6, w6, #0x1
ushll	v0.8h, v0.8b, #0x0
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_504
L_524:
tst	w7, #0x8
b.ne	L_534
st1	{ v30.8h, v31.8h }, [x0], #32
ret
L_534:
add	x9, x5, x2
tst	w7, #0x1
b.eq	L_5c8
sub	x5, x5, #0x2
sub	x9, x9, #0x2
tst	w7, #0x2
b.eq	L_588
ldr	s0, [x5]
ldr	s1, [x5, #0x4]
ldr	s2, [x9]
ldr	s3, [x9, #0x4]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	d0, [x0]
str	d1, [x0, #0x8]
add	x0, x0, #0x10
str	d2, [x0]
str	d3, [x0, #0x8]
ret
L_588:
ldr	s0, [x5]
ldr	h1, [x5, #0x4]
ldr	s2, [x9]
ldr	h3, [x9, #0x4]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	d0, [x0]
str	s1, [x0, #0x8]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	d2, [x0]
str	s3, [x0, #0x8]
str	s31, [x0, #0xc]
ret
L_5c8:
tst	w7, #0x2
b.eq	L_610
ldr	s0, [x5]
ldr	h1, [x5, #0x4]
ldr	s2, [x9]
ldr	h3, [x9, #0x4]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s1, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d2, [x0, #0x4]
str	s3, [x0, #0xc]
ret
L_610:
ldr	s0, [x5]
ldr	s1, [x9]
ushll	v0.8h, v0.8b, #0x0
ushll	v1.8h, v1.8b, #0x0
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d1, [x0, #0x4]
str	s31, [x0, #0xc]
ret
cdef_padding8_edged_8bpc_neon:
sub	x4, x4, #0x2
sub	x5, x5, #0x2
sub	x0, x0, #0x22
add	x9, x4, x2
ldr	d0, [x4]
ldr	s1, [x4, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
str	d0, [x0]
str	s1, [x0, #0x8]
str	d2, [x0, #0x10]
str	s3, [x0, #0x18]
add	x0, x0, #0x20
L_674:
ld1	{ v0.h }[0], [x3], #2
ldr	h2, [x1, #0x8]
ld1	{ v1.8b }, [x1], x2
subs	w6, w6, #0x1
str	h0, [x0]
stur	d1, [x0, #0x2]
str	h2, [x0, #0xa]
add	x0, x0, #0x10
b.gt	L_674
add	x9, x5, x2
ldr	d0, [x5]
ldr	s1, [x5, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
str	d0, [x0]
str	s1, [x0, #0x8]
str	d2, [x0, #0x10]
str	s3, [x0, #0x18]
ret
cdef_padding4_edged_8bpc_neon:
sub	x4, x4, #0x2
sub	x5, x5, #0x2
sub	x0, x0, #0x12
ldr	d0, [x4]
ldr	d1, [x4, x2]
st1	{ v0.8b, v1.8b }, [x0], #16
L_6d8:
ld1	{ v0.h }[0], [x3], #2
ldr	h2, [x1, #0x4]
ld1	{ v1.s }[0], [x1], x2
subs	w6, w6, #0x1
str	h0, [x0]
stur	s1, [x0, #0x2]
str	h2, [x0, #0x6]
add	x0, x0, #0x8
b.gt	L_6d8
ldr	d0, [x5]
ldr	d1, [x5, x2]
st1	{ v0.8b, v1.8b }, [x0], #16
ret
cdef_filter8_pri_8bpc_neon:
ldr	w8, [sp]
cmp	w8, #0xf
b.eq	cdef_filter8_pri_edged_8bpc_neon
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions8
add	x9, x9, :lo12:directions8
add	x5, x9, w5, uxtw #1
movi	v30.4h, #0xf
dup	v28.4h, w6
dup	v25.8h, w3
trn1	v24.4h, v25.4h, v27.4h
clz	v24.4h, v24.4h
sub	v24.4h, v30.4h, v24.4h
uqsub	v24.4h, v28.4h, v24.4h
neg	v24.4h, v24.4h
dup	v24.8h, v24.h[0]
L_758:
ld1	{ v0.8h }, [x2]
movi	v1.8h, #0x0
mov	w11, #0x2
L_764:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.8h }, [x6]
ld1	{ v5.8h }, [x9]
ldrb	w10, [x8]
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v24.8h
ushl	v21.8h, v20.8h, v24.8h
uqsub	v17.8h, v25.8h, v17.8h
uqsub	v21.8h, v25.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w10
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
add	x5, x5, #0x1
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_764
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
xtn	v0.8b, v0.8h
add	x2, x2, #0x20
subs	w7, w7, #0x1
st1	{ v0.8b }, [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_758
ret
cdef_filter8_sec_8bpc_neon:
ldr	w8, [sp]
cmp	w8, #0xf
b.eq	cdef_filter8_sec_edged_8bpc_neon
adrp	x9, directions8
add	x9, x9, :lo12:directions8
add	x5, x9, w5, uxtw #1
movi	v30.4h, #0xf
dup	v28.4h, w6
dup	v27.8h, w4
trn1	v24.4h, v25.4h, v27.4h
clz	v24.4h, v24.4h
sub	v24.4h, v30.4h, v24.4h
uqsub	v24.4h, v28.4h, v24.4h
neg	v24.4h, v24.4h
dup	v26.8h, v24.h[1]
L_83c:
ld1	{ v0.8h }, [x2]
movi	v1.8h, #0x0
mov	w11, #0x2
L_848:
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v6.8h }, [x6]
ld1	{ v7.8h }, [x9]
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.8h }, [x6]
ld1	{ v5.8h }, [x9]
uabd	v16.8h, v0.8h, v6.8h
uabd	v20.8h, v0.8h, v7.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v6.8h, v0.8h
sub	v22.8h, v7.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
sub	x5, x5, #0xb
subs	w11, w11, #0x1
b.ne	L_848
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
xtn	v0.8b, v0.8h
add	x2, x2, #0x20
subs	w7, w7, #0x1
st1	{ v0.8b }, [x0], x1
sub	x5, x5, #0x2
b.gt	L_83c
ret
cdef_filter8_pri_sec_8bpc_neon:
ldr	w8, [sp]
cmp	w8, #0xf
b.eq	cdef_filter8_pri_sec_edged_8bpc_neon
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions8
add	x9, x9, :lo12:directions8
add	x5, x9, w5, uxtw #1
movi	v30.4h, #0xf
dup	v28.4h, w6
dup	v25.8h, w3
dup	v27.8h, w4
trn1	v24.4h, v25.4h, v27.4h
clz	v24.4h, v24.4h
sub	v24.4h, v30.4h, v24.4h
uqsub	v24.4h, v28.4h, v24.4h
neg	v24.4h, v24.4h
dup	v26.8h, v24.h[1]
dup	v24.8h, v24.h[0]
L_98c:
ld1	{ v0.8h }, [x2]
movi	v1.8h, #0x0
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
mov	w11, #0x2
L_9a0:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.8h }, [x6]
ld1	{ v5.8h }, [x9]
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v6.8h }, [x6]
ld1	{ v7.8h }, [x9]
ldrb	w10, [x8]
umin	v2.8h, v2.8h, v4.8h
smax	v3.8h, v3.8h, v4.8h
umin	v2.8h, v2.8h, v5.8h
smax	v3.8h, v3.8h, v5.8h
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v24.8h
ushl	v21.8h, v20.8h, v24.8h
uqsub	v17.8h, v25.8h, v17.8h
uqsub	v21.8h, v25.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w10
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.8h }, [x6]
ld1	{ v5.8h }, [x9]
umin	v2.8h, v2.8h, v6.8h
smax	v3.8h, v3.8h, v6.8h
umin	v2.8h, v2.8h, v7.8h
smax	v3.8h, v3.8h, v7.8h
uabd	v16.8h, v0.8h, v6.8h
uabd	v20.8h, v0.8h, v7.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v6.8h, v0.8h
sub	v22.8h, v7.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
umin	v2.8h, v2.8h, v4.8h
smax	v3.8h, v3.8h, v4.8h
umin	v2.8h, v2.8h, v5.8h
smax	v3.8h, v3.8h, v5.8h
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
sub	x5, x5, #0xb
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_9a0
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
smin	v0.8h, v0.8h, v3.8h
smax	v0.8h, v0.8h, v2.8h
xtn	v0.8b, v0.8h
add	x2, x2, #0x20
subs	w7, w7, #0x1
st1	{ v0.8b }, [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_98c
ret
cdef_filter8_8bpc_neon:
cbnz	w3, L_b34
b	cdef_filter8_sec_8bpc_neon
L_b34:
cbnz	w4, L_b3c
b	cdef_filter8_pri_8bpc_neon
L_b3c:
b	cdef_filter8_pri_sec_8bpc_neon
cdef_filter4_pri_8bpc_neon:
ldr	w8, [sp]
cmp	w8, #0xf
b.eq	cdef_filter4_pri_edged_8bpc_neon
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions4
add	x9, x9, :lo12:directions4
add	x5, x9, w5, uxtw #1
movi	v30.4h, #0xf
dup	v28.4h, w6
dup	v25.8h, w3
trn1	v24.4h, v25.4h, v27.4h
clz	v24.4h, v24.4h
sub	v24.4h, v30.4h, v24.4h
uqsub	v24.4h, v28.4h, v24.4h
neg	v24.4h, v24.4h
dup	v24.8h, v24.h[0]
L_b8c:
add	x12, x2, #0x10
ld1	{ v0.4h }, [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.8h, #0x0
mov	w11, #0x2
L_ba0:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.4h }, [x6]
add	x6, x6, #0x10
ld1	{ v5.4h }, [x9]
add	x9, x9, #0x10
ld1	{ v4.d }[1], [x6]
ld1	{ v5.d }[1], [x9]
ldrb	w10, [x8]
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v24.8h
ushl	v21.8h, v20.8h, v24.8h
uqsub	v17.8h, v25.8h, v17.8h
uqsub	v21.8h, v25.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w10
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
add	x5, x5, #0x1
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_ba0
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
xtn	v0.8b, v0.8h
st1	{ v0.s }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.s }[1], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_b8c
ret
cdef_filter4_sec_8bpc_neon:
ldr	w8, [sp]
cmp	w8, #0xf
b.eq	cdef_filter4_sec_edged_8bpc_neon
adrp	x9, directions4
add	x9, x9, :lo12:directions4
add	x5, x9, w5, uxtw #1
movi	v30.4h, #0xf
dup	v28.4h, w6
dup	v27.8h, w4
trn1	v24.4h, v25.4h, v27.4h
clz	v24.4h, v24.4h
sub	v24.4h, v30.4h, v24.4h
uqsub	v24.4h, v28.4h, v24.4h
neg	v24.4h, v24.4h
dup	v26.8h, v24.h[1]
L_c8c:
add	x12, x2, #0x10
ld1	{ v0.4h }, [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.8h, #0x0
mov	w11, #0x2
L_ca0:
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v6.4h }, [x6]
add	x6, x6, #0x10
ld1	{ v7.4h }, [x9]
add	x9, x9, #0x10
ld1	{ v6.d }[1], [x6]
ld1	{ v7.d }[1], [x9]
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.4h }, [x6]
add	x6, x6, #0x10
ld1	{ v5.4h }, [x9]
add	x9, x9, #0x10
ld1	{ v4.d }[1], [x6]
ld1	{ v5.d }[1], [x9]
uabd	v16.8h, v0.8h, v6.8h
uabd	v20.8h, v0.8h, v7.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v6.8h, v0.8h
sub	v22.8h, v7.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
sub	x5, x5, #0xb
subs	w11, w11, #0x1
b.ne	L_ca0
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
xtn	v0.8b, v0.8h
st1	{ v0.s }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.s }[1], [x0], x1
sub	x5, x5, #0x2
b.gt	L_c8c
ret
cdef_filter4_pri_sec_8bpc_neon:
ldr	w8, [sp]
cmp	w8, #0xf
b.eq	cdef_filter4_pri_sec_edged_8bpc_neon
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions4
add	x9, x9, :lo12:directions4
add	x5, x9, w5, uxtw #1
movi	v30.4h, #0xf
dup	v28.4h, w6
dup	v25.8h, w3
dup	v27.8h, w4
trn1	v24.4h, v25.4h, v27.4h
clz	v24.4h, v24.4h
sub	v24.4h, v30.4h, v24.4h
uqsub	v24.4h, v28.4h, v24.4h
neg	v24.4h, v24.4h
dup	v26.8h, v24.h[1]
dup	v24.8h, v24.h[0]
L_e08:
add	x12, x2, #0x10
ld1	{ v0.4h }, [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.8h, #0x0
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
mov	w11, #0x2
L_e24:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.4h }, [x6]
add	x6, x6, #0x10
ld1	{ v5.4h }, [x9]
add	x9, x9, #0x10
ld1	{ v4.d }[1], [x6]
ld1	{ v5.d }[1], [x9]
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v6.4h }, [x6]
add	x6, x6, #0x10
ld1	{ v7.4h }, [x9]
add	x9, x9, #0x10
ld1	{ v6.d }[1], [x6]
ld1	{ v7.d }[1], [x9]
ldrb	w10, [x8]
umin	v2.8h, v2.8h, v4.8h
smax	v3.8h, v3.8h, v4.8h
umin	v2.8h, v2.8h, v5.8h
smax	v3.8h, v3.8h, v5.8h
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v24.8h
ushl	v21.8h, v20.8h, v24.8h
uqsub	v17.8h, v25.8h, v17.8h
uqsub	v21.8h, v25.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w10
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1	{ v4.4h }, [x6]
add	x6, x6, #0x10
ld1	{ v5.4h }, [x9]
add	x9, x9, #0x10
ld1	{ v4.d }[1], [x6]
ld1	{ v5.d }[1], [x9]
umin	v2.8h, v2.8h, v6.8h
smax	v3.8h, v3.8h, v6.8h
umin	v2.8h, v2.8h, v7.8h
smax	v3.8h, v3.8h, v7.8h
uabd	v16.8h, v0.8h, v6.8h
uabd	v20.8h, v0.8h, v7.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v6.8h, v0.8h
sub	v22.8h, v7.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
umin	v2.8h, v2.8h, v4.8h
smax	v3.8h, v3.8h, v4.8h
umin	v2.8h, v2.8h, v5.8h
smax	v3.8h, v3.8h, v5.8h
uabd	v16.8h, v0.8h, v4.8h
uabd	v20.8h, v0.8h, v5.8h
ushl	v17.8h, v16.8h, v26.8h
ushl	v21.8h, v20.8h, v26.8h
uqsub	v17.8h, v27.8h, v17.8h
uqsub	v21.8h, v27.8h, v21.8h
sub	v18.8h, v4.8h, v0.8h
sub	v22.8h, v5.8h, v0.8h
neg	v16.8h, v17.8h
neg	v20.8h, v21.8h
smin	v18.8h, v18.8h, v17.8h
smin	v22.8h, v22.8h, v21.8h
dup	v19.8h, w11
smax	v18.8h, v18.8h, v16.8h
smax	v22.8h, v22.8h, v20.8h
mla	v1.8h, v18.8h, v19.8h
mla	v1.8h, v22.8h, v19.8h
sub	x5, x5, #0xb
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_e24
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
smin	v0.8h, v0.8h, v3.8h
smax	v0.8h, v0.8h, v2.8h
xtn	v0.8b, v0.8h
st1	{ v0.s }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.s }[1], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_e08
ret
cdef_filter4_8bpc_neon:
cbnz	w3, L_fec
b	cdef_filter4_sec_8bpc_neon
L_fec:
cbnz	w4, L_ff4
b	cdef_filter4_pri_8bpc_neon
L_ff4:
b	cdef_filter4_pri_sec_8bpc_neon
cdef_find_dir_8bpc_neon:
sub	sp, sp, #0x20
mov	w3, #0x8
movi	v31.16b, #0x80
movi	v30.16b, #0x0
movi	v1.8h, #0x0
movi	v3.8h, #0x0
movi	v5.8h, #0x0
movi	v7.8h, #0x0
ld1	{ v26.8b }, [x0], x1
movi	v17.8h, #0x0
movi	v18.8h, #0x0
usubl	v26.8h, v26.8b, v31.8b
movi	v19.8h, #0x0
movi	v21.8h, #0x0
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[0], v25.h[0]
ext	v22.16b, v30.16b, v26.16b, #0xa
ext	v23.16b, v26.16b, v30.16b, #0xa
add	v18.8h, v18.8h, v22.8h
add	v19.4h, v19.4h, v23.4h
mov	v20.16b, v26.16b
mov	v0.16b, v26.16b
ld1	{ v26.8b }, [x0], x1
mov	v2.16b, v27.16b
usubl	v26.8h, v26.8b, v31.8b
mov	v6.16b, v28.16b
mov	v16.16b, v29.16b
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[1], v25.h[0]
ext	v22.16b, v30.16b, v26.16b, #0xa
ext	v23.16b, v26.16b, v30.16b, #0xa
add	v18.8h, v18.8h, v22.8h
add	v19.4h, v19.4h, v23.4h
add	v20.8h, v20.8h, v26.8h
ext	v22.16b, v30.16b, v26.16b, #0xe
ext	v23.16b, v26.16b, v30.16b, #0xe
ext	v24.16b, v30.16b, v27.16b, #0xe
ext	v25.16b, v27.16b, v30.16b, #0xe
ld1	{ v26.8b }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
usubl	v26.8h, v26.8b, v31.8b
ext	v22.16b, v30.16b, v28.16b, #0xe
ext	v23.16b, v28.16b, v30.16b, #0xe
ext	v24.16b, v30.16b, v29.16b, #0xe
ext	v25.16b, v29.16b, v30.16b, #0xe
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[2], v25.h[0]
ext	v22.16b, v30.16b, v26.16b, #0xc
ext	v23.16b, v26.16b, v30.16b, #0xc
add	v18.8h, v18.8h, v22.8h
add	v19.4h, v19.4h, v23.4h
ext	v24.16b, v30.16b, v26.16b, #0xe
ext	v25.16b, v26.16b, v30.16b, #0xe
add	v20.8h, v20.8h, v24.8h
add	v21.4h, v21.4h, v25.4h
ext	v22.16b, v30.16b, v26.16b, #0xc
ext	v23.16b, v26.16b, v30.16b, #0xc
ext	v24.16b, v30.16b, v27.16b, #0xc
ext	v25.16b, v27.16b, v30.16b, #0xc
ld1	{ v26.8b }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
usubl	v26.8h, v26.8b, v31.8b
ext	v22.16b, v30.16b, v28.16b, #0xc
ext	v23.16b, v28.16b, v30.16b, #0xc
ext	v24.16b, v30.16b, v29.16b, #0xc
ext	v25.16b, v29.16b, v30.16b, #0xc
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[3], v25.h[0]
ext	v22.16b, v30.16b, v26.16b, #0xc
ext	v23.16b, v26.16b, v30.16b, #0xc
add	v18.8h, v18.8h, v22.8h
add	v19.4h, v19.4h, v23.4h
ext	v24.16b, v30.16b, v26.16b, #0xe
ext	v25.16b, v26.16b, v30.16b, #0xe
add	v20.8h, v20.8h, v24.8h
add	v21.4h, v21.4h, v25.4h
ext	v22.16b, v30.16b, v26.16b, #0xa
ext	v23.16b, v26.16b, v30.16b, #0xa
ext	v24.16b, v30.16b, v27.16b, #0xa
ext	v25.16b, v27.16b, v30.16b, #0xa
ld1	{ v26.8b }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
usubl	v26.8h, v26.8b, v31.8b
ext	v22.16b, v30.16b, v28.16b, #0xa
ext	v23.16b, v28.16b, v30.16b, #0xa
ext	v24.16b, v30.16b, v29.16b, #0xa
ext	v25.16b, v29.16b, v30.16b, #0xa
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[4], v25.h[0]
ext	v22.16b, v30.16b, v26.16b, #0xe
ext	v23.16b, v26.16b, v30.16b, #0xe
add	v18.8h, v18.8h, v22.8h
add	v19.4h, v19.4h, v23.4h
ext	v24.16b, v30.16b, v26.16b, #0xc
ext	v25.16b, v26.16b, v30.16b, #0xc
add	v20.8h, v20.8h, v24.8h
add	v21.4h, v21.4h, v25.4h
ext	v22.16b, v30.16b, v26.16b, #0x8
ext	v23.16b, v26.16b, v30.16b, #0x8
ext	v24.16b, v30.16b, v27.16b, #0x8
ext	v25.16b, v27.16b, v30.16b, #0x8
ld1	{ v26.8b }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
usubl	v26.8h, v26.8b, v31.8b
ext	v22.16b, v30.16b, v28.16b, #0x8
ext	v23.16b, v28.16b, v30.16b, #0x8
ext	v24.16b, v30.16b, v29.16b, #0x8
ext	v25.16b, v29.16b, v30.16b, #0x8
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[5], v25.h[0]
ext	v22.16b, v30.16b, v26.16b, #0xe
ext	v23.16b, v26.16b, v30.16b, #0xe
add	v18.8h, v18.8h, v22.8h
add	v19.4h, v19.4h, v23.4h
ext	v24.16b, v30.16b, v26.16b, #0xc
ext	v25.16b, v26.16b, v30.16b, #0xc
add	v20.8h, v20.8h, v24.8h
add	v21.4h, v21.4h, v25.4h
ext	v22.16b, v30.16b, v26.16b, #0x6
ext	v23.16b, v26.16b, v30.16b, #0x6
ext	v24.16b, v30.16b, v27.16b, #0x6
ext	v25.16b, v27.16b, v30.16b, #0x6
ld1	{ v26.8b }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
usubl	v26.8h, v26.8b, v31.8b
ext	v22.16b, v30.16b, v28.16b, #0x6
ext	v23.16b, v28.16b, v30.16b, #0x6
ext	v24.16b, v30.16b, v29.16b, #0x6
ext	v25.16b, v29.16b, v30.16b, #0x6
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[6], v25.h[0]
add	v18.8h, v18.8h, v26.8h
ext	v24.16b, v30.16b, v26.16b, #0xa
ext	v25.16b, v26.16b, v30.16b, #0xa
add	v20.8h, v20.8h, v24.8h
add	v21.4h, v21.4h, v25.4h
ext	v22.16b, v30.16b, v26.16b, #0x4
ext	v23.16b, v26.16b, v30.16b, #0x4
ext	v24.16b, v30.16b, v27.16b, #0x4
ext	v25.16b, v27.16b, v30.16b, #0x4
ld1	{ v26.8b }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
usubl	v26.8h, v26.8b, v31.8b
ext	v22.16b, v30.16b, v28.16b, #0x4
ext	v23.16b, v28.16b, v30.16b, #0x4
ext	v24.16b, v30.16b, v29.16b, #0x4
ext	v25.16b, v29.16b, v30.16b, #0x4
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
addv	h25, v26.8h
rev64	v27.8h, v26.8h
addp	v28.8h, v26.8h, v30.8h
add	v5.8h, v5.8h, v26.8h
ext	v27.16b, v27.16b, v27.16b, #0x8
rev64	v29.4h, v28.4h
mov	v4.h[7], v25.h[0]
add	v18.8h, v18.8h, v26.8h
ext	v24.16b, v30.16b, v26.16b, #0xa
ext	v25.16b, v26.16b, v30.16b, #0xa
add	v20.8h, v20.8h, v24.8h
add	v21.4h, v21.4h, v25.4h
ext	v22.16b, v30.16b, v26.16b, #0x2
ext	v23.16b, v26.16b, v30.16b, #0x2
ext	v24.16b, v30.16b, v27.16b, #0x2
ext	v25.16b, v27.16b, v30.16b, #0x2
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ext	v22.16b, v30.16b, v28.16b, #0x2
ext	v23.16b, v28.16b, v30.16b, #0x2
ext	v24.16b, v30.16b, v29.16b, #0x2
ext	v25.16b, v29.16b, v30.16b, #0x2
add	v6.8h, v6.8h, v22.8h
add	v7.4h, v7.4h, v23.4h
add	v16.8h, v16.8h, v24.8h
add	v17.4h, v17.4h, v25.4h
movi	v31.4s, #0x69
smull	v26.4s, v4.4h, v4.4h
smlal2	v26.4s, v4.8h, v4.8h
smull	v27.4s, v5.4h, v5.4h
smlal2	v27.4s, v5.8h, v5.8h
mul	v26.4s, v26.4s, v31.4s
mul	v27.4s, v27.4s, v31.4s
addv	s4, v26.4s
addv	s5, v27.4s
rev64	v1.8h, v1.8h
rev64	v3.8h, v3.8h
ext	v1.16b, v1.16b, v1.16b, #0xa
ext	v3.16b, v3.16b, v3.16b, #0xa
str	s4, [sp, #0x8]
str	s5, [sp, #0x18]
adrp	x4, div_table
add	x4, x4, :lo12:div_table
ld1	{ v31.8h }, [x4]
smull	v22.4s, v0.4h, v0.4h
smull2	v23.4s, v0.8h, v0.8h
smlal	v22.4s, v1.4h, v1.4h
smlal2	v23.4s, v1.8h, v1.8h
smull	v24.4s, v2.4h, v2.4h
smull2	v25.4s, v2.8h, v2.8h
smlal	v24.4s, v3.4h, v3.4h
smlal2	v25.4s, v3.8h, v3.8h
ushll	v30.4s, v31.4h, #0x0
ushll2	v31.4s, v31.8h, #0x0
mul	v22.4s, v22.4s, v30.4s
mla	v22.4s, v23.4s, v31.4s
mul	v24.4s, v24.4s, v30.4s
mla	v24.4s, v25.4s, v31.4s
addv	s0, v22.4s
addv	s2, v24.4s
adrp	x5, alt_fact
add	x5, x5, :lo12:alt_fact
ld1	{ v29.4h, v30.4h, v31.4h }, [x5]
str	s0, [sp]
str	s2, [sp, #0x10]
ushll	v29.4s, v29.4h, #0x0
ushll	v30.4s, v30.4h, #0x0
ushll	v31.4s, v31.4h, #0x0
smull	v22.4s, v6.4h, v6.4h
smull2	v23.4s, v6.8h, v6.8h
smull	v24.4s, v7.4h, v7.4h
smull	v25.4s, v16.4h, v16.4h
smull2	v26.4s, v16.8h, v16.8h
smull	v27.4s, v17.4h, v17.4h
mul	v22.4s, v22.4s, v29.4s
mla	v22.4s, v23.4s, v30.4s
mla	v22.4s, v24.4s, v31.4s
mul	v25.4s, v25.4s, v29.4s
mla	v25.4s, v26.4s, v30.4s
mla	v25.4s, v27.4s, v31.4s
addv	s6, v22.4s
addv	s16, v25.4s
smull	v22.4s, v18.4h, v18.4h
smull2	v23.4s, v18.8h, v18.8h
smull	v24.4s, v19.4h, v19.4h
smull	v25.4s, v20.4h, v20.4h
smull2	v26.4s, v20.8h, v20.8h
smull	v27.4s, v21.4h, v21.4h
mul	v22.4s, v22.4s, v29.4s
mla	v22.4s, v23.4s, v30.4s
mla	v22.4s, v24.4s, v31.4s
mul	v25.4s, v25.4s, v29.4s
mla	v25.4s, v26.4s, v30.4s
mla	v25.4s, v27.4s, v31.4s
addv	s18, v22.4s
addv	s20, v25.4s
str	s6, [sp, #0x4]
str	s16, [sp, #0xc]
mov	w0, #0x0
mov	w1, v0.s[0]
mov	w3, #0x1
str	s18, [sp, #0x14]
str	s20, [sp, #0x1c]
mov	w4, v6.s[0]
mov	w5, v4.s[0]
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
add	w3, w3, #0x1
cmp	w5, w1
mov	w4, v16.s[0]
csel	w0, w3, w0, gt
csel	w1, w5, w1, gt
add	w3, w3, #0x1
mov	w5, v2.s[0]
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
add	w3, w3, #0x1
cmp	w5, w1
mov	w4, v18.s[0]
csel	w0, w3, w0, gt
csel	w1, w5, w1, gt
add	w3, w3, #0x1
mov	w5, v5.s[0]
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
add	w3, w3, #0x1
cmp	w5, w1
mov	w4, v20.s[0]
csel	w0, w3, w0, gt
csel	w1, w5, w1, gt
add	w3, w3, #0x1
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
eor	w3, w0, #0x4
ldr	w4, [sp, w3, uxtw #2]
sub	w1, w1, w4
lsr	w1, w1, #10
str	w1, [x2]
add	sp, sp, #0x20
ret
cdef_filter8_pri_edged_8bpc_neon:
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions8
add	x9, x9, :lo12:directions8
add	x5, x9, w5, uxtw #1
movi	v30.8b, #0x7
dup	v28.8b, w6
dup	v25.16b, w3
trn1	v24.8b, v25.8b, v27.8b
clz	v24.8b, v24.8b
sub	v24.8b, v30.8b, v24.8b
uqsub	v24.8b, v28.8b, v24.8b
neg	v24.8b, v24.8b
dup	v24.16b, v24.b[0]
L_1600:
add	x12, x2, #0x10
ld1	{ v0.d }[0], [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.16b, #0xff
movi	v2.16b, #0x0
mov	w11, #0x2
L_1618:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.d }[0], [x6]
add	x6, x6, #0x10
ld1	{ v6.d }[0], [x9]
add	x9, x9, #0x10
ld1	{ v5.d }[1], [x6]
ld1	{ v6.d }[1], [x9]
ldrb	w10, [x8]
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v24.16b
ushl	v21.16b, v20.16b, v24.16b
uqsub	v17.16b, v25.16b, v17.16b
uqsub	v21.16b, v25.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w10
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
add	x5, x5, #0x1
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_1618
srhadd	v5.16b, v1.16b, v2.16b
shadd	v6.16b, v1.16b, v2.16b
cmlt	v1.16b, v5.16b, #0
bsl	v1.16b, v6.16b, v5.16b
srshr	v1.16b, v1.16b, #0x3
usqadd	v0.16b, v1.16b
st1	{ v0.d }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.d }[1], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_1600
ret
cdef_filter8_sec_edged_8bpc_neon:
adrp	x9, directions8
add	x9, x9, :lo12:directions8
add	x5, x9, w5, uxtw #1
movi	v30.8b, #0x7
dup	v28.8b, w6
dup	v27.16b, w4
trn1	v24.8b, v25.8b, v27.8b
clz	v24.8b, v24.8b
sub	v24.8b, v30.8b, v24.8b
uqsub	v24.8b, v28.8b, v24.8b
neg	v24.8b, v24.8b
dup	v26.16b, v24.b[1]
L_16fc:
add	x12, x2, #0x10
ld1	{ v0.d }[0], [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.16b, #0xff
movi	v2.16b, #0x0
mov	w11, #0x2
L_1714:
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v28.d }[0], [x6]
add	x6, x6, #0x10
ld1	{ v29.d }[0], [x9]
add	x9, x9, #0x10
ld1	{ v28.d }[1], [x6]
ld1	{ v29.d }[1], [x9]
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.d }[0], [x6]
add	x6, x6, #0x10
ld1	{ v6.d }[0], [x9]
add	x9, x9, #0x10
ld1	{ v5.d }[1], [x6]
ld1	{ v6.d }[1], [x9]
uabd	v16.16b, v0.16b, v28.16b
uabd	v20.16b, v0.16b, v29.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v28.16b
cmhi	v22.16b, v0.16b, v29.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
sub	x5, x5, #0xb
subs	w11, w11, #0x1
b.ne	L_1714
srhadd	v5.16b, v1.16b, v2.16b
shadd	v6.16b, v1.16b, v2.16b
cmlt	v1.16b, v5.16b, #0
bsl	v1.16b, v6.16b, v5.16b
srshr	v1.16b, v1.16b, #0x3
usqadd	v0.16b, v1.16b
st1	{ v0.d }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.d }[1], [x0], x1
sub	x5, x5, #0x2
b.gt	L_16fc
ret
cdef_filter8_pri_sec_edged_8bpc_neon:
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions8
add	x9, x9, :lo12:directions8
add	x5, x9, w5, uxtw #1
movi	v30.8b, #0x7
dup	v28.8b, w6
dup	v25.16b, w3
dup	v27.16b, w4
trn1	v24.8b, v25.8b, v27.8b
clz	v24.8b, v24.8b
sub	v24.8b, v30.8b, v24.8b
uqsub	v24.8b, v28.8b, v24.8b
neg	v24.8b, v24.8b
dup	v26.16b, v24.b[1]
dup	v24.16b, v24.b[0]
L_1874:
add	x12, x2, #0x10
ld1	{ v0.d }[0], [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.16b, #0xff
movi	v2.16b, #0x0
mov	v3.16b, v0.16b
mov	v4.16b, v0.16b
mov	w11, #0x2
L_1894:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.d }[0], [x6]
add	x6, x6, #0x10
ld1	{ v6.d }[0], [x9]
add	x9, x9, #0x10
ld1	{ v5.d }[1], [x6]
ld1	{ v6.d }[1], [x9]
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v28.d }[0], [x6]
add	x6, x6, #0x10
ld1	{ v29.d }[0], [x9]
add	x9, x9, #0x10
ld1	{ v28.d }[1], [x6]
ld1	{ v29.d }[1], [x9]
ldrb	w10, [x8]
umin	v3.16b, v3.16b, v5.16b
umax	v4.16b, v4.16b, v5.16b
umin	v3.16b, v3.16b, v6.16b
umax	v4.16b, v4.16b, v6.16b
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v24.16b
ushl	v21.16b, v20.16b, v24.16b
uqsub	v17.16b, v25.16b, v17.16b
uqsub	v21.16b, v25.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w10
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.d }[0], [x6]
add	x6, x6, #0x10
ld1	{ v6.d }[0], [x9]
add	x9, x9, #0x10
ld1	{ v5.d }[1], [x6]
ld1	{ v6.d }[1], [x9]
umin	v3.16b, v3.16b, v28.16b
umax	v4.16b, v4.16b, v28.16b
umin	v3.16b, v3.16b, v29.16b
umax	v4.16b, v4.16b, v29.16b
uabd	v16.16b, v0.16b, v28.16b
uabd	v20.16b, v0.16b, v29.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v28.16b
cmhi	v22.16b, v0.16b, v29.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
umin	v3.16b, v3.16b, v5.16b
umax	v4.16b, v4.16b, v5.16b
umin	v3.16b, v3.16b, v6.16b
umax	v4.16b, v4.16b, v6.16b
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
sub	x5, x5, #0xb
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_1894
srhadd	v5.16b, v1.16b, v2.16b
shadd	v6.16b, v1.16b, v2.16b
cmlt	v1.16b, v5.16b, #0
bsl	v1.16b, v6.16b, v5.16b
srshr	v1.16b, v1.16b, #0x3
usqadd	v0.16b, v1.16b
umin	v0.16b, v0.16b, v4.16b
umax	v0.16b, v0.16b, v3.16b
st1	{ v0.d }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.d }[1], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_1874
ret
cdef_filter4_pri_edged_8bpc_neon:
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions4
add	x9, x9, :lo12:directions4
add	x5, x9, w5, uxtw #1
movi	v30.8b, #0x7
dup	v28.8b, w6
dup	v25.16b, w3
trn1	v24.8b, v25.8b, v27.8b
clz	v24.8b, v24.8b
sub	v24.8b, v30.8b, v24.8b
uqsub	v24.8b, v28.8b, v24.8b
neg	v24.8b, v24.8b
dup	v24.16b, v24.b[0]
L_1a98:
add	x12, x2, #0x8
add	x13, x2, #0x10
add	x14, x2, #0x18
ld1	{ v0.s }[0], [x2]
ld1	{ v0.s }[1], [x12]
ld1	{ v0.s }[2], [x13]
ld1	{ v0.s }[3], [x14]
movi	v1.16b, #0xff
movi	v2.16b, #0x0
mov	w11, #0x2
L_1ac0:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.s }[0], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[0], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[1], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[1], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[2], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[2], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[3], [x6]
ld1	{ v6.s }[3], [x9]
ldrb	w10, [x8]
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v24.16b
ushl	v21.16b, v20.16b, v24.16b
uqsub	v17.16b, v25.16b, v17.16b
uqsub	v21.16b, v25.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w10
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
add	x5, x5, #0x1
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_1ac0
srhadd	v5.16b, v1.16b, v2.16b
shadd	v6.16b, v1.16b, v2.16b
cmlt	v1.16b, v5.16b, #0
bsl	v1.16b, v6.16b, v5.16b
srshr	v1.16b, v1.16b, #0x3
usqadd	v0.16b, v1.16b
st1	{ v0.s }[0], [x0], x1
add	x2, x2, #0x20
st1	{ v0.s }[1], [x0], x1
subs	w7, w7, #0x4
st1	{ v0.s }[2], [x0], x1
st1	{ v0.s }[3], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_1a98
ret
cdef_filter4_sec_edged_8bpc_neon:
adrp	x9, directions4
add	x9, x9, :lo12:directions4
add	x5, x9, w5, uxtw #1
movi	v30.8b, #0x7
dup	v28.8b, w6
dup	v27.16b, w4
trn1	v24.8b, v25.8b, v27.8b
clz	v24.8b, v24.8b
sub	v24.8b, v30.8b, v24.8b
uqsub	v24.8b, v28.8b, v24.8b
neg	v24.8b, v24.8b
dup	v26.16b, v24.b[1]
L_1bcc:
add	x12, x2, #0x8
add	x13, x2, #0x10
add	x14, x2, #0x18
ld1	{ v0.s }[0], [x2]
ld1	{ v0.s }[1], [x12]
ld1	{ v0.s }[2], [x13]
ld1	{ v0.s }[3], [x14]
movi	v1.16b, #0xff
movi	v2.16b, #0x0
mov	w11, #0x2
L_1bf4:
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v28.s }[0], [x6]
add	x6, x6, #0x8
ld1	{ v29.s }[0], [x9]
add	x9, x9, #0x8
ld1	{ v28.s }[1], [x6]
add	x6, x6, #0x8
ld1	{ v29.s }[1], [x9]
add	x9, x9, #0x8
ld1	{ v28.s }[2], [x6]
add	x6, x6, #0x8
ld1	{ v29.s }[2], [x9]
add	x9, x9, #0x8
ld1	{ v28.s }[3], [x6]
ld1	{ v29.s }[3], [x9]
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.s }[0], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[0], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[1], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[1], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[2], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[2], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[3], [x6]
ld1	{ v6.s }[3], [x9]
uabd	v16.16b, v0.16b, v28.16b
uabd	v20.16b, v0.16b, v29.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v28.16b
cmhi	v22.16b, v0.16b, v29.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
sub	x5, x5, #0xb
subs	w11, w11, #0x1
b.ne	L_1bf4
srhadd	v5.16b, v1.16b, v2.16b
shadd	v6.16b, v1.16b, v2.16b
cmlt	v1.16b, v5.16b, #0
bsl	v1.16b, v6.16b, v5.16b
srshr	v1.16b, v1.16b, #0x3
usqadd	v0.16b, v1.16b
st1	{ v0.s }[0], [x0], x1
add	x2, x2, #0x20
st1	{ v0.s }[1], [x0], x1
subs	w7, w7, #0x4
st1	{ v0.s }[2], [x0], x1
st1	{ v0.s }[3], [x0], x1
sub	x5, x5, #0x2
b.gt	L_1bcc
ret
cdef_filter4_pri_sec_edged_8bpc_neon:
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
and	w9, w3, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, directions4
add	x9, x9, :lo12:directions4
add	x5, x9, w5, uxtw #1
movi	v30.8b, #0x7
dup	v28.8b, w6
dup	v25.16b, w3
dup	v27.16b, w4
trn1	v24.8b, v25.8b, v27.8b
clz	v24.8b, v24.8b
sub	v24.8b, v30.8b, v24.8b
uqsub	v24.8b, v28.8b, v24.8b
neg	v24.8b, v24.8b
dup	v26.16b, v24.b[1]
dup	v24.16b, v24.b[0]
L_1d9c:
add	x12, x2, #0x8
add	x13, x2, #0x10
add	x14, x2, #0x18
ld1	{ v0.s }[0], [x2]
ld1	{ v0.s }[1], [x12]
ld1	{ v0.s }[2], [x13]
ld1	{ v0.s }[3], [x14]
movi	v1.16b, #0xff
movi	v2.16b, #0x0
mov	v3.16b, v0.16b
mov	v4.16b, v0.16b
mov	w11, #0x2
L_1dcc:
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.s }[0], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[0], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[1], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[1], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[2], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[2], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[3], [x6]
ld1	{ v6.s }[3], [x9]
add	x5, x5, #0x4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v28.s }[0], [x6]
add	x6, x6, #0x8
ld1	{ v29.s }[0], [x9]
add	x9, x9, #0x8
ld1	{ v28.s }[1], [x6]
add	x6, x6, #0x8
ld1	{ v29.s }[1], [x9]
add	x9, x9, #0x8
ld1	{ v28.s }[2], [x6]
add	x6, x6, #0x8
ld1	{ v29.s }[2], [x9]
add	x9, x9, #0x8
ld1	{ v28.s }[3], [x6]
ld1	{ v29.s }[3], [x9]
ldrb	w10, [x8]
umin	v3.16b, v3.16b, v5.16b
umax	v4.16b, v4.16b, v5.16b
umin	v3.16b, v3.16b, v6.16b
umax	v4.16b, v4.16b, v6.16b
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v24.16b
ushl	v21.16b, v20.16b, v24.16b
uqsub	v17.16b, v25.16b, v17.16b
uqsub	v21.16b, v25.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w10
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
add	x5, x5, #0x8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb
sub	x9, x2, w9, sxtb
ld1	{ v5.s }[0], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[0], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[1], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[1], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[2], [x6]
add	x6, x6, #0x8
ld1	{ v6.s }[2], [x9]
add	x9, x9, #0x8
ld1	{ v5.s }[3], [x6]
ld1	{ v6.s }[3], [x9]
umin	v3.16b, v3.16b, v28.16b
umax	v4.16b, v4.16b, v28.16b
umin	v3.16b, v3.16b, v29.16b
umax	v4.16b, v4.16b, v29.16b
uabd	v16.16b, v0.16b, v28.16b
uabd	v20.16b, v0.16b, v29.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v28.16b
cmhi	v22.16b, v0.16b, v29.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
umin	v3.16b, v3.16b, v5.16b
umax	v4.16b, v4.16b, v5.16b
umin	v3.16b, v3.16b, v6.16b
umax	v4.16b, v4.16b, v6.16b
uabd	v16.16b, v0.16b, v5.16b
uabd	v20.16b, v0.16b, v6.16b
ushl	v17.16b, v16.16b, v26.16b
ushl	v21.16b, v20.16b, v26.16b
uqsub	v17.16b, v27.16b, v17.16b
uqsub	v21.16b, v27.16b, v21.16b
cmhi	v18.16b, v0.16b, v5.16b
cmhi	v22.16b, v0.16b, v6.16b
umin	v17.16b, v17.16b, v16.16b
umin	v21.16b, v21.16b, v20.16b
dup	v19.16b, w11
neg	v16.16b, v17.16b
neg	v20.16b, v21.16b
bsl	v18.16b, v16.16b, v17.16b
bsl	v22.16b, v20.16b, v21.16b
mla	v1.16b, v18.16b, v19.16b
mla	v2.16b, v22.16b, v19.16b
sub	x5, x5, #0xb
subs	w11, w11, #0x1
add	x8, x8, #0x1
b.ne	L_1dcc
srhadd	v5.16b, v1.16b, v2.16b
shadd	v6.16b, v1.16b, v2.16b
cmlt	v1.16b, v5.16b, #0
bsl	v1.16b, v6.16b, v5.16b
srshr	v1.16b, v1.16b, #0x3
usqadd	v0.16b, v1.16b
umin	v0.16b, v0.16b, v4.16b
umax	v0.16b, v0.16b, v3.16b
st1	{ v0.s }[0], [x0], x1
add	x2, x2, #0x20
st1	{ v0.s }[1], [x0], x1
subs	w7, w7, #0x4
st1	{ v0.s }[2], [x0], x1
st1	{ v0.s }[3], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_1d9c
ret
	.section .rodata
div_table:
	.size div_table, 16
	.byte 72,3,164,1,24,1,210,0,168,0,140,0,120,0,105,0
alt_fact:
	.size alt_fact, 24
	.byte 164,1,210,0,140,0,105,0,105,0,105,0,105,0,105,0
	.byte 140,0,210,0,164,1,0,0
directions8:
	.size directions8, 28
	.byte 241,226,1,242,1,2,1,18,17,34,16,33,16,32,16,31
	.byte 241,226,1,242,1,2,1,18,17,34,16,33
directions4:
	.size directions4, 28
	.byte 249,242,1,250,1,2,1,10,9,18,8,17,8,16,8,15
	.byte 249,242,1,250,1,2,1,10,9,18,8,17
pri_taps:
	.size pri_taps, 4
	.byte 4,2,3,3
