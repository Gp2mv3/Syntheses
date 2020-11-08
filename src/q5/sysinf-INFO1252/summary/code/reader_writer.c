/* Initialisation */
pthread_mutex_t mutex_readcount; 	        // protege readcount
pthread_mutex_t mutex_writecount; 	        // protege writecount
pthread_mutex_t z; 				        // un seul reader en attente
sem_t wsem;       				        // acces exclusif a la db
sem_t rsem;					        // pour bloquer des readers
int readcount=0;
int writecount=0;
sem_init(&wsem, 0, 1);
sem_init(&rsem, 0, 1);

/* Writer */
while(true){
  think_up_data();
  pthread_mutex_lock(&mutex_writecount)   // section critique - writecount
  writecount=writecount+1;
  if(writecount==1) {			       // si c'est le premier writer qui arrive
    sem_wait(&rsem);
  }
  pthread_mutex_unlock(&mutex_writecount);// fin de la section critique - writecount
  sem_wait(&wsem);					  // section critique, un seul writer a la fois
  write_database();
  sem_post(&wsem);				       // fin de la section critique
  pthread_mutex_lock(&mutex_writecount);  // section critique - writecount
  writecount=writecount-1;
  if(writecount==0) {				  // depart du dernier writer
    sem_post(&rsem);
  }
  pthread_mutex_unlock(&mutex_writecount);// fin de la section critique - writecount
}

/* Reader */
while(true){
  pthread_mutex_lock(&z);			  // 1e exclusion mutuelle, un seul reader en attente sur rsem
  sem_wait(&rsem);

  pthread_mutex_lock(&mutex_readcount);	  // exclusion mutuelle, readercount
  readcount=readcount+1;
  if (readcount==1) {				  // si arrivee du premier reader
    sem_wait(&wsem);
  }
  pthread_mutex_unlock(&mutex_readcount); // fin exclusion mutuelle, readercount
  sem_post(&rsem);  				  // liberation du prochain reader
  pthread_mutex_unlock(&z);			  // fin 1e exclusion mutuelle
  read_database();
  pthread_mutex_lock(&mutex_readcount);	  // exclusion mutuelle, readcount
  readcount=readcount-1;
  if(readcount==0) {				  // si depart du dernier reader
    sem_post(&wsem);
  }
  pthread_mutex_unlock(&mutex_readcount); // fin exclusion mutuelle, readcount
  use_data_read();
}
