/**
 * Une version étendue de {DigramStats} qui garde trace du nombre total de digrammes et de digrammes différents enregistrés dans les statistiques.
 */
public class DigramStatsWithTotals extends DigramStats
{
	private int nDistinctDigrams; // nombre de digrammes distincts dans la liste
	private int nDigrams; // nombre total de digrammes comptabilisés

	///// QUESTION 6 /////

	/**
	 * Voir {DigramStats}. Initialise les totaux à zéro.
	 */
	public DigramStatsWithTotals(Dict dict) {
		super(dict);
		nDistinctDigrams=0;
		nDigrams=0;
	}

	///// QUESTION 6 /////

	/**
	 * Voir {DigramStats}. Augmente les totaux comme nécessaire.
	 */
	public void add(Digram d) {
		super.add(d);
		if (getCount(d) <= 1) // il n'y avait pas le digramme avant
			nDistinctDigrams++;
		nDigrams++;
	}

	/**
	 * Voir {DigramStats}. Diminue les totaux comme nécessaire.
	 */
	public void remove(Digram d) throws DigramNotFoundException {
		if (getCount(d) <=1) // il n'y en a plus qu'un, ou moins
			nDistinctDigrams--;
		super.remove(d);
		nDigrams--;
	}

	/**
	 * Imprime les statistiques. Chaque digramme est imprimé sur {System.out}, ainsi que les comptes totaux.
	 */
	public void print() {
		super.print();
		System.out.println("Number of distincts digrams: "+nDistinctDigrams);
		System.out.println("Total number of digrams: "+nDigrams);
	}
	// TODO: pas sûr de l'utilité du super pour getCount
}
