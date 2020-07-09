int n;
printf("Combien voulez-vous de int (%d bytes par int) ? : ",
       sizeof(int));
scanf("%d", &n);
// On s'alloue n int consecutifs dans la heap
int *p = malloc(n * sizeof(int));
if (p == NULL) {
  // n est negatif, nul ou trop grand
  printf("Vous avez ete un peut trop optimiste il me semble :)\n");
}
// utilisation de p
// On n'oublie pas de liberer la memoire
free(p);
p = NULL;
