	.text
set_long_icf_fg_aarch64:
stp	x29, x30, [sp, #-0xc0]!
mov	x29, sp
stp	x21, x22, [sp, #0x20]
add	x21, x29, #0x40
stp	x19, x20, [sp, #0x10]
str	x23, [sp, #0x30]
add	x22, x0, x1
mov	x20, x0
add	x23, x0, x2
mov	x19, x3
adrp	x1, .data_dist_start
mov	x2, #0x80
add	x1, x1, :lo12:.data_dist_start
mov	x0, x21
bl	memcpy
add	x5, x22, #0x120
cmp	x23, x5
csel	x23, x23, x5, lo
cmp	x20, x22
b.hs	.done
mov	x13, #0x8
mov	w10, #0x200
mov	w9, #0x101
b	.while_outer_loop
.while_outer_check:
add	x20, x20, #0x1
add	x19, x19, #0x4
cmp	x22, x20
b.ls	.done
.while_outer_loop:
ldrh	w7, [x19]
and	w7, w7, #0x3ff
cmp	w7, #0x105
b.ls	.while_outer_check
ldr	w8, [x19]
add	x1, x20, #0x8
ldrh	w11, [x19, #0x2]
sub	w2, w23, w1
ubfx	x8, x8, #10, #9
ubfx	x11, x11, #3, #13
ubfx	x0, x8, #0, #32
ldr	w0, [x21, x0, lsl #2]
add	w0, w11, w0
sub	x0, x13, x0
add	x0, x20, x0
mov	x4, #0x0
L_b0:
sub	x5, x2, x4
cmp	x5, #0x8
b.lo	L_d4
ldr	x5, [x0, x4]
ldr	x6, [x1, x4]
eor	x5, x6, x5
cbnz	x5, L_f8
add	x4, x4, #0x8
b	L_b0
L_d4:
cbz	x5, L_108
L_d8:
ldrb	w5, [x0, x4]
ldrb	w6, [x1, x4]
cmp	w5, w6
b.ne	L_108
add	x4, x4, #0x1
cmp	x4, x2
b.lo	L_d8
b	L_108
L_f8:
rbit	x5, x5
clz	x5, x5
lsr	x5, x5, #3
add	x4, x4, x5
L_108:
mov	w0, w4
add	w0, w0, #0x106
cmp	w0, w7
b.ls	.while_outer_check
lsl	w2, w11, #19
orr	w2, w2, w8, lsl #10
.while_inner_loop:
cmp	w0, #0x200
add	x20, x20, #0x1
csel	w1, w0, w10, ls
sub	w0, w0, #0x1
orr	w1, w1, w2
str	w1, [x19]
ldrh	w1, [x19, #0x4]!
and	w1, w1, #0x3ff
cmp	w1, #0x101
csel	w1, w1, w9, hs
cmp	w1, w0
b.lo	.while_inner_loop
add	x20, x20, #0x1
add	x19, x19, #0x4
cmp	x22, x20
b.hi	.while_outer_loop
.done:
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldr	x23, [sp, #0x30]
ldp	x29, x30, [sp], #0xc0
ret
	.section .rodata
	.p2align 3
.data_dist_start:
.real_data_dist_start:
	.byte 1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0
	.byte 5,0,0,0,7,0,0,0,9,0,0,0,13,0,0,0
	.byte 17,0,0,0,25,0,0,0,33,0,0,0,49,0,0,0
	.byte 65,0,0,0,97,0,0,0,129,0,0,0,193,0,0,0
	.byte 1,1,0,0,129,1,0,0,1,2,0,0,1,3,0,0
	.byte 1,4,0,0,1,6,0,0,1,8,0,0,1,12,0,0
	.byte 1,16,0,0,1,24,0,0,1,32,0,0,1,48,0,0
	.byte 1,64,0,0,1,96,0,0,0,0,0,0,0,0,0,0
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
