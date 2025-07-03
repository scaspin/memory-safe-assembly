padding_mask_buf:
        .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
padding_mask:
        .byte 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
        .byte 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
        .byte 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
        .byte 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff


.extern ipred_z1_upsample_edge_8bpc_neon 
_ipred_z1_upsample_edge_8bpc_neon:
        adr x4, padding_mask@PAGE
        ld1 {v0.16b}, [x2]
        add x5, x2, w3, uxtw
        sub x4, x4, w3, uxtw

        ld1r {v1.16b}, [x5]
        ld1 {v3.16b}, [x4]

        movi v31.8h, #9

        bit v0.16b, v1.16b, v3.16b

        ext v4.16b, v0.16b, v1.16b, #1
        ext v5.16b, v0.16b, v1.16b, #2
        ext v6.16b, v0.16b, v1.16b, #3

        uaddl v16.8h, v4.8b, v5.8b
        uaddl2 v17.8h, v4.16b, v5.16b
        uaddl v18.8h, v0.8b, v6.8b
        uaddl2 v19.8h, v0.16b, v6.16b
        mul v16.8h, v16.8h, v31.8h
        mul v17.8h, v17.8h, v31.8h
        sub v16.8h, v16.8h, v18.8h
        sub v17.8h, v17.8h, v19.8h

        sqrshrun v16.8b, v16.8h, #4
        sqrshrun2 v16.16b, v17.8h, #4

        zip1 v0.16b, v4.16b, v16.16b
        zip2 v1.16b, v4.16b, v16.16b

        st1 {v0.16b, v1.16b}, [x0]

        ret


.extern ipred_z2_upsample_edge_8bpc_neon 
ipred_z2_upsample_edge_8bpc_neon:

        adr x4, padding_mask
        ld1 {v0.16b}, [x2]
        add x5, x2, w1, uxtw
        sub x4, x4, w1, uxtw

        ld1r {v2.16b}, [x2]
        ld1r {v1.16b}, [x5]
        ld1 {v3.16b}, [x4]

        movi v31.8h, #9

        bit v0.16b, v1.16b, v3.16b

        ext v4.16b, v2.16b, v0.16b, #15
        ext v5.16b, v0.16b, v1.16b, #1
        ext v6.16b, v0.16b, v1.16b, #2

        uaddl v16.8h, v0.8b, v5.8b
        uaddl v18.8h, v4.8b, v6.8b
        mul v16.8h, v16.8h, v31.8h
        sub v16.8h, v16.8h, v18.8h

        sqrshrun v16.8b, v16.8h, #4

        add x5, x0, #16

        zip1 v2.16b, v0.16b, v16.16b

        st1 {v1.b}[0], [x5]

        st1 {v2.16b}, [x0]

        ret

edge_filter:
        .byte 0, 4, 8, 0
        .byte 0, 5, 6, 0


.extern ipred_z1_filter_edge_8bpc_neon;


ipred_z1_filter_edge_8bpc_neon:
        cmp w4, #3
        b.eq Lfivetap

        adr x5, edge_filter, -3
        add x5, x5, w4, uxtw #2

        ld1 {v31.h}[0], [x5]

        ld1 {v0.16b}, [x2], #16

        dup v30.16b, v31.b[0]
        dup v31.16b, v31.b[1]
1b:



        cmp w3, #17
        ld1 {v1.16b}, [x2], #16
        b.lt 2
        ext v2.16b, v0.16b, v1.16b, #1
        ext v3.16b, v0.16b, v1.16b, #2
        umull v4.8h, v0.8b, v30.8b
        umlal v4.8h, v2.8b, v31.8b
        umlal v4.8h, v3.8b, v30.8b
        umull2 v5.8h, v0.16b, v30.16b
        umlal2 v5.8h, v2.16b, v31.16b
        umlal2 v5.8h, v3.16b, v30.16b
        subs w1, w1, #16
        mov v0.16b, v1.16b
        rshrn v4.8b, v4.8h, #4
        rshrn2 v4.16b, v5.8h, #4
        sub w3, w3, #16
        st1 {v4.16b}, [x0], #16
        b.gt 1b
        ret
2:



        adr x5, padding_mask
        sub w6, w3, #32
        sub x5, x5, w3, uxtw
        add x6, x2, w6, sxtw

        ld1 {v2.16b}, [x5]

        ld1r {v1.16b}, [x6]
        bit v0.16b, v1.16b, v2.16b


        ext v2.16b, v0.16b, v1.16b, #1
        ext v3.16b, v0.16b, v1.16b, #2
        umull v4.8h, v0.8b, v30.8b
        umlal v4.8h, v2.8b, v31.8b
        umlal v4.8h, v3.8b, v30.8b
        umull2 v5.8h, v0.16b, v30.16b
        umlal2 v5.8h, v2.16b, v31.16b
        umlal2 v5.8h, v3.16b, v30.16b
        subs w1, w1, #16
        rshrn v4.8b, v4.8h, #4
        rshrn2 v4.16b, v5.8h, #4
        st1 {v4.16b}, [x0], #16
        b.le 9f
