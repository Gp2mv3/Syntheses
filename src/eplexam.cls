\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplexam}[2015/03/06 EPL exam class]

% We do not license exams under CC-BY-SA since part of
% the documents are work of professors.

% I need to pass license=none to eplbase so I cannot just do
% \LoadClassWithOptions because it ignores \PassOptionsToClass.
% I need to pass every option manually with the 2 following lines
% and then use \LoadClass
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{../../../../../../eplbase}}
\ProcessOptions\relax
\PassOptionsToClass{license=none}{../../../../../../eplbase}

\LoadClassWithOptions{../../../../../../epleval}

\IfLanguageName{english}{\newcommand{\Epltype}{Exam}\newcommand{\epltype}{exam}}{\newcommand{\Epltype}{Examen}\newcommand{\epltype}{examen}}

\endinput
