#include ...
sigjmp_buf buf;
static void sigfpe_handler(int);

int main (int argc, char *argv[]){
  if(signal(SIGFPE,sigfpe_handler)==SIG_ERR) {
    perror("signal");
    exit(EXIT_FAILURE);
  }
  for(int i=1;i<argc;i++) {
    char *endptr; int r;
    long val=strtol(argv[i],&endptr,10);
    if(*endptr=='\0') {
      r=sigsetjmp(buf,1);  // faut-il ignorer le resultat ?
      if(r==0){
        int resultat=1252/(int) val;
        printf("1252/%d=%d\n",(int) val,resultat);
      }
      else {
        printf("%d/%d=NaN\n",n,(int) val);
      }
    }
    else{
      printf("Argument incorrect : %s\n",argv[i]);
    }
  }
  return(EXIT_SUCCESS);
}

static void sigfpe_handler(int signum){
  siglongjmp(buf,1);      // ignorer la donnee
}
