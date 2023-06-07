calculatePositionFromXYPositions:   ;params -> Y in DX , X en BX , return value in AX
   push dx
   push bx
   push cx

   xor cx,cx
   xor ax,ax
   mov cx , 320
   @@:
    add ax, dx
    loop @b
   add ax, bx

   pop cx
   pop bx
   pop dx
  ret

printString: ;params -> si pointer string,di -> initial position, ah -> color
   pusha
    startPrintMsg:
      mov al , [si]
      cmp al , 0
      je exitPrintMsg
      mov [es:di], ax
      inc si
      add di, 2
      jmp startPrintMsg
    exitPrintMsg:
   popa
   ret
