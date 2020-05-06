%b
declare
L1 L2 L3 L4
X1 X2 X3
L1= [1 2 3]
thread L2={Map L1 fun{$ X} {Delay 200} X*X end} X1=unit end 
thread L3={Map L1 fun{$ X} {Delay 200} 2*X end} X2=unit end 
thread L4={Map L1 fun{$ X} {Delay 200} 3*X end} X3=unit end
{Wait X1} {Wait X2} {Wait X3}
{Show L2#L3#L4}