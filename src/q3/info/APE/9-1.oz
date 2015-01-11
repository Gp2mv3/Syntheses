declare A B C D
thread D = C+1 end %1
thread C = B+1 end %2
thread A = 1 end %3
thread B = A+1 end %4
{Browse D} % affiche 4