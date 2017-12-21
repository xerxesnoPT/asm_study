asuume cs:code
code segment
 start :mov ax,2000h
        mov ds,ax
        mov bx,0
    s:  mov cl,[bx] ;需要判断字节，使用8位寄存器
        mov ch, 0
        jcxz ok
        inc bx
code ends
end start

asuume cs:code
code segment
 start :mov ax,2000h
        mov ds,ax
        mov bx,0
    s:  mov cl,[bx] 
        mov ch, 0

        inc cx ; loop s 首先会对cx-1.所以判断cx==0时,要+1.否则就会无限死循环

        inc bx
        loop s
code ends
end start
