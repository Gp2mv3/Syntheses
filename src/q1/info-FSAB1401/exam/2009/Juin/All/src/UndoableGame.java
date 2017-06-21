/**
 * Un jeu puissance 4 étendu, qui mémorise les coups joués et permet de revenir en arrière (undo).
 *
 * @author O. Bonaventure and Ch. Pecheur
 * @version May 2009
 */

public class UndoableGame extends SimpleGame
{
	private MoveStack stack; // pile des coups joués.

	/**
	 * Un jeu de taille donnée
	 *
	 * @pre - (voir superclasse)
	 * @post Construit un jeu de largeur w et de hauteur h
	 */
	public UndoableGame(int w, int h)
	{
		super(w, h);
		stack = new MoveStack();
	}

	/**
	 * Un jeu de taille standard
	 *
	 * @pre -
	 * @post Construit un jeu de taille standard
	 */
	public UndoableGame()
	{
		this(DEFAULT_WIDTH, DEFAULT_HEIGHT);
	}

	///// QUESTION 5 /////

	/**
	 * Ajoute un pion p dans la colonne c
	 *
	 * @pre p n'est pas un pion vide et c est un indice valide
	 * @post Si la colonne c n'est pas pleine, ajoute un pion dans la colonne c, mémorise le coup et retourne la ligne à laquelle le pion a été placé ; sinon, lance une IllegalMoveException
	 */
	public int add(Token p, int c) throws IllegalMoveException
	{
		int r = super.add(p, c);
		stack.push(new Move(p, c));
		return r;
	}

	/**
	 * Annule le dernier coup joué
	 *
	 * @pre -
	 * @post Si au moins un coup a été joué, annule l'effet de ce coup.
	 *       Sinon, lance un IllegalMoveException
	 */
	public void undo() throws IllegalMoveException
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
	{
		Move m = stack.pop();
		if (m == null)
			throw new IllegalMoveException("Aucun mouvement à annuler");
		clear(m.getColumn());
	}

	/**
	 * @pre -
	 * @post Retourne la liste des coups joués, dans l'ordre chronologique
	 */
	Move[] getMoves()
	{
		return stack.getAll();
	}
}

