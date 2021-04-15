
; © 2021 Nhan Nguyen Huu.  All rights reserved.
; Display a calendar for a specific month 

INCLUDE Irvine32.inc

.data
	data1	DB	31,28,31,30,31,30,31,31,30,31,30,31			; Khoi tao mang bao gom cac ngay cua moi thang

	str2	DB "Thang ", 0									; 4 xau ky tu dung de ho tro trong xuat ket qua
	str3	DB "Nam ", 0
	str4	DB " ", 0
	day_of_week DB "T2 T3 T4 T5 T6 T7 CN", 0

	ngay_1	DW	1											; ngay dau tien cua thang
	thang_1 DB	2											; <----------------Chinh sua thang o day 
	a		DW ?
	b		DW ?

	d		DW ?
	e		DW ?
	e2		DW ?
	e3		DW ?
	e4		DW ?
	e5		DB ?
	e6		DB ?
	nam_1	DW 2021											; <----------------Chinh sua nam o day
	nam1	word ?
	ketqua	WORD  ?, ?, ?									; Su dung trong xet nam nhuan

	newLine BYTE 0DH, 0AH, 0

.code
namnhuan PROC												; Ham xet nam nhuan, neu la nam nhuan, bl = 1 va nguoc lai
	mov nam1, bx
	xor eax, eax											; xoa eax
	mov ax, nam1											; chuyen bien vao thanh ghi ax de su dung phep chia
	mov bx, 400												; so bi chia la 400
	xor dx, dx												; xoa dx ( vi phep chia bx su dung dx:ax)
	div bx									
	cmp dx, 0												; dx = ax % bx, so sanh dx voi 0, neu chia het ketqua[0] =1 
	je continue1											; neu khong chia het ketqua[0] = 0
	mov dx, 0
	jmp continue1_1
	continue1:												; Tuong duong: if dx == 0: ketqua[0] = 1 else ketqua[0] = 0
	mov dx, 1
	continue1_1:
	mov ketqua[0], dx									
	; -------------------------------------------------------------------------------------------------------
	mov ax, nam1										
	mov bx, 100												; if nam1 % 100 == 0: ketqua[1]= 0 else ketqua[1] = 1
	xor dx, dx
	div bx
	cmp dx, 0
	je continue2
	mov dx, 1
	jmp continue2_1
	continue2:
	mov dx, 0
	continue2_1:
	mov ketqua[1], dx
	;---------------------------------------------------------------------------------------------------------
	mov ax, nam1											; if nam1 % 4 == 0: ketqua[2] = 1 else ketqua[2] = 0
	mov bx, 4
	xor dx, dx
	div bx
	cmp dx, 0
	je continue3
	mov dx, 0
	jmp continue3_1
	continue3:
	mov dx, 1
	continue3_1:
	mov ketqua[2], dx
	;----------------------------------------------------------------------------------------------------------
	mov bh, byte ptr ketqua[0]								; luu lai cac ketqua vao cac thanh ghi
	mov bl, byte ptr ketqua[1]
	mov dl, byte ptr ketqua[2]

	and bl, dl											
	or bl, bh												; bl = (bl and dl) or bh
;	
	ret
namnhuan ENDP


