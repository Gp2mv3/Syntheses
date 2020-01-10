public Iterable<String> keys() {
	return keysWithPrefix("");
}

public Iterable<String> keysWithPrefix(String pre) {
	Queue<String> q = new Queue<String>();
	collect(get(root, pre, 0), pre, q);
	return q;
}

private void collect(Node x, String pre, Queue<String> q) {
	if (x == null)
		return;
	if (x.val != null)
		q.enqueue(pre);
	for (char c = 0; c < R; c++)
		collect(x.next[c], pre + c, q);
}
