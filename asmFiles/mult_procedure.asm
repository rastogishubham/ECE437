	org 0x0000
	LUI $29, 0
	ORI $29, $29, 0xFFFC
	LUI $3, 0
	LUI $4, 0
	LUI $5, 0
	LUI $6, 0
	LUI $7, 0
	ORI $3, $3, 0x00000004
	ORI $4, $4, 0x00000004
	ORI $5, $5, 0x00000004
	ORI $6, $6, 0x00000004
	ORI $7, $7, 3
	PUSH $3
	PUSH $4
	PUSH $5
	PUSH $6
loop1:  ADDI $7, $7, -1
	JAL mul
	AND $9, $9, $0
	BNE $7, $0, loop1
	POP $20
	HALT
mul:    POP $10
	POP $11
loop2:  ADD $9, $9, $10
	ADDI $11, $11, -1
	BNE $11, $0, loop2
	PUSH $9
	JR $31
	
