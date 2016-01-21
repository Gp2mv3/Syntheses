declare
fun {Take Xs N}
   if N=<0 then nil
   else
      case Xs of nil then nil
      []H|T then H|{Take T N-1}
      end
   end
end

fun {Drop Xs N}
   if N=<0 then Xs
   else case Xs of nil then nil
	[]H|T then {Drop T N-1}
	end
   end
end

fun {Interval Xs N M}
   {Drop {Take Xs M} N-1}
end

{Browse {Take [r a p h] 2}}     % affiche [r a]
{Browse {Take [r a p h] 7}}     % affiche [r a p h]
{Browse {Take [r [a p] h] 2}}   % affiche [r [a p]]

{Browse {Drop [r a p h] 2}}     % affiche [p h]
{Browse {Drop [r a p h] 7}}     % affiche nil
{Browse {Drop [r [a p] h] 2}}   % [h]

{Browse {Interval [b o r i s s] 3 5}}     % affiche [r i s]
{Browse {Interval [b o r i s s] 5 3}}     % affiche nil
{Browse {Interval [b [o r i] s s] 2 3}}   % affiche [[o r i] s]