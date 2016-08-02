MOV [0x0], 2049
MOV EAX, [0x0]
MOV EBX, 0x4	; First address
JMP collatz

f:	TEST EAX, 1
	JNZ odd 		; if odd, jump
	SHR EAX, 1	; if even, divide by 2
	RET
	
odd:	IMUL EAX, 3
	ADD EAX, 1
	RET

collatz: 	CALL f
	MOV [EBX], EAX
	ADD EBX, 4
	CMP EAX, 1
	JNE collatz