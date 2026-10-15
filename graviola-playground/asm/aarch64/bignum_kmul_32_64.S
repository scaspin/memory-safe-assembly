bignum_kmul_32_64:
    stp             x19, x20, [sp, #-16]!
    stp             x21, x22, [sp, #-16]!
    stp             x23, x24, [sp, #-16]!
    stp             x25, x26, [sp, #-16]!
    stp             x27, x28, [sp, #-16]!
    stp             x29, x30, [sp, #-16]!
    mov             x19, x0
    mov             x20, x1
    mov             x21, x2
    mov             x22, x3
    bl              Lbignum_kmul_32_64_local_kmul_16_32
    add             x0, x19, #0x100
    add             x1, x20, #0x80
    add             x2, x21, #0x80
    mov             x3, x22
    bl              Lbignum_kmul_32_64_local_kmul_16_32
    ldp             x0, x1, [x20, #128]
    ldp             x16, x17, [x20]
    subs            x0, x0, x16
    sbcs            x1, x1, x17
    ldp             x2, x3, [x20, #144]
    ldp             x16, x17, [x20, #16]
    sbcs            x2, x2, x16
    sbcs            x3, x3, x17
    ldp             x4, x5, [x20, #160]
    ldp             x16, x17, [x20, #32]
    sbcs            x4, x4, x16
    sbcs            x5, x5, x17
    ldp             x6, x7, [x20, #176]
    ldp             x16, x17, [x20, #48]
    sbcs            x6, x6, x16
    sbcs            x7, x7, x17
    ldp             x8, x9, [x20, #192]
    ldp             x16, x17, [x20, #64]
    sbcs            x8, x8, x16
    sbcs            x9, x9, x17
    ldp             x10, x11, [x20, #208]
    ldp             x16, x17, [x20, #80]
    sbcs            x10, x10, x16
    sbcs            x11, x11, x17
    ldp             x12, x13, [x20, #224]
    ldp             x16, x17, [x20, #96]
    sbcs            x12, x12, x16
    sbcs            x13, x13, x17
    ldp             x14, x15, [x20, #240]
    ldp             x16, x17, [x20, #112]
    sbcs            x14, x14, x16
    sbcs            x15, x15, x17
    ngc             x20, xzr
    cmn             x20, x20
    eor             x0, x0, x20
    adcs            x0, x0, xzr
    eor             x1, x1, x20
    adcs            x1, x1, xzr
    stp             x0, x1, [x22]
    eor             x2, x2, x20
    adcs            x2, x2, xzr
    eor             x3, x3, x20
    adcs            x3, x3, xzr
    stp             x2, x3, [x22, #16]
    eor             x4, x4, x20
    adcs            x4, x4, xzr
    eor             x5, x5, x20
    adcs            x5, x5, xzr
    stp             x4, x5, [x22, #32]
    eor             x6, x6, x20
    adcs            x6, x6, xzr
    eor             x7, x7, x20
    adcs            x7, x7, xzr
    stp             x6, x7, [x22, #48]
    eor             x8, x8, x20
    adcs            x8, x8, xzr
    eor             x9, x9, x20
    adcs            x9, x9, xzr
    stp             x8, x9, [x22, #64]
    eor             x10, x10, x20
    adcs            x10, x10, xzr
    eor             x11, x11, x20
    adcs            x11, x11, xzr
    stp             x10, x11, [x22, #80]
    eor             x12, x12, x20
    adcs            x12, x12, xzr
    eor             x13, x13, x20
    adcs            x13, x13, xzr
    stp             x12, x13, [x22, #96]
    eor             x14, x14, x20
    adcs            x14, x14, xzr
    eor             x15, x15, x20
    adc             x15, x15, xzr
    stp             x14, x15, [x22, #112]
    ldp             x0, x1, [x21]
    ldp             x16, x17, [x21, #128]
    subs            x0, x0, x16
    sbcs            x1, x1, x17
    ldp             x2, x3, [x21, #16]
    ldp             x16, x17, [x21, #144]
    sbcs            x2, x2, x16
    sbcs            x3, x3, x17
    ldp             x4, x5, [x21, #32]
    ldp             x16, x17, [x21, #160]
    sbcs            x4, x4, x16
    sbcs            x5, x5, x17
    ldp             x6, x7, [x21, #48]
    ldp             x16, x17, [x21, #176]
    sbcs            x6, x6, x16
    sbcs            x7, x7, x17
    ldp             x8, x9, [x21, #64]
    ldp             x16, x17, [x21, #192]
    sbcs            x8, x8, x16
    sbcs            x9, x9, x17
    ldp             x10, x11, [x21, #80]
    ldp             x16, x17, [x21, #208]
    sbcs            x10, x10, x16
    sbcs            x11, x11, x17
    ldp             x12, x13, [x21, #96]
    ldp             x16, x17, [x21, #224]
    sbcs            x12, x12, x16
    sbcs            x13, x13, x17
    ldp             x14, x15, [x21, #112]
    ldp             x16, x17, [x21, #240]
    sbcs            x14, x14, x16
    sbcs            x15, x15, x17
    ngc             x21, xzr
    cmn             x21, x21
    eor             x0, x0, x21
    adcs            x0, x0, xzr
    eor             x1, x1, x21
    adcs            x1, x1, xzr
    stp             x0, x1, [x22, #128]
    eor             x2, x2, x21
    adcs            x2, x2, xzr
    eor             x3, x3, x21
    adcs            x3, x3, xzr
    stp             x2, x3, [x22, #144]
    eor             x4, x4, x21
    adcs            x4, x4, xzr
    eor             x5, x5, x21
    adcs            x5, x5, xzr
    stp             x4, x5, [x22, #160]
    eor             x6, x6, x21
    adcs            x6, x6, xzr
    eor             x7, x7, x21
    adcs            x7, x7, xzr
    stp             x6, x7, [x22, #176]
    eor             x8, x8, x21
    adcs            x8, x8, xzr
    eor             x9, x9, x21
    adcs            x9, x9, xzr
    stp             x8, x9, [x22, #192]
    eor             x10, x10, x21
    adcs            x10, x10, xzr
    eor             x11, x11, x21
    adcs            x11, x11, xzr
    stp             x10, x11, [x22, #208]
    eor             x12, x12, x21
    adcs            x12, x12, xzr
    eor             x13, x13, x21
    adcs            x13, x13, xzr
    stp             x12, x13, [x22, #224]
    eor             x14, x14, x21
    adcs            x14, x14, xzr
    eor             x15, x15, x21
    adc             x15, x15, xzr
    stp             x14, x15, [x22, #240]
    eor             x21, x21, x20
    ldp             x0, x1, [x19, #256]
    ldp             x2, x3, [x19, #128]
    adds            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #256]
    ldp             x0, x1, [x19, #272]
    ldp             x2, x3, [x19, #144]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #272]
    ldp             x0, x1, [x19, #288]
    ldp             x2, x3, [x19, #160]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #288]
    ldp             x0, x1, [x19, #304]
    ldp             x2, x3, [x19, #176]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #304]
    ldp             x0, x1, [x19, #320]
    ldp             x2, x3, [x19, #192]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #320]
    ldp             x0, x1, [x19, #336]
    ldp             x2, x3, [x19, #208]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #336]
    ldp             x0, x1, [x19, #352]
    ldp             x2, x3, [x19, #224]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #352]
    ldp             x0, x1, [x19, #368]
    ldp             x2, x3, [x19, #240]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #368]
    ldp             x0, x1, [x19, #384]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #384]
    ldp             x0, x1, [x19, #400]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #400]
    ldp             x0, x1, [x19, #416]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #416]
    ldp             x0, x1, [x19, #432]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #432]
    ldp             x0, x1, [x19, #448]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #448]
    ldp             x0, x1, [x19, #464]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #464]
    ldp             x0, x1, [x19, #480]
    adcs            x0, x0, xzr
    adcs            x1, x1, xzr
    stp             x0, x1, [x19, #480]
    ldp             x0, x1, [x19, #496]
    adcs            x0, x0, xzr
    adc             x1, x1, xzr
    stp             x0, x1, [x19, #496]
    add             x0, x22, #0x100
    mov             x1, x22
    add             x2, x22, #0x80
    add             x3, x22, #0x200
    bl              Lbignum_kmul_32_64_local_kmul_16_32
    ldp             x0, x1, [x19, #256]
    ldp             x2, x3, [x19]
    adds            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #128]
    ldp             x0, x1, [x19, #272]
    ldp             x2, x3, [x19, #16]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #144]
    ldp             x0, x1, [x19, #288]
    ldp             x2, x3, [x19, #32]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #160]
    ldp             x0, x1, [x19, #304]
    ldp             x2, x3, [x19, #48]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #176]
    ldp             x0, x1, [x19, #320]
    ldp             x2, x3, [x19, #64]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #192]
    ldp             x0, x1, [x19, #336]
    ldp             x2, x3, [x19, #80]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #208]
    ldp             x0, x1, [x19, #352]
    ldp             x2, x3, [x19, #96]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #224]
    ldp             x0, x1, [x19, #368]
    ldp             x2, x3, [x19, #112]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #240]
    ldp             x0, x1, [x19, #256]
    ldp             x2, x3, [x19, #384]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #256]
    ldp             x0, x1, [x19, #272]
    ldp             x2, x3, [x19, #400]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #272]
    ldp             x0, x1, [x19, #288]
    ldp             x2, x3, [x19, #416]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #288]
    ldp             x0, x1, [x19, #304]
    ldp             x2, x3, [x19, #432]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #304]
    ldp             x0, x1, [x19, #320]
    ldp             x2, x3, [x19, #448]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #320]
    ldp             x0, x1, [x19, #336]
    ldp             x2, x3, [x19, #464]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #336]
    ldp             x0, x1, [x19, #352]
    ldp             x2, x3, [x19, #480]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #352]
    ldp             x0, x1, [x19, #368]
    ldp             x2, x3, [x19, #496]
    adcs            x0, x0, x2
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #368]
    cset            x20, cs
    cmn             x21, x21
    ldp             x0, x1, [x19, #128]
    ldp             x2, x3, [x22, #256]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #128]
    ldp             x0, x1, [x19, #144]
    ldp             x2, x3, [x22, #272]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #144]
    ldp             x0, x1, [x19, #160]
    ldp             x2, x3, [x22, #288]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #160]
    ldp             x0, x1, [x19, #176]
    ldp             x2, x3, [x22, #304]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #176]
    ldp             x0, x1, [x19, #192]
    ldp             x2, x3, [x22, #320]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #192]
    ldp             x0, x1, [x19, #208]
    ldp             x2, x3, [x22, #336]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #208]
    ldp             x0, x1, [x19, #224]
    ldp             x2, x3, [x22, #352]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #224]
    ldp             x0, x1, [x19, #240]
    ldp             x2, x3, [x22, #368]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #240]
    ldp             x0, x1, [x19, #256]
    ldp             x2, x3, [x22, #384]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #256]
    ldp             x0, x1, [x19, #272]
    ldp             x2, x3, [x22, #400]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #272]
    ldp             x0, x1, [x19, #288]
    ldp             x2, x3, [x22, #416]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #288]
    ldp             x0, x1, [x19, #304]
    ldp             x2, x3, [x22, #432]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #304]
    ldp             x0, x1, [x19, #320]
    ldp             x2, x3, [x22, #448]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #320]
    ldp             x0, x1, [x19, #336]
    ldp             x2, x3, [x22, #464]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #336]
    ldp             x0, x1, [x19, #352]
    ldp             x2, x3, [x22, #480]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #352]
    ldp             x0, x1, [x19, #368]
    ldp             x2, x3, [x22, #496]
    eor             x2, x2, x21
    adcs            x0, x0, x2
    eor             x3, x3, x21
    adcs            x1, x1, x3
    stp             x0, x1, [x19, #368]
    adcs            x20, x21, x20
    adc             x16, x21, xzr
    ldp             x0, x1, [x19, #384]
    adds            x0, x0, x20
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #384]
    ldp             x0, x1, [x19, #400]
    adcs            x0, x0, x16
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #400]
    ldp             x0, x1, [x19, #416]
    adcs            x0, x0, x16
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #416]
    ldp             x0, x1, [x19, #432]
    adcs            x0, x0, x16
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #432]
    ldp             x0, x1, [x19, #448]
    adcs            x0, x0, x16
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #448]
    ldp             x0, x1, [x19, #464]
    adcs            x0, x0, x16
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #464]
    ldp             x0, x1, [x19, #480]
    adcs            x0, x0, x16
    adcs            x1, x1, x16
    stp             x0, x1, [x19, #480]
    ldp             x0, x1, [x19, #496]
    adcs            x0, x0, x16
    adc             x1, x1, x16
    stp             x0, x1, [x19, #496]
    ldp             x29, x30, [sp], #16
    ldp             x27, x28, [sp], #16
    ldp             x25, x26, [sp], #16
    ldp             x23, x24, [sp], #16
    ldp             x21, x22, [sp], #16
    ldp             x19, x20, [sp], #16
    b               hoist_finish
Lbignum_kmul_32_64_local_kmul_16_32:
    stp             x19, x20, [sp, #-16]!
    stp             x21, x22, [sp, #-16]!
    stp             x23, x30, [sp, #-16]!
    mov             x25, x0
    mov             x26, x1
    mov             x27, x2
    mov             x28, x3
    bl              Lbignum_kmul_32_64_local_mul_8_16
    ldp             x10, x11, [x26]
    ldp             x8, x9, [x26, #64]
    subs            x10, x10, x8
    sbcs            x11, x11, x9
    ldp             x12, x13, [x26, #16]
    ldp             x8, x9, [x26, #80]
    sbcs            x12, x12, x8
    sbcs            x13, x13, x9
    ldp             x14, x15, [x26, #32]
    ldp             x8, x9, [x26, #96]
    sbcs            x14, x14, x8
    sbcs            x15, x15, x9
    ldp             x16, x17, [x26, #48]
    ldp             x8, x9, [x26, #112]
    sbcs            x16, x16, x8
    sbcs            x17, x17, x9
    csetm           x29, cc
    cmn             x29, x29
    eor             x10, x10, x29
    adcs            x10, x10, xzr
    eor             x11, x11, x29
    adcs            x11, x11, xzr
    stp             x10, x11, [x28]
    eor             x12, x12, x29
    adcs            x12, x12, xzr
    eor             x13, x13, x29
    adcs            x13, x13, xzr
    stp             x12, x13, [x28, #16]
    eor             x14, x14, x29
    adcs            x14, x14, xzr
    eor             x15, x15, x29
    adcs            x15, x15, xzr
    stp             x14, x15, [x28, #32]
    eor             x16, x16, x29
    adcs            x16, x16, xzr
    eor             x17, x17, x29
    adcs            x17, x17, xzr
    stp             x16, x17, [x28, #48]
    add             x0, x25, #0x80
    add             x1, x26, #0x40
    add             x2, x27, #0x40
    bl              Lbignum_kmul_32_64_local_mul_8_16
    ldp             x10, x11, [x27]
    ldp             x8, x9, [x27, #64]
    subs            x10, x8, x10
    sbcs            x11, x9, x11
    ldp             x12, x13, [x27, #16]
    ldp             x8, x9, [x27, #80]
    sbcs            x12, x8, x12
    sbcs            x13, x9, x13
    ldp             x14, x15, [x27, #32]
    ldp             x8, x9, [x27, #96]
    sbcs            x14, x8, x14
    sbcs            x15, x9, x15
    ldp             x16, x17, [x27, #48]
    ldp             x8, x9, [x27, #112]
    sbcs            x16, x8, x16
    sbcs            x17, x9, x17
    csetm           x19, cc
    cmn             x19, x19
    eor             x10, x10, x19
    adcs            x10, x10, xzr
    eor             x11, x11, x19
    adcs            x11, x11, xzr
    stp             x10, x11, [x28, #64]
    eor             x12, x12, x19
    adcs            x12, x12, xzr
    eor             x13, x13, x19
    adcs            x13, x13, xzr
    stp             x12, x13, [x28, #80]
    eor             x14, x14, x19
    adcs            x14, x14, xzr
    eor             x15, x15, x19
    adcs            x15, x15, xzr
    stp             x14, x15, [x28, #96]
    eor             x16, x16, x19
    adcs            x16, x16, xzr
    eor             x17, x17, x19
    adcs            x17, x17, xzr
    stp             x16, x17, [x28, #112]
    eor             x29, x29, x19
    ldp             x10, x11, [x25, #128]
    ldp             x12, x13, [x25, #64]
    adds            x10, x10, x12
    adcs            x11, x11, x13
    stp             x10, x11, [x25, #128]
    ldp             x10, x11, [x25, #144]
    ldp             x12, x13, [x25, #80]
    adcs            x10, x10, x12
    adcs            x11, x11, x13
    stp             x10, x11, [x25, #144]
    ldp             x10, x11, [x25, #160]
    ldp             x12, x13, [x25, #96]
    adcs            x10, x10, x12
    adcs            x11, x11, x13
    stp             x10, x11, [x25, #160]
    ldp             x10, x11, [x25, #176]
    ldp             x12, x13, [x25, #112]
    adcs            x10, x10, x12
    adcs            x11, x11, x13
    stp             x10, x11, [x25, #176]
    ldp             x10, x11, [x25, #192]
    adcs            x10, x10, xzr
    adcs            x11, x11, xzr
    stp             x10, x11, [x25, #192]
    ldp             x10, x11, [x25, #208]
    adcs            x10, x10, xzr
    adcs            x11, x11, xzr
    stp             x10, x11, [x25, #208]
    ldp             x10, x11, [x25, #224]
    adcs            x10, x10, xzr
    adcs            x11, x11, xzr
    stp             x10, x11, [x25, #224]
    ldp             x10, x11, [x25, #240]
    adcs            x10, x10, xzr
    adcs            x11, x11, xzr
    stp             x10, x11, [x25, #240]
    add             x0, x28, #0x80
    mov             x1, x28
    add             x2, x28, #0x40
    bl              Lbignum_kmul_32_64_local_mul_8_16
    ldp             x0, x1, [x25]
    ldp             x16, x17, [x25, #128]
    adds            x0, x0, x16
    adcs            x1, x1, x17
    ldp             x2, x3, [x25, #16]
    ldp             x16, x17, [x25, #144]
    adcs            x2, x2, x16
    adcs            x3, x3, x17
    ldp             x4, x5, [x25, #32]
    ldp             x16, x17, [x25, #160]
    adcs            x4, x4, x16
    adcs            x5, x5, x17
    ldp             x6, x7, [x25, #48]
    ldp             x16, x17, [x25, #176]
    adcs            x6, x6, x16
    adcs            x7, x7, x17
    ldp             x8, x9, [x25, #128]
    ldp             x16, x17, [x25, #192]
    adcs            x8, x8, x16
    adcs            x9, x9, x17
    ldp             x10, x11, [x25, #144]
    ldp             x16, x17, [x25, #208]
    adcs            x10, x10, x16
    adcs            x11, x11, x17
    ldp             x12, x13, [x25, #160]
    ldp             x16, x17, [x25, #224]
    adcs            x12, x12, x16
    adcs            x13, x13, x17
    ldp             x14, x15, [x25, #176]
    ldp             x16, x17, [x25, #240]
    adcs            x14, x14, x16
    adcs            x15, x15, x17
    cset            x26, cs
    cmn             x29, x29
    ldp             x16, x17, [x28, #128]
    eor             x16, x16, x29
    adcs            x0, x0, x16
    eor             x17, x17, x29
    adcs            x1, x1, x17
    stp             x0, x1, [x25, #64]
    ldp             x16, x17, [x28, #144]
    eor             x16, x16, x29
    adcs            x2, x2, x16
    eor             x17, x17, x29
    adcs            x3, x3, x17
    stp             x2, x3, [x25, #80]
    ldp             x16, x17, [x28, #160]
    eor             x16, x16, x29
    adcs            x4, x4, x16
    eor             x17, x17, x29
    adcs            x5, x5, x17
    stp             x4, x5, [x25, #96]
    ldp             x16, x17, [x28, #176]
    eor             x16, x16, x29
    adcs            x6, x6, x16
    eor             x17, x17, x29
    adcs            x7, x7, x17
    stp             x6, x7, [x25, #112]
    ldp             x16, x17, [x28, #192]
    eor             x16, x16, x29
    adcs            x8, x8, x16
    eor             x17, x17, x29
    adcs            x9, x9, x17
    stp             x8, x9, [x25, #128]
    ldp             x16, x17, [x28, #208]
    eor             x16, x16, x29
    adcs            x10, x10, x16
    eor             x17, x17, x29
    adcs            x11, x11, x17
    stp             x10, x11, [x25, #144]
    ldp             x16, x17, [x28, #224]
    eor             x16, x16, x29
    adcs            x12, x12, x16
    eor             x17, x17, x29
    adcs            x13, x13, x17
    stp             x12, x13, [x25, #160]
    ldp             x16, x17, [x28, #240]
    eor             x16, x16, x29
    adcs            x14, x14, x16
    eor             x17, x17, x29
    adcs            x15, x15, x17
    stp             x14, x15, [x25, #176]
    adcs            x27, x29, x26
    adc             x28, x29, xzr
    ldp             x10, x11, [x25, #192]
    adds            x10, x10, x27
    adcs            x11, x11, x28
    stp             x10, x11, [x25, #192]
    ldp             x10, x11, [x25, #208]
    adcs            x10, x10, x28
    adcs            x11, x11, x28
    stp             x10, x11, [x25, #208]
    ldp             x10, x11, [x25, #224]
    adcs            x10, x10, x28
    adcs            x11, x11, x28
    stp             x10, x11, [x25, #224]
    ldp             x10, x11, [x25, #240]
    adcs            x10, x10, x28
    adcs            x11, x11, x28
    stp             x10, x11, [x25, #240]
    ldp             x23, x30, [sp], #16
    ldp             x21, x22, [sp], #16
    ldp             x19, x20, [sp], #16
    ret             
Lbignum_kmul_32_64_local_mul_8_16:
    ldp             x3, x4, [x1]
    ldr             q0, [x1]
    ldp             x7, x8, [x2]
    ldr             q1, [x2]
    ldp             x5, x6, [x1, #16]
    ldr             q2, [x1, #16]
    ldp             x9, x10, [x2, #16]
    ldr             q3, [x2, #16]
    uzp1            v4.4s, v1.4s, v0.4s
    rev64           v1.4s, v1.4s
    uzp1            v5.4s, v0.4s, v0.4s
    mul             v0.4s, v1.4s, v0.4s
    uaddlp          v0.2d, v0.4s
    shl             v0.2d, v0.2d, #32
    umlal           v0.2d, v5.2s, v4.2s
    mov             x11, v0.d[0]
    mov             x15, v0.d[1]
    uzp1            v0.4s, v3.4s, v2.4s
    rev64           v1.4s, v3.4s
    uzp1            v3.4s, v2.4s, v2.4s
    mul             v1.4s, v1.4s, v2.4s
    uaddlp          v1.2d, v1.4s
    shl             v1.2d, v1.2d, #32
    umlal           v1.2d, v3.2s, v0.2s
    mov             x16, v1.d[0]
    mov             x17, v1.d[1]
    ldr             q0, [x1, #32]
    ldr             q1, [x2, #32]
    ldr             q2, [x1, #48]
    ldr             q3, [x2, #48]
    umulh           x19, x3, x7
    adds            x15, x15, x19
    umulh           x19, x4, x8
    adcs            x16, x16, x19
    umulh           x19, x5, x9
    adcs            x17, x17, x19
    umulh           x19, x6, x10
    uzp1            v4.4s, v1.4s, v0.4s
    rev64           v1.4s, v1.4s
    uzp1            v5.4s, v0.4s, v0.4s
    mul             v0.4s, v1.4s, v0.4s
    uaddlp          v0.2d, v0.4s
    shl             v0.2d, v0.2d, #32
    umlal           v0.2d, v5.2s, v4.2s
    adc             x19, x19, xzr
    adds            x12, x15, x11
    adcs            x15, x16, x15
    adcs            x16, x17, x16
    adcs            x17, x19, x17
    adc             x19, xzr, x19
    adds            x13, x15, x11
    adcs            x14, x16, x12
    adcs            x15, x17, x15
    adcs            x16, x19, x16
    adcs            x17, xzr, x17
    adc             x19, xzr, x19
    subs            x24, x5, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x9
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x16, x16, x22
    eor             x21, x21, x20
    adcs            x17, x17, x21
    adc             x19, x19, x20
    subs            x24, x3, x4
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x8, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x12, x12, x22
    eor             x21, x21, x20
    adcs            x13, x13, x21
    adcs            x14, x14, x20
    adcs            x15, x15, x20
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x4, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x8
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x15, x15, x22
    eor             x21, x21, x20
    adcs            x16, x16, x21
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x3, x5
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x9, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x13, x13, x22
    eor             x21, x21, x20
    adcs            x14, x14, x21
    adcs            x15, x15, x20
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x3, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x14, x14, x22
    eor             x21, x21, x20
    adcs            x15, x15, x21
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x4, x5
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x9, x8
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x14, x14, x22
    eor             x21, x21, x20
    adcs            x15, x15, x21
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    ldp             x3, x4, [x1, #32]
    stp             x11, x12, [x0]
    ldp             x7, x8, [x2, #32]
    stp             x13, x14, [x0, #16]
    ldp             x5, x6, [x1, #48]
    stp             x15, x16, [x0, #32]
    ldp             x9, x10, [x2, #48]
    stp             x17, x19, [x0, #48]
    mov             x11, v0.d[0]
    mov             x15, v0.d[1]
    uzp1            v0.4s, v3.4s, v2.4s
    rev64           v1.4s, v3.4s
    uzp1            v3.4s, v2.4s, v2.4s
    mul             v1.4s, v1.4s, v2.4s
    uaddlp          v1.2d, v1.4s
    shl             v1.2d, v1.2d, #32
    umlal           v1.2d, v3.2s, v0.2s
    mov             x16, v1.d[0]
    mov             x17, v1.d[1]
    umulh           x19, x3, x7
    adds            x15, x15, x19
    umulh           x19, x4, x8
    adcs            x16, x16, x19
    umulh           x19, x5, x9
    adcs            x17, x17, x19
    umulh           x19, x6, x10
    adc             x19, x19, xzr
    adds            x12, x15, x11
    adcs            x15, x16, x15
    adcs            x16, x17, x16
    adcs            x17, x19, x17
    adc             x19, xzr, x19
    adds            x13, x15, x11
    adcs            x14, x16, x12
    adcs            x15, x17, x15
    adcs            x16, x19, x16
    adcs            x17, xzr, x17
    adc             x19, xzr, x19
    ldp             x22, x21, [x0, #32]
    adds            x11, x11, x22
    adcs            x12, x12, x21
    ldp             x22, x21, [x0, #48]
    adcs            x13, x13, x22
    adcs            x14, x14, x21
    adcs            x15, x15, xzr
    adcs            x16, x16, xzr
    adcs            x17, x17, xzr
    adc             x19, x19, xzr
    subs            x24, x5, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x9
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x16, x16, x22
    eor             x21, x21, x20
    adcs            x17, x17, x21
    adc             x19, x19, x20
    subs            x24, x3, x4
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x8, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x12, x12, x22
    eor             x21, x21, x20
    adcs            x13, x13, x21
    adcs            x14, x14, x20
    adcs            x15, x15, x20
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x4, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x8
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x15, x15, x22
    eor             x21, x21, x20
    adcs            x16, x16, x21
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x3, x5
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x9, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x13, x13, x22
    eor             x21, x21, x20
    adcs            x14, x14, x21
    adcs            x15, x15, x20
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x3, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x14, x14, x22
    eor             x21, x21, x20
    adcs            x15, x15, x21
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x4, x5
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x9, x8
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x14, x14, x22
    eor             x21, x21, x20
    adcs            x15, x15, x21
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    ldp             x22, x21, [x1]
    subs            x3, x3, x22
    sbcs            x4, x4, x21
    ldp             x22, x21, [x1, #16]
    sbcs            x5, x5, x22
    sbcs            x6, x6, x21
    csetm           x24, cc
    stp             x11, x12, [x0, #64]
    ldp             x22, x21, [x2]
    subs            x7, x22, x7
    sbcs            x8, x21, x8
    ldp             x22, x21, [x2, #16]
    sbcs            x9, x22, x9
    sbcs            x10, x21, x10
    csetm           x1, cc
    stp             x13, x14, [x0, #80]
    eor             x3, x3, x24
    subs            x3, x3, x24
    eor             x4, x4, x24
    sbcs            x4, x4, x24
    eor             x5, x5, x24
    sbcs            x5, x5, x24
    eor             x6, x6, x24
    sbc             x6, x6, x24
    stp             x15, x16, [x0, #96]
    eor             x7, x7, x1
    subs            x7, x7, x1
    eor             x8, x8, x1
    sbcs            x8, x8, x1
    eor             x9, x9, x1
    sbcs            x9, x9, x1
    eor             x10, x10, x1
    sbc             x10, x10, x1
    stp             x17, x19, [x0, #112]
    eor             x1, x1, x24
    mul             x11, x3, x7
    mul             x15, x4, x8
    mul             x16, x5, x9
    mul             x17, x6, x10
    umulh           x19, x3, x7
    adds            x15, x15, x19
    umulh           x19, x4, x8
    adcs            x16, x16, x19
    umulh           x19, x5, x9
    adcs            x17, x17, x19
    umulh           x19, x6, x10
    adc             x19, x19, xzr
    adds            x12, x15, x11
    adcs            x15, x16, x15
    adcs            x16, x17, x16
    adcs            x17, x19, x17
    adc             x19, xzr, x19
    adds            x13, x15, x11
    adcs            x14, x16, x12
    adcs            x15, x17, x15
    adcs            x16, x19, x16
    adcs            x17, xzr, x17
    adc             x19, xzr, x19
    subs            x24, x5, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x9
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x16, x16, x22
    eor             x21, x21, x20
    adcs            x17, x17, x21
    adc             x19, x19, x20
    subs            x24, x3, x4
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x8, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x12, x12, x22
    eor             x21, x21, x20
    adcs            x13, x13, x21
    adcs            x14, x14, x20
    adcs            x15, x15, x20
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x4, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x8
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x15, x15, x22
    eor             x21, x21, x20
    adcs            x16, x16, x21
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x3, x5
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x9, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x13, x13, x22
    eor             x21, x21, x20
    adcs            x14, x14, x21
    adcs            x15, x15, x20
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x3, x6
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x10, x7
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x14, x14, x22
    eor             x21, x21, x20
    adcs            x15, x15, x21
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    subs            x24, x4, x5
    cneg            x24, x24, cc
    csetm           x20, cc
    subs            x21, x9, x8
    cneg            x21, x21, cc
    mul             x22, x24, x21
    umulh           x21, x24, x21
    cinv            x20, x20, cc
    cmn             x20, #0x1
    eor             x22, x22, x20
    adcs            x14, x14, x22
    eor             x21, x21, x20
    adcs            x15, x15, x21
    adcs            x16, x16, x20
    adcs            x17, x17, x20
    adc             x19, x19, x20
    ldp             x3, x4, [x0]
    ldp             x7, x8, [x0, #64]
    adds            x3, x3, x7
    adcs            x4, x4, x8
    ldp             x5, x6, [x0, #16]
    ldp             x9, x10, [x0, #80]
    adcs            x5, x5, x9
    adcs            x6, x6, x10
    ldp             x20, x21, [x0, #96]
    adcs            x7, x7, x20
    adcs            x8, x8, x21
    ldp             x22, x23, [x0, #112]
    adcs            x9, x9, x22
    adcs            x10, x10, x23
    adcs            x24, x1, xzr
    adc             x2, x1, xzr
    cmn             x1, #0x1
    eor             x11, x11, x1
    adcs            x3, x11, x3
    eor             x12, x12, x1
    adcs            x4, x12, x4
    eor             x13, x13, x1
    adcs            x5, x13, x5
    eor             x14, x14, x1
    adcs            x6, x14, x6
    eor             x15, x15, x1
    adcs            x7, x15, x7
    eor             x16, x16, x1
    adcs            x8, x16, x8
    eor             x17, x17, x1
    adcs            x9, x17, x9
    eor             x19, x19, x1
    adcs            x10, x19, x10
    adcs            x20, x20, x24
    adcs            x21, x21, x2
    adcs            x22, x22, x2
    adc             x23, x23, x2
    stp             x3, x4, [x0, #32]
    stp             x5, x6, [x0, #48]
    stp             x7, x8, [x0, #64]
    stp             x9, x10, [x0, #80]
    stp             x20, x21, [x0, #96]
    stp             x22, x23, [x0, #112]
    ret             
hoist_finish:
ret
