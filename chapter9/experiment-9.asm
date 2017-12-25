assume cs:code, ds:data
data segment
    db 'welcome to masm!'
data ends
code segment
    start:  mov ax, data
            mov ds, ax
            mov ax,0b800h ;把显存段地址存入es中
            mov es,ax
            mov si,0
            mov cx,4 ;外部循环3次。
        s:  mov dx,cx ;从data处一个字节对应es处一个字
            mov bx,0
            mov bp,20 ;起始位置，从20个字节处开始
            mov cx,16 ;data中字符串的长度
        s1: mov al,ds:[bx]
            mov ah,42h ;这里设置颜色，红底绿字
            mov es:[bp+si],ax
            add bp,2
            add bx,1 
            loop s1
            mov cx,dx
            add si,160 ;25行，每行80个字。160个字节即
            loop s
        mov ax,4c00h
        int 21h
code ends
end start

