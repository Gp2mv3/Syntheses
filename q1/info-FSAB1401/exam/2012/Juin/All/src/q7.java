public int NAuthors() {
    LinkedList<String> authors = new LinkedList<String>();
    for(int i = 0; i < contents.length; i++) {
        String a = contents[i].getAuthor();
        if(!authors.contains(a))
            authors.add(a);
    }
    return authors.size();
}
            
