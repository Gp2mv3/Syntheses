/**
 * @pre  fileName != null
 * @post sauvegarde dans le fichier dont le nom est fileName
 *       toutes les mesures contenues dans la station, en ordre
 *       chronologique inverse, a raison d'une ligne de texte par mesure.
 *       Chaque ligne contient la mesure de pression 
 *       suivie du caractere ":" et de la mesure de temperature.
 *       En cas de probleme d'acces aux fichiers, affiche un message
 *       en francais puis interrompt le programme
 */
public void sauvegarde(String fileName)

