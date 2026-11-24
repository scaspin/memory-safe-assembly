bignum_copy_row_from_table_32:
dup             v20.2d, xzr
mov             v21.16b, v20.16b
mov             v22.16b, v20.16b
mov             v23.16b, v20.16b
mov             v24.16b, v20.16b
mov             v25.16b, v20.16b
mov             v26.16b, v20.16b
mov             v27.16b, v20.16b
mov             v28.16b, v20.16b
mov             v29.16b, v20.16b
mov             v30.16b, v20.16b
mov             v31.16b, v20.16b
mov             v0.16b, v20.16b
mov             v1.16b, v20.16b
mov             v2.16b, v20.16b
mov             v3.16b, v20.16b
mov             x6, #0
Lbignum_copy_row_from_table_32_loop:
subs            xzr, x6, x3
cinv            x5, xzr, eq
dup             v17.2d, x5
ldr             q16, [x1, #(16*0)]
bit             v20.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*1)]
bit             v21.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*2)]
bit             v22.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*3)]
bit             v23.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*4)]
bit             v24.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*5)]
bit             v25.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*6)]
bit             v26.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*7)]
bit             v27.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*8)]
bit             v28.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*9)]
bit             v29.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*10)]
bit             v30.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*11)]
bit             v31.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*12)]
bit             v0.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*13)]
bit             v1.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*14)]
bit             v2.16b, v16.16b, v17.16b
ldr             q16, [x1, #(16*15)]
bit             v3.16b, v16.16b, v17.16b
add             x1, x1, #(32*8)
add             x6, x6, #1
subs            xzr, x2, x6
b.ne            Lbignum_copy_row_from_table_32_loop
Lbignum_copy_row_from_table_32_end:
str             q20, [x0, #(16*0)]
str             q21, [x0, #(16*1)]
str             q22, [x0, #(16*2)]
str             q23, [x0, #(16*3)]
str             q24, [x0, #(16*4)]
str             q25, [x0, #(16*5)]
str             q26, [x0, #(16*6)]
str             q27, [x0, #(16*7)]
str             q28, [x0, #(16*8)]
str             q29, [x0, #(16*9)]
str             q30, [x0, #(16*10)]
str             q31, [x0, #(16*11)]
str             q0, [x0, #(16*12)]
str             q1, [x0, #(16*13)]
str             q2, [x0, #(16*14)]
str             q3, [x0, #(16*15)]
ret
