declare
fun{Courir2 L1 L2}
   local FUN in
      fun{FUN A B}
	 case A#B
	 of nil#nil then (L1.1 + L2.1)|nil
	 [](H|T)#nil then (H + L2.1)|{FUN T L2.2}
	 []nil#(H|T) then (L1.1 + H)|{FUN L1.2 T}
	 [](H1|T1)#(H2|T2) then (H1+H2)|{FUN T1 T2}
	 end
      end
      case L1#L2
      of (H1|T1)#(H2|T2)
      then {FUN L1 L2}
      else nil
      end
   end
end

fun{Courir3 L1 L2 L3}
   local FUN in
      fun{FUN A B}
	 case A#B
	 of nil#nil then nil
	 [](H|T)#nil then (H + L2.1)|{FUN T L2.2}
	 []nil#(H|T) then (L1.1 + H)|{FUN L1.2 T}
	 [](H1|T1)#(H2|T2) then (H1+H2)|{FUN T1 T2}
	 end
      end
      {Courir2 L3 {FUN L1 L2}}
   end
end

{Browse {Courir2 [4 5 4] [7 8]}}
{Browse {Courir3 [4 5 4] [7 8] [1 1]}}







