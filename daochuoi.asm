INCLUDE Irvine32.inc

.data
Str0 BYTE "Nhap X: ", 00h
Str1 BYTE "Nhap Y: ", 00h
Str2 BYTE "Uoc chung lon nhat cua X va Y la: ", 00h
Str3 BYTE "X va Y phai khac 0.", 0ah, 00h

.code
main PROC
LOOP1_main:
    mov edx, OFFSET Str0
    call WriteString
    call ReadInt
    cmp eax, 0
    je ERROR1_main
    push eax
    mov edx, OFFSET Str1
    call WriteString
    call ReadInt
    cmp eax, 0
    je ERROR1_main
    push eax
    call GCD
    mov edx, OFFSET Str2
    call WriteString
    call WriteInt
    mov al, 0ah
    call WriteChar
    jmp LOOP1_main
ERROR1_main:
     mov edx, OFFSET Str3
     call WriteString
     jmp LOOP1_main
main ENDP

GCD PROC
     push ebp
     mov ebp, esp
     mov ebx, [ebp + 12]
     mov ecx, [ebp + 8]
     push ebx
     call abs
     add esp, 4
     mov ebx, eax
     push ecx
     call abs
     add esp, 4
     mov ecx, eax
    LOOP1_GCD:
         mov eax, ebx
         mov edx, 0
         div ecx
         mov ebx, ecx
         mov ecx, edx
         cmp ecx, 0
         jg LOOP1_GCD
     mov eax, ebx
     pop ebp
     ret
GCD ENDP

abs PROC
     push ebp
     mov ebp, esp
     mov eax, [ebp + 8]
     cmp eax, 0
     jg EXIT1_abs
     neg eax
    EXIT1_abs:
         pop ebp
     ret
abs ENDP

END main
