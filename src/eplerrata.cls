\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplerrata}[2015/01/14 EPL errata class]

\LoadClassWithOptions{../../../eplbase}

\newcommand{\epltype}{errata}
\newcommand{\hypertitle}[7][e ]{%
\basehypertitle[#1]{#2}{#3}{#4}{#5}{#6}{#7}{Errata}}

\RequirePackage{../../../eplcommon}

\RequirePackage{longtable} % so that table can be over several pages
\renewcommand{\arraystretch}{1.5} % to bring space to the table

\newenvironment{errata}
{\begin{longtable}{|l|l|p{0.4\textwidth}|p{0.4\textwidth}|}\hline page & line & before & after\\}
{\hline\end{longtable}}

% ifthenelse, newcommand with optional argument doesnt work with tabular
% http://tex.stackexchange.com/questions/175577/optional-argument-problem
% http://tex.stackexchange.com/questions/42333/problem-with-ifthenelse-multicolumn
\DeclareExpandableDocumentCommand\erratum{O{}mmmm}{%
  \hline
  #2 & $#3$ & #4 & #5\\%
  \noalign{%
    \ifthenelse{\equal{#1}{}}%
        {\gdef\hmm{}}%
        {\gdef\hmm{\hline \multicolumn{4}{|p{\textwidth}|}{\emph{Justification:} #1} \\}}%
  }\hmm
}


\endinput
