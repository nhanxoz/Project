;for(i=0;i<n;i++)
;    {
;        kt=0;
;        for(j=2;j<=a[i]/2;j++)
;        {
;            if(a[i]%j==0)
;            kt=1;    
;        }
;        if(kt==0)
;        printf("\nso nguyen to %d vi tri %d trong mang ", a[i], i );
;    }

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
a dw 3,4,6,3,4,2,7,9,5
n byte 9
kt byte 0
j byte 2
i byte 0
str1 db "So nguyen to", 0
str2 db " vi tri ", 0
str3 db " trong mang ", 0
.code
main proc
	lap:
		mov al, i
		cmp al, n
		je ketthuc
		mov kt, 0
		mov edx, 0
		mov dl, al
		mov ax, a[edx*2]
		mov bx, 0
		mov bl, 2
		div bl
		mov j, 2
		mov ecx, 0
		mov cl, al
		cmp cl, 2
		jbe tiep2
		sub cl, 2
		
		lap2:
			mov eax, 0

			mov al, i
			
			mov ax, a[edx*2]
			mov bx, 0
			mov bl, j
			div bl
			inc j
			cmp ah, 0
			jne tiep1
			mov kt, 1
			tiep1:
			loop lap2
		cmp kt, 0
		jne tiep2
		mov edx, offset str1
		call writestring
		mov eax, 0
		mov al, i
		
		mov ax, a[eax*2]
		call writedec


	tiep2:
	mov al, i
	inc al
	mov i, al
	jmp lap

			
	ketthuc:
	invoke ExitProcess,0
main endp
end main