;for(i=0;i<n;i++)
;    {
;        if(a[i]<0)
;         {    
;            for(j=i;j<n-1;j++)
;            {
;                a[j]=a[j+1];
;           }
;            n=n-1;
;        }
;    }
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
a sword 3,-4,6,3,4,2,7,9,5
n byte 9
i byte 0
max dw 0
.code
main proc
	mov al , -4
	lap:
		mov eax, 0
		mov al, i
		cmp al, n
		je ketthuc
		mov edx, 0
		mov dl, al
		mov ax, a[edx*2]	
		cmp ax, 0
		jb ketthuc
		call writeint
		mov al, i
		inc al
		mov i, al
		jmp lap
	ketthuc:
	mov ax, a[0]
	mov max, ax
	mov i, 1
	
	call writedec

	invoke ExitProcess,0
main endp
end main