\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplsummary}[2015/01/14 EPL summary class]

\DeclareOption{en}{\newcommand{\epltype}{Summary}}
\DeclareOption{fr}{\newcommand{\epltype}{Synth\`ese}}

\ProcessOptions\relax

\LoadClassWithOptions{../../../eplbase}

\endinput
