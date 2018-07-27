public class KruskalMST {
	private Queue<Edge> mst;

	public KruskalMST(EdgeWeightedGraph G) {
		mst = new Queue<Edge>();
		MinPQ<Edge> pq = new MinPQ<Edge>(G.edges());
		UF uf = new UF(G.V());
		while (!pq.isEmpty() && mst.size() < G.V() - 1) {
			Edge e = pq.delMin(); // Get min weight edge on pq
			int v = e.either(), w = e.other(v); // and its vertices.
			if (uf.connected(v, w))
				continue; // Ignore ineligible edges.
			uf.union(v, w); // Merge components.
			mst.enqueue(e); // Add edge to mst.
		}
	}

	public Iterable<Edge> edges() {
		return mst;
	}
	
	public double weight() // See Exercise 4.3.31.
}
