	.text
ipred_dc_128_16bpc_neon:
ldr	w8, [sp]
clz	w3, w3
adrp	x5, ipred_dc_128_tbl
add	x5, x5, :lo12:ipred_dc_128_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
dup	v0.8h, w8
add	x5, x5, x3
add	x6, x0, x1
lsl	x1, x1, #1
urshr	v0.8h, v0.8h, #0x1
br	x5
L_30:
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
b.gt	L_30
ret
L_4c:
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_4c
ret
L_68:
mov	v1.16b, v0.16b
L_6c:
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
b.gt	L_6c
ret
L_88:
mov	v1.16b, v0.16b
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
L_94:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_94
ret
L_b0:
mov	v1.16b, v0.16b
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
sub	x1, x1, #0x40
L_c0:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_c0
ret
ipred_v_16bpc_neon:
clz	w3, w3
adrp	x5, ipred_v_tbl
add	x5, x5, :lo12:ipred_v_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
add	x2, x2, #0x2
add	x5, x5, x3
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_114:
ld1	{ v0.4h }, [x2]
L_118:
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
b.gt	L_118
ret
L_134:
ld1	{ v0.8h }, [x2]
L_138:
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_138
ret
L_154:
ld1	{ v0.8h, v1.8h }, [x2]
L_158:
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
b.gt	L_158
ret
L_174:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2]
L_178:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_178
ret
L_194:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], #64
sub	x1, x1, #0x40
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2]
L_1a0:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x0], x1
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], x1
b.gt	L_1a0
ret
ipred_h_16bpc_neon:
clz	w3, w3
adrp	x5, ipred_h_tbl
add	x5, x5, :lo12:ipred_h_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
sub	x2, x2, #0x8
add	x5, x5, x3
mov	x7, #-0x8
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_1f8:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
st1	{ v3.4h }, [x0], x1
st1	{ v2.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v1.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
b.gt	L_1f8
ret
L_218:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
st1	{ v3.8h }, [x0], x1
st1	{ v2.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v1.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_218
ret
L_238:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
str	q3, [x0, #0x10]
str	q2, [x6, #0x10]
st1	{ v3.8h }, [x0], x1
st1	{ v2.8h }, [x6], x1
subs	w4, w4, #0x4
str	q1, [x0, #0x10]
str	q0, [x6, #0x10]
st1	{ v1.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_238
ret
L_268:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
str	q3, [x0, #0x10]
str	q2, [x6, #0x10]
stp	q3, q3, [x0, #0x20]
stp	q2, q2, [x6, #0x20]
st1	{ v3.8h }, [x0], x1
st1	{ v2.8h }, [x6], x1
subs	w4, w4, #0x4
str	q1, [x0, #0x10]
str	q0, [x6, #0x10]
stp	q1, q1, [x0, #0x20]
stp	q0, q0, [x6, #0x20]
st1	{ v1.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_268
ret
L_2a8:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
str	q3, [x0, #0x10]
str	q2, [x6, #0x10]
stp	q3, q3, [x0, #0x20]
stp	q2, q2, [x6, #0x20]
stp	q3, q3, [x0, #0x40]
stp	q2, q2, [x6, #0x40]
stp	q3, q3, [x0, #0x60]
stp	q2, q2, [x6, #0x60]
st1	{ v3.8h }, [x0], x1
st1	{ v2.8h }, [x6], x1
subs	w4, w4, #0x4
str	q1, [x0, #0x10]
str	q0, [x6, #0x10]
stp	q1, q1, [x0, #0x20]
stp	q0, q0, [x6, #0x20]
stp	q1, q1, [x0, #0x40]
stp	q0, q0, [x6, #0x40]
stp	q1, q1, [x0, #0x60]
stp	q0, q0, [x6, #0x60]
st1	{ v1.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_2a8
ret
ipred_dc_top_16bpc_neon:
clz	w3, w3
adrp	x5, ipred_dc_top_tbl
add	x5, x5, :lo12:ipred_dc_top_tbl
sub	w3, w3, #0x19
ldrsw	x3, [x5, w3, uxtw #2]
add	x2, x2, #0x2
add	x5, x5, x3
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_330:
ld1	{ v0.4h }, [x2]
addv	h0, v0.4h
urshr	v0.4h, v0.4h, #0x2
dup	v0.4h, v0.h[0]
L_340:
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
b.gt	L_340
ret
L_35c:
ld1	{ v0.8h }, [x2]
addv	h0, v0.8h
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
L_36c:
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_36c
ret
L_388:
ld1	{ v0.8h, v1.8h }, [x2]
addp	v0.8h, v0.8h, v1.8h
addv	h0, v0.8h
urshr	v2.4h, v0.4h, #0x4
dup	v0.8h, v2.h[0]
dup	v1.8h, v2.h[0]
L_3a0:
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
b.gt	L_3a0
ret
L_3bc:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2]
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v0.8h, v0.8h, v2.8h
uaddlv	s0, v0.8h
rshrn	v4.4h, v0.4s, #0x5
dup	v0.8h, v4.h[0]
dup	v1.8h, v4.h[0]
dup	v2.8h, v4.h[0]
dup	v3.8h, v4.h[0]
L_3e4:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_3e4
ret
L_400:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], #64
addp	v0.8h, v0.8h, v1.8h
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2]
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
addp	v0.8h, v0.8h, v2.8h
addp	v4.8h, v4.8h, v6.8h
addp	v0.8h, v0.8h, v4.8h
uaddlv	s0, v0.8h
rshrn	v4.4h, v0.4s, #0x6
sub	x1, x1, #0x40
dup	v0.8h, v4.h[0]
dup	v1.8h, v4.h[0]
dup	v2.8h, v4.h[0]
dup	v3.8h, v4.h[0]
L_440:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_440
ret
ipred_dc_left_16bpc_neon:
sub	x2, x2, w4, uxtw #1
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
L_4a4:
ld1	{ v0.4h }, [x2]
addv	h0, v0.4h
urshr	v0.4h, v0.4h, #0x2
dup	v0.8h, v0.h[0]
br	x3
L_4b8:
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
b.gt	L_4b8
ret
L_4d4:
ld1	{ v0.8h }, [x2]
addv	h0, v0.8h
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
br	x3
L_4e8:
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_4e8
ret
L_504:
ld1	{ v0.8h, v1.8h }, [x2]
addp	v0.8h, v0.8h, v1.8h
addv	h0, v0.8h
urshr	v2.4h, v0.4h, #0x4
dup	v0.8h, v2.h[0]
dup	v1.8h, v2.h[0]
br	x3
L_520:
mov	v1.16b, v0.16b
L_524:
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
b.gt	L_524
ret
L_540:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2]
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v0.8h, v0.8h, v2.8h
uaddlp	v0.4s, v0.8h
addv	s0, v0.4s
rshrn	v4.4h, v0.4s, #0x5
dup	v0.8h, v4.h[0]
br	x3
L_564:
mov	v1.16b, v0.16b
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
L_570:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_570
ret
L_58c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], #64
addp	v0.8h, v0.8h, v1.8h
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2]
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
addp	v0.8h, v0.8h, v2.8h
addp	v4.8h, v4.8h, v6.8h
addp	v0.8h, v0.8h, v4.8h
uaddlv	s0, v0.8h
rshrn	v4.4h, v0.4s, #0x6
dup	v0.8h, v4.h[0]
br	x3
L_5c0:
mov	v1.16b, v0.16b
mov	v2.16b, v0.16b
mov	v3.16b, v0.16b
sub	x1, x1, #0x40
L_5d0:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_5d0
ret
ipred_dc_16bpc_neon:
sub	x2, x2, w4, uxtw #1
add	w7, w3, w4
clz	w3, w3
clz	w6, w4
dup	v16.4s, w7
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
ushr	v16.4s, v16.4s, #0x1
dup	v17.4s, w7
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_650:
ld1	{ v0.4h }, [x2], #8
uaddlv	s0, v0.4h
add	x2, x2, #0x2
br	x3
L_660:
ld1	{ v1.4h }, [x2]
add	v0.2s, v0.2s, v16.2s
uaddlv	s1, v1.4h
cmp	w4, #0x4
add	v0.2s, v0.2s, v1.2s
ushl	v0.2s, v0.2s, v17.2s
b.eq	L_698
cmp	w4, #0x10
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v0.2s, v0.2s, v16.2s
ushr	v0.2s, v0.2s, #0x11
L_698:
dup	v0.4h, v0.h[0]
L_69c:
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.4h }, [x0], x1
st1	{ v0.4h }, [x6], x1
b.gt	L_69c
ret
L_6b8:
ld1	{ v0.8h }, [x2], #16
uaddlv	s0, v0.8h
add	x2, x2, #0x2
br	x3
L_6c8:
ld1	{ v1.8h }, [x2]
add	v0.2s, v0.2s, v16.2s
uaddlv	s1, v1.8h
cmp	w4, #0x8
add	v0.2s, v0.2s, v1.2s
ushl	v0.2s, v0.2s, v17.2s
b.eq	L_700
cmp	w4, #0x20
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v0.2s, v0.2s, v16.2s
ushr	v0.2s, v0.2s, #0x11
L_700:
dup	v0.8h, v0.h[0]
L_704:
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h }, [x0], x1
st1	{ v0.8h }, [x6], x1
b.gt	L_704
ret
L_720:
ld1	{ v0.8h, v1.8h }, [x2], #32
addp	v0.8h, v0.8h, v1.8h
add	x2, x2, #0x2
uaddlv	s0, v0.8h
br	x3
L_734:
ld1	{ v1.8h, v2.8h }, [x2]
add	v0.2s, v0.2s, v16.2s
addp	v1.8h, v1.8h, v2.8h
uaddlv	s1, v1.8h
cmp	w4, #0x10
add	v0.2s, v0.2s, v1.2s
ushl	v4.2s, v0.2s, v17.2s
b.eq	L_770
tst	w4, #0x38
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v4.2s, v4.2s, v16.2s
ushr	v4.2s, v4.2s, #0x11
L_770:
dup	v0.8h, v4.h[0]
dup	v1.8h, v4.h[0]
L_778:
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], x1
st1	{ v0.8h, v1.8h }, [x6], x1
b.gt	L_778
ret
L_794:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], #64
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v0.8h, v0.8h, v2.8h
add	x2, x2, #0x2
uaddlv	s0, v0.8h
br	x3
L_7b0:
ld1	{ v1.8h, v2.8h, v3.8h, v4.8h }, [x2]
add	v0.2s, v0.2s, v16.2s
addp	v1.8h, v1.8h, v2.8h
addp	v3.8h, v3.8h, v4.8h
addp	v1.8h, v1.8h, v3.8h
uaddlv	s1, v1.8h
cmp	w4, #0x20
add	v0.2s, v0.2s, v1.2s
ushl	v4.2s, v0.2s, v17.2s
b.eq	L_7f4
cmp	w4, #0x8
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v4.2s, v4.2s, v16.2s
ushr	v4.2s, v4.2s, #0x11
L_7f4:
dup	v0.8h, v4.h[0]
dup	v1.8h, v4.h[0]
dup	v2.8h, v4.h[0]
dup	v3.8h, v4.h[0]
L_804:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_804
ret
L_820:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], #64
addp	v0.8h, v0.8h, v1.8h
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], #64
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
addp	v0.8h, v0.8h, v2.8h
addp	v4.8h, v4.8h, v6.8h
addp	v0.8h, v0.8h, v4.8h
add	x2, x2, #0x2
uaddlv	s0, v0.8h
br	x3
L_850:
ld1	{ v1.8h, v2.8h, v3.8h, v4.8h }, [x2], #64
add	v0.2s, v0.2s, v16.2s
addp	v1.8h, v1.8h, v2.8h
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x2]
addp	v3.8h, v3.8h, v4.8h
addp	v20.8h, v20.8h, v21.8h
addp	v22.8h, v22.8h, v23.8h
addp	v1.8h, v1.8h, v3.8h
addp	v20.8h, v20.8h, v22.8h
addp	v1.8h, v1.8h, v20.8h
uaddlv	s1, v1.8h
cmp	w4, #0x40
add	v0.2s, v0.2s, v1.2s
ushl	v4.2s, v0.2s, v17.2s
b.eq	L_8a8
cmp	w4, #0x10
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v4.2s, v4.2s, v16.2s
ushr	v4.2s, v4.2s, #0x11
L_8a8:
sub	x1, x1, #0x40
dup	v0.8h, v4.h[0]
dup	v1.8h, v4.h[0]
dup	v2.8h, v4.h[0]
dup	v3.8h, v4.h[0]
L_8bc:
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], #64
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x6], x1
b.gt	L_8bc
ret
ipred_paeth_16bpc_neon:
clz	w9, w3
adrp	x5, ipred_paeth_tbl
add	x5, x5, :lo12:ipred_paeth_tbl
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v4.8h }, [x2]
add	x8, x2, #0x2
sub	x2, x2, #0x8
add	x5, x5, x9
mov	x7, #-0x8
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_91c:
ld1r	{ v5.2d }, [x8]
sub	v6.8h, v5.8h, v4.8h
L_924:
ld4r	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], x7
zip1	v0.2d, v0.2d, v1.2d
zip1	v2.2d, v2.2d, v3.2d
add	v16.8h, v6.8h, v0.8h
add	v17.8h, v6.8h, v2.8h
sabd	v20.8h, v5.8h, v16.8h
sabd	v21.8h, v5.8h, v17.8h
sabd	v22.8h, v4.8h, v16.8h
sabd	v23.8h, v4.8h, v17.8h
sabd	v16.8h, v0.8h, v16.8h
sabd	v17.8h, v2.8h, v17.8h
umin	v18.8h, v20.8h, v22.8h
umin	v19.8h, v21.8h, v23.8h
cmge	v20.8h, v22.8h, v20.8h
cmge	v21.8h, v23.8h, v21.8h
cmge	v16.8h, v18.8h, v16.8h
cmge	v17.8h, v19.8h, v17.8h
bsl	v21.16b, v5.16b, v4.16b
bsl	v20.16b, v5.16b, v4.16b
bit	v21.16b, v2.16b, v17.16b
bit	v20.16b, v0.16b, v16.16b
st1	{ v21.d }[1], [x0], x1
st1	{ v21.d }[0], [x6], x1
subs	w4, w4, #0x4
st1	{ v20.d }[1], [x0], x1
st1	{ v20.d }[0], [x6], x1
b.gt	L_924
ret
L_994:
ld1	{ v5.8h }, [x8], #16
mov	w9, w3
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
L_9ac:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
L_9b0:
sub	v6.8h, v5.8h, v4.8h
add	v16.8h, v6.8h, v0.8h
add	v17.8h, v6.8h, v1.8h
add	v18.8h, v6.8h, v2.8h
add	v19.8h, v6.8h, v3.8h
sabd	v20.8h, v5.8h, v16.8h
sabd	v21.8h, v5.8h, v17.8h
sabd	v22.8h, v5.8h, v18.8h
sabd	v23.8h, v5.8h, v19.8h
sabd	v24.8h, v4.8h, v16.8h
sabd	v25.8h, v4.8h, v17.8h
sabd	v26.8h, v4.8h, v18.8h
sabd	v27.8h, v4.8h, v19.8h
sabd	v16.8h, v0.8h, v16.8h
sabd	v17.8h, v1.8h, v17.8h
sabd	v18.8h, v2.8h, v18.8h
sabd	v19.8h, v3.8h, v19.8h
umin	v28.8h, v20.8h, v24.8h
umin	v29.8h, v21.8h, v25.8h
umin	v30.8h, v22.8h, v26.8h
umin	v31.8h, v23.8h, v27.8h
cmge	v20.8h, v24.8h, v20.8h
cmge	v21.8h, v25.8h, v21.8h
cmge	v22.8h, v26.8h, v22.8h
cmge	v23.8h, v27.8h, v23.8h
cmge	v16.8h, v28.8h, v16.8h
cmge	v17.8h, v29.8h, v17.8h
cmge	v18.8h, v30.8h, v18.8h
cmge	v19.8h, v31.8h, v19.8h
bsl	v23.16b, v5.16b, v4.16b
bsl	v22.16b, v5.16b, v4.16b
bsl	v21.16b, v5.16b, v4.16b
bsl	v20.16b, v5.16b, v4.16b
bit	v23.16b, v3.16b, v19.16b
bit	v22.16b, v2.16b, v18.16b
bit	v21.16b, v1.16b, v17.16b
bit	v20.16b, v0.16b, v16.16b
st1	{ v23.8h }, [x0], #16
st1	{ v22.8h }, [x6], #16
subs	w3, w3, #0x8
st1	{ v21.8h }, [x5], #16
st1	{ v20.8h }, [x10], #16
b.le	L_a64
ld1	{ v5.8h }, [x8], #16
b	L_9b0
L_a64:
subs	w4, w4, #0x4
b.le	L_a8c
sub	x8, x8, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
ld1	{ v5.8h }, [x8], #16
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	L_9ac
L_a8c:
ret
ipred_smooth_16bpc_neon:
adrp	x10, sm_weights
add	x10, x10, :lo12:sm_weights
add	x11, x10, w4, uxtw
add	x10, x10, w3, uxtw
clz	w9, w3
adrp	x5, ipred_smooth_tbl
add	x5, x5, :lo12:ipred_smooth_tbl
sub	x12, x2, w4, uxtw #1
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v4.8h }, [x12]
add	x8, x2, #0x2
add	x5, x5, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_ad0:
ld1r	{ v6.2d }, [x8]
ld1r	{ v7.2s }, [x10]
sub	x2, x2, #0x8
mov	x7, #-0x8
dup	v5.8h, v6.h[3]
sub	v6.8h, v6.8h, v4.8h
ushll	v7.8h, v7.8b, #0x0
add	v31.4h, v4.4h, v5.4h
L_af0:
ld4r	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], x7
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x11], #4
ushll	v20.4s, v31.4h, #0x8
ushll	v21.4s, v31.4h, #0x8
ushll	v22.4s, v31.4h, #0x8
ushll	v23.4s, v31.4h, #0x8
zip1	v1.2d, v1.2d, v0.2d
zip1	v0.2d, v3.2d, v2.2d
zip1	v16.2s, v16.2s, v17.2s
zip1	v18.2s, v18.2s, v19.2s
sub	v0.8h, v0.8h, v5.8h
sub	v1.8h, v1.8h, v5.8h
ushll	v16.8h, v16.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
smlal	v20.4s, v0.4h, v7.4h
smlal2	v21.4s, v0.8h, v7.8h
smlal	v22.4s, v1.4h, v7.4h
smlal2	v23.4s, v1.8h, v7.8h
smlal	v20.4s, v6.4h, v16.4h
smlal2	v21.4s, v6.8h, v16.8h
smlal	v22.4s, v6.4h, v18.4h
smlal2	v23.4s, v6.8h, v18.8h
rshrn	v20.4h, v20.4s, #0x9
rshrn	v21.4h, v21.4s, #0x9
rshrn	v22.4h, v22.4s, #0x9
rshrn	v23.4h, v23.4s, #0x9
st1	{ v20.4h }, [x0], x1
st1	{ v21.4h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v22.4h }, [x0], x1
st1	{ v23.4h }, [x6], x1
b.gt	L_af0
ret
L_b74:
ld1	{ v6.8h }, [x8]
ld1	{ v7.8b }, [x10]
sub	x2, x2, #0x8
mov	x7, #-0x8
dup	v5.8h, v6.h[7]
sub	v6.8h, v6.8h, v4.8h
ushll	v7.8h, v7.8b, #0x0
add	v31.4h, v4.4h, v5.4h
L_b94:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x11], #4
ushll	v20.4s, v31.4h, #0x8
ushll	v21.4s, v31.4h, #0x8
ushll	v22.4s, v31.4h, #0x8
ushll	v23.4s, v31.4h, #0x8
ushll	v24.4s, v31.4h, #0x8
ushll	v25.4s, v31.4h, #0x8
ushll	v26.4s, v31.4h, #0x8
ushll	v27.4s, v31.4h, #0x8
sub	v0.8h, v0.8h, v5.8h
sub	v1.8h, v1.8h, v5.8h
sub	v2.8h, v2.8h, v5.8h
sub	v3.8h, v3.8h, v5.8h
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
smlal	v20.4s, v3.4h, v7.4h
smlal2	v21.4s, v3.8h, v7.8h
smlal	v22.4s, v2.4h, v7.4h
smlal2	v23.4s, v2.8h, v7.8h
smlal	v24.4s, v1.4h, v7.4h
smlal2	v25.4s, v1.8h, v7.8h
smlal	v26.4s, v0.4h, v7.4h
smlal2	v27.4s, v0.8h, v7.8h
smlal	v20.4s, v6.4h, v16.4h
smlal2	v21.4s, v6.8h, v16.8h
smlal	v22.4s, v6.4h, v17.4h
smlal2	v23.4s, v6.8h, v17.8h
smlal	v24.4s, v6.4h, v18.4h
smlal2	v25.4s, v6.8h, v18.8h
smlal	v26.4s, v6.4h, v19.4h
smlal2	v27.4s, v6.8h, v19.8h
rshrn	v20.4h, v20.4s, #0x9
rshrn2	v20.8h, v21.4s, #0x9
rshrn	v21.4h, v22.4s, #0x9
rshrn2	v21.8h, v23.4s, #0x9
rshrn	v22.4h, v24.4s, #0x9
rshrn2	v22.8h, v25.4s, #0x9
rshrn	v23.4h, v26.4s, #0x9
rshrn2	v23.8h, v27.4s, #0x9
st1	{ v20.8h }, [x0], x1
st1	{ v21.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v22.8h }, [x0], x1
st1	{ v23.8h }, [x6], x1
b.gt	L_b94
ret
L_c58:
add	x12, x2, w3, uxtw #1
sub	x1, x1, w3, uxtw #1
ld1r	{ v5.8h }, [x12]
sub	x2, x2, #0x4
mov	x7, #-0x4
mov	w9, w3
add	v31.4h, v4.4h, v5.4h
L_c74:
ld2r	{ v0.8h, v1.8h }, [x2], x7
ld2r	{ v16.8b, v17.8b }, [x11], #2
sub	v0.8h, v0.8h, v5.8h
sub	v1.8h, v1.8h, v5.8h
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
L_c8c:
ld1	{ v7.16b }, [x10], #16
ld1	{ v2.8h, v3.8h }, [x8], #32
ushll	v20.4s, v31.4h, #0x8
ushll	v21.4s, v31.4h, #0x8
ushll	v22.4s, v31.4h, #0x8
ushll	v23.4s, v31.4h, #0x8
ushll	v24.4s, v31.4h, #0x8
ushll	v25.4s, v31.4h, #0x8
ushll	v26.4s, v31.4h, #0x8
ushll	v27.4s, v31.4h, #0x8
ushll	v6.8h, v7.8b, #0x0
ushll2	v7.8h, v7.16b, #0x0
sub	v2.8h, v2.8h, v4.8h
sub	v3.8h, v3.8h, v4.8h
smlal	v20.4s, v1.4h, v6.4h
smlal2	v21.4s, v1.8h, v6.8h
smlal	v22.4s, v1.4h, v7.4h
smlal2	v23.4s, v1.8h, v7.8h
smlal	v24.4s, v0.4h, v6.4h
smlal2	v25.4s, v0.8h, v6.8h
smlal	v26.4s, v0.4h, v7.4h
smlal2	v27.4s, v0.8h, v7.8h
smlal	v20.4s, v2.4h, v16.4h
smlal2	v21.4s, v2.8h, v16.8h
smlal	v22.4s, v3.4h, v16.4h
smlal2	v23.4s, v3.8h, v16.8h
smlal	v24.4s, v2.4h, v17.4h
smlal2	v25.4s, v2.8h, v17.8h
smlal	v26.4s, v3.4h, v17.4h
smlal2	v27.4s, v3.8h, v17.8h
rshrn	v20.4h, v20.4s, #0x9
rshrn2	v20.8h, v21.4s, #0x9
rshrn	v21.4h, v22.4s, #0x9
rshrn2	v21.8h, v23.4s, #0x9
rshrn	v22.4h, v24.4s, #0x9
rshrn2	v22.8h, v25.4s, #0x9
rshrn	v23.4h, v26.4s, #0x9
rshrn2	v23.8h, v27.4s, #0x9
subs	w3, w3, #0x10
st1	{ v20.8h, v21.8h }, [x0], #32
st1	{ v22.8h, v23.8h }, [x6], #32
b.gt	L_c8c
subs	w4, w4, #0x2
b.le	L_d54
sub	x8, x8, w9, uxtw #1
sub	x10, x10, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	L_c74
L_d54:
ret
ipred_smooth_v_16bpc_neon:
adrp	x7, sm_weights
add	x7, x7, :lo12:sm_weights
add	x7, x7, w4, uxtw
clz	w9, w3
adrp	x5, ipred_smooth_v_tbl
add	x5, x5, :lo12:ipred_smooth_v_tbl
sub	x8, x2, w4, uxtw #1
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v4.8h }, [x8]
add	x2, x2, #0x2
add	x5, x5, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_d94:
ld1r	{ v6.2d }, [x2]
sub	v6.8h, v6.8h, v4.8h
L_d9c:
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x7], #4
zip1	v16.2s, v16.2s, v17.2s
zip1	v18.2s, v18.2s, v19.2s
ushll	v16.8h, v16.8b, #0x7
ushll	v18.8h, v18.8b, #0x7
sqrdmulh	v20.8h, v6.8h, v16.8h
sqrdmulh	v21.8h, v6.8h, v18.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v4.8h
st1	{ v20.d }[0], [x0], x1
st1	{ v20.d }[1], [x6], x1
subs	w4, w4, #0x4
st1	{ v21.d }[0], [x0], x1
st1	{ v21.d }[1], [x6], x1
b.gt	L_d9c
ret
L_ddc:
ld1	{ v6.8h }, [x2]
sub	v6.8h, v6.8h, v4.8h
L_de4:
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x7], #4
ushll	v16.8h, v16.8b, #0x7
ushll	v17.8h, v17.8b, #0x7
ushll	v18.8h, v18.8b, #0x7
ushll	v19.8h, v19.8b, #0x7
sqrdmulh	v20.8h, v6.8h, v16.8h
sqrdmulh	v21.8h, v6.8h, v17.8h
sqrdmulh	v22.8h, v6.8h, v18.8h
sqrdmulh	v23.8h, v6.8h, v19.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v4.8h
add	v22.8h, v22.8h, v4.8h
add	v23.8h, v23.8h, v4.8h
st1	{ v20.8h }, [x0], x1
st1	{ v21.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v22.8h }, [x0], x1
st1	{ v23.8h }, [x6], x1
b.gt	L_de4
ret
L_e34:
add	x5, x0, x1
add	x8, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
mov	w9, w3
L_e48:
ld4r	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x7], #4
ushll	v16.8h, v16.8b, #0x7
ushll	v17.8h, v17.8b, #0x7
ushll	v18.8h, v18.8b, #0x7
ushll	v19.8h, v19.8b, #0x7
L_e5c:
ld1	{ v2.8h, v3.8h }, [x2], #32
sub	v2.8h, v2.8h, v4.8h
sub	v3.8h, v3.8h, v4.8h
sqrdmulh	v20.8h, v2.8h, v16.8h
sqrdmulh	v21.8h, v3.8h, v16.8h
sqrdmulh	v22.8h, v2.8h, v17.8h
sqrdmulh	v23.8h, v3.8h, v17.8h
sqrdmulh	v24.8h, v2.8h, v18.8h
sqrdmulh	v25.8h, v3.8h, v18.8h
sqrdmulh	v26.8h, v2.8h, v19.8h
sqrdmulh	v27.8h, v3.8h, v19.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v4.8h
add	v22.8h, v22.8h, v4.8h
add	v23.8h, v23.8h, v4.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v4.8h
add	v26.8h, v26.8h, v4.8h
add	v27.8h, v27.8h, v4.8h
subs	w3, w3, #0x10
st1	{ v20.8h, v21.8h }, [x0], #32
st1	{ v22.8h, v23.8h }, [x6], #32
st1	{ v24.8h, v25.8h }, [x5], #32
st1	{ v26.8h, v27.8h }, [x8], #32
b.gt	L_e5c
subs	w4, w4, #0x4
b.le	L_ee4
sub	x2, x2, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x8, x8, x1
mov	w3, w9
b	L_e48
L_ee4:
ret
ipred_smooth_h_16bpc_neon:
adrp	x8, sm_weights
add	x8, x8, :lo12:sm_weights
add	x8, x8, w3, uxtw
clz	w9, w3
adrp	x5, ipred_smooth_h_tbl
add	x5, x5, :lo12:ipred_smooth_h_tbl
add	x12, x2, w3, uxtw #1
sub	w9, w9, #0x19
ldrsw	x9, [x5, w9, uxtw #2]
ld1r	{ v5.8h }, [x12]
add	x5, x5, x9
add	x6, x0, x1
lsl	x1, x1, #1
br	x5
L_f20:
ld1r	{ v7.2s }, [x8]
sub	x2, x2, #0x8
mov	x7, #-0x8
ushll	v7.8h, v7.8b, #0x7
L_f30:
ld4r	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x2], x7
zip1	v1.2d, v1.2d, v0.2d
zip1	v0.2d, v3.2d, v2.2d
sub	v0.8h, v0.8h, v5.8h
sub	v1.8h, v1.8h, v5.8h
sqrdmulh	v20.8h, v0.8h, v7.8h
sqrdmulh	v21.8h, v1.8h, v7.8h
add	v20.8h, v20.8h, v5.8h
add	v21.8h, v21.8h, v5.8h
st1	{ v20.d }[0], [x0], x1
st1	{ v20.d }[1], [x6], x1
subs	w4, w4, #0x4
st1	{ v21.d }[0], [x0], x1
st1	{ v21.d }[1], [x6], x1
b.gt	L_f30
ret
L_f70:
ld1	{ v7.8b }, [x8]
sub	x2, x2, #0x8
mov	x7, #-0x8
ushll	v7.8h, v7.8b, #0x7
L_f80:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
sub	v3.8h, v3.8h, v5.8h
sub	v2.8h, v2.8h, v5.8h
sub	v1.8h, v1.8h, v5.8h
sub	v0.8h, v0.8h, v5.8h
sqrdmulh	v20.8h, v3.8h, v7.8h
sqrdmulh	v21.8h, v2.8h, v7.8h
sqrdmulh	v22.8h, v1.8h, v7.8h
sqrdmulh	v23.8h, v0.8h, v7.8h
add	v20.8h, v20.8h, v5.8h
add	v21.8h, v21.8h, v5.8h
add	v22.8h, v22.8h, v5.8h
add	v23.8h, v23.8h, v5.8h
st1	{ v20.8h }, [x0], x1
st1	{ v21.8h }, [x6], x1
subs	w4, w4, #0x4
st1	{ v22.8h }, [x0], x1
st1	{ v23.8h }, [x6], x1
b.gt	L_f80
ret
L_fd0:
sub	x2, x2, #0x8
mov	x7, #-0x8
add	x5, x0, x1
add	x10, x6, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
mov	w9, w3
L_fec:
ld4r	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x2], x7
sub	v0.8h, v0.8h, v5.8h
sub	v1.8h, v1.8h, v5.8h
sub	v2.8h, v2.8h, v5.8h
sub	v3.8h, v3.8h, v5.8h
L_1000:
ld1	{ v7.16b }, [x8], #16
ushll	v6.8h, v7.8b, #0x7
ushll2	v7.8h, v7.16b, #0x7
sqrdmulh	v20.8h, v3.8h, v6.8h
sqrdmulh	v21.8h, v3.8h, v7.8h
sqrdmulh	v22.8h, v2.8h, v6.8h
sqrdmulh	v23.8h, v2.8h, v7.8h
sqrdmulh	v24.8h, v1.8h, v6.8h
sqrdmulh	v25.8h, v1.8h, v7.8h
sqrdmulh	v26.8h, v0.8h, v6.8h
sqrdmulh	v27.8h, v0.8h, v7.8h
add	v20.8h, v20.8h, v5.8h
add	v21.8h, v21.8h, v5.8h
add	v22.8h, v22.8h, v5.8h
add	v23.8h, v23.8h, v5.8h
add	v24.8h, v24.8h, v5.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v5.8h
add	v27.8h, v27.8h, v5.8h
subs	w3, w3, #0x10
st1	{ v20.8h, v21.8h }, [x0], #32
st1	{ v22.8h, v23.8h }, [x6], #32
st1	{ v24.8h, v25.8h }, [x5], #32
st1	{ v26.8h, v27.8h }, [x10], #32
b.gt	L_1000
subs	w4, w4, #0x4
b.le	L_1088
sub	x8, x8, w9, uxtw
add	x0, x0, x1
add	x6, x6, x1
add	x5, x5, x1
add	x10, x10, x1
mov	w3, w9
b	L_fec
L_1088:
ret
ipred_z1_upsample_edge_16bpc_neon:
dup	v30.8h, w4
adrp	x4, padding_mask
add	x4, x4, :lo12:padding_mask
ld1	{ v0.8h, v1.8h }, [x2]
add	x5, x2, w3, uxtw #1
sub	x4, x4, w3, uxtw #1
ld1r	{ v2.8h }, [x5]
ld1	{ v3.8h, v4.8h }, [x4]
movi	v31.8h, #0x9
bit	v0.16b, v2.16b, v3.16b
bit	v1.16b, v2.16b, v4.16b
ext	v4.16b, v0.16b, v1.16b, #0x2
ext	v5.16b, v1.16b, v2.16b, #0x2
ext	v6.16b, v0.16b, v1.16b, #0x4
ext	v7.16b, v1.16b, v2.16b, #0x4
ext	v16.16b, v0.16b, v1.16b, #0x6
ext	v17.16b, v1.16b, v2.16b, #0x6
add	v18.8h, v4.8h, v6.8h
add	v19.8h, v5.8h, v7.8h
add	v20.8h, v0.8h, v16.8h
add	v21.8h, v1.8h, v17.8h
umull	v22.4s, v18.4h, v31.4h
umull2	v23.4s, v18.8h, v31.8h
umull	v24.4s, v19.4h, v31.4h
umull2	v25.4s, v19.8h, v31.8h
usubw	v22.4s, v22.4s, v20.4h
usubw2	v23.4s, v23.4s, v20.8h
usubw	v24.4s, v24.4s, v21.4h
usubw2	v25.4s, v25.4s, v21.8h
sqrshrun	v16.4h, v22.4s, #0x4
sqrshrun2	v16.8h, v23.4s, #0x4
sqrshrun	v17.4h, v24.4s, #0x4
sqrshrun2	v17.8h, v25.4s, #0x4
smin	v16.8h, v16.8h, v30.8h
smin	v17.8h, v17.8h, v30.8h
zip1	v0.8h, v4.8h, v16.8h
zip2	v1.8h, v4.8h, v16.8h
zip1	v2.8h, v5.8h, v17.8h
zip2	v3.8h, v5.8h, v17.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0]
ret
ipred_z2_upsample_edge_16bpc_neon:
dup	v30.8h, w3
adrp	x4, padding_mask
add	x4, x4, :lo12:padding_mask
ld1	{ v0.8h, v1.8h }, [x2]
add	x5, x2, w1, uxtw #1
sub	x4, x4, w1, uxtw #1
ld1r	{ v3.8h }, [x2]
ld1r	{ v2.8h }, [x5]
ld1	{ v4.8h, v5.8h }, [x4]
movi	v31.8h, #0x9
bit	v0.16b, v2.16b, v4.16b
bit	v1.16b, v2.16b, v5.16b
ext	v4.16b, v3.16b, v0.16b, #0xe
ext	v5.16b, v0.16b, v1.16b, #0x2
ext	v6.16b, v0.16b, v1.16b, #0x4
add	v16.8h, v0.8h, v5.8h
add	v17.8h, v4.8h, v6.8h
umull	v18.4s, v16.4h, v31.4h
umull2	v19.4s, v16.8h, v31.8h
usubw	v18.4s, v18.4s, v17.4h
usubw2	v19.4s, v19.4s, v17.8h
sqrshrun	v16.4h, v18.4s, #0x4
sqrshrun2	v16.8h, v19.4s, #0x4
add	x5, x0, #0x20
smin	v16.8h, v16.8h, v30.8h
zip1	v4.8h, v0.8h, v16.8h
zip2	v5.8h, v0.8h, v16.8h
st1	{ v2.h }[0], [x5]
st1	{ v4.8h, v5.8h }, [x0]
ret
ipred_z1_filter_edge_16bpc_neon:
cmp	w4, #0x3
b.eq	L_1290
adrp	x5, padding_mask_buf+90
add	x5, x5, :lo12:padding_mask_buf+90
add	x5, x5, w4, uxtw #3
ld1	{ v31.s }[0], [x5]
ld1	{ v0.8h }, [x2], #16
dup	v30.8h, v31.h[0]
dup	v31.8h, v31.h[1]
L_11cc:
cmp	w3, #0x11
ld1	{ v1.8h, v2.8h }, [x2], #32
b.lt	L_1220
ext	v3.16b, v0.16b, v1.16b, #0x2
ext	v4.16b, v1.16b, v2.16b, #0x2
ext	v5.16b, v0.16b, v1.16b, #0x4
ext	v6.16b, v1.16b, v2.16b, #0x4
mul	v16.8h, v0.8h, v30.8h
mla	v16.8h, v3.8h, v31.8h
mla	v16.8h, v5.8h, v30.8h
mul	v17.8h, v1.8h, v30.8h
mla	v17.8h, v4.8h, v31.8h
mla	v17.8h, v6.8h, v30.8h
subs	w1, w1, #0x10
mov	v0.16b, v2.16b
urshr	v16.8h, v16.8h, #0x4
urshr	v17.8h, v17.8h, #0x4
sub	w3, w3, #0x10
st1	{ v16.8h, v17.8h }, [x0], #32
b.gt	L_11cc
ret
L_1220:
adrp	x5, padding_mask
add	x5, x5, :lo12:padding_mask
sub	w6, w3, #0x18
sub	x5, x5, w3, uxtw #1
add	x6, x2, w6, sxtw #1
ld1	{ v3.8h, v4.8h }, [x5]
ld1r	{ v2.8h }, [x6]
bit	v0.16b, v2.16b, v3.16b
bit	v1.16b, v2.16b, v4.16b
ext	v3.16b, v0.16b, v1.16b, #0x2
ext	v4.16b, v1.16b, v2.16b, #0x2
ext	v5.16b, v0.16b, v1.16b, #0x4
ext	v6.16b, v1.16b, v2.16b, #0x4
mul	v16.8h, v0.8h, v30.8h
mla	v16.8h, v3.8h, v31.8h
mla	v16.8h, v5.8h, v30.8h
mul	v17.8h, v1.8h, v30.8h
mla	v17.8h, v4.8h, v31.8h
mla	v17.8h, v6.8h, v30.8h
subs	w1, w1, #0x10
urshr	v16.8h, v16.8h, #0x4
urshr	v17.8h, v17.8h, #0x4
st1	{ v16.8h, v17.8h }, [x0], #32
b.le	L_128c
L_1280:
subs	w1, w1, #0x10
st1	{ v2.16b }, [x0], #16
b.gt	L_1280
L_128c:
ret
L_1290:
sub	x2, x2, #0x2
movi	v29.8h, #0x2
ld1	{ v0.8h }, [x2], #16
movi	v30.8h, #0x4
movi	v31.8h, #0x4
mov	v0.h[0], v0.h[1]
L_12a8:
cmp	w3, #0x12
ld1	{ v1.8h, v2.8h }, [x2], #32
b.lt	L_131c
ext	v3.16b, v0.16b, v1.16b, #0x2
ext	v4.16b, v1.16b, v2.16b, #0x2
ext	v5.16b, v0.16b, v1.16b, #0x4
ext	v6.16b, v1.16b, v2.16b, #0x4
ext	v16.16b, v0.16b, v1.16b, #0x6
ext	v17.16b, v1.16b, v2.16b, #0x6
ext	v18.16b, v0.16b, v1.16b, #0x8
ext	v19.16b, v1.16b, v2.16b, #0x8
mul	v20.8h, v0.8h, v29.8h
mla	v20.8h, v3.8h, v30.8h
mla	v20.8h, v5.8h, v31.8h
mla	v20.8h, v16.8h, v30.8h
mla	v20.8h, v18.8h, v29.8h
mul	v21.8h, v1.8h, v29.8h
mla	v21.8h, v4.8h, v30.8h
mla	v21.8h, v6.8h, v31.8h
mla	v21.8h, v17.8h, v30.8h
mla	v21.8h, v19.8h, v29.8h
subs	w1, w1, #0x10
mov	v0.16b, v2.16b
urshr	v20.8h, v20.8h, #0x4
urshr	v21.8h, v21.8h, #0x4
sub	w3, w3, #0x10
st1	{ v20.8h, v21.8h }, [x0], #32
b.gt	L_12a8
ret
L_131c:
adrp	x5, padding_mask_buf+46
add	x5, x5, :lo12:padding_mask_buf+46
sub	w6, w3, #0x17
sub	x5, x5, w3, uxtw #1
add	x6, x2, w6, sxtw #1
ld1	{ v3.8h, v4.8h, v5.8h }, [x5]
ld1r	{ v28.8h }, [x6]
bit	v0.16b, v28.16b, v3.16b
bit	v1.16b, v28.16b, v4.16b
bit	v2.16b, v28.16b, v5.16b
L_1344:
ext	v3.16b, v0.16b, v1.16b, #0x2
ext	v4.16b, v1.16b, v2.16b, #0x2
ext	v5.16b, v0.16b, v1.16b, #0x4
ext	v6.16b, v1.16b, v2.16b, #0x4
ext	v16.16b, v0.16b, v1.16b, #0x6
ext	v17.16b, v1.16b, v2.16b, #0x6
ext	v18.16b, v0.16b, v1.16b, #0x8
ext	v19.16b, v1.16b, v2.16b, #0x8
mul	v20.8h, v0.8h, v29.8h
mla	v20.8h, v3.8h, v30.8h
mla	v20.8h, v5.8h, v31.8h
mla	v20.8h, v16.8h, v30.8h
mla	v20.8h, v18.8h, v29.8h
mul	v21.8h, v1.8h, v29.8h
mla	v21.8h, v4.8h, v30.8h
mla	v21.8h, v6.8h, v31.8h
mla	v21.8h, v17.8h, v30.8h
mla	v21.8h, v19.8h, v29.8h
subs	w1, w1, #0x10
mov	v0.16b, v2.16b
mov	v1.16b, v28.16b
mov	v2.16b, v28.16b
urshr	v20.8h, v20.8h, #0x4
urshr	v21.8h, v21.8h, #0x4
sub	w3, w3, #0x10
st1	{ v20.8h, v21.8h }, [x0], #32
b.le	L_13c4
cmp	w3, #0x0
b.ge	L_1344
L_13b8:
subs	w1, w1, #0x8
st1	{ v28.8h }, [x0], #16
b.gt	L_13b8
L_13c4:
ret
ipred_pixel_set_16bpc_neon:
dup	v0.8h, w1
L_13cc:
subs	w2, w2, #0x8
st1	{ v0.8h }, [x0], #16
b.gt	L_13cc
ret
ipred_z1_fill1_16bpc_neon:
clz	w9, w3
adrp	x8, ipred_z1_fill1_tbl
add	x8, x8, :lo12:ipred_z1_fill1_tbl
sub	w9, w9, #0x19
ldrsw	x9, [x8, w9, uxtw #2]
add	x10, x2, w6, uxtw #1
add	x8, x8, x9
ld1r	{ v31.8h }, [x10]
mov	w7, w5
mov	w15, #0x40
br	x8
L_1408:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_147c
lsl	w8, w8, #1
lsl	w10, w10, #1
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup	v4.4h, w9
dup	v5.4h, w11
ext	v1.16b, v0.16b, v0.16b, #0x2
ext	v3.16b, v2.16b, v2.16b, #0x2
sub	v6.4h, v1.4h, v0.4h
sub	v7.4h, v3.4h, v2.4h
ushll	v16.4s, v0.4h, #0x6
ushll	v17.4s, v2.4h, #0x6
smlal	v16.4s, v6.4h, v4.4h
smlal	v17.4s, v7.4h, v5.4h
rshrn	v16.4h, v16.4s, #0x6
rshrn	v17.4h, v17.4s, #0x6
st1	{ v16.4h }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.4h }, [x0], x1
b.gt	L_1408
ret
L_147c:
st1	{ v31.4h }, [x0], x1
subs	w4, w4, #0x2
st1	{ v31.4h }, [x0], x1
b.gt	L_147c
ret
L_1490:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_152c
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup	v4.8h, w9
dup	v5.8h, w11
ld1	{ v0.8h }, [x8]
ld1	{ v2.8h }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
ldr	h1, [x8, #0x10]
ldr	h3, [x10, #0x10]
dup	v6.8h, w9
dup	v7.8h, w11
ext	v1.16b, v0.16b, v1.16b, #0x2
ext	v3.16b, v2.16b, v3.16b, #0x2
umull	v16.4s, v0.4h, v6.4h
umlal	v16.4s, v1.4h, v4.4h
umull2	v17.4s, v0.8h, v6.8h
umlal2	v17.4s, v1.8h, v4.8h
umull	v18.4s, v2.4h, v7.4h
umlal	v18.4s, v3.4h, v5.4h
umull2	v19.4s, v2.8h, v7.8h
umlal2	v19.4s, v3.8h, v5.8h
rshrn	v16.4h, v16.4s, #0x6
rshrn2	v16.8h, v17.4s, #0x6
rshrn	v17.4h, v18.4s, #0x6
rshrn2	v17.8h, v19.4s, #0x6
st1	{ v16.8h }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.8h }, [x0], x1
b.gt	L_1490
ret
L_152c:
st1	{ v31.8h }, [x0], x1
subs	w4, w4, #0x2
st1	{ v31.8h }, [x0], x1
b.gt	L_152c
ret
L_1540:
mov	w12, w3
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w3, uxtw #1
L_1550:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_1648
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup	v6.8h, w9
dup	v7.8h, w11
ld1	{ v0.8h, v1.8h, v2.8h }, [x8], #48
ld1	{ v3.8h, v4.8h, v5.8h }, [x10], #48
sub	w9, w15, w9
sub	w11, w15, w11
dup	v16.8h, w9
dup	v17.8h, w11
add	w7, w7, w5
L_1598:
ext	v18.16b, v0.16b, v1.16b, #0x2
ext	v19.16b, v1.16b, v2.16b, #0x2
ext	v20.16b, v3.16b, v4.16b, #0x2
ext	v21.16b, v4.16b, v5.16b, #0x2
subs	w3, w3, #0x10
umull	v22.4s, v0.4h, v16.4h
umlal	v22.4s, v18.4h, v6.4h
umull2	v23.4s, v0.8h, v16.8h
umlal2	v23.4s, v18.8h, v6.8h
umull	v24.4s, v1.4h, v16.4h
umlal	v24.4s, v19.4h, v6.4h
umull2	v25.4s, v1.8h, v16.8h
umlal2	v25.4s, v19.8h, v6.8h
umull	v26.4s, v3.4h, v17.4h
umlal	v26.4s, v20.4h, v7.4h
umull2	v27.4s, v3.8h, v17.8h
umlal2	v27.4s, v20.8h, v7.8h
umull	v28.4s, v4.4h, v17.4h
umlal	v28.4s, v21.4h, v7.4h
umull2	v29.4s, v4.8h, v17.8h
umlal2	v29.4s, v21.8h, v7.8h
rshrn	v22.4h, v22.4s, #0x6
rshrn2	v22.8h, v23.4s, #0x6
rshrn	v23.4h, v24.4s, #0x6
rshrn2	v23.8h, v25.4s, #0x6
rshrn	v24.4h, v26.4s, #0x6
rshrn2	v24.8h, v27.4s, #0x6
rshrn	v25.4h, v28.4s, #0x6
rshrn2	v25.8h, v29.4s, #0x6
st1	{ v22.8h, v23.8h }, [x0], #32
st1	{ v24.8h, v25.8h }, [x13], #32
b.le	L_162c
mov	v0.16b, v2.16b
ld1	{ v1.8h, v2.8h }, [x8], #32
mov	v3.16b, v5.16b
ld1	{ v4.8h, v5.8h }, [x10], #32
b	L_1598
L_162c:
subs	w4, w4, #0x2
b.le	L_1644
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	L_1550
L_1644:
ret
L_1648:
st1	{ v31.8h }, [x0], #16
subs	w3, w3, #0x8
st1	{ v31.8h }, [x13], #16
b.gt	L_1648
subs	w4, w4, #0x2
b.le	L_1644
add	x0, x0, x1
add	x13, x13, x1
mov	w3, w12
b	L_1648
ipred_z1_fill2_16bpc_neon:
cmp	w3, #0x8
add	x10, x2, w6, uxtw
ld1r	{ v31.16b }, [x10]
mov	w7, w5
mov	w15, #0x40
b.eq	L_1718
L_1688:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_1704
lsl	w8, w8, #1
lsl	w10, w10, #1
ldr	q0, [x2, w8, uxtw]
ldr	q2, [x2, w10, uxtw]
dup	v4.4h, w9
dup	v5.4h, w11
uzp2	v1.8h, v0.8h, v0.8h
uzp1	v0.8h, v0.8h, v0.8h
uzp2	v3.8h, v2.8h, v2.8h
uzp1	v2.8h, v2.8h, v2.8h
sub	v6.4h, v1.4h, v0.4h
sub	v7.4h, v3.4h, v2.4h
ushll	v16.4s, v0.4h, #0x6
ushll	v17.4s, v2.4h, #0x6
smlal	v16.4s, v6.4h, v4.4h
smlal	v17.4s, v7.4h, v5.4h
rshrn	v16.4h, v16.4s, #0x6
rshrn	v17.4h, v17.4s, #0x6
st1	{ v16.4h }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.4h }, [x0], x1
b.gt	L_1688
ret
L_1704:
st1	{ v31.4h }, [x0], x1
subs	w4, w4, #0x2
st1	{ v31.4h }, [x0], x1
b.gt	L_1704
ret
L_1718:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	L_17b4
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup	v4.8h, w9
dup	v5.8h, w11
ld1	{ v0.8h, v1.8h }, [x8]
ld1	{ v2.8h, v3.8h }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
dup	v6.8h, w9
dup	v7.8h, w11
uzp2	v20.8h, v0.8h, v1.8h
uzp1	v0.8h, v0.8h, v1.8h
uzp2	v21.8h, v2.8h, v3.8h
uzp1	v2.8h, v2.8h, v3.8h
umull	v16.4s, v0.4h, v6.4h
umlal	v16.4s, v20.4h, v4.4h
umull2	v17.4s, v0.8h, v6.8h
umlal2	v17.4s, v20.8h, v4.8h
umull	v18.4s, v2.4h, v7.4h
umlal	v18.4s, v21.4h, v5.4h
umull2	v19.4s, v2.8h, v7.8h
umlal2	v19.4s, v21.8h, v5.8h
rshrn	v16.4h, v16.4s, #0x6
rshrn2	v16.8h, v17.4s, #0x6
rshrn	v17.4h, v18.4s, #0x6
rshrn2	v17.8h, v19.4s, #0x6
st1	{ v16.8h }, [x0], x1
add	w7, w7, w5
subs	w4, w4, #0x2
st1	{ v17.8h }, [x0], x1
b.gt	L_1718
ret
L_17b4:
st1	{ v31.8h }, [x0], x1
subs	w4, w4, #0x2
st1	{ v31.8h }, [x0], x1
b.gt	L_17b4
ret
ipred_reverse_16bpc_neon:
sub	x1, x1, #0x10
add	x3, x0, #0x8
mov	x4, #0x10
L_17d4:
ld1	{ v0.8h }, [x1]
subs	w2, w2, #0x8
rev64	v0.8h, v0.8h
sub	x1, x1, #0x10
st1	{ v0.d }[1], [x0], x4
st1	{ v0.d }[0], [x3], x4
b.gt	L_17d4
ret
ipred_z2_fill1_16bpc_neon:
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
L_1828:
dup	v30.4h, w7
movi	v17.8b, #0x1
mul	v16.4h, v31.4h, v30.4h
movi	v25.8h, #0x3e
add	v30.4h, v16.4h, v30.4h
ld1	{ v0.8h, v1.8h, v2.8h }, [x3]
movi	v26.8h, #0x40
movi	v19.16b, #0x4
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v30.8b, v25.8b
add	v29.8b, v29.8b, v17.8b
movi	v23.4h, #0x1, lsl #8
shl	v29.8b, v29.8b, #0x1
zip1	v29.8b, v29.8b, v29.8b
movi	v17.8b, #0x2
add	v29.8b, v29.8b, v23.8b
add	v30.8b, v29.8b, v17.8b
add	v28.8b, v29.8b, v19.8b
tbl	v18.8b, { v0.16b }, v29.8b
trn1	v30.2d, v30.2d, v28.2d
sub	v28.4h, v26.4h, v27.4h
trn1	v31.2d, v31.2d, v31.2d
trn1	v27.2d, v27.2d, v27.2d
trn1	v28.2d, v28.2d, v28.2d
movi	v29.16b, #0x4
L_188c:
asr	w9, w8, #6
dup	v16.4h, w8
sub	w8, w8, w6
cmn	w9, #0x4
asr	w11, w8, #6
b.le	L_193c
lsl	w9, w9, #1
lsl	w11, w11, #1
dup	v17.4h, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
trn1	v16.2d, v16.2d, v17.2d
tbl	v19.16b, { v0.16b, v1.16b }, v30.16b
sshr	v20.8h, v16.8h, #0x6
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
and	v16.16b, v16.16b, v25.16b
trn1	v18.2d, v18.2d, v19.2d
trn1	v4.2d, v4.2d, v6.2d
trn1	v5.2d, v5.2d, v7.2d
sub	v17.8h, v26.8h, v16.8h
add	v20.8h, v20.8h, v31.8h
umull	v21.4s, v18.4h, v28.4h
umlal	v21.4s, v19.4h, v27.4h
umull2	v22.4s, v18.8h, v28.8h
umlal2	v22.4s, v19.8h, v27.8h
umull	v23.4s, v4.4h, v17.4h
umlal	v23.4s, v5.4h, v16.4h
umull2	v24.4s, v4.8h, v17.8h
umlal2	v24.4s, v5.8h, v16.8h
cmge	v20.8h, v20.8h, #0
rshrn	v21.4h, v21.4s, #0x6
rshrn2	v21.8h, v22.4s, #0x6
rshrn	v22.4h, v23.4s, #0x6
rshrn2	v22.8h, v24.4s, #0x6
bit	v21.16b, v22.16b, v20.16b
st1	{ v21.d }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v21.d }[1], [x0], x1
b.le	L_1978
ext	v18.16b, v19.16b, v19.16b, #0x8
add	v30.16b, v30.16b, v29.16b
b	L_188c
L_193c:
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
trn1	v18.2d, v18.2d, v19.2d
umull	v20.4s, v18.4h, v28.4h
umlal	v20.4s, v19.4h, v27.4h
umull2	v21.4s, v18.8h, v28.8h
umlal2	v21.4s, v19.8h, v27.8h
rshrn	v20.4h, v20.4s, #0x6
rshrn2	v20.8h, v21.4s, #0x6
st1	{ v20.d }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v20.d }[1], [x0], x1
b.le	L_1978
ext	v18.16b, v19.16b, v19.16b, #0x8
add	v30.16b, v30.16b, v29.16b
b	L_193c
L_1978:
ret
L_197c:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
dup	v18.8h, w7
add	x3, x3, #0x2
mul	v16.8h, v31.8h, v18.8h
movi	v25.8h, #0x3e
add	v16.8h, v16.8h, v18.8h
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x3]
ld1r	{ v15.8h }, [x2]
movi	v26.8h, #0x40
movi	v19.16b, #0x4
shrn	v29.8b, v16.8h, #0x6
and	v27.16b, v16.16b, v25.16b
movi	v23.8h, #0x1, lsl #8
shl	v29.8b, v29.8b, #0x1
mov	v18.16b, v15.16b
zip1	v29.16b, v29.16b, v29.16b
movi	v17.16b, #0x2
add	v29.16b, v29.16b, v23.16b
tbx	v18.16b, { v0.16b }, v29.16b
add	v30.16b, v29.16b, v19.16b
add	v29.16b, v29.16b, v17.16b
sub	v28.8h, v26.8h, v27.8h
movi	v24.16b, #0x4
L_19e4:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x10
asr	w11, w8, #6
b.le	L_1adc
dup	v17.8h, w8
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
ld1	{ v4.8h, v5.8h }, [x9]
mov	v19.16b, v15.16b
ld1	{ v6.8h, v7.8h }, [x11]
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
mov	v20.16b, v15.16b
sshr	v21.8h, v16.8h, #0x6
sshr	v22.8h, v17.8h, #0x6
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v30.16b
ext	v5.16b, v4.16b, v5.16b, #0x2
ext	v7.16b, v6.16b, v7.16b, #0x2
and	v16.16b, v16.16b, v25.16b
and	v17.16b, v17.16b, v25.16b
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
sub	v8.8h, v26.8h, v16.8h
sub	v9.8h, v26.8h, v17.8h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
add	v21.8h, v21.8h, v31.8h
add	v22.8h, v22.8h, v31.8h
umull	v12.4s, v19.4h, v28.4h
umlal	v12.4s, v20.4h, v27.4h
umull2	v13.4s, v19.8h, v28.8h
umlal2	v13.4s, v20.8h, v27.8h
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
umull	v12.4s, v4.4h, v8.4h
umlal	v12.4s, v5.4h, v16.4h
umull2	v13.4s, v4.8h, v8.8h
umlal2	v13.4s, v5.8h, v16.8h
umull	v14.4s, v6.4h, v9.4h
umlal	v14.4s, v7.4h, v17.4h
umull2	v18.4s, v6.8h, v9.8h
umlal2	v18.4s, v7.8h, v17.8h
cmge	v21.8h, v21.8h, #0
cmge	v22.8h, v22.8h, #0
rshrn	v12.4h, v12.4s, #0x6
rshrn2	v12.8h, v13.4s, #0x6
rshrn	v13.4h, v14.4s, #0x6
rshrn2	v13.8h, v18.4s, #0x6
bit	v10.16b, v12.16b, v21.16b
bit	v11.16b, v13.16b, v22.16b
st1	{ v10.8h }, [x0], x1
subs	w5, w5, #0x2
sub	w8, w8, w6
st1	{ v11.8h }, [x0], x1
b.le	L_1b3c
mov	v18.16b, v20.16b
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_19e4
L_1adc:
mov	v19.16b, v15.16b
mov	v20.16b, v15.16b
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v30.16b
umull	v4.4s, v18.4h, v28.4h
umlal	v4.4s, v19.4h, v27.4h
umull2	v5.4s, v18.8h, v28.8h
umlal2	v5.4s, v19.8h, v27.8h
umull	v6.4s, v19.4h, v28.4h
umlal	v6.4s, v20.4h, v27.4h
umull2	v7.4s, v19.8h, v28.8h
umlal2	v7.4s, v20.8h, v27.8h
rshrn	v4.4h, v4.4s, #0x6
rshrn2	v4.8h, v5.4s, #0x6
rshrn	v5.4h, v6.4s, #0x6
rshrn2	v5.8h, v7.4s, #0x6
st1	{ v4.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.8h }, [x0], x1
b.le	L_1b3c
mov	v18.16b, v20.16b
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_1adc
L_1b3c:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
L_1b50:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
dup	v25.8h, w7
add	x3, x3, #0x2
add	x13, x0, x1
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw #1
movi	v11.8h, #0x8
mul	v26.8h, v31.8h, v25.8h
add	v26.8h, v26.8h, v25.8h
mul	v25.8h, v25.8h, v11.8h
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x3]
ld1r	{ v15.8h }, [x2]
mov	w12, w4
neg	w14, w4
L_1b94:
mov	v23.16b, v26.16b
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmp	w9, w14
asr	w11, w8, #6
b.le	L_1dd8
dup	v17.8h, w8
sub	w8, w8, w6
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
sshr	v21.8h, v16.8h, #0x6
sshr	v22.8h, v17.8h, #0x6
ld1	{ v4.8h }, [x9], #16
ld1	{ v6.8h }, [x11], #16
movi	v10.8h, #0x3e
movi	v11.8h, #0x40
and	v16.16b, v16.16b, v10.16b
and	v17.16b, v17.16b, v10.16b
sub	v8.8h, v11.8h, v16.8h
sub	v9.8h, v11.8h, v17.8h
add	v21.8h, v21.8h, v31.8h
add	v22.8h, v22.8h, v31.8h
L_1bf0:
smov	w10, v22.h[0]
shrn	v29.8b, v23.8h, #0x6
movi	v12.8h, #0x40
cmp	w10, #0x0
smov	w10, v29.b[0]
movi	v10.8h, #0x3e
b.ge	L_1d7c
and	v27.16b, v23.16b, v10.16b
cmp	w10, #0x1d
mov	v18.16b, v15.16b
sub	v28.8h, v12.8h, v27.8h
b.gt	L_1c54
shl	v29.8b, v29.8b, #0x1
movi	v11.8h, #0x1, lsl #8
zip1	v29.16b, v29.16b, v29.16b
add	v29.16b, v29.16b, v11.16b
movi	v13.16b, #0x2
tbx	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v13.16b
mov	v19.16b, v15.16b
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v13.16b
mov	v20.16b, v15.16b
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
b	L_1cb0
L_1c54:
smov	w15, v29.b[1]
smov	w16, v29.b[2]
add	x10, x3, w10, sxtw #1
smov	w17, v29.b[3]
add	x15, x3, w15, sxtw #1
ld3	{ v18.h, v19.h, v20.h }[0], [x10]
smov	w10, v29.b[4]
add	x16, x3, w16, sxtw #1
ld3	{ v18.h, v19.h, v20.h }[1], [x15]
smov	w15, v29.b[5]
add	x17, x3, w17, sxtw #1
ld3	{ v18.h, v19.h, v20.h }[2], [x16]
smov	w16, v29.b[6]
add	x10, x3, w10, sxtw #1
ld3	{ v18.h, v19.h, v20.h }[3], [x17]
smov	w17, v29.b[7]
add	x15, x3, w15, sxtw #1
add	x16, x3, w16, sxtw #1
ld3	{ v18.h, v19.h, v20.h }[4], [x10]
add	x17, x3, w17, sxtw #1
ld3	{ v18.h, v19.h, v20.h }[5], [x15]
ld3	{ v18.h, v19.h, v20.h }[6], [x16]
ld3	{ v18.h, v19.h, v20.h }[7], [x17]
L_1cb0:
ld1	{ v5.8h }, [x9], #16
ld1	{ v7.8h }, [x11], #16
add	v23.8h, v23.8h, v25.8h
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
umull	v12.4s, v19.4h, v28.4h
umlal	v12.4s, v20.4h, v27.4h
umull2	v13.4s, v19.8h, v28.8h
umlal2	v13.4s, v20.8h, v27.8h
ext	v18.16b, v4.16b, v5.16b, #0x2
ext	v19.16b, v6.16b, v7.16b, #0x2
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
umull	v12.4s, v4.4h, v8.4h
umlal	v12.4s, v18.4h, v16.4h
umull2	v13.4s, v4.8h, v8.8h
umlal2	v13.4s, v18.8h, v16.8h
umull	v14.4s, v6.4h, v9.4h
umlal	v14.4s, v19.4h, v17.4h
umull2	v20.4s, v6.8h, v9.8h
umlal2	v20.4s, v19.8h, v17.8h
cmge	v18.8h, v21.8h, #0
cmge	v19.8h, v22.8h, #0
rshrn	v12.4h, v12.4s, #0x6
rshrn2	v12.8h, v13.4s, #0x6
rshrn	v13.4h, v14.4s, #0x6
rshrn2	v13.8h, v20.4s, #0x6
bit	v10.16b, v12.16b, v18.16b
bit	v11.16b, v13.16b, v19.16b
st1	{ v10.8h }, [x0], #16
subs	w4, w4, #0x8
st1	{ v11.8h }, [x13], #16
b.le	L_1d5c
movi	v10.8h, #0x8
mov	v4.16b, v5.16b
mov	v6.16b, v7.16b
add	v21.8h, v21.8h, v10.8h
add	v22.8h, v22.8h, v10.8h
b	L_1bf0
L_1d5c:
subs	w5, w5, #0x2
b.le	L_20b4
movi	v10.8h, #0x80
add	x0, x0, x1
add	x13, x13, x1
mov	w4, w12
add	v26.8h, v26.8h, v10.8h
b	L_1b94
L_1d7c:
ld1	{ v5.8h }, [x9], #16
ld1	{ v7.8h }, [x11], #16
ext	v18.16b, v4.16b, v5.16b, #0x2
ext	v19.16b, v6.16b, v7.16b, #0x2
umull	v12.4s, v4.4h, v8.4h
umlal	v12.4s, v18.4h, v16.4h
umull2	v13.4s, v4.8h, v8.8h
umlal2	v13.4s, v18.8h, v16.8h
umull	v14.4s, v6.4h, v9.4h
umlal	v14.4s, v19.4h, v17.4h
umull2	v20.4s, v6.8h, v9.8h
umlal2	v20.4s, v19.8h, v17.8h
rshrn	v12.4h, v12.4s, #0x6
rshrn2	v12.8h, v13.4s, #0x6
rshrn	v13.4h, v14.4s, #0x6
rshrn2	v13.8h, v20.4s, #0x6
st1	{ v12.8h }, [x0], #16
subs	w4, w4, #0x8
st1	{ v13.8h }, [x13], #16
b.le	L_1d5c
mov	v4.16b, v5.16b
mov	v6.16b, v7.16b
b	L_1d7c
L_1dd8:
add	x1, x1, w4, uxtw #1
mov	w12, w5
L_1de0:
movi	v12.8h, #0x40
movi	v10.8h, #0x3e
shrn	v29.8b, v23.8h, #0x6
and	v27.16b, v23.16b, v10.16b
smov	w10, v29.b[0]
shl	v29.8b, v29.8b, #0x1
movi	v11.8h, #0x1, lsl #8
zip1	v29.16b, v29.16b, v29.16b
add	v23.8h, v23.8h, v25.8h
add	v29.16b, v29.16b, v11.16b
cmp	w10, #0x1f
mov	v18.16b, v15.16b
movi	v21.16b, #0x2
sub	v28.8h, v12.8h, v27.8h
b.gt	L_1e90
tbx	v18.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v21.16b
L_1e24:
smov	w10, v29.b[0]
mov	v19.16b, v15.16b
cmp	w10, #0x3c
b.gt	L_1ef8
tbx	v19.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v21.16b
mov	v20.16b, v15.16b
tbx	v20.16b, { v0.16b, v1.16b, v2.16b, v3.16b }, v29.16b
add	v29.16b, v29.16b, v21.16b
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
umull	v12.4s, v19.4h, v28.4h
umlal	v12.4s, v20.4h, v27.4h
umull2	v13.4s, v19.8h, v28.8h
umlal2	v13.4s, v20.8h, v27.8h
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
st1	{ v10.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v11.8h }, [x13], x1
b.le	L_208c
mov	v18.16b, v20.16b
b	L_1e24
L_1e90:
smov	w10, v29.b[0]
smov	w15, v29.b[2]
movi	v21.16b, #0x2
smov	w16, v29.b[4]
add	x10, x3, w10, sxtw
smov	w17, v29.b[6]
add	x15, x3, w15, sxtw
ld1	{ v18.h }[0], [x10]
smov	w10, v29.b[8]
add	x16, x3, w16, sxtw
ld1	{ v18.h }[1], [x15]
smov	w15, v29.b[10]
add	x17, x3, w17, sxtw
ld1	{ v18.h }[2], [x16]
smov	w16, v29.b[12]
add	x10, x3, w10, sxtw
ld1	{ v18.h }[3], [x17]
smov	w17, v29.b[14]
add	x15, x3, w15, sxtw
add	x16, x3, w16, sxtw
ld1	{ v18.h }[4], [x10]
add	x17, x3, w17, sxtw
ld1	{ v18.h }[5], [x15]
add	v29.16b, v29.16b, v21.16b
ld1	{ v18.h }[6], [x16]
ld1	{ v18.h }[7], [x17]
L_1ef8:
cmp	w5, #0x4
b.lt	L_1fec
L_1f00:
smov	w10, v29.b[0]
subs	w5, w5, #0x4
smov	w15, v29.b[2]
movi	v10.16b, #0x8
smov	w16, v29.b[4]
add	x10, x3, w10, sxtw
smov	w17, v29.b[6]
add	x15, x3, w15, sxtw
ld4	{ v19.h, v20.h, v21.h, v22.h }[0], [x10]
smov	w10, v29.b[8]
add	x16, x3, w16, sxtw
ld4	{ v19.h, v20.h, v21.h, v22.h }[1], [x15]
smov	w15, v29.b[10]
add	x17, x3, w17, sxtw
ld4	{ v19.h, v20.h, v21.h, v22.h }[2], [x16]
smov	w16, v29.b[12]
add	x10, x3, w10, sxtw
ld4	{ v19.h, v20.h, v21.h, v22.h }[3], [x17]
smov	w17, v29.b[14]
add	x15, x3, w15, sxtw
add	x16, x3, w16, sxtw
ld4	{ v19.h, v20.h, v21.h, v22.h }[4], [x10]
add	x17, x3, w17, sxtw
ld4	{ v19.h, v20.h, v21.h, v22.h }[5], [x15]
ld4	{ v19.h, v20.h, v21.h, v22.h }[6], [x16]
add	v29.16b, v29.16b, v10.16b
ld4	{ v19.h, v20.h, v21.h, v22.h }[7], [x17]
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
umull	v12.4s, v19.4h, v28.4h
umlal	v12.4s, v20.4h, v27.4h
umull2	v13.4s, v19.8h, v28.8h
umlal2	v13.4s, v20.8h, v27.8h
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
umull	v12.4s, v20.4h, v28.4h
umlal	v12.4s, v21.4h, v27.4h
umull2	v13.4s, v20.8h, v28.8h
umlal2	v13.4s, v21.8h, v27.8h
umull	v14.4s, v21.4h, v28.4h
umlal	v14.4s, v22.4h, v27.4h
umull2	v18.4s, v21.8h, v28.8h
umlal2	v18.4s, v22.8h, v27.8h
rshrn	v12.4h, v12.4s, #0x6
rshrn2	v12.8h, v13.4s, #0x6
rshrn	v13.4h, v14.4s, #0x6
rshrn2	v13.8h, v18.4s, #0x6
st1	{ v10.8h }, [x0], x1
cmp	w5, #0x2
st1	{ v11.8h }, [x13], x1
st1	{ v12.8h }, [x0], x1
st1	{ v13.8h }, [x13], x1
b.lt	L_208c
mov	v18.16b, v22.16b
b.gt	L_1f00
L_1fec:
smov	w10, v29.b[0]
smov	w15, v29.b[2]
movi	v21.16b, #0x4
smov	w16, v29.b[4]
add	x10, x3, w10, sxtw
smov	w17, v29.b[6]
add	x15, x3, w15, sxtw
ld2	{ v19.h, v20.h }[0], [x10]
smov	w10, v29.b[8]
add	x16, x3, w16, sxtw
ld2	{ v19.h, v20.h }[1], [x15]
smov	w15, v29.b[10]
add	x17, x3, w17, sxtw
ld2	{ v19.h, v20.h }[2], [x16]
smov	w16, v29.b[12]
add	x10, x3, w10, sxtw
ld2	{ v19.h, v20.h }[3], [x17]
smov	w17, v29.b[14]
add	x15, x3, w15, sxtw
add	x16, x3, w16, sxtw
ld2	{ v19.h, v20.h }[4], [x10]
add	x17, x3, w17, sxtw
ld2	{ v19.h, v20.h }[5], [x15]
ld2	{ v19.h, v20.h }[6], [x16]
add	v29.16b, v29.16b, v21.16b
ld2	{ v19.h, v20.h }[7], [x17]
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
umull	v12.4s, v19.4h, v28.4h
umlal	v12.4s, v20.4h, v27.4h
umull2	v13.4s, v19.8h, v28.8h
umlal2	v13.4s, v20.8h, v27.8h
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
st1	{ v10.8h }, [x0], x1
st1	{ v11.8h }, [x13], x1
L_208c:
subs	w4, w4, #0x8
b.le	L_20b4
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #0x10
add	x13, x13, #0x10
mov	w5, w12
b	L_1de0
L_20b4:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
ipred_z2_fill2_16bpc_neon:
cmp	w4, #0x8
mov	w8, #0x80
sub	w8, w8, w6
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1	{ v31.8h }, [x11]
neg	w7, w7
b.eq	L_2238
dup	v30.4h, w7
movi	v17.8b, #0x1
mul	v16.4h, v31.4h, v30.4h
movi	v25.8h, #0x3e
add	v30.4h, v16.4h, v30.4h
ld1	{ v0.8h, v1.8h }, [x3]
movi	v26.8h, #0x40
movi	v19.16b, #0x4
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v30.8b, v25.8b
add	v29.8b, v29.8b, v17.8b
movi	v23.4h, #0x1, lsl #8
shl	v29.8b, v29.8b, #0x1
zip1	v29.8b, v29.8b, v29.8b
movi	v17.8b, #0x2
add	v29.8b, v29.8b, v23.8b
add	v30.8b, v29.8b, v17.8b
add	v28.8b, v29.8b, v19.8b
tbl	v18.8b, { v0.16b }, v29.8b
trn1	v30.2d, v30.2d, v28.2d
sub	v28.4h, v26.4h, v27.4h
trn1	v31.2d, v31.2d, v31.2d
trn1	v27.2d, v27.2d, v27.2d
trn1	v28.2d, v28.2d, v28.2d
movi	v29.16b, #0x4
add	v31.8h, v31.8h, v31.8h
L_2150:
asr	w9, w8, #6
dup	v16.4h, w8
sub	w8, w8, w6
cmn	w9, #0x8
asr	w11, w8, #6
b.le	L_21f8
lsl	w9, w9, #1
lsl	w11, w11, #1
dup	v17.4h, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
trn1	v16.2d, v16.2d, v17.2d
tbl	v19.16b, { v0.16b, v1.16b }, v30.16b
sshr	v20.8h, v16.8h, #0x6
uzp2	v5.8h, v4.8h, v6.8h
uzp1	v4.8h, v4.8h, v6.8h
and	v16.16b, v16.16b, v25.16b
trn1	v18.2d, v18.2d, v19.2d
sub	v17.8h, v26.8h, v16.8h
add	v20.8h, v20.8h, v31.8h
umull	v21.4s, v18.4h, v28.4h
umlal	v21.4s, v19.4h, v27.4h
umull2	v22.4s, v18.8h, v28.8h
umlal2	v22.4s, v19.8h, v27.8h
umull	v23.4s, v4.4h, v17.4h
umlal	v23.4s, v5.4h, v16.4h
umull2	v24.4s, v4.8h, v17.8h
umlal2	v24.4s, v5.8h, v16.8h
cmge	v20.8h, v20.8h, #0
rshrn	v21.4h, v21.4s, #0x6
rshrn2	v21.8h, v22.4s, #0x6
rshrn	v22.4h, v23.4s, #0x6
rshrn2	v22.8h, v24.4s, #0x6
bit	v21.16b, v22.16b, v20.16b
st1	{ v21.d }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v21.d }[1], [x0], x1
b.le	L_2234
ext	v18.16b, v19.16b, v19.16b, #0x8
add	v30.16b, v30.16b, v29.16b
b	L_2150
L_21f8:
tbl	v19.16b, { v0.16b, v1.16b }, v30.16b
trn1	v18.2d, v18.2d, v19.2d
umull	v20.4s, v18.4h, v28.4h
umlal	v20.4s, v19.4h, v27.4h
umull2	v21.4s, v18.8h, v28.8h
umlal2	v21.4s, v19.8h, v27.8h
rshrn	v20.4h, v20.4s, #0x6
rshrn2	v20.8h, v21.4s, #0x6
st1	{ v20.d }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v20.d }[1], [x0], x1
b.le	L_2234
ext	v18.16b, v19.16b, v19.16b, #0x8
add	v30.16b, v30.16b, v29.16b
b	L_21f8
L_2234:
ret
L_2238:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
dup	v18.8h, w7
movi	v17.8b, #0x1
mul	v16.8h, v31.8h, v18.8h
movi	v25.8h, #0x3e
add	v16.8h, v16.8h, v18.8h
ld1	{ v0.8h, v1.8h }, [x3]
movi	v26.8h, #0x40
movi	v19.16b, #0x4
shrn	v29.8b, v16.8h, #0x6
and	v27.16b, v16.16b, v25.16b
add	v29.8b, v29.8b, v17.8b
movi	v23.8h, #0x1, lsl #8
shl	v29.8b, v29.8b, #0x1
zip1	v29.16b, v29.16b, v29.16b
movi	v17.16b, #0x2
add	v29.16b, v29.16b, v23.16b
tbl	v18.16b, { v0.16b }, v29.16b
add	v30.16b, v29.16b, v19.16b
add	v29.16b, v29.16b, v17.16b
sub	v28.8h, v26.8h, v27.8h
movi	v24.16b, #0x4
add	v31.16b, v31.16b, v31.16b
L_22a0:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x10
asr	w11, w8, #6
b.le	L_23a0
dup	v17.8h, w8
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
ld1	{ v4.8h, v5.8h }, [x9]
ld1	{ v6.8h, v7.8h }, [x11]
tbl	v19.16b, { v0.16b, v1.16b }, v29.16b
sshr	v21.8h, v16.8h, #0x6
sshr	v22.8h, v17.8h, #0x6
tbl	v20.16b, { v0.16b, v1.16b }, v30.16b
uzp2	v2.8h, v4.8h, v5.8h
uzp1	v4.8h, v4.8h, v5.8h
uzp2	v3.8h, v6.8h, v7.8h
uzp1	v6.8h, v6.8h, v7.8h
mov	v5.16b, v2.16b
mov	v7.16b, v3.16b
and	v16.16b, v16.16b, v25.16b
and	v17.16b, v17.16b, v25.16b
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
sub	v8.8h, v26.8h, v16.8h
sub	v9.8h, v26.8h, v17.8h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
add	v21.8h, v21.8h, v31.8h
add	v22.8h, v22.8h, v31.8h
umull	v12.4s, v19.4h, v28.4h
umlal	v12.4s, v20.4h, v27.4h
umull2	v13.4s, v19.8h, v28.8h
umlal2	v13.4s, v20.8h, v27.8h
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
umull	v12.4s, v4.4h, v8.4h
umlal	v12.4s, v5.4h, v16.4h
umull2	v13.4s, v4.8h, v8.8h
umlal2	v13.4s, v5.8h, v16.8h
umull	v14.4s, v6.4h, v9.4h
umlal	v14.4s, v7.4h, v17.4h
umull2	v18.4s, v6.8h, v9.8h
umlal2	v18.4s, v7.8h, v17.8h
cmge	v21.8h, v21.8h, #0
cmge	v22.8h, v22.8h, #0
rshrn	v12.4h, v12.4s, #0x6
rshrn2	v12.8h, v13.4s, #0x6
rshrn	v13.4h, v14.4s, #0x6
rshrn2	v13.8h, v18.4s, #0x6
bit	v10.16b, v12.16b, v21.16b
bit	v11.16b, v13.16b, v22.16b
st1	{ v10.8h }, [x0], x1
subs	w5, w5, #0x2
sub	w8, w8, w6
st1	{ v11.8h }, [x0], x1
b.le	L_23f8
mov	v18.16b, v20.16b
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_22a0
L_23a0:
tbl	v19.16b, { v0.16b, v1.16b }, v29.16b
tbl	v20.16b, { v0.16b, v1.16b }, v30.16b
umull	v4.4s, v18.4h, v28.4h
umlal	v4.4s, v19.4h, v27.4h
umull2	v5.4s, v18.8h, v28.8h
umlal2	v5.4s, v19.8h, v27.8h
umull	v6.4s, v19.4h, v28.4h
umlal	v6.4s, v20.4h, v27.4h
umull2	v7.4s, v19.8h, v28.8h
umlal2	v7.4s, v20.8h, v27.8h
rshrn	v4.4h, v4.4s, #0x6
rshrn2	v4.8h, v5.4s, #0x6
rshrn	v5.4h, v6.4s, #0x6
rshrn2	v5.8h, v7.4s, #0x6
st1	{ v4.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.8h }, [x0], x1
b.le	L_23f8
mov	v18.16b, v20.16b
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_23a0
L_23f8:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
ipred_z2_fill3_16bpc_neon:
cmp	w4, #0x8
mov	w8, #0x40
sub	w8, w8, w6
adrp	x11, increments
add	x11, x11, :lo12:increments
ld1	{ v31.8h }, [x11]
neg	w7, w7
b.eq	L_258c
dup	v30.4h, w7
movi	v17.8b, #0x1
mul	v16.4h, v31.4h, v30.4h
movi	v25.8h, #0x3e
add	v30.4h, v16.4h, v30.4h
ld1	{ v0.8h, v1.8h, v2.8h }, [x3]
movi	v26.8h, #0x40
movi	v19.16b, #0x2
shrn	v29.8b, v30.8h, #0x6
and	v27.8b, v30.8b, v25.8b
add	v29.8b, v29.8b, v19.8b
movi	v23.4h, #0x1, lsl #8
shl	v29.8b, v29.8b, #0x1
movi	v19.16b, #0x4
zip1	v29.8b, v29.8b, v29.8b
movi	v17.8b, #0x2
add	v29.8b, v29.8b, v23.8b
add	v30.8b, v29.8b, v17.8b
add	v28.8b, v29.8b, v19.8b
trn1	v31.2d, v31.2d, v31.2d
add	v24.8b, v30.8b, v19.8b
trn1	v29.2d, v29.2d, v28.2d
trn1	v30.2d, v30.2d, v24.2d
sub	v28.4h, v26.4h, v27.4h
trn1	v27.2d, v27.2d, v27.2d
trn1	v28.2d, v28.2d, v28.2d
movi	v24.16b, #0x8
L_2498:
asr	w9, w8, #6
dup	v16.4h, w8
sub	w8, w8, w6
cmn	w9, #0x4
asr	w11, w8, #6
b.le	L_254c
lsl	w9, w9, #1
lsl	w11, w11, #1
dup	v17.4h, w8
ldr	q4, [x2, w9, sxtw]
ldr	q6, [x2, w11, sxtw]
trn1	v16.2d, v16.2d, v17.2d
tbl	v18.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
sshr	v20.8h, v16.8h, #0x6
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
and	v16.16b, v16.16b, v25.16b
trn1	v4.2d, v4.2d, v6.2d
trn1	v5.2d, v5.2d, v7.2d
sub	v17.8h, v26.8h, v16.8h
add	v20.8h, v20.8h, v31.8h
umull	v21.4s, v18.4h, v28.4h
umlal	v21.4s, v19.4h, v27.4h
umull2	v22.4s, v18.8h, v28.8h
umlal2	v22.4s, v19.8h, v27.8h
umull	v23.4s, v4.4h, v17.4h
umlal	v23.4s, v5.4h, v16.4h
umull2	v24.4s, v4.8h, v17.8h
umlal2	v24.4s, v5.8h, v16.8h
cmge	v20.8h, v20.8h, #0
rshrn	v21.4h, v21.4s, #0x6
rshrn2	v21.8h, v22.4s, #0x6
rshrn	v22.4h, v23.4s, #0x6
rshrn2	v22.8h, v24.4s, #0x6
movi	v24.16b, #0x8
bit	v21.16b, v22.16b, v20.16b
st1	{ v21.d }[0], [x0], x1
sub	w8, w8, w6
subs	w5, w5, #0x2
st1	{ v21.d }[1], [x0], x1
b.le	L_2588
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_2498
L_254c:
tbl	v18.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
umull	v20.4s, v18.4h, v28.4h
umlal	v20.4s, v19.4h, v27.4h
umull2	v21.4s, v18.8h, v28.8h
umlal2	v21.4s, v19.8h, v27.8h
rshrn	v20.4h, v20.4s, #0x6
rshrn2	v20.8h, v21.4s, #0x6
st1	{ v20.d }[0], [x0], x1
subs	w5, w5, #0x2
st1	{ v20.d }[1], [x0], x1
b.le	L_2588
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_254c
L_2588:
ret
L_258c:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
dup	v18.8h, w7
movi	v17.16b, #0x2
mul	v16.8h, v31.8h, v18.8h
movi	v25.8h, #0x3e
add	v16.8h, v16.8h, v18.8h
ld1	{ v0.8h, v1.8h, v2.8h }, [x3]
movi	v26.8h, #0x40
movi	v19.16b, #0x4
shrn	v29.8b, v16.8h, #0x6
and	v27.16b, v16.16b, v25.16b
add	v29.8b, v29.8b, v17.8b
movi	v23.8h, #0x1, lsl #8
shl	v29.8b, v29.8b, #0x1
mov	v18.16b, v15.16b
zip1	v29.16b, v29.16b, v29.16b
add	v29.16b, v29.16b, v23.16b
add	v30.16b, v29.16b, v17.16b
sub	v28.8h, v26.8h, v27.8h
movi	v24.16b, #0x4
L_25e8:
asr	w9, w8, #6
dup	v16.8h, w8
sub	w8, w8, w6
cmn	w9, #0x10
asr	w11, w8, #6
b.le	L_26e4
dup	v17.8h, w8
add	x9, x2, w9, sxtw #1
add	x11, x2, w11, sxtw #1
ld1	{ v4.8h, v5.8h }, [x9]
ld1	{ v6.8h, v7.8h }, [x11]
tbl	v18.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
add	v29.16b, v29.16b, v24.16b
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
add	v30.16b, v30.16b, v24.16b
sshr	v22.8h, v16.8h, #0x6
tbl	v20.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
sshr	v23.8h, v17.8h, #0x6
tbl	v21.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
ext	v5.16b, v4.16b, v5.16b, #0x2
ext	v7.16b, v6.16b, v7.16b, #0x2
and	v16.16b, v16.16b, v25.16b
and	v17.16b, v17.16b, v25.16b
umull	v10.4s, v18.4h, v28.4h
umlal	v10.4s, v19.4h, v27.4h
sub	v8.8h, v26.8h, v16.8h
sub	v9.8h, v26.8h, v17.8h
umull2	v11.4s, v18.8h, v28.8h
umlal2	v11.4s, v19.8h, v27.8h
add	v22.8h, v22.8h, v31.8h
add	v23.8h, v23.8h, v31.8h
umull	v12.4s, v20.4h, v28.4h
umlal	v12.4s, v21.4h, v27.4h
umull2	v13.4s, v20.8h, v28.8h
umlal2	v13.4s, v21.8h, v27.8h
rshrn	v10.4h, v10.4s, #0x6
rshrn2	v10.8h, v11.4s, #0x6
rshrn	v11.4h, v12.4s, #0x6
rshrn2	v11.8h, v13.4s, #0x6
umull	v12.4s, v4.4h, v8.4h
umlal	v12.4s, v5.4h, v16.4h
umull2	v13.4s, v4.8h, v8.8h
umlal2	v13.4s, v5.8h, v16.8h
umull	v14.4s, v6.4h, v9.4h
umlal	v14.4s, v7.4h, v17.4h
umull2	v18.4s, v6.8h, v9.8h
umlal2	v18.4s, v7.8h, v17.8h
cmge	v22.8h, v22.8h, #0
cmge	v23.8h, v23.8h, #0
rshrn	v12.4h, v12.4s, #0x6
rshrn2	v12.8h, v13.4s, #0x6
rshrn	v13.4h, v14.4s, #0x6
rshrn2	v13.8h, v18.4s, #0x6
bit	v10.16b, v12.16b, v22.16b
bit	v11.16b, v13.16b, v23.16b
st1	{ v10.8h }, [x0], x1
subs	w5, w5, #0x2
sub	w8, w8, w6
st1	{ v11.8h }, [x0], x1
b.le	L_2748
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_25e8
L_26e4:
tbl	v18.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
add	v29.16b, v29.16b, v24.16b
tbl	v19.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
add	v30.16b, v30.16b, v24.16b
tbl	v20.16b, { v0.16b, v1.16b, v2.16b }, v29.16b
tbl	v21.16b, { v0.16b, v1.16b, v2.16b }, v30.16b
umull	v4.4s, v18.4h, v28.4h
umlal	v4.4s, v19.4h, v27.4h
umull2	v5.4s, v18.8h, v28.8h
umlal2	v5.4s, v19.8h, v27.8h
umull	v6.4s, v20.4h, v28.4h
umlal	v6.4s, v21.4h, v27.4h
umull2	v7.4s, v20.8h, v28.8h
umlal2	v7.4s, v21.8h, v27.8h
rshrn	v4.4h, v4.4s, #0x6
rshrn2	v4.8h, v5.4s, #0x6
rshrn	v5.4h, v6.4s, #0x6
rshrn2	v5.8h, v7.4s, #0x6
st1	{ v4.8h }, [x0], x1
subs	w5, w5, #0x2
st1	{ v5.8h }, [x0], x1
b.le	L_2748
add	v29.16b, v29.16b, v24.16b
add	v30.16b, v30.16b, v24.16b
b	L_26e4
L_2748:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
ipred_z3_fill1_16bpc_neon:
clz	w9, w4
adrp	x8, ipred_z3_fill1_tbl
add	x8, x8, :lo12:ipred_z3_fill1_tbl
sub	w9, w9, #0x19
ldrsw	x9, [x8, w9, uxtw #2]
add	x10, x2, w6, uxtw #1
add	x8, x8, x9
ld1r	{ v31.8h }, [x10]
mov	w7, w5
mov	w15, #0x40
add	x13, x0, x1
lsl	x1, x1, #1
br	x8
L_2790:
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
dup	v4.8h, w9
dup	v5.8h, w11
ext	v1.16b, v0.16b, v0.16b, #0x2
ext	v3.16b, v2.16b, v2.16b, #0x2
sub	v6.4h, v1.4h, v0.4h
sub	v7.4h, v3.4h, v2.4h
ushll	v16.4s, v0.4h, #0x6
ushll	v17.4s, v2.4h, #0x6
smlal	v16.4s, v6.4h, v4.4h
smlal	v17.4s, v7.4h, v5.4h
rshrn	v16.4h, v16.4s, #0x6
rshrn	v17.4h, v17.4s, #0x6
subs	w3, w3, #0x2
zip1	v18.8h, v16.8h, v17.8h
st1	{ v18.s }[0], [x0], x1
st1	{ v18.s }[1], [x13], x1
add	w7, w7, w5
st1	{ v18.s }[2], [x0]
st1	{ v18.s }[3], [x13]
b.le	L_2820
sub	x0, x0, x1
sub	x13, x13, x1
add	x0, x0, #0x4
add	x13, x13, #0x4
b	L_2790
L_2820:
ret
L_2824:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup	v4.8h, w9
dup	v5.8h, w11
ld1	{ v0.8h }, [x8]
ld1	{ v2.8h }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
ldr	h1, [x8, #0x10]
ldr	h3, [x10, #0x10]
dup	v6.8h, w9
dup	v7.8h, w11
ext	v1.16b, v0.16b, v1.16b, #0x2
ext	v3.16b, v2.16b, v3.16b, #0x2
umull	v16.4s, v0.4h, v6.4h
umlal	v16.4s, v1.4h, v4.4h
umull2	v17.4s, v0.8h, v6.8h
umlal2	v17.4s, v1.8h, v4.8h
umull	v18.4s, v2.4h, v7.4h
umlal	v18.4s, v3.4h, v5.4h
umull2	v19.4s, v2.8h, v7.8h
umlal2	v19.4s, v3.8h, v5.8h
rshrn	v16.4h, v16.4s, #0x6
rshrn2	v16.8h, v17.4s, #0x6
rshrn	v17.4h, v18.4s, #0x6
rshrn2	v17.8h, v19.4s, #0x6
subs	w3, w3, #0x2
zip1	v18.8h, v16.8h, v17.8h
zip2	v19.8h, v16.8h, v17.8h
add	w7, w7, w5
st1	{ v18.s }[0], [x0], x1
st1	{ v18.s }[1], [x13], x1
st1	{ v18.s }[2], [x0], x1
st1	{ v18.s }[3], [x13], x1
st1	{ v19.s }[0], [x0], x1
st1	{ v19.s }[1], [x13], x1
st1	{ v19.s }[2], [x0], x1
st1	{ v19.s }[3], [x13], x1
b.le	L_28f0
sub	x0, x0, x1, lsl #2
sub	x13, x13, x1, lsl #2
add	x0, x0, #0x4
add	x13, x13, #0x4
b	L_2824
L_28f0:
ret
L_28f4:
mov	w12, w4
L_28f8:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup	v6.8h, w9
dup	v7.8h, w11
ld1	{ v0.8h, v1.8h, v2.8h }, [x8], #48
ld1	{ v3.8h, v4.8h, v5.8h }, [x10], #48
sub	w9, w15, w9
sub	w11, w15, w11
dup	v16.8h, w9
dup	v17.8h, w11
add	w7, w7, w5
L_2940:
ext	v18.16b, v0.16b, v1.16b, #0x2
ext	v19.16b, v1.16b, v2.16b, #0x2
ext	v20.16b, v3.16b, v4.16b, #0x2
ext	v21.16b, v4.16b, v5.16b, #0x2
subs	w4, w4, #0x10
umull	v22.4s, v0.4h, v16.4h
umlal	v22.4s, v18.4h, v6.4h
umull2	v23.4s, v0.8h, v16.8h
umlal2	v23.4s, v18.8h, v6.8h
umull	v24.4s, v1.4h, v16.4h
umlal	v24.4s, v19.4h, v6.4h
umull2	v25.4s, v1.8h, v16.8h
umlal2	v25.4s, v19.8h, v6.8h
umull	v26.4s, v3.4h, v17.4h
umlal	v26.4s, v20.4h, v7.4h
umull2	v27.4s, v3.8h, v17.8h
umlal2	v27.4s, v20.8h, v7.8h
umull	v28.4s, v4.4h, v17.4h
umlal	v28.4s, v21.4h, v7.4h
umull2	v29.4s, v4.8h, v17.8h
umlal2	v29.4s, v21.8h, v7.8h
rshrn	v22.4h, v22.4s, #0x6
rshrn2	v22.8h, v23.4s, #0x6
rshrn	v23.4h, v24.4s, #0x6
rshrn2	v23.8h, v25.4s, #0x6
rshrn	v24.4h, v26.4s, #0x6
rshrn2	v24.8h, v27.4s, #0x6
rshrn	v25.4h, v28.4s, #0x6
rshrn2	v25.8h, v29.4s, #0x6
zip1	v18.8h, v22.8h, v24.8h
zip2	v19.8h, v22.8h, v24.8h
zip1	v20.8h, v23.8h, v25.8h
zip2	v21.8h, v23.8h, v25.8h
st1	{ v18.s }[0], [x0], x1
st1	{ v18.s }[1], [x13], x1
st1	{ v18.s }[2], [x0], x1
st1	{ v18.s }[3], [x13], x1
st1	{ v19.s }[0], [x0], x1
st1	{ v19.s }[1], [x13], x1
st1	{ v19.s }[2], [x0], x1
st1	{ v19.s }[3], [x13], x1
st1	{ v20.s }[0], [x0], x1
st1	{ v20.s }[1], [x13], x1
st1	{ v20.s }[2], [x0], x1
st1	{ v20.s }[3], [x13], x1
st1	{ v21.s }[0], [x0], x1
st1	{ v21.s }[1], [x13], x1
st1	{ v21.s }[2], [x0], x1
st1	{ v21.s }[3], [x13], x1
b.le	L_2a1c
mov	v0.16b, v2.16b
ld1	{ v1.8h, v2.8h }, [x8], #32
mov	v3.16b, v5.16b
ld1	{ v4.8h, v5.8h }, [x10], #32
b	L_2940
L_2a1c:
subs	w3, w3, #0x2
b.le	L_2a44
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
lsl	x1, x1, #1
add	x0, x0, #0x4
add	x13, x13, #0x4
mov	w4, w12
b	L_28f8
L_2a44:
ret
ipred_z3_fill_padding_neon:
cmp	w3, #0x8
adrp	x8, ipred_z3_fill_padding_tbl
add	x8, x8, :lo12:ipred_z3_fill_padding_tbl
b.gt	ipred_z3_fill_padding_wide
mov	w12, w4
L_2a5c:
clz	w9, w3
sub	w9, w9, #0x19
ldrsw	x9, [x8, w9, uxtw #2]
add	x9, x8, x9
br	x9
L_2a70:
st1	{ v31.s }[0], [x0], x1
subs	w4, w4, #0x4
st1	{ v31.s }[0], [x13], x1
st1	{ v31.s }[0], [x0], x1
st1	{ v31.s }[0], [x13], x1
b.gt	L_2a70
subs	w3, w3, #0x2
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_2b30
lsl	x1, x1, #1
add	x0, x0, #0x4
add	x13, x13, #0x4
mov	w4, w12
b	L_2a5c
L_2ab0:
st1	{ v31.4h }, [x0], x1
subs	w4, w4, #0x4
st1	{ v31.4h }, [x13], x1
st1	{ v31.4h }, [x0], x1
st1	{ v31.4h }, [x13], x1
b.gt	L_2ab0
subs	w3, w3, #0x4
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_2b30
lsl	x1, x1, #1
add	x0, x0, #0x8
add	x13, x13, #0x8
mov	w4, w12
b	L_2a5c
L_2af0:
st1	{ v31.8h }, [x0], x1
subs	w4, w4, #0x4
st1	{ v31.8h }, [x13], x1
st1	{ v31.8h }, [x0], x1
st1	{ v31.8h }, [x13], x1
b.gt	L_2af0
subs	w3, w3, #0x8
lsr	x1, x1, #1
msub	x0, x1, x12, x0
msub	x13, x1, x12, x13
b.le	L_2b30
lsl	x1, x1, #1
add	x0, x0, #0x10
add	x13, x13, #0x10
mov	w4, w12
b	L_2a5c
L_2b30:
ret
ipred_z3_fill_padding_wide:
lsr	x1, x1, #1
mov	w12, w3
sub	x1, x1, w3, uxtw #1
L_2b40:
ands	w5, w3, #0x7
b.eq	L_2b54
sub	w3, w3, w5
st1	{ v31.8h }, [x0]
add	x0, x0, w5, uxtw #1
L_2b54:
subs	w3, w3, #0x8
st1	{ v31.8h }, [x0], #16
b.gt	L_2b54
subs	w4, w4, #0x1
add	x0, x0, x1
b.le	L_2b74
mov	w3, w12
b	L_2b40
L_2b74:
ret
ipred_z3_fill2_16bpc_neon:
cmp	w4, #0x8
add	x10, x2, w6, uxtw
ld1r	{ v31.16b }, [x10]
mov	w7, w5
mov	w15, #0x40
add	x13, x0, x1
lsl	x1, x1, #1
b.eq	L_2c34
L_2b98:
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
dup	v4.4h, w9
dup	v5.4h, w11
uzp2	v1.8h, v0.8h, v0.8h
uzp1	v0.8h, v0.8h, v0.8h
uzp2	v3.8h, v2.8h, v2.8h
uzp1	v2.8h, v2.8h, v2.8h
sub	v6.4h, v1.4h, v0.4h
sub	v7.4h, v3.4h, v2.4h
ushll	v16.4s, v0.4h, #0x6
ushll	v17.4s, v2.4h, #0x6
smlal	v16.4s, v6.4h, v4.4h
smlal	v17.4s, v7.4h, v5.4h
rshrn	v16.4h, v16.4s, #0x6
rshrn	v17.4h, v17.4s, #0x6
subs	w3, w3, #0x2
zip1	v18.8h, v16.8h, v17.8h
st1	{ v18.s }[0], [x0], x1
st1	{ v18.s }[1], [x13], x1
add	w7, w7, w5
st1	{ v18.s }[2], [x0]
st1	{ v18.s }[3], [x13]
b.le	L_2c30
sub	x0, x0, x1
sub	x13, x13, x1
add	x0, x0, #0x4
add	x13, x13, #0x4
b	L_2b98
L_2c30:
ret
L_2c34:
lsr	w8, w7, #6
and	w9, w7, #0x3e
add	w7, w7, w5
cmp	w8, w6
lsr	w10, w7, #6
and	w11, w7, #0x3e
b.ge	ipred_z3_fill_padding_neon
add	x8, x2, w8, uxtw #1
add	x10, x2, w10, uxtw #1
dup	v4.8h, w9
dup	v5.8h, w11
ld1	{ v0.8h, v1.8h }, [x8]
ld1	{ v2.8h, v3.8h }, [x10]
sub	w9, w15, w9
sub	w11, w15, w11
dup	v6.8h, w9
dup	v7.8h, w11
uzp2	v20.8h, v0.8h, v1.8h
uzp1	v0.8h, v0.8h, v1.8h
uzp2	v21.8h, v2.8h, v3.8h
uzp1	v2.8h, v2.8h, v3.8h
umull	v16.4s, v0.4h, v6.4h
umlal	v16.4s, v20.4h, v4.4h
umull2	v17.4s, v0.8h, v6.8h
umlal2	v17.4s, v20.8h, v4.8h
umull	v18.4s, v2.4h, v7.4h
umlal	v18.4s, v21.4h, v5.4h
umull2	v19.4s, v2.8h, v7.8h
umlal2	v19.4s, v21.8h, v5.8h
rshrn	v16.4h, v16.4s, #0x6
rshrn2	v16.8h, v17.4s, #0x6
rshrn	v17.4h, v18.4s, #0x6
rshrn2	v17.8h, v19.4s, #0x6
subs	w3, w3, #0x2
zip1	v18.8h, v16.8h, v17.8h
zip2	v19.8h, v16.8h, v17.8h
add	w7, w7, w5
st1	{ v18.s }[0], [x0], x1
st1	{ v18.s }[1], [x13], x1
st1	{ v18.s }[2], [x0], x1
st1	{ v18.s }[3], [x13], x1
st1	{ v19.s }[0], [x0], x1
st1	{ v19.s }[1], [x13], x1
st1	{ v19.s }[2], [x0], x1
st1	{ v19.s }[3], [x13], x1
b.le	L_2d00
sub	x0, x0, x1, lsl #2
sub	x13, x13, x1, lsl #2
add	x0, x0, #0x4
add	x13, x13, #0x4
b	L_2c34
L_2d00:
ret
ipred_filter_10bpc_neon:
and	w5, w5, #0x1ff
adrp	x6, filter_intra_taps
add	x6, x6, :lo12:filter_intra_taps
lsl	w5, w5, #6
add	x6, x6, w5, uxtw
ld1	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x6], #32
clz	w9, w3
adrp	x5, ipred_filter10_tbl
add	x5, x5, :lo12:ipred_filter10_tbl
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
dup	v31.8h, w8
movi	v30.8h, #0x0
br	x5
L_2d68:
ldur	d0, [x2, #0x2]
sub	x2, x2, #0x4
mov	x7, #-0x4
L_2d74:
ld1	{ v1.4h }, [x2], x7
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v16.8h, v1.h[2]
mla	v2.8h, v21.8h, v1.h[1]
mla	v2.8h, v22.8h, v1.h[0]
srshr	v2.8h, v2.8h, #0x4
smax	v2.8h, v2.8h, v30.8h
smin	v2.8h, v2.8h, v31.8h
subs	w4, w4, #0x2
st1	{ v2.d }[0], [x0], x1
ext	v0.16b, v2.16b, v2.16b, #0x8
st1	{ v2.d }[1], [x6], x1
b.gt	L_2d74
ret
L_2db8:
ldur	q0, [x2, #0x2]
sub	x2, x2, #0x4
mov	x7, #-0x4
L_2dc4:
ld1	{ v1.4h }, [x2], x7
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v16.8h, v1.h[2]
mla	v2.8h, v21.8h, v1.h[1]
mla	v2.8h, v22.8h, v1.h[0]
mul	v3.8h, v17.8h, v0.h[4]
mla	v3.8h, v18.8h, v0.h[5]
mla	v3.8h, v19.8h, v0.h[6]
srshr	v2.8h, v2.8h, #0x4
smax	v2.8h, v2.8h, v30.8h
smin	v2.8h, v2.8h, v31.8h
mla	v3.8h, v20.8h, v0.h[7]
mla	v3.8h, v16.8h, v0.h[3]
mla	v3.8h, v21.8h, v2.h[3]
mla	v3.8h, v22.8h, v2.h[7]
srshr	v3.8h, v3.8h, #0x4
smax	v3.8h, v3.8h, v30.8h
smin	v3.8h, v3.8h, v31.8h
subs	w4, w4, #0x2
st2	{ v2.d, v3.d }[0], [x0], x1
zip2	v0.2d, v2.2d, v3.2d
st2	{ v2.d, v3.d }[1], [x6], x1
b.gt	L_2dc4
ret
L_2e30:
add	x8, x2, #0x2
sub	x2, x2, #0x4
mov	x7, #-0x4
sub	x1, x1, w3, uxtw #1
mov	w9, w3
L_2e44:
ld1	{ v0.4h }, [x2], x7
L_2e48:
ld1	{ v1.8h, v2.8h }, [x8], #32
mul	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[1]
mla	v3.8h, v22.8h, v0.h[0]
mla	v3.8h, v17.8h, v1.h[0]
mla	v3.8h, v18.8h, v1.h[1]
mla	v3.8h, v19.8h, v1.h[2]
mla	v3.8h, v20.8h, v1.h[3]
mul	v4.8h, v17.8h, v1.h[4]
mla	v4.8h, v18.8h, v1.h[5]
mla	v4.8h, v19.8h, v1.h[6]
srshr	v3.8h, v3.8h, #0x4
smax	v3.8h, v3.8h, v30.8h
smin	v3.8h, v3.8h, v31.8h
mla	v4.8h, v20.8h, v1.h[7]
mla	v4.8h, v16.8h, v1.h[3]
mla	v4.8h, v21.8h, v3.h[3]
mla	v4.8h, v22.8h, v3.h[7]
mul	v5.8h, v17.8h, v2.h[0]
mla	v5.8h, v18.8h, v2.h[1]
mla	v5.8h, v19.8h, v2.h[2]
srshr	v4.8h, v4.8h, #0x4
smax	v4.8h, v4.8h, v30.8h
smin	v4.8h, v4.8h, v31.8h
mla	v5.8h, v20.8h, v2.h[3]
mla	v5.8h, v16.8h, v1.h[7]
mla	v5.8h, v21.8h, v4.h[3]
mla	v5.8h, v22.8h, v4.h[7]
mul	v6.8h, v17.8h, v2.h[4]
mla	v6.8h, v18.8h, v2.h[5]
mla	v6.8h, v19.8h, v2.h[6]
srshr	v5.8h, v5.8h, #0x4
smax	v5.8h, v5.8h, v30.8h
smin	v5.8h, v5.8h, v31.8h
mla	v6.8h, v20.8h, v2.h[7]
mla	v6.8h, v16.8h, v2.h[3]
mla	v6.8h, v21.8h, v5.h[3]
mla	v6.8h, v22.8h, v5.h[7]
subs	w3, w3, #0x10
srshr	v6.8h, v6.8h, #0x4
smax	v6.8h, v6.8h, v30.8h
smin	v6.8h, v6.8h, v31.8h
mov	v0.h[2], v2.h[7]
st4	{ v3.d, v4.d, v5.d, v6.d }[0], [x0], #32
mov	v0.h[0], v6.h[7]
st4	{ v3.d, v4.d, v5.d, v6.d }[1], [x6], #32
mov	v0.h[1], v6.h[3]
b.gt	L_2e48
subs	w4, w4, #0x2
b.le	L_2f24
sub	x8, x6, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	L_2e44
L_2f24:
ret
ipred_filter_12bpc_neon:
and	w5, w5, #0x1ff
adrp	x6, filter_intra_taps
add	x6, x6, :lo12:filter_intra_taps
lsl	w5, w5, #6
add	x6, x6, w5, uxtw
ld1	{ v16.8b, v17.8b, v18.8b, v19.8b }, [x6], #32
clz	w9, w3
adrp	x5, ipred_filter12_tbl
add	x5, x5, :lo12:ipred_filter12_tbl
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
dup	v31.8h, w8
br	x5
L_2f88:
ldur	d0, [x2, #0x2]
sub	x2, x2, #0x4
mov	x7, #-0x4
L_2f94:
ld1	{ v1.4h }, [x2], x7
smull	v2.4s, v17.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v16.4h, v1.h[2]
smlal	v2.4s, v21.4h, v1.h[1]
smlal	v2.4s, v22.4h, v1.h[0]
smull2	v3.4s, v17.8h, v0.h[0]
smlal2	v3.4s, v18.8h, v0.h[1]
smlal2	v3.4s, v19.8h, v0.h[2]
smlal2	v3.4s, v20.8h, v0.h[3]
smlal2	v3.4s, v16.8h, v1.h[2]
smlal2	v3.4s, v21.8h, v1.h[1]
smlal2	v3.4s, v22.8h, v1.h[0]
sqrshrun	v2.4h, v2.4s, #0x4
sqrshrun2	v2.8h, v3.4s, #0x4
smin	v2.8h, v2.8h, v31.8h
subs	w4, w4, #0x2
st1	{ v2.d }[0], [x0], x1
ext	v0.16b, v2.16b, v2.16b, #0x8
st1	{ v2.d }[1], [x6], x1
b.gt	L_2f94
ret
L_2ff4:
ldur	q0, [x2, #0x2]
sub	x2, x2, #0x4
mov	x7, #-0x4
L_3000:
ld1	{ v1.4h }, [x2], x7
smull	v2.4s, v17.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[1]
smlal	v2.4s, v19.4h, v0.h[2]
smlal	v2.4s, v20.4h, v0.h[3]
smlal	v2.4s, v16.4h, v1.h[2]
smlal	v2.4s, v21.4h, v1.h[1]
smlal	v2.4s, v22.4h, v1.h[0]
smull2	v3.4s, v17.8h, v0.h[0]
smlal2	v3.4s, v18.8h, v0.h[1]
smlal2	v3.4s, v19.8h, v0.h[2]
smlal2	v3.4s, v20.8h, v0.h[3]
smlal2	v3.4s, v16.8h, v1.h[2]
smlal2	v3.4s, v21.8h, v1.h[1]
smlal2	v3.4s, v22.8h, v1.h[0]
smull	v4.4s, v17.4h, v0.h[4]
smlal	v4.4s, v18.4h, v0.h[5]
smlal	v4.4s, v19.4h, v0.h[6]
sqrshrun	v2.4h, v2.4s, #0x4
sqrshrun2	v2.8h, v3.4s, #0x4
smin	v2.8h, v2.8h, v31.8h
smlal	v4.4s, v20.4h, v0.h[7]
smlal	v4.4s, v16.4h, v0.h[3]
smlal	v4.4s, v21.4h, v2.h[3]
smlal	v4.4s, v22.4h, v2.h[7]
smull2	v5.4s, v17.8h, v0.h[4]
smlal2	v5.4s, v18.8h, v0.h[5]
smlal2	v5.4s, v19.8h, v0.h[6]
smlal2	v5.4s, v20.8h, v0.h[7]
smlal2	v5.4s, v16.8h, v0.h[3]
smlal2	v5.4s, v21.8h, v2.h[3]
smlal2	v5.4s, v22.8h, v2.h[7]
sqrshrun	v3.4h, v4.4s, #0x4
sqrshrun2	v3.8h, v5.4s, #0x4
smin	v3.8h, v3.8h, v31.8h
subs	w4, w4, #0x2
st2	{ v2.d, v3.d }[0], [x0], x1
zip2	v0.2d, v2.2d, v3.2d
st2	{ v2.d, v3.d }[1], [x6], x1
b.gt	L_3000
ret
L_30a4:
add	x8, x2, #0x2
sub	x2, x2, #0x4
mov	x7, #-0x4
sub	x1, x1, w3, uxtw #1
mov	w9, w3
L_30b8:
ld1	{ v0.4h }, [x2], x7
L_30bc:
ld1	{ v1.8h, v2.8h }, [x8], #32
smull	v3.4s, v16.4h, v0.h[2]
smlal	v3.4s, v21.4h, v0.h[1]
smlal	v3.4s, v22.4h, v0.h[0]
smlal	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smull2	v4.4s, v16.8h, v0.h[2]
smlal2	v4.4s, v21.8h, v0.h[1]
smlal2	v4.4s, v22.8h, v0.h[0]
smlal2	v4.4s, v17.8h, v1.h[0]
smlal2	v4.4s, v18.8h, v1.h[1]
smlal2	v4.4s, v19.8h, v1.h[2]
smlal2	v4.4s, v20.8h, v1.h[3]
smull	v5.4s, v17.4h, v1.h[4]
smlal	v5.4s, v18.4h, v1.h[5]
smlal	v5.4s, v19.4h, v1.h[6]
sqrshrun	v3.4h, v3.4s, #0x4
sqrshrun2	v3.8h, v4.4s, #0x4
smin	v3.8h, v3.8h, v31.8h
smlal	v5.4s, v20.4h, v1.h[7]
smlal	v5.4s, v16.4h, v1.h[3]
smlal	v5.4s, v21.4h, v3.h[3]
smlal	v5.4s, v22.4h, v3.h[7]
smull2	v6.4s, v17.8h, v1.h[4]
smlal2	v6.4s, v18.8h, v1.h[5]
smlal2	v6.4s, v19.8h, v1.h[6]
smlal2	v6.4s, v20.8h, v1.h[7]
smlal2	v6.4s, v16.8h, v1.h[3]
smlal2	v6.4s, v21.8h, v3.h[3]
smlal2	v6.4s, v22.8h, v3.h[7]
smull	v24.4s, v17.4h, v2.h[0]
smlal	v24.4s, v18.4h, v2.h[1]
smlal	v24.4s, v19.4h, v2.h[2]
sqrshrun	v4.4h, v5.4s, #0x4
sqrshrun2	v4.8h, v6.4s, #0x4
smin	v4.8h, v4.8h, v31.8h
smlal	v24.4s, v20.4h, v2.h[3]
smlal	v24.4s, v16.4h, v1.h[7]
smlal	v24.4s, v21.4h, v4.h[3]
smlal	v24.4s, v22.4h, v4.h[7]
smull2	v25.4s, v17.8h, v2.h[0]
smlal2	v25.4s, v18.8h, v2.h[1]
smlal2	v25.4s, v19.8h, v2.h[2]
smlal2	v25.4s, v20.8h, v2.h[3]
smlal2	v25.4s, v16.8h, v1.h[7]
smlal2	v25.4s, v21.8h, v4.h[3]
smlal2	v25.4s, v22.8h, v4.h[7]
smull	v26.4s, v17.4h, v2.h[4]
smlal	v26.4s, v18.4h, v2.h[5]
smlal	v26.4s, v19.4h, v2.h[6]
sqrshrun	v5.4h, v24.4s, #0x4
sqrshrun2	v5.8h, v25.4s, #0x4
smin	v5.8h, v5.8h, v31.8h
smlal	v26.4s, v20.4h, v2.h[7]
smlal	v26.4s, v16.4h, v2.h[3]
smlal	v26.4s, v21.4h, v5.h[3]
smlal	v26.4s, v22.4h, v5.h[7]
smull2	v27.4s, v17.8h, v2.h[4]
smlal2	v27.4s, v18.8h, v2.h[5]
smlal2	v27.4s, v19.8h, v2.h[6]
smlal2	v27.4s, v20.8h, v2.h[7]
smlal2	v27.4s, v16.8h, v2.h[3]
smlal2	v27.4s, v21.8h, v5.h[3]
smlal2	v27.4s, v22.8h, v5.h[7]
subs	w3, w3, #0x10
sqrshrun	v6.4h, v26.4s, #0x4
sqrshrun2	v6.8h, v27.4s, #0x4
smin	v6.8h, v6.8h, v31.8h
mov	v0.h[2], v2.h[7]
st4	{ v3.d, v4.d, v5.d, v6.d }[0], [x0], #32
mov	v0.h[0], v6.h[7]
st4	{ v3.d, v4.d, v5.d, v6.d }[1], [x6], #32
mov	v0.h[1], v6.h[3]
b.gt	L_30bc
subs	w4, w4, #0x2
b.le	L_3208
sub	x8, x6, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b	L_30b8
L_3208:
ret
ipred_filter_16bpc_neon:
ldr	w8, [sp]
cmp	w8, #0x3ff
b.le	ipred_filter_10bpc_neon
b	ipred_filter_12bpc_neon
pal_pred_16bpc_neon:
ld1	{ v30.8h }, [x2]
clz	w9, w4
adrp	x6, pal_pred_tbl
add	x6, x6, :lo12:pal_pred_tbl
sub	w9, w9, #0x19
movi	v29.16b, #0x7
ldrsw	x9, [x6, w9, uxtw #2]
movi	v31.8h, #0x1, lsl #8
add	x6, x6, x9
br	x6
L_3244:
add	x2, x0, x1
lsl	x1, x1, #1
L_324c:
ld1	{ v1.8b }, [x3], #8
subs	w5, w5, #0x4
ushr	v3.8b, v1.8b, #0x4
and	v2.8b, v1.8b, v29.8b
zip1	v1.16b, v2.16b, v3.16b
add	v1.16b, v1.16b, v1.16b
zip1	v0.16b, v1.16b, v1.16b
zip2	v1.16b, v1.16b, v1.16b
add	v0.8h, v0.8h, v31.8h
add	v1.8h, v1.8h, v31.8h
tbl	v0.16b, { v30.16b }, v0.16b
st1	{ v0.d }[0], [x0], x1
tbl	v1.16b, { v30.16b }, v1.16b
st1	{ v0.d }[1], [x2], x1
st1	{ v1.d }[0], [x0], x1
st1	{ v1.d }[1], [x2], x1
b.gt	L_324c
ret
L_3294:
add	x2, x0, x1
lsl	x1, x1, #1
L_329c:
ld1	{ v2.16b }, [x3], #16
subs	w5, w5, #0x4
ushr	v4.16b, v2.16b, #0x4
and	v3.16b, v2.16b, v29.16b
zip1	v2.16b, v3.16b, v4.16b
zip2	v3.16b, v3.16b, v4.16b
add	v2.16b, v2.16b, v2.16b
add	v3.16b, v3.16b, v3.16b
zip1	v0.16b, v2.16b, v2.16b
zip2	v1.16b, v2.16b, v2.16b
zip1	v2.16b, v3.16b, v3.16b
zip2	v3.16b, v3.16b, v3.16b
add	v0.8h, v0.8h, v31.8h
add	v1.8h, v1.8h, v31.8h
add	v2.8h, v2.8h, v31.8h
add	v3.8h, v3.8h, v31.8h
tbl	v0.16b, { v30.16b }, v0.16b
tbl	v1.16b, { v30.16b }, v1.16b
st1	{ v0.8h }, [x0], x1
tbl	v2.16b, { v30.16b }, v2.16b
st1	{ v1.8h }, [x2], x1
tbl	v3.16b, { v30.16b }, v3.16b
st1	{ v2.8h }, [x0], x1
st1	{ v3.8h }, [x2], x1
b.gt	L_329c
ret
L_3304:
add	x2, x0, x1
lsl	x1, x1, #1
L_330c:
ld1	{ v4.16b, v5.16b }, [x3], #32
subs	w5, w5, #0x4
ushr	v7.16b, v4.16b, #0x4
and	v6.16b, v4.16b, v29.16b
ushr	v3.16b, v5.16b, #0x4
and	v2.16b, v5.16b, v29.16b
zip1	v4.16b, v6.16b, v7.16b
zip2	v5.16b, v6.16b, v7.16b
zip1	v6.16b, v2.16b, v3.16b
zip2	v7.16b, v2.16b, v3.16b
add	v4.16b, v4.16b, v4.16b
add	v5.16b, v5.16b, v5.16b
add	v6.16b, v6.16b, v6.16b
add	v7.16b, v7.16b, v7.16b
zip1	v0.16b, v4.16b, v4.16b
zip2	v1.16b, v4.16b, v4.16b
zip1	v2.16b, v5.16b, v5.16b
zip2	v3.16b, v5.16b, v5.16b
zip1	v4.16b, v6.16b, v6.16b
zip2	v5.16b, v6.16b, v6.16b
zip1	v6.16b, v7.16b, v7.16b
zip2	v7.16b, v7.16b, v7.16b
add	v0.8h, v0.8h, v31.8h
add	v1.8h, v1.8h, v31.8h
add	v2.8h, v2.8h, v31.8h
add	v3.8h, v3.8h, v31.8h
add	v4.8h, v4.8h, v31.8h
tbl	v0.16b, { v30.16b }, v0.16b
add	v5.8h, v5.8h, v31.8h
tbl	v1.16b, { v30.16b }, v1.16b
add	v6.8h, v6.8h, v31.8h
tbl	v2.16b, { v30.16b }, v2.16b
add	v7.8h, v7.8h, v31.8h
tbl	v3.16b, { v30.16b }, v3.16b
tbl	v4.16b, { v30.16b }, v4.16b
tbl	v5.16b, { v30.16b }, v5.16b
st1	{ v0.8h, v1.8h }, [x0], x1
tbl	v6.16b, { v30.16b }, v6.16b
st1	{ v2.8h, v3.8h }, [x2], x1
tbl	v7.16b, { v30.16b }, v7.16b
st1	{ v4.8h, v5.8h }, [x0], x1
st1	{ v6.8h, v7.8h }, [x2], x1
b.gt	L_330c
ret
L_33bc:
add	x2, x0, x1
lsl	x1, x1, #1
L_33c4:
ld1	{ v4.16b, v5.16b }, [x3], #32
subs	w5, w5, #0x2
ushr	v7.16b, v4.16b, #0x4
and	v6.16b, v4.16b, v29.16b
ushr	v3.16b, v5.16b, #0x4
and	v2.16b, v5.16b, v29.16b
zip1	v4.16b, v6.16b, v7.16b
zip2	v5.16b, v6.16b, v7.16b
zip1	v6.16b, v2.16b, v3.16b
zip2	v7.16b, v2.16b, v3.16b
add	v4.16b, v4.16b, v4.16b
add	v5.16b, v5.16b, v5.16b
add	v6.16b, v6.16b, v6.16b
add	v7.16b, v7.16b, v7.16b
zip1	v0.16b, v4.16b, v4.16b
zip2	v1.16b, v4.16b, v4.16b
zip1	v2.16b, v5.16b, v5.16b
zip2	v3.16b, v5.16b, v5.16b
zip1	v4.16b, v6.16b, v6.16b
zip2	v5.16b, v6.16b, v6.16b
zip1	v6.16b, v7.16b, v7.16b
zip2	v7.16b, v7.16b, v7.16b
add	v0.8h, v0.8h, v31.8h
add	v1.8h, v1.8h, v31.8h
add	v2.8h, v2.8h, v31.8h
add	v3.8h, v3.8h, v31.8h
add	v4.8h, v4.8h, v31.8h
tbl	v0.16b, { v30.16b }, v0.16b
add	v5.8h, v5.8h, v31.8h
tbl	v1.16b, { v30.16b }, v1.16b
add	v6.8h, v6.8h, v31.8h
tbl	v2.16b, { v30.16b }, v2.16b
add	v7.8h, v7.8h, v31.8h
tbl	v3.16b, { v30.16b }, v3.16b
tbl	v4.16b, { v30.16b }, v4.16b
tbl	v5.16b, { v30.16b }, v5.16b
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
tbl	v6.16b, { v30.16b }, v6.16b
tbl	v7.16b, { v30.16b }, v7.16b
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], x1
b.gt	L_33c4
ret
L_346c:
add	x2, x0, #0x40
L_3470:
ld1	{ v4.16b, v5.16b }, [x3], #32
subs	w5, w5, #0x1
ushr	v7.16b, v4.16b, #0x4
and	v6.16b, v4.16b, v29.16b
ushr	v3.16b, v5.16b, #0x4
and	v2.16b, v5.16b, v29.16b
zip1	v4.16b, v6.16b, v7.16b
zip2	v5.16b, v6.16b, v7.16b
zip1	v6.16b, v2.16b, v3.16b
zip2	v7.16b, v2.16b, v3.16b
add	v4.16b, v4.16b, v4.16b
add	v5.16b, v5.16b, v5.16b
add	v6.16b, v6.16b, v6.16b
add	v7.16b, v7.16b, v7.16b
zip1	v0.16b, v4.16b, v4.16b
zip2	v1.16b, v4.16b, v4.16b
zip1	v2.16b, v5.16b, v5.16b
zip2	v3.16b, v5.16b, v5.16b
zip1	v4.16b, v6.16b, v6.16b
zip2	v5.16b, v6.16b, v6.16b
zip1	v6.16b, v7.16b, v7.16b
zip2	v7.16b, v7.16b, v7.16b
add	v0.8h, v0.8h, v31.8h
add	v1.8h, v1.8h, v31.8h
add	v2.8h, v2.8h, v31.8h
add	v3.8h, v3.8h, v31.8h
add	v4.8h, v4.8h, v31.8h
tbl	v0.16b, { v30.16b }, v0.16b
add	v5.8h, v5.8h, v31.8h
tbl	v1.16b, { v30.16b }, v1.16b
add	v6.8h, v6.8h, v31.8h
tbl	v2.16b, { v30.16b }, v2.16b
add	v7.8h, v7.8h, v31.8h
tbl	v3.16b, { v30.16b }, v3.16b
tbl	v4.16b, { v30.16b }, v4.16b
tbl	v5.16b, { v30.16b }, v5.16b
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], x1
tbl	v6.16b, { v30.16b }, v6.16b
tbl	v7.16b, { v30.16b }, v7.16b
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x2], x1
b.gt	L_3470
ret
ipred_cfl_128_16bpc_neon:
dup	v31.8h, w7
clz	w9, w3
adrp	x7, ipred_cfl_128_tbl
add	x7, x7, :lo12:ipred_cfl_128_tbl
sub	w9, w9, #0x1a
ldrsw	x9, [x7, w9, uxtw #2]
urshr	v0.8h, v31.8h, #0x1
dup	v1.8h, w6
add	x7, x7, x9
add	x6, x0, x1
lsl	x1, x1, #1
movi	v30.8h, #0x0
br	x7
L_354c:
ld1	{ v4.8h, v5.8h }, [x5], #32
subs	w4, w4, #0x4
smull	v2.4s, v4.4h, v1.4h
smull2	v3.4s, v4.8h, v1.8h
smull	v4.4s, v5.4h, v1.4h
smull2	v5.4s, v5.8h, v1.8h
cmlt	v16.4s, v2.4s, #0
cmlt	v17.4s, v3.4s, #0
cmlt	v18.4s, v4.4s, #0
cmlt	v19.4s, v5.4s, #0
add	v2.4s, v2.4s, v16.4s
add	v3.4s, v3.4s, v17.4s
add	v4.4s, v4.4s, v18.4s
add	v5.4s, v5.4s, v19.4s
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
rshrn	v3.4h, v4.4s, #0x6
rshrn2	v3.8h, v5.4s, #0x6
add	v2.8h, v2.8h, v0.8h
add	v3.8h, v3.8h, v0.8h
smax	v2.8h, v2.8h, v30.8h
smax	v3.8h, v3.8h, v30.8h
smin	v2.8h, v2.8h, v31.8h
smin	v3.8h, v3.8h, v31.8h
st1	{ v2.d }[0], [x0], x1
st1	{ v2.d }[1], [x6], x1
st1	{ v3.d }[0], [x0], x1
st1	{ v3.d }[1], [x6], x1
b.gt	L_354c
ret
L_35c4:
ld1	{ v4.8h, v5.8h }, [x5], #32
subs	w4, w4, #0x2
smull	v2.4s, v4.4h, v1.4h
smull2	v3.4s, v4.8h, v1.8h
smull	v4.4s, v5.4h, v1.4h
smull2	v5.4s, v5.8h, v1.8h
cmlt	v16.4s, v2.4s, #0
cmlt	v17.4s, v3.4s, #0
cmlt	v18.4s, v4.4s, #0
cmlt	v19.4s, v5.4s, #0
add	v2.4s, v2.4s, v16.4s
add	v3.4s, v3.4s, v17.4s
add	v4.4s, v4.4s, v18.4s
add	v5.4s, v5.4s, v19.4s
rshrn	v2.4h, v2.4s, #0x6
rshrn2	v2.8h, v3.4s, #0x6
rshrn	v3.4h, v4.4s, #0x6
rshrn2	v3.8h, v5.4s, #0x6
add	v2.8h, v2.8h, v0.8h
add	v3.8h, v3.8h, v0.8h
smax	v2.8h, v2.8h, v30.8h
smax	v3.8h, v3.8h, v30.8h
smin	v2.8h, v2.8h, v31.8h
smin	v3.8h, v3.8h, v31.8h
st1	{ v2.8h }, [x0], x1
st1	{ v3.8h }, [x6], x1
b.gt	L_35c4
ret
L_3634:
add	x7, x5, w3, uxtw #1
sub	x1, x1, w3, uxtw #1
mov	w9, w3
L_3640:
ld1	{ v2.8h, v3.8h }, [x5], #32
ld1	{ v4.8h, v5.8h }, [x7], #32
subs	w3, w3, #0x10
smull	v16.4s, v2.4h, v1.4h
smull2	v17.4s, v2.8h, v1.8h
smull	v18.4s, v3.4h, v1.4h
smull2	v19.4s, v3.8h, v1.8h
smull	v2.4s, v4.4h, v1.4h
smull2	v3.4s, v4.8h, v1.8h
smull	v4.4s, v5.4h, v1.4h
smull2	v5.4s, v5.8h, v1.8h
cmlt	v20.4s, v16.4s, #0
cmlt	v21.4s, v17.4s, #0
cmlt	v22.4s, v18.4s, #0
cmlt	v23.4s, v19.4s, #0
cmlt	v24.4s, v2.4s, #0
cmlt	v25.4s, v3.4s, #0
cmlt	v26.4s, v4.4s, #0
cmlt	v27.4s, v5.4s, #0
add	v16.4s, v16.4s, v20.4s
add	v17.4s, v17.4s, v21.4s
add	v18.4s, v18.4s, v22.4s
add	v19.4s, v19.4s, v23.4s
add	v2.4s, v2.4s, v24.4s
add	v3.4s, v3.4s, v25.4s
add	v4.4s, v4.4s, v26.4s
add	v5.4s, v5.4s, v27.4s
rshrn	v16.4h, v16.4s, #0x6
rshrn2	v16.8h, v17.4s, #0x6
rshrn	v17.4h, v18.4s, #0x6
rshrn2	v17.8h, v19.4s, #0x6
rshrn	v6.4h, v2.4s, #0x6
rshrn2	v6.8h, v3.4s, #0x6
rshrn	v7.4h, v4.4s, #0x6
rshrn2	v7.8h, v5.4s, #0x6
add	v2.8h, v16.8h, v0.8h
add	v3.8h, v17.8h, v0.8h
add	v4.8h, v6.8h, v0.8h
add	v5.8h, v7.8h, v0.8h
smax	v2.8h, v2.8h, v30.8h
smax	v3.8h, v3.8h, v30.8h
smax	v4.8h, v4.8h, v30.8h
smax	v5.8h, v5.8h, v30.8h
smin	v2.8h, v2.8h, v31.8h
smin	v3.8h, v3.8h, v31.8h
smin	v4.8h, v4.8h, v31.8h
smin	v5.8h, v5.8h, v31.8h
st1	{ v2.8h, v3.8h }, [x0], #32
st1	{ v4.8h, v5.8h }, [x6], #32
b.gt	L_3640
subs	w4, w4, #0x2
add	x5, x5, w9, uxtw #1
add	x7, x7, w9, uxtw #1
add	x0, x0, x1
add	x6, x6, x1
mov	w3, w9
b.gt	L_3640
ret
ipred_cfl_top_16bpc_neon:
dup	v31.8h, w7
clz	w9, w3
adrp	x7, ipred_cfl_top_tbl
add	x7, x7, :lo12:ipred_cfl_top_tbl
sub	w9, w9, #0x1a
ldrsw	x9, [x7, w9, uxtw #2]
dup	v1.8h, w6
add	x2, x2, #0x2
add	x7, x7, x9
add	x6, x0, x1
lsl	x1, x1, #1
movi	v30.8h, #0x0
br	x7
L_375c:
ld1	{ v0.4h }, [x2]
addv	h0, v0.4h
urshr	v0.4h, v0.4h, #0x2
dup	v0.8h, v0.h[0]
b	L_354c
L_3770:
ld1	{ v0.8h }, [x2]
addv	h0, v0.8h
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
b	L_35c4
L_3784:
ld1	{ v2.8h, v3.8h }, [x2]
addp	v0.8h, v2.8h, v3.8h
addv	h0, v0.8h
urshr	v0.4h, v0.4h, #0x4
dup	v0.8h, v0.h[0]
b	L_3634
L_379c:
ld1	{ v2.8h, v3.8h, v4.8h, v5.8h }, [x2]
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v0.8h, v2.8h, v4.8h
uaddlv	s0, v0.8h
rshrn	v0.4h, v0.4s, #0x5
dup	v0.8h, v0.h[0]
b	L_3634
ipred_cfl_left_16bpc_neon:
dup	v31.8h, w7
sub	x2, x2, w4, uxtw #1
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
movi	v30.8h, #0x0
br	x7
L_3808:
ld1	{ v0.4h }, [x2]
addv	h0, v0.4h
urshr	v0.4h, v0.4h, #0x2
dup	v0.8h, v0.h[0]
br	x9
L_381c:
ld1	{ v0.8h }, [x2]
addv	h0, v0.8h
urshr	v0.4h, v0.4h, #0x3
dup	v0.8h, v0.h[0]
br	x9
L_3830:
ld1	{ v2.8h, v3.8h }, [x2]
addp	v0.8h, v2.8h, v3.8h
addv	h0, v0.8h
urshr	v0.4h, v0.4h, #0x4
dup	v0.8h, v0.h[0]
br	x9
L_3848:
ld1	{ v2.8h, v3.8h, v4.8h, v5.8h }, [x2]
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v0.8h, v2.8h, v4.8h
uaddlv	s0, v0.8h
rshrn	v0.4h, v0.4s, #0x5
dup	v0.8h, v0.h[0]
br	x9
ipred_cfl_16bpc_neon:
dup	v31.8h, w7
sub	x2, x2, w4, uxtw #1
add	w8, w3, w4
dup	v1.8h, w6
clz	w9, w3
clz	w6, w4
dup	v16.4s, w8
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
ushr	v16.4s, v16.4s, #0x1
dup	v17.4s, w8
add	x6, x0, x1
lsl	x1, x1, #1
movi	v30.8h, #0x0
br	x7
L_38c8:
ld1	{ v0.4h }, [x2], #8
uaddlv	s0, v0.4h
add	x2, x2, #0x2
br	x9
L_38d8:
ld1	{ v2.4h }, [x2]
add	v0.2s, v0.2s, v16.2s
uaddlv	s2, v2.4h
cmp	w4, #0x4
add	v0.2s, v0.2s, v2.2s
ushl	v0.2s, v0.2s, v17.2s
b.eq	L_3910
cmp	w4, #0x10
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v0.2s, v0.2s, v16.2s
ushr	v0.2s, v0.2s, #0x11
L_3910:
dup	v0.8h, v0.h[0]
b	L_354c
L_3918:
ld1	{ v0.8h }, [x2], #16
uaddlv	s0, v0.8h
add	x2, x2, #0x2
br	x9
L_3928:
ld1	{ v2.8h }, [x2]
add	v0.2s, v0.2s, v16.2s
uaddlv	s2, v2.8h
cmp	w4, #0x8
add	v0.2s, v0.2s, v2.2s
ushl	v0.2s, v0.2s, v17.2s
b.eq	L_3960
cmp	w4, #0x20
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v0.2s, v0.2s, v16.2s
ushr	v0.2s, v0.2s, #0x11
L_3960:
dup	v0.8h, v0.h[0]
b	L_35c4
L_3968:
ld1	{ v2.8h, v3.8h }, [x2], #32
addp	v0.8h, v2.8h, v3.8h
add	x2, x2, #0x2
uaddlv	s0, v0.8h
br	x9
L_397c:
ld1	{ v2.8h, v3.8h }, [x2]
add	v0.2s, v0.2s, v16.2s
addp	v2.8h, v2.8h, v3.8h
uaddlv	s2, v2.8h
cmp	w4, #0x10
add	v0.2s, v0.2s, v2.2s
ushl	v0.2s, v0.2s, v17.2s
b.eq	L_39b8
tst	w4, #0x38
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v0.2s, v0.2s, v16.2s
ushr	v0.2s, v0.2s, #0x11
L_39b8:
dup	v0.8h, v0.h[0]
b	L_3634
L_39c0:
ld1	{ v2.8h, v3.8h, v4.8h, v5.8h }, [x2], #64
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v0.8h, v2.8h, v4.8h
add	x2, x2, #0x2
uaddlv	s0, v0.8h
br	x9
L_39dc:
ld1	{ v2.8h, v3.8h, v4.8h, v5.8h }, [x2]
add	v0.4s, v0.4s, v16.4s
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v2.8h, v2.8h, v4.8h
cmp	w4, #0x20
uaddlv	s2, v2.8h
add	v0.2s, v0.2s, v2.2s
ushl	v0.2s, v0.2s, v17.2s
b.eq	L_3a20
cmp	w4, #0x8
mov	w16, #0x6667
mov	w17, #0xaaab
csel	w16, w16, w17, eq
dup	v16.2s, w16
mul	v0.2s, v0.2s, v16.2s
ushr	v0.2s, v0.2s, #0x11
L_3a20:
dup	v0.8h, v0.h[0]
b	L_3634
ipred_cfl_ac_420_16bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adrp	x7, ipred_cfl_ac_420_tbl
add	x7, x7, :lo12:ipred_cfl_ac_420_tbl
sub	w8, w8, #0x1b
ldrsw	x8, [x7, w8, uxtw #2]
movi	v24.4s, #0x0
movi	v25.4s, #0x0
movi	v26.4s, #0x0
movi	v27.4s, #0x0
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
L_3a80:
ld1	{ v0.8h }, [x1], x2
ld1	{ v1.8h }, [x10], x2
ld1	{ v2.8h }, [x1], x2
ld1	{ v3.8h }, [x10], x2
addp	v0.8h, v0.8h, v2.8h
addp	v1.8h, v1.8h, v3.8h
add	v0.8h, v0.8h, v1.8h
shl	v0.8h, v0.8h, #0x1
subs	w8, w8, #0x2
st1	{ v0.8h }, [x0], #16
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
b.gt	L_3a80
trn2	v1.2d, v0.2d, v0.2d
trn2	v0.2d, v0.2d, v0.2d
L_3abc:
cbz	w4, L_3adc
L_3ac0:
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
b.gt	L_3ac0
L_3adc:
add	v24.4s, v24.4s, v25.4s
add	v26.4s, v26.4s, v27.4s
add	v0.4s, v24.4s, v26.4s
addv	s0, v0.4s
sub	x0, x0, w6, uxtw #3
urshl	v4.2s, v0.2s, v31.2s
dup	v4.8h, v4.h[0]
L_3af8:
ld1	{ v0.8h, v1.8h }, [x0]
subs	w6, w6, #0x4
sub	v0.8h, v0.8h, v4.8h
sub	v1.8h, v1.8h, v4.8h
st1	{ v0.8h, v1.8h }, [x0], #32
b.gt	L_3af8
ret
L_3b14:
cbnz	w3, L_3b6c
L_3b18:
ld1	{ v0.8h, v1.8h }, [x1], x2
ld1	{ v2.8h, v3.8h }, [x10], x2
ld1	{ v4.8h, v5.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
ld1	{ v6.8h, v7.8h }, [x10], x2
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
add	v0.8h, v0.8h, v2.8h
add	v4.8h, v4.8h, v6.8h
shl	v0.8h, v0.8h, #0x1
shl	v1.8h, v4.8h, #0x1
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
b.gt	L_3b18
mov	v0.16b, v1.16b
b	L_3bbc
L_3b6c:
ld1	{ v0.8h }, [x1], x2
ld1	{ v1.8h }, [x10], x2
ld1	{ v2.8h }, [x1], x2
ld1	{ v3.8h }, [x10], x2
addp	v0.8h, v0.8h, v2.8h
addp	v1.8h, v1.8h, v3.8h
add	v0.8h, v0.8h, v1.8h
shl	v0.8h, v0.8h, #0x1
dup	v1.4h, v0.h[3]
dup	v3.4h, v0.h[7]
trn2	v2.2d, v0.2d, v0.2d
subs	w8, w8, #0x2
st1	{ v0.4h, v1.4h, v2.4h, v3.4h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw	v25.4s, v25.4s, v1.4h
uaddw	v26.4s, v26.4s, v2.4h
uaddw	v27.4s, v27.4s, v3.4h
b.gt	L_3b6c
trn1	v0.2d, v2.2d, v3.2d
trn1	v1.2d, v2.2d, v3.2d
L_3bbc:
cbz	w4, L_3bf0
L_3bc0:
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
st1	{ v0.8h, v1.8h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
b.gt	L_3bc0
L_3bf0:
lsl	w6, w6, #1
b	L_3adc
L_3bf8:
adrp	x7, ipred_cfl_ac_420_w16_tbl
add	x7, x7, :lo12:ipred_cfl_ac_420_w16_tbl
ldrsw	x3, [x7, w3, uxtw #2]
add	x7, x7, x3
br	x7
L_3c0c:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x10], x2
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x1], x2
add	v0.8h, v0.8h, v4.8h
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x10], x2
add	v2.8h, v2.8h, v6.8h
addp	v16.8h, v16.8h, v17.8h
addp	v18.8h, v18.8h, v19.8h
addp	v20.8h, v20.8h, v21.8h
addp	v22.8h, v22.8h, v23.8h
add	v16.8h, v16.8h, v20.8h
add	v18.8h, v18.8h, v22.8h
shl	v0.8h, v0.8h, #0x1
shl	v1.8h, v2.8h, #0x1
shl	v2.8h, v16.8h, #0x1
shl	v3.8h, v18.8h, #0x1
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3c0c
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_3c94:
ldr	q2, [x1, #0x20]
ld1	{ v0.8h, v1.8h }, [x1], x2
ldr	q5, [x10, #0x20]
ld1	{ v3.8h, v4.8h }, [x10], x2
addp	v2.8h, v2.8h, v2.8h
addp	v0.8h, v0.8h, v1.8h
addp	v5.8h, v5.8h, v5.8h
addp	v3.8h, v3.8h, v4.8h
ldr	q18, [x1, #0x20]
add	v2.4h, v2.4h, v5.4h
ld1	{ v16.8h, v17.8h }, [x1], x2
add	v0.8h, v0.8h, v3.8h
ldr	q21, [x10, #0x20]
ld1	{ v19.8h, v20.8h }, [x10], x2
addp	v18.8h, v18.8h, v18.8h
addp	v16.8h, v16.8h, v17.8h
addp	v21.8h, v21.8h, v21.8h
addp	v19.8h, v19.8h, v20.8h
add	v18.4h, v18.4h, v21.4h
add	v16.8h, v16.8h, v19.8h
shl	v1.4h, v2.4h, #0x1
shl	v0.8h, v0.8h, #0x1
shl	v3.4h, v18.4h, #0x1
shl	v2.8h, v16.8h, #0x1
dup	v4.4h, v1.h[3]
dup	v5.4h, v3.h[3]
trn1	v1.2d, v1.2d, v4.2d
trn1	v3.2d, v3.2d, v5.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3c94
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_3d3c:
ld1	{ v0.8h, v1.8h }, [x1], x2
ld1	{ v2.8h, v3.8h }, [x10], x2
ld1	{ v4.8h, v5.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
ld1	{ v6.8h, v7.8h }, [x10], x2
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
add	v0.8h, v0.8h, v2.8h
add	v4.8h, v4.8h, v6.8h
shl	v0.8h, v0.8h, #0x1
shl	v2.8h, v4.8h, #0x1
dup	v1.8h, v0.h[7]
dup	v3.8h, v2.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3d3c
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_3dac:
ld1	{ v0.8h }, [x1], x2
ld1	{ v2.8h }, [x10], x2
ld1	{ v4.8h }, [x1], x2
ld1	{ v6.8h }, [x10], x2
addp	v0.8h, v0.8h, v4.8h
addp	v2.8h, v2.8h, v6.8h
add	v0.8h, v0.8h, v2.8h
shl	v0.8h, v0.8h, #0x1
dup	v1.8h, v0.h[3]
dup	v3.8h, v0.h[7]
trn2	v2.2d, v0.2d, v3.2d
trn1	v0.2d, v0.2d, v1.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3dac
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
L_3e10:
cbz	w4, L_3e64
L_3e14:
subs	w4, w4, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3e14
L_3e64:
lsl	w6, w6, #2
b	L_3adc
ipred_cfl_ac_422_16bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adrp	x7, ipred_cfl_ac_422_tbl
add	x7, x7, :lo12:ipred_cfl_ac_422_tbl
sub	w8, w8, #0x1b
ldrsw	x8, [x7, w8, uxtw #2]
movi	v24.4s, #0x0
movi	v25.4s, #0x0
movi	v26.4s, #0x0
movi	v27.4s, #0x0
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
L_3ec4:
ld1	{ v0.8h }, [x1], x2
ld1	{ v1.8h }, [x10], x2
ld1	{ v2.8h }, [x1], x2
ld1	{ v3.8h }, [x10], x2
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
shl	v0.8h, v0.8h, #0x2
shl	v1.8h, v2.8h, #0x2
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
b.gt	L_3ec4
trn2	v0.2d, v1.2d, v1.2d
trn2	v1.2d, v1.2d, v1.2d
b	L_3abc
L_3f0c:
cbnz	w3, L_3f78
L_3f10:
ld1	{ v0.8h, v1.8h }, [x1], x2
ld1	{ v2.8h, v3.8h }, [x10], x2
ld1	{ v4.8h, v5.8h }, [x1], x2
addp	v0.8h, v0.8h, v1.8h
ld1	{ v6.8h, v7.8h }, [x10], x2
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
shl	v0.8h, v0.8h, #0x2
shl	v1.8h, v2.8h, #0x2
shl	v2.8h, v4.8h, #0x2
shl	v3.8h, v6.8h, #0x2
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3f10
mov	v0.16b, v3.16b
mov	v1.16b, v3.16b
b	L_3bbc
L_3f78:
ld1	{ v0.8h }, [x1], x2
ld1	{ v1.8h }, [x10], x2
ld1	{ v2.8h }, [x1], x2
ld1	{ v3.8h }, [x10], x2
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
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
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_3f78
mov	v0.16b, v3.16b
mov	v1.16b, v3.16b
b	L_3bbc
L_3ff0:
adrp	x7, ipred_cfl_ac_422_w16_tbl
add	x7, x7, :lo12:ipred_cfl_ac_422_w16_tbl
ldrsw	x3, [x7, w3, uxtw #2]
add	x7, x7, x3
br	x7
L_4004:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
ld1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x10], x2
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
shl	v0.8h, v0.8h, #0x2
shl	v1.8h, v2.8h, #0x2
shl	v2.8h, v4.8h, #0x2
shl	v3.8h, v6.8h, #0x2
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4004
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_4064:
ldr	q2, [x1, #0x20]
ld1	{ v0.8h, v1.8h }, [x1], x2
ldr	q6, [x10, #0x20]
ld1	{ v4.8h, v5.8h }, [x10], x2
addp	v2.8h, v2.8h, v2.8h
addp	v0.8h, v0.8h, v1.8h
addp	v6.8h, v6.8h, v6.8h
addp	v4.8h, v4.8h, v5.8h
shl	v1.4h, v2.4h, #0x2
shl	v0.8h, v0.8h, #0x2
shl	v3.4h, v6.4h, #0x2
shl	v2.8h, v4.8h, #0x2
dup	v4.4h, v1.h[3]
dup	v5.4h, v3.h[3]
trn1	v1.2d, v1.2d, v4.2d
trn1	v3.2d, v3.2d, v5.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4064
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_40dc:
ld1	{ v0.8h, v1.8h }, [x1], x2
ld1	{ v2.8h, v3.8h }, [x10], x2
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
shl	v0.8h, v0.8h, #0x2
shl	v2.8h, v2.8h, #0x2
dup	v1.8h, v0.h[7]
dup	v3.8h, v2.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_40dc
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_4134:
ld1	{ v0.8h }, [x1], x2
ld1	{ v2.8h }, [x10], x2
addp	v0.8h, v0.8h, v0.8h
addp	v2.8h, v2.8h, v2.8h
shl	v0.4h, v0.4h, #0x2
shl	v2.4h, v2.4h, #0x2
dup	v1.8h, v0.h[3]
dup	v3.8h, v2.h[3]
trn1	v0.2d, v0.2d, v1.2d
trn1	v2.2d, v2.2d, v3.2d
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4134
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
ipred_cfl_ac_444_16bpc_neon:
clz	w8, w5
lsl	w4, w4, #2
adrp	x7, ipred_cfl_ac_444_tbl
add	x7, x7, :lo12:ipred_cfl_ac_444_tbl
sub	w8, w8, #0x1a
ldrsw	x8, [x7, w8, uxtw #2]
movi	v24.4s, #0x0
movi	v25.4s, #0x0
movi	v26.4s, #0x0
movi	v27.4s, #0x0
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
L_41ec:
ld1	{ v0.4h }, [x1], x2
ld1	{ v0.d }[1], [x10], x2
ld1	{ v1.4h }, [x1], x2
ld1	{ v1.d }[1], [x10], x2
shl	v0.8h, v0.8h, #0x3
shl	v1.8h, v1.8h, #0x3
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h }, [x0], #32
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
b.gt	L_41ec
trn2	v0.2d, v1.2d, v1.2d
trn2	v1.2d, v1.2d, v1.2d
b	L_3abc
L_422c:
ld1	{ v0.8h }, [x1], x2
ld1	{ v1.8h }, [x10], x2
ld1	{ v2.8h }, [x1], x2
shl	v0.8h, v0.8h, #0x3
ld1	{ v3.8h }, [x10], x2
shl	v1.8h, v1.8h, #0x3
shl	v2.8h, v2.8h, #0x3
shl	v3.8h, v3.8h, #0x3
subs	w8, w8, #0x4
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_422c
mov	v0.16b, v3.16b
mov	v1.16b, v3.16b
b	L_3bbc
L_4284:
cbnz	w3, L_42d8
L_4288:
ld1	{ v0.8h, v1.8h }, [x1], x2
ld1	{ v2.8h, v3.8h }, [x10], x2
shl	v0.8h, v0.8h, #0x3
shl	v1.8h, v1.8h, #0x3
shl	v2.8h, v2.8h, #0x3
shl	v3.8h, v3.8h, #0x3
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4288
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_42d8:
ld1	{ v0.8h }, [x1], x2
ld1	{ v2.8h }, [x10], x2
shl	v0.8h, v0.8h, #0x3
shl	v2.8h, v2.8h, #0x3
dup	v1.8h, v0.h[7]
dup	v3.8h, v2.h[7]
subs	w8, w8, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_42d8
mov	v0.16b, v2.16b
mov	v1.16b, v3.16b
b	L_3e10
L_4328:
adrp	x7, ipred_cfl_ac_444_w32_tbl
add	x7, x7, :lo12:ipred_cfl_ac_444_w32_tbl
lsr	w3, w3, #1
ldrsw	x3, [x7, w3, uxtw #2]
lsr	x2, x2, #1
add	x7, x7, x3
br	x7
L_4344:
ld1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x1], x2
shl	v0.8h, v0.8h, #0x3
shl	v1.8h, v1.8h, #0x3
shl	v2.8h, v2.8h, #0x3
shl	v3.8h, v3.8h, #0x3
subs	w8, w8, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4344
b	L_4450
L_4388:
ld1	{ v0.8h, v1.8h, v2.8h }, [x1], x2
shl	v2.8h, v2.8h, #0x3
shl	v0.8h, v0.8h, #0x3
shl	v1.8h, v1.8h, #0x3
dup	v3.8h, v2.h[7]
subs	w8, w8, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4388
b	L_4450
L_43cc:
ld1	{ v0.8h, v1.8h }, [x1], x2
shl	v1.8h, v1.8h, #0x3
shl	v0.8h, v0.8h, #0x3
dup	v2.8h, v1.h[7]
dup	v3.8h, v1.h[7]
subs	w8, w8, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_43cc
b	L_4450
L_4410:
ld1	{ v0.8h }, [x1], x2
shl	v0.8h, v0.8h, #0x3
dup	v1.8h, v0.h[7]
dup	v2.8h, v0.h[7]
dup	v3.8h, v0.h[7]
subs	w8, w8, #0x1
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4410
L_4450:
cbz	w4, L_44a4
L_4454:
subs	w4, w4, #0x2
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
st1	{ v0.8h, v1.8h, v2.8h, v3.8h }, [x0], #64
uaddw	v24.4s, v24.4s, v0.4h
uaddw2	v25.4s, v25.4s, v0.8h
uaddw	v26.4s, v26.4s, v1.4h
uaddw2	v27.4s, v27.4s, v1.8h
uaddw	v24.4s, v24.4s, v2.4h
uaddw2	v25.4s, v25.4s, v2.8h
uaddw	v26.4s, v26.4s, v3.4h
uaddw2	v27.4s, v27.4s, v3.8h
b.gt	L_4454
L_44a4:
lsl	w6, w6, #3
b	L_3adc
	.section *UND*
	.section .rodata
ipred_dc_128_tbl:
	.size ipred_dc_128_tbl, 20
	.word L_b0 - ipred_dc_128_tbl
	.word L_88 - ipred_dc_128_tbl
	.word L_68 - ipred_dc_128_tbl
	.word L_4c - ipred_dc_128_tbl
	.word L_30 - ipred_dc_128_tbl
ipred_v_tbl:
	.size ipred_v_tbl, 20
	.word L_194 - ipred_v_tbl
	.word L_174 - ipred_v_tbl
	.word L_154 - ipred_v_tbl
	.word L_134 - ipred_v_tbl
	.word L_114 - ipred_v_tbl
ipred_h_tbl:
	.size ipred_h_tbl, 20
	.word L_2a8 - ipred_h_tbl
	.word L_268 - ipred_h_tbl
	.word L_238 - ipred_h_tbl
	.word L_218 - ipred_h_tbl
	.word L_1f8 - ipred_h_tbl
ipred_dc_top_tbl:
	.size ipred_dc_top_tbl, 20
	.word L_400 - ipred_dc_top_tbl
	.word L_3bc - ipred_dc_top_tbl
	.word L_388 - ipred_dc_top_tbl
	.word L_35c - ipred_dc_top_tbl
	.word L_330 - ipred_dc_top_tbl
ipred_dc_left_tbl:
	.size ipred_dc_left_tbl, 40
	.word L_58c - ipred_dc_left_tbl
	.word L_540 - ipred_dc_left_tbl
	.word L_504 - ipred_dc_left_tbl
	.word L_4d4 - ipred_dc_left_tbl
	.word L_4a4 - ipred_dc_left_tbl
	.word L_5c0 - ipred_dc_left_tbl
	.word L_564 - ipred_dc_left_tbl
	.word L_520 - ipred_dc_left_tbl
	.word L_4e8 - ipred_dc_left_tbl
	.word L_4b8 - ipred_dc_left_tbl
ipred_dc_tbl:
	.size ipred_dc_tbl, 40
	.word L_820 - ipred_dc_tbl
	.word L_794 - ipred_dc_tbl
	.word L_720 - ipred_dc_tbl
	.word L_6b8 - ipred_dc_tbl
	.word L_650 - ipred_dc_tbl
	.word L_850 - ipred_dc_tbl
	.word L_7b0 - ipred_dc_tbl
	.word L_734 - ipred_dc_tbl
	.word L_6c8 - ipred_dc_tbl
	.word L_660 - ipred_dc_tbl
ipred_paeth_tbl:
	.size ipred_paeth_tbl, 20
	.word L_994 - ipred_paeth_tbl
	.word L_994 - ipred_paeth_tbl
	.word L_994 - ipred_paeth_tbl
	.word L_994 - ipred_paeth_tbl
	.word L_91c - ipred_paeth_tbl
ipred_smooth_tbl:
	.size ipred_smooth_tbl, 20
	.word L_c58 - ipred_smooth_tbl
	.word L_c58 - ipred_smooth_tbl
	.word L_c58 - ipred_smooth_tbl
	.word L_b74 - ipred_smooth_tbl
	.word L_ad0 - ipred_smooth_tbl
ipred_smooth_v_tbl:
	.size ipred_smooth_v_tbl, 20
	.word L_e34 - ipred_smooth_v_tbl
	.word L_e34 - ipred_smooth_v_tbl
	.word L_e34 - ipred_smooth_v_tbl
	.word L_ddc - ipred_smooth_v_tbl
	.word L_d94 - ipred_smooth_v_tbl
ipred_smooth_h_tbl:
	.size ipred_smooth_h_tbl, 20
	.word L_fd0 - ipred_smooth_h_tbl
	.word L_fd0 - ipred_smooth_h_tbl
	.word L_fd0 - ipred_smooth_h_tbl
	.word L_f70 - ipred_smooth_h_tbl
	.word L_f20 - ipred_smooth_h_tbl
padding_mask_buf:
	.size padding_mask_buf, 96
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
padding_mask:
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
edge_filter:
	.size edge_filter, 16
	.byte 0,0,4,0,8,0,0,0,0,0,5,0,6,0,0,0
ipred_z1_fill1_tbl:
	.size ipred_z1_fill1_tbl, 20
	.word L_1540 - ipred_z1_fill1_tbl
	.word L_1540 - ipred_z1_fill1_tbl
	.word L_1540 - ipred_z1_fill1_tbl
	.word L_1490 - ipred_z1_fill1_tbl
	.word L_1408 - ipred_z1_fill1_tbl
increments:
	.size increments, 16
	.byte 0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0
ipred_z2_fill1_tbl:
	.size ipred_z2_fill1_tbl, 20
	.word L_1b50 - ipred_z2_fill1_tbl
	.word L_1b50 - ipred_z2_fill1_tbl
	.word L_1b50 - ipred_z2_fill1_tbl
	.word L_197c - ipred_z2_fill1_tbl
	.word L_1828 - ipred_z2_fill1_tbl
ipred_z3_fill1_tbl:
	.size ipred_z3_fill1_tbl, 20
	.word L_28f4 - ipred_z3_fill1_tbl
	.word L_28f4 - ipred_z3_fill1_tbl
	.word L_28f4 - ipred_z3_fill1_tbl
	.word L_2824 - ipred_z3_fill1_tbl
	.word L_2790 - ipred_z3_fill1_tbl
ipred_z3_fill_padding_tbl:
	.size ipred_z3_fill_padding_tbl, 24
	.word L_2af0 - ipred_z3_fill_padding_tbl
	.word L_2af0 - ipred_z3_fill_padding_tbl
	.word L_2af0 - ipred_z3_fill_padding_tbl
	.word L_2af0 - ipred_z3_fill_padding_tbl
	.word L_2ab0 - ipred_z3_fill_padding_tbl
	.word L_2a70 - ipred_z3_fill_padding_tbl
ipred_filter10_tbl:
	.size ipred_filter10_tbl, 16
	.word L_2e30 - ipred_filter10_tbl
	.word L_2e30 - ipred_filter10_tbl
	.word L_2db8 - ipred_filter10_tbl
	.word L_2d68 - ipred_filter10_tbl
ipred_filter12_tbl:
	.size ipred_filter12_tbl, 16
	.word L_30a4 - ipred_filter12_tbl
	.word L_30a4 - ipred_filter12_tbl
	.word L_2ff4 - ipred_filter12_tbl
	.word L_2f88 - ipred_filter12_tbl
pal_pred_tbl:
	.size pal_pred_tbl, 20
	.word L_346c - pal_pred_tbl
	.word L_33bc - pal_pred_tbl
	.word L_3304 - pal_pred_tbl
	.word L_3294 - pal_pred_tbl
	.word L_3244 - pal_pred_tbl
ipred_cfl_128_tbl:
	.size ipred_cfl_128_tbl, 16
ipred_cfl_splat_tbl:
	.word L_3634 - ipred_cfl_128_tbl
	.word L_3634 - ipred_cfl_128_tbl
	.word L_35c4 - ipred_cfl_128_tbl
	.word L_354c - ipred_cfl_128_tbl
ipred_cfl_top_tbl:
	.size ipred_cfl_top_tbl, 16
	.word L_379c - ipred_cfl_top_tbl
	.word L_3784 - ipred_cfl_top_tbl
	.word L_3770 - ipred_cfl_top_tbl
	.word L_375c - ipred_cfl_top_tbl
ipred_cfl_left_tbl:
	.size ipred_cfl_left_tbl, 16
	.word L_3848 - ipred_cfl_left_tbl
	.word L_3830 - ipred_cfl_left_tbl
	.word L_381c - ipred_cfl_left_tbl
	.word L_3808 - ipred_cfl_left_tbl
ipred_cfl_tbl:
	.size ipred_cfl_tbl, 32
	.word L_39c0 - ipred_cfl_tbl
	.word L_3968 - ipred_cfl_tbl
	.word L_3918 - ipred_cfl_tbl
	.word L_38c8 - ipred_cfl_tbl
	.word L_39dc - ipred_cfl_tbl
	.word L_397c - ipred_cfl_tbl
	.word L_3928 - ipred_cfl_tbl
	.word L_38d8 - ipred_cfl_tbl
ipred_cfl_ac_420_tbl:
	.size ipred_cfl_ac_420_tbl, 12
	.word L_3bf8 - ipred_cfl_ac_420_tbl
	.word L_3b14 - ipred_cfl_ac_420_tbl
	.word L_3a80 - ipred_cfl_ac_420_tbl
ipred_cfl_ac_420_w16_tbl:
	.size ipred_cfl_ac_420_w16_tbl, 16
	.word L_3c0c - ipred_cfl_ac_420_w16_tbl
	.word L_3c94 - ipred_cfl_ac_420_w16_tbl
	.word L_3d3c - ipred_cfl_ac_420_w16_tbl
	.word L_3dac - ipred_cfl_ac_420_w16_tbl
ipred_cfl_ac_422_tbl:
	.size ipred_cfl_ac_422_tbl, 12
	.word L_3ff0 - ipred_cfl_ac_422_tbl
	.word L_3f0c - ipred_cfl_ac_422_tbl
	.word L_3ec4 - ipred_cfl_ac_422_tbl
ipred_cfl_ac_422_w16_tbl:
	.size ipred_cfl_ac_422_w16_tbl, 16
	.word L_4004 - ipred_cfl_ac_422_w16_tbl
	.word L_4064 - ipred_cfl_ac_422_w16_tbl
	.word L_40dc - ipred_cfl_ac_422_w16_tbl
	.word L_4134 - ipred_cfl_ac_422_w16_tbl
ipred_cfl_ac_444_tbl:
	.size ipred_cfl_ac_444_tbl, 16
	.word L_4328 - ipred_cfl_ac_444_tbl
	.word L_4284 - ipred_cfl_ac_444_tbl
	.word L_422c - ipred_cfl_ac_444_tbl
	.word L_41ec - ipred_cfl_ac_444_tbl
ipred_cfl_ac_444_w32_tbl:
	.size ipred_cfl_ac_444_w32_tbl, 16
	.word L_4344 - ipred_cfl_ac_444_w32_tbl
	.word L_4388 - ipred_cfl_ac_444_w32_tbl
	.word L_43cc - ipred_cfl_ac_444_w32_tbl
	.word L_4410 - ipred_cfl_ac_444_w32_tbl