5b:


        subs w1, w1, #16
        st1 {v1.16b}, [x0], #16
        b.gt 5b
9f:
        ret

Lfivetap:
        sub x2, x2, #1
        movi v29.16b, #2
        ld1 {v0.16b}, [x2], #16
        movi v30.16b, #4
        movi v31.16b, #4
        ins v0.b[0], v0.b[1]
1f:
        cmp w3, #18
        ld1 {v1.16b}, [x2], #16
        b.lt 2f
        ext v2.16b, v0.16b, v1.16b, #1
        ext v3.16b, v0.16b, v1.16b, #2
        ext v4.16b, v0.16b, v1.16b, #3
        ext v5.16b, v0.16b, v1.16b, #4
        umull v6.8h, v0.8b, v29.8b
        umlal v6.8h, v2.8b, v30.8b
        umlal v6.8h, v3.8b, v31.8b
        umlal v6.8h, v4.8b, v30.8b
        umlal v6.8h, v5.8b, v29.8b
        umull2 v7.8h, v0.16b, v29.16b
        umlal2 v7.8h, v2.16b, v30.16b
        umlal2 v7.8h, v3.16b, v31.16b
        umlal2 v7.8h, v4.16b, v30.16b
        umlal2 v7.8h, v5.16b, v29.16b
        subs w1, w1, #16
        mov v0.16b, v1.16b
        rshrn v6.8b, v6.8h, #4
        rshrn2 v6.16b, v7.8h, #4
        sub w3, w3, #16
        st1 {v6.16b}, [x0], #16
        b.gt 1b
        ret
2f:
        adr x5, padding_mask
        sub w6, w3, #31
        sub x5, x5, w3, uxtw
        add x6, x2, w6, sxtw

        ld1 {v2.16b, v3.16b}, [x5]

        ld1r {v28.16b}, [x6]
        bit v0.16b, v28.16b, v2.16b
        bit v1.16b, v28.16b, v3.16b
4f:

        ext v2.16b, v0.16b, v1.16b, #1
        ext v3.16b, v0.16b, v1.16b, #2
        ext v4.16b, v0.16b, v1.16b, #3
        ext v5.16b, v0.16b, v1.16b, #4
        umull v6.8h, v0.8b, v29.8b
        umlal v6.8h, v2.8b, v30.8b
        umlal v6.8h, v3.8b, v31.8b
        umlal v6.8h, v4.8b, v30.8b
        umlal v6.8h, v5.8b, v29.8b
        umull2 v7.8h, v0.16b, v29.16b
        umlal2 v7.8h, v2.16b, v30.16b
        umlal2 v7.8h, v3.16b, v31.16b
        umlal2 v7.8h, v4.16b, v30.16b
        umlal2 v7.8h, v5.16b, v29.16b
        subs w1, w1, #16
        mov v0.16b, v1.16b
        mov v1.16b, v28.16b
        rshrn v6.8b, v6.8h, #4
        rshrn2 v6.16b, v7.8h, #4
        sub w3, w3, #16
        st1 {v6.16b}, [x0], #16
        b.le 9f


        cmp w3, #0
        b.ge 4b
5f:
        subs w1, w1, #16
        st1 {v1.16b}, [x0], #16
        b.gt 5b
9f:
        ret
endfunc



ipred_pixel_set_8bpc_neon:
        dup v0.16b, w1
1:
        subs w2, w2, #16
        st1 {v0.16b}, [x0], #16
        b.gt 1
        ret

