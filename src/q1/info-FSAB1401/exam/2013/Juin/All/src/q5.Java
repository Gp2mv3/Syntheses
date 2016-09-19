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
		bf = new BufferedREader(new FileReader(fileName)); // throws FileNotFoundException, IOException
		String ligne = bf.readLine(); // la ligne en cours ; throws IOException
		String precedent = ""; // buffer contenant le dernier mot de la ligne précédente

		while (ligne != null) {
			String[] tab = splitWords(ligne);
			if (tab.length <= 0) // pas de mot ; ligne vide
				continue;

			// tout d'abord, on check le premier mot et {precedent}
			if ( dict.contains(precedent) && dict.contains(tab[0]) ) // sans doute moyen d'optimiser cela pour n'avoir qu'un seul appel à contains
				add( new Digram(precedent, tab[0]) );
			for (int i=1; i<tab.length; i++) {
				if ( dict.contains(tab[i-1]) && dict.contains(tab[i]) )
					add( new Digram(tab[i-1], tab[i]) );
			}

			precedent = tab[tab.length-1]; // dernier mot de la ligne
			ligne = bf.readLine(); // on lit la nouvelle ligne ; throws IOException
		}

		bf.close(); // Don't forget me ! throws IOException
	} catch (Exception e) { // s'il y a eu une erreur
		System.err.println("Erreur lors de la lecture du fichier: "+e.getMessage());
		return;
	}
	finally { // non nécessaire à l'examen, mais oui dans la vraie vie
		// Si on a eu une erreur d'I/O après l'ouverture du fichier, il faut quand même refermer celui-ci
		if (bf != null) {// le fichier a été ouvert et doit être refermé
			try {
				bf.close(); // oui, même fermer un fichier peut provoquer une erreur
				// à noter que fermer un fichier déjà fermé ne génère pas d'IOException
			} catch (IOException f) {}
		}
	}
}
/* TODO : sans doute moyen d'optimiser les contains, en utilisant une ArrayList qui contient les vrais bons mots.
Est-ce que finally est quand même exécuté en cas de return ? Que se passe-t-il si on met un return dedans ? (note : finally n'est pas exécuté en cas de System.exit)
