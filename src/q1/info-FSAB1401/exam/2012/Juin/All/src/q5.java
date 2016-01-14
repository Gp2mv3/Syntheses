private class JukeBoxListener implements PlayerListener {
    public JukeBoxListener() {}

    public void endOfSong(Song song) {
        assert song != null;
        while(player.isPlaying()) {}
        assert !list.isEmpty();
        player.play(list.dequeue());
    }
}

