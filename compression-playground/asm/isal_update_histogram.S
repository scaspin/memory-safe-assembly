	.text
isal_update_histogram_aarch64:
cmp	w1, #0x0
b.le	.done
stp	x29, x30, [sp, #-0x40]!
mov	x29, sp
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
str	x23, [sp, #0x30]
add	x20, x2, #0x9e0
add	x21, x0, w1, sxtw
mov	x19, x0
sub	x22, x21, #0x3
mov	x23, x2
mov	x0, x20
mov	w1, #0x0
mov	x2, #0x4000
bl	memset
cmp	x19, x22
b.hs	.loop_end
mov	x10, x19
add	x12, x23, #0x8f0
mov	w11, #0x7ffe
b	.loop
.loop_2nd_stream:
and	x8, x8, #0xff
mov	x19, x9
cmp	x22, x19
ldr	x0, [x23, x8, lsl #3]
add	x0, x0, #0x1
str	x0, [x23, x8, lsl #3]
b.ls	.loop_end
.loop:
ldr	w8, [x19]
add	x9, x19, #0x1
mov	w0, w8
crc32cw	w0, wzr, w0
ubfiz	x0, x0, #1, #13
sub	x2, x19, x10
ldrh	w7, [x20, x0]
strh	w2, [x20, x0]
sub	w2, w2, w7
and	w7, w2, #0xffff
sub	w0, w7, #0x1
cmp	w0, w11
b.hi	.loop_2nd_stream
sub	w2, w21, w19
mov	x1, x19
sub	x0, x19, w7, uxth
mov	x5, #0x102
cmp	x2, x5
csel	x2, x2, x5, ls
mov	x3, #0x0
L_c4:
sub	x5, x2, x3
cmp	x5, #0x8
b.lo	L_e8
ldr	x5, [x0, x3]
ldr	x6, [x1, x3]
eor	x5, x6, x5
cbnz	x5, L_10c
add	x3, x3, #0x8
b	L_c4
L_e8:
cbz	x5, L_11c
L_ec:
ldrb	w5, [x0, x3]
ldrb	w6, [x1, x3]
cmp	w5, w6
b.ne	L_11c
add	x3, x3, #0x1
cmp	x3, x2
b.lo	L_ec
b	L_11c
L_10c:
rbit	x5, x5
clz	x5, x5
lsr	x5, x5, #3
add	x3, x3, x5
L_11c:
cmp	w3, #0x3
b.ls	.loop_2nd_stream
add	x4, x19, #0x3
cmp	x4, x22
csel	x4, x4, x22, ls
cmp	x4, x9
b.ls	.skip_inner_loop
.inner_loop:
ldr	w0, [x9]
crc32cw	w0, wzr, w0
ubfiz	x0, x0, #1, #13
sub	x1, x9, x10
add	x9, x9, #0x1
cmp	x9, x4
strh	w1, [x20, x0]
b.ne	.inner_loop
.skip_inner_loop:
mov	w5, w7
mov	w7, #-0x1
cmp	w5, #0x8, lsl #12
b.hi	.dist2code_done
sub	w7, w5, #0x1
cmp	w5, #0x4
b.ls	.dist2code_done
clz	w6, w7
mov	w5, #0x1e
sub	w5, w5, w6
lsr	w7, w7, w5
add	w7, w7, w5, lsl #1
.dist2code_done:
ubfx	x2, x7, #0, #32
ldr	x1, [x12, x2, lsl #3]
add	x1, x1, #0x1
str	x1, [x12, x2, lsl #3]
adrp	x5, .len_to_code_tab_lanchor
add	x5, x5, :lo12:.len_to_code_tab_lanchor
ldr	w6, [x5, w3, uxtw #2]
add	w6, w6, #0x100
ubfx	x0, x6, #0, #32
ldr	x1, [x23, x0, lsl #3]
add	x1, x1, #0x1
str	x1, [x23, x0, lsl #3]
sub	w3, w3, #0x1
add	x3, x3, #0x1
add	x19, x19, x3
cmp	x22, x19
b.hi	.loop
nop
.loop_end:
cmp	x21, x19
b.ls	.loop_fold_end
mov	x0, x19
ldrb	w1, [x0], #0x1
cmp	x21, x0
ldr	x0, [x23, x1, lsl #3]
add	x0, x0, #0x1
str	x0, [x23, x1, lsl #3]
b.ls	.loop_fold_end
ldrb	w1, [x19, #0x1]
add	x0, x19, #0x2
cmp	x21, x0
ldr	x0, [x23, x1, lsl #3]
add	x0, x0, #0x1
str	x0, [x23, x1, lsl #3]
b.ls	.loop_fold_end
ldrb	w1, [x19, #0x2]
add	x0, x19, #0x3
cmp	x21, x0
ldr	x0, [x23, x1, lsl #3]
add	x0, x0, #0x1
str	x0, [x23, x1, lsl #3]
b.ls	.loop_fold_end
ldrb	w1, [x19, #0x3]
ldr	x0, [x23, x1, lsl #3]
add	x0, x0, #0x1
str	x0, [x23, x1, lsl #3]
.loop_fold_end:
ldr	x0, [x23, #0x800]
add	x0, x0, #0x1
str	x0, [x23, #0x800]
ldr	x23, [sp, #0x30]
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldp	x29, x30, [sp], #0x40
ret
.done:
ret
	.section .rodata
.len_to_code_tab_lanchor:
len_to_code_tab:
	.size len_to_code_tab, 1056
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
	.byte 2,0,0,0,3,0,0,0,4,0,0,0,5,0,0,0
	.byte 6,0,0,0,7,0,0,0,8,0,0,0,9,0,0,0
	.byte 9,0,0,0,10,0,0,0,10,0,0,0,11,0,0,0
	.byte 11,0,0,0,12,0,0,0,12,0,0,0,13,0,0,0
	.byte 13,0,0,0,13,0,0,0,13,0,0,0,14,0,0,0
	.byte 14,0,0,0,14,0,0,0,14,0,0,0,15,0,0,0
	.byte 15,0,0,0,15,0,0,0,15,0,0,0,16,0,0,0
	.byte 16,0,0,0,16,0,0,0,16,0,0,0,17,0,0,0
	.byte 17,0,0,0,17,0,0,0,17,0,0,0,17,0,0,0
	.byte 17,0,0,0,17,0,0,0,17,0,0,0,18,0,0,0
	.byte 18,0,0,0,18,0,0,0,18,0,0,0,18,0,0,0
	.byte 18,0,0,0,18,0,0,0,18,0,0,0,19,0,0,0
	.byte 19,0,0,0,19,0,0,0,19,0,0,0,19,0,0,0
	.byte 19,0,0,0,19,0,0,0,19,0,0,0,20,0,0,0
	.byte 20,0,0,0,20,0,0,0,20,0,0,0,20,0,0,0
	.byte 20,0,0,0,20,0,0,0,20,0,0,0,21,0,0,0
	.byte 21,0,0,0,21,0,0,0,21,0,0,0,21,0,0,0
	.byte 21,0,0,0,21,0,0,0,21,0,0,0,21,0,0,0
	.byte 21,0,0,0,21,0,0,0,21,0,0,0,21,0,0,0
	.byte 21,0,0,0,21,0,0,0,21,0,0,0,22,0,0,0
	.byte 22,0,0,0,22,0,0,0,22,0,0,0,22,0,0,0
	.byte 22,0,0,0,22,0,0,0,22,0,0,0,22,0,0,0
	.byte 22,0,0,0,22,0,0,0,22,0,0,0,22,0,0,0
	.byte 22,0,0,0,22,0,0,0,22,0,0,0,23,0,0,0
	.byte 23,0,0,0,23,0,0,0,23,0,0,0,23,0,0,0
	.byte 23,0,0,0,23,0,0,0,23,0,0,0,23,0,0,0
	.byte 23,0,0,0,23,0,0,0,23,0,0,0,23,0,0,0
	.byte 23,0,0,0,23,0,0,0,23,0,0,0,24,0,0,0
	.byte 24,0,0,0,24,0,0,0,24,0,0,0,24,0,0,0
	.byte 24,0,0,0,24,0,0,0,24,0,0,0,24,0,0,0
	.byte 24,0,0,0,24,0,0,0,24,0,0,0,24,0,0,0
	.byte 24,0,0,0,24,0,0,0,24,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,25,0,0,0
	.byte 25,0,0,0,25,0,0,0,25,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,26,0,0,0
	.byte 26,0,0,0,26,0,0,0,26,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,28,0,0,0,28,0,0,0
	.byte 28,0,0,0,28,0,0,0,29,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
// ---- reference memset: stores the low byte of w1 to x0[0..x2)
	.text
memset:
mov	x3, x0
cbz	x2, memset_done
memset_loop:
strb	w1, [x3], #1
subs	x2, x2, #1
b.ne	memset_loop
memset_done:
ret
