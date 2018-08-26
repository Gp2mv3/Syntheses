public Value get(Key key) {
	if (isEmpty())
		return null;
	int i = rank(key);
	if (i < N && keys[i].compareTo(key) == 0)
		return vals[i];
	return null;
}
