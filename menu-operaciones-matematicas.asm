;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID
;6 SEMESTRE GRUPO A           
;KOYOC TUN DARWIN ARATH
;SANTOS GUILLERMO SANTIAGO COB


;____________________________________________________   
;Macros

COMIENZO:

    ;Macro que realiza saltos de linea o internileado
    inter macro   
      
        mov ah,02h
        mov dl, 10
        int 21h
        mov dl,02h
        mov dl,13
        int 21h
     
    endm          
    
    ;Macro que establece el fin del programa
    final macro  
    
        mov AH, 4CH  ; PROGRAMA FIN
        int 21H      ; 
    endm
    
    ; Macro para leer los datos ingresados con el teclado      
    Leer macro 
    
    mov ah,01h
    int 21h
    endm
   
    ;Macro que realiza la accion de regresar al menu principal 
    regreso macro  
    
        jmp menus
    endm  
   
    
;____________________________________________________________
    
    .MODEL
    
   
    .DATA   

;____________________________________________________________
;Variables 
             
        menu DB "---MENU--SELECCIONE UNA OPERACION BASICA--- $"
        opcion1 DB "1.-SUMA$"
        opcion2 DB "2.-RESTA$"
        opcion3 DB "3.-MULTIPLICACION$"
        opcion4 DB "4.-DIVISION$"
        opcion5 DB "5.-PRECIONE OTRA TECLA PARA SALIR $" 
        ingresaropcion DB "INGRESE UNA OPCION: $"
        
        ; _________________________________________
        resultado DB 0   
        ms1 DB "INGRESE UN NUMERO: $"
        ms2 DB "EL RESULTADO ES: $"
        ms3 DB " RESIDUO $"
        ;____________________________________
        m db ?
        n db ?
        cien db 100  
        ;___________________________________
        chr1  db ? ;primer digito
        chr2  db ? ;segundo digito
        chr3  db ? ;multiplo
        chr4  db ?
        r1    db ? ;resultado 1
        r2    db ? ;resultado 2
        r3    db ?
        r4    db ?
        ac    db 0 ;acarreo
        ac1   db 0     
        residuo db 0 
        cocien db ?
        ;__________________________________
        decena db 0
        unidad db 0
        centena db 0    
        m7 db "-$"
 
    .CODE  

;____________________________________________________________
;Codigo
menus proc 
    
    
     MOV AX, DATA ;Inicio, segmentos de datos al registro ax
     MOV DS, AX   ;Mueve datos de ax a ds 
    
 ;_____________________________________________________________
 ;Impresion en pantalla del menu
    
