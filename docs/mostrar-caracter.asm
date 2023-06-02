format binary as 'img'
org 7C00h

mov ax, 3
int 10h

xor di, di
xor dl, dl
xor bl, bl
xor ax, ax
mov es, ax
mov ax,timer
mov [es:4*8], ax
mov [es:4*8+2], cs

mov ax,keyboard
mov [es:4*9], ax
mov [es:4*9+2], cs

sti

jmp $

; _________ISR_______
timer:
  cli
   inc [cont]
   cmp [cont], 18
   jne @f
   mov [cont],0
   inc bl
   mov al, bl
   xor ah, ah
   aam
   add ax, 3030h

    mov [0xb8000+ 160*24+156], ah
    mov [0xb8000+ 160*24+158], al
 @@:
  mov al, 20h
  out 20h, al
  sti
iret

 keyboard:
   in	al,60h	; Leer el buffer del teclado
   cmp	al,127
   ja	@f			; Desechar los eventos de liberaci�n de tecla
   mov	esi,keymap		; Leer la direcci�n del mapa de caracteres
   xor	ah,ah			; Transformar el scan-code en un �ndice de 16bit
   add	si,ax			; y utilizarlo para apuntar al mapa de caracteres
   mov	al,[esi]		; Obtener el equivalente ASCII de la tecla presionada
   mov	edi,[current_pos]
   mov	[0xb8000+edi],al	; Mostrar el ASCII en pantalla
   add	[current_pos],2 	; Actualizar la siguiente coordenada
@@: 
   mov	al,20h			; fin de interrupci�n hardware
   out	20h,al			; al pic maestro
iret
; ________ Declaraci�n de variables________
    cont db 0
    current_pos dd 0
	keymap: 
      db 0
		db 27,'1234567890-=',8
		db 9,'qwertyuiop[]',10
		db 0,'asdfghjkl;',39,96,0,'\'
		db 'zxcvbnm,./',0,'*',0,' '
		db 0,'2345678901',0,'3789-456+1230.'

times	510-($-$$) db 0
	    dw 0xaa55
