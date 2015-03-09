\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epleval}[2015/01/14 EPL eval class]

% I need to pass skiptoc to eplbase so I cannot just do
% \LoadClassWithOptions because it ignores \PassOptionsToClass.
% I need to pass every option manually with the 2 following lines
% and then use \LoadClass
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{../../../../../../eplbase}}
\ProcessOptions\relax
\PassOptionsToClass{skiptoc}{../../../../../../eplbase}

\RequirePackage{ifthen}

\LoadClass{../../../../../../eplbase}

\newcommand{\hypertitle}[9][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#8}{#9}{\epltype{} \IfLanguageName{english}{of}{de} #7 #6}}

\ifthenelse{\isundefined{\Sol}}{\def\Sol{true}}{}


\usepackage{ifthen}
\usepackage{tikzpagenodes}
\usetikzlibrary{calc, arrows}

\RequirePackage{../../../../../../eplcommon}

\RequirePackage{titlesec}
\titleformat
{\section} % command
[display] % shape
{\bfseries\Large} % format
{Question \thesection} % label
{0.5ex} % sep
{} % before-code

\newcommand{\QAlabel}{\IfLanguageName{english}{}{la }Question}
\newcommand{\theQA}{\thesection}

\RequirePackage[eval]{../../../../../../eplqa}

\endinput
