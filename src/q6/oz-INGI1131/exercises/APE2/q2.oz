%a
declare
fun {Sum N M}
    if N == 0 then M
    else {Sum N-1 M+N}
    end
end

{Browse {Sum 8 0}}
%b
%the function is already tail recursive
fun {Append L1 L2}
   case L1 of nil then L2
   [] H|T then H|{Append T L2}
   end
end

%c
fun {TailFact X}
   local
      M
      %calcule la factorielle de X soit X!
      fun {Fact X Acc}%Acc=1 au début
         if X=<0 then Acc
         else {Fact X-1 Acc*X}
         end
      end

      %Fait la liste en comencant par la fin
      fun {Fact2 X Acc M}%Acc = nil au début
         if M=<1 then 1|Acc
         else {Fact2 X-1 M|Acc (M div X)}
         end
      end
   in
      M={Fact X 1}
      {Fact2 X nil M}
   end
end
{Browse {TailFact 5}}
