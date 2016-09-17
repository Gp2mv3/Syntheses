
/**
 * Un ordinateur avec capacité de stockage limitée et nombre de processus limité.
 * 
 * @author O. Bonaventure, Ch. Pecheur
 * @version 2016
 */
public class FullComputer extends BasicComputer
{
    /**
     * Les processus présents sur cet ordinateur. Les processus sont dans
     * procs[0] .. procs[count-1] et procs[i]==null pour i>count
     */
    private Process[] procs;
    private int count;        // nombre de processus présents
    private int storage;      // capacité de stockage totale
    private int availStorage; // capacité de stockage restante

    /**
     * @pre n>0, name!=null, storage>=0
     * @post Construit un FullComputer de nom name, supportant n processus et avec une capacité de stockage égale à storage.
     */
    public FullComputer(String name, int n, int storage)
    {
        super(name);
        this.storage = this.availStorage = storage;
        count=0;
        procs=new Process[n];
    }

    /**
     * Voir ComputerIF.addProcess(Process p) et super.addProcess(Process p).
     * @pre p!=null, p ne se trouve pas déjà sur cet ordinateur
     * @post le processus p a été ajouté à cet ordinateur, si
     *       (1) le nombre de processus maximal n'est pas atteint et
     *       (2) la capacité de stockage nécessaire pour p est disponible.
     *       Retourne true si le processus a été ajouté, false sinon.
     */
    public boolean addProcess(Process p)
    {
        if (count>=procs.length || p.getRequiredStorage()>availStorage)
            return false;
        procs[count]=p;
        count++;
        availStorage -= p.getRequiredStorage();
        return true;
    }

    // Reste du code non fourni
}

