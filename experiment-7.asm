stack segement
    db 16 dup(0)
code segment
start : mov ax,stack ;定义stack存放外部21次循环
        mov ss,ax
        mov sp,16
        mov ax,data ;获取数据段地址
        mov ds,ax
        mov ax,table ;获取要写入的地址
        mov es,ax
        mov bx,0
        mov si,0
        mov di,0
        mov cx,21  ;外部21次循环
        mov bp,0
    s:  push cx ;cx入stack,开始内部循环
        mov cx,2

    s1: mov word ptr es:[bx+si],[bx+di] ;内部循环,第一次写入年份的高位地址,第二次写入低地址
        add bx,2 ; 因为是word,所以+2
        mov word ptr es:[bx+si+5], [bx+di+84] ;写入收入.同为4字节,每次写入2个字节.
        loop s1
        mov bx,0 ;bx置0,因为bx只是内部小循环用来执行第二次写入一个字操作的

        mov word ptr es:[si+10], ds:[bp+168] ;写入人数
        mov ax, es:[si+5] ; 32位被除数除以16位,ax放低位地址
        mov dx, es:[si+7] ; dx放入高位地址
        div word ptr es:[si+10] ;除数为人数
        mov es:[si+13],ax ; 除法得到的商放入偏移13处
        add si,16 ; 每次写入的table需要偏移16
        add di,4 ;年份跟收入每个都是4字节
        add bp,2 ;人数只需要一个字节

        pop cx ; 拿到stack中外部循环的次数
        loop s

        mov ax, 4c00h
        int 21
code ends
end start
