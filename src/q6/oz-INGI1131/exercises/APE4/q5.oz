declare
proc{MapRecord Done R1 F R2}
    A={Record.arity R1}
    proc{Loop L X}
        case L of nil then X=unit
        [] H|T then 
            XTail
        in
            thread R2.H={F R1.H}end
            {Loop T XTail}
            {Wait R2.H}
            {Wait XTail}
            X=unit
        end
    end
in
    R2={Record.make {Record.label R1} A}
    {Loop A Done}
end

Done
R = {MapRecord Done '#'(a:1 b:2 c:3 d:4 e:5 f:6 g:7) fun {$ X} {Delay 1000} 2*X end}
{Wait Done}
{Show R}