code segment     
start: ; INICIO DO PROGRAMA

    ; mapeando o segmento de dados.
    mov ax, data
    ; ds, registrador que representa a area de dados.
    mov ds, ax 
    

    ; INICIO
_leia:  lea dx,msg
        mov ah,9
        int 21h        
        
        mov ah,01h
        int 21h
        
        cmp al,'0'
        jl _aviso 
        
        cmp al,'9'
        jg _aviso
        
        jmp _continua
        
        
_aviso: lea dx,msg2
        mov ah,9
        int 21h
        jmp _leia    
        
_menor5:lea dx,menor5
        mov ah,9
        int 21h
        jmp _leia
        
_maior5:lea dx,maior5
        mov ah,9
        int 21h
        jmp _leia
        
        
_continua: cmp al,'5'
           je _fim 
           jg _maior5 
           jl _menor5
           
           
_fim:lea dx,igual5
     mov ah,9
     int 21h                           
      
    
     mov ax, 4ch
     int 21h 
       
ends


data segment
    ; variavel (byte)
    msg db "Digite um numero.:",0DH, 0AH, "$"
    msg2 db "Valor nao esta entre 0 e 9",0DH, 0AH, "$"
    menor5 db "Valor e menor que 5",0DH, 0AH, "$"
    maior5 db "Valor e maior que 5",0DH, 0AH, "$"
    igual5 db "Valor e igual 5",0DH, 0AH, "$"
    
ends



end start ; FIM DO PROGRAMA
