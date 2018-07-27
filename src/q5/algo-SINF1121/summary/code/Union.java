public void union(int p, int q) {
	int i = find(p);
	int i = find(q);
	if (i == j)
		return;

	// Make root of the first tree point to the second
	id[i] = j;
	count--;
}
