% http://ctan.mirrors.hoobly.com/macros/latex/doc/clsguide.pdf

% Rule of thumb: in class if specific to the class
%                in package if it can be in different class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplsummary}[2015/01/14 EPL summary class]

\DeclareOption{en}{\newcommand{\epltype}{Summary}}
\DeclareOption{fr}{\newcommand{\epltype}{Synth\`ese}}

\ProcessOptions\relax

\LoadClassWithOptions{../../../eplbase}

\endinput
