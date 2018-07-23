public static void inOrder(Node h) {
	if(t != null) {
		inOrder(t.left);
		visit(t);
		inOrder(t.right);
	}
}
