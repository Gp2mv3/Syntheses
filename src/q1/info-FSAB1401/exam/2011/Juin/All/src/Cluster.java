import static java.lang.System.*;
import java.io.*;

/**
 * Une grappe (Cluster) d'ordinateurs formant une ressource commune pour l'exécution de processus.
 *
 * @author O. Bonaventure, Ch. Pecheur, J-M Vlaeminck, S. Binard
 * @version 2016
 */
public class Cluster
{
    public static class ListNode {
        ListNode next;
        ComputerIF elem;
    }
    /*
     * La tête courante de la liste des ordinateurs. Les noeuds suivants sont chainés
     * de manière circulaire: la chaine finit toujours par revenir à current.
     */
    public ListNode current;
    public int count; // nombre d'ordinateur dans le cluster
    /**
     * Constructeur
     */
    public Cluster()
    {
        current=null;
        count=0;
    }

    ///// QUESTION 5 /////

    /**
     * @pre -
     * @post le processus p a été ajouté au premmier ordinateur, à partir de la tête de la liste, disposant des ressources nécessaires. La nouvelle tête de liste est le noeud qui suit cet ordinateur. Si aucun ordinateur ne dispose des ressources nécessaires, la tête de la liste est inchangée et une UnavailableException est lancée.
     */
    public void addProcess(Process p) throws UnavailableException
    {
        if (current==null) // pas d'ordinateur dans le cluster
            throw new UnavailableException("Cluster vide");
        ListNode runner=current;
        if (runner.elem.addProcess(p)) // si on a pu ajouter p à current
        {
            current=current.next;
            return;
        }
        runner=runner.next;
        // tant qu'on n'a pas pu ajouter et qu'on n'a pas bouclé
        while(!runner.elem.addProcess(p) && runner!=current)
            runner=runner.next;
        if (runner==current) // soit on a bouclé : pas d'ordi trouvé
            throw new UnavailableException("Pas d'espace disponible");
        current=runner.next; // on a trouvé ; on affecte la nouvelle tête
    }

    public void removeProcess(Process p) throws UnavailableException
    // Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
    {
        if (current==null) throw new UnavailableException("Cluster vide");
	ListNode runner=current;
        if (runner.elem.removeProcess(p)) // ça a marché
            return;
        runner=runner.next;
        while (!runner.elem.removeProcess(p) && runner != current)
        runner=runner.next;
        if (runner==current)
        throw new UnavailableException("Processus non trouve");
    }

    public void removeAllProcesses()
    // Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
    {
        ListNode runner=current;
        runner.elem.removeAllProcess();
        while (runner!=current) {
            runner.elem.removeAllProcess();
            runner=runner.next;
        }
    }

    /**
     * @pre comp != null, comp ne fait pas partie du cluster
     * @post L'ordinateur comp est ajoutée à la liste des ordinateurs. Le point d'insertion
     *       est entre current et son suivant.
     */
    public void addComputer(ComputerIF comp)
    {
        ListNode l=new ListNode();
        l.elem=comp;
        if(count==0)
        {
            l.next=l;
            current=l;
        }
        else
        {
            l.next=current.next;
            current.next=l;
        }
        count++;
    }

    ///// QUESTION 6 /////

    /**
     * @pre comp != null
     * @post L'ordinateur comp a été retiré du cluster, s'il s'y trouvait. Si comp est en tête de liste, celle-ci passe au noeud suivant, sinon elle est inchangée. Retourne true si comp a été retiré, false sinon.
     */
    public boolean removeComputer(ComputerIF comp)
    {
        if (count==0)
            return true; // ou false, c'est selon votre envie : comp n'y est plus, mais comp n'y a jamais été et comp n'a pas été retiré
        if (count==1) //un seul ordi
        {
            if (current.elem==comp)
            {
                current=null;
                count--; // don't forget me
                return true;
            }
            else
                return false;
        }

        ListNode runner=current;
        while(runner.next.elem!=comp && runner.next!=current)
            runner=runner.next;
        if (runner.next.elem==comp)
        {
            if(runner.next==current)
                current=runner.next.next; // on avance la tête
            runner.next=runner.next.next;
            count--; // don't forget me
            return true;
        }
        else
            return false;
    }

