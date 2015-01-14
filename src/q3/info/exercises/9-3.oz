declare
fun {ProduceInts N}
   fun {ProduceIntsAux N Act}
      {Delay 2}
      if N==0 then nil
      else Act|{ProduceIntsAux N-1 Act+1}
      end	 
   end
in
   {ProduceIntsAux N 1}
end

fun {Sum Str}
   fun {SumAux Str Acc}
      {Delay 2}
      case Str of nil then Acc
      []H|T then {SumAux T Acc+H}
      end
   end
in
   {SumAux Str 0}
end


declare Xs S
thread Xs = {ProduceInts 666} end
thread S = {Sum Xs} end
{Browse S}

declare Xs S
Xs = {ProduceInts 666}
S = {Sum Xs}
{Browse S}