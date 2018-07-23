public int rank(Key key) {
     int lo = 0, hi = N-1;
     while(lo <= hi) {
          int mid = low + (hi - lo)/2;
          int cmp = key.compareTo(keys[mid]);
          if		(cmp < 0) hi = mid-1;
          else if 	(cmp > 0) lo = mid+1;
          else	 return mid;
     }

     return lo;
}
