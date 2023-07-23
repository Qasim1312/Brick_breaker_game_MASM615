Blocks struct
xs dw ?
ys dw ?
xe dw ?
ye dw ?
Colors db ?
changecol db ?
Blocks ends

.model small
.stack 1000h
.data

   bloc Blocks 36 dup(<>)

   windowidth dw 320
   widowheight dw 200
   y word 1
   x word 1
   y1 word 25 ;149 xaxis right 13
   y2 word 32
   x1 word 15 ;89 y axis down
   count1 db 0
   incre db 0
   random word 0
   colur db 1,4,4,2,2,1,1 ;------------colour
   ;insert
   paddleY dw 105
   paddleX dw 175
   ballX dw 150  ;lin
   ballY dw 150 ;col
   ballvelocityY dw 3
   ballvelocityX dw 3
   ballvelocityY2 dw 4
   ballvelocityX2 dw 4
   ballvelocityY3 dw 5
   ballvelocityX3 dw 5
   timetemp db 0 ;for ball movement
   ;------Paddle
   counter db 0
   x_start dw 100  ;col
   x_end dw 170    
   y_start dw 170  ;row
   y_end dw 180
   movement_counter dw 0
   boolstage2 db 0
   boolstage3 db 0
   colorcounter dw 0
   movement_counter_left db 0
   movement_counter_right db 0   
   menu_item1 db 'NEW GAME','$'
    menu_item2 db 'LEVELS','$'
    menu_item3 db 'INSTRUCTIONS','$'
    menu_item4 db 'HIGHSCORES','$'
    menu_item5 db 'QUIT','$'
    row_selector db 5         ;initializing with 5 bcz first item of main menu is at 5
    input_checker db 1
        start_msg      db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ========= BRICK BREAKER ========" 
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ============== BY =============="
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ======== MUSADDIQ ASHFAQ =======" 
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ============== AND ============="
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ========= QASIM HUSSAIN ========$"
              db  0ah,0dh,"                  ================================"
        end_msg        db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ========== THANKS FOR  =========" 
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  =========== PLAYING ============"
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ======== BRICK BREAKER =========" 
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ================================",'$'
        winner_msg        db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  =========== YOU WON ============"
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ================================",'$'
        loser_msg        db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  =========== YOU LOSE ============"
              db  0ah,0dh,"                  ================================"
              db  0ah,0dh,"                  ================================",'$'
        high_scores_msg db "HIGHSCORES",'$'
        level1_msg db "LEVEL1",'$'
        level2_msg db "LEVEL2",'$'
        level3_msg db "LEVEL3",'$'
        level_input_checker db 1
        how_to_play_msg db  0ah,0dh,"                  ==================================="
              db  0ah,0dh,"                  === Use Arrow Keys to move bar ===" 
              db  0ah,0dh,"                  =================================="
              db  0ah,0dh,"                  ============== AND ==============="
              db  0ah,0dh,"                  =================================="
              db  0ah,0dh,"                  ====== try to eliminate ==========" 
              db  0ah,0dh,"                  =================================="
              db  0ah,0dh,"                  ====== all bricks in time ========" 
              db  0ah,0dh,"                  ==================================",'$'
              username byte 8 DUP(' ')
              enter_name_msg byte "ENTER YOUR NAME "
                             byte "UPTO 8 LETTERS:",'$'
	;-------------------------------------------------------------------short paddle
	scounter db 0
    sx_start dw 120  ;col
    sx_end dw 170    
    sy_start dw 170  ;row
    sy_end dw 180
    smovement_counter dw 0
    scolorcounter dw 0
    smovement_counter_left db 0
    smovement_counter_right db 0
    score_counter dw 0
    sound dw 3416
    score_display_counter dw 0
    score_msg db "Score:",'$'
    file db "myfilee.txt",0
    buffer db 100 dup(' ')
    handle dw 0
    level byte 2 dup ('0')
    score byte 3 dup ('0')
    life_x_axis dw 24
    temp_life_x_axis dw 0
    life_y_axis dw 185
    temp_life_y_axis dw 0
	hearts dw 3
    name1 db "mu",'$'
    name2 db "qasim",'$'
    name3 db "player",'$'
    name4 db "musaddiq",'$'
    name5 db "abc",'$'
    hs db "216",'$'
    level_msg db "Level:",'$'
    current_level db "1",'$'
	permanentbrickaddress dw 0
.code
mov ax,@data
mov ds,ax

   push_all macro
      push ax
      push bx
      push cx
      push dx
   endm

   pop_all macro
      pop dx
      pop cx
      pop bx
      pop ax
   endm

   mymacro macro 
      mov ah,0ch
      mov al,15
      mov bl,1
      int 10h      
   endm

main proc
   mov ah,00h
   mov al,13h
   int 10h

   call input_name
   call welcome
   call write_names
   call main_menu
   call setup1
   

   mov ah,4ch
   int 21h
   ret
main endp


;---------------------------------------------------setup proc------------------------------------
setup1 proc
;-------------------------------------------------The white outline-------------------------------
    mov hearts,3
    mov score_counter,0
    mov ah,00h
    mov al,13h
    int 10h
mov cx,317  
l1:
   push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   inc y
   pop cx
   loop l1
mov cx,197
l2:
    push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   inc x
   
   pop cx

loop l2
mov cx,317
l3:
  push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   dec y
   pop cx
   


loop l3
mov cx,197
l4:
  push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   dec x
   pop cx


loop l4
 
;------------------------------------------------------------------------------------------------------------------------------NOW-the--blocks----------------------------------------------------------------
mov cx,6
mov ax,y2
mov bx,x1
mov di,offset bloc
construct1:
;------------------------------------------------------------------------------------- COLOR OF TILES-----------------------
    push bx
	 mov si,cx
    push cx
    mov cx,6
        construct2:
        push cx
        push ax
        push bx
        mov ax,0
        mov bx,0
        
        ;mov si,cx
        mov al,colur[si]
        mov [di+8],al
		mov al,1
		mov [di+9],al
        ; ;colur 
        ;-------------------------------------------------------------------------------------
        pop bx
        pop ax
        
        push ax     
        push bx

        mov [di+0],bx           ; xs
        mov [di+4],bx           ; xe
        add word ptr[di+4],40
        mov [di+2],ax           ; ys
        mov [di+6],ax           ; ye
        add word ptr[di+6],10
        mov ax,[di+2]          ;y axis
        mov bx, [di]            ;x axis
        mov cx,10
        l11:
            push bx         ; x coord
            push ax
            push cx         ;height
            mov cx,40   ;50     ; width
            l21:
                push cx         ;widht
                mov dx,ax
                push ax
                mov ah,0ch
                mov al,[di+8]
                mov cx,bx
                int 10h
                pop ax
                inc bx      ; x-axis
                pop cx
                loop l21
            pop cx
            pop ax
            inc ax
            pop bx 
        loop l11
        pop bx
        pop ax
        
            
        add bx,45 
        pop cx

        add di,sizeof Blocks
        loop construct2

   
    add ax,15 	
    pop cx
    pop bx
 loop construct1
 







 constructout:
 
 

