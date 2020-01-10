premiere_phase();

pthread_mutex_lock(&mutex);		//section critique pour count
count++;
if(count==N) {					// si tous les threads sont arrives
  sem_post(&rendezvous);
}
pthread_mutex_unlock(&mutex);	//fin de section critique
sem_wait(&rendezvous);			//attente a la "barriere"
sem_post(&rendezvous);			//liberation d'un autre thread en attente

seconde_phase();
