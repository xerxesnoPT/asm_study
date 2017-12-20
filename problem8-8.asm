assume cs:code,ds:data
data segment
 dd 1000001
 dw 100
 dw 0
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov bx,0
        mov si,2
        mov ax,[bx]
        mov dx,[bx+si]
        add si,2
        div word ptr [bx+si]
        add si,2
        mov [bx+si],ax
code ends
end start
        
