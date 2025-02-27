\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexercises}[2015/01/14 EPL exercises class]

% We do not license exercises under CC-BY-SA since part of
% the documents are work of professors.

% I need to pass license=none to eplbase so I cannot just do
% \LoadClassWithOptions because it ignores \PassOptionsToClass.
% I need to pass every option manually with the 2 following lines
% and then use \LoadClass
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{../../../../../../eplbase}}
\ProcessOptions\relax
\PassOptionsToClass{license=none}{../../../../../../eplbase}

\LoadClassWithOptions{../../../eplbase}

\IfLanguageName{english}{
\newcommand{\Epltype}{Exercises solutions}
\newcommand{\epltypesingular}{exercises solutions} % Selon moi, on a des solutions d exercices, pas une seule
\newcommand{\epltypeplural}{exercises solutions}
}{
\newcommand{\Epltype}{Correctif}
\newcommand{\epltypesingular}{correctif} % version au singulier
\newcommand{\epltypedefadj}{le } % adjectif défini à utiliser au singulier
\newcommand{\epltypegender}{} % marque du genre ; masculin donc rien
}% end else IfLanguageName{english}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Exercises solutions}{Correctif des APEs}}}

\RequirePackage{../../../eplcommon}

\RequirePackage{titlesec}
\titleformat
{\section} % command
[display] % shape
{\sffamily\mdseries\upshape\Large} % format
{APE \thesection} % label
{0.5ex} % sep
{} % before-code

\newcommand{\skipape}{\stepcounter{section}}

\RequirePackage{titlesec}
\titleformat
{\subsection} % command
[display] % shape
{\sffamily\mdseries\upshape\large} % format
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