    /**
     * @pre filename est un nom de fichier
     * @post Le fichier filename contient l'état du cluster sous forme de texte. Pour chaque processus de chaque ordinateur du cluster, le fichier contient une ligne composée du nom et de la capacité demandée, séparés par une espace. Par exemple :
     *       BlueJ 1276
     *       Firefox 3224
     *       Emacs 297
     *       Terminal 27
     *       Le nom des ordinateurs sur lesques se trouvent les processus n'est pas sauvegardée. Arrête le programme si une erreur d'I/O se produit.
     */
    public void saveState(String filename)
    // Code non fourni à l'examen. Ce code a été rajouté pour permettre à la classe de compiler.
    {
        PrintWriter pw = null;
        try {
            pw = new PrintWriter(filename); // throws IOException
        } catch (IOException e) {
            System.err.println("Erreur d'ouverture du fichier");
            System.exit(-1);
        } if (pw==null) return;
        ListNode runner=current;
        pw.print(runner.elem.getState()); // PrintWriter ne jette pas d'exception à l'écriture.
        runner=runner.next;
        while (runner!=current) {
            pw.print(runner.elem.getState());
            runner=runner.next;
        }
        if (pw.checkError()) {
            System.err.println("Erreur d'écriture du fichier.");
            System.exit(-2);
        }
        pw.close(); // ne jette aucune exception
    }

    ///// QUESTION 7 /////

    /**
     * @pre filename le nom d'un fichier sauvegardé par saveState
     * @post Retire tous les processus présents dans le Cluster, puis ajoute au cluster les processus dont les noms et capacités sont donnés dans le fichier, selon le format généré par saveState. Arrête le programme si une erreur d'I/O se produit ou si la capacité du cluster est insuffisante. Les processus sont répartis équitablement entre les différents ordinateurs du cluster.
     */
    public void loadState(String fileName)
    {
        removeAllProcesses();// le cluster a toujours des ordis, mais sans processus
        BufferedReader bf=null;
        try {
            bf = new BufferedReader(new FileReader(fileName)); // throws IOException
            String ligne = bf.readLine(); // throws IOException
            while(ligne != null) {
                String[] lineTab = ligne.split(" ");
                Process p = new Process(lineTab[0], Integer.parseInt(lineTab[1])); // garanti sans exception par les specs
                try {
                    addProcess(p); // throws UnavailableException
                } catch(UnavailableException f) {
                    System.err.println("Erreur : capacité du cluster insuffisante");
                    bf.close(); // il faut fermer le fichier avant de planter
                    System.exit(-2);
                }
                ligne=bf.readLine(); // throws IOException
            }
            bf.close(); // tout s'est bien passé
        } catch (IOException e) {
            System.err.println("Erreur de lecture du fichier");
            if (bf!=null) // il faut fermer avant de planter
                try {
                    bf.close();
                } catch (IOException f) {
                    System.exit(-1);
                }
        }
    }
    /** code alternatif, mais qui ne ferme pas le fichier en cas d'erreur :
     * @author Sébastien Binard
     */
    public void loadStateSeb(String filename)
    {
        removeAllProcesses();
        try {
            BufferedReader bf = new BufferedReader(new FileReader(filename));
            String str=bf.readLine();
            int i;
            String[] tab;
            while(str!=null) {
                tab = str.split(" ");
                i=Integer.parseInt(tab[1]);
                addProcess(new Process(tab[0], i));
                str=bf.readLine();
            }
                bf.close();
        } catch (IOException e) {
            System.err.println("Erreur d'IO: "+e.getMessage());
            System.exit(-1);
        } catch (UnavailableException e) {
            System.err.println("Erreur, capacité du cluster insuffisante: "+e.getMessage());
            System.exit(-2);
        }
    }

    public String toString()
    {
        ListNode runner=current;
        StringBuffer sb=new StringBuffer();
        sb.append(runner.elem.toString());
        runner=runner.next;
        while (runner!=current) {
            sb.append(runner.elem.toString());
			runner=runner.next;
		}
        return sb.toString();
    }

    /**
     * Une exception utilisée lorsqu'une opération ne peut pas être effectuée par manque de ressources.
     *
     * @author O. Bonaventure, Ch. Pecheur
     * @version Dec. 2007
     */
    public static class UnavailableException extends Exception {
        public UnavailableException(String msg) {
            super(msg);
        }
    }
}

