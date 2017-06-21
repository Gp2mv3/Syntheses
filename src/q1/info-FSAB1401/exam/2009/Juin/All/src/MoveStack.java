/**
 * La pile des coups joués, le dernier coup étant au sommet de la pile.
 * Implémenté sous la forme d'une structure simplement chainée.
 *
 * @author O. Bonaventure, Ch. Pecheur and J-M Vlaeminck
 * @version Dec 2015
 */

public class MoveStack
{

	/**
	 * Noeud interne de la pile
	 */
	private class Node
	{
		public Move move;
		public Node next;
	}
	private Node top;

	/**
	 * @pre -
	 * @post Crée une pile vide
	 */
	public MoveStack()
	{
		top = null;
	}

	///// QUESTION 6 /////

	/**
	 * Ajoute un coup sur la pile
	 *
	 * @pre -
	 * @post Le coup m est ajouté au sommet de la pile
	 */
	public void push(Move m)
	{
		Node n = new Node();
		n.move = m;
		n.next = top;
		top = n;
	}

	/**
	 * @pre -
	 * @post Retourne le dernier coup joué
	 */
	public Move top()
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
	{
		if (top == null)
			return null;
		else
			return top.move;
	}

	/**
	 * Supprime le dernier coup
	 * 
	 * @pre -
	 * @post Le dernier coup joué est retourné et supprimé de la pile
	 */
	public Move pop()
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
	{
		if (top == null)
			return null;
		else {
			Move m = top.move;
			top = top.next;
			return m;
		}
	}

	///// QUESTION 7 /////

	/**
	 * Les coups joués dans l'ordre chronologique
	 *
	 * @pre -
	 * @post Retourne les coups joués sous forme de tableau, dans l'ordre chronologique (sommet de la pile en dernier). Le contenu de la pile reste inchangé.
	 */
	public Move[] getAll()
	{
		Move[] res = new Move[size()];
		Node runner = top;
		/*
		 * On parcourt le tableau dans le sens inverse, la pile étant stockée en sens anti-chronologique.
		 * La première partie du for déclare à la fois i, indice de la case actuelle du tableau de résultat, ainsi qu'un pointeur runner sur l'élément actuel de la pile.
		 * La troisième partie du for effectue deux actions :
		 * - décrémenter l'indice de la case actuelle du tableau de résultat ;
		 * - déplacer le pointeur runner sur l'élément suivant de la pile.
		 */
		for (int i = size() - 1; i >= 0; i--, runner = runner.next) {
			res[i] = runner.move;
		}
		return res;
	}

	/**
	 * @pre -
	 * @post Retourne le nombre de couprs dans la pile
	 */
	public int size()
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
	{
		int s = 0;
		for (Node runner = top; runner != null; runner = runner.next, s++) {}
		// Tout le parcours en un seul for !
		return s;
	}

	/**
	 * La pile est-elle vide ?
	 *
	 * @pre -
	 * @post Retourn true ssi la pile est vide
	 */
	public boolean isEmpty()
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
	{
		return (top == null);
		// alternative : regarder si size() == 0
	}
}

