///// QUESTION 1 /////
/**
 * Un digramme, c'est-à-dire une paire de mots.
 */
public class Digram
{
	private String mot1;
	private String mot2;

	/**
	 * @pre mots1 != null et mot2 != null
	 * @post construit un digramme formé des mots {mot1} et {mot2}
	 */
	public Digram(String mot1, String mot2)
	{
		// Pour plus de facilités, on définit un digramme comme contenant deux mots en minuscules.
		this.mot1=mot1.toLowerCase();
		this.mot2=mot2.toLowerCase();
	}

	/**
	 * @pre -
	 * @post renvoie le premier mot du digramme
	 */
	public String getWord1() {return mot1;}

	/**
	 * @pre -
	 * @post renvoie le second mot du digramme
	 */
	public String getWord2() {return mot2;}

	/**
	 * Détermine l'égalité de deux digrammes, indépendamment de l'ordre des mots ou de la casse
	 * @pre -
	 * @post retourne true si ce digramme et le digramme other contiennent les mêmes mots, sans tenir compte de la casse, et false sinon.
	 */
	public boolean equals(Object other) {
		if (other instanceof Digram) { // instanceof vérifie aussi que other != null
			Digram d = (Digram)other;
			/* a.equalsIgnoreCase(b) ignore la casse (majuscule/minuscule) des lettres
			 * et est équivalent à a.toLowerCase().equals(b.toLowerCase()) */
			return ( (this.mot1.equalsIgnoreCase(d.mot1)
			          && this.mot2.equalsIgnoreCase(d.mot2) )
			      || (this.mot1.equalsIgnoreCase(d.mot2)
				  && this.mot2.equalsIgnoreCase(d.mot1) ) );
		} else
			return false;
	}

	/**
	 * Retourne le contenu du digramme sous forme de texte.
	 * @pre -
	 * @post Retourne le contenu du digramme sous la forme "{mot1}-{mot2}"
	 */
	public String toString() {
		return (mot1.toLowerCase() + "-" + mot2.toLowerCase() );
	}
}

