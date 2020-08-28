%a
declare
fun {Sum N M}
    if N == 0 then M
    else {Sum N-1 M+N}
    end
end

{Browse {Sum 8 0}}
%b

%c
