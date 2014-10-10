
	CPU	8086
	ALIGN	2


resetISR:
	
        push    ax         
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        push    es
        push    ds
	
	call YKEnterISR
        
        sti   
              
        call resetHandler

        cli                 
        
        mov     al, 0x20    
        out     0x20, al

	call	YKExitISR
        
        pop     ds          
        pop     es
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
            
        iret                

tickISR:
        push    ax         
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        push    es
        push    ds

	call 	YKEnterISR        

        sti                 
        
        call 	tickHandler   
        
        cli                 
        
        mov     al, 0x20    
        out     0x20, al

	call 	YKExitISR
        
        pop     ds          
        pop     es
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
            
        iret                

keyboardISR:
        push    ax         
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        push    es
        push    ds
        
	call 	YKEnterISR        

	sti                
        
        call 	keyHandler  
        
        cli                
        
        mov     al, 0x20   
        out     0x20, al

	call 	YKExitISR
        
        pop     ds         
        pop     es
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
            
        iret               
        
