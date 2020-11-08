lock:                 ; etiquette, variable
.long   0             ; initialisee a 0

enter:
movl    $1, %eax      ; %eax=1
xchgl   %eax, (lock)  ; instruction atomique, echange (lock) et %eax
; apres execution, %eax contient la donnee qui etait
; dans lock et lock la valeur 1
testl   %eax, %eax    ; met le flag ZF a TRUE si %eax contient 0
jnz     enter         ; retour a enter: si ZF est TRUE
ret

leave:
mov     $0, %eax      ; %eax=0
xchgl   %eax, (lock)  ; instruction atomique
ret
