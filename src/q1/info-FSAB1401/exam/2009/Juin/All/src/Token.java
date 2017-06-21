/**
 * Un pion dans le jeu Puissance4. Seules trois instances prédéfinies sont disponibles, représentant un pion jaune (Token.YELLOW), un pion rouge (Token.RED) ou une case vide (Token.EMPTY). On utilise la même instance pour représenter tous les pions de même couleur.
 *
 * @author O. Bonaventure and Ch. Pecheur
 * @version May 2009
 */

public class Token
{
	public static final Token YELLOW = new Token("J",  "Jaune"); // jeton jaune
	public static final Token RED    = new Token("R",  "Rouge"); // jeton rouge
	public static final Token EMPTY  = new Token("-", "(vide)"); // case vide

	private static final Token[] ALL_TOKENS = { YELLOW, RED, EMPTY};
	private final String symbol; // le symbole qui représente le jeton
	private final String name; // le nom du jeton

	/**
	 * Construit un jeton de nom et symbole donnés
	 *
	 * @pre s.length == 1
	 * @post un pion de nom n et symbole s est créé
	 */
	private Token(String s, String n)
	{
		this.symbol = s;
		this.name = n;
	}

	/**
	 * @pre -
	 * @post Retourne le symbole du pion
	 */
	public String toString()
	{
		return symbol;
	}

	/**
	 * @pre -
	 * @post Retourne le nom du pion
	 */
	public String getName()
	{
		return name;
	}

	/**
	 * Retourne un pion de symbole donné
	 *
	 * @pre -
	 * @post retourne le pion dont le symbole est s, ou null si le jeton
	 *       n'existe pas
	 */
	public static Token fromString(String s)
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
	{
		for (int i = 0; i < ALL_TOKENS.length; i++) {
			if (ALL_TOKENS[i].toString().equals(s)) {
				return ALL_TOKENS[i];
			}
		}
		return null;
	}
}
