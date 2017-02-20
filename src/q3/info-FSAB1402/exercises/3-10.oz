declare
fun{Average L}
   fun{AverageAcc L S N}
      case L
      of nil then S div N
      [] H|T then {AverageAcc T H+S 1+N}
      end
   end
in
   {AverageAcc L 0 0}
end

{Browse {Average [42 17 25 61 9]}}

declare
fun{Variance L}
   fun{VarianceAcc L P S N}
      case L
      of nil then (P div N)-(S div N)*(S div N)
      [] H|T then {VarianceAcc T H*H+P H+S 1+N}
      end
   end
in
   if L==nil then 0
   else {VarianceAcc L 0 0 0} end
end

{Browse {Variance [42 17 25 61 9]}}