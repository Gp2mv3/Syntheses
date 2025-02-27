\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplmcq}[2015/01/14 EPL mcq class]

\LoadClassWithOptions{../../../eplbase}

\IfLanguageName{english}{
\newcommand{\Epltype}{MCQ}
\newcommand{\epltypesingular}{MCQ}
}{% else IfLanguageName{english}
\newcommand{\Epltype}{QCM}
\newcommand{\epltypesingular}{QCM} % version au singulier
\newcommand{\epltypedefadj}{le } % adjectif défini à utiliser au singulier
\newcommand{\epltypegender}{} % marque du genre ; masculin donc rien
\newcommand{\epltypeplural}{QCM} % version au pluriel
% Dans ce cas-ci, il ne faut pas déclarer \epltypepluralonly, car le soucis est que la marque du pluriel est dans l'abbréviation.
}% end else IfLanguageName{english}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{MCQ}{QCM}}}

\RequirePackage{../../../eplcommon}

\RequirePackage{titlesec}
\titleformat
{\section} % command
[display] % shape
{\sffamily\mdseries\upshape\Large} % format
{\IfLanguageName{english}{MCQ}{QCM} \thesection} % label
{0.5ex} % sep
{} % before-code

\newcommand{\skipape}{\stepcounter{section}}

\RequirePackage{titlesec}
\titleformat
{\subsection} % command
[display] % shape
{\sffamily\mdseries\upshape\large} % format
{\IfLanguageName{english}{MCQ}{QCM} \thesubsection} % label
{0.5ex} % sep
{} % before-code


\newcommand{\QAlabel}{\IfLanguageName{english}{MCQ}{le QCM}}
\newcommand{\theQA}{\thesubsection}

\RequirePackage{../../../eplqa}

\endinput
