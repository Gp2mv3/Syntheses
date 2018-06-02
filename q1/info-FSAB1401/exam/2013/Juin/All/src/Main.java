/**
 * Programme principal d'analyse de digrammes. Ce programme a pour but de comptabiliser les digrammes dans un ensemble de textes.
 */
public class Main
{
	private static final String DICTIONARY_FILE="./words2";
		// le fichier contenant le dictionnaire

	///// QUESTION 7 /////

	/**
	 * Compte et imprime les digrammes dans une série de fichiers de texte.
	 * @pre {args} contient des noms de fichiers contenant du texte.
	 * @post a imprimé sur {System.out} les statistiques de digrammes pour l'ensemble des fichiers dont les noms sont dans {args}.
	 */
	public static void main(String[] args) {
		DigramStatsWithTotals stats = new DigramStatsWithTotals(new Dict(DICTIONARY_FILE));

		if (args != null) // pas d'arguments; normalement on afficherait de l'aide
			for (int i=0; i<args.length; i++)
				stats.analyze(args[i]);
		else
			System.out.println("Please provide a valid filename for the dictionary.");
		stats.print(); // étrangement, print() écrit déjà sur {System.out}.
	}
}
