;for(i=1;i<x;i++)
 ;   {
 ;       if(x%i== 0)
 ;       {
 ;           s=s+i;
 ;       }        
 ;   } 
 
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
i byte ?
x byte ?
s byte 0
.code
main proc
mov dl, 1
mov x, 12
mov ecx, 12

lap:
mov ax, 0
mov al , x
mov bx, 0
mov bl, dl
div bl
cmp ah, 0
jne tiep
add s, dl
tiep:
inc dl
loop lap
	invoke ExitProcess,0
main endp
end main