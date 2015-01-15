\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexercises}[2015/01/14 EPL exercises class]

\ProcessOptions\relax

\LoadClassWithOptions{../../../eplbase}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Exercises solutions}{Correctif des APEs}}}

\RequirePackage{../../../eplcommon}

\endinput
