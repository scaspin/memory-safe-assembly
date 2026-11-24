	.text
cdef_padding8_16bpc_neon:
movi	v30.8h, #0x80, lsl #8
mov	v31.16b, v30.16b
sub	x0, x0, #0x44
tst	w7, #0x4
b.ne	L_20
st1	{ v30.8h, v31.8h }, [x0], #32
st1	{ v30.8h, v31.8h }, [x0], #32
b	L_100
L_20:
add	x9, x4, x2
tst	w7, #0x1
b.eq	L_9c
sub	x4, x4, #0x4
sub	x9, x9, #0x4
tst	w7, #0x2
b.eq	L_68
ldr	q0, [x4]
ldr	d1, [x4, #0x10]
ldr	q2, [x9]
ldr	d3, [x9, #0x10]
str	q0, [x0]
str	d1, [x0, #0x10]
add	x0, x0, #0x20
str	q2, [x0]
str	d3, [x0, #0x10]
add	x0, x0, #0x20
b	L_100
L_68:
ldr	q0, [x4]
ldr	s1, [x4, #0x10]
ldr	q2, [x9]
ldr	s3, [x9, #0x10]
str	q0, [x0]
str	s1, [x0, #0x10]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	q2, [x0]
str	s3, [x0, #0x10]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
b	L_100
L_9c:
tst	w7, #0x2
b.eq	L_d8
ldr	q0, [x4]
ldr	s1, [x4, #0x10]
ldr	q2, [x9]
ldr	s3, [x9, #0x10]
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s1, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q2, [x0, #0x4]
str	s3, [x0, #0x14]
add	x0, x0, #0x20
b	L_100
L_d8:
ldr	q0, [x4]
ldr	q1, [x9]
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q1, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
L_100:
tst	w7, #0x1
b.eq	L_15c
tst	w7, #0x2
b.eq	L_138
L_110:
ld1	{ v0.s }[0], [x3], #4
ldr	s2, [x1, #0x10]
ld1	{ v1.8h }, [x1], x2
subs	w6, w6, #0x1
str	s0, [x0]
stur	q1, [x0, #0x4]
str	s2, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_110
b	L_1a4
L_138:
ld1	{ v0.s }[0], [x3], #4
ld1	{ v1.8h }, [x1], x2
subs	w6, w6, #0x1
str	s0, [x0]
stur	q1, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_138
b	L_1a4
L_15c:
tst	w7, #0x2
b.eq	L_188
L_164:
ldr	s1, [x1, #0x10]
ld1	{ v0.8h }, [x1], x2
subs	w6, w6, #0x1
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s1, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_164
b	L_1a4
L_188:
ld1	{ v0.8h }, [x1], x2
subs	w6, w6, #0x1
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
b.gt	L_188
L_1a4:
tst	w7, #0x8
b.ne	L_1b8
st1	{ v30.8h, v31.8h }, [x0], #32
st1	{ v30.8h, v31.8h }, [x0], #32
ret
L_1b8:
add	x9, x5, x2
tst	w7, #0x1
b.eq	L_22c
sub	x5, x5, #0x4
sub	x9, x9, #0x4
tst	w7, #0x2
b.eq	L_1fc
ldr	q0, [x5]
ldr	d1, [x5, #0x10]
ldr	q2, [x9]
ldr	d3, [x9, #0x10]
str	q0, [x0]
str	d1, [x0, #0x10]
add	x0, x0, #0x20
str	q2, [x0]
str	d3, [x0, #0x10]
ret
L_1fc:
ldr	q0, [x5]
ldr	s1, [x5, #0x10]
ldr	q2, [x9]
ldr	s3, [x9, #0x10]
str	q0, [x0]
str	s1, [x0, #0x10]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	q2, [x0]
str	s3, [x0, #0x10]
str	s31, [x0, #0x14]
ret
L_22c:
tst	w7, #0x2
b.eq	L_264
ldr	q0, [x5]
ldr	s1, [x5, #0x10]
ldr	q2, [x9]
ldr	s3, [x9, #0x10]
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s1, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q2, [x0, #0x4]
str	s3, [x0, #0x14]
ret
L_264:
ldr	q0, [x5]
ldr	q1, [x9]
str	s31, [x0]
stur	q0, [x0, #0x4]
str	s31, [x0, #0x14]
add	x0, x0, #0x20
str	s31, [x0]
stur	q1, [x0, #0x4]
str	s31, [x0, #0x14]
ret
cdef_padding4_16bpc_neon:
movi	v30.8h, #0x80, lsl #8
mov	v31.16b, v30.16b
sub	x0, x0, #0x24
tst	w7, #0x4
b.ne	L_2a8
st1	{ v30.8h, v31.8h }, [x0], #32
b	L_388
L_2a8:
add	x9, x4, x2
tst	w7, #0x1
b.eq	L_324
sub	x4, x4, #0x4
sub	x9, x9, #0x4
tst	w7, #0x2
b.eq	L_2f0
ldr	d0, [x4]
ldr	d1, [x4, #0x8]
ldr	d2, [x9]
ldr	d3, [x9, #0x8]
str	d0, [x0]
str	d1, [x0, #0x8]
add	x0, x0, #0x10
str	d2, [x0]
str	d3, [x0, #0x8]
add	x0, x0, #0x10
b	L_388
L_2f0:
ldr	d0, [x4]
ldr	s1, [x4, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
str	d0, [x0]
str	s1, [x0, #0x8]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	d2, [x0]
str	s3, [x0, #0x8]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
b	L_388
L_324:
tst	w7, #0x2
b.eq	L_360
ldr	d0, [x4]
ldr	s1, [x4, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s1, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d2, [x0, #0x4]
str	s3, [x0, #0xc]
add	x0, x0, #0x10
b	L_388
L_360:
ldr	d0, [x4]
ldr	d1, [x9]
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d1, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
L_388:
tst	w7, #0x1
b.eq	L_3e4
tst	w7, #0x2
b.eq	L_3c0
L_398:
ld1	{ v0.s }[0], [x3], #4
ldr	s2, [x1, #0x8]
ld1	{ v1.4h }, [x1], x2
subs	w6, w6, #0x1
str	s0, [x0]
stur	d1, [x0, #0x4]
str	s2, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_398
b	L_42c
L_3c0:
ld1	{ v0.s }[0], [x3], #4
ld1	{ v1.4h }, [x1], x2
subs	w6, w6, #0x1
str	s0, [x0]
stur	d1, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_3c0
b	L_42c
L_3e4:
tst	w7, #0x2
b.eq	L_410
L_3ec:
ldr	s1, [x1, #0x8]
ld1	{ v0.4h }, [x1], x2
subs	w6, w6, #0x1
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s1, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_3ec
b	L_42c
L_410:
ld1	{ v0.4h }, [x1], x2
subs	w6, w6, #0x1
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
b.gt	L_410
L_42c:
tst	w7, #0x8
b.ne	L_43c
st1	{ v30.8h, v31.8h }, [x0], #32
ret
L_43c:
add	x9, x5, x2
tst	w7, #0x1
b.eq	L_4b0
sub	x5, x5, #0x4
sub	x9, x9, #0x4
tst	w7, #0x2
b.eq	L_480
ldr	d0, [x5]
ldr	d1, [x5, #0x8]
ldr	d2, [x9]
ldr	d3, [x9, #0x8]
str	d0, [x0]
str	d1, [x0, #0x8]
add	x0, x0, #0x10
str	d2, [x0]
str	d3, [x0, #0x8]
ret
L_480:
ldr	d0, [x5]
ldr	s1, [x5, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
str	d0, [x0]
str	s1, [x0, #0x8]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	d2, [x0]
str	s3, [x0, #0x8]
str	s31, [x0, #0xc]
ret
L_4b0:
tst	w7, #0x2
b.eq	L_4e8
ldr	d0, [x5]
ldr	s1, [x5, #0x8]
ldr	d2, [x9]
ldr	s3, [x9, #0x8]
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s1, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d2, [x0, #0x4]
str	s3, [x0, #0xc]
ret
L_4e8:
ldr	d0, [x5]
ldr	d1, [x9]
str	s31, [x0]
stur	d0, [x0, #0x4]
str	s31, [x0, #0xc]
add	x0, x0, #0x10
str	s31, [x0]
stur	d1, [x0, #0x4]
str	s31, [x0, #0xc]
ret
cdef_filter8_pri_16bpc_neon:
ldr	w9, [sp, #0x8]
clz	w9, w9
sub	w9, w9, #0x18
neg	w9, w9
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
lsr	w9, w3, w9
and	w9, w9, #0x1
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
L_564:
ld1	{ v0.8h }, [x2]
movi	v1.8h, #0x0
mov	w11, #0x2
L_570:
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
b.ne	L_570
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
add	x2, x2, #0x20
subs	w7, w7, #0x1
st1	{ v0.8h }, [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_564
ret
cdef_filter8_sec_16bpc_neon:
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
L_638:
ld1	{ v0.8h }, [x2]
movi	v1.8h, #0x0
mov	w11, #0x2
L_644:
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
b.ne	L_644
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
add	x2, x2, #0x20
subs	w7, w7, #0x1
st1	{ v0.8h }, [x0], x1
sub	x5, x5, #0x2
b.gt	L_638
ret
cdef_filter8_pri_sec_16bpc_neon:
ldr	w9, [sp, #0x8]
clz	w9, w9
sub	w9, w9, #0x18
neg	w9, w9
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
lsr	w9, w3, w9
and	w9, w9, #0x1
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
L_78c:
ld1	{ v0.8h }, [x2]
movi	v1.8h, #0x0
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
mov	w11, #0x2
L_7a0:
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
b.ne	L_7a0
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
smin	v0.8h, v0.8h, v3.8h
smax	v0.8h, v0.8h, v2.8h
add	x2, x2, #0x20
subs	w7, w7, #0x1
st1	{ v0.8h }, [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_78c
ret
cdef_filter8_16bpc_neon:
cbnz	w3, L_930
b	cdef_filter8_sec_16bpc_neon
L_930:
cbnz	w4, L_938
b	cdef_filter8_pri_16bpc_neon
L_938:
b	cdef_filter8_pri_sec_16bpc_neon
cdef_filter4_pri_16bpc_neon:
ldr	w9, [sp, #0x8]
clz	w9, w9
sub	w9, w9, #0x18
neg	w9, w9
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
lsr	w9, w3, w9
and	w9, w9, #0x1
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
L_990:
add	x12, x2, #0x10
ld1	{ v0.4h }, [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.8h, #0x0
mov	w11, #0x2
L_9a4:
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
b.ne	L_9a4
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
st1	{ v0.d }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.d }[1], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_990
ret
cdef_filter4_sec_16bpc_neon:
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
L_a80:
add	x12, x2, #0x10
ld1	{ v0.4h }, [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.8h, #0x0
mov	w11, #0x2
L_a94:
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
b.ne	L_a94
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
st1	{ v0.d }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.d }[1], [x0], x1
sub	x5, x5, #0x2
b.gt	L_a80
ret
cdef_filter4_pri_sec_16bpc_neon:
ldr	w9, [sp, #0x8]
clz	w9, w9
sub	w9, w9, #0x18
neg	w9, w9
adrp	x8, pri_taps
add	x8, x8, :lo12:pri_taps
lsr	w9, w3, w9
and	w9, w9, #0x1
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
L_c00:
add	x12, x2, #0x10
ld1	{ v0.4h }, [x2]
ld1	{ v0.d }[1], [x12]
movi	v1.8h, #0x0
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
mov	w11, #0x2
L_c1c:
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
b.ne	L_c1c
cmlt	v4.8h, v1.8h, #0
add	v1.8h, v1.8h, v4.8h
srshr	v1.8h, v1.8h, #0x4
add	v0.8h, v0.8h, v1.8h
smin	v0.8h, v0.8h, v3.8h
smax	v0.8h, v0.8h, v2.8h
st1	{ v0.d }[0], [x0], x1
add	x2, x2, #0x20
subs	w7, w7, #0x2
st1	{ v0.d }[1], [x0], x1
sub	x5, x5, #0x2
sub	x8, x8, #0x2
b.gt	L_c00
ret
cdef_filter4_16bpc_neon:
cbnz	w3, L_de0
b	cdef_filter4_sec_16bpc_neon
L_de0:
cbnz	w4, L_de8
b	cdef_filter4_pri_16bpc_neon
L_de8:
b	cdef_filter4_pri_sec_16bpc_neon
cdef_find_dir_16bpc_neon:
str	d8, [sp, #-0x10]!
clz	w3, w3
sub	w3, w3, #0x18
dup	v8.8h, w3
sub	sp, sp, #0x20
mov	w3, #0x8
movi	v31.8h, #0x80
movi	v30.16b, #0x0
movi	v1.8h, #0x0
movi	v3.8h, #0x0
movi	v5.8h, #0x0
movi	v7.8h, #0x0
ld1	{ v26.8h }, [x0], x1
movi	v17.8h, #0x0
movi	v18.8h, #0x0
ushl	v26.8h, v26.8h, v8.8h
movi	v19.8h, #0x0
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
mov	v2.16b, v27.16b
ushl	v26.8h, v26.8h, v8.8h
mov	v6.16b, v28.16b
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ushl	v26.8h, v26.8h, v8.8h
ext	v22.16b, v30.16b, v28.16b, #0xe
ext	v23.16b, v28.16b, v30.16b, #0xe
ext	v24.16b, v30.16b, v29.16b, #0xe
ext	v25.16b, v29.16b, v30.16b, #0xe
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ushl	v26.8h, v26.8h, v8.8h
ext	v22.16b, v30.16b, v28.16b, #0xc
ext	v23.16b, v28.16b, v30.16b, #0xc
ext	v24.16b, v30.16b, v29.16b, #0xc
ext	v25.16b, v29.16b, v30.16b, #0xc
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ushl	v26.8h, v26.8h, v8.8h
ext	v22.16b, v30.16b, v28.16b, #0xa
ext	v23.16b, v28.16b, v30.16b, #0xa
ext	v24.16b, v30.16b, v29.16b, #0xa
ext	v25.16b, v29.16b, v30.16b, #0xa
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ushl	v26.8h, v26.8h, v8.8h
ext	v22.16b, v30.16b, v28.16b, #0x8
ext	v23.16b, v28.16b, v30.16b, #0x8
ext	v24.16b, v30.16b, v29.16b, #0x8
ext	v25.16b, v29.16b, v30.16b, #0x8
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ushl	v26.8h, v26.8h, v8.8h
ext	v22.16b, v30.16b, v28.16b, #0x6
ext	v23.16b, v28.16b, v30.16b, #0x6
ext	v24.16b, v30.16b, v29.16b, #0x6
ext	v25.16b, v29.16b, v30.16b, #0x6
sub	v26.8h, v26.8h, v31.8h
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
ld1	{ v26.8h }, [x0], x1
add	v0.8h, v0.8h, v22.8h
add	v1.8h, v1.8h, v23.8h
add	v2.8h, v2.8h, v24.8h
add	v3.8h, v3.8h, v25.8h
ushl	v26.8h, v26.8h, v8.8h
ext	v22.16b, v30.16b, v28.16b, #0x4
ext	v23.16b, v28.16b, v30.16b, #0x4
ext	v24.16b, v30.16b, v29.16b, #0x4
ext	v25.16b, v29.16b, v30.16b, #0x4
sub	v26.8h, v26.8h, v31.8h
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
ldr	d8, [sp], #0x10
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
