;for(i=0;i<n;i++)
;    {        
;        scanf("%d", &a[i]);
;    }
;    max=a[0];
;    for(i=1;i<n;i++)
 ;   {
;        if(a[i]>max)
;        {
;            max =a[i];
;        }
;    }
;
;
;
;
;
;
;
;
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
a dw 3,4,6,3,4,2,7,9,5
n byte 9
i byte 0
max dw 0
.code
main proc
	lap:
		mov eax, 0
		mov al, i
		cmp al, n
		je ketthuc
		mov edx, 0
		mov dl, al
		mov ax, a[edx*2]	
		call writedec
		mov al, i
		inc al
		mov i, al
		jmp lap
	ketthuc:
	mov ax, a[0]
	mov max, ax
	mov i, 1
	lap1:
		mov eax, 0
		mov al, i
		cmp al, n
		je ketthuc1
		mov edx, 0
		mov dl, al
		mov ax, a[edx*2]
		cmp max, ax
		ja next1
		mov max, ax	
		next1:

		mov al, i
		inc al
		mov i, al
		jmp lap1
	ketthuc1:
	mov eax, 0
	mov ax, max
	call writedec

	invoke ExitProcess,0
main endp
end main