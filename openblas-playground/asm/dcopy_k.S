dcopy_k:
cmp x0, xzr
b.le dcopy_k_d8
cmp x2, #0x1
b.ne dcopy_k_5c
cmp x4, #0x1
b.ne dcopy_k_5c
asr x5, x0, #2
cmp x5, xzr
b.eq dcopy_k_3c
dcopy_k_24:
ldr q0, [x1], #0x10
str q0, [x3], #0x10
ldr q1, [x1], #0x10
str q1, [x3], #0x10
subs x5, x5, #0x1
b.ne dcopy_k_24
dcopy_k_3c:
ands x5, x0, #0x3
b.le dcopy_k_d8
dcopy_k_44:
ldr d0, [x1], #0x8
str d0, [x3], #0x8
subs x5, x5, #0x1
b.ne dcopy_k_44
mov w0, wzr
ret
dcopy_k_5c:
lsl x2, x2, #3
lsl x4, x4, #3
asr x5, x0, #2
cmp x5, xzr
b.le dcopy_k_b8
dcopy_k_70:
ldr x10, [x1]
add x1, x1, x2
str x10, [x3]
add x3, x3, x4
ldr x10, [x1]
add x1, x1, x2
str x10, [x3]
add x3, x3, x4
ldr x10, [x1]
add x1, x1, x2
str x10, [x3]
add x3, x3, x4
ldr x10, [x1]
add x1, x1, x2
str x10, [x3]
add x3, x3, x4
subs x5, x5, #0x1
b.ne dcopy_k_70
dcopy_k_b8:
ands x5, x0, #0x3
b.le dcopy_k_d8
dcopy_k_c0:
ldr x10, [x1]
add x1, x1, x2
str x10, [x3]
add x3, x3, x4
subs x5, x5, #0x1
b.ne dcopy_k_c0
dcopy_k_d8:
mov w0, wzr
ret
