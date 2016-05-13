\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexercises}[2015/01/14 EPL exercises class]

\LoadClassWithOptions{../../../eplbase}

\IfLanguageName{english}{\newcommand{\epltype}{exercises solution}}{\newcommand{\epltype}{correctif}}
\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Exercises solutions}{Correctif des APEs}}}

\RequirePackage{../../../eplcommon}

\RequirePackage{titlesec}
\titleformat
{\section} % command
[display] % shape
{\bfseries\Large} % format
{APE \thesection} % label
{0.5ex} % sep
{} % before-code

\newcommand{\skipape}{\stepcounter{section}}

\RequirePackage{titlesec}
\titleformat
{\subsection} % command
[display] % shape
{\bfseries\Large} % format
{\IfLanguageName{english}{Exercise}{Exercice} \thesubsection} % label
{0.5ex} % sep
{} % before-code


\newcommand{\QAlabel}{\IfLanguageName{english}{Exercise}{l'Exercice}}
\newcommand{\theQA}{\thesubsection}

\RequirePackage{../../../eplqa}

% \comment and \endcomment of the environment solution
% does not work with newcommand
\ifthenelse{\equal{\Sol}{false}}
{\newcommand{\copypaste}{}}
{\newcommand{\copypaste}[2]{\begin{solution}\IfLanguageName{english}{See}{Voir} \QAlabel~#2 \IfLanguageName{english}{of }{de l'}APE#1.\end{solution}}}

\endinput
