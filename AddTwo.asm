; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
include irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
tb1 db 'Nhap vao 1 chuoi: ', 0
.code
main proc
	mov	eax,5				
	mov ah, 09h
	mov edx, offset tb1
	call writestring 
	add	eax,6				

	invoke ExitProcess,0
main endp
end main