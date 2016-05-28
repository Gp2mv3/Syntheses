%Exo 3
declare
L1 L2 F
L1 = [1 2 3]
F = fun {$ X} {Delay 200} X*X end
thread L2 = {Map L1 F} end
{Wait L2}
{Show L2}

%TODO