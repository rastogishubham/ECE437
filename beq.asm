org   0x0000
ori $1, $zero, 10
ori $2, $zero, 10
nop
nop
nop
nop
beq $1, $2, hal
ori $1, $zero, 15
hal: halt

