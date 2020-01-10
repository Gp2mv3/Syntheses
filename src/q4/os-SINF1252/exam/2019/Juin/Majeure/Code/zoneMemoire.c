#include <stdio.h>
#include <stdlib.h>

int f(int a, int *b ){
  int r = a + *b;
  printf("%d\n",r);
  //---ICI---
  return r;
}

int main(int argc, char *argv[]){
  static int c = 2;
  int *ptr = malloc(sizeof(int));
  int g = 4;
  *ptr = 3;
  int k = f(g,ptr);
  return(EXIT_SUCCESS);
}