;------------------------------------------------------------------------------------------THE FUNCTIONS----------------------------------------
 
checktime:
mov ah,2ch
int 21h
cmp dl,timetemp
je checktime
mov timetemp,dl

 call clearball
 call ballmoves
 call collision
 cmp boolstage2,36
 je exit
 call paddlecollision
 call drawball
 call drawPaddle
 call draw_heart
 cmp hearts,0
 je exit
call display_user_name
call display_level_in_gameplay
call score_display
    mov al,0
    mov ah,1
    int 16h
    jz checktime
    mov al,0
    mov ah,0
    int 16h
    cmp al,'e'
    je exit
jmp checktime
exit:
sub boolstage2,36
mov si,1
mov level[si],'1'
mov score[si],'3'
mov si,2
mov score[si],'6'
call write_levels
call write_score
mov current_level,"2"
call display_level_in_gameplay
call setup2
ret
setup1 endp



;------------------------LEVEL 2-----------------------------------------------------------------------------------------------------
setup2 proc
;-------------------------------------------------The white outline-------------------------------
   mov ah,00h
   mov al,13h
   int 10h
mov cx,317  
l1:
   push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   inc y
   pop cx
   loop l1
mov cx,197
l2:
    push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   inc x
   
   pop cx

loop l2
mov cx,317
l3:
  push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   dec y
   pop cx


loop l3
mov cx,197
l4:
  push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   dec x
   pop cx


loop l4
 
;------------------------------------------------------------------------------------------------------------------------------NOW-the--blocks----------------------------------------------------------------
mov cx,6
mov ax,y1
mov bx,x1
mov di,offset bloc
construct1:
;------------------------------------------------------------------------------------- COLOR OF TILES-----------------------
    push bx
	 mov si,cx
    push cx
    mov cx,6
        construct2:
        push cx
        push ax
        push bx
        mov ax,0
        mov bx,0
        
        ;mov si,cx
        mov al,colur[si]
        mov [di+8],al
		mov al,1
		mov [di+9],al
        ; ;colur 
        ;-------------------------------------------------------------------------------------
        pop bx
        pop ax
        
        push ax     
        push bx

        mov [di+0],bx           ; xs
        mov [di+4],bx           ; xe
        add word ptr[di+4],40
        mov [di+2],ax           ; ys
        mov [di+6],ax           ; ye
        add word ptr[di+6],10
        mov ax,[di+2]          ;y axis
        mov bx, [di]            ;x axis
        mov cx,10
        l11:
            push bx         ; x coord
            push ax
            push cx         ;height
            mov cx,40   ;50     ; width
            l21:
                push cx         ;widht
                mov dx,ax
                push ax
                mov ah,0ch
                mov al,[di+8]
                mov cx,bx
                int 10h
                pop ax
                inc bx      ; x-axis
                pop cx
                loop l21
            pop cx
            pop ax
            inc ax
            pop bx 
        loop l11
        pop bx
        pop ax
        
            
        add bx,45 
        pop cx

        add di,sizeof Blocks
        loop construct2

   
    add ax,15 	
    pop cx
    pop bx
 loop construct1
 







 constructout:
 
 

;------------------------------------------------------------------------------------------THE FUNCTIONS----------------------------------------
        mov cx,x_start
		mov dx,y_start
		mov counter,1
		outer:
		horizontal:
		mov ah,0ch
		mov al,0 ;color of bar
		int 10H
		inc cx
		cmp cx,x_end
		jb horizontal
		inc counter
		cmp counter,10  ;for height
		mov cx,x_start
		inc dx
		jb outer
		
	    mov x_start, 100  ;col
		mov x_end,170    
		mov y_start, 170  ;row
		mov y_end,180
		mov ballX,150  ;lin
        mov ballY, 150 ;col
 
checktime:
mov ah,2ch
int 21h
cmp dl,timetemp
je checktime
mov timetemp,dl

 call clearball
 call ballmoves2
 call collision2
 cmp  boolstage2,72
 je exit
 call short_paddlecollision
 call drawball
 call draw_short_paddle
 call draw_heart
 cmp hearts,0
 je exit
 call display_user_name
call display_level_in_gameplay
    mov al,0
    mov ah,1
    int 16h
    jz checktime
    mov al,0
    mov ah,0
    int 16h
    cmp al,'e'
    je exit
jmp checktime
exit:
sub boolstage2,72
mov si,1
mov level[si],'2'
mov si,0
mov level[si],'1'
mov si,1
mov score[si],'0'
mov si,2
mov score[si],'8'
call write_levels
call write_score
mov current_level,"3"
call display_level_in_gameplay
call setup3
ret
setup2 endp
;--------------------------------------------------------------------------LEVEL 3------------------------------------------------------------------

setup3 proc
;-------------------------------------------------The white outline-------------------------------
   mov ah,00h
   mov al,13h
   int 10h
mov cx,317  
l1:
   push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   inc y
   pop cx
   loop l1
mov cx,197
l2:
    push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   inc x
   
   pop cx

loop l2
mov cx,317
l3:
  push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   dec y
   pop cx


loop l3
mov cx,197
l4:
  push cx
   mov ah,0ch
   mov al,15
   mov cx,y
   mov dx,x
   int 10h
   dec x
   pop cx


loop l4
 
;------------------------------------------------------------------------------------------------------------------------------NOW-the--blocks----------------------------------------------------------------
mov cx,6
mov ax,y1
mov bx,x1
mov di,offset bloc
construct1:
;------------------------------------------------------------------------------------- COLOR OF TILES-----------------------
    push bx
	 mov si,cx
    push cx
    mov cx,6
        construct2:
        push cx
        push ax
        push bx
        mov ax,0
        mov bx,0
        
        ;mov si,cx
        mov al,colur[si]
        mov [di+8],al
		cmp permanentbrickaddress,di
		jne jover
		mov byte ptr[di+8] ,7h
		jover:
		mov al,1
		mov [di+9],al
        ; ;colur 
        ;-------------------------------------------------------------------------------------
        pop bx
        pop ax
        
        push ax     
        push bx

        mov [di+0],bx           ; xs
        mov [di+4],bx           ; xe
        add word ptr[di+4],40
        mov [di+2],ax           ; ys
        mov [di+6],ax           ; ye
        add word ptr[di+6],10
        mov ax,[di+2]          ;y axis
        mov bx, [di]            ;x axis
        mov cx,10
        l11:
            push bx         ; x coord
            push ax
            push cx         ;height
            mov cx,40   ;50     ; width
            l21:
                push cx         ;widht
                mov dx,ax
                push ax
                mov ah,0ch
                mov al,[di+8]
                mov cx,bx
                int 10h
                pop ax
                inc bx      ; x-axis
                pop cx
                loop l21
            pop cx
            pop ax
            inc ax
            pop bx 
        loop l11
        pop bx
        pop ax
        
            
        add bx,45 
        pop cx

        add di,sizeof Blocks
        loop construct2

   
    add ax,15 	
    pop cx
    pop bx
	cmp cx,2
	jne permanent
	mov permanentbrickaddress,di
	
	permanent: 
 loop construct1
 







 constructout:
 
 

