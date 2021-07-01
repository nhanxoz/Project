
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
a dw 10
b dw 12
.code
main proc
mov ax, a
mov bx, b
lap: 
	cmp ax, bx
	je tiep
	cmp ax, bx
	ja dk_if
	sub bx, ax
	jmp lap
	dk_if: sub ax, bx
	jmp lap
tiep:

	invoke ExitProcess,0
main endp
end main
;while(a!=b)
;    {
;        if(a>b)
;        {
 ;           a-=b;
 ;       }
 ;       else
;        {
;            b-=a;    
;        }
;    }