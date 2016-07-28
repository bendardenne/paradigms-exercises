; 3. AbsMean

; Sample Data
; dd  n,   item_1,  item_2, ...  item_n
dd 15,    -12,  14,  65, -124, 57, 12, 13, -98, -41, 2, 10, 24, -30, 74, 146, 85

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

avg: 
	MOV EDX, [EBX]
	CMP EDX, 0
	JGE positive 
	NEG EDX
positive:   ADD EAX, EDX
	ADD EBX, 4
	LOOP avg
	
MOV ECX, [0x0]
;DIV ECX