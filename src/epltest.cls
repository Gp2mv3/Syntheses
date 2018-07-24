\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epltest}[2015/03/06 EPL test class]

% We do not license tests under CC-BY-SA since part of
% the documents are work of professors.

% I need to pass license=none to eplbase so I cannot just do
% \LoadClassWithOptions because it ignores \PassOptionsToClass.
% I need to pass every option manually with the 2 following lines
% and then use \LoadClass
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{../../../../../../eplbase}}
\ProcessOptions\relax
\PassOptionsToClass{license=none}{../../../../../../eplbase}

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
