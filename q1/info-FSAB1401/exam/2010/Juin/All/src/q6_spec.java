/**
 * @pre  fileName != null
 * @post sauvegarde dans le fichier dont le nom est fileName
 *       toutes les mesures contenues dans la station, en ordre
 *       chronologique inverse, à raison d'une ligne de texte par mesure.
 *       Chaque ligne contient la mesure de pression 
 *       suivie du caractère ":" et de la mesure de temperature.
 *       En cas de problème d'accès aux fichiers, affiche un message
 *       en francais puis interrompt le programme.
 */
public void sauvegarde(String fileName)

