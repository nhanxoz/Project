;(1)
; do
;    {
;       a+=10; b+=20;
;    }
;    while(a<=100 || b<=200);


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
a db 0
b db 0
.code
main proc
	lap:
	add a, 10
	add b, 20
	cmp a, 100
	jbe lap
	cmp b, 200
	jbe lap
	invoke ExitProcess,0
main endp
end main
