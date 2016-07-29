;2. Flow Control

MOV [0xC], -35
MOV BX, 0x20
MOV CX, 0x70

; Check that the integer in adress 0xC is stricly negative.
; If it is, multiply it by three, otherwise do nothing.
; (Hint: jump to a label to skip the multiplication if the number is even.)

CMP [0xC], 0
JGE positive 
	MOV EAX, [0xC]
	IMUL EAX, 3
	MOV [0xC], EAX
positive:

; Write a loop to generate a sequence of incrementing numbers 
; starting from 0, in every address from the address in EBX 
; up to the address in ECX (use 32-bit words).
; EAX and EBX must be unchanged after the operation.

PUSH EBX
write: 
	MOV [EBX], EDX 
	INC EDX
	ADD EBX, 4	; Next address. 
			; 32 bit words -> addresses increase by 4
	CMP EBX, ECX
	JNE write
; End of the loop, EBX == ECX
POP EBX
