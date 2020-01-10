//Avec l'operateur '.'
printf("[%d] %s %s\n", mark.matricule, mark.nom, mark.prenom);
//Avec l'operateur '->'
Etudiant *e = &evil;
printf("[%d] %s %s\n" e->matricule, e->nom, e->prenom);
// qui est identique a :
printf("[%d] %s %s\n", (*e).matricule, (*e).nom, (*e).prenom);
