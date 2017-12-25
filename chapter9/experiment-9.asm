assume cs:code, ds:data
data segment
    db 'welcome to masm!'
    db 2,24h,71h
data ends
code segment
    start:  mov ax, data
            mov ds, ax
            mov ax,0b800h ;把显存段地址存入es中
            mov es,ax
            mov bx,16
            mov cx,3 ;外部循环3次。
            mov di,1824 ;起始位置，从屏幕中间字节处开始
        s:  mov dx,cx ;从data处一个字节对应es处一个字
            mov si,0
            mov cx,16 ;data中字符串的长度
        s1: mov al,ds:[si]
            mov ah,ds:[bx] ;这里设置颜色
            mov es:[di],ax
            inc si
            add di,2
            loop s1
            mov cx,dx
            inc bx
            add di,128 ;25行，每行80个字。160个字节,还有减去原来di每次偏移的32个字节
            loop s
        mov ax,4c00h
        int 21h
code ends
end start

