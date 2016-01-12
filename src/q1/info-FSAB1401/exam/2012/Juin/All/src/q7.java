public int NAuthors() {
    LinkedList<String> authors = new LinkedList<String>();
    for(int i = 0; i < contents.length; i++) {
        String a = contents[i].getAuthor();
        boolean inList = false;
        Iterator<String> it = authors.iterator();
        while(it.hasNext()) {
            String b = it.next();
            if(a.equals(b))
                inList = true;
        }
        if(!inList) authors.add(a);
    }
    return authors.size();
}
            
