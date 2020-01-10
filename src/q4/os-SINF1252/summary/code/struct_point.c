struct point {
  int x;
  int y;
}
int move (struct point *p, struct point delta) {
  (*p).x += delta.x;
  p->y += delta.y;
}
int main () {
  struct point d;
  d.x = 1;
  d.y = 2;
  struct point *triangle = malloc(3 * sizeof(struct point));
  printf("Before\n");
  for (int i = 0; i < 3; i++) {
    triangle[i].x = i;
    triangle[i].y = i+1;
    printf("(%d, %d)\n", triangle[i].x, triangle[i].y);
  }
  printf("After\n");
  for (int i = 0; i < 3; i++) {
    move(triangle[i], d);
    printf("(%d, %d)\n", triangle[i].x, triangle[i].y);
  }
  free(triangle);
  return 0;
}
