Notes pour le mandatory solution:
C'est extrêmement chiant à faire.

Propositions d'améliorations:
- Redéfinir itemize/enumerate et leur commande \item pour que utiliser cette commande génère un statement, qui attend donc une solution.
  Si la solution n'est pas trouvée, indiquer dans le .aux qu'on s'attend à la trouver dans un \item correspondant d'un enumerate qui serait contenu dans un env solution.
- Dans un env solution, ce même environnement checkerait que tous les item trouvent une correspondance, et qu'il n'y en a pas d'autre.
- Si un \item est directement suivi de sa solution, alors il faut que dans cette solution il n'y ait qu'un seul item.
- On pourrait imaginer que l'on ne puisse pas mélanger les deux styles : si on trouve un \begin{solution} après un \item dans un enumerate/itemize de statement, alors ce env solution ne peut contenir qu'une seule solution, et chaque \item suivant doit avoir un \begin{solution} qui le suit. Et on ne peut pas avoir de env solution après l'enumerate. Si au contraire on ne trouve qu'un \item après le premier \item, alors on doit ne trouver aucun env solution dans le enumerate, et on doit trouver un enumerate avec le même nombre d'items que l'enumerate de l'énoncé.
- Pour l'affaire des section/subsection/etc: si on a \section puis \subsection puis env sol, alors on doit rencontrer un \subsection ou un \section avant de rencontrer un nouvel env sol ou un \nosol; on ne peut pas alors rencontrer de \subsubsection par exemple. Donc dès qu'on rencontre un env sol, on ne peut trouver que deux choses : soit un titre de même niveau; soit un titre de niveau supérieur. Dans les deux cas, ceux-ci gèrent comme ils veulent le fait qu'il y ait une solution ou non. Par contre, pour un titre d'un certain niveau, si on rencontre un titre de même niveau ou de niveau supérieur, sans avoir rencontré de solution, alors il y a une erreur.

