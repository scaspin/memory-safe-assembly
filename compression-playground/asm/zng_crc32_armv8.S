	.text
crc32_armv8:
subs	x9, x2, #0x1
mvn	w8, w0
b.eq	L_b8
tst	x1, #0x7
b.eq	L_60
cbz	x2, L_94
tbz	w1, #0x0, L_28
mov	x2, x9
ldrb	w10, [x1], #0x1
crc32b	w8, w8, w10
L_28:
subs	x9, x2, #0x2
b.lo	L_44
and	x10, x1, #0x3
cbz	x10, L_44
mov	x2, x9
ldrh	w10, [x1], #0x2
crc32h	w8, w8, w10
L_44:
subs	x9, x2, #0x4
b.lo	L_60
and	x10, x1, #0x7
cbz	x10, L_60
mov	x2, x9
ldr	w10, [x1], #0x4
crc32w	w8, w8, w10
L_60:
cmp	x2, #0x8
b.lo	L_7c
L_68:
sub	x2, x2, #0x8
ldr	x9, [x1], #0x8
cmp	x2, #0x7
crc32x	w8, w8, x9
b.hi	L_68
L_7c:
cmp	x2, #0x4
b.hs	L_9c
tbnz	w2, #0x1, L_a8
L_88:
tbz	w2, #0x0, L_94
L_8c:
ldrb	w9, [x1]
crc32b	w8, w8, w9
L_94:
mvn	w0, w8
ret
L_9c:
ldr	w9, [x1], #0x4
crc32w	w8, w8, w9
tbz	w2, #0x1, L_88
L_a8:
ldrh	w9, [x1], #0x2
crc32h	w8, w8, w9
tbnz	w2, #0x0, L_8c
b	L_94
L_b8:
ldrb	w9, [x1]
crc32b	w8, w8, w9
mvn	w0, w8
ret
crc32_fold_copy_armv8:
stp	x29, x30, [sp, #-0x30]!
stp	x22, x21, [sp, #0x10]
mov	x21, x0
ldr	w0, [x0, #0x40]
stp	x20, x19, [sp, #0x20]
mov	x20, x2
mov	x22, x1
mov	x1, x2
mov	x2, x3
mov	x29, sp
mov	x19, x3
bl	crc32_armv8
mov	w8, w0
mov	x0, x22
mov	x1, x20
mov	x2, x19
str	w8, [x21, #0x40]
ldp	x20, x19, [sp, #0x20]
ldp	x22, x21, [sp, #0x10]
ldp	x29, x30, [sp], #0x30
b	memcpy
crc32_fold_armv8:
stp	x29, x30, [sp, #-0x20]!
str	x19, [sp, #0x10]
mov	x19, x0
ldr	w0, [x0, #0x40]
mov	x29, sp
bl	crc32_armv8
str	w0, [x19, #0x40]
ldr	x19, [sp, #0x10]
ldp	x29, x30, [sp], #0x20
ret
// ---- reference memcpy: copies x1[0..x2) to x0[0..x2)
	.text
memcpy:
mov	x3, x0
cbz	x2, memcpy_done
memcpy_loop:
ldrb	w4, [x1], #1
strb	w4, [x3], #1
subs	x2, x2, #1
b.ne	memcpy_loop
memcpy_done:
ret
