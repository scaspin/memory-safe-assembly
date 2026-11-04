	.text
isal_deflate_finish_aarch64:
stp	x29, x30, [sp, #-0x90]!
mov	x29, sp
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
stp	x27, x28, [sp, #0x50]
ldr	w16, [x0, #0x18]
ldr	x14, [x0, #0x10]
add	x16, x14, w16, uxtw
sub	x16, x16, #0x8
mov	x15, x14
stp	x14, x16, [x0, #0x68]
str	x15, [x0, #0x78]
ldr	w2, [x0, #0x60]
ldr	x17, [x0, #0x58]
add	x26, x0, #0x10, lsl #12
add	x26, x26, #0x1d0
ldr	w9, [x0, #0x8]
ldr	x19, [x0]
mov	x21, x19
add	x20, x19, w9, uxtw
ldr	x13, [x0, #0x20]
cbz	w9, update_not_full
sub	x22, x20, #0x4
cmp	x21, x22
ldr	w27, [x0, #0xc]
sub	x27, x21, w27, uxtw
ldr	w28, [x0, #0x4c]
ldr	w11, [x0, #0x50]
b.hi	main_loop_end
main_loop_start:
cmp	x14, x16
b.hi	update_state_exit
ldr	w23, [x21]
crc32cw	w24, wzr, w23
and	w24, w24, w11
ldrh	w5, [x26, x24, lsl #1]
sub	x25, x21, x27
strh	w25, [x26, x24, lsl #1]
sub	w25, w25, w5
and	w25, w25, #0xffff
sub	w5, w25, #0x1
cmp	w28, w5
b.ls	get_lit_code
sub	x7, x21, x25
sub	x24, x20, x21
mov	x5, #0x102
cmp	x24, x5
csel	x24, x24, x5, ls
mov	x12, #0x0
L_c8:
sub	x5, x24, x12
cmp	x5, #0x8
b.lo	L_ec
ldr	x5, [x7, x12]
ldr	x6, [x21, x12]
eor	x5, x6, x5
cbnz	x5, L_110
add	x12, x12, #0x8
b	L_c8
L_ec:
cbz	x5, L_120
L_f0:
ldrb	w5, [x7, x12]
ldrb	w6, [x21, x12]
cmp	w5, w6
b.ne	L_120
add	x12, x12, #0x1
cmp	x12, x24
b.lo	L_f0
b	L_120
L_110:
rbit	x5, x5
clz	x5, x5
lsr	x5, x5, #3
add	x12, x12, x5
L_120:
cmp	w12, #0x3
b.ls	get_lit_code
add	x5, x13, #0x14c
ldr	w24, [x5, x12, lsl #2]
lsr	w3, w24, #5
and	x24, x24, #0x1f
cmp	w25, #0x2
b.hi	_compute_dist_code
add	x5, x13, #0x14c
ldr	w4, [x5, x25, lsl #2]
lsr	w10, w4, #5
and	x4, x4, #0x1f
b	_end_get_dist_code
_compute_dist_code:
and	w25, w25, #0xffff
sub	w25, w25, #0x1
clz	w5, w25
mov	w6, #0x1e
sub	w5, w6, w5
mov	w6, #0x1
lsl	w6, w6, w5
sub	w6, w6, #0x1
and	w6, w6, w25
asr	w25, w25, w5
lsl	w7, w5, #1
add	w7, w25, w7
add	x10, x13, #0x85c
add	x4, x13, #0x898
ldrh	w10, [x10, x7, lsl #1]
ldrb	w4, [x4, x7]
lsl	w6, w6, w4
orr	w10, w10, w6
add	w4, w4, w5
_end_get_dist_code:
lsl	x10, x10, x24
orr	x3, x3, x10
add	x24, x24, x4
add	x21, x21, w12, uxtw
lsl	x3, x3, x2
orr	x17, x3, x17
add	x2, x24, x2
str	x17, [x14]
and	w3, w2, #0xfffffff8
lsr	w24, w2, #3
add	x14, x14, w24, uxtw
sub	w2, w2, w3
lsr	x17, x17, x3
str	x17, [x0, #0x58]
str	w2, [x0, #0x60]
str	x14, [x0, #0x68]
cmp	x21, x22
b.ls	main_loop_start
b	main_loop_end
get_lit_code:
and	w23, w23, #0xff
add	x3, x13, #0x558
ldrh	w3, [x3, x23, lsl #1]
add	x24, x13, #0x75a
ldrb	w24, [x24, x23]
add	x21, x21, #0x1
lsl	x3, x3, x2
orr	x17, x3, x17
add	x2, x24, x2
str	x17, [x14]
and	w3, w2, #0xfffffff8
lsr	w24, w2, #3
add	x14, x14, w24, uxtw
sub	w2, w2, w3
lsr	x17, x17, x3
str	x17, [x0, #0x58]
str	w2, [x0, #0x60]
str	x14, [x0, #0x68]
cmp	x21, x22
b.ls	main_loop_start
main_loop_end:
sub	x22, x20, #0x1
cmp	x21, x22
b.hi	update_not_full
second_loop_start:
cmp	x14, x16
b.hi	update_state_exit
ldrb	w23, [x21]
add	x3, x13, #0x558
ldrh	w3, [x3, x23, lsl #1]
add	x24, x13, #0x75a
ldrb	w24, [x24, x23]
add	x21, x21, #0x1
lsl	x3, x3, x2
orr	x17, x3, x17
add	x2, x24, x2
str	x17, [x14]
and	w3, w2, #0xfffffff8
lsr	w24, w2, #3
add	x14, x14, w24, uxtw
sub	w2, w2, w3
lsr	x17, x17, x3
str	x17, [x0, #0x58]
str	w2, [x0, #0x60]
str	x14, [x0, #0x68]
cmp	x21, x22
b.ls	second_loop_start
update_not_full:
cmp	x14, x16
b.hi	update_state_exit
mov	w23, #0x100
add	x3, x13, #0x558
ldrh	w3, [x3, x23, lsl #1]
add	x24, x13, #0x75a
ldrb	w24, [x24, x23]
lsl	x3, x3, x2
orr	x17, x3, x17
add	x2, x24, x2
str	x17, [x14]
and	w3, w2, #0xfffffff8
lsr	w24, w2, #3
add	x14, x14, w24, uxtw
sub	w2, w2, w3
lsr	x17, x17, x3
str	x17, [x0, #0x58]
str	w2, [x0, #0x60]
str	x14, [x0, #0x68]
ldrh	w10, [x0, #0x38]
mov	w5, #0x1
strb	w5, [x0, #0x86]
cmp	w10, w5
mov	w5, #0xa
mov	w6, #0x8
csel	w5, w5, w6, eq
str	w5, [x0, #0x54]
update_state_exit:
sub	x14, x14, x15
cmp	x21, x19
b.ls	skip_has_hist
mov	w5, #0x1
strb	w5, [x0, #0x87]
skip_has_hist:
ldr	w5, [x0, #0xc]
ldr	x15, [x0, #0x10]
str	x21, [x0]
sub	x19, x21, x19
sub	x20, x20, x21
add	w5, w5, w19
stp	w20, w5, [x0, #0x8]
ldp	w21, w19, [x0, #0x18]
add	x15, x15, x14
str	x15, [x0, #0x10]
add	w19, w19, w14
sub	w21, w21, w14
stp	w21, w19, [x0, #0x18]
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldp	x23, x24, [sp, #0x30]
ldp	x25, x26, [sp, #0x40]
ldp	x27, x28, [sp, #0x50]
ldp	x29, x30, [sp], #0x90
ret
