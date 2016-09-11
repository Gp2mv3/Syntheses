public int NAuthors() {
    ArrayList<String> authors = new ArrayList<>();
    for(Song song : contents) {
        if(!authors.contains(song.getAuthor()))
            authors.add(a);
    }
    return authors.size();
}

