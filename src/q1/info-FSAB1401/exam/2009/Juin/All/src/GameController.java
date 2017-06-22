import java.util.Scanner;
import java.io.*;

/**
 * Classe principale de contrôle du jeu
 *
 * @author O. Bonaventure, Ch. Pecheur and J-M Vlaeminck
 * @version June 2017
 */

public class GameController {

	/**
	 * Fichier pour sauver une partie de puissance 4
	 */
	private static final String FILENAME = "puissance4.dat";

	/**
	 * Taille d'une ligne gagnante
	 */
	private static final int WINSIZE = 4;

	/**
	 * Programme principal : crée et joue un jeu standard, en mode terminal
	 *
	 * @pre -
	 * @post Une partie complète a été jouée
	 */
	public static void main(String[] args) {
		play(new UndoableGame(), System.in, System.out);
	}

	///// QUESTION 8 /////

	/**
	 * Sauvegarde un jeu en cours dans un fichier donné.
	 *
	 * @pre fileName est un nom de fichier valide
	 * @post L'état de game a été sauvegardé dans le fichier de nom fileName
	 *
	 * FORMAT DU FICHIER : le fichier contient l'historique des coups joués dans la partie, selon le format suivant.
	 *
	 * Première ligne : "LARGEUR HAUTEUR COUPS", soit respectivement la largueur et hauteur de la grille et le nombre de coups joués.
	 *
	 * Ensuite, chaque coup sous la forme "PION COLONNE" dans l'ordre chronologique, où PION est le symbole du pion et COLONNe l'index de la colonne jouée.
	 */
	public static void save(String fileName, UndoableGame game)
	{
		if (game == null || fileName == null)
			return;
		int w = game.getWidth(),
		    h = game.getHeight();
		PrintWriter pw = null;
		try {
			pw = new PrintWriter(fileName);
		} catch (IOException e) {
			System.err.println("Erreur lors de l'ouverture du fichier " + fileName + ".");
			return;
		}
		if (pw == null)
			return;
		Move[] moves = game.getMoves();
		int coups = moves.length;
		// Pour information, println ne jette aucune exception en cas d'erreur d'écriture ; à la place, l'instance retient si il y a eu une erreur.
		pw.println(w + " " + h + " " + coups);
		for (Move move : moves) {
			pw.println(move);
			// grâce à la définition d'une méthode toString pour un Move ; sinon,
			//pw.println(move.getToken() + " " + move.getColumn());
		}
		if (pw.checkError()) {
			System.err.println("Erreur lors de la sauvegarde de la partie dans le fichier " + fileName + ".");
		}
		try {
			pw.close();
		} catch (IOException e) {}
	}

