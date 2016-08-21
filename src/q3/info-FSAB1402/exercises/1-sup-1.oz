declare
fun {Exp2 X} %calculer 2^X
   if X==0 then 1 else 2*{Exp2 X-1} end
end
{Browse {Exp2 7}*3+{Exp2 42}-{Exp2 100}*5}