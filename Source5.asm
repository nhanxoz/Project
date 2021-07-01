;int n = ?,s=0;
;    for(i=1;i<=2*n+1;i=i+2)
;    {
;        s=s+i;
;    }


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
n byte ?
s byte 0
i byte 1
.code
main proc
	mov n, 10
	mov al, n
	shl al, 1
	inc al 
	lap:
	cmp i, al
	ja ketthuc
	mov bl, i
	add s, bl
	inc i
	inc i
	jmp lap
	ketthuc:
	invoke ExitProcess,0
main endp
end main
