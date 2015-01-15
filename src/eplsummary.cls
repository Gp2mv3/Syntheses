\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplsummary}[2015/01/14 EPL summary class]

\DeclareOption{en}{\newcommand{\epltype}{Summary}}
\DeclareOption{fr}{\newcommand{\epltype}{Synth\`ese}}

\ProcessOptions\relax

\LoadClassWithOptions{../../../eplbase}

\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Summary}{Synth\`ese}}}

\RequirePackage{../../../eplcommon}

\endinput
