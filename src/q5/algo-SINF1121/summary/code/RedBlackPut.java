public void put(Key key, Value val) {
	root = put(root, key, val);
	root.color = BLACK;
}

private Node put(Node h, Key key, Value val) {
	// Do standard insert, with red link to parent.
	if (h == null)
		return new Node(key, val, 1, RED);

	int cmp = key.compareTo(h.key);
	if (cmp > 0)
		h.right = put(h.right, key, val);
	else if (cmp < 0)
		h.left = put(h.left, key, val);
	else
		h.val = val;

	if (isRed(h.left)  && isRed(h.left.left))
		h = rotateRight(h);
	if (!isRed(h.left) && isRed(h.right))
		h = rotateLeft(h);
	if (isRed(h.left)  && isRed(h.right))
		flipColors(h);

	h.N = 1 + size(h.left) + size(h.right);
	return h;
}
