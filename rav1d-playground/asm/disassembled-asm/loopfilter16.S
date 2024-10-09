_ltmp0:
uabd.8h	v0, v22, v23
uabd.8h	v1, v25, v24
uabd.8h	v2, v23, v24
uabd.8h	v3, v22, v25
uabd.8h	v4, v21, v22
uabd.8h	v5, v26, v25
uabd.8h	v6, v20, v21
uabd.8h	v7, v27, v26
umax.8h	v4, v4, v5
uqadd.8h	v2, v2, v2
umax.8h	v6, v6, v7
ushr.8h	v3, v3, #1
umax.8h	v4, v4, v6
and.16b	v4, v4, v14
umax.8h	v0, v0, v1
uqadd.8h	v2, v2, v3
umax.8h	v4, v0, v4
cmhs.8h	v1, v11, v4
cmhs.8h	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
and.16b	v14, v14, v1
and.16b	v15, v15, v1
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	ltmp0
mov	x14, #1
ret
movi.8h	v10, #1
uabd.8h	v2, v21, v23
uabd.8h	v3, v22, v23
uabd.8h	v4, v25, v24
uabd.8h	v5, v26, v24
dup.8h	v9, w9
uabd.8h	v6, v20, v23
uabd.8h	v7, v27, v24
umax.8h	v2, v2, v3
umax.8h	v4, v4, v5
umax.8h	v6, v6, v7
umax.8h	v2, v2, v4
ushl.8h	v10, v10, v9
umax.8h	v2, v2, v6
uabd.8h	v3, v17, v23
uabd.8h	v4, v18, v23
uabd.8h	v5, v19, v23
cmhs.8h	v2, v10, v2
uabd.8h	v6, v28, v24
uabd.8h	v7, v29, v24
uabd.8h	v8, v30, v24
and.16b	v14, v2, v14
bic.16b	v1, v1, v14
umax.8h	v3, v3, v4
umax.8h	v5, v5, v6
mov.d	x16, v1[0]
mov.d	x17, v1[1]
umax.8h	v7, v7, v8
umax.8h	v3, v3, v5
umax.8h	v3, v3, v7
cmhs.8h	v3, v10, v3
adds	x16, x16, x17
and.16b	v15, v15, v3
and.16b	v15, v15, v14
bic.16b	v14, v14, v15
b.eq	ltmp0
dup.8h	v3, w8
sub.8h	v2, v22, v25
ushr.8h	v3, v3, #1
cmhi.8h	v0, v0, v12
mvn.16b	v9, v3
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
and.16b	v4, v2, v0
sub.8h	v2, v24, v23
movi.8h	v5, #3
bic.16b	v0, v1, v0
mul.8h	v2, v2, v5
movi.8h	v6, #4
add.8h	v2, v2, v4
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
sqadd.8h	v4, v6, v2
sqadd.8h	v5, v5, v2
smin.8h	v4, v4, v3
smin.8h	v5, v5, v3
sshr.8h	v4, v4, #3
sshr.8h	v5, v5, #3
movi.8h	v9, #0
dup.8h	v3, w8
sqadd.8h	v2, v23, v5
sqsub.8h	v6, v24, v4
srshr.8h	v4, v4, #1
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v23, v2, v1
bit.16b	v24, v6, v1
sqadd.8h	v2, v22, v4
sqsub.8h	v6, v25, v4
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v22, v2, v0
bit.16b	v25, v6, v0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	ltmp0
add.8h	v0, v20, v21
add.8h	v2, v22, v25
add.8h	v4, v20, v22
add.8h	v6, v23, v26
add.8h	v8, v0, v0
add.8h	v9, v23, v24
add.8h	v8, v8, v4
sub.8h	v2, v2, v0
add.8h	v8, v8, v9
sub.8h	v6, v6, v4
urshr.8h	v10, v8, #3
add.8h	v8, v8, v2
add.8h	v0, v20, v23
add.8h	v2, v24, v27
urshr.8h	v11, v8, #3
add.8h	v8, v8, v6
sub.8h	v2, v2, v0
add.8h	v4, v21, v24
add.8h	v6, v25, v27
urshr.8h	v12, v8, #3
add.8h	v8, v8, v2
sub.8h	v6, v6, v4
add.8h	v0, v22, v25
add.8h	v2, v26, v27
urshr.8h	v13, v8, #3
add.8h	v8, v8, v6
sub.8h	v2, v2, v0
urshr.8h	v0, v8, #3
add.8h	v8, v8, v2
bit.16b	v21, v10, v14
bit.16b	v22, v11, v14
bit.16b	v23, v12, v14
urshr.8h	v1, v8, #3
bit.16b	v24, v13, v14
bit.16b	v25, v0, v14
bit.16b	v26, v1, v14
mov.d	x16, v15[0]
mov.d	x17, v15[1]
adds	x16, x16, x17
b.ne	ltmp0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	ltmp0
b	ltmp0
add.8h	v2, v17, v17
add.8h	v4, v17, v18
add.8h	v6, v17, v19
add.8h	v8, v17, v20
add.8h	v12, v2, v4
add.8h	v10, v6, v8
add.8h	v6, v17, v21
add.8h	v12, v12, v10
add.8h	v8, v17, v22
add.8h	v10, v18, v23
add.8h	v6, v6, v8
add.8h	v8, v19, v24
add.8h	v12, v12, v6
add.8h	v10, v10, v8
add.8h	v6, v20, v25
add.8h	v12, v12, v10
sub.8h	v6, v6, v2
add.8h	v2, v21, v26
urshr.8h	v0, v12, #4
add.8h	v12, v12, v6
sub.8h	v2, v2, v4
add.8h	v4, v22, v27
add.8h	v6, v17, v19
urshr.8h	v1, v12, #4
add.8h	v12, v12, v2
sub.8h	v4, v4, v6
add.8h	v6, v23, v28
add.8h	v8, v17, v20
urshr.8h	v2, v12, #4
add.8h	v12, v12, v4
sub.8h	v6, v6, v8
add.8h	v8, v24, v29
add.8h	v4, v17, v21
urshr.8h	v3, v12, #4
add.8h	v12, v12, v6
sub.8h	v8, v8, v4
add.8h	v6, v25, v30
add.8h	v10, v17, v22
urshr.8h	v4, v12, #4
add.8h	v12, v12, v8
sub.8h	v6, v6, v10
add.8h	v8, v26, v30
bif.16b	v0, v18, v15
add.8h	v10, v18, v23
urshr.8h	v5, v12, #4
add.8h	v12, v12, v6
sub.8h	v8, v8, v10
add.8h	v10, v27, v30
bif.16b	v1, v19, v15
add.8h	v18, v19, v24
urshr.8h	v6, v12, #4
add.8h	v12, v12, v8
sub.8h	v10, v10, v18
add.8h	v8, v28, v30
bif.16b	v2, v20, v15
add.8h	v18, v20, v25
urshr.8h	v7, v12, #4
add.8h	v12, v12, v10
sub.8h	v18, v8, v18
add.8h	v10, v29, v30
bif.16b	v3, v21, v15
add.8h	v20, v21, v26
urshr.8h	v8, v12, #4
add.8h	v12, v12, v18
sub.8h	v10, v10, v20
add.8h	v18, v30, v30
bif.16b	v4, v22, v15
add.8h	v20, v22, v27
urshr.8h	v9, v12, #4
add.8h	v12, v12, v10
sub.8h	v18, v18, v20
bif.16b	v5, v23, v15
urshr.8h	v10, v12, #4
add.8h	v12, v12, v18
urshr.8h	v11, v12, #4
bif.16b	v6, v24, v15
bif.16b	v7, v25, v15
bif.16b	v8, v26, v15
bif.16b	v9, v27, v15
bif.16b	v10, v28, v15
bif.16b	v11, v29, v15
mov	x14, #0
ret
mov	x14, #64
ret
mov	x14, #16
ret
_lpf_8_wd8_neon:
uabd.8h	v0, v22, v23
uabd.8h	v1, v25, v24
uabd.8h	v2, v23, v24
uabd.8h	v3, v22, v25
uabd.8h	v4, v21, v22
uabd.8h	v5, v26, v25
uabd.8h	v6, v20, v21
uabd.8h	v7, v27, v26
umax.8h	v4, v4, v5
uqadd.8h	v2, v2, v2
umax.8h	v6, v6, v7
ushr.8h	v3, v3, #1
umax.8h	v4, v4, v6
and.16b	v4, v4, v14
umax.8h	v0, v0, v1
uqadd.8h	v2, v2, v3
umax.8h	v4, v0, v4
cmhs.8h	v1, v11, v4
cmhs.8h	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
and.16b	v14, v14, v1
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	lpf_8_wd8_neon
mov	x14, #1
ret
movi.8h	v10, #1
uabd.8h	v2, v21, v23
uabd.8h	v3, v22, v23
uabd.8h	v4, v25, v24
uabd.8h	v5, v26, v24
dup.8h	v9, w9
uabd.8h	v6, v20, v23
uabd.8h	v7, v27, v24
umax.8h	v2, v2, v3
umax.8h	v4, v4, v5
umax.8h	v6, v6, v7
umax.8h	v2, v2, v4
ushl.8h	v10, v10, v9
umax.8h	v2, v2, v6
cmhs.8h	v2, v10, v2
and.16b	v14, v2, v14
bic.16b	v1, v1, v14
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.eq	lpf_8_wd8_neon
dup.8h	v3, w8
sub.8h	v2, v22, v25
ushr.8h	v3, v3, #1
cmhi.8h	v0, v0, v12
mvn.16b	v9, v3
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
and.16b	v4, v2, v0
sub.8h	v2, v24, v23
movi.8h	v5, #3
bic.16b	v0, v1, v0
mul.8h	v2, v2, v5
movi.8h	v6, #4
add.8h	v2, v2, v4
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
sqadd.8h	v4, v6, v2
sqadd.8h	v5, v5, v2
smin.8h	v4, v4, v3
smin.8h	v5, v5, v3
sshr.8h	v4, v4, #3
sshr.8h	v5, v5, #3
movi.8h	v9, #0
dup.8h	v3, w8
sqadd.8h	v2, v23, v5
sqsub.8h	v6, v24, v4
srshr.8h	v4, v4, #1
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v23, v2, v1
bit.16b	v24, v6, v1
sqadd.8h	v2, v22, v4
sqsub.8h	v6, v25, v4
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v22, v2, v0
bit.16b	v25, v6, v0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	lpf_8_wd8_neon
add.8h	v0, v20, v21
add.8h	v2, v22, v25
add.8h	v4, v20, v22
add.8h	v6, v23, v26
add.8h	v8, v0, v0
add.8h	v9, v23, v24
add.8h	v8, v8, v4
sub.8h	v2, v2, v0
add.8h	v8, v8, v9
sub.8h	v6, v6, v4
urshr.8h	v10, v8, #3
add.8h	v8, v8, v2
add.8h	v0, v20, v23
add.8h	v2, v24, v27
urshr.8h	v11, v8, #3
add.8h	v8, v8, v6
sub.8h	v2, v2, v0
add.8h	v4, v21, v24
add.8h	v6, v25, v27
urshr.8h	v12, v8, #3
add.8h	v8, v8, v2
sub.8h	v6, v6, v4
add.8h	v0, v22, v25
add.8h	v2, v26, v27
urshr.8h	v13, v8, #3
add.8h	v8, v8, v6
sub.8h	v2, v2, v0
urshr.8h	v0, v8, #3
add.8h	v8, v8, v2
bit.16b	v21, v10, v14
bit.16b	v22, v11, v14
bit.16b	v23, v12, v14
urshr.8h	v1, v8, #3
bit.16b	v24, v13, v14
bit.16b	v25, v0, v14
bit.16b	v26, v1, v14
mov	x14, #0
ret
mov	x14, #16
ret
_lpf_8_wd6_neon:
uabd.8h	v0, v22, v23
uabd.8h	v1, v25, v24
uabd.8h	v2, v23, v24
uabd.8h	v3, v22, v25
uabd.8h	v4, v21, v22
uabd.8h	v5, v26, v25
umax.8h	v4, v4, v5
uqadd.8h	v2, v2, v2
ushr.8h	v3, v3, #1
and.16b	v4, v4, v14
umax.8h	v0, v0, v1
uqadd.8h	v2, v2, v3
umax.8h	v4, v0, v4
cmhs.8h	v1, v11, v4
cmhs.8h	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
and.16b	v14, v14, v1
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	lpf_8_wd6_neon
mov	x14, #1
ret
movi.8h	v10, #1
uabd.8h	v2, v21, v23
uabd.8h	v3, v22, v23
uabd.8h	v4, v25, v24
uabd.8h	v5, v26, v24
dup.8h	v9, w9
umax.8h	v2, v2, v3
umax.8h	v4, v4, v5
umax.8h	v2, v2, v4
ushl.8h	v10, v10, v9
cmhs.8h	v2, v10, v2
and.16b	v14, v2, v14
bic.16b	v1, v1, v14
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.eq	lpf_8_wd6_neon
dup.8h	v3, w8
sub.8h	v2, v22, v25
ushr.8h	v3, v3, #1
cmhi.8h	v0, v0, v12
mvn.16b	v9, v3
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
and.16b	v4, v2, v0
sub.8h	v2, v24, v23
movi.8h	v5, #3
bic.16b	v0, v1, v0
mul.8h	v2, v2, v5
movi.8h	v6, #4
add.8h	v2, v2, v4
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
sqadd.8h	v4, v6, v2
sqadd.8h	v5, v5, v2
smin.8h	v4, v4, v3
smin.8h	v5, v5, v3
sshr.8h	v4, v4, #3
sshr.8h	v5, v5, #3
movi.8h	v9, #0
dup.8h	v3, w8
sqadd.8h	v2, v23, v5
sqsub.8h	v6, v24, v4
srshr.8h	v4, v4, #1
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v23, v2, v1
bit.16b	v24, v6, v1
sqadd.8h	v2, v22, v4
sqsub.8h	v6, v25, v4
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v22, v2, v0
bit.16b	v25, v6, v0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	lpf_8_wd6_neon
add.8h	v0, v21, v21
add.8h	v2, v21, v22
add.8h	v4, v22, v23
add.8h	v6, v23, v24
add.8h	v8, v0, v2
add.8h	v10, v4, v6
add.8h	v12, v24, v25
add.8h	v8, v8, v10
sub.8h	v12, v12, v0
add.8h	v10, v25, v26
urshr.8h	v0, v8, #3
add.8h	v8, v8, v12
sub.8h	v10, v10, v2
add.8h	v12, v26, v26
urshr.8h	v1, v8, #3
add.8h	v8, v8, v10
sub.8h	v12, v12, v4
urshr.8h	v2, v8, #3
bit.16b	v22, v0, v14
add.8h	v8, v8, v12
bit.16b	v23, v1, v14
urshr.8h	v3, v8, #3
bit.16b	v24, v2, v14
bit.16b	v25, v3, v14
mov	x14, #0
ret
_lpf_8_wd4_neon:
uabd.8h	v0, v22, v23
uabd.8h	v1, v25, v24
uabd.8h	v2, v23, v24
uabd.8h	v3, v22, v25
uqadd.8h	v2, v2, v2
ushr.8h	v3, v3, #1
umax.8h	v0, v0, v1
uqadd.8h	v2, v2, v3
cmhs.8h	v1, v11, v0
cmhs.8h	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	lpf_8_wd4_neon
mov	x14, #1
ret
dup.8h	v3, w8
sub.8h	v2, v22, v25
ushr.8h	v3, v3, #1
cmhi.8h	v0, v0, v12
mvn.16b	v9, v3
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
and.16b	v4, v2, v0
sub.8h	v2, v24, v23
movi.8h	v5, #3
bic.16b	v0, v1, v0
mul.8h	v2, v2, v5
movi.8h	v6, #4
add.8h	v2, v2, v4
smin.8h	v2, v2, v3
smax.8h	v2, v2, v9
sqadd.8h	v4, v6, v2
sqadd.8h	v5, v5, v2
smin.8h	v4, v4, v3
smin.8h	v5, v5, v3
sshr.8h	v4, v4, #3
sshr.8h	v5, v5, #3
movi.8h	v9, #0
dup.8h	v3, w8
sqadd.8h	v2, v23, v5
sqsub.8h	v6, v24, v4
srshr.8h	v4, v4, #1
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v23, v2, v1
bit.16b	v24, v6, v1
sqadd.8h	v2, v22, v4
sqsub.8h	v6, v25, v4
smin.8h	v2, v2, v3
smin.8h	v6, v6, v3
smax.8h	v2, v2, v9
smax.8h	v6, v6, v9
bit.16b	v22, v2, v0
bit.16b	v25, v6, v0
mov	x14, #0
ret
_lpf_v_4_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
bl	lpf_8_wd4_neon
cbz	x14, lpf_v_4_8_neon
ret	x15
sub	x16, x0, x1, lsl #1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_4_8_neon:
mov	x15, x30
sub	x16, x0, #4
add	x0, x16, x1, lsl #2
ld1.d	{ v22 }[0], [x16], x1
ld1.d	{ v22 }[1], [x0], x1
ld1.d	{ v23 }[0], [x16], x1
ld1.d	{ v23 }[1], [x0], x1
ld1.d	{ v24 }[0], [x16], x1
ld1.d	{ v24 }[1], [x0], x1
ld1.d	{ v25 }[0], [x16], x1
ld1.d	{ v25 }[1], [x0], x1
add	x0, x0, #4
trn1.8h	v26, v22, v23
trn2.8h	v27, v22, v23
trn1.8h	v28, v24, v25
trn2.8h	v29, v24, v25
trn1.4s	v22, v26, v28
trn2.4s	v24, v26, v28
trn1.4s	v23, v27, v29
trn2.4s	v25, v27, v29
bl	lpf_8_wd4_neon
cbz	x14, lpf_h_4_8_neon
ret	x15
sub	x16, x0, x1, lsl #3
sub	x16, x16, #4
trn1.8h	v26, v22, v23
trn2.8h	v27, v22, v23
trn1.8h	v28, v24, v25
trn2.8h	v29, v24, v25
trn1.4s	v22, v26, v28
trn2.4s	v24, v26, v28
trn1.4s	v23, v27, v29
trn2.4s	v25, v27, v29
add	x0, x16, x1, lsl #2
st1.d	{ v22 }[0], [x16], x1
st1.d	{ v22 }[1], [x0], x1
st1.d	{ v23 }[0], [x16], x1
st1.d	{ v23 }[1], [x0], x1
st1.d	{ v24 }[0], [x16], x1
st1.d	{ v24 }[1], [x0], x1
st1.d	{ v25 }[0], [x16], x1
st1.d	{ v25 }[1], [x0], x1
add	x0, x0, #4
ret	x15
_lpf_v_6_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
ld1.8h	{ v21 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v26 }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
bl	lpf_8_wd6_neon
cbz	x14, lpf_v_6_8_neon
ret	x15
sub	x16, x0, x1, lsl #1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_6_8_neon:
mov	x15, x30
sub	x16, x0, #8
add	x0, x16, x1, lsl #2
ld1.8h	{ v20 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v21 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v26 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v27 }, [x0], x1
add	x0, x0, #8
trn1.8h	v28, v20, v21
trn2.8h	v29, v20, v21
trn1.8h	v21, v22, v23
trn2.8h	v23, v22, v23
trn1.8h	v20, v24, v25
trn2.8h	v25, v24, v25
trn1.8h	v22, v26, v27
trn2.8h	v27, v26, v27
trn1.4s	v24, v20, v22
trn2.4s	v22, v20, v22
trn1.4s	v26, v25, v27
trn2.4s	v27, v25, v27
trn1.4s	v25, v29, v23
trn2.4s	v29, v29, v23
trn1.4s	v23, v28, v21
trn2.4s	v28, v28, v21
trn1.2d	v20, v23, v24
trn2.2d	v24, v23, v24
trn1.2d	v21, v25, v26
trn2.2d	v25, v25, v26
trn2.2d	v26, v28, v22
trn1.2d	v22, v28, v22
trn1.2d	v23, v29, v27
trn2.2d	v27, v29, v27
bl	lpf_8_wd6_neon
cbz	x14, lpf_h_6_8_neon
ret	x15
sub	x16, x0, x1, lsl #3
sub	x16, x16, #4
trn1.8h	v26, v22, v23
trn2.8h	v27, v22, v23
trn1.8h	v28, v24, v25
trn2.8h	v29, v24, v25
trn1.4s	v22, v26, v28
trn2.4s	v24, v26, v28
trn1.4s	v23, v27, v29
trn2.4s	v25, v27, v29
add	x0, x16, x1, lsl #2
st1.d	{ v22 }[0], [x16], x1
st1.d	{ v22 }[1], [x0], x1
st1.d	{ v23 }[0], [x16], x1
st1.d	{ v23 }[1], [x0], x1
st1.d	{ v24 }[0], [x16], x1
st1.d	{ v24 }[1], [x0], x1
st1.d	{ v25 }[0], [x16], x1
st1.d	{ v25 }[1], [x0], x1
add	x0, x0, #4
ret	x15
_lpf_v_8_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #2
ld1.8h	{ v20 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v21 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v26 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v27 }, [x0], x1
sub	x0, x0, x1, lsl #2
bl	lpf_8_wd8_neon
cbz	x14, lpf_v_8_8_neon
tbnz	w14, #4, lpf_v_8_8_neon
ret	x15
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
st1.8h	{ v21 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v26 }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
sub	x16, x0, x1, lsl #1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_8_8_neon:
mov	x15, x30
sub	x16, x0, #8
add	x0, x16, x1, lsl #2
ld1.8h	{ v20 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v21 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v26 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v27 }, [x0], x1
add	x0, x0, #8
trn1.8h	v28, v20, v21
trn2.8h	v29, v20, v21
trn1.8h	v21, v22, v23
trn2.8h	v23, v22, v23
trn1.8h	v20, v24, v25
trn2.8h	v25, v24, v25
trn1.8h	v22, v26, v27
trn2.8h	v27, v26, v27
trn1.4s	v24, v20, v22
trn2.4s	v22, v20, v22
trn1.4s	v26, v25, v27
trn2.4s	v27, v25, v27
trn1.4s	v25, v29, v23
trn2.4s	v29, v29, v23
trn1.4s	v23, v28, v21
trn2.4s	v28, v28, v21
trn1.2d	v20, v23, v24
trn2.2d	v24, v23, v24
trn1.2d	v21, v25, v26
trn2.2d	v25, v25, v26
trn2.2d	v26, v28, v22
trn1.2d	v22, v28, v22
trn1.2d	v23, v29, v27
trn2.2d	v27, v29, v27
bl	lpf_8_wd8_neon
cbz	x14, lpf_h_8_8_neon
tbnz	w14, #4, lpf_h_8_8_neon
ret	x15
sub	x16, x0, x1, lsl #3
sub	x16, x16, #8
trn1.8h	v28, v20, v21
trn2.8h	v29, v20, v21
trn1.8h	v21, v22, v23
trn2.8h	v23, v22, v23
trn1.8h	v20, v24, v25
trn2.8h	v25, v24, v25
trn1.8h	v22, v26, v27
trn2.8h	v27, v26, v27
trn1.4s	v24, v20, v22
trn2.4s	v22, v20, v22
trn1.4s	v26, v25, v27
trn2.4s	v27, v25, v27
trn1.4s	v25, v29, v23
trn2.4s	v29, v29, v23
trn1.4s	v23, v28, v21
trn2.4s	v28, v28, v21
trn1.2d	v20, v23, v24
trn2.2d	v24, v23, v24
trn1.2d	v21, v25, v26
trn2.2d	v25, v25, v26
trn2.2d	v26, v28, v22
trn1.2d	v22, v28, v22
trn1.2d	v23, v29, v27
trn2.2d	v27, v29, v27
add	x0, x16, x1, lsl #2
st1.8h	{ v20 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v21 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v26 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v27 }, [x0], x1
add	x0, x0, #8
ret	x15
sub	x16, x0, x1, lsl #3
sub	x16, x16, #4
trn1.8h	v26, v22, v23
trn2.8h	v27, v22, v23
trn1.8h	v28, v24, v25
trn2.8h	v29, v24, v25
trn1.4s	v22, v26, v28
trn2.4s	v24, v26, v28
trn1.4s	v23, v27, v29
trn2.4s	v25, v27, v29
add	x0, x16, x1, lsl #2
st1.d	{ v22 }[0], [x16], x1
st1.d	{ v22 }[1], [x0], x1
st1.d	{ v23 }[0], [x16], x1
st1.d	{ v23 }[1], [x0], x1
st1.d	{ v24 }[0], [x16], x1
st1.d	{ v24 }[1], [x0], x1
st1.d	{ v25 }[0], [x16], x1
st1.d	{ v25 }[1], [x0], x1
add	x0, x0, #4
ret	x15
_lpf_v_16_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #3
add	x16, x16, x1
ld1.8h	{ v17 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v18 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
ld1.8h	{ v19 }, [x16], x1
ld1.8h	{ v26 }, [x0], x1
ld1.8h	{ v20 }, [x16], x1
ld1.8h	{ v27 }, [x0], x1
ld1.8h	{ v21 }, [x16], x1
ld1.8h	{ v28 }, [x0], x1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v29 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v30 }, [x0], x1
sub	x0, x0, x1, lsl #3
add	x0, x0, x1
bl	ltmp0
cbz	x14, lpf_v_16_8_neon
tbnz	w14, #6, lpf_v_16_8_neon
tbnz	w14, #4, lpf_v_16_8_neon
ret	x15
sub	x16, x0, x1, lsl #2
sub	x16, x16, x1, lsl #1
st1.8h	{ v0 }, [x16], x1
st1.8h	{ v6 }, [x0], x1
st1.8h	{ v1 }, [x16], x1
st1.8h	{ v7 }, [x0], x1
st1.8h	{ v2 }, [x16], x1
st1.8h	{ v8 }, [x0], x1
st1.8h	{ v3 }, [x16], x1
st1.8h	{ v9 }, [x0], x1
st1.8h	{ v4 }, [x16], x1
st1.8h	{ v10 }, [x0], x1
st1.8h	{ v5 }, [x16], x1
st1.8h	{ v11 }, [x0], x1
sub	x0, x0, x1, lsl #2
sub	x0, x0, x1, lsl #1
ret	x15
sub	x16, x0, x1
sub	x16, x16, x1, lsl #1
st1.8h	{ v21 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v26 }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
sub	x16, x0, x1, lsl #1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_16_8_neon:
mov	x15, x30
sub	x16, x0, #16
ld1.8h	{ v16 }, [x16], x1
ld1.8h	{ v24 }, [x0], x1
ld1.8h	{ v17 }, [x16], x1
ld1.8h	{ v25 }, [x0], x1
ld1.8h	{ v18 }, [x16], x1
ld1.8h	{ v26 }, [x0], x1
ld1.8h	{ v19 }, [x16], x1
ld1.8h	{ v27 }, [x0], x1
ld1.8h	{ v20 }, [x16], x1
ld1.8h	{ v28 }, [x0], x1
ld1.8h	{ v21 }, [x16], x1
ld1.8h	{ v29 }, [x0], x1
ld1.8h	{ v22 }, [x16], x1
ld1.8h	{ v30 }, [x0], x1
ld1.8h	{ v23 }, [x16], x1
ld1.8h	{ v31 }, [x0], x1
trn1.8h	v0, v16, v17
trn2.8h	v1, v16, v17
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
trn1.4s	v21, v1, v19
trn2.4s	v1, v1, v19
trn1.4s	v19, v0, v17
trn2.4s	v0, v0, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v0, v18
trn1.2d	v18, v0, v18
trn1.2d	v19, v1, v23
trn2.2d	v23, v1, v23
trn1.8h	v0, v24, v25
trn2.8h	v1, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v1, v27
trn2.4s	v1, v1, v27
trn1.4s	v27, v0, v25
trn2.4s	v0, v0, v25
trn1.2d	v24, v27, v28
trn2.2d	v28, v27, v28
trn1.2d	v25, v29, v30
trn2.2d	v29, v29, v30
trn2.2d	v30, v0, v26
trn1.2d	v26, v0, v26
trn1.2d	v27, v1, v31
trn2.2d	v31, v1, v31
bl	ltmp0
cbz	x14, lpf_h_16_8_neon
tbnz	w14, #6, lpf_h_16_8_neon
tbnz	w14, #4, lpf_h_16_8_neon
ret	x15
sub	x0, x0, x1, lsl #3
sub	x16, x0, #16
trn1.8h	v18, v16, v17
trn2.8h	v19, v16, v17
trn1.8h	v17, v0, v1
trn2.8h	v1, v0, v1
trn1.8h	v16, v2, v3
trn2.8h	v3, v2, v3
trn1.8h	v0, v4, v5
trn2.8h	v5, v4, v5
trn1.4s	v2, v16, v0
trn2.4s	v0, v16, v0
trn1.4s	v4, v3, v5
trn2.4s	v5, v3, v5
trn1.4s	v3, v19, v1
trn2.4s	v19, v19, v1
trn1.4s	v1, v18, v17
trn2.4s	v18, v18, v17
trn1.2d	v16, v1, v2
trn2.2d	v2, v1, v2
trn1.2d	v17, v3, v4
trn2.2d	v3, v3, v4
trn2.2d	v4, v18, v0
trn1.2d	v0, v18, v0
trn1.2d	v1, v19, v5
trn2.2d	v5, v19, v5
trn1.8h	v18, v6, v7
trn2.8h	v19, v6, v7
trn1.8h	v7, v8, v9
trn2.8h	v9, v8, v9
trn1.8h	v6, v10, v11
trn2.8h	v11, v10, v11
trn1.8h	v8, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v10, v6, v8
trn2.4s	v8, v6, v8
trn1.4s	v30, v11, v31
trn2.4s	v31, v11, v31
trn1.4s	v11, v19, v9
trn2.4s	v19, v19, v9
trn1.4s	v9, v18, v7
trn2.4s	v18, v18, v7
trn1.2d	v6, v9, v10
trn2.2d	v10, v9, v10
trn1.2d	v7, v11, v30
trn2.2d	v11, v11, v30
trn2.2d	v30, v18, v8
trn1.2d	v8, v18, v8
trn1.2d	v9, v19, v31
trn2.2d	v31, v19, v31
st1.8h	{ v16 }, [x16], x1
st1.8h	{ v6 }, [x0], x1
st1.8h	{ v17 }, [x16], x1
st1.8h	{ v7 }, [x0], x1
st1.8h	{ v0 }, [x16], x1
st1.8h	{ v8 }, [x0], x1
st1.8h	{ v1 }, [x16], x1
st1.8h	{ v9 }, [x0], x1
st1.8h	{ v2 }, [x16], x1
st1.8h	{ v10 }, [x0], x1
st1.8h	{ v3 }, [x16], x1
st1.8h	{ v11 }, [x0], x1
st1.8h	{ v4 }, [x16], x1
st1.8h	{ v30 }, [x0], x1
st1.8h	{ v5 }, [x16], x1
st1.8h	{ v31 }, [x0], x1
ret	x15
sub	x16, x0, x1, lsl #3
sub	x16, x16, #8
trn1.8h	v28, v20, v21
trn2.8h	v29, v20, v21
trn1.8h	v21, v22, v23
trn2.8h	v23, v22, v23
trn1.8h	v20, v24, v25
trn2.8h	v25, v24, v25
trn1.8h	v22, v26, v27
trn2.8h	v27, v26, v27
trn1.4s	v24, v20, v22
trn2.4s	v22, v20, v22
trn1.4s	v26, v25, v27
trn2.4s	v27, v25, v27
trn1.4s	v25, v29, v23
trn2.4s	v29, v29, v23
trn1.4s	v23, v28, v21
trn2.4s	v28, v28, v21
trn1.2d	v20, v23, v24
trn2.2d	v24, v23, v24
trn1.2d	v21, v25, v26
trn2.2d	v25, v25, v26
trn2.2d	v26, v28, v22
trn1.2d	v22, v28, v22
trn1.2d	v23, v29, v27
trn2.2d	v27, v29, v27
add	x0, x16, x1, lsl #2
st1.8h	{ v20 }, [x16], x1
st1.8h	{ v24 }, [x0], x1
st1.8h	{ v21 }, [x16], x1
st1.8h	{ v25 }, [x0], x1
st1.8h	{ v22 }, [x16], x1
st1.8h	{ v26 }, [x0], x1
st1.8h	{ v23 }, [x16], x1
st1.8h	{ v27 }, [x0], x1
add	x0, x0, #8
ret	x15
sub	x16, x0, x1, lsl #3
sub	x16, x16, #4
trn1.8h	v26, v22, v23
trn2.8h	v27, v22, v23
trn1.8h	v28, v24, v25
trn2.8h	v29, v24, v25
trn1.4s	v22, v26, v28
trn2.4s	v24, v26, v28
trn1.4s	v23, v27, v29
trn2.4s	v25, v27, v29
add	x0, x16, x1, lsl #2
st1.d	{ v22 }[0], [x16], x1
st1.d	{ v22 }[1], [x0], x1
st1.d	{ v23 }[0], [x16], x1
st1.d	{ v23 }[1], [x0], x1
st1.d	{ v24 }[0], [x16], x1
st1.d	{ v24 }[1], [x0], x1
st1.d	{ v25 }[0], [x16], x1
st1.d	{ v25 }[1], [x0], x1
add	x0, x0, #4
ret	x15
_lpf_v_sb_y_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #24
sub	w9, w10, w9
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
ldr	w2, [x2, #8]
add	x5, x5, #128
orr	w7, w7, w2
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
tst	w6, #0x3
ld1.8b	{ v0 }, [x4], #8
ld1.8b	{ v1 }, [x3], #8
b.eq	lpf_v_sb_y_16bpc_neon
ld1r.8b	{ v5 }, [x5]
add	x5, x5, #8
movi.2s	v2, #255
dup.2s	v13, w6
dup.8h	v31, w9
and.8b	v0, v0, v2
and.8b	v1, v1, v2
cmtst.8b	v3, v1, v2
movi.8b	v4, #1
ld1r.8b	{ v6 }, [x5]
sub	x5, x5, #8
bif.8b	v1, v0, v3
cmtst.2s	v2, v1, v2
mul.2s	v1, v1, v4
dup.2s	v15, w2
dup.2s	v14, w7
mov.d	x16, v2[0]
cmp	x16, #0
b.eq	lpf_v_sb_y_16bpc_neon
neg.8b	v5, v5
adrp	x16, lpf_v_sb_y_16bpc_neon
add	x16, x16, #0
ushr.8b	v12, v1, #4
ld1.2s	{ v16 }, [x16]
sshl.8b	v3, v1, v5
cmtst.2s	v15, v15, v16
movi.8b	v7, #2
umin.8b	v3, v3, v6
add.8b	v0, v1, v7
umax.8b	v11, v3, v4
add.8b	v0, v0, v0
cmtst.2s	v14, v14, v16
ushll.8h	v12, v12, #0
add.8b	v10, v0, v11
cmtst.2s	v13, v13, v16
ushll.8h	v11, v11, #0
ushll.8h	v10, v10, #0
and.8b	v13, v13, v2
sshll.8h	v14, v14, #0
sshll.8h	v13, v13, #0
sshll.8h	v15, v15, #0
ushl.8h	v12, v12, v31
ushl.8h	v11, v11, v31
ushl.8h	v10, v10, v31
tst	w2, #0x3
b.eq	lpf_v_sb_y_16bpc_neon
bl	lpf_v_16_8_neon
b	lpf_v_sb_y_16bpc_neon
tst	w7, #0x3
b.eq	lpf_v_sb_y_16bpc_neon
bl	lpf_v_8_8_neon
b	lpf_v_sb_y_16bpc_neon
bl	lpf_v_4_8_neon
lsr	w6, w6, #2
lsr	w7, w7, #2
lsr	w2, w2, #2
add	x0, x0, #16
cbnz	w6, lpf_v_sb_y_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
_lpf_h_sb_y_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #24
sub	w9, w10, w9
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
ldr	w2, [x2, #8]
add	x5, x5, #128
orr	w7, w7, w2
sub	x3, x3, #4
lsl	x4, x4, #2
orr	w6, w6, w7
tst	w6, #0x3
ld2.s	{ v0, v1 }[0], [x3], x4
ld2.s	{ v0, v1 }[1], [x3], x4
b.eq	lpf_h_sb_y_16bpc_neon
ld1r.8b	{ v5 }, [x5]
add	x5, x5, #8
movi.2s	v2, #255
dup.2s	v13, w6
dup.8h	v31, w9
and.8b	v0, v0, v2
and.8b	v1, v1, v2
cmtst.8b	v3, v1, v2
movi.8b	v4, #1
ld1r.8b	{ v6 }, [x5]
sub	x5, x5, #8
bif.8b	v1, v0, v3
cmtst.2s	v2, v1, v2
mul.2s	v1, v1, v4
dup.2s	v15, w2
dup.2s	v14, w7
mov.d	x16, v2[0]
cmp	x16, #0
b.eq	lpf_h_sb_y_16bpc_neon
neg.8b	v5, v5
adrp	x16, lpf_h_sb_y_16bpc_neon
add	x16, x16, #0
ushr.8b	v12, v1, #4
ld1.2s	{ v16 }, [x16]
sshl.8b	v3, v1, v5
cmtst.2s	v15, v15, v16
movi.8b	v7, #2
umin.8b	v3, v3, v6
add.8b	v0, v1, v7
umax.8b	v11, v3, v4
add.8b	v0, v0, v0
cmtst.2s	v14, v14, v16
ushll.8h	v12, v12, #0
add.8b	v10, v0, v11
cmtst.2s	v13, v13, v16
ushll.8h	v11, v11, #0
ushll.8h	v10, v10, #0
and.8b	v13, v13, v2
sshll.8h	v14, v14, #0
sshll.8h	v13, v13, #0
sshll.8h	v15, v15, #0
ushl.8h	v12, v12, v31
ushl.8h	v11, v11, v31
ushl.8h	v10, v10, v31
tst	w2, #0x3
b.eq	lpf_h_sb_y_16bpc_neon
bl	lpf_h_16_8_neon
b	lpf_h_sb_y_16bpc_neon
tst	w7, #0x3
b.eq	lpf_h_sb_y_16bpc_neon
bl	lpf_h_8_8_neon
b	lpf_h_sb_y_16bpc_neon
bl	lpf_h_4_8_neon
b	lpf_h_sb_y_16bpc_neon
add	x0, x0, x1, lsl #3
lsr	w6, w6, #2
lsr	w7, w7, #2
lsr	w2, w2, #2
cbnz	w6, lpf_h_sb_y_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
_lpf_v_sb_uv_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #24
sub	w9, w10, w9
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
add	x5, x5, #128
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
tst	w6, #0x3
ld1.8b	{ v0 }, [x4], #8
ld1.8b	{ v1 }, [x3], #8
b.eq	lpf_v_sb_uv_16bpc_neon
ld1r.8b	{ v5 }, [x5]
add	x5, x5, #8
movi.2s	v2, #255
dup.2s	v13, w6
dup.8h	v31, w9
and.8b	v0, v0, v2
and.8b	v1, v1, v2
cmtst.8b	v3, v1, v2
movi.8b	v4, #1
ld1r.8b	{ v6 }, [x5]
sub	x5, x5, #8
bif.8b	v1, v0, v3
cmtst.2s	v2, v1, v2
mul.2s	v1, v1, v4
dup.2s	v14, w7
mov.d	x16, v2[0]
cmp	x16, #0
b.eq	lpf_v_sb_uv_16bpc_neon
neg.8b	v5, v5
adrp	x16, lpf_v_sb_uv_16bpc_neon
add	x16, x16, #0
ushr.8b	v12, v1, #4
ld1.2s	{ v16 }, [x16]
sshl.8b	v3, v1, v5
movi.8b	v7, #2
umin.8b	v3, v3, v6
add.8b	v0, v1, v7
umax.8b	v11, v3, v4
add.8b	v0, v0, v0
cmtst.2s	v14, v14, v16
ushll.8h	v12, v12, #0
add.8b	v10, v0, v11
cmtst.2s	v13, v13, v16
ushll.8h	v11, v11, #0
ushll.8h	v10, v10, #0
and.8b	v13, v13, v2
sshll.8h	v14, v14, #0
sshll.8h	v13, v13, #0
ushl.8h	v12, v12, v31
ushl.8h	v11, v11, v31
ushl.8h	v10, v10, v31
tst	w7, #0x3
b.eq	lpf_v_sb_uv_16bpc_neon
bl	lpf_v_6_8_neon
b	lpf_v_sb_uv_16bpc_neon
bl	lpf_v_4_8_neon
lsr	w6, w6, #2
lsr	w7, w7, #2
add	x0, x0, #16
cbnz	w6, lpf_v_sb_uv_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
_lpf_h_sb_uv_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #24
sub	w9, w10, w9
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
add	x5, x5, #128
sub	x3, x3, #4
lsl	x4, x4, #2
orr	w6, w6, w7
tst	w6, #0x3
ld2.s	{ v0, v1 }[0], [x3], x4
ld2.s	{ v0, v1 }[1], [x3], x4
b.eq	lpf_h_sb_uv_16bpc_neon
ld1r.8b	{ v5 }, [x5]
add	x5, x5, #8
movi.2s	v2, #255
dup.2s	v13, w6
dup.8h	v31, w9
and.8b	v0, v0, v2
and.8b	v1, v1, v2
cmtst.8b	v3, v1, v2
movi.8b	v4, #1
ld1r.8b	{ v6 }, [x5]
sub	x5, x5, #8
bif.8b	v1, v0, v3
cmtst.2s	v2, v1, v2
mul.2s	v1, v1, v4
dup.2s	v14, w7
mov.d	x16, v2[0]
cmp	x16, #0
b.eq	lpf_h_sb_uv_16bpc_neon
neg.8b	v5, v5
adrp	x16, lpf_h_sb_uv_16bpc_neon
add	x16, x16, #0
ushr.8b	v12, v1, #4
ld1.2s	{ v16 }, [x16]
sshl.8b	v3, v1, v5
movi.8b	v7, #2
umin.8b	v3, v3, v6
add.8b	v0, v1, v7
umax.8b	v11, v3, v4
add.8b	v0, v0, v0
cmtst.2s	v14, v14, v16
ushll.8h	v12, v12, #0
add.8b	v10, v0, v11
cmtst.2s	v13, v13, v16
ushll.8h	v11, v11, #0
ushll.8h	v10, v10, #0
and.8b	v13, v13, v2
sshll.8h	v14, v14, #0
sshll.8h	v13, v13, #0
ushl.8h	v12, v12, v31
ushl.8h	v11, v11, v31
ushl.8h	v10, v10, v31
tst	w7, #0x3
b.eq	lpf_h_sb_uv_16bpc_neon
bl	lpf_h_6_8_neon
b	lpf_h_sb_uv_16bpc_neon
bl	lpf_h_4_8_neon
b	lpf_h_sb_uv_16bpc_neon
add	x0, x0, x1, lsl #3
lsr	w6, w6, #2
lsr	w7, w7, #2
cbnz	w6, lpf_h_sb_uv_16bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11