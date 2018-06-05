\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplformulaire}[2016/01/06 EPL formulaire class]

% I need to pass skiptoc to eplbase so I cannot just do
% \LoadClassWithOptions because it ignores \PassOptionsToClass.
% I need to pass every option manually with the 2 following lines
% and then use \LoadClass
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{../../../eplbase}}
\ProcessOptions\relax
\PassOptionsToClass{skiptoc}{../../../eplbase}

\LoadClass{../../../eplbase}

\IfLanguageName{english}{
\newcommand{\Epltype}{Formulary}
\newcommand{\epltypesingular}{formulary} % si quelqu'un connait la vraie traduction en anglais
}{
\newcommand{\Epltype}{Formulaire}
\newcommand{\epltypesingular}{formulaire} % version au singulier
\newcommand{\epltypedefadj}{le } % adjectif défini à utiliser au singulier
\newcommand{\epltypegender}{} % marque du genre ; masculin donc rien
}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Formulary}{Formulaire}}}

\RequirePackage{../../../eplcommon}

\endinput
