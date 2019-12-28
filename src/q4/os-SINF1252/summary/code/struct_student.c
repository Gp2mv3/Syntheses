// Definition d'une structure
struct student {
  int matricule ;
  char prenom [20] ;
  char nom [30] ;
};
// Declaration + Initialisation
struct student linus = { 1 , "Linus" , "Torvalds" } ;
struct student richard = { .matricule = 2 , .prenom = "Richard" , .nom = "Stallman" } ;
struct student evil;
evil.noma = 3;
evil.prenom = "Bill";
evil.nom = "Gates";
