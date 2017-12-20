assume cs:code,ds:data
data segment
    dw 0001h,86a1h,0064h ;先处理1000001/100  1000001>65536, 32位除以16位
    db 0e9h,03h,64h
data ends
code segment
start:      mov ax,data
            mov ds,ax
            mov bx,0
            mov dx,[bx]
            mov ax,[bx+2]
            div word ptr ds:[bx+4]

            mov ax,[bx+6]
            mov bl,[bx+8]
            div bl

code ends
end start




