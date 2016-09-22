org   0x0000
ori $1, $zero, 10
ori $2, $zero, 11
nop
nop
nop
nop
nop
bne $1, $2, hal
ori $1, $zero, 15
hal: halt

