Synthèses de l'EPL
=================
Les documents présents sur ce repository sont des documents mis à disposition pour les élèves de l'EPL.

Documentation
-------------
Ce README donne quelques premières indications quand à l'utilisation de ce repository.
Pour de plus amples informations, voir le [wiki](https://github.com/Gp2mv3/Syntheses/wiki).

Utilisation
-----------
### Télécharger les synthèses
Les *.pdf* des synthèses sont disponibles
[ici](https://www.dropbox.com/sh/mglnckwio1ug5x0/BgESQh2X2a).

### Compiler
Il y a des **Makefile** à côté des *.tex*, ils servent à les compiler en *.pdf*.
Voici comment les utiliser:
> Allez dans le bon répertoire (le même qu'où se trouve le **Makefile**) et écrivez (sans le `$`)
> 
	$ make
> Ca crée un *.pdf* à partir du *.tex* dans le même répertoire
>
	$ make release
>
> Ca met le *.pdf* à jour dans le dossier correspondant à l'extérieur de **src**
>
	$ make clean
>
> Ca supprime tous les fichiers intermédiaires de compilation.
> Parfois, quand le compilateur fait une erreur incompréhensible, elle est en fait due à un fichier intermédiaire qui est mauvais à cause d'un fichier qui a été bougé ou quelque chose comme ça. Un `$ make clean` est dans ces cas très utile.

Package nécessaires pour compiler
---------------------------------
Il vous sera parfois nécessaire d'avoir une installation plutôt complète de **LaTeX** pour compiler certains fichiers.

Si vous êtes sur **Linux**, assurez-vous que vous avez installé les packets suivants (si vous avez installé le packet **texlive-full**, vous devriez tous les avoir)

* **texlive**
* **texlive-fonts-extra**
* **texlive-latex-extra**
* **texlive-math-extra**
* **texlive-science**
* **texlive-lang-french**
* **chemfig** - Pas disponible pour texlive 2009

Sinon, vous pouvez très simplement installer **LaTeX** par [vous même](http://tug.org/texlive/acquire-netinstall.html), ainsi vous êtes sûr d'avoir la version la plus à jour.
Plus d'info [ici](http://tex.stackexchange.com/questions/1092/how-to-install-vanilla-texlive-on-debian-or-ubuntu/39162#39162).
