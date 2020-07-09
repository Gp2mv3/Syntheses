...
// Dans la fonction principale : initialisation
#define N 10 // nbre de slots du buffer
pthread_mutex_t mutex; 	sem_t empty; sem_t full;

pthread_mutex_init(&mutex, NULL);
sem_init(&empty, 0 , N);  // empty compte le nbre de slot vide => N = buffer vide
sem_init(&full, 0 , 0);   // full compte le nbre de slot rempli => 0 = buffer vide
...
// Le Producteur
void producer(void){
  int item;
  while(true){
    item=produce(item);
    sem_wait(&empty); 		     // attente d'un slot libre
    pthread_mutex_lock(&mutex);  	// section critique
    insert_item();
    pthread_mutex_unlock(&mutex);	// fin de section critique
    sem_post(&full); 			// il y a un slot rempli en plus
  }
}

// Le Consommateur
void consumer(void){
  int item;
  while(true){
    sem_wait(&full); 			// attente d'un slot rempli
    pthread_mutex_lock(&mutex); 	// section critique
    item=remove(item);
    pthread_mutex_unlock(&mutex);
    sem_post(&empty);              // il y a un slot libre en plus
  }
}
