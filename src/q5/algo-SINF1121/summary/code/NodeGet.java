public Value get(Key key) {
	return get(root, key);
}

private Value get(Node x, Key key) {
	if (x == null)
		return null;

	int cmp = key.compareTo(x.key);
	if (cmp > 0)
		return get(x.right, key);
	else if (cmp < 0)
		return get(x.left, key);
	else
		return x.val;
}
