	org 0x0000
	LUI $29, 0xFFFC
	SLL $29, $29, 16
	LUI $3, 0
	LUI $4, 0
	ORI $3, $3, 0x10
	ORI $4, $4, 0x20
	PUSH $3
	PUSH $4
	POP $10
	POP $11
loop:   ADD $9, $9, $10
	ADDI $11, $11, -1
	BNE $11, $0, loop
	PUSH $9
	HALT
