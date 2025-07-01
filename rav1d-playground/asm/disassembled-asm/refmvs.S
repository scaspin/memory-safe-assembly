_splat_mv_neon:
ld1.16b	{ v3 }, [x1]
clz	w3, w3
adr	x5, #128
sub	w3, w3, #26
ext.16b	v2, v3, v3, #12
ldrh	w3, [x5, w3, uxtw #1]
add	w2, w2, w2, lsl #1
ext.16b	v0, v2, v3, #4
sub	x3, x5, w3, uxtw
ext.16b	v1, v2, v3, #8
lsl	w2, w2, #2
ext.16b	v2, v2, v3, #12
ldr	x1, [x0], #8
subs	w4, w4, #1
add	x1, x1, x2
br	x3
st1.8b	{ v0 }, [x1]
str	s2, [x1, #8]
b.gt	splat_mv_neon
ret
st1.16b	{ v0 }, [x1]
str	d1, [x1, #16]
b.gt	splat_mv_neon
ret
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1], #48
st1.16b	{ v0, v1, v2 }, [x1]
b.gt	splat_mv_neon
ret
<unknown>
<unknown>
<unknown>
_save_tmvs_neon:
stp	x29, x30, [sp, #-16]!
mov	x29, sp
movi.8b	v30, #0
ld1.8b	{ v31 }, [x3]
adr	x8, #404
adrp	x16, save_tmvs_neon
add	x16, x16, #0
adrp	x13, save_tmvs_neon
add	x13, x13, #0
ld1.8b	{ v29 }, [x16]
ext.8b	v31, v30, v31, #7
mov	w15, #5
mov	w14, #24
sxtw	x4, w4
sxtw	x6, w6
mul	w1, w1, w15
sub	w5, w5, w7
lsl	w7, w7, #1
mov	w15, #5
and	w9, w7, #0x1e
ldr	x9, [x2, w9, uxtw #3]
add	x9, x9, #12
madd	x10, x4, x14, x9
madd	x9, x6, x14, x9
madd	x3, x6, x15, x0
ldrb	w11, [x9, #10]
ld1.16b	{ v0 }, [x9]
add	x11, x8, w11, uxtw #2
ldr	h1, [x9, #8]
ldrh	w12, [x11]
mov	x15, x8
add	x9, x9, w12, uxtw #1
cmp	x9, x10
mov.8b	v2, v0
b.ge	save_tmvs_neon
ldrb	w15, [x9, #10]
add	x16, x9, #8
ld1.16b	{ v4 }, [x9]
add	x15, x8, w15, uxtw #2
ld1.h	{ v1 }[1], [x16]
ldrh	w12, [x15]
add	x9, x9, w12, uxtw #1
trn1.2d	v2, v0, v4
abs.8h	v2, v2
tbl.8b	v1, { v31 }, v1
ushr.8h	v2, v2, #12
umull.8h	v1, v1, v29
cmeq.4s	v2, v2, #0
xtn.4h	v2, v2
and.8b	v1, v1, v2
addp.4h	v1, v1, v1
umov.h	w16, v1[0]
umov.h	w17, v1[1]
ldrh	w11, [x11, #2]
ldrh	w15, [x15, #2]
ldr	q1, [x13, w16, uxtw #4]
ldr	q5, [x13, w17, uxtw #4]
sub	x11, x8, w11, uxtw
sub	x15, x8, w15, uxtw
tbl.16b	v0, { v0 }, v1
tbl.16b	v4, { v4 }, v5
ext.16b	v1, v0, v0, #1
ext.16b	v5, v4, v4, #1
ext.16b	v2, v0, v1, #4
ext.16b	v6, v4, v5, #4
blr	x11
b.ge	save_tmvs_neon
mov.16b	v0, v4
mov.16b	v1, v5
mov.16b	v2, v6
cmp	x9, x10
blr	x15
b.lt	save_tmvs_neon
subs	w5, w5, #1
add	w7, w7, #2
add	x0, x0, x1
b.gt	save_tmvs_neon
ldp	x29, x30, [sp], #16
ret
add	x16, x3, #4
st1.s	{ v0 }[0], [x3]
st1.b	{ v0 }[4], [x16]
add	x3, x3, #5
ret
add	x16, x3, #8
st1.d	{ v0 }[0], [x3]
st1.h	{ v0 }[4], [x16]
add	x3, x3, #10
ret
st1.16b	{ v0 }, [x3]
str	s1, [x3, #16]
add	x3, x3, #20
ret
st1.16b	{ v0, v1 }, [x3]
stur	q2, [x3, #24]
add	x3, x3, #40
ret
add	x16, x3, #30
add	x17, x3, #60
st1.16b	{ v0, v1 }, [x3]
st1.16b	{ v0, v1 }, [x16]
st1.8b	{ v0 }, [x17]
str	q2, [x3, #64]
add	x3, x3, #80
ret
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>