drawTank1ToDown :
  pusha
    mov  ax,[tank1Pos]      ;; position
    call drawSquare20x20
    add ax , 320 * 20 + 5
    call drawSquare10x10
    sub ax , 320 * 20 + 5
  popa
  ret

drawTank1ToUp:
  pusha
    mov  ax,[tank1Pos]      ;; position
    call drawSquare20x20
    sub ax , 10 * 320 - 5
    call drawSquare10x10
    add ax , 10 * 320 - 5
  popa
  ret

drawTank1ToRight:
  pusha
    mov ax, [tank1Pos]
    call drawSquare20x20
    add  ax , 20 * 1 + 5 * 320
    call drawSquare10x10
    sub ax , 20 * 1 + 5 * 320
  popa
  ret

drawTank1ToLeft:
  pusha
    mov  ax,[tank1Pos]      ;; position
    call drawSquare20x20
    sub ax , 1 * 10  - 5 * 320
    call drawSquare10x10
    add ax , 1 * 10 - 5 * 320
  popa
  ret
