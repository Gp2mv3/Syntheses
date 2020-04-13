declare
proc{Fact N R}
    if  N==1 then R = [N]
    else 
        Out = {Fact N-1}
    in
        R = N*Out.1|Out
    end
end

{Browse {Fact 4}} %-> [24 6 2 1]