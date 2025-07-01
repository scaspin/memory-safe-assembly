_ltmp0:
ldr	w8, [sp]
clz	w3, w3
adr	x5, #224
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
dup.8h	v0, w8
sub	x5, x5, w3, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
urshr.8h	v0, v0, #1
br	x5
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
b.gt	ltmp0
ret
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ltmp0
ret
mov.16b	v1, v0
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
b.gt	ltmp0
ret
mov.16b	v1, v0
mov.16b	v2, v0
mov.16b	v3, v0
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ltmp0
ret
mov.16b	v1, v0
mov.16b	v2, v0
mov.16b	v3, v0
sub	x1, x1, #64
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ltmp0
ret
<unknown>
<unknown>
udf	#188
_ipred_v_16bpc_neon:
clz	w3, w3
adr	x5, #216
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
add	x2, x2, #2
sub	x5, x5, w3, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1.4h	{ v0 }, [x2]
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
b.gt	ipred_v_16bpc_neon
ret
ld1.8h	{ v0 }, [x2]
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_v_16bpc_neon
ret
ld1.8h	{ v0, v1 }, [x2]
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
b.gt	ipred_v_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2]
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_v_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2], #64
sub	x1, x1, #64
ld1.8h	{ v4, v5, v6, v7 }, [x2]
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
st1.8h	{ v4, v5, v6, v7 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
st1.8h	{ v4, v5, v6, v7 }, [x6], x1
b.gt	ipred_v_16bpc_neon
ret
<unknown>
<unknown>
udf	#184
_ipred_h_16bpc_neon:
clz	w3, w3
adr	x5, #308
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
sub	x2, x2, #8
sub	x5, x5, w3, uxtw
mov	x7, #-8
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
st1.4h	{ v3 }, [x0], x1
st1.4h	{ v2 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v1 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
b.gt	ipred_h_16bpc_neon
ret
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
st1.8h	{ v3 }, [x0], x1
st1.8h	{ v2 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_h_16bpc_neon
ret
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
str	q3, [x0, #16]
str	q2, [x6, #16]
st1.8h	{ v3 }, [x0], x1
st1.8h	{ v2 }, [x6], x1
subs	w4, w4, #4
str	q1, [x0, #16]
str	q0, [x6, #16]
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_h_16bpc_neon
ret
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
str	q3, [x0, #16]
str	q2, [x6, #16]
stp	q3, q3, [x0, #32]
stp	q2, q2, [x6, #32]
st1.8h	{ v3 }, [x0], x1
st1.8h	{ v2 }, [x6], x1
subs	w4, w4, #4
str	q1, [x0, #16]
str	q0, [x6, #16]
stp	q1, q1, [x0, #32]
stp	q0, q0, [x6, #32]
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_h_16bpc_neon
ret
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
str	q3, [x0, #16]
str	q2, [x6, #16]
stp	q3, q3, [x0, #32]
stp	q2, q2, [x6, #32]
stp	q3, q3, [x0, #64]
stp	q2, q2, [x6, #64]
stp	q3, q3, [x0, #96]
stp	q2, q2, [x6, #96]
st1.8h	{ v3 }, [x0], x1
st1.8h	{ v2 }, [x6], x1
subs	w4, w4, #4
str	q1, [x0, #16]
str	q0, [x6, #16]
stp	q1, q1, [x0, #32]
stp	q0, q0, [x6, #32]
stp	q1, q1, [x0, #64]
stp	q0, q0, [x6, #64]
stp	q1, q1, [x0, #96]
stp	q0, q0, [x6, #96]
st1.8h	{ v1 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_h_16bpc_neon
ret
<unknown>
<unknown>
udf	#272
_ipred_dc_top_16bpc_neon:
clz	w3, w3
adr	x5, #348
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
add	x2, x2, #2
sub	x5, x5, w3, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1.4h	{ v0 }, [x2]
addv.4h	h0, v0
urshr.4h	v0, v0, #2
dup.4h	v0, v0[0]
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
b.gt	ipred_dc_top_16bpc_neon
ret
ld1.8h	{ v0 }, [x2]
addv.8h	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_dc_top_16bpc_neon
ret
ld1.8h	{ v0, v1 }, [x2]
addp.8h	v0, v0, v1
addv.8h	h0, v0
urshr.4h	v2, v0, #4
dup.8h	v0, v2[0]
dup.8h	v1, v2[0]
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
b.gt	ipred_dc_top_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2]
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
addp.8h	v0, v0, v2
uaddlv.8h	s0, v0
rshrn.4h	v4, v0, #5
dup.8h	v0, v4[0]
dup.8h	v1, v4[0]
dup.8h	v2, v4[0]
dup.8h	v3, v4[0]
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_top_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2], #64
addp.8h	v0, v0, v1
ld1.8h	{ v4, v5, v6, v7 }, [x2]
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
addp.8h	v0, v0, v2
addp.8h	v4, v4, v6
addp.8h	v0, v0, v4
uaddlv.8h	s0, v0
rshrn.4h	v4, v0, #6
sub	x1, x1, #64
dup.8h	v0, v4[0]
dup.8h	v1, v4[0]
dup.8h	v2, v4[0]
dup.8h	v3, v4[0]
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_top_16bpc_neon
ret
<unknown>
<unknown>
udf	#316
_ipred_dc_left_16bpc_neon:
sub	x2, x2, w4, uxtw #1
clz	w3, w3
clz	w7, w4
adr	x5, #384
sub	w3, w3, #20
sub	w7, w7, #25
ldrh	w3, [x5, w3, uxtw #1]
ldrh	w7, [x5, w7, uxtw #1]
sub	x3, x5, w3, uxtw
sub	x5, x5, w7, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1.4h	{ v0 }, [x2]
addv.4h	h0, v0
urshr.4h	v0, v0, #2
dup.8h	v0, v0[0]
br	x3
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
b.gt	ipred_dc_left_16bpc_neon
ret
ld1.8h	{ v0 }, [x2]
addv.8h	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
br	x3
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_dc_left_16bpc_neon
ret
ld1.8h	{ v0, v1 }, [x2]
addp.8h	v0, v0, v1
addv.8h	h0, v0
urshr.4h	v2, v0, #4
dup.8h	v0, v2[0]
dup.8h	v1, v2[0]
br	x3
mov.16b	v1, v0
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
b.gt	ipred_dc_left_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2]
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
addp.8h	v0, v0, v2
uaddlp.4s	v0, v0
addv.4s	s0, v0
rshrn.4h	v4, v0, #5
dup.8h	v0, v4[0]
br	x3
mov.16b	v1, v0
mov.16b	v2, v0
mov.16b	v3, v0
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_left_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2], #64
addp.8h	v0, v0, v1
ld1.8h	{ v4, v5, v6, v7 }, [x2]
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
addp.8h	v0, v0, v2
addp.8h	v4, v4, v6
addp.8h	v0, v0, v4
uaddlv.8h	s0, v0
rshrn.4h	v4, v0, #6
dup.8h	v0, v4[0]
br	x3
mov.16b	v1, v0
mov.16b	v2, v0
mov.16b	v3, v0
sub	x1, x1, #64
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_left_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
_ipred_dc_16bpc_neon:
sub	x2, x2, w4, uxtw #1
add	w7, w3, w4
clz	w3, w3
clz	w6, w4
dup.4s	v16, w7
adr	x5, #724
rbit	w7, w7
sub	w3, w3, #20
sub	w6, w6, #25
clz	w7, w7
ldrh	w3, [x5, w3, uxtw #1]
ldrh	w6, [x5, w6, uxtw #1]
neg	w7, w7
sub	x3, x5, w3, uxtw
sub	x5, x5, w6, uxtw
ushr.4s	v16, v16, #1
dup.4s	v17, w7
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1.4h	{ v0 }, [x2], #8
uaddlv.4h	s0, v0
add	x2, x2, #2
br	x3
ld1.4h	{ v1 }, [x2]
add.2s	v0, v0, v16
uaddlv.4h	s1, v1
cmp	w4, #4
add.2s	v0, v0, v1
ushl.2s	v0, v0, v17
b.eq	ipred_dc_16bpc_neon
cmp	w4, #16
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v0, v0, v16
ushr.2s	v0, v0, #17
dup.4h	v0, v0[0]
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v0 }, [x0], x1
st1.4h	{ v0 }, [x6], x1
b.gt	ipred_dc_16bpc_neon
ret
ld1.8h	{ v0 }, [x2], #16
uaddlv.8h	s0, v0
add	x2, x2, #2
br	x3
ld1.8h	{ v1 }, [x2]
add.2s	v0, v0, v16
uaddlv.8h	s1, v1
cmp	w4, #8
add.2s	v0, v0, v1
ushl.2s	v0, v0, v17
b.eq	ipred_dc_16bpc_neon
cmp	w4, #32
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v0, v0, v16
ushr.2s	v0, v0, #17
dup.8h	v0, v0[0]
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0 }, [x0], x1
st1.8h	{ v0 }, [x6], x1
b.gt	ipred_dc_16bpc_neon
ret
ld1.8h	{ v0, v1 }, [x2], #32
addp.8h	v0, v0, v1
add	x2, x2, #2
uaddlv.8h	s0, v0
br	x3
ld1.8h	{ v1, v2 }, [x2]
add.2s	v0, v0, v16
addp.8h	v1, v1, v2
uaddlv.8h	s1, v1
cmp	w4, #16
add.2s	v0, v0, v1
ushl.2s	v4, v0, v17
b.eq	ipred_dc_16bpc_neon
tst	w4, #0x38
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v4, v4, v16
ushr.2s	v4, v4, #17
dup.8h	v0, v4[0]
dup.8h	v1, v4[0]
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], x1
st1.8h	{ v0, v1 }, [x6], x1
b.gt	ipred_dc_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2], #64
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
addp.8h	v0, v0, v2
add	x2, x2, #2
uaddlv.8h	s0, v0
br	x3
ld1.8h	{ v1, v2, v3, v4 }, [x2]
add.2s	v0, v0, v16
addp.8h	v1, v1, v2
addp.8h	v3, v3, v4
addp.8h	v1, v1, v3
uaddlv.8h	s1, v1
cmp	w4, #32
add.2s	v0, v0, v1
ushl.2s	v4, v0, v17
b.eq	ipred_dc_16bpc_neon
cmp	w4, #8
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v4, v4, v16
ushr.2s	v4, v4, #17
dup.8h	v0, v4[0]
dup.8h	v1, v4[0]
dup.8h	v2, v4[0]
dup.8h	v3, v4[0]
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_16bpc_neon
ret
ld1.8h	{ v0, v1, v2, v3 }, [x2], #64
addp.8h	v0, v0, v1
ld1.8h	{ v4, v5, v6, v7 }, [x2], #64
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
addp.8h	v0, v0, v2
addp.8h	v4, v4, v6
addp.8h	v0, v0, v4
add	x2, x2, #2
uaddlv.8h	s0, v0
br	x3
ld1.8h	{ v1, v2, v3, v4 }, [x2], #64
add.2s	v0, v0, v16
addp.8h	v1, v1, v2
ld1.8h	{ v20, v21, v22, v23 }, [x2]
addp.8h	v3, v3, v4
addp.8h	v20, v20, v21
addp.8h	v22, v22, v23
addp.8h	v1, v1, v3
addp.8h	v20, v20, v22
addp.8h	v1, v1, v20
uaddlv.8h	s1, v1
cmp	w4, #64
add.2s	v0, v0, v1
ushl.2s	v4, v0, v17
b.eq	ipred_dc_16bpc_neon
cmp	w4, #16
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v4, v4, v16
ushr.2s	v4, v4, #17
sub	x1, x1, #64
dup.8h	v0, v4[0]
dup.8h	v1, v4[0]
dup.8h	v2, v4[0]
dup.8h	v3, v4[0]
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
st1.8h	{ v0, v1, v2, v3 }, [x6], #64
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
st1.8h	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_16bpc_neon
ret
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
_ipred_paeth_16bpc_neon:
clz	w9, w3
adr	x5, #416
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.8h	{ v4 }, [x2]
add	x8, x2, #2
sub	x2, x2, #8
sub	x5, x5, w9, uxtw
mov	x7, #-8
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2d	{ v5 }, [x8]
sub.8h	v6, v5, v4
ld4r.4h	{ v0, v1, v2, v3 }, [x2], x7
zip1.2d	v0, v0, v1
zip1.2d	v2, v2, v3
add.8h	v16, v6, v0
add.8h	v17, v6, v2
sabd.8h	v20, v5, v16
sabd.8h	v21, v5, v17
sabd.8h	v22, v4, v16
sabd.8h	v23, v4, v17
sabd.8h	v16, v0, v16
sabd.8h	v17, v2, v17
umin.8h	v18, v20, v22
umin.8h	v19, v21, v23
cmge.8h	v20, v22, v20
cmge.8h	v21, v23, v21
cmge.8h	v16, v18, v16
cmge.8h	v17, v19, v17
bsl.16b	v21, v5, v4
bsl.16b	v20, v5, v4
bit.16b	v21, v2, v17
bit.16b	v20, v0, v16
st1.d	{ v21 }[1], [x0], x1
st1.d	{ v21 }[0], [x6], x1
subs	w4, w4, #4
st1.d	{ v20 }[1], [x0], x1
st1.d	{ v20 }[0], [x6], x1
b.gt	ipred_paeth_16bpc_neon
ret
ld1.8h	{ v5 }, [x8], #16
mov	w9, w3
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
sub.8h	v6, v5, v4
add.8h	v16, v6, v0
add.8h	v17, v6, v1
add.8h	v18, v6, v2
add.8h	v19, v6, v3
sabd.8h	v20, v5, v16
sabd.8h	v21, v5, v17
sabd.8h	v22, v5, v18
sabd.8h	v23, v5, v19
sabd.8h	v24, v4, v16
sabd.8h	v25, v4, v17
sabd.8h	v26, v4, v18
sabd.8h	v27, v4, v19
sabd.8h	v16, v0, v16
sabd.8h	v17, v1, v17
sabd.8h	v18, v2, v18
sabd.8h	v19, v3, v19
umin.8h	v28, v20, v24
umin.8h	v29, v21, v25
umin.8h	v30, v22, v26
umin.8h	v31, v23, v27
cmge.8h	v20, v24, v20
cmge.8h	v21, v25, v21
cmge.8h	v22, v26, v22
cmge.8h	v23, v27, v23
cmge.8h	v16, v28, v16
cmge.8h	v17, v29, v17
cmge.8h	v18, v30, v18
cmge.8h	v19, v31, v19
bsl.16b	v23, v5, v4
bsl.16b	v22, v5, v4
bsl.16b	v21, v5, v4
bsl.16b	v20, v5, v4
bit.16b	v23, v3, v19
bit.16b	v22, v2, v18
bit.16b	v21, v1, v17
bit.16b	v20, v0, v16
st1.8h	{ v23 }, [x0], #16
st1.8h	{ v22 }, [x6], #16
subs	w3, w3, #8
st1.8h	{ v21 }, [x5], #16
st1.8h	{ v20 }, [x10], #16
b.le	ipred_paeth_16bpc_neon
ld1.8h	{ v5 }, [x8], #16
b	ipred_paeth_16bpc_neon
subs	w4, w4, #4
b.le	ipred_paeth_16bpc_neon
sub	x8, x8, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
ld1.8h	{ v5 }, [x8], #16
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	ipred_paeth_16bpc_neon
ret
<unknown>
<unknown>
udf	#372
_ipred_smooth_16bpc_neon:
adrp	x10, ipred_smooth_16bpc_neon
add	x10, x10, #0
add	x11, x10, w4, uxtw
add	x10, x10, w3, uxtw
clz	w9, w3
adr	x5, #688
sub	x12, x2, w4, uxtw #1
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.8h	{ v4 }, [x12]
add	x8, x2, #2
sub	x5, x5, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2d	{ v6 }, [x8]
ld1r.2s	{ v7 }, [x10]
sub	x2, x2, #8
mov	x7, #-8
dup.8h	v5, v6[3]
sub.8h	v6, v6, v4
ushll.8h	v7, v7, #0
add.4h	v31, v4, v5
ld4r.4h	{ v0, v1, v2, v3 }, [x2], x7
ld4r.8b	{ v16, v17, v18, v19 }, [x11], #4
ushll.4s	v20, v31, #8
ushll.4s	v21, v31, #8
ushll.4s	v22, v31, #8
ushll.4s	v23, v31, #8
zip1.2d	v1, v1, v0
zip1.2d	v0, v3, v2
zip1.2s	v16, v16, v17
zip1.2s	v18, v18, v19
sub.8h	v0, v0, v5
sub.8h	v1, v1, v5
ushll.8h	v16, v16, #0
ushll.8h	v18, v18, #0
smlal.4s	v20, v0, v7
smlal2.4s	v21, v0, v7
smlal.4s	v22, v1, v7
smlal2.4s	v23, v1, v7
smlal.4s	v20, v6, v16
smlal2.4s	v21, v6, v16
smlal.4s	v22, v6, v18
smlal2.4s	v23, v6, v18
rshrn.4h	v20, v20, #9
rshrn.4h	v21, v21, #9
rshrn.4h	v22, v22, #9
rshrn.4h	v23, v23, #9
st1.4h	{ v20 }, [x0], x1
st1.4h	{ v21 }, [x6], x1
subs	w4, w4, #4
st1.4h	{ v22 }, [x0], x1
st1.4h	{ v23 }, [x6], x1
b.gt	ipred_smooth_16bpc_neon
ret
ld1.8h	{ v6 }, [x8]
ld1.8b	{ v7 }, [x10]
sub	x2, x2, #8
mov	x7, #-8
dup.8h	v5, v6[7]
sub.8h	v6, v6, v4
ushll.8h	v7, v7, #0
add.4h	v31, v4, v5
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
ld4r.8b	{ v16, v17, v18, v19 }, [x11], #4
ushll.4s	v20, v31, #8
ushll.4s	v21, v31, #8
ushll.4s	v22, v31, #8
ushll.4s	v23, v31, #8
ushll.4s	v24, v31, #8
ushll.4s	v25, v31, #8
ushll.4s	v26, v31, #8
ushll.4s	v27, v31, #8
sub.8h	v0, v0, v5
sub.8h	v1, v1, v5
sub.8h	v2, v2, v5
sub.8h	v3, v3, v5
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
smlal.4s	v20, v3, v7
smlal2.4s	v21, v3, v7
smlal.4s	v22, v2, v7
smlal2.4s	v23, v2, v7
smlal.4s	v24, v1, v7
smlal2.4s	v25, v1, v7
smlal.4s	v26, v0, v7
smlal2.4s	v27, v0, v7
smlal.4s	v20, v6, v16
smlal2.4s	v21, v6, v16
smlal.4s	v22, v6, v17
smlal2.4s	v23, v6, v17
smlal.4s	v24, v6, v18
smlal2.4s	v25, v6, v18
smlal.4s	v26, v6, v19
smlal2.4s	v27, v6, v19
rshrn.4h	v20, v20, #9
rshrn2.8h	v20, v21, #9
rshrn.4h	v21, v22, #9
rshrn2.8h	v21, v23, #9
rshrn.4h	v22, v24, #9
rshrn2.8h	v22, v25, #9
rshrn.4h	v23, v26, #9
rshrn2.8h	v23, v27, #9
st1.8h	{ v20 }, [x0], x1
st1.8h	{ v21 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v22 }, [x0], x1
st1.8h	{ v23 }, [x6], x1
b.gt	ipred_smooth_16bpc_neon
ret
add	x12, x2, w3, uxtw #1
sub	x1, x1, w3, uxtw #1
ld1r.8h	{ v5 }, [x12]
sub	x2, x2, #4
mov	x7, #-4
mov	w9, w3
add.4h	v31, v4, v5
ld2r.8h	{ v0, v1 }, [x2], x7
ld2r.8b	{ v16, v17 }, [x11], #2
sub.8h	v0, v0, v5
sub.8h	v1, v1, v5
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ld1.16b	{ v7 }, [x10], #16
ld1.8h	{ v2, v3 }, [x8], #32
ushll.4s	v20, v31, #8
ushll.4s	v21, v31, #8
ushll.4s	v22, v31, #8
ushll.4s	v23, v31, #8
ushll.4s	v24, v31, #8
ushll.4s	v25, v31, #8
ushll.4s	v26, v31, #8
ushll.4s	v27, v31, #8
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
sub.8h	v2, v2, v4
sub.8h	v3, v3, v4
smlal.4s	v20, v1, v6
smlal2.4s	v21, v1, v6
smlal.4s	v22, v1, v7
smlal2.4s	v23, v1, v7
smlal.4s	v24, v0, v6
smlal2.4s	v25, v0, v6
smlal.4s	v26, v0, v7
smlal2.4s	v27, v0, v7
smlal.4s	v20, v2, v16
smlal2.4s	v21, v2, v16
smlal.4s	v22, v3, v16
smlal2.4s	v23, v3, v16
smlal.4s	v24, v2, v17
smlal2.4s	v25, v2, v17
smlal.4s	v26, v3, v17
smlal2.4s	v27, v3, v17
rshrn.4h	v20, v20, #9
rshrn2.8h	v20, v21, #9
rshrn.4h	v21, v22, #9
rshrn2.8h	v21, v23, #9
rshrn.4h	v22, v24, #9
rshrn2.8h	v22, v25, #9
rshrn.4h	v23, v26, #9
rshrn2.8h	v23, v27, #9
subs	w3, w3, #16
st1.8h	{ v20, v21 }, [x0], #32
st1.8h	{ v22, v23 }, [x6], #32
b.gt	ipred_smooth_16bpc_neon
subs	w4, w4, #2
b.le	ipred_smooth_16bpc_neon
sub	x8, x8, w9, uxtw #1
sub	x10, x10, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	ipred_smooth_16bpc_neon
ret
<unknown>
<unknown>
udf	#648
_ipred_smooth_v_16bpc_neon:
adrp	x7, ipred_smooth_v_16bpc_neon
add	x7, x7, #0
add	x7, x7, w4, uxtw
clz	w9, w3
adr	x5, #380
sub	x8, x2, w4, uxtw #1
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.8h	{ v4 }, [x8]
add	x2, x2, #2
sub	x5, x5, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2d	{ v6 }, [x2]
sub.8h	v6, v6, v4
ld4r.8b	{ v16, v17, v18, v19 }, [x7], #4
zip1.2s	v16, v16, v17
zip1.2s	v18, v18, v19
ushll.8h	v16, v16, #7
ushll.8h	v18, v18, #7
sqrdmulh.8h	v20, v6, v16
sqrdmulh.8h	v21, v6, v18
add.8h	v20, v20, v4
add.8h	v21, v21, v4
st1.d	{ v20 }[0], [x0], x1
st1.d	{ v20 }[1], [x6], x1
subs	w4, w4, #4
st1.d	{ v21 }[0], [x0], x1
st1.d	{ v21 }[1], [x6], x1
b.gt	ipred_smooth_v_16bpc_neon
ret
ld1.8h	{ v6 }, [x2]
sub.8h	v6, v6, v4
ld4r.8b	{ v16, v17, v18, v19 }, [x7], #4
ushll.8h	v16, v16, #7
ushll.8h	v17, v17, #7
ushll.8h	v18, v18, #7
ushll.8h	v19, v19, #7
sqrdmulh.8h	v20, v6, v16
sqrdmulh.8h	v21, v6, v17
sqrdmulh.8h	v22, v6, v18
sqrdmulh.8h	v23, v6, v19
add.8h	v20, v20, v4
add.8h	v21, v21, v4
add.8h	v22, v22, v4
add.8h	v23, v23, v4
st1.8h	{ v20 }, [x0], x1
st1.8h	{ v21 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v22 }, [x0], x1
st1.8h	{ v23 }, [x6], x1
b.gt	ipred_smooth_v_16bpc_neon
ret
add	x5, x0, x1
add	x8, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
mov	w9, w3
ld4r.8b	{ v16, v17, v18, v19 }, [x7], #4
ushll.8h	v16, v16, #7
ushll.8h	v17, v17, #7
ushll.8h	v18, v18, #7
ushll.8h	v19, v19, #7
ld1.8h	{ v2, v3 }, [x2], #32
sub.8h	v2, v2, v4
sub.8h	v3, v3, v4
sqrdmulh.8h	v20, v2, v16
sqrdmulh.8h	v21, v3, v16
sqrdmulh.8h	v22, v2, v17
sqrdmulh.8h	v23, v3, v17
sqrdmulh.8h	v24, v2, v18
sqrdmulh.8h	v25, v3, v18
sqrdmulh.8h	v26, v2, v19
sqrdmulh.8h	v27, v3, v19
add.8h	v20, v20, v4
add.8h	v21, v21, v4
add.8h	v22, v22, v4
add.8h	v23, v23, v4
add.8h	v24, v24, v4
add.8h	v25, v25, v4
add.8h	v26, v26, v4
add.8h	v27, v27, v4
subs	w3, w3, #16
st1.8h	{ v20, v21 }, [x0], #32
st1.8h	{ v22, v23 }, [x6], #32
st1.8h	{ v24, v25 }, [x5], #32
st1.8h	{ v26, v27 }, [x8], #32
b.gt	ipred_smooth_v_16bpc_neon
subs	w4, w4, #4
b.le	ipred_smooth_v_16bpc_neon
sub	x2, x2, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x8, x8, x1
mov	w3, w9
b	ipred_smooth_v_16bpc_neon
ret
<unknown>
<unknown>
udf	#340
_ipred_smooth_h_16bpc_neon:
adrp	x8, ipred_smooth_h_16bpc_neon
add	x8, x8, #0
add	x8, x8, w3, uxtw
clz	w9, w3
adr	x5, #400
add	x12, x2, w3, uxtw #1
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.8h	{ v5 }, [x12]
sub	x5, x5, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2s	{ v7 }, [x8]
sub	x2, x2, #8
mov	x7, #-8
ushll.8h	v7, v7, #7
ld4r.4h	{ v0, v1, v2, v3 }, [x2], x7
zip1.2d	v1, v1, v0
zip1.2d	v0, v3, v2
sub.8h	v0, v0, v5
sub.8h	v1, v1, v5
sqrdmulh.8h	v20, v0, v7
sqrdmulh.8h	v21, v1, v7
add.8h	v20, v20, v5
add.8h	v21, v21, v5
st1.d	{ v20 }[0], [x0], x1
st1.d	{ v20 }[1], [x6], x1
subs	w4, w4, #4
st1.d	{ v21 }[0], [x0], x1
st1.d	{ v21 }[1], [x6], x1
b.gt	ipred_smooth_h_16bpc_neon
ret
ld1.8b	{ v7 }, [x8]
sub	x2, x2, #8
mov	x7, #-8
ushll.8h	v7, v7, #7
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
sub.8h	v3, v3, v5
sub.8h	v2, v2, v5
sub.8h	v1, v1, v5
sub.8h	v0, v0, v5
sqrdmulh.8h	v20, v3, v7
sqrdmulh.8h	v21, v2, v7
sqrdmulh.8h	v22, v1, v7
sqrdmulh.8h	v23, v0, v7
add.8h	v20, v20, v5
add.8h	v21, v21, v5
add.8h	v22, v22, v5
add.8h	v23, v23, v5
st1.8h	{ v20 }, [x0], x1
st1.8h	{ v21 }, [x6], x1
subs	w4, w4, #4
st1.8h	{ v22 }, [x0], x1
st1.8h	{ v23 }, [x6], x1
b.gt	ipred_smooth_h_16bpc_neon
ret
sub	x2, x2, #8
mov	x7, #-8
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
mov	w9, w3
ld4r.8h	{ v0, v1, v2, v3 }, [x2], x7
sub.8h	v0, v0, v5
sub.8h	v1, v1, v5
sub.8h	v2, v2, v5
sub.8h	v3, v3, v5
ld1.16b	{ v7 }, [x8], #16
ushll.8h	v6, v7, #7
ushll2.8h	v7, v7, #7
sqrdmulh.8h	v20, v3, v6
sqrdmulh.8h	v21, v3, v7
sqrdmulh.8h	v22, v2, v6
sqrdmulh.8h	v23, v2, v7
sqrdmulh.8h	v24, v1, v6
sqrdmulh.8h	v25, v1, v7
sqrdmulh.8h	v26, v0, v6
sqrdmulh.8h	v27, v0, v7
add.8h	v20, v20, v5
add.8h	v21, v21, v5
add.8h	v22, v22, v5
add.8h	v23, v23, v5
add.8h	v24, v24, v5
add.8h	v25, v25, v5
add.8h	v26, v26, v5
add.8h	v27, v27, v5
subs	w3, w3, #16
st1.8h	{ v20, v21 }, [x0], #32
st1.8h	{ v22, v23 }, [x6], #32
st1.8h	{ v24, v25 }, [x5], #32
st1.8h	{ v26, v27 }, [x10], #32
b.gt	ipred_smooth_h_16bpc_neon
subs	w4, w4, #4
b.le	ipred_smooth_h_16bpc_neon
sub	x8, x8, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	ipred_smooth_h_16bpc_neon
ret
<unknown>
<unknown>
udf	#364
_ipred_z1_upsample_edge_16bpc_neon:
dup.8h	v30, w4
adrp	x4, ipred_z1_upsample_edge_16bpc_neon
add	x4, x4, #0
ld1.8h	{ v0, v1 }, [x2]
add	x5, x2, w3, uxtw #1
sub	x4, x4, w3, uxtw #1
ld1r.8h	{ v2 }, [x5]
ld1.8h	{ v3, v4 }, [x4]
movi.8h	v31, #9
bit.16b	v0, v2, v3
bit.16b	v1, v2, v4
ext.16b	v4, v0, v1, #2
ext.16b	v5, v1, v2, #2
ext.16b	v6, v0, v1, #4
ext.16b	v7, v1, v2, #4
ext.16b	v16, v0, v1, #6
ext.16b	v17, v1, v2, #6
add.8h	v18, v4, v6
add.8h	v19, v5, v7
add.8h	v20, v0, v16
add.8h	v21, v1, v17
umull.4s	v22, v18, v31
umull2.4s	v23, v18, v31
umull.4s	v24, v19, v31
umull2.4s	v25, v19, v31
usubw.4s	v22, v22, v20
usubw2.4s	v23, v23, v20
usubw.4s	v24, v24, v21
usubw2.4s	v25, v25, v21
sqrshrun.4h	v16, v22, #4
sqrshrun2.8h	v16, v23, #4
sqrshrun.4h	v17, v24, #4
sqrshrun2.8h	v17, v25, #4
smin.8h	v16, v16, v30
smin.8h	v17, v17, v30
zip1.8h	v0, v4, v16
zip2.8h	v1, v4, v16
zip1.8h	v2, v5, v17
zip2.8h	v3, v5, v17
st1.8h	{ v0, v1, v2, v3 }, [x0]
ret
_ipred_z2_upsample_edge_16bpc_neon:
dup.8h	v30, w3
adrp	x4, ipred_z2_upsample_edge_16bpc_neon
add	x4, x4, #0
ld1.8h	{ v0, v1 }, [x2]
add	x5, x2, w1, uxtw #1
sub	x4, x4, w1, uxtw #1
ld1r.8h	{ v3 }, [x2]
ld1r.8h	{ v2 }, [x5]
ld1.8h	{ v4, v5 }, [x4]
movi.8h	v31, #9
bit.16b	v0, v2, v4
bit.16b	v1, v2, v5
ext.16b	v4, v3, v0, #14
ext.16b	v5, v0, v1, #2
ext.16b	v6, v0, v1, #4
add.8h	v16, v0, v5
add.8h	v17, v4, v6
umull.4s	v18, v16, v31
umull2.4s	v19, v16, v31
usubw.4s	v18, v18, v17
usubw2.4s	v19, v19, v17
sqrshrun.4h	v16, v18, #4
sqrshrun2.8h	v16, v19, #4
add	x5, x0, #32
smin.8h	v16, v16, v30
zip1.8h	v4, v0, v16
zip2.8h	v5, v0, v16
st1.h	{ v2 }[0], [x5]
st1.8h	{ v4, v5 }, [x0]
ret
_ipred_z1_filter_edge_16bpc_neon:
cmp	w4, #3
b.eq	ipred_z1_filter_edge_16bpc_neon
adrp	x5, ipred_z1_filter_edge_16bpc_neon
add	x5, x5, #0
sub	x5, x5, #6
add	x5, x5, w4, uxtw #3
ld1.s	{ v31 }[0], [x5]
ld1.8h	{ v0 }, [x2], #16
dup.8h	v30, v31[0]
dup.8h	v31, v31[1]
cmp	w3, #17
ld1.8h	{ v1, v2 }, [x2], #32
b.lt	ipred_z1_filter_edge_16bpc_neon
ext.16b	v3, v0, v1, #2
ext.16b	v4, v1, v2, #2
ext.16b	v5, v0, v1, #4
ext.16b	v6, v1, v2, #4
mul.8h	v16, v0, v30
mla.8h	v16, v3, v31
mla.8h	v16, v5, v30
mul.8h	v17, v1, v30
mla.8h	v17, v4, v31
mla.8h	v17, v6, v30
subs	w1, w1, #16
mov.16b	v0, v2
urshr.8h	v16, v16, #4
urshr.8h	v17, v17, #4
sub	w3, w3, #16
st1.8h	{ v16, v17 }, [x0], #32
b.gt	ipred_z1_filter_edge_16bpc_neon
ret
adrp	x5, ipred_z1_filter_edge_16bpc_neon
add	x5, x5, #0
sub	w6, w3, #24
sub	x5, x5, w3, uxtw #1
add	x6, x2, w6, sxtw #1
ld1.8h	{ v3, v4 }, [x5]
ld1r.8h	{ v2 }, [x6]
bit.16b	v0, v2, v3
bit.16b	v1, v2, v4
ext.16b	v3, v0, v1, #2
ext.16b	v4, v1, v2, #2
ext.16b	v5, v0, v1, #4
ext.16b	v6, v1, v2, #4
mul.8h	v16, v0, v30
mla.8h	v16, v3, v31
mla.8h	v16, v5, v30
mul.8h	v17, v1, v30
mla.8h	v17, v4, v31
mla.8h	v17, v6, v30
subs	w1, w1, #16
urshr.8h	v16, v16, #4
urshr.8h	v17, v17, #4
st1.8h	{ v16, v17 }, [x0], #32
b.le	ipred_z1_filter_edge_16bpc_neon
subs	w1, w1, #16
st1.16b	{ v2 }, [x0], #16
b.gt	ipred_z1_filter_edge_16bpc_neon
ret
sub	x2, x2, #2
movi.8h	v29, #2
ld1.8h	{ v0 }, [x2], #16
movi.8h	v30, #4
movi.8h	v31, #4
mov.h	v0[0], v0[1]
cmp	w3, #18
ld1.8h	{ v1, v2 }, [x2], #32
b.lt	ipred_z1_filter_edge_16bpc_neon
ext.16b	v3, v0, v1, #2
ext.16b	v4, v1, v2, #2
ext.16b	v5, v0, v1, #4
ext.16b	v6, v1, v2, #4
ext.16b	v16, v0, v1, #6
ext.16b	v17, v1, v2, #6
ext.16b	v18, v0, v1, #8
ext.16b	v19, v1, v2, #8
mul.8h	v20, v0, v29
mla.8h	v20, v3, v30
mla.8h	v20, v5, v31
mla.8h	v20, v16, v30
mla.8h	v20, v18, v29
mul.8h	v21, v1, v29
mla.8h	v21, v4, v30
mla.8h	v21, v6, v31
mla.8h	v21, v17, v30
mla.8h	v21, v19, v29
subs	w1, w1, #16
mov.16b	v0, v2
urshr.8h	v20, v20, #4
urshr.8h	v21, v21, #4
sub	w3, w3, #16
st1.8h	{ v20, v21 }, [x0], #32
b.gt	ipred_z1_filter_edge_16bpc_neon
ret
adrp	x5, ipred_z1_filter_edge_16bpc_neon
add	x5, x5, #0
sub	x5, x5, #2
sub	w6, w3, #23
sub	x5, x5, w3, uxtw #1
add	x6, x2, w6, sxtw #1
ld1.8h	{ v3, v4, v5 }, [x5]
ld1r.8h	{ v28 }, [x6]
bit.16b	v0, v28, v3
bit.16b	v1, v28, v4
bit.16b	v2, v28, v5
ext.16b	v3, v0, v1, #2
ext.16b	v4, v1, v2, #2
ext.16b	v5, v0, v1, #4
ext.16b	v6, v1, v2, #4
ext.16b	v16, v0, v1, #6
ext.16b	v17, v1, v2, #6
ext.16b	v18, v0, v1, #8
ext.16b	v19, v1, v2, #8
mul.8h	v20, v0, v29
mla.8h	v20, v3, v30
mla.8h	v20, v5, v31
mla.8h	v20, v16, v30
mla.8h	v20, v18, v29
mul.8h	v21, v1, v29
mla.8h	v21, v4, v30
mla.8h	v21, v6, v31
mla.8h	v21, v17, v30
mla.8h	v21, v19, v29
subs	w1, w1, #16
mov.16b	v0, v2
mov.16b	v1, v28
mov.16b	v2, v28
urshr.8h	v20, v20, #4
urshr.8h	v21, v21, #4
sub	w3, w3, #16
st1.8h	{ v20, v21 }, [x0], #32
b.le	ipred_z1_filter_edge_16bpc_neon
cmp	w3, #0
b.ge	ipred_z1_filter_edge_16bpc_neon
subs	w1, w1, #8
st1.8h	{ v28 }, [x0], #16
b.gt	ipred_z1_filter_edge_16bpc_neon
ret
_ipred_pixel_set_16bpc_neon:
dup.8h	v0, w1
subs	w2, w2, #8
st1.8h	{ v0 }, [x0], #16
b.gt	ipred_pixel_set_16bpc_neon
ret
_ipred_z1_fill1_16bpc_neon:
clz	w9, w3
adr	x8, #652
sub	w9, w9, #25
ldrh	w9, [x8, w9, uxtw #1]
add	x10, x2, w6, uxtw #1
sub	x8, x8, w9, uxtw
ld1r.8h	{ v31 }, [x10]
mov	w7, w5
mov	w15, #64
br	x8
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill1_16bpc_neon
lsl	w8, w8, #1
lsl	w10, w10, #1
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup.4h	v4, w9
dup.4h	v5, w11
ext.16b	v1, v0, v0, #2
ext.16b	v3, v2, v2, #2
sub.4h	v6, v1, v0
sub.4h	v7, v3, v2
ushll.4s	v16, v0, #6
ushll.4s	v17, v2, #6
smlal.4s	v16, v6, v4
smlal.4s	v17, v7, v5
rshrn.4h	v16, v16, #6
rshrn.4h	v17, v17, #6
st1.4h	{ v16 }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.4h	{ v17 }, [x0], x1
b.gt	ipred_z1_fill1_16bpc_neon
ret
st1.4h	{ v31 }, [x0], x1
subs	w4, w4, #2
st1.4h	{ v31 }, [x0], x1
b.gt	ipred_z1_fill1_16bpc_neon
ret
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill1_16bpc_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup.8h	v4, w9
dup.8h	v5, w11
ld1.8h	{ v0 }, [x8]
ld1.8h	{ v2 }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
ldr	h1, [x8, #16]
ldr	h3, [x10, #16]
dup.8h	v6, w9
dup.8h	v7, w11
ext.16b	v1, v0, v1, #2
ext.16b	v3, v2, v3, #2
umull.4s	v16, v0, v6
umlal.4s	v16, v1, v4
umull2.4s	v17, v0, v6
umlal2.4s	v17, v1, v4
umull.4s	v18, v2, v7
umlal.4s	v18, v3, v5
umull2.4s	v19, v2, v7
umlal2.4s	v19, v3, v5
rshrn.4h	v16, v16, #6
rshrn2.8h	v16, v17, #6
rshrn.4h	v17, v18, #6
rshrn2.8h	v17, v19, #6
st1.8h	{ v16 }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.8h	{ v17 }, [x0], x1
b.gt	ipred_z1_fill1_16bpc_neon
ret
st1.8h	{ v31 }, [x0], x1
subs	w4, w4, #2
st1.8h	{ v31 }, [x0], x1
b.gt	ipred_z1_fill1_16bpc_neon
ret
mov	w12, w3
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill1_16bpc_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup.8h	v6, w9
dup.8h	v7, w11
ld1.8h	{ v0, v1, v2 }, [x8], #48
ld1.8h	{ v3, v4, v5 }, [x10], #48
sub	w9, w15, w9
sub	w11, w15, w11
dup.8h	v16, w9
dup.8h	v17, w11
add	w7, w7, w5
ext.16b	v18, v0, v1, #2
ext.16b	v19, v1, v2, #2
ext.16b	v20, v3, v4, #2
ext.16b	v21, v4, v5, #2
subs	w3, w3, #16
umull.4s	v22, v0, v16
umlal.4s	v22, v18, v6
umull2.4s	v23, v0, v16
umlal2.4s	v23, v18, v6
umull.4s	v24, v1, v16
umlal.4s	v24, v19, v6
umull2.4s	v25, v1, v16
umlal2.4s	v25, v19, v6
umull.4s	v26, v3, v17
umlal.4s	v26, v20, v7
umull2.4s	v27, v3, v17
umlal2.4s	v27, v20, v7
umull.4s	v28, v4, v17
umlal.4s	v28, v21, v7
umull2.4s	v29, v4, v17
umlal2.4s	v29, v21, v7
rshrn.4h	v22, v22, #6
rshrn2.8h	v22, v23, #6
rshrn.4h	v23, v24, #6
rshrn2.8h	v23, v25, #6
rshrn.4h	v24, v26, #6
rshrn2.8h	v24, v27, #6
rshrn.4h	v25, v28, #6
rshrn2.8h	v25, v29, #6
st1.8h	{ v22, v23 }, [x0], #32
st1.8h	{ v24, v25 }, [x13], #32
b.le	ipred_z1_fill1_16bpc_neon
mov.16b	v0, v2
ld1.8h	{ v1, v2 }, [x8], #32
mov.16b	v3, v5
ld1.8h	{ v4, v5 }, [x10], #32
b	ipred_z1_fill1_16bpc_neon
subs	w4, w4, #2
b.le	ipred_z1_fill1_16bpc_neon
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	ipred_z1_fill1_16bpc_neon
ret
st1.8h	{ v31 }, [x0], #16
subs	w3, w3, #8
st1.8h	{ v31 }, [x13], #16
b.gt	ipred_z1_fill1_16bpc_neon
subs	w4, w4, #2
b.le	ipred_z1_fill1_16bpc_neon
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	ipred_z1_fill1_16bpc_neon
<unknown>
<unknown>
udf	#616
_ipred_z1_fill2_16bpc_neon:
cmp	w3, #8
add	x10, x2, w6, uxtw
ld1r.16b	{ v31 }, [x10]
mov	w7, w5
mov	w15, #64
b.eq	ipred_z1_fill2_16bpc_neon
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill2_16bpc_neon
lsl	w8, w8, #1
lsl	w10, w10, #1
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup.4h	v4, w9
dup.4h	v5, w11
uzp2.8h	v1, v0, v0
uzp1.8h	v0, v0, v0
uzp2.8h	v3, v2, v2
uzp1.8h	v2, v2, v2
sub.4h	v6, v1, v0
sub.4h	v7, v3, v2
ushll.4s	v16, v0, #6
ushll.4s	v17, v2, #6
smlal.4s	v16, v6, v4
smlal.4s	v17, v7, v5
rshrn.4h	v16, v16, #6
rshrn.4h	v17, v17, #6
st1.4h	{ v16 }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.4h	{ v17 }, [x0], x1
b.gt	ipred_z1_fill2_16bpc_neon
ret
st1.4h	{ v31 }, [x0], x1
subs	w4, w4, #2
st1.4h	{ v31 }, [x0], x1
b.gt	ipred_z1_fill2_16bpc_neon
ret
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill2_16bpc_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup.8h	v4, w9
dup.8h	v5, w11
ld1.8h	{ v0, v1 }, [x8]
ld1.8h	{ v2, v3 }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
dup.8h	v6, w9
dup.8h	v7, w11
uzp2.8h	v20, v0, v1
uzp1.8h	v0, v0, v1
uzp2.8h	v21, v2, v3
uzp1.8h	v2, v2, v3
umull.4s	v16, v0, v6
umlal.4s	v16, v20, v4
umull2.4s	v17, v0, v6
umlal2.4s	v17, v20, v4
umull.4s	v18, v2, v7
umlal.4s	v18, v21, v5
umull2.4s	v19, v2, v7
umlal2.4s	v19, v21, v5
rshrn.4h	v16, v16, #6
rshrn2.8h	v16, v17, #6
rshrn.4h	v17, v18, #6
rshrn2.8h	v17, v19, #6
st1.8h	{ v16 }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.8h	{ v17 }, [x0], x1
b.gt	ipred_z1_fill2_16bpc_neon
ret
st1.8h	{ v31 }, [x0], x1
subs	w4, w4, #2
st1.8h	{ v31 }, [x0], x1
b.gt	ipred_z1_fill2_16bpc_neon
ret
_ipred_reverse_16bpc_neon:
sub	x1, x1, #16
add	x3, x0, #8
mov	x4, #16
ld1.8h	{ v0 }, [x1]
subs	w2, w2, #8
rev64.8h	v0, v0
sub	x1, x1, #16
st1.d	{ v0 }[1], [x0], x4
st1.d	{ v0 }[0], [x3], x4
b.gt	ipred_reverse_16bpc_neon
ret
_ipred_z2_fill1_16bpc_neon:
clz	w10, w4
adr	x9, #2252
sub	w10, w10, #25
ldrh	w10, [x9, w10, uxtw #1]
mov	w8, #64
sub	x9, x9, w10, uxtw
sub	w8, w8, w6
adrp	x11, ipred_z2_fill1_16bpc_neon
add	x11, x11, #0
ld1.8h	{ v31 }, [x11]
neg	w7, w7
br	x9
dup.4h	v30, w7
movi.8b	v17, #1
mul.4h	v16, v31, v30
movi.8h	v25, #62
add.4h	v30, v16, v30
ld1.8h	{ v0, v1, v2 }, [x3]
movi.8h	v26, #64
movi.16b	v19, #4
shrn.8b	v29, v30, #6
and.8b	v27, v30, v25
add.8b	v29, v29, v17
movi.4h	v23, #1, lsl #8
shl.8b	v29, v29, #1
zip1.8b	v29, v29, v29
movi.8b	v17, #2
add.8b	v29, v29, v23
add.8b	v30, v29, v17
add.8b	v28, v29, v19
tbl.8b	v18, { v0 }, v29
trn1.2d	v30, v30, v28
sub.4h	v28, v26, v27
trn1.2d	v31, v31, v31
trn1.2d	v27, v27, v27
trn1.2d	v28, v28, v28
movi.16b	v29, #4
asr	w9, w8, #6
dup.4h	v16, w8
sub	w8, w8, w6
cmn	w9, #4
asr	w11, w8, #6
b.le	ipred_z2_fill1_16bpc_neon
lsl	w9, w9, #1
lsl	w11, w11, #1
dup.4h	v17, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
trn1.2d	v16, v16, v17
tbl.16b	v19, { v0, v1 }, v30
sshr.8h	v20, v16, #6
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
and.16b	v16, v16, v25
trn1.2d	v18, v18, v19
trn1.2d	v4, v4, v6
trn1.2d	v5, v5, v7
sub.8h	v17, v26, v16
add.8h	v20, v20, v31
umull.4s	v21, v18, v28
umlal.4s	v21, v19, v27
umull2.4s	v22, v18, v28
umlal2.4s	v22, v19, v27
umull.4s	v23, v4, v17
umlal.4s	v23, v5, v16
umull2.4s	v24, v4, v17
umlal2.4s	v24, v5, v16
cmge.8h	v20, v20, #0
rshrn.4h	v21, v21, #6
rshrn2.8h	v21, v22, #6
rshrn.4h	v22, v23, #6
rshrn2.8h	v22, v24, #6
bit.16b	v21, v22, v20
st1.d	{ v21 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.d	{ v21 }[1], [x0], x1
b.le	ipred_z2_fill1_16bpc_neon
ext.16b	v18, v19, v19, #8
add.16b	v30, v30, v29
b	ipred_z2_fill1_16bpc_neon
tbl.16b	v19, { v0, v1, v2 }, v30
trn1.2d	v18, v18, v19
umull.4s	v20, v18, v28
umlal.4s	v20, v19, v27
umull2.4s	v21, v18, v28
umlal2.4s	v21, v19, v27
rshrn.4h	v20, v20, #6
rshrn2.8h	v20, v21, #6
st1.d	{ v20 }[0], [x0], x1
subs	w5, w5, #2
st1.d	{ v20 }[1], [x0], x1
b.le	ipred_z2_fill1_16bpc_neon
ext.16b	v18, v19, v19, #8
add.16b	v30, v30, v29
b	ipred_z2_fill1_16bpc_neon
ret
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
dup.8h	v18, w7
add	x3, x3, #2
mul.8h	v16, v31, v18
movi.8h	v25, #62
add.8h	v16, v16, v18
ld1.8h	{ v0, v1, v2, v3 }, [x3]
ld1r.8h	{ v15 }, [x2]
movi.8h	v26, #64
movi.16b	v19, #4
shrn.8b	v29, v16, #6
and.16b	v27, v16, v25
movi.8h	v23, #1, lsl #8
shl.8b	v29, v29, #1
mov.16b	v18, v15
zip1.16b	v29, v29, v29
movi.16b	v17, #2
add.16b	v29, v29, v23
tbx.16b	v18, { v0 }, v29
add.16b	v30, v29, v19
add.16b	v29, v29, v17
sub.8h	v28, v26, v27
movi.16b	v24, #4
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #16
asr	w11, w8, #6
b.le	ipred_z2_fill1_16bpc_neon
dup.8h	v17, w8
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
ld1.8h	{ v4, v5 }, [x9]
mov.16b	v19, v15
ld1.8h	{ v6, v7 }, [x11]
tbx.16b	v19, { v0, v1, v2, v3 }, v29
mov.16b	v20, v15
sshr.8h	v21, v16, #6
sshr.8h	v22, v17, #6
tbx.16b	v20, { v0, v1, v2, v3 }, v30
ext.16b	v5, v4, v5, #2
ext.16b	v7, v6, v7, #2
and.16b	v16, v16, v25
and.16b	v17, v17, v25
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
sub.8h	v8, v26, v16
sub.8h	v9, v26, v17
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
add.8h	v21, v21, v31
add.8h	v22, v22, v31
umull.4s	v12, v19, v28
umlal.4s	v12, v20, v27
umull2.4s	v13, v19, v28
umlal2.4s	v13, v20, v27
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
umull.4s	v12, v4, v8
umlal.4s	v12, v5, v16
umull2.4s	v13, v4, v8
umlal2.4s	v13, v5, v16
umull.4s	v14, v6, v9
umlal.4s	v14, v7, v17
umull2.4s	v18, v6, v9
umlal2.4s	v18, v7, v17
cmge.8h	v21, v21, #0
cmge.8h	v22, v22, #0
rshrn.4h	v12, v12, #6
rshrn2.8h	v12, v13, #6
rshrn.4h	v13, v14, #6
rshrn2.8h	v13, v18, #6
bit.16b	v10, v12, v21
bit.16b	v11, v13, v22
st1.8h	{ v10 }, [x0], x1
subs	w5, w5, #2
sub	w8, w8, w6
st1.8h	{ v11 }, [x0], x1
b.le	ipred_z2_fill1_16bpc_neon
mov.16b	v18, v20
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill1_16bpc_neon
mov.16b	v19, v15
mov.16b	v20, v15
tbx.16b	v19, { v0, v1, v2, v3 }, v29
tbx.16b	v20, { v0, v1, v2, v3 }, v30
umull.4s	v4, v18, v28
umlal.4s	v4, v19, v27
umull2.4s	v5, v18, v28
umlal2.4s	v5, v19, v27
umull.4s	v6, v19, v28
umlal.4s	v6, v20, v27
umull2.4s	v7, v19, v28
umlal2.4s	v7, v20, v27
rshrn.4h	v4, v4, #6
rshrn2.8h	v4, v5, #6
rshrn.4h	v5, v6, #6
rshrn2.8h	v5, v7, #6
st1.8h	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v5 }, [x0], x1
b.le	ipred_z2_fill1_16bpc_neon
mov.16b	v18, v20
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill1_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
dup.8h	v25, w7
add	x3, x3, #2
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
movi.8h	v11, #8
mul.8h	v26, v31, v25
add.8h	v26, v26, v25
mul.8h	v25, v25, v11
ld1.8h	{ v0, v1, v2, v3 }, [x3]
ld1r.8h	{ v15 }, [x2]
mov	w12, w4
neg	w14, w4
mov.16b	v23, v26
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmp	w9, w14
asr	w11, w8, #6
b.le	ipred_z2_fill1_16bpc_neon
dup.8h	v17, w8
sub	w8, w8, w6
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
sshr.8h	v21, v16, #6
sshr.8h	v22, v17, #6
ld1.8h	{ v4 }, [x9], #16
ld1.8h	{ v6 }, [x11], #16
movi.8h	v10, #62
movi.8h	v11, #64
and.16b	v16, v16, v10
and.16b	v17, v17, v10
sub.8h	v8, v11, v16
sub.8h	v9, v11, v17
add.8h	v21, v21, v31
add.8h	v22, v22, v31
smov.h	w10, v22[0]
shrn.8b	v29, v23, #6
movi.8h	v12, #64
cmp	w10, #0
smov.b	w10, v29[0]
movi.8h	v10, #62
b.ge	ipred_z2_fill1_16bpc_neon
and.16b	v27, v23, v10
cmp	w10, #29
mov.16b	v18, v15
sub.8h	v28, v12, v27
b.gt	ipred_z2_fill1_16bpc_neon
shl.8b	v29, v29, #1
movi.8h	v11, #1, lsl #8
zip1.16b	v29, v29, v29
add.16b	v29, v29, v11
movi.16b	v13, #2
tbx.16b	v18, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v13
mov.16b	v19, v15
tbx.16b	v19, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v13
mov.16b	v20, v15
tbx.16b	v20, { v0, v1, v2, v3 }, v29
b	ipred_z2_fill1_16bpc_neon
smov.b	w15, v29[1]
smov.b	w16, v29[2]
add	x10, x3, w10, sxtw #1
smov.b	w17, v29[3]
add	x15, x3, w15, sxtw #1
ld3.h	{ v18, v19, v20 }[0], [x10]
smov.b	w10, v29[4]
add	x16, x3, w16, sxtw #1
ld3.h	{ v18, v19, v20 }[1], [x15]
smov.b	w15, v29[5]
add	x17, x3, w17, sxtw #1
ld3.h	{ v18, v19, v20 }[2], [x16]
smov.b	w16, v29[6]
add	x10, x3, w10, sxtw #1
ld3.h	{ v18, v19, v20 }[3], [x17]
smov.b	w17, v29[7]
add	x15, x3, w15, sxtw #1
add	x16, x3, w16, sxtw #1
ld3.h	{ v18, v19, v20 }[4], [x10]
add	x17, x3, w17, sxtw #1
ld3.h	{ v18, v19, v20 }[5], [x15]
ld3.h	{ v18, v19, v20 }[6], [x16]
ld3.h	{ v18, v19, v20 }[7], [x17]
ld1.8h	{ v5 }, [x9], #16
ld1.8h	{ v7 }, [x11], #16
add.8h	v23, v23, v25
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
umull.4s	v12, v19, v28
umlal.4s	v12, v20, v27
umull2.4s	v13, v19, v28
umlal2.4s	v13, v20, v27
ext.16b	v18, v4, v5, #2
ext.16b	v19, v6, v7, #2
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
umull.4s	v12, v4, v8
umlal.4s	v12, v18, v16
umull2.4s	v13, v4, v8
umlal2.4s	v13, v18, v16
umull.4s	v14, v6, v9
umlal.4s	v14, v19, v17
umull2.4s	v20, v6, v9
umlal2.4s	v20, v19, v17
cmge.8h	v18, v21, #0
cmge.8h	v19, v22, #0
rshrn.4h	v12, v12, #6
rshrn2.8h	v12, v13, #6
rshrn.4h	v13, v14, #6
rshrn2.8h	v13, v20, #6
bit.16b	v10, v12, v18
bit.16b	v11, v13, v19
st1.8h	{ v10 }, [x0], #16
subs	w4, w4, #8
st1.8h	{ v11 }, [x13], #16
b.le	ipred_z2_fill1_16bpc_neon
movi.8h	v10, #8
mov.16b	v4, v5
mov.16b	v6, v7
add.8h	v21, v21, v10
add.8h	v22, v22, v10
b	ipred_z2_fill1_16bpc_neon
subs	w5, w5, #2
b.le	ipred_z2_fill1_16bpc_neon
movi.8h	v10, #128
add	x0, x0, x1
add	x13, x13, x1
mov	w4, w12
add.8h	v26, v26, v10
b	ipred_z2_fill1_16bpc_neon
ld1.8h	{ v5 }, [x9], #16
ld1.8h	{ v7 }, [x11], #16
ext.16b	v18, v4, v5, #2
ext.16b	v19, v6, v7, #2
umull.4s	v12, v4, v8
umlal.4s	v12, v18, v16
umull2.4s	v13, v4, v8
umlal2.4s	v13, v18, v16
umull.4s	v14, v6, v9
umlal.4s	v14, v19, v17
umull2.4s	v20, v6, v9
umlal2.4s	v20, v19, v17
rshrn.4h	v12, v12, #6
rshrn2.8h	v12, v13, #6
rshrn.4h	v13, v14, #6
rshrn2.8h	v13, v20, #6
st1.8h	{ v12 }, [x0], #16
subs	w4, w4, #8
st1.8h	{ v13 }, [x13], #16
b.le	ipred_z2_fill1_16bpc_neon
mov.16b	v4, v5
mov.16b	v6, v7
b	ipred_z2_fill1_16bpc_neon
add	x1, x1, w4, uxtw #1
mov	w12, w5
movi.8h	v12, #64
movi.8h	v10, #62
shrn.8b	v29, v23, #6
and.16b	v27, v23, v10
smov.b	w10, v29[0]
shl.8b	v29, v29, #1
movi.8h	v11, #1, lsl #8
zip1.16b	v29, v29, v29
add.8h	v23, v23, v25
add.16b	v29, v29, v11
cmp	w10, #31
mov.16b	v18, v15
movi.16b	v21, #2
sub.8h	v28, v12, v27
b.gt	ipred_z2_fill1_16bpc_neon
tbx.16b	v18, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v21
smov.b	w10, v29[0]
mov.16b	v19, v15
cmp	w10, #60
b.gt	ipred_z2_fill1_16bpc_neon
tbx.16b	v19, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v21
mov.16b	v20, v15
tbx.16b	v20, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v21
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
umull.4s	v12, v19, v28
umlal.4s	v12, v20, v27
umull2.4s	v13, v19, v28
umlal2.4s	v13, v20, v27
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
st1.8h	{ v10 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v11 }, [x13], x1
b.le	ipred_z2_fill1_16bpc_neon
mov.16b	v18, v20
b	ipred_z2_fill1_16bpc_neon
smov.b	w10, v29[0]
smov.b	w15, v29[2]
movi.16b	v21, #2
smov.b	w16, v29[4]
add	x10, x3, w10, sxtw
smov.b	w17, v29[6]
add	x15, x3, w15, sxtw
ld1.h	{ v18 }[0], [x10]
smov.b	w10, v29[8]
add	x16, x3, w16, sxtw
ld1.h	{ v18 }[1], [x15]
smov.b	w15, v29[10]
add	x17, x3, w17, sxtw
ld1.h	{ v18 }[2], [x16]
smov.b	w16, v29[12]
add	x10, x3, w10, sxtw
ld1.h	{ v18 }[3], [x17]
smov.b	w17, v29[14]
add	x15, x3, w15, sxtw
add	x16, x3, w16, sxtw
ld1.h	{ v18 }[4], [x10]
add	x17, x3, w17, sxtw
ld1.h	{ v18 }[5], [x15]
add.16b	v29, v29, v21
ld1.h	{ v18 }[6], [x16]
ld1.h	{ v18 }[7], [x17]
cmp	w5, #4
b.lt	ipred_z2_fill1_16bpc_neon
smov.b	w10, v29[0]
subs	w5, w5, #4
smov.b	w15, v29[2]
movi.16b	v10, #8
smov.b	w16, v29[4]
add	x10, x3, w10, sxtw
smov.b	w17, v29[6]
add	x15, x3, w15, sxtw
ld4.h	{ v19, v20, v21, v22 }[0], [x10]
smov.b	w10, v29[8]
add	x16, x3, w16, sxtw
ld4.h	{ v19, v20, v21, v22 }[1], [x15]
smov.b	w15, v29[10]
add	x17, x3, w17, sxtw
ld4.h	{ v19, v20, v21, v22 }[2], [x16]
smov.b	w16, v29[12]
add	x10, x3, w10, sxtw
ld4.h	{ v19, v20, v21, v22 }[3], [x17]
smov.b	w17, v29[14]
add	x15, x3, w15, sxtw
add	x16, x3, w16, sxtw
ld4.h	{ v19, v20, v21, v22 }[4], [x10]
add	x17, x3, w17, sxtw
ld4.h	{ v19, v20, v21, v22 }[5], [x15]
ld4.h	{ v19, v20, v21, v22 }[6], [x16]
add.16b	v29, v29, v10
ld4.h	{ v19, v20, v21, v22 }[7], [x17]
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
umull.4s	v12, v19, v28
umlal.4s	v12, v20, v27
umull2.4s	v13, v19, v28
umlal2.4s	v13, v20, v27
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
umull.4s	v12, v20, v28
umlal.4s	v12, v21, v27
umull2.4s	v13, v20, v28
umlal2.4s	v13, v21, v27
umull.4s	v14, v21, v28
umlal.4s	v14, v22, v27
umull2.4s	v18, v21, v28
umlal2.4s	v18, v22, v27
rshrn.4h	v12, v12, #6
rshrn2.8h	v12, v13, #6
rshrn.4h	v13, v14, #6
rshrn2.8h	v13, v18, #6
st1.8h	{ v10 }, [x0], x1
cmp	w5, #2
st1.8h	{ v11 }, [x13], x1
st1.8h	{ v12 }, [x0], x1
st1.8h	{ v13 }, [x13], x1
b.lt	ipred_z2_fill1_16bpc_neon
mov.16b	v18, v22
b.gt	ipred_z2_fill1_16bpc_neon
smov.b	w10, v29[0]
smov.b	w15, v29[2]
movi.16b	v21, #4
smov.b	w16, v29[4]
add	x10, x3, w10, sxtw
smov.b	w17, v29[6]
add	x15, x3, w15, sxtw
ld2.h	{ v19, v20 }[0], [x10]
smov.b	w10, v29[8]
add	x16, x3, w16, sxtw
ld2.h	{ v19, v20 }[1], [x15]
smov.b	w15, v29[10]
add	x17, x3, w17, sxtw
ld2.h	{ v19, v20 }[2], [x16]
smov.b	w16, v29[12]
add	x10, x3, w10, sxtw
ld2.h	{ v19, v20 }[3], [x17]
smov.b	w17, v29[14]
add	x15, x3, w15, sxtw
add	x16, x3, w16, sxtw
ld2.h	{ v19, v20 }[4], [x10]
add	x17, x3, w17, sxtw
ld2.h	{ v19, v20 }[5], [x15]
ld2.h	{ v19, v20 }[6], [x16]
add.16b	v29, v29, v21
ld2.h	{ v19, v20 }[7], [x17]
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
umull.4s	v12, v19, v28
umlal.4s	v12, v20, v27
umull2.4s	v13, v19, v28
umlal2.4s	v13, v20, v27
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
st1.8h	{ v10 }, [x0], x1
st1.8h	{ v11 }, [x13], x1
subs	w4, w4, #8
b.le	ipred_z2_fill1_16bpc_neon
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #16
add	x13, x13, #16
mov	w5, w12
b	ipred_z2_fill1_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
ext	z24.b, { z11.b, z12.b }, #193
<unknown>
udf	#2208
_ipred_z2_fill2_16bpc_neon:
cmp	w4, #8
mov	w8, #128
sub	w8, w8, w6
adrp	x11, ipred_z2_fill2_16bpc_neon
add	x11, x11, #0
ld1.8h	{ v31 }, [x11]
neg	w7, w7
b.eq	ipred_z2_fill2_16bpc_neon
dup.4h	v30, w7
movi.8b	v17, #1
mul.4h	v16, v31, v30
movi.8h	v25, #62
add.4h	v30, v16, v30
ld1.8h	{ v0, v1 }, [x3]
movi.8h	v26, #64
movi.16b	v19, #4
shrn.8b	v29, v30, #6
and.8b	v27, v30, v25
add.8b	v29, v29, v17
movi.4h	v23, #1, lsl #8
shl.8b	v29, v29, #1
zip1.8b	v29, v29, v29
movi.8b	v17, #2
add.8b	v29, v29, v23
add.8b	v30, v29, v17
add.8b	v28, v29, v19
tbl.8b	v18, { v0 }, v29
trn1.2d	v30, v30, v28
sub.4h	v28, v26, v27
trn1.2d	v31, v31, v31
trn1.2d	v27, v27, v27
trn1.2d	v28, v28, v28
movi.16b	v29, #4
add.8h	v31, v31, v31
asr	w9, w8, #6
dup.4h	v16, w8
sub	w8, w8, w6
cmn	w9, #8
asr	w11, w8, #6
b.le	ipred_z2_fill2_16bpc_neon
lsl	w9, w9, #1
lsl	w11, w11, #1
dup.4h	v17, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
trn1.2d	v16, v16, v17
tbl.16b	v19, { v0, v1 }, v30
sshr.8h	v20, v16, #6
uzp2.8h	v5, v4, v6
uzp1.8h	v4, v4, v6
and.16b	v16, v16, v25
trn1.2d	v18, v18, v19
sub.8h	v17, v26, v16
add.8h	v20, v20, v31
umull.4s	v21, v18, v28
umlal.4s	v21, v19, v27
umull2.4s	v22, v18, v28
umlal2.4s	v22, v19, v27
umull.4s	v23, v4, v17
umlal.4s	v23, v5, v16
umull2.4s	v24, v4, v17
umlal2.4s	v24, v5, v16
cmge.8h	v20, v20, #0
rshrn.4h	v21, v21, #6
rshrn2.8h	v21, v22, #6
rshrn.4h	v22, v23, #6
rshrn2.8h	v22, v24, #6
bit.16b	v21, v22, v20
st1.d	{ v21 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.d	{ v21 }[1], [x0], x1
b.le	ipred_z2_fill2_16bpc_neon
ext.16b	v18, v19, v19, #8
add.16b	v30, v30, v29
b	ipred_z2_fill2_16bpc_neon
tbl.16b	v19, { v0, v1 }, v30
trn1.2d	v18, v18, v19
umull.4s	v20, v18, v28
umlal.4s	v20, v19, v27
umull2.4s	v21, v18, v28
umlal2.4s	v21, v19, v27
rshrn.4h	v20, v20, #6
rshrn2.8h	v20, v21, #6
st1.d	{ v20 }[0], [x0], x1
subs	w5, w5, #2
st1.d	{ v20 }[1], [x0], x1
b.le	ipred_z2_fill2_16bpc_neon
ext.16b	v18, v19, v19, #8
add.16b	v30, v30, v29
b	ipred_z2_fill2_16bpc_neon
ret
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
dup.8h	v18, w7
movi.8b	v17, #1
mul.8h	v16, v31, v18
movi.8h	v25, #62
add.8h	v16, v16, v18
ld1.8h	{ v0, v1 }, [x3]
movi.8h	v26, #64
movi.16b	v19, #4
shrn.8b	v29, v16, #6
and.16b	v27, v16, v25
add.8b	v29, v29, v17
movi.8h	v23, #1, lsl #8
shl.8b	v29, v29, #1
zip1.16b	v29, v29, v29
movi.16b	v17, #2
add.16b	v29, v29, v23
tbl.16b	v18, { v0 }, v29
add.16b	v30, v29, v19
add.16b	v29, v29, v17
sub.8h	v28, v26, v27
movi.16b	v24, #4
add.16b	v31, v31, v31
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #16
asr	w11, w8, #6
b.le	ipred_z2_fill2_16bpc_neon
dup.8h	v17, w8
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
ld1.8h	{ v4, v5 }, [x9]
ld1.8h	{ v6, v7 }, [x11]
tbl.16b	v19, { v0, v1 }, v29
sshr.8h	v21, v16, #6
sshr.8h	v22, v17, #6
tbl.16b	v20, { v0, v1 }, v30
uzp2.8h	v2, v4, v5
uzp1.8h	v4, v4, v5
uzp2.8h	v3, v6, v7
uzp1.8h	v6, v6, v7
mov.16b	v5, v2
mov.16b	v7, v3
and.16b	v16, v16, v25
and.16b	v17, v17, v25
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
sub.8h	v8, v26, v16
sub.8h	v9, v26, v17
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
add.8h	v21, v21, v31
add.8h	v22, v22, v31
umull.4s	v12, v19, v28
umlal.4s	v12, v20, v27
umull2.4s	v13, v19, v28
umlal2.4s	v13, v20, v27
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
umull.4s	v12, v4, v8
umlal.4s	v12, v5, v16
umull2.4s	v13, v4, v8
umlal2.4s	v13, v5, v16
umull.4s	v14, v6, v9
umlal.4s	v14, v7, v17
umull2.4s	v18, v6, v9
umlal2.4s	v18, v7, v17
cmge.8h	v21, v21, #0
cmge.8h	v22, v22, #0
rshrn.4h	v12, v12, #6
rshrn2.8h	v12, v13, #6
rshrn.4h	v13, v14, #6
rshrn2.8h	v13, v18, #6
bit.16b	v10, v12, v21
bit.16b	v11, v13, v22
st1.8h	{ v10 }, [x0], x1
subs	w5, w5, #2
sub	w8, w8, w6
st1.8h	{ v11 }, [x0], x1
b.le	ipred_z2_fill2_16bpc_neon
mov.16b	v18, v20
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill2_16bpc_neon
tbl.16b	v19, { v0, v1 }, v29
tbl.16b	v20, { v0, v1 }, v30
umull.4s	v4, v18, v28
umlal.4s	v4, v19, v27
umull2.4s	v5, v18, v28
umlal2.4s	v5, v19, v27
umull.4s	v6, v19, v28
umlal.4s	v6, v20, v27
umull2.4s	v7, v19, v28
umlal2.4s	v7, v20, v27
rshrn.4h	v4, v4, #6
rshrn2.8h	v4, v5, #6
rshrn.4h	v5, v6, #6
rshrn2.8h	v5, v7, #6
st1.8h	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v5 }, [x0], x1
b.le	ipred_z2_fill2_16bpc_neon
mov.16b	v18, v20
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill2_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
_ipred_z2_fill3_16bpc_neon:
cmp	w4, #8
mov	w8, #64
sub	w8, w8, w6
adrp	x11, ipred_z2_fill3_16bpc_neon
add	x11, x11, #0
ld1.8h	{ v31 }, [x11]
neg	w7, w7
b.eq	ipred_z2_fill3_16bpc_neon
dup.4h	v30, w7
movi.8b	v17, #1
mul.4h	v16, v31, v30
movi.8h	v25, #62
add.4h	v30, v16, v30
ld1.8h	{ v0, v1, v2 }, [x3]
movi.8h	v26, #64
movi.16b	v19, #2
shrn.8b	v29, v30, #6
and.8b	v27, v30, v25
add.8b	v29, v29, v19
movi.4h	v23, #1, lsl #8
shl.8b	v29, v29, #1
movi.16b	v19, #4
zip1.8b	v29, v29, v29
movi.8b	v17, #2
add.8b	v29, v29, v23
add.8b	v30, v29, v17
add.8b	v28, v29, v19
trn1.2d	v31, v31, v31
add.8b	v24, v30, v19
trn1.2d	v29, v29, v28
trn1.2d	v30, v30, v24
sub.4h	v28, v26, v27
trn1.2d	v27, v27, v27
trn1.2d	v28, v28, v28
movi.16b	v24, #8
asr	w9, w8, #6
dup.4h	v16, w8
sub	w8, w8, w6
cmn	w9, #4
asr	w11, w8, #6
b.le	ipred_z2_fill3_16bpc_neon
lsl	w9, w9, #1
lsl	w11, w11, #1
dup.4h	v17, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
trn1.2d	v16, v16, v17
tbl.16b	v18, { v0, v1, v2 }, v29
tbl.16b	v19, { v0, v1, v2 }, v30
sshr.8h	v20, v16, #6
ext.16b	v5, v4, v4, #2
ext.16b	v7, v6, v6, #2
and.16b	v16, v16, v25
trn1.2d	v4, v4, v6
trn1.2d	v5, v5, v7
sub.8h	v17, v26, v16
add.8h	v20, v20, v31
umull.4s	v21, v18, v28
umlal.4s	v21, v19, v27
umull2.4s	v22, v18, v28
umlal2.4s	v22, v19, v27
umull.4s	v23, v4, v17
umlal.4s	v23, v5, v16
umull2.4s	v24, v4, v17
umlal2.4s	v24, v5, v16
cmge.8h	v20, v20, #0
rshrn.4h	v21, v21, #6
rshrn2.8h	v21, v22, #6
rshrn.4h	v22, v23, #6
rshrn2.8h	v22, v24, #6
movi.16b	v24, #8
bit.16b	v21, v22, v20
st1.d	{ v21 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.d	{ v21 }[1], [x0], x1
b.le	ipred_z2_fill3_16bpc_neon
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill3_16bpc_neon
tbl.16b	v18, { v0, v1, v2 }, v29
tbl.16b	v19, { v0, v1, v2 }, v30
umull.4s	v20, v18, v28
umlal.4s	v20, v19, v27
umull2.4s	v21, v18, v28
umlal2.4s	v21, v19, v27
rshrn.4h	v20, v20, #6
rshrn2.8h	v20, v21, #6
st1.d	{ v20 }[0], [x0], x1
subs	w5, w5, #2
st1.d	{ v20 }[1], [x0], x1
b.le	ipred_z2_fill3_16bpc_neon
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill3_16bpc_neon
ret
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
dup.8h	v18, w7
movi.16b	v17, #2
mul.8h	v16, v31, v18
movi.8h	v25, #62
add.8h	v16, v16, v18
ld1.8h	{ v0, v1, v2 }, [x3]
movi.8h	v26, #64
movi.16b	v19, #4
shrn.8b	v29, v16, #6
and.16b	v27, v16, v25
add.8b	v29, v29, v17
movi.8h	v23, #1, lsl #8
shl.8b	v29, v29, #1
mov.16b	v18, v15
zip1.16b	v29, v29, v29
add.16b	v29, v29, v23
add.16b	v30, v29, v17
sub.8h	v28, v26, v27
movi.16b	v24, #4
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #16
asr	w11, w8, #6
b.le	ipred_z2_fill3_16bpc_neon
dup.8h	v17, w8
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
ld1.8h	{ v4, v5 }, [x9]
ld1.8h	{ v6, v7 }, [x11]
tbl.16b	v18, { v0, v1, v2 }, v29
add.16b	v29, v29, v24
tbl.16b	v19, { v0, v1, v2 }, v30
add.16b	v30, v30, v24
sshr.8h	v22, v16, #6
tbl.16b	v20, { v0, v1, v2 }, v29
sshr.8h	v23, v17, #6
tbl.16b	v21, { v0, v1, v2 }, v30
ext.16b	v5, v4, v5, #2
ext.16b	v7, v6, v7, #2
and.16b	v16, v16, v25
and.16b	v17, v17, v25
umull.4s	v10, v18, v28
umlal.4s	v10, v19, v27
sub.8h	v8, v26, v16
sub.8h	v9, v26, v17
umull2.4s	v11, v18, v28
umlal2.4s	v11, v19, v27
add.8h	v22, v22, v31
add.8h	v23, v23, v31
umull.4s	v12, v20, v28
umlal.4s	v12, v21, v27
umull2.4s	v13, v20, v28
umlal2.4s	v13, v21, v27
rshrn.4h	v10, v10, #6
rshrn2.8h	v10, v11, #6
rshrn.4h	v11, v12, #6
rshrn2.8h	v11, v13, #6
umull.4s	v12, v4, v8
umlal.4s	v12, v5, v16
umull2.4s	v13, v4, v8
umlal2.4s	v13, v5, v16
umull.4s	v14, v6, v9
umlal.4s	v14, v7, v17
umull2.4s	v18, v6, v9
umlal2.4s	v18, v7, v17
cmge.8h	v22, v22, #0
cmge.8h	v23, v23, #0
rshrn.4h	v12, v12, #6
rshrn2.8h	v12, v13, #6
rshrn.4h	v13, v14, #6
rshrn2.8h	v13, v18, #6
bit.16b	v10, v12, v22
bit.16b	v11, v13, v23
st1.8h	{ v10 }, [x0], x1
subs	w5, w5, #2
sub	w8, w8, w6
st1.8h	{ v11 }, [x0], x1
b.le	ipred_z2_fill3_16bpc_neon
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill3_16bpc_neon
tbl.16b	v18, { v0, v1, v2 }, v29
add.16b	v29, v29, v24
tbl.16b	v19, { v0, v1, v2 }, v30
add.16b	v30, v30, v24
tbl.16b	v20, { v0, v1, v2 }, v29
tbl.16b	v21, { v0, v1, v2 }, v30
umull.4s	v4, v18, v28
umlal.4s	v4, v19, v27
umull2.4s	v5, v18, v28
umlal2.4s	v5, v19, v27
umull.4s	v6, v20, v28
umlal.4s	v6, v21, v27
umull2.4s	v7, v20, v28
umlal2.4s	v7, v21, v27
rshrn.4h	v4, v4, #6
rshrn2.8h	v4, v5, #6
rshrn.4h	v5, v6, #6
rshrn2.8h	v5, v7, #6
st1.8h	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.8h	{ v5 }, [x0], x1
b.le	ipred_z2_fill3_16bpc_neon
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill3_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
_ipred_z3_fill1_16bpc_neon:
clz	w9, w4
adr	x8, #740
sub	w9, w9, #25
ldrh	w9, [x8, w9, uxtw #1]
add	x10, x2, w6, uxtw #1
sub	x8, x8, w9, uxtw
ld1r.8h	{ v31 }, [x10]
mov	w7, w5
mov	w15, #64
add	x13, x0, x1
lsl	x1, x1, #1
br	x8
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
lsl	w8, w8, #1
lsl	w10, w10, #1
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup.8h	v4, w9
dup.8h	v5, w11
ext.16b	v1, v0, v0, #2
ext.16b	v3, v2, v2, #2
sub.4h	v6, v1, v0
sub.4h	v7, v3, v2
ushll.4s	v16, v0, #6
ushll.4s	v17, v2, #6
smlal.4s	v16, v6, v4
smlal.4s	v17, v7, v5
rshrn.4h	v16, v16, #6
rshrn.4h	v17, v17, #6
subs	w3, w3, #2
zip1.8h	v18, v16, v17
st1.s	{ v18 }[0], [x0], x1
st1.s	{ v18 }[1], [x13], x1
add	w7, w7, w5
st1.s	{ v18 }[2], [x0]
st1.s	{ v18 }[3], [x13]
b.le	ipred_z3_fill1_16bpc_neon
sub	x0, x0, x1
sub	x13, x13, x1
add	x0, x0, #4
add	x13, x13, #4
b	ipred_z3_fill1_16bpc_neon
ret
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup.8h	v4, w9
dup.8h	v5, w11
ld1.8h	{ v0 }, [x8]
ld1.8h	{ v2 }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
ldr	h1, [x8, #16]
ldr	h3, [x10, #16]
dup.8h	v6, w9
dup.8h	v7, w11
ext.16b	v1, v0, v1, #2
ext.16b	v3, v2, v3, #2
umull.4s	v16, v0, v6
umlal.4s	v16, v1, v4
umull2.4s	v17, v0, v6
umlal2.4s	v17, v1, v4
umull.4s	v18, v2, v7
umlal.4s	v18, v3, v5
umull2.4s	v19, v2, v7
umlal2.4s	v19, v3, v5
rshrn.4h	v16, v16, #6
rshrn2.8h	v16, v17, #6
rshrn.4h	v17, v18, #6
rshrn2.8h	v17, v19, #6
subs	w3, w3, #2
zip1.8h	v18, v16, v17
zip2.8h	v19, v16, v17
add	w7, w7, w5
st1.s	{ v18 }[0], [x0], x1
st1.s	{ v18 }[1], [x13], x1
st1.s	{ v18 }[2], [x0], x1
st1.s	{ v18 }[3], [x13], x1
st1.s	{ v19 }[0], [x0], x1
st1.s	{ v19 }[1], [x13], x1
st1.s	{ v19 }[2], [x0], x1
st1.s	{ v19 }[3], [x13], x1
b.le	ipred_z3_fill1_16bpc_neon
sub	x0, x0, x1, lsl #2
sub	x13, x13, x1, lsl #2
add	x0, x0, #4
add	x13, x13, #4
b	ipred_z3_fill1_16bpc_neon
ret
mov	w12, w4
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup.8h	v6, w9
dup.8h	v7, w11
ld1.8h	{ v0, v1, v2 }, [x8], #48
ld1.8h	{ v3, v4, v5 }, [x10], #48
sub	w9, w15, w9
sub	w11, w15, w11
dup.8h	v16, w9
dup.8h	v17, w11
add	w7, w7, w5
ext.16b	v18, v0, v1, #2
ext.16b	v19, v1, v2, #2
ext.16b	v20, v3, v4, #2
ext.16b	v21, v4, v5, #2
subs	w4, w4, #16
umull.4s	v22, v0, v16
umlal.4s	v22, v18, v6
umull2.4s	v23, v0, v16
umlal2.4s	v23, v18, v6
umull.4s	v24, v1, v16
umlal.4s	v24, v19, v6
umull2.4s	v25, v1, v16
umlal2.4s	v25, v19, v6
umull.4s	v26, v3, v17
umlal.4s	v26, v20, v7
umull2.4s	v27, v3, v17
umlal2.4s	v27, v20, v7
umull.4s	v28, v4, v17
umlal.4s	v28, v21, v7
umull2.4s	v29, v4, v17
umlal2.4s	v29, v21, v7
rshrn.4h	v22, v22, #6
rshrn2.8h	v22, v23, #6
rshrn.4h	v23, v24, #6
rshrn2.8h	v23, v25, #6
rshrn.4h	v24, v26, #6
rshrn2.8h	v24, v27, #6
rshrn.4h	v25, v28, #6
rshrn2.8h	v25, v29, #6
zip1.8h	v18, v22, v24
zip2.8h	v19, v22, v24
zip1.8h	v20, v23, v25
zip2.8h	v21, v23, v25
st1.s	{ v18 }[0], [x0], x1
st1.s	{ v18 }[1], [x13], x1
st1.s	{ v18 }[2], [x0], x1
st1.s	{ v18 }[3], [x13], x1
st1.s	{ v19 }[0], [x0], x1
st1.s	{ v19 }[1], [x13], x1
st1.s	{ v19 }[2], [x0], x1
st1.s	{ v19 }[3], [x13], x1
st1.s	{ v20 }[0], [x0], x1
st1.s	{ v20 }[1], [x13], x1
st1.s	{ v20 }[2], [x0], x1
st1.s	{ v20 }[3], [x13], x1
st1.s	{ v21 }[0], [x0], x1
st1.s	{ v21 }[1], [x13], x1
st1.s	{ v21 }[2], [x0], x1
st1.s	{ v21 }[3], [x13], x1
b.le	ipred_z3_fill1_16bpc_neon
mov.16b	v0, v2
ld1.8h	{ v1, v2 }, [x8], #32
mov.16b	v3, v5
ld1.8h	{ v4, v5 }, [x10], #32
b	ipred_z3_fill1_16bpc_neon
subs	w3, w3, #2
b.le	ipred_z3_fill1_16bpc_neon
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #4
add	x13, x13, #4
mov	w4, w12
b	ipred_z3_fill1_16bpc_neon
ret
<unknown>
<unknown>
udf	#696
_ipred_z3_fill_padding_neon:
cmp	w3, #8
adr	x8, #228
b.gt	ipred_z3_fill_padding_neon
mov	w12, w4
clz	w9, w3
sub	w9, w9, #25
ldrh	w9, [x8, w9, uxtw #1]
sub	x9, x8, w9, uxtw
br	x9
st1.s	{ v31 }[0], [x0], x1
subs	w4, w4, #4
st1.s	{ v31 }[0], [x13], x1
st1.s	{ v31 }[0], [x0], x1
st1.s	{ v31 }[0], [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #2
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	ipred_z3_fill_padding_neon
lsl	x1, x1, #1
add	x0, x0, #4
add	x13, x13, #4
mov	w4, w12
b	ipred_z3_fill_padding_neon
st1.4h	{ v31 }, [x0], x1
subs	w4, w4, #4
st1.4h	{ v31 }, [x13], x1
st1.4h	{ v31 }, [x0], x1
st1.4h	{ v31 }, [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #4
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	ipred_z3_fill_padding_neon
lsl	x1, x1, #1
add	x0, x0, #8
add	x13, x13, #8
mov	w4, w12
b	ipred_z3_fill_padding_neon
st1.8h	{ v31 }, [x0], x1
subs	w4, w4, #4
st1.8h	{ v31 }, [x13], x1
st1.8h	{ v31 }, [x0], x1
st1.8h	{ v31 }, [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #8
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	ipred_z3_fill_padding_neon
lsl	x1, x1, #1
add	x0, x0, #16
add	x13, x13, #16
mov	w4, w12
b	ipred_z3_fill_padding_neon
ret
<unknown>
<unknown>
<unknown>
lsr	x1, x1, #1
mov	w12, w3
sub	x1, x1, w3, uxtw #1
ands	w5, w3, #0x7
b.eq	ipred_z3_fill_padding_neon
sub	w3, w3, w5
st1.8h	{ v31 }, [x0]
add	x0, x0, w5, uxtw #1
subs	w3, w3, #8
st1.8h	{ v31 }, [x0], #16
b.gt	ipred_z3_fill_padding_neon
subs	w4, w4, #1
add	x0, x0, x1
b.le	ipred_z3_fill_padding_neon
mov	w3, w12
b	ipred_z3_fill_padding_neon
ret
_ipred_z3_fill2_16bpc_neon:
cmp	w4, #8
add	x10, x2, w6, uxtw
ld1r.16b	{ v31 }, [x10]
mov	w7, w5
mov	w15, #64
add	x13, x0, x1
lsl	x1, x1, #1
b.eq	ipred_z3_fill2_16bpc_neon
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
lsl	w8, w8, #1
lsl	w10, w10, #1
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup.4h	v4, w9
dup.4h	v5, w11
uzp2.8h	v1, v0, v0
uzp1.8h	v0, v0, v0
uzp2.8h	v3, v2, v2
uzp1.8h	v2, v2, v2
sub.4h	v6, v1, v0
sub.4h	v7, v3, v2
ushll.4s	v16, v0, #6
ushll.4s	v17, v2, #6
smlal.4s	v16, v6, v4
smlal.4s	v17, v7, v5
rshrn.4h	v16, v16, #6
rshrn.4h	v17, v17, #6
subs	w3, w3, #2
zip1.8h	v18, v16, v17
st1.s	{ v18 }[0], [x0], x1
st1.s	{ v18 }[1], [x13], x1
add	w7, w7, w5
st1.s	{ v18 }[2], [x0]
st1.s	{ v18 }[3], [x13]
b.le	ipred_z3_fill2_16bpc_neon
sub	x0, x0, x1
sub	x13, x13, x1
add	x0, x0, #4
add	x13, x13, #4
b	ipred_z3_fill2_16bpc_neon
ret
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup.8h	v4, w9
dup.8h	v5, w11
ld1.8h	{ v0, v1 }, [x8]
ld1.8h	{ v2, v3 }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
dup.8h	v6, w9
dup.8h	v7, w11
uzp2.8h	v20, v0, v1
uzp1.8h	v0, v0, v1
uzp2.8h	v21, v2, v3
uzp1.8h	v2, v2, v3
umull.4s	v16, v0, v6
umlal.4s	v16, v20, v4
umull2.4s	v17, v0, v6
umlal2.4s	v17, v20, v4
umull.4s	v18, v2, v7
umlal.4s	v18, v21, v5
umull2.4s	v19, v2, v7
umlal2.4s	v19, v21, v5
rshrn.4h	v16, v16, #6
rshrn2.8h	v16, v17, #6
rshrn.4h	v17, v18, #6
rshrn2.8h	v17, v19, #6
subs	w3, w3, #2
zip1.8h	v18, v16, v17
zip2.8h	v19, v16, v17
add	w7, w7, w5
st1.s	{ v18 }[0], [x0], x1
st1.s	{ v18 }[1], [x13], x1
st1.s	{ v18 }[2], [x0], x1
st1.s	{ v18 }[3], [x13], x1
st1.s	{ v19 }[0], [x0], x1
st1.s	{ v19 }[1], [x13], x1
st1.s	{ v19 }[2], [x0], x1
st1.s	{ v19 }[3], [x13], x1
b.le	ipred_z3_fill2_16bpc_neon
sub	x0, x0, x1, lsl #2
sub	x13, x13, x1, lsl #2
add	x0, x0, #4
add	x13, x13, #4
b	ipred_z3_fill2_16bpc_neon
ret
_ipred_filter_10bpc_neon:
and	w5, w5, #0x1ff
adrp	x6, ipred_filter_10bpc_neon
add	x6, x6, #0
lsl	w5, w5, #6
add	x6, x6, w5, uxtw
ld1.8b	{ v16, v17, v18, v19 }, [x6], #32
clz	w9, w3
adr	x5, #516
ld1.8b	{ v20, v21, v22 }, [x6]
sub	w9, w9, #26
ldrh	w9, [x5, w9, uxtw #1]
sshll.8h	v16, v16, #0
sshll.8h	v17, v17, #0
sub	x5, x5, w9, uxtw
sshll.8h	v18, v18, #0
sshll.8h	v19, v19, #0
add	x6, x0, x1
lsl	x1, x1, #1
sshll.8h	v20, v20, #0
sshll.8h	v21, v21, #0
sshll.8h	v22, v22, #0
dup.8h	v31, w8
movi.8h	v30, #0
br	x5
ldur	d0, [x2, #2]
sub	x2, x2, #4
mov	x7, #-4
ld1.4h	{ v1 }, [x2], x7
mul.8h	v2, v17, v0[0]
mla.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
mla.8h	v2, v20, v0[3]
mla.8h	v2, v16, v1[2]
mla.8h	v2, v21, v1[1]
mla.8h	v2, v22, v1[0]
srshr.8h	v2, v2, #4
smax.8h	v2, v2, v30
smin.8h	v2, v2, v31
subs	w4, w4, #2
st1.d	{ v2 }[0], [x0], x1
ext.16b	v0, v2, v2, #8
st1.d	{ v2 }[1], [x6], x1
b.gt	ipred_filter_10bpc_neon
ret
ldur	q0, [x2, #2]
sub	x2, x2, #4
mov	x7, #-4
ld1.4h	{ v1 }, [x2], x7
mul.8h	v2, v17, v0[0]
mla.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
mla.8h	v2, v20, v0[3]
mla.8h	v2, v16, v1[2]
mla.8h	v2, v21, v1[1]
mla.8h	v2, v22, v1[0]
mul.8h	v3, v17, v0[4]
mla.8h	v3, v18, v0[5]
mla.8h	v3, v19, v0[6]
srshr.8h	v2, v2, #4
smax.8h	v2, v2, v30
smin.8h	v2, v2, v31
mla.8h	v3, v20, v0[7]
mla.8h	v3, v16, v0[3]
mla.8h	v3, v21, v2[3]
mla.8h	v3, v22, v2[7]
srshr.8h	v3, v3, #4
smax.8h	v3, v3, v30
smin.8h	v3, v3, v31
subs	w4, w4, #2
st2.d	{ v2, v3 }[0], [x0], x1
zip2.2d	v0, v2, v3
st2.d	{ v2, v3 }[1], [x6], x1
b.gt	ipred_filter_10bpc_neon
ret
add	x8, x2, #2
sub	x2, x2, #4
mov	x7, #-4
sub	x1, x1, w3, uxtw #1
mov	w9, w3
ld1.4h	{ v0 }, [x2], x7
ld1.8h	{ v1, v2 }, [x8], #32
mul.8h	v3, v16, v0[2]
mla.8h	v3, v21, v0[1]
mla.8h	v3, v22, v0[0]
mla.8h	v3, v17, v1[0]
mla.8h	v3, v18, v1[1]
mla.8h	v3, v19, v1[2]
mla.8h	v3, v20, v1[3]
mul.8h	v4, v17, v1[4]
mla.8h	v4, v18, v1[5]
mla.8h	v4, v19, v1[6]
srshr.8h	v3, v3, #4
smax.8h	v3, v3, v30
smin.8h	v3, v3, v31
mla.8h	v4, v20, v1[7]
mla.8h	v4, v16, v1[3]
mla.8h	v4, v21, v3[3]
mla.8h	v4, v22, v3[7]
mul.8h	v5, v17, v2[0]
mla.8h	v5, v18, v2[1]
mla.8h	v5, v19, v2[2]
srshr.8h	v4, v4, #4
smax.8h	v4, v4, v30
smin.8h	v4, v4, v31
mla.8h	v5, v20, v2[3]
mla.8h	v5, v16, v1[7]
mla.8h	v5, v21, v4[3]
mla.8h	v5, v22, v4[7]
mul.8h	v6, v17, v2[4]
mla.8h	v6, v18, v2[5]
mla.8h	v6, v19, v2[6]
srshr.8h	v5, v5, #4
smax.8h	v5, v5, v30
smin.8h	v5, v5, v31
mla.8h	v6, v20, v2[7]
mla.8h	v6, v16, v2[3]
mla.8h	v6, v21, v5[3]
mla.8h	v6, v22, v5[7]
subs	w3, w3, #16
srshr.8h	v6, v6, #4
smax.8h	v6, v6, v30
smin.8h	v6, v6, v31
mov.h	v0[2], v2[7]
st4.d	{ v3, v4, v5, v6 }[0], [x0], #32
mov.h	v0[0], v6[7]
st4.d	{ v3, v4, v5, v6 }[1], [x6], #32
mov.h	v0[1], v6[3]
b.gt	ipred_filter_10bpc_neon
subs	w4, w4, #2
b.le	ipred_filter_10bpc_neon
sub	x8, x6, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	ipred_filter_10bpc_neon
ret
<unknown>
<unknown>
_ipred_filter_12bpc_neon:
and	w5, w5, #0x1ff
adrp	x6, ipred_filter_12bpc_neon
add	x6, x6, #0
lsl	w5, w5, #6
add	x6, x6, w5, uxtw
ld1.8b	{ v16, v17, v18, v19 }, [x6], #32
clz	w9, w3
adr	x5, #708
ld1.8b	{ v20, v21, v22 }, [x6]
sub	w9, w9, #26
ldrh	w9, [x5, w9, uxtw #1]
sshll.8h	v16, v16, #0
sshll.8h	v17, v17, #0
sub	x5, x5, w9, uxtw
sshll.8h	v18, v18, #0
sshll.8h	v19, v19, #0
add	x6, x0, x1
lsl	x1, x1, #1
sshll.8h	v20, v20, #0
sshll.8h	v21, v21, #0
sshll.8h	v22, v22, #0
dup.8h	v31, w8
br	x5
ldur	d0, [x2, #2]
sub	x2, x2, #4
mov	x7, #-4
ld1.4h	{ v1 }, [x2], x7
smull.4s	v2, v17, v0[0]
smlal.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v16, v1[2]
smlal.4s	v2, v21, v1[1]
smlal.4s	v2, v22, v1[0]
smull2.4s	v3, v17, v0[0]
smlal2.4s	v3, v18, v0[1]
smlal2.4s	v3, v19, v0[2]
smlal2.4s	v3, v20, v0[3]
smlal2.4s	v3, v16, v1[2]
smlal2.4s	v3, v21, v1[1]
smlal2.4s	v3, v22, v1[0]
sqrshrun.4h	v2, v2, #4
sqrshrun2.8h	v2, v3, #4
smin.8h	v2, v2, v31
subs	w4, w4, #2
st1.d	{ v2 }[0], [x0], x1
ext.16b	v0, v2, v2, #8
st1.d	{ v2 }[1], [x6], x1
b.gt	ipred_filter_12bpc_neon
ret
ldur	q0, [x2, #2]
sub	x2, x2, #4
mov	x7, #-4
ld1.4h	{ v1 }, [x2], x7
smull.4s	v2, v17, v0[0]
smlal.4s	v2, v18, v0[1]
smlal.4s	v2, v19, v0[2]
smlal.4s	v2, v20, v0[3]
smlal.4s	v2, v16, v1[2]
smlal.4s	v2, v21, v1[1]
smlal.4s	v2, v22, v1[0]
smull2.4s	v3, v17, v0[0]
smlal2.4s	v3, v18, v0[1]
smlal2.4s	v3, v19, v0[2]
smlal2.4s	v3, v20, v0[3]
smlal2.4s	v3, v16, v1[2]
smlal2.4s	v3, v21, v1[1]
smlal2.4s	v3, v22, v1[0]
smull.4s	v4, v17, v0[4]
smlal.4s	v4, v18, v0[5]
smlal.4s	v4, v19, v0[6]
sqrshrun.4h	v2, v2, #4
sqrshrun2.8h	v2, v3, #4
smin.8h	v2, v2, v31
smlal.4s	v4, v20, v0[7]
smlal.4s	v4, v16, v0[3]
smlal.4s	v4, v21, v2[3]
smlal.4s	v4, v22, v2[7]
smull2.4s	v5, v17, v0[4]
smlal2.4s	v5, v18, v0[5]
smlal2.4s	v5, v19, v0[6]
smlal2.4s	v5, v20, v0[7]
smlal2.4s	v5, v16, v0[3]
smlal2.4s	v5, v21, v2[3]
smlal2.4s	v5, v22, v2[7]
sqrshrun.4h	v3, v4, #4
sqrshrun2.8h	v3, v5, #4
smin.8h	v3, v3, v31
subs	w4, w4, #2
st2.d	{ v2, v3 }[0], [x0], x1
zip2.2d	v0, v2, v3
st2.d	{ v2, v3 }[1], [x6], x1
b.gt	ipred_filter_12bpc_neon
ret
add	x8, x2, #2
sub	x2, x2, #4
mov	x7, #-4
sub	x1, x1, w3, uxtw #1
mov	w9, w3
ld1.4h	{ v0 }, [x2], x7
ld1.8h	{ v1, v2 }, [x8], #32
smull.4s	v3, v16, v0[2]
smlal.4s	v3, v21, v0[1]
smlal.4s	v3, v22, v0[0]
smlal.4s	v3, v17, v1[0]
smlal.4s	v3, v18, v1[1]
smlal.4s	v3, v19, v1[2]
smlal.4s	v3, v20, v1[3]
smull2.4s	v4, v16, v0[2]
smlal2.4s	v4, v21, v0[1]
smlal2.4s	v4, v22, v0[0]
smlal2.4s	v4, v17, v1[0]
smlal2.4s	v4, v18, v1[1]
smlal2.4s	v4, v19, v1[2]
smlal2.4s	v4, v20, v1[3]
smull.4s	v5, v17, v1[4]
smlal.4s	v5, v18, v1[5]
smlal.4s	v5, v19, v1[6]
sqrshrun.4h	v3, v3, #4
sqrshrun2.8h	v3, v4, #4
smin.8h	v3, v3, v31
smlal.4s	v5, v20, v1[7]
smlal.4s	v5, v16, v1[3]
smlal.4s	v5, v21, v3[3]
smlal.4s	v5, v22, v3[7]
smull2.4s	v6, v17, v1[4]
smlal2.4s	v6, v18, v1[5]
smlal2.4s	v6, v19, v1[6]
smlal2.4s	v6, v20, v1[7]
smlal2.4s	v6, v16, v1[3]
smlal2.4s	v6, v21, v3[3]
smlal2.4s	v6, v22, v3[7]
smull.4s	v24, v17, v2[0]
smlal.4s	v24, v18, v2[1]
smlal.4s	v24, v19, v2[2]
sqrshrun.4h	v4, v5, #4
sqrshrun2.8h	v4, v6, #4
smin.8h	v4, v4, v31
smlal.4s	v24, v20, v2[3]
smlal.4s	v24, v16, v1[7]
smlal.4s	v24, v21, v4[3]
smlal.4s	v24, v22, v4[7]
smull2.4s	v25, v17, v2[0]
smlal2.4s	v25, v18, v2[1]
smlal2.4s	v25, v19, v2[2]
smlal2.4s	v25, v20, v2[3]
smlal2.4s	v25, v16, v1[7]
smlal2.4s	v25, v21, v4[3]
smlal2.4s	v25, v22, v4[7]
smull.4s	v26, v17, v2[4]
smlal.4s	v26, v18, v2[5]
smlal.4s	v26, v19, v2[6]
sqrshrun.4h	v5, v24, #4
sqrshrun2.8h	v5, v25, #4
smin.8h	v5, v5, v31
smlal.4s	v26, v20, v2[7]
smlal.4s	v26, v16, v2[3]
smlal.4s	v26, v21, v5[3]
smlal.4s	v26, v22, v5[7]
smull2.4s	v27, v17, v2[4]
smlal2.4s	v27, v18, v2[5]
smlal2.4s	v27, v19, v2[6]
smlal2.4s	v27, v20, v2[7]
smlal2.4s	v27, v16, v2[3]
smlal2.4s	v27, v21, v5[3]
smlal2.4s	v27, v22, v5[7]
subs	w3, w3, #16
sqrshrun.4h	v6, v26, #4
sqrshrun2.8h	v6, v27, #4
smin.8h	v6, v6, v31
mov.h	v0[2], v2[7]
st4.d	{ v3, v4, v5, v6 }[0], [x0], #32
mov.h	v0[0], v6[7]
st4.d	{ v3, v4, v5, v6 }[1], [x6], #32
mov.h	v0[1], v6[3]
b.gt	ipred_filter_12bpc_neon
subs	w4, w4, #2
b.le	ipred_filter_12bpc_neon
sub	x8, x6, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	ipred_filter_12bpc_neon
ret
<unknown>
<unknown>
_ipred_filter_16bpc_neon:
ldr	w8, [sp]
cmp	w8, #1023
b.le	ipred_filter_10bpc_neon
b	ipred_filter_12bpc_neon
_pal_pred_16bpc_neon:
ld1.8h	{ v30 }, [x2]
clz	w9, w4
adr	x6, #752
sub	w9, w9, #25
movi.16b	v29, #7
ldrh	w9, [x6, w9, uxtw #1]
movi.8h	v31, #1, lsl #8
sub	x6, x6, w9, uxtw
br	x6
add	x2, x0, x1
lsl	x1, x1, #1
ld1.8b	{ v1 }, [x3], #8
subs	w5, w5, #4
ushr.8b	v3, v1, #4
and.8b	v2, v1, v29
zip1.16b	v1, v2, v3
add.16b	v1, v1, v1
zip1.16b	v0, v1, v1
zip2.16b	v1, v1, v1
add.8h	v0, v0, v31
add.8h	v1, v1, v31
tbl.16b	v0, { v30 }, v0
st1.d	{ v0 }[0], [x0], x1
tbl.16b	v1, { v30 }, v1
st1.d	{ v0 }[1], [x2], x1
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x2], x1
b.gt	pal_pred_16bpc_neon
ret
add	x2, x0, x1
lsl	x1, x1, #1
ld1.16b	{ v2 }, [x3], #16
subs	w5, w5, #4
ushr.16b	v4, v2, #4
and.16b	v3, v2, v29
zip1.16b	v2, v3, v4
zip2.16b	v3, v3, v4
add.16b	v2, v2, v2
add.16b	v3, v3, v3
zip1.16b	v0, v2, v2
zip2.16b	v1, v2, v2
zip1.16b	v2, v3, v3
zip2.16b	v3, v3, v3
add.8h	v0, v0, v31
add.8h	v1, v1, v31
add.8h	v2, v2, v31
add.8h	v3, v3, v31
tbl.16b	v0, { v30 }, v0
tbl.16b	v1, { v30 }, v1
st1.8h	{ v0 }, [x0], x1
tbl.16b	v2, { v30 }, v2
st1.8h	{ v1 }, [x2], x1
tbl.16b	v3, { v30 }, v3
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x2], x1
b.gt	pal_pred_16bpc_neon
ret
add	x2, x0, x1
lsl	x1, x1, #1
ld1.16b	{ v4, v5 }, [x3], #32
subs	w5, w5, #4
ushr.16b	v7, v4, #4
and.16b	v6, v4, v29
ushr.16b	v3, v5, #4
and.16b	v2, v5, v29
zip1.16b	v4, v6, v7
zip2.16b	v5, v6, v7
zip1.16b	v6, v2, v3
zip2.16b	v7, v2, v3
add.16b	v4, v4, v4
add.16b	v5, v5, v5
add.16b	v6, v6, v6
add.16b	v7, v7, v7
zip1.16b	v0, v4, v4
zip2.16b	v1, v4, v4
zip1.16b	v2, v5, v5
zip2.16b	v3, v5, v5
zip1.16b	v4, v6, v6
zip2.16b	v5, v6, v6
zip1.16b	v6, v7, v7
zip2.16b	v7, v7, v7
add.8h	v0, v0, v31
add.8h	v1, v1, v31
add.8h	v2, v2, v31
add.8h	v3, v3, v31
add.8h	v4, v4, v31
tbl.16b	v0, { v30 }, v0
add.8h	v5, v5, v31
tbl.16b	v1, { v30 }, v1
add.8h	v6, v6, v31
tbl.16b	v2, { v30 }, v2
add.8h	v7, v7, v31
tbl.16b	v3, { v30 }, v3
tbl.16b	v4, { v30 }, v4
tbl.16b	v5, { v30 }, v5
st1.8h	{ v0, v1 }, [x0], x1
tbl.16b	v6, { v30 }, v6
st1.8h	{ v2, v3 }, [x2], x1
tbl.16b	v7, { v30 }, v7
st1.8h	{ v4, v5 }, [x0], x1
st1.8h	{ v6, v7 }, [x2], x1
b.gt	pal_pred_16bpc_neon
ret
add	x2, x0, x1
lsl	x1, x1, #1
ld1.16b	{ v4, v5 }, [x3], #32
subs	w5, w5, #2
ushr.16b	v7, v4, #4
and.16b	v6, v4, v29
ushr.16b	v3, v5, #4
and.16b	v2, v5, v29
zip1.16b	v4, v6, v7
zip2.16b	v5, v6, v7
zip1.16b	v6, v2, v3
zip2.16b	v7, v2, v3
add.16b	v4, v4, v4
add.16b	v5, v5, v5
add.16b	v6, v6, v6
add.16b	v7, v7, v7
zip1.16b	v0, v4, v4
zip2.16b	v1, v4, v4
zip1.16b	v2, v5, v5
zip2.16b	v3, v5, v5
zip1.16b	v4, v6, v6
zip2.16b	v5, v6, v6
zip1.16b	v6, v7, v7
zip2.16b	v7, v7, v7
add.8h	v0, v0, v31
add.8h	v1, v1, v31
add.8h	v2, v2, v31
add.8h	v3, v3, v31
add.8h	v4, v4, v31
tbl.16b	v0, { v30 }, v0
add.8h	v5, v5, v31
tbl.16b	v1, { v30 }, v1
add.8h	v6, v6, v31
tbl.16b	v2, { v30 }, v2
add.8h	v7, v7, v31
tbl.16b	v3, { v30 }, v3
tbl.16b	v4, { v30 }, v4
tbl.16b	v5, { v30 }, v5
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
tbl.16b	v6, { v30 }, v6
tbl.16b	v7, { v30 }, v7
st1.8h	{ v4, v5, v6, v7 }, [x2], x1
b.gt	pal_pred_16bpc_neon
ret
add	x2, x0, #64
ld1.16b	{ v4, v5 }, [x3], #32
subs	w5, w5, #1
ushr.16b	v7, v4, #4
and.16b	v6, v4, v29
ushr.16b	v3, v5, #4
and.16b	v2, v5, v29
zip1.16b	v4, v6, v7
zip2.16b	v5, v6, v7
zip1.16b	v6, v2, v3
zip2.16b	v7, v2, v3
add.16b	v4, v4, v4
add.16b	v5, v5, v5
add.16b	v6, v6, v6
add.16b	v7, v7, v7
zip1.16b	v0, v4, v4
zip2.16b	v1, v4, v4
zip1.16b	v2, v5, v5
zip2.16b	v3, v5, v5
zip1.16b	v4, v6, v6
zip2.16b	v5, v6, v6
zip1.16b	v6, v7, v7
zip2.16b	v7, v7, v7
add.8h	v0, v0, v31
add.8h	v1, v1, v31
add.8h	v2, v2, v31
add.8h	v3, v3, v31
add.8h	v4, v4, v31
tbl.16b	v0, { v30 }, v0
add.8h	v5, v5, v31
tbl.16b	v1, { v30 }, v1
add.8h	v6, v6, v31
tbl.16b	v2, { v30 }, v2
add.8h	v7, v7, v31
tbl.16b	v3, { v30 }, v3
tbl.16b	v4, { v30 }, v4
tbl.16b	v5, { v30 }, v5
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
tbl.16b	v6, { v30 }, v6
tbl.16b	v7, { v30 }, v7
st1.8h	{ v4, v5, v6, v7 }, [x2], x1
b.gt	pal_pred_16bpc_neon
ret
<unknown>
<unknown>
udf	#724
_ipred_cfl_128_16bpc_neon:
dup.8h	v31, w7
clz	w9, w3
adr	x7, #516
sub	w9, w9, #26
ldrh	w9, [x7, w9, uxtw #1]
urshr.8h	v0, v31, #1
dup.8h	v1, w6
sub	x7, x7, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
movi.8h	v30, #0
br	x7
ld1.8h	{ v4, v5 }, [x5], #32
subs	w4, w4, #4
smull.4s	v2, v4, v1
smull2.4s	v3, v4, v1
smull.4s	v4, v5, v1
smull2.4s	v5, v5, v1
cmlt.4s	v16, v2, #0
cmlt.4s	v17, v3, #0
cmlt.4s	v18, v4, #0
cmlt.4s	v19, v5, #0
add.4s	v2, v2, v16
add.4s	v3, v3, v17
add.4s	v4, v4, v18
add.4s	v5, v5, v19
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
rshrn.4h	v3, v4, #6
rshrn2.8h	v3, v5, #6
add.8h	v2, v2, v0
add.8h	v3, v3, v0
smax.8h	v2, v2, v30
smax.8h	v3, v3, v30
smin.8h	v2, v2, v31
smin.8h	v3, v3, v31
st1.d	{ v2 }[0], [x0], x1
st1.d	{ v2 }[1], [x6], x1
st1.d	{ v3 }[0], [x0], x1
st1.d	{ v3 }[1], [x6], x1
b.gt	ipred_cfl_128_16bpc_neon
ret
ld1.8h	{ v4, v5 }, [x5], #32
subs	w4, w4, #2
smull.4s	v2, v4, v1
smull2.4s	v3, v4, v1
smull.4s	v4, v5, v1
smull2.4s	v5, v5, v1
cmlt.4s	v16, v2, #0
cmlt.4s	v17, v3, #0
cmlt.4s	v18, v4, #0
cmlt.4s	v19, v5, #0
add.4s	v2, v2, v16
add.4s	v3, v3, v17
add.4s	v4, v4, v18
add.4s	v5, v5, v19
rshrn.4h	v2, v2, #6
rshrn2.8h	v2, v3, #6
rshrn.4h	v3, v4, #6
rshrn2.8h	v3, v5, #6
add.8h	v2, v2, v0
add.8h	v3, v3, v0
smax.8h	v2, v2, v30
smax.8h	v3, v3, v30
smin.8h	v2, v2, v31
smin.8h	v3, v3, v31
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x6], x1
b.gt	ipred_cfl_128_16bpc_neon
ret
add	x7, x5, w3, uxtw #1
sub	x1, x1, w3, uxtw #1
mov	w9, w3
ld1.8h	{ v2, v3 }, [x5], #32
ld1.8h	{ v4, v5 }, [x7], #32
subs	w3, w3, #16
smull.4s	v16, v2, v1
smull2.4s	v17, v2, v1
smull.4s	v18, v3, v1
smull2.4s	v19, v3, v1
smull.4s	v2, v4, v1
smull2.4s	v3, v4, v1
smull.4s	v4, v5, v1
smull2.4s	v5, v5, v1
cmlt.4s	v20, v16, #0
cmlt.4s	v21, v17, #0
cmlt.4s	v22, v18, #0
cmlt.4s	v23, v19, #0
cmlt.4s	v24, v2, #0
cmlt.4s	v25, v3, #0
cmlt.4s	v26, v4, #0
cmlt.4s	v27, v5, #0
add.4s	v16, v16, v20
add.4s	v17, v17, v21
add.4s	v18, v18, v22
add.4s	v19, v19, v23
add.4s	v2, v2, v24
add.4s	v3, v3, v25
add.4s	v4, v4, v26
add.4s	v5, v5, v27
rshrn.4h	v16, v16, #6
rshrn2.8h	v16, v17, #6
rshrn.4h	v17, v18, #6
rshrn2.8h	v17, v19, #6
rshrn.4h	v6, v2, #6
rshrn2.8h	v6, v3, #6
rshrn.4h	v7, v4, #6
rshrn2.8h	v7, v5, #6
add.8h	v2, v16, v0
add.8h	v3, v17, v0
add.8h	v4, v6, v0
add.8h	v5, v7, v0
smax.8h	v2, v2, v30
smax.8h	v3, v3, v30
smax.8h	v4, v4, v30
smax.8h	v5, v5, v30
smin.8h	v2, v2, v31
smin.8h	v3, v3, v31
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
st1.8h	{ v2, v3 }, [x0], #32
st1.8h	{ v4, v5 }, [x6], #32
b.gt	ipred_cfl_128_16bpc_neon
subs	w4, w4, #2
add	x5, x5, w9, uxtw #1
add	x7, x7, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b.gt	ipred_cfl_128_16bpc_neon
ret
<unknown>
<unknown>
_ipred_cfl_top_16bpc_neon:
dup.8h	v31, w7
clz	w9, w3
adr	x7, #136
sub	w9, w9, #26
ldrh	w9, [x7, w9, uxtw #1]
dup.8h	v1, w6
add	x2, x2, #2
sub	x7, x7, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
movi.8h	v30, #0
br	x7
ld1.4h	{ v0 }, [x2]
addv.4h	h0, v0
urshr.4h	v0, v0, #2
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
ld1.8h	{ v0 }, [x2]
addv.8h	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
ld1.8h	{ v2, v3 }, [x2]
addp.8h	v0, v2, v3
addv.8h	h0, v0
urshr.4h	v0, v0, #4
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
ld1.8h	{ v2, v3, v4, v5 }, [x2]
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v0, v2, v4
uaddlv.8h	s0, v0
rshrn.4h	v0, v0, #5
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
<unknown>
<unknown>
_ipred_cfl_left_16bpc_neon:
dup.8h	v31, w7
sub	x2, x2, w4, uxtw #1
clz	w9, w3
clz	w8, w4
adr	x10, #-176
adr	x7, #144
sub	w9, w9, #26
sub	w8, w8, #26
ldrh	w9, [x10, w9, uxtw #1]
ldrh	w8, [x7, w8, uxtw #1]
dup.8h	v1, w6
sub	x9, x10, w9, uxtw
sub	x7, x7, w8, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
movi.8h	v30, #0
br	x7
ld1.4h	{ v0 }, [x2]
addv.4h	h0, v0
urshr.4h	v0, v0, #2
dup.8h	v0, v0[0]
br	x9
ld1.8h	{ v0 }, [x2]
addv.8h	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
br	x9
ld1.8h	{ v2, v3 }, [x2]
addp.8h	v0, v2, v3
addv.8h	h0, v0
urshr.4h	v0, v0, #4
dup.8h	v0, v0[0]
br	x9
ld1.8h	{ v2, v3, v4, v5 }, [x2]
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v0, v2, v4
uaddlv.8h	s0, v0
rshrn.4h	v0, v0, #5
dup.8h	v0, v0[0]
br	x9
<unknown>
<unknown>
_ipred_cfl_16bpc_neon:
dup.8h	v31, w7
sub	x2, x2, w4, uxtw #1
add	w8, w3, w4
dup.8h	v1, w6
clz	w9, w3
clz	w6, w4
dup.4s	v16, w8
adr	x7, #416
rbit	w8, w8
sub	w9, w9, #22
sub	w6, w6, #26
clz	w8, w8
ldrh	w9, [x7, w9, uxtw #1]
ldrh	w6, [x7, w6, uxtw #1]
neg	w8, w8
sub	x9, x7, w9, uxtw
sub	x7, x7, w6, uxtw
ushr.4s	v16, v16, #1
dup.4s	v17, w8
add	x6, x0, x1
lsl	x1, x1, #1
movi.8h	v30, #0
br	x7
ld1.4h	{ v0 }, [x2], #8
uaddlv.4h	s0, v0
add	x2, x2, #2
br	x9
ld1.4h	{ v2 }, [x2]
add.2s	v0, v0, v16
uaddlv.4h	s2, v2
cmp	w4, #4
add.2s	v0, v0, v2
ushl.2s	v0, v0, v17
b.eq	ipred_cfl_16bpc_neon
cmp	w4, #16
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v0, v0, v16
ushr.2s	v0, v0, #17
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
ld1.8h	{ v0 }, [x2], #16
uaddlv.8h	s0, v0
add	x2, x2, #2
br	x9
ld1.8h	{ v2 }, [x2]
add.2s	v0, v0, v16
uaddlv.8h	s2, v2
cmp	w4, #8
add.2s	v0, v0, v2
ushl.2s	v0, v0, v17
b.eq	ipred_cfl_16bpc_neon
cmp	w4, #32
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v0, v0, v16
ushr.2s	v0, v0, #17
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
ld1.8h	{ v2, v3 }, [x2], #32
addp.8h	v0, v2, v3
add	x2, x2, #2
uaddlv.8h	s0, v0
br	x9
ld1.8h	{ v2, v3 }, [x2]
add.2s	v0, v0, v16
addp.8h	v2, v2, v3
uaddlv.8h	s2, v2
cmp	w4, #16
add.2s	v0, v0, v2
ushl.2s	v0, v0, v17
b.eq	ipred_cfl_16bpc_neon
tst	w4, #0x38
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v0, v0, v16
ushr.2s	v0, v0, #17
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
ld1.8h	{ v2, v3, v4, v5 }, [x2], #64
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v0, v2, v4
add	x2, x2, #2
uaddlv.8h	s0, v0
br	x9
ld1.8h	{ v2, v3, v4, v5 }, [x2]
add.4s	v0, v0, v16
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v2, v2, v4
cmp	w4, #32
uaddlv.8h	s2, v2
add.2s	v0, v0, v2
ushl.2s	v0, v0, v17
b.eq	ipred_cfl_16bpc_neon
cmp	w4, #8
mov	w16, #26215
mov	w17, #43691
csel	w16, w16, w17, eq
dup.2s	v16, w16
mul.2s	v0, v0, v16
ushr.2s	v0, v0, #17
dup.8h	v0, v0[0]
b	ipred_cfl_128_16bpc_neon
<unknown>
<unknown>
<unknown>
<unknown>
_ipred_cfl_ac_420_16bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adr	x7, #1076
sub	w8, w8, #27
ldrh	w8, [x7, w8, uxtw #1]
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
sub	x7, x7, w8, uxtw
sub	w8, w6, w4
rbit	w9, w5
rbit	w10, w6
clz	w9, w9
clz	w10, w10
add	w9, w9, w10
add	x10, x1, x2
dup.4s	v31, w9
lsl	x2, x2, #1
neg.4s	v31, v31
br	x7
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v1 }, [x10], x2
ld1.8h	{ v2 }, [x1], x2
ld1.8h	{ v3 }, [x10], x2
addp.8h	v0, v0, v2
addp.8h	v1, v1, v3
add.8h	v0, v0, v1
shl.8h	v0, v0, #1
subs	w8, w8, #2
st1.8h	{ v0 }, [x0], #16
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
b.gt	ipred_cfl_ac_420_16bpc_neon
trn2.2d	v1, v0, v0
trn2.2d	v0, v0, v0
cbz	w4, ipred_cfl_ac_420_16bpc_neon
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
b.gt	ipred_cfl_ac_420_16bpc_neon
add.4s	v24, v24, v25
add.4s	v26, v26, v27
add.4s	v0, v24, v26
addv.4s	s0, v0
sub	x0, x0, w6, uxtw #3
urshl.2s	v4, v0, v31
dup.8h	v4, v4[0]
ld1.8h	{ v0, v1 }, [x0]
subs	w6, w6, #4
sub.8h	v0, v0, v4
sub.8h	v1, v1, v4
st1.8h	{ v0, v1 }, [x0], #32
b.gt	ipred_cfl_ac_420_16bpc_neon
ret
cbnz	w3, ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0, v1 }, [x1], x2
ld1.8h	{ v2, v3 }, [x10], x2
ld1.8h	{ v4, v5 }, [x1], x2
addp.8h	v0, v0, v1
ld1.8h	{ v6, v7 }, [x10], x2
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
add.8h	v0, v0, v2
add.8h	v4, v4, v6
shl.8h	v0, v0, #1
shl.8h	v1, v4, #1
subs	w8, w8, #2
st1.8h	{ v0, v1 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
b.gt	ipred_cfl_ac_420_16bpc_neon
mov.16b	v0, v1
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v1 }, [x10], x2
ld1.8h	{ v2 }, [x1], x2
ld1.8h	{ v3 }, [x10], x2
addp.8h	v0, v0, v2
addp.8h	v1, v1, v3
add.8h	v0, v0, v1
shl.8h	v0, v0, #1
dup.4h	v1, v0[3]
dup.4h	v3, v0[7]
trn2.2d	v2, v0, v0
subs	w8, w8, #2
st1.4h	{ v0, v1, v2, v3 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw.4s	v25, v25, v1
uaddw.4s	v26, v26, v2
uaddw.4s	v27, v27, v3
b.gt	ipred_cfl_ac_420_16bpc_neon
trn1.2d	v0, v2, v3
trn1.2d	v1, v2, v3
cbz	w4, ipred_cfl_ac_420_16bpc_neon
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
st1.8h	{ v0, v1 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
b.gt	ipred_cfl_ac_420_16bpc_neon
lsl	w6, w6, #1
b	ipred_cfl_ac_420_16bpc_neon
adr	x7, #632
ldrh	w3, [x7, w3, uxtw #1]
sub	x7, x7, w3, uxtw
br	x7
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
ld1.8h	{ v4, v5, v6, v7 }, [x10], x2
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
ld1.8h	{ v16, v17, v18, v19 }, [x1], x2
add.8h	v0, v0, v4
ld1.8h	{ v20, v21, v22, v23 }, [x10], x2
add.8h	v2, v2, v6
addp.8h	v16, v16, v17
addp.8h	v18, v18, v19
addp.8h	v20, v20, v21
addp.8h	v22, v22, v23
add.8h	v16, v16, v20
add.8h	v18, v18, v22
shl.8h	v0, v0, #1
shl.8h	v1, v2, #1
shl.8h	v2, v16, #1
shl.8h	v3, v18, #1
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_420_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ldr	q2, [x1, #32]
ld1.8h	{ v0, v1 }, [x1], x2
ldr	q5, [x10, #32]
ld1.8h	{ v3, v4 }, [x10], x2
addp.8h	v2, v2, v2
addp.8h	v0, v0, v1
addp.8h	v5, v5, v5
addp.8h	v3, v3, v4
ldr	q18, [x1, #32]
add.4h	v2, v2, v5
ld1.8h	{ v16, v17 }, [x1], x2
add.8h	v0, v0, v3
ldr	q21, [x10, #32]
ld1.8h	{ v19, v20 }, [x10], x2
addp.8h	v18, v18, v18
addp.8h	v16, v16, v17
addp.8h	v21, v21, v21
addp.8h	v19, v19, v20
add.4h	v18, v18, v21
add.8h	v16, v16, v19
shl.4h	v1, v2, #1
shl.8h	v0, v0, #1
shl.4h	v3, v18, #1
shl.8h	v2, v16, #1
dup.4h	v4, v1[3]
dup.4h	v5, v3[3]
trn1.2d	v1, v1, v4
trn1.2d	v3, v3, v5
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_420_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0, v1 }, [x1], x2
ld1.8h	{ v2, v3 }, [x10], x2
ld1.8h	{ v4, v5 }, [x1], x2
addp.8h	v0, v0, v1
ld1.8h	{ v6, v7 }, [x10], x2
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
add.8h	v0, v0, v2
add.8h	v4, v4, v6
shl.8h	v0, v0, #1
shl.8h	v2, v4, #1
dup.8h	v1, v0[7]
dup.8h	v3, v2[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_420_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v2 }, [x10], x2
ld1.8h	{ v4 }, [x1], x2
ld1.8h	{ v6 }, [x10], x2
addp.8h	v0, v0, v4
addp.8h	v2, v2, v6
add.8h	v0, v0, v2
shl.8h	v0, v0, #1
dup.8h	v1, v0[3]
dup.8h	v3, v0[7]
trn2.2d	v2, v0, v3
trn1.2d	v0, v0, v1
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_420_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
cbz	w4, ipred_cfl_ac_420_16bpc_neon
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_420_16bpc_neon
lsl	w6, w6, #2
b	ipred_cfl_ac_420_16bpc_neon
<unknown>
udf	#1000
<unknown>
<unknown>
_ipred_cfl_ac_422_16bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adr	x7, #792
sub	w8, w8, #27
ldrh	w8, [x7, w8, uxtw #1]
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
sub	x7, x7, w8, uxtw
sub	w8, w6, w4
rbit	w9, w5
rbit	w10, w6
clz	w9, w9
clz	w10, w10
add	w9, w9, w10
add	x10, x1, x2
dup.4s	v31, w9
lsl	x2, x2, #1
neg.4s	v31, v31
br	x7
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v1 }, [x10], x2
ld1.8h	{ v2 }, [x1], x2
ld1.8h	{ v3 }, [x10], x2
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
shl.8h	v0, v0, #2
shl.8h	v1, v2, #2
subs	w8, w8, #4
st1.8h	{ v0, v1 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
b.gt	ipred_cfl_ac_422_16bpc_neon
trn2.2d	v0, v1, v1
trn2.2d	v1, v1, v1
b	ipred_cfl_ac_420_16bpc_neon
cbnz	w3, ipred_cfl_ac_422_16bpc_neon
ld1.8h	{ v0, v1 }, [x1], x2
ld1.8h	{ v2, v3 }, [x10], x2
ld1.8h	{ v4, v5 }, [x1], x2
addp.8h	v0, v0, v1
ld1.8h	{ v6, v7 }, [x10], x2
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
shl.8h	v0, v0, #2
shl.8h	v1, v2, #2
shl.8h	v2, v4, #2
shl.8h	v3, v6, #2
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_422_16bpc_neon
mov.16b	v0, v3
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v1 }, [x10], x2
ld1.8h	{ v2 }, [x1], x2
ld1.8h	{ v3 }, [x10], x2
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
shl.8h	v0, v0, #2
shl.8h	v2, v2, #2
dup.4h	v4, v0[3]
dup.8h	v5, v0[7]
dup.4h	v6, v2[3]
dup.8h	v7, v2[7]
trn2.2d	v1, v0, v5
trn1.2d	v0, v0, v4
trn2.2d	v3, v2, v7
trn1.2d	v2, v2, v6
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_422_16bpc_neon
mov.16b	v0, v3
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
adr	x7, #424
ldrh	w3, [x7, w3, uxtw #1]
sub	x7, x7, w3, uxtw
br	x7
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
ld1.8h	{ v4, v5, v6, v7 }, [x10], x2
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
addp.8h	v4, v4, v5
addp.8h	v6, v6, v7
shl.8h	v0, v0, #2
shl.8h	v1, v2, #2
shl.8h	v2, v4, #2
shl.8h	v3, v6, #2
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_422_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ldr	q2, [x1, #32]
ld1.8h	{ v0, v1 }, [x1], x2
ldr	q6, [x10, #32]
ld1.8h	{ v4, v5 }, [x10], x2
addp.8h	v2, v2, v2
addp.8h	v0, v0, v1
addp.8h	v6, v6, v6
addp.8h	v4, v4, v5
shl.4h	v1, v2, #2
shl.8h	v0, v0, #2
shl.4h	v3, v6, #2
shl.8h	v2, v4, #2
dup.4h	v4, v1[3]
dup.4h	v5, v3[3]
trn1.2d	v1, v1, v4
trn1.2d	v3, v3, v5
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_422_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0, v1 }, [x1], x2
ld1.8h	{ v2, v3 }, [x10], x2
addp.8h	v0, v0, v1
addp.8h	v2, v2, v3
shl.8h	v0, v0, #2
shl.8h	v2, v2, #2
dup.8h	v1, v0[7]
dup.8h	v3, v2[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_422_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v2 }, [x10], x2
addp.8h	v0, v0, v0
addp.8h	v2, v2, v2
shl.4h	v0, v0, #2
shl.4h	v2, v2, #2
dup.8h	v1, v0[3]
dup.8h	v3, v2[3]
trn1.2d	v0, v0, v1
trn1.2d	v2, v2, v3
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_422_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
<unknown>
udf	#716
<unknown>
<unknown>
_ipred_cfl_ac_444_16bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adr	x7, #772
sub	w8, w8, #26
ldrh	w8, [x7, w8, uxtw #1]
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
sub	x7, x7, w8, uxtw
sub	w8, w6, w4
rbit	w9, w5
rbit	w10, w6
clz	w9, w9
clz	w10, w10
add	w9, w9, w10
add	x10, x1, x2
dup.4s	v31, w9
lsl	x2, x2, #1
neg.4s	v31, v31
br	x7
ld1.4h	{ v0 }, [x1], x2
ld1.d	{ v0 }[1], [x10], x2
ld1.4h	{ v1 }, [x1], x2
ld1.d	{ v1 }[1], [x10], x2
shl.8h	v0, v0, #3
shl.8h	v1, v1, #3
subs	w8, w8, #4
st1.8h	{ v0, v1 }, [x0], #32
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
b.gt	ipred_cfl_ac_444_16bpc_neon
trn2.2d	v0, v1, v1
trn2.2d	v1, v1, v1
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v1 }, [x10], x2
ld1.8h	{ v2 }, [x1], x2
shl.8h	v0, v0, #3
ld1.8h	{ v3 }, [x10], x2
shl.8h	v1, v1, #3
shl.8h	v2, v2, #3
shl.8h	v3, v3, #3
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
mov.16b	v0, v3
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
cbnz	w3, ipred_cfl_ac_444_16bpc_neon
ld1.8h	{ v0, v1 }, [x1], x2
ld1.8h	{ v2, v3 }, [x10], x2
shl.8h	v0, v0, #3
shl.8h	v1, v1, #3
shl.8h	v2, v2, #3
shl.8h	v3, v3, #3
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
ld1.8h	{ v2 }, [x10], x2
shl.8h	v0, v0, #3
shl.8h	v2, v2, #3
dup.8h	v1, v0[7]
dup.8h	v3, v2[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_16bpc_neon
adr	x7, #388
ldrh	w3, [x7, w3, uxtw]
lsr	x2, x2, #1
sub	x7, x7, w3, uxtw
br	x7
ld1.8h	{ v0, v1, v2, v3 }, [x1], x2
shl.8h	v0, v0, #3
shl.8h	v1, v1, #3
shl.8h	v2, v2, #3
shl.8h	v3, v3, #3
subs	w8, w8, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
b	ipred_cfl_ac_444_16bpc_neon
ld1.8h	{ v0, v1, v2 }, [x1], x2
shl.8h	v2, v2, #3
shl.8h	v0, v0, #3
shl.8h	v1, v1, #3
dup.8h	v3, v2[7]
subs	w8, w8, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
b	ipred_cfl_ac_444_16bpc_neon
ld1.8h	{ v0, v1 }, [x1], x2
shl.8h	v1, v1, #3
shl.8h	v0, v0, #3
dup.8h	v2, v1[7]
dup.8h	v3, v1[7]
subs	w8, w8, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
b	ipred_cfl_ac_444_16bpc_neon
ld1.8h	{ v0 }, [x1], x2
shl.8h	v0, v0, #3
dup.8h	v1, v0[7]
dup.8h	v2, v0[7]
dup.8h	v3, v0[7]
subs	w8, w8, #1
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
cbz	w4, ipred_cfl_ac_444_16bpc_neon
subs	w4, w4, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
uaddw.4s	v24, v24, v0
uaddw2.4s	v25, v25, v0
uaddw.4s	v26, v26, v1
uaddw2.4s	v27, v27, v1
uaddw.4s	v24, v24, v2
uaddw2.4s	v25, v25, v2
uaddw.4s	v26, v26, v3
uaddw2.4s	v27, v27, v3
b.gt	ipred_cfl_ac_444_16bpc_neon
lsl	w6, w6, #3
b	ipred_cfl_ac_420_16bpc_neon
<unknown>
<unknown>
<unknown>
<unknown>