inter  ;Llama a la Macro para realizar saltos de linea
    
    ;Imprime menu
    mov ah, 09h
    mov dx,offset menu ;Imprime titulo
    int 21h
    
    inter
     ;Imprime menu
    mov ah, 09h
    mov dx,offset opcion1 ;Imprime opcion 1
    int 21h

     inter
    
      ;imprime menu
    mov ah, 09h
    mov dx,offset opcion2 ;Imprime opcion 2
    int 21h
    
      inter
           
     ;imprime menu
    mov ah, 09h
    mov dx,offset opcion3 ;Imprime opcion 3
    int 21h
    
      inter 
      
     ;imprime menu
    mov ah, 09h
    mov dx,offset opcion4 ;Imprime opcion 4
    int 21h
    
      inter
                 
    ;imprime menu
    mov ah, 09h
    mov dx,offset opcion5 ;Imprime opcion 5
    int 21h  
               
    
     inter
      
    
      ;imprime menu
    mov ah, 09h
    mov dx,offset ingresaropcion  ;Imprime ingresar opcion
    int 21h  
    
    

 ;_____________________________________________________________
 ;Lectura de valor del teclado en la eleccion dentro del menu
    
    
    leer ;lee teclado, llamada a la macro
    
    ;ajustando el teclado
    xor ah,ah
    sub al,30h
    mov cx,2
    
    ;verificando opcion
    cmp al,1 ;Compara si la tecla oprimida es 1
    jz suma  ;Salto hacia seccion suma
   
    cmp al,2 ;Compara si la tecla oprimida es 2
    jz resta ;Salto hacia seccion resta
      
    cmp al,3 ;Compara si la tecla oprimida es 3
    jz multiplicacion ;Salto hacia seccion multiplicacion
    
    cmp al,4 ;Compara si la tecla oprimida es 4
    jz division ;Salto hacia seccion division
    
    cmp al,7  ;Compara si la tecla oprimida es 5
    final    ;LLamada a la macro final 
    
  
  
 ;_____________________________________________________________
 ;Operacion suma
 ; suma de dos numeros   
    suma: 
        inter
      ;imprime ms1
        mov ah,9
        lea dx,ms1 
        int 21h 

        mov ah,1
        int 21h 

        ;lee los valores ingresados en el teclado dos teclas
        sub al,30h  ;primera lectura, (digito en decena)
        mov m,al 
        int 21h  
        sub al,30h
        mov ah,m ; 
        aad ;ajuste ascii 
        mov m,al ;segunda lectura, (digito en unidad)
       
       
        inter

        ;imprime ms1
        mov ah,9 
        lea dx,ms1 
        int 21h
        ;lee los valores ingresados en el teclado dos teclas
        mov ah,1
        int 21h
        sub al,30h ;primera lectura, (digito en decena)
        mov n,al
        int 21h
        sub al,30h ;segunda lectura, (digito en unidad)
        mov ah,n
        aad
        mov n,al 
        
        inter

        ;imprime un mensaje
        mov ah,9
        lea dx,ms2 ;imprime ms2
        int 21h
         
        mov al,m ;mueve el valor de m a al
        add al,n  ;suma del valor dentro de al y el valor de n 
        xor ah,ah

        ;im presion del resultado
        div cien
        add al,30h
        mov dl,al
        mov al,ah
        aam
        ;imprime centena
        add ax,3030h
        mov bx,ax
        mov ah,2
        int 21h
        mov dl,bh ;imprime decena
        int 21h
        mov dl,bl ;imprime unidad
        int 21h

    mov resultado,0 ; elimina valores acumulados en la variable resultado  
             inter
        
    regreso ;Llamada a macro para regresar al menu 
    
 ;_____________________________________________________________
 ;Operacion resta
 
    resta: 
        inter
        ;imprime mensaje   
        mov ah, 09h      
        lea dx, ms1 
        int 21h
        
         ;lectura de decena  
        mov ah,1       ;entrada de datos
        int 21h        
        sub al, 30h    
        mov decena, al     ;mover el valor ingresado a variable decena
            
        ;lectura de unidad
        mov ah, 1   ;entrada de datos
        int 21h
        sub al, 30h
        mov unidad, al     ;mover el valor ingresado a variable unidad
        
        ;operacion para agrupar los digitos de decena y unidad en una sola
        mov al,decena  ;entrada de datos    
        mov bl,10  
        mul bl
        add al,unidad
        mov m,al ;mover los valores de decena y unidad  a variable m
        
        inter
        ;imprime mensaje
        mov ah, 09h      
        lea dx, ms1
        int 21h 
        
        ;lectura de decena   
        mov ah,1       ;;entrada de datos
        int 21h        
        sub al, 30h   
        mov decena, al     ;mover el valor ingresado a variable decena
            
        ;lectura de unidad
        mov ah, 1           ;entrada de datos
        int 21h
        sub al, 30h
        mov unidad, al      ;mover el valor ingresado a variable unidad
        
        ;operacion para agrupar los digitos de decena y unidad en una sola
        mov al,decena      
        mov bl,10  
        mul bl
        add al,unidad
        mov n,al ;mover los valores de decena y unidad  a variable n
        
        mov si, 0
         
        mov al, m ;Mover m a al
        cmp al, n ;Compara si al y n son iguales
        jnle operacion ; Salto  a operacion si n es menor o igual
        mov ah, n  ;Si no, mover valor n a ah
        mov m, ah
        mov n, al
        mov si, 1  ;mover 1 a registro si, (servira para indicar un valor negativo)
        
        operacion:
        mov al, m   ;movemos numero 1 a al 
        sub al, n   ;resta del numero 2 a al 
            

        ;procedimiento para imprimir los resultados de las operaciones
        aam 
        mov unidad,al ; respaldo 4 en unidades
        mov al,ah ;muevo lo que tengo en ah a al para poder volver a separar los numeros
        aam ; ajuste ascii
        mov centena,ah ;respaldo las centenas en cen en este caso 2
        mov decena,al ;respaldo las decenas en dec, en este caso 3
                                                                 
           
         inter
        ;imprimos los tres valores empezando por centenas, decenas y unidades.
        mov ah, 09h      
        lea dx, ms2
        int 21h   
         
        ;Condicion para determinar si el resultado es negativo 
        cmp si, 0 ; compara si el registro si es igual a sero
        je  imprimir; si es igual salta a imprimir       
        lea dx, m7 ;Impris el signo negativo
        int 21h    ;    Interrupcion
        
        imprimir:
        mov ah,02h
        mov dl,centena
        add dl,30h 
        int 21h
        mov dl,decena
        add dl,30h
        int 21h
        mov dl,unidad
        add dl,30h
        int 21h
        inter 
     
     regreso ;Llamada a macro para regresar al menu
 ;_____________________________________________________________
 ;Operacion multiplicacion
 
    multiplicacion:
        inter
        ;Imprime mensaje
        mov ah, 09h
        mov dx,offset ms1 ;Imprime opcion 1    
        int 21h
   
        ;Leer decena   
        mov ah,01h     ;Mover en AL
        int 21h        ;Interrucion
        sub al,30h     ;Ajustamos valores
        mov chr1,al    ;Mover el valor de al en chr1
   
        ;Leer unidad
        mov ah,01h     ;Mover 01h en AL
        int 21h        
        sub al,30h     ;Ajustamos valores
        mov chr2,al    ;Mover el valor de AL a chr2
          
          inter
        ;Imprime mensaje
        mov ah, 09h
        mov dx,offset ms1 ;Imprime opcion 1    
        int 21h 
   
        ;Lee el digito en decena del segundo numero
        mov ah,01h     ;Mover 01h en AL
        int 21h        
        sub al,30h     
        mov chr3,al    ;Mueve el valor almacenado en al a chr4 
   
        ;Lee el digito en unidad del segundo numero
        mov ah,01h     ;Mueve 01h en AL
        int 21h        
        sub al,30h     
        mov chr4,al    ;Mueve el valor almacenado en al a chr4
          
          inter
        ;Imprime mensaje
        mov ah, 09h
        mov dx,offset ms2    
        int 21h

        ;Realizacion de operacion   
  
        mov al,chr4  ;unidad del segundo numero
        mov bl,chr2  ;unidad del primer numero
        mul bl       ;multiplicar
        mov ah,0     ;limpiamos ah0
        aam          
        mov ac1,ah   ;decenas del primera multiplicacion
        mov r4,al    ;unidades del primera multiplicacion
            
        mov al,chr4  ;unidades del segundo numero
        mov bl,chr1  ;decentas del primer numero
        mul bl       ;multiplicar
        mov r3,al    ;movemos el resultado de la operacion a r3
        mov bl,ac1   ;movemos el acarreo a bl
        add r3,bl    ;sumamos resultado mas acarreo
        mov ah,00h   ;limpiamos ah por residuos
       mov al,r3    ;movemos el resultado de la suma a al
        aam          ;Ajuste ASCII
        mov r3,al    ;guardamos unidades en r3
        mov ac1,ah   ;guardamos decenas en ac1

        mov al,chr3    ;al = chr3
        mov bl,chr2    ;bl = chr2
        mul bl         ;AL = chr3*chr2 
        mov Ah,0h      ;
        AAM            ;Ajuste ASCII 
        mov ac,AH      ;ac = AH (Acarreo)
        mov r2,AL      ;r2 = AL (Unidad del resultado)

        mov al,chr3    ;AL = chr3
        mov bl,chr1    ;BL = chr1
        mul bl         ;AL = chr1*chr3 
        mov r1,al      ;r1 = AL   (Decena del resultado)
        mov bl,ac      ;BL = Acarreo anterior
        add r1,bl      ;r1 = r1+ac (r1 + Acarreo)
        mov ah,00h     ;
        mov al,r1      ;AL = r1 
        AAM            ;Ajuste ASCII 
        mov r1,al      ;r1 = AL
        mov ac,ah      ;ac = AH (Acarreo para la Centena del resultado)
  
  
        ;suma final
        ;R4 resulta ser las unidades de mul y no se toma en cuenta ya que se pasa entero
  
  
        mov ax,0   ;limpiamos ax
  
        mov al,r3      ;movemos el segundo resultado de la primera mult a al
        mov bl,r2      ;movemos primer resultado de la segunda mult a bl
        add al,bl      ;sumamos
        mov ah,00h     ;limpiamos ah
        aam            
        mov r3,al      ;r3 guarda las decenas del resultado final
        mov r2,ah      ;r2 se utiliza como nuevo acarreo
  
        mov ax,0  ;limpiamos ax 
  
        mov al,ac1     ;movemos el acarreo de la primera mult a al
        mov bl,r1      ;movemos segundo resultado de la segunda mult a bl
        add al,r2      ;sumamos el nuevo  acarreo de la suma anterior  a al
        add al,bl      ;sumamos al a bl
        mov ah,00h     ;limpiamos el registro ah
        aam          
        mov r1,al      ;r1 guarda las centenas
        mov r2,ah      ;ah se sigue utilizando como acarreo
  
        mov al,r2      ;movemos el acarreo a al
        mov bl,ac      ;movemos ac a bl
        add al,bl      ;sumamos al a bl
   
        mov ac,al      ;mov al a ac como nuestro acarreo final
  
 
  
         ;Mostramos resultado
         ;Valor en millar
         mov ah,02h 
        mov dl,ac
        add dl,30h
        int 21h        
        ;Valor en centena
        mov ah,02H
        mov dl,r1
        add dl,30h
        int 21h        
        ;Valor en decena            
        mov ah,02H
        mov dl,r3
        add dl,30h
        int 21h        
        ;Valor en unidad
        mov ah,02H
        mov dl,r4
        add dl,30h
        int 21h       
                
        inter
    regreso 
 
 ;_____________________________________________________________
 ;Operacion division      
    division: 
         inter
         ;Impimir msj  
         mov ah,02h
         mov dh,n
         mov dl,m         
         mov dx,offset ms1  ;Imprimr el primer msj
         mov ah,09h      ;Toma el primer digito
         int 21h 
         
         ;Tomar segundo digito
         mov ah,01h
         int 21h 
         
         sub al,30h
         mov bh,al  ; primer numero en hexa
         
         mov ah,01h
         int 21h 
         
         sub al,30h  ;Realiza una operacion
         mov bl,al
         
         push bx    ;Es introducido
         mov bx,00h
         
         inter
         ;Imprimir msj
         mov ah,02h
         mov dh,n
         mov dl,m
         mov dx,offset ms1  ;Imprimir msj1
         mov ah,09h         ;tomar primer valor
         int 21h            ;imprimir
         
         ;Tomar segundo valor
         mov ah,01h
         int 21h
          
         sub al,30h   ;Realiza una operacion
         mov ch,al  ; segundo numero en hexa 
           
         mov ah,01h
         int 21h 
         
         sub al,30h   ;Realiza una operacion
         mov cl,al    ;
         
         pop bx
           
         cmp cx,bx    ;Realiza una comparacion
         ja division  ;salta
         
         
         mov al,0ah ;multiplicar por 10 al segmento ch y se guarda en el segmento al
         mul bh 
         add bl,al
         mov chr1,bl ; numero en decimal    
         
         mov al,0ah ;multiplicar por 10 al segmento ch y se guarda en el segmento al
         mul ch 
         add cl,al
         mov chr2,cl ; numero en decimal
         
         mov al,chr3    ;El valor pasa a al
         cmp al,32h    ;Se realiza una comparacion
         je seguir    ;salta a seguir
         
         mov al,chr1    ;EL valor pasa a al
         mov cl,chr2 ;El valor pasa a cl
         mov dx,00h
         
         div cl        ;Realiza una operacion
         mov residuo,ah
         mov cocien,al
         
         cmp ah,0ah    ;Se compara
         jae acarreo    ;Salta a acarreo
         mov bx,00h  

         inter            
         ;Impimir msj
         mov ah,02h
         mov dh,n
         mov dl,m 
         mov dx,offset ms3   ;Imprime msj
         mov ah,09h        
         int 21h       ;Interrupcion
         
         mov dl,residuo
         add dl,30h
         mov ah,02h  ;muestras el numero guardado en memoria,"dl"
         int 21h  
         
         mov bx,00h 
                
