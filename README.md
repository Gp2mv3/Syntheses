# Synthèses de l'EPL
Les documents présents sur ce repository sont des documents
mis à disposition pour les élèves de l'EPL.

## Visualisation des Synthèses
Les `.pdf` des synthèses dans leur dernière version sont disponibles
[ici](https://www.dropbox.com/sh/mglnckwio1ug5x0/BgESQh2X2a).

Vous pourriez aussi être intéressés par
[EPL-Backup](https://www.dropbox.com/sh/5a1dfg8e17bbgkw/bgVWq1icjf)
et
[EPL-Heavy](https://www.dropbox.com/sh/tn2r9y2m4d4o03m/AzfvTnqwv5).

## Documentation
Ce README donne quelques premières indications
quand à l'utilisation de ce repository.
Pour de plus amples informations,
voir le [wiki](https://github.com/Gp2mv3/Syntheses/wiki).

## Comment contribuer
La façon la plus simple de contribuer est de suggérez des améliorations
en soumettant une issue sur le
[bug tracker](https://github.com/Gp2mv3/Syntheses/issues).

Vous pouvez aussi directement modifier le code et nous le soumettre
en utilisant `git`,
plus d'infos sur `git`,
lisez la partie *Utilisation linéaire de Git* de
[ce tutoriel](http://sites.uclouvain.be/SystInfo/notes/Outils/html/git.html)
écrit par Benoît Legat, jettez aussi un oeuil dans le
[wiki](https://github.com/Gp2mv3/Syntheses/wiki).

Vous pouvez visualiser le status des différentes synthèses
[ici](https://github.com/Gp2mv3/Syntheses/wiki/Status).

### Contribuer à une synthèse existante
Pour contribuer à une synthèse existante,
allez dans le dossier correspondant et modifier le `.tex` à l'aide
de votre IDE LaTeX favoris.
Pour le compiler,
faites le soit avec votre IDE, soit en console à l'aide du Makefile

    $ make
Vous pouvez aussi faire

	$ make clean
Ça supprime tous les fichiers intermédiaires de compilation.
Parfois, quand le compilateur fait une erreur incompréhensible,
elle est en fait due à un fichier intermédiaire qui est mauvais
à cause d'un fichier qui a été bougé ou quelque chose comme ça.
Un `$ make clean` est dans ces cas très utile.

### Ajouter un synthèse
Supposons que vous vouliez ajouter une synthèse d'`info`
pour `q2`.
Commençez par créer un dossier `info` dans le dossier `q2` et
ajoutez-y le `Makefile` suivant

    MAIN_NAME=info
    include ../q2.mk
Ajoutez ensuite le fichier `info.tex` suivant,
en supposant que vous vous appeliez Jean Dupont et que le cours
soit `FSAB1402`

    \input{../../lib.tex}

    \hypertitle{Informatique}{2}{FSAB}{1402}

    \end{document}
Le `\begin{document}`, le titre et la table des matières
sont fait par `\hypertitle`.
Pas mal de nouvelles commandes sont aussi créées.
Ouvrez le fichier `lib.tex` pour plus d'information.

Vous pouvez alors ajouter le contenu de votre synthèse entre
`\hypertitle` et `\end{document}`.
Vous pouvez aussi ajoutez des choses dans le préambule en les
ajoutant entre `\input` et `\hypertitle`.

### Package nécessaires pour compiler
Il vous sera parfois nécessaire d'avoir une installation plutôt complète de
**LaTeX** pour compiler certaines synthèses.

Si vous êtes sur **Linux**,
assurez-vous que vous avez installé les packets suivants
(si vous avez installé le packet **texlive-full**, vous devriez tous les avoir)

* **texlive**
* **texlive-fonts-extra**
* **texlive-latex-extra**
* **texlive-math-extra**
* **texlive-science**
* **texlive-lang-french**
* **chemfig** - Pas disponible pour texlive 2009

Sinon, vous pouvez très simplement installer **LaTeX** par
[vous même](http://tug.org/texlive/acquire-netinstall.html),
ainsi vous êtes sûr d'avoir la version la plus à jour.
Plus d'info
[ici](http://tex.stackexchange.com/questions/1092/how-to-install-vanilla-texlive-on-debian-or-ubuntu/39162#39162).

## Copier les synthèses à leur destination
Vous pouvez copier les synthèses automatiquement vers leur destination à l'aide de `make release` mais pour cela il vous faut d'abord spécifier les destination dans un fichier de configuration `src/config.yml` et installer
[`smartcp`](https://github.com/blegat/smartcp).
Vous pouvez trouver une explication sur l'écriture du fichier dans le lien de `smartcp`.
Comme exemple, voici le mien

    input_base: .
    output_base: /home/blegat/Dropbox
    clients:
      - name: Officiel
        arguments: &all_args
          quadri: [1, 2, 3, 4]
          cours: &courses
            - chimie
            - chimieorga
            - eco
            - edo
            - elec
            - info
            - math
            - meca
            - methodnum
            - coo
            - opti
            - os
            - philo
            - physique
            - sigsys
        input: &input_path
          path_format: q{0}/{1}/{1}.pdf
          parameters:
            - arg: quadri
            - arg: cours
        output:
          path_format: Synthèses_EPL/q{0}/{1}/{2}
          parameters:
            - arg: quadri
            - arg: cours
            - &output_file
              path_format: Synthèse_q{0}_{1}.pdf
              parameters:
              - arg: quadri
              - arg: cours
      - name: EPL Backup
        arguments: *all_args
        input: *input_path
        output:
          path_format: EPL-Backup/{0}
          parameters:
            - &EPL_style_output
              path_format: Q{0}/{1}/{2}
              parameters:
              - arg: quadri
              - mapping:
                  chimie: CHIMIE
                  chimieorga: CHIMIEORGA
                  eco: ECO
                  edo: EDO
                  elec: PHYSIQUE
                  info: INFO
                  math: MATH
                  meca: PHYSIQUE
                  methodnum: METHODNUM
                  coo: COO
                  opti: OPTIMISATION
                  os: OS
                  philo: PHILO
                  physique: PHYSIQUE
                  sigsys: SIGSYS
                key:
                  arg: cours
              - &output_end
                path_format: Synthèses/{0}
                parameters:
                - *output_file
      - name: EPL q3
        arguments:
          quadri: [3]
          cours: *courses
        input: *input_path
        output:
          path_format: EPL/{0}
          parameters:
            - *EPL_style_output
      - name: EPL q4
        arguments:
          quadri: [4]
          cours: [eco, sigsys]
        input: *input_path
        output:
          path_format: EPL/{0}
          parameters:
            - *EPL_style_output
      - name: UCL_EPL_BAC1
        arguments:
          quadri: [1, 2]
          cours: *courses
        input: *input_path
        output:
          path_format: UCL_EPL_BAC1/{0}
          parameters:
            - *EPL_style_output
      - name: MAP
        arguments:
          quadri: [3, 4]
          cours: [edo, opti]
        input: *input_path
        output:
          path_format: MAP/{0}
          parameters:
            - *EPL_style_output
      - name: INFO
        arguments:
          quadri: [3, 4]
          cours: [coo, os]
        input: *input_path
        output:
          path_format: INFO/{0}
          parameters:
            - *EPL_style_output
      - name: FYKI
        arguments:
          quadri: [3, 4]
          cours: [chimieorga]
        input: *input_path
        output:
          path_format: FYKI12/{0}/{1}
          parameters:
            - mapping:
                chimieorga: MAPR1230 CHIMIE ORGANIQUE
              key:
                arg: cours
            - *output_end
