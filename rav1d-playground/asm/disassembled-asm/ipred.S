_ltmp0:
clz	w3, w3
adr	x5, #188
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
movi.16b	v0, #128
sub	x5, x5, w3, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
subs	w4, w4, #4
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
b.gt	ltmp0
ret
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
b.gt	ltmp0
ret
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ltmp0
ret
movi.16b	v1, #128
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
b.gt	ltmp0
ret
movi.16b	v1, #128
movi.16b	v2, #128
movi.16b	v3, #128
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ltmp0
ret
<unknown>
<unknown>
udf	#156
_ipred_v_8bpc_neon:
clz	w3, w3
adr	x5, #192
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
add	x2, x2, #1
sub	x5, x5, w3, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1.s	{ v0 }[0], [x2]
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
subs	w4, w4, #4
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
b.gt	ipred_v_8bpc_neon
ret
ld1.8b	{ v0 }, [x2]
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
b.gt	ipred_v_8bpc_neon
ret
ld1.16b	{ v0 }, [x2]
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_v_8bpc_neon
ret
ld1.16b	{ v0, v1 }, [x2]
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
b.gt	ipred_v_8bpc_neon
ret
ld1.16b	{ v0, v1, v2, v3 }, [x2]
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_v_8bpc_neon
ret
<unknown>
<unknown>
udf	#160
_ipred_h_8bpc_neon:
clz	w3, w3
adr	x5, #244
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
sub	x2, x2, #4
sub	x5, x5, w3, uxtw
mov	x7, #-4
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v2 }[0], [x6], x1
subs	w4, w4, #4
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
b.gt	ipred_h_8bpc_neon
ret
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
st1.8b	{ v3 }, [x0], x1
st1.8b	{ v2 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v1 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
b.gt	ipred_h_8bpc_neon
ret
ld4r.16b	{ v0, v1, v2, v3 }, [x2], x7
st1.16b	{ v3 }, [x0], x1
st1.16b	{ v2 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_h_8bpc_neon
ret
ld4r.16b	{ v0, v1, v2, v3 }, [x2], x7
str	q3, [x0, #16]
str	q2, [x6, #16]
st1.16b	{ v3 }, [x0], x1
st1.16b	{ v2 }, [x6], x1
subs	w4, w4, #4
str	q1, [x0, #16]
str	q0, [x6, #16]
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_h_8bpc_neon
ret
ld4r.16b	{ v0, v1, v2, v3 }, [x2], x7
str	q3, [x0, #16]
str	q2, [x6, #16]
stp	q3, q3, [x0, #32]
stp	q2, q2, [x6, #32]
st1.16b	{ v3 }, [x0], x1
st1.16b	{ v2 }, [x6], x1
subs	w4, w4, #4
str	q1, [x0, #16]
str	q0, [x6, #16]
stp	q1, q1, [x0, #32]
stp	q0, q0, [x6, #32]
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_h_8bpc_neon
ret
<unknown>
<unknown>
udf	#208
_ipred_dc_top_8bpc_neon:
clz	w3, w3
adr	x5, #300
sub	w3, w3, #25
ldrh	w3, [x5, w3, uxtw #1]
add	x2, x2, #1
sub	x5, x5, w3, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2s	{ v0 }, [x2]
uaddlv.8b	h0, v0
rshrn.8b	v0, v0, #3
dup.8b	v0, v0[0]
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
subs	w4, w4, #4
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
b.gt	ipred_dc_top_8bpc_neon
ret
ld1.8b	{ v0 }, [x2]
uaddlv.8b	h0, v0
rshrn.8b	v0, v0, #3
dup.8b	v0, v0[0]
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
b.gt	ipred_dc_top_8bpc_neon
ret
ld1.16b	{ v0 }, [x2]
uaddlv.16b	h0, v0
rshrn.8b	v0, v0, #4
dup.16b	v0, v0[0]
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_dc_top_8bpc_neon
ret
ld1.16b	{ v0, v1 }, [x2]
uaddlv.16b	h0, v0
uaddlv.16b	h1, v1
add.4h	v2, v0, v1
rshrn.8b	v2, v2, #5
dup.16b	v0, v2[0]
dup.16b	v1, v2[0]
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
b.gt	ipred_dc_top_8bpc_neon
ret
ld1.16b	{ v0, v1, v2, v3 }, [x2]
uaddlv.16b	h0, v0
uaddlv.16b	h1, v1
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
add.4h	v4, v0, v1
add.4h	v5, v2, v3
add.4h	v4, v4, v5
rshrn.8b	v4, v4, #6
dup.16b	v0, v4[0]
dup.16b	v1, v4[0]
dup.16b	v2, v4[0]
dup.16b	v3, v4[0]
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_top_8bpc_neon
ret
<unknown>
<unknown>
udf	#268
_ipred_dc_left_8bpc_neon:
sub	x2, x2, w4, uxtw
clz	w3, w3
clz	w7, w4
adr	x5, #328
sub	w3, w3, #20
sub	w7, w7, #25
ldrh	w3, [x5, w3, uxtw #1]
ldrh	w7, [x5, w7, uxtw #1]
sub	x3, x5, w3, uxtw
sub	x5, x5, w7, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2s	{ v0 }, [x2]
uaddlv.8b	h0, v0
rshrn.8b	v0, v0, #3
dup.16b	v0, v0[0]
br	x3
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
subs	w4, w4, #4
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
b.gt	ipred_dc_left_8bpc_neon
ret
ld1.8b	{ v0 }, [x2]
uaddlv.8b	h0, v0
rshrn.8b	v0, v0, #3
dup.16b	v0, v0[0]
br	x3
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
b.gt	ipred_dc_left_8bpc_neon
ret
ld1.16b	{ v0 }, [x2]
uaddlv.16b	h0, v0
rshrn.8b	v0, v0, #4
dup.16b	v0, v0[0]
br	x3
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_dc_left_8bpc_neon
ret
ld1.16b	{ v0, v1 }, [x2]
uaddlv.16b	h0, v0
uaddlv.16b	h1, v1
add.4h	v0, v0, v1
rshrn.8b	v0, v0, #5
dup.16b	v0, v0[0]
br	x3
mov.16b	v1, v0
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
b.gt	ipred_dc_left_8bpc_neon
ret
ld1.16b	{ v0, v1, v2, v3 }, [x2]
uaddlv.16b	h0, v0
uaddlv.16b	h1, v1
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
add.4h	v0, v0, v1
add.4h	v2, v2, v3
add.4h	v0, v0, v2
rshrn.8b	v0, v0, #6
dup.16b	v0, v0[0]
br	x3
mov.16b	v1, v0
mov.16b	v2, v0
mov.16b	v3, v0
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_left_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
_ipred_dc_8bpc_neon:
sub	x2, x2, w4, uxtw
add	w7, w3, w4
clz	w3, w3
clz	w6, w4
dup.8h	v16, w7
adr	x5, #644
rbit	w7, w7
sub	w3, w3, #20
sub	w6, w6, #25
clz	w7, w7
ldrh	w3, [x5, w3, uxtw #1]
ldrh	w6, [x5, w6, uxtw #1]
neg	w7, w7
sub	x3, x5, w3, uxtw
sub	x5, x5, w6, uxtw
ushr.8h	v16, v16, #1
dup.8h	v17, w7
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1.s	{ v0 }[0], [x2], #4
mov.s	v0[1], wzr
uaddlv.8b	h0, v0
add	x2, x2, #1
br	x3
ld1.s	{ v1 }[0], [x2]
mov.s	v1[1], wzr
add.4h	v0, v0, v16
uaddlv.8b	h1, v1
cmp	w4, #4
add.4h	v0, v0, v1
ushl.4h	v0, v0, v17
b.eq	ipred_dc_8bpc_neon
mov	w16, #6554
movk	w16, #10923, lsl #16
add	w17, w4, w4
lsr	w16, w16, w17
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.8b	v0, v0[0]
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
subs	w4, w4, #4
st1.s	{ v0 }[0], [x0], x1
st1.s	{ v0 }[0], [x6], x1
b.gt	ipred_dc_8bpc_neon
ret
ld1.8b	{ v0 }, [x2], #8
uaddlv.8b	h0, v0
add	x2, x2, #1
br	x3
ld1.8b	{ v1 }, [x2]
add.4h	v0, v0, v16
uaddlv.8b	h1, v1
cmp	w4, #8
add.4h	v0, v0, v1
ushl.4h	v0, v0, v17
b.eq	ipred_dc_8bpc_neon
cmp	w4, #32
mov	w16, #6554
mov	w17, #10923
csel	w16, w16, w17, eq
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.8b	v0, v0[0]
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v0 }, [x0], x1
st1.8b	{ v0 }, [x6], x1
b.gt	ipred_dc_8bpc_neon
ret
ld1.16b	{ v0 }, [x2], #16
uaddlv.16b	h0, v0
add	x2, x2, #1
br	x3
ld1.16b	{ v1 }, [x2]
add.4h	v0, v0, v16
uaddlv.16b	h1, v1
cmp	w4, #16
add.4h	v0, v0, v1
ushl.4h	v0, v0, v17
b.eq	ipred_dc_8bpc_neon
tst	w4, #0x38
mov	w16, #6554
mov	w17, #10923
csel	w16, w16, w17, eq
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.16b	v0, v0[0]
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0 }, [x0], x1
st1.16b	{ v0 }, [x6], x1
b.gt	ipred_dc_8bpc_neon
ret
ld1.16b	{ v0, v1 }, [x2], #32
uaddlv.16b	h0, v0
uaddlv.16b	h1, v1
add	x2, x2, #1
add.4h	v0, v0, v1
br	x3
ld1.16b	{ v1, v2 }, [x2]
add.4h	v0, v0, v16
uaddlv.16b	h1, v1
uaddlv.16b	h2, v2
cmp	w4, #32
add.4h	v0, v0, v1
add.4h	v0, v0, v2
ushl.4h	v4, v0, v17
b.eq	ipred_dc_8bpc_neon
cmp	w4, #8
mov	w16, #6554
mov	w17, #10923
csel	w16, w16, w17, eq
dup.4h	v16, w16
sqdmulh.4h	v4, v4, v16
dup.16b	v0, v4[0]
dup.16b	v1, v4[0]
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1 }, [x0], x1
st1.16b	{ v0, v1 }, [x6], x1
b.gt	ipred_dc_8bpc_neon
ret
ld1.16b	{ v0, v1, v2, v3 }, [x2], #64
uaddlv.16b	h0, v0
uaddlv.16b	h1, v1
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
add.4h	v0, v0, v1
add.4h	v2, v2, v3
add	x2, x2, #1
add.4h	v0, v0, v2
br	x3
ld1.16b	{ v1, v2, v3, v4 }, [x2]
add.4h	v0, v0, v16
uaddlv.16b	h1, v1
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
uaddlv.16b	h4, v4
add.4h	v1, v1, v2
add.4h	v3, v3, v4
cmp	w4, #64
add.4h	v0, v0, v1
add.4h	v0, v0, v3
ushl.4h	v4, v0, v17
b.eq	ipred_dc_8bpc_neon
mov	w16, #10923
movk	w16, #6554, lsl #16
lsr	w16, w16, w4
dup.4h	v16, w16
sqdmulh.4h	v4, v4, v16
dup.16b	v0, v4[0]
dup.16b	v1, v4[0]
dup.16b	v2, v4[0]
dup.16b	v3, v4[0]
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
subs	w4, w4, #4
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
st1.16b	{ v0, v1, v2, v3 }, [x6], x1
b.gt	ipred_dc_8bpc_neon
ret
<unknown>
<unknown>
<unknown>
<unknown>
<unknown>
_ipred_paeth_8bpc_neon:
clz	w9, w3
adr	x5, #592
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.16b	{ v4 }, [x2]
add	x8, x2, #1
sub	x2, x2, #4
sub	x5, x5, w9, uxtw
mov	x7, #-4
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.4s	{ v5 }, [x8]
usubl.8h	v6, v5, v4
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
zip1.2s	v0, v0, v1
zip1.2s	v2, v2, v3
uaddw.8h	v16, v6, v0
uaddw.8h	v17, v6, v2
sqxtun.8b	v16, v16
sqxtun2.16b	v16, v17
zip1.2d	v0, v0, v2
uabd.16b	v20, v5, v16
uabd.16b	v22, v4, v16
uabd.16b	v16, v0, v16
umin.16b	v18, v20, v22
cmhs.16b	v20, v22, v20
cmhs.16b	v16, v18, v16
bsl.16b	v20, v5, v4
bit.16b	v20, v0, v16
st1.s	{ v20 }[3], [x0], x1
st1.s	{ v20 }[2], [x6], x1
subs	w4, w4, #4
st1.s	{ v20 }[1], [x0], x1
st1.s	{ v20 }[0], [x6], x1
b.gt	ipred_paeth_8bpc_neon
ret
ld1r.2d	{ v5 }, [x8]
usubl.8h	v6, v5, v4
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
uaddw.8h	v16, v6, v0
uaddw.8h	v17, v6, v1
uaddw.8h	v18, v6, v2
uaddw.8h	v19, v6, v3
sqxtun.8b	v16, v16
sqxtun2.16b	v16, v17
sqxtun.8b	v18, v18
sqxtun2.16b	v18, v19
zip1.2d	v2, v2, v3
zip1.2d	v0, v0, v1
uabd.16b	v21, v5, v18
uabd.16b	v20, v5, v16
uabd.16b	v23, v4, v18
uabd.16b	v22, v4, v16
uabd.16b	v17, v2, v18
uabd.16b	v16, v0, v16
umin.16b	v19, v21, v23
umin.16b	v18, v20, v22
cmhs.16b	v21, v23, v21
cmhs.16b	v20, v22, v20
cmhs.16b	v17, v19, v17
cmhs.16b	v16, v18, v16
bsl.16b	v21, v5, v4
bsl.16b	v20, v5, v4
bit.16b	v21, v2, v17
bit.16b	v20, v0, v16
st1.d	{ v21 }[1], [x0], x1
st1.d	{ v21 }[0], [x6], x1
subs	w4, w4, #4
st1.d	{ v20 }[1], [x0], x1
st1.d	{ v20 }[0], [x6], x1
b.gt	ipred_paeth_8bpc_neon
ret
ld1.16b	{ v5 }, [x8], #16
mov	w9, w3
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
ld4r.16b	{ v0, v1, v2, v3 }, [x2], x7
usubl.8h	v6, v5, v4
usubl2.8h	v7, v5, v4
uaddw.8h	v24, v6, v0
uaddw.8h	v25, v7, v0
uaddw.8h	v26, v6, v1
uaddw.8h	v27, v7, v1
uaddw.8h	v28, v6, v2
uaddw.8h	v29, v7, v2
uaddw.8h	v30, v6, v3
uaddw.8h	v31, v7, v3
sqxtun.8b	v17, v26
sqxtun2.16b	v17, v27
sqxtun.8b	v16, v24
sqxtun2.16b	v16, v25
sqxtun.8b	v19, v30
sqxtun2.16b	v19, v31
sqxtun.8b	v18, v28
sqxtun2.16b	v18, v29
uabd.16b	v23, v5, v19
uabd.16b	v22, v5, v18
uabd.16b	v21, v5, v17
uabd.16b	v20, v5, v16
uabd.16b	v27, v4, v19
uabd.16b	v26, v4, v18
uabd.16b	v25, v4, v17
uabd.16b	v24, v4, v16
uabd.16b	v19, v3, v19
uabd.16b	v18, v2, v18
uabd.16b	v17, v1, v17
uabd.16b	v16, v0, v16
umin.16b	v31, v23, v27
umin.16b	v30, v22, v26
umin.16b	v29, v21, v25
umin.16b	v28, v20, v24
cmhs.16b	v23, v27, v23
cmhs.16b	v22, v26, v22
cmhs.16b	v21, v25, v21
cmhs.16b	v20, v24, v20
cmhs.16b	v19, v31, v19
cmhs.16b	v18, v30, v18
cmhs.16b	v17, v29, v17
cmhs.16b	v16, v28, v16
bsl.16b	v23, v5, v4
bsl.16b	v22, v5, v4
bsl.16b	v21, v5, v4
bsl.16b	v20, v5, v4
bit.16b	v23, v3, v19
bit.16b	v22, v2, v18
bit.16b	v21, v1, v17
bit.16b	v20, v0, v16
subs	w3, w3, #16
st1.16b	{ v23 }, [x0], #16
st1.16b	{ v22 }, [x6], #16
st1.16b	{ v21 }, [x5], #16
st1.16b	{ v20 }, [x10], #16
b.le	ipred_paeth_8bpc_neon
ld1.16b	{ v5 }, [x8], #16
b	ipred_paeth_8bpc_neon
subs	w4, w4, #4
b.le	ipred_paeth_8bpc_neon
sub	x8, x8, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
ld1.16b	{ v5 }, [x8], #16
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	ipred_paeth_8bpc_neon
ret
<unknown>
<unknown>
udf	#548
_ipred_smooth_8bpc_neon:
adrp	x10, ipred_smooth_8bpc_neon
add	x10, x10, #0
add	x11, x10, w4, uxtw
add	x10, x10, w3, uxtw
clz	w9, w3
adr	x5, #596
sub	x12, x2, w4, uxtw
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.16b	{ v4 }, [x12]
add	x8, x2, #1
sub	x5, x5, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2s	{ v6 }, [x8]
ld1r.2s	{ v7 }, [x10]
sub	x2, x2, #4
mov	x7, #-4
dup.16b	v5, v6[3]
usubl.8h	v6, v6, v4
ushll.8h	v7, v7, #0
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
ld4r.8b	{ v16, v17, v18, v19 }, [x11], #4
shll.8h	v20, v5, #8
shll.8h	v21, v5, #8
zip1.2s	v1, v1, v0
zip1.2s	v0, v3, v2
zip1.2s	v16, v16, v17
zip1.2s	v18, v18, v19
shll.8h	v22, v4, #8
shll.8h	v23, v4, #8
usubl.8h	v0, v0, v5
usubl.8h	v1, v1, v5
ushll.8h	v16, v16, #0
ushll.8h	v18, v18, #0
mla.8h	v20, v0, v7
mla.8h	v21, v1, v7
mla.8h	v22, v6, v16
mla.8h	v23, v6, v18
uhadd.8h	v20, v20, v22
uhadd.8h	v21, v21, v23
rshrn.8b	v20, v20, #8
rshrn.8b	v21, v21, #8
st1.s	{ v20 }[0], [x0], x1
st1.s	{ v20 }[1], [x6], x1
subs	w4, w4, #4
st1.s	{ v21 }[0], [x0], x1
st1.s	{ v21 }[1], [x6], x1
b.gt	ipred_smooth_8bpc_neon
ret
ld1.8b	{ v6 }, [x8]
ld1.8b	{ v7 }, [x10]
sub	x2, x2, #4
mov	x7, #-4
dup.16b	v5, v6[7]
usubl.8h	v6, v6, v4
ushll.8h	v7, v7, #0
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
ld4r.8b	{ v16, v17, v18, v19 }, [x11], #4
shll.8h	v20, v5, #8
shll.8h	v21, v5, #8
shll.8h	v22, v5, #8
shll.8h	v23, v5, #8
usubl.8h	v0, v0, v5
usubl.8h	v1, v1, v5
usubl.8h	v2, v2, v5
usubl.8h	v3, v3, v5
shll.8h	v24, v4, #8
shll.8h	v25, v4, #8
shll.8h	v26, v4, #8
shll.8h	v27, v4, #8
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
mla.8h	v20, v3, v7
mla.8h	v21, v2, v7
mla.8h	v22, v1, v7
mla.8h	v23, v0, v7
mla.8h	v24, v6, v16
mla.8h	v25, v6, v17
mla.8h	v26, v6, v18
mla.8h	v27, v6, v19
uhadd.8h	v20, v20, v24
uhadd.8h	v21, v21, v25
uhadd.8h	v22, v22, v26
uhadd.8h	v23, v23, v27
rshrn.8b	v20, v20, #8
rshrn.8b	v21, v21, #8
rshrn.8b	v22, v22, #8
rshrn.8b	v23, v23, #8
st1.8b	{ v20 }, [x0], x1
st1.8b	{ v21 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v22 }, [x0], x1
st1.8b	{ v23 }, [x6], x1
b.gt	ipred_smooth_8bpc_neon
ret
add	x12, x2, w3, uxtw
sub	x2, x2, #2
mov	x7, #-2
ld1r.16b	{ v5 }, [x12]
sub	x1, x1, w3, uxtw
mov	w9, w3
ld2r.8b	{ v0, v1 }, [x2], x7
ld2r.8b	{ v16, v17 }, [x11], #2
usubl.8h	v0, v0, v5
usubl.8h	v1, v1, v5
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ld1.16b	{ v7 }, [x10], #16
ld1.16b	{ v3 }, [x8], #16
shll.8h	v20, v5, #8
shll.8h	v21, v5, #8
shll.8h	v22, v5, #8
shll.8h	v23, v5, #8
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
usubl.8h	v2, v3, v4
usubl2.8h	v3, v3, v4
mla.8h	v20, v1, v6
mla.8h	v21, v1, v7
mla.8h	v22, v0, v6
mla.8h	v23, v0, v7
shll.8h	v24, v4, #8
shll.8h	v25, v4, #8
shll.8h	v26, v4, #8
shll.8h	v27, v4, #8
mla.8h	v24, v2, v16
mla.8h	v25, v3, v16
mla.8h	v26, v2, v17
mla.8h	v27, v3, v17
uhadd.8h	v20, v20, v24
uhadd.8h	v21, v21, v25
uhadd.8h	v22, v22, v26
uhadd.8h	v23, v23, v27
rshrn.8b	v20, v20, #8
rshrn2.16b	v20, v21, #8
rshrn.8b	v22, v22, #8
rshrn2.16b	v22, v23, #8
subs	w3, w3, #16
st1.16b	{ v20 }, [x0], #16
st1.16b	{ v22 }, [x6], #16
b.gt	ipred_smooth_8bpc_neon
subs	w4, w4, #2
b.le	ipred_smooth_8bpc_neon
sub	x8, x8, w9, uxtw
sub	x10, x10, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	ipred_smooth_8bpc_neon
ret
<unknown>
<unknown>
udf	#556
_ipred_smooth_v_8bpc_neon:
adrp	x7, ipred_smooth_v_8bpc_neon
add	x7, x7, #0
add	x7, x7, w4, uxtw
clz	w9, w3
adr	x5, #436
sub	x8, x2, w4, uxtw
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.16b	{ v4 }, [x8]
add	x2, x2, #1
sub	x5, x5, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2s	{ v6 }, [x2]
usubl.8h	v6, v6, v4
ld4r.8b	{ v16, v17, v18, v19 }, [x7], #4
shll.8h	v22, v4, #8
shll.8h	v23, v4, #8
zip1.2s	v16, v16, v17
zip1.2s	v18, v18, v19
ushll.8h	v16, v16, #0
ushll.8h	v18, v18, #0
mla.8h	v22, v6, v16
mla.8h	v23, v6, v18
rshrn.8b	v22, v22, #8
rshrn.8b	v23, v23, #8
st1.s	{ v22 }[0], [x0], x1
st1.s	{ v22 }[1], [x6], x1
subs	w4, w4, #4
st1.s	{ v23 }[0], [x0], x1
st1.s	{ v23 }[1], [x6], x1
b.gt	ipred_smooth_v_8bpc_neon
ret
ld1.8b	{ v6 }, [x2]
usubl.8h	v6, v6, v4
ld4r.8b	{ v16, v17, v18, v19 }, [x7], #4
shll.8h	v24, v4, #8
shll.8h	v25, v4, #8
shll.8h	v26, v4, #8
shll.8h	v27, v4, #8
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
mla.8h	v24, v6, v16
mla.8h	v25, v6, v17
mla.8h	v26, v6, v18
mla.8h	v27, v6, v19
rshrn.8b	v24, v24, #8
rshrn.8b	v25, v25, #8
rshrn.8b	v26, v26, #8
rshrn.8b	v27, v27, #8
st1.8b	{ v24 }, [x0], x1
st1.8b	{ v25 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v26 }, [x0], x1
st1.8b	{ v27 }, [x6], x1
b.gt	ipred_smooth_v_8bpc_neon
ret
add	x5, x0, x1
add	x8, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
mov	w9, w3
ld4r.8b	{ v16, v17, v18, v19 }, [x7], #4
ushll.8h	v16, v16, #0
ushll.8h	v17, v17, #0
ushll.8h	v18, v18, #0
ushll.8h	v19, v19, #0
ld1.16b	{ v3 }, [x2], #16
shll.8h	v20, v4, #8
shll.8h	v21, v4, #8
shll.8h	v22, v4, #8
shll.8h	v23, v4, #8
shll.8h	v24, v4, #8
shll.8h	v25, v4, #8
shll.8h	v26, v4, #8
shll.8h	v27, v4, #8
usubl.8h	v2, v3, v4
usubl2.8h	v3, v3, v4
mla.8h	v20, v2, v16
mla.8h	v21, v3, v16
mla.8h	v22, v2, v17
mla.8h	v23, v3, v17
mla.8h	v24, v2, v18
mla.8h	v25, v3, v18
mla.8h	v26, v2, v19
mla.8h	v27, v3, v19
rshrn.8b	v20, v20, #8
rshrn2.16b	v20, v21, #8
rshrn.8b	v22, v22, #8
rshrn2.16b	v22, v23, #8
rshrn.8b	v24, v24, #8
rshrn2.16b	v24, v25, #8
rshrn.8b	v26, v26, #8
rshrn2.16b	v26, v27, #8
subs	w3, w3, #16
st1.16b	{ v20 }, [x0], #16
st1.16b	{ v22 }, [x6], #16
st1.16b	{ v24 }, [x5], #16
st1.16b	{ v26 }, [x8], #16
b.gt	ipred_smooth_v_8bpc_neon
subs	w4, w4, #4
b.le	ipred_smooth_v_8bpc_neon
sub	x2, x2, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x8, x8, x1
mov	w3, w9
b	ipred_smooth_v_8bpc_neon
ret
<unknown>
<unknown>
udf	#396
_ipred_smooth_h_8bpc_neon:
adrp	x8, ipred_smooth_h_8bpc_neon
add	x8, x8, #0
add	x8, x8, w3, uxtw
clz	w9, w3
adr	x5, #456
add	x12, x2, w3, uxtw
sub	w9, w9, #25
ldrh	w9, [x5, w9, uxtw #1]
ld1r.16b	{ v5 }, [x12]
sub	x5, x5, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
ld1r.2s	{ v7 }, [x8]
sub	x2, x2, #4
mov	x7, #-4
ushll.8h	v7, v7, #0
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
shll.8h	v20, v5, #8
shll.8h	v21, v5, #8
zip1.2s	v1, v1, v0
zip1.2s	v0, v3, v2
usubl.8h	v0, v0, v5
usubl.8h	v1, v1, v5
mla.8h	v20, v0, v7
mla.8h	v21, v1, v7
rshrn.8b	v20, v20, #8
rshrn.8b	v21, v21, #8
st1.s	{ v20 }[0], [x0], x1
st1.s	{ v20 }[1], [x6], x1
subs	w4, w4, #4
st1.s	{ v21 }[0], [x0], x1
st1.s	{ v21 }[1], [x6], x1
b.gt	ipred_smooth_h_8bpc_neon
ret
ld1.8b	{ v7 }, [x8]
sub	x2, x2, #4
mov	x7, #-4
ushll.8h	v7, v7, #0
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
shll.8h	v20, v5, #8
shll.8h	v21, v5, #8
shll.8h	v22, v5, #8
shll.8h	v23, v5, #8
usubl.8h	v3, v3, v5
usubl.8h	v2, v2, v5
usubl.8h	v1, v1, v5
usubl.8h	v0, v0, v5
mla.8h	v20, v3, v7
mla.8h	v21, v2, v7
mla.8h	v22, v1, v7
mla.8h	v23, v0, v7
rshrn.8b	v20, v20, #8
rshrn.8b	v21, v21, #8
rshrn.8b	v22, v22, #8
rshrn.8b	v23, v23, #8
st1.8b	{ v20 }, [x0], x1
st1.8b	{ v21 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v22 }, [x0], x1
st1.8b	{ v23 }, [x6], x1
b.gt	ipred_smooth_h_8bpc_neon
ret
sub	x2, x2, #4
mov	x7, #-4
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
mov	w9, w3
ld4r.8b	{ v0, v1, v2, v3 }, [x2], x7
usubl.8h	v0, v0, v5
usubl.8h	v1, v1, v5
usubl.8h	v2, v2, v5
usubl.8h	v3, v3, v5
ld1.16b	{ v7 }, [x8], #16
shll.8h	v20, v5, #8
shll.8h	v21, v5, #8
shll.8h	v22, v5, #8
shll.8h	v23, v5, #8
shll.8h	v24, v5, #8
shll.8h	v25, v5, #8
shll.8h	v26, v5, #8
shll.8h	v27, v5, #8
ushll.8h	v6, v7, #0
ushll2.8h	v7, v7, #0
mla.8h	v20, v3, v6
mla.8h	v21, v3, v7
mla.8h	v22, v2, v6
mla.8h	v23, v2, v7
mla.8h	v24, v1, v6
mla.8h	v25, v1, v7
mla.8h	v26, v0, v6
mla.8h	v27, v0, v7
rshrn.8b	v20, v20, #8
rshrn2.16b	v20, v21, #8
rshrn.8b	v22, v22, #8
rshrn2.16b	v22, v23, #8
rshrn.8b	v24, v24, #8
rshrn2.16b	v24, v25, #8
rshrn.8b	v26, v26, #8
rshrn2.16b	v26, v27, #8
subs	w3, w3, #16
st1.16b	{ v20 }, [x0], #16
st1.16b	{ v22 }, [x6], #16
st1.16b	{ v24 }, [x5], #16
st1.16b	{ v26 }, [x10], #16
b.gt	ipred_smooth_h_8bpc_neon
subs	w4, w4, #4
b.le	ipred_smooth_h_8bpc_neon
sub	x8, x8, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	ipred_smooth_h_8bpc_neon
ret
<unknown>
<unknown>
udf	#420
_ipred_z1_upsample_edge_8bpc_neon:
adrp	x4, ipred_z1_upsample_edge_8bpc_neon
add	x4, x4, #0
ld1.16b	{ v0 }, [x2]
add	x5, x2, w3, uxtw
sub	x4, x4, w3, uxtw
ld1r.16b	{ v1 }, [x5]
ld1.16b	{ v3 }, [x4]
movi.8h	v31, #9
bit.16b	v0, v1, v3
ext.16b	v4, v0, v1, #1
ext.16b	v5, v0, v1, #2
ext.16b	v6, v0, v1, #3
uaddl.8h	v16, v4, v5
uaddl2.8h	v17, v4, v5
uaddl.8h	v18, v0, v6
uaddl2.8h	v19, v0, v6
mul.8h	v16, v16, v31
mul.8h	v17, v17, v31
sub.8h	v16, v16, v18
sub.8h	v17, v17, v19
sqrshrun.8b	v16, v16, #4
sqrshrun2.16b	v16, v17, #4
zip1.16b	v0, v4, v16
zip2.16b	v1, v4, v16
st1.16b	{ v0, v1 }, [x0]
ret
_ipred_z2_upsample_edge_8bpc_neon:
adrp	x4, ipred_z2_upsample_edge_8bpc_neon
add	x4, x4, #0
ld1.16b	{ v0 }, [x2]
add	x5, x2, w1, uxtw
sub	x4, x4, w1, uxtw
ld1r.16b	{ v2 }, [x2]
ld1r.16b	{ v1 }, [x5]
ld1.16b	{ v3 }, [x4]
movi.8h	v31, #9
bit.16b	v0, v1, v3
ext.16b	v4, v2, v0, #15
ext.16b	v5, v0, v1, #1
ext.16b	v6, v0, v1, #2
uaddl.8h	v16, v0, v5
uaddl.8h	v18, v4, v6
mul.8h	v16, v16, v31
sub.8h	v16, v16, v18
sqrshrun.8b	v16, v16, #4
add	x5, x0, #16
zip1.16b	v2, v0, v16
st1.b	{ v1 }[0], [x5]
st1.16b	{ v2 }, [x0]
ret
_ipred_z1_filter_edge_8bpc_neon:
cmp	w4, #3
b.eq	ipred_z1_filter_edge_8bpc_neon
adrp	x5, ipred_z1_filter_edge_8bpc_neon
add	x5, x5, #0
sub	x5, x5, #3
add	x5, x5, w4, uxtw #2
ld1.h	{ v31 }[0], [x5]
ld1.16b	{ v0 }, [x2], #16
dup.16b	v30, v31[0]
dup.16b	v31, v31[1]
cmp	w3, #17
ld1.16b	{ v1 }, [x2], #16
b.lt	ipred_z1_filter_edge_8bpc_neon
ext.16b	v2, v0, v1, #1
ext.16b	v3, v0, v1, #2
umull.8h	v4, v0, v30
umlal.8h	v4, v2, v31
umlal.8h	v4, v3, v30
umull2.8h	v5, v0, v30
umlal2.8h	v5, v2, v31
umlal2.8h	v5, v3, v30
subs	w1, w1, #16
mov.16b	v0, v1
rshrn.8b	v4, v4, #4
rshrn2.16b	v4, v5, #4
sub	w3, w3, #16
st1.16b	{ v4 }, [x0], #16
b.gt	ipred_z1_filter_edge_8bpc_neon
ret
adrp	x5, ipred_z1_filter_edge_8bpc_neon
add	x5, x5, #0
sub	w6, w3, #32
sub	x5, x5, w3, uxtw
add	x6, x2, w6, sxtw
ld1.16b	{ v2 }, [x5]
ld1r.16b	{ v1 }, [x6]
bit.16b	v0, v1, v2
ext.16b	v2, v0, v1, #1
ext.16b	v3, v0, v1, #2
umull.8h	v4, v0, v30
umlal.8h	v4, v2, v31
umlal.8h	v4, v3, v30
umull2.8h	v5, v0, v30
umlal2.8h	v5, v2, v31
umlal2.8h	v5, v3, v30
subs	w1, w1, #16
rshrn.8b	v4, v4, #4
rshrn2.16b	v4, v5, #4
st1.16b	{ v4 }, [x0], #16
b.le	ipred_z1_filter_edge_8bpc_neon
subs	w1, w1, #16
st1.16b	{ v1 }, [x0], #16
b.gt	ipred_z1_filter_edge_8bpc_neon
ret
sub	x2, x2, #1
movi.16b	v29, #2
ld1.16b	{ v0 }, [x2], #16
movi.16b	v30, #4
movi.16b	v31, #4
mov.b	v0[0], v0[1]
cmp	w3, #18
ld1.16b	{ v1 }, [x2], #16
b.lt	ipred_z1_filter_edge_8bpc_neon
ext.16b	v2, v0, v1, #1
ext.16b	v3, v0, v1, #2
ext.16b	v4, v0, v1, #3
ext.16b	v5, v0, v1, #4
umull.8h	v6, v0, v29
umlal.8h	v6, v2, v30
umlal.8h	v6, v3, v31
umlal.8h	v6, v4, v30
umlal.8h	v6, v5, v29
umull2.8h	v7, v0, v29
umlal2.8h	v7, v2, v30
umlal2.8h	v7, v3, v31
umlal2.8h	v7, v4, v30
umlal2.8h	v7, v5, v29
subs	w1, w1, #16
mov.16b	v0, v1
rshrn.8b	v6, v6, #4
rshrn2.16b	v6, v7, #4
sub	w3, w3, #16
st1.16b	{ v6 }, [x0], #16
b.gt	ipred_z1_filter_edge_8bpc_neon
ret
adrp	x5, ipred_z1_filter_edge_8bpc_neon
add	x5, x5, #0
sub	x5, x5, #1
sub	w6, w3, #31
sub	x5, x5, w3, uxtw
add	x6, x2, w6, sxtw
ld1.16b	{ v2, v3 }, [x5]
ld1r.16b	{ v28 }, [x6]
bit.16b	v0, v28, v2
bit.16b	v1, v28, v3
ext.16b	v2, v0, v1, #1
ext.16b	v3, v0, v1, #2
ext.16b	v4, v0, v1, #3
ext.16b	v5, v0, v1, #4
umull.8h	v6, v0, v29
umlal.8h	v6, v2, v30
umlal.8h	v6, v3, v31
umlal.8h	v6, v4, v30
umlal.8h	v6, v5, v29
umull2.8h	v7, v0, v29
umlal2.8h	v7, v2, v30
umlal2.8h	v7, v3, v31
umlal2.8h	v7, v4, v30
umlal2.8h	v7, v5, v29
subs	w1, w1, #16
mov.16b	v0, v1
mov.16b	v1, v28
rshrn.8b	v6, v6, #4
rshrn2.16b	v6, v7, #4
sub	w3, w3, #16
st1.16b	{ v6 }, [x0], #16
b.le	ipred_z1_filter_edge_8bpc_neon
cmp	w3, #0
b.ge	ipred_z1_filter_edge_8bpc_neon
subs	w1, w1, #16
st1.16b	{ v1 }, [x0], #16
b.gt	ipred_z1_filter_edge_8bpc_neon
ret
_ipred_pixel_set_8bpc_neon:
dup.16b	v0, w1
subs	w2, w2, #16
st1.16b	{ v0 }, [x0], #16
b.gt	ipred_pixel_set_8bpc_neon
ret
_ipred_z1_fill1_8bpc_neon:
clz	w9, w3
adr	x8, #548
sub	w9, w9, #25
ldrh	w9, [x8, w9, uxtw #1]
add	x10, x2, w6, uxtw
sub	x8, x8, w9, uxtw
ld1r.16b	{ v31 }, [x10]
mov	w7, w5
mov	w15, #64
br	x8
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill1_8bpc_neon
ldr	d0, [x2, w8, uxtw]
ldr	d2, [x2, w10, uxtw]
dup.4h	v4, w9
dup.4h	v5, w11
ext.8b	v1, v0, v0, #1
ext.8b	v3, v2, v2, #1
usubl.8h	v6, v1, v0
usubl.8h	v7, v3, v2
ushll.8h	v16, v0, #6
ushll.8h	v17, v2, #6
mla.4h	v16, v6, v4
mla.4h	v17, v7, v5
rshrn.8b	v16, v16, #6
rshrn.8b	v17, v17, #6
st1.s	{ v16 }[0], [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.s	{ v17 }[0], [x0], x1
b.gt	ipred_z1_fill1_8bpc_neon
ret
st1.s	{ v31 }[0], [x0], x1
subs	w4, w4, #2
st1.s	{ v31 }[0], [x0], x1
b.gt	ipred_z1_fill1_8bpc_neon
ret
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill1_8bpc_neon
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup.8b	v4, w9
dup.8b	v5, w11
sub	w9, w15, w9
sub	w11, w15, w11
dup.8b	v6, w9
dup.8b	v7, w11
ext.16b	v1, v0, v0, #1
ext.16b	v3, v2, v2, #1
umull.8h	v16, v0, v6
umlal.8h	v16, v1, v4
umull.8h	v17, v2, v7
umlal.8h	v17, v3, v5
rshrn.8b	v16, v16, #6
rshrn.8b	v17, v17, #6
st1.8b	{ v16 }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.8b	{ v17 }, [x0], x1
b.gt	ipred_z1_fill1_8bpc_neon
ret
st1.8b	{ v31 }, [x0], x1
subs	w4, w4, #2
st1.8b	{ v31 }, [x0], x1
b.gt	ipred_z1_fill1_8bpc_neon
ret
mov	w12, w3
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill1_8bpc_neon
add	x8, x2, w8, uxtw
add	x10, x2, w10, uxtw
dup.16b	v4, w9
dup.16b	v5, w11
ld1.16b	{ v0, v1 }, [x8], #32
ld1.16b	{ v2, v3 }, [x10], #32
sub	w9, w15, w9
sub	w11, w15, w11
dup.16b	v6, w9
dup.16b	v7, w11
add	w7, w7, w5
ext.16b	v16, v0, v1, #1
ext.16b	v17, v2, v3, #1
subs	w3, w3, #16
umull.8h	v18, v0, v6
umlal.8h	v18, v16, v4
umull2.8h	v19, v0, v6
umlal2.8h	v19, v16, v4
umull.8h	v20, v2, v7
umlal.8h	v20, v17, v5
umull2.8h	v21, v2, v7
umlal2.8h	v21, v17, v5
rshrn.8b	v16, v18, #6
rshrn2.16b	v16, v19, #6
rshrn.8b	v17, v20, #6
rshrn2.16b	v17, v21, #6
st1.16b	{ v16 }, [x0], #16
st1.16b	{ v17 }, [x13], #16
b.le	ipred_z1_fill1_8bpc_neon
mov.16b	v0, v1
ld1.16b	{ v1 }, [x8], #16
mov.16b	v2, v3
ld1.16b	{ v3 }, [x10], #16
b	ipred_z1_fill1_8bpc_neon
subs	w4, w4, #2
b.le	ipred_z1_fill1_8bpc_neon
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	ipred_z1_fill1_8bpc_neon
ret
st1.16b	{ v31 }, [x0], #16
subs	w3, w3, #16
st1.16b	{ v31 }, [x13], #16
b.gt	ipred_z1_fill1_8bpc_neon
subs	w4, w4, #2
b.le	ipred_z1_fill1_8bpc_neon
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	ipred_z1_fill1_8bpc_neon
<unknown>
<unknown>
udf	#512
_ipred_z1_fill2_8bpc_neon:
cmp	w3, #8
add	x10, x2, w6, uxtw
ld1r.16b	{ v31 }, [x10]
mov	w7, w5
mov	w15, #64
b.eq	ipred_z1_fill2_8bpc_neon
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill2_8bpc_neon
ldr	d0, [x2, w8, uxtw]
ldr	d2, [x2, w10, uxtw]
dup.4h	v4, w9
dup.4h	v5, w11
uzp2.8b	v1, v0, v0
uzp1.8b	v0, v0, v0
uzp2.8b	v3, v2, v2
uzp1.8b	v2, v2, v2
usubl.8h	v6, v1, v0
usubl.8h	v7, v3, v2
ushll.8h	v16, v0, #6
ushll.8h	v17, v2, #6
mla.4h	v16, v6, v4
mla.4h	v17, v7, v5
rshrn.8b	v16, v16, #6
rshrn.8b	v17, v17, #6
st1.s	{ v16 }[0], [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.s	{ v17 }[0], [x0], x1
b.gt	ipred_z1_fill2_8bpc_neon
ret
st1.s	{ v31 }[0], [x0], x1
subs	w4, w4, #2
st1.s	{ v31 }[0], [x0], x1
b.gt	ipred_z1_fill2_8bpc_neon
ret
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z1_fill2_8bpc_neon
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup.8b	v4, w9
dup.8b	v5, w11
sub	w9, w15, w9
sub	w11, w15, w11
dup.8b	v6, w9
dup.8b	v7, w11
uzp2.16b	v1, v0, v0
uzp1.16b	v0, v0, v0
uzp2.16b	v3, v2, v2
uzp1.16b	v2, v2, v2
umull.8h	v16, v1, v4
umlal.8h	v16, v0, v6
umull.8h	v17, v3, v5
umlal.8h	v17, v2, v7
rshrn.8b	v16, v16, #6
rshrn.8b	v17, v17, #6
st1.8b	{ v16 }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #2
st1.8b	{ v17 }, [x0], x1
b.gt	ipred_z1_fill2_8bpc_neon
ret
st1.8b	{ v31 }, [x0], x1
subs	w4, w4, #2
st1.8b	{ v31 }, [x0], x1
b.gt	ipred_z1_fill2_8bpc_neon
ret
_ipred_reverse_8bpc_neon:
sub	x1, x1, #16
add	x3, x0, #8
mov	x4, #16
ld1.16b	{ v0 }, [x1]
subs	w2, w2, #16
rev64.16b	v0, v0
sub	x1, x1, #16
st1.d	{ v0 }[1], [x0], x4
st1.d	{ v0 }[0], [x3], x4
b.gt	ipred_reverse_8bpc_neon
ret
_ipred_z2_fill1_8bpc_neon:
clz	w10, w4
adr	x9, #1972
sub	w10, w10, #25
ldrh	w10, [x9, w10, uxtw #1]
mov	w8, #64
sub	x9, x9, w10, uxtw
sub	w8, w8, w6
adrp	x11, ipred_z2_fill1_8bpc_neon
add	x11, x11, #0
ld1.8h	{ v31 }, [x11]
neg	w7, w7
br	x9
dup.4h	v30, w7
movi.8b	v17, #1
mul.4h	v16, v31, v30
movi.16b	v25, #62
add.4h	v30, v16, v30
xtn.8b	v31, v31
ld1.16b	{ v0, v1 }, [x3]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v30
shrn.8b	v29, v30, #6
and.8b	v27, v27, v25
add.8b	v29, v29, v17
add.8b	v30, v29, v17
add.8b	v28, v29, v19
tbl.8b	v16, { v0 }, v29
trn1.2s	v30, v30, v28
sub.8b	v28, v26, v27
trn1.2s	v31, v31, v31
trn1.2s	v27, v27, v27
trn1.2s	v28, v28, v28
movi.8b	v29, #2
asr	w9, w8, #6
dup.4h	v6, w8
sub	w8, w8, w6
cmn	w9, #4
asr	w11, w8, #6
b.le	ipred_z2_fill1_8bpc_neon
dup.4h	v7, w8
ldr	d2, [x2, w9, sxtw]
ldr	d4, [x2, w11, sxtw]
trn1.2d	v6, v6, v7
tbl.8b	v17, { v0 }, v30
shrn.8b	v20, v6, #6
xtn.8b	v6, v6
ext.8b	v3, v2, v2, #1
ext.8b	v5, v4, v4, #1
and.8b	v6, v6, v25
trn1.2s	v16, v16, v17
trn1.2s	v2, v2, v4
trn1.2s	v3, v3, v5
sub.8b	v7, v26, v6
add.8b	v20, v20, v31
umull.8h	v16, v16, v28
umlal.8h	v16, v17, v27
umull.8h	v22, v2, v7
umlal.8h	v22, v3, v6
cmge.8b	v20, v20, #0
rshrn.8b	v16, v16, #6
rshrn.8b	v22, v22, #6
bit.8b	v16, v22, v20
st1.s	{ v16 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.s	{ v16 }[1], [x0], x1
b.le	ipred_z2_fill1_8bpc_neon
ext.8b	v16, v17, v17, #4
add.8b	v30, v30, v29
b	ipred_z2_fill1_8bpc_neon
tbl.8b	v17, { v0, v1 }, v30
trn1.2s	v16, v16, v17
umull.8h	v18, v16, v28
umlal.8h	v18, v17, v27
rshrn.8b	v18, v18, #6
st1.s	{ v18 }[0], [x0], x1
subs	w5, w5, #2
st1.s	{ v18 }[1], [x0], x1
b.le	ipred_z2_fill1_8bpc_neon
ext.8b	v16, v17, v17, #4
add.8b	v30, v30, v29
b	ipred_z2_fill1_8bpc_neon
ret
dup.8h	v30, w7
movi.8b	v17, #1
mul.8h	v16, v31, v30
movi.16b	v25, #62
add.8h	v30, v16, v30
xtn.8b	v31, v31
ld1.16b	{ v0, v1, v2 }, [x3]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v30
shrn.8b	v29, v30, #6
and.8b	v27, v27, v25
add.8b	v29, v29, v17
tbl.8b	v18, { v0 }, v29
add.8b	v30, v29, v19
add.8b	v29, v29, v17
sub.8b	v28, v26, v27
trn1.2d	v31, v31, v31
movi.8b	v24, #2
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #8
asr	w11, w8, #6
b.le	ipred_z2_fill1_8bpc_neon
dup.8h	v17, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
tbl.8b	v19, { v0, v1 }, v29
shrn.8b	v21, v16, #6
shrn2.16b	v21, v17, #6
xtn.8b	v16, v16
xtn2.16b	v16, v17
tbl.8b	v20, { v0, v1 }, v30
ext.16b	v5, v4, v4, #1
ext.16b	v7, v6, v6, #1
and.16b	v16, v16, v25
trn1.2d	v4, v4, v6
trn1.2d	v5, v5, v7
sub.16b	v7, v26, v16
add.16b	v21, v21, v31
umull.8h	v6, v18, v28
umlal.8h	v6, v19, v27
umull.8h	v17, v19, v28
umlal.8h	v17, v20, v27
umull.8h	v22, v4, v7
umlal.8h	v22, v5, v16
umull2.8h	v23, v4, v7
umlal2.8h	v23, v5, v16
cmge.16b	v21, v21, #0
rshrn.8b	v6, v6, #6
rshrn2.16b	v6, v17, #6
rshrn.8b	v22, v22, #6
rshrn2.16b	v22, v23, #6
bit.16b	v6, v22, v21
st1.d	{ v6 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.d	{ v6 }[1], [x0], x1
b.le	ipred_z2_fill1_8bpc_neon
mov.8b	v18, v20
add.8b	v29, v29, v24
add.8b	v30, v30, v24
b	ipred_z2_fill1_8bpc_neon
tbl.8b	v19, { v0, v1, v2 }, v29
tbl.8b	v20, { v0, v1, v2 }, v30
umull.8h	v6, v18, v28
umlal.8h	v6, v19, v27
umull.8h	v17, v19, v28
umlal.8h	v17, v20, v27
rshrn.8b	v6, v6, #6
rshrn2.16b	v6, v17, #6
st1.d	{ v6 }[0], [x0], x1
subs	w5, w5, #2
st1.d	{ v6 }[1], [x0], x1
b.le	ipred_z2_fill1_8bpc_neon
mov.8b	v18, v20
add.8b	v29, v29, v24
add.8b	v30, v30, v24
b	ipred_z2_fill1_8bpc_neon
ret
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
add	x11, x11, #16
dup.8h	v18, w7
movi.16b	v17, #1
add	x3, x3, #1
ld1.8h	{ v14 }, [x11]
mul.8h	v16, v31, v18
mul.8h	v19, v14, v18
movi.16b	v25, #62
add.8h	v16, v16, v18
add.8h	v18, v19, v18
xtn.8b	v31, v31
xtn2.16b	v31, v14
ld1.16b	{ v0, v1, v2, v3 }, [x3]
ld1r.16b	{ v15 }, [x2]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v16
xtn2.16b	v27, v18
shrn.8b	v29, v16, #6
shrn2.16b	v29, v18, #6
mov.16b	v18, v15
and.16b	v27, v27, v25
tbx.16b	v18, { v0 }, v29
add.16b	v30, v29, v19
add.16b	v29, v29, v17
sub.16b	v28, v26, v27
movi.16b	v24, #2
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #16
asr	w11, w8, #6
b.le	ipred_z2_fill1_8bpc_neon
dup.8h	v17, w8
add	x9, x2, w9, sxtw
add	x11, x2, w11, sxtw
ld1.16b	{ v4, v5 }, [x9]
mov.16b	v19, v15
ld1.16b	{ v6, v7 }, [x11]
tbx.16b	v19, { v0, v1, v2, v3 }, v29
mov.16b	v20, v15
shrn.8b	v21, v16, #6
shrn.8b	v22, v17, #6
xtn.8b	v16, v16
xtn.8b	v17, v17
tbx.16b	v20, { v0, v1, v2, v3 }, v30
trn1.2d	v21, v21, v21
trn1.2d	v22, v22, v22
trn1.2d	v16, v16, v16
trn1.2d	v17, v17, v17
ext.16b	v5, v4, v5, #1
ext.16b	v7, v6, v7, #1
and.16b	v16, v16, v25
and.16b	v17, v17, v25
umull.8h	v10, v18, v28
umlal.8h	v10, v19, v27
sub.16b	v8, v26, v16
sub.16b	v9, v26, v17
umull2.8h	v11, v18, v28
umlal2.8h	v11, v19, v27
add.16b	v21, v21, v31
add.16b	v22, v22, v31
umull.8h	v12, v19, v28
umlal.8h	v12, v20, v27
umull2.8h	v13, v19, v28
umlal2.8h	v13, v20, v27
rshrn.8b	v10, v10, #6
rshrn2.16b	v10, v11, #6
rshrn.8b	v11, v12, #6
rshrn2.16b	v11, v13, #6
umull.8h	v12, v4, v8
umlal.8h	v12, v5, v16
umull2.8h	v13, v4, v8
umlal2.8h	v13, v5, v16
umull.8h	v14, v6, v9
umlal.8h	v14, v7, v17
umull2.8h	v18, v6, v9
umlal2.8h	v18, v7, v17
cmge.16b	v21, v21, #0
cmge.16b	v22, v22, #0
rshrn.8b	v12, v12, #6
rshrn2.16b	v12, v13, #6
rshrn.8b	v13, v14, #6
rshrn2.16b	v13, v18, #6
bit.16b	v10, v12, v21
bit.16b	v11, v13, v22
st1.16b	{ v10 }, [x0], x1
subs	w5, w5, #2
sub	w8, w8, w6
st1.16b	{ v11 }, [x0], x1
b.le	ipred_z2_fill1_8bpc_neon
mov.16b	v18, v20
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill1_8bpc_neon
mov.16b	v19, v15
mov.16b	v20, v15
tbx.16b	v19, { v0, v1, v2, v3 }, v29
tbx.16b	v20, { v0, v1, v2, v3 }, v30
umull.8h	v4, v18, v28
umlal.8h	v4, v19, v27
umull2.8h	v5, v18, v28
umlal2.8h	v5, v19, v27
umull.8h	v6, v19, v28
umlal.8h	v6, v20, v27
umull2.8h	v7, v19, v28
umlal2.8h	v7, v20, v27
rshrn.8b	v4, v4, #6
rshrn2.16b	v4, v5, #6
rshrn.8b	v5, v6, #6
rshrn2.16b	v5, v7, #6
st1.16b	{ v4 }, [x0], x1
subs	w5, w5, #2
st1.16b	{ v5 }, [x0], x1
b.le	ipred_z2_fill1_8bpc_neon
mov.16b	v18, v20
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill1_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
add	x11, x11, #16
dup.8h	v25, w7
add	x3, x3, #1
ld1.8h	{ v14 }, [x11]
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
movi.8h	v11, #8
mul.8h	v26, v31, v25
add.8h	v26, v26, v25
mul.8h	v25, v25, v11
xtn.8b	v31, v31
xtn2.16b	v31, v14
ld1.16b	{ v0, v1, v2, v3 }, [x3]
ld1r.16b	{ v15 }, [x2]
mov	w12, w4
neg	w14, w4
mov.16b	v23, v26
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmp	w9, w14
asr	w11, w8, #6
b.le	ipred_z2_fill1_8bpc_neon
dup.8h	v17, w8
sub	w8, w8, w6
add	x9, x2, w9, sxtw
add	x11, x2, w11, sxtw
sqshrn.8b	v21, v16, #6
sqshrn.8b	v22, v17, #6
xtn.8b	v16, v16
xtn.8b	v17, v17
ld1.16b	{ v4 }, [x9], #16
ld1.16b	{ v6 }, [x11], #16
trn1.2d	v21, v21, v21
trn1.2d	v22, v22, v22
trn1.2d	v16, v16, v16
trn1.2d	v17, v17, v17
movi.16b	v10, #62
movi.16b	v11, #64
and.16b	v16, v16, v10
and.16b	v17, v17, v10
sub.16b	v8, v11, v16
sub.16b	v9, v11, v17
add.16b	v21, v21, v31
add.16b	v22, v22, v31
add.8h	v13, v23, v25
movi.16b	v12, #64
movi.16b	v20, #2
movi.16b	v10, #62
smov.b	w10, v22[0]
xtn.8b	v27, v23
xtn2.16b	v27, v13
shrn.8b	v29, v23, #6
shrn2.16b	v29, v13, #6
cmp	w10, #0
and.16b	v27, v27, v10
mov.16b	v18, v15
b.ge	ipred_z2_fill1_8bpc_neon
add.8h	v23, v13, v25
movi.16b	v13, #1
tbx.16b	v18, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v13
mov.16b	v19, v15
sub.16b	v28, v12, v27
ld1.16b	{ v5 }, [x9], #16
ld1.16b	{ v7 }, [x11], #16
tbx.16b	v19, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v13
mov.16b	v20, v15
tbx.16b	v20, { v0, v1, v2, v3 }, v29
umull.8h	v10, v18, v28
umlal.8h	v10, v19, v27
umull2.8h	v11, v18, v28
umlal2.8h	v11, v19, v27
umull.8h	v12, v19, v28
umlal.8h	v12, v20, v27
umull2.8h	v13, v19, v28
umlal2.8h	v13, v20, v27
ext.16b	v18, v4, v5, #1
ext.16b	v19, v6, v7, #1
rshrn.8b	v10, v10, #6
rshrn2.16b	v10, v11, #6
rshrn.8b	v11, v12, #6
rshrn2.16b	v11, v13, #6
umull.8h	v12, v4, v8
umlal.8h	v12, v18, v16
umull2.8h	v13, v4, v8
umlal2.8h	v13, v18, v16
umull.8h	v14, v6, v9
umlal.8h	v14, v19, v17
umull2.8h	v20, v6, v9
umlal2.8h	v20, v19, v17
cmge.16b	v18, v21, #0
cmge.16b	v19, v22, #0
rshrn.8b	v12, v12, #6
rshrn2.16b	v12, v13, #6
rshrn.8b	v13, v14, #6
rshrn2.16b	v13, v20, #6
bit.16b	v10, v12, v18
bit.16b	v11, v13, v19
st1.16b	{ v10 }, [x0], #16
subs	w4, w4, #16
st1.16b	{ v11 }, [x13], #16
b.le	ipred_z2_fill1_8bpc_neon
movi.16b	v10, #16
mov.16b	v4, v5
mov.16b	v6, v7
add.16b	v21, v21, v10
add.16b	v22, v22, v10
b	ipred_z2_fill1_8bpc_neon
subs	w5, w5, #2
b.le	ipred_z2_fill1_8bpc_neon
movi.8h	v10, #128
add	x0, x0, x1
add	x13, x13, x1
mov	w4, w12
add.8h	v26, v26, v10
b	ipred_z2_fill1_8bpc_neon
ld1.16b	{ v5 }, [x9], #16
ld1.16b	{ v7 }, [x11], #16
ext.16b	v18, v4, v5, #1
ext.16b	v19, v6, v7, #1
umull.8h	v12, v4, v8
umlal.8h	v12, v18, v16
umull2.8h	v13, v4, v8
umlal2.8h	v13, v18, v16
umull.8h	v14, v6, v9
umlal.8h	v14, v19, v17
umull2.8h	v20, v6, v9
umlal2.8h	v20, v19, v17
rshrn.8b	v12, v12, #6
rshrn2.16b	v12, v13, #6
rshrn.8b	v13, v14, #6
rshrn2.16b	v13, v20, #6
st1.16b	{ v12 }, [x0], #16
subs	w4, w4, #16
st1.16b	{ v13 }, [x13], #16
b.le	ipred_z2_fill1_8bpc_neon
mov.16b	v4, v5
mov.16b	v6, v7
b	ipred_z2_fill1_8bpc_neon
add	x1, x1, w4, uxtw
mov	w12, w5
add.8h	v13, v23, v25
movi.16b	v12, #64
movi.16b	v10, #62
xtn.8b	v27, v23
xtn2.16b	v27, v13
shrn.8b	v29, v23, #6
shrn2.16b	v29, v13, #6
and.16b	v27, v27, v10
mov.16b	v18, v15
add.8h	v23, v13, v25
movi.16b	v21, #1
tbx.16b	v18, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v21
sub.16b	v28, v12, v27
mov.16b	v19, v15
tbx.16b	v19, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v21
mov.16b	v20, v15
tbx.16b	v20, { v0, v1, v2, v3 }, v29
add.16b	v29, v29, v21
umull.8h	v10, v18, v28
umlal.8h	v10, v19, v27
umull2.8h	v11, v18, v28
umlal2.8h	v11, v19, v27
umull.8h	v12, v19, v28
umlal.8h	v12, v20, v27
umull2.8h	v13, v19, v28
umlal2.8h	v13, v20, v27
rshrn.8b	v10, v10, #6
rshrn2.16b	v10, v11, #6
rshrn.8b	v11, v12, #6
rshrn2.16b	v11, v13, #6
st1.16b	{ v10 }, [x0], x1
subs	w5, w5, #2
st1.16b	{ v11 }, [x13], x1
b.le	ipred_z2_fill1_8bpc_neon
mov.16b	v18, v20
b	ipred_z2_fill1_8bpc_neon
subs	w4, w4, #16
b.le	ipred_z2_fill1_8bpc_neon
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #16
add	x13, x13, #16
mov	w5, w12
b	ipred_z2_fill1_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
<unknown>
<unknown>
udf	#1928
_ipred_z2_fill2_8bpc_neon:
cmp	w4, #8
mov	w8, #128
sub	w8, w8, w6
adrp	x11, ipred_z2_fill2_8bpc_neon
add	x11, x11, #0
ld1.8h	{ v31 }, [x11]
neg	w7, w7
b.eq	ipred_z2_fill2_8bpc_neon
dup.4h	v30, w7
movi.8b	v17, #1
mul.4h	v16, v31, v30
movi.16b	v25, #62
add.4h	v30, v16, v30
xtn.8b	v31, v31
ld1.16b	{ v0 }, [x3]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v30
shrn.8b	v29, v30, #6
and.8b	v27, v27, v25
add.8b	v29, v29, v17
add.8b	v30, v29, v17
add.8b	v28, v29, v19
tbl.8b	v16, { v0 }, v29
trn1.2s	v30, v30, v28
sub.8b	v28, v26, v27
trn1.2s	v31, v31, v31
trn1.2s	v27, v27, v27
trn1.2s	v28, v28, v28
movi.8b	v29, #2
add.8b	v31, v31, v31
asr	w9, w8, #6
dup.4h	v6, w8
sub	w8, w8, w6
cmn	w9, #8
asr	w11, w8, #6
b.le	ipred_z2_fill2_8bpc_neon
dup.4h	v7, w8
ldr	d2, [x2, w9, sxtw]
ldr	d4, [x2, w11, sxtw]
trn1.2d	v6, v6, v7
tbl.8b	v17, { v0 }, v30
shrn.8b	v20, v6, #6
xtn.8b	v6, v6
uzp2.8b	v3, v2, v4
uzp1.8b	v2, v2, v4
and.8b	v6, v6, v25
trn1.2s	v16, v16, v17
sub.8b	v7, v26, v6
add.8b	v20, v20, v31
umull.8h	v16, v16, v28
umlal.8h	v16, v17, v27
umull.8h	v22, v2, v7
umlal.8h	v22, v3, v6
cmge.8b	v20, v20, #0
rshrn.8b	v16, v16, #6
rshrn.8b	v22, v22, #6
bit.8b	v16, v22, v20
st1.s	{ v16 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.s	{ v16 }[1], [x0], x1
b.le	ipred_z2_fill2_8bpc_neon
ext.8b	v16, v17, v17, #4
add.8b	v30, v30, v29
b	ipred_z2_fill2_8bpc_neon
tbl.8b	v17, { v0 }, v30
trn1.2s	v16, v16, v17
umull.8h	v18, v16, v28
umlal.8h	v18, v17, v27
rshrn.8b	v18, v18, #6
st1.s	{ v18 }[0], [x0], x1
subs	w5, w5, #2
st1.s	{ v18 }[1], [x0], x1
b.le	ipred_z2_fill2_8bpc_neon
ext.8b	v16, v17, v17, #4
add.8b	v30, v30, v29
b	ipred_z2_fill2_8bpc_neon
ret
dup.8h	v30, w7
movi.8b	v17, #1
mul.8h	v16, v31, v30
movi.16b	v25, #62
add.8h	v30, v16, v30
xtn.8b	v31, v31
ld1.16b	{ v0 }, [x3]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v30
shrn.8b	v29, v30, #6
and.8b	v27, v27, v25
add.8b	v29, v29, v17
tbl.8b	v18, { v0 }, v29
add.8b	v30, v29, v19
add.8b	v29, v29, v17
sub.8b	v28, v26, v27
trn1.2d	v31, v31, v31
movi.8b	v24, #2
add.16b	v31, v31, v31
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #16
asr	w11, w8, #6
b.le	ipred_z2_fill2_8bpc_neon
dup.8h	v17, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
tbl.8b	v19, { v0 }, v29
shrn.8b	v21, v16, #6
shrn2.16b	v21, v17, #6
xtn.8b	v16, v16
xtn2.16b	v16, v17
tbl.8b	v20, { v0 }, v30
uzp2.16b	v5, v4, v6
uzp1.16b	v4, v4, v6
and.16b	v16, v16, v25
sub.16b	v7, v26, v16
add.16b	v21, v21, v31
umull.8h	v6, v18, v28
umlal.8h	v6, v19, v27
umull.8h	v17, v19, v28
umlal.8h	v17, v20, v27
umull.8h	v22, v4, v7
umlal.8h	v22, v5, v16
umull2.8h	v23, v4, v7
umlal2.8h	v23, v5, v16
cmge.16b	v21, v21, #0
rshrn.8b	v6, v6, #6
rshrn2.16b	v6, v17, #6
rshrn.8b	v22, v22, #6
rshrn2.16b	v22, v23, #6
bit.16b	v6, v22, v21
st1.d	{ v6 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.d	{ v6 }[1], [x0], x1
b.le	ipred_z2_fill2_8bpc_neon
mov.8b	v18, v20
add.8b	v29, v29, v24
add.8b	v30, v30, v24
b	ipred_z2_fill2_8bpc_neon
tbl.8b	v19, { v0 }, v29
tbl.8b	v20, { v0 }, v30
umull.8h	v6, v18, v28
umlal.8h	v6, v19, v27
umull.8h	v17, v19, v28
umlal.8h	v17, v20, v27
rshrn.8b	v6, v6, #6
rshrn2.16b	v6, v17, #6
st1.d	{ v6 }[0], [x0], x1
subs	w5, w5, #2
st1.d	{ v6 }[1], [x0], x1
b.le	ipred_z2_fill2_8bpc_neon
mov.8b	v18, v20
add.8b	v29, v29, v24
add.8b	v30, v30, v24
b	ipred_z2_fill2_8bpc_neon
ret
_ipred_z2_fill3_8bpc_neon:
cmp	w4, #8
mov	w8, #64
sub	w8, w8, w6
adrp	x11, ipred_z2_fill3_8bpc_neon
add	x11, x11, #0
ld1.8h	{ v31 }, [x11]
neg	w7, w7
b.eq	ipred_z2_fill3_8bpc_neon
dup.4h	v30, w7
movi.8b	v17, #1
mul.4h	v16, v31, v30
movi.16b	v25, #62
add.4h	v30, v16, v30
xtn.8b	v31, v31
ld1.16b	{ v0, v1 }, [x3]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v30
shrn.8b	v29, v30, #6
and.8b	v27, v27, v25
add.8b	v29, v29, v19
add.8b	v30, v29, v17
add.8b	v28, v29, v19
trn1.2s	v31, v31, v31
add.8b	v24, v30, v19
trn1.2s	v29, v29, v28
trn1.2s	v30, v30, v24
sub.8b	v28, v26, v27
trn1.2s	v27, v27, v27
trn1.2s	v28, v28, v28
movi.8b	v24, #4
asr	w9, w8, #6
dup.4h	v6, w8
sub	w8, w8, w6
cmn	w9, #4
asr	w11, w8, #6
b.le	ipred_z2_fill3_8bpc_neon
dup.4h	v7, w8
ldr	d2, [x2, w9, sxtw]
ldr	d4, [x2, w11, sxtw]
trn1.2d	v6, v6, v7
tbl.8b	v16, { v0, v1 }, v29
tbl.8b	v17, { v0, v1 }, v30
shrn.8b	v20, v6, #6
xtn.8b	v6, v6
ext.8b	v3, v2, v2, #1
ext.8b	v5, v4, v4, #1
and.8b	v6, v6, v25
trn1.2s	v2, v2, v4
trn1.2s	v3, v3, v5
sub.8b	v7, v26, v6
add.8b	v20, v20, v31
umull.8h	v16, v16, v28
umlal.8h	v16, v17, v27
umull.8h	v22, v2, v7
umlal.8h	v22, v3, v6
cmge.8b	v20, v20, #0
rshrn.8b	v16, v16, #6
rshrn.8b	v22, v22, #6
bit.8b	v16, v22, v20
st1.s	{ v16 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.s	{ v16 }[1], [x0], x1
b.le	ipred_z2_fill3_8bpc_neon
add.8b	v29, v29, v24
add.8b	v30, v30, v24
b	ipred_z2_fill3_8bpc_neon
tbl.8b	v16, { v0, v1 }, v29
tbl.8b	v17, { v0, v1 }, v30
umull.8h	v18, v16, v28
umlal.8h	v18, v17, v27
rshrn.8b	v18, v18, #6
st1.s	{ v18 }[0], [x0], x1
subs	w5, w5, #2
st1.s	{ v18 }[1], [x0], x1
b.le	ipred_z2_fill3_8bpc_neon
add.8b	v29, v29, v24
add.8b	v30, v30, v24
b	ipred_z2_fill3_8bpc_neon
ret
dup.8h	v30, w7
movi.8b	v17, #1
mul.8h	v16, v31, v30
movi.16b	v25, #62
add.8h	v30, v16, v30
xtn.8b	v31, v31
ld1.16b	{ v0, v1, v2 }, [x3]
movi.16b	v26, #64
movi.16b	v19, #2
xtn.8b	v27, v30
shrn.8b	v29, v30, #6
and.8b	v27, v27, v25
add.8b	v29, v29, v19
add.8b	v28, v29, v17
add.8b	v30, v29, v19
trn1.2d	v31, v31, v31
add.8b	v24, v28, v19
trn1.2d	v29, v29, v30
trn1.2d	v30, v28, v24
sub.8b	v28, v26, v27
movi.16b	v24, #4
trn1.2d	v27, v27, v27
trn1.2d	v28, v28, v28
asr	w9, w8, #6
dup.8h	v16, w8
sub	w8, w8, w6
cmn	w9, #8
asr	w11, w8, #6
b.le	ipred_z2_fill3_8bpc_neon
dup.8h	v17, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
tbl.16b	v18, { v0, v1, v2 }, v29
tbl.16b	v19, { v0, v1, v2 }, v30
shrn.8b	v21, v16, #6
shrn2.16b	v21, v17, #6
xtn.8b	v16, v16
xtn2.16b	v16, v17
ext.16b	v5, v4, v4, #1
ext.16b	v7, v6, v6, #1
and.16b	v16, v16, v25
trn1.2d	v4, v4, v6
trn1.2d	v5, v5, v7
sub.16b	v7, v26, v16
add.16b	v21, v21, v31
umull.8h	v6, v18, v28
umlal.8h	v6, v19, v27
umull2.8h	v17, v18, v28
umlal2.8h	v17, v19, v27
umull.8h	v22, v4, v7
umlal.8h	v22, v5, v16
umull2.8h	v23, v4, v7
umlal2.8h	v23, v5, v16
cmge.16b	v21, v21, #0
rshrn.8b	v6, v6, #6
rshrn2.16b	v6, v17, #6
rshrn.8b	v22, v22, #6
rshrn2.16b	v22, v23, #6
bit.16b	v6, v22, v21
st1.d	{ v6 }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #2
st1.d	{ v6 }[1], [x0], x1
b.le	ipred_z2_fill3_8bpc_neon
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill3_8bpc_neon
tbl.16b	v18, { v0, v1, v2 }, v29
tbl.16b	v19, { v0, v1, v2 }, v30
umull.8h	v6, v18, v28
umlal.8h	v6, v19, v27
umull2.8h	v17, v18, v28
umlal2.8h	v17, v19, v27
rshrn.8b	v6, v6, #6
rshrn2.16b	v6, v17, #6
st1.d	{ v6 }[0], [x0], x1
subs	w5, w5, #2
st1.d	{ v6 }[1], [x0], x1
b.le	ipred_z2_fill3_8bpc_neon
add.16b	v29, v29, v24
add.16b	v30, v30, v24
b	ipred_z2_fill3_8bpc_neon
ret
_ipred_z3_fill1_8bpc_neon:
cmp	w6, #64
clz	w9, w3
adr	x8, #1044
sub	w9, w9, #25
ldrh	w9, [x8, w9, uxtw #1]
add	x10, x2, w6, uxtw
sub	x8, x8, w9, uxtw
adrp	x11, ipred_z3_fill1_8bpc_neon
add	x11, x11, #0
ld1r.16b	{ v31 }, [x10]
ld1.8h	{ v30 }, [x11]
mov	w7, w5
b.gt	ipred_z3_fill1_8bpc_neon
br	x8
dup.4h	v29, w5
mul.4h	v30, v30, v29
movi.16b	v23, #62
ld1.16b	{ v0, v1 }, [x2]
add.4h	v30, v29, v30
movi.16b	v22, #64
movi.16b	v20, #1
movi.16b	v21, #2
xtn.8b	v24, v30
uqshrn.8b	v26, v30, #6
and.8b	v24, v24, v23
mov.8b	v4, v31
uqadd.8b	v27, v26, v20
uqadd.8b	v28, v26, v21
sub.8b	v25, v22, v24
tbx.8b	v4, { v0, v1 }, v26
trn1.2s	v27, v27, v28
trn1.2s	v24, v24, v24
trn1.2s	v25, v25, v25
mov.8b	v5, v31
tbx.8b	v5, { v0, v1 }, v27
trn1.2s	v4, v4, v5
umull.8h	v16, v4, v25
umlal.8h	v16, v5, v24
rshrn.8b	v16, v16, #6
st1.s	{ v16 }[0], [x0], x1
subs	w4, w4, #2
st1.s	{ v16 }[1], [x0], x1
b.le	ipred_z3_fill1_8bpc_neon
ext.8b	v4, v5, v5, #4
uqadd.8b	v27, v27, v21
b	ipred_z3_fill1_8bpc_neon
ret
dup.8h	v29, w5
mul.8h	v30, v30, v29
movi.16b	v23, #62
ld1.16b	{ v0, v1, v2 }, [x2]
add.8h	v30, v29, v30
movi.16b	v22, #64
movi.16b	v20, #1
movi.16b	v21, #2
xtn.8b	v24, v30
uqshrn.8b	v26, v30, #6
and.8b	v24, v24, v23
mov.8b	v4, v31
uqadd.8b	v27, v26, v20
uqadd.8b	v28, v26, v21
sub.8b	v25, v22, v24
tbx.8b	v4, { v0, v1, v2 }, v26
mov.8b	v5, v31
mov.8b	v6, v31
tbx.8b	v5, { v0, v1, v2 }, v27
tbx.8b	v6, { v0, v1, v2 }, v28
umull.8h	v16, v4, v25
umlal.8h	v16, v5, v24
umull.8h	v17, v5, v25
umlal.8h	v17, v6, v24
rshrn.8b	v16, v16, #6
rshrn.8b	v17, v17, #6
st1.8b	{ v16 }, [x0], x1
subs	w4, w4, #2
st1.8b	{ v17 }, [x0], x1
b.le	ipred_z3_fill1_8bpc_neon
mov.8b	v4, v6
uqadd.8b	v27, v27, v21
uqadd.8b	v28, v28, v21
b	ipred_z3_fill1_8bpc_neon
ret
dup.8h	v28, w5
shl.8h	v29, v28, #3
mul.8h	v30, v30, v28
movi.16b	v23, #62
ld1.16b	{ v0, v1, v2, v3 }, [x2]
add.8h	v28, v28, v30
movi.16b	v22, #64
movi.16b	v20, #1
movi.16b	v21, #2
add.8h	v29, v28, v29
xtn.8b	v24, v28
xtn2.16b	v24, v29
uqshrn.8b	v26, v28, #6
uqshrn2.16b	v26, v29, #6
and.16b	v24, v24, v23
mov.16b	v4, v31
uqadd.16b	v27, v26, v20
uqadd.16b	v28, v26, v21
sub.16b	v25, v22, v24
tbx.16b	v4, { v0, v1, v2, v3 }, v26
mov.16b	v5, v31
mov.16b	v6, v31
tbx.16b	v5, { v0, v1, v2, v3 }, v27
tbx.16b	v6, { v0, v1, v2, v3 }, v28
umull.8h	v16, v4, v25
umlal.8h	v16, v5, v24
umull2.8h	v17, v4, v25
umlal2.8h	v17, v5, v24
umull.8h	v18, v5, v25
umlal.8h	v18, v6, v24
umull2.8h	v19, v5, v25
umlal2.8h	v19, v6, v24
rshrn.8b	v16, v16, #6
rshrn2.16b	v16, v17, #6
rshrn.8b	v17, v18, #6
rshrn2.16b	v17, v19, #6
st1.16b	{ v16 }, [x0], x1
subs	w4, w4, #2
st1.16b	{ v17 }, [x0], x1
b.le	ipred_z3_fill1_8bpc_neon
mov.16b	v4, v6
uqadd.16b	v27, v27, v21
uqadd.16b	v28, v28, v21
b	ipred_z3_fill1_8bpc_neon
ret
dup.8h	v28, w5
mov	w12, w3
add	x13, x0, x1
shl.8h	v29, v28, #3
mul.8h	v30, v30, v28
movi.16b	v23, #62
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw
add.8h	v30, v28, v30
ld1.16b	{ v0, v1, v2, v3 }, [x2]
movi.16b	v22, #64
movi.16b	v20, #1
movi.16b	v21, #2
mov.16b	v26, v30
add.8h	v27, v26, v29
uqshrn.8b	v16, v26, #6
uqshrn2.16b	v16, v27, #6
xtn.8b	v24, v26
xtn2.16b	v24, v27
umov.b	w14, v16[0]
and.16b	v24, v24, v23
uqadd.16b	v17, v16, v20
cmp	w14, w6
uqadd.16b	v18, v16, v21
sub.16b	v25, v22, v24
b.ge	ipred_z3_fill1_8bpc_neon
mov.16b	v4, v31
mov.16b	v5, v31
mov.16b	v6, v31
tbx.16b	v4, { v0, v1, v2, v3 }, v16
tbx.16b	v5, { v0, v1, v2, v3 }, v17
tbx.16b	v6, { v0, v1, v2, v3 }, v18
subs	w3, w3, #16
umull.8h	v16, v4, v25
umlal.8h	v16, v5, v24
umull2.8h	v17, v4, v25
umlal2.8h	v17, v5, v24
umull.8h	v18, v5, v25
umlal.8h	v18, v6, v24
umull2.8h	v19, v5, v25
umlal2.8h	v19, v6, v24
rshrn.8b	v16, v16, #6
rshrn2.16b	v16, v17, #6
rshrn.8b	v17, v18, #6
rshrn2.16b	v17, v19, #6
st1.16b	{ v16 }, [x0], #16
st1.16b	{ v17 }, [x13], #16
b.le	ipred_z3_fill1_8bpc_neon
add.8h	v26, v27, v29
b	ipred_z3_fill1_8bpc_neon
subs	w4, w4, #2
b.le	ipred_z3_fill1_8bpc_neon
movi.8h	v16, #128
add	x0, x0, x1
add	x13, x13, x1
add.8h	v30, v30, v16
mov	w3, w12
b	ipred_z3_fill1_8bpc_neon
subs	w3, w3, #16
st1.16b	{ v31 }, [x0], #16
st1.16b	{ v31 }, [x13], #16
b.gt	ipred_z3_fill1_8bpc_neon
b	ipred_z3_fill1_8bpc_neon
ret
mov	w15, #64
add	x13, x0, x1
lsl	x1, x1, #1
mov	w12, w4
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw
add	x10, x2, w10, uxtw
dup.16b	v4, w9
dup.16b	v5, w11
ld1.16b	{ v0, v1 }, [x8], #32
ld1.16b	{ v2, v3 }, [x10], #32
sub	w9, w15, w9
sub	w11, w15, w11
dup.16b	v6, w9
dup.16b	v7, w11
add	w7, w7, w5
ext.16b	v16, v0, v1, #1
ext.16b	v17, v2, v3, #1
subs	w4, w4, #16
umull.8h	v18, v16, v4
umlal.8h	v18, v0, v6
umull2.8h	v19, v16, v4
umlal2.8h	v19, v0, v6
umull.8h	v20, v17, v5
umlal.8h	v20, v2, v7
umull2.8h	v21, v17, v5
umlal2.8h	v21, v2, v7
rshrn.8b	v16, v18, #6
rshrn2.16b	v16, v19, #6
rshrn.8b	v17, v20, #6
rshrn2.16b	v17, v21, #6
zip1.16b	v18, v16, v17
zip2.16b	v19, v16, v17
st1.h	{ v18 }[0], [x0], x1
st1.h	{ v18 }[1], [x13], x1
st1.h	{ v18 }[2], [x0], x1
st1.h	{ v18 }[3], [x13], x1
st1.h	{ v18 }[4], [x0], x1
st1.h	{ v18 }[5], [x13], x1
st1.h	{ v18 }[6], [x0], x1
st1.h	{ v18 }[7], [x13], x1
st1.h	{ v19 }[0], [x0], x1
st1.h	{ v19 }[1], [x13], x1
st1.h	{ v19 }[2], [x0], x1
st1.h	{ v19 }[3], [x13], x1
st1.h	{ v19 }[4], [x0], x1
st1.h	{ v19 }[5], [x13], x1
st1.h	{ v19 }[6], [x0], x1
st1.h	{ v19 }[7], [x13], x1
b.le	ipred_z3_fill1_8bpc_neon
mov.16b	v0, v1
ld1.16b	{ v1 }, [x8], #16
mov.16b	v2, v3
ld1.16b	{ v3 }, [x10], #16
b	ipred_z3_fill1_8bpc_neon
subs	w3, w3, #2
b.le	ipred_z3_fill1_8bpc_neon
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #2
add	x13, x13, #2
mov	w4, w12
b	ipred_z3_fill1_8bpc_neon
ret
<unknown>
<unknown>
udf	#996
_ipred_z3_fill_padding_neon:
cmp	w3, #16
adr	x8, #292
b.gt	ipred_z3_fill_padding_neon
mov	w12, w4
clz	w9, w3
sub	w9, w9, #25
ldrh	w9, [x8, w9, uxtw #1]
sub	x9, x8, w9, uxtw
br	x9
st1.h	{ v31 }[0], [x0], x1
subs	w4, w4, #4
st1.h	{ v31 }[0], [x13], x1
st1.h	{ v31 }[0], [x0], x1
st1.h	{ v31 }[0], [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #2
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	ipred_z3_fill_padding_neon
lsl	x1, x1, #1
add	x0, x0, #2
add	x13, x13, #2
mov	w4, w12
b	ipred_z3_fill_padding_neon
st1.s	{ v31 }[0], [x0], x1
subs	w4, w4, #4
st1.s	{ v31 }[0], [x13], x1
st1.s	{ v31 }[0], [x0], x1
st1.s	{ v31 }[0], [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #4
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	ipred_z3_fill_padding_neon
lsl	x1, x1, #1
add	x0, x0, #4
add	x13, x13, #4
mov	w4, w12
b	ipred_z3_fill_padding_neon
st1.8b	{ v31 }, [x0], x1
subs	w4, w4, #4
st1.8b	{ v31 }, [x13], x1
st1.8b	{ v31 }, [x0], x1
st1.8b	{ v31 }, [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #8
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	ipred_z3_fill_padding_neon
lsl	x1, x1, #1
add	x0, x0, #8
add	x13, x13, #8
mov	w4, w12
b	ipred_z3_fill_padding_neon
st1.16b	{ v31 }, [x0], x1
subs	w4, w4, #4
st1.16b	{ v31 }, [x13], x1
st1.16b	{ v31 }, [x0], x1
st1.16b	{ v31 }, [x13], x1
b.gt	ipred_z3_fill_padding_neon
subs	w3, w3, #16
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
sub	x1, x1, w3, uxtw
ands	w5, w3, #0xf
b.eq	ipred_z3_fill_padding_neon
sub	w3, w3, w5
st1.16b	{ v31 }, [x0]
add	x0, x0, w5, uxtw
subs	w3, w3, #16
st1.16b	{ v31 }, [x0], #16
b.gt	ipred_z3_fill_padding_neon
subs	w4, w4, #1
add	x0, x0, x1
b.le	ipred_z3_fill_padding_neon
mov	w3, w12
b	ipred_z3_fill_padding_neon
ret
_ipred_z3_fill2_8bpc_neon:
cmp	w3, #8
add	x10, x2, w6, uxtw
adrp	x11, ipred_z3_fill2_8bpc_neon
add	x11, x11, #0
ld1r.16b	{ v31 }, [x10]
ld1.8h	{ v30 }, [x11]
b.eq	ipred_z3_fill2_8bpc_neon
dup.4h	v29, w5
mul.4h	v30, v30, v29
movi.16b	v23, #62
ld1.16b	{ v0, v1 }, [x2]
add.4h	v30, v29, v30
movi.16b	v22, #64
movi.16b	v20, #1
movi.16b	v21, #2
xtn.8b	v24, v30
uqshrn.8b	v26, v30, #6
and.8b	v24, v24, v23
uqadd.8b	v27, v26, v20
uqadd.8b	v28, v26, v21
sub.8b	v25, v22, v24
uqadd.8b	v29, v27, v21
trn1.2s	v24, v24, v24
trn1.2s	v26, v26, v28
trn1.2s	v27, v27, v29
trn1.2s	v25, v25, v25
movi.16b	v21, #4
mov.8b	v4, v31
mov.8b	v5, v31
tbx.8b	v4, { v0, v1 }, v26
tbx.8b	v5, { v0, v1 }, v27
umull.8h	v16, v4, v25
umlal.8h	v16, v5, v24
rshrn.8b	v16, v16, #6
st1.s	{ v16 }[0], [x0], x1
subs	w4, w4, #2
st1.s	{ v16 }[1], [x0], x1
b.le	ipred_z3_fill2_8bpc_neon
uqadd.8b	v26, v26, v21
uqadd.8b	v27, v27, v21
b	ipred_z3_fill2_8bpc_neon
ret
dup.8h	v29, w5
mul.8h	v30, v30, v29
movi.16b	v23, #62
ld1.16b	{ v0, v1 }, [x2]
add.8h	v30, v29, v30
movi.16b	v22, #64
movi.16b	v20, #1
movi.16b	v21, #2
xtn.8b	v24, v30
uqshrn.8b	v26, v30, #6
and.8b	v24, v24, v23
uqadd.8b	v27, v26, v20
uqadd.8b	v28, v26, v21
sub.8b	v25, v22, v24
uqadd.8b	v29, v27, v21
trn1.2d	v24, v24, v24
trn1.2d	v26, v26, v28
trn1.2d	v27, v27, v29
trn1.2d	v25, v25, v25
movi.16b	v21, #4
mov.16b	v4, v31
mov.16b	v5, v31
tbx.16b	v4, { v0, v1, v2, v3 }, v26
tbx.16b	v5, { v0, v1, v2, v3 }, v27
umull.8h	v16, v4, v25
umlal.8h	v16, v5, v24
umull2.8h	v17, v4, v25
umlal2.8h	v17, v5, v24
rshrn.8b	v16, v16, #6
rshrn.8b	v17, v17, #6
st1.8b	{ v16 }, [x0], x1
subs	w4, w4, #2
st1.8b	{ v17 }, [x0], x1
b.le	ipred_z3_fill2_8bpc_neon
uqadd.16b	v26, v26, v21
uqadd.16b	v27, v27, v21
b	ipred_z3_fill2_8bpc_neon
ret
_ipred_filter_8bpc_neon:
and	w5, w5, #0x1ff
adrp	x6, ipred_filter_8bpc_neon
add	x6, x6, #0
lsl	w5, w5, #6
add	x6, x6, w5, uxtw
ld1.8b	{ v16, v17, v18, v19 }, [x6], #32
clz	w9, w3
adr	x5, #508
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
br	x5
ldur	s0, [x2, #1]
sub	x2, x2, #2
mov	x7, #-2
ushll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x7
mul.8h	v2, v17, v0[0]
mla.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
ushll.8h	v1, v1, #0
mla.8h	v2, v20, v0[3]
mla.8h	v2, v16, v1[2]
mla.8h	v2, v21, v1[1]
mla.8h	v2, v22, v1[0]
sqrshrun.8b	v2, v2, #4
subs	w4, w4, #2
st1.s	{ v2 }[0], [x0], x1
ushll.8h	v0, v2, #0
st1.s	{ v2 }[1], [x6], x1
ext.16b	v0, v0, v0, #8
b.gt	ipred_filter_8bpc_neon
ret
ldur	d0, [x2, #1]
sub	x2, x2, #2
mov	x7, #-2
ushll.8h	v0, v0, #0
ld1.s	{ v1 }[0], [x2], x7
mul.8h	v2, v17, v0[0]
mla.8h	v2, v18, v0[1]
mla.8h	v2, v19, v0[2]
ushll.8h	v1, v1, #0
mla.8h	v2, v20, v0[3]
mla.8h	v2, v16, v1[2]
mla.8h	v2, v21, v1[1]
mla.8h	v2, v22, v1[0]
mul.8h	v3, v17, v0[4]
mla.8h	v3, v18, v0[5]
mla.8h	v3, v19, v0[6]
sqrshrun.8b	v2, v2, #4
ushll.8h	v1, v2, #0
mla.8h	v3, v20, v0[7]
mla.8h	v3, v16, v0[3]
mla.8h	v3, v21, v1[3]
mla.8h	v3, v22, v1[7]
sqrshrun.8b	v3, v3, #4
subs	w4, w4, #2
st2.s	{ v2, v3 }[0], [x0], x1
zip2.2s	v0, v2, v3
st2.s	{ v2, v3 }[1], [x6], x1
ushll.8h	v0, v0, #0
b.gt	ipred_filter_8bpc_neon
ret
add	x8, x2, #1
sub	x2, x2, #2
mov	x7, #-2
sub	x1, x1, w3, uxtw
mov	w9, w3
ld1.s	{ v0 }[0], [x2], x7
ushll.8h	v0, v0, #0
ld1.16b	{ v2 }, [x8], #16
mul.8h	v3, v16, v0[2]
mla.8h	v3, v21, v0[1]
ushll.8h	v1, v2, #0
ushll2.8h	v2, v2, #0
mla.8h	v3, v22, v0[0]
mla.8h	v3, v17, v1[0]
mla.8h	v3, v18, v1[1]
mla.8h	v3, v19, v1[2]
mla.8h	v3, v20, v1[3]
mul.8h	v4, v17, v1[4]
mla.8h	v4, v18, v1[5]
mla.8h	v4, v19, v1[6]
sqrshrun.8b	v3, v3, #4
ushll.8h	v0, v3, #0
mla.8h	v4, v20, v1[7]
mla.8h	v4, v16, v1[3]
mla.8h	v4, v21, v0[3]
mla.8h	v4, v22, v0[7]
mul.8h	v5, v17, v2[0]
mla.8h	v5, v18, v2[1]
mla.8h	v5, v19, v2[2]
sqrshrun.8b	v4, v4, #4
ushll.8h	v0, v4, #0
mla.8h	v5, v20, v2[3]
mla.8h	v5, v16, v1[7]
mla.8h	v5, v21, v0[3]
mla.8h	v5, v22, v0[7]
mul.8h	v6, v17, v2[4]
mla.8h	v6, v18, v2[5]
mla.8h	v6, v19, v2[6]
sqrshrun.8b	v5, v5, #4
ushll.8h	v0, v5, #0
mla.8h	v6, v20, v2[7]
mla.8h	v6, v16, v2[3]
mla.8h	v6, v21, v0[3]
mla.8h	v6, v22, v0[7]
subs	w3, w3, #16
sqrshrun.8b	v6, v6, #4
st4.s	{ v3, v4, v5, v6 }[0], [x0], #16
st4.s	{ v3, v4, v5, v6 }[1], [x6], #16
b.le	ipred_filter_8bpc_neon
mov.h	v0[2], v2[7]
mov.b	v0[0], v6[7]
mov.b	v0[2], v6[3]
b	ipred_filter_8bpc_neon
subs	w4, w4, #2
b.le	ipred_filter_8bpc_neon
sub	x8, x6, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	ipred_filter_8bpc_neon
ret
<unknown>
<unknown>
_pal_pred_8bpc_neon:
ld1.8b	{ v0 }, [x2]
clz	w9, w4
adr	x6, #464
sub	w9, w9, #25
movi.16b	v31, #7
ldrh	w9, [x6, w9, uxtw #1]
sub	x6, x6, w9, uxtw
add	x2, x0, x1
lsl	x1, x1, #1
br	x6
ld1.8b	{ v1 }, [x3], #8
subs	w5, w5, #4
ushr.8b	v3, v1, #4
and.8b	v2, v1, v31
zip1.16b	v1, v2, v3
tbl.16b	v1, { v0 }, v1
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x2], x1
st1.s	{ v1 }[2], [x0], x1
st1.s	{ v1 }[3], [x2], x1
b.gt	pal_pred_8bpc_neon
ret
ld1.16b	{ v1 }, [x3], #16
subs	w5, w5, #4
ushr.16b	v4, v1, #4
and.16b	v3, v1, v31
zip1.16b	v1, v3, v4
zip2.16b	v2, v3, v4
tbl.16b	v1, { v0 }, v1
st1.d	{ v1 }[0], [x0], x1
tbl.16b	v2, { v0 }, v2
st1.d	{ v1 }[1], [x2], x1
st1.d	{ v2 }[0], [x0], x1
st1.d	{ v2 }[1], [x2], x1
b.gt	pal_pred_8bpc_neon
ret
ld1.16b	{ v1, v2 }, [x3], #32
subs	w5, w5, #4
ushr.16b	v5, v1, #4
and.16b	v4, v1, v31
ushr.16b	v7, v2, #4
and.16b	v6, v2, v31
zip1.16b	v1, v4, v5
zip2.16b	v2, v4, v5
zip1.16b	v3, v6, v7
tbl.16b	v1, { v0 }, v1
zip2.16b	v4, v6, v7
tbl.16b	v2, { v0 }, v2
st1.16b	{ v1 }, [x0], x1
tbl.16b	v3, { v0 }, v3
st1.16b	{ v2 }, [x2], x1
tbl.16b	v4, { v0 }, v4
st1.16b	{ v3 }, [x0], x1
st1.16b	{ v4 }, [x2], x1
b.gt	pal_pred_8bpc_neon
ret
ld1.16b	{ v16, v17, v18, v19 }, [x3], #64
subs	w5, w5, #4
ushr.16b	v21, v16, #4
and.16b	v20, v16, v31
ushr.16b	v23, v17, #4
and.16b	v22, v17, v31
ushr.16b	v25, v18, #4
and.16b	v24, v18, v31
ushr.16b	v27, v19, #4
and.16b	v26, v19, v31
zip1.16b	v16, v20, v21
zip2.16b	v17, v20, v21
zip1.16b	v18, v22, v23
zip2.16b	v19, v22, v23
zip1.16b	v20, v24, v25
zip2.16b	v21, v24, v25
tbl.16b	v16, { v0 }, v16
zip1.16b	v22, v26, v27
tbl.16b	v17, { v0 }, v17
zip2.16b	v23, v26, v27
tbl.16b	v18, { v0 }, v18
tbl.16b	v19, { v0 }, v19
tbl.16b	v20, { v0 }, v20
st1.16b	{ v16, v17 }, [x0], x1
tbl.16b	v21, { v0 }, v21
st1.16b	{ v18, v19 }, [x2], x1
tbl.16b	v22, { v0 }, v22
st1.16b	{ v20, v21 }, [x0], x1
tbl.16b	v23, { v0 }, v23
st1.16b	{ v22, v23 }, [x2], x1
b.gt	pal_pred_8bpc_neon
ret
ld1.16b	{ v16, v17, v18, v19 }, [x3], #64
subs	w5, w5, #2
ushr.16b	v21, v16, #4
and.16b	v20, v16, v31
ushr.16b	v23, v17, #4
and.16b	v22, v17, v31
ushr.16b	v25, v18, #4
and.16b	v24, v18, v31
ushr.16b	v27, v19, #4
and.16b	v26, v19, v31
zip1.16b	v16, v20, v21
zip2.16b	v17, v20, v21
zip1.16b	v18, v22, v23
zip2.16b	v19, v22, v23
zip1.16b	v20, v24, v25
zip2.16b	v21, v24, v25
tbl.16b	v16, { v0 }, v16
zip1.16b	v22, v26, v27
tbl.16b	v17, { v0 }, v17
zip2.16b	v23, v26, v27
tbl.16b	v18, { v0 }, v18
tbl.16b	v19, { v0 }, v19
st1.16b	{ v16, v17, v18, v19 }, [x0], x1
tbl.16b	v20, { v0 }, v20
tbl.16b	v21, { v0 }, v21
tbl.16b	v22, { v0 }, v22
tbl.16b	v23, { v0 }, v23
st1.16b	{ v20, v21, v22, v23 }, [x2], x1
b.gt	pal_pred_8bpc_neon
ret
<unknown>
<unknown>
udf	#432
_ipred_cfl_128_8bpc_neon:
clz	w9, w3
adr	x7, #408
sub	w9, w9, #26
ldrh	w9, [x7, w9, uxtw #1]
movi.8h	v0, #128
dup.8h	v1, w6
sub	x7, x7, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
ld1.8h	{ v2, v3 }, [x5], #32
mul.8h	v2, v2, v1
mul.8h	v3, v3, v1
cmlt.8h	v4, v2, #0
cmlt.8h	v5, v3, #0
add.8h	v2, v2, v4
add.8h	v3, v3, v5
srshr.8h	v2, v2, #6
srshr.8h	v3, v3, #6
add.8h	v2, v2, v0
add.8h	v3, v3, v0
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
st1.s	{ v2 }[0], [x0], x1
st1.s	{ v2 }[1], [x6], x1
subs	w4, w4, #4
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v3 }[1], [x6], x1
b.gt	ipred_cfl_128_8bpc_neon
ret
ld1.8h	{ v2, v3, v4, v5 }, [x5], #64
mul.8h	v2, v2, v1
mul.8h	v3, v3, v1
mul.8h	v4, v4, v1
mul.8h	v5, v5, v1
cmlt.8h	v16, v2, #0
cmlt.8h	v17, v3, #0
cmlt.8h	v18, v4, #0
cmlt.8h	v19, v5, #0
add.8h	v2, v2, v16
add.8h	v3, v3, v17
add.8h	v4, v4, v18
add.8h	v5, v5, v19
srshr.8h	v2, v2, #6
srshr.8h	v3, v3, #6
srshr.8h	v4, v4, #6
srshr.8h	v5, v5, #6
add.8h	v2, v2, v0
add.8h	v3, v3, v0
add.8h	v4, v4, v0
add.8h	v5, v5, v0
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
sqxtun.8b	v4, v4
sqxtun.8b	v5, v5
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x6], x1
subs	w4, w4, #4
st1.8b	{ v4 }, [x0], x1
st1.8b	{ v5 }, [x6], x1
b.gt	ipred_cfl_128_8bpc_neon
ret
add	x7, x5, w3, uxtw #1
sub	x1, x1, w3, uxtw
mov	w9, w3
ld1.8h	{ v2, v3 }, [x5], #32
ld1.8h	{ v4, v5 }, [x7], #32
mul.8h	v2, v2, v1
mul.8h	v3, v3, v1
mul.8h	v4, v4, v1
mul.8h	v5, v5, v1
cmlt.8h	v16, v2, #0
cmlt.8h	v17, v3, #0
cmlt.8h	v18, v4, #0
cmlt.8h	v19, v5, #0
add.8h	v2, v2, v16
add.8h	v3, v3, v17
add.8h	v4, v4, v18
add.8h	v5, v5, v19
srshr.8h	v2, v2, #6
srshr.8h	v3, v3, #6
srshr.8h	v4, v4, #6
srshr.8h	v5, v5, #6
add.8h	v2, v2, v0
add.8h	v3, v3, v0
add.8h	v4, v4, v0
add.8h	v5, v5, v0
sqxtun.8b	v2, v2
sqxtun.8b	v3, v3
sqxtun.8b	v4, v4
sqxtun.8b	v5, v5
subs	w3, w3, #16
st1.8b	{ v2, v3 }, [x0], #16
st1.8b	{ v4, v5 }, [x6], #16
b.gt	ipred_cfl_128_8bpc_neon
subs	w4, w4, #2
add	x5, x5, w9, uxtw #1
add	x7, x7, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b.gt	ipred_cfl_128_8bpc_neon
ret
<unknown>
<unknown>
_ipred_cfl_top_8bpc_neon:
clz	w9, w3
adr	x7, #124
sub	w9, w9, #26
ldrh	w9, [x7, w9, uxtw #1]
dup.8h	v1, w6
add	x2, x2, #1
sub	x7, x7, w9, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
ld1r.2s	{ v0 }, [x2]
uaddlv.8b	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
ld1.8b	{ v0 }, [x2]
uaddlv.8b	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
ld1.16b	{ v0 }, [x2]
uaddlv.16b	h0, v0
urshr.4h	v0, v0, #4
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
ld1.16b	{ v2, v3 }, [x2]
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
add.4h	v2, v2, v3
urshr.4h	v2, v2, #5
dup.8h	v0, v2[0]
b	ipred_cfl_128_8bpc_neon
<unknown>
<unknown>
_ipred_cfl_left_8bpc_neon:
sub	x2, x2, w4, uxtw
clz	w9, w3
clz	w8, w4
adr	x10, #-156
adr	x7, #132
sub	w9, w9, #26
sub	w8, w8, #26
ldrh	w9, [x10, w9, uxtw #1]
ldrh	w8, [x7, w8, uxtw #1]
dup.8h	v1, w6
sub	x9, x10, w9, uxtw
sub	x7, x7, w8, uxtw
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
ld1r.2s	{ v0 }, [x2]
uaddlv.8b	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
br	x9
ld1.8b	{ v0 }, [x2]
uaddlv.8b	h0, v0
urshr.4h	v0, v0, #3
dup.8h	v0, v0[0]
br	x9
ld1.16b	{ v0 }, [x2]
uaddlv.16b	h0, v0
urshr.4h	v0, v0, #4
dup.8h	v0, v0[0]
br	x9
ld1.16b	{ v2, v3 }, [x2]
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
add.4h	v2, v2, v3
urshr.4h	v2, v2, #5
dup.8h	v0, v2[0]
br	x9
<unknown>
<unknown>
_ipred_cfl_8bpc_neon:
sub	x2, x2, w4, uxtw
add	w8, w3, w4
dup.8h	v1, w6
clz	w9, w3
clz	w6, w4
dup.8h	v16, w8
adr	x7, #388
rbit	w8, w8
sub	w9, w9, #22
sub	w6, w6, #26
clz	w8, w8
ldrh	w9, [x7, w9, uxtw #1]
ldrh	w6, [x7, w6, uxtw #1]
neg	w8, w8
sub	x9, x7, w9, uxtw
sub	x7, x7, w6, uxtw
ushr.8h	v16, v16, #1
dup.8h	v17, w8
add	x6, x0, x1
lsl	x1, x1, #1
br	x7
ld1.s	{ v0 }[0], [x2], #4
mov.s	v0[1], wzr
add	x2, x2, #1
uaddlv.8b	h0, v0
br	x9
ld1.s	{ v2 }[0], [x2]
mov.s	v2[1], wzr
add.4h	v0, v0, v16
uaddlv.8b	h2, v2
cmp	w4, #4
add.4h	v0, v0, v2
ushl.4h	v0, v0, v17
b.eq	ipred_cfl_8bpc_neon
mov	w16, #6554
movk	w16, #10923, lsl #16
add	w17, w4, w4
lsr	w16, w16, w17
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
ld1.8b	{ v0 }, [x2], #8
uaddlv.8b	h0, v0
add	x2, x2, #1
br	x9
ld1.8b	{ v2 }, [x2]
add.4h	v0, v0, v16
uaddlv.8b	h2, v2
cmp	w4, #8
add.4h	v0, v0, v2
ushl.4h	v0, v0, v17
b.eq	ipred_cfl_8bpc_neon
cmp	w4, #32
mov	w16, #6554
mov	w17, #10923
csel	w16, w16, w17, eq
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
ld1.16b	{ v0 }, [x2], #16
uaddlv.16b	h0, v0
add	x2, x2, #1
br	x9
ld1.16b	{ v2 }, [x2]
add.4h	v0, v0, v16
uaddlv.16b	h2, v2
cmp	w4, #16
add.4h	v0, v0, v2
ushl.4h	v0, v0, v17
b.eq	ipred_cfl_8bpc_neon
cmp	w4, #4
mov	w16, #6554
mov	w17, #10923
csel	w16, w16, w17, eq
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
ld1.16b	{ v2, v3 }, [x2], #32
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
add	x2, x2, #1
add.4h	v0, v2, v3
br	x9
ld1.16b	{ v2, v3 }, [x2]
add.4h	v0, v0, v16
uaddlv.16b	h2, v2
uaddlv.16b	h3, v3
cmp	w4, #32
add.4h	v0, v0, v2
add.4h	v0, v0, v3
ushl.4h	v0, v0, v17
b.eq	ipred_cfl_8bpc_neon
mov	w16, #10923
movk	w16, #6554, lsl #16
add	w17, w4, w4
lsr	w16, w16, w17
dup.4h	v16, w16
sqdmulh.4h	v0, v0, v16
dup.8h	v0, v0[0]
b	ipred_cfl_128_8bpc_neon
<unknown>
<unknown>
<unknown>
<unknown>
_ipred_cfl_ac_420_8bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adr	x7, #1016
sub	w8, w8, #27
ldrh	w8, [x7, w8, uxtw #1]
movi.8h	v16, #0
movi.8h	v17, #0
movi.8h	v18, #0
movi.8h	v19, #0
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
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v1 }, [x10], x2
ld1.d	{ v0 }[1], [x1], x2
ld1.d	{ v1 }[1], [x10], x2
uaddlp.8h	v0, v0
uaddlp.8h	v1, v1
add.8h	v0, v0, v1
shl.8h	v0, v0, #1
subs	w8, w8, #2
st1.8h	{ v0 }, [x0], #16
add.8h	v16, v16, v0
b.gt	ipred_cfl_ac_420_8bpc_neon
trn2.2d	v1, v0, v0
trn2.2d	v0, v0, v0
cbz	w4, ipred_cfl_ac_420_8bpc_neon
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], #32
add.8h	v16, v16, v0
add.8h	v17, v17, v1
b.gt	ipred_cfl_ac_420_8bpc_neon
add.8h	v0, v16, v17
uaddlv.8h	s0, v0
sub	x0, x0, w6, uxtw #3
urshl.2s	v4, v0, v31
dup.8h	v4, v4[0]
ld1.8h	{ v0, v1 }, [x0]
subs	w6, w6, #4
sub.8h	v0, v0, v4
sub.8h	v1, v1, v4
st1.8h	{ v0, v1 }, [x0], #32
b.gt	ipred_cfl_ac_420_8bpc_neon
ret
cbnz	w3, ipred_cfl_ac_420_8bpc_neon
ld1.16b	{ v0 }, [x1], x2
ld1.16b	{ v1 }, [x10], x2
ld1.16b	{ v2 }, [x1], x2
uaddlp.8h	v0, v0
ld1.16b	{ v3 }, [x10], x2
uaddlp.8h	v1, v1
uaddlp.8h	v2, v2
uaddlp.8h	v3, v3
add.8h	v0, v0, v1
add.8h	v2, v2, v3
shl.8h	v0, v0, #1
shl.8h	v1, v2, #1
subs	w8, w8, #2
st1.8h	{ v0, v1 }, [x0], #32
add.8h	v16, v16, v0
add.8h	v17, v17, v1
b.gt	ipred_cfl_ac_420_8bpc_neon
mov.16b	v0, v1
b	ipred_cfl_ac_420_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v1 }, [x10], x2
ld1.d	{ v0 }[1], [x1], x2
ld1.d	{ v1 }[1], [x10], x2
uaddlp.8h	v0, v0
uaddlp.8h	v1, v1
add.8h	v0, v0, v1
shl.8h	v0, v0, #1
dup.4h	v1, v0[3]
dup.4h	v3, v0[7]
trn2.2d	v2, v0, v0
subs	w8, w8, #2
st1.4h	{ v0, v1, v2, v3 }, [x0], #32
add.4h	v16, v16, v0
add.4h	v17, v17, v1
add.4h	v18, v18, v2
add.4h	v19, v19, v3
b.gt	ipred_cfl_ac_420_8bpc_neon
trn1.2d	v0, v2, v3
trn1.2d	v1, v2, v3
cbz	w4, ipred_cfl_ac_420_8bpc_neon
subs	w4, w4, #4
st1.8h	{ v0, v1 }, [x0], #32
add.8h	v16, v16, v0
add.8h	v17, v17, v1
st1.8h	{ v0, v1 }, [x0], #32
add.8h	v18, v18, v0
add.8h	v19, v19, v1
b.gt	ipred_cfl_ac_420_8bpc_neon
add.8h	v0, v16, v17
add.8h	v2, v18, v19
uaddlp.4s	v0, v0
uaddlp.4s	v2, v2
add.4s	v0, v0, v2
addv.4s	s0, v0
sub	x0, x0, w6, uxtw #4
urshl.2s	v4, v0, v31
dup.8h	v4, v4[0]
ld1.8h	{ v0, v1, v2, v3 }, [x0]
subs	w6, w6, #4
sub.8h	v0, v0, v4
sub.8h	v1, v1, v4
sub.8h	v2, v2, v4
sub.8h	v3, v3, v4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
b.gt	ipred_cfl_ac_420_8bpc_neon
ret
adr	x7, #552
ldrh	w3, [x7, w3, uxtw #1]
sub	x7, x7, w3, uxtw
br	x7
ld1.16b	{ v0, v1 }, [x1], x2
ld1.16b	{ v2, v3 }, [x10], x2
uaddlp.8h	v0, v0
ld1.16b	{ v4, v5 }, [x1], x2
uaddlp.8h	v1, v1
ld1.16b	{ v6, v7 }, [x10], x2
uaddlp.8h	v2, v2
uaddlp.8h	v3, v3
uaddlp.8h	v4, v4
uaddlp.8h	v5, v5
uaddlp.8h	v6, v6
uaddlp.8h	v7, v7
add.8h	v0, v0, v2
add.8h	v1, v1, v3
add.8h	v4, v4, v6
add.8h	v5, v5, v7
shl.8h	v0, v0, #1
shl.8h	v1, v1, #1
shl.8h	v2, v4, #1
shl.8h	v3, v5, #1
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_420_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ldr	d1, [x1, #16]
ld1.16b	{ v0 }, [x1], x2
ldr	d3, [x10, #16]
ld1.16b	{ v2 }, [x10], x2
uaddlp.4h	v1, v1
ldr	d5, [x1, #16]
uaddlp.8h	v0, v0
ld1.16b	{ v4 }, [x1], x2
uaddlp.4h	v3, v3
ldr	d7, [x10, #16]
uaddlp.8h	v2, v2
ld1.16b	{ v6 }, [x10], x2
uaddlp.4h	v5, v5
uaddlp.8h	v4, v4
uaddlp.4h	v7, v7
uaddlp.8h	v6, v6
add.4h	v1, v1, v3
add.8h	v0, v0, v2
add.4h	v5, v5, v7
add.8h	v4, v4, v6
shl.4h	v1, v1, #1
shl.8h	v0, v0, #1
shl.4h	v3, v5, #1
shl.8h	v2, v4, #1
dup.4h	v4, v1[3]
dup.4h	v5, v3[3]
trn1.2d	v1, v1, v4
trn1.2d	v3, v3, v5
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_420_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ld1.16b	{ v0 }, [x1], x2
ld1.16b	{ v2 }, [x10], x2
ld1.16b	{ v4 }, [x1], x2
uaddlp.8h	v0, v0
ld1.16b	{ v6 }, [x10], x2
uaddlp.8h	v2, v2
uaddlp.8h	v4, v4
uaddlp.8h	v6, v6
add.8h	v0, v0, v2
add.8h	v4, v4, v6
shl.8h	v0, v0, #1
shl.8h	v2, v4, #1
dup.8h	v1, v0[7]
dup.8h	v3, v2[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_420_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v2 }, [x10], x2
ld1.8b	{ v4 }, [x1], x2
uaddlp.4h	v0, v0
ld1.8b	{ v6 }, [x10], x2
uaddlp.4h	v2, v2
uaddlp.4h	v4, v4
uaddlp.4h	v6, v6
add.4h	v0, v0, v2
add.4h	v4, v4, v6
shl.4h	v0, v0, #1
shl.4h	v2, v4, #1
dup.8h	v1, v0[3]
dup.8h	v3, v2[3]
trn1.2d	v0, v0, v1
trn1.2d	v2, v2, v3
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_420_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
cbz	w4, ipred_cfl_ac_420_8bpc_neon
subs	w4, w4, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_420_8bpc_neon
lsl	w6, w6, #1
b	ipred_cfl_ac_420_8bpc_neon
<unknown>
udf	#940
<unknown>
<unknown>
_ipred_cfl_ac_422_8bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adr	x7, #688
sub	w8, w8, #27
ldrh	w8, [x7, w8, uxtw #1]
movi.8h	v16, #0
movi.8h	v17, #0
movi.8h	v18, #0
movi.8h	v19, #0
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
ld1.8b	{ v0 }, [x1], x2
ld1.d	{ v0 }[1], [x10], x2
ld1.8b	{ v1 }, [x1], x2
ld1.d	{ v1 }[1], [x10], x2
uaddlp.8h	v0, v0
uaddlp.8h	v1, v1
shl.8h	v0, v0, #2
shl.8h	v1, v1, #2
subs	w8, w8, #4
add.8h	v16, v16, v0
add.8h	v17, v17, v1
st1.8h	{ v0, v1 }, [x0], #32
b.gt	ipred_cfl_ac_422_8bpc_neon
trn2.2d	v0, v1, v1
trn2.2d	v1, v1, v1
b	ipred_cfl_ac_420_8bpc_neon
cbnz	w3, ipred_cfl_ac_422_8bpc_neon
ld1.16b	{ v0 }, [x1], x2
ld1.16b	{ v1 }, [x10], x2
ld1.16b	{ v2 }, [x1], x2
uaddlp.8h	v0, v0
ld1.16b	{ v3 }, [x10], x2
uaddlp.8h	v1, v1
uaddlp.8h	v2, v2
uaddlp.8h	v3, v3
shl.8h	v0, v0, #2
shl.8h	v1, v1, #2
shl.8h	v2, v2, #2
shl.8h	v3, v3, #2
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_422_8bpc_neon
mov.16b	v0, v3
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.d	{ v0 }[1], [x10], x2
ld1.8b	{ v2 }, [x1], x2
ld1.d	{ v2 }[1], [x10], x2
uaddlp.8h	v0, v0
uaddlp.8h	v2, v2
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
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_422_8bpc_neon
mov.16b	v0, v3
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
adr	x7, #360
ldrh	w3, [x7, w3, uxtw #1]
sub	x7, x7, w3, uxtw
br	x7
ld1.16b	{ v0, v1 }, [x1], x2
ld1.16b	{ v2, v3 }, [x10], x2
uaddlp.8h	v0, v0
uaddlp.8h	v1, v1
uaddlp.8h	v2, v2
uaddlp.8h	v3, v3
shl.8h	v0, v0, #2
shl.8h	v1, v1, #2
shl.8h	v2, v2, #2
shl.8h	v3, v3, #2
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_422_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ldr	d1, [x1, #16]
ld1.16b	{ v0 }, [x1], x2
ldr	d3, [x10, #16]
ld1.16b	{ v2 }, [x10], x2
uaddlp.4h	v1, v1
uaddlp.8h	v0, v0
uaddlp.4h	v3, v3
uaddlp.8h	v2, v2
shl.4h	v1, v1, #2
shl.8h	v0, v0, #2
shl.4h	v3, v3, #2
shl.8h	v2, v2, #2
dup.4h	v4, v1[3]
dup.4h	v5, v3[3]
trn1.2d	v1, v1, v4
trn1.2d	v3, v3, v5
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_422_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ld1.16b	{ v0 }, [x1], x2
ld1.16b	{ v2 }, [x10], x2
uaddlp.8h	v0, v0
uaddlp.8h	v2, v2
shl.8h	v0, v0, #2
shl.8h	v2, v2, #2
dup.8h	v1, v0[7]
dup.8h	v3, v2[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_422_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v2 }, [x10], x2
uaddlp.4h	v0, v0
uaddlp.4h	v2, v2
shl.4h	v0, v0, #2
shl.4h	v2, v2, #2
dup.8h	v1, v0[3]
dup.8h	v3, v2[3]
trn1.2d	v0, v0, v1
trn1.2d	v2, v2, v3
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_422_8bpc_neon
mov.16b	v0, v2
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
<unknown>
udf	#612
<unknown>
<unknown>
_ipred_cfl_ac_444_8bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adr	x7, #932
sub	w8, w8, #26
ldrh	w8, [x7, w8, uxtw #1]
movi.8h	v16, #0
movi.8h	v17, #0
movi.8h	v18, #0
movi.8h	v19, #0
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
ld1.s	{ v0 }[0], [x1], x2
ld1.s	{ v0 }[1], [x10], x2
ld1.s	{ v1 }[0], [x1], x2
ld1.s	{ v1 }[1], [x10], x2
ushll.8h	v0, v0, #3
ushll.8h	v1, v1, #3
subs	w8, w8, #4
add.8h	v16, v16, v0
add.8h	v17, v17, v1
st1.8h	{ v0, v1 }, [x0], #32
b.gt	ipred_cfl_ac_444_8bpc_neon
trn2.2d	v0, v1, v1
trn2.2d	v1, v1, v1
b	ipred_cfl_ac_420_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v1 }, [x10], x2
ld1.8b	{ v2 }, [x1], x2
ushll.8h	v0, v0, #3
ld1.8b	{ v3 }, [x10], x2
ushll.8h	v1, v1, #3
ushll.8h	v2, v2, #3
ushll.8h	v3, v3, #3
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
b.gt	ipred_cfl_ac_444_8bpc_neon
mov.16b	v0, v3
mov.16b	v1, v3
b	ipred_cfl_ac_420_8bpc_neon
cbnz	w3, ipred_cfl_ac_444_8bpc_neon
ld1.16b	{ v0 }, [x1], x2
ld1.16b	{ v2 }, [x10], x2
ld1.16b	{ v4 }, [x1], x2
ushll2.8h	v1, v0, #3
ushll.8h	v0, v0, #3
ld1.16b	{ v6 }, [x10], x2
ushll2.8h	v3, v2, #3
ushll.8h	v2, v2, #3
ushll2.8h	v5, v4, #3
ushll.8h	v4, v4, #3
ushll2.8h	v7, v6, #3
ushll.8h	v6, v6, #3
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
mov.16b	v0, v6
mov.16b	v1, v7
mov.16b	v2, v6
mov.16b	v3, v7
b	ipred_cfl_ac_420_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v2 }, [x10], x2
ld1.8b	{ v4 }, [x1], x2
ld1.8b	{ v6 }, [x10], x2
ushll.8h	v0, v0, #3
ushll.8h	v2, v2, #3
ushll.8h	v4, v4, #3
ushll.8h	v6, v6, #3
dup.8h	v1, v0[7]
dup.8h	v3, v2[7]
dup.8h	v5, v4[7]
dup.8h	v7, v6[7]
subs	w8, w8, #4
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
mov.16b	v0, v6
mov.16b	v1, v7
mov.16b	v2, v6
mov.16b	v3, v7
b	ipred_cfl_ac_420_8bpc_neon
adr	x7, #500
ldrh	w3, [x7, w3, uxtw]
sub	x7, x7, w3, uxtw
br	x7
ld1.16b	{ v2, v3 }, [x1], x2
ld1.16b	{ v6, v7 }, [x10], x2
ushll.8h	v0, v2, #3
ushll2.8h	v1, v2, #3
ushll.8h	v2, v3, #3
ushll2.8h	v3, v3, #3
ushll.8h	v4, v6, #3
ushll2.8h	v5, v6, #3
ushll.8h	v6, v7, #3
ushll2.8h	v7, v7, #3
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
b	ipred_cfl_ac_444_8bpc_neon
ldr	d2, [x1, #16]
ld1.16b	{ v1 }, [x1], x2
ldr	d6, [x10, #16]
ld1.16b	{ v5 }, [x10], x2
ushll.8h	v2, v2, #3
ushll.8h	v0, v1, #3
ushll2.8h	v1, v1, #3
ushll.8h	v6, v6, #3
ushll.8h	v4, v5, #3
ushll2.8h	v5, v5, #3
dup.8h	v3, v2[7]
dup.8h	v7, v6[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
b	ipred_cfl_ac_444_8bpc_neon
ld1.16b	{ v1 }, [x1], x2
ld1.16b	{ v5 }, [x10], x2
ushll.8h	v0, v1, #3
ushll2.8h	v1, v1, #3
ushll.8h	v4, v5, #3
ushll2.8h	v5, v5, #3
dup.8h	v2, v1[7]
dup.8h	v3, v1[7]
dup.8h	v6, v5[7]
dup.8h	v7, v5[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
b	ipred_cfl_ac_444_8bpc_neon
ld1.8b	{ v0 }, [x1], x2
ld1.8b	{ v4 }, [x10], x2
ushll.8h	v0, v0, #3
ushll.8h	v4, v4, #3
dup.8h	v1, v0[7]
dup.8h	v2, v0[7]
dup.8h	v3, v0[7]
dup.8h	v5, v4[7]
dup.8h	v6, v4[7]
dup.8h	v7, v4[7]
subs	w8, w8, #2
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
add.8h	v16, v16, v0
add.8h	v17, v17, v1
add.8h	v18, v18, v2
add.8h	v19, v19, v3
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
cbz	w4, ipred_cfl_ac_444_8bpc_neon
subs	w4, w4, #2
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
st1.8h	{ v4, v5, v6, v7 }, [x0], #64
add.8h	v16, v16, v4
add.8h	v17, v17, v5
add.8h	v18, v18, v6
add.8h	v19, v19, v7
b.gt	ipred_cfl_ac_444_8bpc_neon
lsl	w6, w6, #2
uaddlp.4s	v0, v16
uaddlp.4s	v1, v17
uaddlp.4s	v2, v18
uaddlp.4s	v3, v19
add.4s	v0, v0, v1
add.4s	v2, v2, v3
add.4s	v0, v0, v2
addv.4s	s0, v0
sub	x0, x0, w6, uxtw #4
urshl.2s	v4, v0, v31
dup.8h	v4, v4[0]
b	ipred_cfl_ac_420_8bpc_neon
<unknown>
<unknown>
<unknown>
<unknown>