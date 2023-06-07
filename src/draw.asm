printBackground:
  mov di, 0             ; screen position
  mov ax , 0808h        ; pixel color  gris
  mov ecx ,  (320 * 200 + 320 ) / 2
  backGroundLoop :
    mov [es:di], ax
    add di, 2
    loop backGroundLoop
  ret

drawSquare20x20:  ;; parametros en ax -> posicion , dl -> color
  pusha
  mov cx , 400d              ; counter 100px  20x20 square
  xor edi, edi
  mov di , ax
  xor ax,ax

  @@ :
    cmp cx , 400d
    je pintar20x20

    mov ax , cx
    mov bl , 20d
    div bl

    cmp ah, 0
    je  aumentarFila20x20        ; aumentar fila cada 10 vueltas
    jmp pintar20x20

    aumentarFila20x20:
      add di , 320 - 20
      jmp pintar20x20

    pintar20x20 :
      mov al, dl              ; pixel color
      mov [es:di], al
      inc di
      loop @b
  popa
  ret

drawSquare10x10: ;; parametros en ax -> posicion , dl -> color
  pusha
  mov cx , 100d              ; counter 100px  10x10 square
  xor edi, edi
  mov di , ax
  xor ax,ax

  @@ :
    cmp cx , 100d
    je pintar10x10

    mov ax , cx
    mov bl , 10d
    div bl

    cmp ah, 0
    je  aumentarFila10x10      ; aumentar fila cada 10 vueltas
    jmp pintar10x10

    aumentarFila10x10:
      add di , 320 - 10
      jmp pintar10x10

    pintar10x10:
      mov al, dl           ; pixel color
      mov [es:di], al
      inc di
      loop @b
  popa
  ret

drawSquare5x5: ;; parametros en ax -> posicion , dl -> color
  pusha
  mov cx , 25              ; counter 100px  10x10 square
  xor edi, edi
  mov di , ax
  xor ax,ax

  @@ :
    cmp cx , 25
    je pintar5x5

    mov ax , cx
    mov bl , 5
    div bl

    cmp ah, 0
    je  aumentarFila5x5      ; aumentar fila cada 10 vueltas
    jmp pintar5x5

    aumentarFila5x5:
      add di , 320 - 5
      jmp pintar5x5

    pintar5x5:
      mov al, dl           ; pixel color
      mov [es:di], al
      inc di
      loop @b
  popa
  ret

