format binary as 'img'
;;;;;;;;;;;; Seccion de booteo
org 7c00h
mov ax, cs
mov ds, ax
xor ax,ax
xor di,di

;; Stack Set
mov bp, 0x8000 ; set the stack safely away
mov sp, bp

;; Keyboard initialization
xor ax,ax
mov es, ax
mov ax,keyboard
mov [es:4*9], ax
mov [es:4*9+2], cs

;; TIMER
mov ax,timer
mov [es:4*8] , ax
mov [es:4*8 + 2] ,cs

sti

;;;;;;;;;;;; Modo grafico
xor eax, eax
mov ax, 13h
int 10h
mov ax, 0A000h
mov es, ax

;; Fill the Background
call printBackground
call drawTank1ToRight
call drawTank2ToLeft

jmp exit
;;;;;;;;;;;; Loop Infinite
exit :
  jmp $

;; includes
include 'draw.asm'
include 'keyboard.asm'
include 'timer.asm'
include 'tank1.asm'
include 'tank2.asm'

;; Data
tank1Pos dw (320 * 0 + 0)
tank2Pos dw (320 * 180 + 300)
isPausedGame dd 0
;; Keys Mappings
keyEnter db 1ch
keyEsc db 01h
;; Arrows Keys
keyLeftArrow db 4bh
keyRigthArrow db 4dh
keyUpArrow db 48h
keyDownArrow db 50h
;; AWSD Keys
keyMapA db 1eh
keyMapD db 20h
keyMapW db 11h
keyMapS db 1fh

;;;;;;;;;;;; padding and magic number
times 510 - ($ - $$) db 0
dw 0aa55h