.extern pal_pred_8bpc_neon 
pal_pred_8bpc_neon:
        ld1             {v0.8b}, [x2]
        clz             w9,  w4
        adr             x6,  Lpal_pred_tbl
        sub             w9,  w9,  #25
        movi            v31.16b, #7
        ldrh            w9,  [x6, w9, uxtw #1]
        sub             x6,  x6,  w9, uxtw
        add             x2,  x0,  x1
        lsl             x1,  x1,  #1
        br              x6
4:
        AARCH64_VALID_JUMP_TARGET
        ld1             {v1.8b}, [x3], #8
        subs            w5,  w5,  #4
        ushr            v3.8b,   v1.8b,   #4
        and             v2.8b,   v1.8b,   v31.8b
        zip1            v1.16b,  v2.16b,  v3.16b
        tbl             v1.16b, {v0.16b}, v1.16b
        st1             {v1.s}[0], [x0], x1
        st1             {v1.s}[1], [x2], x1
        st1             {v1.s}[2], [x0], x1
        st1             {v1.s}[3], [x2], x1
        b.gt            4b
        ret
8:
        AARCH64_VALID_JUMP_TARGET
        ld1             {v1.16b}, [x3], #16
        subs            w5,  w5,  #4
        ushr            v4.16b,  v1.16b,  #4
        and             v3.16b,  v1.16b,  v31.16b
        zip1            v1.16b,  v3.16b,  v4.16b
        zip2            v2.16b,  v3.16b,  v4.16b
        tbl             v1.16b, {v0.16b}, v1.16b
        st1             {v1.d}[0], [x0], x1
        tbl             v2.16b, {v0.16b}, v2.16b
        st1             {v1.d}[1], [x2], x1
        st1             {v2.d}[0], [x0], x1
        st1             {v2.d}[1], [x2], x1
        b.gt            8b
        ret
16:
        AARCH64_VALID_JUMP_TARGET
        ld1             {v1.16b, v2.16b}, [x3], #32
        subs            w5,  w5,  #4
        ushr            v5.16b,  v1.16b,  #4
        and             v4.16b,  v1.16b,  v31.16b
        ushr            v7.16b,  v2.16b,  #4
        and             v6.16b,  v2.16b,  v31.16b
        zip1            v1.16b,  v4.16b,  v5.16b
        zip2            v2.16b,  v4.16b,  v5.16b
        zip1            v3.16b,  v6.16b,  v7.16b
        tbl             v1.16b, {v0.16b}, v1.16b
        zip2            v4.16b,  v6.16b,  v7.16b
        tbl             v2.16b, {v0.16b}, v2.16b
        st1             {v1.16b}, [x0], x1
        tbl             v3.16b, {v0.16b}, v3.16b
        st1             {v2.16b}, [x2], x1
        tbl             v4.16b, {v0.16b}, v4.16b
        st1             {v3.16b}, [x0], x1
        st1             {v4.16b}, [x2], x1
        b.gt            16b
        ret
32:
        AARCH64_VALID_JUMP_TARGET
        ld1             {v16.16b, v17.16b, v18.16b, v19.16b}, [x3], #64
        subs            w5,  w5,  #4
        ushr            v21.16b, v16.16b, #4
        and             v20.16b, v16.16b, v31.16b
        ushr            v23.16b, v17.16b, #4
        and             v22.16b, v17.16b, v31.16b
        ushr            v25.16b, v18.16b, #4
        and             v24.16b, v18.16b, v31.16b
        ushr            v27.16b, v19.16b, #4
        and             v26.16b, v19.16b, v31.16b
        zip1            v16.16b, v20.16b, v21.16b
        zip2            v17.16b, v20.16b, v21.16b
        zip1            v18.16b, v22.16b, v23.16b
        zip2            v19.16b, v22.16b, v23.16b
        zip1            v20.16b, v24.16b, v25.16b
        zip2            v21.16b, v24.16b, v25.16b
        tbl             v16.16b, {v0.16b}, v16.16b
        zip1            v22.16b, v26.16b, v27.16b
        tbl             v17.16b, {v0.16b}, v17.16b
        zip2            v23.16b, v26.16b, v27.16b
        tbl             v18.16b, {v0.16b}, v18.16b
        tbl             v19.16b, {v0.16b}, v19.16b
        tbl             v20.16b, {v0.16b}, v20.16b
        st1             {v16.16b, v17.16b}, [x0], x1
        tbl             v21.16b, {v0.16b}, v21.16b
        st1             {v18.16b, v19.16b}, [x2], x1
        tbl             v22.16b, {v0.16b}, v22.16b
        st1             {v20.16b, v21.16b}, [x0], x1
        tbl             v23.16b, {v0.16b}, v23.16b
        st1             {v22.16b, v23.16b}, [x2], x1
        b.gt            32b
        ret
64:
        AARCH64_VALID_JUMP_TARGET
        ld1             {v16.16b, v17.16b, v18.16b, v19.16b}, [x3], #64
        subs            w5,  w5,  #2
        ushr            v21.16b, v16.16b, #4
        and             v20.16b, v16.16b, v31.16b
        ushr            v23.16b, v17.16b, #4
        and             v22.16b, v17.16b, v31.16b
        ushr            v25.16b, v18.16b, #4
        and             v24.16b, v18.16b, v31.16b
        ushr            v27.16b, v19.16b, #4
        and             v26.16b, v19.16b, v31.16b
        zip1            v16.16b, v20.16b, v21.16b
        zip2            v17.16b, v20.16b, v21.16b
        zip1            v18.16b, v22.16b, v23.16b
        zip2            v19.16b, v22.16b, v23.16b
        zip1            v20.16b, v24.16b, v25.16b
        zip2            v21.16b, v24.16b, v25.16b
        tbl             v16.16b, {v0.16b}, v16.16b
        zip1            v22.16b, v26.16b, v27.16b
        tbl             v17.16b, {v0.16b}, v17.16b
        zip2            v23.16b, v26.16b, v27.16b
        tbl             v18.16b, {v0.16b}, v18.16b
        tbl             v19.16b, {v0.16b}, v19.16b
        st1             {v16.16b, v17.16b, v18.16b, v19.16b}, [x0], x1
        tbl             v20.16b, {v0.16b}, v20.16b
        tbl             v21.16b, {v0.16b}, v21.16b
        tbl             v22.16b, {v0.16b}, v22.16b
        tbl             v23.16b, {v0.16b}, v23.16b
        st1             {v20.16b, v21.16b, v22.16b, v23.16b}, [x2], x1
        b.gt            64b
        ret

Lpal_pred_tbl:
        .hword Lpal_pred_tbl - 64b
        .hword Lpal_pred_tbl - 32b
        .hword Lpal_pred_tbl - 16b
        .hword Lpal_pred_tbl -  8b
        .hword Lpal_pred_tbl -  4b