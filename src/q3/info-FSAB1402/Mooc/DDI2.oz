fun{Counter S}
   Mona Lisa
in
   fun{Mona S Tuple} 
      case S of H|T then
	 local L in
	    L = {Lisa Tuple H}
	    L|{Mona T L}
	 end
      else nil
      end
   end
   fun{Lisa Tuple Element}
      case Tuple of A#B|T then
	 if Element == A then
	    A#(B+1)|T
	 else A#B|{Lisa T Element}
	 end
      else Element#1|nil
      end
   end
   thread {Mona S nil} end
end