;------------------------------------------------------------------------------------------THE FUNCTIONS----------------------------------------
        mov cx,x_start
		mov dx,y_start
		mov counter,1
		outer:
		horizontal:
		mov ah,0ch
		mov al,0 ;color of bar
		int 10H
		inc cx
		cmp cx,x_end
		jb horizontal
		inc counter
		cmp counter,10  ;for height
		mov cx,x_start
		inc dx
		jb outer
		
	    mov x_start, 100  ;col
		mov x_end,170    
		mov y_start, 170  ;row
		mov y_end,180
		mov ballX,150  ;lin
        mov ballY, 150 ;col
 
checktime:
mov ah,2ch
int 21h
cmp dl,timetemp
je checktime
mov timetemp,dl

 call clearball
 call ballmoves2
 call collision3
 cmp  boolstage2,105
 je exit
 ;call paddlecollision
 call short_paddlecollision
 call drawball
 ;call drawPaddle
 call draw_short_paddle
 call draw_heart
 cmp hearts,0
 je exit
 call display_user_name
  call display_level_in_gameplay
    mov al,0
    mov ah,1
    int 16h
    jz checktime
    mov al,0
    mov ah,0
    int 16h
    cmp al,'e'
    je exit
jmp checktime
exit:
sub boolstage2,105
mov si,1
mov level[si],'3'
call write_levels
mov si,0
mov score[si],'2'
mov si,1
mov score[si],'1'
mov si,2
mov score[si],'6'
call write_score
call winner
ret
setup3 endp

;--------------------------------------------------------------BALL---------------------------------
ballmoves proc

mov ax,ballvelocityX ;mov vertically
add ballX,ax
mov ax,ballvelocityY  ;move horizontally and also check for collisions
add ballY,ax

    cmp ballX,13h
    ja BMskip1
        neg ballvelocityX
    BMskip1:
    cmp ballX,305
    jb BMskip2
        neg ballvelocityX
    BMskip2:
    cmp ballY,08h
    ja BMskip3
        neg ballvelocityY
    BMskip3:
    cmp ballY,185
    jb BMskip4
	    ;--------------------------------make the previous paddle black
		mov cx,x_start
		mov dx,y_start
		mov counter,1
		outer:
		horizontal:
		mov ah,0ch
		mov al,0 ;color of bar
		int 10H
		inc cx
		cmp cx,x_end
		jb horizontal
		inc counter
		cmp counter,10  ;for height
		mov cx,x_start
		inc dx
		jb outer
		
	    mov x_start, 100  ;col
		mov x_end,170    
		mov y_start, 170  ;row
		mov y_end,180
		mov ballX,150  ;lin
        mov ballY, 150 ;col
		dec hearts
		call remove_Life
		sub life_x_axis,8
        ;neg ballvelocityY
		
    BMskip4:
ret
;------------------------------------------------------------------------------------------------------------

ballmoves endp


ballmoves2 proc

mov ax,ballvelocityX ;mov vertically
add ballX,ax
mov ax,ballvelocityY  ;move horizontally and also check for collisions
add ballY,ax

    cmp ballX,13h
    ja BMskip1
        neg ballvelocityX
    BMskip1:
    cmp ballX,305
    jb BMskip2
        neg ballvelocityX
    BMskip2:
    cmp ballY,08h
    ja BMskip3
        neg ballvelocityY
    BMskip3:
    cmp ballY,185
    jb BMskip4
	    ;--------------------------------make the previous paddle black
	  mov cx,sx_start
      mov dx,sy_start
      mov scounter,1
		   souter:
			  shorizontal:
			  mov ah,0ch
			  mov al,0 ;color of bar
			  int 10H
			  inc cx
			  cmp cx,sx_end
			  jb shorizontal
			  inc scounter
			  cmp scounter,10  ;for height
			  mov cx,sx_start
			  inc dx
			  jb souter
				
	    mov sx_start, 110  ;col
		mov sx_end, 160    
		mov sy_start, 170  ;row
		mov sy_end, 180
		dec hearts
		call remove_Life
		sub life_x_axis,8
		mov ballX,150  ;lin
        mov ballY, 150 ;col
        ;neg ballvelocityY
		
    BMskip4:
ret
;------------------------------------------------------------------------------------------------------------

ballmoves2 endp





ballmoves3 proc

mov ax,ballvelocityX3 ;mov vertically
add ballX,ax
mov ax,ballvelocityY3  ;move horizontally and also check for collisions
add ballY,ax

    cmp ballX,13h
    ja BMskip1
        neg ballvelocityX3
    BMskip1:
    cmp ballX,305
    jb BMskip2
        neg ballvelocityX3
    BMskip2:
    cmp ballY,08h
    ja BMskip3
        neg ballvelocityY3
    BMskip3:
    cmp ballY,185
    jb BMskip4
	    ;--------------------------------make the previous paddle black
	  mov cx,sx_start
      mov dx,sy_start
      mov scounter,1
		   souter:
			  shorizontal:
			  mov ah,0ch
			  mov al,0 ;color of bar
			  int 10H
			  inc cx
			  cmp cx,sx_end
			  jb shorizontal
			  inc scounter
			  cmp scounter,10  ;for height
			  mov cx,sx_start
			  inc dx
			  jb souter
				
	    mov sx_start, 110  ;col
		mov sx_end, 160    
		mov sy_start, 170  ;row
		mov sy_end, 180
		dec hearts
		call remove_Life
		sub life_x_axis,8
		mov ballX,150  ;lin
        mov ballY, 150 ;col
        ;neg ballvelocityY
		
    BMskip4:
ret
;------------------------------------------------------------------------------------------------------------

ballmoves3 endp



;----------------------------------------------------------------------------------------------
clearball proc
pop si
mov cx,9
mov ax,ballX
push ax
l7:
   mov bx,ballY
    push bx
    push cx
    mov cx,10
   l8:
   push cx
   mov ah,0ch
   mov al,0
   mov cx,ballX
   mov dx,ballY
   int 10h
   inc ballY
   pop cx
   loop l8
   pop cx
   dec ballX
   pop bx 
   mov ballY,bx
   
 loop l7
 pop ax
 mov ballX,ax
