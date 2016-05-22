%Exo 01
declare
A={NewCell 0}
B={NewCell 0}
T1=@A
T2=@B
{Browse A==B}%false
{Browse T1==T2}%true
{Browse A=B}%error
A:=@B
{Browse A==B}%false
{Show A==B} % a: What will be printed here
% true, false, A, B or 0? false
{Show T1==T2} % b: What will be printed here
% true, false, A, B or 0? true
{Show T1=T2} % b: What will be printed here
% true, false, A, B or 0? nothing
A:=@B
{Show A==B} % b: What will be printed here
% true, false, A, B or 0? false