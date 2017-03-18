code segment     
start: ; INICIO DO PROGRAMA

    ; mapeando o segmento de dados.
    mov ax, data
    ; ds, registrador que representa a area de dados.
    mov ds, ax 
    

    ; INICIO
            
    ; lea = carrega um dado do seg. de dados para o seg. de codigo
_loop: lea dx, msg ; dx usado para E/S
    ; imprimi uma cadeia de caracter
    mov ah, 9      
    ; chama o DOS
    int 21h
    
    jmp _loop
    
    lea dx, msg2
    mov ah, 9
    int 21h            
      
    ; finaliza o programa
    mov ax, 4ch
    int 21h 
       
ends


data segment
    ; variavel (byte)
    msg db "Mensagem 01...",0Dh, 0Ah, "$"
    msg2 db "Mensagem 02...$"
ends



end start ; FIM DO PROGRAMA
