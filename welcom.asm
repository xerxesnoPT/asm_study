assume cs:code,ds:data
data segment
    db 'welcome to masm!'
    db '................'
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov si,0
        mov cx,16
    s:  mov al,[si]
        mov 16[si],al
        inc si
        loop s
        
        mov ax,4c00h
        int 21
code ends
end start
        
