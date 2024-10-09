_wiener_filter7_8bpc_neon:
stp	x29, x30, [sp, #-16]!
mov	x29, sp
ld1.8h	{ v0, v1 }, [x6]
tst	w7, #0x4
sub	sp, sp, #1, lsl #12     ; =4096
sub	sp, sp, #512
mov	w17, #16380
dup.8h	v30, w17
movi.8h	v31, #8, lsl #8
mov	x14, sp
b.eq	wiener_filter7_8bpc_neon
mov	x16, x2
mov	x2, #0
bl	wiener_filter7_h_8bpc_neon
add	x3, x3, x1
mov	x9, x14
mov	x10, x14
add	x14, x14, #768
bl	wiener_filter7_h_8bpc_neon
add	x3, x3, x1, lsl #2
add	x3, x3, x1
mov	x11, x14
add	x14, x14, #768
mov	x2, x16
mov	x16, x3
mov	x3, x0
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #1
mov	x12, x14
mov	x13, x14
b.eq	wiener_filter7_8bpc_neon
add	x3, x3, x1
add	x14, x14, #768
bl	wiener_filter7_h_8bpc_neon
mov	x13, x14
subs	w5, w5, #1
b.eq	wiener_filter7_8bpc_neon
add	x3, x3, x1
add	x14, x14, #768
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #1
b.eq	wiener_filter7_8bpc_neon
add	x3, x3, x1
add	x15, x14, #768
bl	wiener_filter7_hv_8bpc_neon
subs	w5, w5, #1
b.ne	wiener_filter7_8bpc_neon
tst	w7, #0x8
b.eq	wiener_filter7_8bpc_neon
mov	x3, x16
mov	x2, #0
bl	wiener_filter7_hv_8bpc_neon
bl	wiener_filter7_hv_8bpc_neon
bl	wiener_filter7_v_8bpc_neon
mov	sp, x29
ldp	x29, x30, [sp], #16
ret
add	x3, x3, x1, lsl #2
add	x16, x3, x1, lsl #1
mov	x3, x0
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #1
mov	x9, x14
mov	x10, x14
mov	x11, x14
mov	x12, x14
mov	x13, x14
b.eq	wiener_filter7_8bpc_neon
add	x3, x3, x1
add	x14, x14, #768
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #1
mov	x13, x14
b.eq	wiener_filter7_8bpc_neon
add	x3, x3, x1
add	x14, x14, #768
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #1
b.eq	wiener_filter7_8bpc_neon
add	x3, x3, x1
add	x15, x14, #768
bl	wiener_filter7_hv_8bpc_neon
subs	w5, w5, #1
b.eq	wiener_filter7_8bpc_neon
add	x15, x15, #3072
bl	wiener_filter7_hv_8bpc_neon
subs	w5, w5, #1
b.ne	wiener_filter7_8bpc_neon
bl	wiener_filter7_v_8bpc_neon
bl	wiener_filter7_v_8bpc_neon
b	wiener_filter7_8bpc_neon
_wiener_filter7_h_8bpc_neon:
stp	x3, x4, [sp, #-32]!
str	x14, [sp, #16]
tst	w7, #0x1
b.eq	wiener_filter7_h_8bpc_neon
cbnz	x2, wiener_filter7_h_8bpc_neon
sub	x3, x3, #3
ld1.16b	{ v3 }, [x3], #16
b	wiener_filter7_h_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
ld1.s	{ v2 }[3], [x2], #4
sub	x3, x3, #3
ext.16b	v3, v2, v3, #13
b	wiener_filter7_h_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
dup.16b	v2, v3[0]
sub	x3, x3, #3
ext.16b	v3, v2, v3, #13
ld1.8b	{ v4 }, [x3], #8
ushll.8h	v2, v3, #0
ushll2.8h	v3, v3, #0
ushll.8h	v4, v4, #0
tst	w7, #0x2
b.ne	wiener_filter7_h_8bpc_neon
cmp	w4, #19
b.ge	wiener_filter7_h_8bpc_neon
sub	w17, w4, #22
adrp	x6, wiener_filter7_h_8bpc_neon
add	x6, x6, #0
sub	x6, x6, #6
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup.8h	v28, v28[0]
ld1.16b	{ v25, v26, v27 }, [x6]
bit.16b	v2, v28, v25
bit.16b	v3, v28, v26
bit.16b	v4, v28, v27
ext.16b	v17, v2, v3, #4
ext.16b	v19, v2, v3, #8
ext.16b	v16, v2, v3, #2
ext.16b	v20, v2, v3, #10
ext.16b	v21, v2, v3, #12
ext.16b	v18, v2, v3, #6
add.8h	v19, v19, v17
add.8h	v20, v20, v16
add.8h	v21, v21, v2
shl.8h	v22, v18, #7
mul.8h	v6, v18, v0[3]
mla.8h	v6, v19, v0[4]
mla.8h	v6, v20, v0[5]
mla.8h	v6, v21, v0[6]
ext.16b	v17, v3, v4, #4
ext.16b	v19, v3, v4, #8
ext.16b	v16, v3, v4, #2
ext.16b	v20, v3, v4, #10
ext.16b	v21, v3, v4, #12
ext.16b	v18, v3, v4, #6
add.8h	v19, v19, v17
add.8h	v20, v20, v16
add.8h	v21, v21, v3
shl.8h	v23, v18, #7
mul.8h	v7, v18, v0[3]
mla.8h	v7, v19, v0[4]
mla.8h	v7, v20, v0[5]
mla.8h	v7, v21, v0[6]
sub.8h	v22, v22, v30
sub.8h	v23, v23, v30
sqadd.8h	v6, v6, v22
sqadd.8h	v7, v7, v23
sshr.8h	v6, v6, #3
sshr.8h	v7, v7, #3
add.8h	v6, v6, v31
add.8h	v7, v7, v31
subs	w4, w4, #16
st1.8h	{ v6, v7 }, [x14], #32
b.le	wiener_filter7_h_8bpc_neon
mov.16b	v2, v4
ld1.16b	{ v4 }, [x3], #16
tst	w7, #0x2
ushll.8h	v3, v4, #0
ushll2.8h	v4, v4, #0
b.ne	wiener_filter7_h_8bpc_neon
b	wiener_filter7_h_8bpc_neon
ldr	x14, [sp, #16]
ldp	x3, x4, [sp], #32
ret
_wiener_filter7_v_8bpc_neon:
stp	x10, x11, [sp, #-64]!
stp	x12, x13, [sp, #16]
stp	x14, x14, [sp, #32]
stp	x0, x4, [sp, #48]
ld1.8h	{ v20, v21 }, [x11], #32
ld1.8h	{ v24, v25 }, [x13], #32
ld1.8h	{ v18, v19 }, [x10], #32
add.8h	v24, v24, v20
ld1.8h	{ v26, v27 }, [x14], #32
ld1.8h	{ v16, v17 }, [x9], #32
add.8h	v28, v26, v18
ld1.8h	{ v22, v23 }, [x12], #32
add.8h	v16, v26, v16
add.8h	v25, v25, v21
smull.4s	v2, v22, v1[3]
smlal.4s	v2, v24, v1[4]
smlal.4s	v2, v28, v1[5]
smlal.4s	v2, v16, v1[6]
add.8h	v29, v27, v19
smull2.4s	v3, v22, v1[3]
smlal2.4s	v3, v24, v1[4]
smlal2.4s	v3, v28, v1[5]
smlal2.4s	v3, v16, v1[6]
add.8h	v17, v27, v17
smull.4s	v4, v23, v1[3]
smlal.4s	v4, v25, v1[4]
smlal.4s	v4, v29, v1[5]
smlal.4s	v4, v17, v1[6]
smull2.4s	v5, v23, v1[3]
smlal2.4s	v5, v25, v1[4]
smlal2.4s	v5, v29, v1[5]
smlal2.4s	v5, v17, v1[6]
sqrshrun.4h	v2, v2, #11
sqrshrun2.8h	v2, v3, #11
sqrshrun.4h	v3, v4, #11
sqrshrun2.8h	v3, v5, #11
sqxtun.8b	v2, v2
sqxtun2.16b	v2, v3
subs	w4, w4, #16
st1.16b	{ v2 }, [x0], #16
b.gt	wiener_filter7_v_8bpc_neon
ldp	x0, x4, [sp, #48]
ldp	x13, x14, [sp, #32]
ldp	x11, x12, [sp, #16]
ldp	x9, x10, [sp], #64
add	x0, x0, x1
ret
_wiener_filter7_hv_8bpc_neon:
stp	x10, x11, [sp, #-80]!
stp	x12, x13, [sp, #16]
stp	x14, x15, [sp, #32]
stp	x10, x0, [sp, #48]
stp	x3, x4, [sp, #64]
tst	w7, #0x1
b.eq	wiener_filter7_hv_8bpc_neon
cbnz	x2, wiener_filter7_hv_8bpc_neon
sub	x3, x3, #3
ld1.16b	{ v3 }, [x3], #16
b	wiener_filter7_hv_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
ld1.s	{ v2 }[3], [x2], #4
sub	x3, x3, #3
ext.16b	v3, v2, v3, #13
b	wiener_filter7_hv_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
dup.16b	v2, v3[0]
sub	x3, x3, #3
ext.16b	v3, v2, v3, #13
ld1.8b	{ v4 }, [x3], #8
ushll.8h	v2, v3, #0
ushll2.8h	v3, v3, #0
ushll.8h	v4, v4, #0
tst	w7, #0x2
b.ne	wiener_filter7_hv_8bpc_neon
cmp	w4, #19
b.ge	wiener_filter7_hv_8bpc_neon
sub	w17, w4, #22
adrp	x6, wiener_filter7_hv_8bpc_neon
add	x6, x6, #0
sub	x6, x6, #6
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup.8h	v28, v28[0]
ld1.16b	{ v25, v26, v27 }, [x6]
bit.16b	v2, v28, v25
bit.16b	v3, v28, v26
bit.16b	v4, v28, v27
ext.16b	v17, v2, v3, #4
ext.16b	v19, v2, v3, #8
ext.16b	v16, v2, v3, #2
ext.16b	v20, v2, v3, #10
ext.16b	v21, v2, v3, #12
ext.16b	v18, v2, v3, #6
add.8h	v19, v19, v17
add.8h	v20, v20, v16
add.8h	v21, v21, v2
shl.8h	v22, v18, #7
mul.8h	v6, v18, v0[3]
mla.8h	v6, v19, v0[4]
mla.8h	v6, v20, v0[5]
mla.8h	v6, v21, v0[6]
ext.16b	v17, v3, v4, #4
ext.16b	v19, v3, v4, #8
ext.16b	v16, v3, v4, #2
ext.16b	v20, v3, v4, #10
ext.16b	v21, v3, v4, #12
ext.16b	v18, v3, v4, #6
add.8h	v19, v19, v17
add.8h	v20, v20, v16
add.8h	v21, v21, v3
shl.8h	v23, v18, #7
mul.8h	v7, v18, v0[3]
mla.8h	v7, v19, v0[4]
mla.8h	v7, v20, v0[5]
mla.8h	v7, v21, v0[6]
ld1.8h	{ v20, v21 }, [x11], #32
sub.8h	v22, v22, v30
sub.8h	v23, v23, v30
ld1.8h	{ v26, v27 }, [x13], #32
sqadd.8h	v6, v6, v22
sqadd.8h	v7, v7, v23
ld1.8h	{ v18, v19 }, [x10], #32
sshr.8h	v6, v6, #3
sshr.8h	v7, v7, #3
ld1.8h	{ v28, v29 }, [x14], #32
add.8h	v6, v6, v31
add.8h	v7, v7, v31
ld1.8h	{ v16, v17 }, [x9], #32
add.8h	v26, v20, v26
ld1.8h	{ v24, v25 }, [x12], #32
add.8h	v28, v18, v28
add.8h	v16, v16, v6
add.8h	v27, v21, v27
smull.4s	v18, v24, v1[3]
smlal.4s	v18, v26, v1[4]
smlal.4s	v18, v28, v1[5]
smlal.4s	v18, v16, v1[6]
add.8h	v29, v19, v29
smull2.4s	v19, v24, v1[3]
smlal2.4s	v19, v26, v1[4]
smlal2.4s	v19, v28, v1[5]
smlal2.4s	v19, v16, v1[6]
add.8h	v17, v17, v7
smull.4s	v20, v25, v1[3]
smlal.4s	v20, v27, v1[4]
smlal.4s	v20, v29, v1[5]
smlal.4s	v20, v17, v1[6]
smull2.4s	v21, v25, v1[3]
smlal2.4s	v21, v27, v1[4]
smlal2.4s	v21, v29, v1[5]
smlal2.4s	v21, v17, v1[6]
sqrshrun.4h	v18, v18, #11
sqrshrun2.8h	v18, v19, #11
sqrshrun.4h	v19, v20, #11
sqrshrun2.8h	v19, v21, #11
st1.8h	{ v6, v7 }, [x15], #32
sqxtun.8b	v18, v18
sqxtun2.16b	v18, v19
subs	w4, w4, #16
st1.16b	{ v18 }, [x0], #16
b.le	wiener_filter7_hv_8bpc_neon
mov.16b	v2, v4
ld1.16b	{ v4 }, [x3], #16
tst	w7, #0x2
ushll.8h	v3, v4, #0
ushll2.8h	v4, v4, #0
b.ne	wiener_filter7_hv_8bpc_neon
b	wiener_filter7_hv_8bpc_neon
ldp	x3, x4, [sp, #64]
ldp	x15, x0, [sp, #48]
ldp	x13, x14, [sp, #32]
ldp	x11, x12, [sp, #16]
ldp	x9, x10, [sp], #80
add	x3, x3, x1
add	x0, x0, x1
ret
_wiener_filter5_8bpc_neon:
stp	x29, x30, [sp, #-16]!
mov	x29, sp
ld1.8h	{ v0, v1 }, [x6]
tst	w7, #0x4
sub	sp, sp, #3072
mov	w17, #16380
dup.8h	v30, w17
movi.8h	v31, #8, lsl #8
mov	x14, sp
b.eq	wiener_filter5_8bpc_neon
mov	x16, x2
mov	x2, #0
bl	wiener_filter5_h_8bpc_neon
add	x3, x3, x1
mov	x11, x14
add	x14, x14, #768
bl	wiener_filter5_h_8bpc_neon
add	x3, x3, x1, lsl #2
add	x3, x3, x1
mov	x12, x14
add	x14, x14, #768
mov	x2, x16
mov	x16, x3
mov	x3, x0
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #1
mov	x13, x14
b.eq	wiener_filter5_8bpc_neon
add	x3, x3, x1
add	x14, x14, #768
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #1
b.eq	wiener_filter5_8bpc_neon
add	x3, x3, x1
mov	x15, x11
bl	wiener_filter5_hv_8bpc_neon
subs	w5, w5, #1
b.ne	wiener_filter5_8bpc_neon
tst	w7, #0x8
b.eq	wiener_filter5_8bpc_neon
mov	x3, x16
mov	x2, #0
bl	wiener_filter5_hv_8bpc_neon
bl	wiener_filter5_hv_8bpc_neon
mov	sp, x29
ldp	x29, x30, [sp], #16
ret
add	x3, x3, x1, lsl #2
add	x16, x3, x1, lsl #1
mov	x3, x0
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #1
mov	x11, x14
mov	x12, x14
mov	x13, x14
b.eq	wiener_filter5_8bpc_neon
add	x3, x3, x1
add	x14, x14, #768
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #1
b.eq	wiener_filter5_8bpc_neon
add	x3, x3, x1
add	x15, x14, #768
bl	wiener_filter5_hv_8bpc_neon
subs	w5, w5, #1
b.eq	wiener_filter5_8bpc_neon
add	x15, x15, #2304
bl	wiener_filter5_hv_8bpc_neon
subs	w5, w5, #1
b.ne	wiener_filter5_8bpc_neon
bl	wiener_filter5_v_8bpc_neon
add	x0, x0, x1
mov	x11, x12
mov	x12, x13
mov	x13, x14
bl	wiener_filter5_v_8bpc_neon
b	wiener_filter5_8bpc_neon
_wiener_filter5_h_8bpc_neon:
stp	x3, x4, [sp, #-32]!
str	x14, [sp, #16]
tst	w7, #0x1
b.eq	wiener_filter5_h_8bpc_neon
cbnz	x2, wiener_filter5_h_8bpc_neon
sub	x3, x3, #2
ld1.16b	{ v3 }, [x3], #16
b	wiener_filter5_h_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
ld1.s	{ v2 }[3], [x2], #4
sub	x3, x3, #2
ext.16b	v3, v2, v3, #14
b	wiener_filter5_h_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
dup.16b	v2, v3[0]
sub	x3, x3, #2
ext.16b	v3, v2, v3, #14
ld1.8b	{ v4 }, [x3], #8
ushll.8h	v2, v3, #0
ushll2.8h	v3, v3, #0
ushll.8h	v4, v4, #0
tst	w7, #0x2
b.ne	wiener_filter5_h_8bpc_neon
cmp	w4, #18
b.ge	wiener_filter5_h_8bpc_neon
sub	w17, w4, #23
adrp	x6, wiener_filter5_h_8bpc_neon
add	x6, x6, #0
sub	x6, x6, #4
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup.8h	v28, v28[0]
ld1.16b	{ v25, v26, v27 }, [x6]
bit.16b	v2, v28, v25
bit.16b	v3, v28, v26
bit.16b	v4, v28, v27
ext.16b	v16, v2, v3, #2
ext.16b	v18, v2, v3, #6
ext.16b	v19, v2, v3, #8
ext.16b	v17, v2, v3, #4
add.8h	v18, v18, v16
add.8h	v19, v19, v2
shl.8h	v22, v17, #7
mul.8h	v6, v17, v0[3]
mla.8h	v6, v18, v0[4]
mla.8h	v6, v19, v0[5]
ext.16b	v16, v3, v4, #2
ext.16b	v18, v3, v4, #6
ext.16b	v19, v3, v4, #8
ext.16b	v17, v3, v4, #4
add.8h	v18, v18, v16
add.8h	v19, v19, v3
shl.8h	v23, v17, #7
mul.8h	v7, v17, v0[3]
mla.8h	v7, v18, v0[4]
mla.8h	v7, v19, v0[5]
sub.8h	v22, v22, v30
sub.8h	v23, v23, v30
sqadd.8h	v6, v6, v22
sqadd.8h	v7, v7, v23
sshr.8h	v6, v6, #3
sshr.8h	v7, v7, #3
add.8h	v6, v6, v31
add.8h	v7, v7, v31
subs	w4, w4, #16
st1.8h	{ v6, v7 }, [x14], #32
b.le	wiener_filter5_h_8bpc_neon
mov.16b	v2, v4
ld1.16b	{ v4 }, [x3], #16
tst	w7, #0x2
ushll.8h	v3, v4, #0
ushll2.8h	v4, v4, #0
b.ne	wiener_filter5_h_8bpc_neon
b	wiener_filter5_h_8bpc_neon
ldr	x14, [sp, #16]
ldp	x3, x4, [sp], #32
ret
_wiener_filter5_v_8bpc_neon:
stp	x11, x12, [sp, #-48]!
stp	x13, x14, [sp, #16]
stp	x0, x4, [sp, #32]
ld1.8h	{ v18, v19 }, [x12], #32
ld1.8h	{ v22, v23 }, [x14], #32
ld1.8h	{ v16, v17 }, [x11], #32
add.8h	v24, v22, v18
ld1.8h	{ v20, v21 }, [x13], #32
add.8h	v16, v22, v16
add.8h	v25, v23, v19
smull.4s	v2, v20, v1[3]
smlal.4s	v2, v24, v1[4]
smlal.4s	v2, v16, v1[5]
add.8h	v17, v23, v17
smull2.4s	v3, v20, v1[3]
smlal2.4s	v3, v24, v1[4]
smlal2.4s	v3, v16, v1[5]
smull.4s	v4, v21, v1[3]
smlal.4s	v4, v25, v1[4]
smlal.4s	v4, v17, v1[5]
smull2.4s	v5, v21, v1[3]
smlal2.4s	v5, v25, v1[4]
smlal2.4s	v5, v17, v1[5]
sqrshrun.4h	v2, v2, #11
sqrshrun2.8h	v2, v3, #11
sqrshrun.4h	v3, v4, #11
sqrshrun2.8h	v3, v5, #11
sqxtun.8b	v2, v2
sqxtun2.16b	v2, v3
subs	w4, w4, #16
st1.16b	{ v2 }, [x0], #16
b.gt	wiener_filter5_v_8bpc_neon
ldp	x0, x4, [sp, #32]
ldp	x13, x14, [sp, #16]
ldp	x11, x12, [sp], #48
ret
_wiener_filter5_hv_8bpc_neon:
stp	x12, x13, [sp, #-64]!
stp	x14, x15, [sp, #16]
stp	x12, x0, [sp, #32]
stp	x3, x4, [sp, #48]
tst	w7, #0x1
b.eq	wiener_filter5_hv_8bpc_neon
cbnz	x2, wiener_filter5_hv_8bpc_neon
sub	x3, x3, #2
ld1.16b	{ v3 }, [x3], #16
b	wiener_filter5_hv_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
ld1.s	{ v2 }[3], [x2], #4
sub	x3, x3, #2
ext.16b	v3, v2, v3, #14
b	wiener_filter5_hv_8bpc_neon
ld1.16b	{ v3 }, [x3], #16
dup.16b	v2, v3[0]
sub	x3, x3, #2
ext.16b	v3, v2, v3, #14
ld1.8b	{ v4 }, [x3], #8
ushll.8h	v2, v3, #0
ushll2.8h	v3, v3, #0
ushll.8h	v4, v4, #0
tst	w7, #0x2
b.ne	wiener_filter5_hv_8bpc_neon
cmp	w4, #18
b.ge	wiener_filter5_hv_8bpc_neon
sub	w17, w4, #23
adrp	x6, wiener_filter5_hv_8bpc_neon
add	x6, x6, #0
sub	x6, x6, #4
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup.8h	v28, v28[0]
ld1.16b	{ v25, v26, v27 }, [x6]
bit.16b	v2, v28, v25
bit.16b	v3, v28, v26
bit.16b	v4, v28, v27
ext.16b	v16, v2, v3, #2
ext.16b	v18, v2, v3, #6
ext.16b	v19, v2, v3, #8
ext.16b	v17, v2, v3, #4
add.8h	v18, v18, v16
add.8h	v19, v19, v2
shl.8h	v22, v17, #7
mul.8h	v6, v17, v0[3]
mla.8h	v6, v18, v0[4]
mla.8h	v6, v19, v0[5]
ext.16b	v16, v3, v4, #2
ext.16b	v18, v3, v4, #6
ext.16b	v19, v3, v4, #8
ext.16b	v17, v3, v4, #4
add.8h	v18, v18, v16
add.8h	v19, v19, v3
shl.8h	v23, v17, #7
mul.8h	v7, v17, v0[3]
mla.8h	v7, v18, v0[4]
mla.8h	v7, v19, v0[5]
ld1.8h	{ v18, v19 }, [x12], #32
sub.8h	v22, v22, v30
sub.8h	v23, v23, v30
ld1.8h	{ v24, v25 }, [x14], #32
sqadd.8h	v6, v6, v22
sqadd.8h	v7, v7, v23
ld1.8h	{ v16, v17 }, [x11], #32
sshr.8h	v6, v6, #3
sshr.8h	v7, v7, #3
ld1.8h	{ v20, v21 }, [x13], #32
add.8h	v6, v6, v31
add.8h	v7, v7, v31
add.8h	v24, v24, v18
add.8h	v16, v16, v6
smull.4s	v18, v20, v1[3]
smlal.4s	v18, v24, v1[4]
smlal.4s	v18, v16, v1[5]
add.8h	v25, v25, v19
smull2.4s	v19, v20, v1[3]
smlal2.4s	v19, v24, v1[4]
smlal2.4s	v19, v16, v1[5]
add.8h	v17, v17, v7
smull.4s	v20, v21, v1[3]
smlal.4s	v20, v25, v1[4]
smlal.4s	v20, v17, v1[5]
smull2.4s	v21, v21, v1[3]
smlal2.4s	v21, v25, v1[4]
smlal2.4s	v21, v17, v1[5]
sqrshrun.4h	v18, v18, #11
sqrshrun2.8h	v18, v19, #11
sqrshrun.4h	v19, v20, #11
sqrshrun2.8h	v19, v21, #11
st1.8h	{ v6, v7 }, [x15], #32
sqxtun.8b	v18, v18
sqxtun2.16b	v18, v19
subs	w4, w4, #16
st1.16b	{ v18 }, [x0], #16
b.le	wiener_filter5_hv_8bpc_neon
mov.16b	v2, v4
ld1.16b	{ v4 }, [x3], #16
tst	w7, #0x2
ushll.8h	v3, v4, #0
ushll2.8h	v4, v4, #0
b.ne	wiener_filter5_hv_8bpc_neon
b	wiener_filter5_hv_8bpc_neon
ldp	x3, x4, [sp, #48]
ldp	x15, x0, [sp, #32]
ldp	x13, x14, [sp, #16]
ldp	x11, x12, [sp], #64
add	x3, x3, x1
add	x0, x0, x1
ret
_sgr_box3_row_h_8bpc_neon:
add	w4, w4, #2
tst	w5, #0x1
b.eq	sgr_box3_row_h_8bpc_neon
cbnz	x2, sgr_box3_row_h_8bpc_neon
sub	x3, x3, #2
ld1.16b	{ v0 }, [x3], #16
b	sgr_box3_row_h_8bpc_neon
ld1.16b	{ v0 }, [x3], #16
ld1.s	{ v1 }[3], [x2]
sub	x3, x3, #2
ext.16b	v0, v1, v0, #14
b	sgr_box3_row_h_8bpc_neon
ld1.16b	{ v0 }, [x3], #16
dup.16b	v1, v0[0]
sub	x3, x3, #2
ext.16b	v0, v1, v0, #14
umull.8h	v1, v0, v0
umull2.8h	v2, v0, v0
tst	w5, #0x2
b.ne	sgr_box3_row_h_8bpc_neon
sub	w13, w4, #17
ldr	b30, [x3, w13, sxtw]
dup.16b	v30, v30[0]
cmp	w4, #10
b.ge	sgr_box3_row_h_8bpc_neon
adrp	x13, sgr_box3_row_h_8bpc_neon
add	x13, x13, #0
sub	x13, x13, w4, uxtw
ld1.16b	{ v29 }, [x13]
bit.16b	v0, v30, v29
umull.8h	v1, v0, v0
umull2.8h	v2, v0, v0
ext.16b	v16, v0, v0, #1
ext.16b	v17, v0, v0, #2
uaddl.8h	v3, v0, v16
ext.16b	v20, v1, v2, #2
uaddw.8h	v3, v3, v17
ext.16b	v21, v1, v2, #4
uaddl.4s	v26, v1, v20
uaddl2.4s	v27, v1, v20
uaddw.4s	v26, v26, v21
uaddw2.4s	v27, v27, v21
subs	w4, w4, #8
st1.8h	{ v3 }, [x1], #16
st1.4s	{ v26, v27 }, [x0], #32
b.le	sgr_box3_row_h_8bpc_neon
tst	w5, #0x2
ld1.8b	{ v3 }, [x3], #8
mov.16b	v1, v2
ext.16b	v0, v0, v3, #8
umull.8h	v2, v3, v3
b.ne	sgr_box3_row_h_8bpc_neon
b	sgr_box3_row_h_8bpc_neon
ret
_sgr_box5_row_h_8bpc_neon:
add	w4, w4, #2
tst	w5, #0x1
b.eq	sgr_box5_row_h_8bpc_neon
cbnz	x2, sgr_box5_row_h_8bpc_neon
sub	x3, x3, #3
ld1.16b	{ v0 }, [x3], #16
b	sgr_box5_row_h_8bpc_neon
ld1.16b	{ v0 }, [x3], #16
ld1.s	{ v1 }[3], [x2], #4
sub	x3, x3, #3
ext.16b	v0, v1, v0, #13
b	sgr_box5_row_h_8bpc_neon
ld1.16b	{ v0 }, [x3], #16
dup.16b	v1, v0[0]
sub	x3, x3, #3
ext.16b	v0, v1, v0, #13
umull.8h	v1, v0, v0
umull2.8h	v2, v0, v0
tst	w5, #0x2
b.ne	sgr_box5_row_h_8bpc_neon
sub	w13, w4, #16
ldr	b30, [x3, w13, sxtw]
dup.16b	v30, v30[0]
cmp	w4, #11
b.ge	sgr_box5_row_h_8bpc_neon
adrp	x13, sgr_box5_row_h_8bpc_neon
add	x13, x13, #0
sub	x13, x13, #1
sub	x13, x13, w4, uxtw
ld1.16b	{ v29 }, [x13]
bit.16b	v0, v30, v29
umull.8h	v1, v0, v0
umull2.8h	v2, v0, v0
ext.16b	v16, v0, v0, #1
ext.16b	v17, v0, v0, #2
ext.16b	v18, v0, v0, #3
ext.16b	v19, v0, v0, #4
uaddl.8h	v3, v0, v16
uaddl.8h	v24, v17, v18
uaddw.8h	v3, v3, v19
add.8h	v3, v3, v24
ext.16b	v16, v1, v2, #2
ext.16b	v17, v1, v2, #4
ext.16b	v18, v1, v2, #6
ext.16b	v19, v1, v2, #8
uaddl.4s	v26, v1, v16
uaddl2.4s	v27, v1, v16
uaddl.4s	v16, v17, v18
uaddl2.4s	v17, v17, v18
uaddw.4s	v26, v26, v19
uaddw2.4s	v27, v27, v19
add.4s	v26, v26, v16
add.4s	v27, v27, v17
subs	w4, w4, #8
st1.8h	{ v3 }, [x1], #16
st1.4s	{ v26, v27 }, [x0], #32
b.le	sgr_box5_row_h_8bpc_neon
tst	w5, #0x2
ld1.8b	{ v3 }, [x3], #8
mov.16b	v1, v2
ext.16b	v0, v0, v3, #8
umull.8h	v2, v3, v3
b.ne	sgr_box5_row_h_8bpc_neon
b	sgr_box5_row_h_8bpc_neon
ret
_sgr_box35_row_h_8bpc_neon:
add	w6, w6, #2
tst	w7, #0x1
b.eq	sgr_box35_row_h_8bpc_neon
cbnz	x4, sgr_box35_row_h_8bpc_neon
sub	x5, x5, #3
ld1.16b	{ v0 }, [x5], #16
b	sgr_box35_row_h_8bpc_neon
ld1.16b	{ v0 }, [x5], #16
ld1.s	{ v1 }[3], [x4], #4
sub	x5, x5, #3
ext.16b	v0, v1, v0, #13
b	sgr_box35_row_h_8bpc_neon
ld1.16b	{ v0 }, [x5], #16
dup.16b	v1, v0[0]
sub	x5, x5, #3
ext.16b	v0, v1, v0, #13
umull.8h	v1, v0, v0
umull2.8h	v2, v0, v0
tst	w7, #0x2
b.ne	sgr_box35_row_h_8bpc_neon
sub	w13, w6, #16
ldr	b30, [x5, w13, sxtw]
dup.16b	v30, v30[0]
cmp	w6, #11
b.ge	sgr_box35_row_h_8bpc_neon
adrp	x13, sgr_box35_row_h_8bpc_neon
add	x13, x13, #0
sub	x13, x13, #1
sub	x13, x13, w6, uxtw
ld1.16b	{ v29 }, [x13]
bit.16b	v0, v30, v29
umull.8h	v1, v0, v0
umull2.8h	v2, v0, v0
ext.16b	v16, v0, v0, #1
ext.16b	v17, v0, v0, #2
ext.16b	v19, v0, v0, #4
ext.16b	v18, v0, v0, #3
uaddl.8h	v3, v16, v17
uaddl.8h	v24, v0, v19
uaddw.8h	v3, v3, v18
ext.16b	v16, v1, v2, #2
ext.16b	v17, v1, v2, #4
ext.16b	v19, v1, v2, #8
ext.16b	v18, v1, v2, #6
st1.8h	{ v3 }, [x1], #16
add.8h	v3, v3, v24
uaddl.4s	v26, v16, v17
uaddl2.4s	v27, v16, v17
uaddl.4s	v16, v1, v19
uaddl2.4s	v17, v1, v19
uaddw.4s	v26, v26, v18
uaddw2.4s	v27, v27, v18
st1.4s	{ v26, v27 }, [x0], #32
add.4s	v26, v26, v16
add.4s	v27, v27, v17
subs	w6, w6, #8
st1.8h	{ v3 }, [x3], #16
st1.4s	{ v26, v27 }, [x2], #32
b.le	sgr_box35_row_h_8bpc_neon
tst	w7, #0x2
ld1.8b	{ v3 }, [x5], #8
mov.16b	v1, v2
ext.16b	v0, v0, v3, #8
umull.8h	v2, v3, v3
b.ne	sgr_box35_row_h_8bpc_neon
b	sgr_box35_row_h_8bpc_neon
ret
_sgr_finish_filter1_2rows_8bpc_neon:
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	x7, x8, [x3]
ldp	x9, x3, [x3, #16]
ldp	x10, x11, [x4]
ldp	x12, x4, [x4, #16]
mov	x13, #384
cmp	w6, #1
add	x2, x1, x2
csel	x2, x1, x2, le
add	x13, x0, x13, lsl #1
movi.8h	v30, #3
movi.4s	v31, #3
ld1.8h	{ v0, v1 }, [x10], #32
ld1.8h	{ v2, v3 }, [x11], #32
ld1.8h	{ v4, v5 }, [x12], #32
ld1.8h	{ v6, v7 }, [x4], #32
ld1.4s	{ v16, v17, v18 }, [x7], #48
ld1.4s	{ v19, v20, v21 }, [x8], #48
ld1.4s	{ v22, v23, v24 }, [x9], #48
ld1.4s	{ v25, v26, v27 }, [x3], #48
ext.16b	v8, v0, v1, #2
ext.16b	v9, v2, v3, #2
ext.16b	v10, v4, v5, #2
ext.16b	v11, v0, v1, #4
ext.16b	v12, v2, v3, #4
ext.16b	v13, v4, v5, #4
add.8h	v14, v2, v8
add.8h	v15, v9, v10
add.8h	v28, v0, v11
add.8h	v14, v14, v12
add.8h	v29, v4, v13
ext.16b	v8, v6, v7, #2
ext.16b	v11, v6, v7, #4
add.8h	v14, v14, v15
add.8h	v15, v28, v29
add.8h	v28, v4, v9
add.8h	v29, v10, v8
add.8h	v2, v2, v12
add.8h	v28, v28, v13
add.8h	v4, v6, v11
add.8h	v0, v28, v29
add.8h	v2, v2, v4
shl.8h	v4, v14, #2
mla.8h	v4, v15, v30
shl.8h	v0, v0, #2
mla.8h	v0, v2, v30
ext.16b	v8, v16, v17, #4
ext.16b	v9, v17, v18, #4
ext.16b	v10, v16, v17, #8
ext.16b	v11, v17, v18, #8
ext.16b	v12, v19, v20, #4
ext.16b	v13, v20, v21, #4
add.4s	v8, v8, v19
add.4s	v9, v9, v20
add.4s	v16, v16, v10
add.4s	v17, v17, v11
ext.16b	v14, v19, v20, #8
ext.16b	v15, v20, v21, #8
add.4s	v16, v16, v22
add.4s	v17, v17, v23
add.4s	v28, v12, v14
add.4s	v29, v13, v15
ext.16b	v10, v22, v23, #4
ext.16b	v11, v23, v24, #4
add.4s	v8, v8, v28
add.4s	v9, v9, v29
add.4s	v19, v19, v14
add.4s	v20, v20, v15
add.4s	v14, v22, v12
add.4s	v15, v23, v13
ext.16b	v12, v22, v23, #8
ext.16b	v13, v23, v24, #8
ext.16b	v28, v25, v26, #4
ext.16b	v29, v26, v27, #4
add.4s	v8, v8, v10
add.4s	v9, v9, v11
add.4s	v14, v14, v10
add.4s	v15, v15, v11
ext.16b	v10, v25, v26, #8
ext.16b	v11, v26, v27, #8
add.4s	v16, v16, v12
add.4s	v17, v17, v13
add.4s	v12, v12, v28
add.4s	v13, v13, v29
add.4s	v25, v25, v10
add.4s	v26, v26, v11
add.4s	v14, v14, v12
add.4s	v15, v15, v13
add.4s	v19, v19, v25
add.4s	v20, v20, v26
ld1.8b	{ v25 }, [x1], #8
ld1.8b	{ v26 }, [x2], #8
shl.4s	v8, v8, #2
shl.4s	v9, v9, #2
mla.4s	v8, v16, v31
mla.4s	v9, v17, v31
ushll.8h	v25, v25, #0
ushll.8h	v26, v26, #0
shl.4s	v14, v14, #2
shl.4s	v15, v15, #2
mla.4s	v14, v19, v31
mla.4s	v15, v20, v31
umlal.4s	v8, v4, v25
umlal2.4s	v9, v4, v25
umlal.4s	v14, v0, v26
umlal2.4s	v15, v0, v26
mov.16b	v0, v1
rshrn.4h	v8, v8, #9
rshrn2.8h	v8, v9, #9
mov.16b	v2, v3
rshrn.4h	v14, v14, #9
rshrn2.8h	v14, v15, #9
subs	w5, w5, #8
mov.16b	v4, v5
st1.8h	{ v8 }, [x0], #16
mov.16b	v6, v7
st1.8h	{ v14 }, [x13], #16
b.le	sgr_finish_filter1_2rows_8bpc_neon
mov.16b	v16, v18
mov.16b	v19, v21
mov.16b	v22, v24
mov.16b	v25, v27
ld1.8h	{ v1 }, [x10], #16
ld1.8h	{ v3 }, [x11], #16
ld1.8h	{ v5 }, [x12], #16
ld1.8h	{ v7 }, [x4], #16
ld1.4s	{ v17, v18 }, [x7], #32
ld1.4s	{ v20, v21 }, [x8], #32
ld1.4s	{ v23, v24 }, [x9], #32
ld1.4s	{ v26, v27 }, [x3], #32
b	sgr_finish_filter1_2rows_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
_sgr_finish_weighted1_8bpc_neon:
ldp	x7, x8, [x1]
ldr	x1, [x1, #16]
ldp	x9, x10, [x2]
ldr	x2, [x2, #16]
dup.8h	v31, w4
dup.8h	v30, w5
movi.8h	v6, #3
movi.4s	v7, #3
ld1.8h	{ v0, v1 }, [x9], #32
ld1.8h	{ v2, v3 }, [x10], #32
ld1.8h	{ v4, v5 }, [x2], #32
ld1.4s	{ v16, v17, v18 }, [x7], #48
ld1.4s	{ v19, v20, v21 }, [x8], #48
ld1.4s	{ v22, v23, v24 }, [x1], #48
ext.16b	v25, v0, v1, #2
ext.16b	v26, v2, v3, #2
ext.16b	v27, v4, v5, #2
ext.16b	v28, v0, v1, #4
ext.16b	v29, v2, v3, #4
add.8h	v2, v2, v25
ext.16b	v25, v4, v5, #4
add.8h	v26, v26, v27
add.8h	v0, v0, v28
add.8h	v2, v2, v26
add.8h	v4, v4, v25
add.8h	v2, v2, v29
add.8h	v0, v0, v4
ext.16b	v25, v16, v17, #4
ext.16b	v26, v17, v18, #4
shl.8h	v2, v2, #2
ext.16b	v27, v16, v17, #8
ext.16b	v28, v17, v18, #8
ext.16b	v29, v19, v20, #4
ext.16b	v4, v20, v21, #4
mla.8h	v2, v0, v6
add.4s	v25, v25, v19
add.4s	v26, v26, v20
add.4s	v16, v16, v27
add.4s	v17, v17, v28
ext.16b	v27, v19, v20, #8
ext.16b	v28, v20, v21, #8
add.4s	v16, v16, v22
add.4s	v17, v17, v23
add.4s	v29, v29, v27
add.4s	v4, v4, v28
add.4s	v25, v25, v29
add.4s	v26, v26, v4
ext.16b	v27, v22, v23, #4
ext.16b	v28, v23, v24, #4
ext.16b	v29, v22, v23, #8
ext.16b	v4, v23, v24, #8
ld1.8b	{ v19 }, [x0]
add.4s	v25, v25, v27
add.4s	v26, v26, v28
add.4s	v16, v16, v29
add.4s	v17, v17, v4
shl.4s	v25, v25, #2
shl.4s	v26, v26, #2
mla.4s	v25, v16, v7
mla.4s	v26, v17, v7
ushll.8h	v19, v19, #0
mov.16b	v0, v1
umlal.4s	v25, v2, v19
umlal2.4s	v26, v2, v19
mov.16b	v2, v3
rshrn.4h	v25, v25, #9
rshrn2.8h	v25, v26, #9
subs	w3, w3, #8
shl.8h	v19, v19, #4
mov.16b	v4, v5
sub.8h	v25, v25, v19
ld1.8h	{ v1 }, [x9], #16
ushll.4s	v26, v19, #7
ushll2.4s	v27, v19, #7
ld1.8h	{ v3 }, [x10], #16
smlal.4s	v26, v25, v31
smlal2.4s	v27, v25, v31
ld1.8h	{ v5 }, [x2], #16
rshrn.4h	v26, v26, #11
rshrn2.8h	v26, v27, #11
mov.16b	v16, v18
sqxtun.8b	v26, v26
mov.16b	v19, v21
mov.16b	v22, v24
st1.8b	{ v26 }, [x0], #8
b.le	sgr_finish_weighted1_8bpc_neon
ld1.4s	{ v17, v18 }, [x7], #32
ld1.4s	{ v20, v21 }, [x8], #32
ld1.4s	{ v23, v24 }, [x1], #32
b	sgr_finish_weighted1_8bpc_neon
ret
_sgr_finish_filter2_2rows_8bpc_neon:
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	x3, x7, [x3]
ldp	x4, x8, [x4]
mov	x10, #384
cmp	w6, #1
add	x2, x1, x2
csel	x2, x1, x2, le
add	x10, x0, x10, lsl #1
movi.8h	v4, #5
movi.4s	v5, #5
movi.8h	v6, #6
movi.4s	v7, #6
ld1.8h	{ v0, v1 }, [x4], #32
ld1.8h	{ v2, v3 }, [x8], #32
ld1.4s	{ v16, v17, v18 }, [x3], #48
ld1.4s	{ v19, v20, v21 }, [x7], #48
ext.16b	v24, v0, v1, #4
ext.16b	v25, v2, v3, #4
ext.16b	v22, v0, v1, #2
ext.16b	v23, v2, v3, #2
add.8h	v0, v0, v24
add.8h	v25, v2, v25
add.8h	v2, v22, v23
add.8h	v0, v0, v25
mul.8h	v8, v25, v4
mla.8h	v8, v23, v6
ext.16b	v22, v16, v17, #4
ext.16b	v23, v17, v18, #4
ext.16b	v24, v19, v20, #4
ext.16b	v25, v20, v21, #4
ext.16b	v26, v16, v17, #8
ext.16b	v27, v17, v18, #8
ext.16b	v28, v19, v20, #8
ext.16b	v29, v20, v21, #8
mul.8h	v0, v0, v4
mla.8h	v0, v2, v6
ld1.8b	{ v31 }, [x1], #8
ld1.8b	{ v30 }, [x2], #8
add.4s	v16, v16, v26
add.4s	v17, v17, v27
add.4s	v19, v19, v28
add.4s	v20, v20, v29
add.4s	v16, v16, v19
add.4s	v17, v17, v20
mul.4s	v9, v19, v5
mla.4s	v9, v24, v7
mul.4s	v10, v20, v5
mla.4s	v10, v25, v7
add.4s	v22, v22, v24
add.4s	v23, v23, v25
mul.4s	v16, v16, v5
mla.4s	v16, v22, v7
mul.4s	v17, v17, v5
mla.4s	v17, v23, v7
ushll.8h	v31, v31, #0
ushll.8h	v30, v30, #0
umlal.4s	v16, v0, v31
umlal2.4s	v17, v0, v31
umlal.4s	v9, v8, v30
umlal2.4s	v10, v8, v30
mov.16b	v0, v1
rshrn.4h	v16, v16, #9
rshrn2.8h	v16, v17, #9
rshrn.4h	v9, v9, #8
rshrn2.8h	v9, v10, #8
subs	w5, w5, #8
mov.16b	v2, v3
st1.8h	{ v16 }, [x0], #16
st1.8h	{ v9 }, [x10], #16
b.le	sgr_finish_filter2_2rows_8bpc_neon
mov.16b	v16, v18
mov.16b	v19, v21
ld1.8h	{ v1 }, [x4], #16
ld1.8h	{ v3 }, [x8], #16
ld1.4s	{ v17, v18 }, [x3], #32
ld1.4s	{ v20, v21 }, [x7], #32
b	sgr_finish_filter2_2rows_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
_sgr_finish_weighted2_8bpc_neon:
stp	d8, d9, [sp, #-48]!
str	d10, [sp, #16]
stp	d14, d15, [sp, #32]
dup.8h	v14, w6
dup.8h	v15, w7
ldp	x2, x7, [x2]
ldp	x3, x8, [x3]
cmp	w5, #1
add	x1, x0, x1
csel	x1, x2, x1, le
movi.8h	v4, #5
movi.4s	v5, #5
movi.8h	v6, #6
movi.4s	v7, #6
ld1.8h	{ v0, v1 }, [x3], #32
ld1.8h	{ v2, v3 }, [x8], #32
ld1.4s	{ v16, v17, v18 }, [x2], #48
ld1.4s	{ v19, v20, v21 }, [x7], #48
ext.16b	v24, v0, v1, #4
ext.16b	v25, v2, v3, #4
ext.16b	v22, v0, v1, #2
ext.16b	v23, v2, v3, #2
add.8h	v0, v0, v24
add.8h	v25, v2, v25
add.8h	v2, v22, v23
add.8h	v0, v0, v25
mul.8h	v8, v25, v4
mla.8h	v8, v23, v6
ext.16b	v22, v16, v17, #4
ext.16b	v23, v17, v18, #4
ext.16b	v24, v19, v20, #4
ext.16b	v25, v20, v21, #4
ext.16b	v26, v16, v17, #8
ext.16b	v27, v17, v18, #8
ext.16b	v28, v19, v20, #8
ext.16b	v29, v20, v21, #8
mul.8h	v0, v0, v4
mla.8h	v0, v2, v6
ld1.8b	{ v31 }, [x0]
ld1.8b	{ v30 }, [x1]
add.4s	v16, v16, v26
add.4s	v17, v17, v27
add.4s	v19, v19, v28
add.4s	v20, v20, v29
add.4s	v16, v16, v19
add.4s	v17, v17, v20
mul.4s	v9, v19, v5
mla.4s	v9, v24, v7
mul.4s	v10, v20, v5
mla.4s	v10, v25, v7
add.4s	v22, v22, v24
add.4s	v23, v23, v25
mul.4s	v16, v16, v5
mla.4s	v16, v22, v7
mul.4s	v17, v17, v5
mla.4s	v17, v23, v7
ushll.8h	v31, v31, #0
ushll.8h	v30, v30, #0
umlal.4s	v16, v0, v31
umlal2.4s	v17, v0, v31
umlal.4s	v9, v8, v30
umlal2.4s	v10, v8, v30
mov.16b	v0, v1
rshrn.4h	v16, v16, #9
rshrn2.8h	v16, v17, #9
rshrn.4h	v9, v9, #8
rshrn2.8h	v9, v10, #8
subs	w4, w4, #8
shl.8h	v31, v31, #4
shl.8h	v30, v30, #4
mov.16b	v2, v3
sub.8h	v16, v16, v31
sub.8h	v9, v9, v30
ld1.8h	{ v1 }, [x3], #16
ushll.4s	v22, v31, #7
ushll2.4s	v23, v31, #7
ushll.4s	v24, v30, #7
ushll2.4s	v25, v30, #7
ld1.8h	{ v3 }, [x8], #16
smlal.4s	v22, v16, v14
smlal2.4s	v23, v16, v14
mov.16b	v16, v18
smlal.4s	v24, v9, v14
smlal2.4s	v25, v9, v14
mov.16b	v19, v21
rshrn.4h	v22, v22, #11
rshrn2.8h	v22, v23, #11
rshrn.4h	v23, v24, #11
rshrn2.8h	v23, v25, #11
sqxtun.8b	v22, v22
sqxtun.8b	v23, v23
st1.8b	{ v22 }, [x0], #8
st1.8b	{ v23 }, [x1], #8
b.le	sgr_finish_weighted2_8bpc_neon
ld1.4s	{ v17, v18 }, [x2], #32
ld1.4s	{ v20, v21 }, [x7], #32
b	sgr_finish_weighted2_8bpc_neon
ldp	d14, d15, [sp, #32]
ldr	d10, [sp, #16]
ldp	d8, d9, [sp], #48
ret
_sgr_weighted2_8bpc_neon:
ldr	x8, [sp]
cmp	w7, #2
add	x10, x0, x1
add	x11, x2, x3
add	x12, x4, #768
add	x13, x5, #768
ld2r.8h	{ v30, v31 }, [x8]
mov	x8, #1536
lsl	x1, x1, #1
lsl	x3, x3, #1
add	x9, x6, #7
and	x9, x9, #0xfffffffffffffff8
sub	x1, x1, x9
sub	x3, x3, x9
sub	x8, x8, x9, lsl #1
mov	w9, w6
b.lt	sgr_weighted2_8bpc_neon
ld1.8b	{ v0 }, [x2], #8
ld1.8b	{ v16 }, [x11], #8
ld1.8h	{ v1 }, [x4], #16
ld1.8h	{ v17 }, [x12], #16
ld1.8h	{ v2 }, [x5], #16
ld1.8h	{ v18 }, [x13], #16
subs	w6, w6, #8
ushll.8h	v0, v0, #4
ushll.8h	v16, v16, #4
sub.8h	v1, v1, v0
sub.8h	v2, v2, v0
sub.8h	v17, v17, v16
sub.8h	v18, v18, v16
ushll.4s	v3, v0, #7
ushll2.4s	v4, v0, #7
ushll.4s	v19, v16, #7
ushll2.4s	v20, v16, #7
smlal.4s	v3, v1, v30
smlal.4s	v3, v2, v31
smlal2.4s	v4, v1, v30
smlal2.4s	v4, v2, v31
smlal.4s	v19, v17, v30
smlal.4s	v19, v18, v31
smlal2.4s	v20, v17, v30
smlal2.4s	v20, v18, v31
rshrn.4h	v3, v3, #11
rshrn2.8h	v3, v4, #11
rshrn.4h	v19, v19, #11
rshrn2.8h	v19, v20, #11
sqxtun.8b	v3, v3
sqxtun.8b	v19, v19
st1.8b	{ v3 }, [x0], #8
st1.8b	{ v19 }, [x10], #8
b.gt	sgr_weighted2_8bpc_neon
subs	w7, w7, #2
cmp	w7, #1
b.lt	sgr_weighted2_8bpc_neon
mov	w6, w9
add	x0, x0, x1
add	x10, x10, x1
add	x2, x2, x3
add	x11, x11, x3
add	x4, x4, x8
add	x12, x12, x8
add	x5, x5, x8
add	x13, x13, x8
b.eq	sgr_weighted2_8bpc_neon
b	sgr_weighted2_8bpc_neon
ld1.8b	{ v0 }, [x2], #8
ld1.8h	{ v1 }, [x4], #16
ld1.8h	{ v2 }, [x5], #16
subs	w6, w6, #8
ushll.8h	v0, v0, #4
sub.8h	v1, v1, v0
sub.8h	v2, v2, v0
ushll.4s	v3, v0, #7
ushll2.4s	v4, v0, #7
smlal.4s	v3, v1, v30
smlal.4s	v3, v2, v31
smlal2.4s	v4, v1, v30
smlal2.4s	v4, v2, v31
rshrn.4h	v3, v3, #11
rshrn2.8h	v3, v4, #11
sqxtun.8b	v3, v3
st1.8b	{ v3 }, [x0], #8
b.gt	sgr_weighted2_8bpc_neon
ret