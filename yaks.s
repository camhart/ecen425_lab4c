	CPU	8086
	ALIGN	2


YKEnterMutex:
				cli
				ret

YKExitMutex:
				sti		
				ret		

saveAndRestoreContext:
			;save context of current TCB
				;push general registers to stack

				push bp
				push ax
				push bx
				push cx
				push dx
				push si
				push di
				push ds
				push es
				pushf
	

				;save stack pointer and stack segment to TCB block

				mov		si, word [curTCB]			;load si with address of curTCB
				mov		word [si], ss 		

				add 		si, 2
				mov		word [si], sp

				add 		si, 2
				mov 		word [si], cs

		;restore context

				mov 		si, word[readyHead]			;load si with readyHead
				
				mov		word [curTCB], si			;assign new task to curTCB

				mov 		ss, word [si]
				add 		si, 2

				mov		sp, word [si]
				add 		si, 2

				mov		cs, word [si]
				
				popf
				pop		es
				pop		ds
				pop		di
				pop		si
				pop		dx
				pop		cx
				pop		bx
				pop		ax

				pop 		bp

				
				pushf
				push 		cs
				push    	word [bp+2]				;ip

				iret

restoreContext:

				mov 	si, word[readyHead]			;load si with readyHead
				
				mov		word [curTCB], si			;assign new task to curTCB

				mov 	ss, word [si]
				add 	si, 2

				mov		sp, word [si]
				add 	si, 2

				mov		cs, word [si]
				add 	si, 12


				pushf
				push 		cs

				push    	word [si]				;ip

				iret


saveAndFirstRestoreContext: 
			;save context of current TCB
				;push general registers to stack

				push bp
				push ax
				push bx
				push cx
				push dx
				push si
				push di
				push ds
				push es
				pushf
	

				;save stack pointer and stack segment to TCB block

				mov		si, word [curTCB]			;load si with address of curTCB
				mov		word [si], ss 		

				add 		si, 2
				mov		word [si], sp

				add 		si, 2
				mov 		word [si], cs

		;restore context

				mov 	si, word[readyHead]			;load si with readyHead
				
				mov		word [curTCB], si			;assign new task to curTCB

				mov 	ss, word [si]
				add 	si, 2

				mov		sp, word [si]
				add 	si, 2

				mov		cs, word [si]
				add 	si, 12


				pushf
				push 		cs

				push    	word [si]				;ip

				iret








