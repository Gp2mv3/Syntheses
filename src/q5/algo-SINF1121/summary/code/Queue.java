public class Queue<Item> implements Iterable<Item> {
	private int N;         // number of elements in queue
	private Node first;    // beginning of queue
	private Node last;     // end of queue

	private class Node {
		private Item item;
		private Node next;
	}

	public Queue() {
		first = null;
		last  = null;
	}

	public boolean isEmpty() {
		return first == null;
	}

	public int size() {
		return N;
	}

	public int length() {
		return N;
	}

	public void enqueue(Item item) {
		Node x = new Node();
		x.item = item;
		if (isEmpty()) {
			first = x;
			last = x;
		} else {
			last.next = x;
			last = x;
		}
		N++;
	}

	public Item dequeue() {
		if (isEmpty())
			throw new RuntimeException("Queue underflow");
		Item item = first.item;
		first = first.next;
		N--;
		if (isEmpty())
			last = null; // to avoid loitering
		return item;
	}
}
