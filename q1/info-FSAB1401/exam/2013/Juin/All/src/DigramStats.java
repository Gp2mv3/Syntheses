/**
 * Les statistiques de comptage des digrammes dans un ensemble de documents. Les digrammes sont stockés sous forme de liste simplement chainée, chaque noeud contenant un compteur du nombre de fois que le digramme a été rencontré. La structure comporte un dictionnaire; seuls les mots dans ce dictionnaire sont pris en compte.
 */
import java.io.*;

public class DigramStats
{
	protected Node head; // premier noeud de la liste de digrammes
	protected Dict dict; // dictionnaire contenant les mots à prendre en compte

	/**
	 * @pre d!=null
	 * @post a construit une structure vide avec {d} comme dictionnaire.
	 */
	public DigramStats(Dict d)
	{
		head=null;
		this.dict=d;
	}

	///// QUESTION 5 /////

	/**
	 * Ajoute les digrammes du fichier {fileName} aux statistiques.
	 * @pre fileName != null, fileName est un nom de fichier contenant un texte.
	 * @post les digrammes se trouvant dans le fichier fileName ont été ajoutés aux statistiques, selon les règles suivantes:
	 *       - Les mots sont tels que retournés par la méthode {splitWords}.
	 *       - Un digramme est constitué de deux mots consécutifs, quels que soient les caractères d'espace ou de ponctuation qui les séparent. En particulier, le dernier mot d'une ligne et le premier mot de la ligne suivante constituent un digramme.
	 *       - Seuls les digrammes dont les deux mots sont dans le dictionnaire sont pris en compte. Si un mot n'est pas dans le dictionnaire, alors les deux digrammes dont il fait partie sont ignorés.
	 *       En cas d'erreur d'I/O, abandonne la lecture du fichier, émet un message sur {System.err} et retourne.
	 */
	public void analyze(String fileName) {
		BufferedReader bf = null;
		try {
			bf = new BufferedReader(new FileReader(fileName)); // throws FileNotFoundException, IOException
			String ligne = bf.readLine(); // la ligne en cours ; throws IOException
			String precedent = ""; // buffer contenant le dernier mot de la ligne précédente
			while (ligne != null) {
				String[] tab = splitWords(ligne);
				if (tab.length <= 0) // pas de mot ; ligne vide
					continue;
				// tout d'abord, on check le premier mot et {precedent}
				if ( dict.contains(precedent) && dict.contains(tab[0]) )
					add( new Digram(precedent, tab[0]) );
				for (int i=1; i<tab.length; i++)
					if ( dict.contains(tab[i-1]) && dict.contains(tab[i]) )
						add( new Digram(tab[i-1], tab[i]) );

				precedent = tab[tab.length-1]; // dernier mot de la ligne
				ligne = bf.readLine(); // on lit la nouvelle ligne ; throws IOException
			}

			bf.close(); // Don't forget me ! throws IOException
		} catch (Exception e) { // s'il y a eu une erreur
			System.err.println("Erreur lors de la lecture du fichier.");
			return;
		} finally { // non nécessaire à l'examen, mais oui dans la vraie vie
			// Si on a eu une erreur d'I/O après l'ouverture du fichier, il faut quand même refermer celui-ci
			if (bf != null) {// le fichier a été ouvert et doit être refermé
				try {
					bf.close(); // oui, même fermer un fichier peut provoquer une erreur
					// à noter que fermer un fichier déjà fermé ne génère pas d'IOException
				} catch (IOException f) {}
			}
		}
	}
	// TODO : sans doute moyen d'optimiser les contains, en utilisant une ArrayList qui contient les vrais bons mots.

	/**
	 * @pre l!=null
	 * @post retourne un tableau de String contenant tous les mots se trouvant dans {l}. Retourne un tableau de taille null si {l} ne contient aucun mot.
	 * Un mot est une chaine de lettres et/ou de chiffres consécutifs (sans accents). Les majuscules sont converties en minuscules.
	 */
	private static String[] splitWords(String l) {
		String[] filter1 = (l.toLowerCase()).split("\\W+");
		/* Expression régulière : indique à la méthode split qu'elle doit couper lorsqu'elle rencontre un ou plusieurs (+) caractères qui ne sont pas a-z, A-Z ou 0-9 (\\W, le premier backslahs permet l'écrire le deuxième). */
		return filter1;
	}

	/**
	 * Ajoute un digramme {d}.
	 * @pre d!=null
	 * @post Si le digramme {d} était présent dans la liste, son compteur a été incrémenté de 1. Sinon, un nouveau digramme avec la valeur l est ajouté à la liste.
	 */
	public void add(Digram d) {
		if (!dict.contains(d.getWord1()) || !dict.contains(d.getWord2()))
			return; // Digramme invalide ; sécurité supplémentaire, vu que c'est une méthode publique.
		Node runner=head;
		if (head==null) {// clairement on peut l'ajouter
			head = new Node(d, 1, null);
			return;
		}
		else if (head.digram.equals(d)) {
			head.count++;
		}
		else {
			while(runner.next != null && !runner.next.digram.equals(d))
				runner=runner.next;
			if (runner.next==null)
				runner.next=new Node(d, 1, null);
			else // runner.next.digram.equals(d)
				runner.next.count++;
		}
	}

	///// QUESTION 4 /////

	/**
	 * Enlève le digramme {d}.
	 * @pre d!=null
	 * @post Si le digramme {d} était présent dans la liste, son compteur a été diminué de 1. Sinon une {DigramNotFoundException} est lancée. Le digramme est retiré de la liste si son compteur tombe à zéro.
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

	/**
	 * Le compteur du digramme {d}.
	 * @pre d!=null
	 * @post retourne le compteur du digramme {d} et 0 si il n'est pas dans la liste.
	 */
	public int getCount(Digram d) {
		Node runner=head;
		while(runner != null && !runner.digram.equals(d)) // break if runner==null or if the digram is found
			runner=runner.next;
		if (runner==null)
			return 0;
		else // runner.digram.equals(d)
			return runner.count;
	}

	/**
	 * Imprime les statistiques sur {System.out}. Chaque digramme et son compteur sont imprimés.
	 */
	public void print() {
		Node runner=head;
		StringBuffer sb=new StringBuffer();
		while(runner!=null) {
			sb.append(runner.digram);
			sb.append(" : ");
			sb.append(runner.count);
			sb.append("\n");
			runner=runner.next;
		}
		System.out.print(sb.toString());
	}

	protected class Node {
		Node next; // noeud suivant dans la liste
		Digram digram; // référence vers le digramme
		int count; // compteur pour ce digramme
		/**
		 * Construit un noeud pour le digramme {d} avec un compteur égal à {c} et {n} pour le noeud suivant.
		 */
		public Node(Digram d, int c, Node n) {
			digram=d; count=c; next=n;
		}
	}
}
