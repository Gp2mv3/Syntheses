declare
fun {Counter InS}
   fun {ListAdd L E}
      case L
      of nil then [E#1]
      [] H|T then
         if H.1 == E then
            E#(H.2+1)|T
         else
            H|{ListAdd T E}
         end
      end
   end
   fun {Count InS Acc}
      case InS of
         nil then nil
      [] H|T then Acc2 in
         Acc2 = {ListAdd Acc H}
         Acc2|{Count T Acc2}
      end
   end
in
   thread {Count InS nil} end
end

local
   InS
in
   {Browse {Counter InS}}
   InS=e|m|e|c|_
end
