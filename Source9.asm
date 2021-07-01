;v=0; 
;    i=0;
;    while(a[i]>x)
;    {    
;        i++;
;    } 
 ;   v=i;    
 ;   for(i=n-1;i>=v;i--)
 ;   {
;        a[i+1]=a[i];
;    }
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
a dw 3,4,6,3,4,2,7,9,5,?
n byte 9
i byte 0
max dw 0
.code
main proc

	mov ax, a[0]
	mov max, 5
	mov i, 0
	lap1:
		mov eax, 0
		mov al, i
		cmp al, n
		je ketthuc1
		mov edx, 0
		mov dl, al
		mov ax, a[edx*2]
		cmp max, ax
		jb next1
		

		mov al, i
		inc al
		mov i, al
		jmp lap1
	next1:
	mov eax, 0
	mov al, i
	mov max, ax
	call writedec
	ketthuc1:
	lap2:
		mov eax, 0
		mov al, n
		cmp ax, max
		je ketthuc2
		mov edx, 0
		mov dl, al
		mov ebx, 0
		mov bl, al
		dec bl
		mov ax, a[ebx*2]
		mov a[edx*2], ax
		
		

		mov al, n
		dec al
		mov n, al
		jmp lap2
	next2:
	
	ketthuc2:
	invoke ExitProcess,0
main endp
end main