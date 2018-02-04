\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplsummary}[2015/01/14 EPL summary class]

\LoadClassWithOptions{../../../eplbase}

\IfLanguageName{english}{
\newcommand{\Epltype}{Summary}
\newcommand{\epltypesingular}{summary}
\newcommand{\epltypeplural}{summaries} % version au pluriel; différente de summarys
}{% else IfLanguageName{english}
\newcommand{\Epltype}{Synth\`ese}
\newcommand{\epltypesingular}{synth\`ese} % version au singulier
\newcommand{\epltypedefadj}{la } % adjectif défini à utiliser au singulier
\newcommand{\epltypegender}{e} % marque du genre ; féminin donc 'e'
}% end else IfLanguageName{english}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Summary}{Synth\`ese}}}

\RequirePackage{../../../eplcommon}

\endinput
