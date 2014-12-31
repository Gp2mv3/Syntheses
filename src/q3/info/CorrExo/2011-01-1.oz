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
   Out
   proc {MulNAux LA LB N}
      case LA#LB of nil#nil then skip
      [](H1|T1)#(H2|T2) then Out.N={Mul2 H1 H2}
	 {MulNAux LA T2 N+1}
      [](H1|T1)#nil then
	 case T1 of nil then skip
	 [](H2|T2) then {MulNAux T1 T2 N}
	 end
      end
   end
   fun{CountLengthOut N Acc}
      if N < {Length Ass} then {CountLengthOut N+1 Acc+N}
      else
	 Acc
      end
   end
   
in
   Out = {MakeTuple prodCart {CountLengthOut 2 1}}
   case Ass of (H|T) then {MulNAux Ass T 1} Out
   else error
   end
end

{Browse {MulN [[a b c] [1 2] [alpha beta] [x y z]]}}