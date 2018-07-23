public class RabinKarp
{
	private long patHash; // pattern hash value
	private int M; // pattern length
	private long Q; // a large prime
	private int R = 256; // alphabet size
	private long RM; // R^(M-1) % Q for use in removing leading digit

	public RabinKarp(String pat) {
		M = pat.length();
		Q = longRandomPrime();
		RM = 1;
		for (int i = 1; i <= M-1; i++) {
			RM = (R * RM) % Q;
		}

		patHash = hash(pat, M);
	}

	private long hash(String key, int M) {
		long h = 0;
		for(int j = 0; j < M; j++) {
			h = (R * h + key.charAt(j)) % Q;
		}

		return h;
	}

	private int search(String txt) {
		int N = txt.length();
		long txtHash = hash(txt, M);

		if(patHash == txtHash)	return 0; // match

		for(int i = M; i < N; i++) {
			txtHash = (txtHash + Q - RM*txt.charAt(i-M) % Q) % Q;
			txtHash = (txtHash*R + txt.charAt(i)) % Q;
			if(patHash == txtHash)
				return (i - M + 1);
		}

		return N; // no match
	}
}