cociente:
        inter
        ;Imprimir msj
        mov ah,02h
        mov dh,n      ;El valor pasa a dh
        mov dl,m      ;El valo pasa a dl
        mov dx,offset ms2 ;se imprime el ms3
        mov ah,09h
        int 21h      ;Lo imprime
       
         
         mov dl,cocien 
         add dl,30h
         mov ah,02h  ;muestras el numero guardado en memoria,"dl"
         int 21h 
    
         mov ah,07h 
         jmp menus   ;Regresa la menu
         int 21h      

acarreo: 
         mov al,ah     ; El valor pasa a al
         mov ah,00h
         aam       ;ajuste ASCII para la multiplicacion 
         
         ;Oprecion
         add ah,30h
         add al,30h 
         
         push ax       ;Introducir
         mov bx,00h
        
         inter
         ;Imprimir msj
         mov ah,02h
         mov dh,n      ;El valor pasa a dh
         mov dl,m      ;El valor pasa a dl
         mov dx,offset ms2 ;Imprime el msj
         mov ah,09h
         int 21h        ;Ejecuta
       
         pop ax   ;Extrae
         push ax         ;Introduce
         mov dl,ah      ;El valor pasa a dl
         mov ah,02h
         int 21h       ;Es ejecutado
         
         pop ax          ;Extrea
         mov dl,al       ;Se trandiere a ah
         mov ah,02h
         int 21h        ;Lo ejecuta
         jmp cociente   ;Salta a cociente 
         
seguir:
        mov bh,chr1      ;El valor pasa a bh
        mov ch,chr2   ;Se trasnfiere a vh
        sub bh,ch     ;Resaliza una operacion
        mov ax,00h
        mov al,bh
        aam        ;ajuste ASCII para la multiplicacion 
        push ax     ;Introduce el valor
       
        mov bx,00h
        inter                 
        ;Imprimir msj
        mov ah,02h
        mov dh,n   ;El valor pasa a dh
        mov dl,m   ;El valor pasa a dl
        mov dx,offset ms1   ;Imprime el msj
        mov ah,09h
        int 21h     ;Lo ejecuta
       
        pop ax      ;Extraemos el valor
        push ax    ;Es tomado
        add ah,30h    ;Realiza una operacion
        mov dl,ah
        mov ah,02h  ;El valor es tranferido a ah
        int 21h
    
        pop ax        ;Tomamos el valor
        add al,30h    ;Realiza una operacion
        mov dl,al     ;El valor pasa a dl
        mov ah,02h
        int 21h       ;Se ejecuta
      
        mov ah,07h
        int 21  
    regreso 
             
 ;_______________________________________________________

  
        
        
    
    ENDs