public class Node {
     private Key key;
     private Value val;
     private Node left, right;
     private int N;

     public Node(Key key, Value val, int N) {
          this.key = key; this.val = val; this.N = N;
     }
}
