public Iterable<String> keysThatMatch(String pat) {
	Queue<String> q = new Queue<String>();
	collect(root, "", pat, q);
	return q;
}

public void collect(Node x, String pre, String pat, Queue<String> q) {
	int d = pre.length();
	if (x == null)
		return;
	if (d == pat.length() && x.val != null)
		q.enqueue(pre);
	if (d == pat.length())
		return;
	char next = pat.charAt(d);
	for (char c = 0; c < R; c++) {
		if (next == '.' || next == c)
			collect(x.next[c], pre + c, pat, q);
	}
}
