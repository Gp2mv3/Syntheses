declare
fun {Prefix L1 L2}
   case L1#L2 of nil#M then true
   []M#nil then false
   [](H1|T1)#(H2|T2) then
      if H1==H2 then {Prefix T1 T2}
      else false
      end
   end
end

fun {FindString L1 L2}
   fun {FindStringAux L Pos}
      case L of nil then nil
      []H|T then
	 if {Prefix L1 L} then Pos|{FindStringAux T Pos+1}
	 else {FindStringAux T Pos+1}
	 end
      end
   end
in
   {FindStringAux L2 1}
end

{Browse {FindString [a b a b] [a b a b a b]}}   % affiche [1 3]
{Browse {FindString [a] [a b a b a b]}}         % affiche [1 3 5]
{Browse {FindString [c] [a b a b a b]}}         % affiche nil