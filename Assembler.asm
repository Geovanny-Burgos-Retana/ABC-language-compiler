y db 
x db 
mov x,10
mov y,20
mov ax,x
add ax,y
mov x,ax
start_while1:
CMP ...
JNE exit_while1

start_if1:
CMP ...
JNE start_else1

mov al,x
mov bl,y
mul bl
mov x,al
JMP exit_if1
start_else1:

mov ax,x
sub ax,y
mov x,ax
exit_if1:

mov ax,x
inc ax
mov x,ax
mov ax,y
dec ax
mov y,ax
mov al,x
mov bl,y
div bl
mov x,al
JMP start_while1
exit_while1:


