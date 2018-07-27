public void put(Key key, Value val) {
	root = put(root, key, val);
}

private Node put(Node x, Key key, Value val) {
	if (x == null)
		return new Node(key, val, 1);

	int cmp = key.compareTo(x.key);
	if (cmp > 0)
		x.right = put(x.right, key, val);
	else if (cmp < 0)
		x.left = put(x.left, key, val);
	else
		x.val = val;
	x.N = size(x.left) + size(x.right) + 1;
	return x;
}
