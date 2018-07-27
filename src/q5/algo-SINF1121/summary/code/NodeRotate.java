private Node rotateLeft(Node h) {
	Node x = h.right;
	h.right = x.left;
	x.left = h;
	x.color = h.color;
	h.color = RED;
	x.N = h.N;
	h.N = 1 + size(h.left) + size(h.right);
	return x;
}

private Node rotateRight(Node h) {
	Node x = h.left;
	h.left = x.right;
	x.right = h;
	x.color = h.color;
	h.color = RED;
	x.N = h.N;
	h.N = 1 + size(h.left) + size(h.right);
	return x;
}
