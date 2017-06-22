/**
 * Un jeu puissance 4 simple. Représente la zone de jeu, permet de stocker
 * les pions joués, de détecter les lignes de pions, et de générer
 * une représentation textuelle du panneau de jeu.
 *
 * Les pions joués sont mémorisés dans le tableau grid, colonnes d'abord:
 * grid[c][1] = pion à la colonne c, ligne 1. Les lignes sont numérotées de bas
 * en haut. Le tableau firstFreeCell[c] contient, pour chaque colonne c,
 * l'indice de ligne de la première case libre, au-dessus de tous les pions déjà
 * joués dans cette colonne.
 *
 * @author O. Bonaventure, Ch. Pecheur and J-M Vlaeminck
 * @version June 2017
 */

public class SimpleGame {

	public static final int DEFAULT_WIDTH = 7; // largeur par défaut
	public static final int DEFAULT_HEIGHT = 6; // hauteur par défaut
	private int width; // largeur du tableau de jeu
	private int height; // hauteur du tableau de jeu
	private Token[][] grid; // le tableau contenant les pions

	/*
	 * La première case libre dans chaque colonne (=height si la colonne
	 * est pleine).
	 */
	private int[] firstFreeCell;

	///// QUESTION 2 /////

	/**
	 * Un jeu de la taille fournie par l'utilisateur
	 *
	 * @pre w > 4, h > 4
	 * @post Un jeu initial de w colonne et h lignes est créé, dont toutes les cases contiennent le jeton Token.EMPTY
	 */
	public SimpleGame(int w, int h) {
		this.width = w;
		this.height = h;
		this.grid = new Token[width][height];
		this.firstFreeCell = new int[width];
		for (int i = 0; i < width; i++) {
			firstFreeCell[i] = 0;
			for (int j = 0; j < height; j++) {
				grid[i][j] = Token.EMPTY;
			}
		}
	}

	/**
	 * Construit un jeu de taille standard
	 *
	 * @pre -
	 * @post Un jeu initial de taille standard est créé
	 */
	public SimpleGame() {
		this(DEFAULT_WIDTH, DEFAULT_HEIGHT);
	}

	/**
	 * @pre -
	 * @post Retourne le nombre de colonnes du jeu
	 */
	public int getWidth() {
		return width;
	}

	/**
	 * @pre -
	 * @post Retourne le nombre de lignes du jeu
	 */
	public int getHeight() {
		return height;
	}

	/**
	 * @pre 0 <= l < width && 0 <= h < height
	 * @post Retourne le pion de coordonnées (l, h)
	 */
	public Token getToken(int l, int h) {
		return grid[l][h];
	}

	///// QUESTION 3 /////

	/**
	 * Ajoute un pion p dans la colonne c
	 *
	 * @pre p n'est pas un pion vide et c esr un indice de colonne valide
	 * @post Si la colonne c n'est pas pleine, le pion a été ajouté dans la colonne et retourne l'indice de la ligne à laquelle le pion a été placé ; sinon, lance une IllegalMoveException
	 */
	public int add(Token p, int c) throws IllegalMoveException {
		if (firstFreeCell[c] == height) {
			throw new IllegalMoveException("La colonne c est pleine.");
		} else {
			grid[c][firstFreeCell[c]] = p;
			firstFreeCell[c]++;
			return firstFreeCell[c] - 1;
			/* bonus : on peut écrire cela en deux lignes :
			grid[c][firstFreeCell[c]++] = p;
			return firstFreeCell[c] - 1;
			ou
			grid[c][firstFreeCell[c]] = p;
			return firstFreeCell[c]++;
			*/
		}
	}

	/**
	 * Enlève et retourne le dernier jeton de la colonne c
	 *
	 * @pre c est l'indice d'une colonne qui n'est pas vide
	 * @post Enlève et retourne le jeton au sommet de la colonne c.
	 *       Si la colonne est vide, retourne Token.EMPTY
	 */
	public Token clear(int c) {
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
		if (firstFreeCell[c] == 0)
			return Token.EMPTY;
		else {
			Token t = grid[c][--firstFreeCell[c]];
			grid[c][firstFreeCell[c]] = Token.EMPTY;
			return t;
		}
	}

	/**
	 * Vérifie la validité d'une paire de coordonnées
	 *
	 * @pre -
	 * @post Retourne true ssi les coordonnées (x, y) sont dans la grille de jeu
	 */
	public boolean isValidCoord(int x, int y) {
		return (0 <= x && x < width) && (0 <= y && y < height);
	}

	/**
	 * Taille de la plus longue ligne de pions en un point donné
	 *
	 * @pre (x0, y0) coordonnées d'une case de jeu valide
	 * @post Retourne la taille de la plus grande ligne de pions de même couleur passant par (x0, y0)
	 */
	public int lineSize(int x0, int y0) {
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
		/*
		 * Algorithme : pour chaque direction (horizontale, diagonale directe, verticale, diagonale innverse), on parcourt chaque case, dans les deux sens, jusqu'à rencontrer une case qui n'est pas de la même couleur. On fait la somme dans les deux sens, et on compare avec le maximum actuel.
		 */
		if (!(0 <= x0 && x0 < width && 0 <= y0 && y0 < height))
			return 0; // hors du plateau
		if (grid[x0][y0] == Token.EMPTY)
			return 0; // case vide, donc on ignore
		int absmax = 1; // il y a au moins une case de la même couleur : moi-même
		Token me = grid[x0][y0];
		int deltax[] = new int[] {1, 1, 0, -1};
		int deltay[] = new int[] {0, 1, 1,  1};
		for (int d = 0; d < 4; d++) {
			int curmax = 1;
			int cx = x0, cy = y0; // dernière case visitée et donc vérifiée
			boolean dirvalide = true; // indique si la dernière case visitée avait des coordonnées valides et a la bonne couleur ; permet de savoir si on doit encore regarder par après
			while (dirvalide) {
				cx += deltax[d];
				cy += deltay[d];
				if (0 <= cx && cx < width && 0 <= cy && cy < height) {
					if (grid[cx][cy] == me)
						curmax++;
					else
						dirvalide = false;
				} else {
					dirvalide = false;
				}
			}
			while (dirvalide) {
				cx -= deltax[d];
				cy -= deltay[d];
				if (0 <= cx && cx < width && 0 <= cy && cy < height) { // coordonnées valides
					if (grid[cx][cy] == me)
						curmax++;
					else
						dirvalide = false;
				} else {
					dirvalide = false;
				}
			}
			if (curmax > absmax)
				absmax = curmax;
		}
		return absmax;
	}

	///// QUESTION 4 /////

	/**
	 * Vérfie si la grille est pleine
	 *
	 * @pre -
	 * @post Retourne true ssi toutes les colonnes de la grille sont pleines.
	 */
	public boolean isFull()
	{
		for (int i = 0; i < width; i++)
			if (firstFreeCell[i] < height)
				// la colonne n'est pas pleine, donc la grille non plus
				return false;
		return true;
	}
}