push si
ret
clearball endp


;---------------------------------------------------------------------------------------
drawball proc
pop si
mov cx,9
mov ax,ballX
push ax
l7:
   mov bx,ballY
    push bx
    push cx
    mov cx,10
   l8:
   push cx
   mov ah,0ch
   mov al,14
   mov cx,ballX
   mov dx,ballY
   int 10h
   inc ballY
   pop cx
   loop l8
   pop cx
   dec ballX
   pop bx 
   mov ballY,bx
   
 loop l7
 pop ax
 mov ballX,ax
push si
ret
drawball endp

;-----------------------------------------------Drawing Paddle
drawPaddle proc
   start:
    mov cx,x_start
    mov dx,y_start
    mov counter,1
outer:
    horizontal:
    mov ah,0ch
    mov al,13 ;color of bar
    int 10H
    inc cx
    cmp cx,x_end
    jb horizontal
    inc counter
    cmp counter,10  ;for height
    mov cx,x_start
    inc dx
    jb outer

      mov al,0    ;keys input for movement
      mov ah,1
      int 16h
      jz exiting
      mov ah,0
	   int 16h
      cmp ah,04Bh
         je Left
      cmp ah,04Dh
         je Right

    Left:
            mov movement_counter_left,0
            making_black_left:
            mov cx,x_end
            mov dx,y_start
        remove_on_left:
            mov ah,0ch
            mov al,0
            int 10H
            inc dx
            cmp dx,y_end
            je removed
            jmp remove_on_left
            removed:
                cmp movement_counter_left,7
                je start
            left_remover:
                inc movement_counter_left
                dec x_end
                mov cx,x_end
                mov dx,y_start
            removing_2nd:
                mov ah,0ch
                mov al,0
                int 10H
                inc dx
                cmp dx,y_end
                je left_done
                jmp removing_2nd
                left_done:
                    cmp movement_counter_left,7
                    jne left_remover
                    cmp x_start,10
                    jle left_side_collide
                    sub x_start,8
                    sub x_end,1
         jmp start
         left_side_collide:
         mov x_start,2
         mov x_end,72
         mov y_start,170
         mov y_end,180
         jmp start
    Right:
         mov movement_counter_right,0
         making_black_right:
         mov cx,x_start
         mov dx,y_start
         remove_on_right:
            mov ah,0ch
            mov al,0
            int 10H
            inc dx
            cmp dx,y_end
            je removed1
            jmp remove_on_right
            removed1:
               cmp movement_counter_right,7
               je start
            remove_again:
               add movement_counter_right,1
               inc x_start
               mov cx,x_start
               mov dx,y_start
               removing_2nd_pixel:
                  mov ah,0ch
                  mov al,0
                  int 10H
                  inc dx
                  cmp dx,y_end
                  je right_done
                  jmp removing_2nd_pixel
                  right_done:
                        cmp movement_counter_right,7
                        jne remove_again
                        cmp x_start,247
                        jge right_side_collision
                        add x_start,1
                        add x_end,8
                    jmp start
                    right_side_collision:
                        mov x_start,247
                        mov x_end,318
                        mov y_start,170
                        mov y_end,180
                        jmp start
                  jmp start
            jmp exiting
exiting:
ret 
drawPaddle endp




;--------------------------------------------------------------COLLISON WITH BLOCKS----------------------------------------------------------------------------
collision proc
push ax
push bx
push cx
push dx
push si
push di
        ;     if (rect1.x < rect2.x + rect2.w && ------> ball.x2 - rect.x1 > 0          (i)
        ;     rect1.x + rect1.w > rect2.x &&     ------> rect.x2 - ball.x1 > 0          (ii)
        ;     rect1.y < rect2.y + rect2.h &&     ------> ball.y2 - rect.y1 > 0          (iii)
        ;     rect1.h + rect1.y > rect2.y        ------> rect.y2 - ball.y1 > 0 )        (iv)

    mov cx,36           ;------- number of brick
    mov di,offset bloc
    ColLOOP:
        push cx
        cmp byte ptr[di+8],0
		
        je NEXTITR
        mov ax,ballX
        add ax,10
        sub ax,[di]
        cmp ax,0           
        jle NEXTITR

        mov ax, [di+4] 
        sub ax, ballX
        cmp ax,0           
        jle NEXTITR

        mov ax, ballY
        add ax,10
        sub ax,[di+2]
        cmp ax,0           
        jle NEXTITR


        mov ax, [di+6]
        sub ax, ballY
        cmp ax,0 

        jle NEXTITR
        ;-------------------------------- agr yahan tak aa gya to collission --- fingers crossed<3
            ;add ballvelocityX ,20
            ; mov ax,ballvelocityY
            ; mov bx,-1
            ; mul bx
            ; mov ballvelocityY,ax
            inc boolstage2
            inc score_counter
            call beep
            call score_display
            neg ballvelocityY
            call ballmoves
            mov byte ptr[di+8],0            ; changed color to black
            mov ax,[di+2]          ;y axis
            mov bx, [di]            ;x axis
            mov cx,12 
            l11:
                push bx         ; x coord
                push ax
                push cx         ;height
                mov cx,40   ;50     ; width
                l21:
                    push cx         ;widht
                    mov dx,ax
                    push ax
                    mov ah,0ch
                    mov al,[di+8]
                    mov cx,bx
                    int 10h
                    pop ax
                    inc bx      ; x-axis
                    pop cx
                    loop l21
                pop cx
                pop ax
                inc ax
                pop bx 
            loop l11

        NEXTITR:    

        add di,sizeof Blocks

        pop cx
    loop ColLOOP

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
collision endp

