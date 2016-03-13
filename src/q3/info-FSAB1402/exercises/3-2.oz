declare
fun {Head L}
   L.1
end

fun {Tail L}
   L.2
end

{Browse {Head [a b c]}}   % affiche a
{Browse {Tail [a b c]}}   % affiche [b c]