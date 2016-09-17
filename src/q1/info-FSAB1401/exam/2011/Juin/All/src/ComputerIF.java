
/**
 * Un ordinateur, sur lequel on peut ajouter et retirer des processus.
 * L'ordinateur dispose de ressources (nombre de processus, volume de stockage) éventuellement limitées, et donc peut refuser l'ajout de processus supplémentaire.
 * Un ordinateur a un nom.
 *
 * @author O. Bonaventure, Ch. Pecheur
 * @version Dec 2007
 */
public interface ComputerIF
{
    /**
     * @pre p != null, p ne se trouve pas déjà sur cet ordinateur
     * @post le processus a été ajouté à cet ordinateur, si les ressources nécessaires sont disponibles. Retourne true si le processus a été ajouté, false sinon.
     */
    public boolean addProcess(Process p);
    
    /**
     * @pre p != null
     * @post le processus a été retiré de cet ordinateur, si ce processus se trouve sur cet ordinateur, et libère les ressources occupées. Retourne true si le processus a été supprimé, false sinon.
     */
    public boolean removeProcess(Process p);

    /**
     * @pre -
     * @post Tous les processus de cet ordinateur ont été retirés.
     */
    public void removeAllProcess();

    /**
     * @pre -
     * @post Retourne la liste des processus de cet ordinateur sous forme de texte, avec une ligne par processus,
     *       chaque ligne comprenant le nom du processus et sa taille de stockage, séparés par un espace,
     *       et se termine par un passage à la ligne. Par exemple:
     *
     *       process1 0
     *       bigprocess 666
     *       smallprocess 42
     */
    public String getName();
}
