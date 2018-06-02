private class JukeBoxListener implements PlayerListener {
	/**
	 * @pre -
	 * @post Crée un JukeBoxListener
	 */
	public JukeBoxListener() {}

	/**
	 * Cf interface PlayerListener
	 * @pre song != null
	 * @post une nouvelle chanson est sur écoute.
	 */
	public void endOfSong(Song song) {
		if(list.isEmpty())
			return;
		while(player.isPlaying()) {
			// ne fait rien, attend la fin
		}
		player.play(list.dequeue());
	}
}

