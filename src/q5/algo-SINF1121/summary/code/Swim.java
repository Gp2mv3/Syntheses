private void swim(int k) {
	while(k > 1 && less(k/2, k)) {
		exch(k/2, k);
		k = k/2;
	}
}
