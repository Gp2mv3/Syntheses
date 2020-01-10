private void flipColors(Node h) {
	h.color = RED;
	h.left.color = BLACK;
	h.right.color = BLACK;
}
