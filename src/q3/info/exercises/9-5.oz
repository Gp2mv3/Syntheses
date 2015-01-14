declare
fun {Counter S}
   local CounterAux AddInCount in
      fun {CounterAux Last SAux}
	 thread
	    case SAux of nil then nil
	    [] H|T then
	       New
	    in
	       New = {AddInCount Last H}
	       New|{CounterAux New T}
	    end
	 end
      end

      fun {AddInCount Last Element}
	 case Last of nil then Element#1|nil
	 []H|T then
	    case H of E#N then
	       if E==Element then (E#(N+1))|T
	       else H|{AddInCount T Element}
	       end
	    end
	 end
      end
      {CounterAux nil S}	 
   end     
end


local InS X in X = {Counter InS} InS = a|b|a|c|_  {Browse X} end