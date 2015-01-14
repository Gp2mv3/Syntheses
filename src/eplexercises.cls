\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexercises}[2015/01/14 EPL exercises class]

\DeclareOption{en}{\newcommand{\epltype}{Exercises solutions}}
\DeclareOption{fr}{\newcommand{\epltype}{Correctif des APEs}}

\ProcessOptions\relax

\LoadClassWithOptions{../../../eplbase}

\endinput