;--------------------------------------level collison 2---------------------------------------------------------------------------
collision2 proc
push ax
push bx
push cx
push dx
push si
push di
        ;     if (rect1.x < rect2.x + rect2.w && ------> ball.x2 - rect.x1 > 0          (i)
        ;     rect1.x + rect1.w > rect2.x &&     ------> rect.x2 - ball.x1 > 0          (ii)
        ;     rect1.y < rect2.y + rect2.h &&     ------> ball.y2 - rect.y1 > 0          (iii)
        ;     rect1.h + rect1.y > rect2.y        ------> rect.y2 - ball.y1 > 0 )        (iv)
    
    mov cx,36           ;------- number of brick
    mov di,offset bloc
    ColLOOP:
        push cx
        cmp byte ptr[di+8],0
        je NEXTITR
        mov ax,ballX
        add ax,10
        sub ax,[di]
        cmp ax,0           
        jle NEXTITR

        mov ax, [di+4] 
        sub ax, ballX
        cmp ax,0           
        jle NEXTITR

        mov ax, ballY
        add ax,10
        sub ax,[di+2]
        cmp ax,0           
        jle NEXTITR


        mov ax, [di+6]
        sub ax, ballY
        cmp ax,0 

        jle NEXTITR
        ;-------------------------------- agr yahan tak aa gya to collission --- fingers crossed<3
            ;add ballvelocityX ,20
            ; mov ax,ballvelocityY
            ; mov bx,-1
            ; mul bx
            ; mov ballvelocityY,ax
            inc boolstage2
            inc score_counter
            call beep
            call score_display
            neg ballvelocityY
            call ballmoves
			mov al,byte ptr[di+9]
			cmp al,1
			ja colorchange
			add byte ptr[di+8],8
			mov al,2
			mov byte ptr[di+9],al
			jmp ext
			colorchange:
            mov byte ptr[di+8],0            ; changed color to black
			ext:
            mov ax,[di+2]          ;y axis
            mov bx, [di]            ;x axis
            mov cx,12 
            l11:
                push bx         ; x coord
                push ax
                push cx         ;height
                mov cx,40   ;50     ; width
                l21:
                    push cx         ;widht
                    mov dx,ax
                    push ax
                    mov ah,0ch
                    mov al,[di+8]
                    mov cx,bx
                    int 10h
                    pop ax
                    inc bx      ; x-axis
                    pop cx
                    loop l21
                pop cx
                pop ax
                inc ax
                pop bx 
            loop l11

        NEXTITR: 		
  
		;--------------------------------------------------------------------
        add di,sizeof Blocks

        pop cx
		dec cx
		cmp cx,36
	jb ColLOOP
  

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
collision2 endp

;------------------------------------LEVEL 3-------------------------------------------------------------------------------
collision3 proc
push ax
push bx
push cx
push dx
push si
push di
        ;     if (rect1.x < rect2.x + rect2.w && ------> ball.x2 - rect.x1 > 0          (i)
        ;     rect1.x + rect1.w > rect2.x &&     ------> rect.x2 - ball.x1 > 0          (ii)
        ;     rect1.y < rect2.y + rect2.h &&     ------> ball.y2 - rect.y1 > 0          (iii)
        ;     rect1.h + rect1.y > rect2.y        ------> rect.y2 - ball.y1 > 0 )        (iv)
    
    mov cx,36           ;------- number of brick
    mov di,offset bloc
    ColLOOP:
        push cx
		
        cmp byte ptr[di+8],0
        je NEXTITR
        mov ax,ballX
        add ax,10
        sub ax,[di]
        cmp ax,0           
        jle NEXTITR

        mov ax, [di+4] 
        sub ax, ballX
        cmp ax,0           
        jle NEXTITR

        mov ax, ballY
        add ax,10
        sub ax,[di+2]
        cmp ax,0           
        jle NEXTITR


        mov ax, [di+6]
        sub ax, ballY
        cmp ax,0 

        jle NEXTITR
        ;-------------------------------- agr yahan tak aa gya to collission --- fingers crossed<3
            ;add ballvelocityX ,20
            ; mov ax,ballvelocityY
            ; mov bx,-1
            ; mul bx
            ; mov ballvelocityY,ax
		    neg ballvelocityY
			 call beep
            call score_display
			cmp permanentbrickaddress,di
			je NEXTITR
			inc boolstage2
            inc score_counter
            call ballmoves
			mov al,byte ptr[di+9]
			cmp al,1
			je colorchange
			jmp movone
			colorchange:
			add byte ptr[di+8],8
			mov al,2
			mov byte ptr[di+9],al
			jmp ext
			movone:
			mov al,byte ptr[di+9]
			cmp al,2
			je secolorchange
			jmp black1
			secolorchange:
			mov al,3
			mov byte ptr[di+9],al
			mov byte ptr[di+8],15
			jmp ext
			;colorchange:
			black1:
			mov byte ptr[di+8],0            ; changed color to black
			ext:
            mov ax,[di+2]          ;y axis
            mov bx, [di]            ;x axis
            mov cx,12 
            l11:
                push bx         ; x coord
                push ax
                push cx         ;height
                mov cx,40   ;50     ; width
                l21:
                    push cx         ;widht
                    mov dx,ax
                    push ax
                    mov ah,0ch
                    mov al,[di+8]
                    mov cx,bx
                    int 10h
                    pop ax
                    inc bx      ; x-axis
                    pop cx
                    loop l21
                pop cx
                pop ax
                inc ax
                pop bx 
            loop l11
		    jmp NEXTITR

        NEXTITR: 		
  
		;--------------------------------------------------------------------
        add di,sizeof Blocks

        pop cx
		dec cx
		cmp cx,36
	jb ColLOOP
  

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
collision3 endp
;------------------------------------------------------------------------------COLLISON------------------------------------------------------------------------
paddlecollision proc
push ax
push bx
push cx
push dx
push si
push di
        ;     if (rect1.x < rect2.x + rect2.w && ------> ball.x2 - rect.x1 > 0          (i)
        ;     rect1.x + rect1.w > rect2.x &&     ------> rect.x2 - ball.x1 > 0          (ii)
        ;     rect1.y < rect2.y + rect2.h &&     ------> ball.y2 - rect.y1 > 0          (iii)
        ;     rect1.h + rect1.y > rect2.y        ------> rect.y2 - ball.y1 > 0 )        (iv)

    ;mov cx,36           ;------- number of brick
    ;mov di,offset bloc
    
        
       
        mov ax,ballX
        add ax,10
        sub ax,x_start
        cmp ax,0           
        jle NEXTITR

        mov ax, x_end
        sub ax, ballX
        cmp ax,0           
        jle NEXTITR

        mov ax, ballY
        add ax,10
        sub ax,y_start
        cmp ax,0           
        jle NEXTITR


        mov ax, y_end
        sub ax, ballY
        cmp ax,0 

        jle NEXTITR
        ;-------------------------------- agr yahan tak aa gya to collission --- fingers crossed<3
           

            neg ballvelocityY
            

        NEXTITR:    

        
    

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
paddlecollision endp

;------------------------------------------NOT NEEDED!----------------------------------------------------------
clearscreen proc
pop si
mov ah,00h
mov al,13h
int 10h
mov ah,0Bh
mov bh,00h
mov bl,00h
int 10h

push si
ret
clearscreen endp


;--====================================================================================================
;--====================================================================================================
;--====================================================================================================

;------------------------------------------DISPLAY NAME

