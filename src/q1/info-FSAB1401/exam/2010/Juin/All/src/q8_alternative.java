/* Dans la suite, on suppose que la liste est bien construite, sans erreurs sur les pointeurs, et que n appartient bien à la liste. */
private void remove(Node n) {
	if(n.previous == null) // n au début de la liste; équivalent à front==n
		front = n.next; // donc on avance le début
	else // je n'y suis pas ; n a donc un précédent
		n.previous.next = n.next;

	if(n.next == null) // en fin de liste
		back = n.previous;
	else // n a un suivant
		n.next.previous = n.previous;

	// Le cas où n est seul dans la liste implique n.next=n.previous=null, et après exécution front=back=null
	// safety : on met les références à null, pour aider la JVM
	n.next = n.previous = null;
}
