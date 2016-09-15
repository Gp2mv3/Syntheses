public void addBefore(Song songin, Song songnew) {
    // on verifie que le premier element n est pas la chanson recherchee
    if(head.data.equals(songin)) {
        Node newHead = new Node(songnew, head);
        head = newHead;
    } else {
        Node runner = head;
        while(runner != tail) {
            if(runner.next.data.equals(songin)) {
                Node newNode = new Node(songnew, runner.next);
                runner.next = newNode;
                return;
            }
            runner = runner.next;
        }
    }
}

// Que se passe-t-il si la liste est vide (malgré les prés ?)
