public int NAuthors() {
    String[] auteurs = new String[contents.length];
    int compteur=0;
    for(Song song : contents) {
        String a=song.get=author();
        for (int j=0; j<compteur; j++) {
            if(auteurs[j].equals(a))
                continue;
        } // l'auteur a n'est pas dans le tableau auteurs
        auteurs[compteur++] = a; // 2 opérations en un coup !
    }
    return compteur;
}

