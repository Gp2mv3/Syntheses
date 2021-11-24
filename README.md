# Synthèses de l'EPL

| **Documentation**  | **PDF** | **Chat** | **Forum** | **Git** |
|:------------------:|:-------:|:--------:|:---------:|:-------:|
| [<img src="https://cdn.pixabay.com/photo/2013/04/01/21/32/reading-99244_960_720.png" width="48">][doc-url] | [<img src="https://image.freepik.com/free-icon/pdf-file-format-symbol_318-45340.jpg" width="48">][pdf-url] | [![Join the chat at https://gitter.im/Gp2mv3/Syntheses](https://badges.gitter.im/Gp2mv3/Syntheses.svg)][chat-url] | [<img src="http://forum-epl.be/images/avatars/gallery/Photos/logo_phpBB.gif" width="96">][forum-url] | [<img src="https://gitforwindows.org/img/git_logo.png" width="48">][git-url]


Les documents présents sur ce repository sont des documents
mis à disposition pour les étudiants de l'EPL.

## Visualisation des synthèses et correctifs
Les `.pdf` des synthèses et correctifs dans leur dernière version sont disponibles
[ici][pdf-url].

## Documentation
Ce README donne quelques premières indications
quant à l'utilisation de ce repository.
Pour de plus amples informations,
voir le [guide pour les nouveaux contributeurs][doc-url]
ou le [wiki](https://github.com/Gp2mv3/Syntheses/wiki).

## Comment contribuer
La façon la plus simple de contribuer est de suggérer des améliorations
en soumettant une issue sur le
[bug tracker](https://github.com/Gp2mv3/Syntheses/issues).
Même pour une simple faute d'orthographe, ça vaut la peine de le signaler.

Vous pouvez aussi directement modifier le code et nous le soumettre
en utilisant `git`; le [guide pour les nouveaux contributeurs][doc-url]
donne une explication rapide de comment faire cela.
Pour une explication plus détaillée, lisez la partie *Utilisation linéaire de Git* de
[ce tutoriel](http://sites.uclouvain.be/SystInfo/notes/Outils/html/git.html)
écrit par Benoît Legat.
Voir aussi le [wiki](https://github.com/Gp2mv3/Syntheses/wiki) à ce sujet.

Nous vous recommandons d'utiliser le système des *branches* de Git,
qui permettent d'avoir en parallèle des changements différents sur des documents différents
(par exemple, un changement sur la synthèse de physique 1 et un ajout d'examen en algèbre),
avec la possibilité de facilement passer d'un groupe de changements à l'autre,
et d'ainsi ouvrir plusieurs *pull requests*, une par groupe de changements/thématique.
Cela vous permettra aussi de garder une branche *master* propre
et qui peut facilement être mise à jour avec ce repository (*fast-forward*).

Vous pouvez visualiser le statut des différentes synthèses
[ici](https://github.com/Gp2mv3/Syntheses/wiki/Status).
N'hésitez pas à en rajouter dans la liste :)

## Compiler automatiquement les documents en PDF
Vous pouvez compiler automatiquement tous les documents dans leur destination (le dossier où se trouve le fichier `.tex`) en tapant en ligne de commande à la racine du repository (dossier `Syntheses`):
* `make pdf` pour supprimer les fichiers de compilation
* `make` pour laisser les fichiers de compilation
* `make release` pour compiler **et** copier les documents automatiquement dans un dossier de destination à part, que vous aurez préalablement choisi en inscrivant le chemin absolu du dossier dans le fichier `compilation.yml` (copier et renommer `compilation.example.yml` en `compilation.yml`)

## License
Sauf mention expresse, vous licensiez sous license [CC-BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)
tout le contenu que vous soumettez pour inclusion dans ce dépot.

Si cette license vous pose problème, venez en discuter en ouvrant une [issue](https://github.com/Gp2mv3/Syntheses/issues/new).

[pdf-url]: https://uclouvain-my.sharepoint.com/personal/miguel_delecourt_student_uclouvain_be/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fmiguel%5Fdelecourt%5Fstudent%5Fuclouvain%5Fbe%2FDocuments%2FEPL%2DDrive
[doc-url]: https://drive.google.com/file/d/0B1axlYz3_XXKRzdGVWdGdUZ6UGs/view?usp=sharing&resourcekey=0-OJs4Mzz_eBpEbfdTmiUOgw
[chat-url]: https://gitter.im/Gp2mv3/Syntheses?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[forum-url]: http://forum-epl.be
[git-url]: https://try.github.io
