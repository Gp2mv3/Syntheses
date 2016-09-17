/**
 * Un ordinateur de base, supportant un seul processus et sans capacité de stockage.
 *
 * @author O. Bonaventure, Ch. Pecheur
 * @version 2016
 */
public class BasicComputer implements ComputerIF
{
    private String name; // Nom de l'ordinateur
    private Process proc; // processus éventuel, null si absent

    /**
     * @pre name != null
     * @post Construit un BasicComputer de nom name.
     */
    public BasicComputer(String name) {
        this.name=name;
    }

    /**
     * Voir ComputerIF.getName().
     */
    public String getName() {
        return name;
    }

    /**
     * Voir ComputerIF.addProcess(Process p).
     * @pre p != null, p ne se trouve pas déjà sur cet ordinateur
     * @post le processus p a été ajouté à cet ordinateur, si aucun processus n'est présent et si p ne demande pas de stockage. Retourne true si le processus a été ajouté, false sinon.
     */
    public boolean addProcess(Process p) {
        if(proc==null && p.getRequiredStorage()==0)
        {
            proc=p;
            return true;
        }
        else
            return false;
    }

    /**
     * Voir ComputerIF.removeProcess(Process p).
     * @pre p != null
     * @post le processus p a été retiré de cet ordinateur, s'il s'agit bien du processus présent. Retourne true si le processus a été supprimé, false sinon.
     */
    public boolean removeProcess(Process p) {
        if (proc==p)
        {
            proc=null;
            return true;
        }
        else
            return false;
    }

    /**
     * Voir ComputerIF.removeAllProcess().
     * Tous les processus de cet ordinateur ont été retirés. Retire proc s'il est actif.
     */
    public void removeAllProcess() {
        proc=null;
    }

    /**
     * Voir ComputerIF.getState().
     */
    public String getState() {
        if (proc != null) {
	    return proc.getDesc() + "\n";
	} else {
	    return "";
	}
    }
}
