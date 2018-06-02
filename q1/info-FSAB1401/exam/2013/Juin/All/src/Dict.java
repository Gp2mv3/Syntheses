/**
 * Un dictionnaire, sous forme d'un tableau de mots trié par ordre alphabétique, permettant une recherche efficace.
 *
 * @author O. Bonaventure, Ch. Pecheur, J-M Vlaeminck
 */
import java.util.*;
import java.io.*;

public class Dict
{
	public String[] dict; // le dictionnaire trié en ordre alphabétique

	/**
	 * Construit un dictionnaire à partir d'un fichier contenant une liste de mots.
	 * @pre filename!=null
	 * @post a construit un dictionnaire contenant les mots extraits du fichier {filename}. Les mots sont convertis en minuscules et triés par ordre alphabétique dans le tableau {dict}.
	 */
	public Dict(String filename)
	{
		/* Honteusement inspiré d'un post de StackOverflow :
		 * http://stackoverflow.com/questions/5343689/java-reading-a-file-into-an-arraylist
		 */
		Scanner sc=null;
		try {
			sc=new Scanner(new File(filename));
		} catch (IOException e) {
			System.err.println("Couldn't read dictionary.");
			System.exit(-1);
		}
		ArrayList<String> liste = new ArrayList<>();
		while(sc.hasNext())
			liste.add(sc.next().toLowerCase());
		sc.close();
		dict=liste.toArray(new String[0]);
		Arrays.sort(dict);
	}

	///// QUESTION 2 /////
	/**
	 * Teste si un mot est dans le dictionnaire.
	 * @pre s!=null
	 * @post retourne {true} si s est présent dans le dictionnaire et false sinon.
	 */
	public boolean contains(String s) {
		// Arrays est importé ; on peut utiliser binarySearch
		return Arrays.binarySearch(dict, s) >= 0;
	}
	// Si Arrays n'avait pas été importé, code d'une recherche binaire:
	public boolean contains2(String s) {
		int lower=0, upper=dict.length; // index inférieur et supérieur de recherche
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
	// Je ne suis pas complètement sûr du code ci-dessus.
}
