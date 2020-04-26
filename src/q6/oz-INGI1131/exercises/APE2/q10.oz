declare
fun {Flatten X}
   fun {DoFlatten Xs Start End}
      case Xs 
      of X|Xr then S S1 in
         if {DoFlatten X S S1} then 
            S = Start 
            {DoFlatten Xr S1 End}
         else S2 in 
            Start = X|S2 
            {DoFlatten Xr S2 End}
         end
      [] nil then
         Start = End 
         true
      else false
      end
   end
   Start
in
   if {DoFlatten X Start nil} then Start 
   else X 
   end
end
{Browse {Flatten [a [b [c d]] e [[[f]]]]}} % -> [a b c d e f]