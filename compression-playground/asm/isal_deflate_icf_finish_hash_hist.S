	.text
write_deflate_icf_constprop:
ldrh	w2, [x0]
mov	w3, #0x1e
bfxil	w2, w1, #0, #10
strh	w2, [x0]
ldr	w1, [x0]
bfi	w1, w3, #10, #9
str	w1, [x0]
ubfx	x1, x1, #16, #3
strh	w1, [x0, #0x2]
ret
write_deflate_icf:
ldrh	w4, [x0]
bfxil	w4, w1, #0, #10
strh	w4, [x0]
ldr	w1, [x0]
bfi	w1, w2, #10, #9
str	w1, [x0]
lsr	w1, w1, #16
bfi	w1, w3, #3, #13
strh	w1, [x0, #0x2]
ret
update_state:
sub	x7, x2, x1
ldr	x4, [x0, #0x30]
cmp	x7, #0x0
b.le	L_68
mov	w1, #0x1
strb	w1, [x0, #0x87]
L_68:
ldr	w1, [x0, #0xc]
sub	x6, x6, x5
str	x2, [x0]
sub	x3, x3, x2
add	w1, w1, w7
stp	w3, w1, [x0, #0x8]
str	w1, [x0, #0x48]
asr	x6, x6, #2
str	x5, [x4, #0x1250]
str	x6, [x4, #0x1258]
ret
isal_deflate_icf_finish_hash_hist_aarch64:
ldr	w11, [x0, #0x8]
cbz	w11, .stream_not_available
stp	x29, x30, [sp, #-0x60]!
mov	x29, sp
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
stp	x27, x28, [sp, #0x50]
mov	x15, x0
ldr	x13, [x0, #0x30]
ldr	x21, [x0]
ldr	x22, [x13, #0x1250]
add	x23, x0, #0x40
ldr	x12, [x13, #0x1258]
mov	x8, x21
ldr	w17, [x0, #0xc]
mov	x25, #0x1268
add	x14, x13, x25
add	x11, x21, w11, uxtw
and	x12, x12, #0xfffffffffffffffc
mov	x10, x22
ldp	w20, w19, [x23, #0xc]
sub	x17, x21, x17
add	x12, x22, x12
mov	x5, x10
add	x0, x8, #0x3
cmp	x11, x0
b.ls	.while_first_end
.while_first:
cmp	x10, x12
b.hs	.save_and_update_state
ldr	w9, [x8]
mov	w0, w9
crc32cw	w0, wzr, w0
and	w0, w0, w19
sub	x2, x8, x17
lsl	x0, x0, #1
ldrh	w7, [x14, x0]
strh	w2, [x14, x0]
sub	w2, w2, w7
and	w7, w2, #0xffff
sub	w24, w7, #0x1
cmp	w24, w20
b.hs	.skip_compare258
mov	x2, #0x0
sub	w2, w11, w8
mov	x1, x8
sub	x0, x8, w7, uxth
mov	x25, #0x102
cmp	x2, x25
csel	x2, x2, x25, ls
mov	x27, #0x0
L_164:
sub	x25, x2, x27
cmp	x25, #0x8
b.lo	L_188
ldr	x25, [x0, x27]
ldr	x26, [x1, x27]
eor	x25, x26, x25
cbnz	x25, L_1ac
add	x27, x27, #0x8
b	L_164
L_188:
cbz	x25, L_1bc
L_18c:
ldrb	w25, [x0, x27]
ldrb	w26, [x1, x27]
cmp	w25, w26
b.ne	L_1bc
add	x27, x27, #0x1
cmp	x27, x2
b.lo	L_18c
b	L_1bc
L_1ac:
rbit	x25, x25
clz	x25, x25
lsr	x25, x25, #3
add	x27, x27, x25
L_1bc:
mov	w0, w27
and	w2, w0, #0xffff
cmp	w2, #0x3
b.hi	.while_first_match_length
.skip_compare258:
and	w9, w9, #0xff
add	x8, x8, #0x1
mov	w1, w9
mov	x0, x10
add	x9, x13, w9, uxtb #2
ldr	w25, [x9, #0x8f8]
add	w25, w25, #0x1
str	w25, [x9, #0x8f8]
bl	write_deflate_icf_constprop
add	x10, x10, #0x4
.while_first_check:
add	x0, x8, #0x3
mov	x5, x10
cmp	x11, x0
b.hi	.while_first
.while_first_end:
cmp	x8, x11
b.hs	.while_2nd_end
cmp	x10, x12
b.lo	.while_2nd_handle
b	.save_and_update_state_2nd
.while_2nd:
cmp	x12, x5
b.ls	.save_and_update_state_2nd
.while_2nd_handle:
ldrb	w2, [x8], #0x1
mov	x0, x5
add	x5, x5, #0x4
mov	w1, w2
add	x2, x13, w2, uxtb #2
ldr	w25, [x2, #0x8f8]
add	w25, w25, #0x1
str	w25, [x2, #0x8f8]
bl	write_deflate_icf_constprop
cmp	x11, x8
b.ne	.while_2nd
mov	x8, x11
b	.end_of_stream_check_and_exit
.while_first_match_length:
and	w0, w0, #0xffff
mov	w3, #0x0
add	w1, w0, #0xfe
cmp	w7, #0x2
b.hi	.compute_dist_icf_code
.while_first_match_length_end:
ubfiz	x27, x1, #2, #17
add	x26, x13, w24, uxtw #2
add	x27, x13, x27
add	x8, x8, w2, uxth
mov	w2, w24
ldr	w25, [x27, #0x8f8]
add	w25, w25, #0x1
str	w25, [x27, #0x8f8]
mov	x0, x10
ldr	w25, [x26, #0x880]
add	w25, w25, #0x1
str	w25, [x26, #0x880]
bl	write_deflate_icf
add	x10, x10, #0x4
b	.while_first_check
.compute_dist_icf_code:
clz	w3, w24
mov	w0, #0x1e
sub	w0, w0, w3
mov	w3, #0x1
lsl	w3, w3, w0
sub	w3, w3, #0x1
and	w3, w3, w24
lsl	w4, w0, #1
lsr	w24, w24, w0
add	w24, w24, w4
b	.while_first_match_length_end
.while_2nd_end:
b.eq	.end_of_stream_check_and_exit
mov	x6, x12
b	.update_state
.end_of_stream_check_and_exit:
ldr	w25, [x15, #0x38]
cbz	w25, .update_state_2nd
b	.save_and_update_state_2nd
.save_and_update_state_2nd:
mov	w25, #0x2
str	w25, [x23, #0x14]
.update_state_2nd:
mov	x6, x12
b	.update_state
.save_and_update_state:
mov	x6, x12
mov	x5, x10
mov	w25, #0x2
str	w25, [x23, #0x14]
.update_state:
mov	x4, x22
mov	x1, x21
mov	x3, x11
mov	x2, x8
mov	x0, x15
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldp	x23, x24, [sp, #0x30]
ldp	x25, x26, [sp, #0x40]
ldp	x27, x28, [sp, #0x50]
ldp	x29, x30, [sp], #0x60
b	update_state
.stream_not_available:
ldr	w1, [x0, #0x38]
cbz	w1, .done
mov	w1, #0x2
str	w1, [x0, #0x54]
.done:
ret
