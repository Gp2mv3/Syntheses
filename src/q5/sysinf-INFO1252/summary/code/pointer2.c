int i=1;				// entier
int *ptr_i;				// pointeur vers un entier

ptr_i=&i;				// initialisation du pointeur, a l'adresse de i
*ptr_i = *(ptr_i)+1252;	// changement du contenu de la memoire pointee par ptr_i
