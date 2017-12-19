assume cs:code,ds:data,ss:stack
data segment
    db 'BaSic'
    db 'MinIx'
data ends

code segment
start:  mov ax, data
        mov ds, ax
        mov bx, 0
        mov cx, 5
    s:  mov al, ds:[bx]
        and al, 11011111b
        mov ds:[bx], al
        mov al, ds:[bx+5]
        or al, 00100000b
        mov ds:[bx+5], al
        inc bx
        loop s

        mov ax,4c00h
        int 21h
        inc bx
code ends
end start
