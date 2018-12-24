private int hash(Key x) {
	return (x.hashCode() & 0x7fffffff) % M);   //be careful! "&" means bitwise AND
}
