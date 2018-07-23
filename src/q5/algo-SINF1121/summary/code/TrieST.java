public class TrieST<Value>
{

   private static int R = 256; // radix or number of possible characters
   private Node root;
   // root of trie

   private static class Node
   {
	private Object val;
	private Node[] next = new Node[R];
   }

   public Value get(String key)
   {
	Node x = get(root, key, 0);
	if (x == null) return null;
	return (Value) x.val;
   }

   private Node get(Node x, String key, int d)
   { // Return value associated with key in the subtrie rooted at x.
 	if (x == null) return null;
	if (d == key.length()) return x;
	char c = key.charAt(d); // Use dth key char to identify subtrie.
	return get(x.next[c], key, d+1);
   }

   public void put(String key, Value val)
   { root = put(root, key, val, 0); }

   private Node put(Node x, String key, Value val, int d)
   { // Change value associated with key if in subtrie rooted at x.
	if (x == null) x = new Node();
	if (d == key.length()) { x.val = val; return x; }
	char c = key.charAt(d); // Use dth key char to identify subtrie.
	x.next[c] = put(x.next[c], key, val, d+1);
	return x;
  }
}
