\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexam}[2015/01/14 EPL exam class]

\RequirePackage{ifthen}

\PassOptionsToClass{skiptoc}{../../../../../eplbase}

\LoadClassWithOptions{../../../../../eplbase}

\IfLanguageName{english}{\newcommand{\epltype}{Exam}}{\newcommand{\epltype}{Examen}}

\newcommand{\hypertitle}[9][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#8}{#9}{\IfLanguageName{english}{Exam of #7 #6}{Examen de #7 #6}}}

\ifthenelse{\isundefined{\Sol}}{\def\Sol{true}}{}

\newcommand{\solution}[1]
{\ifthenelse{\equal{\Sol}{true}}{\subsection*{Solution}#1}{}}

\RequirePackage{../../../../../eplcommon}

\endinput
