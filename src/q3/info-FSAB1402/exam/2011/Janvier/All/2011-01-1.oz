declare
fun {Mul2 As Bs}
   fun {Mul2Aux LA LB}
      case LA#LB of nil#nil then nil
      [](H1|T1)#(H2|T2) then (H1#H2)|{Mul2Aux LA T2}
      [](H1|T1)#nil then {Mul2Aux T1 Bs}
      []nil#M then nil
      end
   end
in
   {Mul2Aux As Bs}
end

fun {MulN Ass}
   Leng = {Length Ass}
   fun {MulNAux N}
      NewTuple = {MakeTuple '#' Leng}
      {Fill NewTuple 1 L Ass}
      NewTuple|{MulNAux N+1}
   end
   proc {Fill Tuple N Indexs Ass}
      case Indexs#Ass of nil#nil then Tuple
      [](H1|T1)#(H2|T2) then
	 Tuple.N = {GetValueAtIndex H2 H1}
	 {Fill Tuple N+1 T1 T2}
      else
	 skip
      end
   end

   fun {Increment ListOfPos PosToInc} % retourne une liste avec les nouvelles positions
      fun {IncrementAux ListOfValues ListOfPosAux Pos}
	 case ListOfValues#ListOfPosAux of (H1|T1)#(H2|T2) then
	    if Pos==1 andthen H2 < {Length H1} then
	       (H2+1)|T2
	    elseif Pos==1 then
	       {Increment Ass LPos PosToInc+1}
	    elseif Pos==0 then
	       endofproc
	    else
	       H2|{Increment T1 T2 PosToIncAux+1}	       
	    end
	 end
      end
   in
      {IncrementAux Ass ListOfPos PosToInc}
   end

   fun {GetValueAtIndex List Index}
      case List of H|T then
	 if Index==1 then H
	 else {GetValueAtIndex T Index-1}
	 end
      end
   end   
   
in
   case Ass of (H|T) then {MulNAux Ass T 1} Out
   else error
   end
end

{Browse {MulN [[a b c] [1 2] [alpha beta] [x y z]]}}