display_user_name proc
   mov dh,23; row (0 -> 24)
   mov dl ,48; col (0 -> 79)
   mov ah, 2
   int 10h
   mov si,0
   mov cx,8
   start_printing:
      mov dl,username[si]
      cmp dl,' '
      je stop_printing
      mov ah,2
      int 21h
      inc si
      loop start_printing
   stop_printing:
   ret
   display_user_name endp

   ;-----------------------------------------DRAW HEART
    draw_heart proc
        cmp hearts,0
            je lost
        jmp skip  
        lost:
            call loser
        skip:
        mov dh,23; row (0 -> 24)
        mov dl ,41; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode
        mov al, 3
        mov bx,0
        mov bl,0100b; red color
        mov cx,hearts
        mov ah,09h
        int 10h
        
        ret
    draw_heart endp


    welcome proc
        ;setting video mode
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset start_msg
        ;mov bx,0
        mov bl,01110b; yellow color
        ;mov cx,1
        mov ah,09h
        int 21h

        input_again:
            mov ah,0    ;keys input
            int 16h
            cmp ah,28   ;comparing with scan code, next page will open only on ENTER key
            jne input_again
            ;call clear_screen
        ret
    welcome endp

    winner proc
        ;setting video mode
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset winner_msg
        ;mov bx,0
        ;mov bl,01110b; yellow color
        ;mov cx,1
        mov ah,09h
        int 21h
        mov ah,00
        int 16h
        cmp ah,13
        call main_menu
    ret
    winner endp

    loser proc
        ;setting video mode
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset loser_msg
        ;mov bx,0
        ;mov bl,01110b; yellow color
        ;mov cx,1
        mov ah,09h
        int 21h
        mov ah,00
        int 16h
        cmp ah,13
        call main_menu
    ret
    loser endp

    write_names proc
        ;loading file handler
        mov dx,offset file
        mov al,1
        mov ah,3dh
        int 21h

        ;Appending File
        mov bx,ax
        mov cx,0
        mov ah,42h
        mov al,02h
        int 21h

        ;Writing File
        mov cx,lengthof username; should have been 1 less than length of msg.
        mov dx,offset username
        mov ah,40h
        int 21h

        ;close file
        mov ah,3eh
        int 21h
    ret
    write_names endp

    write_levels proc
        ;loading file handler
        mov dx,offset file
        mov al,1
        mov ah,3dh
        int 21h

        ;Appending File
        mov bx,ax
        mov cx,0
        mov dx,0
        mov ah,42h
        mov al,02h
        int 21h

        ;Writing File
        mov cx,2; should have been 1 less than length of msg.
        mov dx,offset level
        mov ah,40h
        int 21h

        ;close file
        mov ah,3eh
        int 21h
    ret
    write_levels endp

    write_score proc
        ;loading file handler
        mov dx,offset file
        mov al,1
        mov ah,3dh
        int 21h

        ;Appending File
        mov bx,ax
        mov cx,0
        mov ah,42h
        mov al,02h
        int 21h

        ;Writing File
        mov cx,3; should have been 1 less than length of msg.
        mov dx,offset score
        mov ah,40h
        int 21h

        ;close file
        mov ah,3eh
        int 21h
    ret
    write_score endp

    score_display proc
        mov dh,23; row (0 -> 24)
        mov dl ,69; col (0 -> 79)
        mov ah, 2
        int 10h
        mov dx,offset score_msg
        mov ah,9
        int 21h
        ; xor dx,dx
        ; mov dh,0
        ; mov dx,score_counter
        ; add dx,48
        ; mov ah,2
        ; int 21h
        mov dx, 0
	MOV AX, score_counter
	MOV Bx, 10
	L1:
        mov dx, 0
		CMP Ax, 0
		JE DISP
		DIV Bx
		MOV cx, dx
		PUSH CX
		inc score_display_counter
		MOV AH, 0
		JMP L1

    DISP:
        CMP score_display_counter, 0
        JE EXIT
        POP DX
        ADD DX, 48
        MOV AH, 02H
        INT 21H
        dec score_display_counter
        JMP DISP
    EXIT:
        ret
    score_display endp

    display_level_in_gameplay proc
        mov dh,23; row (0 -> 24)
        mov dl ,60; col (0 -> 79)
        mov ah, 2
        int 10h
        mov dx,offset level_msg
        mov ah,9
        int 21h
        mov dx, 0
        mov dh,23
        mov dl,66
        mov ah,2
        int 10h
        mov dx,offset current_level
        mov ah,9
        int 21h
    ret
    display_level_in_gameplay endp

;-----------------------------------------------------------MAIN MENU-----------------------------------------------

    main_menu proc
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0
        ;setting video mode
        mov ah,0
        mov  al,3   ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,33; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx, offset menu_item1
        mov bl,01110b; yellow color
        ;mov cx,40
        mov ah,09h
        int 21h            

        ;next item(2)
        mov dh,7; row (0 -> 24)
        mov dl,33; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset menu_item2
        mov ah,09h
        int 21h


        ;next item(3)
        mov dh,9; row (0 -> 24)
        mov dl,33; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset menu_item3
        mov ah,09h
        int 21h


        ;next item(4)
        mov dh,11; row (0 -> 24)
        mov dl,33; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset menu_item4
        mov ah,09h
        int 21h


        ;next item(5)
        mov dh,13; row (0 -> 24)
        mov dl,33; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset menu_item5
        mov ah,09h
        int 21h

        ;Printing Selector and input of main

        L1:
            mov dh,row_selector; row (0 -> 24)
            mov dl,31; col (0 -> 79)
            mov ah,2
            int 10h

            mov al,'>'
            mov bx,0
            mov bl,01111b
            mov cx,1
            mov ah,09h
            int 10h


            mov ah,00    ;keys input
            int 16h

            cmp ah, 50h ;comparing with scan key
            je Down
            cmp ah,48h
            je Up
            cmp ah,1
            je escaped_pressed
            cmp ah,28
                jmp Enter_key_pressed
            jmp L1

            Down:
                ;prev_black:
                    mov dh,row_selector; row (0 -> 24)
                    mov dl,31; col (0 -> 79)
                    mov ah,2
                    int 10h

                    mov al,'>'
                    mov bx,0
                    mov bl,0    ;color
                    mov cx,1
                    mov ah,09h
                    int 10h
                ;moving to next item
                inc input_checker
                add row_selector,2
                cmp row_selector,15     ;comparing if going below the last one
                    je lower_limit

                jmp L1

            Up:
                ;prev_black
                    mov dh,row_selector; row (0 -> 24)
                    mov dl,31; col (0 -> 79)
                    mov ah,2
                    int 10h

                    mov al,'>'
                    mov bx,0
                    mov bl,0
                    mov cx,1
                    mov ah,09h
                    int 10h
                ;moving to next item
                dec input_checker
                sub row_selector,2
                cmp row_selector,3 ;comparing if going above the first one
                  je above_limit
                jmp L1

            Enter_key_pressed:
                cmp row_selector,13
                  je Quit_pressed
                cmp row_selector,11
                  je high_score_pressed    
                cmp row_selector,7
                  je level_pressed
                cmp row_selector,9
                  je how_to_play_pressed  
               cmp row_selector,5
                  je new_game_pressed       
               jmp L1


               lower_limit:
                  dec input_checker
                  sub row_selector,2
               jmp L1
               above_limit:
                  inc input_checker
                  add row_selector,2
               jmp L1
                
               Quit_pressed:
                  call ending
               high_score_pressed:
                  call display_high_scores
               level_pressed:
                  call display_levels
               how_to_play_pressed:
                  call display_how_to_play
               new_game_pressed:
                  call setup1


               escaped_pressed:
                  mov ah,4ch 
                  int 21h

        mov ah,4ch
        int 21h
        ret
    main_menu endp



    ending proc
        ;setting video mode
        push_all
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,20; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset end_msg
        mov bx,0
        mov bl,01110b; yellow color
        mov cx,1
        mov ah,09h
        int 21h  

        input_again:
            mov ah,0    ;keys input
            int 16h
            cmp ah,28   ;comparing with scan code, next page will open only on ENTER key
            jne input_again
            call main_menu
            ;call clear_screen
            pop_all
        ret
        mov ah,4ch 
        int 21h
    ending endp

