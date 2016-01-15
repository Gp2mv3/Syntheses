private class JukeBoxListener implements PlayerListener {
    public JukeBoxListener() {}

    public void endOfSong(Song song) {
        if(list.isEmpty()) return;
        while(player.isPlaying()) {}
        player.play(list.dequeue());
    }
}

