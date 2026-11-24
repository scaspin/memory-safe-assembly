	.text
decode_huffman_code_block_stateless_aarch64:
stp	x29, x30, [sp, #-0x90]!
mov	x29, sp
stp	x19, x20, [sp, #0x10]
stp	x21, x22, [sp, #0x20]
stp	x23, x24, [sp, #0x30]
stp	x25, x26, [sp, #0x40]
stp	x27, x28, [sp, #0x50]
mov	x11, x0
mov	w8, #0x52a8
mov	x29, x1
add	x9, x11, w8, uxtw
ldr	w8, [x9]
ldr	w22, [x9, #0x8]
ldr	x12, [x11]
ldp	w13, w14, [x11, #0x8]
ldp	x23, x3, [x11, #0x10]
ldp	w20, w4, [x11, #0x20]
ldp	w26, w25, [x9, #0x1c]
adrp	x15, rfc_lookup_table
add	x15, x15, :lo12:rfc_lookup_table
ld1	{ v1.16b, v2.16b, v3.16b }, [x15]
add	x15, x15, #0x30
ld1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x15]
mov	x28, xzr
stur	xzr, [x9, #0x24]
block_state_loop:
cmp	w8, #0x3
b.ne	exit_func_success
cmp	w4, #0x3f
b.gt	L_1a4
cmp	w20, #0x7
b.hi	L_17c
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_1a4
cbz	w20, L_1a4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
b	L_1a4
L_17c:
add	w7, w4, #0x7
mov	w16, #0x8
lsr	w7, w7, #3
sub	w7, w16, w7
ldr	x16, [x23]
lsl	x16, x16, x4
orr	x3, x3, x16
add	x23, x23, w7, uxtb
add	w4, w4, w7, lsl #3
sub	w20, w20, w7
L_1a4:
str	x12, [x11]
stp	w13, w14, [x11, #0x8]
stp	x23, x3, [x11, #0x10]
stp	w20, w4, [x11, #0x20]
stp	w26, w25, [x9, #0x1c]
cmp	w4, #0xf
b.le	inflate_in_load_decode
decode_next_lit_len_start:
and	x6, x3, #0xfff
add	w6, w6, #0xa
ldr	w17, [x11, x6, lsl #2]
tbnz	w17, #0x19, long_code_lookup_routine
lsr	w19, w17, #28
sub	w4, w4, w19
lsr	x3, x3, x19
mov	x16, #0x1fff
cmp	w19, #0x0
csel	w17, w17, w16, ne
ubfx	w5, w17, #26, #2
and	w6, w17, #0x1ffffff
b	decode_next_lit_len_end
long_code_lookup_routine:
lsr	w21, w17, #26
mov	w5, #0x1
and	w17, w17, #0x1ffffff
mov	x16, #0x3ff
lsl	w21, w5, w21
sub	w21, w21, #0x1
and	x6, x3, x21
add	w6, w17, w6, lsr #12
mov	w17, #0x2014
add	w6, w6, w17
ldrh	w17, [x11, x6, lsl #1]
lsr	w19, w17, #10
sub	w4, w4, w19
and	w6, w17, w16
lsr	x3, x3, x19
cmp	w19, #0x0
csel	w6, w6, w16, ne
decode_next_lit_len_end:
cbz	w5, invalid_symbol
tbnz	w4, #0x1f, end_input
sym_count_loop:
and	w24, w6, #0xffff
cmp	w24, #0xff
ccmp	w5, #0x1, #0x0, hi
b.eq	next_lit_256
cbnz	w13, sym_count_adjust
mov	w25, w5
lsl	w5, w5, #3
mov	w26, w6
sub	w5, w5, #0x8
lsr	w6, w6, w5
mov	w5, #0x1
cmp	w6, #0xff
b.ls	isal_out_overflow
cmp	w6, #0x100
sub	w25, w25, #0x1
b.eq	isal_out_overflow_1
b	sym_count_loop
sym_count_adjust:
subs	w5, w5, #0x1
lsr	w6, w6, #8
strb	w24, [x12], #0x1
sub	w13, w13, #0x1
add	w14, w14, #0x1
b.ne	sym_count_loop
b	block_state_loop
next_lit_256:
cmp	w24, #0x100
b.eq	next_lit_eq_256
cmp	w24, #0x200
b.hi	invalid_symbol
sub	w27, w24, #0xfe
cmp	w4, #0xf
b.le	inflate_in_load_decode_next_dist
decode_next_dist_start:
and	x6, x3, #0x3ff
mov	w17, #0x2504
add	w6, w6, w17
ldrh	w17, [x11, x6, lsl #1]
tbz	w17, #0xa, decode_next_dist_flag
sub	w21, w17, #0x400
mov	x16, #0x1
asr	w21, w21, #11
and	w17, w17, #0x1ff
lsl	w21, w16, w21
sub	w21, w21, #0x1
and	x6, x3, x21
add	w6, w17, w6, lsr #10
mov	w17, #0x2904
add	w6, w6, w17
ldrh	w17, [x11, x6, lsl #1]
lsr	w19, w17, #10
b	decode_next_dist_adjust
decode_next_dist_flag:
lsr	w19, w17, #11
decode_next_dist_adjust:
sub	w4, w4, w19
lsr	x3, x3, x19
cbnz	w19, decode_next_dist_end
sub	w4, w4, w17
mov	w17, #0x1fff
decode_next_dist_end:
and	w17, w17, #0x1f
tbnz	w4, #0x1f, end_input
cmp	w17, #0x1d
b.hi	invalid_symbol
mov	v0.b[0], w17
tbl	v0.8b, { v2.16b, v3.16b }, v0.8b
umov	w19, v0.b[0]
cmp	w4, #0x3f
b.gt	L_470
cmp	w20, #0x7
b.hi	L_448
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_470
cbz	w20, L_470
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
b	L_470
L_448:
add	w7, w4, #0x7
mov	w16, #0x8
lsr	w7, w7, #3
sub	w7, w16, w7
ldr	x16, [x23]
lsl	x16, x16, x4
orr	x3, x3, x16
add	x23, x23, w7, uxtb
add	w4, w4, w7, lsl #3
sub	w20, w20, w7
L_470:
mov	x16, #0x1
lsl	x16, x16, x19
sub	w4, w4, w19
sub	x16, x16, #0x1
and	x10, x16, x3
lsr	x3, x3, x19
dup	v0.8b, w17
add	v0.8b, v1.8b, v0.8b
tbl	v0.8b, { v4.16b, v5.16b, v6.16b, v7.16b }, v0.8b
umov	w17, v0.h[0]
add	w10, w10, w17
tbnz	w4, #0x1f, end_input
sub	x16, x12, x10
cmp	x16, x29
b.lo	isal_invalid_lookback
cmp	w13, w27
b.hs	decompress_data_start
sub	w28, w27, w13
stp	w28, w10, [x9, #0x24]
mov	w27, w13
decompress_data_start:
add	w14, w14, w27
sub	w13, w13, w27
sub	x1, x12, x10
cmp	w10, w27
b.ls	byte_copy_start
cbz	w27, decompress_data_end
cmp	w27, #0x3
b.ls	load_byte_less_than_4
load_byte_4:
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x3
str	w0, [x12], #0x4
b.ls	load_byte_less_than_4
sub	w27, w27, #0x4
ldr	w0, [x1], #0x4
cmp	w27, #0x4
str	w0, [x12], #0x4
b.ge	load_byte_4
load_byte_less_than_4:
tbz	w27, #0x0, load_byte_2
ldrb	w0, [x1], #0x1
sub	w27, w27, #0x1
strb	w0, [x12], #0x1
load_byte_2:
tbz	w27, #0x1, decompress_data_end
ldrh	w0, [x1], #0x2
strh	w0, [x12], #0x2
decompress_data_end:
cmp	w28, #0x0
b.gt	isal_out_overflow
b	block_state_loop
next_lit_eq_256:
mov	w8, #0x4
cmp	w22, #0x0
csel	w8, w8, w22, ne
str	w8, [x9]
b	block_state_loop
exit_func_success:
mov	w0, #0x0
exit_func:
str	x12, [x11]
stp	w13, w14, [x11, #0x8]
stp	x23, x3, [x11, #0x10]
stp	w20, w4, [x11, #0x20]
stp	w26, w25, [x9, #0x1c]
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldp	x23, x24, [sp, #0x30]
ldp	x25, x26, [sp, #0x40]
ldp	x27, x28, [sp, #0x50]
ldp	x29, x30, [sp], #0x90
ret
end_input:
end_input_1:
mov	w0, #0x1
ldp	x19, x20, [sp, #0x10]
ldp	x21, x22, [sp, #0x20]
ldp	x23, x24, [sp, #0x30]
ldp	x25, x26, [sp, #0x40]
ldp	x27, x28, [sp, #0x50]
ldp	x29, x30, [sp], #0x90
ret
invalid_symbol:
str	x12, [x11]
stp	w13, w14, [x11, #0x8]
stp	x23, x3, [x11, #0x10]
stp	w20, w4, [x11, #0x20]
stp	w26, w25, [x9, #0x1c]
mov	w0, #-0x2
b	exit_func
isal_out_overflow_1:
cmp	w22, #0x0
mov	w8, #0x4
csel	w8, w8, wzr, ne
str	w8, [x9]
isal_out_overflow:
mov	w0, #0x2
b	exit_func
isal_invalid_lookback:
mov	w0, #-0x3
b	exit_func
inflate_in_load_decode:
cmp	w4, #0x3f
b.gt	L_be4
cmp	w20, #0x7
b.hi	L_bbc
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_be4
cbz	w20, L_be4
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
b	L_be4
L_bbc:
add	w7, w4, #0x7
mov	w16, #0x8
lsr	w7, w7, #3
sub	w7, w16, w7
ldr	x16, [x23]
lsl	x16, x16, x4
orr	x3, x3, x16
add	x23, x23, w7, uxtb
add	w4, w4, w7, lsl #3
sub	w20, w20, w7
L_be4:
b	decode_next_lit_len_start
inflate_in_load_decode_next_dist:
cmp	w4, #0x3f
b.gt	L_d20
cmp	w20, #0x7
b.hi	L_cf8
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
cmp	w4, #0x38
b.gt	L_d20
cbz	w20, L_d20
ldrb	w16, [x23], #0x1
sub	w20, w20, #0x1
lsl	x16, x16, x4
orr	x3, x3, x16
add	w4, w4, #0x8
ubfx	x4, x4, #0, #32
b	L_d20
L_cf8:
add	w7, w4, #0x7
mov	w16, #0x8
lsr	w7, w7, #3
sub	w7, w16, w7
ldr	x16, [x23]
lsl	x16, x16, x4
orr	x3, x3, x16
add	x23, x23, w7, uxtb
add	w4, w4, w7, lsl #3
sub	w20, w20, w7
L_d20:
b	decode_next_dist_start
byte_copy_start:
add	x2, x12, x27
cmp	x2, x12
b.eq	decompress_data_end
sub	x2, x2, #0x1
byte_copy_loop:
ldrb	w0, [x1], #0x1
cmp	x2, x12
strb	w0, [x12], #0x1
b.ne	byte_copy_loop
b	decompress_data_end
	.section .text_data
rfc_lookup_table:
	.word 0x00002000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x02020101
	.word 0x04040303
	.word 0x06060505
	.word 0x08080707
	.word 0x0a0a0909
	.word 0x0c0c0b0b
	.word 0x00000d0d
	.word 0x04030201
	.word 0x0d090705
	.word 0x31211911
	.word 0xc1816141
	.word 0x01018101
	.word 0x01010101
	.word 0x01010101
	.word 0x00000101
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x03020101
	.word 0x0c080604
	.word 0x30201810
	.word 0x00006040
