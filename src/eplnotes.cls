\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplnotes}[2015/01/14 EPL notes class]

\LoadClassWithOptions{../../../eplbase}

% Les noms de documents sont communs aux deux langues
\newcommand{\Epltype}{Notes}
\newcommand{\epltypesingular}{notes} % version "au singulier" (toujours pluriel)
\newcommand{\epltypeplural}{notes} % version au pluriel

\IfLanguageName{english}{
% nothing to do
}{% else IfLanguageName{english}
\newcommand{\epltypedefadj}{les } % adjectif défini à utiliser au singulier
\newcommand{\epltypegender}{es} % marque du genre ; féminin pluriel donc 'es'
\newcommand{\epltypepluralonly}{} % le singulier est en fait un pluriel
}% end else IfLanguageName{english}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{Notes}}

\RequirePackage{../../../eplcommon}

\endinput
