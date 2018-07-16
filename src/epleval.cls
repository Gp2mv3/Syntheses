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
\newcommand{\isepleval}{} % indique que la classe hérite de epleval

\newcommand{\hypertitle}[9][e ]{%
  \def\ArgI{#1}
  \def\ArgII{#2}
  \def\ArgIII{#3}
  \def\ArgIV{#4}
  \def\ArgV{#5}
  \def\ArgVI{#6}
  \def\ArgVII{#7}
  \def\ArgVIII{#8}
  \def\ArgIX{\string #9}
  \BlahRelay
}

\newcommand\BlahRelay[1]{%
  % argument 1-9 are now in
  %   \ArgI-\ArgIX
  % argument 10 is in
  %   #1
  \basehypertitle[\ArgI]{\ArgII}{\ArgIII}{\ArgIV}{\ArgV}{\ArgIX}{#1}{\ArgVIII}{\Epltype{} \IfLanguageName{english}{of}{de} \ArgVII \space \ArgVI}
}

\ifthenelse{\isundefined{\Sol}}{\def\Sol{true}}{}


\usepackage{ifthen}
\usepackage{tikzpagenodes}
\usetikzlibrary{calc, arrows}

\RequirePackage{../../../../../../eplcommon}

\RequirePackage{fancybox}

\RequirePackage{titlesec}
\titleformat
{\section} % command
[hang] % shape
{\bfseries} % format
{\shadowbox{~\thesection~}} % label
{0.5ex} % sep
{} % before-code

\newcommand{\QAlabel}{\IfLanguageName{english}{}{la }Question}
\newcommand{\theQA}{\thesection}

\RequirePackage[eval]{../../../../../../eplqa}

\endinput
