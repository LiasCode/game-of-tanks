timer:
  cli

  inc [gameTickTimer]
  mov al , [gameTickTimer]
  cmp al , 18
  jne continueTimer

  ;; Reset Timer to 0
  mov al, 0
  mov [gameTickTimer] , al

  continueTimer:
    push ax
    push bx
      xor ax,ax
      mov al, [gameTickTimer]
      mov bl , 1
      div bl
      cmp ah , 0
      jne exitTimer
      call gameLoop
    pop bx
    pop ax

  exitTimer:
    mov al, 20h
    out 20h, al
  iret

gameLoop:
    call printBackground
    call printHearts

    call drawTank1
    call drawTank2

    call drawBulletTank1
    call drawBulletTank2

    call calculateCollisionBullet1
    call calculateCollisionBullet2
  ret

calculateCollisionBullet1:
  pusha
    mov al , [tank1BalaActiveTime]
    cmp al, 0
    je exitCalculateCollisionBullet1

    mov ax , [tank2PosX]
    mov bx , [tank1BalaPosX]
    mov cx , [tank2PosY]
    mov dx , [tank1BalaPosY]

    add bx, 5
    add dx, 5

    cmp bx, ax
    jl exitCalculateCollisionBullet1
    add ax, 20
    cmp bx , ax
    ja exitCalculateCollisionBullet1

    cmp dx, cx
    jl exitCalculateCollisionBullet1
    add cx, 20
    cmp dx , cx
    ja exitCalculateCollisionBullet1

    isColliding1:
      mov al, [tank2Hearts]
      cmp al, 1
      jne subHeartTank2
      mov [gameWinner] , 1
      call printEndGame
      call resetGameState
      jmp exitCalculateCollisionBullet1

      subHeartTank2:
        sub al,1
        mov [tank2Hearts], al

      continueIsColliding:
        mov [tank1LastDir], 2
        mov [tank1PosX], 20
        mov [tank1PosY], 20
        mov [tank1BalaActiveTime], 0
        mov [tank1BalaActiveDirPos], 0
        mov [tank1BalaPosX], 0
        mov [tank1BalaPosY], 0

        mov [tank2LastDir], 4
        mov [tank2PosX], 280
        mov [tank2PosY], 160
        mov [tank2BalaActiveTime], 0
        mov [tank2BalaActiveDirPos], 0
        mov [tank2BalaPosX], 0
        mov [tank2BalaPosY], 0
  exitCalculateCollisionBullet1:
  popa
  ret

calculateCollisionBullet2:
  pusha
    mov al , [tank2BalaActiveTime]
    cmp al, 0
    je exitCalculateCollisionBullet2

    mov ax , [tank1PosX]
    mov bx , [tank2BalaPosX]
    mov cx , [tank1PosY]
    mov dx , [tank2BalaPosY]

    add bx, 5
    add dx, 5

    cmp bx, ax
    jl exitCalculateCollisionBullet2
    add ax, 20
    cmp bx , ax
    ja exitCalculateCollisionBullet2

    cmp dx, cx
    jl exitCalculateCollisionBullet2
    add cx, 20
    cmp dx , cx
    ja exitCalculateCollisionBullet2

    isColliding2:
      mov al, [tank1Hearts]
      cmp al, 1
      jne subHeartTank1
      mov [gameWinner] , 2
      call printEndGame
      call resetGameState
      jmp exitCalculateCollisionBullet2

      subHeartTank1:
        sub al,1
        mov [tank1Hearts], al

      continueIsColliding2:
        mov [tank1LastDir], 2
        mov [tank1PosX], 20
        mov [tank1PosY], 20
        mov [tank1BalaActiveTime], 0
        mov [tank1BalaActiveDirPos], 0
        mov [tank1BalaPosX], 0
        mov [tank1BalaPosY], 0

        mov [tank2LastDir], 4
        mov [tank2PosX], 280
        mov [tank2PosY], 160
        mov [tank2BalaActiveTime], 0
        mov [tank2BalaActiveDirPos], 0
        mov [tank2BalaPosX], 0
        mov [tank2BalaPosY], 0
  exitCalculateCollisionBullet2:
  popa
  ret

