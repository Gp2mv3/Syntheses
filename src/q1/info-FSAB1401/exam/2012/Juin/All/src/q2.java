public Catalog(String filename) {
    BufferedReader br;
    try {
        br = new BufferedReader(new FileReader(filename));
        int nbSongs = Integer.parseInt(br.readLine());
        contents = new Song[nbSongs];
        for(int i = 0; i < nbSongs; i++) {
            String properties[] = (br.readLine()).split(";");
            String title = properties[0], author = properties[1];
            int duration = Integer.parseInt(properties[2]);
            contents[i] = new Song(title, author, duration);
        }
        br.close();
    } catch(IOException e) {
        System.err.println("Erreur lors de la lecture du fichier");
        System.exit(-1);
        if (br != null)
            br.close();
    }
}

