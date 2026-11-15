	.text
_armv7_neon_probe:
mov	v15.16b, v15.16b
ret
_armv7_tick:
mrs	x0, CNTVCT_EL0
ret
_armv8_aes_probe:
aese	v0.16b, v0.16b
ret
_armv8_sha1_probe:
sha1h	s0, s0
ret
_armv8_sha256_probe:
sha256su0	v0.4s, v0.4s
ret
_armv8_pmull_probe:
pmull	v0.1q, v0.1d, v0.1d
ret
_armv8_sm4_probe:
sm4e	v0.4s, v0.4s
ret
_armv8_sha512_probe:
sha512su0	v0.2d, v0.2d
ret
_armv8_eor3_probe:
eor3	v0.16b, v0.16b, v1.16b, v2.16b
ret
_armv8_sve_probe:
eor	z0.d, z0.d, z0.d
ret
_armv8_sve2_probe:
xar	z0.d, z0.d, z0.d, #0x20
ret
_armv8_sve_get_vl_bytes:
cntb	x0
ret
_armv8_cpuid_probe:
mrs	x0, MIDR_EL1
ret
_armv8_sm3_probe:
sm3partw1	v4.4s, v0.4s, v3.4s
ret
nop
nop
nop
nop
OPENSSL_cleanse:
cbz	x1, L_9c
cmp	x1, #0xf
b.hi	L_a0
nop
L_90:
strb	wzr, [x0], #0x1
subs	x1, x1, #0x1
b.ne	L_90
L_9c:
ret
L_a0:
tst	x0, #0x7
b.eq	L_c0
strb	wzr, [x0], #0x1
sub	x1, x1, #0x1
b	L_a0
nop
nop
nop
L_c0:
str	xzr, [x0], #0x8
sub	x1, x1, #0x8
tst	x1, #0xfffffffffffffff8
b.ne	L_c0
cbnz	x1, L_90
ret
nop
nop
CRYPTO_memcmp:
eor	w3, w3, w3
cbz	x2, L_138
cmp	x2, #0x10
b.ne	L_120
ldp	x8, x9, [x0]
ldp	x10, x11, [x1]
eor	x8, x8, x10
eor	x9, x9, x11
orr	x8, x8, x9
mov	x0, #0x1
cmp	x8, #0x0
csel	x0, xzr, x0, eq
ret
nop
nop
nop
L_120:
ldrb	w4, [x0], #0x1
ldrb	w5, [x1], #0x1
eor	w4, w4, w5
orr	w3, w3, w4
subs	x2, x2, #0x1
b.ne	L_120
L_138:
neg	w0, w3
lsr	w0, w0, #31
ret
_armv8_rng_probe:
mrs	x0, RNDR
mrs	x0, RNDRRS
ret
OPENSSL_rndr_asm:
mov	x2, xzr
mov	x3, xzr
nop
nop
L_160:
cmp	x1, #0x0
b.eq	.rndr_done
mov	x3, xzr
mrs	x3, RNDR
b.eq	.rndr_done
cmp	x1, #0x8
b.lt	L_190
str	x3, [x0]
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	x1, x1, #0x8
b.ge	L_160
L_190:
strb	w3, [x0]
lsr	x3, x3, #8
add	x2, x2, #0x1
add	x0, x0, #0x1
subs	x1, x1, #0x1
b.gt	L_190
nop
nop
.rndr_done:
mov	x0, x2
ret
nop
nop
OPENSSL_rndrrs_asm:
mov	x2, xzr
mov	x3, xzr
nop
nop
L_1d0:
cmp	x1, #0x0
b.eq	.rndrrs_done
mov	x3, xzr
mrs	x3, RNDRRS
b.eq	.rndrrs_done
cmp	x1, #0x8
b.lt	L_200
str	x3, [x0]
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	x1, x1, #0x8
b.ge	L_1d0
L_200:
strb	w3, [x0]
lsr	x3, x3, #8
add	x2, x2, #0x1
add	x0, x0, #0x1
subs	x1, x1, #0x1
b.gt	L_200
nop
nop
.rndrrs_done:
mov	x0, x2
ret
