assume cs:code,ds:data
data segment
    dw 1,2,3,4,5,6,7,8
    dd 8 dup(0)
data ends
code segment
start:
    mov ax,data
    mov ds,ax
    mov cx,8
    mov si,0
    mov di,16
s:
    mov bx,ds:[si]
    call cube
    mov ds:[di],ax
    mov ds:[di+2],dx
    add si,2
    add di,4
    loop s
    mov ax,4c00h
    int 21h
cube:   
    mov ax,bx
    mul bx
    mul bx
    ret
code ends
end start
    