main PROC
;---------------------------------------------------------------------------------------------
; Tuong duong cau lenh trong C++:
;
;	int a= ((14 - month) / 12);
;	int	jmd = (day + ((153 * (month + 12 * a - 3) + 2) / 5) +
;     (365 * (year + 4800 - a) % 343) +
;     ((year + 4800 - a) / 4) - 
;    ((year + 4800 - a) / 100) + 
;    ((year + 4800 - a) / 400)  - 6) % 7
;---------------------------------------------------------------------------------------------
	xor eax, eax
	mov ax, 14
	sub al, thang_1
	mov bl, 12
	div bl
	mov ah, 0
	mov a, ax												; a = ((14 - month) / 12)

	mov bl,12
	mul bl
	add al, thang_1
	sub al, 3
	mov bl, 153
	mul bl
	add al, 2
	mov bl, 5
	mov bh, 0
	xor dx,dx
	div bx
	mov e4, ax												; e4 = ((153 * (month + 12 * a - 3) + 2) / 5)

	mov cx, 4800
	add cx, nam_1
	sub cx, a
	mov b, cx												; b = year + 4800 - a
	
	mov bx, 365
	mov ax, b
	mul bx
	mov bx, 343
	div bx
	mov d, dx												; d = (365 * b )% 343 ; trong cong thuc goc chi la 365 * b , % 343 them de tranh tran thanh ghi

	xor dx, dx
	mov ax, b
	mov bh, 0
	mov bl, 4
	div bx													; e = b/4
	mov e, ax

	xor dx, dx
	mov ax, b
	mov bh, 0
	mov bl, 100
	div bx													; e2 = b/100
	mov e2, ax

	xor dx, dx
	mov ax, b
	mov bx, 400
	div bx
	mov e3, ax												; e3 = b/400

	mov ax, 0
	mov ax, d
	add ax, ngay_1
	add ax, e4
	add ax, e
	sub ax, e2
	add ax, e3
	sub ax, 6
	mov bx, 7
	xor dx, dx
	div bx													; e5 =  (day + e4 + d + e - e2 + e3) % 7

	mov e5, dl
	mov bx, nam_1
	call namnhuan											; Goi ham nam nhuan
	cmp dx, 1												; neu la nam nhuan thi data1[1] = 29 ( thang 2 nam do co 29 ngay)
	jne continue_main
	mov data1[1], 29
	continue_main:
;-------------------------------------------------Hien thi lich thang do--------------------------------------------------
	mov edx, offset str3
	call writestring

	mov ax, nam_1
	call writeDec											; printf("Nam %d", nam_1 ); in ra nam

	mov edx, offset newline
	call writestring

	mov edx, offset str2
	call writestring
	mov ah, 0
	mov al, thang_1
	call writeDec											; printf("\nThang %d", thang_1); in ra thang

	mov edx, offset newline									;
	call writestring

	mov edx, offset day_of_week								; In ra ten cac ngay trong tuan
	call writestring

	
	mov edx, offset newline
	call writestring

	xor edx, edx
	mov dl, thang_1
	dec dl
	mov cl, data1[edx]
	mov e6, cl												; e6 = so ngay cua thang do
	mov al, 0												; khoi tao lai al = 0, bl = 1
	mov bl, 1												; al : so thu tu cua vi tri in ra , bl : ngay trong thang
	l1:														; Lap 1: in ra chuoi "   " ( 3 dau cach) cho den khi al == e5 ( ngay dau tien trong thang)
		cmp al, e5											; so sanh al voi e5, neu al == e5 ket thuc vong lap 1 nhay sang vong lap thu 2
		je ctn_1
		mov edx, offset str4
		call writestring
		call writestring
		call writestring
		inc al												; tang al len 1 
		jmp l1												; tro lai l1
		
			
	ctn_1:													; vong lap 2: in ra tat ca cac ngay con lai
		cmp bl, e6											; so sanh bl voi e6 ( e6 la so ngay cua thang)
		ja end_1											; neu bl > e6 ket thuc chuong trinh
		cmp bl, 10											; neu bl < 10: in them ky tu '0' vao dau moi ngay
		jae ctn_3											; neu bl >= 10: bo qua buoc nay
			mov bh, 0
			mov ah, 0
			mov e5, al
			mov al, 0
			call writedec
			mov al, e5
		ctn_3:												
		mov bh, al
		mov ah, 0											; lam sach thanh ghi ah
		mov al, bl											; in ra ngay tren thanh ghi ax
		call writedec
		mov edx, offset str4	
		call writestring
		mov al, bh											
		mov cl, bl
		mov ch, al											; luu gia tri cua bl va al hien thoi vao thanh ghi cl va ch
		mov bl, 7											; bl = 7 - so chia bang 7
		mov ah, 0											; lam sach thanh ghi ah
		div bl												; ax / bl: thuong luu vao thanh ghi al, so du luu vao thanh ghi ah
		cmp ah, 6											; neu ah = 6: in ky tu xuong dong
		jne ctn_2											; neu ah != 6: bo qua buoc nay
			mov edx, offset newline
			call writestring
		ctn_2:
		mov al, ch											; tra lai gia tri cho thanh ghi al va bl
		mov bl, cl
		inc al												; tang al va bl them 1 don vi
		inc bl
		jmp ctn_1											; den vong lap tiep
	end_1:													; ket thuc
	exit
main ENDP
END main