;;;;;;;;;; Main Code ;;;;;
org 8000h

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


;;;;;;;;;;;; Modo grafico
xor eax, eax
mov ax, 13h
int 10h
mov ax, 0A000h
mov es, ax

gameLoop:
  call printGame
  jmp gameLoop

jmp exit

exit :
  jmp $
;;;;;;;;;;;; LOOP INFINITE

;; INCLUDES
include 'draw.asm'
include 'keyboard.asm'
include 'timer.asm'
include 'tank1.asm'
include 'tank2.asm'
include 'bullet.asm'

;;;;; DATA
tank1Pos              dw (320 * 12 + 5)
tank1Hearts           db 3 ;; max 3 hearts
tank1BalaPos          dw (320 * 0 + 0)
tank1BalaActiveDirPos db 0   ; 1 up, 2 right, 3 down, 4 left, 0 inactive
tank1BalaActiveTime   db 0   ; max 8 times, when == 8 set to 0 and tank1BalaActiveDirPos = 0

tank2Pos              dw (320 * 175 + 295)
tank2Hearts           db 3 ;; max 3 hearts
tank2BalaPos          dw (320 * 0 + 0)
tank2BalaActiveDirPos db 0   ; 1 up, 2 right, 3 down, 4 left, 0 inactive
tank2BalaActiveTime   db 0   ; when == 8 set to 0 and tank1BalaActiveDirPos = 0

tank1Color    db 02h 
tank2Color    db 04h 

tank1LastDir  db  2   ; 1 up, 2 right, 3 down, 4 left
tank2LastDir  db  4   ; 1 up, 2 right, 3 down, 4 left

isPausedGame  db 0
gameTickTimer db 0

;;;;; KEYS MAPPINGS
keyEnter db 1ch
keyEsc   db 01h
keySpace   db 39h

;;;;; ARROWS KEYS
keyLeftArrow db 4bh
keyRigthArrow db 4dh
keyUpArrow db 48h
keyDownArrow db 50h

;;;;; AWSD KEYS
keyMapA db 1eh
keyMapD db 20h
keyMapW db 11h
keyMapS db 1fh
