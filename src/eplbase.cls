% http://ctan.mirrors.hoobly.com/macros/latex/doc/clsguide.pdf

% Rule of thumb: in class if specific to the class
%                in package if it can be in different class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplbase}[2015/01/14 EPL summary class]

\DeclareOption{en}{\PassOptionsToPackage{english}{babel}}
\DeclareOption{fr}{\PassOptionsToPackage{frenchb}{babel}}

% If you want to compile without it
\DeclareOption{skiptoc}{\newcommand{\skiptableofcontents}{}}
\DeclareOption{skiptitle}{\newcommand{\skiptitlepage}{}}

\DeclareOption{usereportclass}{\newcommand{\usereport}{}}

\DeclareOption*{\ClassError{eplbase}{I have not the faintest idea of what you wanted to do when you gave the the option ``\CurrentOption''. I could have just thrown a warning, ignore it and continue compiling but I think I will just stop here. Press ``H'' for help}{If you really don't understand why I say that, please ask on Github with an issue.}}

% relax is needed since \ProcessOptions* exists too
\ProcessOptions\relax

\ifcsname usereport\endcsname%
\LoadClass[11pt,a4paper]{report}
\else%
\LoadClass[11pt,a4paper]{article}
\fi%

\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

\RequirePackage{babel}
\RequirePackage{iflang}

\RequirePackage{ifthen}
\RequirePackage{url}

%%% SECTION TITLE APPEARANCE
\RequirePackage{sectsty}
\allsectionsfont{\sffamily\mdseries\upshape} % (See the fntguide.pdf for font help)
% (This matches ConTeXt defaults)

% Color
% cfr http://en.wikibooks.org/wiki/LaTeX/Colors
\RequirePackage{color}
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
\definecolor{dkgreen}{rgb}{0.25,0.7,0.35}
\definecolor{dkred}{rgb}{0.7,0,0}

%\RequirePackage{../../../eplcommon}

\newcommand{\annexe}{\part{Annexes}\appendix}

% Bibliography
\newcommand{\biblio}[1][plain]{\bibliographystyle{#1}\bibliography{biblio}}

\RequirePackage{fullpage}

% For multirow in tabular
\RequirePackage{multirow}
% For multiple columns like in beamer
\RequirePackage{multicol}

\RequirePackage{tikz}
\usetikzlibrary{positioning, calc}
\ifthenelse{\lengthtest{\pgfversion cm < 3.0 cm}}
{\typeout{You have an old version of Tikz: \pgfversion, try to update some time ;)}}
{\usetikzlibrary{babel}}

\RequirePackage{pdfpages}
%\usepackage{subfig}
% subfig is deprecated see
% http://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions#Subfloats
\usepackage{caption}
\usepackage{subcaption}

\usepackage{enumerate}

\RequirePackage{hyperref}

% le `[e ]' rend le premier argument (#1) optionnel
% avec comme valeur par défaut `e `
\newcommand{\basehypertitle}[8][e ]{

{\renewcommand{\and}{\unskip, }
\hypersetup{pdfauthor={#6},
            pdftitle={#8 #2 Q#3 - L#4#5},
            pdfsubject={#2}}
}

\title{\IfLanguageName{english}{#8 of }{#8 d#1}#2 Q#3 - L#4#5}
\author{#6}

\begin{document}

\ifthenelse{\isundefined{\skiptitlepage}}{
\begin{titlepage}
\maketitle

  \paragraph{\IfLanguageName{english}{Important Information}{Informations importantes}}
   \IfLanguageName{english}{This document is largely inspired from the excellent course given by}{Ce document est grandement inspiré de l'excellent cours donné par}
   #7
   \IfLanguageName{english}{at the }{à l'}%
   EPL (École Polytechnique de Louvain),
   \IfLanguageName{english}{faculty of the }{faculté de l'}%
   UCL (Université Catholique de Louvain).
   \IfLanguageName{english}
   {It has been written by the aforementioned authors with the help of all other students,
   yours is therefore welcome as well.
   It is always possible to improve it,
   it is even more true if the course has changed because the summary must be updated accordingly.
   The source code and a link to the latest version of the pdf can be found at the following address}
   {Il est écrit par les auteurs susnommés avec l'aide de tous
   les autres étudiants, la vôtre est donc la bienvenue.
   Il y a toujours moyen de l'améliorer, surtout si le cours change car la synthèse doit alors être mise à jour en conséquence.
   On peut retrouver le code source et un lien vers la dernière version du pdf à l'adresse suivante}
   \begin{center}
     \url{https://github.com/Gp2mv3/Syntheses}.
   \end{center}
   \IfLanguageName{english}
   {You can also find there the content of the \texttt{README} file which contains
   more information, you are invited to read it.}
   {On y trouve aussi le contenu du \texttt{README} qui contient de plus
   amples informations, vous êtes invité à le lire.}

   \IfLanguageName{english}
   {It is written on it that questions, error reports,
   improvement suggestions or any discussion about the project
   are to be submitted at the following address}
   {Il y est indiqué que les questions, signalements d'erreurs,
   suggestions d'améliorations ou quelque discussion que ce soit
   relative au projet
   sont à spécifier de préférence à l'adresse suivante}
   \begin{center}
     \url{https://github.com/Gp2mv3/Syntheses/issues}.
   \end{center}
   \IfLanguageName{english}
   {It allows everyone to see them, comment and act accordingly.
   You are invited to join the discussions.}
   {Ça permet à tout le monde de les voir, les commenter et agir
   en conséquence.
   Vous êtes d'ailleurs invité à participer aux discussions.}

   \IfLanguageName{english}
   {You can also find informations on the wiki}
   {Vous trouverez aussi des informations dans le wiki}
   \begin{center}
     \url{https://github.com/Gp2mv3/Syntheses/wiki}
   \end{center}
   \IfLanguageName{english}
   {like the status of the summaries for each course}
   {comme le statut des synthèses pour chaque cours}
   \begin{center}
     \url{https://github.com/Gp2mv3/Syntheses/wiki/Status}
   \end{center}
   \IfLanguageName{english}
   {you can notice that there is still a lot missing,
   your help is welcome.}
   {vous pouvez d'ailleurs remarquer qu'il en manque encore beaucoup,
   votre aide est la bienvenue.}

   \IfLanguageName{english}
   {To contribute to the bug tracker or the wiki,
   you just have to create an account on GitHub.
   To interact with the source code of the summaries,
   you will have to install}
   {Pour contribuer au bug tracker et au wiki, il vous suffira de
   créer un compte sur GitHub.
   Pour interagir avec le code des synthèses,
   il vous faudra installer}
   \LaTeX.
   \IfLanguageName{english}
   {To directly interact with the source code on GitHub,
   you will have to use}
   {Pour interagir directement avec le code sur GitHub,
   vous devrez utiliser}
   \texttt{git}.
   \IfLanguageName{english}
   {If it is a problem,
   we are of course open to contributions sent by mail
   or any other mean.}
   {Si cela pose problème,
   nous sommes évidemment ouverts à des contributeurs envoyant leurs
   changements par mail ou par n'importe quel autre moyen.}
\end{titlepage}
}{}

\ifthenelse{\isundefined{\skiptableofcontents}}{
\tableofcontents
}{}
}

\endinput
