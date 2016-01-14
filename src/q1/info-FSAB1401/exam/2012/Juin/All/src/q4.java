public void addBefore(Song songin, Song songnew) {
    assert songin != null : "songin n'est pas defini";
    assert songnew != null : "songnew n'est pas defini";

    // on verifie que songin est present dans la playlist
    boolean inPlayList = false;
    Node runner = head;
    while(runner != null) {
        if(runner.data.equals(songin))
            inPlayList = true;
        runner = runner.next;
    }
    assert inPlayList : "songin n'est pas dans la playlist";

    if(head.data.equals(songin)) {
        Node newHead = new Node(songnew, head);
        head = newHead;
    } else {
        runner = head;
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
