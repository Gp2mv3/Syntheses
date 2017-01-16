declare
fun {MakeDeck}
   fun {MakeDeckAux C V}
      if C == 5 then nil
      elseif V =< 13 then
	 carte(C V)|{MakeDeckAux C V+1}
      elseif V>13 then
	 {MakeDeckAux C+1 1}
      end
   end
in
   {MakeDeckAux 1 1}
end

fun {Rand N}
   N div 2
end

fun {Shuffle J1}
   fun {ShuffleAux J1 N}
      if N == 0 then nil
      else
	 case J1 of nil then nil
	 else
	    RandIndex = {Rand N}+1
	    RandValue={ElementAtIndex J1 RandIndex}
	 in
	    RandValue|{ShuffleAux {DeleteElementAtIndex J1 RandIndex} N-1}
	 end
      end
   end
in
   {ShuffleAux J1 52}
end

fun {ElementAtIndex List Index}
   case List of nil then notfound
   []H|T then
      if Index == 1 then H
      else
	 {ElementAtIndex T Index-1}
      end
   end
end

fun {DeleteElementAtIndex List Index}
   case List of nil then nil
   []H|T then
      if Index==1 then T
      else
	 H|{DeleteElementAtIndex T Index-1}
      end
   end
end

proc {Bridge J A B C D}
   proc {BridgeAux J Acc1 Acc2 Acc3 Acc4}
      case J of nil then
	 A=Acc1
	 B=Acc2
	 C=Acc3
	 D=Acc4
      []H1|T1 then
	 case T1 of H2|T2 then
	    case T2 of H3|T3 then
	       case T3 of H4|T4 then
		  {BridgeAux T4 H1|Acc1 H2|Acc2 H3|Acc3 H4|Acc4}
	       end
	    end
	 end
      end	 
   end
in
   {BridgeAux J nil nil nil nil}
end
fun{Win A B C D}
   local Win2 W in
      fun{Win2 A B}
	 case A#B
	 of carte(N1 C1)#carte(N2 C2) then
	    if C1-C2 > 0 then B
	    elseif C1-C2 < 0 then A
	    else
	       if A == 1 then A
	       elseif B == 1 then B
	       elseif N1 - N2 > 0 then A
	       else B
	       end
	    end
	 end
      end
      W = {Win2 A {Win2 B {Win2 C D}}}
      if W == A then 1
      elseif W == B then 2
      elseif W == C then 3
      else 4
      end
   end
end

