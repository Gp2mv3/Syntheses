\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epltest}[2015/03/06 EPL test class]

\newcommand*{\Majmin}{}

\LoadClassWithOptions{../../../../../../epleval}

\IfLanguageName{english}{
\newcommand{\Epltype}{Test}
\newcommand{\epltypesingular}{test}
}{ % else IfLanguageName{english}
\newcommand{\Epltype}{Interro}
\newcommand{\epltypesingular}{interro} % version au singulier
\newcommand{\epltypedefadj}{l'} % adjectif défini à utiliser au singulier
\newcommand{\epltypegender}{e} % marque du genre ; féminin donc 'e'
} % end else IfLanguageName{english}

\endinput
