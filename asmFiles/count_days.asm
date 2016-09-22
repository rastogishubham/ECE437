	org 0x0000
	LUI $29, 0xFFFC
	SLL $29, $29, 16
	LUI $3, 0
	ORI $3, $3, 19
	LUI $4, 0
	ORI $4, $4, 8
	LUI $5, 0
	ORI $5, $5, 2016
	ADDI $4, $4, -1
	PUSH $4
	LUI $6, 0
	ORI $6, $6, 30
	PUSH $6
	JAL mul1
	BEQ $0, $0, next
mul1:   POP $10
	POP $11
loop1:  ADD $9, $9, $10
	ADDI $11, $11, -1
	BNE $11, $0, loop1
	PUSH $9
	JR $31
next:	POP $15
	AND $9, $9, $0
	ADDI $5, $5, -2000
	LUI $7, 0
	ORI $7, $7, 365
	PUSH $5
	PUSH $7
	JAL mul1
	POP $16
	ADD $3, $3, $15
	ADD $3, $3, $16
	PUSH $3
	HALT
