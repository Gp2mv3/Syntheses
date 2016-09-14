/**
 * Enlève le digramme {d}.
 * @pre d!=null
 * @post Si le digramme {d} était présent dans la liste son compteur a été diminué de 1. Sinon une {DigramNotFoundException} est lancée. Le digramme est retiré de la liste si son compteur tombe à zéro.
 */
public void remove(Digram d) throws DigramNotFoundException {
	if (head==null) // la liste est vide
		throw new DigramNotFoundException("Erreur : liste vide");
	if (head.digram.equals(d)) {
		if (head.count <= 1) // on supprime le digramme de la liste
			head = head.next; // en remplaçant head par son suivant
		else // head.count > 1 : on décrémente le compteur
			head.count--;
		return;
	}
	// else : le digramme est ailleurs

	Node runner=head;
	while(runner.next !=null && runner.next.digram.equals(d))
		runner=runner.next;
	
	// deux possibilités de sortie
	if (runner.next==null) // on est arrivé au bout de la liste
		throw new DigramNotFoundException("Digramme non trouvé");
	// else : runner.next.digram.equals(d)==true ; on a trouvé le digramme chez runner.next
	if (runner.next.count <= 1) // si un seul, on le supprime de la liste
		runner.next=runner.next.next; // en remplaçant runner.next (le bon noeud) par son suivant (.next)
		// traduction de l'instruction : (runner.next).next est affectée à la variable next de current
	else // sinon, on décrémente
		runner.next.count--;
}

