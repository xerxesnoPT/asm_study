assume cs:code,ds:data,ss:stack
data segment
 db 'welcome to masm!',0
data ends

stack segment
    dw 8 dup (0)
stack ends 
code segment
start:  mov dh,8
        mov dl,3
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str

        mov ax,4c00h
        int 21h

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
