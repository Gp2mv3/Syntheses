// stably merge a[lo .. mid] with a[mid+1 ..hi] using aux[lo .. hi]
private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi) {
    // copy to aux[]
    for (int k = lo; k <= hi; k++) {
        aux[k] = a[k];
    }

    // merge back to a[]
    int i = lo, j = mid+1;
    for (int k = lo; k <= hi; k++) {
		// left half exhausted
        if      (i > mid)	a[k] = aux[j++];
		// right half exhausted
		else if (j > hi)	a[k] = aux[i++];
		// current key on right less than current key on left
		else if (less(aux[j], aux[i]))	a[k] = aux[j++];
		// current key on right greater than or equal to current key on left
        else	a[k] = aux[i++];
    }
}
