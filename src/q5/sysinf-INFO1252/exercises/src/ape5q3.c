#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

struct ThreadParam {
	int integer;
	char character;
};

void *my_thread(void *param)
{
	struct ThreadParam *realParam = (struct ThreadParam*)param;
	int n = realParam->integer;
	char c = realParam->character;
	printf("Paramètres reçus : %d et %c\n", n, c);
	return NULL;
}

int main(int argc, char **argv)
{
	pthread_t threads[4];
	struct ThreadParam params[4];
	for (int i = 0; i < 4; i++) {
		params[i].integer = i * 42;
		params[i].character = ('A' + i);
		pthread_create(&threads[i], NULL, &my_thread, &params[i]);
	}
	for (int i = 0; i < 4; i++)
		pthread_join(threads[i], NULL);
	return EXIT_SUCCESS;
}
