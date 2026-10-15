bignum_copy_row_from_table_8n:
cbz             x2, Lbignum_copy_row_from_table_8n_end
cbz             x3, Lbignum_copy_row_from_table_8n_end
mov             x5, x3
mov             x6, x0
dup             v16.2d, xzr
Lbignum_copy_row_from_table_8n_initzero:
str             q16, [x6]
str             q16, [x6, #16]
str             q16, [x6, #32]
str             q16, [x6, #48]
add             x6, x6, #64
subs            x5, x5, #8
bne             Lbignum_copy_row_from_table_8n_initzero
mov             x5, xzr
mov             x8, x1
Lbignum_copy_row_from_table_8n_outerloop:
cmp             x5, x4
csetm           x6, eq
dup             v16.2d, x6
mov             x7, x3
mov             x9, x0
Lbignum_copy_row_from_table_8n_innerloop:
ldr             q17, [x8]
ldr             q18, [x9]
bit             v18.16b, v17.16b, v16.16b
str             q18, [x9]
ldr             q17, [x8, #16]
ldr             q18, [x9, #16]
bit             v18.16b, v17.16b, v16.16b
str             q18, [x9, #16]
ldr             q17, [x8, #32]
ldr             q18, [x9, #32]
bit             v18.16b, v17.16b, v16.16b
str             q18, [x9, #32]
ldr             q17, [x8, #48]
ldr             q18, [x9, #48]
bit             v18.16b, v17.16b, v16.16b
str             q18, [x9, #48]
add             x8, x8, #64
add             x9, x9, #64
subs            x7, x7, #8
bne             Lbignum_copy_row_from_table_8n_innerloop
Lbignum_copy_row_from_table_8n_innerloop_done:
add             x5, x5, #1
cmp             x5, x2
bne             Lbignum_copy_row_from_table_8n_outerloop
Lbignum_copy_row_from_table_8n_end:
ret
