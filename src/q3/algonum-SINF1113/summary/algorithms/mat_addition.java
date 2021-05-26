public static double[][] addition(double[][] A, double[][] B) {
    double[][] C = new double[A.length][A[0].length];
    for (int i = 0; i < C.length; i++) {
        for (int j = 0; j < C.length; j++) {
            C[i][j] = A[i][j] + B[i][j];
        }
    }
    return C;
}
