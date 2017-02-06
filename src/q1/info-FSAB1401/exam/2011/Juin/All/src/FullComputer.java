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

    ///// QUESTION 2 /////

    /**
     * @pre n>0, name!=null, storage>=0
     * @post Construit un FullComputer de nom name, supportant n processus
     *       et avec une capacité de stockage égale à storage.
     */
    public FullComputer(String name, int n, int storage)
    {
        super(name);
        this.storage = this.availStorage = storage;
        count=0;
        procs=new Process[n];
    }

    ///// QUESTION 4 /////

    /**
     * Voir ComputerIF.addProcess(Process p).
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

    // Reste du code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.

    /**
     * Voir ComputerIF.removeProcess(p).
     * @pre p!= null
     * @post le processus p a été supprimé de l'ordinateur, s'il y était,
     *       et les ressources ont été libérées. Retourne true si le processus
     *       a été supprimé, false sinon
     */
    public boolean removeProcess(Process p)
    {
        for (int i=0; i<count; i++) {
            if (procs[i]==p) {
                availStorage += procs[i].getRequiredStorage();
                for (int j=i; j<count-1; j++)
                    procs[j]=procs[j+1];
                count--;
                procs[count]=null;
                return true;
            }
        }
        return false;
    }

    /**
     * Voir ComputerIF.removeAllProcess()
     * @pre -
     * @post tous les processus et les ressources associées ont été libérées.
     */
    public void removeAllProcess()
    {
        for (int i=0; i<count; i++) {
            procs[i]=null;
        }
        availStorage=storage;
        count=0;
    }

    /**
     * Voir ComputerIF.getState()
     */
    public String getState()
    {
        StringBuffer sb = new StringBuffer();
        for (int i=0; i<count; i++) {
            sb.append(procs[i].getDescr());
            sb.append("\n");
        }
        return sb.toString();
    }

    public String toString()
    {
        return getName()+" :\n"+getState();
    }
}

