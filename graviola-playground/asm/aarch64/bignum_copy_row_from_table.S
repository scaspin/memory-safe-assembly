bignum_copy_row_from_table:
    cbz             x2, Lbignum_copy_row_from_table_end
    cbz             x3, Lbignum_copy_row_from_table_end
    mov             x5, x3
    mov             x6, x0
Lbignum_copy_row_from_table_initzero:
    str             xzr, [x6]
    add             x6, x6, #8
    subs            x5, x5, #1
    bne             Lbignum_copy_row_from_table_initzero
    mov             x5, xzr
    mov             x8, x1
Lbignum_copy_row_from_table_outerloop:
    cmp             x5, x4
    csetm           x6, eq
    mov             x7, x3
    mov             x9, x0
Lbignum_copy_row_from_table_innerloop:
    ldr             x10, [x8]
    ldr             x11, [x9]
    and             x10, x10, x6
    orr             x11, x11, x10
    str             x11, [x9]
    add             x8, x8, #8
    add             x9, x9, #8
    subs            x7, x7, #1
    bne             Lbignum_copy_row_from_table_innerloop
Lbignum_copy_row_from_table_innerloop_done:
    add             x5, x5, #1
    cmp             x5, x2
    bne             Lbignum_copy_row_from_table_outerloop
Lbignum_copy_row_from_table_end:
ret
