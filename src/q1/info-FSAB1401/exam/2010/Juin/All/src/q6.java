public void sauvegarde(String fileName) {
    PrintWriter pw;
    try {
        pw = new PrintWriter(new FileWriter(fileName));
        for(MesureEtendue m : super.mesures)
            pw.printf("%d:%f\n", m.getPression(), m.getTemperature());
    } catch(IOException e) {
        System.err.println("Erreur lors de l'ecriture du fichier");
        System.exit(-1);
    } finally {
        if(pw != null)
            pw.close();
    }
}

