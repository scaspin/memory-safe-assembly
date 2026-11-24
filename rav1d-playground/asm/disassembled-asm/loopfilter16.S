	.text
lpf_8_wd16_neon:
uabd	v0.8h, v22.8h, v23.8h
uabd	v1.8h, v25.8h, v24.8h
uabd	v2.8h, v23.8h, v24.8h
uabd	v3.8h, v22.8h, v25.8h
uabd	v4.8h, v21.8h, v22.8h
uabd	v5.8h, v26.8h, v25.8h
uabd	v6.8h, v20.8h, v21.8h
uabd	v7.8h, v27.8h, v26.8h
umax	v4.8h, v4.8h, v5.8h
uqadd	v2.8h, v2.8h, v2.8h
umax	v6.8h, v6.8h, v7.8h
ushr	v3.8h, v3.8h, #0x1
umax	v4.8h, v4.8h, v6.8h
and	v4.16b, v4.16b, v14.16b
umax	v0.8h, v0.8h, v1.8h
uqadd	v2.8h, v2.8h, v3.8h
umax	v4.8h, v0.8h, v4.8h
cmhs	v1.8h, v11.8h, v4.8h
cmhs	v2.8h, v10.8h, v2.8h
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
and	v14.16b, v14.16b, v1.16b
and	v15.16b, v15.16b, v1.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_74
mov	x14, #0x1
ret
L_74:
movi	v10.8h, #0x1
uabd	v2.8h, v21.8h, v23.8h
uabd	v3.8h, v22.8h, v23.8h
uabd	v4.8h, v25.8h, v24.8h
uabd	v5.8h, v26.8h, v24.8h
dup	v9.8h, w9
uabd	v6.8h, v20.8h, v23.8h
uabd	v7.8h, v27.8h, v24.8h
umax	v2.8h, v2.8h, v3.8h
umax	v4.8h, v4.8h, v5.8h
umax	v6.8h, v6.8h, v7.8h
umax	v2.8h, v2.8h, v4.8h
ushl	v10.8h, v10.8h, v9.8h
umax	v2.8h, v2.8h, v6.8h
uabd	v3.8h, v17.8h, v23.8h
uabd	v4.8h, v18.8h, v23.8h
uabd	v5.8h, v19.8h, v23.8h
cmhs	v2.8h, v10.8h, v2.8h
uabd	v6.8h, v28.8h, v24.8h
uabd	v7.8h, v29.8h, v24.8h
uabd	v8.8h, v30.8h, v24.8h
and	v14.16b, v2.16b, v14.16b
bic	v1.16b, v1.16b, v14.16b
umax	v3.8h, v3.8h, v4.8h
umax	v5.8h, v5.8h, v6.8h
mov	x16, v1.d[0]
mov	x17, v1.d[1]
umax	v7.8h, v7.8h, v8.8h
umax	v3.8h, v3.8h, v5.8h
umax	v3.8h, v3.8h, v7.8h
cmhs	v3.8h, v10.8h, v3.8h
adds	x16, x16, x17
and	v15.16b, v15.16b, v3.16b
and	v15.16b, v15.16b, v14.16b
bic	v14.16b, v14.16b, v15.16b
b.eq	L_1a8
dup	v3.8h, w8
sub	v2.8h, v22.8h, v25.8h
ushr	v3.8h, v3.8h, #0x1
cmhi	v0.8h, v0.8h, v12.8h
mvn	v9.16b, v3.16b
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
and	v4.16b, v2.16b, v0.16b
sub	v2.8h, v24.8h, v23.8h
movi	v5.8h, #0x3
bic	v0.16b, v1.16b, v0.16b
mul	v2.8h, v2.8h, v5.8h
movi	v6.8h, #0x4
add	v2.8h, v2.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
sqadd	v4.8h, v6.8h, v2.8h
sqadd	v5.8h, v5.8h, v2.8h
smin	v4.8h, v4.8h, v3.8h
smin	v5.8h, v5.8h, v3.8h
sshr	v4.8h, v4.8h, #0x3
sshr	v5.8h, v5.8h, #0x3
movi	v9.8h, #0x0
dup	v3.8h, w8
sqadd	v2.8h, v23.8h, v5.8h
sqsub	v6.8h, v24.8h, v4.8h
srshr	v4.8h, v4.8h, #0x1
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v6.16b, v1.16b
sqadd	v2.8h, v22.8h, v4.8h
sqsub	v6.8h, v25.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v6.16b, v0.16b
L_1a8:
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_248
add	v0.8h, v20.8h, v21.8h
add	v2.8h, v22.8h, v25.8h
add	v4.8h, v20.8h, v22.8h
add	v6.8h, v23.8h, v26.8h
add	v8.8h, v0.8h, v0.8h
add	v9.8h, v23.8h, v24.8h
add	v8.8h, v8.8h, v4.8h
sub	v2.8h, v2.8h, v0.8h
add	v8.8h, v8.8h, v9.8h
sub	v6.8h, v6.8h, v4.8h
urshr	v10.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v0.8h, v20.8h, v23.8h
add	v2.8h, v24.8h, v27.8h
urshr	v11.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v6.8h
sub	v2.8h, v2.8h, v0.8h
add	v4.8h, v21.8h, v24.8h
add	v6.8h, v25.8h, v27.8h
urshr	v12.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v2.8h
sub	v6.8h, v6.8h, v4.8h
add	v0.8h, v22.8h, v25.8h
add	v2.8h, v26.8h, v27.8h
urshr	v13.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v6.8h
sub	v2.8h, v2.8h, v0.8h
urshr	v0.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v2.8h
bit	v21.16b, v10.16b, v14.16b
bit	v22.16b, v11.16b, v14.16b
bit	v23.16b, v12.16b, v14.16b
urshr	v1.8h, v8.8h, #0x3
bit	v24.16b, v13.16b, v14.16b
bit	v25.16b, v0.16b, v14.16b
bit	v26.16b, v1.16b, v14.16b
L_248:
mov	x16, v15.d[0]
mov	x17, v15.d[1]
adds	x16, x16, x17
b.ne	L_26c
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_3c0
b	L_3b8
L_26c:
add	v2.8h, v17.8h, v17.8h
add	v4.8h, v17.8h, v18.8h
add	v6.8h, v17.8h, v19.8h
add	v8.8h, v17.8h, v20.8h
add	v12.8h, v2.8h, v4.8h
add	v10.8h, v6.8h, v8.8h
add	v6.8h, v17.8h, v21.8h
add	v12.8h, v12.8h, v10.8h
add	v8.8h, v17.8h, v22.8h
add	v10.8h, v18.8h, v23.8h
add	v6.8h, v6.8h, v8.8h
add	v8.8h, v19.8h, v24.8h
add	v12.8h, v12.8h, v6.8h
add	v10.8h, v10.8h, v8.8h
add	v6.8h, v20.8h, v25.8h
add	v12.8h, v12.8h, v10.8h
sub	v6.8h, v6.8h, v2.8h
add	v2.8h, v21.8h, v26.8h
urshr	v0.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v6.8h
sub	v2.8h, v2.8h, v4.8h
add	v4.8h, v22.8h, v27.8h
add	v6.8h, v17.8h, v19.8h
urshr	v1.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v2.8h
sub	v4.8h, v4.8h, v6.8h
add	v6.8h, v23.8h, v28.8h
add	v8.8h, v17.8h, v20.8h
urshr	v2.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v4.8h
sub	v6.8h, v6.8h, v8.8h
add	v8.8h, v24.8h, v29.8h
add	v4.8h, v17.8h, v21.8h
urshr	v3.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v6.8h
sub	v8.8h, v8.8h, v4.8h
add	v6.8h, v25.8h, v30.8h
add	v10.8h, v17.8h, v22.8h
urshr	v4.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v8.8h
sub	v6.8h, v6.8h, v10.8h
add	v8.8h, v26.8h, v30.8h
bif	v0.16b, v18.16b, v15.16b
add	v10.8h, v18.8h, v23.8h
urshr	v5.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v6.8h
sub	v8.8h, v8.8h, v10.8h
add	v10.8h, v27.8h, v30.8h
bif	v1.16b, v19.16b, v15.16b
add	v18.8h, v19.8h, v24.8h
urshr	v6.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v8.8h
sub	v10.8h, v10.8h, v18.8h
add	v8.8h, v28.8h, v30.8h
bif	v2.16b, v20.16b, v15.16b
add	v18.8h, v20.8h, v25.8h
urshr	v7.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v10.8h
sub	v18.8h, v8.8h, v18.8h
add	v10.8h, v29.8h, v30.8h
bif	v3.16b, v21.16b, v15.16b
add	v20.8h, v21.8h, v26.8h
urshr	v8.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v18.8h
sub	v10.8h, v10.8h, v20.8h
add	v18.8h, v30.8h, v30.8h
bif	v4.16b, v22.16b, v15.16b
add	v20.8h, v22.8h, v27.8h
urshr	v9.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v10.8h
sub	v18.8h, v18.8h, v20.8h
bif	v5.16b, v23.16b, v15.16b
urshr	v10.8h, v12.8h, #0x4
add	v12.8h, v12.8h, v18.8h
urshr	v11.8h, v12.8h, #0x4
bif	v6.16b, v24.16b, v15.16b
bif	v7.16b, v25.16b, v15.16b
bif	v8.16b, v26.16b, v15.16b
bif	v9.16b, v27.16b, v15.16b
bif	v10.16b, v28.16b, v15.16b
bif	v11.16b, v29.16b, v15.16b
mov	x14, #0x0
ret
L_3b8:
mov	x14, #0x40
ret
L_3c0:
mov	x14, #0x10
ret
lpf_8_wd8_neon:
uabd	v0.8h, v22.8h, v23.8h
uabd	v1.8h, v25.8h, v24.8h
uabd	v2.8h, v23.8h, v24.8h
uabd	v3.8h, v22.8h, v25.8h
uabd	v4.8h, v21.8h, v22.8h
uabd	v5.8h, v26.8h, v25.8h
uabd	v6.8h, v20.8h, v21.8h
uabd	v7.8h, v27.8h, v26.8h
umax	v4.8h, v4.8h, v5.8h
uqadd	v2.8h, v2.8h, v2.8h
umax	v6.8h, v6.8h, v7.8h
ushr	v3.8h, v3.8h, #0x1
umax	v4.8h, v4.8h, v6.8h
and	v4.16b, v4.16b, v14.16b
umax	v0.8h, v0.8h, v1.8h
uqadd	v2.8h, v2.8h, v3.8h
umax	v4.8h, v0.8h, v4.8h
cmhs	v1.8h, v11.8h, v4.8h
cmhs	v2.8h, v10.8h, v2.8h
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
and	v14.16b, v14.16b, v1.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_438
mov	x14, #0x1
ret
L_438:
movi	v10.8h, #0x1
uabd	v2.8h, v21.8h, v23.8h
uabd	v3.8h, v22.8h, v23.8h
uabd	v4.8h, v25.8h, v24.8h
uabd	v5.8h, v26.8h, v24.8h
dup	v9.8h, w9
uabd	v6.8h, v20.8h, v23.8h
uabd	v7.8h, v27.8h, v24.8h
umax	v2.8h, v2.8h, v3.8h
umax	v4.8h, v4.8h, v5.8h
umax	v6.8h, v6.8h, v7.8h
umax	v2.8h, v2.8h, v4.8h
ushl	v10.8h, v10.8h, v9.8h
umax	v2.8h, v2.8h, v6.8h
cmhs	v2.8h, v10.8h, v2.8h
and	v14.16b, v2.16b, v14.16b
bic	v1.16b, v1.16b, v14.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.eq	L_530
dup	v3.8h, w8
sub	v2.8h, v22.8h, v25.8h
ushr	v3.8h, v3.8h, #0x1
cmhi	v0.8h, v0.8h, v12.8h
mvn	v9.16b, v3.16b
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
and	v4.16b, v2.16b, v0.16b
sub	v2.8h, v24.8h, v23.8h
movi	v5.8h, #0x3
bic	v0.16b, v1.16b, v0.16b
mul	v2.8h, v2.8h, v5.8h
movi	v6.8h, #0x4
add	v2.8h, v2.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
sqadd	v4.8h, v6.8h, v2.8h
sqadd	v5.8h, v5.8h, v2.8h
smin	v4.8h, v4.8h, v3.8h
smin	v5.8h, v5.8h, v3.8h
sshr	v4.8h, v4.8h, #0x3
sshr	v5.8h, v5.8h, #0x3
movi	v9.8h, #0x0
dup	v3.8h, w8
sqadd	v2.8h, v23.8h, v5.8h
sqsub	v6.8h, v24.8h, v4.8h
srshr	v4.8h, v4.8h, #0x1
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v6.16b, v1.16b
sqadd	v2.8h, v22.8h, v4.8h
sqsub	v6.8h, v25.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v6.16b, v0.16b
L_530:
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_5d8
add	v0.8h, v20.8h, v21.8h
add	v2.8h, v22.8h, v25.8h
add	v4.8h, v20.8h, v22.8h
add	v6.8h, v23.8h, v26.8h
add	v8.8h, v0.8h, v0.8h
add	v9.8h, v23.8h, v24.8h
add	v8.8h, v8.8h, v4.8h
sub	v2.8h, v2.8h, v0.8h
add	v8.8h, v8.8h, v9.8h
sub	v6.8h, v6.8h, v4.8h
urshr	v10.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v0.8h, v20.8h, v23.8h
add	v2.8h, v24.8h, v27.8h
urshr	v11.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v6.8h
sub	v2.8h, v2.8h, v0.8h
add	v4.8h, v21.8h, v24.8h
add	v6.8h, v25.8h, v27.8h
urshr	v12.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v2.8h
sub	v6.8h, v6.8h, v4.8h
add	v0.8h, v22.8h, v25.8h
add	v2.8h, v26.8h, v27.8h
urshr	v13.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v6.8h
sub	v2.8h, v2.8h, v0.8h
urshr	v0.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v2.8h
bit	v21.16b, v10.16b, v14.16b
bit	v22.16b, v11.16b, v14.16b
bit	v23.16b, v12.16b, v14.16b
urshr	v1.8h, v8.8h, #0x3
bit	v24.16b, v13.16b, v14.16b
bit	v25.16b, v0.16b, v14.16b
bit	v26.16b, v1.16b, v14.16b
mov	x14, #0x0
ret
L_5d8:
mov	x14, #0x10
ret
lpf_8_wd6_neon:
uabd	v0.8h, v22.8h, v23.8h
uabd	v1.8h, v25.8h, v24.8h
uabd	v2.8h, v23.8h, v24.8h
uabd	v3.8h, v22.8h, v25.8h
uabd	v4.8h, v21.8h, v22.8h
uabd	v5.8h, v26.8h, v25.8h
umax	v4.8h, v4.8h, v5.8h
uqadd	v2.8h, v2.8h, v2.8h
ushr	v3.8h, v3.8h, #0x1
and	v4.16b, v4.16b, v14.16b
umax	v0.8h, v0.8h, v1.8h
uqadd	v2.8h, v2.8h, v3.8h
umax	v4.8h, v0.8h, v4.8h
cmhs	v1.8h, v11.8h, v4.8h
cmhs	v2.8h, v10.8h, v2.8h
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
and	v14.16b, v14.16b, v1.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_640
mov	x14, #0x1
ret
L_640:
movi	v10.8h, #0x1
uabd	v2.8h, v21.8h, v23.8h
uabd	v3.8h, v22.8h, v23.8h
uabd	v4.8h, v25.8h, v24.8h
uabd	v5.8h, v26.8h, v24.8h
dup	v9.8h, w9
umax	v2.8h, v2.8h, v3.8h
umax	v4.8h, v4.8h, v5.8h
umax	v2.8h, v2.8h, v4.8h
ushl	v10.8h, v10.8h, v9.8h
cmhs	v2.8h, v10.8h, v2.8h
and	v14.16b, v2.16b, v14.16b
bic	v1.16b, v1.16b, v14.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.eq	L_728
dup	v3.8h, w8
sub	v2.8h, v22.8h, v25.8h
ushr	v3.8h, v3.8h, #0x1
cmhi	v0.8h, v0.8h, v12.8h
mvn	v9.16b, v3.16b
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
and	v4.16b, v2.16b, v0.16b
sub	v2.8h, v24.8h, v23.8h
movi	v5.8h, #0x3
bic	v0.16b, v1.16b, v0.16b
mul	v2.8h, v2.8h, v5.8h
movi	v6.8h, #0x4
add	v2.8h, v2.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
sqadd	v4.8h, v6.8h, v2.8h
sqadd	v5.8h, v5.8h, v2.8h
smin	v4.8h, v4.8h, v3.8h
smin	v5.8h, v5.8h, v3.8h
sshr	v4.8h, v4.8h, #0x3
sshr	v5.8h, v5.8h, #0x3
movi	v9.8h, #0x0
dup	v3.8h, w8
sqadd	v2.8h, v23.8h, v5.8h
sqsub	v6.8h, v24.8h, v4.8h
srshr	v4.8h, v4.8h, #0x1
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v6.16b, v1.16b
sqadd	v2.8h, v22.8h, v4.8h
sqsub	v6.8h, v25.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v6.16b, v0.16b
L_728:
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_798
add	v0.8h, v21.8h, v21.8h
add	v2.8h, v21.8h, v22.8h
add	v4.8h, v22.8h, v23.8h
add	v6.8h, v23.8h, v24.8h
add	v8.8h, v0.8h, v2.8h
add	v10.8h, v4.8h, v6.8h
add	v12.8h, v24.8h, v25.8h
add	v8.8h, v8.8h, v10.8h
sub	v12.8h, v12.8h, v0.8h
add	v10.8h, v25.8h, v26.8h
urshr	v0.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v12.8h
sub	v10.8h, v10.8h, v2.8h
add	v12.8h, v26.8h, v26.8h
urshr	v1.8h, v8.8h, #0x3
add	v8.8h, v8.8h, v10.8h
sub	v12.8h, v12.8h, v4.8h
urshr	v2.8h, v8.8h, #0x3
bit	v22.16b, v0.16b, v14.16b
add	v8.8h, v8.8h, v12.8h
bit	v23.16b, v1.16b, v14.16b
urshr	v3.8h, v8.8h, #0x3
bit	v24.16b, v2.16b, v14.16b
bit	v25.16b, v3.16b, v14.16b
L_798:
mov	x14, #0x0
ret
lpf_8_wd4_neon:
uabd	v0.8h, v22.8h, v23.8h
uabd	v1.8h, v25.8h, v24.8h
uabd	v2.8h, v23.8h, v24.8h
uabd	v3.8h, v22.8h, v25.8h
uqadd	v2.8h, v2.8h, v2.8h
ushr	v3.8h, v3.8h, #0x1
umax	v0.8h, v0.8h, v1.8h
uqadd	v2.8h, v2.8h, v3.8h
cmhs	v1.8h, v11.8h, v0.8h
cmhs	v2.8h, v10.8h, v2.8h
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_7e8
mov	x14, #0x1
ret
L_7e8:
dup	v3.8h, w8
sub	v2.8h, v22.8h, v25.8h
ushr	v3.8h, v3.8h, #0x1
cmhi	v0.8h, v0.8h, v12.8h
mvn	v9.16b, v3.16b
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
and	v4.16b, v2.16b, v0.16b
sub	v2.8h, v24.8h, v23.8h
movi	v5.8h, #0x3
bic	v0.16b, v1.16b, v0.16b
mul	v2.8h, v2.8h, v5.8h
movi	v6.8h, #0x4
add	v2.8h, v2.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
sqadd	v4.8h, v6.8h, v2.8h
sqadd	v5.8h, v5.8h, v2.8h
smin	v4.8h, v4.8h, v3.8h
smin	v5.8h, v5.8h, v3.8h
sshr	v4.8h, v4.8h, #0x3
sshr	v5.8h, v5.8h, #0x3
movi	v9.8h, #0x0
dup	v3.8h, w8
sqadd	v2.8h, v23.8h, v5.8h
sqsub	v6.8h, v24.8h, v4.8h
srshr	v4.8h, v4.8h, #0x1
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v6.16b, v1.16b
sqadd	v2.8h, v22.8h, v4.8h
sqsub	v6.8h, v25.8h, v4.8h
smin	v2.8h, v2.8h, v3.8h
smin	v6.8h, v6.8h, v3.8h
smax	v2.8h, v2.8h, v9.8h
smax	v6.8h, v6.8h, v9.8h
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v6.16b, v0.16b
mov	x14, #0x0
ret
lpf_v_4_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
ld1	{ v22.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
bl	lpf_8_wd4_neon
cbz	x14, L_8bc
ret	x15
L_8bc:
sub	x16, x0, x1, lsl #1
st1	{ v22.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_4_8_neon:
mov	x15, x30
sub	x16, x0, #0x4
add	x0, x16, x1, lsl #2
ld1	{ v22.d }[0], [x16], x1
ld1	{ v22.d }[1], [x0], x1
ld1	{ v23.d }[0], [x16], x1
ld1	{ v23.d }[1], [x0], x1
ld1	{ v24.d }[0], [x16], x1
ld1	{ v24.d }[1], [x0], x1
ld1	{ v25.d }[0], [x16], x1
ld1	{ v25.d }[1], [x0], x1
add	x0, x0, #0x4
trn1	v26.8h, v22.8h, v23.8h
trn2	v27.8h, v22.8h, v23.8h
trn1	v28.8h, v24.8h, v25.8h
trn2	v29.8h, v24.8h, v25.8h
trn1	v22.4s, v26.4s, v28.4s
trn2	v24.4s, v26.4s, v28.4s
trn1	v23.4s, v27.4s, v29.4s
trn2	v25.4s, v27.4s, v29.4s
bl	lpf_8_wd4_neon
cbz	x14, L_934
ret	x15
L_934:
sub	x16, x0, x1, lsl #3
sub	x16, x16, #0x4
trn1	v26.8h, v22.8h, v23.8h
trn2	v27.8h, v22.8h, v23.8h
trn1	v28.8h, v24.8h, v25.8h
trn2	v29.8h, v24.8h, v25.8h
trn1	v22.4s, v26.4s, v28.4s
trn2	v24.4s, v26.4s, v28.4s
trn1	v23.4s, v27.4s, v29.4s
trn2	v25.4s, v27.4s, v29.4s
add	x0, x16, x1, lsl #2
st1	{ v22.d }[0], [x16], x1
st1	{ v22.d }[1], [x0], x1
st1	{ v23.d }[0], [x16], x1
st1	{ v23.d }[1], [x0], x1
st1	{ v24.d }[0], [x16], x1
st1	{ v24.d }[1], [x0], x1
st1	{ v25.d }[0], [x16], x1
st1	{ v25.d }[1], [x0], x1
add	x0, x0, #0x4
ret	x15
lpf_v_6_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
ld1	{ v21.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v22.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v26.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
bl	lpf_8_wd6_neon
cbz	x14, L_9c0
ret	x15
L_9c0:
sub	x16, x0, x1, lsl #1
st1	{ v22.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_6_8_neon:
mov	x15, x30
sub	x16, x0, #0x8
add	x0, x16, x1, lsl #2
ld1	{ v20.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v21.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
ld1	{ v22.8h }, [x16], x1
ld1	{ v26.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v27.8h }, [x0], x1
add	x0, x0, #0x8
trn1	v28.8h, v20.8h, v21.8h
trn2	v29.8h, v20.8h, v21.8h
trn1	v21.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.8h, v24.8h, v25.8h
trn2	v25.8h, v24.8h, v25.8h
trn1	v22.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.4s, v20.4s, v22.4s
trn2	v22.4s, v20.4s, v22.4s
trn1	v26.4s, v25.4s, v27.4s
trn2	v27.4s, v25.4s, v27.4s
trn1	v25.4s, v29.4s, v23.4s
trn2	v29.4s, v29.4s, v23.4s
trn1	v23.4s, v28.4s, v21.4s
trn2	v28.4s, v28.4s, v21.4s
trn1	v20.2d, v23.2d, v24.2d
trn2	v24.2d, v23.2d, v24.2d
trn1	v21.2d, v25.2d, v26.2d
trn2	v25.2d, v25.2d, v26.2d
trn2	v26.2d, v28.2d, v22.2d
trn1	v22.2d, v28.2d, v22.2d
trn1	v23.2d, v29.2d, v27.2d
trn2	v27.2d, v29.2d, v27.2d
bl	lpf_8_wd6_neon
cbz	x14, L_a78
ret	x15
L_a78:
sub	x16, x0, x1, lsl #3
sub	x16, x16, #0x4
trn1	v26.8h, v22.8h, v23.8h
trn2	v27.8h, v22.8h, v23.8h
trn1	v28.8h, v24.8h, v25.8h
trn2	v29.8h, v24.8h, v25.8h
trn1	v22.4s, v26.4s, v28.4s
trn2	v24.4s, v26.4s, v28.4s
trn1	v23.4s, v27.4s, v29.4s
trn2	v25.4s, v27.4s, v29.4s
add	x0, x16, x1, lsl #2
st1	{ v22.d }[0], [x16], x1
st1	{ v22.d }[1], [x0], x1
st1	{ v23.d }[0], [x16], x1
st1	{ v23.d }[1], [x0], x1
st1	{ v24.d }[0], [x16], x1
st1	{ v24.d }[1], [x0], x1
st1	{ v25.d }[0], [x16], x1
st1	{ v25.d }[1], [x0], x1
add	x0, x0, #0x4
ret	x15
lpf_v_8_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #2
ld1	{ v20.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v21.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
ld1	{ v22.8h }, [x16], x1
ld1	{ v26.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v27.8h }, [x0], x1
sub	x0, x0, x1, lsl #2
bl	lpf_8_wd8_neon
cbz	x14, L_b08
tbnz	w14, #0x4, L_b34
ret	x15
L_b08:
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
st1	{ v21.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v22.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v26.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
L_b34:
sub	x16, x0, x1, lsl #1
st1	{ v22.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_8_8_neon:
mov	x15, x30
sub	x16, x0, #0x8
add	x0, x16, x1, lsl #2
ld1	{ v20.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v21.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
ld1	{ v22.8h }, [x16], x1
ld1	{ v26.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v27.8h }, [x0], x1
add	x0, x0, #0x8
trn1	v28.8h, v20.8h, v21.8h
trn2	v29.8h, v20.8h, v21.8h
trn1	v21.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.8h, v24.8h, v25.8h
trn2	v25.8h, v24.8h, v25.8h
trn1	v22.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.4s, v20.4s, v22.4s
trn2	v22.4s, v20.4s, v22.4s
trn1	v26.4s, v25.4s, v27.4s
trn2	v27.4s, v25.4s, v27.4s
trn1	v25.4s, v29.4s, v23.4s
trn2	v29.4s, v29.4s, v23.4s
trn1	v23.4s, v28.4s, v21.4s
trn2	v28.4s, v28.4s, v21.4s
trn1	v20.2d, v23.2d, v24.2d
trn2	v24.2d, v23.2d, v24.2d
trn1	v21.2d, v25.2d, v26.2d
trn2	v25.2d, v25.2d, v26.2d
trn2	v26.2d, v28.2d, v22.2d
trn1	v22.2d, v28.2d, v22.2d
trn1	v23.2d, v29.2d, v27.2d
trn2	v27.2d, v29.2d, v27.2d
bl	lpf_8_wd8_neon
cbz	x14, L_bf0
tbnz	w14, #0x4, L_c84
ret	x15
L_bf0:
sub	x16, x0, x1, lsl #3
sub	x16, x16, #0x8
trn1	v28.8h, v20.8h, v21.8h
trn2	v29.8h, v20.8h, v21.8h
trn1	v21.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.8h, v24.8h, v25.8h
trn2	v25.8h, v24.8h, v25.8h
trn1	v22.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.4s, v20.4s, v22.4s
trn2	v22.4s, v20.4s, v22.4s
trn1	v26.4s, v25.4s, v27.4s
trn2	v27.4s, v25.4s, v27.4s
trn1	v25.4s, v29.4s, v23.4s
trn2	v29.4s, v29.4s, v23.4s
trn1	v23.4s, v28.4s, v21.4s
trn2	v28.4s, v28.4s, v21.4s
trn1	v20.2d, v23.2d, v24.2d
trn2	v24.2d, v23.2d, v24.2d
trn1	v21.2d, v25.2d, v26.2d
trn2	v25.2d, v25.2d, v26.2d
trn2	v26.2d, v28.2d, v22.2d
trn1	v22.2d, v28.2d, v22.2d
trn1	v23.2d, v29.2d, v27.2d
trn2	v27.2d, v29.2d, v27.2d
add	x0, x16, x1, lsl #2
st1	{ v20.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v21.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
st1	{ v22.8h }, [x16], x1
st1	{ v26.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v27.8h }, [x0], x1
add	x0, x0, #0x8
ret	x15
L_c84:
sub	x16, x0, x1, lsl #3
sub	x16, x16, #0x4
trn1	v26.8h, v22.8h, v23.8h
trn2	v27.8h, v22.8h, v23.8h
trn1	v28.8h, v24.8h, v25.8h
trn2	v29.8h, v24.8h, v25.8h
trn1	v22.4s, v26.4s, v28.4s
trn2	v24.4s, v26.4s, v28.4s
trn1	v23.4s, v27.4s, v29.4s
trn2	v25.4s, v27.4s, v29.4s
add	x0, x16, x1, lsl #2
st1	{ v22.d }[0], [x16], x1
st1	{ v22.d }[1], [x0], x1
st1	{ v23.d }[0], [x16], x1
st1	{ v23.d }[1], [x0], x1
st1	{ v24.d }[0], [x16], x1
st1	{ v24.d }[1], [x0], x1
st1	{ v25.d }[0], [x16], x1
st1	{ v25.d }[1], [x0], x1
add	x0, x0, #0x4
ret	x15
lpf_v_16_8_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #3
add	x16, x16, x1
ld1	{ v17.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v18.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
ld1	{ v19.8h }, [x16], x1
ld1	{ v26.8h }, [x0], x1
ld1	{ v20.8h }, [x16], x1
ld1	{ v27.8h }, [x0], x1
ld1	{ v21.8h }, [x16], x1
ld1	{ v28.8h }, [x0], x1
ld1	{ v22.8h }, [x16], x1
ld1	{ v29.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v30.8h }, [x0], x1
sub	x0, x0, x1, lsl #3
add	x0, x0, x1
bl	lpf_8_wd16_neon
cbz	x14, L_d38
tbnz	w14, #0x6, L_d7c
tbnz	w14, #0x4, L_da8
ret	x15
L_d38:
sub	x16, x0, x1, lsl #2
sub	x16, x16, x1, lsl #1
st1	{ v0.8h }, [x16], x1
st1	{ v6.8h }, [x0], x1
st1	{ v1.8h }, [x16], x1
st1	{ v7.8h }, [x0], x1
st1	{ v2.8h }, [x16], x1
st1	{ v8.8h }, [x0], x1
st1	{ v3.8h }, [x16], x1
st1	{ v9.8h }, [x0], x1
st1	{ v4.8h }, [x16], x1
st1	{ v10.8h }, [x0], x1
st1	{ v5.8h }, [x16], x1
st1	{ v11.8h }, [x0], x1
sub	x0, x0, x1, lsl #2
sub	x0, x0, x1, lsl #1
ret	x15
L_d7c:
sub	x16, x0, x1
sub	x16, x16, x1, lsl #1
st1	{ v21.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v22.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v26.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
L_da8:
sub	x16, x0, x1, lsl #1
st1	{ v22.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_16_8_neon:
mov	x15, x30
sub	x16, x0, #0x10
ld1	{ v16.8h }, [x16], x1
ld1	{ v24.8h }, [x0], x1
ld1	{ v17.8h }, [x16], x1
ld1	{ v25.8h }, [x0], x1
ld1	{ v18.8h }, [x16], x1
ld1	{ v26.8h }, [x0], x1
ld1	{ v19.8h }, [x16], x1
ld1	{ v27.8h }, [x0], x1
ld1	{ v20.8h }, [x16], x1
ld1	{ v28.8h }, [x0], x1
ld1	{ v21.8h }, [x16], x1
ld1	{ v29.8h }, [x0], x1
ld1	{ v22.8h }, [x16], x1
ld1	{ v30.8h }, [x0], x1
ld1	{ v23.8h }, [x16], x1
ld1	{ v31.8h }, [x0], x1
trn1	v0.8h, v16.8h, v17.8h
trn2	v1.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v1.4s, v19.4s
trn2	v1.4s, v1.4s, v19.4s
trn1	v19.4s, v0.4s, v17.4s
trn2	v0.4s, v0.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v0.2d, v18.2d
trn1	v18.2d, v0.2d, v18.2d
trn1	v19.2d, v1.2d, v23.2d
trn2	v23.2d, v1.2d, v23.2d
trn1	v0.8h, v24.8h, v25.8h
trn2	v1.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v1.4s, v27.4s
trn2	v1.4s, v1.4s, v27.4s
trn1	v27.4s, v0.4s, v25.4s
trn2	v0.4s, v0.4s, v25.4s
trn1	v24.2d, v27.2d, v28.2d
trn2	v28.2d, v27.2d, v28.2d
trn1	v25.2d, v29.2d, v30.2d
trn2	v29.2d, v29.2d, v30.2d
trn2	v30.2d, v0.2d, v26.2d
trn1	v26.2d, v0.2d, v26.2d
trn1	v27.2d, v1.2d, v31.2d
trn2	v31.2d, v1.2d, v31.2d
bl	lpf_8_wd16_neon
cbz	x14, L_ee0
tbnz	w14, #0x6, L_fec
tbnz	w14, #0x4, L_1080
ret	x15
L_ee0:
sub	x0, x0, x1, lsl #3
sub	x16, x0, #0x10
trn1	v18.8h, v16.8h, v17.8h
trn2	v19.8h, v16.8h, v17.8h
trn1	v17.8h, v0.8h, v1.8h
trn2	v1.8h, v0.8h, v1.8h
trn1	v16.8h, v2.8h, v3.8h
trn2	v3.8h, v2.8h, v3.8h
trn1	v0.8h, v4.8h, v5.8h
trn2	v5.8h, v4.8h, v5.8h
trn1	v2.4s, v16.4s, v0.4s
trn2	v0.4s, v16.4s, v0.4s
trn1	v4.4s, v3.4s, v5.4s
trn2	v5.4s, v3.4s, v5.4s
trn1	v3.4s, v19.4s, v1.4s
trn2	v19.4s, v19.4s, v1.4s
trn1	v1.4s, v18.4s, v17.4s
trn2	v18.4s, v18.4s, v17.4s
trn1	v16.2d, v1.2d, v2.2d
trn2	v2.2d, v1.2d, v2.2d
trn1	v17.2d, v3.2d, v4.2d
trn2	v3.2d, v3.2d, v4.2d
trn2	v4.2d, v18.2d, v0.2d
trn1	v0.2d, v18.2d, v0.2d
trn1	v1.2d, v19.2d, v5.2d
trn2	v5.2d, v19.2d, v5.2d
trn1	v18.8h, v6.8h, v7.8h
trn2	v19.8h, v6.8h, v7.8h
trn1	v7.8h, v8.8h, v9.8h
trn2	v9.8h, v8.8h, v9.8h
trn1	v6.8h, v10.8h, v11.8h
trn2	v11.8h, v10.8h, v11.8h
trn1	v8.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v10.4s, v6.4s, v8.4s
trn2	v8.4s, v6.4s, v8.4s
trn1	v30.4s, v11.4s, v31.4s
trn2	v31.4s, v11.4s, v31.4s
trn1	v11.4s, v19.4s, v9.4s
trn2	v19.4s, v19.4s, v9.4s
trn1	v9.4s, v18.4s, v7.4s
trn2	v18.4s, v18.4s, v7.4s
trn1	v6.2d, v9.2d, v10.2d
trn2	v10.2d, v9.2d, v10.2d
trn1	v7.2d, v11.2d, v30.2d
trn2	v11.2d, v11.2d, v30.2d
trn2	v30.2d, v18.2d, v8.2d
trn1	v8.2d, v18.2d, v8.2d
trn1	v9.2d, v19.2d, v31.2d
trn2	v31.2d, v19.2d, v31.2d
st1	{ v16.8h }, [x16], x1
st1	{ v6.8h }, [x0], x1
st1	{ v17.8h }, [x16], x1
st1	{ v7.8h }, [x0], x1
st1	{ v0.8h }, [x16], x1
st1	{ v8.8h }, [x0], x1
st1	{ v1.8h }, [x16], x1
st1	{ v9.8h }, [x0], x1
st1	{ v2.8h }, [x16], x1
st1	{ v10.8h }, [x0], x1
st1	{ v3.8h }, [x16], x1
st1	{ v11.8h }, [x0], x1
st1	{ v4.8h }, [x16], x1
st1	{ v30.8h }, [x0], x1
st1	{ v5.8h }, [x16], x1
st1	{ v31.8h }, [x0], x1
ret	x15
L_fec:
sub	x16, x0, x1, lsl #3
sub	x16, x16, #0x8
trn1	v28.8h, v20.8h, v21.8h
trn2	v29.8h, v20.8h, v21.8h
trn1	v21.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.8h, v24.8h, v25.8h
trn2	v25.8h, v24.8h, v25.8h
trn1	v22.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.4s, v20.4s, v22.4s
trn2	v22.4s, v20.4s, v22.4s
trn1	v26.4s, v25.4s, v27.4s
trn2	v27.4s, v25.4s, v27.4s
trn1	v25.4s, v29.4s, v23.4s
trn2	v29.4s, v29.4s, v23.4s
trn1	v23.4s, v28.4s, v21.4s
trn2	v28.4s, v28.4s, v21.4s
trn1	v20.2d, v23.2d, v24.2d
trn2	v24.2d, v23.2d, v24.2d
trn1	v21.2d, v25.2d, v26.2d
trn2	v25.2d, v25.2d, v26.2d
trn2	v26.2d, v28.2d, v22.2d
trn1	v22.2d, v28.2d, v22.2d
trn1	v23.2d, v29.2d, v27.2d
trn2	v27.2d, v29.2d, v27.2d
add	x0, x16, x1, lsl #2
st1	{ v20.8h }, [x16], x1
st1	{ v24.8h }, [x0], x1
st1	{ v21.8h }, [x16], x1
st1	{ v25.8h }, [x0], x1
st1	{ v22.8h }, [x16], x1
st1	{ v26.8h }, [x0], x1
st1	{ v23.8h }, [x16], x1
st1	{ v27.8h }, [x0], x1
add	x0, x0, #0x8
ret	x15
L_1080:
sub	x16, x0, x1, lsl #3
sub	x16, x16, #0x4
trn1	v26.8h, v22.8h, v23.8h
trn2	v27.8h, v22.8h, v23.8h
trn1	v28.8h, v24.8h, v25.8h
trn2	v29.8h, v24.8h, v25.8h
trn1	v22.4s, v26.4s, v28.4s
trn2	v24.4s, v26.4s, v28.4s
trn1	v23.4s, v27.4s, v29.4s
trn2	v25.4s, v27.4s, v29.4s
add	x0, x16, x1, lsl #2
st1	{ v22.d }[0], [x16], x1
st1	{ v22.d }[1], [x0], x1
st1	{ v23.d }[0], [x16], x1
st1	{ v23.d }[1], [x0], x1
st1	{ v24.d }[0], [x16], x1
st1	{ v24.d }[1], [x0], x1
st1	{ v25.d }[0], [x16], x1
st1	{ v25.d }[1], [x0], x1
add	x0, x0, #0x4
ret	x15
lpf_v_sb_y_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #0x18
sub	w9, w10, w9
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
ldr	w2, [x2, #0x8]
add	x5, x5, #0x80
orr	w7, w7, w2
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
L_1110:
tst	w6, #0x3
ld1	{ v0.8b }, [x4], #8
ld1	{ v1.8b }, [x3], #8
b.eq	L_11f4
ld1r	{ v5.8b }, [x5]
add	x5, x5, #0x8
movi	v2.2s, #0xff
dup	v13.2s, w6
dup	v31.8h, w9
and	v0.8b, v0.8b, v2.8b
and	v1.8b, v1.8b, v2.8b
cmtst	v3.8b, v1.8b, v2.8b
movi	v4.8b, #0x1
ld1r	{ v6.8b }, [x5]
sub	x5, x5, #0x8
bif	v1.8b, v0.8b, v3.8b
cmtst	v2.2s, v1.2s, v2.2s
mul	v1.2s, v1.2s, v4.2s
dup	v15.2s, w2
dup	v14.2s, w7
mov	x16, v2.d[0]
cmp	x16, #0x0
b.eq	L_11f4
neg	v5.8b, v5.8b
adrp	x16, word_12
add	x16, x16, :lo12:word_12
ushr	v12.8b, v1.8b, #0x4
ld1	{ v16.2s }, [x16]
sshl	v3.8b, v1.8b, v5.8b
cmtst	v15.2s, v15.2s, v16.2s
movi	v7.8b, #0x2
umin	v3.8b, v3.8b, v6.8b
add	v0.8b, v1.8b, v7.8b
umax	v11.8b, v3.8b, v4.8b
add	v0.8b, v0.8b, v0.8b
cmtst	v14.2s, v14.2s, v16.2s
ushll	v12.8h, v12.8b, #0x0
add	v10.8b, v0.8b, v11.8b
cmtst	v13.2s, v13.2s, v16.2s
ushll	v11.8h, v11.8b, #0x0
ushll	v10.8h, v10.8b, #0x0
and	v13.8b, v13.8b, v2.8b
sshll	v14.8h, v14.8b, #0x0
sshll	v13.8h, v13.8b, #0x0
sshll	v15.8h, v15.8b, #0x0
ushl	v12.8h, v12.8h, v31.8h
ushl	v11.8h, v11.8h, v31.8h
ushl	v10.8h, v10.8h, v31.8h
tst	w2, #0x3
b.eq	L_11e0
bl	lpf_v_16_8_neon
b	L_11f4
L_11e0:
tst	w7, #0x3
b.eq	L_11f0
bl	lpf_v_8_8_neon
b	L_11f4
L_11f0:
bl	lpf_v_4_8_neon
L_11f4:
lsr	w6, w6, #2
lsr	w7, w7, #2
lsr	w2, w2, #2
add	x0, x0, #0x10
cbnz	w6, L_1110
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
lpf_h_sb_y_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #0x18
sub	w9, w10, w9
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
ldr	w2, [x2, #0x8]
add	x5, x5, #0x80
orr	w7, w7, w2
sub	x3, x3, #0x4
lsl	x4, x4, #2
orr	w6, w6, w7
L_125c:
tst	w6, #0x3
ld2	{ v0.s, v1.s }[0], [x3], x4
ld2	{ v0.s, v1.s }[1], [x3], x4
b.eq	L_1344
ld1r	{ v5.8b }, [x5]
add	x5, x5, #0x8
movi	v2.2s, #0xff
dup	v13.2s, w6
dup	v31.8h, w9
and	v0.8b, v0.8b, v2.8b
and	v1.8b, v1.8b, v2.8b
cmtst	v3.8b, v1.8b, v2.8b
movi	v4.8b, #0x1
ld1r	{ v6.8b }, [x5]
sub	x5, x5, #0x8
bif	v1.8b, v0.8b, v3.8b
cmtst	v2.2s, v1.2s, v2.2s
mul	v1.2s, v1.2s, v4.2s
dup	v15.2s, w2
dup	v14.2s, w7
mov	x16, v2.d[0]
cmp	x16, #0x0
b.eq	L_1344
neg	v5.8b, v5.8b
adrp	x16, word_12
add	x16, x16, :lo12:word_12
ushr	v12.8b, v1.8b, #0x4
ld1	{ v16.2s }, [x16]
sshl	v3.8b, v1.8b, v5.8b
cmtst	v15.2s, v15.2s, v16.2s
movi	v7.8b, #0x2
umin	v3.8b, v3.8b, v6.8b
add	v0.8b, v1.8b, v7.8b
umax	v11.8b, v3.8b, v4.8b
add	v0.8b, v0.8b, v0.8b
cmtst	v14.2s, v14.2s, v16.2s
ushll	v12.8h, v12.8b, #0x0
add	v10.8b, v0.8b, v11.8b
cmtst	v13.2s, v13.2s, v16.2s
ushll	v11.8h, v11.8b, #0x0
ushll	v10.8h, v10.8b, #0x0
and	v13.8b, v13.8b, v2.8b
sshll	v14.8h, v14.8b, #0x0
sshll	v13.8h, v13.8b, #0x0
sshll	v15.8h, v15.8b, #0x0
ushl	v12.8h, v12.8h, v31.8h
ushl	v11.8h, v11.8h, v31.8h
ushl	v10.8h, v10.8h, v31.8h
tst	w2, #0x3
b.eq	L_132c
bl	lpf_h_16_8_neon
b	L_1348
L_132c:
tst	w7, #0x3
b.eq	L_133c
bl	lpf_h_8_8_neon
b	L_1348
L_133c:
bl	lpf_h_4_8_neon
b	L_1348
L_1344:
add	x0, x0, x1, lsl #3
L_1348:
lsr	w6, w6, #2
lsr	w7, w7, #2
lsr	w2, w2, #2
cbnz	w6, L_125c
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
lpf_v_sb_uv_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #0x18
sub	w9, w10, w9
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
add	x5, x5, #0x80
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
L_13a0:
tst	w6, #0x3
ld1	{ v0.8b }, [x4], #8
ld1	{ v1.8b }, [x3], #8
b.eq	L_1468
ld1r	{ v5.8b }, [x5]
add	x5, x5, #0x8
movi	v2.2s, #0xff
dup	v13.2s, w6
dup	v31.8h, w9
and	v0.8b, v0.8b, v2.8b
and	v1.8b, v1.8b, v2.8b
cmtst	v3.8b, v1.8b, v2.8b
movi	v4.8b, #0x1
ld1r	{ v6.8b }, [x5]
sub	x5, x5, #0x8
bif	v1.8b, v0.8b, v3.8b
cmtst	v2.2s, v1.2s, v2.2s
mul	v1.2s, v1.2s, v4.2s
dup	v14.2s, w7
mov	x16, v2.d[0]
cmp	x16, #0x0
b.eq	L_1468
neg	v5.8b, v5.8b
adrp	x16, word_12
add	x16, x16, :lo12:word_12
ushr	v12.8b, v1.8b, #0x4
ld1	{ v16.2s }, [x16]
sshl	v3.8b, v1.8b, v5.8b
movi	v7.8b, #0x2
umin	v3.8b, v3.8b, v6.8b
add	v0.8b, v1.8b, v7.8b
umax	v11.8b, v3.8b, v4.8b
add	v0.8b, v0.8b, v0.8b
cmtst	v14.2s, v14.2s, v16.2s
ushll	v12.8h, v12.8b, #0x0
add	v10.8b, v0.8b, v11.8b
cmtst	v13.2s, v13.2s, v16.2s
ushll	v11.8h, v11.8b, #0x0
ushll	v10.8h, v10.8b, #0x0
and	v13.8b, v13.8b, v2.8b
sshll	v14.8h, v14.8b, #0x0
sshll	v13.8h, v13.8b, #0x0
ushl	v12.8h, v12.8h, v31.8h
ushl	v11.8h, v11.8h, v31.8h
ushl	v10.8h, v10.8h, v31.8h
tst	w7, #0x3
b.eq	L_1464
bl	lpf_v_6_8_neon
b	L_1468
L_1464:
bl	lpf_v_4_8_neon
L_1468:
lsr	w6, w6, #2
lsr	w7, w7, #2
add	x0, x0, #0x10
cbnz	w6, L_13a0
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
lpf_h_sb_uv_16bpc_neon:
mov	x11, x30
mov	w8, w7
clz	w9, w8
mov	w10, #0x18
sub	w9, w10, w9
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
add	x5, x5, #0x80
sub	x3, x3, #0x4
lsl	x4, x4, #2
orr	w6, w6, w7
L_14c4:
tst	w6, #0x3
ld2	{ v0.s, v1.s }[0], [x3], x4
ld2	{ v0.s, v1.s }[1], [x3], x4
b.eq	L_1590
ld1r	{ v5.8b }, [x5]
add	x5, x5, #0x8
movi	v2.2s, #0xff
dup	v13.2s, w6
dup	v31.8h, w9
and	v0.8b, v0.8b, v2.8b
and	v1.8b, v1.8b, v2.8b
cmtst	v3.8b, v1.8b, v2.8b
movi	v4.8b, #0x1
ld1r	{ v6.8b }, [x5]
sub	x5, x5, #0x8
bif	v1.8b, v0.8b, v3.8b
cmtst	v2.2s, v1.2s, v2.2s
mul	v1.2s, v1.2s, v4.2s
dup	v14.2s, w7
mov	x16, v2.d[0]
cmp	x16, #0x0
b.eq	L_1590
neg	v5.8b, v5.8b
adrp	x16, word_12
add	x16, x16, :lo12:word_12
ushr	v12.8b, v1.8b, #0x4
ld1	{ v16.2s }, [x16]
sshl	v3.8b, v1.8b, v5.8b
movi	v7.8b, #0x2
umin	v3.8b, v3.8b, v6.8b
add	v0.8b, v1.8b, v7.8b
umax	v11.8b, v3.8b, v4.8b
add	v0.8b, v0.8b, v0.8b
cmtst	v14.2s, v14.2s, v16.2s
ushll	v12.8h, v12.8b, #0x0
add	v10.8b, v0.8b, v11.8b
cmtst	v13.2s, v13.2s, v16.2s
ushll	v11.8h, v11.8b, #0x0
ushll	v10.8h, v10.8b, #0x0
and	v13.8b, v13.8b, v2.8b
sshll	v14.8h, v14.8b, #0x0
sshll	v13.8h, v13.8b, #0x0
ushl	v12.8h, v12.8h, v31.8h
ushl	v11.8h, v11.8h, v31.8h
ushl	v10.8h, v10.8h, v31.8h
tst	w7, #0x3
b.eq	L_1588
bl	lpf_h_6_8_neon
b	L_1594
L_1588:
bl	lpf_h_4_8_neon
b	L_1594
L_1590:
add	x0, x0, x1, lsl #3
L_1594:
lsr	w6, w6, #2
lsr	w7, w7, #2
cbnz	w6, L_14c4
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
	.section .rodata
word_12:
	.size word_12, 8
	.byte 1,0,0,0,2,0,0,0
