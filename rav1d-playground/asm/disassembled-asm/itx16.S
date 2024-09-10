_ltmp0:
mvni.8h	v31, #252, lsl #8
ld1.d	{ v0 }[0], [x0], x1
ld1.d	{ v0 }[1], [x0], x1
ld1.d	{ v1 }[0], [x0], x1
subs	w4, w4, #4
ld1.d	{ v1 }[1], [x0], x1
usqadd.8h	v0, v16
sub	x0, x0, x1, lsl #2
usqadd.8h	v1, v16
smin.8h	v0, v0, v31
st1.d	{ v0 }[0], [x0], x1
smin.8h	v1, v1, v31
st1.d	{ v0 }[1], [x0], x1
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x0], x1
b.gt	ltmp0
ret
_idct_dc_w8_neon:
mvni.8h	v31, #252, lsl #8
ld1.8h	{ v0 }, [x0], x1
subs	w4, w4, #4
ld1.8h	{ v1 }, [x0], x1
usqadd.8h	v0, v16
ld1.8h	{ v2 }, [x0], x1
usqadd.8h	v1, v16
ld1.8h	{ v3 }, [x0], x1
usqadd.8h	v2, v16
usqadd.8h	v3, v16
sub	x0, x0, x1, lsl #2
smin.8h	v0, v0, v31
smin.8h	v1, v1, v31
st1.8h	{ v0 }, [x0], x1
smin.8h	v2, v2, v31
st1.8h	{ v1 }, [x0], x1
smin.8h	v3, v3, v31
st1.8h	{ v2 }, [x0], x1
st1.8h	{ v3 }, [x0], x1
b.gt	idct_dc_w8_neon
ret
_idct_dc_w16_neon:
mvni.8h	v31, #252, lsl #8
ld1.8h	{ v0, v1 }, [x0], x1
subs	w4, w4, #2
ld1.8h	{ v2, v3 }, [x0], x1
usqadd.8h	v0, v16
usqadd.8h	v1, v16
sub	x0, x0, x1, lsl #1
usqadd.8h	v2, v16
usqadd.8h	v3, v16
smin.8h	v0, v0, v31
smin.8h	v1, v1, v31
smin.8h	v2, v2, v31
st1.8h	{ v0, v1 }, [x0], x1
smin.8h	v3, v3, v31
st1.8h	{ v2, v3 }, [x0], x1
b.gt	idct_dc_w16_neon
ret
_idct_dc_w32_neon:
mvni.8h	v31, #252, lsl #8
ld1.8h	{ v0, v1, v2, v3 }, [x0]
subs	w4, w4, #1
usqadd.8h	v0, v16
usqadd.8h	v1, v16
usqadd.8h	v2, v16
usqadd.8h	v3, v16
smin.8h	v0, v0, v31
smin.8h	v1, v1, v31
smin.8h	v2, v2, v31
smin.8h	v3, v3, v31
st1.8h	{ v0, v1, v2, v3 }, [x0], x1
b.gt	idct_dc_w32_neon
ret
_idct_dc_w64_neon:
mvni.8h	v31, #252, lsl #8
sub	x1, x1, #64
ld1.8h	{ v0, v1, v2, v3 }, [x0], #64
subs	w4, w4, #1
usqadd.8h	v0, v16
ld1.8h	{ v4, v5, v6, v7 }, [x0]
usqadd.8h	v1, v16
sub	x0, x0, #64
usqadd.8h	v2, v16
usqadd.8h	v3, v16
usqadd.8h	v4, v16
usqadd.8h	v5, v16
usqadd.8h	v6, v16
usqadd.8h	v7, v16
smin.8h	v0, v0, v31
smin.8h	v1, v1, v31
smin.8h	v2, v2, v31
smin.8h	v3, v3, v31
smin.8h	v4, v4, v31
smin.8h	v5, v5, v31
st1.8h	{ v0, v1, v2, v3 }, [x0], #64
smin.8h	v6, v6, v31
smin.8h	v7, v7, v31
st1.8h	{ v4, v5, v6, v7 }, [x0], x1
b.gt	idct_dc_w64_neon
ret
_inv_dct_4s_x4_neon:
adrp	x16, inv_dct_4s_x4_neon
add	x16, x16, #0
ld1.4s	{ v0 }, [x16]
mul.4s	v6, v17, v0[3]
mla.4s	v6, v19, v0[2]
mul.4s	v2, v16, v0[0]
mla.4s	v2, v18, v0[0]
mul.4s	v4, v17, v0[2]
mls.4s	v4, v19, v0[3]
mul.4s	v3, v16, v0[0]
mls.4s	v3, v18, v0[0]
srshr.4s	v6, v6, #12
srshr.4s	v2, v2, #12
srshr.4s	v7, v4, #12
srshr.4s	v3, v3, #12
sqadd.4s	v16, v2, v6
sqsub.4s	v19, v2, v6
sqadd.4s	v17, v3, v7
sqsub.4s	v18, v3, v7
ret
_inv_adst_4s_x4_neon:
adrp	x16, inv_adst_4s_x4_neon
add	x16, x16, #0
ld1.4s	{ v0 }, [x16]
sub.4s	v3, v16, v18
mul.4s	v4, v16, v0[0]
mla.4s	v4, v18, v0[1]
mla.4s	v4, v19, v0[2]
mul.4s	v7, v17, v0[3]
add.4s	v3, v3, v19
mul.4s	v5, v16, v0[2]
mls.4s	v5, v18, v0[0]
mls.4s	v5, v19, v0[1]
add.4s	v19, v4, v5
mul.4s	v18, v3, v0[3]
add.4s	v16, v4, v7
add.4s	v17, v5, v7
sub.4s	v19, v19, v7
srshr.4s	v16, v16, #12
srshr.4s	v18, v18, #12
srshr.4s	v17, v17, #12
srshr.4s	v19, v19, #12
ret
_inv_flipadst_4s_x4_neon:
adrp	x16, inv_flipadst_4s_x4_neon
add	x16, x16, #0
ld1.4s	{ v0 }, [x16]
sub.4s	v3, v16, v18
mul.4s	v4, v16, v0[0]
mla.4s	v4, v18, v0[1]
mla.4s	v4, v19, v0[2]
mul.4s	v7, v17, v0[3]
add.4s	v3, v3, v19
mul.4s	v5, v16, v0[2]
mls.4s	v5, v18, v0[0]
mls.4s	v5, v19, v0[1]
add.4s	v16, v4, v5
mul.4s	v17, v3, v0[3]
add.4s	v19, v4, v7
add.4s	v18, v5, v7
sub.4s	v16, v16, v7
srshr.4s	v19, v19, #12
srshr.4s	v17, v17, #12
srshr.4s	v18, v18, #12
srshr.4s	v16, v16, #12
ret
_inv_identity_4s_x4_neon:
mov	w16, #889716736
dup.2s	v0, w16
sqrdmulh.4s	v4, v16, v0[0]
sqrdmulh.4s	v5, v17, v0[0]
sqrdmulh.4s	v6, v18, v0[0]
sqrdmulh.4s	v7, v19, v0[0]
sqadd.4s	v16, v16, v4
sqadd.4s	v17, v17, v5
sqadd.4s	v18, v18, v6
sqadd.4s	v19, v19, v7
ret
_inv_txfm_add_wht_wht_4x4_16bpc_neon:
mov	x15, x30
movi.4s	v30, #0
movi.4s	v31, #0
ld1.4s	{ v16, v17, v18, v19 }, [x2]
st1.4s	{ v30, v31 }, [x2], #32
sshr.4s	v16, v16, #2
sshr.4s	v17, v17, #2
sshr.4s	v18, v18, #2
sshr.4s	v19, v19, #2
add.4s	v16, v16, v17
sub.4s	v21, v18, v19
sub.4s	v20, v16, v21
sshr.4s	v20, v20, #1
sub.4s	v18, v20, v17
sub.4s	v17, v20, v19
add.4s	v19, v21, v18
sub.4s	v16, v16, v17
st1.4s	{ v30, v31 }, [x2], #32
trn1.4s	v20, v16, v17
trn2.4s	v21, v16, v17
trn1.4s	v22, v18, v19
trn2.4s	v23, v18, v19
trn1.2d	v16, v20, v22
trn2.2d	v18, v20, v22
trn1.2d	v17, v21, v23
trn2.2d	v19, v21, v23
add.4s	v16, v16, v17
sub.4s	v21, v18, v19
sub.4s	v20, v16, v21
sshr.4s	v20, v20, #1
sub.4s	v18, v20, v17
sub.4s	v17, v20, v19
add.4s	v19, v21, v18
sub.4s	v16, v16, v17
ld1.d	{ v0 }[0], [x0], x1
sqxtn.4h	v16, v16
ld1.d	{ v0 }[1], [x0], x1
sqxtn2.8h	v16, v17
ld1.d	{ v1 }[0], [x0], x1
sqxtn.4h	v18, v18
ld1.d	{ v1 }[1], [x0], x1
sqxtn2.8h	v18, v19
b	inv_txfm_add_4x4_neon
_inv_txfm_add_4x4_neon:
movi.4s	v30, #0
movi.4s	v31, #0
ld1.4s	{ v16, v17, v18, v19 }, [x2]
st1.4s	{ v30, v31 }, [x2], #32
blr	x5
st1.4s	{ v30, v31 }, [x2], #32
sqxtn.4h	v16, v16
sqxtn.4h	v17, v17
sqxtn.4h	v18, v18
sqxtn.4h	v19, v19
trn1.4h	v20, v16, v17
trn2.4h	v21, v16, v17
trn1.4h	v22, v18, v19
trn2.4h	v23, v18, v19
trn1.2s	v16, v20, v22
trn2.2s	v18, v20, v22
trn1.2s	v17, v21, v23
trn2.2s	v19, v21, v23
blr	x6
ld1.d	{ v0 }[0], [x0], x1
ld1.d	{ v0 }[1], [x0], x1
mov.d	v16[1], v17[0]
mov.d	v18[1], v19[0]
ld1.d	{ v1 }[0], [x0], x1
ld1.d	{ v1 }[1], [x0], x1
srshr.8h	v16, v16, #4
srshr.8h	v18, v18, #4
dup.8h	v31, w4
sub	x0, x0, x1, lsl #2
usqadd.8h	v0, v16
usqadd.8h	v1, v18
smin.8h	v0, v0, v31
st1.d	{ v0 }[0], [x0], x1
smin.8h	v1, v1, v31
st1.d	{ v0 }[1], [x0], x1
st1.d	{ v1 }[0], [x0], x1
st1.d	{ v1 }[1], [x0], x1
ret	x15
_inv_txfm_add_dct_dct_4x4_16bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_4x4_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v4, w16
str	wzr, [x2]
sqrdmulh.4s	v16, v16, v4[0]
ld1.d	{ v0 }[0], [x0], x1
sqxtn.4h	v20, v16
sqxtn2.8h	v20, v16
ld1.d	{ v0 }[1], [x0], x1
sqrdmulh.8h	v20, v20, v4[1]
ld1.d	{ v1 }[0], [x0], x1
srshr.8h	v16, v20, #4
ld1.d	{ v1 }[1], [x0], x1
srshr.8h	v18, v20, #4
movi.8h	v30, #0
b	inv_txfm_add_4x4_neon
adr	x5, #-696
adrp	x6, inv_txfm_add_dct_dct_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_identity_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-460
adrp	x6, inv_txfm_add_identity_identity_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_dct_adst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-736
adrp	x6, inv_txfm_add_dct_adst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_dct_flipadst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-756
adrp	x6, inv_txfm_add_dct_flipadst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_dct_identity_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-776
adrp	x6, inv_txfm_add_dct_identity_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_dct_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-716
adrp	x6, inv_txfm_add_adst_dct_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_adst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-736
adrp	x6, inv_txfm_add_adst_adst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_flipadst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-756
adrp	x6, inv_txfm_add_adst_flipadst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_dct_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-688
adrp	x6, inv_txfm_add_flipadst_dct_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_adst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-708
adrp	x6, inv_txfm_add_flipadst_adst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_flipadst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-728
adrp	x6, inv_txfm_add_flipadst_flipadst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_dct_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-660
adrp	x6, inv_txfm_add_identity_dct_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_identity_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-856
adrp	x6, inv_txfm_add_adst_identity_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_identity_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-788
adrp	x6, inv_txfm_add_flipadst_identity_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_adst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-720
adrp	x6, inv_txfm_add_identity_adst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_flipadst_4x4_16bpc_neon:
mov	x15, x30
adr	x5, #-740
adrp	x6, inv_txfm_add_identity_flipadst_4x4_16bpc_neon
add	x6, x6, #0
b	inv_txfm_add_4x4_neon
_inv_dct_4s_x8_neon:
adrp	x16, inv_dct_4s_x8_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16]
mul.4s	v6, v18, v0[3]
mla.4s	v6, v22, v0[2]
mul.4s	v2, v16, v0[0]
mla.4s	v2, v20, v0[0]
mul.4s	v4, v18, v0[2]
mls.4s	v4, v22, v0[3]
mul.4s	v3, v16, v0[0]
mls.4s	v3, v20, v0[0]
srshr.4s	v6, v6, #12
srshr.4s	v2, v2, #12
srshr.4s	v7, v4, #12
srshr.4s	v3, v3, #12
sqadd.4s	v16, v2, v6
sqsub.4s	v22, v2, v6
sqadd.4s	v18, v3, v7
sqsub.4s	v20, v3, v7
movi.4s	v5, #1, msl #16
mvni.4s	v4, #1, msl #16
smin.4s	v16, v16, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v22, v22, v5
smax.4s	v16, v16, v4
smax.4s	v18, v18, v4
smax.4s	v20, v20, v4
smax.4s	v22, v22, v4
mul.4s	v2, v17, v1[0]
mls.4s	v2, v23, v1[1]
mul.4s	v3, v17, v1[1]
mla.4s	v3, v23, v1[0]
mul.4s	v6, v21, v1[2]
mls.4s	v6, v19, v1[3]
mul.4s	v7, v21, v1[3]
mla.4s	v7, v19, v1[2]
srshr.4s	v17, v2, #12
srshr.4s	v23, v3, #12
srshr.4s	v19, v6, #12
srshr.4s	v21, v7, #12
sqadd.4s	v2, v17, v19
sqsub.4s	v17, v17, v19
sqadd.4s	v3, v23, v21
sqsub.4s	v19, v23, v21
smin.4s	v2, v2, v5
smin.4s	v17, v17, v5
smin.4s	v3, v3, v5
smin.4s	v19, v19, v5
smax.4s	v2, v2, v4
smax.4s	v17, v17, v4
smax.4s	v3, v3, v4
smax.4s	v19, v19, v4
mul.4s	v7, v19, v0[0]
mls.4s	v7, v17, v0[0]
mul.4s	v6, v19, v0[0]
mla.4s	v6, v17, v0[0]
srshr.4s	v7, v7, #12
srshr.4s	v6, v6, #12
sqsub.4s	v23, v16, v3
sqadd.4s	v16, v16, v3
sqadd.4s	v17, v18, v6
sqsub.4s	v6, v18, v6
sqadd.4s	v18, v20, v7
sqsub.4s	v21, v20, v7
sqadd.4s	v19, v22, v2
sqsub.4s	v20, v22, v2
mov.16b	v22, v6
ret
_inv_adst_4s_x8_neon:
adrp	x16, inv_adst_4s_x8_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16], #32
mul.4s	v2, v23, v0[0]
mla.4s	v2, v16, v0[1]
mul.4s	v4, v23, v0[1]
mls.4s	v4, v16, v0[0]
mul.4s	v6, v21, v0[2]
mla.4s	v6, v18, v0[3]
srshr.4s	v16, v2, #12
srshr.4s	v23, v4, #12
mul.4s	v2, v21, v0[3]
mls.4s	v2, v18, v0[2]
mul.4s	v4, v19, v1[0]
mla.4s	v4, v20, v1[1]
srshr.4s	v18, v6, #12
srshr.4s	v21, v2, #12
mul.4s	v6, v19, v1[1]
mls.4s	v6, v20, v1[0]
mul.4s	v2, v17, v1[2]
mla.4s	v2, v22, v1[3]
srshr.4s	v20, v4, #12
srshr.4s	v19, v6, #12
mul.4s	v4, v17, v1[3]
mls.4s	v4, v22, v1[2]
srshr.4s	v22, v2, #12
srshr.4s	v17, v4, #12
ld1.4s	{ v0 }, [x16]
movi.4s	v1, #1, msl #16
sqadd.4s	v2, v16, v20
sqsub.4s	v3, v16, v20
mvni.4s	v20, #1, msl #16
sqadd.4s	v4, v23, v19
sqsub.4s	v5, v23, v19
sqadd.4s	v6, v18, v22
sqsub.4s	v7, v18, v22
sqadd.4s	v18, v21, v17
sqsub.4s	v19, v21, v17
smin.4s	v2, v2, v1
smin.4s	v3, v3, v1
smin.4s	v4, v4, v1
smin.4s	v5, v5, v1
smin.4s	v6, v6, v1
smin.4s	v7, v7, v1
smin.4s	v18, v18, v1
smin.4s	v19, v19, v1
smax.4s	v2, v2, v20
smax.4s	v3, v3, v20
smax.4s	v4, v4, v20
smax.4s	v5, v5, v20
smax.4s	v6, v6, v20
smax.4s	v7, v7, v20
smax.4s	v18, v18, v20
smax.4s	v19, v19, v20
mul.4s	v16, v3, v0[3]
mla.4s	v16, v5, v0[2]
mul.4s	v20, v3, v0[2]
mls.4s	v20, v5, v0[3]
mul.4s	v22, v19, v0[3]
mls.4s	v22, v7, v0[2]
srshr.4s	v3, v16, #12
srshr.4s	v5, v20, #12
mul.4s	v16, v19, v0[2]
mla.4s	v16, v7, v0[3]
srshr.4s	v7, v22, #12
srshr.4s	v19, v16, #12
sqadd.4s	v16, v2, v6
sqsub.4s	v2, v2, v6
sqadd.4s	v23, v4, v18
sqsub.4s	v4, v4, v18
mvni.4s	v18, #1, msl #16
sqadd.4s	v17, v3, v7
sqsub.4s	v3, v3, v7
sqadd.4s	v22, v5, v19
sqsub.4s	v5, v5, v19
smin.4s	v2, v2, v1
smin.4s	v4, v4, v1
smin.4s	v3, v3, v1
smin.4s	v5, v5, v1
smax.4s	v2, v2, v18
smax.4s	v4, v4, v18
smax.4s	v3, v3, v18
smax.4s	v5, v5, v18
sqneg.4s	v23, v23
sqneg.4s	v17, v17
mul.4s	v18, v2, v0[0]
mla.4s	v18, v4, v0[0]
mul.4s	v6, v2, v0[0]
mls.4s	v6, v4, v0[0]
mul.4s	v20, v3, v0[0]
mls.4s	v20, v5, v0[0]
srshr.4s	v2, v18, #12
mul.4s	v18, v3, v0[0]
mla.4s	v18, v5, v0[0]
srshr.4s	v3, v20, #12
srshr.4s	v18, v18, #12
srshr.4s	v20, v6, #12
sqneg.4s	v19, v2
sqneg.4s	v21, v3
ret
_inv_flipadst_4s_x8_neon:
adrp	x16, inv_flipadst_4s_x8_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16], #32
mul.4s	v2, v23, v0[0]
mla.4s	v2, v16, v0[1]
mul.4s	v4, v23, v0[1]
mls.4s	v4, v16, v0[0]
mul.4s	v6, v21, v0[2]
mla.4s	v6, v18, v0[3]
srshr.4s	v16, v2, #12
srshr.4s	v23, v4, #12
mul.4s	v2, v21, v0[3]
mls.4s	v2, v18, v0[2]
mul.4s	v4, v19, v1[0]
mla.4s	v4, v20, v1[1]
srshr.4s	v18, v6, #12
srshr.4s	v21, v2, #12
mul.4s	v6, v19, v1[1]
mls.4s	v6, v20, v1[0]
mul.4s	v2, v17, v1[2]
mla.4s	v2, v22, v1[3]
srshr.4s	v20, v4, #12
srshr.4s	v19, v6, #12
mul.4s	v4, v17, v1[3]
mls.4s	v4, v22, v1[2]
srshr.4s	v22, v2, #12
srshr.4s	v17, v4, #12
ld1.4s	{ v0 }, [x16]
movi.4s	v1, #1, msl #16
sqadd.4s	v2, v16, v20
sqsub.4s	v3, v16, v20
mvni.4s	v20, #1, msl #16
sqadd.4s	v4, v23, v19
sqsub.4s	v5, v23, v19
sqadd.4s	v6, v18, v22
sqsub.4s	v7, v18, v22
sqadd.4s	v18, v21, v17
sqsub.4s	v19, v21, v17
smin.4s	v2, v2, v1
smin.4s	v3, v3, v1
smin.4s	v4, v4, v1
smin.4s	v5, v5, v1
smin.4s	v6, v6, v1
smin.4s	v7, v7, v1
smin.4s	v18, v18, v1
smin.4s	v19, v19, v1
smax.4s	v2, v2, v20
smax.4s	v3, v3, v20
smax.4s	v4, v4, v20
smax.4s	v5, v5, v20
smax.4s	v6, v6, v20
smax.4s	v7, v7, v20
smax.4s	v18, v18, v20
smax.4s	v19, v19, v20
mul.4s	v16, v3, v0[3]
mla.4s	v16, v5, v0[2]
mul.4s	v20, v3, v0[2]
mls.4s	v20, v5, v0[3]
mul.4s	v22, v19, v0[3]
mls.4s	v22, v7, v0[2]
srshr.4s	v3, v16, #12
srshr.4s	v5, v20, #12
mul.4s	v16, v19, v0[2]
mla.4s	v16, v7, v0[3]
srshr.4s	v7, v22, #12
srshr.4s	v19, v16, #12
sqadd.4s	v23, v2, v6
sqsub.4s	v2, v2, v6
sqadd.4s	v16, v4, v18
sqsub.4s	v4, v4, v18
mvni.4s	v18, #1, msl #16
sqadd.4s	v22, v3, v7
sqsub.4s	v3, v3, v7
sqadd.4s	v17, v5, v19
sqsub.4s	v5, v5, v19
smin.4s	v2, v2, v1
smin.4s	v4, v4, v1
smin.4s	v3, v3, v1
smin.4s	v5, v5, v1
smax.4s	v2, v2, v18
smax.4s	v4, v4, v18
smax.4s	v3, v3, v18
smax.4s	v5, v5, v18
sqneg.4s	v16, v16
sqneg.4s	v22, v22
mul.4s	v18, v2, v0[0]
mla.4s	v18, v4, v0[0]
mul.4s	v6, v2, v0[0]
mls.4s	v6, v4, v0[0]
mul.4s	v20, v3, v0[0]
mls.4s	v20, v5, v0[0]
srshr.4s	v2, v18, #12
mul.4s	v18, v3, v0[0]
mla.4s	v18, v5, v0[0]
srshr.4s	v3, v20, #12
srshr.4s	v21, v18, #12
srshr.4s	v19, v6, #12
sqneg.4s	v20, v2
sqneg.4s	v18, v3
ret
_inv_identity_4s_x8_neon:
sqshl.4s	v16, v16, #1
sqshl.4s	v17, v17, #1
sqshl.4s	v18, v18, #1
sqshl.4s	v19, v19, #1
sqshl.4s	v20, v20, #1
sqshl.4s	v21, v21, #1
sqshl.4s	v22, v22, #1
sqshl.4s	v23, v23, #1
ret
_inv_txfm_add_8x8_neon:
movi.4s	v31, #0
cmp	w3, w13
mov	x11, #32
b.lt	inv_txfm_add_8x8_neon
add	x6, x2, #16
ld1.4s	{ v16 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v20 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v21 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v22 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v23 }, [x6]
st1.4s	{ v31 }, [x6], x11
blr	x4
sqrshrn.4h	v24, v16, #1
sqrshrn.4h	v25, v17, #1
sqrshrn.4h	v26, v18, #1
sqrshrn.4h	v27, v19, #1
sqrshrn2.8h	v24, v20, #1
sqrshrn2.8h	v25, v21, #1
sqrshrn2.8h	v26, v22, #1
sqrshrn2.8h	v27, v23, #1
trn1.8h	v2, v24, v25
trn2.8h	v3, v24, v25
trn1.8h	v4, v26, v27
trn2.8h	v5, v26, v27
trn1.4s	v24, v2, v4
trn2.4s	v26, v2, v4
trn1.4s	v25, v3, v5
trn2.4s	v27, v3, v5
b	inv_txfm_add_8x8_neon
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
ld1.4s	{ v16 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v17 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v18 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v19 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v20 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v21 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v22 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v23 }, [x2]
st1.4s	{ v31 }, [x2], x11
blr	x4
sqrshrn.4h	v16, v16, #1
sqrshrn.4h	v17, v17, #1
sqrshrn.4h	v18, v18, #1
sqrshrn.4h	v19, v19, #1
sqrshrn2.8h	v16, v20, #1
sqrshrn2.8h	v17, v21, #1
sqrshrn2.8h	v18, v22, #1
sqrshrn2.8h	v19, v23, #1
trn1.8h	v20, v16, v17
trn2.8h	v21, v16, v17
trn1.8h	v22, v18, v19
trn2.8h	v23, v18, v19
trn1.4s	v16, v20, v22
trn2.4s	v18, v20, v22
trn1.4s	v17, v21, v23
trn2.4s	v19, v21, v23
mov.16b	v20, v24
mov.16b	v21, v25
mov.16b	v22, v26
mov.16b	v23, v27
blr	x5
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
ret	x15
_inv_txfm_add_dct_dct_8x8_16bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_8x8_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #8
b	idct_dc_w8_neon
adrp	x5, inv_txfm_add_dct_dct_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1672
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_identity_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_identity_identity_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-620
b	inv_txfm_add_8x8_neon
_inv_txfm_add_dct_adst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_dct_adst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1720
b	inv_txfm_add_8x8_neon
_inv_txfm_add_dct_flipadst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_dct_flipadst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1744
b	inv_txfm_add_8x8_neon
_inv_txfm_add_dct_identity_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_dct_identity_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #4
adr	x4, #-1768
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_dct_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_adst_dct_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1516
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_adst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_adst_adst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1540
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_flipadst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_adst_flipadst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1564
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_dct_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_flipadst_dct_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1188
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_adst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_flipadst_adst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1212
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_flipadst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_flipadst_flipadst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #10
adr	x4, #-1236
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_dct_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_identity_dct_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #4
adr	x4, #-860
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_identity_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_adst_identity_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #4
adr	x4, #-1684
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_identity_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_flipadst_identity_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #4
adr	x4, #-1308
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_adst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_identity_adst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #4
adr	x4, #-932
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_flipadst_8x8_16bpc_neon:
mov	x15, x30
adrp	x5, inv_txfm_add_identity_flipadst_8x8_16bpc_neon
add	x5, x5, #0
mov	w13, #4
adr	x4, #-956
b	inv_txfm_add_8x8_neon
_inv_txfm_add_8x4_neon:
movi.4s	v28, #0
movi.4s	v29, #0
movi.4s	v30, #0
movi.4s	v31, #0
ld1.4s	{ v16, v17, v18, v19 }, [x2]
st1.4s	{ v28, v29, v30, v31 }, [x2], #64
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v20, v21, v22, v23 }, [x2]
st1.4s	{ v28, v29, v30, v31 }, [x2]
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
blr	x4
sqxtn.4h	v16, v16
sqxtn.4h	v17, v17
sqxtn.4h	v18, v18
sqxtn.4h	v19, v19
sqxtn.4h	v20, v20
sqxtn.4h	v21, v21
sqxtn.4h	v22, v22
sqxtn.4h	v23, v23
trn1.4h	v4, v16, v17
trn2.4h	v5, v16, v17
trn1.4h	v6, v18, v19
trn2.4h	v7, v18, v19
trn1.2s	v16, v4, v6
trn2.2s	v18, v4, v6
trn1.2s	v17, v5, v7
trn2.2s	v19, v5, v7
trn1.4h	v4, v20, v21
trn2.4h	v5, v20, v21
trn1.4h	v6, v22, v23
trn2.4h	v7, v22, v23
trn1.2s	v20, v4, v6
trn2.2s	v22, v4, v6
trn1.2s	v21, v5, v7
trn2.2s	v23, v5, v7
mov.d	v16[1], v20[0]
mov.d	v17[1], v21[0]
mov.d	v18[1], v22[0]
mov.d	v19[1], v23[0]
blr	x5
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
st1.8h	{ v5 }, [x0], x1
ret	x15
_inv_txfm_add_4x8_neon:
mov	w16, #1518338048
movi.4s	v31, #0
dup.2s	v30, w16
cmp	w3, w13
mov	x11, #32
b.lt	inv_txfm_add_4x8_neon
add	x6, x2, #16
ld1.4s	{ v16 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v31 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v31 }, [x6], x11
sqrdmulh.4s	v16, v16, v30[0]
sqrdmulh.4s	v17, v17, v30[0]
sqrdmulh.4s	v18, v18, v30[0]
sqrdmulh.4s	v19, v19, v30[0]
blr	x4
sqxtn.4h	v20, v16
sqxtn.4h	v21, v17
sqxtn.4h	v22, v18
sqxtn.4h	v23, v19
trn1.4h	v4, v20, v21
trn2.4h	v5, v20, v21
trn1.4h	v6, v22, v23
trn2.4h	v7, v22, v23
trn1.2s	v20, v4, v6
trn2.2s	v22, v4, v6
trn1.2s	v21, v5, v7
trn2.2s	v23, v5, v7
b	inv_txfm_add_4x8_neon
movi.4h	v20, #0
movi.4h	v21, #0
movi.4h	v22, #0
movi.4h	v23, #0
ld1.4s	{ v16 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v17 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v18 }, [x2]
st1.4s	{ v31 }, [x2], x11
ld1.4s	{ v19 }, [x2]
st1.4s	{ v31 }, [x2], x11
sqrdmulh.4s	v16, v16, v30[0]
sqrdmulh.4s	v17, v17, v30[0]
sqrdmulh.4s	v18, v18, v30[0]
sqrdmulh.4s	v19, v19, v30[0]
blr	x4
sqxtn.4h	v16, v16
sqxtn.4h	v17, v17
sqxtn.4h	v18, v18
sqxtn.4h	v19, v19
trn1.4h	v4, v16, v17
trn2.4h	v5, v16, v17
trn1.4h	v6, v18, v19
trn2.4h	v7, v18, v19
trn1.2s	v16, v4, v6
trn2.2s	v18, v4, v6
trn1.2s	v17, v5, v7
trn2.2s	v19, v5, v7
blr	x5
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.d	{ v0 }[0], [x7], x1
mov.d	v16[1], v17[0]
ld1.d	{ v0 }[1], [x7], x1
ld1.d	{ v1 }[0], [x7], x1
mov.d	v18[1], v19[0]
ld1.d	{ v1 }[1], [x7], x1
ld1.d	{ v2 }[0], [x7], x1
mov.d	v20[1], v21[0]
srshr.8h	v16, v16, #4
ld1.d	{ v2 }[1], [x7], x1
ld1.d	{ v3 }[0], [x7], x1
mov.d	v22[1], v23[0]
srshr.8h	v18, v18, #4
ld1.d	{ v3 }[1], [x7], x1
usqadd.8h	v0, v16
srshr.8h	v20, v20, #4
usqadd.8h	v1, v18
smin.8h	v0, v0, v7
srshr.8h	v22, v22, #4
usqadd.8h	v2, v20
st1.d	{ v0 }[0], [x0], x1
smin.8h	v1, v1, v7
st1.d	{ v0 }[1], [x0], x1
usqadd.8h	v3, v22
st1.d	{ v1 }[0], [x0], x1
smin.8h	v2, v2, v7
st1.d	{ v1 }[1], [x0], x1
st1.d	{ v2 }[0], [x0], x1
smin.8h	v3, v3, v7
st1.d	{ v2 }[1], [x0], x1
st1.d	{ v3 }[0], [x0], x1
st1.d	{ v3 }[1], [x0], x1
ret	x15
_inv_txfm_add_dct_dct_4x8_16bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_4x8_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqxtn.4h	v16, v20
sqxtn2.8h	v16, v20
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #8
b	ltmp0
adr	x4, #-3784
mov	w13, #13
adrp	x5, inv_txfm_add_dct_dct_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_identity_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3552
mov	w13, #13
adrp	x5, inv_txfm_add_identity_identity_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_adst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3832
mov	w13, #13
adrp	x5, inv_txfm_add_dct_adst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_flipadst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3856
mov	w13, #13
adrp	x5, inv_txfm_add_dct_flipadst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_identity_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3880
mov	w13, #4
adrp	x5, inv_txfm_add_dct_identity_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_dct_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3824
mov	w13, #13
adrp	x5, inv_txfm_add_adst_dct_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_adst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3848
mov	w13, #13
adrp	x5, inv_txfm_add_adst_adst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_flipadst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3872
mov	w13, #13
adrp	x5, inv_txfm_add_adst_flipadst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_dct_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3808
mov	w13, #13
adrp	x5, inv_txfm_add_flipadst_dct_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_adst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3832
mov	w13, #13
adrp	x5, inv_txfm_add_flipadst_adst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_flipadst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3856
mov	w13, #13
adrp	x5, inv_txfm_add_flipadst_flipadst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_dct_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3792
mov	w13, #16
adrp	x5, inv_txfm_add_identity_dct_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_identity_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3992
mov	w13, #4
adrp	x5, inv_txfm_add_adst_identity_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_identity_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3928
mov	w13, #4
adrp	x5, inv_txfm_add_flipadst_identity_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_adst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3864
mov	w13, #16
adrp	x5, inv_txfm_add_identity_adst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_flipadst_4x8_16bpc_neon:
mov	x15, x30
adr	x4, #-3888
mov	w13, #16
adrp	x5, inv_txfm_add_identity_flipadst_4x8_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_dct_8x4_16bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_8x4_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqxtn.4h	v16, v20
sqxtn2.8h	v16, v20
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #4
b	idct_dc_w8_neon
adr	x4, #-3208
adrp	x5, inv_txfm_add_dct_dct_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_identity_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2152
adrp	x5, inv_txfm_add_identity_identity_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_dct_adst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3248
adrp	x5, inv_txfm_add_dct_adst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_dct_flipadst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3268
adrp	x5, inv_txfm_add_dct_flipadst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_dct_identity_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3288
adrp	x5, inv_txfm_add_dct_identity_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_dct_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3032
adrp	x5, inv_txfm_add_adst_dct_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_adst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3052
adrp	x5, inv_txfm_add_adst_adst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_flipadst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3072
adrp	x5, inv_txfm_add_adst_flipadst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_dct_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2692
adrp	x5, inv_txfm_add_flipadst_dct_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_adst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2712
adrp	x5, inv_txfm_add_flipadst_adst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_flipadst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2732
adrp	x5, inv_txfm_add_flipadst_flipadst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_dct_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2352
adrp	x5, inv_txfm_add_identity_dct_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_identity_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-3172
adrp	x5, inv_txfm_add_adst_identity_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_identity_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2792
adrp	x5, inv_txfm_add_flipadst_identity_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_adst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2412
adrp	x5, inv_txfm_add_identity_adst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_flipadst_8x4_16bpc_neon:
mov	x15, x30
adr	x4, #-2432
adrp	x5, inv_txfm_add_identity_flipadst_8x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_8x4_neon
_inv_dct_4s_x16_neon:
adrp	x16, inv_dct_4s_x16_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16], #32
mul.4s	v6, v20, v0[3]
mla.4s	v6, v28, v0[2]
mul.4s	v2, v16, v0[0]
mla.4s	v2, v24, v0[0]
mul.4s	v4, v20, v0[2]
mls.4s	v4, v28, v0[3]
mul.4s	v3, v16, v0[0]
mls.4s	v3, v24, v0[0]
srshr.4s	v6, v6, #12
srshr.4s	v2, v2, #12
srshr.4s	v7, v4, #12
srshr.4s	v3, v3, #12
sqadd.4s	v16, v2, v6
sqsub.4s	v28, v2, v6
sqadd.4s	v20, v3, v7
sqsub.4s	v24, v3, v7
movi.4s	v5, #1, msl #16
mvni.4s	v4, #1, msl #16
smin.4s	v16, v16, v5
smin.4s	v20, v20, v5
smin.4s	v24, v24, v5
smin.4s	v28, v28, v5
smax.4s	v16, v16, v4
smax.4s	v20, v20, v4
smax.4s	v24, v24, v4
smax.4s	v28, v28, v4
mul.4s	v2, v18, v1[0]
mls.4s	v2, v30, v1[1]
mul.4s	v3, v18, v1[1]
mla.4s	v3, v30, v1[0]
mul.4s	v6, v26, v1[2]
mls.4s	v6, v22, v1[3]
mul.4s	v7, v26, v1[3]
mla.4s	v7, v22, v1[2]
srshr.4s	v18, v2, #12
srshr.4s	v30, v3, #12
srshr.4s	v22, v6, #12
srshr.4s	v26, v7, #12
sqadd.4s	v2, v18, v22
sqsub.4s	v18, v18, v22
sqadd.4s	v3, v30, v26
sqsub.4s	v22, v30, v26
smin.4s	v2, v2, v5
smin.4s	v18, v18, v5
smin.4s	v3, v3, v5
smin.4s	v22, v22, v5
smax.4s	v2, v2, v4
smax.4s	v18, v18, v4
smax.4s	v3, v3, v4
smax.4s	v22, v22, v4
mul.4s	v7, v22, v0[0]
mls.4s	v7, v18, v0[0]
mul.4s	v6, v22, v0[0]
mla.4s	v6, v18, v0[0]
srshr.4s	v7, v7, #12
srshr.4s	v6, v6, #12
sqsub.4s	v30, v16, v3
sqadd.4s	v16, v16, v3
sqadd.4s	v18, v20, v6
sqsub.4s	v6, v20, v6
sqadd.4s	v20, v24, v7
sqsub.4s	v26, v24, v7
sqadd.4s	v22, v28, v2
sqsub.4s	v24, v28, v2
mov.16b	v28, v6
smin.4s	v16, v16, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v22, v22, v5
smin.4s	v24, v24, v5
smin.4s	v26, v26, v5
smin.4s	v28, v28, v5
smin.4s	v30, v30, v5
smax.4s	v16, v16, v4
smax.4s	v18, v18, v4
smax.4s	v20, v20, v4
smax.4s	v22, v22, v4
smax.4s	v24, v24, v4
smax.4s	v26, v26, v4
smax.4s	v28, v28, v4
smax.4s	v30, v30, v4
ld1.4s	{ v0, v1 }, [x16]
sub	x16, x16, #32
mul.4s	v2, v17, v0[0]
mls.4s	v2, v31, v0[1]
mul.4s	v3, v17, v0[1]
mla.4s	v3, v31, v0[0]
mul.4s	v6, v25, v0[2]
mls.4s	v6, v23, v0[3]
srshr.4s	v17, v2, #12
srshr.4s	v31, v3, #12
mul.4s	v2, v25, v0[3]
mla.4s	v2, v23, v0[2]
mul.4s	v3, v21, v1[0]
mls.4s	v3, v27, v1[1]
srshr.4s	v23, v6, #12
srshr.4s	v25, v2, #12
mul.4s	v6, v21, v1[1]
mla.4s	v6, v27, v1[0]
mul.4s	v2, v29, v1[2]
mls.4s	v2, v19, v1[3]
srshr.4s	v21, v3, #12
srshr.4s	v27, v6, #12
mul.4s	v3, v29, v1[3]
mla.4s	v3, v19, v1[2]
srshr.4s	v19, v2, #12
srshr.4s	v29, v3, #12
ld1.4s	{ v0 }, [x16]
sqsub.4s	v2, v17, v23
sqadd.4s	v17, v17, v23
sqsub.4s	v3, v31, v25
sqadd.4s	v31, v31, v25
sqsub.4s	v23, v19, v21
sqadd.4s	v19, v19, v21
sqadd.4s	v25, v29, v27
sqsub.4s	v29, v29, v27
smin.4s	v2, v2, v5
smin.4s	v17, v17, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v23, v23, v5
smin.4s	v19, v19, v5
smin.4s	v25, v25, v5
smin.4s	v29, v29, v5
smax.4s	v2, v2, v4
smax.4s	v17, v17, v4
smax.4s	v3, v3, v4
smax.4s	v31, v31, v4
smax.4s	v23, v23, v4
smax.4s	v19, v19, v4
smax.4s	v25, v25, v4
smax.4s	v29, v29, v4
mul.4s	v7, v3, v0[2]
mls.4s	v7, v2, v0[3]
mul.4s	v6, v3, v0[3]
mla.4s	v6, v2, v0[2]
srshr.4s	v21, v7, #12
srshr.4s	v27, v6, #12
mul.4s	v7, v29, v0[2]
mls.4s	v7, v23, v0[3]
mul.4s	v6, v29, v0[3]
mla.4s	v6, v23, v0[2]
srshr.4s	v29, v7, #12
neg.4s	v6, v6
srshr.4s	v23, v6, #12
sqsub.4s	v2, v17, v19
sqadd.4s	v17, v17, v19
sqsub.4s	v3, v31, v25
sqadd.4s	v31, v31, v25
sqadd.4s	v19, v21, v23
sqsub.4s	v21, v21, v23
sqsub.4s	v25, v27, v29
sqadd.4s	v27, v27, v29
smin.4s	v2, v2, v5
smin.4s	v17, v17, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v19, v19, v5
smin.4s	v21, v21, v5
smin.4s	v25, v25, v5
smin.4s	v27, v27, v5
smax.4s	v2, v2, v4
smax.4s	v17, v17, v4
smax.4s	v3, v3, v4
smax.4s	v31, v31, v4
smax.4s	v19, v19, v4
smax.4s	v21, v21, v4
smax.4s	v25, v25, v4
smax.4s	v27, v27, v4
mul.4s	v7, v3, v0[0]
mls.4s	v7, v2, v0[0]
mul.4s	v6, v3, v0[0]
mla.4s	v6, v2, v0[0]
mul.4s	v2, v25, v0[0]
mls.4s	v2, v21, v0[0]
srshr.4s	v7, v7, #12
srshr.4s	v6, v6, #12
mul.4s	v3, v25, v0[0]
mla.4s	v3, v21, v0[0]
srshr.4s	v2, v2, #12
srshr.4s	v3, v3, #12
sqadd.4s	v1, v16, v31
sqsub.4s	v31, v16, v31
mov.16b	v16, v1
sqadd.4s	v23, v30, v17
sqsub.4s	v1, v30, v17
sqadd.4s	v17, v18, v27
sqsub.4s	v30, v18, v27
sqadd.4s	v18, v20, v3
sqsub.4s	v29, v20, v3
sqadd.4s	v3, v28, v19
sqsub.4s	v25, v28, v19
sqadd.4s	v19, v22, v6
sqsub.4s	v28, v22, v6
sqadd.4s	v20, v24, v7
sqsub.4s	v27, v24, v7
sqadd.4s	v21, v26, v2
sqsub.4s	v26, v26, v2
mov.16b	v24, v1
mov.16b	v22, v3
ret
_inv_adst_4s_x16_neon:
adrp	x16, inv_adst_4s_x16_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16], #32
mul.4s	v2, v31, v0[0]
mla.4s	v2, v16, v0[1]
mul.4s	v4, v31, v0[1]
mls.4s	v4, v16, v0[0]
mul.4s	v6, v29, v0[2]
mla.4s	v6, v18, v0[3]
srshr.4s	v16, v2, #12
srshr.4s	v31, v4, #12
mul.4s	v2, v29, v0[3]
mls.4s	v2, v18, v0[2]
mul.4s	v4, v27, v1[0]
mla.4s	v4, v20, v1[1]
srshr.4s	v18, v6, #12
srshr.4s	v29, v2, #12
mul.4s	v6, v27, v1[1]
mls.4s	v6, v20, v1[0]
mul.4s	v2, v25, v1[2]
mla.4s	v2, v22, v1[3]
srshr.4s	v20, v4, #12
srshr.4s	v27, v6, #12
mul.4s	v4, v25, v1[3]
mls.4s	v4, v22, v1[2]
ld1.4s	{ v0, v1 }, [x16]
adrp	x16, inv_adst_4s_x16_neon
add	x16, x16, #0
mul.4s	v6, v23, v0[0]
mla.4s	v6, v24, v0[1]
srshr.4s	v22, v2, #12
srshr.4s	v25, v4, #12
mul.4s	v2, v23, v0[1]
mls.4s	v2, v24, v0[0]
mul.4s	v4, v21, v0[2]
mla.4s	v4, v26, v0[3]
srshr.4s	v23, v6, #12
srshr.4s	v24, v2, #12
mul.4s	v6, v21, v0[3]
mls.4s	v6, v26, v0[2]
mul.4s	v2, v19, v1[0]
mla.4s	v2, v28, v1[1]
srshr.4s	v21, v4, #12
srshr.4s	v26, v6, #12
mul.4s	v4, v19, v1[1]
mls.4s	v4, v28, v1[0]
mul.4s	v6, v17, v1[2]
mla.4s	v6, v30, v1[3]
srshr.4s	v19, v2, #12
srshr.4s	v28, v4, #12
mul.4s	v2, v17, v1[3]
mls.4s	v2, v30, v1[2]
srshr.4s	v17, v6, #12
srshr.4s	v30, v2, #12
ld1.4s	{ v0, v1 }, [x16]
movi.4s	v5, #1, msl #16
mvni.4s	v7, #1, msl #16
sqsub.4s	v2, v16, v23
sqadd.4s	v16, v16, v23
sqsub.4s	v3, v31, v24
sqadd.4s	v31, v31, v24
sqadd.4s	v23, v18, v21
sqsub.4s	v18, v18, v21
sqadd.4s	v24, v29, v26
sqsub.4s	v29, v29, v26
sqadd.4s	v21, v20, v19
sqsub.4s	v20, v20, v19
sqadd.4s	v26, v27, v28
sqsub.4s	v27, v27, v28
sqadd.4s	v19, v22, v17
sqsub.4s	v22, v22, v17
sqadd.4s	v28, v25, v30
sqsub.4s	v25, v25, v30
smin.4s	v2, v2, v5
smin.4s	v16, v16, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v23, v23, v5
smin.4s	v18, v18, v5
smin.4s	v24, v24, v5
smin.4s	v29, v29, v5
smin.4s	v21, v21, v5
smin.4s	v20, v20, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v19, v19, v5
smin.4s	v22, v22, v5
smin.4s	v28, v28, v5
smin.4s	v25, v25, v5
smax.4s	v2, v2, v7
smax.4s	v16, v16, v7
smax.4s	v3, v3, v7
smax.4s	v31, v31, v7
smax.4s	v23, v23, v7
smax.4s	v18, v18, v7
smax.4s	v24, v24, v7
smax.4s	v29, v29, v7
smax.4s	v21, v21, v7
smax.4s	v20, v20, v7
smax.4s	v26, v26, v7
smax.4s	v27, v27, v7
smax.4s	v19, v19, v7
smax.4s	v22, v22, v7
smax.4s	v28, v28, v7
smax.4s	v25, v25, v7
mul.4s	v4, v2, v1[1]
mla.4s	v4, v3, v1[0]
mul.4s	v6, v2, v1[0]
mls.4s	v6, v3, v1[1]
mul.4s	v2, v18, v1[3]
mla.4s	v2, v29, v1[2]
srshr.4s	v17, v4, #12
srshr.4s	v30, v6, #12
mul.4s	v4, v18, v1[2]
mls.4s	v4, v29, v1[3]
mul.4s	v6, v27, v1[1]
mls.4s	v6, v20, v1[0]
srshr.4s	v18, v2, #12
srshr.4s	v29, v4, #12
mul.4s	v2, v27, v1[0]
mla.4s	v2, v20, v1[1]
mul.4s	v4, v25, v1[3]
mls.4s	v4, v22, v1[2]
srshr.4s	v27, v6, #12
srshr.4s	v20, v2, #12
mul.4s	v6, v25, v1[2]
mla.4s	v6, v22, v1[3]
srshr.4s	v25, v4, #12
srshr.4s	v22, v6, #12
sqsub.4s	v2, v16, v21
sqadd.4s	v16, v16, v21
sqsub.4s	v3, v31, v26
sqadd.4s	v31, v31, v26
sqadd.4s	v21, v23, v19
sqsub.4s	v23, v23, v19
sqadd.4s	v26, v24, v28
sqsub.4s	v24, v24, v28
sqadd.4s	v19, v17, v27
sqsub.4s	v17, v17, v27
sqadd.4s	v28, v30, v20
sqsub.4s	v30, v30, v20
sqadd.4s	v27, v18, v25
sqsub.4s	v18, v18, v25
sqadd.4s	v20, v29, v22
sqsub.4s	v29, v29, v22
smin.4s	v2, v2, v5
smin.4s	v16, v16, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v21, v21, v5
smin.4s	v23, v23, v5
smin.4s	v26, v26, v5
smin.4s	v24, v24, v5
smin.4s	v19, v19, v5
smin.4s	v17, v17, v5
smin.4s	v28, v28, v5
smin.4s	v30, v30, v5
smin.4s	v27, v27, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v29, v29, v5
smax.4s	v2, v2, v7
smax.4s	v16, v16, v7
smax.4s	v3, v3, v7
smax.4s	v31, v31, v7
smax.4s	v21, v21, v7
smax.4s	v23, v23, v7
smax.4s	v26, v26, v7
smax.4s	v24, v24, v7
smax.4s	v19, v19, v7
smax.4s	v17, v17, v7
smax.4s	v28, v28, v7
smax.4s	v30, v30, v7
smax.4s	v27, v27, v7
smax.4s	v18, v18, v7
smax.4s	v20, v20, v7
smax.4s	v29, v29, v7
mul.4s	v4, v2, v0[3]
mla.4s	v4, v3, v0[2]
mul.4s	v6, v2, v0[2]
mls.4s	v6, v3, v0[3]
mul.4s	v2, v24, v0[3]
mls.4s	v2, v23, v0[2]
srshr.4s	v22, v4, #12
srshr.4s	v25, v6, #12
mul.4s	v4, v24, v0[2]
mla.4s	v4, v23, v0[3]
mul.4s	v6, v17, v0[3]
mla.4s	v6, v30, v0[2]
srshr.4s	v24, v2, #12
srshr.4s	v23, v4, #12
mul.4s	v2, v17, v0[2]
mls.4s	v2, v30, v0[3]
mul.4s	v4, v29, v0[3]
mls.4s	v4, v18, v0[2]
srshr.4s	v17, v6, #12
mul.4s	v6, v29, v0[2]
mla.4s	v6, v18, v0[3]
srshr.4s	v29, v2, #12
srshr.4s	v30, v4, #12
srshr.4s	v18, v6, #12
sqsub.4s	v2, v16, v21
sqadd.4s	v16, v16, v21
sqsub.4s	v21, v31, v26
sqadd.4s	v31, v31, v26
sqsub.4s	v3, v29, v18
sqadd.4s	v29, v29, v18
sqadd.4s	v18, v17, v30
sqsub.4s	v26, v17, v30
sqadd.4s	v17, v19, v27
sqsub.4s	v27, v19, v27
sqadd.4s	v30, v28, v20
sqsub.4s	v20, v28, v20
sqadd.4s	v19, v22, v24
sqsub.4s	v22, v22, v24
sqadd.4s	v28, v25, v23
sqsub.4s	v23, v25, v23
smin.4s	v2, v2, v5
smin.4s	v21, v21, v5
smin.4s	v3, v3, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v20, v20, v5
smin.4s	v22, v22, v5
smin.4s	v23, v23, v5
smax.4s	v2, v2, v7
smax.4s	v21, v21, v7
smax.4s	v3, v3, v7
smax.4s	v26, v26, v7
smax.4s	v27, v27, v7
smax.4s	v20, v20, v7
smax.4s	v22, v22, v7
smax.4s	v23, v23, v7
sqneg.4s	v31, v31
sqneg.4s	v29, v29
sqneg.4s	v17, v17
sqneg.4s	v19, v19
mul.4s	v24, v2, v0[0]
mls.4s	v24, v21, v0[0]
mul.4s	v4, v2, v0[0]
mla.4s	v4, v21, v0[0]
mul.4s	v6, v26, v0[0]
mla.4s	v6, v3, v0[0]
srshr.4s	v24, v24, #12
srshr.4s	v4, v4, #12
srshr.4s	v5, v6, #12
mul.4s	v6, v26, v0[0]
mls.4s	v6, v3, v0[0]
mul.4s	v2, v22, v0[0]
mla.4s	v2, v23, v0[0]
srshr.4s	v26, v6, #12
mul.4s	v6, v22, v0[0]
mls.4s	v6, v23, v0[0]
mul.4s	v22, v27, v0[0]
mla.4s	v22, v20, v0[0]
mul.4s	v21, v27, v0[0]
mls.4s	v21, v20, v0[0]
srshr.4s	v20, v2, #12
srshr.4s	v6, v6, #12
srshr.4s	v7, v21, #12
srshr.4s	v22, v22, #12
sqneg.4s	v23, v4
sqneg.4s	v21, v5
sqneg.4s	v27, v6
sqneg.4s	v25, v7
ret
_inv_flipadst_4s_x16_neon:
adrp	x16, inv_flipadst_4s_x16_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16], #32
mul.4s	v2, v31, v0[0]
mla.4s	v2, v16, v0[1]
mul.4s	v4, v31, v0[1]
mls.4s	v4, v16, v0[0]
mul.4s	v6, v29, v0[2]
mla.4s	v6, v18, v0[3]
srshr.4s	v16, v2, #12
srshr.4s	v31, v4, #12
mul.4s	v2, v29, v0[3]
mls.4s	v2, v18, v0[2]
mul.4s	v4, v27, v1[0]
mla.4s	v4, v20, v1[1]
srshr.4s	v18, v6, #12
srshr.4s	v29, v2, #12
mul.4s	v6, v27, v1[1]
mls.4s	v6, v20, v1[0]
mul.4s	v2, v25, v1[2]
mla.4s	v2, v22, v1[3]
srshr.4s	v20, v4, #12
srshr.4s	v27, v6, #12
mul.4s	v4, v25, v1[3]
mls.4s	v4, v22, v1[2]
ld1.4s	{ v0, v1 }, [x16]
adrp	x16, inv_flipadst_4s_x16_neon
add	x16, x16, #0
mul.4s	v6, v23, v0[0]
mla.4s	v6, v24, v0[1]
srshr.4s	v22, v2, #12
srshr.4s	v25, v4, #12
mul.4s	v2, v23, v0[1]
mls.4s	v2, v24, v0[0]
mul.4s	v4, v21, v0[2]
mla.4s	v4, v26, v0[3]
srshr.4s	v23, v6, #12
srshr.4s	v24, v2, #12
mul.4s	v6, v21, v0[3]
mls.4s	v6, v26, v0[2]
mul.4s	v2, v19, v1[0]
mla.4s	v2, v28, v1[1]
srshr.4s	v21, v4, #12
srshr.4s	v26, v6, #12
mul.4s	v4, v19, v1[1]
mls.4s	v4, v28, v1[0]
mul.4s	v6, v17, v1[2]
mla.4s	v6, v30, v1[3]
srshr.4s	v19, v2, #12
srshr.4s	v28, v4, #12
mul.4s	v2, v17, v1[3]
mls.4s	v2, v30, v1[2]
srshr.4s	v17, v6, #12
srshr.4s	v30, v2, #12
ld1.4s	{ v0, v1 }, [x16]
movi.4s	v5, #1, msl #16
mvni.4s	v7, #1, msl #16
sqsub.4s	v2, v16, v23
sqadd.4s	v16, v16, v23
sqsub.4s	v3, v31, v24
sqadd.4s	v31, v31, v24
sqadd.4s	v23, v18, v21
sqsub.4s	v18, v18, v21
sqadd.4s	v24, v29, v26
sqsub.4s	v29, v29, v26
sqadd.4s	v21, v20, v19
sqsub.4s	v20, v20, v19
sqadd.4s	v26, v27, v28
sqsub.4s	v27, v27, v28
sqadd.4s	v19, v22, v17
sqsub.4s	v22, v22, v17
sqadd.4s	v28, v25, v30
sqsub.4s	v25, v25, v30
smin.4s	v2, v2, v5
smin.4s	v16, v16, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v23, v23, v5
smin.4s	v18, v18, v5
smin.4s	v24, v24, v5
smin.4s	v29, v29, v5
smin.4s	v21, v21, v5
smin.4s	v20, v20, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v19, v19, v5
smin.4s	v22, v22, v5
smin.4s	v28, v28, v5
smin.4s	v25, v25, v5
smax.4s	v2, v2, v7
smax.4s	v16, v16, v7
smax.4s	v3, v3, v7
smax.4s	v31, v31, v7
smax.4s	v23, v23, v7
smax.4s	v18, v18, v7
smax.4s	v24, v24, v7
smax.4s	v29, v29, v7
smax.4s	v21, v21, v7
smax.4s	v20, v20, v7
smax.4s	v26, v26, v7
smax.4s	v27, v27, v7
smax.4s	v19, v19, v7
smax.4s	v22, v22, v7
smax.4s	v28, v28, v7
smax.4s	v25, v25, v7
mul.4s	v4, v2, v1[1]
mla.4s	v4, v3, v1[0]
mul.4s	v6, v2, v1[0]
mls.4s	v6, v3, v1[1]
mul.4s	v2, v18, v1[3]
mla.4s	v2, v29, v1[2]
srshr.4s	v17, v4, #12
srshr.4s	v30, v6, #12
mul.4s	v4, v18, v1[2]
mls.4s	v4, v29, v1[3]
mul.4s	v6, v27, v1[1]
mls.4s	v6, v20, v1[0]
srshr.4s	v18, v2, #12
srshr.4s	v29, v4, #12
mul.4s	v2, v27, v1[0]
mla.4s	v2, v20, v1[1]
mul.4s	v4, v25, v1[3]
mls.4s	v4, v22, v1[2]
srshr.4s	v27, v6, #12
srshr.4s	v20, v2, #12
mul.4s	v6, v25, v1[2]
mla.4s	v6, v22, v1[3]
srshr.4s	v25, v4, #12
srshr.4s	v22, v6, #12
sqsub.4s	v2, v16, v21
sqadd.4s	v16, v16, v21
sqsub.4s	v3, v31, v26
sqadd.4s	v31, v31, v26
sqadd.4s	v21, v23, v19
sqsub.4s	v23, v23, v19
sqadd.4s	v26, v24, v28
sqsub.4s	v24, v24, v28
sqadd.4s	v19, v17, v27
sqsub.4s	v17, v17, v27
sqadd.4s	v28, v30, v20
sqsub.4s	v30, v30, v20
sqadd.4s	v27, v18, v25
sqsub.4s	v18, v18, v25
sqadd.4s	v20, v29, v22
sqsub.4s	v29, v29, v22
smin.4s	v2, v2, v5
smin.4s	v16, v16, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v21, v21, v5
smin.4s	v23, v23, v5
smin.4s	v26, v26, v5
smin.4s	v24, v24, v5
smin.4s	v19, v19, v5
smin.4s	v17, v17, v5
smin.4s	v28, v28, v5
smin.4s	v30, v30, v5
smin.4s	v27, v27, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v29, v29, v5
smax.4s	v2, v2, v7
smax.4s	v16, v16, v7
smax.4s	v3, v3, v7
smax.4s	v31, v31, v7
smax.4s	v21, v21, v7
smax.4s	v23, v23, v7
smax.4s	v26, v26, v7
smax.4s	v24, v24, v7
smax.4s	v19, v19, v7
smax.4s	v17, v17, v7
smax.4s	v28, v28, v7
smax.4s	v30, v30, v7
smax.4s	v27, v27, v7
smax.4s	v18, v18, v7
smax.4s	v20, v20, v7
smax.4s	v29, v29, v7
mul.4s	v4, v2, v0[3]
mla.4s	v4, v3, v0[2]
mul.4s	v6, v2, v0[2]
mls.4s	v6, v3, v0[3]
mul.4s	v2, v24, v0[3]
mls.4s	v2, v23, v0[2]
srshr.4s	v22, v4, #12
srshr.4s	v25, v6, #12
mul.4s	v4, v24, v0[2]
mla.4s	v4, v23, v0[3]
mul.4s	v6, v17, v0[3]
mla.4s	v6, v30, v0[2]
srshr.4s	v24, v2, #12
srshr.4s	v23, v4, #12
mul.4s	v2, v17, v0[2]
mls.4s	v2, v30, v0[3]
mul.4s	v4, v29, v0[3]
mls.4s	v4, v18, v0[2]
srshr.4s	v17, v6, #12
mul.4s	v6, v29, v0[2]
mla.4s	v6, v18, v0[3]
srshr.4s	v29, v2, #12
srshr.4s	v30, v4, #12
srshr.4s	v18, v6, #12
sqsub.4s	v2, v16, v21
sqadd.4s	v4, v16, v21
sqsub.4s	v21, v31, v26
sqadd.4s	v16, v31, v26
mov.16b	v31, v4
sqsub.4s	v3, v29, v18
sqadd.4s	v18, v29, v18
sqadd.4s	v29, v17, v30
sqsub.4s	v26, v17, v30
sqadd.4s	v30, v19, v27
sqsub.4s	v27, v19, v27
sqadd.4s	v17, v28, v20
sqsub.4s	v20, v28, v20
sqadd.4s	v28, v22, v24
sqsub.4s	v22, v22, v24
sqadd.4s	v19, v25, v23
sqsub.4s	v23, v25, v23
smin.4s	v2, v2, v5
smin.4s	v21, v21, v5
smin.4s	v3, v3, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v20, v20, v5
smin.4s	v22, v22, v5
smin.4s	v23, v23, v5
smax.4s	v2, v2, v7
smax.4s	v21, v21, v7
smax.4s	v3, v3, v7
smax.4s	v26, v26, v7
smax.4s	v27, v27, v7
smax.4s	v20, v20, v7
smax.4s	v22, v22, v7
smax.4s	v23, v23, v7
sqneg.4s	v16, v16
sqneg.4s	v18, v18
sqneg.4s	v30, v30
sqneg.4s	v28, v28
mul.4s	v24, v2, v0[0]
mls.4s	v24, v21, v0[0]
mul.4s	v4, v2, v0[0]
mla.4s	v4, v21, v0[0]
mul.4s	v6, v26, v0[0]
mla.4s	v6, v3, v0[0]
srshr.4s	v24, v24, #12
srshr.4s	v4, v4, #12
srshr.4s	v5, v6, #12
mul.4s	v6, v26, v0[0]
mls.4s	v6, v3, v0[0]
mul.4s	v2, v22, v0[0]
mla.4s	v2, v23, v0[0]
srshr.4s	v26, v6, #12
mul.4s	v6, v22, v0[0]
mls.4s	v6, v23, v0[0]
mul.4s	v22, v27, v0[0]
mla.4s	v22, v20, v0[0]
mul.4s	v21, v27, v0[0]
mls.4s	v21, v20, v0[0]
srshr.4s	v27, v2, #12
srshr.4s	v6, v6, #12
srshr.4s	v7, v21, #12
srshr.4s	v25, v22, #12
mov.16b	v23, v24
mov.16b	v21, v26
sqneg.4s	v24, v4
sqneg.4s	v26, v5
sqneg.4s	v20, v6
sqneg.4s	v22, v7
ret
_inv_identity_4s_x16_neon:
mov	w16, #1779433472
dup.2s	v0, w16
sqrdmulh.4s	v2, v16, v0[0]
sqadd.4s	v16, v16, v16
sqadd.4s	v16, v16, v2
sqrdmulh.4s	v2, v17, v0[0]
sqadd.4s	v17, v17, v17
sqadd.4s	v17, v17, v2
sqrdmulh.4s	v2, v18, v0[0]
sqadd.4s	v18, v18, v18
sqadd.4s	v18, v18, v2
sqrdmulh.4s	v2, v19, v0[0]
sqadd.4s	v19, v19, v19
sqadd.4s	v19, v19, v2
sqrdmulh.4s	v2, v20, v0[0]
sqadd.4s	v20, v20, v20
sqadd.4s	v20, v20, v2
sqrdmulh.4s	v2, v21, v0[0]
sqadd.4s	v21, v21, v21
sqadd.4s	v21, v21, v2
sqrdmulh.4s	v2, v22, v0[0]
sqadd.4s	v22, v22, v22
sqadd.4s	v22, v22, v2
sqrdmulh.4s	v2, v23, v0[0]
sqadd.4s	v23, v23, v23
sqadd.4s	v23, v23, v2
sqrdmulh.4s	v2, v24, v0[0]
sqadd.4s	v24, v24, v24
sqadd.4s	v24, v24, v2
sqrdmulh.4s	v2, v25, v0[0]
sqadd.4s	v25, v25, v25
sqadd.4s	v25, v25, v2
sqrdmulh.4s	v2, v26, v0[0]
sqadd.4s	v26, v26, v26
sqadd.4s	v26, v26, v2
sqrdmulh.4s	v2, v27, v0[0]
sqadd.4s	v27, v27, v27
sqadd.4s	v27, v27, v2
sqrdmulh.4s	v2, v28, v0[0]
sqadd.4s	v28, v28, v28
sqadd.4s	v28, v28, v2
sqrdmulh.4s	v2, v29, v0[0]
sqadd.4s	v29, v29, v29
sqadd.4s	v29, v29, v2
sqrdmulh.4s	v2, v30, v0[0]
sqadd.4s	v30, v30, v30
sqadd.4s	v30, v30, v2
sqrdmulh.4s	v2, v31, v0[0]
sqadd.4s	v31, v31, v31
sqadd.4s	v31, v31, v2
ret
_inv_txfm_horz_scale_16x4_neon:
mov	x14, x30
movi.4s	v7, #0
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v24 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v25 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v26 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v27 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v28 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v29 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v30 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v31 }, [x7]
st1.4s	{ v7 }, [x7], x8
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
sqrdmulh.4s	v24, v24, v0[0]
sqrdmulh.4s	v25, v25, v0[0]
sqrdmulh.4s	v26, v26, v0[0]
sqrdmulh.4s	v27, v27, v0[0]
sqrdmulh.4s	v28, v28, v0[0]
sqrdmulh.4s	v29, v29, v0[0]
sqrdmulh.4s	v30, v30, v0[0]
sqrdmulh.4s	v31, v31, v0[0]
blr	x4
sqrshrn.4h	v16, v16, #1
sqrshrn.4h	v17, v17, #1
sqrshrn.4h	v18, v18, #1
sqrshrn.4h	v19, v19, #1
sqrshrn2.8h	v16, v20, #1
sqrshrn2.8h	v17, v21, #1
sqrshrn2.8h	v18, v22, #1
sqrshrn2.8h	v19, v23, #1
sqrshrn.4h	v20, v24, #1
sqrshrn.4h	v21, v25, #1
sqrshrn.4h	v22, v26, #1
sqrshrn.4h	v23, v27, #1
sqrshrn2.8h	v20, v28, #1
sqrshrn2.8h	v21, v29, #1
sqrshrn2.8h	v22, v30, #1
sqrshrn2.8h	v23, v31, #1
b	inv_txfm_horz_16x4_neon
_inv_txfm_horz_16x4_neon:
mov	x14, x30
movi.4s	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v24 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v25 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v26 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v27 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v28 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v29 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v30 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v31 }, [x7]
st1.4s	{ v7 }, [x7], x8
blr	x4
sqrshrn.4h	v16, v16, #2
sqrshrn.4h	v17, v17, #2
sqrshrn.4h	v18, v18, #2
sqrshrn.4h	v19, v19, #2
sqrshrn2.8h	v16, v20, #2
sqrshrn2.8h	v17, v21, #2
sqrshrn2.8h	v18, v22, #2
sqrshrn2.8h	v19, v23, #2
sqrshrn.4h	v20, v24, #2
sqrshrn.4h	v21, v25, #2
sqrshrn.4h	v22, v26, #2
sqrshrn.4h	v23, v27, #2
sqrshrn2.8h	v20, v28, #2
sqrshrn2.8h	v21, v29, #2
sqrshrn2.8h	v22, v30, #2
sqrshrn2.8h	v23, v31, #2
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v6, v18, v19
trn2.8h	v7, v18, v19
trn1.4s	v16, v4, v6
trn2.4s	v18, v4, v6
trn1.4s	v17, v5, v7
trn2.4s	v19, v5, v7
trn1.8h	v4, v20, v21
trn2.8h	v5, v20, v21
trn1.8h	v6, v22, v23
trn2.8h	v7, v22, v23
trn1.4s	v20, v4, v6
trn2.4s	v22, v4, v6
trn1.4s	v21, v5, v7
trn2.4s	v23, v5, v7
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v23 }, [x6], #16
ret	x14
_inv_txfm_add_vert_8x16_neon:
mov	x14, x30
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
ld1.8h	{ v24 }, [x7], x8
ld1.8h	{ v25 }, [x7], x8
ld1.8h	{ v26 }, [x7], x8
ld1.8h	{ v27 }, [x7], x8
ld1.8h	{ v28 }, [x7], x8
ld1.8h	{ v29 }, [x7], x8
ld1.8h	{ v30 }, [x7], x8
ld1.8h	{ v31 }, [x7], x8
blr	x5
mov	x7, x6
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x6], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x6], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x6], x1
ld1.8h	{ v20 }, [x7], x1
srshr.8h	v24, v24, #4
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x6], x1
ld1.8h	{ v21 }, [x7], x1
srshr.8h	v25, v25, #4
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x6], x1
ld1.8h	{ v22 }, [x7], x1
srshr.8h	v26, v26, #4
usqadd.8h	v20, v24
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x6], x1
ld1.8h	{ v23 }, [x7], x1
srshr.8h	v27, v27, #4
usqadd.8h	v21, v25
smin.8h	v20, v20, v7
st1.8h	{ v19 }, [x6], x1
ld1.8h	{ v24 }, [x7], x1
srshr.8h	v28, v28, #4
usqadd.8h	v22, v26
smin.8h	v21, v21, v7
st1.8h	{ v20 }, [x6], x1
ld1.8h	{ v25 }, [x7], x1
srshr.8h	v29, v29, #4
usqadd.8h	v23, v27
smin.8h	v22, v22, v7
st1.8h	{ v21 }, [x6], x1
ld1.8h	{ v26 }, [x7], x1
srshr.8h	v30, v30, #4
usqadd.8h	v24, v28
smin.8h	v23, v23, v7
st1.8h	{ v22 }, [x6], x1
ld1.8h	{ v27 }, [x7], x1
srshr.8h	v31, v31, #4
usqadd.8h	v25, v29
smin.8h	v24, v24, v7
st1.8h	{ v23 }, [x6], x1
usqadd.8h	v26, v30
smin.8h	v25, v25, v7
st1.8h	{ v24 }, [x6], x1
usqadd.8h	v27, v31
smin.8h	v26, v26, v7
st1.8h	{ v25 }, [x6], x1
smin.8h	v27, v27, v7
st1.8h	{ v26 }, [x6], x1
st1.8h	{ v27 }, [x6], x1
ret	x14
_inv_txfm_add_16x16_neon:
mov	x15, x30
sub	sp, sp, #512
ldrh	w12, [x13], #2
mov	x6, sp
add	x7, x2, #0
mov	x8, #64
bl	inv_txfm_horz_16x4_neon
add	x6, sp, #128
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_16x16_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #64
bl	inv_txfm_horz_16x4_neon
add	x6, sp, #256
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_16x16_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #64
bl	inv_txfm_horz_16x4_neon
add	x6, sp, #384
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_16x16_neon
add	x7, x2, #48
mov	x8, #64
bl	inv_txfm_horz_16x4_neon
b	inv_txfm_add_16x16_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_16x16_neon
add	x6, x0, #0
mov	x7, sp
mov	x8, #32
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #16
add	x7, sp, #16
mov	x8, #32
bl	inv_txfm_add_vert_8x16_neon
add	sp, sp, #512
ret	x15
_inv_txfm_add_dct_dct_16x16_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x16_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w16_neon
adr	x4, #-4392
adrp	x5, inv_txfm_add_dct_dct_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_dct_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_identity_identity_16x16_16bpc_neon:
adr	x4, #-1460
adrp	x5, inv_txfm_add_identity_identity_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_identity_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_dct_adst_16x16_16bpc_neon:
adr	x4, #-4440
adrp	x5, inv_txfm_add_dct_adst_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_adst_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_dct_flipadst_16x16_16bpc_neon:
adr	x4, #-4464
adrp	x5, inv_txfm_add_dct_flipadst_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_flipadst_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_dct_identity_16x16_16bpc_neon:
adr	x4, #-4488
adrp	x5, inv_txfm_add_dct_identity_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_identity_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_adst_dct_16x16_16bpc_neon:
adr	x4, #-3696
adrp	x5, inv_txfm_add_adst_dct_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_dct_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_adst_adst_16x16_16bpc_neon:
adr	x4, #-3720
adrp	x5, inv_txfm_add_adst_adst_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_adst_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_adst_flipadst_16x16_16bpc_neon:
adr	x4, #-3744
adrp	x5, inv_txfm_add_adst_flipadst_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_flipadst_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_flipadst_dct_16x16_16bpc_neon:
adr	x4, #-2704
adrp	x5, inv_txfm_add_flipadst_dct_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_dct_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_flipadst_adst_16x16_16bpc_neon:
adr	x4, #-2728
adrp	x5, inv_txfm_add_flipadst_adst_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_adst_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_flipadst_flipadst_16x16_16bpc_neon:
adr	x4, #-2752
adrp	x5, inv_txfm_add_flipadst_flipadst_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_flipadst_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_identity_dct_16x16_16bpc_neon:
adr	x4, #-1700
adrp	x5, inv_txfm_add_identity_dct_16x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_dct_16x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_16x16_neon
_inv_txfm_add_16x4_neon:
mov	x15, x30
movi.4s	v4, #0
ld1.4s	{ v16 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v17 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v18 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v19 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v20 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v21 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v22 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v23 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v24 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v25 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v26 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v27 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v28 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v29 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v30 }, [x2]
st1.4s	{ v4 }, [x2], #16
ld1.4s	{ v31 }, [x2]
st1.4s	{ v4 }, [x2], #16
blr	x4
sqrshrn.4h	v16, v16, #1
sqrshrn.4h	v17, v17, #1
sqrshrn.4h	v18, v18, #1
sqrshrn.4h	v19, v19, #1
sqrshrn2.8h	v16, v20, #1
sqrshrn2.8h	v17, v21, #1
sqrshrn2.8h	v18, v22, #1
sqrshrn2.8h	v19, v23, #1
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v4, v18, v19
trn2.8h	v5, v18, v19
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
blr	x5
mov	x6, x0
mov	x7, x6
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x6], x1
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x6], x1
st1.8h	{ v5 }, [x6], x1
sqrshrn.4h	v16, v24, #1
sqrshrn.4h	v17, v25, #1
sqrshrn.4h	v18, v26, #1
sqrshrn.4h	v19, v27, #1
sqrshrn2.8h	v16, v28, #1
sqrshrn2.8h	v17, v29, #1
sqrshrn2.8h	v18, v30, #1
sqrshrn2.8h	v19, v31, #1
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v4, v18, v19
trn2.8h	v5, v18, v19
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
blr	x5
add	x6, x0, #16
mov	x7, x6
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x6], x1
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x6], x1
st1.8h	{ v5 }, [x6], x1
ret	x15
_inv_txfm_add_4x16_neon:
ldrh	w12, [x13, #4]
mov	x15, x30
mov	x11, #64
cmp	w3, w12
ldrh	w12, [x13, #2]
b.lt	inv_txfm_add_4x16_neon
add	x6, x2, #48
movi.4s	v2, #0
ld1.4s	{ v16 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v2 }, [x6], x11
blr	x4
sqrshrn.4h	v28, v16, #1
sqrshrn.4h	v29, v17, #1
sqrshrn.4h	v30, v18, #1
sqrshrn.4h	v31, v19, #1
trn1.4h	v4, v28, v29
trn2.4h	v5, v28, v29
trn1.4h	v6, v30, v31
trn2.4h	v7, v30, v31
trn1.2s	v28, v4, v6
trn2.2s	v30, v4, v6
trn1.2s	v29, v5, v7
trn2.2s	v31, v5, v7
b	inv_txfm_add_4x16_neon
movi.4h	v28, #0
movi.4h	v29, #0
movi.4h	v30, #0
movi.4h	v31, #0
cmp	w3, w12
ldrh	w12, [x13]
b.lt	inv_txfm_add_4x16_neon
add	x6, x2, #32
movi.4s	v2, #0
ld1.4s	{ v16 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v2 }, [x6], x11
blr	x4
sqrshrn.4h	v24, v16, #1
sqrshrn.4h	v25, v17, #1
sqrshrn.4h	v26, v18, #1
sqrshrn.4h	v27, v19, #1
trn1.4h	v4, v24, v25
trn2.4h	v5, v24, v25
trn1.4h	v6, v26, v27
trn2.4h	v7, v26, v27
trn1.2s	v24, v4, v6
trn2.2s	v26, v4, v6
trn1.2s	v25, v5, v7
trn2.2s	v27, v5, v7
b	inv_txfm_add_4x16_neon
movi.4h	v24, #0
movi.4h	v25, #0
movi.4h	v26, #0
movi.4h	v27, #0
cmp	w3, w12
b.lt	inv_txfm_add_4x16_neon
add	x6, x2, #16
movi.4s	v2, #0
ld1.4s	{ v16 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v2 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v2 }, [x6], x11
blr	x4
sqrshrn.4h	v20, v16, #1
sqrshrn.4h	v21, v17, #1
sqrshrn.4h	v22, v18, #1
sqrshrn.4h	v23, v19, #1
trn1.4h	v4, v20, v21
trn2.4h	v5, v20, v21
trn1.4h	v6, v22, v23
trn2.4h	v7, v22, v23
trn1.2s	v20, v4, v6
trn2.2s	v22, v4, v6
trn1.2s	v21, v5, v7
trn2.2s	v23, v5, v7
b	inv_txfm_add_4x16_neon
movi.4h	v20, #0
movi.4h	v21, #0
movi.4h	v22, #0
movi.4h	v23, #0
movi.4s	v2, #0
ld1.4s	{ v16 }, [x2]
st1.4s	{ v2 }, [x2], x11
ld1.4s	{ v17 }, [x2]
st1.4s	{ v2 }, [x2], x11
ld1.4s	{ v18 }, [x2]
st1.4s	{ v2 }, [x2], x11
ld1.4s	{ v19 }, [x2]
st1.4s	{ v2 }, [x2], x11
blr	x4
sqrshrn.4h	v16, v16, #1
sqrshrn.4h	v17, v17, #1
sqrshrn.4h	v18, v18, #1
sqrshrn.4h	v19, v19, #1
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v6, v18, v19
trn2.8h	v7, v18, v19
trn1.4s	v16, v4, v6
trn2.4s	v18, v4, v6
trn1.4s	v17, v5, v7
trn2.4s	v19, v5, v7
blr	x5
mov	x6, x0
mvni.8h	v7, #252, lsl #8
ld1.d	{ v0 }[0], [x6], x1
mov.d	v16[1], v17[0]
ld1.d	{ v0 }[1], [x6], x1
ld1.d	{ v1 }[0], [x6], x1
mov.d	v18[1], v19[0]
ld1.d	{ v1 }[1], [x6], x1
ld1.d	{ v2 }[0], [x6], x1
mov.d	v20[1], v21[0]
srshr.8h	v16, v16, #4
ld1.d	{ v2 }[1], [x6], x1
ld1.d	{ v3 }[0], [x6], x1
mov.d	v22[1], v23[0]
srshr.8h	v18, v18, #4
ld1.d	{ v3 }[1], [x6], x1
usqadd.8h	v0, v16
ld1.d	{ v17 }[0], [x6], x1
mov.d	v24[1], v25[0]
srshr.8h	v20, v20, #4
ld1.d	{ v17 }[1], [x6], x1
usqadd.8h	v1, v18
smin.8h	v0, v0, v7
ld1.d	{ v19 }[0], [x6], x1
mov.d	v26[1], v27[0]
srshr.8h	v22, v22, #4
ld1.d	{ v19 }[1], [x6], x1
usqadd.8h	v2, v20
st1.d	{ v0 }[0], [x0], x1
smin.8h	v1, v1, v7
st1.d	{ v0 }[1], [x0], x1
ld1.d	{ v21 }[0], [x6], x1
mov.d	v28[1], v29[0]
srshr.8h	v24, v24, #4
ld1.d	{ v21 }[1], [x6], x1
usqadd.8h	v3, v22
st1.d	{ v1 }[0], [x0], x1
smin.8h	v2, v2, v7
st1.d	{ v1 }[1], [x0], x1
ld1.d	{ v23 }[0], [x6], x1
mov.d	v30[1], v31[0]
srshr.8h	v26, v26, #4
ld1.d	{ v23 }[1], [x6], x1
usqadd.8h	v17, v24
st1.d	{ v2 }[0], [x0], x1
smin.8h	v3, v3, v7
st1.d	{ v2 }[1], [x0], x1
srshr.8h	v28, v28, #4
usqadd.8h	v19, v26
st1.d	{ v3 }[0], [x0], x1
smin.8h	v17, v17, v7
st1.d	{ v3 }[1], [x0], x1
srshr.8h	v30, v30, #4
usqadd.8h	v21, v28
st1.d	{ v17 }[0], [x0], x1
smin.8h	v19, v19, v7
st1.d	{ v17 }[1], [x0], x1
usqadd.8h	v23, v30
st1.d	{ v19 }[0], [x0], x1
smin.8h	v21, v21, v7
st1.d	{ v19 }[1], [x0], x1
st1.d	{ v21 }[0], [x0], x1
smin.8h	v23, v23, v7
st1.d	{ v21 }[1], [x0], x1
st1.d	{ v23 }[0], [x0], x1
st1.d	{ v23 }[1], [x0], x1
ret	x15
_inv_txfm_add_dct_dct_4x16_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_4x16_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #16
b	ltmp0
adr	x4, #-10468
adrp	x5, inv_txfm_add_dct_dct_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_dct_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_identity_4x16_16bpc_neon:
adr	x4, #-10236
adrp	x5, inv_txfm_add_identity_identity_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_identity_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_dct_adst_4x16_16bpc_neon:
adr	x4, #-10516
adrp	x5, inv_txfm_add_dct_adst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_adst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_dct_flipadst_4x16_16bpc_neon:
adr	x4, #-10540
adrp	x5, inv_txfm_add_dct_flipadst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_flipadst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_dct_identity_4x16_16bpc_neon:
adr	x4, #-10564
adrp	x5, inv_txfm_add_dct_identity_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_identity_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_dct_4x16_16bpc_neon:
adr	x4, #-10508
adrp	x5, inv_txfm_add_adst_dct_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_dct_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_adst_4x16_16bpc_neon:
adr	x4, #-10532
adrp	x5, inv_txfm_add_adst_adst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_adst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_flipadst_4x16_16bpc_neon:
adr	x4, #-10556
adrp	x5, inv_txfm_add_adst_flipadst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_flipadst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_dct_4x16_16bpc_neon:
adr	x4, #-10492
adrp	x5, inv_txfm_add_flipadst_dct_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_dct_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_adst_4x16_16bpc_neon:
adr	x4, #-10516
adrp	x5, inv_txfm_add_flipadst_adst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_adst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_flipadst_4x16_16bpc_neon:
adr	x4, #-10540
adrp	x5, inv_txfm_add_flipadst_flipadst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_flipadst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_dct_4x16_16bpc_neon:
adr	x4, #-10476
adrp	x5, inv_txfm_add_identity_dct_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_dct_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_identity_4x16_16bpc_neon:
adr	x4, #-10676
adrp	x5, inv_txfm_add_adst_identity_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_identity_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_identity_4x16_16bpc_neon:
adr	x4, #-10612
adrp	x5, inv_txfm_add_flipadst_identity_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_identity_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_adst_4x16_16bpc_neon:
adr	x4, #-10548
adrp	x5, inv_txfm_add_identity_adst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_adst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_flipadst_4x16_16bpc_neon:
adr	x4, #-10572
adrp	x5, inv_txfm_add_identity_flipadst_4x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_flipadst_4x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_4x16_neon
_inv_txfm_add_dct_dct_16x4_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x4_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #4
b	idct_dc_w16_neon
adr	x4, #-6364
adrp	x5, inv_txfm_add_dct_dct_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_identity_16x4_16bpc_neon:
adr	x4, #-3424
adrp	x5, inv_txfm_add_identity_identity_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_dct_adst_16x4_16bpc_neon:
adr	x4, #-6396
adrp	x5, inv_txfm_add_dct_adst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_dct_flipadst_16x4_16bpc_neon:
adr	x4, #-6412
adrp	x5, inv_txfm_add_dct_flipadst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_dct_identity_16x4_16bpc_neon:
adr	x4, #-6428
adrp	x5, inv_txfm_add_dct_identity_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_dct_16x4_16bpc_neon:
adr	x4, #-5628
adrp	x5, inv_txfm_add_adst_dct_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_adst_16x4_16bpc_neon:
adr	x4, #-5644
adrp	x5, inv_txfm_add_adst_adst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_flipadst_16x4_16bpc_neon:
adr	x4, #-5660
adrp	x5, inv_txfm_add_adst_flipadst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_dct_16x4_16bpc_neon:
adr	x4, #-4612
adrp	x5, inv_txfm_add_flipadst_dct_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_adst_16x4_16bpc_neon:
adr	x4, #-4628
adrp	x5, inv_txfm_add_flipadst_adst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_flipadst_16x4_16bpc_neon:
adr	x4, #-4644
adrp	x5, inv_txfm_add_flipadst_flipadst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_dct_16x4_16bpc_neon:
adr	x4, #-3584
adrp	x5, inv_txfm_add_identity_dct_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_identity_16x4_16bpc_neon:
adr	x4, #-5740
adrp	x5, inv_txfm_add_adst_identity_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_identity_16x4_16bpc_neon:
adr	x4, #-4692
adrp	x5, inv_txfm_add_flipadst_identity_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_adst_16x4_16bpc_neon:
adr	x4, #-3632
adrp	x5, inv_txfm_add_identity_adst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_flipadst_16x4_16bpc_neon:
adr	x4, #-3648
adrp	x5, inv_txfm_add_identity_flipadst_16x4_16bpc_neon
add	x5, x5, #0
b	inv_txfm_add_16x4_neon
_inv_txfm_add_16x8_neon:
mov	x15, x30
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
cmp	w3, w13
mov	x11, #32
b.lt	inv_txfm_add_16x8_neon
movi.4s	v4, #0
mov	w16, #1518338048
dup.2s	v0, w16
add	x6, x2, #16
ld1.4s	{ v16 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v20 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v21 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v22 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v23 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v24 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v25 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v26 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v27 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v28 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v29 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v30 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v31 }, [x6]
st1.4s	{ v4 }, [x6], x11
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
sqrdmulh.4s	v24, v24, v0[0]
sqrdmulh.4s	v25, v25, v0[0]
sqrdmulh.4s	v26, v26, v0[0]
sqrdmulh.4s	v27, v27, v0[0]
sqrdmulh.4s	v28, v28, v0[0]
sqrdmulh.4s	v29, v29, v0[0]
sqrdmulh.4s	v30, v30, v0[0]
sqrdmulh.4s	v31, v31, v0[0]
blr	x4
sqrshrn.4h	v8, v16, #1
sqrshrn.4h	v9, v17, #1
sqrshrn.4h	v10, v18, #1
sqrshrn.4h	v11, v19, #1
sqrshrn2.8h	v8, v20, #1
sqrshrn2.8h	v9, v21, #1
sqrshrn2.8h	v10, v22, #1
sqrshrn2.8h	v11, v23, #1
sqrshrn.4h	v12, v24, #1
sqrshrn.4h	v13, v25, #1
sqrshrn.4h	v14, v26, #1
sqrshrn.4h	v15, v27, #1
sqrshrn2.8h	v12, v28, #1
sqrshrn2.8h	v13, v29, #1
sqrshrn2.8h	v14, v30, #1
sqrshrn2.8h	v15, v31, #1
trn1.8h	v2, v8, v9
trn2.8h	v3, v8, v9
trn1.8h	v4, v10, v11
trn2.8h	v5, v10, v11
trn1.4s	v8, v2, v4
trn2.4s	v10, v2, v4
trn1.4s	v9, v3, v5
trn2.4s	v11, v3, v5
trn1.8h	v2, v12, v13
trn2.8h	v3, v12, v13
trn1.8h	v4, v14, v15
trn2.8h	v5, v14, v15
trn1.4s	v12, v2, v4
trn2.4s	v14, v2, v4
trn1.4s	v13, v3, v5
trn2.4s	v15, v3, v5
b	inv_txfm_add_16x8_neon
movi.8h	v8, #0
movi.8h	v9, #0
movi.8h	v10, #0
movi.8h	v11, #0
movi.8h	v12, #0
movi.8h	v13, #0
movi.8h	v14, #0
movi.8h	v15, #0
mov	w16, #1518338048
dup.2s	v0, w16
movi.4s	v4, #0
ld1.4s	{ v16 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v17 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v18 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v19 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v20 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v21 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v22 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v23 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v24 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v25 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v26 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v27 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v28 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v29 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v30 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v31 }, [x2]
st1.4s	{ v4 }, [x2], x11
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
sqrdmulh.4s	v24, v24, v0[0]
sqrdmulh.4s	v25, v25, v0[0]
sqrdmulh.4s	v26, v26, v0[0]
sqrdmulh.4s	v27, v27, v0[0]
sqrdmulh.4s	v28, v28, v0[0]
sqrdmulh.4s	v29, v29, v0[0]
sqrdmulh.4s	v30, v30, v0[0]
sqrdmulh.4s	v31, v31, v0[0]
blr	x4
sqrshrn.4h	v16, v16, #1
sqrshrn.4h	v17, v17, #1
sqrshrn.4h	v18, v18, #1
sqrshrn.4h	v19, v19, #1
sqrshrn2.8h	v16, v20, #1
sqrshrn2.8h	v17, v21, #1
sqrshrn2.8h	v18, v22, #1
sqrshrn2.8h	v19, v23, #1
mov.16b	v20, v8
mov.16b	v21, v9
mov.16b	v22, v10
mov.16b	v23, v11
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v4, v18, v19
trn2.8h	v5, v18, v19
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
sqrshrn.4h	v8, v24, #1
sqrshrn.4h	v9, v25, #1
sqrshrn.4h	v10, v26, #1
sqrshrn.4h	v11, v27, #1
sqrshrn2.8h	v8, v28, #1
sqrshrn2.8h	v9, v29, #1
sqrshrn2.8h	v10, v30, #1
sqrshrn2.8h	v11, v31, #1
trn1.8h	v2, v8, v9
trn2.8h	v3, v8, v9
trn1.8h	v4, v10, v11
trn2.8h	v5, v10, v11
trn1.4s	v8, v2, v4
trn2.4s	v10, v2, v4
trn1.4s	v9, v3, v5
trn2.4s	v11, v3, v5
blr	x5
mov	x6, x0
mov	x7, x6
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x6], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x6], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x6], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x6], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x6], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x6], x1
st1.8h	{ v19 }, [x6], x1
mov.16b	v16, v8
mov.16b	v17, v9
mov.16b	v18, v10
mov.16b	v19, v11
mov.16b	v20, v12
mov.16b	v21, v13
mov.16b	v22, v14
mov.16b	v23, v15
blr	x5
add	x0, x0, #16
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x15
_inv_txfm_add_8x16_neon:
mov	x15, x30
stp	d8, d9, [sp, #-32]!
stp	d10, d11, [sp, #16]
ldrh	w12, [x13, #4]
mov	x11, #64
cmp	w3, w12
ldrh	w12, [x13, #2]
b.lt	inv_txfm_add_8x16_neon
add	x6, x2, #48
movi.4s	v4, #0
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v16 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v20 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v21 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v22 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v23 }, [x6]
st1.4s	{ v4 }, [x6], x11
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
blr	x4
sqrshrn.4h	v28, v16, #1
sqrshrn.4h	v29, v17, #1
sqrshrn.4h	v30, v18, #1
sqrshrn.4h	v31, v19, #1
sqrshrn2.8h	v28, v20, #1
sqrshrn2.8h	v29, v21, #1
sqrshrn2.8h	v30, v22, #1
sqrshrn2.8h	v31, v23, #1
trn1.8h	v2, v28, v29
trn2.8h	v3, v28, v29
trn1.8h	v4, v30, v31
trn2.8h	v5, v30, v31
trn1.4s	v28, v2, v4
trn2.4s	v30, v2, v4
trn1.4s	v29, v3, v5
trn2.4s	v31, v3, v5
b	inv_txfm_add_8x16_neon
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
cmp	w3, w12
ldrh	w12, [x13]
b.lt	inv_txfm_add_8x16_neon
add	x6, x2, #32
movi.4s	v4, #0
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v16 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v20 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v21 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v22 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v23 }, [x6]
st1.4s	{ v4 }, [x6], x11
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
blr	x4
sqrshrn.4h	v24, v16, #1
sqrshrn.4h	v25, v17, #1
sqrshrn.4h	v26, v18, #1
sqrshrn.4h	v27, v19, #1
sqrshrn2.8h	v24, v20, #1
sqrshrn2.8h	v25, v21, #1
sqrshrn2.8h	v26, v22, #1
sqrshrn2.8h	v27, v23, #1
trn1.8h	v2, v24, v25
trn2.8h	v3, v24, v25
trn1.8h	v4, v26, v27
trn2.8h	v5, v26, v27
trn1.4s	v24, v2, v4
trn2.4s	v26, v2, v4
trn1.4s	v25, v3, v5
trn2.4s	v27, v3, v5
b	inv_txfm_add_8x16_neon
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
cmp	w3, w12
b.lt	inv_txfm_add_8x16_neon
add	x6, x2, #16
movi.4s	v4, #0
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v16 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v17 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v18 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v19 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v20 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v21 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v22 }, [x6]
st1.4s	{ v4 }, [x6], x11
ld1.4s	{ v23 }, [x6]
st1.4s	{ v4 }, [x6], x11
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
blr	x4
sqrshrn.4h	v8, v16, #1
sqrshrn.4h	v9, v17, #1
sqrshrn.4h	v10, v18, #1
sqrshrn.4h	v11, v19, #1
sqrshrn2.8h	v8, v20, #1
sqrshrn2.8h	v9, v21, #1
sqrshrn2.8h	v10, v22, #1
sqrshrn2.8h	v11, v23, #1
trn1.8h	v2, v8, v9
trn2.8h	v3, v8, v9
trn1.8h	v4, v10, v11
trn2.8h	v5, v10, v11
trn1.4s	v8, v2, v4
trn2.4s	v10, v2, v4
trn1.4s	v9, v3, v5
trn2.4s	v11, v3, v5
b	inv_txfm_add_8x16_neon
movi.8h	v8, #0
movi.8h	v9, #0
movi.8h	v10, #0
movi.8h	v11, #0
movi.4s	v4, #0
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v16 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v17 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v18 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v19 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v20 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v21 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v22 }, [x2]
st1.4s	{ v4 }, [x2], x11
ld1.4s	{ v23 }, [x2]
st1.4s	{ v4 }, [x2], x11
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
blr	x4
sqrshrn.4h	v16, v16, #1
sqrshrn.4h	v17, v17, #1
sqrshrn.4h	v18, v18, #1
sqrshrn.4h	v19, v19, #1
sqrshrn2.8h	v16, v20, #1
sqrshrn2.8h	v17, v21, #1
sqrshrn2.8h	v18, v22, #1
sqrshrn2.8h	v19, v23, #1
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v4, v18, v19
trn2.8h	v5, v18, v19
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
mov.16b	v20, v8
mov.16b	v21, v9
mov.16b	v22, v10
mov.16b	v23, v11
blr	x5
mov	x6, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x6], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x6], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x6], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x6], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x6], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x6], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x6], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x6], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
ld1.8h	{ v20 }, [x6], x1
srshr.8h	v24, v24, #4
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
ld1.8h	{ v21 }, [x6], x1
srshr.8h	v25, v25, #4
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
ld1.8h	{ v22 }, [x6], x1
srshr.8h	v26, v26, #4
usqadd.8h	v20, v24
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
ld1.8h	{ v23 }, [x6], x1
srshr.8h	v27, v27, #4
usqadd.8h	v21, v25
smin.8h	v20, v20, v7
st1.8h	{ v19 }, [x0], x1
ld1.8h	{ v24 }, [x6], x1
srshr.8h	v28, v28, #4
usqadd.8h	v22, v26
smin.8h	v21, v21, v7
st1.8h	{ v20 }, [x0], x1
ld1.8h	{ v25 }, [x6], x1
srshr.8h	v29, v29, #4
usqadd.8h	v23, v27
smin.8h	v22, v22, v7
st1.8h	{ v21 }, [x0], x1
ld1.8h	{ v26 }, [x6], x1
srshr.8h	v30, v30, #4
usqadd.8h	v24, v28
smin.8h	v23, v23, v7
st1.8h	{ v22 }, [x0], x1
ld1.8h	{ v27 }, [x6], x1
srshr.8h	v31, v31, #4
usqadd.8h	v25, v29
smin.8h	v24, v24, v7
st1.8h	{ v23 }, [x0], x1
usqadd.8h	v26, v30
smin.8h	v25, v25, v7
st1.8h	{ v24 }, [x0], x1
usqadd.8h	v27, v31
smin.8h	v26, v26, v7
st1.8h	{ v25 }, [x0], x1
smin.8h	v27, v27, v7
st1.8h	{ v26 }, [x0], x1
st1.8h	{ v27 }, [x0], x1
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #32
ret	x15
_inv_txfm_add_dct_dct_8x16_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_8x16_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w8_neon
adr	x4, #-12548
adrp	x5, inv_txfm_add_dct_dct_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_dct_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_identity_8x16_16bpc_neon:
adr	x4, #-11496
adrp	x5, inv_txfm_add_identity_identity_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_identity_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_dct_adst_8x16_16bpc_neon:
adr	x4, #-12596
adrp	x5, inv_txfm_add_dct_adst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_adst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_dct_flipadst_8x16_16bpc_neon:
adr	x4, #-12620
adrp	x5, inv_txfm_add_dct_flipadst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_flipadst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_dct_identity_8x16_16bpc_neon:
adr	x4, #-12644
adrp	x5, inv_txfm_add_dct_identity_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_identity_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_dct_8x16_16bpc_neon:
adr	x4, #-12392
adrp	x5, inv_txfm_add_adst_dct_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_dct_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_adst_8x16_16bpc_neon:
adr	x4, #-12416
adrp	x5, inv_txfm_add_adst_adst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_adst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_flipadst_8x16_16bpc_neon:
adr	x4, #-12440
adrp	x5, inv_txfm_add_adst_flipadst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_flipadst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_dct_8x16_16bpc_neon:
adr	x4, #-12064
adrp	x5, inv_txfm_add_flipadst_dct_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_dct_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_adst_8x16_16bpc_neon:
adr	x4, #-12088
adrp	x5, inv_txfm_add_flipadst_adst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_adst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_flipadst_8x16_16bpc_neon:
adr	x4, #-12112
adrp	x5, inv_txfm_add_flipadst_flipadst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_flipadst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_dct_8x16_16bpc_neon:
adr	x4, #-11736
adrp	x5, inv_txfm_add_identity_dct_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_dct_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_identity_8x16_16bpc_neon:
adr	x4, #-12560
adrp	x5, inv_txfm_add_adst_identity_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_identity_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_identity_8x16_16bpc_neon:
adr	x4, #-12184
adrp	x5, inv_txfm_add_flipadst_identity_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_identity_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_adst_8x16_16bpc_neon:
adr	x4, #-11808
adrp	x5, inv_txfm_add_identity_adst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_adst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_flipadst_8x16_16bpc_neon:
adr	x4, #-11832
adrp	x5, inv_txfm_add_identity_flipadst_8x16_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_flipadst_8x16_16bpc_neon
add	x13, x13, #0
b	inv_txfm_add_8x16_neon
_inv_txfm_add_dct_dct_16x8_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x8_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #8
b	idct_dc_w16_neon
adr	x4, #-9460
adrp	x5, inv_txfm_add_dct_dct_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_dct_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_identity_16x8_16bpc_neon:
adr	x4, #-6532
adrp	x5, inv_txfm_add_identity_identity_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_identity_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_dct_adst_16x8_16bpc_neon:
adr	x4, #-9516
adrp	x5, inv_txfm_add_dct_adst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_adst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_dct_flipadst_16x8_16bpc_neon:
adr	x4, #-9544
adrp	x5, inv_txfm_add_dct_flipadst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_flipadst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_dct_identity_16x8_16bpc_neon:
adr	x4, #-9572
adrp	x5, inv_txfm_add_dct_identity_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_dct_identity_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_dct_16x8_16bpc_neon:
adr	x4, #-8784
adrp	x5, inv_txfm_add_adst_dct_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_dct_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_adst_16x8_16bpc_neon:
adr	x4, #-8812
adrp	x5, inv_txfm_add_adst_adst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_adst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_flipadst_16x8_16bpc_neon:
adr	x4, #-8840
adrp	x5, inv_txfm_add_adst_flipadst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_flipadst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_dct_16x8_16bpc_neon:
adr	x4, #-7804
adrp	x5, inv_txfm_add_flipadst_dct_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_dct_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_adst_16x8_16bpc_neon:
adr	x4, #-7832
adrp	x5, inv_txfm_add_flipadst_adst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_adst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_flipadst_16x8_16bpc_neon:
adr	x4, #-7860
adrp	x5, inv_txfm_add_flipadst_flipadst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_flipadst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_dct_16x8_16bpc_neon:
adr	x4, #-6812
adrp	x5, inv_txfm_add_identity_dct_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_dct_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_identity_16x8_16bpc_neon:
adr	x4, #-8980
adrp	x5, inv_txfm_add_adst_identity_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_adst_identity_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_identity_16x8_16bpc_neon:
adr	x4, #-7944
adrp	x5, inv_txfm_add_flipadst_identity_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_flipadst_identity_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_adst_16x8_16bpc_neon:
adr	x4, #-6896
adrp	x5, inv_txfm_add_identity_adst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_adst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_flipadst_16x8_16bpc_neon:
adr	x4, #-6924
adrp	x5, inv_txfm_add_identity_flipadst_16x8_16bpc_neon
add	x5, x5, #0
adrp	x13, inv_txfm_add_identity_flipadst_16x8_16bpc_neon
add	x13, x13, #0
ldrh	w13, [x13]
b	inv_txfm_add_16x8_neon
_inv_dct32_odd_4s_x16_neon:
adrp	x16, inv_dct32_odd_4s_x16_neon
add	x16, x16, #0
ld1.4s	{ v0, v1 }, [x16], #32
mul.4s	v2, v16, v0[0]
mls.4s	v2, v31, v0[1]
mul.4s	v4, v16, v0[1]
mla.4s	v4, v31, v0[0]
mul.4s	v6, v24, v0[2]
mls.4s	v6, v23, v0[3]
srshr.4s	v16, v2, #12
srshr.4s	v31, v4, #12
mul.4s	v2, v24, v0[3]
mla.4s	v2, v23, v0[2]
mul.4s	v4, v20, v1[0]
mls.4s	v4, v27, v1[1]
srshr.4s	v24, v6, #12
srshr.4s	v23, v2, #12
mul.4s	v6, v20, v1[1]
mla.4s	v6, v27, v1[0]
mul.4s	v2, v28, v1[2]
mls.4s	v2, v19, v1[3]
srshr.4s	v20, v4, #12
srshr.4s	v27, v6, #12
mul.4s	v4, v28, v1[3]
mla.4s	v4, v19, v1[2]
ld1.4s	{ v0, v1 }, [x16]
sub	x16, x16, #96
mul.4s	v6, v18, v0[0]
mls.4s	v6, v29, v0[1]
srshr.4s	v28, v2, #12
srshr.4s	v19, v4, #12
mul.4s	v2, v18, v0[1]
mla.4s	v2, v29, v0[0]
mul.4s	v4, v26, v0[2]
mls.4s	v4, v21, v0[3]
srshr.4s	v18, v6, #12
srshr.4s	v29, v2, #12
mul.4s	v6, v26, v0[3]
mla.4s	v6, v21, v0[2]
mul.4s	v2, v22, v1[0]
mls.4s	v2, v25, v1[1]
srshr.4s	v26, v4, #12
srshr.4s	v21, v6, #12
mul.4s	v4, v22, v1[1]
mla.4s	v4, v25, v1[0]
mul.4s	v6, v30, v1[2]
mls.4s	v6, v17, v1[3]
srshr.4s	v22, v2, #12
srshr.4s	v25, v4, #12
mul.4s	v2, v30, v1[3]
mla.4s	v2, v17, v1[2]
srshr.4s	v30, v6, #12
srshr.4s	v17, v2, #12
ld1.4s	{ v0, v1 }, [x16]
movi.4s	v5, #1, msl #16
mvni.4s	v4, #1, msl #16
sqsub.4s	v2, v16, v24
sqadd.4s	v16, v16, v24
sqsub.4s	v3, v31, v23
sqadd.4s	v31, v31, v23
sqsub.4s	v24, v28, v20
sqadd.4s	v28, v28, v20
sqadd.4s	v23, v18, v26
sqsub.4s	v18, v18, v26
sqsub.4s	v20, v30, v22
sqadd.4s	v30, v30, v22
sqadd.4s	v26, v17, v25
sqsub.4s	v17, v17, v25
sqsub.4s	v22, v29, v21
sqadd.4s	v29, v29, v21
sqadd.4s	v25, v19, v27
sqsub.4s	v19, v19, v27
smin.4s	v2, v2, v5
smin.4s	v16, v16, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v24, v24, v5
smin.4s	v28, v28, v5
smin.4s	v23, v23, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v30, v30, v5
smin.4s	v26, v26, v5
smin.4s	v17, v17, v5
smin.4s	v22, v22, v5
smin.4s	v29, v29, v5
smin.4s	v25, v25, v5
smin.4s	v19, v19, v5
smax.4s	v2, v2, v4
smax.4s	v16, v16, v4
smax.4s	v3, v3, v4
smax.4s	v31, v31, v4
smax.4s	v24, v24, v4
smax.4s	v28, v28, v4
smax.4s	v23, v23, v4
smax.4s	v18, v18, v4
smax.4s	v20, v20, v4
smax.4s	v30, v30, v4
smax.4s	v26, v26, v4
smax.4s	v17, v17, v4
smax.4s	v22, v22, v4
smax.4s	v29, v29, v4
smax.4s	v25, v25, v4
smax.4s	v19, v19, v4
mul.4s	v7, v3, v1[0]
mls.4s	v7, v2, v1[1]
mul.4s	v6, v3, v1[1]
mla.4s	v6, v2, v1[0]
mul.4s	v2, v19, v1[1]
mla.4s	v2, v24, v1[0]
srshr.4s	v21, v7, #12
srshr.4s	v27, v6, #12
neg.4s	v2, v2
mul.4s	v7, v19, v1[0]
mls.4s	v7, v24, v1[1]
mul.4s	v6, v22, v1[2]
mls.4s	v6, v18, v1[3]
srshr.4s	v19, v2, #12
srshr.4s	v24, v7, #12
mul.4s	v2, v22, v1[3]
mla.4s	v2, v18, v1[2]
mul.4s	v7, v17, v1[3]
mla.4s	v7, v20, v1[2]
srshr.4s	v22, v6, #12
srshr.4s	v18, v2, #12
neg.4s	v7, v7
mul.4s	v6, v17, v1[2]
mls.4s	v6, v20, v1[3]
srshr.4s	v17, v7, #12
srshr.4s	v20, v6, #12
sqsub.4s	v2, v27, v24
sqadd.4s	v27, v27, v24
sqsub.4s	v3, v21, v19
sqadd.4s	v21, v21, v19
sqsub.4s	v24, v16, v28
sqadd.4s	v16, v16, v28
sqsub.4s	v19, v30, v23
sqadd.4s	v30, v30, v23
sqsub.4s	v28, v17, v22
sqadd.4s	v17, v17, v22
sqadd.4s	v23, v26, v29
sqsub.4s	v26, v26, v29
sqadd.4s	v22, v20, v18
sqsub.4s	v20, v20, v18
sqsub.4s	v29, v31, v25
sqadd.4s	v31, v31, v25
smin.4s	v2, v2, v5
smin.4s	v27, v27, v5
smin.4s	v3, v3, v5
smin.4s	v21, v21, v5
smin.4s	v24, v24, v5
smin.4s	v16, v16, v5
smin.4s	v19, v19, v5
smin.4s	v30, v30, v5
smin.4s	v28, v28, v5
smin.4s	v17, v17, v5
smin.4s	v23, v23, v5
smin.4s	v26, v26, v5
smin.4s	v22, v22, v5
smin.4s	v20, v20, v5
smin.4s	v29, v29, v5
smin.4s	v31, v31, v5
smax.4s	v2, v2, v4
smax.4s	v27, v27, v4
smax.4s	v3, v3, v4
smax.4s	v21, v21, v4
smax.4s	v24, v24, v4
smax.4s	v16, v16, v4
smax.4s	v19, v19, v4
smax.4s	v30, v30, v4
smax.4s	v28, v28, v4
smax.4s	v17, v17, v4
smax.4s	v23, v23, v4
smax.4s	v26, v26, v4
smax.4s	v22, v22, v4
smax.4s	v20, v20, v4
smax.4s	v29, v29, v4
smax.4s	v31, v31, v4
mul.4s	v7, v2, v0[2]
mls.4s	v7, v3, v0[3]
mul.4s	v6, v2, v0[3]
mla.4s	v6, v3, v0[2]
mul.4s	v2, v29, v0[2]
mls.4s	v2, v24, v0[3]
srshr.4s	v18, v7, #12
srshr.4s	v25, v6, #12
mul.4s	v7, v29, v0[3]
mla.4s	v7, v24, v0[2]
mul.4s	v6, v26, v0[3]
mla.4s	v6, v19, v0[2]
srshr.4s	v29, v2, #12
srshr.4s	v24, v7, #12
neg.4s	v6, v6
mul.4s	v2, v26, v0[2]
mls.4s	v2, v19, v0[3]
mul.4s	v7, v20, v0[3]
mla.4s	v7, v28, v0[2]
srshr.4s	v26, v6, #12
srshr.4s	v19, v2, #12
neg.4s	v7, v7
mul.4s	v6, v20, v0[2]
mls.4s	v6, v28, v0[3]
srshr.4s	v20, v7, #12
srshr.4s	v28, v6, #12
sqsub.4s	v2, v16, v30
sqadd.4s	v16, v16, v30
sqsub.4s	v3, v31, v23
sqadd.4s	v31, v31, v23
sqsub.4s	v23, v21, v17
sqadd.4s	v17, v21, v17
sqadd.4s	v30, v27, v22
sqsub.4s	v21, v27, v22
sqsub.4s	v27, v18, v20
sqadd.4s	v18, v18, v20
sqadd.4s	v7, v29, v26
sqsub.4s	v26, v29, v26
sqadd.4s	v29, v25, v28
sqsub.4s	v25, v25, v28
sqadd.4s	v28, v24, v19
sqsub.4s	v24, v24, v19
mov.16b	v19, v7
smin.4s	v2, v2, v5
smin.4s	v16, v16, v5
smin.4s	v3, v3, v5
smin.4s	v31, v31, v5
smin.4s	v23, v23, v5
smin.4s	v17, v17, v5
smin.4s	v30, v30, v5
smin.4s	v21, v21, v5
smin.4s	v27, v27, v5
smin.4s	v18, v18, v5
smin.4s	v19, v19, v5
smin.4s	v26, v26, v5
smin.4s	v29, v29, v5
smin.4s	v25, v25, v5
smin.4s	v28, v28, v5
smin.4s	v24, v24, v5
smax.4s	v2, v2, v4
smax.4s	v16, v16, v4
smax.4s	v3, v3, v4
smax.4s	v31, v31, v4
smax.4s	v23, v23, v4
smax.4s	v17, v17, v4
smax.4s	v30, v30, v4
smax.4s	v21, v21, v4
smax.4s	v27, v27, v4
smax.4s	v18, v18, v4
smax.4s	v19, v19, v4
smax.4s	v26, v26, v4
smax.4s	v29, v29, v4
smax.4s	v25, v25, v4
smax.4s	v28, v28, v4
smax.4s	v24, v24, v4
mul.4s	v7, v24, v0[0]
mls.4s	v7, v26, v0[0]
mul.4s	v6, v24, v0[0]
mla.4s	v6, v26, v0[0]
srshr.4s	v20, v7, #12
srshr.4s	v22, v6, #12
mul.4s	v7, v25, v0[0]
mla.4s	v7, v27, v0[0]
mul.4s	v6, v25, v0[0]
mls.4s	v6, v27, v0[0]
mov.16b	v27, v22
srshr.4s	v26, v7, #12
mul.4s	v24, v21, v0[0]
mls.4s	v24, v23, v0[0]
mul.4s	v7, v21, v0[0]
mla.4s	v7, v23, v0[0]
srshr.4s	v21, v6, #12
srshr.4s	v22, v24, #12
srshr.4s	v25, v7, #12
mul.4s	v7, v3, v0[0]
mls.4s	v7, v2, v0[0]
mul.4s	v6, v3, v0[0]
mla.4s	v6, v2, v0[0]
srshr.4s	v23, v7, #12
srshr.4s	v24, v6, #12
ret
_inv_txfm_horz_dct_32x4_neon:
mov	x14, x30
movi.4s	v7, #0
lsl	x8, x8, #1
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v24 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v25 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v26 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v27 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v28 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v29 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v30 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v31 }, [x7]
st1.4s	{ v7 }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
bl	inv_dct_4s_x16_neon
smin.4s	v16, v16, v5
smin.4s	v17, v17, v5
smin.4s	v18, v18, v5
smin.4s	v19, v19, v5
smin.4s	v20, v20, v5
smin.4s	v21, v21, v5
smin.4s	v22, v22, v5
smin.4s	v23, v23, v5
smin.4s	v24, v24, v5
smin.4s	v25, v25, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v28, v28, v5
smin.4s	v29, v29, v5
smin.4s	v30, v30, v5
smin.4s	v31, v31, v5
smax.4s	v16, v16, v4
smax.4s	v17, v17, v4
smax.4s	v18, v18, v4
smax.4s	v19, v19, v4
smax.4s	v20, v20, v4
smax.4s	v21, v21, v4
smax.4s	v22, v22, v4
smax.4s	v23, v23, v4
smax.4s	v24, v24, v4
smax.4s	v25, v25, v4
smax.4s	v26, v26, v4
smax.4s	v27, v27, v4
smax.4s	v28, v28, v4
smax.4s	v29, v29, v4
smax.4s	v30, v30, v4
smax.4s	v31, v31, v4
trn1.4s	v2, v16, v17
trn2.4s	v3, v16, v17
trn1.4s	v4, v18, v19
trn2.4s	v5, v18, v19
trn1.2d	v16, v2, v4
trn2.2d	v18, v2, v4
trn1.2d	v17, v3, v5
trn2.2d	v19, v3, v5
trn1.4s	v2, v20, v21
trn2.4s	v3, v20, v21
trn1.4s	v4, v22, v23
trn2.4s	v5, v22, v23
trn1.2d	v20, v2, v4
trn2.2d	v22, v2, v4
trn1.2d	v21, v3, v5
trn2.2d	v23, v3, v5
trn1.4s	v2, v24, v25
trn2.4s	v3, v24, v25
trn1.4s	v4, v26, v27
trn2.4s	v5, v26, v27
trn1.2d	v24, v2, v4
trn2.2d	v26, v2, v4
trn1.2d	v25, v3, v5
trn2.2d	v27, v3, v5
trn1.4s	v2, v28, v29
trn2.4s	v3, v28, v29
trn1.4s	v4, v30, v31
trn2.4s	v5, v30, v31
trn1.2d	v28, v2, v4
trn2.2d	v30, v2, v4
trn1.2d	v29, v3, v5
trn2.2d	v31, v3, v5
st1.4s	{ v16 }, [x6], #16
st1.4s	{ v20 }, [x6], #16
st1.4s	{ v24 }, [x6], #16
st1.4s	{ v28 }, [x6], #16
st1.4s	{ v17 }, [x6], #16
st1.4s	{ v21 }, [x6], #16
st1.4s	{ v25 }, [x6], #16
st1.4s	{ v29 }, [x6], #16
st1.4s	{ v18 }, [x6], #16
st1.4s	{ v22 }, [x6], #16
st1.4s	{ v26 }, [x6], #16
st1.4s	{ v30 }, [x6], #16
st1.4s	{ v19 }, [x6], #16
st1.4s	{ v23 }, [x6], #16
st1.4s	{ v27 }, [x6], #16
st1.4s	{ v31 }, [x6], #16
sub	x6, x6, #256
movi.4s	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v24 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v25 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v26 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v27 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v28 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v29 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v30 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v31 }, [x7]
st1.4s	{ v7 }, [x7], x8
bl	inv_dct32_odd_4s_x16_neon
trn1.4s	v2, v31, v30
trn2.4s	v3, v31, v30
trn1.4s	v4, v29, v28
trn2.4s	v5, v29, v28
trn1.2d	v31, v2, v4
trn2.2d	v29, v2, v4
trn1.2d	v30, v3, v5
trn2.2d	v28, v3, v5
trn1.4s	v2, v27, v26
trn2.4s	v3, v27, v26
trn1.4s	v4, v25, v24
trn2.4s	v5, v25, v24
trn1.2d	v27, v2, v4
trn2.2d	v25, v2, v4
trn1.2d	v26, v3, v5
trn2.2d	v24, v3, v5
trn1.4s	v2, v23, v22
trn2.4s	v3, v23, v22
trn1.4s	v4, v21, v20
trn2.4s	v5, v21, v20
trn1.2d	v23, v2, v4
trn2.2d	v21, v2, v4
trn1.2d	v22, v3, v5
trn2.2d	v20, v3, v5
trn1.4s	v2, v19, v18
trn2.4s	v3, v19, v18
trn1.4s	v4, v17, v16
trn2.4s	v5, v17, v16
trn1.2d	v19, v2, v4
trn2.2d	v17, v2, v4
trn1.2d	v18, v3, v5
trn2.2d	v16, v3, v5
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v31
sqadd.4s	v0, v0, v31
sqsub.4s	v5, v1, v27
sqadd.4s	v1, v1, v27
sqsub.4s	v6, v2, v23
sqadd.4s	v2, v2, v23
sqsub.4s	v7, v3, v19
sqadd.4s	v3, v3, v19
sqrshrn.4h	v0, v0, #2
sqrshrn2.8h	v0, v1, #2
sqrshrn.4h	v1, v2, #2
sqrshrn2.8h	v1, v3, #2
sqrshrn.4h	v2, v7, #2
sqrshrn2.8h	v2, v6, #2
sqrshrn.4h	v3, v5, #2
sqrshrn2.8h	v3, v4, #2
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v30
sqadd.4s	v0, v0, v30
sqsub.4s	v5, v1, v26
sqadd.4s	v1, v1, v26
sqsub.4s	v6, v2, v22
sqadd.4s	v2, v2, v22
sqsub.4s	v7, v3, v18
sqadd.4s	v3, v3, v18
sqrshrn.4h	v0, v0, #2
sqrshrn2.8h	v0, v1, #2
sqrshrn.4h	v1, v2, #2
sqrshrn2.8h	v1, v3, #2
sqrshrn.4h	v2, v7, #2
sqrshrn2.8h	v2, v6, #2
sqrshrn.4h	v3, v5, #2
sqrshrn2.8h	v3, v4, #2
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v29
sqadd.4s	v0, v0, v29
sqsub.4s	v5, v1, v25
sqadd.4s	v1, v1, v25
sqsub.4s	v6, v2, v21
sqadd.4s	v2, v2, v21
sqsub.4s	v7, v3, v17
sqadd.4s	v3, v3, v17
sqrshrn.4h	v0, v0, #2
sqrshrn2.8h	v0, v1, #2
sqrshrn.4h	v1, v2, #2
sqrshrn2.8h	v1, v3, #2
sqrshrn.4h	v2, v7, #2
sqrshrn2.8h	v2, v6, #2
sqrshrn.4h	v3, v5, #2
sqrshrn2.8h	v3, v4, #2
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v28
sqadd.4s	v0, v0, v28
sqsub.4s	v5, v1, v24
sqadd.4s	v1, v1, v24
sqsub.4s	v6, v2, v20
sqadd.4s	v2, v2, v20
sqsub.4s	v7, v3, v16
sqadd.4s	v3, v3, v16
sqrshrn.4h	v0, v0, #2
sqrshrn2.8h	v0, v1, #2
sqrshrn.4h	v1, v2, #2
sqrshrn2.8h	v1, v3, #2
sqrshrn.4h	v2, v7, #2
sqrshrn2.8h	v2, v6, #2
sqrshrn.4h	v3, v5, #2
sqrshrn2.8h	v3, v4, #2
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ret	x14
_inv_txfm_horz_scale_dct_32x4_neon:
mov	x14, x30
movi.4s	v7, #0
lsl	x8, x8, #1
mov	w16, #1518338048
dup.2s	v0, w16
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v24 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v25 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v26 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v27 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v28 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v29 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v30 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v31 }, [x7]
st1.4s	{ v7 }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
sqrdmulh.4s	v24, v24, v0[0]
sqrdmulh.4s	v25, v25, v0[0]
sqrdmulh.4s	v26, v26, v0[0]
sqrdmulh.4s	v27, v27, v0[0]
sqrdmulh.4s	v28, v28, v0[0]
sqrdmulh.4s	v29, v29, v0[0]
sqrdmulh.4s	v30, v30, v0[0]
sqrdmulh.4s	v31, v31, v0[0]
bl	inv_dct_4s_x16_neon
smin.4s	v16, v16, v5
smin.4s	v17, v17, v5
smin.4s	v18, v18, v5
smin.4s	v19, v19, v5
smin.4s	v20, v20, v5
smin.4s	v21, v21, v5
smin.4s	v22, v22, v5
smin.4s	v23, v23, v5
smin.4s	v24, v24, v5
smin.4s	v25, v25, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v28, v28, v5
smin.4s	v29, v29, v5
smin.4s	v30, v30, v5
smin.4s	v31, v31, v5
smax.4s	v16, v16, v4
smax.4s	v17, v17, v4
smax.4s	v18, v18, v4
smax.4s	v19, v19, v4
smax.4s	v20, v20, v4
smax.4s	v21, v21, v4
smax.4s	v22, v22, v4
smax.4s	v23, v23, v4
smax.4s	v24, v24, v4
smax.4s	v25, v25, v4
smax.4s	v26, v26, v4
smax.4s	v27, v27, v4
smax.4s	v28, v28, v4
smax.4s	v29, v29, v4
smax.4s	v30, v30, v4
smax.4s	v31, v31, v4
trn1.4s	v2, v16, v17
trn2.4s	v3, v16, v17
trn1.4s	v4, v18, v19
trn2.4s	v5, v18, v19
trn1.2d	v16, v2, v4
trn2.2d	v18, v2, v4
trn1.2d	v17, v3, v5
trn2.2d	v19, v3, v5
trn1.4s	v2, v20, v21
trn2.4s	v3, v20, v21
trn1.4s	v4, v22, v23
trn2.4s	v5, v22, v23
trn1.2d	v20, v2, v4
trn2.2d	v22, v2, v4
trn1.2d	v21, v3, v5
trn2.2d	v23, v3, v5
trn1.4s	v2, v24, v25
trn2.4s	v3, v24, v25
trn1.4s	v4, v26, v27
trn2.4s	v5, v26, v27
trn1.2d	v24, v2, v4
trn2.2d	v26, v2, v4
trn1.2d	v25, v3, v5
trn2.2d	v27, v3, v5
trn1.4s	v2, v28, v29
trn2.4s	v3, v28, v29
trn1.4s	v4, v30, v31
trn2.4s	v5, v30, v31
trn1.2d	v28, v2, v4
trn2.2d	v30, v2, v4
trn1.2d	v29, v3, v5
trn2.2d	v31, v3, v5
st1.4s	{ v16 }, [x6], #16
st1.4s	{ v20 }, [x6], #16
st1.4s	{ v24 }, [x6], #16
st1.4s	{ v28 }, [x6], #16
st1.4s	{ v17 }, [x6], #16
st1.4s	{ v21 }, [x6], #16
st1.4s	{ v25 }, [x6], #16
st1.4s	{ v29 }, [x6], #16
st1.4s	{ v18 }, [x6], #16
st1.4s	{ v22 }, [x6], #16
st1.4s	{ v26 }, [x6], #16
st1.4s	{ v30 }, [x6], #16
st1.4s	{ v19 }, [x6], #16
st1.4s	{ v23 }, [x6], #16
st1.4s	{ v27 }, [x6], #16
st1.4s	{ v31 }, [x6], #16
sub	x6, x6, #256
movi.4s	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v24 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v25 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v26 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v27 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v28 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v29 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v30 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v31 }, [x7]
st1.4s	{ v7 }, [x7], x8
sqrdmulh.4s	v16, v16, v0[1]
sqrdmulh.4s	v17, v17, v0[1]
sqrdmulh.4s	v18, v18, v0[1]
sqrdmulh.4s	v19, v19, v0[1]
sqrdmulh.4s	v20, v20, v0[1]
sqrdmulh.4s	v21, v21, v0[1]
sqrdmulh.4s	v22, v22, v0[1]
sqrdmulh.4s	v23, v23, v0[1]
sqrdmulh.4s	v24, v24, v0[1]
sqrdmulh.4s	v25, v25, v0[1]
sqrdmulh.4s	v26, v26, v0[1]
sqrdmulh.4s	v27, v27, v0[1]
sqrdmulh.4s	v28, v28, v0[1]
sqrdmulh.4s	v29, v29, v0[1]
sqrdmulh.4s	v30, v30, v0[1]
sqrdmulh.4s	v31, v31, v0[1]
bl	inv_dct32_odd_4s_x16_neon
trn1.4s	v2, v31, v30
trn2.4s	v3, v31, v30
trn1.4s	v4, v29, v28
trn2.4s	v5, v29, v28
trn1.2d	v31, v2, v4
trn2.2d	v29, v2, v4
trn1.2d	v30, v3, v5
trn2.2d	v28, v3, v5
trn1.4s	v2, v27, v26
trn2.4s	v3, v27, v26
trn1.4s	v4, v25, v24
trn2.4s	v5, v25, v24
trn1.2d	v27, v2, v4
trn2.2d	v25, v2, v4
trn1.2d	v26, v3, v5
trn2.2d	v24, v3, v5
trn1.4s	v2, v23, v22
trn2.4s	v3, v23, v22
trn1.4s	v4, v21, v20
trn2.4s	v5, v21, v20
trn1.2d	v23, v2, v4
trn2.2d	v21, v2, v4
trn1.2d	v22, v3, v5
trn2.2d	v20, v3, v5
trn1.4s	v2, v19, v18
trn2.4s	v3, v19, v18
trn1.4s	v4, v17, v16
trn2.4s	v5, v17, v16
trn1.2d	v19, v2, v4
trn2.2d	v17, v2, v4
trn1.2d	v18, v3, v5
trn2.2d	v16, v3, v5
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v31
sqadd.4s	v0, v0, v31
sqsub.4s	v5, v1, v27
sqadd.4s	v1, v1, v27
sqsub.4s	v6, v2, v23
sqadd.4s	v2, v2, v23
sqsub.4s	v7, v3, v19
sqadd.4s	v3, v3, v19
sqrshrn.4h	v0, v0, #1
sqrshrn2.8h	v0, v1, #1
sqrshrn.4h	v1, v2, #1
sqrshrn2.8h	v1, v3, #1
sqrshrn.4h	v2, v7, #1
sqrshrn2.8h	v2, v6, #1
sqrshrn.4h	v3, v5, #1
sqrshrn2.8h	v3, v4, #1
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v30
sqadd.4s	v0, v0, v30
sqsub.4s	v5, v1, v26
sqadd.4s	v1, v1, v26
sqsub.4s	v6, v2, v22
sqadd.4s	v2, v2, v22
sqsub.4s	v7, v3, v18
sqadd.4s	v3, v3, v18
sqrshrn.4h	v0, v0, #1
sqrshrn2.8h	v0, v1, #1
sqrshrn.4h	v1, v2, #1
sqrshrn2.8h	v1, v3, #1
sqrshrn.4h	v2, v7, #1
sqrshrn2.8h	v2, v6, #1
sqrshrn.4h	v3, v5, #1
sqrshrn2.8h	v3, v4, #1
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v29
sqadd.4s	v0, v0, v29
sqsub.4s	v5, v1, v25
sqadd.4s	v1, v1, v25
sqsub.4s	v6, v2, v21
sqadd.4s	v2, v2, v21
sqsub.4s	v7, v3, v17
sqadd.4s	v3, v3, v17
sqrshrn.4h	v0, v0, #1
sqrshrn2.8h	v0, v1, #1
sqrshrn.4h	v1, v2, #1
sqrshrn2.8h	v1, v3, #1
sqrshrn.4h	v2, v7, #1
sqrshrn2.8h	v2, v6, #1
sqrshrn.4h	v3, v5, #1
sqrshrn2.8h	v3, v4, #1
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ld1.4s	{ v0, v1, v2, v3 }, [x6]
sqsub.4s	v4, v0, v28
sqadd.4s	v0, v0, v28
sqsub.4s	v5, v1, v24
sqadd.4s	v1, v1, v24
sqsub.4s	v6, v2, v20
sqadd.4s	v2, v2, v20
sqsub.4s	v7, v3, v16
sqadd.4s	v3, v3, v16
sqrshrn.4h	v0, v0, #1
sqrshrn2.8h	v0, v1, #1
sqrshrn.4h	v1, v2, #1
sqrshrn2.8h	v1, v3, #1
sqrshrn.4h	v2, v7, #1
sqrshrn2.8h	v2, v6, #1
sqrshrn.4h	v3, v5, #1
sqrshrn2.8h	v3, v4, #1
st1.8h	{ v0, v1 }, [x6], #32
rev64.8h	v2, v2
rev64.8h	v3, v3
st1.8h	{ v2, v3 }, [x6], #32
ret	x14
_inv_txfm_add_vert_dct_8x32_neon:
mov	x14, x30
lsl	x8, x8, #1
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
ld1.8h	{ v24 }, [x7], x8
ld1.8h	{ v25 }, [x7], x8
ld1.8h	{ v26 }, [x7], x8
ld1.8h	{ v27 }, [x7], x8
ld1.8h	{ v28 }, [x7], x8
ld1.8h	{ v29 }, [x7], x8
ld1.8h	{ v30 }, [x7], x8
ld1.8h	{ v31 }, [x7], x8
sub	x7, x7, x8, lsl #4
bl	inv_txfm_add_vert_dct_8x32_neon
st1.8h	{ v16 }, [x7], x8
st1.8h	{ v17 }, [x7], x8
st1.8h	{ v18 }, [x7], x8
st1.8h	{ v19 }, [x7], x8
st1.8h	{ v20 }, [x7], x8
st1.8h	{ v21 }, [x7], x8
st1.8h	{ v22 }, [x7], x8
st1.8h	{ v23 }, [x7], x8
st1.8h	{ v24 }, [x7], x8
st1.8h	{ v25 }, [x7], x8
st1.8h	{ v26 }, [x7], x8
st1.8h	{ v27 }, [x7], x8
st1.8h	{ v28 }, [x7], x8
st1.8h	{ v29 }, [x7], x8
st1.8h	{ v30 }, [x7], x8
st1.8h	{ v31 }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
ld1.8h	{ v24 }, [x7], x8
ld1.8h	{ v25 }, [x7], x8
ld1.8h	{ v26 }, [x7], x8
ld1.8h	{ v27 }, [x7], x8
ld1.8h	{ v28 }, [x7], x8
ld1.8h	{ v29 }, [x7], x8
ld1.8h	{ v30 }, [x7], x8
ld1.8h	{ v31 }, [x7], x8
sub	x7, x7, x8, lsl #4
sub	x7, x7, x8, lsr #1
bl	inv_txfm_add_vert_dct_8x32_neon
neg	x9, x8
mov	x10, x6
mvni.8h	v1, #252, lsl #8
ld1.8h	{ v5 }, [x7], x8
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8h	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v31
ld1.8h	{ v7 }, [x7], x8
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v30
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v29
ld1.8h	{ v5 }, [x7], x8
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v28
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x8
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8h	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v27
ld1.8h	{ v7 }, [x7], x8
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v26
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v25
ld1.8h	{ v5 }, [x7], x8
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v24
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x8
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8h	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v23
ld1.8h	{ v7 }, [x7], x8
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v22
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v21
ld1.8h	{ v5 }, [x7], x8
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v20
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x8
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8h	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v19
ld1.8h	{ v7 }, [x7], x8
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v18
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v17
ld1.8h	{ v5 }, [x7], x8
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v16
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
sub	x7, x7, x8
ld1.8h	{ v5 }, [x7], x9
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8h	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v16
ld1.8h	{ v7 }, [x7], x9
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v17
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v18
ld1.8h	{ v5 }, [x7], x9
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v19
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x9
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8h	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v20
ld1.8h	{ v7 }, [x7], x9
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v21
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v22
ld1.8h	{ v5 }, [x7], x9
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v23
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x9
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8h	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v24
ld1.8h	{ v7 }, [x7], x9
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v25
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v26
ld1.8h	{ v5 }, [x7], x9
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v27
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x9
ld1.8h	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8h	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v28
ld1.8h	{ v7 }, [x7], x9
ld1.8h	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v29
usqadd.8h	v2, v5
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v30
ld1.8h	{ v5 }, [x7], x9
usqadd.8h	v3, v6
smin.8h	v2, v2, v1
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v31
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v2 }, [x10], x1
usqadd.8h	v4, v7
smin.8h	v3, v3, v1
srshr.8h	v5, v5, #4
st1.8h	{ v3 }, [x6], x1
usqadd.8h	v2, v5
smin.8h	v4, v4, v1
st1.8h	{ v4 }, [x6], x1
smin.8h	v2, v2, v1
st1.8h	{ v2 }, [x6], x1
ret	x14
_inv_txfm_add_identity_identity_32x32_16bpc_neon:
movi.8h	v0, #0
movi.8h	v1, #0
adrp	x13, inv_txfm_add_identity_identity_32x32_16bpc_neon
add	x13, x13, #0
mov	x8, #128
mov	w9, #0
adrp	x12, inv_txfm_add_identity_identity_32x32_16bpc_neon
add	x12, x12, #0
add	w9, w9, #8
ld1.4s	{ v16, v17 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v18, v19 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v20, v21 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v22, v23 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v24, v25 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v26, v27 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v28, v29 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v30, v31 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
sqxtn.4h	v16, v16
sqxtn2.8h	v16, v17
sqxtn.4h	v17, v18
sqxtn2.8h	v17, v19
sqxtn.4h	v18, v20
sqxtn2.8h	v18, v21
sqxtn.4h	v19, v22
sqxtn2.8h	v19, v23
sqxtn.4h	v20, v24
sqxtn2.8h	v20, v25
sqxtn.4h	v21, v26
sqxtn2.8h	v21, v27
sqxtn.4h	v22, v28
sqxtn2.8h	v22, v29
sqxtn.4h	v23, v30
sqxtn2.8h	v23, v31
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #2
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #2
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #2
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #2
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #2
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #2
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #2
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #2
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
ldrh	w11, [x12], #4
sub	x0, x0, x1, lsl #3
add	x0, x0, #16
cmp	w3, w11
b.ge	inv_txfm_add_identity_identity_32x32_16bpc_neon
ldrh	w11, [x13], #4
cmp	w3, w11
b.lt	inv_txfm_add_identity_identity_32x32_16bpc_neon
sub	x0, x0, w9, uxtw #1
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #32
b	inv_txfm_add_identity_identity_32x32_16bpc_neon
ret
_inv_txfm_add_identity_identity_16x32_16bpc_neon:
mov	w16, #1518338048
mov	w17, #1779433472
movi.4s	v0, #0
movi.4s	v1, #0
adrp	x13, inv_txfm_add_identity_identity_16x32_16bpc_neon
add	x13, x13, #0
mov	x8, #128
mov	w9, #0
adrp	x12, inv_txfm_add_identity_identity_16x32_16bpc_neon
add	x12, x12, #0
add	w9, w9, #8
ld1.4s	{ v16, v17 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
dup.2s	v2, w16
ld1.4s	{ v18, v19 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
mov.s	v2[1], w17
ld1.4s	{ v20, v21 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v22, v23 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v24, v25 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v26, v27 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v28, v29 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v30, v31 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
sqrdmulh.4s	v16, v16, v2[0]
sqrdmulh.4s	v17, v17, v2[0]
sqrdmulh.4s	v18, v18, v2[0]
sqrdmulh.4s	v19, v19, v2[0]
sqrdmulh.4s	v20, v20, v2[0]
sqrdmulh.4s	v21, v21, v2[0]
sqrdmulh.4s	v22, v22, v2[0]
sqrdmulh.4s	v23, v23, v2[0]
sqrdmulh.4s	v24, v24, v2[0]
sqrdmulh.4s	v25, v25, v2[0]
sqrdmulh.4s	v26, v26, v2[0]
sqrdmulh.4s	v27, v27, v2[0]
sqrdmulh.4s	v28, v28, v2[0]
sqrdmulh.4s	v29, v29, v2[0]
sqrdmulh.4s	v30, v30, v2[0]
sqrdmulh.4s	v31, v31, v2[0]
sqrdmulh.4s	v3, v16, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v16, v16, v3
sqrdmulh.4s	v3, v17, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v17, v17, v3
sqrdmulh.4s	v3, v18, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v18, v18, v3
sqrdmulh.4s	v3, v19, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v19, v19, v3
sqrdmulh.4s	v3, v20, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v20, v20, v3
sqrdmulh.4s	v3, v21, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v21, v21, v3
sqrdmulh.4s	v3, v22, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v22, v22, v3
sqrdmulh.4s	v3, v23, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v23, v23, v3
sqrdmulh.4s	v3, v24, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v24, v24, v3
sqrdmulh.4s	v3, v25, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v25, v25, v3
sqrdmulh.4s	v3, v26, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v26, v26, v3
sqrdmulh.4s	v3, v27, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v27, v27, v3
sqrdmulh.4s	v3, v28, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v28, v28, v3
sqrdmulh.4s	v3, v29, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v29, v29, v3
sqrdmulh.4s	v3, v30, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v30, v30, v3
sqrdmulh.4s	v3, v31, v2[1]
srshr.4s	v3, v3, #1
sqadd.4s	v31, v31, v3
sqxtn.4h	v16, v16
sqxtn2.8h	v16, v17
sqxtn.4h	v17, v18
sqxtn2.8h	v17, v19
sqxtn.4h	v18, v20
sqxtn2.8h	v18, v21
sqxtn.4h	v19, v22
sqxtn2.8h	v19, v23
sqxtn.4h	v20, v24
sqxtn2.8h	v20, v25
sqxtn.4h	v21, v26
sqxtn2.8h	v21, v27
sqxtn.4h	v22, v28
sqxtn2.8h	v22, v29
sqxtn.4h	v23, v30
sqxtn2.8h	v23, v31
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #2
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #2
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #2
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #2
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #2
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #2
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #2
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #2
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
ldrh	w11, [x12], #4
sub	x0, x0, x1, lsl #3
add	x0, x0, #16
cmp	w3, w11
b.ge	inv_txfm_add_identity_identity_16x32_16bpc_neon
ldrh	w11, [x13], #4
cmp	w3, w11
b.lt	inv_txfm_add_identity_identity_16x32_16bpc_neon
sub	x0, x0, w9, uxtw #1
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #32
b	inv_txfm_add_identity_identity_16x32_16bpc_neon
ret
_inv_txfm_add_identity_identity_32x16_16bpc_neon:
mov	w16, #1518338048
mov	w17, #1779433472
movi.4s	v0, #0
movi.4s	v1, #0
adrp	x13, inv_txfm_add_identity_identity_32x16_16bpc_neon
add	x13, x13, #0
mov	x8, #64
mov	w9, #0
adrp	x12, inv_txfm_add_identity_identity_32x16_16bpc_neon
add	x12, x12, #0
add	w9, w9, #8
ld1.4s	{ v16, v17 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
dup.2s	v2, w16
ld1.4s	{ v18, v19 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
mov.s	v2[1], w17
ld1.4s	{ v20, v21 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v22, v23 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v24, v25 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v26, v27 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v28, v29 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v30, v31 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
sqrdmulh.4s	v16, v16, v2[0]
sqrdmulh.4s	v17, v17, v2[0]
sqrdmulh.4s	v18, v18, v2[0]
sqrdmulh.4s	v19, v19, v2[0]
sqrdmulh.4s	v20, v20, v2[0]
sqrdmulh.4s	v21, v21, v2[0]
sqrdmulh.4s	v22, v22, v2[0]
sqrdmulh.4s	v23, v23, v2[0]
sqrdmulh.4s	v24, v24, v2[0]
sqrdmulh.4s	v25, v25, v2[0]
sqrdmulh.4s	v26, v26, v2[0]
sqrdmulh.4s	v27, v27, v2[0]
sqrdmulh.4s	v28, v28, v2[0]
sqrdmulh.4s	v29, v29, v2[0]
sqrdmulh.4s	v30, v30, v2[0]
sqrdmulh.4s	v31, v31, v2[0]
sqshl.4s	v16, v16, #1
sqshl.4s	v17, v17, #1
sqshl.4s	v18, v18, #1
sqshl.4s	v19, v19, #1
sqshl.4s	v20, v20, #1
sqshl.4s	v21, v21, #1
sqshl.4s	v22, v22, #1
sqshl.4s	v23, v23, #1
sqshl.4s	v24, v24, #1
sqshl.4s	v25, v25, #1
sqshl.4s	v26, v26, #1
sqshl.4s	v27, v27, #1
sqshl.4s	v28, v28, #1
sqshl.4s	v29, v29, #1
sqshl.4s	v30, v30, #1
sqshl.4s	v31, v31, #1
sqrdmulh.4s	v3, v16, v2[1]
sqadd.4s	v16, v16, v16
sqadd.4s	v16, v16, v3
sqrdmulh.4s	v3, v17, v2[1]
sqadd.4s	v17, v17, v17
sqadd.4s	v17, v17, v3
sqrdmulh.4s	v3, v18, v2[1]
sqadd.4s	v18, v18, v18
sqadd.4s	v18, v18, v3
sqrdmulh.4s	v3, v19, v2[1]
sqadd.4s	v19, v19, v19
sqadd.4s	v19, v19, v3
sqrdmulh.4s	v3, v20, v2[1]
sqadd.4s	v20, v20, v20
sqadd.4s	v20, v20, v3
sqrdmulh.4s	v3, v21, v2[1]
sqadd.4s	v21, v21, v21
sqadd.4s	v21, v21, v3
sqrdmulh.4s	v3, v22, v2[1]
sqadd.4s	v22, v22, v22
sqadd.4s	v22, v22, v3
sqrdmulh.4s	v3, v23, v2[1]
sqadd.4s	v23, v23, v23
sqadd.4s	v23, v23, v3
sqrdmulh.4s	v3, v24, v2[1]
sqadd.4s	v24, v24, v24
sqadd.4s	v24, v24, v3
sqrdmulh.4s	v3, v25, v2[1]
sqadd.4s	v25, v25, v25
sqadd.4s	v25, v25, v3
sqrdmulh.4s	v3, v26, v2[1]
sqadd.4s	v26, v26, v26
sqadd.4s	v26, v26, v3
sqrdmulh.4s	v3, v27, v2[1]
sqadd.4s	v27, v27, v27
sqadd.4s	v27, v27, v3
sqrdmulh.4s	v3, v28, v2[1]
sqadd.4s	v28, v28, v28
sqadd.4s	v28, v28, v3
sqrdmulh.4s	v3, v29, v2[1]
sqadd.4s	v29, v29, v29
sqadd.4s	v29, v29, v3
sqrdmulh.4s	v3, v30, v2[1]
sqadd.4s	v30, v30, v30
sqadd.4s	v30, v30, v3
sqrdmulh.4s	v3, v31, v2[1]
sqadd.4s	v31, v31, v31
sqadd.4s	v31, v31, v3
sqxtn.4h	v16, v16
sqxtn2.8h	v16, v17
sqxtn.4h	v17, v18
sqxtn2.8h	v17, v19
sqxtn.4h	v18, v20
sqxtn2.8h	v18, v21
sqxtn.4h	v19, v22
sqxtn2.8h	v19, v23
sqxtn.4h	v20, v24
sqxtn2.8h	v20, v25
sqxtn.4h	v21, v26
sqxtn2.8h	v21, v27
sqxtn.4h	v22, v28
sqxtn2.8h	v22, v29
sqxtn.4h	v23, v30
sqxtn2.8h	v23, v31
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
ldrh	w11, [x12], #4
sub	x0, x0, x1, lsl #3
add	x0, x0, #16
cmp	w3, w11
b.ge	inv_txfm_add_identity_identity_32x16_16bpc_neon
ldrh	w11, [x13], #4
cmp	w3, w11
b.lt	inv_txfm_add_identity_identity_32x16_16bpc_neon
sub	x0, x0, w9, uxtw #1
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #32
b	inv_txfm_add_identity_identity_32x16_16bpc_neon
ret
_inv_txfm_add_identity_identity_8x32_16bpc_neon:
movi.4s	v0, #0
movi.4s	v1, #0
adrp	x13, inv_txfm_add_identity_identity_8x32_16bpc_neon
add	x13, x13, #0
mov	w8, #128
ldrh	w12, [x13], #4
ld1.4s	{ v16, v17 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v18, v19 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v20, v21 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v22, v23 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v24, v25 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v26, v27 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v28, v29 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v30, v31 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
sqrshrn.4h	v16, v16, #1
sqrshrn2.8h	v16, v17, #1
sqrshrn.4h	v17, v18, #1
sqrshrn2.8h	v17, v19, #1
sqrshrn.4h	v18, v20, #1
sqrshrn2.8h	v18, v21, #1
sqrshrn.4h	v19, v22, #1
sqrshrn2.8h	v19, v23, #1
sqrshrn.4h	v20, v24, #1
sqrshrn2.8h	v20, v25, #1
sqrshrn.4h	v21, v26, #1
sqrshrn2.8h	v21, v27, #1
sqrshrn.4h	v22, v28, #1
sqrshrn2.8h	v22, v29, #1
sqrshrn.4h	v23, v30, #1
sqrshrn2.8h	v23, v31, #1
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
cmp	w3, w12
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #2
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #2
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #2
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #2
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #2
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #2
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #2
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #2
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
b.lt	inv_txfm_add_identity_identity_8x32_16bpc_neon
sub	x2, x2, x8, lsl #3
add	x2, x2, #32
b	inv_txfm_add_identity_identity_8x32_16bpc_neon
ret
_inv_txfm_add_identity_identity_32x8_16bpc_neon:
movi.4s	v0, #0
movi.4s	v1, #0
adrp	x13, inv_txfm_add_identity_identity_32x8_16bpc_neon
add	x13, x13, #0
mov	w8, #32
ldrh	w12, [x13], #4
ld1.4s	{ v16, v17 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v18, v19 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v20, v21 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v22, v23 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v24, v25 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v26, v27 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v28, v29 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
ld1.4s	{ v30, v31 }, [x2]
st1.4s	{ v0, v1 }, [x2], x8
sqxtn.4h	v16, v16
sqxtn2.8h	v16, v17
sqxtn.4h	v17, v18
sqxtn2.8h	v17, v19
sqxtn.4h	v18, v20
sqxtn2.8h	v18, v21
sqxtn.4h	v19, v22
sqxtn2.8h	v19, v23
sqxtn.4h	v20, v24
sqxtn2.8h	v20, v25
sqxtn.4h	v21, v26
sqxtn2.8h	v21, v27
sqxtn.4h	v22, v28
sqxtn2.8h	v22, v29
sqxtn.4h	v23, v30
sqxtn2.8h	v23, v31
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
cmp	w3, w12
mov	x7, x0
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #3
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #3
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #3
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #3
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #3
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x0], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #3
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x0], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #3
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x0], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #3
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x0], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x0], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x0], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x0], x1
st1.8h	{ v19 }, [x0], x1
b.lt	inv_txfm_add_identity_identity_32x8_16bpc_neon
sub	x0, x0, x1, lsl #3
add	x0, x0, #16
b	inv_txfm_add_identity_identity_32x8_16bpc_neon
ret
_inv_txfm_add_dct_dct_32x32_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x32_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #2048
adrp	x13, inv_txfm_add_dct_dct_32x32_16bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
mov	x6, sp
add	x7, x2, #0
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #256
mov	w8, #28
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #512
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #768
mov	w8, #20
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #48
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #1024
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #64
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #1280
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #80
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #1536
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #96
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #1792
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_16bpc_neon
add	x7, x2, #112
mov	x8, #128
bl	inv_txfm_horz_dct_32x4_neon
b	inv_txfm_add_dct_dct_32x32_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_32x32_16bpc_neon
add	x6, x0, #0
mov	x7, sp
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #16
add	x7, sp, #16
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #32
add	x7, sp, #32
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #48
add	x7, sp, #48
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #2048
ret	x15
_inv_txfm_add_dct_dct_16x32_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x32_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w16_neon
mov	x15, x30
sub	sp, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_16x32_16bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
adr	x4, #-17896
mov	x6, sp
add	x7, x2, #0
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #128
add	x7, x2, #16
mov	w8, #28
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #256
add	x7, x2, #32
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #384
add	x7, x2, #48
mov	w8, #20
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #512
add	x7, x2, #64
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #640
add	x7, x2, #80
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #768
add	x7, x2, #96
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
add	x6, sp, #896
add	x7, x2, #112
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_16bpc_neon
mov	x8, #128
bl	inv_txfm_horz_scale_16x4_neon
b	inv_txfm_add_dct_dct_16x32_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_16x32_16bpc_neon
add	x6, x0, #0
mov	x7, sp
mov	x8, #32
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #16
add	x7, sp, #16
mov	x8, #32
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #1024
ret	x15
_inv_txfm_add_dct_dct_32x16_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x16_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_32x16_16bpc_neon
add	x13, x13, #0
adrp	x5, inv_txfm_add_dct_dct_32x16_16bpc_neon
add	x5, x5, #0
ldrh	w12, [x13], #2
mov	x6, sp
add	x7, x2, #0
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, sp, #256
add	x7, x2, #16
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x16_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, sp, #512
add	x7, x2, #32
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x16_16bpc_neon
ldrh	w12, [x13], #2
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, sp, #768
add	x7, x2, #48
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x16_16bpc_neon
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x4_neon
b	inv_txfm_add_dct_dct_32x16_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_32x16_16bpc_neon
add	x6, x0, #0
mov	x7, sp
mov	x8, #64
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #16
add	x7, sp, #16
mov	x8, #64
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #32
add	x7, sp, #32
mov	x8, #64
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #48
add	x7, sp, #48
mov	x8, #64
bl	inv_txfm_add_vert_8x16_neon
add	sp, sp, #1024
ret	x15
_inv_txfm_add_dct_dct_8x32_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_8x32_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w8_neon
mov	x15, x30
sub	sp, sp, #512
adrp	x13, inv_txfm_add_dct_dct_8x32_16bpc_neon
add	x13, x13, #0
movi.4s	v28, #0
mov	x8, #128
mov	w9, #32
mov	x6, sp
mov	x7, x2
ld1.4s	{ v16 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v28 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v28 }, [x7], x8
ldrh	w12, [x13], #2
sub	w9, w9, #4
sub	x7, x7, x8, lsl #3
add	x7, x7, #16
bl	inv_dct_4s_x8_neon
sqrshrn.4h	v16, v16, #2
sqrshrn.4h	v17, v17, #2
sqrshrn.4h	v18, v18, #2
sqrshrn.4h	v19, v19, #2
sqrshrn2.8h	v16, v20, #2
sqrshrn2.8h	v17, v21, #2
sqrshrn2.8h	v18, v22, #2
sqrshrn2.8h	v19, v23, #2
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v4, v18, v19
trn2.8h	v5, v18, v19
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
cmp	w3, w12
st1.8h	{ v16, v17, v18, v19 }, [x6], #64
b.ge	inv_txfm_add_dct_dct_8x32_16bpc_neon
cbz	w9, inv_txfm_add_dct_dct_8x32_16bpc_neon
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
subs	w9, w9, #4
st1.8h	{ v28, v29, v30, v31 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_8x32_16bpc_neon
mov	x6, x0
mov	x7, sp
mov	x8, #16
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #512
ret	x15
_inv_txfm_add_dct_dct_32x8_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x8_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #8
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #512
mov	x6, sp
add	x7, x2, #0
mov	x8, #32
bl	inv_txfm_horz_dct_32x4_neon
add	x6, sp, #256
add	x7, x2, #16
cmp	w3, #10
b.lt	inv_txfm_add_dct_dct_32x8_16bpc_neon
mov	x8, #32
bl	inv_txfm_horz_dct_32x4_neon
b	inv_txfm_add_dct_dct_32x8_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
mov	x8, #64
mov	w9, #0
add	x6, x0, x9, lsl #1
add	x7, sp, x9, lsl #1
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
add	w9, w9, #8
bl	inv_txfm_add_dct_dct_32x8_16bpc_neon
cmp	w9, #32
mov	x7, x6
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8h	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8h	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
usqadd.8h	v2, v16
ld1.8h	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
usqadd.8h	v3, v17
smin.8h	v2, v2, v7
ld1.8h	{ v16 }, [x7], x1
srshr.8h	v20, v20, #4
usqadd.8h	v4, v18
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
ld1.8h	{ v17 }, [x7], x1
srshr.8h	v21, v21, #4
usqadd.8h	v5, v19
smin.8h	v4, v4, v7
st1.8h	{ v3 }, [x6], x1
ld1.8h	{ v18 }, [x7], x1
srshr.8h	v22, v22, #4
usqadd.8h	v16, v20
smin.8h	v5, v5, v7
st1.8h	{ v4 }, [x6], x1
ld1.8h	{ v19 }, [x7], x1
srshr.8h	v23, v23, #4
usqadd.8h	v17, v21
smin.8h	v16, v16, v7
st1.8h	{ v5 }, [x6], x1
usqadd.8h	v18, v22
smin.8h	v17, v17, v7
st1.8h	{ v16 }, [x6], x1
usqadd.8h	v19, v23
smin.8h	v18, v18, v7
st1.8h	{ v17 }, [x6], x1
smin.8h	v19, v19, v7
st1.8h	{ v18 }, [x6], x1
st1.8h	{ v19 }, [x6], x1
b.lt	inv_txfm_add_dct_dct_32x8_16bpc_neon
add	sp, sp, #512
ret	x15
_inv_dct64_step1_neon:
ld1.4s	{ v0, v1 }, [x17], #32
sqrdmulh.4s	v23, v16, v0[1]
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v22, v17, v0[2]
sqrdmulh.4s	v17, v17, v0[3]
sqrdmulh.4s	v21, v18, v1[1]
sqrdmulh.4s	v18, v18, v1[0]
sqrdmulh.4s	v20, v19, v1[2]
sqrdmulh.4s	v19, v19, v1[3]
ld1.4s	{ v0 }, [x17], #16
sqadd.4s	v24, v16, v17
sqsub.4s	v25, v16, v17
sqsub.4s	v26, v19, v18
sqadd.4s	v27, v19, v18
sqadd.4s	v28, v20, v21
sqsub.4s	v29, v20, v21
sqsub.4s	v30, v23, v22
sqadd.4s	v31, v23, v22
smin.4s	v24, v24, v5
smin.4s	v25, v25, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v28, v28, v5
smin.4s	v29, v29, v5
smin.4s	v30, v30, v5
smin.4s	v31, v31, v5
smax.4s	v24, v24, v4
smax.4s	v25, v25, v4
smax.4s	v26, v26, v4
smax.4s	v27, v27, v4
smax.4s	v28, v28, v4
smax.4s	v29, v29, v4
smax.4s	v30, v30, v4
smax.4s	v31, v31, v4
mul.4s	v2, v29, v0[0]
mla.4s	v2, v26, v0[1]
mul.4s	v7, v29, v0[1]
mls.4s	v7, v26, v0[0]
neg.4s	v2, v2
mul.4s	v6, v30, v0[1]
mls.4s	v6, v25, v0[0]
srshr.4s	v26, v2, #12
mul.4s	v2, v30, v0[0]
mla.4s	v2, v25, v0[1]
srshr.4s	v29, v7, #12
srshr.4s	v25, v6, #12
srshr.4s	v30, v2, #12
sqadd.4s	v16, v24, v27
sqsub.4s	v19, v24, v27
sqadd.4s	v17, v25, v26
sqsub.4s	v18, v25, v26
sqsub.4s	v20, v31, v28
sqadd.4s	v23, v31, v28
sqsub.4s	v21, v30, v29
sqadd.4s	v22, v30, v29
smin.4s	v16, v16, v5
smin.4s	v19, v19, v5
smin.4s	v17, v17, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v23, v23, v5
smin.4s	v21, v21, v5
smin.4s	v22, v22, v5
smax.4s	v16, v16, v4
smax.4s	v19, v19, v4
smax.4s	v17, v17, v4
smax.4s	v18, v18, v4
smax.4s	v20, v20, v4
smax.4s	v23, v23, v4
smax.4s	v21, v21, v4
smax.4s	v22, v22, v4
mul.4s	v2, v21, v0[2]
mla.4s	v2, v18, v0[3]
mul.4s	v7, v21, v0[3]
mls.4s	v7, v18, v0[2]
mul.4s	v6, v20, v0[2]
mla.4s	v6, v19, v0[3]
srshr.4s	v21, v2, #12
srshr.4s	v18, v7, #12
mul.4s	v2, v20, v0[3]
mls.4s	v2, v19, v0[2]
srshr.4s	v20, v6, #12
srshr.4s	v19, v2, #12
st1.4s	{ v16, v17, v18, v19 }, [x6], #64
st1.4s	{ v20, v21, v22, v23 }, [x6], #64
ret
_inv_dct64_step2_neon:
adrp	x16, inv_dct64_step2_neon
add	x16, x16, #0
ld1.4s	{ v0 }, [x16]
ldr	q16, [x6]
ldr	q17, [x9, #128]
ldr	q18, [x9]
ldr	q19, [x6, #128]
ldr	q20, [x6, #256]
ldr	q21, [x9, #384]
ldr	q22, [x9, #256]
ldr	q23, [x6, #384]
sqadd.4s	v24, v16, v17
sqsub.4s	v25, v16, v17
sqadd.4s	v26, v18, v19
sqsub.4s	v27, v18, v19
sqsub.4s	v28, v21, v20
sqadd.4s	v29, v21, v20
sqadd.4s	v30, v23, v22
sqsub.4s	v31, v23, v22
smin.4s	v24, v24, v5
smin.4s	v25, v25, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v28, v28, v5
smin.4s	v29, v29, v5
smin.4s	v30, v30, v5
smin.4s	v31, v31, v5
smax.4s	v24, v24, v4
smax.4s	v25, v25, v4
smax.4s	v26, v26, v4
smax.4s	v27, v27, v4
smax.4s	v28, v28, v4
smax.4s	v29, v29, v4
smax.4s	v30, v30, v4
smax.4s	v31, v31, v4
mul.4s	v2, v27, v0[3]
mla.4s	v2, v25, v0[2]
mul.4s	v7, v27, v0[2]
mls.4s	v7, v25, v0[3]
mul.4s	v6, v31, v0[3]
mla.4s	v6, v28, v0[2]
srshr.4s	v25, v2, #12
srshr.4s	v27, v7, #12
neg.4s	v6, v6
mul.4s	v2, v31, v0[2]
mls.4s	v2, v28, v0[3]
srshr.4s	v31, v6, #12
srshr.4s	v28, v2, #12
sqadd.4s	v16, v24, v29
sqsub.4s	v19, v24, v29
sqadd.4s	v17, v27, v31
sqsub.4s	v18, v27, v31
sqsub.4s	v20, v26, v30
sqadd.4s	v23, v26, v30
sqsub.4s	v21, v25, v28
sqadd.4s	v22, v25, v28
smin.4s	v16, v16, v5
smin.4s	v19, v19, v5
smin.4s	v17, v17, v5
smin.4s	v18, v18, v5
smin.4s	v20, v20, v5
smin.4s	v23, v23, v5
smin.4s	v21, v21, v5
smin.4s	v22, v22, v5
smax.4s	v16, v16, v4
smax.4s	v19, v19, v4
smax.4s	v17, v17, v4
smax.4s	v18, v18, v4
smax.4s	v20, v20, v4
smax.4s	v23, v23, v4
smax.4s	v21, v21, v4
smax.4s	v22, v22, v4
mul.4s	v2, v21, v0[0]
mls.4s	v2, v18, v0[0]
mul.4s	v7, v21, v0[0]
mla.4s	v7, v18, v0[0]
mul.4s	v6, v20, v0[0]
mls.4s	v6, v19, v0[0]
srshr.4s	v18, v2, #12
srshr.4s	v21, v7, #12
mul.4s	v2, v20, v0[0]
mla.4s	v2, v19, v0[0]
srshr.4s	v19, v6, #12
srshr.4s	v20, v2, #12
str	q16, [x6]
str	q17, [x9]
str	q18, [x6, #128]
str	q19, [x9, #128]
str	q20, [x6, #256]
str	q21, [x9, #256]
str	q22, [x6, #384]
str	q23, [x9, #384]
add	x6, x6, #16
sub	x9, x9, #16
cmp	x6, x9
b.lt	inv_dct64_step2_neon
ret
_inv_txfm_dct_clear_4s_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
movi.4s	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
movi.4s	v28, #0
movi.4s	v29, #0
movi.4s	v30, #0
movi.4s	v31, #0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
bl	inv_dct_4s_x16_neon
smin.4s	v16, v16, v5
smin.4s	v17, v17, v5
smin.4s	v18, v18, v5
smin.4s	v19, v19, v5
smin.4s	v20, v20, v5
smin.4s	v21, v21, v5
smin.4s	v22, v22, v5
smin.4s	v23, v23, v5
smin.4s	v24, v24, v5
smin.4s	v25, v25, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v28, v28, v5
smin.4s	v29, v29, v5
smin.4s	v30, v30, v5
smin.4s	v31, v31, v5
smax.4s	v16, v16, v4
smax.4s	v17, v17, v4
smax.4s	v18, v18, v4
smax.4s	v19, v19, v4
smax.4s	v20, v20, v4
smax.4s	v21, v21, v4
smax.4s	v22, v22, v4
smax.4s	v23, v23, v4
smax.4s	v24, v24, v4
smax.4s	v25, v25, v4
smax.4s	v26, v26, v4
smax.4s	v27, v27, v4
smax.4s	v28, v28, v4
smax.4s	v29, v29, v4
smax.4s	v30, v30, v4
smax.4s	v31, v31, v4
st1.4s	{ v16 }, [x6], #16
st1.4s	{ v17 }, [x6], #16
st1.4s	{ v18 }, [x6], #16
st1.4s	{ v19 }, [x6], #16
st1.4s	{ v20 }, [x6], #16
st1.4s	{ v21 }, [x6], #16
st1.4s	{ v22 }, [x6], #16
st1.4s	{ v23 }, [x6], #16
st1.4s	{ v24 }, [x6], #16
st1.4s	{ v25 }, [x6], #16
st1.4s	{ v26 }, [x6], #16
st1.4s	{ v27 }, [x6], #16
st1.4s	{ v28 }, [x6], #16
st1.4s	{ v29 }, [x6], #16
st1.4s	{ v30 }, [x6], #16
st1.4s	{ v31 }, [x6], #16
movi.8h	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
movi.4s	v28, #0
movi.4s	v29, #0
movi.4s	v30, #0
movi.4s	v31, #0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_4s_x16_neon
add	x10, x6, #240
sub	x6, x6, #256
mov	x9, #-16
movi.4s	v1, #1, msl #16
mvni.4s	v0, #1, msl #16
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v31
sqsub.4s	v31, v2, v31
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v30
sqsub.4s	v30, v3, v30
smin.4s	v6, v6, v1
smin.4s	v31, v31, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v29
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v31, v31, v0
sqsub.4s	v29, v4, v29
smin.4s	v7, v7, v1
smin.4s	v30, v30, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v31 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v29, v29, v1
smax.4s	v7, v7, v0
smax.4s	v30, v30, v0
sqadd.4s	v3, v5, v28
sqsub.4s	v28, v5, v28
smax.4s	v2, v2, v0
smax.4s	v29, v29, v0
smin.4s	v3, v3, v1
smin.4s	v28, v28, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v30 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v28, v28, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v29 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v28 }, [x10], x9
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v27
sqsub.4s	v27, v2, v27
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v26
sqsub.4s	v26, v3, v26
smin.4s	v6, v6, v1
smin.4s	v27, v27, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v25
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v27, v27, v0
sqsub.4s	v25, v4, v25
smin.4s	v7, v7, v1
smin.4s	v26, v26, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v27 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v25, v25, v1
smax.4s	v7, v7, v0
smax.4s	v26, v26, v0
sqadd.4s	v3, v5, v24
sqsub.4s	v24, v5, v24
smax.4s	v2, v2, v0
smax.4s	v25, v25, v0
smin.4s	v3, v3, v1
smin.4s	v24, v24, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v26 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v24, v24, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v25 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v24 }, [x10], x9
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v23
sqsub.4s	v23, v2, v23
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v22
sqsub.4s	v22, v3, v22
smin.4s	v6, v6, v1
smin.4s	v23, v23, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v21
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v23, v23, v0
sqsub.4s	v21, v4, v21
smin.4s	v7, v7, v1
smin.4s	v22, v22, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v23 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v21, v21, v1
smax.4s	v7, v7, v0
smax.4s	v22, v22, v0
sqadd.4s	v3, v5, v20
sqsub.4s	v20, v5, v20
smax.4s	v2, v2, v0
smax.4s	v21, v21, v0
smin.4s	v3, v3, v1
smin.4s	v20, v20, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v22 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v20, v20, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v21 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v20 }, [x10], x9
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v19
sqsub.4s	v19, v2, v19
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v18
sqsub.4s	v18, v3, v18
smin.4s	v6, v6, v1
smin.4s	v19, v19, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v17
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v19, v19, v0
sqsub.4s	v17, v4, v17
smin.4s	v7, v7, v1
smin.4s	v18, v18, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v19 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v17, v17, v1
smax.4s	v7, v7, v0
smax.4s	v18, v18, v0
sqadd.4s	v3, v5, v16
sqsub.4s	v16, v5, v16
smax.4s	v2, v2, v0
smax.4s	v17, v17, v0
smin.4s	v3, v3, v1
smin.4s	v16, v16, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v18 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v16, v16, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v17 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v16 }, [x10], x9
add	x6, x6, #256
adrp	x17, inv_txfm_dct_clear_4s_x64_neon
add	x17, x17, #0
movi.4s	v5, #1, msl #16
mvni.4s	v4, #1, msl #16
movi.4s	v7, #0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1.4s	{ v16 }, [x7]
ld1.4s	{ v17 }, [x9]
ld1.4s	{ v18 }, [x10]
ld1.4s	{ v19 }, [x11]
st1.4s	{ v7 }, [x7]
st1.4s	{ v7 }, [x9]
st1.4s	{ v7 }, [x10]
st1.4s	{ v7 }, [x11]
bl	inv_dct64_step1_neon
movi.4s	v7, #0
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1.4s	{ v16 }, [x10]
ld1.4s	{ v17 }, [x11]
ld1.4s	{ v18 }, [x9]
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7]
st1.4s	{ v7 }, [x9]
st1.4s	{ v7 }, [x10]
st1.4s	{ v7 }, [x11]
bl	inv_dct64_step1_neon
movi.4s	v7, #0
sub	x10, x10, x8, lsl #1
sub	x9, x9, x8, lsl #1
add	x7, x7, x8
add	x11, x11, x8
ldr	q16, [x10, x8]
ldr	q17, [x11]
ldr	q18, [x9, x8]
ldr	q19, [x7]
str	q7, [x10, x8]
str	q7, [x11]
str	q7, [x9, x8]
str	q7, [x7]
bl	inv_dct64_step1_neon
movi.4s	v7, #0
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
str	q7, [x10]
str	q7, [x11, x8]
str	q7, [x9]
str	q7, [x7, x8]
bl	inv_dct64_step1_neon
sub	x6, x6, #512
add	x9, x6, #112
bl	inv_dct64_step2_neon
ret	x14
_inv_txfm_dct_clear_scale_4s_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
mov	w16, #1518338048
dup.2s	v0, w16
movi.4s	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
movi.4s	v28, #0
movi.4s	v29, #0
movi.4s	v30, #0
movi.4s	v31, #0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
bl	inv_dct_4s_x16_neon
smin.4s	v16, v16, v5
smin.4s	v17, v17, v5
smin.4s	v18, v18, v5
smin.4s	v19, v19, v5
smin.4s	v20, v20, v5
smin.4s	v21, v21, v5
smin.4s	v22, v22, v5
smin.4s	v23, v23, v5
smin.4s	v24, v24, v5
smin.4s	v25, v25, v5
smin.4s	v26, v26, v5
smin.4s	v27, v27, v5
smin.4s	v28, v28, v5
smin.4s	v29, v29, v5
smin.4s	v30, v30, v5
smin.4s	v31, v31, v5
smax.4s	v16, v16, v4
smax.4s	v17, v17, v4
smax.4s	v18, v18, v4
smax.4s	v19, v19, v4
smax.4s	v20, v20, v4
smax.4s	v21, v21, v4
smax.4s	v22, v22, v4
smax.4s	v23, v23, v4
smax.4s	v24, v24, v4
smax.4s	v25, v25, v4
smax.4s	v26, v26, v4
smax.4s	v27, v27, v4
smax.4s	v28, v28, v4
smax.4s	v29, v29, v4
smax.4s	v30, v30, v4
smax.4s	v31, v31, v4
st1.4s	{ v16 }, [x6], #16
st1.4s	{ v17 }, [x6], #16
st1.4s	{ v18 }, [x6], #16
st1.4s	{ v19 }, [x6], #16
st1.4s	{ v20 }, [x6], #16
st1.4s	{ v21 }, [x6], #16
st1.4s	{ v22 }, [x6], #16
st1.4s	{ v23 }, [x6], #16
st1.4s	{ v24 }, [x6], #16
st1.4s	{ v25 }, [x6], #16
st1.4s	{ v26 }, [x6], #16
st1.4s	{ v27 }, [x6], #16
st1.4s	{ v28 }, [x6], #16
st1.4s	{ v29 }, [x6], #16
st1.4s	{ v30 }, [x6], #16
st1.4s	{ v31 }, [x6], #16
mov	w16, #1518338048
dup.2s	v0, w16
movi.8h	v7, #0
ld1.4s	{ v16 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v17 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v18 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v20 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v21 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v22 }, [x7]
st1.4s	{ v7 }, [x7], x8
ld1.4s	{ v23 }, [x7]
st1.4s	{ v7 }, [x7], x8
movi.4s	v24, #0
movi.4s	v25, #0
movi.4s	v26, #0
movi.4s	v27, #0
movi.4s	v28, #0
movi.4s	v29, #0
movi.4s	v30, #0
movi.4s	v31, #0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
sqrdmulh.4s	v20, v20, v0[0]
sqrdmulh.4s	v21, v21, v0[0]
sqrdmulh.4s	v22, v22, v0[0]
sqrdmulh.4s	v23, v23, v0[0]
bl	inv_dct32_odd_4s_x16_neon
add	x10, x6, #240
sub	x6, x6, #256
mov	x9, #-16
movi.4s	v1, #1, msl #16
mvni.4s	v0, #1, msl #16
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v31
sqsub.4s	v31, v2, v31
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v30
sqsub.4s	v30, v3, v30
smin.4s	v6, v6, v1
smin.4s	v31, v31, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v29
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v31, v31, v0
sqsub.4s	v29, v4, v29
smin.4s	v7, v7, v1
smin.4s	v30, v30, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v31 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v29, v29, v1
smax.4s	v7, v7, v0
smax.4s	v30, v30, v0
sqadd.4s	v3, v5, v28
sqsub.4s	v28, v5, v28
smax.4s	v2, v2, v0
smax.4s	v29, v29, v0
smin.4s	v3, v3, v1
smin.4s	v28, v28, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v30 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v28, v28, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v29 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v28 }, [x10], x9
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v27
sqsub.4s	v27, v2, v27
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v26
sqsub.4s	v26, v3, v26
smin.4s	v6, v6, v1
smin.4s	v27, v27, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v25
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v27, v27, v0
sqsub.4s	v25, v4, v25
smin.4s	v7, v7, v1
smin.4s	v26, v26, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v27 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v25, v25, v1
smax.4s	v7, v7, v0
smax.4s	v26, v26, v0
sqadd.4s	v3, v5, v24
sqsub.4s	v24, v5, v24
smax.4s	v2, v2, v0
smax.4s	v25, v25, v0
smin.4s	v3, v3, v1
smin.4s	v24, v24, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v26 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v24, v24, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v25 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v24 }, [x10], x9
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v23
sqsub.4s	v23, v2, v23
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v22
sqsub.4s	v22, v3, v22
smin.4s	v6, v6, v1
smin.4s	v23, v23, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v21
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v23, v23, v0
sqsub.4s	v21, v4, v21
smin.4s	v7, v7, v1
smin.4s	v22, v22, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v23 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v21, v21, v1
smax.4s	v7, v7, v0
smax.4s	v22, v22, v0
sqadd.4s	v3, v5, v20
sqsub.4s	v20, v5, v20
smax.4s	v2, v2, v0
smax.4s	v21, v21, v0
smin.4s	v3, v3, v1
smin.4s	v20, v20, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v22 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v20, v20, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v21 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v20 }, [x10], x9
ld1.4s	{ v2 }, [x6], #16
ld1.4s	{ v3 }, [x6], #16
sqadd.4s	v6, v2, v19
sqsub.4s	v19, v2, v19
ld1.4s	{ v4 }, [x6], #16
sqadd.4s	v7, v3, v18
sqsub.4s	v18, v3, v18
smin.4s	v6, v6, v1
smin.4s	v19, v19, v1
ld1.4s	{ v5 }, [x6], #16
sqadd.4s	v2, v4, v17
sub	x6, x6, #64
smax.4s	v6, v6, v0
smax.4s	v19, v19, v0
sqsub.4s	v17, v4, v17
smin.4s	v7, v7, v1
smin.4s	v18, v18, v1
st1.4s	{ v6 }, [x6], #16
st1.4s	{ v19 }, [x10], x9
smin.4s	v2, v2, v1
smin.4s	v17, v17, v1
smax.4s	v7, v7, v0
smax.4s	v18, v18, v0
sqadd.4s	v3, v5, v16
sqsub.4s	v16, v5, v16
smax.4s	v2, v2, v0
smax.4s	v17, v17, v0
smin.4s	v3, v3, v1
smin.4s	v16, v16, v1
st1.4s	{ v7 }, [x6], #16
st1.4s	{ v18 }, [x10], x9
smax.4s	v3, v3, v0
smax.4s	v16, v16, v0
st1.4s	{ v2 }, [x6], #16
st1.4s	{ v17 }, [x10], x9
st1.4s	{ v3 }, [x6], #16
st1.4s	{ v16 }, [x10], x9
add	x6, x6, #256
adrp	x17, inv_txfm_dct_clear_scale_4s_x64_neon
add	x17, x17, #0
movi.4s	v5, #1, msl #16
mvni.4s	v4, #1, msl #16
mov	w16, #1518338048
dup.2s	v0, w16
movi.4s	v7, #0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1.4s	{ v16 }, [x7]
ld1.4s	{ v17 }, [x9]
ld1.4s	{ v18 }, [x10]
ld1.4s	{ v19 }, [x11]
st1.4s	{ v7 }, [x7]
st1.4s	{ v7 }, [x9]
st1.4s	{ v7 }, [x10]
st1.4s	{ v7 }, [x11]
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
bl	inv_dct64_step1_neon
mov	w16, #1518338048
dup.2s	v0, w16
movi.4s	v7, #0
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1.4s	{ v16 }, [x10]
ld1.4s	{ v17 }, [x11]
ld1.4s	{ v18 }, [x9]
ld1.4s	{ v19 }, [x7]
st1.4s	{ v7 }, [x7]
st1.4s	{ v7 }, [x9]
st1.4s	{ v7 }, [x10]
st1.4s	{ v7 }, [x11]
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
bl	inv_dct64_step1_neon
mov	w16, #1518338048
dup.2s	v0, w16
movi.4s	v7, #0
sub	x10, x10, x8, lsl #1
sub	x9, x9, x8, lsl #1
add	x7, x7, x8
add	x11, x11, x8
ldr	q16, [x10, x8]
ldr	q17, [x11]
ldr	q18, [x9, x8]
ldr	q19, [x7]
str	q7, [x10, x8]
str	q7, [x11]
str	q7, [x9, x8]
str	q7, [x7]
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
bl	inv_dct64_step1_neon
mov	w16, #1518338048
dup.2s	v0, w16
movi.4s	v7, #0
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
str	q7, [x10]
str	q7, [x11, x8]
str	q7, [x9]
str	q7, [x7, x8]
sqrdmulh.4s	v16, v16, v0[0]
sqrdmulh.4s	v17, v17, v0[0]
sqrdmulh.4s	v18, v18, v0[0]
sqrdmulh.4s	v19, v19, v0[0]
bl	inv_dct64_step1_neon
sub	x6, x6, #512
add	x9, x6, #112
bl	inv_dct64_step2_neon
ret	x14
_inv_txfm_horz_dct_64x4_neon:
mov	x14, x30
mov	x7, sp
add	x8, sp, #960
add	x9, x6, #112
mov	x10, #128
mov	x11, #-64
dup.4s	v7, w12
ld1.4s	{ v16, v17, v18, v19 }, [x7], #64
ld1.4s	{ v28, v29, v30, v31 }, [x8], x11
ld1.4s	{ v20, v21, v22, v23 }, [x7], #64
ld1.4s	{ v24, v25, v26, v27 }, [x8], x11
trn1.4s	v2, v16, v17
trn2.4s	v3, v16, v17
trn1.4s	v4, v18, v19
trn2.4s	v5, v18, v19
trn1.2d	v16, v2, v4
trn2.2d	v18, v2, v4
trn1.2d	v17, v3, v5
trn2.2d	v19, v3, v5
trn1.4s	v2, v20, v21
trn2.4s	v3, v20, v21
trn1.4s	v4, v22, v23
trn2.4s	v5, v22, v23
trn1.2d	v20, v2, v4
trn2.2d	v22, v2, v4
trn1.2d	v21, v3, v5
trn2.2d	v23, v3, v5
trn1.4s	v2, v31, v30
trn2.4s	v3, v31, v30
trn1.4s	v4, v29, v28
trn2.4s	v5, v29, v28
trn1.2d	v31, v2, v4
trn2.2d	v29, v2, v4
trn1.2d	v30, v3, v5
trn2.2d	v28, v3, v5
trn1.4s	v2, v27, v26
trn2.4s	v3, v27, v26
trn1.4s	v4, v25, v24
trn2.4s	v5, v25, v24
trn1.2d	v27, v2, v4
trn2.2d	v25, v2, v4
trn1.2d	v26, v3, v5
trn2.2d	v24, v3, v5
sqsub.4s	v1, v16, v31
sqadd.4s	v0, v16, v31
sqsub.4s	v3, v20, v27
srshl.4s	v1, v1, v7
sqadd.4s	v2, v20, v27
srshl.4s	v3, v3, v7
srshl.4s	v0, v0, v7
srshl.4s	v2, v2, v7
sqxtn.4h	v3, v3
sqxtn2.8h	v3, v1
sqxtn.4h	v0, v0
sqxtn2.8h	v0, v2
rev64.8h	v3, v3
st1.8h	{ v0 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sqsub.4s	v1, v17, v30
sqadd.4s	v0, v17, v30
sqsub.4s	v3, v21, v26
srshl.4s	v1, v1, v7
sqadd.4s	v2, v21, v26
srshl.4s	v3, v3, v7
srshl.4s	v0, v0, v7
srshl.4s	v2, v2, v7
sqxtn.4h	v3, v3
sqxtn2.8h	v3, v1
sqxtn.4h	v0, v0
sqxtn2.8h	v0, v2
rev64.8h	v3, v3
st1.8h	{ v0 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sqsub.4s	v1, v18, v29
sqadd.4s	v0, v18, v29
sqsub.4s	v3, v22, v25
srshl.4s	v1, v1, v7
sqadd.4s	v2, v22, v25
srshl.4s	v3, v3, v7
srshl.4s	v0, v0, v7
srshl.4s	v2, v2, v7
sqxtn.4h	v3, v3
sqxtn2.8h	v3, v1
sqxtn.4h	v0, v0
sqxtn2.8h	v0, v2
rev64.8h	v3, v3
st1.8h	{ v0 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sqsub.4s	v1, v19, v28
sqadd.4s	v0, v19, v28
sqsub.4s	v3, v23, v24
srshl.4s	v1, v1, v7
sqadd.4s	v2, v23, v24
srshl.4s	v3, v3, v7
srshl.4s	v0, v0, v7
srshl.4s	v2, v2, v7
sqxtn.4h	v3, v3
sqxtn2.8h	v3, v1
sqxtn.4h	v0, v0
sqxtn2.8h	v0, v2
rev64.8h	v3, v3
st1.8h	{ v0 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sub	x6, x6, x10, lsl #2
sub	x9, x9, x10, lsl #2
add	x6, x6, #16
sub	x9, x9, #16
cmp	x7, x8
b.lt	inv_txfm_horz_dct_64x4_neon
ret	x14
_inv_txfm_add_vert_dct_8x64_neon:
mov	x14, x30
lsl	x8, x8, #1
mov	x7, sp
add	x8, sp, #960
add	x9, x6, x1, lsl #6
sub	x9, x9, x1
neg	x10, x1
mov	x11, #-64
ld1.8h	{ v16, v17, v18, v19 }, [x7], #64
ld1.8h	{ v28, v29, v30, v31 }, [x8], x11
ld1.8h	{ v20, v21, v22, v23 }, [x7], #64
ld1.8h	{ v24, v25, v26, v27 }, [x8], x11
mvni.8h	v7, #252, lsl #8
ld1.8h	{ v0 }, [x6], x1
ld1.8h	{ v1 }, [x9], x10
sqadd.8h	v4, v16, v31
ld1.8h	{ v2 }, [x6]
sqsub.8h	v16, v16, v31
ld1.8h	{ v3 }, [x9]
sqadd.8h	v5, v17, v30
sqsub.8h	v17, v17, v30
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v16, v16, #4
usqadd.8h	v0, v4
srshr.8h	v17, v17, #4
usqadd.8h	v1, v16
usqadd.8h	v2, v5
smin.8h	v0, v0, v7
usqadd.8h	v3, v17
smin.8h	v1, v1, v7
st1.8h	{ v0 }, [x6], x1
smin.8h	v2, v2, v7
st1.8h	{ v1 }, [x9], x10
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
st1.8h	{ v3 }, [x9], x10
ld1.8h	{ v0 }, [x6], x1
ld1.8h	{ v1 }, [x9], x10
sqadd.8h	v4, v18, v29
ld1.8h	{ v2 }, [x6]
sqsub.8h	v18, v18, v29
ld1.8h	{ v3 }, [x9]
sqadd.8h	v5, v19, v28
sqsub.8h	v19, v19, v28
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v18, v18, #4
usqadd.8h	v0, v4
srshr.8h	v19, v19, #4
usqadd.8h	v1, v18
usqadd.8h	v2, v5
smin.8h	v0, v0, v7
usqadd.8h	v3, v19
smin.8h	v1, v1, v7
st1.8h	{ v0 }, [x6], x1
smin.8h	v2, v2, v7
st1.8h	{ v1 }, [x9], x10
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
st1.8h	{ v3 }, [x9], x10
ld1.8h	{ v0 }, [x6], x1
ld1.8h	{ v1 }, [x9], x10
sqadd.8h	v4, v20, v27
ld1.8h	{ v2 }, [x6]
sqsub.8h	v20, v20, v27
ld1.8h	{ v3 }, [x9]
sqadd.8h	v5, v21, v26
sqsub.8h	v21, v21, v26
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v20, v20, #4
usqadd.8h	v0, v4
srshr.8h	v21, v21, #4
usqadd.8h	v1, v20
usqadd.8h	v2, v5
smin.8h	v0, v0, v7
usqadd.8h	v3, v21
smin.8h	v1, v1, v7
st1.8h	{ v0 }, [x6], x1
smin.8h	v2, v2, v7
st1.8h	{ v1 }, [x9], x10
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
st1.8h	{ v3 }, [x9], x10
ld1.8h	{ v0 }, [x6], x1
ld1.8h	{ v1 }, [x9], x10
sqadd.8h	v4, v22, v25
ld1.8h	{ v2 }, [x6]
sqsub.8h	v22, v22, v25
ld1.8h	{ v3 }, [x9]
sqadd.8h	v5, v23, v24
sqsub.8h	v23, v23, v24
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v22, v22, #4
usqadd.8h	v0, v4
srshr.8h	v23, v23, #4
usqadd.8h	v1, v22
usqadd.8h	v2, v5
smin.8h	v0, v0, v7
usqadd.8h	v3, v23
smin.8h	v1, v1, v7
st1.8h	{ v0 }, [x6], x1
smin.8h	v2, v2, v7
st1.8h	{ v1 }, [x9], x10
smin.8h	v3, v3, v7
st1.8h	{ v2 }, [x6], x1
st1.8h	{ v3 }, [x9], x10
cmp	x7, x8
b.lt	inv_txfm_add_vert_dct_8x64_neon
ret	x14
_inv_txfm_add_dct_dct_64x64_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_64x64_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #64
b	idct_dc_w64_neon
mov	x15, x30
sub	sp, sp, #1, lsl #12     ; =4096
sub	sp, sp, #1024
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x13, x13, #0
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #0
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #512
mov	w8, #28
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #16
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #512
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #1024
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #32
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #1024
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #1536
mov	w8, #20
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #48
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #1536
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #2048
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #64
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #2048
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #2560
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #80
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #2560
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #3072
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #96
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #3072
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #3584
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x2, #112
mov	x8, #128
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x5, #3584
bl	inv_txfm_horz_dct_64x4_neon
b	inv_txfm_add_dct_dct_64x64_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #2
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x7, x5, #0
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #16
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #16
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #32
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #32
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #48
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #48
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #64
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #64
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #80
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #80
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #96
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #96
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #112
mov	x8, #128
bl	inv_txfm_add_dct_dct_64x64_16bpc_neon
add	x6, x0, #112
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #1, lsl #12     ; =4096
ret	x15
_inv_txfm_add_dct_dct_64x32_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_64x32_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w64_neon
mov	x15, x30
sub	sp, sp, #1, lsl #12     ; =4096
sub	sp, sp, #1024
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x13, x13, #0
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #0
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #512
mov	w8, #28
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #16
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #512
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #1024
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #32
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #1024
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #1536
mov	w8, #20
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #48
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #1536
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #2048
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #64
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #2048
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #2560
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #80
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #2560
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #3072
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #96
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #3072
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x5, #3584
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x7, x2, #112
mov	x8, #128
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_4s_x64_neon
add	x6, x5, #3584
bl	inv_txfm_horz_dct_64x4_neon
b	inv_txfm_add_dct_dct_64x32_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #2
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_64x32_16bpc_neon
add	x6, x0, #0
add	x7, x5, #0
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #16
add	x7, x5, #16
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #32
add	x7, x5, #32
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #48
add	x7, x5, #48
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #64
add	x7, x5, #64
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #80
add	x7, x5, #80
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #96
add	x7, x5, #96
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #112
add	x7, x5, #112
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, x5, #1, lsl #12     ; =4096
ret	x15
_inv_txfm_add_dct_dct_32x64_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x64_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrdmulh.4s	v20, v20, v0[0]
sqrshrn.4h	v16, v20, #1
sqrshrn2.8h	v16, v20, #1
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #64
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #3072
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_32x64_16bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #256
mov	w8, #28
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #512
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #768
mov	w8, #20
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #48
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #1024
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #64
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #1280
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #80
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #1536
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #96
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
add	x6, x5, #1792
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #112
mov	x8, #128
bl	inv_txfm_horz_scale_dct_32x4_neon
b	inv_txfm_add_dct_dct_32x64_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_32x64_16bpc_neon
add	x7, x5, #0
mov	x8, #64
bl	inv_txfm_add_dct_dct_32x64_16bpc_neon
add	x6, x0, #0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #16
mov	x8, #64
bl	inv_txfm_add_dct_dct_32x64_16bpc_neon
add	x6, x0, #16
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #32
mov	x8, #64
bl	inv_txfm_add_dct_dct_32x64_16bpc_neon
add	x6, x0, #32
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #48
mov	x8, #64
bl	inv_txfm_add_dct_dct_32x64_16bpc_neon
add	x6, x0, #48
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #2048
ret	x15
_inv_txfm_add_dct_dct_64x16_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_64x16_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w64_neon
mov	x15, x30
sub	sp, sp, #3072
add	x4, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_64x16_16bpc_neon
add	x13, x13, #0
add	x6, x4, #0
add	x7, x2, #0
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x4, #0
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x4, #512
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x16_16bpc_neon
add	x7, x2, #16
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x4, #512
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x4, #1024
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x16_16bpc_neon
add	x7, x2, #32
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x4, #1024
bl	inv_txfm_horz_dct_64x4_neon
ldrh	w12, [x13], #2
add	x6, x4, #1536
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x16_16bpc_neon
add	x7, x2, #48
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_4s_x64_neon
add	x6, x4, #1536
bl	inv_txfm_horz_dct_64x4_neon
b	inv_txfm_add_dct_dct_64x16_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #2
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_64x16_16bpc_neon
adrp	x5, inv_txfm_add_dct_dct_64x16_16bpc_neon
add	x5, x5, #0
add	x6, x0, #0
add	x7, x4, #0
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #16
add	x7, x4, #16
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #32
add	x7, x4, #32
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #48
add	x7, x4, #48
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #64
add	x7, x4, #64
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #80
add	x7, x4, #80
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #96
add	x7, x4, #96
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #112
add	x7, x4, #112
mov	x8, #128
bl	inv_txfm_add_vert_8x16_neon
add	sp, x4, #2048
ret	x15
_inv_txfm_add_dct_dct_16x64_16bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x64_16bpc_neon
mov	w16, #1518338048
ld1r.4s	{ v16 }, [x2]
dup.2s	v0, w16
sqrdmulh.4s	v20, v16, v0[0]
str	wzr, [x2]
sqrshrn.4h	v16, v20, #2
sqrshrn2.8h	v16, v20, #2
sqrdmulh.8h	v16, v16, v0[1]
srshr.8h	v16, v16, #4
mov	w4, #64
b	idct_dc_w16_neon
mov	x15, x30
sub	sp, sp, #2048
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_16x64_16bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
adr	x4, #-25736
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #128
mov	w8, #28
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #256
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #384
mov	w8, #20
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #48
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #512
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #64
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #640
mov	w8, #12
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #80
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #768
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #96
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
add	x6, x5, #896
mov	w8, #4
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_16bpc_neon
add	x7, x2, #112
mov	x8, #128
bl	inv_txfm_horz_16x4_neon
b	inv_txfm_add_dct_dct_16x64_16bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_16x64_16bpc_neon
add	x7, x5, #0
mov	x8, #32
bl	inv_txfm_add_dct_dct_16x64_16bpc_neon
add	x6, x0, #0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #16
mov	x8, #32
bl	inv_txfm_add_dct_dct_16x64_16bpc_neon
add	x6, x0, #16
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #1024
ret	x15