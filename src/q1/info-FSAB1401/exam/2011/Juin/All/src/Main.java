/**
 * Classe de test du code Java de l'examen 2011
 * @author Jean-Martin Vlaeminck
 * @version 2017
 */
public class Main
{
	public static void main(String[] args)
	{
		Cluster cl=new Cluster();
		Process[] processus = new Process[] {
			new Process("vi", 1),
			new Process("Emacs", 200), // ;p
			new Process("Firefox", 450),
			new Process("Vivaldi", 53),
			new Process("system idle", 0),
			new Process("Vivaldi", 432), // un onglet Facebook
			new Process("Vivaldi", 84),
			new Process("Texstudio", 42),
			new Process("Vivaldi", 177),
			new Process("Vivaldi", 242),
			new Process("Git", 3),
			new Process("system interrupts", 0),
			new Process("LibreOffice", 150),
			new Process("MATLAB", 670),
			new Process("GNU Octave", 335)
		}; // Tous ces chiffres sont bien sur fictifs
		ComputerIF[] comps = new ComputerIF[] {
			new BasicComputer("Macbook Pro 2016"), // :p
			new FullComputer("ThinkPad P50", 6, 1000),
			new FullComputer("Cray", 15, 600),
			new FullComputer("Dell XPS", 4, 750),
			new BasicComputer("Chromebook")
		};
		for (int i=0; i<comps.length; i++) {
			cl.addComputer(comps[i]);
		}
		int compte=0;
		for (int j=0; j<processus.length; j++) {
			try {
				cl.addProcess(processus[j]);
				compte++;
			} catch (Cluster.UnavailableException e) {
				System.out.println("Probleme avec "+processus[j].getName()+" ("+e.getMessage()+")");
				if (j==0) {System.out.println("WTF"); continue;}
				try {
					cl.removeProcess(processus[j-1]);
					cl.addProcess(processus[j]);
					compte++;
				} catch (Cluster.UnavailableException f) {
					System.out.println("Unable to add process "+processus[j].getName()+". Skipping ("+f.getMessage()+")");
				}
			}
		}
		System.out.println("Etat 1:\n"+cl);
		cl.saveState("output.txt");
		cl.removeComputer(comps[1]);
		System.out.println("Etat 2:\n"+cl);
		cl.saveState("output1.txt");
		System.out.println(compte+" processus actifs");
		for (int j=0; j<processus.length; j++) {
			try {
				cl.removeProcess(processus[j]);
				compte--;
			} catch (Cluster.UnavailableException e) {
				System.out.println("Processus "+processus[j].getName()+" disparu. ("+e.getMessage()+")");
			}
			try {

				cl.addProcess(processus[j]);
				compte++;
			} catch (Cluster.UnavailableException e) {
				System.out.println("Pas assez de place pour "+processus[j].getName()+". ("+e.getMessage()+")");
			}
		}
		System.out.println("Etat 3:\n"+cl);
		System.out.println(compte+" processus actifs");
		cl.saveState("output2.txt");
		ComputerIF[] comps2 = new ComputerIF[] {
			new BasicComputer("Macbook"), // :p
			new FullComputer("ThinkPad Yoga", 3, 200),
			new FullComputer("Cray", 15, 600),
			new FullComputer("Dell XPS", 4, 750),
			new BasicComputer("Chromebook"),
			new FullComputer("Mac Pro", 10, 2000)
		};
		for (int i=0; i<comps2.length; i++)
			cl.addComputer(comps2[i]);
		cl.loadState("input.txt");
		System.out.println("Etat 4:\n"+cl);
		cl.saveState("output2.txt");

	}
}
