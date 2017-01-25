\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplmcq}[2015/01/14 EPL mcq class]

\LoadClassWithOptions{../../../eplbase}

\IfLanguageName{english}{\newcommand{\epltype}{MCQ}}{\newcommand{\epltype}{QCM}}
\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{\IfLanguageName{english}{MCQ}{QCM}}}

\RequirePackage{../../../eplcommon}

\RequirePackage{titlesec}
\titleformat
{\section} % command
[display] % shape
{\bfseries\Large} % format
{\IfLanguageName{english}{MCQ}{QCM} \thesection} % label
{0.5ex} % sep
{} % before-code

\newcommand{\skipape}{\stepcounter{section}}

\RequirePackage{titlesec}
\titleformat
{\subsection} % command
[display] % shape
{\bfseries\Large} % format
{\IfLanguageName{english}{MCQ}{QCM} \thesubsection} % label
{0.5ex} % sep
{} % before-code


\newcommand{\QAlabel}{\IfLanguageName{english}{MCQ}{le QCM}}
\newcommand{\theQA}{\thesubsection}

\RequirePackage{../../../eplqa}

\endinput
