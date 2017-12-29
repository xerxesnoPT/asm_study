assume cs:code,ds:data,ss:stack
data segment
    dw 2 dup(0)
data ends

data segment
    db 16 dup(0)
segment ends

code segment
    start:  mov ax,4240H
            mov dx,000fh
            mov cx,0AH
            call divdw
            mov ax, 4c00h
            int 21h


    divdw:  push ax ;先把低16位保存起来. X/N = int(H/N)*65536  + [rem(H/N)*65536+L]/N  
            mov ax,dx ;进行32位除以16位除法
            mov dx,0
            div cx ; 得到的商在ax，余数在dx
            mov bx,ax ;  商保存在bx中 (bx) = int(H/N)
            pop ax ; 把低16位再取出，与dx一起再进行32位除以16位
            div cx ; [rem(H/N)*65536+L]/N
            mov cx,dx ; 余数放在cx中。
            mov dx,bx ;int(H/N)*65536
            ret
code ends
end start
