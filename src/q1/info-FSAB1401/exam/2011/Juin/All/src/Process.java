///// QUESTION 3 /////

/**
 * Un processus ayant un nom, une capacité de stockage requise, un identifiant de processus (PID),
 * pouvant s'exécuter sur un ordinateur implémentant l'interface ComputerIF.
 * Les PID sont attribués séquentiellement à chaque nouveau processus créé, à partir de 1.
 *
 * @author Jean-Martin Vlaeminck
 * @version 2016/01/12
 */
public class Process
{
    private String name; // Nom du processus
    private int storage; // Capacité de stockage requise
    private int pid; // Identifiant de processus
    private static int nextPid = 1; // le PID libre suivant

    /**
     * @pre name != null, storage >= 0
     * @post Construit un processus ayant pour nom name, et pour capacité de stockage requise storage.
     */
    public Process(String name, int storage)
    {
        this.name = name;
        this.storage = storage;
        this.pid = nextPid++; // deux opérations d'un coup ! :)
    }

    /**
     * @pre -
     * @post retourne le nom du processus.
     */
    public String getName() {return name;}

    /**
     * @pre -
     * @post retourne la capacité de stockage requise du processus.
     */
    public int getRequiredStorage() {return storage;}

    /**
     * @pre -
     * @post retourne le PID du processus.
     */
    public int getPid() {return pid;}

    /**
     * @pre -
     * @post retourne une description du processus selon le format
     *       <nom du processus> <capacité de stockage requise>
     *       (format adapté aux méthodes getState de ComputerIF).
     */
    public String getDescr()
    {
        return name+" "+storage;
    }
}

