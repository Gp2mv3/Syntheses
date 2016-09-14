/*
 * Ceci n'est qu'une partie de la classe DigramStatsWithTotals.
 * Elle n'est donc pas fonctionnelle.
 */

/*
 * Voir {DigramStats}. Initialise les totaux à zéro.
 */
public DigramStatsWithTotals(Dict dict) {
	super(dict);

	nDistinctDigrams=0;
	nDigrams=0;
}

/*
 * Voir {DigramStats}. Augmente les totaux comme nécessaire.
 */
public void add(Digram d) {
	super.add(d);
	if (super.getCount(d) <= 1) // il n'y avait pas le digramme avant
		nDistinctDigrams++;
	nDigrams++;
}
// TODO: pas sûr de l'utilité du super pour getCount
