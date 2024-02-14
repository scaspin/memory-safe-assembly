start: 
    add x3,x1,x2
loop_1:
    ldr x5,[x1]
    add x1,x1,#1
    cmp x1,x3
    b.ne loop_1
add x4,x4,#4
