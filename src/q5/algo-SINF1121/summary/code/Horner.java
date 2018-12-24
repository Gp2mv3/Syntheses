int hash = 0;
for (int i = 0; i < s.length(); i++)
	hash = (R * hash + s.charAt(i)) % M;