printHearts:
  pusha
    xor cx,cx
    mov cl , [tank1Hearts]
    mov ax , 320 * 3 + 5
    @@:
      mov dl , [tank1Color]
      call drawSquare5x5
      add ax , 10
      loop @b

    mov cl , [tank2Hearts]
    mov ax , 315
    mov ax , 320 * 3 + 311
    @@:
      mov dl , [tank2Color]
      call drawSquare5x5
      sub ax , 10
      loop @b
  popa
  ret

printEndGame:
  pusha
    cli
    ;;;;;;;;;;;; Text Mode initialization
    xor eax, eax
    mov ax, 03h
    int 10h
    mov ax, 0xB800
    mov es, ax

    mov al , [gameWinner]
    cmp al, 1
    je loadMsgGreen
    cmp al, 2
    je loadMsgRed

    mov si , errorMsg
    jmp printMsg

    loadMsgGreen:
      mov si , endGameWinGreenMsg
      jmp printMsg
    loadMsgRed:
      mov si , endGameWinRedMsg
      jmp printMsg

    printMsg:
      ;; Print Msg
      mov di , 160 * 10 + 2 * 10 ; msg start position
      cmp [gameWinner],1
      je loadColorGreen
      loadColorRed:
        mov ah, 00001100b
        jmp executePrintMsg
      loadColorGreen:
        mov ah, 00001010b
      executePrintMsg:
      call printString

    @@:
      in al , 60h
      cmp al , [keyEnter]
      je continueEndGame
      jmp @b

    continueEndGame:

    ;;;;;;;;;;;; Graphic Mode restore
    xor eax, eax
    mov ax, 13h
    int 10h
    mov ax, 0A000h
    mov es, ax
    sti
  popa
  ret

printStartGameScreen:
  pusha
    ;;;;;;;;;;;; Text Mode initialization
    xor eax, eax
    mov ax, 03h
    int 10h
    mov ax, 0xB800
    mov es, ax

    mov si , startGameMsgTitle
    mov di , 160 * 10 + 2 * 26 ; msg start position
    mov ah, 00001111b
    call printString

    mov si , startGameMsgTutorialKeys
    mov di , 160 * 12 + 2 * 10 ; msg start position
    mov ah, 00001011b
    call printString

    mov si , startGameMsgTutorialPayerGreen
    mov di , 160 * 14 + 2 * 10 ; msg start position
    mov ah, 00001010b
    call printString

    mov si , startGameMsgTutorialPayerRed
    mov di , 160 * 16 + 2 * 10 ; msg start position
    mov ah, 00001100b
    call printString

    mov si , startGameMsgPressEnter
    mov di , 160 * 18 + 2 * 18 ; msg start position
    mov ah, 00001101b
    call printString

    @@:
      in al , 60h
      cmp al , [keyEnter]
      je continueStarGame
      jmp @b

    continueStarGame:
    ;;;;;;;;;;;; Graphic Mode restore
    xor eax, eax
    mov ax, 13h
    int 10h
    mov ax, 0A000h
    mov es, ax
  popa
  ret

resetGameState:
  pusha
    mov [tank1LastDir], 2
    mov [tank1Hearts], 3
    mov [tank1PosX], 20
    mov [tank1PosY], 20
    mov [tank1BalaActiveTime], 0
    mov [tank1BalaActiveDirPos], 0
    mov [tank1BalaPosX], 0
    mov [tank1BalaPosY], 0

    mov [tank2LastDir], 4
    mov [tank2Hearts], 3
    mov [tank2PosX], 280
    mov [tank2PosY], 160
    mov [tank2BalaActiveTime], 0
    mov [tank2BalaActiveDirPos], 0
    mov [tank2BalaPosX], 0
    mov [tank2BalaPosY], 0
  popa
  ret
