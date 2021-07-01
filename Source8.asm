.586
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
array byte 8,17,3,9,13
sizearr dword 5
.code
main PROC
	; write your code
	sub sizearr,1
	mov ecx, -1
	mov edx, 0
	lap:
	inc ecx
	cmp ecx,sizearr
	je ketThuc
	mov edx,ecx
	lap1:
	inc edx
	cmp edx,sizearr
	jg lap
	mov bl,array[ecx]
	cmp bl,array[edx]
	jg swap
	jmp lap1
	swap:
		mov al, array[ecx]
		mov bl, array[edx]
		mov array[edx], al
		mov array[ecx], bl
	jmp lap1
	ketThuc: 
	xor ecx,ecx
	mov cl,array[0]
	mov cl,array[1]
	mov cl,array[2]
	mov cl,array[3]
	mov cl,array[4]

	INVOKE ExitProcess,0
main ENDP
END main

;for(i=0;i<n-1;i++)
;       for(j=i+1; j<n; j++)
;       {
;        if(a[i]>a[j])
;          {
;            tg=a[i];
;             a[i]=a[j];
;              a[j]=tg;
 ;          } 
;       }