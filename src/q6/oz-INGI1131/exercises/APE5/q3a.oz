%a
declare
L1 L2 F 
L1 = [1 2 3]
F = fun{$ X} {Delay 200} X*X end
X
thread L2 = {Map L1 F} X=unit end
{Wait X}
{Show L2}