public Catalog(String filename) {
	BufferedReader br;
	try {
		br = new BufferedReader(new FileReader(filename)); // throw IOException
		
		int nbSongs = Integer.parseInt(br.readLine());// throws NumberFormatException, ignoré
		contents = new Song[nbSongs];
		
		String ligne = br.readLine();// throws IOException
		int countPos=0;// nombre de chansons lues jusqu'à présent, et première case libre dans contents.
		while(ligne != null && ligne.size()>0) {
			// même si on connait le nombre de chansons, on vérifie quand même que la ligne n'est pas vide
			String[] properties = ligne.split(";");
			contents[countPos] = new Song(properties[0], properties[1], Integer.parseInt(properties[2]));

			countPos++;
			ligne=br.readLine();
		}
		br.close(); // Comme il n'y a pas de bloc finally, il faut fermer le fichier ici si tout s'est bien passé.
	} catch(Exception e) {
		if(br != null) {// et aussi ici, si erreur
			try {
				br.close();
			} catch(IOException e) {}
		}
		System.err.println("Erreur lors de la lecture du fichier");
		System.exit(-1); // à cause de lui, un bloc finally ne serait pas exécuté et donc il faut procéder autrement
	}
}
// with the help of Sébastien Binard

