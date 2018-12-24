#define MSG_LEN 10
int g;   // initialise par le compilateur
int g_init=1252;
const int un=1;
int tab[3]={1,2,3};
int array[10000];
char cours[]="SINF1252";
char msg[MSG_LEN]; // initialise par le compilateur

int main(int argc, char *argv[]) {
  int i;
  printf("g est a l'adresse %p et initialisee a %d\n",&g,g);
  printf("msg est a l'adresse %p contient les caracteres :",msg);
  for(i=0;i<MSG_LEN;i++)
  printf("%x ",msg[i]);
  printf("\n");
  printf("Cours est a l'adresse %p et contient : %s \n",&cours,cours);
  return(EXIT_SUCCESS);
}
