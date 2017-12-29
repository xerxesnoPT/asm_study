assume cs:code,ds:data,ss:stack
data segment
    db 36 dup (0)
data ends

stack segment
    db 48 dup(0)
stack ends

code segment
    start:  mov ax,12312
            mov bx,data
            mov ds,bx
            mov si,0
            call dtoc

            mov dh,8
            mov dl,3
            mov cl,2
            call show_str
            mov ax,4c00h
            int 21h

    dtoc:    
            mov dx,0
            mov cx,0AH
            call divdw 

            jcxz filling

            mov bl,cl
            add bl,30h
            push bx
            inc si
            jmp short dtoc
    filling: 
            mov cx,si
            mov si,0
            a : pop bx
                mov ds:[si],bl
                inc si
                loop a
            mov ds: [si], cl
            mov si,0
            ret

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
    
    show_str:
    head:  
            push dx
            push cx
            push ax
            push ss
            push si

            mov ax,0b800h ;拿到显卡地址
            mov es,ax
            mov al,160 ;每行160个字节
            dec dh ;第一行对应应该为0
            mul dh
            mov bx,ax ;结果放入bx中
            mov al,2 ;一个字符2个字节 公式为 地址=（行数-1）*160 + （列数-1）*2
            dec dl
            mul dl
            add bx,ax ;行数跟列数地址相加得到实际定位地址
            mov di,0
            mov si,0
            mov ah,cl ;把要显示的颜色放入ah中
    change: 
            mov ch,0
            mov cl,[si]
            mov al,cl
            jcxz ok ;进行0的判断
            mov es:[bx+di],ax ; 把字节数按照高位属性，低位ascii码 放入到显卡中显示
            add di,2
            inc si
        jmp short change
        ok :
            pop si
            pop ss
            pop ax
            pop cx
            pop dx
            ret

code ends
end start
