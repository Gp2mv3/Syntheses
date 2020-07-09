...
if(signal(SIGALRM, sig_handler)==SIG_ERR)==SIG_ERR){ perror("signal"); exit(EXIT_FAILURE); }
if(siginterrupt(SIGALRM,true)<0){	// Indique qu'il faut arreter les appels systemes si on recoit SIGALRM
  perror("siginterrupt"); exit(EXIT_FAILURE);
}
...
char c;
alarm(5);
int r = read(STDIN_FILENO, &c, 1);
if((r==1)){
  alarm(0); 			// reset timer
  ...			     // On utilise la reponse donnee
} else {
  ... 				// On utilise une valeur par defaut
}
...

static void sig_handler(int signum){
  // rien a faire, read sera interrompu
}
