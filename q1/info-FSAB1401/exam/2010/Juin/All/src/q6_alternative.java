// Version alternative
public void sauvegarde(String fileName) {
	PrintWriter pw;
	try {
		pw = new PrintWriter(new FileWriter(fileName)); // throws IOException
	} catch(IOException e) {
		System.err.println("Erreur lors de l'ouverture du fichier");
		System.exit(-1);
	}
	// écrivons ; PrintWriter ne jette pas d'exception lors de l'écriture
	for(MesureEtendue m : mesures)
		pw.printf("%d:%f\n", m.getPression(), m.getTemperature());
	// Il est temps de vérifier qu'il n'y a pas eu d'erreur
	boolean erreurs = pw.checkError();
	pw.close();
	if (erreurs) {
		System.err.println("Erreur(s) lors de l'écriture du fichier");
		System.exit(-2);
	}
}
// on aurait pu utiliser println directement, si on avait bien défini toString() ;-)