;----------------------------------------------HIGH SCORES-------------------------------------------------

    display_high_scores proc
        ;setting video mode
        push_all
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset high_scores_msg
        mov ah,09h
        int 21h  

        mov dh,7
        mov dl,25
        mov ah,2
        int 10h

        mov dx,offset name1
        mov ah,09h
        int 21h

        mov dh,7
        mov dl,42
        mov ah,2
        int 10h

        mov dx,offset hs
        mov ah,9h
        int 21h

        mov dh,9
        mov dl,25
        mov ah,2
        int 10h

        mov dx,offset name2
        mov ah,09h
        int 21h

        mov dh,9
        mov dl,42
        mov ah,2
        int 10h

        mov dx,offset hs
        mov ah,9h
        int 21h

        mov dh,11
        mov dl,25
        mov ah,2
        int 10h

        mov dx,offset name3
        mov ah,09h
        int 21h

        mov dh,11
        mov dl,42
        mov ah,2
        int 10h

        mov dx,offset hs
        mov ah,9h
        int 21h

        mov dh,13
        mov dl,25
        mov ah,2
        int 10h

        mov dx,offset name4
        mov ah,09h
        int 21h

        mov dh,13
        mov dl,42
        mov ah,2
        int 10h

        mov dx,offset hs
        mov ah,9h
        int 21h

        mov dh,15
        mov dl,25
        mov ah,2
        int 10h

        mov dx,offset name5
        mov ah,09h
        int 21h

        mov dh,15
        mov dl,42
        mov ah,2
        int 10h

        mov dx,offset hs
        mov ah,9h
        int 21h

        input_again:
            mov ah,0    ;keys input
            int 16h
            cmp ah,28   ;comparing with scan code, next page will open only on ENTER key
            jne input_again
            call main_menu
            pop_all
        ret
        mov ah,4ch 
        int 21h
    display_high_scores endp

;----------------------------------------------------INSTRUCTIONS/HOW TO PLAY-------------------------------------------

    display_how_to_play proc
        ;setting video mode
        push_all
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,20; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing text)
        mov dx,offset how_to_play_msg
        mov bx,0
        mov bl,01110b; yellow color
        mov cx,1
        mov ah,09h
        int 21h  

        input_again:
            mov ah,0    ;keys input
            int 16h
            cmp ah,28   ;comparing with scan code, next page will open only on ENTER key
            jne input_again
            call main_menu
            ;call clear_screen
            pop_all
        ret
        mov ah,4ch 
        int 21h
    display_how_to_play endp

;-----------------------------------------------DISPLAY LEVELS-------------------------------------------------

    display_levels proc
        ;setting video mode
        push_all
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0
        mov ah,0
        mov  al,3     ;80 x 25 - color text
        int 10h

        ; cursor position 
        mov dh,5; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing level1)
        mov dx,offset level1_msg
        mov bx,0
        mov bl,01110b; yellow color
        mov cx,1
        mov ah,09h
        int 21h

        ; cursor position 
        mov dh,7; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing level2)
        mov dx,offset level2_msg
        mov bx,0
        mov bl,01110b; yellow color
        mov cx,1
        mov ah,09h
        int 21h

        ; cursor position 
        mov dh,9; row (0 -> 24)
        mov dl,30; col (0 -> 79)
        mov ah, 2
        int 10h

        ;text mode(printing level3)
        mov dx,offset level3_msg
        mov bx,0
        mov bl,01110b; yellow color
        mov cx,1
        mov ah,09h
        int 21h




;-------------------------------------------------------TAKING INPUT FOR LEVELS------------------------------------------



        mov row_selector,5

        L2:
            mov dh,row_selector; row (0 -> 24)
            mov dl,27; col (0 -> 79)
            mov ah,2
            int 10h

            mov al,'>'
            mov bx,0
            mov bl,01111b
            mov cx,1
            mov ah,09h
            int 10h


            mov ah,00    ;keys input
            int 16h

            cmp ah, 50h ;comparing with scan key
            je Down
            cmp ah,48h
            je Up
            cmp ah,1
            je escape_pressed
            cmp ah,28
                jmp Enter_pressed
            jmp L2

            Down:
                ;prev_black:
                    mov dh,row_selector; row (0 -> 24)
                    mov dl,27; col (0 -> 79)
                    mov ah,2
                    int 10h

                    mov al,'>'
                    mov bx,0
                    mov bl,0    ;color
                    mov cx,1
                    mov ah,09h
                    int 10h
                ;moving to next item
                inc input_checker
                add row_selector,2
                cmp row_selector,11     ;comparing if going below the last one
                    je lower_limit

                jmp L2

            Up:
                ;prev_black
                    mov dh,row_selector; row (0 -> 24)
                    mov dl,27; col (0 -> 79)
                    mov ah,2
                    int 10h

                    mov al,'>'
                    mov bx,0
                    mov bl,0
                    mov cx,1
                    mov ah,09h
                    int 10h
                ;moving to next item
                dec input_checker
                sub row_selector,2
                cmp row_selector,3 ;comparing if going above the first one
                    je above_limit
                jmp L2

            Enter_pressed:
                cmp row_selector,9
                    je level3_selected
                cmp row_selector,7
                    je level2_selected    
                cmp row_selector,5
                    je level1_selected        
                jmp L2


                lower_limit:
                    dec input_checker
                    sub row_selector,2
                jmp L2
                above_limit:
                    inc input_checker
                    add row_selector,2
                jmp L2

                

                level1_selected:
                    mov hearts,3
                    mov score_counter,0
                    mov current_level,"1"
                    call display_level_in_gameplay
                    call setup1         

                level2_selected:
                    mov hearts,3
                    mov score_counter,0
                    mov current_level,"2"
                    call display_level_in_gameplay
                    call setup2

                level3_selected:
                    mov hearts,3
                    mov score_counter,0
                    mov current_level,"3"
                    call display_level_in_gameplay
                    call setup3

                escape_pressed:
                    call main_menu
        
            pop_all
        ret
    display_levels endp
    

