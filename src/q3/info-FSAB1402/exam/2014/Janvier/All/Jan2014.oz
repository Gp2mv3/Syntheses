declare
%Prend une liste L et un entier K >= 0
%Retourne les K premier elements de L
fun{Give L K}
   if K == 0 then nil
   elseif L == nil then nil
   else
      L.1|{Give L.2 K-1}
   end
end
%Prend une liste L et un entier K >= 0
%Retourne la liste L sans les K premier elements
fun{Drop L K}
   if K == 0 then L
   elseif L == nil then nil
   else
      {Drop L.2 K-1}
   end
end
fun{Unflatten L}
   case L
   of nil then nil
   [] H|T then
      if {Int.is H} then
	 {Unflatten {Give T H}}|{Unflatten {Drop T H}}
      else
	 H|{Unflatten T}
      end
   end
end
{Browse {Unflatten [a b c]}}
{Browse {Unflatten [a 2 b c d]}}
{Browse {Unflatten [a 5 b c d e f g]}}
{Browse {Unflatten [a 5 b 2 c e e i o p]}}
{Browse {Unflatten [3 2 1 a]}}
