#define A 0
#define B 1
int flag[];
flag[A]=false;
flag[B]=false;
// thread A
void* threadA(void* ){
  flag[A]=true;
  turn=B;
  while((flag[B]==true)&&(turn==B)) { /* loop */ }
  section_critique();
  flag[A]=false;
  // ...
}
// thread B
void* threadB(void* ){
  flag[B]=true;
  turn=A;
  while((flag[A]==true)&&(turn==A))
  { /* loop */ }
  section_critique();
  flag[B]=false;
  // ...
}
