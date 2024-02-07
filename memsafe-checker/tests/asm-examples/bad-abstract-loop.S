start: 
    add x3,x1,x2
loop:
    add x1,x1,#1
    ldr x4,[x1]
    cmp x1,x3
    b.ne loop
add x4,x4,#4
