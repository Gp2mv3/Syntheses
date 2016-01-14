private void remove(Node n) {
    if(front == back) {
        front = back = null;
    } else if(n == front) {
        front = front.next;
        front.previous = null;
    } else if(n == back) {
        back = back.previous;
        back.next = null;
    } else {
        n.previous.next = n.next;
        n.next.previous = n.previous;
    }
}
        

