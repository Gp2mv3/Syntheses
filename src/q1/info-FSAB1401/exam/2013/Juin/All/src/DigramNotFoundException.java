/**
 * Exception lancée lorsque un digramme n'est pas présent dans un DigramStats.
 */
public class DigramNotFoundException extends Exception
{
	/**
	 * @pre msg != null
	 * @post construit une DigramNotFoundException avec le message {msg}
	 */
	 public DigramNotFoundException(String msg) {
	 	super(msg);
	}
}
// Voilà

