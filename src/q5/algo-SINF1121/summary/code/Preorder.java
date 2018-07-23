public static void preOrder(Node h) {
	if(t != null) {
		visit(t);
		preOrder(t.left);
		preOrder(t.right);
	}
}