	/**
	 * Charge un jeu sauvé sur disque.
	 *
	 * @see save() pour le format du fichier
	 * @pre fileName est le nom d'un fichier contenant un jeu sauvegardé
	 *      avec save()
	 * @post Retourne le jeu lu.
	 */
	public static UndoableGame load(String fileName) {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(fileName));
			// lecture de la première ligne
			String[] words = reader.readLine().split(" ");
			int width = Integer.parseInt(words[0]),
			   height = Integer.parseInt(words[1]),
			    count = Integer.parseInt(words[2]);
			UndoableGame game = new UndoableGame(width, height);
			for (int i = 0; i < count; i++) {
				// lecture des lignes suivantes
				words = reader.readLine().split(" ");
				Token tok = Token.fromString(words[0]);
				int col = Integer.parseInt(words[1]);
				game.add(tok, col);
			}
			return game;
		} catch (IOException e) {
			System.err.println("Erreur de lecture du fichier " + fileName + " " + e.getMessage());
			return null;
		} catch (IllegalMoveException e) {
			System.err.println("Erreur au niveau des mouvements du fichier " + fileName + " " + e.getMessage());
			return null;
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {}
			}
		}
	}

	/**
	 * Joue un jeu en mode terminal sur les flux donnés
	 *
	 * @pre input, output sont deux flux de texte interactifs liés à un terminal
	 *      utilisé par les joueurs
	 * @post Une partie complète a été jouée
	 */
	public static void play(UndoableGame game, InputStream input, PrintStream output) {
	// Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
		/*
		 * Le programme commence par expliquer les règles du jeu, ainsi que les différentes commandes accessibles aux utilisateurs.
		 * Il propose ensuite à l'utilisateur de commencer une nouvelle partie, de continuer une partie existante, ou de quitter.
		 *
		 * A chaque tour, chaque joueur voit la position actuelle du plateau de jeu, ainsi que le joueur dont c'est le tour.
		 * Le programme attend alors que l'utilisateur ait rentré une commande valide et ait pressé la touche ENTER ; si la commande n'est pas valide, le programme redemande la commande.
		 * Le programme va alors exécuter la commande rentrée par l'utilisateur, qui peut être d'ajouter un pion, d'annuler un coup ou encore de commencer une nouvelle partie prédéfinie.
		 * Enfin, le programme affiche le nouvel état de jeu et attend de nouveau que l'utilisateur rentre une commande.
		 *
		 * Le programme vérifie également à chaque tour si l'un des joueurs a gagné. Si c'est le cas, le programme propose de sauvegarder la partie, de rejouer une nouvelle partie, ou encore de jouer une partie déjà enregistrée.
		 *
		 * A tout moment, l'utilisatuer peut arrêter le jeu en rentrant une commande adéquate.
		 *
		 * Le programme souffre d'un défaut : lors d'une nouvelle partie, le programme ne supprime pas de la mémoire la précédente partie.
		 * Au contraire, la partie précédente est conservée en mémoire bien qu'inaccessible, et un appel récursif à la méthode play est effectué.
		 * Au bout d'un très grand nombre de parties, le programme risque fort de demander une quantité non négligeable de mémoire RAM inutilement.
		 * Ce défaut est imposé par la nécessité de garder un code compatible avec le code de l'examen, qui oblige de faire tourner le programme dans la méthode main.
		 * Ca marche, mais c'est loin d'être optimal.
		 */

		Scanner sc = new Scanner(input);

		output.println("================================================");
		output.println("===== WELCOME TO PUISSANCE 4 - EPL EDITION =====");
		output.println("================================================");
		output.println();
		output.println("Règles du jeu");
		output.println("-------------");
		output.println("Le jeu est constitué de jetons de deux couleurs différentes (Rouge et Jaune) et d'un plateau de jeu rectangulaire, chaque case pouvant accueillir un jeton.");
		output.println("Il y a deux joueurs, l'un a les jetons rouge, l'autre les jetons jaunes. Le joueur aux jetons rouge commence.");
		output.println("Chacun à leur tout, les joueurs vont pouvoir placer un jeton au sommet d'une des colonnes du plateau de jeu.");
		output.println("Le jeton va alors glisser dans la colonne jusqu'à rencontrer la première case libre au bas de la colonne.");
		output.println("Le gagnant est le premier joueur qui parvient à aligner 4 jetons de sa couleur, verticalement, horizontalement, ou en diagonale.");
		output.println("Il y a match nul si la grille est remplie sans qu'un des joueurs ne soit parvenu à aligner 4 pions.");
		output.println();
		output.println("Commandes du jeu");
		output.println("----------------");
		output.println("Pour pouvoir interagir avec le jeu, vous devez utiliser des commandes. Une commande se compose d'un ou de plusieurs caractères bien précis, suivi par une pression de la touche ENTER.");
		showTurnCommands(output);
		output.println("Voulez-vous");
		output.println(" - commencer un nouveau jeu (y)");
		output.println(" - ouvrir un jeu enregistré dans le fichier \"" + FILENAME + "\" (o)");
		output.println(" - quitter le jeu (N) ?");
		do {
			String s = sc.next();
			if (s != null && s.length() > 0) {
				if (s.charAt(0) == 'o') {
					// ouvrir un nouveau jeu
					output.println("Désolé, le programme va de nouveau vous réexpliquer les règles.");
					UndoableGame g = load(FILENAME);
					if (g == null) {
						output.println("Impossible d'ouvrir le fichier. Tant pis.");
						return;
					}
					play(g, input, output);
					return;
				} else if (s.charAt(0) == 'n') {
					output.println("Au revoir, alors.");
					return;
				} else if (s.charAt(0) == 'y') {
					// rien à faire, ça va continuer
					break;
				}
			}
			output.println("Commande inconnue, veuillez réessayer.");
		} while (true);

		boolean gameIsActive = true;
		int winner = 0; // 0 si match nul ou personne ; 1 si rouge ; 2 si jaune
		int currentPlayer = 1; // 1 si rouge, 2 si jaune
		Token tokenPlayers[] = new Token[] {Token.EMPTY, Token.RED, Token.YELLOW};
		String namePlayers[] = new String[] {Token.EMPTY.getName(), Token.RED.getName(), Token.YELLOW.getName()};
		do { // while (gameIsActive)
			boolean hasConfirmed = false;
			boolean hasPlayed = false;
			int[] pion = new int[] {0, 0};
			do { // while (!hasConfirmed)
				showGrid(game, output);
				if (hasPlayed) {
					output.println("Vous avez joué. Voulez-vous annuler votre coup (u) ou le confirmer (n) ?");
				} else {
					output.println("Veuillez spécifier votre action.");
				}
				int[] rep = getTurnCommand(game, input, output, game.getWidth(), tokenPlayers[currentPlayer], hasPlayed); // n'a pas encore joué
				if (rep[0] == -16) {
					gameIsActive = false;
					winner = 0;
					hasConfirmed = true;
				} else if (rep[0] == -4) {
					// c'est à l'autre joueur : passé son tour, ou confirmé son coup
					hasConfirmed = true;
				} else if (rep[0] == -2) {
					// il veut annuler son coup
					try {
						game.undo();
						hasConfirmed = false;
						hasPlayed = false;
					} catch (IllegalMoveException e) {
						System.err.println("Impossible d'annuler.");
					}
				} else {
					// C'est un bon numéro, et on a pu y jouer
					output.println("Vous avez placé votre pion dans la colonne " + rep[0] + " et la ligne " + rep[1] + ".");
					pion = new int[] {rep[0], rep[1]};
					hasPlayed = true;
					hasConfirmed = false;
				}
			} while (!hasConfirmed);
			// Le joueur a joué son coup et a confirmé qu'il était bon, et a laissé le tour à l'autre joueur
			if (hasPlayed) {
				output.println("Le joueur " + namePlayers[currentPlayer] + " a placé son pion dans la colonne " + pion[0] + " et la ligne " + pion[1] + ".");
			} else if (gameIsActive) {
				output.println("Le joueur " + namePlayers[currentPlayer] + " a passé son tour.");
			}
			currentPlayer = 3 - currentPlayer;
			/*
			 * Vérifications :
			 * - y a-t-il un gagnant ?
			 * - y a-t-il encore de la place dans le plateau ?
			 */
			for (int i = 0; i < game.getWidth() && winner == 0; i++) {
				for (int j = 0; j < game.getHeight() && winner == 0; j++) {
					// on regarde la case actuelle
					int r = game.lineSize(i, j);
					if (r >= 4) {
						if (game.getToken(i, j) == Token.RED) {
							winner = 1;
						} else if (game.getToken(i, j) == Token.YELLOW) {
							winner = 2;
						} else {
							winner = 0;
						}
					}
				}
			}
			if (winner != 0)
				gameIsActive = false;
			if (game.isFull())
				gameIsActive = false;
		} while (gameIsActive);
		if (winner != 0) {
			output.println("Le joueur " + namePlayers[winner] + " a gagné !!!");
			output.println("!!!!! Félicitations !!!!!");
		} else {
			output.println("Il n'y a malheureusement aucun vainqueur.");
		}
		output.println("Voulez-vous enregistrer cette partie ? [O/n]");
		do {
			String s = sc.next();
			if (s != null && s.length() > 0) {
				if (s.charAt(0) == 'O') {
					save(FILENAME, game);
					output.println("Partie enregistrée dans le fichier \"" + FILENAME + "\".");
					break;
				} else if (s.charAt(0) == 'n') {
					break;
				}
			}
			output.println("Commande inconnue, veuillez réessayer.");
		} while (true);
		output.println("Merci d'avoir joué. A bientôt :)");
	}
	/*
	 * Méthodes auxiliaires pour la méthode précédente.
	 */
	private static void showTurnCommands(PrintStream output) {
		output.println("Les commandes accessibles à chaque tour sont :");
		output.println(" - h : afficher la liste des commandes accessibles. Vous pouvez de nouveau effectuer l'un des commandes listées.");
		output.println(" - q : arrêter le jeu actuel ; il y a match nul. Impossible d'annuler cette action.");
		output.println(" - u : annuler le mouvement que vous venez de faire. Ne permet pas d'annuler le mouvement de votre adversaire au tour précédent.");
		output.println("\tVous pouvez de nouveau effectuer l'une des commandes listées.");
		output.println(" - n : passer votre tour (si vous n'avez pas posé de jeton), ou passer au tour de l'autre joueur. Ne peut pas être annulé, car le tour passe à l'autre joueur.");
		output.println(" - un nombre : le numéro de la colonne dans lequel vous voulez mettre votre jeton. Vous devrez encore appuyer sur n et ENTER pour laisser l'autre jouer.");
		output.println("Si la commande n'est aucune des précédentes, ou que la colonne spécifiée est vide, le programme renouvelle sa demande.");
	}

	private static void showGrid(UndoableGame g, PrintStream output) {
		int width = g.getWidth();
		int height = g.getHeight();
		for (int j = 0; j <= (width / 10); j++) {
			output.printf("%20d", j * 10);
		}
		output.println();
		output.print("       ");
		for (int j = 0; j < width; j++) {
			output.print(j % 10 + " "); // modulo 10 afin d'éviter de péter le format.
		}
		output.println();
		output.print("      -");
		for (int j = 0; j < width; j++) {
			output.print("--");
		}
		output.println();
		for (int i = (height - 1); i >= 0; i--) {
			output.printf("%4d | ", i);
			for (int j = 0; j < width; j++) {
				output.print(g.getToken(j, i).toString() + " ");
			}
			output.print("|\n");
			output.println();
		}
		output.print("      -");
		for (int j = 0; j < width; j++) {
			output.print("--");
		}
		output.println("\n");
	}

	/*
	 * Retourne :
	 * {-2, 0} si undo.
	 * {-4, 0} si confirmation du mouvement effectué, ou passe son tour.
	 * {-16,0} si quitter le jeu.
	 * {c,  l} si colonne et ligne valides ; aura aussi appliqué le coup précisé par cette position et par {token}.
	 */
	private static int[] getTurnCommand(UndoableGame game, InputStream input, PrintStream output, int maxwidth, Token token, boolean hasPlayed) {
		String s;
		Scanner sc = new Scanner(input);
		do {
			s = sc.nextLine();
			if (s == null || s.length() == 0) {
				if (hasPlayed) {
					// autre manière de valider son coup : ne rien taper sauf ENTER.
					return new int[] {-4, 0};
				}
				// invalide
			} else if (s.equals("h")) {
				showTurnCommands(output); // on continue
			} else if (s.equals("q")) {
				return new int[] {-16, 0}; // valide : quitter le jeu, pas d'annulation
			} else if (s.equals("u")) {
				if (hasPlayed) {
					return new int[] {-2, 0}; // valide : annuler le coup, nécessite de revenir au caller
				} else {
					output.println("Impossible d'annuler. Réessayez ou affichez l'aide ('h' + ENTER).");
				}
			} else if (s.equals("n")) {
				return new int[] {-4, 0}; // valide : je laisse l'autre jouer
			} else if (!hasPlayed) {
				try {
					int c = Integer.parseInt(s);
					if (0 <= c && c < maxwidth) {
						// colonne valide : je joue
						try {
							int l = game.add(token, c);
							return new int[] {c, l};
						} catch (IllegalMoveException e) {
							output.println("Colonne remplie ; essayez une autre colonne.");
						}
					} else {
						output.println("Numéro de colonne invalide ; elle doit être entre 0 et " + (maxwidth - 1) + ".");
					}
				} catch (NumberFormatException e) {
					output.println("Commande invalide (en dehors de h, n, q, u ou nombre). Réessayez ou affichez l'aide ('h' + ENTER).");
				}
			} else {
				output.println("Commande invalide (en dehors de h, n, q ou u). Réessayez ou afficher l'aide ('h' + ENTER).");
			}
			output.println("Que souhaitez-vous faire ?");
		} while (true);
	}
}

