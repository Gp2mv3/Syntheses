declare
fun {Numbers N I J}
   if N == 0 then
      nil
   else
      {Delay 500}
      (({OS.rand} mod (J - I + 1)) + I)|{Numbers N-1 I J}
   end
end
fun {SumAndCount L}
   fun {SumAndCountAux L Acc}
      case L
      of nil then Acc
      [] H|T then
         {SumAndCountAux T (Acc.1+H)#(Acc.2+1)}
      end
   end
in
   {SumAndCountAux L 0#0}
end

N = 4
From = {OS.time}
{Browse {SumAndCount thread {Numbers N 3 10} end}}
End = {OS.time}
{Browse End - From}
% It takes N / 2 seconds

fun {FilterList Xs Ys}
   case Xs
   of nil then nil
   [] H|T then
      if {Member H Ys} then
         {FilterList T Ys}
      else
         H|{FilterList T Ys}
      end
   end
end

{Browse thread {FilterList thread {Numbers N 6 10} end [8]} end}
