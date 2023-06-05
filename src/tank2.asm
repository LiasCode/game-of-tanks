drawTank2:
  pusha
    mov al, [tank2LastDir]

    ;;; Compara con la ultima posicion para eligir en que direccion pintar el tanque
    cmp al , 1
    je call2DrawUp
    cmp al , 2
    je call2DrawRight
    cmp al , 3
    je call2DrawDown
    cmp al , 4
    je call2DrawLeft

    call2DrawUp: 
      call drawTank2ToUp
      jmp drawTank2Return
    call2DrawRight: 
      call drawTank2ToRight
      jmp drawTank2Return
    call2DrawDown: 
      call drawTank2ToDown
      jmp drawTank2Return
    call2DrawLeft: 
      call drawTank2ToLeft
      jmp drawTank2Return

  drawTank2Return:
  popa
  ret

drawTank2ToUp:
  pusha
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    call drawSquare20x20

    ;; Canon
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    sub ax , 10 * 320 - 8
    call drawSquare5x5
    ;; Canon
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    sub ax , 5 * 320 - 8
    call drawSquare5x5
    ;; Cabain Tank
    mov  ax,[tank2Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

drawTank2ToRight:
  pusha
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    call drawSquare20x20
    ;; Canon
    mov ax, [tank2Pos]
    mov  dl, [tank2Color]             ;; color
    add  ax , 20 * 1 + 7 * 320
    call drawSquare5x5
    ;; Canon
    mov ax, [tank2Pos]
    mov  dl, [tank2Color]             ;; color
    add  ax , 25 * 1 + 7 * 320
    call drawSquare5x5
    ;; Cabain Tank
    mov  ax,[tank2Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

drawTank2ToDown:
  pusha
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    call drawSquare20x20
    ;; Canon
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    add  ax , 20 * 320 + 8
    call drawSquare5x5
    ;; Canon
    mov  ax,[tank2Pos]      ;; position
    mov  dl, [tank2Color]             ;; color
    add ax , 25 * 320 + 8
    call drawSquare5x5
    ;; Cabain Tank
    mov  ax,[tank2Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

drawTank2ToLeft:
  pusha
    mov  ax,[tank2Pos]      ;; position
    mov  dl,[tank2Color]             ;; color
    call drawSquare20x20
    ;; Canon
    mov ax, [tank2Pos]
    mov  dl, [tank2Color]             ;; color
    add  ax , 7 * 320
    sub  ax , 5
    call drawSquare5x5
    ;; Canon
    mov ax, [tank2Pos]
    mov  dl, [tank2Color]             ;; color
    add  ax , 7 * 320
    sub  ax , 10
    call drawSquare5x5
    ;; Cabain Tank
    mov  ax,[tank2Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

;; Tank 2 Position Movement
incPosTank2Right:
  pusha
    mov ax, [tank2Pos]
    add ax , 1 * 20     ;; increment possition
    mov [tank2Pos], ax
  popa
  ret

incPosTank2Left:
  pusha
    mov ax, [tank2Pos]
    sub ax , 1 * 20     ;; increment possition
    mov [tank2Pos] , ax
  popa
  ret

incPosTank2Up:
  pusha
    mov ax, [tank2Pos]
    sub ax , (320 * 20)     ;; increment possition
    mov [tank2Pos] , ax
  popa
  ret

incPosTank2Down:
  pusha
    mov ax, [tank2Pos]
    add ax , (320 * 20)     ;; increment possition
    mov [tank2Pos] , ax
  popa
  ret
