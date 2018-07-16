% http://ctan.mirrors.hoobly.com/macros/latex/doc/clsguide.pdf

% Rule of thumb: in class if specific to the class
%                in package if it can be in different class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplbase}[2015/01/14 EPL summary class]

\DeclareOption{en}{\PassOptionsToPackage{english}{babel}}
\DeclareOption{fr}{\PassOptionsToPackage{french}{babel}}

% If you want to compile without it
\DeclareOption{skiptoc}{\newcommand{\skiptableofcontents}{}}
\DeclareOption{skiptitle}{\newcommand{\skiptitlepage}{}}
\DeclareOption{license=none}{\newcommand{\nolicense}{}}

\DeclareOption{usereportclass}{\newcommand{\usereport}{}}
\DeclareOption{10pt}{
\ifcsname usereport\endcsname%
\PassOptionsToClass{10pt}{report}
\else%
\PassOptionsToClass{10pt}{article}
\fi%
}
\DeclareOption{landscape}{
\ifcsname usereport\endcsname%
\PassOptionsToClass{landscape}{report}
\else%
\PassOptionsToClass{landscape}{article}
\fi%
}

\DeclareOption*{\ClassError{eplbase}{I have not the faintest idea of what you wanted to do when you gave the the option ``\CurrentOption''. I could have just thrown a warning, ignore it and continue compiling but I think I will just stop here. Press ``H'' for help}{If you really don't understand why I say that, please ask on Github with an issue.}}

% relax is needed since \ProcessOptions* exists too
\ProcessOptions\relax

\ifcsname usereport\endcsname%
\LoadClass[a4paper]{report}
\else%
\LoadClass[a4paper]{article}
\fi%

% utf8x requires ucs package, which is quasi-obsolete and conflicts with biblatex. See https://tex.stackexchange.com/questions/13067/utf8x-vs-utf8-inputenc
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{textcomp} % Allows the use of more symbols, like inline degree

% You may need to load the polutonikogreek option of babel if you want to use \textgreek{} to include Greek text, as utf8 doesn't provide them out of the box (utf8x did).
\RequirePackage{babel}
\RequirePackage{iflang}
\RequirePackage{ifthen}

\RequirePackage{url}
\RequirePackage{xparse}

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

% For tikz v3 or higher we should use the babel tikz library
% but for tikz v2 or lower it does not exists
\newif\iftikzthree
\begingroup
\def\getmainversion#1.#2\getmainversion{#1}
\ifnum\expandafter\getmainversion\pgfversion\getmainversion=3
  \global\tikzthreetrue
\fi
\endgroup

\iftikzthree
\usetikzlibrary{babel}
\else
\typeout{You have an old version of Tikz: \pgfversion, try to update some time ;)}
\fi

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
\DeclareDocumentCommand{\basehypertitle}{ O{e } m m m m m m m O{} }{

% About \epltype-commands :
% \epltypesingular refers to the name of the type of the document
% \Epltype should be the same, but with an Uppercase letter at the beginning, as it is used for the title of the document
% \epltypeplural should be used if the plural of the type name cannot be constructed by appending 's' at the end. Currently, it is unused
% \epltypepluralonly est utilisé pour indiquer que le type de document ne devrait être utilisé qu'au pluriel, et que les verbes doivent donc s'accorder au pluriel. L'exemple parfait est notes. Probablement useless en anglais.
% \epltypegender est utilisé pour accorder les adjectifs en français.
% \epltypedefadj est utilisé pour spécifier le déterminant défini.

% Default plural
\ifthenelse{\isundefined{\epltypeplural}}{\newcommand{\epltypeplural}{\epltypesingular{}s}}{}

{\renewcommand{\and}{, }
\hypersetup{pdfauthor={#6},
            pdftitle={#8 #2 Q#3 - L#4#5},
            pdfsubject={#2}}
}

\title{\IfLanguageName{english}{#8 of }{#8 d#1}#2 \\ Q#3 - L#4#5}
\author{#6}

\begin{document}

\ifthenelse{\isundefined{\skiptitlepage}}{
\begin{titlepage}
\maketitle
% Remove duplicate page number on title page
\thispagestyle{empty}

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
   \ifthenelse{\isundefined{\isepleval}}{%
   It is always possible to improve it,
   even more so if the course has changed in which case
   the \epltypesingular{} must be updated accordingly.}
   {It is always possible to improve it, by completing missing statements or solutions.}
   The source code and a link to the latest version of the pdf can be found at the following address}
   {Il est écrit par les auteurs susnommés avec l'aide de tous
   les autres étudiants, la vôtre est donc la bienvenue.
   \ifthenelse{\isundefined{\isepleval}}{%
   Il y a toujours moyen de l'améliorer,
   surtout si le cours change car \epltypedefadj{}\epltypesingular{}
   \ifthenelse{\isundefined{\epltypepluralonly}}{doit}{doivent}
   alors être mis\epltypegender{} à jour en conséquence.}
   {Il y a toujours moyen de l'améliorer, en complétant les énoncés ou les solutions manquantes.}
   On peut retrouver le code source et un lien vers la dernière version du pdf à l'adresse suivante}
   \begin{center}
     \url{https://github.com/Gp2mv3/Syntheses}.
   \end{center}
   \IfLanguageName{english}
   {There, you can also find the content of the \texttt{README} file which contains
   more information. You are invited to read it.}
   {On y trouve aussi le contenu du \texttt{README} qui contient de plus
   amples informations, vous êtes invités à le lire.}

   \IfLanguageName{english}
   {It is indicated there that questions, error reports,
   improvement suggestions or any discussion concerning the project
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
   {like the status of the documents for each course}
   {comme le statut des documents pour chaque cours}
   \begin{center}
     \url{https://github.com/Gp2mv3/Syntheses/wiki/Status}
   \end{center}
   \IfLanguageName{english}
   {You will have noticed that there are still a lot of missing ones,
   your help is welcome.}
   {Vous pouvez d'ailleurs remarquer qu'il en manque encore beaucoup,
   votre aide est la bienvenue.}

   \IfLanguageName{english}
   {To contribute to the bug tracker or the wiki,
   you just have to create an account on GitHub.
   To interact with the source code of the documents,
   you will have to install}
   {Pour contribuer au bug tracker et au wiki, il vous suffira de
   créer un compte sur GitHub.
   Pour interagir avec le code des documents,
   il vous faudra installer}
   \LaTeX.
   \IfLanguageName{english}
   {To directly interact with the source code on GitHub,
   you will have to use}
   {Pour interagir directement avec le code sur GitHub,
   vous devrez utiliser}
   \texttt{git}.
   \IfLanguageName{english}
   {If that constitutes a problem,
   we are of course open to contributions sent by mail (to \href{mailto:contact.epldrive@gmail.com}{contact.epldrive@gmail.com})
   or any other means.}
   {Si cela pose problème,
   nous sommes évidemment ouverts à des contributeurs envoyant leurs
   changements par mail (à l'adresse \href{mailto:contact.epldrive@gmail.com}{contact.epldrive@gmail.com}) ou par n'importe quel autre moyen.}

   #9

    \ifthenelse{\isundefined{\nolicense}}{
        \bigskip
        \paragraph{License} \IfLanguageName{english}
        {This work is licensed under the Creative Commons Attribution 4.0 Unported License.
            To view a copy of this license, visit \url{http://creativecommons.org/licenses/by/4.0/},
        or look into the GitHub repository (see above).}
        {Ce travail est disponible sous license Creative Commons Attribution 4.0 Unported.
            Une copie de cette license est disponible sur \url{http://creativecommons.org/licenses/by/4.0/},
        ou dans le dépot GitHub (voir ci-dessus).}
    }{}
\end{titlepage}
}{}

\ifthenelse{\isundefined{\skiptableofcontents}}{
\tableofcontents
}{}
}

\endinput
