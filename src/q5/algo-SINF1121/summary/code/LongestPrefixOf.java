public String longestPrefixOf(String s)
{
	int length = search(root, s, 0, 0);
	return s.substring(0, length);
}

private int search(Node x, String s, int d, int length)
{
	if (x == null) return length;
	if (x.val != null) length = d;
	if (d == s.length()) return length;
	char c = s.charAt(d);
	return search(x.next[c], s, d+1, length);
}
