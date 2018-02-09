fun {Prod A B}
   if A =< B then
      A|{Prod A+1 B}
   else nil
   end
end
fun {Sieve S}
   fun {Filter Xs K} 
      case Xs of X|Xr then
	 if X mod K \= 0 then 
	    X|{Filter Xr K}
	 else {Filter Xr K}
	 end
      else nil
      end 
   end 
in
   case S 
   of H|T then H|{Sieve thread {Filter T H} end}
   else nil
   end
end
fun {NotPrime S S2}
   case S#S2 of (H|T)#(X|Y) then
      if X == H then {NotPrime T Y}
      elseif X < H then {NotPrime S Y}
      else H|{NotPrime T S2}
      end
   else S
   end
end
