public JukeBox(SongPlayer player, String filename) {
    this.player = player;
    this.catalog = new Catalog(filename);

    player.addListener(new JukeBoxListener());
    list = new PlayList();
}

