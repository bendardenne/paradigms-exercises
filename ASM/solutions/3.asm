; 3. AbsMean

; Sample Data
; DD  n,	item_1,  item_2, 	...  			item_n
DD 10,	-12,  14,  65, -124, 57, 12, 13, -98, -41, 2, 10


; Write a program that computes the average value of the absolute values
; of an array in memory.  
; We assume the memory contains :
; 	at 0x0:  n, a 32bit integer: the length of the array.
;	from 0x4: 	the array of 32 bit integers.
; (you can use the table on the right to manually change the example values)



; We will store in EAX the sum of all numbers 
; (because we will divide it, and DIV uses EAX)

; We can use EBX as an adress counter
;	   ECX as a index counter (LOOP instruction to decrement)
;	   EDX as an tmp register
MOV EBX, 0x4
MOV ECX, [0x0]

absmean: 
	MOV EDX, [EBX]	; Get item from memory
	CMP EDX, 0	
	JGE positive 	; if negative
	NEG EDX		; Change sign
positive:   
	ADD EAX, EDX	; Sum
	ADD EBX, 4	; Next address
	LOOP absmean
	
MOV ECX, [0x0]		; Get n
MOV EDX, 0		; DIV will operate on EDX:EAX
DIV ECX			; Average
