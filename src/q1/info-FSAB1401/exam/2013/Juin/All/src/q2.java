// TODO : mettre ce code dans la classe Dict

public boolean contains(String s) {
	// Arrays est importé ; on peut utiliser binarySearch
	return Arrays.binarySearch(dict, s) >= 0;
}

// Si Arrays n'avait pas été importé, code d'une recherche binaire:
public boolean contains(String s) {
	int lower=0, upper=dict.length; // index inférieur et supérieur de recherche
	// Je ne suis pas complètement sûr du code ci-dessous.
	while(lower+1 < upper) {
		int mid = (lower + upper)/2;
		if (dict[mid].compareTo(s) > 0) // ce qu'on cherche est certainement à une po strict. < mid
			upper = mid;
		else // dict[mid].compareTo(s) <= 0  ce qu'on cherche est à une position >= lower
			lower = mid;
	}
	/* Lorsqu'on sort, lower + 1 = upper, donc ce qu'on cherche ne peut être que à lower ou alors,
	 * strictement en dessous de upper, donc en lower (même s'il est en dehors du tableau)
	 */
	return dict[lower].equals(s);
}

