Variable2 db 
Variable1 dw 
start_if1:
CMP ...
jmp exit_if1
exit_if1:

start_if2:
CMP ...
jmp exit_if2
exit_if2:

start_if3:
CMP ...
jmp exit_if3
exit_if3:

start_while1:
CMP ...
jmp exit_while1
exit_while1:

start_while2:
CMP ...
jmp exit_while2
exit_while2:

mov b,a
mov ax,a
inc ax
mov b,ax
mov ax,a
dec ax
mov b,ax
mov ax,b
add ax,a
mov b,ax
mov ax,b
sub ax,a
mov b,ax
mov al,b
mov bl,a
mul bl
mov b,al
mov al,b
mov bl,a
div bl
mov b,al
mov ax,b
add ax,c
mov a,ax
mov ax,b
sub ax,c
mov a,ax
mov al,b
mov bl,c
mul bl
mov a,al
mov al,b
mov bl,c
div bl
mov a,al
mov al,b
mov bl, c
div bl
mov a,al

