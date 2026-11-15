	.text
poly1305_init:
cmp	x1, xzr
stp	xzr, xzr, [x0]
stp	xzr, xzr, [x0, #0x10]
csel	x0, xzr, x0, eq
b.eq	L_7c
adrp	x17, OPENSSL_armcap_P
ldr	w17, [x17]
ldp	x7, x8, [x1]
mov	x9, #-0x3f0000001
movk	x9, #0xfff, lsl #48
and	x7, x7, x9
and	x9, x9, #0xfffffffffffffffc
and	x8, x8, x9
stp	x7, x8, [x0, #0x20]
tst	w17, #0x1
adrp	x12, poly1305_blocks
add	x12, x12, :lo12:poly1305_blocks
adrp	x7, poly1305_blocks_neon
add	x7, x7, :lo12:poly1305_blocks_neon
adrp	x13, poly1305_emit
add	x13, x13, :lo12:poly1305_emit
adrp	x8, poly1305_emit_neon
add	x8, x8, :lo12:poly1305_emit_neon
csel	x12, x12, x7, eq
csel	x13, x13, x8, eq
tst	w17, #0x20000
adrp	x7, poly1305_blocks_sve2
add	x7, x7, :lo12:poly1305_blocks_sve2
csel	x12, x12, x7, eq
stp	x12, x13, [x2]
mov	x0, #0x1
L_7c:
ret
poly1305_blocks:
ands	x2, x2, #0xfffffffffffffff0
b.eq	L_120
ldp	x4, x5, [x0]
ldp	x7, x8, [x0, #0x20]
ldr	x6, [x0, #0x10]
add	x9, x8, x8, lsr #2
b	L_a0
nop
L_a0:
ldp	x10, x11, [x1], #0x10
sub	x2, x2, #0x10
adds	x4, x4, x10
adcs	x5, x5, x11
mul	x12, x4, x7
adc	x6, x6, x3
umulh	x13, x4, x7
mul	x10, x5, x9
umulh	x11, x5, x9
adds	x12, x12, x10
mul	x10, x4, x8
adc	x13, x13, x11
umulh	x14, x4, x8
adds	x13, x13, x10
mul	x10, x5, x7
adc	x14, x14, xzr
umulh	x11, x5, x7
adds	x13, x13, x10
mul	x10, x6, x9
adc	x14, x14, x11
mul	x11, x6, x7
adds	x13, x13, x10
adc	x14, x14, x11
and	x10, x14, #0xfffffffffffffffc
and	x6, x14, #0x3
add	x10, x10, x14, lsr #2
adds	x4, x12, x10
adcs	x5, x13, xzr
adc	x6, x6, xzr
cbnz	x2, L_a0
stp	x4, x5, [x0]
str	x6, [x0, #0x10]
L_120:
ret
nop
nop
nop
nop
nop
nop
nop
poly1305_emit:
ldp	x4, x5, [x0]
ldr	x6, [x0, #0x10]
ldp	x10, x11, [x2]
adds	x12, x4, #0x5
adcs	x13, x5, xzr
adc	x14, x6, xzr
tst	x14, #0xfffffffffffffffc
csel	x4, x4, x12, eq
csel	x5, x5, x13, eq
adds	x4, x4, x10
adc	x5, x5, x11
stp	x4, x5, [x1]
ret
nop
nop
nop
poly1305_mult:
mul	x12, x4, x7
umulh	x13, x4, x7
mul	x10, x5, x9
umulh	x11, x5, x9
adds	x12, x12, x10
mul	x10, x4, x8
adc	x13, x13, x11
umulh	x14, x4, x8
adds	x13, x13, x10
mul	x10, x5, x7
adc	x14, x14, xzr
umulh	x11, x5, x7
adds	x13, x13, x10
mul	x10, x6, x9
adc	x14, x14, x11
mul	x11, x6, x7
adds	x13, x13, x10
adc	x14, x14, x11
and	x10, x14, #0xfffffffffffffffc
and	x6, x14, #0x3
add	x10, x10, x14, lsr #2
adds	x4, x12, x10
adcs	x5, x13, xzr
adc	x6, x6, xzr
ret
nop
nop
nop
nop
nop
nop
nop
poly1305_splat:
and	x12, x4, #0x3ffffff
ubfx	x13, x4, #26, #26
extr	x14, x5, x4, #0x34
and	x14, x14, #0x3ffffff
ubfx	x15, x5, #14, #26
extr	x16, x6, x5, #0x28
str	w12, [x0]
add	w12, w13, w13, lsl #2
str	w13, [x0, #0x10]
add	w13, w14, w14, lsl #2
str	w12, [x0, #0x20]
str	w14, [x0, #0x30]
add	w14, w15, w15, lsl #2
str	w13, [x0, #0x40]
str	w15, [x0, #0x50]
add	w15, w16, w16, lsl #2
str	w14, [x0, #0x60]
str	w16, [x0, #0x70]
str	w15, [x0, #0x80]
ret
nop
nop
nop
nop
poly1305_blocks_neon:
ldr	x17, [x0, #0x18]
cmp	x2, #0x80
b.hs	L_270
cbz	x17, poly1305_blocks
L_270:
stp	x29, x30, [sp, #-0x50]!
mov	x29, sp
ands	x2, x2, #0xfffffffffffffff0
b.eq	L_8e0
cbz	x17, L_340
ldp	w10, w11, [x0]
ldp	w12, w13, [x0, #0x8]
ldr	w14, [x0, #0x10]
tst	x2, #0x1f
b.eq	L_410
ldp	x7, x8, [x0, #0x20]
add	x4, x10, x11, lsl #26
lsr	x5, x12, #12
adds	x4, x4, x12, lsl #52
add	x5, x5, x13, lsl #14
adc	x5, x5, xzr
lsr	x6, x14, #24
adds	x5, x5, x14, lsl #40
adc	x14, x6, xzr
ldp	x12, x13, [x1], #0x10
sub	x2, x2, #0x10
add	x9, x8, x8, lsr #2
and	x10, x14, #0xfffffffffffffffc
and	x6, x14, #0x3
add	x10, x10, x14, lsr #2
adds	x4, x4, x10
adcs	x5, x5, xzr
adc	x6, x6, xzr
adds	x4, x4, x12
adcs	x5, x5, x13
adc	x6, x6, x3
bl	poly1305_mult
ldr	x30, [sp, #0x8]
cbz	x3, L_330
and	x10, x4, #0x3ffffff
ubfx	x11, x4, #26, #26
extr	x12, x5, x4, #0x34
and	x12, x12, #0x3ffffff
ubfx	x13, x5, #14, #26
extr	x14, x6, x5, #0x28
cbnz	x2, L_410
stp	w10, w11, [x0]
stp	w12, w13, [x0, #0x8]
str	w14, [x0, #0x10]
b	L_8e0
nop
nop
nop
L_330:
stp	x4, x5, [x0]
stp	x6, xzr, [x0, #0x10]
b	L_8e0
nop
L_340:
ldp	x7, x8, [x0, #0x20]
ldp	x4, x5, [x0]
ldr	x6, [x0, #0x10]
tst	x2, #0x1f
b.eq	L_370
ldp	x12, x13, [x1], #0x10
sub	x2, x2, #0x10
add	x9, x8, x8, lsr #2
adds	x4, x4, x12
adcs	x5, x5, x13
adc	x6, x6, x3
bl	poly1305_mult
L_370:
and	x10, x4, #0x3ffffff
ubfx	x11, x4, #26, #26
extr	x12, x5, x4, #0x34
and	x12, x12, #0x3ffffff
ubfx	x13, x5, #14, #26
extr	x14, x6, x5, #0x28
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
fmov	d24, x10
fmov	d25, x11
fmov	d26, x12
fmov	d27, x13
fmov	d28, x14
mov	x4, x7
add	x9, x8, x8, lsr #2
mov	x5, x8
mov	x6, xzr
add	x0, x0, #0x3c
bl	poly1305_splat
bl	poly1305_mult
sub	x0, x0, #0x4
bl	poly1305_splat
bl	poly1305_mult
sub	x0, x0, #0x4
bl	poly1305_splat
bl	poly1305_mult
sub	x0, x0, #0x4
bl	poly1305_splat
ldr	x30, [sp, #0x8]
add	x16, x1, #0x20
adrp	x17, bums_rodata
add	x17, x17, :lo12:bums_rodata
subs	x2, x2, #0x40
csel	x16, x17, x16, lo
mov	x4, #0x1
stur	x4, [x0, #-0x18]
sub	x0, x0, #0x30
b	L_448
L_410:
add	x16, x1, #0x20
adrp	x17, bums_rodata
add	x17, x17, :lo12:bums_rodata
subs	x2, x2, #0x40
csel	x16, x17, x16, lo
stp	d8, d9, [sp, #0x10]
stp	d10, d11, [sp, #0x20]
stp	d12, d13, [sp, #0x30]
stp	d14, d15, [sp, #0x40]
fmov	d24, x10
fmov	d25, x11
fmov	d26, x12
fmov	d27, x13
fmov	d28, x14
L_448:
ldp	x8, x12, [x16], #0x10
ldp	x9, x13, [x16], #0x30
lsl	x3, x3, #24
add	x15, x0, #0x30
and	x4, x8, #0x3ffffff
and	x5, x9, #0x3ffffff
ubfx	x6, x8, #26, #26
ubfx	x7, x9, #26, #26
add	x4, x4, x5, lsl #32
extr	x8, x12, x8, #0x34
extr	x9, x13, x9, #0x34
add	x6, x6, x7, lsl #32
fmov	d14, x4
and	x8, x8, #0x3ffffff
and	x9, x9, #0x3ffffff
ubfx	x10, x12, #14, #26
ubfx	x11, x13, #14, #26
add	x12, x3, x12, lsr #40
add	x13, x3, x13, lsr #40
add	x8, x8, x9, lsl #32
fmov	d15, x6
add	x10, x10, x11, lsl #32
add	x12, x12, x13, lsl #32
fmov	d16, x8
fmov	d17, x10
fmov	d18, x12
ldp	x8, x12, [x1], #0x10
ldp	x9, x13, [x1], #0x30
ld1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x15], #64
ld1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x15], #64
ld1	{ v8.4s }, [x15]
and	x4, x8, #0x3ffffff
and	x5, x9, #0x3ffffff
ubfx	x6, x8, #26, #26
ubfx	x7, x9, #26, #26
add	x4, x4, x5, lsl #32
extr	x8, x12, x8, #0x34
extr	x9, x13, x9, #0x34
add	x6, x6, x7, lsl #32
fmov	d9, x4
and	x8, x8, #0x3ffffff
and	x9, x9, #0x3ffffff
ubfx	x10, x12, #14, #26
ubfx	x11, x13, #14, #26
add	x12, x3, x12, lsr #40
add	x13, x3, x13, lsr #40
add	x8, x8, x9, lsl #32
fmov	d10, x6
add	x10, x10, x11, lsl #32
add	x12, x12, x13, lsl #32
movi	v31.2d, #0xffffffffffffffff
fmov	d11, x8
fmov	d12, x10
fmov	d13, x12
ushr	v31.2d, v31.2d, #0x26
b.ls	L_748
nop
nop
L_530:
subs	x2, x2, #0x40
umull	v23.2d, v14.2s, v7.s[2]
csel	x16, x17, x16, lo
umull	v22.2d, v14.2s, v5.s[2]
umull	v21.2d, v14.2s, v3.s[2]
ldp	x8, x12, [x16], #0x10
umull	v20.2d, v14.2s, v1.s[2]
ldp	x9, x13, [x16], #0x30
umull	v19.2d, v14.2s, v0.s[2]
umlal	v23.2d, v15.2s, v5.s[2]
and	x4, x8, #0x3ffffff
umlal	v22.2d, v15.2s, v3.s[2]
and	x5, x9, #0x3ffffff
umlal	v21.2d, v15.2s, v1.s[2]
ubfx	x6, x8, #26, #26
umlal	v20.2d, v15.2s, v0.s[2]
ubfx	x7, x9, #26, #26
umlal	v19.2d, v15.2s, v8.s[2]
add	x4, x4, x5, lsl #32
umlal	v23.2d, v16.2s, v3.s[2]
extr	x8, x12, x8, #0x34
umlal	v22.2d, v16.2s, v1.s[2]
extr	x9, x13, x9, #0x34
umlal	v21.2d, v16.2s, v0.s[2]
add	x6, x6, x7, lsl #32
umlal	v20.2d, v16.2s, v8.s[2]
fmov	d14, x4
umlal	v19.2d, v16.2s, v6.s[2]
and	x8, x8, #0x3ffffff
umlal	v23.2d, v17.2s, v1.s[2]
and	x9, x9, #0x3ffffff
umlal	v22.2d, v17.2s, v0.s[2]
ubfx	x10, x12, #14, #26
umlal	v21.2d, v17.2s, v8.s[2]
ubfx	x11, x13, #14, #26
umlal	v20.2d, v17.2s, v6.s[2]
add	x8, x8, x9, lsl #32
umlal	v19.2d, v17.2s, v4.s[2]
fmov	d15, x6
add	v11.2s, v11.2s, v26.2s
add	x12, x3, x12, lsr #40
umlal	v23.2d, v18.2s, v0.s[2]
add	x13, x3, x13, lsr #40
umlal	v22.2d, v18.2s, v8.s[2]
add	x10, x10, x11, lsl #32
umlal	v21.2d, v18.2s, v6.s[2]
add	x12, x12, x13, lsl #32
umlal	v20.2d, v18.2s, v4.s[2]
fmov	d16, x8
umlal	v19.2d, v18.2s, v2.s[2]
fmov	d17, x10
add	v9.2s, v9.2s, v24.2s
fmov	d18, x12
umlal	v22.2d, v11.2s, v1.s[0]
ldp	x8, x12, [x1], #0x10
umlal	v19.2d, v11.2s, v6.s[0]
ldp	x9, x13, [x1], #0x30
umlal	v23.2d, v11.2s, v3.s[0]
umlal	v20.2d, v11.2s, v8.s[0]
umlal	v21.2d, v11.2s, v0.s[0]
add	v10.2s, v10.2s, v25.2s
umlal	v22.2d, v9.2s, v5.s[0]
umlal	v23.2d, v9.2s, v7.s[0]
and	x4, x8, #0x3ffffff
umlal	v21.2d, v9.2s, v3.s[0]
and	x5, x9, #0x3ffffff
umlal	v19.2d, v9.2s, v0.s[0]
ubfx	x6, x8, #26, #26
umlal	v20.2d, v9.2s, v1.s[0]
ubfx	x7, x9, #26, #26
add	v12.2s, v12.2s, v27.2s
add	x4, x4, x5, lsl #32
umlal	v22.2d, v10.2s, v3.s[0]
extr	x8, x12, x8, #0x34
umlal	v23.2d, v10.2s, v5.s[0]
extr	x9, x13, x9, #0x34
umlal	v19.2d, v10.2s, v8.s[0]
add	x6, x6, x7, lsl #32
umlal	v21.2d, v10.2s, v1.s[0]
fmov	d9, x4
umlal	v20.2d, v10.2s, v0.s[0]
and	x8, x8, #0x3ffffff
add	v13.2s, v13.2s, v28.2s
and	x9, x9, #0x3ffffff
umlal	v22.2d, v12.2s, v0.s[0]
ubfx	x10, x12, #14, #26
umlal	v19.2d, v12.2s, v4.s[0]
ubfx	x11, x13, #14, #26
umlal	v23.2d, v12.2s, v1.s[0]
add	x8, x8, x9, lsl #32
umlal	v20.2d, v12.2s, v6.s[0]
fmov	d10, x6
umlal	v21.2d, v12.2s, v8.s[0]
add	x12, x3, x12, lsr #40
umlal	v22.2d, v13.2s, v8.s[0]
add	x13, x3, x13, lsr #40
umlal	v19.2d, v13.2s, v2.s[0]
add	x10, x10, x11, lsl #32
umlal	v23.2d, v13.2s, v0.s[0]
add	x12, x12, x13, lsl #32
umlal	v20.2d, v13.2s, v4.s[0]
fmov	d11, x8
umlal	v21.2d, v13.2s, v6.s[0]
fmov	d12, x10
fmov	d13, x12
ushr	v29.2d, v22.2d, #0x1a
xtn	v27.2s, v22.2d
ushr	v30.2d, v19.2d, #0x1a
and	v19.16b, v19.16b, v31.16b
add	v23.2d, v23.2d, v29.2d
bic	v27.2s, #0xfc, lsl #24
add	v20.2d, v20.2d, v30.2d
ushr	v29.2d, v23.2d, #0x1a
xtn	v28.2s, v23.2d
ushr	v30.2d, v20.2d, #0x1a
xtn	v25.2s, v20.2d
bic	v28.2s, #0xfc, lsl #24
add	v21.2d, v21.2d, v30.2d
add	v19.2d, v19.2d, v29.2d
shl	v29.2d, v29.2d, #0x2
shrn	v30.2s, v21.2d, #0x1a
xtn	v26.2s, v21.2d
add	v19.2d, v19.2d, v29.2d
bic	v25.2s, #0xfc, lsl #24
add	v27.2s, v27.2s, v30.2s
bic	v26.2s, #0xfc, lsl #24
shrn	v29.2s, v19.2d, #0x1a
xtn	v24.2s, v19.2d
ushr	v30.2s, v27.2s, #0x1a
bic	v27.2s, #0xfc, lsl #24
bic	v24.2s, #0xfc, lsl #24
add	v25.2s, v25.2s, v29.2s
add	v28.2s, v28.2s, v30.2s
b.hi	L_530
L_748:
dup	v16.2d, v16.d[0]
add	v11.2s, v11.2s, v26.2s
adds	x2, x2, #0x20
b.ne	L_76c
dup	v16.2d, v11.d[0]
add	v14.2s, v9.2s, v24.2s
add	v17.2s, v12.2s, v27.2s
add	v15.2s, v10.2s, v25.2s
add	v18.2s, v13.2s, v28.2s
L_76c:
dup	v14.2d, v14.d[0]
umull2	v19.2d, v16.4s, v6.4s
umull2	v22.2d, v16.4s, v1.4s
umull2	v23.2d, v16.4s, v3.4s
umull2	v21.2d, v16.4s, v0.4s
umull2	v20.2d, v16.4s, v8.4s
dup	v15.2d, v15.d[0]
umlal2	v19.2d, v14.4s, v0.4s
umlal2	v21.2d, v14.4s, v3.4s
umlal2	v22.2d, v14.4s, v5.4s
umlal2	v23.2d, v14.4s, v7.4s
umlal2	v20.2d, v14.4s, v1.4s
dup	v17.2d, v17.d[0]
umlal2	v19.2d, v15.4s, v8.4s
umlal2	v22.2d, v15.4s, v3.4s
umlal2	v21.2d, v15.4s, v1.4s
umlal2	v23.2d, v15.4s, v5.4s
umlal2	v20.2d, v15.4s, v0.4s
dup	v18.2d, v18.d[0]
umlal2	v22.2d, v17.4s, v0.4s
umlal2	v23.2d, v17.4s, v1.4s
umlal2	v19.2d, v17.4s, v4.4s
umlal2	v20.2d, v17.4s, v6.4s
umlal2	v21.2d, v17.4s, v8.4s
umlal2	v22.2d, v18.4s, v8.4s
umlal2	v19.2d, v18.4s, v2.4s
umlal2	v23.2d, v18.4s, v0.4s
umlal2	v20.2d, v18.4s, v4.4s
umlal2	v21.2d, v18.4s, v6.4s
b.eq	L_858
add	v9.2s, v9.2s, v24.2s
umlal	v22.2d, v11.2s, v1.2s
umlal	v19.2d, v11.2s, v6.2s
umlal	v23.2d, v11.2s, v3.2s
umlal	v20.2d, v11.2s, v8.2s
umlal	v21.2d, v11.2s, v0.2s
add	v10.2s, v10.2s, v25.2s
umlal	v22.2d, v9.2s, v5.2s
umlal	v19.2d, v9.2s, v0.2s
umlal	v23.2d, v9.2s, v7.2s
umlal	v20.2d, v9.2s, v1.2s
umlal	v21.2d, v9.2s, v3.2s
add	v12.2s, v12.2s, v27.2s
umlal	v22.2d, v10.2s, v3.2s
umlal	v19.2d, v10.2s, v8.2s
umlal	v23.2d, v10.2s, v5.2s
umlal	v20.2d, v10.2s, v0.2s
umlal	v21.2d, v10.2s, v1.2s
add	v13.2s, v13.2s, v28.2s
umlal	v22.2d, v12.2s, v0.2s
umlal	v19.2d, v12.2s, v4.2s
umlal	v23.2d, v12.2s, v1.2s
umlal	v20.2d, v12.2s, v6.2s
umlal	v21.2d, v12.2s, v8.2s
umlal	v22.2d, v13.2s, v8.2s
umlal	v19.2d, v13.2s, v2.2s
umlal	v23.2d, v13.2s, v0.2s
umlal	v20.2d, v13.2s, v4.2s
umlal	v21.2d, v13.2s, v6.2s
L_858:
addp	v22.2d, v22.2d, v22.2d
ldp	d8, d9, [sp, #0x10]
addp	v19.2d, v19.2d, v19.2d
ldp	d10, d11, [sp, #0x20]
addp	v23.2d, v23.2d, v23.2d
ldp	d12, d13, [sp, #0x30]
addp	v20.2d, v20.2d, v20.2d
ldp	d14, d15, [sp, #0x40]
addp	v21.2d, v21.2d, v21.2d
ushr	v29.2d, v22.2d, #0x1a
and	v22.16b, v22.16b, v31.16b
ushr	v30.2d, v19.2d, #0x1a
and	v19.16b, v19.16b, v31.16b
add	v23.2d, v23.2d, v29.2d
add	v20.2d, v20.2d, v30.2d
ushr	v29.2d, v23.2d, #0x1a
and	v23.16b, v23.16b, v31.16b
ushr	v30.2d, v20.2d, #0x1a
and	v20.16b, v20.16b, v31.16b
add	v21.2d, v21.2d, v30.2d
add	v19.2d, v19.2d, v29.2d
shl	v29.2d, v29.2d, #0x2
ushr	v30.2d, v21.2d, #0x1a
and	v21.16b, v21.16b, v31.16b
add	v19.2d, v19.2d, v29.2d
add	v22.2d, v22.2d, v30.2d
ushr	v29.2d, v19.2d, #0x1a
and	v19.16b, v19.16b, v31.16b
ushr	v30.2d, v22.2d, #0x1a
and	v22.16b, v22.16b, v31.16b
add	v20.2d, v20.2d, v29.2d
add	v23.2d, v23.2d, v30.2d
st4	{ v19.s, v20.s, v21.s, v22.s }[0], [x0], #16
st1	{ v23.s }[0], [x0]
L_8e0:
ldr	x29, [sp], #0x50
ret
nop
nop
nop
nop
nop
nop
poly1305_emit_neon:
ldr	x17, [x0, #0x18]
cbz	x17, poly1305_emit
ldp	w10, w11, [x0]
ldp	w12, w13, [x0, #0x8]
ldr	w14, [x0, #0x10]
add	x4, x10, x11, lsl #26
lsr	x5, x12, #12
adds	x4, x4, x12, lsl #52
add	x5, x5, x13, lsl #14
adc	x5, x5, xzr
lsr	x6, x14, #24
adds	x5, x5, x14, lsl #40
adc	x6, x6, xzr
ldp	x10, x11, [x2]
and	x12, x6, #0xfffffffffffffffc
add	x12, x12, x6, lsr #2
and	x6, x6, #0x3
adds	x4, x4, x12
adcs	x5, x5, xzr
adc	x6, x6, xzr
adds	x12, x4, #0x5
adcs	x13, x5, xzr
adc	x14, x6, xzr
tst	x14, #0xfffffffffffffffc
csel	x4, x4, x12, eq
csel	x5, x5, x13, eq
adds	x4, x4, x10
adc	x5, x5, x11
stp	x4, x5, [x1]
ret
nop
nop
poly1305_sw_2_26:
mov	x15, #0x3ffffff
and	x10, x7, x15
lsr	x11, x7, #26
str	w10, [x5]
bfi	x11, x8, #18, #8
ubfx	x12, x8, #8, #26
str	w11, [x5, #0x1c]
lsr	x13, x8, #34
str	w12, [x5, #0x38]
bfi	x13, x9, #10, #16
lsr	x14, x9, #16
str	w13, [x5, #0x54]
str	w14, [x5, #0x70]
ret
nop
nop
poly1305_sqr_2_44:
mov	x12, #0x14
lsl	x13, x8, #1
mul	x12, x9, x12
lsl	x10, x7, #1
umulh	x24, x8, x8
mul	x23, x8, x8
umulh	x15, x10, x9
mul	x14, x10, x9
umulh	x20, x7, x7
mul	x19, x7, x7
umulh	x11, x13, x12
mul	x10, x13, x12
adds	x23, x23, x14
adc	x24, x24, x15
umulh	x22, x7, x13
mul	x21, x7, x13
umulh	x13, x9, x12
mul	x12, x9, x12
adds	x19, x19, x10
adc	x20, x20, x11
adds	x21, x21, x12
adc	x22, x22, x13
lsr	x10, x19, #44
lsl	x11, x20, #20
and	x7, x19, x26
orr	x10, x10, x11
lsr	x12, x21, #44
lsl	x13, x22, #20
and	x8, x21, x26
orr	x12, x12, x13
add	x8, x8, x10
lsr	x11, x26, #2
lsr	x10, x23, #42
lsl	x13, x24, #22
and	x9, x23, x11
orr	x10, x10, x13
add	x9, x9, x12
lsr	x13, x9, #42
and	x9, x9, x11
add	x10, x10, x13
add	x11, x10, x10, lsl #2
add	x7, x7, x11
lsr	x11, x8, #44
and	x8, x8, x26
add	x9, x9, x11
lsr	x10, x7, #44
and	x7, x7, x26
add	x8, x8, x10
ret
nop
nop
nop
nop
nop
nop
nop
poly1305_lazy_reduce_sve2:
mov	z31.d, #0xffffffffffffffff
lsr	z29.d, z22.d, #0x1a
trn1	z27.s, z22.s, z24.s
lsr	z31.d, z31.d, #0x26
lsr	z30.d, z19.d, #0x1a
and	z19.d, z19.d, z31.d
add	z23.d, z23.d, z29.d
and	z27.d, z27.d, z31.d
add	z20.d, z20.d, z30.d
lsr	z29.d, z23.d, #0x1a
trn1	z28.s, z23.s, z24.s
lsr	z30.d, z20.d, #0x1a
trn1	z25.s, z20.s, z24.s
and	z28.d, z28.d, z31.d
add	z21.d, z21.d, z30.d
add	z19.d, z19.d, z29.d
lsl	z29.d, z29.d, #0x2
shrnb	z30.s, z21.d, #0x1a
trn1	z26.s, z21.s, z24.s
add	z19.d, z19.d, z29.d
and	z25.d, z25.d, z31.d
add	z27.s, z27.s, z30.s
and	z26.d, z26.d, z31.d
shrnb	z29.s, z19.d, #0x1a
trn1	z24.s, z19.s, z24.s
lsr	z30.s, z27.s, #0x1a
and	z27.d, z27.d, z31.d
add	z25.s, z25.s, z29.s
and	z24.d, z24.d, z31.d
add	z28.s, z28.s, z30.s
eor	z31.d, z31.d, z31.d
ret
poly1305_blocks_sve2:
ldr	w17, [x0, #0x18]
cntd	x16
lsl	x4, x16, #4
add	x5, x4, x4, lsl #1
cmp	x2, x5
b.hs	L_b3c
cbz	w17, L_12c0
L_b3c:
stp	x29, x30, [sp, #-0x90]!
mov	x29, sp
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
ands	x2, x2, #0xfffffffffffffff0
b.eq	L_12a8
cbz	w17, L_c20
ldp	w10, w11, [x0]
ldp	w12, w13, [x0, #0x8]
ldr	w14, [x0, #0x10]
neg	x5, x4
sub	x4, x4, #0x1
and	x6, x2, x5
and	x8, x2, x4
cbz	x8, L_d00
add	x7, x1, x8
stp	x6, x7, [sp, #-0x10]!
mov	x2, x8
add	x4, x10, x11, lsl #26
lsr	x5, x12, #12
adds	x4, x4, x12, lsl #52
add	x5, x5, x13, lsl #14
adc	x5, x5, xzr
lsr	x6, x14, #24
adds	x5, x5, x14, lsl #40
adc	x14, x6, xzr
and	x10, x14, #0xfffffffffffffffc
and	x6, x14, #0x3
add	x10, x10, x14, lsr #2
adds	x4, x4, x10
adcs	x5, x5, xzr
adc	x6, x6, xzr
stp	x4, x5, [x0]
str	x6, [x0, #0x10]
bl	poly1305_blocks
ldp	x2, x1, [sp], #0x10
ldr	x30, [sp, #0x8]
cbz	x3, L_c10
ldp	x4, x5, [x0]
ldr	x6, [x0, #0x10]
and	x10, x4, #0x3ffffff
ubfx	x11, x4, #26, #26
extr	x12, x5, x4, #0x34
and	x12, x12, #0x3ffffff
ubfx	x13, x5, #14, #26
extr	x14, x6, x5, #0x28
cbnz	x2, L_d00
stp	w10, w11, [x0]
stp	w12, w13, [x0, #0x8]
str	w14, [x0, #0x10]
b	L_12a8
L_c10:
str	xzr, [x0, #0x18]
b	L_12a8
nop
nop
L_c20:
neg	x5, x4
sub	x4, x4, #0x1
and	x6, x2, x5
and	x8, x2, x4
cbz	x8, L_c48
add	x7, x1, x8
stp	x6, x7, [sp, #-0x10]!
mov	x2, x8
bl	poly1305_blocks
ldp	x2, x1, [sp], #0x10
L_c48:
ldr	w5, [x0, #0x1c]
add	x25, x0, #0x4c
mov	x26, #-0x1
lsr	x26, x26, #20
cbnz	w5, L_c98
ldp	x7, x8, [x0, #0x20]
lsr	x9, x8, #24
extr	x8, x8, x7, #0x2c
and	x7, x7, x26
and	x8, x8, x26
mov	x4, x16
sub	x5, x25, #0x4
bl	poly1305_sw_2_26
L_c7c:
lsr	x4, x4, #1
sub	x5, x5, #0x4
bl	poly1305_sqr_2_44
bl	poly1305_sw_2_26
cbnz	x4, L_c7c
sub	x5, x5, x25
str	w5, [x0, #0x1c]
L_c98:
ldp	x4, x5, [x0]
ldr	x6, [x0, #0x10]
and	x10, x4, #0x3ffffff
ubfx	x11, x4, #26, #26
extr	x12, x5, x4, #0x34
and	x12, x12, #0x3ffffff
ubfx	x13, x5, #14, #26
extr	x14, x6, x5, #0x28
stp	d8, d9, [sp, #0x50]
stp	d10, d11, [sp, #0x60]
stp	d12, d13, [sp, #0x70]
stp	d14, d15, [sp, #0x80]
eor	z24.d, z24.d, z24.d
eor	z25.d, z25.d, z25.d
eor	z26.d, z26.d, z26.d
eor	z27.d, z27.d, z27.d
eor	z28.d, z28.d, z28.d
fmov	d24, x10
fmov	d25, x11
fmov	d26, x12
fmov	d27, x13
fmov	d28, x14
ldr	x30, [sp, #0x8]
mov	x4, #0x1
stur	w4, [x0, #0x18]
b	L_d38
L_d00:
stp	d8, d9, [sp, #0x50]
stp	d10, d11, [sp, #0x60]
stp	d12, d13, [sp, #0x70]
stp	d14, d15, [sp, #0x80]
eor	z24.d, z24.d, z24.d
eor	z25.d, z25.d, z25.d
eor	z26.d, z26.d, z26.d
eor	z27.d, z27.d, z27.d
eor	z28.d, z28.d, z28.d
fmov	d24, x10
fmov	d25, x11
fmov	d26, x12
fmov	d27, x13
fmov	d28, x14
L_d38:
ptrue	p0.b
ldr	w5, [x0, #0x1c]
sxtw	x5, w5
add	x25, x0, #0x4c
add	x10, x0, #0x44
add	x25, x25, x5
mov	x15, #0x2
whilelo	p1.s, xzr, x15
ld1w	{ z0.s }, p1/z, [x25]
ld1w	{ z29.s }, p1/z, [x10]
add	x25, x25, #0x1c
add	x10, x10, #0x1c
zip1	z0.s, z0.s, z29.s
ld1w	{ z1.s }, p1/z, [x25]
ld1w	{ z30.s }, p1/z, [x10]
add	x25, x25, #0x1c
add	x10, x10, #0x1c
zip1	z1.s, z1.s, z30.s
ld1w	{ z3.s }, p1/z, [x25]
ld1w	{ z29.s }, p1/z, [x10]
add	x25, x25, #0x1c
add	x10, x10, #0x1c
zip1	z3.s, z3.s, z29.s
ld1w	{ z5.s }, p1/z, [x25]
ld1w	{ z30.s }, p1/z, [x10]
add	x25, x25, #0x1c
add	x10, x10, #0x1c
zip1	z5.s, z5.s, z30.s
ld1w	{ z7.s }, p1/z, [x25]
ld1w	{ z29.s }, p1/z, [x10]
sub	x25, x25, #0x68
zip1	z7.s, z7.s, z29.s
cmp	x16, #0x2
b.eq	L_dd4
mov	z0.q, q0
mov	z1.q, q1
mov	z3.q, q3
mov	z5.q, q5
mov	z7.q, q7
L_dd4:
adr	z2.s, [z1.s, z1.s, lsl #2]
adr	z4.s, [z3.s, z3.s, lsl #2]
adr	z6.s, [z5.s, z5.s, lsl #2]
adr	z8.s, [z7.s, z7.s, lsl #2]
lsr	x15, x2, #4
whilelo	p1.s, xzr, x15
lsl	x3, x3, #24
ld4w	{ z9.s - z12.s }, p1/z, [x1]
mov	z31.s, #0xffffffff
lsr	z31.s, z31.s, #0x6
lsr	z29.s, z11.s, #0xe
lsr	z13.s, z12.s, #0x8
lsl	z11.s, z11.s, #0xc
lsl	z12.s, z12.s, #0x12
lsr	z30.s, z10.s, #0x14
orr	z12.d, z12.d, z29.d
lsl	z10.s, z10.s, #0x6
lsr	z29.s, z9.s, #0x1a
and	z9.d, z9.d, z31.d
orr	z11.d, z11.d, z30.d
orr	z10.d, z10.d, z29.d
mov	z30.s, w3
eor	z29.d, z29.d, z29.d
orr	z13.d, z13.d, z30.d
and	z12.d, z12.d, z31.d
and	z11.d, z11.d, z31.d
and	z10.d, z10.d, z31.d
zip2	z14.s, z9.s, z29.s
zip2	z18.s, z13.s, z29.s
zip2	z17.s, z12.s, z29.s
zip2	z16.s, z11.s, z29.s
zip2	z15.s, z10.s, z29.s
zip1	z9.s, z9.s, z29.s
zip1	z13.s, z13.s, z29.s
zip1	z12.s, z12.s, z29.s
zip1	z11.s, z11.s, z29.s
zip1	z10.s, z10.s, z29.s
subs	x2, x2, x16, lsl #5
b.ls	L_fe0
L_e70:
add	x1, x1, x16, lsl #5
umullb	z23.d, z14.s, z7.s[2]
umullb	z22.d, z14.s, z5.s[2]
umullb	z21.d, z14.s, z3.s[2]
umullb	z20.d, z14.s, z1.s[2]
umullb	z19.d, z14.s, z0.s[2]
umlalb	z23.d, z15.s, z5.s[2]
umlalb	z22.d, z15.s, z3.s[2]
umlalb	z21.d, z15.s, z1.s[2]
umlalb	z20.d, z15.s, z0.s[2]
umlalb	z19.d, z15.s, z8.s[2]
umlalb	z23.d, z16.s, z3.s[2]
umlalb	z22.d, z16.s, z1.s[2]
umlalb	z21.d, z16.s, z0.s[2]
umlalb	z20.d, z16.s, z8.s[2]
umlalb	z19.d, z16.s, z6.s[2]
umlalb	z23.d, z17.s, z1.s[2]
umlalb	z22.d, z17.s, z0.s[2]
umlalb	z21.d, z17.s, z8.s[2]
umlalb	z20.d, z17.s, z6.s[2]
umlalb	z19.d, z17.s, z4.s[2]
add	z11.s, z11.s, z26.s
umlalb	z23.d, z18.s, z0.s[2]
umlalb	z22.d, z18.s, z8.s[2]
umlalb	z21.d, z18.s, z6.s[2]
umlalb	z20.d, z18.s, z4.s[2]
umlalb	z19.d, z18.s, z2.s[2]
add	z9.s, z9.s, z24.s
lsr	x15, x2, #4
umlalb	z22.d, z11.s, z1.s[0]
whilelo	p1.s, xzr, x15
umlalb	z19.d, z11.s, z6.s[0]
ld4w	{ z14.s - z17.s }, p1/z, [x1]
umlalb	z23.d, z11.s, z3.s[0]
umlalb	z20.d, z11.s, z8.s[0]
umlalb	z21.d, z11.s, z0.s[0]
add	z10.s, z10.s, z25.s
mov	z31.s, #0xffffffff
umlalb	z22.d, z9.s, z5.s[0]
lsr	z31.s, z31.s, #0x6
umlalb	z23.d, z9.s, z7.s[0]
lsr	z29.s, z16.s, #0xe
umlalb	z21.d, z9.s, z3.s[0]
lsr	z18.s, z17.s, #0x8
umlalb	z19.d, z9.s, z0.s[0]
lsl	z16.s, z16.s, #0xc
umlalb	z20.d, z9.s, z1.s[0]
lsl	z17.s, z17.s, #0x12
add	z12.s, z12.s, z27.s
lsr	z30.s, z15.s, #0x14
umlalb	z22.d, z10.s, z3.s[0]
orr	z17.d, z17.d, z29.d
umlalb	z23.d, z10.s, z5.s[0]
lsl	z15.s, z15.s, #0x6
umlalb	z19.d, z10.s, z8.s[0]
lsr	z29.s, z14.s, #0x1a
umlalb	z21.d, z10.s, z1.s[0]
and	z14.d, z14.d, z31.d
umlalb	z20.d, z10.s, z0.s[0]
orr	z16.d, z16.d, z30.d
add	z13.s, z13.s, z28.s
orr	z15.d, z15.d, z29.d
umlalb	z22.d, z12.s, z0.s[0]
mov	z30.s, w3
umlalb	z19.d, z12.s, z4.s[0]
eor	z29.d, z29.d, z29.d
umlalb	z23.d, z12.s, z1.s[0]
orr	z18.d, z18.d, z30.d
umlalb	z20.d, z12.s, z6.s[0]
and	z17.d, z17.d, z31.d
umlalb	z21.d, z12.s, z8.s[0]
and	z16.d, z16.d, z31.d
umlalb	z22.d, z13.s, z8.s[0]
and	z15.d, z15.d, z31.d
umlalb	z19.d, z13.s, z2.s[0]
zip1	z9.s, z14.s, z29.s
umlalb	z23.d, z13.s, z0.s[0]
zip1	z10.s, z15.s, z29.s
umlalb	z20.d, z13.s, z4.s[0]
zip1	z11.s, z16.s, z29.s
umlalb	z21.d, z13.s, z6.s[0]
zip1	z12.s, z17.s, z29.s
zip1	z13.s, z18.s, z29.s
zip2	z14.s, z14.s, z29.s
zip2	z15.s, z15.s, z29.s
zip2	z16.s, z16.s, z29.s
zip2	z17.s, z17.s, z29.s
zip2	z18.s, z18.s, z29.s
subs	x2, x2, x16, lsl #5
bl	poly1305_lazy_reduce_sve2
ldr	x30, [sp, #0x8]
b.hi	L_e70
L_fe0:
adds	x2, x2, x16, lsl #4
b.eq	L_107c
add	z11.s, z11.s, z26.s
add	z9.s, z9.s, z24.s
add	z10.s, z10.s, z25.s
add	z12.s, z12.s, z27.s
add	z13.s, z13.s, z28.s
umullb	z22.d, z11.s, z1.s[2]
umullb	z19.d, z11.s, z6.s[2]
umullb	z23.d, z11.s, z3.s[2]
umullb	z20.d, z11.s, z8.s[2]
umullb	z21.d, z11.s, z0.s[2]
umlalb	z22.d, z9.s, z5.s[2]
umlalb	z23.d, z9.s, z7.s[2]
umlalb	z21.d, z9.s, z3.s[2]
umlalb	z19.d, z9.s, z0.s[2]
umlalb	z20.d, z9.s, z1.s[2]
mov	z11.d, z16.d
umlalb	z22.d, z10.s, z3.s[2]
umlalb	z23.d, z10.s, z5.s[2]
umlalb	z19.d, z10.s, z8.s[2]
umlalb	z21.d, z10.s, z1.s[2]
umlalb	z20.d, z10.s, z0.s[2]
mov	z9.d, z14.d
umlalb	z22.d, z12.s, z0.s[2]
umlalb	z19.d, z12.s, z4.s[2]
umlalb	z23.d, z12.s, z1.s[2]
umlalb	z20.d, z12.s, z6.s[2]
umlalb	z21.d, z12.s, z8.s[2]
mov	z10.d, z15.d
umlalb	z22.d, z13.s, z8.s[2]
umlalb	z19.d, z13.s, z2.s[2]
umlalb	z23.d, z13.s, z0.s[2]
umlalb	z20.d, z13.s, z4.s[2]
umlalb	z21.d, z13.s, z6.s[2]
mov	z12.d, z17.d
bl	poly1305_lazy_reduce_sve2
ldr	x30, [sp, #0x8]
mov	z13.d, z18.d
L_107c:
cmp	x16, #0x2
b.ls	L_1180
mov	x15, #0x1
whilelo	p1.s, xzr, x15
L_108c:
ldr	w10, [x25]
ldr	w11, [x25, #0x1c]
ldr	w12, [x25, #0x38]
mov	z0.s, p1/m, w10
ldr	w13, [x25, #0x54]
mov	z1.s, p1/m, w11
mov	z0.q, q0
ldr	w14, [x25, #0x70]
mov	z3.s, p1/m, w12
mov	z1.q, q1
mov	z5.s, p1/m, w13
mov	z3.q, q3
mov	z7.s, p1/m, w14
add	x25, x25, #0x4
mov	z5.q, q5
mov	z7.q, q7
add	z11.s, z11.s, z26.s
adr	z2.s, [z1.s, z1.s, lsl #2]
add	z9.s, z9.s, z24.s
adr	z4.s, [z3.s, z3.s, lsl #2]
add	z10.s, z10.s, z25.s
adr	z6.s, [z5.s, z5.s, lsl #2]
add	z12.s, z12.s, z27.s
adr	z8.s, [z7.s, z7.s, lsl #2]
add	z13.s, z13.s, z28.s
umullb	z22.d, z9.s, z5.s[0]
umullb	z23.d, z9.s, z7.s[0]
umullb	z21.d, z9.s, z3.s[0]
umullb	z19.d, z9.s, z0.s[0]
umullb	z20.d, z9.s, z1.s[0]
umlalb	z22.d, z10.s, z3.s[0]
umlalb	z23.d, z10.s, z5.s[0]
umlalb	z19.d, z10.s, z8.s[0]
umlalb	z21.d, z10.s, z1.s[0]
umlalb	z20.d, z10.s, z0.s[0]
umlalb	z22.d, z11.s, z1.s[0]
umlalb	z19.d, z11.s, z6.s[0]
umlalb	z23.d, z11.s, z3.s[0]
umlalb	z20.d, z11.s, z8.s[0]
umlalb	z21.d, z11.s, z0.s[0]
umlalb	z22.d, z12.s, z0.s[0]
umlalb	z19.d, z12.s, z4.s[0]
umlalb	z23.d, z12.s, z1.s[0]
umlalb	z20.d, z12.s, z6.s[0]
umlalb	z21.d, z12.s, z8.s[0]
umlalb	z22.d, z13.s, z8.s[0]
umlalb	z19.d, z13.s, z2.s[0]
umlalb	z23.d, z13.s, z0.s[0]
umlalb	z20.d, z13.s, z4.s[0]
umlalb	z21.d, z13.s, z6.s[0]
bl	poly1305_lazy_reduce_sve2
ldr	x30, [sp, #0x8]
index	z29.s, w16, #0x1
tbl	z9.s, { z9.s }, z29.s
tbl	z10.s, { z10.s }, z29.s
tbl	z11.s, { z11.s }, z29.s
tbl	z12.s, { z12.s }, z29.s
tbl	z13.s, { z13.s }, z29.s
lsr	x16, x16, #1
cmp	x16, #0x2
b.hi	L_108c
L_1180:
add	z26.s, z26.s, z11.s
add	z24.s, z24.s, z9.s
add	z25.s, z25.s, z10.s
add	z27.s, z27.s, z12.s
add	z28.s, z28.s, z13.s
trn1	z26.s, z31.s, z26.s
trn1	z24.s, z31.s, z24.s
trn1	z25.s, z31.s, z25.s
trn1	z27.s, z31.s, z27.s
trn1	z28.s, z31.s, z28.s
umullt	z22.d, z26.s, z1.s
umullt	z19.d, z26.s, z6.s
umullt	z23.d, z26.s, z3.s
umullt	z20.d, z26.s, z8.s
umullt	z21.d, z26.s, z0.s
umlalt	z22.d, z24.s, z5.s
umlalt	z23.d, z24.s, z7.s
umlalt	z21.d, z24.s, z3.s
umlalt	z19.d, z24.s, z0.s
umlalt	z20.d, z24.s, z1.s
umlalt	z22.d, z25.s, z3.s
umlalt	z23.d, z25.s, z5.s
umlalt	z19.d, z25.s, z8.s
umlalt	z21.d, z25.s, z1.s
umlalt	z20.d, z25.s, z0.s
umlalt	z22.d, z27.s, z0.s
umlalt	z19.d, z27.s, z4.s
umlalt	z23.d, z27.s, z1.s
umlalt	z20.d, z27.s, z6.s
umlalt	z21.d, z27.s, z8.s
umlalt	z22.d, z28.s, z8.s
umlalt	z19.d, z28.s, z2.s
umlalt	z23.d, z28.s, z0.s
umlalt	z20.d, z28.s, z4.s
umlalt	z21.d, z28.s, z6.s
mov	x15, #0x2
whilelo	p2.d, xzr, x15
mov	z31.d, #0xffffffffffffffff
lsr	z31.d, z31.d, #0x26
uaddv	d22, p2, z22.d
ldp	d8, d9, [sp, #0x50]
uaddv	d19, p2, z19.d
ldp	d10, d11, [sp, #0x60]
uaddv	d23, p2, z23.d
ldp	d12, d13, [sp, #0x70]
uaddv	d20, p2, z20.d
ldp	d14, d15, [sp, #0x80]
uaddv	d21, p2, z21.d
ushr	d29, d22, #0x1a
and	v22.8b, v22.8b, v31.8b
ushr	d30, d19, #0x1a
and	v19.8b, v19.8b, v31.8b
add	d23, d23, d29
add	d20, d20, d30
ushr	d29, d23, #0x1a
and	v23.8b, v23.8b, v31.8b
ushr	d30, d20, #0x1a
and	v20.8b, v20.8b, v31.8b
add	d21, d21, d30
add	d19, d19, d29
shl	d29, d29, #0x2
ushr	d30, d21, #0x1a
and	v21.8b, v21.8b, v31.8b
add	d19, d19, d29
add	d22, d22, d30
ushr	d29, d19, #0x1a
and	v19.8b, v19.8b, v31.8b
ushr	d30, d22, #0x1a
and	v22.8b, v22.8b, v31.8b
add	d20, d20, d29
add	d23, d23, d30
stp	s19, s20, [x0], #0x8
stp	s21, s22, [x0], #0x8
str	s23, [x0]
L_12a8:
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldp	x23, x24, [sp, #0x30]
ldp	x25, x26, [sp, #0x40]
ldr	x29, [sp], #0x90
ret
L_12c0:
b	poly1305_blocks
	.section .rodata
bums_rodata:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 80,111,108,121,49,51,48,53,32,102,111,114,32,65,82,77
	.byte 118,56,44,32,67,82,89,80,84,79,71,65,77,83,32,98
	.byte 121,32,60,104,116,116,112,115,58,47,47,103,105,116,104,117
	.byte 98,46,99,111,109,47,100,111,116,45,97,115,109,62,0,0
