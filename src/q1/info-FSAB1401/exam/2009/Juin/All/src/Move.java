/**
 * Un coup de jeu, sous forme d'une paire (jeton, colonne).
 * Utilisé dans UndoableGame pour mémoriser les coups joués.
 *
 * @author O. Bonaventure, Ch. Pecheur and J-M Vlaeminck
 * @version December 2015
 */

///// QUESTION 1 /////

public class Move {
	private final Token token;
	private final int column;

	/**
	 * Construit un coup de jeton et de colonne donnés.
	 * @pre c est un indice de colonne valide, t != null
	 * @post Un coup de jeton t et de colonne c a été créé
	 */
	public Move(Token t, int c) {
		this.token = t;
		this.column = c;
	}
	/**
	 * @pre -
	 * @post Retourne le jeton du coup
	 */
	public Token getToken() {
		return token;
	}
	/**
	 * @pre -
	 * @post Retourne le numéro de la colonne du coup
	 */
	public int getColumn() {
		return column;
	}
	/**
	 * @pre -
	 * @post Retourne une description du coup joué, sous la forme "<jeton> <colonne>"
	 */
	public String toString() {
		return token.toString() + " " + column;
	}
}

