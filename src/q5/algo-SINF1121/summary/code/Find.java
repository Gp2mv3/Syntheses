public int find(int p) {
	while (p != id[p])
		p = id[p];
	return p;
}
