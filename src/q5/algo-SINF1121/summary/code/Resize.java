private void resize(int cap) {
	LinearProbingHashST<Key, Value> t;
	t = new LinearProbingHashST<Key, Value>(cap);
	for(int i = 0; i < M; i++) {
		if(keys[i] != null) {
			t.put(keys[i], vals[i]);
		}
	}

	keys = t.keys;
	vals = t.vals;
	M = t.M;
}
