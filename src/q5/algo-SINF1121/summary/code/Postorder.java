public static void postOrder(Node h) {
	if (t != null) {
		postOrder(t.left);
		postOrder(t.right);
		visit(t);
	}
}
