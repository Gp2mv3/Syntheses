public static double[][] multiplication(double[][] A, double[][] B) {
    // A est une matrice n*m et B est une matrice m*p
    int n = A.length, m = A[0.length], p = B[0].length;
    double[][] C = new double[A.length][B[0].length];
    for (int k = 0; k < n; k++) {
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < p; j++) {
                C[i][j] = C[i][j] + A[i][k] * B[k][j];
            }
        }
    }
    return C;
}
