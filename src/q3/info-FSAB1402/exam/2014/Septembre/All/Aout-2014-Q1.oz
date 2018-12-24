declare
fun{FoldPoly L X F U}
   case L of H|nil then {F H X*U}
   [] H1|H2|T then {F H1 X*{FoldPoly L.2 X F U}}
   end
end
{Browse {FoldPoly [1 2 3] 2 fun {$ X Y} X+Y end 0}}

fun{AddPoly L1 L2} % Additionne deux polynomes L1 et L2 (listes)
   case L1#L2 of nil#nil then nil
   [] (L)#nil then L
   [] nil#(L) then L
   [] (H1|T1)#(H2|T2) then (H1+H2)|{AddPoly T1 T2}
   end
end
{Browse {AddPoly [1 2] [0 0 0 5 6]}}

fun{MulPolyConst L C} % Multiplie L par la constante C
   case L of nil then nil
   [] H|T then C*H|{MulPolyConst T C}
   end
end
{Browse {MulPolyConst [1 2 3] 2}}

fun{MulPoly L1 L2}
   local MulPolyHelp Zeros in
      fun{Zeros I L} % Ajoute I zeros devant L (revient a multiplier par x^i si L represente un polynome)
	 if I==1 then 0|L
	 else 0|{Zeros I-1 L}
	 end
      end 
      fun{MulPolyHelp L1 L2 I}
	 case L1 of nil then nil
	 [] H|T andthen I==0 then {AddPoly {MulPolyConst L2 H} {MulPolyHelp T L2 I+1}}
	 [] H|T then {AddPoly {Zeros I {MulPolyConst L2 H}} {MulPolyHelp T L2 I+1}} 
	 end
      end
      {MulPolyHelp L1 L2 0}
   end
end

% Calculs et evaluations sur les polynomes
local L1 L2 X1 X2 in
   L1 = {MulPoly [1 1] [1 1]}
   X1 = 42
   {Browse L1}
   {Browse {FoldPoly L1 X1 fun {$ X Y} X+Y end 0}}

   L2= {MulPoly [3 2 1] [~2 1 ~1 1]}
   X2=9
  {Browse L2}
  {Browse {FoldPoly L2 X2 fun {$ X Y} X+Y end 0}}
end

