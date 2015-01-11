declare
fun {Length L}
   case L of nil then 0
   [] H|T then 1+{Length T}
   end
end

fun {LengthRecursif L}
   fun {LengthRecursifAux L Acc}
      case L of nil then Acc
      [] H|T then {LengthRecursifAux T Acc+1}
      end
   end
in
   {LengthRecursifAux L 0}
end

{Browse {Length [r a p h]}}       % affiche 4
{Browse {Length [[b o r] i s]}}   % affiche 3
{Browse {Length [[l u i s]]}}     % affiche 1

{Browse {LengthRecursif [r a p h]}}       % affiche 4
{Browse {LengthRecursif [[b o r] i s]}}   % affiche 3
{Browse {LengthRecursif [[l u i s]]}}     % affiche 1


