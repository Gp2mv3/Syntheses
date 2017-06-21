/**
 * Exception correspondant à un coup illégal, par exemple dans une colonne pleine.
 *
 * @author O. Bonaventure and Ch. Pecheur
 * @version May 2009
 */

public class IllegalMoveException extends Exception
{
	public IllegalMoveException(String msg)
	{
		super(msg);
	}
}

