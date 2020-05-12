%Exo 3a
declare
L1 L2 F
L1 = [1 2 3]
F = fun {$ X} {Delay 200} X*X end
thread L2 = {Map L1 F} end
{Wait L2} %affiche optimised|optimised 
{Show L2}

%autre solution exo3a, n'utilisant pas le Wait standard
declare
L1 L2 F
L1 = [1 2 3]
F = fun {$ X} {Delay 200} X*X end
thread L2 = {Map L1 F} end
proc {MyWait L}
    if L==nil then skip
    else {MyWait L.2}
    end
end
{MyWait L2}
{Show L2}

%Exo 3b
declare
L1 L2 L3 L4 L5
L1 = [1 2 3]
thread L2 = {Map L1 fun {$ X} {Delay 200} X*X end} end
thread L3 = {Map L1 fun {$ X} {Delay 200} 2*X end} end
thread L4 = {Map L1 fun {$ X} {Delay 200} 3*X end} end
L5=L2#L3#L4
proc {MyWait L}
    if L==nil then skip %bloquant!
    else {MyWait L.2}
    end
end
{MyWait L5}
{Show L5}

%Exo 3c
declare
fun {MapRecord R1 F R2 Fin}
    A={Record.arity R1}
    proc {Loop L}
        case L of nil then skip
        [] H|T then
            thread R2.H={F R1.H} end
            {Loop T}
        end
    end
in
    R2={Record.make {Record.label R1} A}
    {Loop A}
    for X in A do
        {Wait R2.X}
    end
    Fin = unit
    R2
end
R2 Fin D
D={MapRecord '#'(a:1 b:2 c:3 d:4 e:5 f:6 g:7) fun {$ X} {Delay 1000} 2*X end R2 Fin}
if Fin == 0 then skip % '=='' bloquant
else {Show D} end

%Exo4 TODO