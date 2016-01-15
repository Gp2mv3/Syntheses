/**
 * @pre filename != null, filename est un nom de fichier qui
 * respecte le format ci-dessous :
 * La premiere ligne du fichier contient le nombre de chansons
 * dans le fichier. Chaque chanson occupe une ligne du fichier et
 * est de la forme
 *
 * Titre;Auteur;Duree
 *
 * Ou Titre est le titre de la chanson, Auteur son auteur
 * et Duree sa duree.
 *
 * @post Initialise le contenu du catalogue avec les chansons contenues
 * dans le fichier de nom (filename).
 *
 * En cas d erreur d entrees/sorties, le programme s arrete en
 * affichant un message d erreur en francais.
 */
public Catalog(String filename) {
