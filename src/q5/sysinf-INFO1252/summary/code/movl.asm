; EXEMPLE MODE REGISTRE
movl %eax, %ebx	; deplacement de %eax vers %ebx
movl %ecx, %ecx	; aucun effet

; EXEMPLE MODE IMMEDIAT
movl $0, %eax		; initialisation de %eax a 0
movl $1252, %ecx	; initialisation de %ecx a 1252

; EXEMPLE MODE ABSOLU
movl 0x04, %eax		; place la valeur contenue a l'adresse 0x04 en memoire dans %eax
movl $1252,	%ecx	; initialisation de %ecx a 1252
movl %ecx, 0x08		; remplace le contenu de la memoire a l'adresse 0x08 par 1252

; EXEMPLE MODE INDIRECT
movl $0x08, %eax	; place la valeur 0x08 dans %eax
movl (%eax), %ecx	; place la valeur se trouvant a l'adresse qui est dans
; %eax dans le registre %ecx
movl 0x10, %eax		; place la valeur se trouvant a l'adresse 0x10 dans %eax
movl %ecx, (%eax)	; place le contenu de %ecx a l'adresse qui est contenue
; dans %eax(0x10)

; EXEMPLE MODE AVEC UNE BASE ET UN DEPLACEMENT
movl $0x08,%eax		; place la valeur 0x08 dans %eax
movl 0(%eax), %ecx	; place la valeur se trouvant a l'adresse 0x08 dans le
; registre %ecx
movl 4(%eax), %ecx	; place la valeur se trouvant a l'adresse 0x0C (=0x08+4) dans
; le registre %ecx
movl -8(%eax), %ecx	; place la valeur se trouvant a l'adresse 0x00 (=0x08-8) dans
; le registre %ecx
