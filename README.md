# Synthèses de l'EPL
Les documents présents sur ce repository sont des documents
mis à disposition pour les étudiants de l'EPL.

## Visualisation des synthèses et correctifs
Les `.pdf` des synthèses et correctifs dans leur dernière version sont disponibles
[ici](https://www.dropbox.com/sh/mglnckwio1ug5x0/BgESQh2X2a).

Vous pourriez aussi être intéressés par
[EPL-Backup](https://www.dropbox.com/sh/5a1dfg8e17bbgkw/bgVWq1icjf)
et
[EPL-Heavy](https://www.dropbox.com/sh/tn2r9y2m4d4o03m/AzfvTnqwv5).

## Documentation
Ce README donne quelques premières indications
quant à l'utilisation de ce repository.
Pour de plus amples informations,
voir le [wiki](https://github.com/Gp2mv3/Syntheses/wiki).

## Comment contribuer
La façon la plus simple de contribuer est de suggérer des améliorations
en soumettant une issue sur le
[bug tracker](https://github.com/Gp2mv3/Syntheses/issues).

Vous pouvez aussi directement modifier le code et nous le soumettre
en utilisant `git`,
plus d'infos sur `git`,
lisez la partie *Utilisation linéaire de Git* de
[ce tutoriel](http://sites.uclouvain.be/SystInfo/notes/Outils/html/git.html)
écrit par Benoît Legat, jetez aussi un oeil dans le
[wiki](https://github.com/Gp2mv3/Syntheses/wiki).

Vous pouvez visualiser le statut des différentes synthèses
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
Commencez par créer un dossier `info` dans le dossier `q2` et
ajoutez-y le `info.mk` suivant

    COURSE=info
    include ../../q2.mk

Créer ensuite le dossier `summary`.
Dedans, créez le fichier `Makefile` suivant

    TYPE=summary
    include ../info.mk

Ajoutez ensuite le fichier `info-summary.tex` suivant,
en supposant que vous vous appeliez Jean Dupont, que le cours
soit `FSAB1402` et qu'il soit donné par John Doe

    \documentclass[fr]{../../../eplsummary}

    \hypertitle[']{Informatique}{2}{FSAB}{1402}
    {Jean Dupont}
    {John Doe}

    \end{document}
L'argument `[']` doit être enlevé si le nom du cours
ne commence pas par une voyelle.
Le `\begin{document}`, le titre et la table des matières
sont fait par `\hypertitle`.
Pas mal de nouvelles commandes sont aussi créées.
Ouvrez le fichier `eplcommon.sty` pour plus d'information.

Vous pouvez alors ajouter le contenu de votre synthèse entre
`\hypertitle` et `\end{document}`.
Vous pouvez aussi ajouter des choses dans le préambule en les
ajoutant entre `\documentclass` et `\hypertitle`.

### Package nécessaires pour compiler
Il vous sera parfois nécessaire d'avoir une installation plutôt complète de
**LaTeX** pour compiler certaines synthèses.

Si vous êtes sur **Linux**,
assurez-vous que vous avez installé les paquets suivants
(si vous avez installé le paquet **texlive-full**, vous devriez tous les avoir)

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
      - name: Official
        arguments: &all_args
          quadri: [1, 2, 3, 4, 5, 6, 7, 8]
          cours: &courses
            - AnalyseQuantitatives
            - autolin
            - ca
            - Calcu2
            - chimie
            - chimieorga
            - eco
            - edo
            - elec
            - GRH
            - info
            - math
            - mcp
            - meca
            - methodnum
            - mmc
            - coo
            - opti
            - os
            - oz
            - philo
            - physique
            - prostoch
            - sigsys
            - stat
            - telecom
            - ELEC1370
            - ELEC2870
            - INGI1341
            - concu-LINGI2143
            - ia-LINGI2261
            - INMA2380
            - INMA2471
            - MAT2440
            - distributed-LSINF2345
            - secu-INGI2347
          type:
            - exercises
            - notes
            - summary
        input: &input_path
          path_format: q{0}/{1}/{2}/{1}-{2}.pdf
          parameters:
            - arg: quadri
            - arg: cours
            - arg: type
        output:
          path_format: Synthèses_EPL/q{0}/{1}/{2}
          parameters:
            - arg: quadri
            - arg: cours
            - path_format: "{0}/{1}"
              parameters:
              - arg: type
              - &output_file
                path_format: "{0}_q{1}_{2}.pdf"
                parameters:
                - mapping:
                    exercises: APE
                    notes: CM
                    summary: Synthèse
                  key:
                    arg: type
                - arg: quadri
                - arg: cours
      - name: EPL Backup
        arguments: *all_args
        input: *input_path
        output:
          path_format: EPL-Backup/{0}
          parameters:
            - &EPL_style_output
              path_format: "Q{0}/{1}/{2}"
              parameters:
              - arg: quadri
              - mapping:
                  autolin: Automatique Linéaire - LINMA1510
                  chimie: CHIMIE
                  chimieorga: CHIMIEORGA
                  coo: COO
                  eco: ECO
                  edo: EDO
                  ca: Complément d'Analyse
                  elec: PHYSIQUE
                  info: INFO
                  math: MATH
                  meca: PHYSIQUE
                  methodnum: METHODNUM
                  mmc: MMC
                  opti: OPTIMISATION
                  os: OS
                  oz: OZ
                  philo: PHILO
                  physique: PHYSIQUE
                  prostoch: Processus Stochastiques
                  sigsys: SIGSYS
                  stat: STAT
                  INMA2380: TDM
                  INMA2471: Opti
                key:
                  arg: cours
              - path_format: "{0}/{1}"
                parameters:
                - mapping:
                    exercises: APE
                    notes: CM
                    summary: Synthèses
                  key:
                    arg: type
                - *output_file
      - name: MAP
        arguments:
          quadri: &quadri_map
            [5, 6, 7, 8]
          cours: &cours_map
            [prostoch, ca, INMA2380, INMA2471]
          type: [exercises, notes, summary]
        input: *input_path
        output:
          path_format: MAP/{0}
          parameters:
            - *EPL_style_output
      - name: Official Exam
        arguments: &all_args_exam
          quadri: [3]
          cours: [math]
          type: [exam]
          year: [2011, 2012, 2013]
          month: [Janvier, Juin, Août]
          sol: ['', '-Sol']
        input: &input_path_exam
          path_format: "q{0}/{1}/{2}/{3}/{4}/{1}-{2}-{3}-{4}{5}.pdf"
          parameters:
            - arg: quadri
            - arg: cours
            - arg: type
            - arg: year
            - arg: month
            - arg: sol
        output:
          path_format: "Synthèses_EPL/{0}"
          parameters:
            - path_format: "q{0}/{1}/{2}/{3}"
              parameters:
                - arg: quadri
                - arg: cours
                - arg: type
                - &output_end_exam
                  path_format: "{0}_{1}/{3}-{0}-{1}{2}.pdf"
                  parameters:
                  - arg: year
                  - arg: month
                  - arg: sol
                  - mapping:
                      math: FSAB1103
                    key:
                      arg: cours
      - name: EPL Backup Exam
        arguments: *all_args_exam
        input: *input_path_exam
        output:
          path_format: EPL-Backup/{0}
          parameters:
            - &EPL_style_output_exam
              path_format: "Q{0}/{1}/{2}"
              parameters:
                - arg: quadri
                - mapping:
                    math: MATH
                  key:
                    arg: cours
                - path_format: "{0}/{1}"
                  parameters:
                  - mapping:
                      exam: Examens
                    key:
                      arg: type
                  - *output_end_exam
      - name: MAP Exam
        arguments:
          quadri: *quadri_map
          cours: *cours_map
          type: [exam]
        input: *input_path_exam
        output:
          path_format: MAP/{0}
          parameters:
            - *EPL_style_output_exam
