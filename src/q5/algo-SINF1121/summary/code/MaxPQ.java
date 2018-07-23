public class MaxPQ<Key extends Comparable<Key>> {
	private Key[] pq;
	private int N = 0;

	public MaxPQ(int maxN) {
		pq = (Key[]) new Comparable[maxN+1];
	}

	public boolean isEmpty() { return N == 0; }
	public int size() { return N; }

	public void insert(Key v) {
		pq[++N] = v;
		swim(N);
	}

	public Key delMax() {
		Key max = pq[1];
		exch(1, N--);
		pq[N+1] = null;
		sink(1);
		return max;
	}
}
