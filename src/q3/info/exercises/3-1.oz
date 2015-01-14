% a)
declare
L1=[a]             % a|nil
L2=[a [b c] d]     % a|(b|c|nil)|d|nil
L3=[proc {$} {Browse oui} end proc {$} {Browse non} end]
                   % <P/0 L3.1>|<P/0 L3.2.1>|nil
L4=[est une liste] % est|une|liste|nil
L5=[[a p]]         % (a|p|nil)|nil

% b)
L6=ceci|L4

% c)
{L3.1}

% d)
L7=L2.2