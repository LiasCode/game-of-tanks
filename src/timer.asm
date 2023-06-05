timer: 
  pusha
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
    pop bx
    pop ax
    je printGame

  exitTimer:
    mov al, 20h
    out 20h, al
  popa
  iret

printGame:
  call printBackground
  call drawTank1
  call drawTank2
  call calculateBullet1Pos
  call drawBullet1
  call calculateBullet2Pos
  call drawBullet2
  call printHearts
  jmp exitTimer

calculateCollisionBullet1:
  pusha

  popa
  ret

calculateBullet1Pos:
  pusha
    cmp [tank1BalaActiveDirPos], 0
    je  exitCalculateBullet1Pos
    cmp [tank1BalaActiveDirPos], 1
    je  moveBulletToUp
    cmp [tank1BalaActiveDirPos], 2
    je  moveBulletToRight
    cmp [tank1BalaActiveDirPos], 3
    je  moveBulletToDown
    cmp [tank1BalaActiveDirPos], 4
    je  moveBulletToLeft
  
    moveBulletToUp:
      call incPosBala1Up
      jmp incBulletPosTime
    moveBulletToRight:
      call incPosBala1Right
      jmp incBulletPosTime
    moveBulletToDown:
      call incPosBala1Down
      jmp incBulletPosTime
    moveBulletToLeft:
      call incPosBala1Left
      jmp incBulletPosTime

    incBulletPosTime:
      mov al , [tank1BalaActiveTime]
      inc al
      cmp al , 18
      je resetBullet
      mov [tank1BalaActiveTime], al
      jmp exitCalculateBullet1Pos

    resetBullet:
      mov al , 0
      mov [tank1BalaActiveDirPos], al
      mov [tank1BalaActiveTime],  al
      jmp exitCalculateBullet1Pos

  exitCalculateBullet1Pos:
  popa
  ret
  
calculateBullet2Pos:
  pusha
    cmp [tank2BalaActiveDirPos], 0
    je  exitCalculateBullet2Pos
    cmp [tank2BalaActiveDirPos], 1
    je  moveBullet2ToUp
    cmp [tank2BalaActiveDirPos], 2
    je  moveBullet2ToRight
    cmp [tank2BalaActiveDirPos], 3
    je  moveBullet2ToDown
    cmp [tank2BalaActiveDirPos], 4
    je  moveBullet2ToLeft
  
    moveBullet2ToUp:
      call incPosBala2Up
      jmp incBullet2PosTime
    moveBullet2ToRight:
      call incPosBala2Right
      jmp incBullet2PosTime
    moveBullet2ToDown:
      call incPosBala2Down
      jmp incBullet2PosTime
    moveBullet2ToLeft:
      call incPosBala2Left
      jmp incBullet2PosTime

    incBullet2PosTime:
      mov al , [tank2BalaActiveTime]
      inc al
      cmp al , 18
      je resetBullet2
      mov [tank2BalaActiveTime], al
      jmp exitCalculateBullet2Pos

    resetBullet2:
      mov al , 0
      mov [tank2BalaActiveDirPos], al
      mov [tank2BalaActiveTime],  al
      jmp exitCalculateBullet2Pos

  exitCalculateBullet2Pos:
  popa
  ret
  
printHearts:
  pusha
    xor cx,cx
    mov cl , [tank1Hearts]
    mov ax , 0
    @@:
      mov dl , [tank1Color]
      call drawSquare5x5
      add ax , 10
      loop @b

    mov cl , [tank2Hearts]
    mov ax , 315
    @@:
      mov dl , [tank2Color]
      call drawSquare5x5
      sub ax , 10
      loop @b
  popa
  
