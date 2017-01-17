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

proc{Bridge J A B C D}
   local L4 in
      fun{L4 L}
	 case L
	 of H1|H2|H3|H4|T then H1|{L4 T}
	 else
	    nil
	 end
      end
      A = {L4 J}
      case J
      of H|T then B = {L4 T}
	 case T of H1|T1 then C = {L4 T1}
	    case T1 of H2|T2 then D = {L4 T2}
	    else D = nil
	    end
	 else C = nil D = nil
	 end
      else B = nil C = nil D =nil
      end
   end
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

