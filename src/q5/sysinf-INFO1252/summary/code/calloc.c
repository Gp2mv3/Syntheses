#define N 42
int *p = malloc(N * sizeof(int));
for (int i = 0; i < N; i++) {
  p[i] = 0;
}
// est plus lent que
int *p = calloc(N, sizeof(int));
