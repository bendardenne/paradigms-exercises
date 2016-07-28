; 1.a  Using registers, memory and the stack

; Store the integer 4 in the 32-bit EAX register
; Store the integer 10 in the 32-bit EBX register 
; Store the integer 5 in the 16-bit CX register
; Store the integer 2 in the 8-bit DL register
MOV EAX, 4
MOV EBX, 10
MOV CX, 5
MOV DL, 2

; Store 25 in the adress pointed by EAX (i.e. 0x4)
MOV [EAX], 25


; Stack manipulation

; Push the integer 42 on the stack. Then push 30. 
PUSH 42
PUSH 30

; Pop the first element of the stack into the 16-bit CX register.
POP CX 	


; 1.b Basic Arithmetics 

; Add 4 to EBX 
ADD EBX, 4

; Subtract the content of EBX
; to the integer located at the adress contained in EAX
SUB [EAX], EBX 

; Multiply EBX by 8.
IMUL EBX, 8

; Divide CX by 7. The quotient must be stored in ECX 
; and the remainder in EDX
; EAX must be unchanged at the end of the operation.
; (hint: use the stack to restore EAX. Use an 8 bit register)

PUSH AX		; Save AX on the stack

MOV AX, CX	; Set up the operands
MOV DX, 7		; in the appropriate registers

IDIV DL		; DL is 8bit 
		; -> AL = AX / DL   and  AH = AX % DL
MOV CL, AL	 
MOV DL, AH    	
POP AX		; Restore AX
