\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexam}[2015/01/14 EPL exam class]
\newcommand{\isepleval}{} % indique que la classe hérite de epleval (enfin, quasi)
\DeclareOption{en}{
  \PassOptionsToClass{\CurrentOption}{../../../../../eplbase}
  \newcommand{\epltypesingular}{Exam}
}
\DeclareOption{fr}{
  \PassOptionsToClass{\CurrentOption}{../../../../../eplbase}
  \newcommand{\epltypesingular}{Examen} % version au singulier
  \newcommand{\epltypedefadj}{l'} % adjectif défini à utiliser au singulier
  \newcommand{\epltypegender}{} % marque du genre ; masculin donc rien
}

\newcounter{eplargc}

\DeclareOption*{%
  \ifnum\value{eplargc} = 2%
    \PassOptionsToClass{\CurrentOption}{../../../../../eplbase}
  \fi
  \ifnum\value{eplargc} = 1%
    \let\eplmonth\CurrentOption
    \stepcounter{eplargc}
  \fi
  \ifnum\value{eplargc} = 0%
    \let\eplyear\CurrentOption
    \stepcounter{eplargc}
  \fi
}

\ProcessOptions\relax

\typeout{You should rather use eplexam.cls instead.}

\RequirePackage{ifthen}

\ifthenelse{\isundefined{\eplyear}}{
\ClassError{eplexam}{You should give the year (e.g. 2015) after the year as argument of eplexam. Press ``H'' for help}{If you really don't understand why I say that, please ask on Github with an issue.}
}{}

\ifthenelse{\isundefined{\eplmonth}}{
\ClassError{eplexam}{You should give the month (e.g. Janvier, Juin or Août) after the year as argument of eplexam. Press ``H'' for help}{If you really don't understand why I say that, please ask on Github with an issue.}
}{}

\typeout{\eplmonth}
\newcommand{\epltext}{\epltype{} de \eplmonth{} \eplyear{}}

\LoadClass[skiptoc]{../../../../../eplbase}

\ifthenelse{\isundefined{\Sol}}{\def\Sol{true}}{}

\newcommand{\solution}[1]
{\ifthenelse{\equal{\Sol}{true}}{\subsection*{Solution}#1}{}}

\RequirePackage{../../../../../eplcommon}

\endinput
