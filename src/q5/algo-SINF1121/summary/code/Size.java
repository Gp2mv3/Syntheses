public int size() {
     return size(root);
}

private int size(Node x) {
     if (x == null) return 0;
     else return x.N;
}
