declare
fun {GateMaker F}
   fun {$ Xs Ys }
      fun {GateLoop Xs Ys}
	 {ByNeed fun{$}
		    case Xs#Ys
		    of (X|Xr)#(Y|Yr) then
		       {F X Y}|{GateLoop Xr Yr}
		    end
		 end
	  }
      end
   in
      thread {GateLoop Xs Ys} end
   end
end

fun {DelayG Xs }
   {ByNeed fun {$} 0|Xs end}
end


fun {Schema Xs}
   A B XorG = {GateMaker fun {$ X Y} X+Y-2*X*Y end}
in
   A= {DelayG B}
   B = {XorG Xs A}
   B
end

Osc = 0|1|0|1|0|1|0|1|_
Circuit = {Schema Osc}
