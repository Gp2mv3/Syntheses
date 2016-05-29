\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplsummary}[2015/01/14 EPL summary class]

\LoadClassWithOptions{../../../eplbase}

\IfLanguageName{english}{\newcommand{\epltype}{summary}}{\newcommand{\epltype}{synth\`ese}}
\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{Summary}{Synth\`ese}}}

\RequirePackage{../../../eplcommon}

\endinput
