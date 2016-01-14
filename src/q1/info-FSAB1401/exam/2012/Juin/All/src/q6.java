public JukeBox(SongPlayer player, String filename) {
    assert player   != null : "Lecteur non defini";
    assert filename != null : "Nom de fichier non defini";

    this.player = player;
    this.catalog = new Catalog(filename);

    player.addListener(new JukeBoxListener());
    list = new PlayList();
}

