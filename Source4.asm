
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
n byte 20
i byte 2
dem byte 0
j byte 2
.code
main proc
	lap:
		mov ax, 0
		mov al, i
		cmp al, n
		ja ketthuc
		mov ecx, 0
		mov bl, 2
		div bl
		mov ecx, 0
		mov cl, al
		mov dem, 0
		dec cl
		cmp cl, 0
		je tiep1
		mov j, 2
		lap2:
			mov ax, 0
			mov al, i
			mov bx, 0
			mov bl, j
			div bl
			cmp ah, 0
			jne tiep
			inc dem
			
			tiep:
				inc j
				loop lap2

		tiep1:
		inc i
		jmp lap
	ketthuc:
	invoke ExitProcess,0
main endp
end main

;or(i=2;i<=n;i++)
;    {        
;        dem=0;
;        for(j=2;j<=i/2;j++)
;        {
;            if(i%j==0)
;            dem++;
;        }        
;    }