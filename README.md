# Synthèses de l'EPL

[![Join the chat at https://gitter.im/Nhoutain/Syntheses](https://badges.gitter.im/Nhoutain/Syntheses.svg)](https://gitter.im/Nhoutain/Syntheses?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
Les documents présents sur ce repository sont des documents
mis à disposition pour les étudiants de l'EPL.

## Visualisation des synthèses et correctifs
Les `.pdf` des synthèses et correctifs dans leur dernière version sont disponibles
[ici](https://www.dropbox.com/sh/mglnckwio1ug5x0/BgESQh2X2a).

Ces derniers sont aussi dans
[EPL-Backup](https://www.dropbox.com/sh/5a1dfg8e17bbgkw/bgVWq1icjf)
ainsi que d'autre documents utiles qui ne viennent pas de ce repository.

## Documentation
Ce README donne quelques premières indications
quant à l'utilisation de ce repository.
Pour de plus amples informations,
voir le
le document [How_to_Contribute](https://www.dropbox.com/s/s48t7iv4n6xotya/How_to_Contribute.pdf?dl=0)
ou le [wiki](https://github.com/Gp2mv3/Syntheses/wiki).

## Comment contribuer
La façon la plus simple de contribuer est de suggérer des améliorations
en soumettant une issue sur le
[bug tracker](https://github.com/Gp2mv3/Syntheses/issues).
Même pour une simple faute d'orthographe, ça vaut la peine de le signaler.

Vous pouvez aussi directement modifier le code et nous le soumettre
en utilisant `git`, voir le document
[How_to_Contribute.pdf](https://www.dropbox.com/s/s48t7iv4n6xotya/How_to_Contribute.pdf?dl=0)
pour une explication rapide.
Pour une explication plus détaillée, lisez la partie *Utilisation linéaire de Git* de
[ce tutoriel](http://sites.uclouvain.be/SystInfo/notes/Outils/html/git.html)
écrit par Benoît Legat.
Voir aussi le [wiki](https://github.com/Gp2mv3/Syntheses/wiki) à ce sujet.

Vous pouvez visualiser le statut des différentes synthèses
[ici](https://github.com/Gp2mv3/Syntheses/wiki/Status).
N'hésitez pas à en rajouter dans la liste :)

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
          quadri: &quadris
            [1, 2, 3, 4, 5, 6, 7, 8]
          cours: &courses
            - AnalyseQuantitatives
            - autolin
            - ca
            - chimie
            - chimieorga
            - eco
            - elec
            - GRH
            - info
            - math
            - methodnum-FSAB1104
            - mmc-MECA1901
            - coo
            - opti
            - oz
            - philo
            - physique
            - prostoch
            - sigsys
            - math-FSAB1101
            - math-FSAB1103
            - stat-FSAB1105
            - elec-FSAB1201
            - meca-FSAB1201
            - chimie-FSAB1302
            - matstruct-AUCE1031
            - geomat-AUCE1171
            - stat-BIR1304
            - gpo-ECGE1223
            - strat-ECGE1315
            - tdo-ECGE1317
            - mana-ECGE1321
            - dispo-ELEC1330
            - magn-ELEC1350
            - ELEC1370
            - circ-ELEC1530
            - telecom-ELEC1930
            - crypto-ELEC2760
            - ELEC2870
            - mcp-INGI1122
            - calcu-INGI1123
            - oz-INGI1131
            - INGI1341
            - translators-INGI2132
            - network2-INGI2142
            - concurrent-INGI2143
            - cloud-INGI2145
            - database-INGI2172
            - archi-INGI2241
            - ia-LINGI2261
            - algo-INGI2266
            - secu-INGI2347
            - constraint-INGI2365
            - ananum-INMA1170
            - matrix-INMA2380
            - opticombi-INMA2450
            - nlp-INMA2460
            - modstoch-INMA2470
            - INMA2471
            - grh-LSMG2004
            - edo-MAT1223
            - MAT2440
            - crypto-MAT2450
            - dam-MECA1210
            - algo-SINF1121
            - os-SINF1225
            - distributed-SINF2345
          type:
            - exercises
            - errata
            - mcq
            - notes
            - summary
          sol: ['', '-Sol']
        input: &input_path
          path_format: q{0}/{1}/{2}/{1}-{2}{3}.pdf
          parameters:
            - arg: quadri
            - arg: cours
            - arg: type
            - arg: sol
        output:
          path_format: Synthèses_EPL/q{0}/{1}/{2}
          parameters:
            - arg: quadri
            - arg: cours
            - path_format: "{0}/{1}"
              parameters:
              - arg: type
              - &output_file
                path_format: "{0}_q{1}_{2}{3}.pdf"
                parameters:
                - mapping:
                    exercises: APE
                    notes: CM
                    summary: Synthèse
                  key:
                    arg: type
                - arg: quadri
                - arg: cours
                - arg: sol
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
                  ca: Complément d'Analyse
                  elec-FSAB1201: PHYSIQUE
                  elec: PHYSIQUE
                  info: INFO
                  math: MATH
                  meca: PHYSIQUE
                  opti: OPTIMISATION
                  oz: OZ
                  philo: PHILO
                  physique: PHYSIQUE
                  prostoch: Processus Stochastiques
                  sigsys: SIGSYS
                  matrix-INMA2380: TDM
                  INMA2471: Opti
                key:
                  arg: cours
              - path_format: "{0}/{1}"
                parameters:
                - mapping:
                    exercises: APE
                    mcq: MCQ
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
            [prostoch, ca, matrix-INMA2380, nlp-INMA2460, modstoch-INMA2470, INMA2471]
          type: [exercises, mcq, notes, summary, errata]
          sol: ['', '-Sol']
        input: *input_path
        output:
          path_format: MAP/{0}
          parameters:
            - *EPL_style_output
      - name: Official Exam
        arguments: &all_args_exam
          quadri: *quadris
          cours:
            - math-FSAB1103
            - chimie-FSAB1302
            - info
            - matstruct-AUCE1031
            - stat-BIR1304
            - gpo-ECGE1223
            - strat-ECGE1315
            - mana-ECGE1321
            - mcp-INGI1122
            - calcu-INGI1123
            - oz-INGI1131
            - infoth-INGI2348
            - nlp-INMA2460
            - ananum-INMA1170
            - mmc-MECA1901
          type: [exam,test]
          year: &years
            [2009, 2010, 2011, 2012, 2013, 2014, 2015]
          month: &months
            [Janvier, Mars, Juin, Août, Novembre]
          minmaj: &minmajs
            [All, Mineure, Majeure]
          sol: &sols
            ['', '-Sol']
        input: &input_path_exam
          path_format: "q{0}/{1}/{2}/{3}/{4}/{5}/{1}-{2}-{3}-{4}-{5}{6}.pdf"
          parameters:
            - arg: quadri
            - arg: cours
            - arg: type
            - arg: year
            - arg: month
            - arg: minmaj
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
                  path_format: "{0}_{1}/{4}-{0}-{1}{2}{3}.pdf"
                  parameters:
                  - arg: year
                  - arg: month
                  - mapping:
                      All: ''
                      Mineure: -Mineure
                      Majeure: -Majeure
                    key:
                      arg: minmaj
                  - arg: sol
                  - mapping:
                      math-FSAB1103: FSAB1103
                      chimie-FSAB1302: FSAB1302
                      info: FSAB1402
                      matstruct-AUCE1031: AUCE1031
                      stat-BIR1304: BIR1304
                      gpo-ECGE1223: ECGE1223
                      strat-ECGE1315: ECGE1315
                      mana-ECGE1321: ECGE1321
                      oz-INGI1131: INGI1131
                      infoth-INGI2348: INGI2348
                      mcp-INGI1122: INGI1122
                      calcu-INGI1123: INGI1123
                      ananum-INMA1170: INMA1170
                      nlp-INMA2460: INMA2460
                      mmc-MECA1901: MECA1901
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
                    info: INFO
                  key:
                    arg: cours
                - path_format: "{0}/{1}"
                  parameters:
                  - mapping:
                      exam: Examens
                      test: Interros
                    key:
                      arg: type
                  - *output_end_exam
      - name: MAP Exam
        arguments:
          quadri: *quadri_map
          cours: *cours_map
          type: [exam,test]
          year: *years
          month: *months
          minmaj: *minmajs
          sol: *sols
        input: *input_path_exam
        output:
          path_format: MAP/{0}
          parameters:
            - *EPL_style_output_exam
      - name: Public Errata
        arguments:
          quadri: *quadris
          cours: [nlp-INMA2460]
          type: [errata]
          sol: *sols
        input: *input_path
        output:
          path_format: Errata/{0}
          parameters:
            - *EPL_style_output