input_name proc
    mov ah,00
    mov al,13
    int 10H

    mov dh,5; row (0 -> 24)
    mov dl,4; col (0 -> 79)
    mov ah, 2
    int 10h

    mov dx,offset enter_name_msg
    mov ah,9
    int 21h

    mov si,0

    mov dh,10; row (0 -> 24)
    mov dl,13; col (0 -> 79)
    mov ah, 2
    int 10h

input_name_start:
   mov ah,1
   int 21h
   cmp al,13
   je stop_input
   mov username[si],al
   inc si
   jmp input_name_start
stop_input:
   mov cx,8
	mov si,0
	LoopName:
	    mov dl,username[si]
        cmp dl,' '
        je stop_output
        mov ah,2
        int 21h
        inc si
	LOOP LoopName
   stop_output:
ret
input_name endp

draw_short_paddle proc
      sstart:
      mov cx,sx_start
      mov dx,sy_start
      mov scounter,1
   souter:
      shorizontal:
      mov ah,0ch
      mov al,13 ;color of bar
      int 10H
      inc cx
      cmp cx,sx_end
      jb shorizontal
      inc scounter
      cmp scounter,10  ;for height
      mov cx,sx_start
      inc dx
      jb souter

         mov al,0    ;keys input for movement
         mov ah,1
         int 16h
         jz sexiting
         mov ah,0
         int 16h
         cmp ah,04Bh
            je sLeft
         cmp ah,04Dh
            je sRight

      sLeft:
               mov smovement_counter_left,0
               smaking_black_left:
               mov cx,sx_end
               mov dx,sy_start
         sremove_on_left:
               mov ah,0ch
               mov al,0
               int 10H
               inc dx
               cmp dx,sy_end
               je sremoved
               jmp sremove_on_left
               sremoved:
                  cmp smovement_counter_left,7
                  je sstart
               left_remover_for_3rd:
                  inc smovement_counter_left
                  dec sx_end
                  mov cx,sx_end
                  mov dx,sy_start
               sremoving_2nd:
                  mov ah,0ch
                  mov al,0
                  int 10H
                  inc dx
                  cmp dx,sy_end
                  je sleft_done
                  jmp sremoving_2nd
                  sleft_done:
                     cmp smovement_counter_left,7
                     jne left_remover_for_3rd
                     cmp sx_start,10
                     jle left_collide
                     sub sx_start,8
                     sub sx_end,1
            jmp sstart
            left_collide:
                ;call beep
                mov sx_start,2
                mov sx_end,50
                mov sy_start,170
                mov sy_end,180
                jmp sstart
      sRight:
         mov smovement_counter_right,0
         smaking_black_right:
         mov cx,sx_start
         mov dx,sy_start
         sremove_on_right:
            mov ah,0ch
            mov al,0
            int 10H
            inc dx
            cmp dx,sy_end
            je sremoved1
            jmp sremove_on_right
            sremoved1:
               cmp smovement_counter_right,7
               je sstart
            right_again:
               add smovement_counter_right,1
               inc sx_start
               mov cx,sx_start
               mov dx,sy_start
               sremoving_2nd_pixel:
                  mov ah,0ch
                  mov al,0
                  int 10H
                  inc dx
                  cmp dx,sy_end
                  je sright_done
                  jmp sremoving_2nd_pixel
                  sright_done:
                     cmp smovement_counter_right,7
                     jne right_again
                     cmp sx_start,267
                     jge right_collide
                     add sx_start,1
                     add sx_end,8
                  jmp sstart
                  right_collide:
                    ;call beep
                    mov sx_start,267
                    mov sx_end,318
                    mov sy_start,170
                    mov sy_end,180
                    jmp sstart
            jmp sexiting
   sexiting:
   ret
draw_short_paddle endp

short_paddlecollision proc
push ax
push bx
push cx
push dx
push si
push di
        ;     if (rect1.x < rect2.x + rect2.w && ------> ball.x2 - rect.x1 > 0          (i)
        ;     rect1.x + rect1.w > rect2.x &&     ------> rect.x2 - ball.x1 > 0          (ii)
        ;     rect1.y < rect2.y + rect2.h &&     ------> ball.y2 - rect.y1 > 0          (iii)
        ;     rect1.h + rect1.y > rect2.y        ------> rect.y2 - ball.y1 > 0 )        (iv)

    ;mov cx,36           ;------- number of brick
    ;mov di,offset bloc
    
        
       
        mov ax,ballX
        add ax,10
        sub ax,sx_start
        cmp ax,0           
        jle sNEXTITR

        mov ax, sx_end
        sub ax, ballX
        cmp ax,0           
        jle sNEXTITR

        mov ax, ballY
        add ax,10
        sub ax,sy_start
        cmp ax,0           
        jle sNEXTITR


        mov ax, sy_end
        sub ax, ballY
        cmp ax,0 

        jle sNEXTITR
        ;-------------------------------- agr yahan tak aa gya to collission --- fingers crossed<3
           

            neg ballvelocityY
            call beep

        sNEXTITR:    

        
    

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
short_paddlecollision endp

beep proc
    mov cx,1
	mov al, 182
	out 43h, al
	mov ax, sound
	
	out 42h, al
	mov al, ah
	out 42h, al
	in al, 61h
	
	or al, 3
	out 61h, al
	mov dx, 4240h
	mov ah, 86h
	int 15h
	in al, 61h
	
	and al, 11111100b
	out 61h, al
ret
beep endp


remove_Life proc

mov ax, life_x_axis
mov temp_life_x_axis, ax
mov ax, life_y_axis
mov temp_life_y_axis, ax

mov cx, 8
L1:
	mov bx, temp_life_x_axis
	push bx
	push cx
	mov cx, 8
	L2:
		push cx
		mov ah, 0ch
		mov al, 0
		mov cx, temp_life_x_axis
		mov dx, temp_life_y_axis
		int 10h
		inc temp_life_x_axis
		pop cx
		loop L2
	pop cx
	pop bx
	mov temp_life_x_axis, bx
	inc temp_life_y_axis
	loop L1

ret
remove_Life endp


end