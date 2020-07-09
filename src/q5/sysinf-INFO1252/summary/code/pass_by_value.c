void inc1 (int a) {
  a++;
}
void inc2 (int *b) {
  (*b)++;
}
void foo () {
  int n = 0;
  inc1(n);
  printf("%d\n", n); // affiche 0
  inc2(&n);
  printf("%d\n", n); // affiche 1
}
