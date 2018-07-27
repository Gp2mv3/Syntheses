public void delete(String key) {
	root = delete(root, key, 0);
}

private Node delete(Node x, String key, int d) {
	if (x == null)
		return null;
	if (d == key.length()) {
		x.val = null;
	} else {
		char c = key.charAt(d);
		x.next[c] = delete(x.next[c], key, d+1);
	}

	if (x.val != null)
		return x;

	for (char c = 0; c < R; c++) {
		if (x.next[c] != null)
			return x;
	}
	return null;
}
