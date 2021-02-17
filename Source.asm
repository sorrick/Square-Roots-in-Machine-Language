;AUTHOR: Richard Soria
;DESCR:  This machine language code finds the square root of each number between 0 and 100

INCLUDE Irvine32.inc

.data
	prompt1 BYTE "The square root of ", 0
	prompt2 BYTE " is: "

.code
SquareRoot PROC
	push ebp
	mov ebp, esp
	sub esp, 8							;only need 2 local variables
	mov DWORD PTR[ebp - 4], 0			;sqrt
	mov DWORD PTR[ebp - 8], 1			;subtractant
	mov eax, DWORD PTR[ebp + 8]			;int x
work:
	cmp eax, DWORD PTR[ebp - 8]			;while x >= subtractant
	jl done								;if x < substractant, jump to done
	sub eax, DWORD PTR[ebp - 8]			;x -= subtractant
	mov DWORD PTR[ebp + 8], eax			;x = x - subtractant
	add DWORD PTR[ebp - 8], 2			;subtractant += 2
	inc DWORD PTR[ebp - 4]				;inc
	jmp work							;loops back
done:
	mov eax, DWORD PTR[ebp -4]			;sets eax equal to sqrt
	add esp, 8							
	pop ebp
	ret 4
SquareRoot ENDP



main PROC

mov ecx, 101						;Needs to loop 100
mov ebx, 0							;i = 0

again:
	
	mov edx, OFFSET prompt1
	call WriteString
	mov eax, ebx
	call WriteDec
	mov edx, OFFSET prompt2
	call WriteString				;Prints out the two prompts
	push eax						;pushes eax into the function as a parameter
	call SquareRoot
	call WriteDec					;cout << value
	call Crlf
	inc ebx							;++i

	loop again
	
	call WaitMsg

	exit
main ENDP
END main