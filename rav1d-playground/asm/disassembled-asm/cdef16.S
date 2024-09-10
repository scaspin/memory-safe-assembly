_ltmp0:
movi.8h	v30, #128, lsl #8
mov.16b	v31, v30
sub	x0, x0, #68
tst	w7, #0x4
b.ne	ltmp0
st1.8h	{ v30, v31 }, [x0], #32
st1.8h	{ v30, v31 }, [x0], #32
b	ltmp0
add	x9, x4, x2
tst	w7, #0x1
b.eq	ltmp0
sub	x4, x4, #4
sub	x9, x9, #4
tst	w7, #0x2
b.eq	ltmp0
ldr	q0, [x4]
ldr	d1, [x4, #16]
ldr	q2, [x9]
ldr	d3, [x9, #16]
str	q0, [x0]
str	d1, [x0, #16]
add	x0, x0, #32
str	q2, [x0]
str	d3, [x0, #16]
add	x0, x0, #32
b	ltmp0
ldr	q0, [x4]
ldr	s1, [x4, #16]
ldr	q2, [x9]
ldr	s3, [x9, #16]
str	q0, [x0]
str	s1, [x0, #16]
str	s31, [x0, #20]
add	x0, x0, #32
str	q2, [x0]
str	s3, [x0, #16]
str	s31, [x0, #20]
add	x0, x0, #32
b	ltmp0
tst	w7, #0x2
b.eq	ltmp0
ldr	q0, [x4]
ldr	s1, [x4, #16]
ldr	q2, [x9]
ldr	s3, [x9, #16]
str	s31, [x0]
stur	q0, [x0, #4]
str	s1, [x0, #20]
add	x0, x0, #32
str	s31, [x0]
stur	q2, [x0, #4]
str	s3, [x0, #20]
add	x0, x0, #32
b	ltmp0
ldr	q0, [x4]
ldr	q1, [x9]
str	s31, [x0]
stur	q0, [x0, #4]
str	s31, [x0, #20]
add	x0, x0, #32
str	s31, [x0]
stur	q1, [x0, #4]
str	s31, [x0, #20]
add	x0, x0, #32
tst	w7, #0x1
b.eq	ltmp0
tst	w7, #0x2
b.eq	ltmp0
ld1.s	{ v0 }[0], [x3], #4
ldr	s2, [x1, #16]
ld1.8h	{ v1 }, [x1], x2
subs	w6, w6, #1
str	s0, [x0]
stur	q1, [x0, #4]
str	s2, [x0, #20]
add	x0, x0, #32
b.gt	ltmp0
b	ltmp0
ld1.s	{ v0 }[0], [x3], #4
ld1.8h	{ v1 }, [x1], x2
subs	w6, w6, #1
str	s0, [x0]
stur	q1, [x0, #4]
str	s31, [x0, #20]
add	x0, x0, #32
b.gt	ltmp0
b	ltmp0
tst	w7, #0x2
b.eq	ltmp0
ldr	s1, [x1, #16]
ld1.8h	{ v0 }, [x1], x2
subs	w6, w6, #1
str	s31, [x0]
stur	q0, [x0, #4]
str	s1, [x0, #20]
add	x0, x0, #32
b.gt	ltmp0
b	ltmp0
ld1.8h	{ v0 }, [x1], x2
subs	w6, w6, #1
str	s31, [x0]
stur	q0, [x0, #4]
str	s31, [x0, #20]
add	x0, x0, #32
b.gt	ltmp0
tst	w7, #0x8
b.ne	ltmp0
st1.8h	{ v30, v31 }, [x0], #32
st1.8h	{ v30, v31 }, [x0], #32
ret
add	x9, x5, x2
tst	w7, #0x1
b.eq	ltmp0
sub	x5, x5, #4
sub	x9, x9, #4
tst	w7, #0x2
b.eq	ltmp0
ldr	q0, [x5]
ldr	d1, [x5, #16]
ldr	q2, [x9]
ldr	d3, [x9, #16]
str	q0, [x0]
str	d1, [x0, #16]
add	x0, x0, #32
str	q2, [x0]
str	d3, [x0, #16]
ret
ldr	q0, [x5]
ldr	s1, [x5, #16]
ldr	q2, [x9]
ldr	s3, [x9, #16]
str	q0, [x0]
str	s1, [x0, #16]
str	s31, [x0, #20]
add	x0, x0, #32
str	q2, [x0]
str	s3, [x0, #16]
str	s31, [x0, #20]
ret
tst	w7, #0x2
b.eq	ltmp0
ldr	q0, [x5]
ldr	s1, [x5, #16]
ldr	q2, [x9]
ldr	s3, [x9, #16]
str	s31, [x0]
stur	q0, [x0, #4]
str	s1, [x0, #20]
add	x0, x0, #32
str	s31, [x0]
stur	q2, [x0, #4]
str	s3, [x0, #20]
ret
ldr	q0, [x5]
ldr	q1, [x9]
str	s31, [x0]
stur	q0, [x0, #4]
str	s31, [x0, #20]
add	x0, x0, #32
str	s31, [x0]
stur	q1, [x0, #4]
str	s31, [x0, #20]
ret
_cdef_padding4_16bpc_neon:
movi.8h	v30, #128, lsl #8
mov.16b	v31, v30
sub	x0, x0, #36
tst	w7, #0x4
b.ne	cdef_padding4_16bpc_neon
st1.8h	{ v30, v31 }, [x0], #32
b	cdef_padding4_16bpc_neon
add	x9, x4, x2
tst	w7, #0x1
b.eq	cdef_padding4_16bpc_neon
sub	x4, x4, #4
sub	x9, x9, #4
tst	w7, #0x2
b.eq	cdef_padding4_16bpc_neon
ldr	d0, [x4]
ldr	d1, [x4, #8]
ldr	d2, [x9]
ldr	d3, [x9, #8]
str	d0, [x0]
str	d1, [x0, #8]
add	x0, x0, #16
str	d2, [x0]
str	d3, [x0, #8]
add	x0, x0, #16
b	cdef_padding4_16bpc_neon
ldr	d0, [x4]
ldr	s1, [x4, #8]
ldr	d2, [x9]
ldr	s3, [x9, #8]
str	d0, [x0]
str	s1, [x0, #8]
str	s31, [x0, #12]
add	x0, x0, #16
str	d2, [x0]
str	s3, [x0, #8]
str	s31, [x0, #12]
add	x0, x0, #16
b	cdef_padding4_16bpc_neon
tst	w7, #0x2
b.eq	cdef_padding4_16bpc_neon
ldr	d0, [x4]
ldr	s1, [x4, #8]
ldr	d2, [x9]
ldr	s3, [x9, #8]
str	s31, [x0]
stur	d0, [x0, #4]
str	s1, [x0, #12]
add	x0, x0, #16
str	s31, [x0]
stur	d2, [x0, #4]
str	s3, [x0, #12]
add	x0, x0, #16
b	cdef_padding4_16bpc_neon
ldr	d0, [x4]
ldr	d1, [x9]
str	s31, [x0]
stur	d0, [x0, #4]
str	s31, [x0, #12]
add	x0, x0, #16
str	s31, [x0]
stur	d1, [x0, #4]
str	s31, [x0, #12]
add	x0, x0, #16
tst	w7, #0x1
b.eq	cdef_padding4_16bpc_neon
tst	w7, #0x2
b.eq	cdef_padding4_16bpc_neon
ld1.s	{ v0 }[0], [x3], #4
ldr	s2, [x1, #8]
ld1.4h	{ v1 }, [x1], x2
subs	w6, w6, #1
str	s0, [x0]
stur	d1, [x0, #4]
str	s2, [x0, #12]
add	x0, x0, #16
b.gt	cdef_padding4_16bpc_neon
b	cdef_padding4_16bpc_neon
ld1.s	{ v0 }[0], [x3], #4
ld1.4h	{ v1 }, [x1], x2
subs	w6, w6, #1
str	s0, [x0]
stur	d1, [x0, #4]
str	s31, [x0, #12]
add	x0, x0, #16
b.gt	cdef_padding4_16bpc_neon
b	cdef_padding4_16bpc_neon
tst	w7, #0x2
b.eq	cdef_padding4_16bpc_neon
ldr	s1, [x1, #8]
ld1.4h	{ v0 }, [x1], x2
subs	w6, w6, #1
str	s31, [x0]
stur	d0, [x0, #4]
str	s1, [x0, #12]
add	x0, x0, #16
b.gt	cdef_padding4_16bpc_neon
b	cdef_padding4_16bpc_neon
ld1.4h	{ v0 }, [x1], x2
subs	w6, w6, #1
str	s31, [x0]
stur	d0, [x0, #4]
str	s31, [x0, #12]
add	x0, x0, #16
b.gt	cdef_padding4_16bpc_neon
tst	w7, #0x8
b.ne	cdef_padding4_16bpc_neon
st1.8h	{ v30, v31 }, [x0], #32
ret
add	x9, x5, x2
tst	w7, #0x1
b.eq	cdef_padding4_16bpc_neon
sub	x5, x5, #4
sub	x9, x9, #4
tst	w7, #0x2
b.eq	cdef_padding4_16bpc_neon
ldr	d0, [x5]
ldr	d1, [x5, #8]
ldr	d2, [x9]
ldr	d3, [x9, #8]
str	d0, [x0]
str	d1, [x0, #8]
add	x0, x0, #16
str	d2, [x0]
str	d3, [x0, #8]
ret
ldr	d0, [x5]
ldr	s1, [x5, #8]
ldr	d2, [x9]
ldr	s3, [x9, #8]
str	d0, [x0]
str	s1, [x0, #8]
str	s31, [x0, #12]
add	x0, x0, #16
str	d2, [x0]
str	s3, [x0, #8]
str	s31, [x0, #12]
ret
tst	w7, #0x2
b.eq	cdef_padding4_16bpc_neon
ldr	d0, [x5]
ldr	s1, [x5, #8]
ldr	d2, [x9]
ldr	s3, [x9, #8]
str	s31, [x0]
stur	d0, [x0, #4]
str	s1, [x0, #12]
add	x0, x0, #16
str	s31, [x0]
stur	d2, [x0, #4]
str	s3, [x0, #12]
ret
ldr	d0, [x5]
ldr	d1, [x9]
str	s31, [x0]
stur	d0, [x0, #4]
str	s31, [x0, #12]
add	x0, x0, #16
str	s31, [x0]
stur	d1, [x0, #4]
str	s31, [x0, #12]
ret
_cdef_filter8_pri_16bpc_neon:
ldr	w9, [sp, #8]
clz	w9, w9
sub	w9, w9, #24
neg	w9, w9
adrp	x8, cdef_filter8_pri_16bpc_neon
add	x8, x8, #0
lsr	w9, w3, w9
and	w9, w9, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, cdef_filter8_pri_16bpc_neon
add	x9, x9, #0
add	x5, x9, w5, uxtw #1
movi.4h	v30, #15
dup.4h	v28, w6
dup.8h	v25, w3
trn1.4h	v24, v25, v27
clz.4h	v24, v24
sub.4h	v24, v30, v24
uqsub.4h	v24, v28, v24
neg.4h	v24, v24
dup.8h	v24, v24[0]
ld1.8h	{ v0 }, [x2]
movi.8h	v1, #0
mov	w11, #2
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.8h	{ v4 }, [x6]
ld1.8h	{ v5 }, [x9]
ldrb	w10, [x8]
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v24
ushl.8h	v21, v20, v24
uqsub.8h	v17, v25, v17
uqsub.8h	v21, v25, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w10
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
add	x5, x5, #1
subs	w11, w11, #1
add	x8, x8, #1
b.ne	cdef_filter8_pri_16bpc_neon
cmlt.8h	v4, v1, #0
add.8h	v1, v1, v4
srshr.8h	v1, v1, #4
add.8h	v0, v0, v1
add	x2, x2, #32
subs	w7, w7, #1
st1.8h	{ v0 }, [x0], x1
sub	x5, x5, #2
sub	x8, x8, #2
b.gt	cdef_filter8_pri_16bpc_neon
ret
_cdef_filter8_sec_16bpc_neon:
adrp	x9, cdef_filter8_sec_16bpc_neon
add	x9, x9, #0
add	x5, x9, w5, uxtw #1
movi.4h	v30, #15
dup.4h	v28, w6
dup.8h	v27, w4
trn1.4h	v24, v25, v27
clz.4h	v24, v24
sub.4h	v24, v30, v24
uqsub.4h	v24, v28, v24
neg.4h	v24, v24
dup.8h	v26, v24[1]
ld1.8h	{ v0 }, [x2]
movi.8h	v1, #0
mov	w11, #2
add	x5, x5, #4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.8h	{ v6 }, [x6]
ld1.8h	{ v7 }, [x9]
add	x5, x5, #8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.8h	{ v4 }, [x6]
ld1.8h	{ v5 }, [x9]
uabd.8h	v16, v0, v6
uabd.8h	v20, v0, v7
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v6, v0
sub.8h	v22, v7, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
sub	x5, x5, #11
subs	w11, w11, #1
b.ne	cdef_filter8_sec_16bpc_neon
cmlt.8h	v4, v1, #0
add.8h	v1, v1, v4
srshr.8h	v1, v1, #4
add.8h	v0, v0, v1
add	x2, x2, #32
subs	w7, w7, #1
st1.8h	{ v0 }, [x0], x1
sub	x5, x5, #2
b.gt	cdef_filter8_sec_16bpc_neon
ret
_cdef_filter8_pri_sec_16bpc_neon:
ldr	w9, [sp, #8]
clz	w9, w9
sub	w9, w9, #24
neg	w9, w9
adrp	x8, cdef_filter8_pri_sec_16bpc_neon
add	x8, x8, #0
lsr	w9, w3, w9
and	w9, w9, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, cdef_filter8_pri_sec_16bpc_neon
add	x9, x9, #0
add	x5, x9, w5, uxtw #1
movi.4h	v30, #15
dup.4h	v28, w6
dup.8h	v25, w3
dup.8h	v27, w4
trn1.4h	v24, v25, v27
clz.4h	v24, v24
sub.4h	v24, v30, v24
uqsub.4h	v24, v28, v24
neg.4h	v24, v24
dup.8h	v26, v24[1]
dup.8h	v24, v24[0]
ld1.8h	{ v0 }, [x2]
movi.8h	v1, #0
mov.16b	v2, v0
mov.16b	v3, v0
mov	w11, #2
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.8h	{ v4 }, [x6]
ld1.8h	{ v5 }, [x9]
add	x5, x5, #4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.8h	{ v6 }, [x6]
ld1.8h	{ v7 }, [x9]
ldrb	w10, [x8]
umin.8h	v2, v2, v4
smax.8h	v3, v3, v4
umin.8h	v2, v2, v5
smax.8h	v3, v3, v5
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v24
ushl.8h	v21, v20, v24
uqsub.8h	v17, v25, v17
uqsub.8h	v21, v25, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w10
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
add	x5, x5, #8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.8h	{ v4 }, [x6]
ld1.8h	{ v5 }, [x9]
umin.8h	v2, v2, v6
smax.8h	v3, v3, v6
umin.8h	v2, v2, v7
smax.8h	v3, v3, v7
uabd.8h	v16, v0, v6
uabd.8h	v20, v0, v7
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v6, v0
sub.8h	v22, v7, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
umin.8h	v2, v2, v4
smax.8h	v3, v3, v4
umin.8h	v2, v2, v5
smax.8h	v3, v3, v5
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
sub	x5, x5, #11
subs	w11, w11, #1
add	x8, x8, #1
b.ne	cdef_filter8_pri_sec_16bpc_neon
cmlt.8h	v4, v1, #0
add.8h	v1, v1, v4
srshr.8h	v1, v1, #4
add.8h	v0, v0, v1
smin.8h	v0, v0, v3
smax.8h	v0, v0, v2
add	x2, x2, #32
subs	w7, w7, #1
st1.8h	{ v0 }, [x0], x1
sub	x5, x5, #2
sub	x8, x8, #2
b.gt	cdef_filter8_pri_sec_16bpc_neon
ret
_cdef_filter8_16bpc_neon:
cbnz	w3, cdef_filter8_16bpc_neon
b	cdef_filter8_sec_16bpc_neon
cbnz	w4, cdef_filter8_16bpc_neon
b	cdef_filter8_pri_16bpc_neon
b	cdef_filter8_pri_sec_16bpc_neon
_cdef_filter4_pri_16bpc_neon:
ldr	w9, [sp, #8]
clz	w9, w9
sub	w9, w9, #24
neg	w9, w9
adrp	x8, cdef_filter4_pri_16bpc_neon
add	x8, x8, #0
lsr	w9, w3, w9
and	w9, w9, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, cdef_filter4_pri_16bpc_neon
add	x9, x9, #0
add	x5, x9, w5, uxtw #1
movi.4h	v30, #15
dup.4h	v28, w6
dup.8h	v25, w3
trn1.4h	v24, v25, v27
clz.4h	v24, v24
sub.4h	v24, v30, v24
uqsub.4h	v24, v28, v24
neg.4h	v24, v24
dup.8h	v24, v24[0]
add	x12, x2, #16
ld1.4h	{ v0 }, [x2]
ld1.d	{ v0 }[1], [x12]
movi.8h	v1, #0
mov	w11, #2
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.4h	{ v4 }, [x6]
add	x6, x6, #16
ld1.4h	{ v5 }, [x9]
add	x9, x9, #16
ld1.d	{ v4 }[1], [x6]
ld1.d	{ v5 }[1], [x9]
ldrb	w10, [x8]
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v24
ushl.8h	v21, v20, v24
uqsub.8h	v17, v25, v17
uqsub.8h	v21, v25, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w10
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
add	x5, x5, #1
subs	w11, w11, #1
add	x8, x8, #1
b.ne	cdef_filter4_pri_16bpc_neon
cmlt.8h	v4, v1, #0
add.8h	v1, v1, v4
srshr.8h	v1, v1, #4
add.8h	v0, v0, v1
st1.d	{ v0 }[0], [x0], x1
add	x2, x2, #32
subs	w7, w7, #2
st1.d	{ v0 }[1], [x0], x1
sub	x5, x5, #2
sub	x8, x8, #2
b.gt	cdef_filter4_pri_16bpc_neon
ret
_cdef_filter4_sec_16bpc_neon:
adrp	x9, cdef_filter4_sec_16bpc_neon
add	x9, x9, #0
add	x5, x9, w5, uxtw #1
movi.4h	v30, #15
dup.4h	v28, w6
dup.8h	v27, w4
trn1.4h	v24, v25, v27
clz.4h	v24, v24
sub.4h	v24, v30, v24
uqsub.4h	v24, v28, v24
neg.4h	v24, v24
dup.8h	v26, v24[1]
add	x12, x2, #16
ld1.4h	{ v0 }, [x2]
ld1.d	{ v0 }[1], [x12]
movi.8h	v1, #0
mov	w11, #2
add	x5, x5, #4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.4h	{ v6 }, [x6]
add	x6, x6, #16
ld1.4h	{ v7 }, [x9]
add	x9, x9, #16
ld1.d	{ v6 }[1], [x6]
ld1.d	{ v7 }[1], [x9]
add	x5, x5, #8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.4h	{ v4 }, [x6]
add	x6, x6, #16
ld1.4h	{ v5 }, [x9]
add	x9, x9, #16
ld1.d	{ v4 }[1], [x6]
ld1.d	{ v5 }[1], [x9]
uabd.8h	v16, v0, v6
uabd.8h	v20, v0, v7
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v6, v0
sub.8h	v22, v7, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
sub	x5, x5, #11
subs	w11, w11, #1
b.ne	cdef_filter4_sec_16bpc_neon
cmlt.8h	v4, v1, #0
add.8h	v1, v1, v4
srshr.8h	v1, v1, #4
add.8h	v0, v0, v1
st1.d	{ v0 }[0], [x0], x1
add	x2, x2, #32
subs	w7, w7, #2
st1.d	{ v0 }[1], [x0], x1
sub	x5, x5, #2
b.gt	cdef_filter4_sec_16bpc_neon
ret
_cdef_filter4_pri_sec_16bpc_neon:
ldr	w9, [sp, #8]
clz	w9, w9
sub	w9, w9, #24
neg	w9, w9
adrp	x8, cdef_filter4_pri_sec_16bpc_neon
add	x8, x8, #0
lsr	w9, w3, w9
and	w9, w9, #0x1
add	x8, x8, w9, uxtw #1
adrp	x9, cdef_filter4_pri_sec_16bpc_neon
add	x9, x9, #0
add	x5, x9, w5, uxtw #1
movi.4h	v30, #15
dup.4h	v28, w6
dup.8h	v25, w3
dup.8h	v27, w4
trn1.4h	v24, v25, v27
clz.4h	v24, v24
sub.4h	v24, v30, v24
uqsub.4h	v24, v28, v24
neg.4h	v24, v24
dup.8h	v26, v24[1]
dup.8h	v24, v24[0]
add	x12, x2, #16
ld1.4h	{ v0 }, [x2]
ld1.d	{ v0 }[1], [x12]
movi.8h	v1, #0
mov.16b	v2, v0
mov.16b	v3, v0
mov	w11, #2
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.4h	{ v4 }, [x6]
add	x6, x6, #16
ld1.4h	{ v5 }, [x9]
add	x9, x9, #16
ld1.d	{ v4 }[1], [x6]
ld1.d	{ v5 }[1], [x9]
add	x5, x5, #4
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.4h	{ v6 }, [x6]
add	x6, x6, #16
ld1.4h	{ v7 }, [x9]
add	x9, x9, #16
ld1.d	{ v6 }[1], [x6]
ld1.d	{ v7 }[1], [x9]
ldrb	w10, [x8]
umin.8h	v2, v2, v4
smax.8h	v3, v3, v4
umin.8h	v2, v2, v5
smax.8h	v3, v3, v5
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v24
ushl.8h	v21, v20, v24
uqsub.8h	v17, v25, v17
uqsub.8h	v21, v25, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w10
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
add	x5, x5, #8
ldrb	w9, [x5]
add	x6, x2, w9, sxtb #1
sub	x9, x2, w9, sxtb #1
ld1.4h	{ v4 }, [x6]
add	x6, x6, #16
ld1.4h	{ v5 }, [x9]
add	x9, x9, #16
ld1.d	{ v4 }[1], [x6]
ld1.d	{ v5 }[1], [x9]
umin.8h	v2, v2, v6
smax.8h	v3, v3, v6
umin.8h	v2, v2, v7
smax.8h	v3, v3, v7
uabd.8h	v16, v0, v6
uabd.8h	v20, v0, v7
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v6, v0
sub.8h	v22, v7, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
umin.8h	v2, v2, v4
smax.8h	v3, v3, v4
umin.8h	v2, v2, v5
smax.8h	v3, v3, v5
uabd.8h	v16, v0, v4
uabd.8h	v20, v0, v5
ushl.8h	v17, v16, v26
ushl.8h	v21, v20, v26
uqsub.8h	v17, v27, v17
uqsub.8h	v21, v27, v21
sub.8h	v18, v4, v0
sub.8h	v22, v5, v0
neg.8h	v16, v17
neg.8h	v20, v21
smin.8h	v18, v18, v17
smin.8h	v22, v22, v21
dup.8h	v19, w11
smax.8h	v18, v18, v16
smax.8h	v22, v22, v20
mla.8h	v1, v18, v19
mla.8h	v1, v22, v19
sub	x5, x5, #11
subs	w11, w11, #1
add	x8, x8, #1
b.ne	cdef_filter4_pri_sec_16bpc_neon
cmlt.8h	v4, v1, #0
add.8h	v1, v1, v4
srshr.8h	v1, v1, #4
add.8h	v0, v0, v1
smin.8h	v0, v0, v3
smax.8h	v0, v0, v2
st1.d	{ v0 }[0], [x0], x1
add	x2, x2, #32
subs	w7, w7, #2
st1.d	{ v0 }[1], [x0], x1
sub	x5, x5, #2
sub	x8, x8, #2
b.gt	cdef_filter4_pri_sec_16bpc_neon
ret
_cdef_filter4_16bpc_neon:
cbnz	w3, cdef_filter4_16bpc_neon
b	cdef_filter4_sec_16bpc_neon
cbnz	w4, cdef_filter4_16bpc_neon
b	cdef_filter4_pri_16bpc_neon
b	cdef_filter4_pri_sec_16bpc_neon
_cdef_find_dir_16bpc_neon:
str	d8, [sp, #-16]!
clz	w3, w3
sub	w3, w3, #24
dup.8h	v8, w3
sub	sp, sp, #32
mov	w3, #8
movi.8h	v31, #128
movi.16b	v30, #0
movi.8h	v1, #0
movi.8h	v3, #0
movi.8h	v5, #0
movi.8h	v7, #0
ld1.8h	{ v26 }, [x0], x1
movi.8h	v17, #0
movi.8h	v18, #0
ushl.8h	v26, v26, v8
movi.8h	v19, #0
sub.8h	v26, v26, v31
movi.8h	v21, #0
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[0], v25[0]
ext.16b	v22, v30, v26, #10
ext.16b	v23, v26, v30, #10
add.8h	v18, v18, v22
add.4h	v19, v19, v23
mov.16b	v20, v26
mov.16b	v0, v26
ld1.8h	{ v26 }, [x0], x1
mov.16b	v2, v27
ushl.8h	v26, v26, v8
mov.16b	v6, v28
sub.8h	v26, v26, v31
mov.16b	v16, v29
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[1], v25[0]
ext.16b	v22, v30, v26, #10
ext.16b	v23, v26, v30, #10
add.8h	v18, v18, v22
add.4h	v19, v19, v23
add.8h	v20, v20, v26
ext.16b	v22, v30, v26, #14
ext.16b	v23, v26, v30, #14
ext.16b	v24, v30, v27, #14
ext.16b	v25, v27, v30, #14
ld1.8h	{ v26 }, [x0], x1
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ushl.8h	v26, v26, v8
ext.16b	v22, v30, v28, #14
ext.16b	v23, v28, v30, #14
ext.16b	v24, v30, v29, #14
ext.16b	v25, v29, v30, #14
sub.8h	v26, v26, v31
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[2], v25[0]
ext.16b	v22, v30, v26, #12
ext.16b	v23, v26, v30, #12
add.8h	v18, v18, v22
add.4h	v19, v19, v23
ext.16b	v24, v30, v26, #14
ext.16b	v25, v26, v30, #14
add.8h	v20, v20, v24
add.4h	v21, v21, v25
ext.16b	v22, v30, v26, #12
ext.16b	v23, v26, v30, #12
ext.16b	v24, v30, v27, #12
ext.16b	v25, v27, v30, #12
ld1.8h	{ v26 }, [x0], x1
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ushl.8h	v26, v26, v8
ext.16b	v22, v30, v28, #12
ext.16b	v23, v28, v30, #12
ext.16b	v24, v30, v29, #12
ext.16b	v25, v29, v30, #12
sub.8h	v26, v26, v31
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[3], v25[0]
ext.16b	v22, v30, v26, #12
ext.16b	v23, v26, v30, #12
add.8h	v18, v18, v22
add.4h	v19, v19, v23
ext.16b	v24, v30, v26, #14
ext.16b	v25, v26, v30, #14
add.8h	v20, v20, v24
add.4h	v21, v21, v25
ext.16b	v22, v30, v26, #10
ext.16b	v23, v26, v30, #10
ext.16b	v24, v30, v27, #10
ext.16b	v25, v27, v30, #10
ld1.8h	{ v26 }, [x0], x1
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ushl.8h	v26, v26, v8
ext.16b	v22, v30, v28, #10
ext.16b	v23, v28, v30, #10
ext.16b	v24, v30, v29, #10
ext.16b	v25, v29, v30, #10
sub.8h	v26, v26, v31
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[4], v25[0]
ext.16b	v22, v30, v26, #14
ext.16b	v23, v26, v30, #14
add.8h	v18, v18, v22
add.4h	v19, v19, v23
ext.16b	v24, v30, v26, #12
ext.16b	v25, v26, v30, #12
add.8h	v20, v20, v24
add.4h	v21, v21, v25
ext.16b	v22, v30, v26, #8
ext.16b	v23, v26, v30, #8
ext.16b	v24, v30, v27, #8
ext.16b	v25, v27, v30, #8
ld1.8h	{ v26 }, [x0], x1
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ushl.8h	v26, v26, v8
ext.16b	v22, v30, v28, #8
ext.16b	v23, v28, v30, #8
ext.16b	v24, v30, v29, #8
ext.16b	v25, v29, v30, #8
sub.8h	v26, v26, v31
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[5], v25[0]
ext.16b	v22, v30, v26, #14
ext.16b	v23, v26, v30, #14
add.8h	v18, v18, v22
add.4h	v19, v19, v23
ext.16b	v24, v30, v26, #12
ext.16b	v25, v26, v30, #12
add.8h	v20, v20, v24
add.4h	v21, v21, v25
ext.16b	v22, v30, v26, #6
ext.16b	v23, v26, v30, #6
ext.16b	v24, v30, v27, #6
ext.16b	v25, v27, v30, #6
ld1.8h	{ v26 }, [x0], x1
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ushl.8h	v26, v26, v8
ext.16b	v22, v30, v28, #6
ext.16b	v23, v28, v30, #6
ext.16b	v24, v30, v29, #6
ext.16b	v25, v29, v30, #6
sub.8h	v26, v26, v31
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[6], v25[0]
add.8h	v18, v18, v26
ext.16b	v24, v30, v26, #10
ext.16b	v25, v26, v30, #10
add.8h	v20, v20, v24
add.4h	v21, v21, v25
ext.16b	v22, v30, v26, #4
ext.16b	v23, v26, v30, #4
ext.16b	v24, v30, v27, #4
ext.16b	v25, v27, v30, #4
ld1.8h	{ v26 }, [x0], x1
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ushl.8h	v26, v26, v8
ext.16b	v22, v30, v28, #4
ext.16b	v23, v28, v30, #4
ext.16b	v24, v30, v29, #4
ext.16b	v25, v29, v30, #4
sub.8h	v26, v26, v31
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
addv.8h	h25, v26
rev64.8h	v27, v26
addp.8h	v28, v26, v30
add.8h	v5, v5, v26
ext.16b	v27, v27, v27, #8
rev64.4h	v29, v28
mov.h	v4[7], v25[0]
add.8h	v18, v18, v26
ext.16b	v24, v30, v26, #10
ext.16b	v25, v26, v30, #10
add.8h	v20, v20, v24
add.4h	v21, v21, v25
ext.16b	v22, v30, v26, #2
ext.16b	v23, v26, v30, #2
ext.16b	v24, v30, v27, #2
ext.16b	v25, v27, v30, #2
add.8h	v0, v0, v22
add.8h	v1, v1, v23
add.8h	v2, v2, v24
add.8h	v3, v3, v25
ext.16b	v22, v30, v28, #2
ext.16b	v23, v28, v30, #2
ext.16b	v24, v30, v29, #2
ext.16b	v25, v29, v30, #2
add.8h	v6, v6, v22
add.4h	v7, v7, v23
add.8h	v16, v16, v24
add.4h	v17, v17, v25
movi.4s	v31, #105
smull.4s	v26, v4, v4
smlal2.4s	v26, v4, v4
smull.4s	v27, v5, v5
smlal2.4s	v27, v5, v5
mul.4s	v26, v26, v31
mul.4s	v27, v27, v31
addv.4s	s4, v26
addv.4s	s5, v27
rev64.8h	v1, v1
rev64.8h	v3, v3
ext.16b	v1, v1, v1, #10
ext.16b	v3, v3, v3, #10
str	s4, [sp, #8]
str	s5, [sp, #24]
adrp	x4, cdef_find_dir_16bpc_neon
add	x4, x4, #0
ld1.8h	{ v31 }, [x4]
smull.4s	v22, v0, v0
smull2.4s	v23, v0, v0
smlal.4s	v22, v1, v1
smlal2.4s	v23, v1, v1
smull.4s	v24, v2, v2
smull2.4s	v25, v2, v2
smlal.4s	v24, v3, v3
smlal2.4s	v25, v3, v3
ushll.4s	v30, v31, #0
ushll2.4s	v31, v31, #0
mul.4s	v22, v22, v30
mla.4s	v22, v23, v31
mul.4s	v24, v24, v30
mla.4s	v24, v25, v31
addv.4s	s0, v22
addv.4s	s2, v24
adrp	x5, cdef_find_dir_16bpc_neon
add	x5, x5, #0
ld1.4h	{ v29, v30, v31 }, [x5]
str	s0, [sp]
str	s2, [sp, #16]
ushll.4s	v29, v29, #0
ushll.4s	v30, v30, #0
ushll.4s	v31, v31, #0
smull.4s	v22, v6, v6
smull2.4s	v23, v6, v6
smull.4s	v24, v7, v7
smull.4s	v25, v16, v16
smull2.4s	v26, v16, v16
smull.4s	v27, v17, v17
mul.4s	v22, v22, v29
mla.4s	v22, v23, v30
mla.4s	v22, v24, v31
mul.4s	v25, v25, v29
mla.4s	v25, v26, v30
mla.4s	v25, v27, v31
addv.4s	s6, v22
addv.4s	s16, v25
smull.4s	v22, v18, v18
smull2.4s	v23, v18, v18
smull.4s	v24, v19, v19
smull.4s	v25, v20, v20
smull2.4s	v26, v20, v20
smull.4s	v27, v21, v21
mul.4s	v22, v22, v29
mla.4s	v22, v23, v30
mla.4s	v22, v24, v31
mul.4s	v25, v25, v29
mla.4s	v25, v26, v30
mla.4s	v25, v27, v31
addv.4s	s18, v22
addv.4s	s20, v25
str	s6, [sp, #4]
str	s16, [sp, #12]
mov	w0, #0
mov.s	w1, v0[0]
mov	w3, #1
str	s18, [sp, #20]
str	s20, [sp, #28]
mov.s	w4, v6[0]
mov.s	w5, v4[0]
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
add	w3, w3, #1
cmp	w5, w1
mov.s	w4, v16[0]
csel	w0, w3, w0, gt
csel	w1, w5, w1, gt
add	w3, w3, #1
mov.s	w5, v2[0]
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
add	w3, w3, #1
cmp	w5, w1
mov.s	w4, v18[0]
csel	w0, w3, w0, gt
csel	w1, w5, w1, gt
add	w3, w3, #1
mov.s	w5, v5[0]
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
add	w3, w3, #1
cmp	w5, w1
mov.s	w4, v20[0]
csel	w0, w3, w0, gt
csel	w1, w5, w1, gt
add	w3, w3, #1
cmp	w4, w1
csel	w0, w3, w0, gt
csel	w1, w4, w1, gt
eor	w3, w0, #0x4
ldr	w4, [sp, w3, uxtw #2]
sub	w1, w1, w4
lsr	w1, w1, #10
str	w1, [x2]
add	sp, sp, #32
ldr	d8, [sp], #16
ret