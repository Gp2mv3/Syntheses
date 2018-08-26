public void put(Key key, Value val) {
	int i = rank(key);

	if (i < N && keys[i].compareTo(key) == 0) {
		vals[i] = val;
		return;
	}

	for (int j = N; j > i; j--) {
		keys[j] = keys[j-1]; vals[j] = vals[j-1];

	keys[i] = key; vals[i] = val;
	N++;
}
